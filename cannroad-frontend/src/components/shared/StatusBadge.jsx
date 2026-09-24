/**
 * CannRoad v3.0 — StatusBadge
 * Componente para mostrar estados con colores
 * Estados: success, warning, error, neutral
 */

export function StatusBadge({ estado = 'neutral', children, className = '' }) {
    const estadoMap = {
        success: 'badge-success',
        warning: 'badge-warning',
        error: 'badge-error',
        neutral: 'badge-neutral',
        // Aliases
        aprobado: 'badge-success',
        aceptado: 'badge-success',
        ok: 'badge-success',
        pendiente: 'badge-warning',
        alerta: 'badge-warning',
        rechazado: 'badge-error',
        vencido: 'badge-error',
    };

    const badgeClass = estadoMap[estado] || 'badge-neutral';

    return (
        <span className={`badge ${badgeClass} ${className}`}>
            {children}
        </span>
    );
}

export default StatusBadge;
