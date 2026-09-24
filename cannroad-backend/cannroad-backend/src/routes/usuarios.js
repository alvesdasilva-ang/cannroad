import crypto from 'crypto';
import pool from '../../config/db.js';

const ROLES_VALIDOS = [
    'director_tecnico', 'resp_calidad', 'jefe_produccion', 'operario_cultivo',
    'operario_postcosecha', 'resp_mantenimiento', 'resp_almacenes'
];

export default async function usuariosRoutes(fastify, opts) {

    // POST /login — Autenticación (sin JWT previo)
    fastify.post('/login', async (request, reply) => {
        const { email, password } = request.body || {};

        if (!email || !password) {
            return reply.code(400).send({ error: 'Email y contraseña son requeridos.' });
        }

        try {
            const passwordHash = crypto.createHash('sha256').update(password).digest('hex');
            const result = await pool.query(
                `SELECT id, tenant_id, email, nombre, rol
                 FROM usuarios
                 WHERE email = $1 AND password_hash = $2 AND activo = true`,
                [email, passwordHash]
            );

            if (result.rows.length === 0) {
                return reply.code(401).send({ error: 'Credenciales inválidas.' });
            }

            const usuario = result.rows[0];
            const token = fastify.jwt.sign({
                userId: usuario.id,
                tenantId: usuario.tenant_id,
                email: usuario.email,
                rol: usuario.rol
            });

            await pool.query(
                `INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, ip_addr)
                 VALUES ($1, $2, $3, $4, $5)`,
                [usuario.tenant_id, usuario.id, usuario.email, 'LOGIN', request.ip]
            );

            return reply.code(200).send({
                token,
                usuario: {
                    id: usuario.id,
                    email: usuario.email,
                    nombre: usuario.nombre,
                    rol: usuario.rol
                }
            });
        } catch (err) {
            fastify.log.error(err);
            return reply.code(500).send({ error: 'Error al iniciar sesión: ' + err.message });
        }
    });

    // Rutas administrativas — encapsuladas en su propio contexto para que el
    // preHandler de abajo (JWT + rol director_tecnico) no afecte a /login
    fastify.register(async function rutasAdmin(fastify) {

        fastify.addHook('preHandler', async (request, reply) => {
            try {
                await request.jwtVerify();
            } catch (err) {
                return reply.code(401).send({ error: 'Token inválido o expirado.' });
            }
            if (request.user.rol !== 'director_tecnico') {
                return reply.code(403).send({ error: 'Rol insuficiente para esta operación.' });
            }
        });

    // GET / — Listar usuarios del tenant
    fastify.get('/', async (request, reply) => {
        const { tenantId } = request.user;
        try {
            const result = await pool.query(
                `SELECT id, email, nombre, rol, activo, created_at
                 FROM usuarios
                 WHERE tenant_id = $1
                 ORDER BY created_at ASC`,
                [tenantId]
            );
            return reply.code(200).send({ usuarios: result.rows });
        } catch (err) {
            fastify.log.error(err);
            return reply.code(500).send({ error: 'Error al listar usuarios: ' + err.message });
        }
    });

    // POST / — Crear usuario
    fastify.post('/', async (request, reply) => {
        const { tenantId, email: adminEmail, userId: adminId } = request.user;
        const { email, nombre, password, rol } = request.body;

        if (!email || !nombre || !password || !rol) {
            return reply.code(400).send({ error: 'Todos los campos son requeridos.' });
        }
        if (!ROLES_VALIDOS.includes(rol)) {
            return reply.code(400).send({ error: 'Rol inválido.' });
        }
        if (password.length < 8) {
            return reply.code(400).send({ error: 'La contraseña debe tener al menos 8 caracteres.' });
        }

        try {
            const passwordHash = crypto.createHash('sha256').update(password).digest('hex');
            const result = await pool.query(
                `INSERT INTO usuarios (tenant_id, email, nombre, password_hash, rol, activo)
                 VALUES ($1, $2, $3, $4, $5, true)
                 RETURNING id, email, nombre, rol, activo, created_at`,
                [tenantId, email, nombre, passwordHash, rol]
            );

            await pool.query(
                `INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, ip_addr)
                 VALUES ($1, $2, $3, $4, $5)`,
                [tenantId, adminId, adminEmail, 'USER_CREATED:' + email, request.ip]
            );

            return reply.code(201).send({ usuario: result.rows[0] });
        } catch (err) {
            if (err.code === '23505') {
                return reply.code(409).send({ error: 'Ese email ya está registrado.' });
            }
            fastify.log.error(err);
            return reply.code(500).send({ error: 'Error al crear usuario: ' + err.message });
        }
    });

    // PUT /:id — Editar nombre y rol
    fastify.put('/:id', async (request, reply) => {
        const { tenantId, email: adminEmail, userId: adminId } = request.user;
        const { id } = request.params;
        const { nombre, rol } = request.body;

        if (!nombre || !rol) {
            return reply.code(400).send({ error: 'Nombre y rol son requeridos.' });
        }
        if (!ROLES_VALIDOS.includes(rol)) {
            return reply.code(400).send({ error: 'Rol inválido.' });
        }

        try {
            if (rol !== 'director_tecnico') {
                const actual = await pool.query(
                    `SELECT rol FROM usuarios WHERE id = $1 AND tenant_id = $2`,
                    [id, tenantId]
                );
                if (actual.rows.length === 0) {
                    return reply.code(404).send({ error: 'Usuario no encontrado.' });
                }
                if (actual.rows[0].rol === 'director_tecnico') {
                    const directores = await pool.query(
                        `SELECT COUNT(*) AS count FROM usuarios WHERE tenant_id = $1 AND rol = 'director_tecnico' AND activo = true`,
                        [tenantId]
                    );
                    if (parseInt(directores.rows[0].count) <= 1) {
                        return reply.code(409).send({ error: 'No puedes quitar el rol al último Director Técnico.' });
                    }
                }
            }

            const result = await pool.query(
                `UPDATE usuarios SET nombre = $1, rol = $2
                 WHERE id = $3 AND tenant_id = $4
                 RETURNING id, email, nombre, rol, activo, created_at`,
                [nombre, rol, id, tenantId]
            );

            if (result.rows.length === 0) {
                return reply.code(404).send({ error: 'Usuario no encontrado.' });
            }

            await pool.query(
                `INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, ip_addr)
                 VALUES ($1, $2, $3, $4, $5)`,
                [tenantId, adminId, adminEmail, 'USER_UPDATED:' + result.rows[0].email, request.ip]
            );

            return reply.code(200).send({ usuario: result.rows[0] });
        } catch (err) {
            fastify.log.error(err);
            return reply.code(500).send({ error: 'Error al actualizar usuario: ' + err.message });
        }
    });

    // POST /:id/reset-password — Resetear contraseña
    fastify.post('/:id/reset-password', async (request, reply) => {
        const { tenantId, email: adminEmail, userId: adminId } = request.user;
        const { id } = request.params;
        const { password } = request.body;

        if (!password || password.length < 8) {
            return reply.code(400).send({ error: 'La contraseña debe tener al menos 8 caracteres.' });
        }

        try {
            const passwordHash = crypto.createHash('sha256').update(password).digest('hex');
            const result = await pool.query(
                `UPDATE usuarios SET password_hash = $1
                 WHERE id = $2 AND tenant_id = $3
                 RETURNING id, email`,
                [passwordHash, id, tenantId]
            );

            if (result.rows.length === 0) {
                return reply.code(404).send({ error: 'Usuario no encontrado.' });
            }

            await pool.query(
                `INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, ip_addr)
                 VALUES ($1, $2, $3, $4, $5)`,
                [tenantId, adminId, adminEmail, 'PASS_RESET_BY_ADMIN:' + result.rows[0].email, request.ip]
            );

            return reply.code(200).send({ success: true });
        } catch (err) {
            fastify.log.error(err);
            return reply.code(500).send({ error: 'Error al resetear contraseña: ' + err.message });
        }
    });

    // DELETE /:id — Baja lógica (activo = false)
    fastify.delete('/:id', async (request, reply) => {
        const { tenantId, email: adminEmail, userId: adminId } = request.user;
        const { id } = request.params;

        if (id === adminId) {
            return reply.code(409).send({ error: 'No puedes eliminar tu propia cuenta mientras estás logueado.' });
        }

        try {
            const actual = await pool.query(
                `SELECT rol, email FROM usuarios WHERE id = $1 AND tenant_id = $2`,
                [id, tenantId]
            );
            if (actual.rows.length === 0) {
                return reply.code(404).send({ error: 'Usuario no encontrado.' });
            }
            if (actual.rows[0].rol === 'director_tecnico') {
                const directores = await pool.query(
                    `SELECT COUNT(*) AS count FROM usuarios WHERE tenant_id = $1 AND rol = 'director_tecnico' AND activo = true`,
                    [tenantId]
                );
                if (parseInt(directores.rows[0].count) <= 1) {
                    return reply.code(409).send({ error: 'No puedes eliminar al último Director Técnico del sistema.' });
                }
            }

            await pool.query(
                `UPDATE usuarios SET activo = false WHERE id = $1 AND tenant_id = $2`,
                [id, tenantId]
            );

            await pool.query(
                `INSERT INTO audit_log (tenant_id, usuario_id, usuario_email, accion, ip_addr)
                 VALUES ($1, $2, $3, $4, $5)`,
                [tenantId, adminId, adminEmail, 'USER_DELETED:' + actual.rows[0].email, request.ip]
            );

            return reply.code(200).send({ deleted: true });
        } catch (err) {
            fastify.log.error(err);
            return reply.code(500).send({ error: 'Error al eliminar usuario: ' + err.message });
        }
    });

    });
}
