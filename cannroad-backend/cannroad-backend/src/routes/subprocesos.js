// src/routes/subprocesos.js
// FASE 2 — Rutas para gestión de subprocesos y sus registros v3.0

import crypto from 'crypto';

export async function registrarRutasSubprocesos(fastify) {
    
    // GET /subprocesos/:id/variables
    fastify.get(
        '/subprocesos/:id/variables',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;

                const spCheck = await fastify.pg.query(`
                    SELECT id, nombre, requiere_climatizacion FROM subprocesos WHERE id = $1 AND activo = TRUE
                `, [id]);

                if (spCheck.rowCount === 0) {
                    return reply.code(404).send({ statusCode: 404, error: 'Not Found', message: 'Subproceso no encontrado' });
                }

                const subproceso = spCheck.rows[0];

                const result = await fastify.pg.query(`
                    SELECT 
                        id, nombre, tipo_dato, unidad, opciones,
                        rango_min, rango_max, obligatorio, orden, descripcion
                    FROM variables
                    WHERE subproceso_id = $1 AND activo = TRUE
                    ORDER BY orden ASC
                `, [id]);

                return {
                    status: 'ok',
                    subproceso: {
                        id: subproceso.id,
                        nombre: subproceso.nombre,
                        requiere_climatizacion: subproceso.requiere_climatizacion
                    },
                    variables: result.rows,
                    total: result.rowCount
                };
            } catch (err) {
                if (err.statusCode) throw err;
                fastify.log.error(err);
                return reply.code(500).send({ statusCode: 500, error: 'Internal Server Error', message: 'Error al obtener variables' });
            }
        }
    );

    // GET /subprocesos/:id/registros
    fastify.get(
        '/subprocesos/:id/registros',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;
                const { limite = 20, offset = 0, estado = 'activo' } = request.query;

                if (isNaN(limite) || isNaN(offset)) {
                    return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: 'Parámetros inválidos: limite y offset deben ser números' });
                }

                const spCheck = await fastify.pg.query(`
                    SELECT id FROM subprocesos WHERE id = $1 AND activo = TRUE
                `, [id]);

                if (spCheck.rowCount === 0) {
                    return reply.code(404).send({ statusCode: 404, error: 'Not Found', message: 'Subproceso no encontrado' });
                }

                const result = await fastify.pg.query(`
                    SELECT 
                        id, codigo_lote, usuario_email, responsable_sala,
                        responsable_calidad, estado, created_at, updated_at
                    FROM registros_subproceso
                    WHERE subproceso_id = $1 AND estado = $2
                    ORDER BY created_at DESC
                    LIMIT $3 OFFSET $4
                `, [id, estado, limite, offset]);

                const countResult = await fastify.pg.query(`
                    SELECT COUNT(*) as total FROM registros_subproceso
                    WHERE subproceso_id = $1 AND estado = $2
                `, [id, estado]);

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
                return reply.code(500).send({ statusCode: 500, error: 'Internal Server Error', message: 'Error al obtener registros' });
            }
        }
    );

    // POST /subprocesos/:id/registros
    fastify.post(
        '/subprocesos/:id/registros',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;
                const {
                    codigo_lote, responsable_sala, responsable_calidad,
                    climatizacion, valores
                } = request.body;

                if (!codigo_lote || !responsable_sala || !responsable_calidad) {
                    return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: 'Faltan campos obligatorios: codigo_lote, responsable_sala, responsable_calidad' });
                }

                if (!Array.isArray(valores)) {
                    return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: 'valores debe ser un array de {variable_id, valor}' });
                }

                const spCheck = await fastify.pg.query(`
                    SELECT id FROM subprocesos WHERE id = $1 AND activo = TRUE
                `, [id]);

                if (spCheck.rowCount === 0) {
                    return reply.code(404).send({ statusCode: 404, error: 'Not Found', message: 'Subproceso no encontrado' });
                }

                const varsResult = await fastify.pg.query(`
                    SELECT id, nombre, tipo_dato, rango_min, rango_max, obligatorio
                    FROM variables
                    WHERE subproceso_id = $1 AND activo = TRUE
                `, [id]);

                const variablesMap = new Map(varsResult.rows.map(v => [v.id, v]));

                for (const val of valores) {
                    const variable = variablesMap.get(val.variable_id);
                    
                    if (!variable) {
                        return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: `Variable ${val.variable_id} no existe en este subproceso` });
                    }

                    if (variable.obligatorio && !val.valor) {
                        return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: `Variable ${variable.nombre} es obligatoria` });
                    }

                    if (variable.tipo_dato === 'numero' && val.valor) {
                        const num = parseFloat(val.valor);
                        if (isNaN(num)) {
                            return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: `Variable ${variable.nombre} debe ser numérica` });
                        }
                        if (variable.rango_min !== null && num < variable.rango_min) {
                            return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: `Variable ${variable.nombre} debe ser >= ${variable.rango_min}` });
                        }
                        if (variable.rango_max !== null && num > variable.rango_max) {
                            return reply.code(400).send({ statusCode: 400, error: 'Bad Request', message: `Variable ${variable.nombre} debe ser <= ${variable.rango_max}` });
                        }
                    }
                }

                const client = await fastify.pg.connect();
                try {
                    await client.query('BEGIN');

                    const hashContent = JSON.stringify({
                        codigo_lote, responsable_sala, responsable_calidad,
                        valores: valores.sort((a, b) => a.variable_id - b.variable_id),
                        timestamp: new Date().toISOString()
                    });
                    const hashIntegridad = crypto.createHash('sha256').update(hashContent).digest('hex');

                    const regResult = await client.query(`
                        INSERT INTO registros_subproceso (
                            tenant_id, subproceso_id, codigo_lote, usuario_id, usuario_email,
                            responsable_sala, responsable_calidad, climatizacion, estado, hash_integridad
                        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
                        RETURNING id
                    `, [
                        request.user.tenant_id, id, codigo_lote,
                        request.user.id, request.user.email,
                        responsable_sala, responsable_calidad,
                        climatizacion ? JSON.stringify(climatizacion) : null,
                        'activo', hashIntegridad
                    ]);

                    const registroId = regResult.rows[0].id;

                    for (const val of valores) {
                        await client.query(`
                            INSERT INTO valores_registro (registro_id, variable_id, valor)
                            VALUES ($1, $2, $3)
                        `, [registroId, val.variable_id, JSON.stringify(val.valor)]);
                    }

                    await client.query(`
                        INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, tipo_cmre, registro_id)
                        VALUES ($1, $2, $3, $4, $5, $6)
                    `, [
                        request.user.tenant_id, request.user.id, request.user.email,
                        'CREAR_REGISTRO', null, registroId
                    ]);

                    await client.query('COMMIT');

                    return reply.status(201).send({
                        status: 'ok',
                        message: 'Registro creado exitosamente',
                        data: { id: registroId, codigo_lote, hash_integridad: hashIntegridad }
                    });
                } catch (err) {
                    await client.query('ROLLBACK');
                    throw err;
                } finally {
                    client.release();
                }
            } catch (err) {
                if (err.statusCode) throw err;
                fastify.log.error(err);
                return reply.code(500).send({ statusCode: 500, error: 'Internal Server Error', message: 'Error al crear registro' });
            }
        }
    );
}
