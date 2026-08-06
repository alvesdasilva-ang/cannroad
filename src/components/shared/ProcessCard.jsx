/**
 * CannRoad v3.0 — ProcessCard
 * Componente para mostrar un proceso en grid
 * Muestra: nombre, icono, cantidad de subprocesos, descripción
 */

import { useState } from 'react';

const ICONOS_PROCESOS = {
    potted_plant: '🪴',
    propagate: '🌱',
    flower: '🌸',
    harvest: '✂️',
    dry: '🏜️',
    scissors: '✂️',
    package: '📦',
    archive: '📚',
    scale: '⚖️',
    leaf: '🍃',
    microscope: '🔬',
    flask: '⚗️',
    file: '📋',
    wrench: '🔧',
    truck: '🚚',
};

export function ProcessCard({ 
    proceso, 
    onClick,
    expandido = false,
    subprocesos = []
}) {
    const [expandidoLocal, setExpandidoLocal] = useState(expandido);

    const icono = ICONOS_PROCESOS[proceso.icono] || '📌';
    const cantidadSp = subprocesos.length || proceso.cantidad_subprocesos || 0;
    const esProductivo = proceso.tipo === 'productivo';

    const handleClick = () => {
        setExpandidoLocal(!expandidoLocal);
        onClick?.(proceso);
    };

    return (
        <div className="flex flex-col">
            {/* Card principal */}
            <button
                onClick={handleClick}
                className={`
                    glass-panel glass-panel-hover p-6
                    text-left transition-all
                    ${expandidoLocal ? 'rounded-b-none border-b-0' : ''}
                `}
            >
                <div className="flex items-start justify-between">
                    <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                            <span className="text-3xl">{icono}</span>
                            <div>
                                <h3 className="text-heading font-display font-medium">
                                    {proceso.nombre}
                                </h3>
                                <p className="text-xs text-muted-text uppercase tracking-wider">
                                    {esProductivo ? 'Productivo' : 'Administrativo'}
                                </p>
                            </div>
                        </div>
                        {proceso.descripcion && (
                            <p className="text-small text-muted-text mt-2">
                                {proceso.descripcion}
                            </p>
                        )}
                    </div>

                    <div className="flex flex-col items-end gap-2">
                        <span className="badge badge-neutral text-xs">
                            {cantidadSp} sub
                        </span>
                        <span className={`text-2xl transition-transform ${expandidoLocal ? 'rotate-180' : ''}`}>
                            ▼
                        </span>
                    </div>
                </div>
            </button>

            {/* Subprocesos expandidos */}
            {expandidoLocal && subprocesos.length > 0 && (
                <div className="glass-panel rounded-t-none border-t border-white/30 p-0 bg-white/30 backdrop-blur-sm">
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2 p-4">
                        {subprocesos.map((sp) => (
                            <button
                                key={sp.id}
                                onClick={() => {
                                    onClick?.({ ...proceso, subproceso: sp });
                                }}
                                className="text-left p-3 rounded-input bg-white/40 hover:bg-white/60 transition-colors border border-white/20"
                            >
                                <p className="font-medium text-sm text-navy-text">
                                    {sp.nombre}
                                </p>
                                <p className="text-xs text-muted-text mt-1">
                                    {sp.cantidad_variables || 0} variables
                                </p>
                            </button>
                        ))}
                    </div>
                </div>
            )}
        </div>
    );
}

export default ProcessCard;
