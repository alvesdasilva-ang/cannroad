import 'dotenv/config';

import Fastify from 'fastify';
import cors from '@fastify/cors';
import jwt from '@fastify/jwt';
import pool from '../config/db.js';

// ============================================================================
// v2.1 — Rutas originales (funcionales)
// ============================================================================
import usuariosRoutes from './routes/usuarios.js';  // tiene export default

// ============================================================================
// Fase 2 — Nuevas rutas (named exports)
// ============================================================================
import { registrarRutasProcesos } from './routes/procesos.js';
import { registrarRutasSubprocesos } from './routes/subprocesos.js';
import { registrarRutasRegistros } from './routes/registros.js';
import { registrarRutasBackups } from './routes/backups.js';

const fastify = Fastify({ logger: true });
// ============================================================================
// PLUGINS
// ============================================================================

fastify.register(cors, { origin: process.env.CORS_ORIGIN || '*' });
fastify.register(jwt, { secret: process.env.JWT_SECRET || 'dev-secret' });

// ============================================================================
// DECORADORES Y HOOKS
// ============================================================================

// Decorador para autenticación global (usado por las rutas de Fase 2)
fastify.decorate('authenticate', async (request, reply) => {
    try {
        await request.jwtVerify();
    } catch (err) {
        reply.code(401).send({ 
            statusCode: 401, 
            error: 'Unauthorized', 
            message: 'Token inválido o expirado.' 
        });
    }
});

// Pool de PostgreSQL decorado como fastify.pg (para que las rutas de Fase 2 funcionen)
fastify.decorate('pg', pool);

// ============================================================================
// RUTAS v2.1 (mantienen compatibilidad hacia atrás)
// ============================================================================

await fastify.register(usuariosRoutes, { prefix: '/auth' });

// ============================================================================
// RUTAS FASE 2 (v3.0 — procesos, subprocesos, registros dinámicos, backups)
// ============================================================================

await fastify.register(registrarRutasProcesos);
await fastify.register(registrarRutasSubprocesos);
await fastify.register(registrarRutasRegistros);    
await fastify.register(registrarRutasBackups, { prefix: '/admin' });

// ============================================================================
// HEALTH CHECK
// ============================================================================

fastify.get('/health', async (request, reply) => {
    try {
        const result = await pool.query('SELECT NOW()');
        return {
            status: 'ok',
            db: 'connected',
            time: result.rows[0].now
        };
    } catch (err) {
        return reply.code(500).send({
            status: 'error',
            db: 'disconnected',
            error: err.message
        });
    }
});

// ============================================================================
// START SERVER
// ============================================================================

const start = async () => {
    try {
        // Esperar a que PostgreSQL esté listo
        let dbReady = false;
        let attempts = 0;
        while (!dbReady && attempts < 30) {
            try {
                await pool.query('SELECT NOW()');
                dbReady = true;
            } catch (err) {
                attempts++;
                console.log(`Esperando a PostgreSQL... (${attempts}/30)`);
                await new Promise(resolve => setTimeout(resolve, 1000));
            }
        }

        if (!dbReady) {
            throw new Error('PostgreSQL no está disponible después de 30 segundos');
        }

        console.log('✓ Conectado a PostgreSQL');

        await fastify.listen({
            port: process.env.PORT || 3000,
            host: '0.0.0.0'
        });

        console.log(`✓ Servidor corriendo en http://localhost:${process.env.PORT || 3000}`);
    } catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};

start();
