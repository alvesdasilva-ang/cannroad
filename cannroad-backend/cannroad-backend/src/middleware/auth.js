// src/middleware/auth.js — Middleware de autenticación
export async function verificarJWT(fastify, request) {
    try {
        await request.jwtVerify();
    } catch (err) {
        throw fastify.httpErrors.unauthorized('Token inválido o expirado.');
    }
}

export async function verificarRol(request, rolesRequeridos) {
    if (!rolesRequeridos.includes(request.user.rol)) {
        throw fastify.httpErrors.forbidden('Rol insuficiente para esta operación.');
    }
}
