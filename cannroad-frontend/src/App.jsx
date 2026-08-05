import { Routes, Route, Navigate } from 'react-router-dom';
import useAuth from '@/hooks/useAuth';
import ErrorBoundary from '@/components/ErrorBoundary';
import AnimatedLayout from '@/components/layout/AnimatedLayout';
import Login from '@/pages/Login';
import ModuloProductivo from '@/pages/ModuloProductivo';
import SubprocesoForm from '@/pages/SubprocesoForm';
import Configuracion from '@/pages/Configuracion';

function Cargando() {
    return (
        <div className="min-h-screen flex items-center justify-center">
            <p className="text-gray-400 text-sm animate-pulse">Cargando...</p>
        </div>
    );
}

function ProtectedRoute({ children, autenticado, cargando }) {
    if (cargando) return <Cargando />;
    if (!autenticado) return <Navigate to="/login" replace />;
    return (
        <AnimatedLayout>
            {children}
        </AnimatedLayout>
    );
}

function App() {
    const { autenticado, cargando } = useAuth();

    return (
        <ErrorBoundary>
            <Routes>
                <Route path="/login" element={<Login />} />

                <Route path="/" element={
                    <ProtectedRoute autenticado={autenticado} cargando={cargando}>
                        <ModuloProductivo />
                    </ProtectedRoute>
                } />

                <Route path="/modulo-productivo" element={
                    <ProtectedRoute autenticado={autenticado} cargando={cargando}>
                        <ModuloProductivo />
                    </ProtectedRoute>
                } />

                <Route path="/subproceso/:id" element={
                    <ProtectedRoute autenticado={autenticado} cargando={cargando}>
                        <SubprocesoForm />
                    </ProtectedRoute>
                } />

                <Route path="/configuracion" element={
                    <ProtectedRoute autenticado={autenticado} cargando={cargando}>
                        <Configuracion />
                    </ProtectedRoute>
                } />

                <Route path="*" element={<Navigate to="/" replace />} />
            </Routes>
        </ErrorBoundary>
    );
}

export default App;