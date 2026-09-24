// src/server.js — Fastify + CannRoad API (simplificado)
import Fastify from 'fastify';
import cors from '@fastify/cors';
import jwt from '@fastify/jwt';
import dotenv from 'dotenv';
import pool from '../config/db.js';
import authRoutes from './routes/auth.js';
import registrosRoutes from './routes/registros.js';

dotenv.config();

const fastify = Fastify({ logger: true });

// Plugins
fastify.register(cors, { origin: process.env.CORS_ORIGIN || '*' });
fastify.register(jwt, { secret: process.env.JWT_SECRET || 'dev-secret' });

// Rutas
fastify.register(authRoutes, { prefix: '/api/auth' });
fastify.register(registrosRoutes, { prefix: '/api/registros' });

// Health check
fastify.get('/health', async (request, reply) => {
    try {
        const result = await pool.query('SELECT NOW()');
        return { status: 'ok', db: 'connected', time: result.rows[0].now };
    } catch (err) {
        return { status: 'error', db: 'disconnected', error: err.message };
    }
});

// Start server
const start = async () => {
    try {
        // Esperar a que PostgreSQL esté listo
        let dbReady = false;
        let attempts = 0;
        while (!dbReady && attempts < 30) {
            try {
                const result = await pool.query('SELECT NOW()');
                dbReady = true;
            } catch (err) {
                attempts++;
                console.log(`Waiting for database... (${attempts}/30)`);
                await new Promise(resolve => setTimeout(resolve, 1000));
            }
        }

        if (!dbReady) {
            throw new Error('Database not ready after 30 seconds');
        }

        console.log('✓ Database connected');

        // Server
        await fastify.listen({ port: process.env.PORT || 3000, host: '0.0.0.0' });
        console.log(`✓ Server running on http://localhost:${process.env.PORT || 3000}`);
    } catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};

start();