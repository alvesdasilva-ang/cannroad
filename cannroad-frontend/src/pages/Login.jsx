/**
 * CannRoad v3.0 — Login Page
 * Formulario de autenticación con JWT
 * Usa: useAuth hook, GlassPanel, client.auth.login()
 */

import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import useAuth from '@/hooks/useAuth';
import GlassPanel from '@/components/shared/GlassPanel';
import StatusBadge from '@/components/shared/StatusBadge';

export function Login() {
    const navigate = useNavigate();
    const { login, cargando, autenticado } = useAuth();
    
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [enviando, setEnviando] = useState(false);

    // Si ya está autenticado, redirige a inicio
    if (autenticado) {
        navigate('/');
        return null;
    }

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setEnviando(true);

        if (!email || !password) {
            setError('Email y contraseña son obligatorios');
            setEnviando(false);
            return;
        }

        const { success, error: loginError } = await login(email, password);

        if (success) {
            navigate('/');
        } else {
            setError(loginError || 'Error desconocido');
            setEnviando(false);
        }
    };

    if (cargando) {
        return (
            <div className="min-h-screen flex items-center justify-center p-8">
                <GlassPanel className="p-12 text-center">
                    <p className="text-muted-text">Cargando...</p>
                </GlassPanel>
            </div>
        );
    }

    return (
        <div className="min-h-screen flex items-center justify-center p-8">
            <GlassPanel className="p-12 max-w-md w-full">
                {/* Header */}
                <div className="mb-8">
                    <h1 className="text-display-2 font-display mb-2">CannRoad</h1>
                </div>

                {/* Formulario */}
                <form onSubmit={handleSubmit} className="space-y-4">
                    {/* Email */}
                    <div>
                        <label className="label-base">Email</label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            disabled={enviando}
                            placeholder="usuario@ejemplo.com"
                            className="input-base w-full"
                            required
                        />
                    </div>

                    {/* Contraseña */}
                    <div>
                        <label className="label-base">Contraseña</label>
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            disabled={enviando}
                            placeholder="••••••••"
                            className="input-base w-full"
                            required
                        />
                    </div>

                    {/* Error */}
                    {error && (
                        <div className="p-3 bg-error/10 border border-error/30 rounded-input">
                            <p className="text-xs text-error">⚠️ {error}</p>
                        </div>
                    )}

                    {/* Botón submit */}
                    <button
                        type="submit"
                        disabled={enviando}
                        className={`
                            btn-primary w-full
                            ${enviando ? 'opacity-50 cursor-not-allowed' : ''}
                        `}
                    >
                        {enviando ? 'Iniciando sesión...' : 'Iniciar sesión'}
                    </button>
                </form>

                {/* Footer info */}
                <div className="mt-6 pt-6 border-t border-white/20">
                    <p className="text-xs text-muted-text text-center">
                        ℹ️ Datos de prueba:<br />
                        Email: naty@fis.com.ar<br />
                        Contraseña: naty2024
                    </p>
                </div>
            </GlassPanel>
        </div>
    );
}

export default Login;
