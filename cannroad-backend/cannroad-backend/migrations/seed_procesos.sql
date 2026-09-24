-- ============================================================================
-- CannRoad v3.0 — Seed: 15 Procesos base (11 productivos + 4 administrativos)
-- ============================================================================
-- Archivo: migrations/seed_procesos.sql
-- Descripción: Carga los procesos sin subprocesos (que llegaran con la matriz actualizada)
-- Ejecutar DESPUÉS de: 002_v3_schema.sql
-- ============================================================================

-- Limpiar procesos existentes (si existen) para ejecutar idempotentemente
DELETE FROM procesos WHERE nombre IN (
    'Planta Madre',
    'Clonación',
    'Floración',
    'Cosecha',
    'Secado',
    'Trimeo',
    'Empaquetado',
    'Almacenamiento',
    'Trazabilidad General',
    'Aplicación de Sales',
    'Fitosanitarios',
    'Muestras',
    'Gestión Documental',
    'Gestión de Equipamiento',
    'Calibración'
);

-- ============================================================================
-- PROCESOS PRODUCTIVOS (11)
-- ============================================================================

INSERT INTO procesos (nombre, tipo, icono, orden, descripcion, activo)
VALUES
    (
        'Planta Madre',
        'productivo',
        'potted_plant',
        1,
        'Gestión de plantas madre, genealogía, labores culturales, cuidados y reproducción',
        TRUE
    ),
    (
        'Clonación',
        'productivo',
        'content_copy',
        2,
        'Propagación vegetativa: HPAC, JIFFY, disposición y manejo de clones',
        TRUE
    ),
    (
        'Floración',
        'productivo',
        'local_florist',
        3,
        'Control ambiental, riego, escorrentía, fotoperiodo y monitoreo de floración',
        TRUE
    ),
    (
        'Cosecha',
        'productivo',
        'agriculture',
        4,
        'Recolección, pesaje, clasificación y buenas prácticas agrícolas (BPA)',
        TRUE
    ),
    (
        'Secado',
        'productivo',
        'air',
        5,
        'Control ambiental durante secado: temperatura, humedad, ventilación y tiempo de secado',
        TRUE
    ),
    (
        'Trimeo',
        'productivo',
        'content_cut',
        6,
        'Procesamiento post-secado: eliminación de hojas, clasificación y acondicionamiento',
        TRUE
    ),
    (
        'Empaquetado',
        'productivo',
        'inventory_2',
        7,
        'Acondicionamiento final: selección de formato, pesaje y empaque para almacenamiento o envío',
        TRUE
    ),
    (
        'Almacenamiento',
        'productivo',
        'warehouse',
        8,
        'Gestión de condiciones de almacén, lotes, trazabilidad de producto terminado',
        TRUE
    ),
    (
        'Trazabilidad General',
        'productivo',
        'account_tree',
        9,
        'Seguimiento integral de lotes a través de todo el ciclo productivo: desde origen hasta destino',
        TRUE
    ),
    (
        'Aplicación de Sales',
        'productivo',
        'science',
        10,
        'Preparación y aplicación de soluciones nutritivas: pH, EC, dosis, frecuencia de riego',
        TRUE
    ),
    (
        'Fitosanitarios',
        'productivo',
        'bug_report',
        11,
        'Control de plagas y enfermedades: identificación, aplicación de productos, carencias',
        TRUE
    );

-- ============================================================================
-- PROCESOS ADMINISTRATIVOS (4)
-- ============================================================================

INSERT INTO procesos (nombre, tipo, icono, orden, descripcion, activo)
VALUES
    (
        'Muestras',
        'administrativo',
        'biotech',
        12,
        'Toma de muestras, envío a laboratorio y registro de resultados de análisis (THC, CBD, pesticidas)',
        TRUE
    ),
    (
        'Gestión Documental',
        'administrativo',
        'folder_open',
        13,
        'SOPs, certificados regulatorios, registros de auditoría, documentos de cumplimiento ANMAT',
        TRUE
    ),
    (
        'Gestión de Equipamiento',
        'administrativo',
        'precision_manufacturing',
        14,
        'Inventario de equipos, mantenimiento preventivo, estado operativo, reparaciones',
        TRUE
    ),
    (
        'Calibración',
        'administrativo',
        'straighten',
        15,
        'Calibración de instrumentos de medición: sensores de temperatura, humedad, pH, EC, balanzas',
        TRUE
    );

-- ============================================================================
-- COMMIT
-- ============================================================================

COMMIT;

-- ============================================================================
-- VERIFICACIÓN (SELECT para confirmar que los datos se cargaron)
-- ============================================================================

SELECT 
    COUNT(*) as total_procesos,
    SUM(CASE WHEN tipo = 'productivo' THEN 1 ELSE 0 END) as productivos,
    SUM(CASE WHEN tipo = 'administrativo' THEN 1 ELSE 0 END) as administrativos
FROM procesos;

-- Salida esperada:
-- total_procesos | productivos | administrativos
-- ===============|=============|=================
--      15        |      11     |        4
