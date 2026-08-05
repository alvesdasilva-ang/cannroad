/**
 * CannRoad v3.0 — ResponsablesFooter
 * Componente para capturar firmas: Responsable de Sala + Responsable de Calidad
 * Se renderiza al final de TODO formulario (regla transversal)
 */

export function ResponsablesFooter({ 
    responsableSala = '', 
    responsableCalidad = '',
    onChange,
    readOnly = false 
}) {
    const handleChange = (field, valor) => {
        onChange?.({
            responsable_sala: field === 'sala' ? valor : responsableSala,
            responsable_calidad: field === 'calidad' ? valor : responsableCalidad,
        });
    };

    return (
        <div className="border-t border-white/30 pt-6 mt-8">
            <h3 className="text-subheading font-display font-medium text-navy-text mb-4">
                Responsables de Registro
            </h3>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Responsable de Sala */}
                <div>
                    <label className="label-base">
                        Responsable de Sala
                        <span className="text-error ml-1">*</span>
                    </label>
                    <input
                        type="text"
                        value={responsableSala}
                        onChange={(e) => handleChange('sala', e.target.value)}
                        disabled={readOnly}
                        placeholder="Nombre completo"
                        className="input-base"
                        required
                    />
                    <p className="text-xs text-muted-text mt-1">
                        Firma de quien realiza el registro en la sala
                    </p>
                </div>

                {/* Responsable de Calidad */}
                <div>
                    <label className="label-base">
                        Responsable de Calidad
                        <span className="text-error ml-1">*</span>
                    </label>
                    <input
                        type="text"
                        value={responsableCalidad}
                        onChange={(e) => handleChange('calidad', e.target.value)}
                        disabled={readOnly}
                        placeholder="Nombre completo"
                        className="input-base"
                        required
                    />
                    <p className="text-xs text-muted-text mt-1">
                        Firma de validación de calidad
                    </p>
                </div>
            </div>

            {/* Nota regulatoria */}
            <p className="text-xs text-muted-text mt-4 p-3 bg-white/30 rounded-input border border-white/20">
                ℹ️ Ambos responsables deben firmar. Este registro es trazable según ANMAT 4159/2023.
            </p>
        </div>
    );
}

export default ResponsablesFooter;
