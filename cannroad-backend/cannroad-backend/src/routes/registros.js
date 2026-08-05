// src/routes/registros.js (extensión para v3.0)
// FASE 2 — Rutas para gestión de registros de subprocesos

export async function registrarRutasRegistros(fastify) {
    
    // GET /registros/:id
    // Retorna detalle completo de un registro (valores + adjuntos + auditoría)
    fastify.get(
        '/registros/:id',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;

                // Obtener registro
                const regResult = await fastify.pg.query(`
                    SELECT 
                        r.id,
                        r.subproceso_id,
                        r.codigo_lote,
                        r.usuario_email,
                        r.responsable_sala,
                        r.responsable_calidad,
                        r.climatizacion,
                        r.estado,
                        r.motivo_anulacion,
                        r.hash_integridad,
                        r.created_at,
                        r.updated_at,
                        s.nombre as subproceso_nombre,
                        p.nombre as proceso_nombre
                    FROM registros_subproceso r
                    JOIN subprocesos s ON r.subproceso_id = s.id
                    JOIN procesos p ON s.proceso_id = p.id
                    WHERE r.id = $1 AND r.tenant_id = $2
                `, [id, request.user.tenant_id]);

                if (regResult.rowCount === 0) {
                    throw fastify.httpErrors.notFound('Registro no encontrado');
                }

                const registro = regResult.rows[0];

                // Obtener valores (EAV)
                const valoresResult = await fastify.pg.query(`
                    SELECT 
                        v.id as variable_id,
                        var.nombre as variable_nombre,
                        var.unidad,
                        var.tipo_dato,
                        vr.valor
                    FROM valores_registro vr
                    JOIN variables var ON vr.variable_id = var.id
                    ORDER BY var.orden ASC
                `, [id]);

                // Obtener adjuntos
                const adjuntosResult = await fastify.pg.query(`
                    SELECT 
                        id,
                        url,
                        tipo,
                        nombre_archivo,
                        tamano_bytes,
                        subido_en
                    FROM adjuntos
                    WHERE registro_id = $1
                    ORDER BY subido_en DESC
                `, [id]);

                // Obtener auditoría del registro
                const auditResult = await fastify.pg.query(`
                    SELECT 
                        accion,
                        usuario_email,
                        created_at
                    FROM audit_log
                    WHERE registro_id = $1
                    ORDER BY created_at DESC
                `, [id]);

                return {
                    status: 'ok',
                    registro: {
                        id: registro.id,
                        codigo_lote: registro.codigo_lote,
                        proceso: registro.proceso_nombre,
                        subproceso: registro.subproceso_nombre,
                        responsable_sala: registro.responsable_sala,
                        responsable_calidad: registro.responsable_calidad,
                        climatizacion: registro.climatizacion ? JSON.parse(registro.climatizacion) : null,
                        estado: registro.estado,
                        motivo_anulacion: registro.motivo_anulacion,
                        hash_integridad: registro.hash_integridad,
                        created_at: registro.created_at,
                        updated_at: registro.updated_at
                    },
                    valores: valoresResult.rows,
                    adjuntos: adjuntosResult.rows,
                    auditoria: auditResult.rows
                };
            } catch (err) {
                if (err.status) throw err;
                fastify.log.error(err);
                throw fastify.httpErrors.internalServerError('Error al obtener registro');
            }
        }
    );

    // PATCH /registros/:id/anular
    // Anular un registro (nunca DELETE físico — ALCOA+)
    fastify.patch(
        '/registros/:id/anular',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;
                const { motivo_anulacion } = request.body;

                if (!motivo_anulacion) {
                    throw fastify.httpErrors.badRequest('motivo_anulacion es obligatorio');
                }

                // Verificar que el registro existe y pertenece al tenant
                const regCheck = await fastify.pg.query(`
                    SELECT id, estado FROM registros_subproceso
                    WHERE id = $1 AND tenant_id = $2
                `, [id, request.user.tenant_id]);

                if (regCheck.rowCount === 0) {
                    throw fastify.httpErrors.notFound('Registro no encontrado');
                }

                if (regCheck.rows[0].estado === 'anulado') {
                    throw fastify.httpErrors.conflict('El registro ya está anulado');
                }

                // Anular registro en transacción
                const client = await fastify.pg.connect();
                try {
                    await client.query('BEGIN');

                    // Actualizar estado
                    await client.query(`
                        UPDATE registros_subproceso
                        SET estado = 'anulado', motivo_anulacion = $1, updated_at = NOW()
                        WHERE id = $2
                    `, [motivo_anulacion, id]);

                    // Log de auditoría
                    await client.query(`
                        INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, registro_id, hash_nuevo)
                        VALUES ($1, $2, $3, $4, $5, $6)
                    `, [
                        request.user.tenant_id,
                        request.user.id,
                        request.user.email,
                        'ANULAR_REGISTRO',
                        id,
                        motivo_anulacion
                    ]);

                    await client.query('COMMIT');

                    return reply.status(200).send({
                        status: 'ok',
                        message: 'Registro anulado exitosamente',
                        data: {
                            id,
                            estado: 'anulado',
                            motivo_anulacion
                        }
                    });
                } catch (err) {
                    await client.query('ROLLBACK');
                    throw err;
                } finally {
                    client.release();
                }
            } catch (err) {
                if (err.status) throw err;
                fastify.log.error(err);
                throw fastify.httpErrors.internalServerError('Error al anular registro');
            }
        }
    );
}
