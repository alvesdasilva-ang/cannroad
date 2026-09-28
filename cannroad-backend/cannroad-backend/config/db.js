import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false // Necesario para validar el certificado SSL de Supabase en contenedores
  }
});

const pool = new Pool({
    host: process.env.DB_HOST || 'db.vhrxveogtlmoqivtnbln.supabase.co',
    port: process.env.DB_PORT || 5432,
    user: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'postgres',
    // ⚠️ Obligatorio para conectar con Supabase desde la nube o de forma externa
    ssl: {
        rejectUnauthorized: false
    },
    max: 20,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 5000,
});

pool.on('error', (err) => {
    console.error('Error inesperado en el pool:', err);
});

export default pool;
