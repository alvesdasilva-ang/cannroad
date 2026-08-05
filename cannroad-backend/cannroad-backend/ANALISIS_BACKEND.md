# Análisis del Backend — CannRoad (cannroad-backend)

Fecha de análisis: 2026-07-30
Alcance: `~/Escritorio/cannroad-lean/Cannroad-backend/cannroad-backend/`

> ⚠️ Resumen ejecutivo: el backend actual **no arranca** en ninguno de sus dos puntos de entrada (`src/server.js` ni `src/server-simplificado.js`). Hay imports `default` que apuntan a archivos sin `export default`, rutas de Fase 2 que dependen de `fastify.pg` y `fastify.authenticate` sin que ningún plugin los registre, y `src/routes/auth.js` no contiene rutas de autenticación sino una copia del middleware. Ver sección 5 y 6 para el detalle y sección 7 para la causa raíz.

---

## 1. `src/routes/` — archivos y exports

| Archivo | Exports | Qué registra/hace |
|---|---|---|
| `auth.js` | `verificarJWT(fastify, request)`, `verificarRol(request, rolesRequeridos)`, `crearGuardRol(rolesRequeridos)` — **named**, sin `export default` | ⚠️ No define ninguna ruta HTTP (`fastify.get/post`...). Es una copia casi idéntica del contenido de `src/middleware/auth.js` (versión "CORREGIDA" con `crearGuardRol`). No implementa `POST /api/auth/login` ni `POST /api/auth/validate` que documenta el README. |
| `backups.js` | `registrarRutasBackups(fastify)` — named | Fase 2. Registra `POST/GET /admin/backups` y `GET /admin/backups/:id/download`. Usa `fastify.pg.query(...)` y `fastify.authenticate` (ninguno decorado, ver §5). Define su propio guard local `crearGuardRolAdmin()` (duplica el concepto de `crearGuardRol` de `middleware/auth.js` con otra implementación). |
| `procesos.js` | `registrarRutasProcesos(fastify)` — named | Fase 2. `GET /procesos`, `GET /procesos/:id`, `GET /procesos/:id/subprocesos`. Usa `fastify.pg` y `fastify.authenticate`. |
| `registros.js` | `registrarRutasRegistros(fastify)` — named, **sin `export default`** | Fase 2. `GET /registros/:id`, `PATCH /registros/:id/anular`. ⚠️ Este archivo debería ser también el v2.1 original (CRUD de `CM-RE-0201`..`CM-RE-0209` que documenta el README), pero ese contenido **no existe** en el archivo actual — fue reemplazado/perdido. No se encontró ninguna referencia a `CM-RE` en todo `src/`. |
| `subprocesos.js` | `registrarRutasSubprocesos(fastify)` — named | Fase 2. `GET /subprocesos/:id/variables`, `GET /subprocesos/:id/registros`, `POST /subprocesos/:id/registros`. Usa `fastify.pg` y `fastify.authenticate`. |
| `usuarios.js` | `usuariosRoutes(fastify, opts)` — **default export** (único archivo de `routes/` con `export default`) | v2.1. CRUD de usuarios bajo prefijo `/api/usuarios`: `GET /`, `POST /`, `PUT /:id`, `POST /:id/reset-password`, `DELETE /:id` (baja lógica). Usa `pool` importado directo de `config/db.js` (no `fastify.pg`) y su propio hook `preHandler` con `request.jwtVerify()` + chequeo de rol `director_tecnico`. |

---

## 2. `src/middleware/` — archivos y exports

| Archivo | Exports |
|---|---|
| `auth.js` | `verificarJWT(fastify, request)`, `verificarRol(request, rolesRequeridos)` (lee `request.server` internamente), `crearGuardRol(rolesRequeridos)` — todos named, sin `export default`. Comentario interno dice "CORREGIDO: verificarRol ahora recibe request.server en lugar de fastify suelto". |

⚠️ Este archivo **no se importa desde ningún otro archivo del proyecto** (`grep` no encontró ningún `import ... from '.../middleware/auth.js'`). Es código muerto actualmente, y además está duplicado casi al carácter dentro de `src/routes/auth.js` (ver §1 y §5).

---

## 3. `config/` — archivos

| Archivo | Contenido |
|---|---|
| `db.js` | Crea y exporta (`export default`) un `pg.Pool` único, leyendo `DB_HOST/DB_PORT/DB_USER/DB_PASSWORD/DB_NAME` de `process.env` con defaults de desarrollo. Usado por `src/server.js`, `src/server-simplificado.js` y `src/db/seed.js` (todos apuntan al mismo archivo en la raíz — no hay duplicado de config). |

No existe ningún otro archivo en `config/` (ni `config/index.js`, ni configs por entorno).

---

## 4. `src/server.js` — estructura y rutas registradas

```js
fastify.register(cors, ...)
fastify.register(jwt, { secret: JWT_SECRET })   // solo agrega request.jwtVerify(), NO fastify.authenticate

await fastify.register(registrosRoutes)                              // import default de routes/registros.js → undefined (ver §5)
await fastify.register(usuariosRoutes, { prefix: '/api/usuarios' })   // v2.1, funcional

await fastify.register(registrarRutasProcesos)      // Fase 2
await fastify.register(registrarRutasSubprocesos)   // Fase 2
await fastify.register(registrarRutasRegistros)     // Fase 2
await fastify.register(registrarRutasBackups, { prefix: '/admin' })  // Fase 2

fastify.get('/health', ...)  // chequea conexión a DB
```

Es el entry point declarado en `package.json` (`"main"`, `npm start`, `npm run dev`). Es el **único** de los dos server files que registra las rutas de Fase 2.

`src/server-simplificado.js` es un segundo entry point, **no referenciado por ningún script de `package.json`** ni por `Dockerfile`/`docker-compose.yml`. Registra sólo `authRoutes` (`/api/auth`) y `registrosRoutes` (`/api/registros`) — un esquema más parecido a lo descrito en el README, pero roto por las mismas razones del §5.

---

## 5. Conflictos y bugs de integración detectados

1. **`registrosRoutes` es `undefined` en ambos servers.**
   `src/routes/registros.js` no tiene `export default`, solo `export async function registrarRutasRegistros`. Pero:
   - `src/server.js:6` hace `import registrosRoutes from './routes/registros.js'` y luego `await fastify.register(registrosRoutes)` → `fastify.register(undefined)` lanza excepción al levantar el server.
   - `src/server-simplificado.js:8` hace lo mismo.

2. **`authRoutes` es `undefined` en `server-simplificado.js`.**
   `src/routes/auth.js` no tiene `export default` (solo exports named de funciones de middleware) → `fastify.register(authRoutes, { prefix: '/api/auth' })` también rompe.

3. **`src/routes/auth.js` no es un archivo de rutas.**
   Su contenido real es una copia de `src/middleware/auth.js` (versión con `crearGuardRol`), no las rutas `POST /api/auth/login` / `POST /api/auth/validate` que documenta el `README.md`. Es decir, **la lógica de login/autenticación real no existe en ningún archivo actual del repo** — se perdió o nunca se migró a la nueva estructura.

4. **`fastify.authenticate` no está decorado en ningún lado.**
   Se usa como `preHandler: fastify.authenticate` en `procesos.js`, `subprocesos.js`, `registros.js`, `backups.js`, pero `src/server.js` solo hace `fastify.register(jwt, {...})`, que agrega `request.jwtVerify()` — **no** agrega automáticamente un decorador `fastify.authenticate`. Ningún archivo llama a `fastify.decorate('authenticate', ...)`. Estas rutas fallarán en tiempo de registro/petición.

5. **`fastify.pg` no existe.** Todas las rutas de Fase 2 (`procesos.js`, `subprocesos.js`, `registros.js`, `backups.js`) usan `fastify.pg.query(...)` / `fastify.pg.connect()`, asumiendo el plugin `@fastify/postgres`. Ese paquete **no está en `package.json`** ni en `package-lock.json` (`grep` = 0 resultados), y `src/server.js` nunca lo registra. Solo existe el `pool` crudo de `config/db.js`, usado directamente por `usuarios.js` y `db/seed.js`, pero no decorado como `fastify.pg`.

6. **Duplicación de guards de rol.** Existen tres implementaciones distintas de "verificar rol", sin reuso entre sí:
   - `middleware/auth.js` → `crearGuardRol(rolesRequeridos)` (código muerto, no importado).
   - `routes/auth.js` → copia idéntica de la anterior (también código muerto).
   - `routes/backups.js` → función local `crearGuardRolAdmin()` (hardcodea roles `administrador`/`director_tecnico`, no reutiliza nada de `middleware/`).
   - `routes/usuarios.js` → chequeo de rol inline dentro de un hook `preHandler` propio.

7. **Dos entry points (`server.js` y `server-simplificado.js`)** con esquemas de rutas distintos e incompatibles (prefijos `/api/registros` vs sin prefijo, `authRoutes` vs no tener auth en absoluto). Ambos rotos, pero por razones parcialmente distintas. No queda claro cuál es la fuente de verdad — `package.json` apunta a `server.js`, así que `server-simplificado.js` parece un remanente sin limpiar.

8. **Pérdida de funcionalidad v2.1 documentada en `README.md`:** el README describe endpoints CRUD `POST/GET/PUT/DELETE /api/registros/CM-RE-0201..0209` y `GET /api/registros/audit/log`, además de `POST /api/auth/login` y `POST /api/auth/validate`. Ninguno de estos existe hoy en `src/routes/`. La estructura de directorios que muestra el propio README (`routes/auth.js`, `routes/registros.js` únicamente) tampoco coincide con la actual (que agrega `backups.js`, `procesos.js`, `subprocesos.js`).

9. **`src/models/` está vacío** (0 archivos) — carpeta creada pero sin uso.

---

## 6. Clasificación de archivos: v2.1 original vs Fase 0/1/2

| Archivo | Clasificación | Justificación |
|---|---|---|
| `config/db.js` | v2.1 original | Pool simple, sin relación con `@fastify/postgres`; usado tal cual desde el inicio. |
| `src/server.js` | **Mixto v2.1 + Fase 2** | Base v2.1 (`registrosRoutes`, `usuariosRoutes`) + bloque explícito comentado `// Rutas v3.0 (Fase 2)` que agrega procesos/subprocesos/registros(v3)/backups. |
| `src/server-simplificado.js` | v2.1 original (remanente) | Esquema con prefijos `/api/auth`, `/api/registros`, coincide con lo descrito en README "Paso 5". No tiene rutas de Fase 2. Parece ser el server.js pre-Fase 2, dejado sin borrar. |
| `src/middleware/auth.js` | v2.1 original, con un parche posterior | Comentario interno "CORREGIDO: verificarRol ahora recibe request.server..." indica una corrección posterior a la versión original, pero sigue siendo del linaje v2.1 (no Fase 2). Código muerto hoy. |
| `src/routes/auth.js` | Copia corrupta / mal migrada | Debería ser v2.1 (rutas de login), pero su contenido actual es una copia de `middleware/auth.js`, no las rutas reales. |
| `src/routes/registros.js` | Fase 2 (reemplazó al v2.1) | Comentario `// FASE 2 — Rutas para gestión de registros de subprocesos` y `// (extensión para v3.0)`. El contenido v2.1 (CRUD `CM-RE-02xx`) no está presente. |
| `src/routes/usuarios.js` | v2.1 original | Sin comentarios de fase, usa `pool` directo y JWT manual — patrón consistente con el resto de v2.1, no toca tablas de Fase 2 (`procesos`, `subprocesos`, `variables`). |
| `src/routes/procesos.js` | Fase 2 | Comentario explícito `// FASE 2 — Rutas para gestión de procesos v3.0`. |
| `src/routes/subprocesos.js` | Fase 2 | Comentario explícito `// FASE 2 — Rutas para gestión de subprocesos y sus registros v3.0`. |
| `src/routes/backups.js` | Fase 2 | Comentario explícito `// FASE 2 — Rutas para gestión de backups (requisito Santiago, administrador)`. |
| `src/db/seed.js` | v2.1 con corrección posterior | Comentario "CORREGIDO: sin credenciales hardcodeadas" — v2.1 base, parcheado para no hardcodear passwords (usa `process.env.ADMIN_PASSWORD`/`TEST_PASSWORD`). |
| `migrations/001_initial_schema.sql` | v2.1 original | Nombre y orden sugieren esquema base (tenants, usuarios, registros). |
| `migrations/002_v3_schema.sql` | Fase 2 | Nombre explícito `v3_schema` — agrega `procesos`, `subprocesos`, `variables`, `registros_subproceso`, `valores_registro`, `adjuntos`, `backups`, etc. (tablas consumidas por las rutas Fase 2). |
| `migrations/seed_procesos.sql` | Fase 2 | Datos semilla específicos de `procesos`/`subprocesos`, tablas que no existen en el esquema v2.1. |
| `src/models/` (vacío) | Sin clasificar | Directorio sin contenido; no se puede atribuir a ninguna fase. |

---

## 7. Causa raíz probable

El proyecto migró de un esquema v2.1 (auth por rutas propias + `registros` genéricos por tipo `CM-RE-XXXX`, usando `pool` crudo) hacia un esquema v3.0/Fase 2 (procesos → subprocesos → variables → registros_subproceso, pensado para usar `@fastify/postgres` vía `fastify.pg` y un decorador `fastify.authenticate`). La migración quedó **a medio camino**:

- Se agregaron las rutas de Fase 2 y se registraron en `server.js`, pero nunca se instaló/registró `@fastify/postgres` ni se creó el decorador `fastify.authenticate`.
- Al escribir `routes/registros.js` para Fase 2 se sobrescribió el archivo que antes tenía el CRUD v2.1 con `export default`, sin conservar ese export ni ese contenido.
- `routes/auth.js` terminó con una copia del middleware en lugar de las rutas de login (posible copy-paste erróneo durante la migración).
- `server-simplificado.js` quedó como resabio del server v2.1 pre-Fase 2, sin actualizarse ni eliminarse.

## 8. Recomendaciones (siguiente paso, no ejecutado)

- Restaurar o reescribir `src/routes/auth.js` con las rutas reales de login/validate (default export, plugin Fastify).
- Restaurar el CRUD v2.1 de `registros.js` **o** decidir formalmente que queda reemplazado por `registrarRutasRegistros`/`subprocesos.js`, actualizando el README en consecuencia.
- Agregar `export default` a `registros.js` si `server.js`/`server-simplificado.js` deben seguir importándolo como default, o quitar ese import si ya no aplica.
- Instalar y registrar `@fastify/postgres` en `server.js`, o migrar todas las rutas Fase 2 a usar el `pool` de `config/db.js` (como ya hace `usuarios.js`) en vez de `fastify.pg`.
- Registrar un decorador `fastify.authenticate` (típicamente vía `fastify.decorate('authenticate', async (req, reply) => { await req.jwtVerify() })` en `server.js`) antes de registrar las rutas que lo usan.
- Unificar los tres guards de rol duplicados (`middleware/auth.js`, `routes/auth.js`, `crearGuardRolAdmin` en `backups.js`) en una sola implementación reutilizable.
- Decidir el destino de `src/server-simplificado.js` (eliminar o fusionar) y de `src/models/` (vacío).
