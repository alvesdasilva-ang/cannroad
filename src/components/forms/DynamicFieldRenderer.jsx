/**
 * CannRoad v3.0 — DynamicFieldRenderer 
 * Renderiza campos dinámicamente con soporte para:
 * - Campos dependientes (seleccion_condicional)
 * - Autocarga condicional
 * - Validación ALCOA+
 */

import { useMemo, useEffect, useState } from 'react';

export function DynamicFieldRenderer({
    variable,
    value,
    onChange,
    formData = {},
    setFormData = () => {},
    error = null,
}) {
    const [filteredOptions, setFilteredOptions] = useState([]);
    const [isDependent, setIsDependent] = useState(false);

    // Detectar si es campo dependiente
    useEffect(() => {
        if (variable.tipo_dato === 'seleccion_condicional' || variable.opciones?.depende_de) {
            setIsDependent(true);

            // Si depende de otro campo, filtrar opciones
            if (variable.opciones?.depende_de) {
                const parentFieldName = variable.opciones.depende_de;
                const parentValue = formData[parentFieldName];

                if (parentValue && variable.opciones.datos?.[parentValue]) {
                    setFilteredOptions(variable.opciones.datos[parentValue]);
                } else {
                    setFilteredOptions([]);
                }
            }
        } else {
            setIsDependent(false);
        }
    }, [formData, variable]);

    // Autocarga condicional
    useEffect(() => {
        if (variable.opciones?.mapeo && variable.opciones.depende_de) {
            const parentFieldName = variable.opciones.depende_de;
            const parentValue = formData[parentFieldName];

            if (parentValue && variable.opciones.mapeo[parentValue]) {
                const autoloadedValue = variable.opciones.mapeo[parentValue];
                onChange(autoloadedValue);

                // Si es en un formulario con setFormData, actualizar estado global
                if (setFormData) {
                    setFormData(prev => ({
                        ...prev,
                        [variable.nombre]: autoloadedValue
                    }));
                }
            }
        }
    }, [formData, variable, onChange, setFormData]);

    // Obtener opciones válidas
    const options = useMemo(() => {
        if (isDependent && filteredOptions.length > 0) {
            return filteredOptions;
        }
        if (variable.opciones?.datos && !variable.opciones.depende_de) {
            return Array.isArray(variable.opciones.datos)
                ? variable.opciones.datos
                : Object.keys(variable.opciones.datos);
        }
        return [];
    }, [variable.opciones, isDependent, filteredOptions]);

    const isReadonly = variable.opciones?.mapeo && variable.opciones.depende_de;
    const isMandatory = variable.obligatorio ? true : false;
    const hasError = error && error.length > 0;

    // Label con indicador de obligatorio
    const label = (
        <label className="label-base">
            {variable.nombre}
            {isMandatory && <span className="text-red-500 ml-1">*</span>}
            {isReadonly && <span className="text-emerald-600 ml-1 text-xs font-semibold">(AUTOCARGADO)</span>}
        </label>
    );

    // Mensaje de descripción
    const description = variable.descripcion ? (
        <p className="text-xs text-gray-400 mt-1">{variable.descripcion}</p>
    ) : null;

    // Mensaje de error
    const errorMsg = hasError ? (
        <p className="text-xs text-red-500 mt-1">{error}</p>
    ) : null;

    // Indicador de dependencia
    const dependencyNote = isDependent && variable.opciones?.depende_de ? (
        <p className="text-xs text-amber-600 mt-1 flex items-center gap-1">
            <span>ℹ</span>
            Depende de: <strong>{variable.opciones.depende_de}</strong>
        </p>
    ) : null;

    // === TIPO: TEXTO ===
    if (variable.tipo_dato === 'texto') {
        return (
            <div>
                {label}
                <input
                    type="text"
                    value={value || ''}
                    onChange={(e) => onChange(e.target.value)}
                    placeholder={variable.descripcion || 'Ingrese texto aquí'}
                    className={`input-base ${hasError ? 'border-red-500' : ''}`}
                    disabled={isReadonly}
                />
                {description}
                {errorMsg}
                {dependencyNote}
            </div>
        );
    }

    // === TIPO: NUMERO ===
    if (variable.tipo_dato === 'numero') {
        return (
            <div>
                {label}
                <input
                    type="number"
                    value={value || ''}
                    onChange={(e) => onChange(e.target.value ? parseFloat(e.target.value) : '')}
                    placeholder={variable.descripcion || 'Ingrese un número'}
                    min={variable.rango_min || undefined}
                    max={variable.rango_max || undefined}
                    step={variable.unidad === 'decimal' ? '0.01' : '1'}
                    className={`input-base ${hasError ? 'border-red-500' : ''}`}
                    disabled={isReadonly}
                />
                {description}
                {errorMsg}
                {dependencyNote}
            </div>
        );
    }

    // === TIPO: FECHA ===
    if (variable.tipo_dato === 'fecha') {
        return (
            <div>
                {label}
                <input
                    type="date"
                    value={value || ''}
                    onChange={(e) => onChange(e.target.value)}
                    className={`input-base ${hasError ? 'border-red-500' : ''}`}
                    disabled={isReadonly}
                />
                {description}
                {errorMsg}
                {dependencyNote}
            </div>
        );
    }

    // === TIPO: BOOLEANO ===
    if (variable.tipo_dato === 'booleano') {
        return (
            <div className="flex items-center gap-3">
                <input
                    type="checkbox"
                    id={`check_${variable.id}`}
                    checked={value || false}
                    onChange={(e) => onChange(e.target.checked)}
                    disabled={isReadonly}
                    className="w-4 h-4 cursor-pointer"
                />
                <label htmlFor={`check_${variable.id}`} className="cursor-pointer flex-1">
                    {variable.nombre}
                    {isMandatory && <span className="text-red-500 ml-1">*</span>}
                </label>
                {description}
                {errorMsg}
                {dependencyNote}
            </div>
        );
    }

    // === TIPO: SELECCION (Simple) ===
    if (variable.tipo_dato === 'seleccion') {
        return (
            <div>
                {label}
                <select
                    value={value || ''}
                    onChange={(e) => onChange(e.target.value)}
                    className={`input-base cursor-pointer ${hasError ? 'border-red-500' : ''}`}
                    disabled={isReadonly}
                >
                    <option value="">Seleccionar...</option>
                    {options.map((opt) => (
                        <option key={opt} value={opt}>
                            {opt}
                        </option>
                    ))}
                </select>
                {description}
                {errorMsg}
                {dependencyNote}
            </div>
        );
    }

    // === TIPO: SELECCION CONDICIONAL ===
    if (variable.tipo_dato === 'seleccion_condicional') {
        const parentFieldName = variable.opciones?.depende_de;
        const parentValue = formData[parentFieldName];
        const isParentEmpty = !parentValue;

        return (
            <div className="bg-emerald-50/30 border-l-3 border-emerald-600 pl-3 py-2 rounded-sm">
                {label}
                <select
                    value={value || ''}
                    onChange={(e) => onChange(e.target.value)}
                    className={`input-base cursor-pointer ${hasError ? 'border-red-500' : ''}`}
                    disabled={isParentEmpty || isReadonly}
                >
                    <option value="">
                        {isParentEmpty ? `Selecciona ${parentFieldName} primero` : 'Seleccionar...'}
                    </option>
                    {!isParentEmpty && filteredOptions.map((opt) => (
                        <option key={opt} value={opt}>
                            {opt}
                        </option>
                    ))}
                </select>
                {description}
                <p className="text-xs text-emerald-700 mt-1 flex items-center gap-1">
                    <span>ℹ</span>
                    Depende de: <strong>{parentFieldName}</strong>
                </p>
                {errorMsg}
            </div>
        );
    }

    // Fallback
    return (
        <div className="text-red-500 text-sm">
            ⚠️ Tipo de dato no reconocido: {variable.tipo_dato}
        </div>
    );
}

export default DynamicFieldRenderer;