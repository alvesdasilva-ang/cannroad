/**
 * CannRoad v3.0 — useAnimatedList
 * Hook para animar listas con efecto stagger (un elemento tras otro)
 * Inspirado en React Bits — animación de entrada secuencial
 */

import { useEffect, useRef } from 'react';

/**
 * Anima una lista de elementos con stagger
 * @param {number} itemCount - Cantidad de elementos en la lista
 * @param {number} staggerMs - Delay entre cada elemento (default: 80ms)
 */
export function useAnimatedList(itemCount, staggerMs = 80) {
    const listRef = useRef(null);

    useEffect(() => {
        if (!listRef.current) return;

        const items = listRef.current.children;

        // Estado inicial: invisible y desplazado
        Array.from(items).forEach((item) => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(20px)';
            item.style.transition = 'none';
        });

        // Animar cada elemento con delay progresivo
        Array.from(items).forEach((item, idx) => {
            setTimeout(() => {
                item.style.transition = 'opacity 0.4s ease-out, transform 0.4s ease-out';
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            }, idx * staggerMs);
        });
    }, [itemCount]);

    return listRef;
}

export default useAnimatedList;
