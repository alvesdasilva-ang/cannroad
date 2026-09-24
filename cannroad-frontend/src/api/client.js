/**
 * CannRoad v3.0 — Cliente HTTP para la API Fastify
 * Portado del patrón apiUsuarios() del v2.1, ahora genérico
 * Maneja: autenticación JWT, errores 401, logging, retry
 */

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

/**
 * Obtener el JWT del localStorage
 */
function obtenerToken() {
    try {
        const sesion = localStorage.getItem('cannroad_sesion');
        if (!sesion) return null;
        const data = JSON.parse(sesion);
        return data.token || null;
    } catch (err) {
        console.error('[client] Error al parsear sesión:', err);
        return null;
    }
}

/**
 * Guardar sesión en localStorage
 */
export function guardarSesion(token, user) {
    const sesion = { token, user, timestamp: Date.now() };
    localStorage.setItem('cannroad_sesion', JSON.stringify(sesion));
}

/**
 * Limpiar sesión
 */
export function limpiarSesion() {
    localStorage.removeItem('cannroad_sesion');
}

/**
 * Obtener datos de sesión actual
 */
export function obtenerSesion() {
    try {
        const sesion = localStorage.getItem('cannroad_sesion');
        return sesion ? JSON.parse(sesion) : null;
    } catch (err) {
        console.error('[client] Error al obtener sesión:', err);
        return null;
    }
}

/**
 * Hacer request a la API con JWT automático
 * @param {string} path - Ruta relativa (ej: '/procesos', '/subprocesos/1/variables')
 * @param {object} options - Opciones fetch (method, body, headers, etc.)
 * @returns {Promise<object>} - Respuesta JSON parseada
 * @throws {Error} - Si la respuesta no es OK o hay error de red
 */
export async function apiCall(path, options = {}) {
    const token = obtenerToken();
    const url = `${API_URL}${path}`;
    
    const headers = {
        'Content-Type': 'application/json',
        ...(token && { 'Authorization': `Bearer ${token}` }),
        ...(options.headers || {}),
    };

    const config = {
        ...options,
        headers,
    };

    console.log(`[api] → ${options.method || 'GET'} ${path}`);

    try {
        const response = await fetch(url, config);
        const data = await response.json().catch(() => ({}));

        console.log(`[api] ← ${response.status} ${path}`, data);

        // Token expirado o inválido
        if (response.status === 401) {
            console.warn('[api] Sesión expirada (401). Limpiando y redirigiendo al login.');
            limpiarSesion();
            window.location.href = '/login';
            throw new Error('Sesión expirada. Volviendo al login.');
        }

        if (!response.ok) {
            throw new Error(data.message || data.error || `HTTP ${response.status}`);
        }

        return data;
    } catch (err) {
        console.error(`[api] Error en ${path}:`, err);
        throw err;
    }
}

/**
 * GET genérico
 */
export async function get(path) {
    return apiCall(path, { method: 'GET' });
}

/**
 * POST genérico
 */
export async function post(path, body) {
    return apiCall(path, {
        method: 'POST',
        body: JSON.stringify(body),
    });
}

/**
 * PATCH genérico (actualizar parcial)
 */
export async function patch(path, body) {
    return apiCall(path, {
        method: 'PATCH',
        body: JSON.stringify(body),
    });
}

/**
 * DELETE genérico
 */
export async function del(path) {
    return apiCall(path, { method: 'DELETE' });
}

/**
 * === APIS ESPECÍFICAS PARA CANNROAD ===
 */

/**
 * Autenticación
 */
export const auth = {
    login: (email, password) => post('/auth/login', { email, password }),
    logout: () => {
        limpiarSesion();
        return Promise.resolve();
    },
};

/**
 * Procesos y subprocesos
 */
export const procesos = {
    listar: () => get('/procesos'),
    obtener: (id) => get(`/procesos/${id}`),
    subprocesos: (id) => get(`/procesos/${id}/subprocesos`),
};

/**
 * Subprocesos y variables
 */
export const subprocesos = {
    variables: (id) => get(`/subprocesos/${id}/variables`),
    registros: (id, query = {}) => {
        const params = new URLSearchParams(query);
        return get(`/subprocesos/${id}/registros?${params}`);
    },
    crearRegistro: (id, data) => post(`/subprocesos/${id}/registros`, data),
};

/**
 * Registros
 */
export const registros = {
    obtener: (id) => get(`/registros/${id}`),
    anular: (id, motivo) => patch(`/registros/${id}/anular`, { motivo_anulacion: motivo }),
};

/**
 * Usuarios (admin)
 */
export const usuarios = {
    listar: () => get('/api/usuarios'),
    crear: (data) => post('/api/usuarios', data),
    actualizar: (id, data) => patch(`/api/usuarios/${id}`, data),
    eliminar: (id) => del(`/api/usuarios/${id}`),
    resetPassword: (id) => post(`/api/usuarios/${id}/reset-password`, {}),
};

/**
 * Backups (admin)
 */
export const backups = {
    listar: () => get('/admin/backups'),
    crear: () => post('/admin/backups', {}),
    descargar: (id) => {
        // No usa apiCall porque necesita servir un archivo, no JSON
        const token = obtenerToken();
        const url = `${API_URL}/admin/backups/${id}/download`;
        window.location.href = token 
            ? `${url}?token=${token}` 
            : url;
    },
};

export default {
    apiCall,
    get,
    post,
    patch,
    del,
    obtenerToken,
    guardarSesion,
    limpiarSesion,
    obtenerSesion,
    auth,
    procesos,
    subprocesos,
    registros,
    usuarios,
    backups,
};
