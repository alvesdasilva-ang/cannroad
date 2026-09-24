/**
 * CannRoad v3.0 — GlassPanel
 * Componente base: panel con efecto glass, bordes especulares, sombra
 * Se usa para envolver contenido (formularios, listas, detalles)
 */

export function GlassPanel({ children, className = '', hover = false }) {
    return (
        <div
            className={`
                glass-panel
                ${hover ? 'glass-panel-hover' : ''}
                ${className}
            `}
        >
            {children}
        </div>
    );
}

export default GlassPanel;
