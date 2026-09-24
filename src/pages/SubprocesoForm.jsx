/**
 * CannRoad v3.0 — SubprocesoForm (v2 con campos dependientes)
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

    // Estados para formulario con campos dependientes
    const [formData, setFormData] = useState({});
    const [errors, setErrors] = useState({});

    const [subproceso, setSubproceso] = useState(null);
    const [variables, setVariables] = useState([]);
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

            // Inicializar formData con variables
            const initialFormData = {};
            (data.variables || []).forEach(v => {
                initialFormData[v.nombre] = '';
            });
            setFormData(initialFormData);
        } catch (err) {
            console.error('[SubprocesoForm] Error:', err);
            setError(err.message || 'Error al cargar variables');
        } finally {
            setCargando(false);
        }
    };

    // Actualizar formData cuando cambia una variable
    const handleVariableChange = (variableId, value) => {
        const variable = variables.find(v => v.id === variableId);
        if (!variable) return;

        setFormData(prev => ({
            ...prev,
            [variable.nombre]: value
        }));
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

            // Validar variables obligatorias
            const erroresValidacion = {};
            variables.forEach(v => {
                if (v.obligatorio && !formData[v.nombre]) {
                    erroresValidacion[v.id] = 'Campo obligatorio';
                }
            });

            if (Object.keys(erroresValidacion).length > 0) {
                setErrors(erroresValidacion);
                throw new Error('Completa todos los campos obligatorios');
            }

            // Construir payload (compatible con API existente)
            const payload = {
                codigo_lote: codigoLote,
                responsable_sala: responsables.responsable_sala,
                responsable_calidad: responsables.responsable_calidad,
                climatizacion: subproceso?.requiere_climatizacion ? climatizacion : null,
                valores: Object.entries(formData).map(([varName, valor]) => {
                    const variable = variables.find(v => v.nombre === varName);
                    return {
                        variable_id: variable?.id || 0,
                        valor,
                    };
                }),
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
            {/* Header con botón back */}
            <GlassPanel className="p-8">
                <div className="flex items-start justify-between gap-4">
                    <div className="flex items-center gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:bg-gray-50 hover:text-gray-600 transition-all"
                        >
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                <path d="M19 12H5M12 5l-7 7 7 7"/>
                            </svg>
                        </button>
                        <div>
                            <h1 className="text-display-2 font-display mb-2">
                                {subproceso.nombre}
                            </h1>
                            <p className="text-muted-text">{subproceso.descripcion}</p>
                        </div>
                    </div>
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

                {/* Variables dinámicas con campos dependientes */}
                {variables.length > 0 && (
                    <GlassPanel className="p-6 space-y-6">
                        <h2 className="text-subheading font-display font-medium">
                            Variables de {subproceso.nombre}
                        </h2>
                        <div className="space-y-6">
                            {variables.map((variable) => (
                                <DynamicFieldRenderer
                                    key={variable.id}
                                    variable={variable}
                                    value={formData[variable.nombre] || ''}
                                    onChange={(value) => handleVariableChange(variable.id, value)}
                                    formData={formData}
                                    setFormData={setFormData}
                                    error={errors[variable.id]}
                                />
                            ))}
                        </div>
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
