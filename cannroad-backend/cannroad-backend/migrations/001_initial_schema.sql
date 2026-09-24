-- ============================================================================
-- CannRoad v2.0 — Schema PostgreSQL (GAMP 5 · ALCOA+)
-- ============================================================================

-- Multi-tenancy: tabla Tenants
CREATE TABLE IF NOT EXISTS tenants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(255) NOT NULL,
    empresa VARCHAR(255) NOT NULL,
    legajo_anmat VARCHAR(20),
    encr_key VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Usuarios con roles
CREATE TABLE IF NOT EXISTS usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'operario_cultivo',
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla genérica de registros (todos los CM-RE-)
CREATE TABLE IF NOT EXISTS registros (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    tipo_cmre VARCHAR(20) NOT NULL,  -- CM-RE-0201, CM-RE-0202, etc.
    datos JSONB NOT NULL,              -- {codigo_id, fecha_ingreso, ...}
    hash_sha256 VARCHAR(64),           -- SHA-256 de los datos
    usuario_id UUID REFERENCES usuarios(id) ON DELETE SET NULL,
    usuario_email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit log (quién qué cuándo)
CREATE TABLE IF NOT EXISTS audit_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    usuario_id UUID REFERENCES usuarios(id) ON DELETE SET NULL,
    usuario_email VARCHAR(255),
    accion VARCHAR(100) NOT NULL,  -- CREAR, ACTUALIZAR, ELIMINAR, LOGIN, LOGOUT
    tipo_cmre VARCHAR(20),
    registro_id UUID REFERENCES registros(id) ON DELETE SET NULL,
    hash_anterior VARCHAR(64),
    hash_nuevo VARCHAR(64),
    ip_addr VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sesiones JWT (revocation list)
CREATE TABLE IF NOT EXISTS sesiones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    jwt_token TEXT NOT NULL,
    ip_addr VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP NOT NULL,
    revoked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- ÍNDICES (PostgreSQL-válido: CREATE INDEX separados, no inline)
-- ============================================================================

-- Índices de registros
CREATE INDEX IF NOT EXISTS idx_registros_tenant_tipo ON registros(tenant_id, tipo_cmre);
CREATE INDEX IF NOT EXISTS idx_registros_tipo ON registros(tipo_cmre);
CREATE INDEX IF NOT EXISTS idx_registros_hash ON registros(hash_sha256);
CREATE INDEX IF NOT EXISTS idx_registros_created ON registros(created_at DESC);

-- Índices de audit_log
CREATE INDEX IF NOT EXISTS idx_audit_tenant_usuario ON audit_log(tenant_id, usuario_id);
CREATE INDEX IF NOT EXISTS idx_audit_accion ON audit_log(accion);
CREATE INDEX IF NOT EXISTS idx_audit_created ON audit_log(created_at DESC);

-- Índices de usuarios
CREATE INDEX IF NOT EXISTS idx_usuarios_activos ON usuarios(activo, tenant_id);

-- Índices de sesiones
CREATE INDEX IF NOT EXISTS idx_sesiones_usuario ON sesiones(usuario_id);
CREATE INDEX IF NOT EXISTS idx_sesiones_expires ON sesiones(expires_at);

COMMIT;
