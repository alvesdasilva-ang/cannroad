/**
 * CannRoad v3.0 — Hook de autenticación
 * Reemplaza requireAuth() del v2.1
 * Proporciona: sesión actual, login, logout, estado de autenticación
 */

import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import client from '@/api/client';

/**
 * Hook useAuth
 * @returns {object} - { usuario, token, autenticado, cargando, login, logout, sesion }
 */
export function useAuth() {
    const [sesion, setSesion] = useState(null);
    const [cargando, setCargando] = useState(true);
    const navigate = useNavigate();

    // Cargar sesión al montar el componente
    useEffect(() => {
        const sesionGuardada = client.obtenerSesion();
        if (sesionGuardada) {
            setSesion(sesionGuardada);
        }
        setCargando(false);
    }, []);

    // Login
    const login = useCallback(async (email, password) => {
        try {
            setCargando(true);
            const data = await client.auth.login(email, password);

            if (data.token && data.usuario) {
                client.guardarSesion(data.token, data.usuario);
                setSesion({ token: data.token, user: data.usuario });
                console.log('[useAuth] Login exitoso:', data.usuario.email);
                return { success: true, data };
            }

            throw new Error('Respuesta de login inválida');
        } catch (err) {
            console.error('[useAuth] Error en login:', err);
            return { success: false, error: err.message };
        } finally {
            setCargando(false);
        }
    }, []);

    // Logout
    const logout = useCallback(() => {
        client.limpiarSesion();
        setSesion(null);
        console.log('[useAuth] Logout');
        navigate('/login');
    }, [navigate]);

    return {
        usuario: sesion?.user || null,
        token: sesion?.token || null,
        autenticado: !!sesion?.token,
        cargando,
        login,
        logout,
        sesion,
    };
}

export default useAuth;
