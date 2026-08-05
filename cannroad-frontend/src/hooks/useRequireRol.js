/**
 * CannRoad v3.0 — Hook de verificación de rol
 * Reemplaza requireRol() del v2.1
 * Proporciona: verificación de permisos, redirect si no autorizado
 */

import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import useAuth from './useAuth';

/**
 * Mapeo de nombres de roles (para UI)
 */
export const NOMBRES_ROL = {
    administrador: 'Administrador',
    director_tecnico: 'Director Técnico',
    resp_calidad: 'Responsable de Calidad',
    jefe_produccion: 'Jefe de Producción',
    operario_cultivo: 'Operario de Cultivo',
    operario_postcosecha: 'Operario de Postcosecha',
    operario_pm: 'Operario Planta Madre',
    operario_clonacion: 'Operario Clonación',
    operario_floracion: 'Operario Floración',
    operario_cosecha: 'Operario Cosecha',
    operario_secado: 'Operario Secado',
    operario_trimeo: 'Operario Trimeo',
    operario_empaquetado: 'Operario Empaquetado',
    resp_mantenimiento: 'Responsable de Mantenimiento',
    resp_almacenes: 'Responsable de Almacenes',
};

/**
 * Hook useRequireRol
 * Verifica que el usuario tenga uno de los roles permitidos
 * Si no está autenticado o no tiene permisos, redirige al login
 *
 * @param {string|string[]} rolesPermitidos - Rol o array de roles requeridos
 * @returns {object} - { autorizado: boolean, cargando: boolean, rol: string }
 */
export function useRequireRol(rolesPermitidos) {
    const { usuario, cargando, autenticado } = useAuth();
    const navigate = useNavigate();

    // Normalizar a array
    const rolesArray = Array.isArray(rolesPermitidos) ? rolesPermitidos : [rolesPermitidos];

    useEffect(() => {
        if (cargando) return; // Esperar a que cargue la sesión

        if (!autenticado) {
            console.warn('[useRequireRol] No autenticado. Redirigiendo al login.');
            navigate('/login', { replace: true });
            return;
        }

        const tieneRol = rolesArray.includes(usuario?.rol);

        if (!tieneRol) {
            console.warn(`[useRequireRol] Rol '${usuario?.rol}' no autorizado para esta página.`);
            navigate('/', { replace: true });
            return;
        }

        console.log(`[useRequireRol] Rol autorizado: ${usuario?.rol}`);
    }, [autenticado, cargando, usuario?.rol, rolesArray, navigate]);

    return {
        autorizado: autenticado && rolesArray.includes(usuario?.rol),
        cargando,
        rol: usuario?.rol || null,
    };
}

/**
 * Hook useVerificarRol (sin redirect, solo verificación)
 * Útil para mostrar/ocultar componentes condicionalmente
 *
 * @param {string|string[]} rolesPermitidos - Rol o array de roles
 * @returns {boolean} - true si el usuario tiene uno de los roles
 */
export function useVerificarRol(rolesPermitidos) {
    const { usuario } = useAuth();

    const rolesArray = Array.isArray(rolesPermitidos) ? rolesPermitidos : [rolesPermitidos];

    return rolesArray.includes(usuario?.rol);
}

export default useRequireRol;
