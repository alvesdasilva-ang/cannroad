/**
 * CannRoad v3.0 — NavDock (Rediseño Figma)
 * Floating pill con animated indicator, avatar con dropdown de config, logo clickeable
 */

import { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import useAuth from '@/hooks/useAuth';

const TABS = [
    {
        id: 'productivo',
        label: 'Procesos Productivos',
        filter: 'productivo',
        icon: (
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2z"/>
                <path d="M12 6v6l4 2"/>
            </svg>
        ),
    },
    {
        id: 'gestion',
        label: 'Gestión',
        filter: 'administrativo',
        icon: (
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                <circle cx="9" cy="7" r="4"/>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
        ),
    },
];

export function NavDock({ onFilterChange }) {
    const navigate = useNavigate();
    const { usuario, logout } = useAuth();
    const navRef = useRef(null);
    const avatarRef = useRef(null);

    const [indicatorStyle, setIndicatorStyle] = useState({ left: 0, width: 0, opacity: 0 });
    const [activeTab, setActiveTab] = useState(TABS[0].id);
    const [dropdownOpen, setDropdownOpen] = useState(false);

    useEffect(() => {
        if (!navRef.current) return;
        const activeButton = navRef.current.querySelector(`[data-tab="${activeTab}"]`);
        if (activeButton) {
            setIndicatorStyle({
                left: activeButton.offsetLeft,
                width: activeButton.offsetWidth,
                opacity: 1,
            });
        }
    }, [activeTab]);

    // Cerrar dropdown al hacer click afuera
    useEffect(() => {
        const handleClickOutside = (e) => {
            if (avatarRef.current && !avatarRef.current.contains(e.target)) {
                setDropdownOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const handleTabClick = (tab) => {
        setActiveTab(tab.id);
        if (onFilterChange) onFilterChange(tab.filter);
    };

    const initials = usuario?.nombre
        ? usuario.nombre.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase()
        : usuario?.email?.slice(0, 2).toUpperCase() || 'ND';

    return (
        <div className="fixed top-6 left-0 right-0 z-50 flex justify-center px-4 pointer-events-none">
            <header className="nav-floating px-6 py-3 flex items-center justify-between w-full max-w-5xl pointer-events-auto">

                {/* Logo — clickeable, redirige a home */}
                <button
                    onClick={() => navigate('/modulo-productivo')}
                    className="text-lg font-bold text-emerald-600 uppercase tracking-wider select-none hover:opacity-80 transition-opacity"
                >
                    CannRoad
                </button>

                {/* Tabs con animated pill */}
                <nav
                    ref={navRef}
                    className="flex items-center relative rounded-full bg-emerald-50/50 p-1 border border-emerald-100"
                >
                    <div
                        className="nav-tab-indicator absolute top-1 h-[calc(100%-8px)]"
                        style={{
                            left: indicatorStyle.left,
                            width: indicatorStyle.width,
                            opacity: indicatorStyle.opacity,
                        }}
                    />
                    {TABS.map((tab) => (
                        <button
                            key={tab.id}
                            data-tab={tab.id}
                            onClick={() => handleTabClick(tab)}
                            className={`
                                relative flex items-center gap-1.5 px-4 py-1.5
                                text-sm font-medium transition-colors duration-300
                                z-10 rounded-full select-none
                                ${activeTab === tab.id ? 'text-emerald-700' : 'text-gray-500 hover:text-emerald-600'}
                            `}
                        >
                            {tab.icon}
                            {tab.label}
                        </button>
                    ))}
                </nav>

                {/* Avatar con dropdown + logout */}
                <div className="flex items-center gap-3">

                    {/* Avatar con dropdown de configuración */}
                    <div className="relative" ref={avatarRef}>
                        <button
                            onClick={() => setDropdownOpen(!dropdownOpen)}
                            className="w-8 h-8 rounded-full bg-gradient-to-tr from-emerald-100 to-emerald-50 border border-emerald-200 flex items-center justify-center text-emerald-600 text-sm font-bold shadow-sm hover:border-emerald-300 transition-all"
                            title="Configuración de usuario"
                        >
                            {initials}
                        </button>

                        {/* Dropdown */}
                        {dropdownOpen && (
                            <div className="absolute right-0 top-full mt-2 w-56 bg-white border border-gray-100 rounded-2xl shadow-lg overflow-hidden z-50">
                                {/* Info usuario */}
                                <div className="px-4 py-3 border-b border-gray-50">
                                    <p className="text-sm font-semibold text-gray-800 truncate">
                                        {usuario?.nombre || usuario?.email}
                                    </p>
                                    <p className="text-xs text-gray-400 capitalize mt-0.5">
                                        {usuario?.rol?.replace('_', ' ')}
                                    </p>
                                </div>

                                {/* Opción configuración */}
                                <button
                                    onClick={() => { navigate('/configuracion'); setDropdownOpen(false); }}
                                    className="w-full flex items-center gap-3 px-4 py-3 text-sm text-gray-600 hover:bg-gray-50 transition-colors"
                                >
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <circle cx="12" cy="12" r="3"/>
                                        <path d="M19.07 4.93a10 10 0 0 1 0 14.14M4.93 4.93a10 10 0 0 0 0 14.14"/>
                                    </svg>
                                    Configuración
                                </button>

                                {/* Separador */}
                                <div className="border-t border-gray-50" />

                                {/* Logout */}
                                <button
                                    onClick={() => { logout(); setDropdownOpen(false); }}
                                    className="w-full flex items-center gap-3 px-4 py-3 text-sm text-red-500 hover:bg-red-50 transition-colors"
                                >
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                        <polyline points="16 17 21 12 16 7"/>
                                        <line x1="21" y1="12" x2="9" y2="12"/>
                                    </svg>
                                    Cerrar sesión
                                </button>
                            </div>
                        )}
                    </div>
                </div>
            </header>
        </div>
    );
}

export default NavDock;