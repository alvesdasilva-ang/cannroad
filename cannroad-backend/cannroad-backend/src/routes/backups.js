// src/routes/backups.js
// FASE 2 — Rutas para gestión de backups (requisito Santiago, administrador)

import { exec } from 'child_process';
import { promisify } from 'util';
import { promises as fs } from 'fs';
import path from 'path';
import crypto from 'crypto';

const execPromise = promisify(exec);

export async function registrarRutasBackups(fastify) {
    
    // POST /admin/backups
    fastify.post(
        '/admin/backups',
        { preHandler: [fastify.authenticate, crearGuardRolAdmin()] },
        async (request, reply) => {
            try {
                const timestamp = new Date().toISOString().replace(/:/g, '-').split('.')[0];
                const nombreBackup = `backup_${timestamp}.sql`;
                const rutaBackup = `/backups/${nombreBackup}`;

                fastify.log.info(`Iniciando backup manual: ${nombreBackup}`);

                const comandoPgDump = `
                    PGPASSWORD="${process.env.DB_PASSWORD}" pg_dump \
                    -h ${process.env.DB_HOST} \
                    -U ${process.env.DB_USER} \
                    -d ${process.env.DB_NAME} \
                    -F plain \
                    > ${rutaBackup}
                `;

                await execPromise(comandoPgDump);

                const contenido = await fs.readFile(rutaBackup);
                const checksumSha256 = crypto.createHash('sha256').update(contenido).digest('hex');
                const tamanoBytes = contenido.length;

                const result = await fastify.pg.query(`
                    INSERT INTO backups (
                        tenant_id, solicitado_por, archivo, tamano_bytes,
                        tipo, checksum_sha256, notas
                    ) VALUES ($1, $2, $3, $4, $5, $6, $7)
                    RETURNING id, created_at
                `, [
                    request.user.tenant_id, request.user.id, rutaBackup,
                    tamanoBytes, 'manual', checksumSha256,
                    `Backup manual solicitado por ${request.user.email}`
                ]);

                const backupId = result.rows[0].id;

                fastify.log.info(`Backup completado: ${nombreBackup} (${tamanoBytes} bytes, ID: ${backupId})`);

                await fastify.pg.query(`
                    INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, hash_nuevo)
                    VALUES ($1, $2, $3, $4, $5)
                `, [
                    request.user.tenant_id, request.user.id, request.user.email,
                    'CREAR_BACKUP', checksumSha256
                ]);

                return reply.status(201).send({
                    status: 'ok',
                    message: 'Backup creado exitosamente',
                    data: {
                        id: backupId, archivo: nombreBackup, tamano_bytes: tamanoBytes,
                        checksum_sha256: checksumSha256, creado_en: result.rows[0].created_at
                    }
                });
            } catch (err) {
                fastify.log.error('Error durante backup:', err);
                return reply.code(500).send({ statusCode: 500, error: 'Internal Server Error', message: 'Error al crear backup' });
            }
        }
    );

    // GET /admin/backups
    fastify.get(
        '/admin/backups',
        { preHandler: [fastify.authenticate, crearGuardRolAdmin()] },
        async (request, reply) => {
            try {
                const { limite = 30, offset = 0, tipo = null } = request.query;

                if (isNaN(limite) || isNaN(offset)) {
                    return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: 'Parámetros inválidos: limite y offset deben ser números' });
                }

                let query = `
                    SELECT id, archivo, tamano_bytes, tipo, checksum_sha256, notas, created_at
                    FROM backups WHERE tenant_id = $1
                `;
                const params = [request.user.tenant_id];

                if (tipo) {
                    query += ` AND tipo = $${params.length + 1}`;
                    params.push(tipo);
                }

                query += ` ORDER BY created_at DESC LIMIT $${params.length + 1} OFFSET $${params.length + 2}`;
                params.push(limite, offset);

                const result = await fastify.pg.query(query, params);

                let countQuery = `SELECT COUNT(*) as total FROM backups WHERE tenant_id = $1`;
                const countParams = [request.user.tenant_id];
                
                if (tipo) {
                    countQuery += ` AND tipo = $2`;
                    countParams.push(tipo);
                }

                const countResult = await fastify.pg.query(countQuery, countParams);

                return {
                    status: 'ok',
                    data: result.rows,
                    paginacion: {
                        total: parseInt(countResult.rows[0].total),
                        limite: parseInt(limite),
                        offset: parseInt(offset)
                    }
                };
            } catch (err) {
                if (err.statusCode) throw err;
                fastify.log.error(err);
                return reply.code(500).send({ statusCode: 500, error: 'Internal Server Error', message: 'Error al listar backups' });
            }
        }
    );

    // GET /admin/backups/:id/download
    fastify.get(
        '/admin/backups/:id/download',
        { preHandler: [fastify.authenticate, crearGuardRolAdmin()] },
        async (request, reply) => {
            try {
                const { id } = request.params;

                const backupCheck = await fastify.pg.query(`
                    SELECT archivo, tamano_bytes, checksum_sha256
                    FROM backups WHERE id = $1 AND tenant_id = $2
                `, [id, request.user.tenant_id]);

                if (backupCheck.rowCount === 0) {
                    return reply.code(404).send({ statusCode: 404, error: 'Not Found', message: 'Backup no encontrado' });
                }

                const backup = backupCheck.rows[0];
                const rutaArchivo = backup.archivo;

                try {
                    await fs.access(rutaArchivo);
                } catch (err) {
                    return reply.code(404).send({ statusCode: 404, error: 'Not Found', message: 'Archivo de backup no existe en el servidor' });
                }

                const nombreDescarga = path.basename(rutaArchivo);
                
                fastify.log.info(`Descargando backup: ${nombreDescarga} (usuario: ${request.user.email})`);

                await fastify.pg.query(`
                    INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, hash_nuevo)
                    VALUES ($1, $2, $3, $4, $5)
                `, [
                    request.user.tenant_id, request.user.id, request.user.email,
                    'DESCARGAR_BACKUP', backup.checksum_sha256
                ]);

                return reply.download(rutaArchivo, nombreDescarga);
            } catch (err) {
                if (err.statusCode) throw err;
                fastify.log.error(err);
                return reply.code(500).send({ statusCode: 500, error: 'Internal Server Error', message: 'Error al descargar backup' });
            }
        }
    );
}

function crearGuardRolAdmin() {
    return async (request, reply) => {
        if (request.user.rol !== 'administrador' && request.user.rol !== 'director_tecnico') {
            return reply.code(403).send({ statusCode: 403, error: 'Forbidden', message: 'Se requiere rol administrador para esta operación' });
        }
    };
}
