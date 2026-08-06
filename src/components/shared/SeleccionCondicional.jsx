/**
 * CannRoad v3.0 — SeleccionCondicional
 * Componente para selecciones con opción 'Otros' que despliega campo de texto libre
 * Usado en: Motivo de Salida, Condiciones de Entrega, etc.
 */

import { useState } from 'react';

export function SeleccionCondicional({ 
    nombre,
    opciones = [],
    valor = '',
    valorTexto = '',
    onChange,
    readOnly = false,
    obligatorio = false,
    descripcion = ''
}) {
    const [expandido, setExpandido] = useState(valor?.endsWith('_especificar') || !!valorTexto);

    const tieneOtros = opciones.some(op => op.includes('Otros') || op.includes('OTROS'));

    const handleSelectChange = (e) => {
        const nuevoValor = e.target.value;
        onChange?.({ valor: nuevoValor, valorTexto: '' });

        if (nuevoValor.includes('Otros') || nuevoValor.includes('OTROS')) {
            setExpandido(true);
        } else {
            setExpandido(false);
        }
    };

    const handleTextoChange = (e) => {
        onChange?.({ valor, valorTexto: e.target.value });
    };

    return (
        <div className="space-y-2">
            <label className="label-base">
                {nombre}
                {obligatorio && <span className="text-error ml-1">*</span>}
            </label>

            {/* Select principal */}
            <select
                value={valor}
                onChange={handleSelectChange}
                disabled={readOnly}
                className="input-base w-full"
                required={obligatorio}
            >
                <option value="">Seleccionar una opción...</option>
                {opciones.map((op, idx) => (
                    <option key={idx} value={op}>
                        {op}
                    </option>
                ))}
            </select>

            {descripcion && (
                <p className="text-xs text-muted-text">{descripcion}</p>
            )}

            {/* Campo de texto si selecciona "Otros" */}
            {expandido && tieneOtros && (
                <div className="mt-3 p-3 bg-white/40 rounded-input border border-white/30">
                    <label className="label-base text-sm">
                        Especificar (obligatorio si seleccionó "Otros")
                    </label>
                    <textarea
                        value={valorTexto}
                        onChange={handleTextoChange}
                        disabled={readOnly}
                        placeholder="Describe en detalle..."
                        rows={3}
                        className={`
                            input-base resize-none
                            ${!valorTexto && valor?.includes('Otros') ? 'border-error/50' : ''}
                        `}
                    />
                    {!valorTexto && valor?.includes('Otros') && (
                        <p className="text-xs text-error mt-1">
                            ⚠️ Este campo es obligatorio cuando seleccionas "Otros"
                        </p>
                    )}
                </div>
            )}
        </div>
    );
}

export default SeleccionCondicional;
