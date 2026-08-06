/**
 * CannRoad v3.0 — Validadores de rangos
 * Portado del v2.1 (shared/components.js - VALIDATORS)
 * Se usa como fallback si la API no envía rango en las variables
 */

/**
 * Validadores por tipo de variable
 * Estructura: { min, max, warn: { min, max } }
 */
export const VALIDATORS = {
    // Temperatura (°C)
    temperatura: {
        min: 15,
        max: 30,
        warn: { min: 18, max: 28 },
    },

    // Humedad relativa (%)
    humedad: {
        min: 30,
        max: 80,
        warn: { min: 40, max: 70 },
    },

    // VPD - Vapor Pressure Deficit (kPa)
    vpd: {
        min: 0.5,
        max: 2.0,
        warn: { min: 0.8, max: 1.5 },
    },

    // CO2 (ppm)
    co2: {
        min: 400,
        max: 1500,
        warn: { min: 600, max: 1200 },
    },

    // pH (sin unidad)
    ph: {
        min: 5.5,
        max: 7.0,
        warn: { min: 6.0, max: 6.8 },
    },

    // EC - Electrical Conductivity (mS/cm)
    ec: {
        min: 0.5,
        max: 3.0,
        warn: { min: 1.2, max: 2.0 },
    },

    // Ventilación (0-100 %)
    ventilacion: {
        min: 0,
        max: 100,
        warn: { min: 30, max: 80 },
    },

    // Luz PAR (μmol/m²/s)
    par: {
        min: 100,
        max: 1000,
        warn: { min: 300, max: 800 },
    },
};

/**
 * Valida un valor contra un rango
 * @param {number} valor - Valor a validar
 * @param {number} min - Mínimo permitido
 * @param {number} max - Máximo permitido
 * @returns {object} - { válido: boolean, estado: 'ok'|'warning'|'error', mensaje: string }
 */
export function validarRango(valor, min, max) {
    const num = parseFloat(valor);

    if (isNaN(num)) {
        return { válido: false, estado: 'error', mensaje: 'Debe ser un número' };
    }

    if (num < min || num > max) {
        return {
            válido: false,
            estado: 'error',
            mensaje: `Debe estar entre ${min} y ${max}`,
        };
    }

    return { válido: true, estado: 'ok', mensaje: '' };
}

/**
 * Valida un valor y devuelve su estado visual (ok/warning/error)
 * @param {number} valor - Valor a validar
 * @param {object} validator - Objeto con { min, max, warn: { min, max } }
 * @returns {string} - 'ok' | 'warning' | 'error'
 */
export function obtenerEstadoValor(valor, validator) {
    const num = parseFloat(valor);

    if (isNaN(num)) return 'error';

    if (num < validator.min || num > validator.max) return 'error';

    if (validator.warn) {
        if (num < validator.warn.min || num > validator.warn.max) return 'warning';
    }

    return 'ok';
}

/**
 * Obtiene el validador por nombre de variable
 * @param {string} nombreVariable - Ej: 'temperatura', 'humedad', 'vpd'
 * @returns {object|null} - Validador o null si no existe
 */
export function obtenerValidator(nombreVariable) {
    const nombre = nombreVariable.toLowerCase().trim();

    // Búsqueda directa
    if (VALIDATORS[nombre]) return VALIDATORS[nombre];

    // Búsqueda por palabra clave
    if (nombre.includes('temp')) return VALIDATORS.temperatura;
    if (nombre.includes('hum')) return VALIDATORS.humedad;
    if (nombre.includes('vpd')) return VALIDATORS.vpd;
    if (nombre.includes('co2')) return VALIDATORS.co2;
    if (nombre.includes('ph')) return VALIDATORS.ph;
    if (nombre.includes('ec')) return VALIDATORS.ec;
    if (nombre.includes('ventil')) return VALIDATORS.ventilacion;
    if (nombre.includes('par')) return VALIDATORS.par;

    return null;
}

export default {
    VALIDATORS,
    validarRango,
    obtenerEstadoValor,
    obtenerValidator,
};
