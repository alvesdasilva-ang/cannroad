/**
 * CannRoad v3.0 — Configuración de Usuario
 * Perfil, preferencias y datos de sesión
 */

import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import useAuth from '@/hooks/useAuth';

const BackIcon = () => (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M19 12H5M12 5l-7 7 7 7"/>
    </svg>
);

export function Configuracion() {
    const navigate = useNavigate();
    const { usuario, logout } = useAuth();

    const [nombre, setNombre] = useState(usuario?.nombre || '');
    const [email] = useState(usuario?.email || '');
    const [guardando, setGuardando] = useState(false);
    const [exito, setExito] = useState(false);

    const handleGuardar = async (e) => {
        e.preventDefault();
        setGuardando(true);
        // Placeholder — conectar a API cuando esté lista
        await new Promise(r => setTimeout(r, 800));
        setGuardando(false);
        setExito(true);
        setTimeout(() => setExito(false), 3000);
    };

    return (
        <div className="max-w-2xl mx-auto w-full">

            {/* Header con back */}
            <div className="flex items-center gap-4 mb-8">
                <button
                    onClick={() => navigate(-1)}
                    className="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:bg-gray-50 hover:text-gray-600 transition-all"
                >
                    <BackIcon />
                </button>
                <h1 className="text-3xl font-bold tracking-tight text-gray-900">Configuración</h1>
            </div>

            {/* Sección: Perfil */}
            <div className="bg-white rounded-2xl border border-gray-100 shadow-sm mb-4 overflow-hidden">
                <div className="px-6 py-4 border-b border-gray-50">
                    <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-wide">Perfil</h2>
                </div>
                <form onSubmit={handleGuardar} className="p-6 space-y-5">
                    <div>
                        <label className="label-base">Nombre completo</label>
                        <input
                            type="text"
                            value={nombre}
                            onChange={e => setNombre(e.target.value)}
                            className="input-base"
                            placeholder="Tu nombre"
                        />
                    </div>
                    <div>
                        <label className="label-base">Correo electrónico</label>
                        <input
                            type="email"
                            value={email}
                            disabled
                            className="input-base opacity-50 cursor-not-allowed"
                        />
                        <p className="text-xs text-gray-400 mt-1">El email no puede modificarse</p>
                    </div>
                    <div>
                        <label className="label-base">Rol</label>
                        <input
                            type="text"
                            value={usuario?.rol?.replace(/_/g, ' ') || ''}
                            disabled
                            className="input-base opacity-50 cursor-not-allowed capitalize"
                        />
                    </div>

                    {exito && (
                        <p className="text-sm text-emerald-600 font-medium">Cambios guardados correctamente</p>
                    )}

                    <button
                        type="submit"
                        disabled={guardando}
                        className="btn-primary"
                    >
                        {guardando ? 'Guardando...' : 'Guardar cambios'}
                    </button>
                </form>
            </div>

            {/* Sección: Seguridad */}
            <div className="bg-white rounded-2xl border border-gray-100 shadow-sm mb-4 overflow-hidden">
                <div className="px-6 py-4 border-b border-gray-50">
                    <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-wide">Seguridad</h2>
                </div>
                <div className="p-6 space-y-5">
                    <div>
                        <label className="label-base">Contraseña actual</label>
                        <input type="password" className="input-base" placeholder="••••••••" />
                    </div>
                    <div>
                        <label className="label-base">Nueva contraseña</label>
                        <input type="password" className="input-base" placeholder="••••••••" />
                    </div>
                    <div>
                        <label className="label-base">Confirmar nueva contraseña</label>
                        <input type="password" className="input-base" placeholder="••••••••" />
                    </div>
                    <button className="btn-secondary">
                        Cambiar contraseña
                    </button>
                </div>
            </div>

            {/* Sección: Sesión */}
            <div className="bg-white rounded-2xl border border-red-50 shadow-sm overflow-hidden">
                <div className="px-6 py-4 border-b border-red-50">
                    <h2 className="text-sm font-semibold text-red-400 uppercase tracking-wide">Sesión</h2>
                </div>
                <div className="p-6">
                    <p className="text-sm text-gray-500 mb-4">Al cerrar sesión deberás volver a ingresar tus credenciales.</p>
                    <button
                        onClick={() => logout()}
                        className="inline-flex items-center gap-2 px-5 py-2.5 rounded-full text-sm font-medium bg-red-50 text-red-600 border border-red-100 hover:bg-red-100 transition-all"
                    >
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                            <polyline points="16 17 21 12 16 7"/>
                            <line x1="21" y1="12" x2="9" y2="12"/>
                        </svg>
                        Cerrar sesión
                    </button>
                </div>
            </div>
        </div>
    );
}

export default Configuracion;
