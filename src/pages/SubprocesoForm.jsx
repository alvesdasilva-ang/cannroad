/**
 * CannRoad v3.0 — SubprocesoForm
 * Formulario dinámico: carga variables de la API y renderiza con DynamicFieldRenderer
 * Agrupa: variables + climatización (si aplica) + responsables
 * Submits a: POST /subprocesos/:id/registros
 */

import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import client from '@/api/client';
import { useRequireRol } from '@/hooks/useRequireRol';
import GlassPanel from '@/components/shared/GlassPanel';
import DynamicFieldRenderer from '@/components/forms/DynamicFieldRenderer';
import ClimatizacionBlock from '@/components/shared/ClimatizacionBlock';
import ResponsablesFooter from '@/components/shared/ResponsablesFooter';
import StatusBadge from '@/components/shared/StatusBadge';

export function SubprocesoForm() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { autorizado, cargando: cargandoAuth } = useRequireRol(['operario_cultivo', 'director_tecnico', 'administrador']);

    const [subproceso, setSubproceso] = useState(null);
    const [variables, setVariables] = useState([]);
    const [valores, setValores] = useState({});
    const [climatizacion, setClimatizacion] = useState({});
    const [responsables, setResponsables] = useState({
        responsable_sala: '',
        responsable_calidad: '',
    });
    const [codigoLote, setCodigoLote] = useState('');

    const [cargando, setCargando] = useState(true);
    const [enviando, setEnviando] = useState(false);
    const [error, setError] = useState('');
    const [exito, setExito] = useState(false);

    useEffect(() => {
        if (!autorizado || cargandoAuth) return;

        cargarSubproceso();
    }, [id, autorizado, cargandoAuth]);

    const cargarSubproceso = async () => {
        try {
            setCargando(true);
            const data = await client.subprocesos.variables(id);

            setSubproceso(data.subproceso);
            setVariables(data.variables || []);
            setError('');
        } catch (err) {
            console.error('[SubprocesoForm] Error:', err);
            setError(err.message || 'Error al cargar variables');
        } finally {
            setCargando(false);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setEnviando(true);

        try {
            // Validar obligatorios
            if (!codigoLote) throw new Error('Código de lote es obligatorio');
            if (!responsables.responsable_sala) throw new Error('Responsable de Sala es obligatorio');
            if (!responsables.responsable_calidad) throw new Error('Responsable de Calidad es obligatorio');

            // Construir payload
            const payload = {
                codigo_lote: codigoLote,
                responsable_sala: responsables.responsable_sala,
                responsable_calidad: responsables.responsable_calidad,
                climatizacion: subproceso?.requiere_climatizacion ? climatizacion : null,
                valores: Object.entries(valores).map(([varId, valor]) => ({
                    variable_id: parseInt(varId),
                    valor,
                })),
            };

            // Crear registro
            const resultado = await client.subprocesos.crearRegistro(id, payload);

            setExito(true);
            console.log('[SubprocesoForm] Registro creado:', resultado);

            // Redirigir después de 2 segundos
            setTimeout(() => {
                navigate('/modulo-productivo');
            }, 2000);
        } catch (err) {
            console.error('[SubprocesoForm] Error:', err);
            setError(err.message || 'Error al crear registro');
        } finally {
            setEnviando(false);
        }
    };

    if (cargandoAuth || !autorizado) {
        return (
            <div className="min-h-screen flex items-center justify-center p-8">
                <GlassPanel className="p-12 text-center">
                    <p className="text-muted-text">Verificando permisos...</p>
                </GlassPanel>
            </div>
        );
    }

    if (cargando) {
        return (
            <div className="min-h-screen flex items-center justify-center p-8">
                <GlassPanel className="p-12 text-center">
                    <p className="text-muted-text">Cargando formulario...</p>
                </GlassPanel>
            </div>
        );
    }

    if (!subproceso) {
        return (
            <div className="min-h-screen flex items-center justify-center p-8">
                <GlassPanel className="p-12 text-center">
                    <p className="text-error">❌ Subproceso no encontrado</p>
                    <button
                        onClick={() => navigate('/modulo-productivo')}
                        className="btn-primary mt-4"
                    >
                        Volver
                    </button>
                </GlassPanel>
            </div>
        );
    }

    return (
        <div className="min-h-screen p-8 space-y-8">
            {/* Header */}
            <GlassPanel className="p-8">
                <div className="flex items-start justify-between gap-4">
                    <div>
                        <h1 className="text-display-2 font-display mb-2">
                            {subproceso.nombre}
                        </h1>
                        <p className="text-muted-text">{subproceso.descripcion}</p>
                    </div>
                    <StatusBadge estado="neutral">
                        {variables.length} variables
                    </StatusBadge>
                </div>
            </GlassPanel>

            {/* Formulario */}
            <form onSubmit={handleSubmit} className="space-y-8">
                {/* Error */}
                {error && (
                    <GlassPanel className="p-4 bg-error/10 border-error/30">
                        <p className="text-error text-sm">⚠️ {error}</p>
                    </GlassPanel>
                )}

                {/* Éxito */}
                {exito && (
                    <GlassPanel className="p-4 bg-liquid-jade/10 border-liquid-jade/30">
                        <p className="text-liquid-jade text-sm">
                            ✅ Registro creado exitosamente. Redirigiendo...
                        </p>
                    </GlassPanel>
                )}

                {/* Código de lote (obligatorio) */}
                <GlassPanel className="p-6 space-y-4">
                    <h2 className="text-subheading font-display font-medium">Datos del Lote</h2>

                    <div>
                        <label className="label-base">
                            Código de Lote
                            <span className="text-error ml-1">*</span>
                        </label>
                        <input
                            type="text"
                            value={codigoLote}
                            onChange={(e) => setCodigoLote(e.target.value)}
                            disabled={enviando}
                            placeholder="LOT-2026-001"
                            className="input-base w-full"
                            required
                        />
                        <p className="text-xs text-muted-text mt-1">
                            Identificador único del lote/camada
                        </p>
                    </div>
                </GlassPanel>

                {/* Variables dinámicas */}
                {variables.length > 0 && (
                    <GlassPanel className="p-6 space-y-6">
                        <h2 className="text-subheading font-display font-medium">
                            Variables de {subproceso.nombre}
                        </h2>
                        <DynamicFieldRenderer
                            variables={variables}
                            valores={valores}
                            onChange={setValores}
                            readOnly={enviando}
                        />
                    </GlassPanel>
                )}

                {/* Climatización (si aplica) */}
                {subproceso.requiere_climatizacion && (
                    <GlassPanel className="p-6">
                        <ClimatizacionBlock
                            valores={climatizacion}
                            onChange={setClimatizacion}
                            readOnly={enviando}
                        />
                    </GlassPanel>
                )}

                {/* Responsables (obligatorio) */}
                <GlassPanel className="p-6">
                    <ResponsablesFooter
                        responsableSala={responsables.responsable_sala}
                        responsableCalidad={responsables.responsable_calidad}
                        onChange={setResponsables}
                        readOnly={enviando}
                    />
                </GlassPanel>

                {/* Botones */}
                <div className="flex gap-4 justify-end">
                    <button
                        type="button"
                        onClick={() => navigate('/modulo-productivo')}
                        disabled={enviando}
                        className="btn-ghost"
                    >
                        Cancelar
                    </button>
                    <button
                        type="submit"
                        disabled={enviando}
                        className={`
                            btn-primary
                            ${enviando ? 'opacity-50 cursor-not-allowed' : ''}
                        `}
                    >
                        {enviando ? 'Guardando...' : 'Guardar Registro'}
                    </button>
                </div>
            </form>
        </div>
    );
}

export default SubprocesoForm;
