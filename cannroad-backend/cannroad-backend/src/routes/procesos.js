// src/routes/procesos.js
// FASE 2 — Rutas para gestión de procesos v3.0

export async function registrarRutasProcesos(fastify) {
    // GET /procesos
    // Retorna lista de 15 procesos con conteo de subprocesos activos
    fastify.get(
        '/procesos',
               async (request, reply) => {
            try {
                const result = await fastify.pg.query(`
                    SELECT 
                        p.id,
                        p.nombre,
                        p.tipo,
                        p.icono,
                        p.orden,
                        p.descripcion,
                        p.activo,
                        COUNT(s.id) as cantidad_subprocesos,
                        p.created_at
                    FROM procesos p
                    LEFT JOIN subprocesos s ON s.proceso_id = p.id AND s.activo = TRUE
                    WHERE p.activo = TRUE
                    GROUP BY p.id
                    ORDER BY p.orden ASC
                `);

                return {
                    status: 'ok',
                    data: result.rows,
                    total: result.rowCount
                };
            } catch (err) {
                fastify.log.error(err);
                throw fastify.httpErrors.internalServerError('Error al obtener procesos');
            }
        }
    );

    // GET /procesos/:id
    // Retorna detalle de un proceso específico
    fastify.get(
        '/procesos/:id',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;

                const result = await fastify.pg.query(`
                    SELECT 
                        p.id,
                        p.nombre,
                        p.tipo,
                        p.icono,
                        p.orden,
                        p.descripcion,
                        p.activo,
                        p.created_at,
                        p.updated_at
                    FROM procesos p
                    WHERE p.id = $1 AND p.activo = TRUE
                `, [id]);

                if (result.rowCount === 0) {
                    throw fastify.httpErrors.notFound('Proceso no encontrado');
                }

                return {
                    status: 'ok',
                    data: result.rows[0]
                };
            } catch (err) {
                if (err.status) throw err;
                fastify.log.error(err);
                throw fastify.httpErrors.internalServerError('Error al obtener proceso');
            }
        }
    );

    // GET /procesos/:id/subprocesos
    // Retorna subprocesos de un proceso específico
    fastify.get(
        '/procesos/:id/subprocesos',
        { preHandler: fastify.authenticate },
        async (request, reply) => {
            try {
                const { id } = request.params;

                // Verificar que el proceso existe
                const procesoCheck = await fastify.pg.query(`
                    SELECT id FROM procesos WHERE id = $1 AND activo = TRUE
                `, [id]);

                if (procesoCheck.rowCount === 0) {
                    throw fastify.httpErrors.notFound('Proceso no encontrado');
                }

                // Obtener subprocesos
                const result = await fastify.pg.query(`
                    SELECT 
                        s.id,
                        s.proceso_id,
                        s.nombre,
                        s.orden,
                        s.requiere_climatizacion,
                        s.cm_re_referencia,
                        s.descripcion,
                        s.activo,
                        COUNT(v.id) as cantidad_variables,
                        s.created_at,
                        s.updated_at
                    FROM subprocesos s
                    LEFT JOIN variables v ON v.subproceso_id = s.id AND v.activo = TRUE
                    WHERE s.proceso_id = $1 AND s.activo = TRUE
                    GROUP BY s.id
                    ORDER BY s.orden ASC
                `, [id]);

                return {
                    status: 'ok',
                    data: result.rows,
                    total: result.rowCount
                };
            } catch (err) {
                if (err.status) throw err;
                fastify.log.error(err);
                throw fastify.httpErrors.internalServerError('Error al obtener subprocesos');
            }
        }
    );
}
