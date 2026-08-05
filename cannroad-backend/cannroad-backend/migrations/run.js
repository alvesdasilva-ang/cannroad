// migrations/run.js — Run SQL migrations
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const pool = new pg.Pool({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 5432,
    user: process.env.DB_USER || 'cannroad_user',
    password: process.env.DB_PASSWORD || 'cannroad_pass',
    database: process.env.DB_NAME || 'cannroad_db',
});

async function runMigrations() {
    const client = await pool.connect();
    try {
        console.log('🔄 Running migrations...');
        
        // Create migrations table
        await client.query(`
            CREATE TABLE IF NOT EXISTS schema_migrations (
                id SERIAL PRIMARY KEY,
                filename VARCHAR(255) UNIQUE NOT NULL,
                executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        `);

        // Read all .sql files
        const files = fs.readdirSync(__dirname)
            .filter(f => f.endsWith('.sql'))
            .sort();

        for (const file of files) {
            const result = await client.query(
                'SELECT * FROM schema_migrations WHERE filename = $1',
                [file]
            );

            if (result.rows.length === 0) {
                const sql = fs.readFileSync(path.join(__dirname, file), 'utf-8');
                console.log(`  → ${file}`);
                await client.query(sql);
                await client.query(
                    'INSERT INTO schema_migrations (filename) VALUES ($1)',
                    [file]
                );
            }
        }

        console.log('✓ Migrations complete');
    } catch (err) {
        console.error('✗ Migration error:', err.message);
        process.exit(1);
    } finally {
        client.release();
        await pool.end();
    }
}

runMigrations();
EOF
echo "✓ migrations/run.js"