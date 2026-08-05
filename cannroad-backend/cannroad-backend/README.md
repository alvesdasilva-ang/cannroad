# CannRoad Backend — Paso 5

**Fastify + PostgreSQL + Docker Compose**

## Setup local (sin Docker)

```bash
# 1. Instalar dependencias
npm install

# 2. Configurar .env (ya existe con defaults)
# DB_HOST=localhost, DB_USER=cannroad_user, etc.

# 3. PostgreSQL local (o usar Docker)
# brew install postgresql@15
# brew services start postgresql@15
# createdb -U postgres cannroad_db
# psql -U postgres -d cannroad_db -c "CREATE ROLE cannroad_user WITH LOGIN PASSWORD 'cannroad_pass';"
# psql -U postgres -d cannroad_db -c "GRANT ALL PRIVILEGES ON DATABASE cannroad_db TO cannroad_user;"

# 4. Correr migraciones
npm run migrate

# 5. Dev server (con auto-reload)
npm run dev
```

## Setup con Docker Compose

```bash
# Build + start (incluye migraciones y seed)
docker-compose up --build

# Logs
docker-compose logs -f api

# Detener
docker-compose down

# Limpiar todo (incluyendo volumen de datos)
docker-compose down -v
```

## Endpoints

**Autenticación**
- `POST /api/auth/login` — Login (email, password)
- `POST /api/auth/validate` — Validar JWT

**Registros (9 módulos G02)**
- `POST /api/registros/CM-RE-0201` — Crear planta madre
- `GET /api/registros/CM-RE-0201` — Listar plantas madres
- `GET /api/registros/CM-RE-0201/:id` — Obtener específico
- `PUT /api/registros/CM-RE-0201/:id` — Actualizar
- `DELETE /api/registros/CM-RE-0201/:id` — Eliminar (soft delete)

Los tipos soportados: `CM-RE-0201` a `CM-RE-0209`

**Auditoría**
- `GET /api/registros/audit/log` — Histórico completo

**Health**
- `GET /health` — Estado del servidor y DB

## Estructura

```
cannroad-backend/
├── config/
│   └── db.js          # Pool PostgreSQL
├── migrations/
│   ├── 001_initial_schema.sql
│   └── run.js
├── src/
│   ├── routes/
│   │   ├── auth.js
│   │   └── registros.js
│   ├── middleware/
│   │   └── auth.js
│   ├── db/
│   │   └── seed.js
│   └── server.js
├── .env
├── package.json
├── Dockerfile
└── docker-compose.yml
```

## Datos de prueba

Al iniciar, se crean automáticamente:

- **Tenant:** FIS S.A.S. (Legajo ANMAT 7.563)
- **Usuarios:**
  - `naty@fis.com.ar` / `naty2024` — Director Técnico
  - `jefe@fis.com.ar` / `pass1234` — Jefe de Producción
  - `operario@fis.com.ar` / `pass1234` — Operario de Cultivo
  - `calidad@fis.com.ar` / `pass1234` — Responsable de Calidad

## JWT Token

Los tokens expiran en 24 horas. Incluyelos en el header:
```
Authorization: Bearer <token>
```

## Base de datos

- **Multi-tenant:** `tenants`, `usuarios`
- **Registros:** tabla `registros` con JSONB para datos flexibles
- **Auditoría:** `audit_log` (quién qué cuándo) + `sesiones` (revocation list)
- **Integridad:** SHA-256 en cada `registros.hash_sha256`

## Próximo paso

Paso 6 — Integrar este backend con el frontend (CannRoad v2.1) mediante llamadas a la API.
EOF
cat README.md