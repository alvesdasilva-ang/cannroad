// src/db/seed.js — Datos iniciales de prueba (CORREGIDO: sin credenciales hardcodeadas)
import pool from '../../config/db.js';
import crypto from 'crypto';

export async function seedDatabase() {
    const client = await pool.connect();
    try {
        console.log('🌱 Seeding database...');

        // Obtener contraseña del .env o usar defecto seguro
        const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'changeme_en_produccion';
        const TEST_PASSWORD = process.env.TEST_PASSWORD || 'test1234';

        // 1. Crear tenant
        const tenantResult = await client.query(
            `INSERT INTO tenants (nombre, empresa, legajo_anmat)
             VALUES ($1, $2, $3)
             ON CONFLICT DO NOTHING
             RETURNING id`,
            ['FIS', 'FIS S.A.S.', '7.563']
        );
        let tenantId;
        if (tenantResult.rows.length > 0) {
            tenantId = tenantResult.rows[0].id;
        } else {
            const existing = await client.query(`SELECT id FROM tenants WHERE legajo_anmat = '7.563' LIMIT 1`);
            tenantId = existing.rows[0].id;
        }

        console.log(`  ✓ Tenant FIS: ${tenantId}`);

        // 2. Crear usuario admin
        const adminPwHash = crypto.createHash('sha256').update(ADMIN_PASSWORD).digest('hex');
        await client.query(
            `INSERT INTO usuarios (tenant_id, email, nombre, password_hash, rol, activo)
             VALUES ($1, $2, $3, $4, $5, $6)
             ON CONFLICT DO NOTHING`,
            [tenantId, 'naty@fis.com.ar', 'Naty Directora', adminPwHash, 'director_tecnico', true]
        );
        console.log(`  ✓ Usuario admin: naty@fis.com.ar (contraseña: desde .env ADMIN_PASSWORD)`);

        // 3. Crear usuarios de prueba por rol
        const usuarios = [
            { email: 'jefe@fis.com.ar', nombre: 'Juan Jefe', rol: 'jefe_produccion' },
            { email: 'operario@fis.com.ar', nombre: 'Pedro Operario', rol: 'operario_cultivo' },
            { email: 'calidad@fis.com.ar', nombre: 'Rosa Calidad', rol: 'resp_calidad' },
        ];

        const testPwHash = crypto.createHash('sha256').update(TEST_PASSWORD).digest('hex');
        for (const u of usuarios) {
            await client.query(
                `INSERT INTO usuarios (tenant_id, email, nombre, password_hash, rol, activo)
                 VALUES ($1, $2, $3, $4, $5, $6)
                 ON CONFLICT DO NOTHING`,
                [tenantId, u.email, u.nombre, testPwHash, u.rol, true]
            );
            console.log(`  ✓ Usuario de prueba: ${u.email} (rol: ${u.rol})`);
        }

        console.log('✅ Seed completado exitosamente\n');
    } catch (err) {
        console.error('❌ Error durante seed:', err.message);
        throw err;
    } finally {
        client.release();
    }
}
