import pg from 'pg';
const { Pool } = pg;

const connectionString = process.env.DATABASE_URL;

const pool = connectionString
    // Producción (Railway → Supabase): cadena completa + SSL obligatorio
    ? new Pool({
        connectionString,
        ssl: { rejectUnauthorized: false },
        max: 10,
        idleTimeoutMillis: 30000,
        connectionTimeoutMillis: 10000,
    })
    // Desarrollo local (Docker): mismos valores que antes, sin SSL
    : new Pool({
        host: process.env.DB_HOST || 'localhost',
        port: Number(process.env.DB_PORT) || 5432,
        user: process.env.DB_USER || 'cannroad_user',
        password: process.env.DB_PASSWORD || 'cannroad_pass',
        database: process.env.DB_NAME || 'cannroad_db',
        max: 20,
        idleTimeoutMillis: 30000,
        connectionTimeoutMillis: 5000,
    });

pool.on('error', (err) => {
    console.error('Error inesperado en el pool:', err);
});

export default pool;
