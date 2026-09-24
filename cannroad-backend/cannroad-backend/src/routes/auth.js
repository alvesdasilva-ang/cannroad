// src/middleware/auth.js — Middleware de autenticación y autorización
// CORREGIDO: verificarRol ahora recibe request.server en lugar de fastify suelto

export async function verificarJWT(fastify, request) {
    try {
        await request.jwtVerify();
    } catch (err) {
        throw fastify.httpErrors.unauthorized('Token inválido o expirado.');
    }
}

export async function verificarRol(request, rolesRequeridos) {
    const fastify = request.server;
    
    if (!rolesRequeridos.includes(request.user.rol)) {
        throw fastify.httpErrors.forbidden('Rol insuficiente para esta operación.');
    }
}

// Exportar un hook preHandler que combine ambas verificaciones
export function crearGuardRol(rolesRequeridos) {
    return async (request, reply) => {
        // 1. Verificar JWT
        try {
            await request.jwtVerify();
        } catch (err) {
            throw request.server.httpErrors.unauthorized('Token inválido o expirado.');
        }
        
        // 2. Verificar rol
        if (!rolesRequeridos.includes(request.user.rol)) {
            throw request.server.httpErrors.forbidden('Rol insuficiente para esta operación.');
        }
    };
}
