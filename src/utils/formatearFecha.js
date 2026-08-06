/**
 * CannRoad v3.0 — Utilidades de fecha
 * Portado del v2.1 (shared/utils.js)
 * Formato argentino: dd/mm/yyyy hh:mm
 */

/**
 * Formatea una fecha ISO a dd/mm/yyyy hh:mm (notación argentina)
 * @param {string} isoString - Fecha en formato ISO (ej: "2026-07-30T14:42:00.000Z")
 * @returns {string} - Fecha formateada (ej: "30/07/2026 14:42") o "—" si vacío
 */
export function formatearFecha(isoString) {
    if (!isoString) return '—';
    try {
        const fecha = new Date(isoString);
        const dia = String(fecha.getDate()).padStart(2, '0');
        const mes = String(fecha.getMonth() + 1).padStart(2, '0');
        const año = fecha.getFullYear();
        const hora = String(fecha.getHours()).padStart(2, '0');
        const minuto = String(fecha.getMinutes()).padStart(2, '0');
        return `${dia}/${mes}/${año} ${hora}:${minuto}`;
    } catch (err) {
        console.error('[formatearFecha] Error:', err);
        return '—';
    }
}

/**
 * Formatea solo la fecha (sin hora)
 * @param {string} isoString - Fecha en formato ISO
 * @returns {string} - Fecha formateada (ej: "30/07/2026") o "—" si vacío
 */
export function formatearSoloFecha(isoString) {
    if (!isoString) return '—';
    try {
        const fecha = new Date(isoString);
        const dia = String(fecha.getDate()).padStart(2, '0');
        const mes = String(fecha.getMonth() + 1).padStart(2, '0');
        const año = fecha.getFullYear();
        return `${dia}/${mes}/${año}`;
    } catch (err) {
        console.error('[formatearSoloFecha] Error:', err);
        return '—';
    }
}

/**
 * Formatea solo la hora
 * @param {string} isoString - Fecha en formato ISO
 * @returns {string} - Hora formateada (ej: "14:42") o "—" si vacío
 */
export function formatearSoloHora(isoString) {
    if (!isoString) return '—';
    try {
        const fecha = new Date(isoString);
        const hora = String(fecha.getHours()).padStart(2, '0');
        const minuto = String(fecha.getMinutes()).padStart(2, '0');
        return `${hora}:${minuto}`;
    } catch (err) {
        console.error('[formatearSoloHora] Error:', err);
        return '—';
    }
}

/**
 * Calcula la diferencia entre dos fechas en días
 * @param {Date} fecha1 - Primera fecha
 * @param {Date} fecha2 - Segunda fecha
 * @returns {number} - Diferencia en días (positivo si fecha2 > fecha1)
 */
export function diasEntre(fecha1, fecha2) {
    const ms = fecha2 - fecha1;
    return Math.floor(ms / (1000 * 60 * 60 * 24));
}

/**
 * Calcula si una fecha ya pasó (está en el pasado)
 * @param {string} isoString - Fecha en formato ISO
 * @returns {boolean} - true si la fecha está en el pasado
 */
export function estaVencido(isoString) {
    if (!isoString) return false;
    try {
        const fecha = new Date(isoString);
        return fecha < new Date();
    } catch (err) {
        return false;
    }
}

export default {
    formatearFecha,
    formatearSoloFecha,
    formatearSoloHora,
    diasEntre,
    estaVencido,
};
