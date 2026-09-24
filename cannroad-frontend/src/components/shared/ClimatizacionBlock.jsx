/**
 * CannRoad v3.0 — ClimatizacionBlock
 * Componente reutilizable para campos de climatización
 * Se renderiza cuando un subproceso requiere climatización
 * Incluye: Temperatura, Humedad, VPD, CO2, Ventilación
 */

import { useState } from 'react';
import { obtenerEstadoValor, obtenerValidator } from '@/utils/validadores';

const CAMPOS_CLIMATIZACION = [
    { nombre: 'Temperatura Aire', key: 'temperatura', unidad: '°C', tipo: 'numero' },
    { nombre: 'Humedad Relativa', key: 'humedad', unidad: '%', tipo: 'numero' },
    { nombre: 'VPD', key: 'vpd', unidad: 'kPa', tipo: 'numero' },
    { nombre: 'CO2', key: 'co2', unidad: 'ppm', tipo: 'numero' },
    { nombre: 'Ventilación', key: 'ventilacion', unidad: null, tipo: 'seleccion' },
];

export function ClimatizacionBlock({ 
    valores = {}, 
    onChange,
    readOnly = false 
}) {
    const [estados, setEstados] = useState({});

    const handleChange = (key, valor) => {
        onChange?.({ ...valores, [key]: valor });

        // Calcular estado visual (ok/warning/error)
        if (key !== 'ventilacion') {
            const validator = obtenerValidator(key);
            if (validator) {
                setEstados({
                    ...estados,
                    [key]: obtenerEstadoValor(valor, validator),
                });
            }
        }
    };

    return (
        <div className="space-y-4">
            <h3 className="text-subheading font-display font-medium text-navy-text">
                Climatización del Ambiente
            </h3>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                {CAMPOS_CLIMATIZACION.map((campo) => {
                    const valor = valores[campo.key] || '';
                    const estado = estados[campo.key] || 'ok';

                    return (
                        <div key={campo.key}>
                            <label className="label-base">{campo.nombre}</label>

                            {campo.tipo === 'numero' ? (
                                <input
                                    type="number"
                                    value={valor}
                                    onChange={(e) => handleChange(campo.key, e.target.value)}
                                    disabled={readOnly}
                                    placeholder={`Ej: 23.5${campo.unidad ? ' ' + campo.unidad : ''}`}
                                    className={`
                                        input-base
                                        ${estado === 'error' ? 'border-error/50 bg-error/5' : ''}
                                        ${estado === 'warning' ? 'border-liquid-brass/50 bg-liquid-brass/5' : ''}
                                    `}
                                />
                            ) : campo.tipo === 'seleccion' ? (
                                <select
                                    value={valor}
                                    onChange={(e) => handleChange(campo.key, e.target.value)}
                                    disabled={readOnly}
                                    className="input-base"
                                >
                                    <option value="">Seleccionar...</option>
                                    <option value="Baja">Baja</option>
                                    <option value="Media">Media</option>
                                    <option value="Alta">Alta</option>
                                </select>
                            ) : null}

                            {campo.unidad && (
                                <p className="text-xs text-muted-text mt-1">
                                    Unidad: {campo.unidad}
                                </p>
                            )}

                            {/* Indicador de estado */}
                            {estado !== 'ok' && campo.tipo === 'numero' && (
                                <p
                                    className={`text-xs mt-1 ${
                                        estado === 'error' ? 'text-error' : 'text-liquid-brass'
                                    }`}
                                >
                                    {estado === 'error' ? '⚠️ Fuera de rango' : '⚡ Dentro del rango de alerta'}
                                </p>
                            )}
                        </div>
                    );
                })}
            </div>
        </div>
    );
}

export default ClimatizacionBlock;
