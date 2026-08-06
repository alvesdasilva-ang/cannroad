/**
 * CannRoad v3.0 — AnimatedLayout (Rediseño Figma)
 * Ambient lighting con orbs emerald/teal (del diseño Figma)
 * Full-screen layout, fade-in suave al cambiar de página
 */

import { useEffect, useRef, useState } from 'react';
import { useLocation } from 'react-router-dom';
import { Children, cloneElement } from 'react';
import NavDock from '@/components/layout/NavDock';

export function AnimatedLayout({ children }) {
    const location = useLocation();
    const contentRef = useRef(null);
    const [filtro, setFiltro] = useState('productivo');

    useEffect(() => {
        if (!contentRef.current) return;
        contentRef.current.style.opacity = '0';
        contentRef.current.style.transform = 'translateY(12px)';

        requestAnimationFrame(() => {
            requestAnimationFrame(() => {
                if (contentRef.current) {
                    contentRef.current.style.transition = 'opacity 0.35s ease-out, transform 0.35s ease-out';
                    contentRef.current.style.opacity = '1';
                    contentRef.current.style.transform = 'translateY(0)';
                }
            });
        });
    }, [location.pathname]);

    const handleFilterChange = (newFiltro) => {
        setFiltro(newFiltro);
    };

    const childrenWithProps = Children.map(children, child => {
        if (child && typeof child.type === 'function') {
            return cloneElement(child, { filtro });
        }
        return child;
    });

    return (
        <div className="min-h-screen bg-white text-gray-800 flex flex-col relative overflow-x-hidden w-screen">

            {/* Ambient background orbs (del Figma) */}
            <div className="ambient-top" />
            <div className="ambient-bottom" />

            {/* NavDock flotante con filtro */}
            <NavDock onFilterChange={handleFilterChange} />

            {/* Contenido con fade-in */}
            <main
                ref={contentRef}
                className="flex-1 w-full flex flex-col pt-32 pb-12 px-8 overflow-y-auto"
            >
                {childrenWithProps}
            </main>
        </div>
    );
}

export default AnimatedLayout;