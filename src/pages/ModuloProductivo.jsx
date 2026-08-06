/**
 * CannRoad v3.0 — Módulo Productivo (Rediseño Figma)
 * Sin emojis, sin IA bloating, íconos SVG profesionales
 * Layout full-screen con content-area verde tenue del Figma
 */

import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import client from '@/api/client';
import { useAnimatedList } from '@/hooks/useAnimatedList';

// Ícono de flecha para las cards (del Figma)
const ArrowIcon = () => (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M5 12h14M12 5l7 7-7 7"/>
    </svg>
);

const ChevronIcon = ({ rotated }) => (
    <svg
        width="16" height="16" viewBox="0 0 24 24" fill="none"
        stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
        style={{ transform: rotated ? 'rotate(180deg)' : 'none', transition: 'transform 0.3s ease' }}
    >
        <polyline points="6 9 12 15 18 9"/>
    </svg>
);

function ProcessRow({ proceso, subprocesos = [], onSubprocesoClick, onExpand, expandido }) {
    return (
        <div>
            {/* Fila principal */}
            <div
                className="process-card"
                onClick={() => onExpand(proceso.id)}
            >
                <div className="flex items-center gap-6">
                    {/* Número de orden */}
                    <div className="w-12 h-12 rounded-full bg-emerald-50 border border-emerald-200 flex items-center justify-center text-emerald-600 font-bold text-sm flex-shrink-0">
                        {String(proceso.orden || proceso.id).padStart(2, '0')}
                    </div>

                    <div>
                        <h3 className="text-lg font-semibold text-gray-800 group-hover:text-emerald-700 transition-colors">
                            {proceso.nombre}
                        </h3>
                    </div>
                </div>

                <div className="flex items-center gap-8">
                    <div className="text-right">
                        <div className="text-xs font-medium text-gray-400 uppercase tracking-wide">Tipo</div>
                        <div className="text-emerald-600 font-semibold text-sm capitalize">
                            {proceso.tipo === 'productivo' ? 'Productivo' : 'Administrativo'}
                        </div>
                    </div>

                    <div className="w-8 h-8 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 group-hover:border-emerald-300 group-hover:bg-emerald-50 group-hover:text-emerald-600 transition-all">
                        <ChevronIcon rotated={expandido} />
                    </div>
                </div>
            </div>

            {/* Subprocesos expandidos */}
            {expandido && (
                <div className="ml-6 mt-1 mb-2 space-y-1">
                    {subprocesos.length === 0 ? (
                        <p className="text-sm text-gray-400 px-6 py-3">Sin subprocesos configurados</p>
                    ) : (
                        subprocesos.map((sp) => (
                            <button
                                key={sp.id}
                                onClick={() => onSubprocesoClick(sp)}
                                className="w-full text-left px-6 py-3 rounded-xl bg-white border border-emerald-100/50 hover:bg-emerald-50 hover:border-emerald-200 transition-all flex items-center justify-between group"
                            >
                                <p className="text-sm font-medium text-gray-700 group-hover:text-emerald-700 transition-colors">
                                        {sp.nombre}
                                </p>
                                <ArrowIcon />
                            </button>
                        ))
                    )}
                </div>
            )}
        </div>
    );
}

export function ModuloProductivo({ filtro = 'productivo' }) {
    const navigate = useNavigate();
    const [procesos, setProcesos] = useState([]);
    const [subprocesosMap, setSubprocesosMap] = useState({});
    const [expandidoId, setExpandidoId] = useState(null);
    const [cargando, setCargando] = useState(true);
    const [error, setError] = useState('');

    const listRef = useAnimatedList(procesos.length, 50);

    useEffect(() => {
        cargarProcesos();
    }, []);

    const cargarProcesos = async () => {
        try {
            setCargando(true);
            setError('');
            const data = await client.procesos.listar();
            setProcesos(data.data || []);
        } catch (err) {
            setError(err.message || 'Error al cargar procesos');
        } finally {
            setCargando(false);
        }
    };

    const handleExpand = async (procesoId) => {
        if (expandidoId === procesoId) {
            setExpandidoId(null);
            return;
        }
        setExpandidoId(procesoId);
        if (!subprocesosMap[procesoId]) {
            try {
                const data = await client.procesos.subprocesos(procesoId);
                setSubprocesosMap(prev => ({ ...prev, [procesoId]: data.data || [] }));
            } catch (err) {
                console.error('[ModuloProductivo] Error cargando subprocesos:', err);
            }
        }
    };

    const handleSubprocesoClick = (sp) => {
        navigate(`/subproceso/${sp.id}`);
    };

    const procesosFiltrados = procesos.filter(p => {
        if (filtro === 'productivo') return p.tipo === 'productivo';
        if (filtro === 'administrativo') return p.tipo === 'administrativo';
        return true;
    });

    return (
        <div className="flex-1 content-area">
            {/* Header */}
            <div className="mb-8 shrink-0">
                <h1 className="text-4xl font-bold tracking-tight text-gray-900">
                    {filtro === 'productivo' ? 'Procesos Productivos' : 'Gestión'}
                </h1>
            </div>

            {/* Error */}
            {error && (
                <div className="mb-4 p-4 bg-red-50 border border-red-100 rounded-xl flex items-center justify-between">
                    <p className="text-sm text-red-600">{error}</p>
                    <button onClick={cargarProcesos} className="btn-secondary text-sm">
                        Reintentar
                    </button>
                </div>
            )}

            {/* Cargando */}
            {cargando && (
                <div className="flex-1 flex items-center justify-center">
                    <p className="text-gray-400 text-sm animate-pulse">Cargando procesos...</p>
                </div>
            )}

            {/* Lista de procesos */}
            {!cargando && (
                <div ref={listRef} className="flex-1 flex flex-col gap-3 overflow-y-auto pr-2 pb-4">
                    {procesosFiltrados.map(proceso => (
                        <ProcessRow
                            key={proceso.id}
                            proceso={proceso}
                            subprocesos={subprocesosMap[proceso.id] || []}
                            expandido={expandidoId === proceso.id}
                            onExpand={handleExpand}
                            onSubprocesoClick={handleSubprocesoClick}
                        />
                    ))}

                    {procesosFiltrados.length === 0 && (
                        <div className="flex-1 flex items-center justify-center">
                            <p className="text-gray-400 text-sm">No hay procesos en esta categoría</p>
                        </div>
                    )}
                </div>
            )}
        </div>
    );
}

export default ModuloProductivo;