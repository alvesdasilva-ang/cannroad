-- ============================================================================
-- CannRoad v3.0 — Migración: Tablas de procesos, subprocesos, variables
-- ============================================================================
-- Archivo: migrations/002_v3_schema.sql
-- Descripción: Agrega la estructura de procesos-subprocesos-variables (EAV)
--              que reemplaza la estructura G/CM-RE
-- Ejecutar DESPUÉS de: 001_initial_schema.sql (que ya existe)
-- ============================================================================

-- ============================================================================
-- 1. CATÁLOGO DE PROCESOS (11 productivos + 4 administrativos)
-- ============================================================================

CREATE TABLE IF NOT EXISTS procesos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('productivo', 'administrativo')),
    icono VARCHAR(50),                  -- referencia a Material Symbols (ej: 'potted_plant')
    orden INT NOT NULL,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsquedas rápidas por tipo
CREATE INDEX IF NOT EXISTS idx_procesos_tipo ON procesos(tipo);
CREATE INDEX IF NOT EXISTS idx_procesos_activo ON procesos(activo);

-- ============================================================================
-- 2. SUBPROCESOS DENTRO DE CADA PROCESO
-- ============================================================================

CREATE TABLE IF NOT EXISTS subprocesos (
    id SERIAL PRIMARY KEY,
    proceso_id INT NOT NULL REFERENCES procesos(id) ON DELETE CASCADE,
    nombre VARCHAR(150) NOT NULL,
    orden INT NOT NULL,
    requiere_climatizacion BOOLEAN DEFAULT FALSE,
    cm_re_referencia VARCHAR(20),      -- ej: 'CM-RE-0605', metadato opcional
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_subprocesos_proceso ON subprocesos(proceso_id);
CREATE INDEX IF NOT EXISTS idx_subprocesos_activo ON subprocesos(activo);
CREATE INDEX IF NOT EXISTS idx_subprocesos_cm_re ON subprocesos(cm_re_referencia);

-- ============================================================================
-- 3. DEFINICIÓN DE VARIABLES DE CADA SUBPROCESO (Catálogo)
-- ============================================================================

CREATE TABLE IF NOT EXISTS variables (
    id SERIAL PRIMARY KEY,
    subproceso_id INT NOT NULL REFERENCES subprocesos(id) ON DELETE CASCADE,
    nombre VARCHAR(150) NOT NULL,
    tipo_dato VARCHAR(30) NOT NULL CHECK (
        tipo_dato IN (
            'numero',
            'texto',
            'fecha',
            'booleano',
            'seleccion',
            'seleccion_condicional'
        )
    ),
    unidad VARCHAR(20),                 -- '°C', '%', 'kPa', 'ppm', 'mg/L', etc.
    opciones JSONB,                     -- ej: ["ACEPTADO","RECHAZADO"] o {"Si":[],"No":["campo_extra"]}
    rango_min NUMERIC,                  -- para validación de números
    rango_max NUMERIC,
    obligatorio BOOLEAN DEFAULT TRUE,
    orden INT NOT NULL,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsquedas rápidas por subproceso
CREATE INDEX IF NOT EXISTS idx_variables_subproceso ON variables(subproceso_id);
CREATE INDEX IF NOT EXISTS idx_variables_activo ON variables(activo);

-- ============================================================================
-- 4. REGISTRO DE DATOS DE UN SUBPROCESO (EAV parent)
-- ============================================================================

CREATE TABLE IF NOT EXISTS registros_subproceso (
    id SERIAL PRIMARY KEY,
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    subproceso_id INT NOT NULL REFERENCES subprocesos(id) ON DELETE RESTRICT,
    codigo_lote VARCHAR(50) NOT NULL,       -- trazabilidad transversal (ej: LT-2024-08A)
    usuario_id UUID REFERENCES usuarios(id) ON DELETE SET NULL,
    usuario_email VARCHAR(255),
    responsable_sala VARCHAR(150) NOT NULL,     -- regla transversal obligatoria
    responsable_calidad VARCHAR(150) NOT NULL,  -- regla transversal obligatoria
    climatizacion JSONB,                        -- {temp_aire, humedad, vpd, co2, ventilacion} si aplica
    estado VARCHAR(30) DEFAULT 'activo' CHECK (estado IN ('activo', 'anulado')),
    motivo_anulacion TEXT,                      -- si estado = 'anulado'
    hash_integridad VARCHAR(64),                -- SHA-256 del contenido (GAMP5/ALCOA+)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para búsquedas rápidas y auditoría
CREATE INDEX IF NOT EXISTS idx_registros_sp_tenant ON registros_subproceso(tenant_id, subproceso_id);
CREATE INDEX IF NOT EXISTS idx_registros_sp_lote ON registros_subproceso(codigo_lote);
CREATE INDEX IF NOT EXISTS idx_registros_sp_usuario ON registros_subproceso(usuario_id);
CREATE INDEX IF NOT EXISTS idx_registros_sp_estado ON registros_subproceso(estado);
CREATE INDEX IF NOT EXISTS idx_registros_sp_created ON registros_subproceso(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_registros_sp_hash ON registros_subproceso(hash_integridad);

-- ============================================================================
-- 5. VALORES POR VARIABLE (EAV table)
-- ============================================================================

CREATE TABLE IF NOT EXISTS valores_registro (
    id SERIAL PRIMARY KEY,
    registro_id INT NOT NULL REFERENCES registros_subproceso(id) ON DELETE CASCADE,
    variable_id INT NOT NULL REFERENCES variables(id) ON DELETE RESTRICT,
    valor JSONB NOT NULL,                    -- soporta número, texto, booleano, objeto (para "Otros")
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_valores_registro ON valores_registro(registro_id);
CREATE INDEX IF NOT EXISTS idx_valores_variable ON valores_registro(variable_id);

-- ============================================================================
-- 6. ADJUNTOS (certificados, fotos, PDFs de laboratorio, etc.)
-- ============================================================================

CREATE TABLE IF NOT EXISTS adjuntos (
    id SERIAL PRIMARY KEY,
    registro_id INT NOT NULL REFERENCES registros_subproceso(id) ON DELETE CASCADE,
    url TEXT NOT NULL,
    tipo VARCHAR(50),                   -- 'pdf', 'image', 'report', etc.
    nombre_archivo VARCHAR(255),
    tamano_bytes BIGINT,
    subido_por UUID REFERENCES usuarios(id) ON DELETE SET NULL,
    subido_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_adjuntos_registro ON adjuntos(registro_id);

-- ============================================================================
-- 7. BACKUPS (requisito de Santiago: respaldar datos)
-- ============================================================================

CREATE TABLE IF NOT EXISTS backups (
    id SERIAL PRIMARY KEY,
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    solicitado_por UUID NOT NULL REFERENCES usuarios(id) ON DELETE RESTRICT,
    archivo VARCHAR(255) NOT NULL,     -- ruta al dump (ej: /backups/backup_2024-07-24_14-30.sql)
    tamano_bytes BIGINT,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('manual', 'programado')),
    checksum_sha256 VARCHAR(64),        -- para verificar integridad del backup
    notas TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_backups_tenant ON backups(tenant_id);
CREATE INDEX IF NOT EXISTS idx_backups_solicitado_por ON backups(solicitado_por);
CREATE INDEX IF NOT EXISTS idx_backups_tipo ON backups(tipo);
CREATE INDEX IF NOT EXISTS idx_backups_created ON backups(created_at DESC);

-- ============================================================================
-- 8. EXTENSIÓN DE TABLA EXISTENTE: registros (v2.1)
-- ============================================================================
-- Se agregan columnas a la tabla 'registros' existente para mantener 
-- compatibilidad hacia atrás con registros de v2.1, mientras los nuevos 
-- subprocesos usan registros_subproceso

ALTER TABLE registros ADD COLUMN IF NOT EXISTS subproceso_id INT REFERENCES subprocesos(id) ON DELETE SET NULL;
ALTER TABLE registros ADD COLUMN IF NOT EXISTS responsable_sala VARCHAR(150);
ALTER TABLE registros ADD COLUMN IF NOT EXISTS responsable_calidad VARCHAR(150);
ALTER TABLE registros ADD COLUMN IF NOT EXISTS climatizacion JSONB;
ALTER TABLE registros ADD COLUMN IF NOT EXISTS codigo_lote VARCHAR(50);

-- ============================================================================
-- 9. COMMIT
-- ============================================================================

COMMIT;
