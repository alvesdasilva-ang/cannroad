/**
 * CannRoad v3.0 — DynamicFieldRenderer
 * Componente core: lee variables de la API y renderiza formulario dinámico
 * Soporta: numero, texto, fecha, booleano, seleccion, seleccion_condicional
 * Valida rangos, opciones, campos obligatorios
 */

import { useState } from 'react';
import { obtenerValidator, validarRango } from '@/utils/validadores';
import SeleccionCondicional from '@/components/shared/SeleccionCondicional';

export function DynamicFieldRenderer({ 
    variables = [],
    valores = {},
    onChange,
    readOnly = false,
    mostrarDescripciones = true
}) {
    const [errores, setErrores] = useState({});

    const renderarCampo = (variable) => {
        const { id, nombre, tipo_dato, unidad, rango_min, rango_max, obligatorio, opciones, descripcion } = variable;
        const valor = valores[id] || '';

        const handleChange = (nuevoValor) => {
            // Validar si es numérico
            if (tipo_dato === 'numero') {
                const min = rango_min !== null ? rango_min : (obtenerValidator(nombre)?.min || -Infinity);
                const max = rango_max !== null ? rango_max : (obtenerValidator(nombre)?.max || Infinity);

                const validacion = validarRango(nuevoValor, min, max);
                if (nuevoValor && !validacion.válido) {
                    setErrores({ ...errores, [id]: validacion.mensaje });
                } else {
                    const nuevosErrores = { ...errores };
                    delete nuevosErrores[id];
                    setErrores(nuevosErrores);
                }
            }

            // Validar obligatorio
            if (obligatorio && !nuevoValor) {
                setErrores({ ...errores, [id]: 'Campo obligatorio' });
            } else {
                const nuevosErrores = { ...errores };
                delete nuevosErrores[id];
                setErrores(nuevosErrores);
            }

            onChange?.({ ...valores, [id]: nuevoValor });
        };

        const error = errores[id];

        switch (tipo_dato) {
            case 'numero':
                return (
                    <div key={id} className="space-y-1">
                        <label className="label-base">
                            {nombre} {unidad && `(${unidad})`}
                            {obligatorio && <span className="text-error ml-1">*</span>}
                        </label>
                        <input
                            type="number"
                            value={valor}
                            onChange={(e) => handleChange(e.target.value)}
                            disabled={readOnly}
                            min={rango_min}
                            max={rango_max}
                            placeholder={`Ej: ${rango_min || 0}`}
                            className={`
                                input-base
                                ${error ? 'border-error/50 bg-error/5' : ''}
                            `}
                        />
                        {mostrarDescripciones && descripcion && (
                            <p className="text-xs text-muted-text">{descripcion}</p>
                        )}
                        {error && <p className="text-xs text-error">⚠️ {error}</p>}
                    </div>
                );

            case 'texto':
                return (
                    <div key={id} className="space-y-1">
                        <label className="label-base">
                            {nombre}
                            {obligatorio && <span className="text-error ml-1">*</span>}
                        </label>
                        <input
                            type="text"
                            value={valor}
                            onChange={(e) => handleChange(e.target.value)}
                            disabled={readOnly}
                            placeholder="Escribe aquí..."
                            className={`
                                input-base
                                ${error ? 'border-error/50 bg-error/5' : ''}
                            `}
                        />
                        {mostrarDescripciones && descripcion && (
                            <p className="text-xs text-muted-text">{descripcion}</p>
                        )}
                        {error && <p className="text-xs text-error">⚠️ {error}</p>}
                    </div>
                );

            case 'fecha':
                return (
                    <div key={id} className="space-y-1">
                        <label className="label-base">
                            {nombre}
                            {obligatorio && <span className="text-error ml-1">*</span>}
                        </label>
                        <input
                            type="date"
                            value={valor}
                            onChange={(e) => handleChange(e.target.value)}
                            disabled={readOnly}
                            className={`
                                input-base
                                ${error ? 'border-error/50 bg-error/5' : ''}
                            `}
                        />
                        {mostrarDescripciones && descripcion && (
                            <p className="text-xs text-muted-text">{descripcion}</p>
                        )}
                        {error && <p className="text-xs text-error">⚠️ {error}</p>}
                    </div>
                );

            case 'booleano':
                return (
                    <div key={id} className="space-y-1">
                        <label className="flex items-center gap-2 cursor-pointer">
                            <input
                                type="checkbox"
                                checked={valor === true || valor === 'true'}
                                onChange={(e) => handleChange(e.target.checked)}
                                disabled={readOnly}
                                className="w-4 h-4"
                            />
                            <span className="label-base mb-0">{nombre}</span>
                            {obligatorio && <span className="text-error">*</span>}
                        </label>
                        {mostrarDescripciones && descripcion && (
                            <p className="text-xs text-muted-text">{descripcion}</p>
                        )}
                    </div>
                );

            case 'seleccion':
                return (
                    <div key={id} className="space-y-1">
                        <label className="label-base">
                            {nombre}
                            {obligatorio && <span className="text-error ml-1">*</span>}
                        </label>
                        <select
                            value={valor}
                            onChange={(e) => handleChange(e.target.value)}
                            disabled={readOnly}
                            className={`
                                input-base
                                ${error ? 'border-error/50 bg-error/5' : ''}
                            `}
                        >
                            <option value="">Seleccionar...</option>
                            {Array.isArray(opciones) && opciones.map((op, idx) => (
                                <option key={idx} value={op}>
                                    {op}
                                </option>
                            ))}
                        </select>
                        {mostrarDescripciones && descripcion && (
                            <p className="text-xs text-muted-text">{descripcion}</p>
                        )}
                        {error && <p className="text-xs text-error">⚠️ {error}</p>}
                    </div>
                );

            case 'seleccion_condicional':
                return (
                    <div key={id}>
                        <SeleccionCondicional
                            nombre={nombre}
                            opciones={Array.isArray(opciones) ? opciones : []}
                            valor={valor}
                            onChange={(data) => handleChange(data.valor)}
                            readOnly={readOnly}
                            obligatorio={obligatorio}
                            descripcion={mostrarDescripciones ? descripcion : ''}
                        />
                        {error && <p className="text-xs text-error mt-1">⚠️ {error}</p>}
                    </div>
                );

            default:
                return null;
        }
    };

    return (
        <div className="space-y-6">
            {variables.length === 0 ? (
                <p className="text-muted-text text-center py-8">
                    Sin variables configuradas para este subproceso
                </p>
            ) : (
                variables.map((variable) => (
                    <div key={variable.id}>
                        {renderarCampo(variable)}
                    </div>
                ))
            )}
        </div>
    );
}

export default DynamicFieldRenderer;
