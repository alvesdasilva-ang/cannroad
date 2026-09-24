import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Search, X } from 'lucide-react';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export default function SearchBar() {
  const navigate = useNavigate();
  const [isOpen, setIsOpen] = useState(false);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);

  const handleSearch = async (value) => {
    setQuery(value);
    
    if (!value.trim()) {
      setResults([]);
      return;
    }

    setLoading(true);
    try {
      // Buscar en procesos y subprocesos
      const response = await fetch(
        `${API_URL}/api/search?q=${encodeURIComponent(value)}`
      );
      const data = await response.json();
      if (!response.ok || !Array.isArray(data)) {
        console.error('Error searching:', data);
        setResults([]);
        return;
      }
      setResults(data);
    } catch (error) {
      console.error('Error searching:', error);
      setResults([]);
    } finally {
      setLoading(false);
    }
  };

  const handleResultClick = (result) => {
    // Navegar al subproceso, o al listado de procesos si es un proceso
    if (result.type === 'subproceso') {
      navigate(`/subproceso/${result.id}`);
    } else {
      navigate('/modulo-productivo');
    }
    setQuery('');
    setResults([]);
    setIsOpen(false);
  };

  return (
    <div className="relative flex-1 max-w-md">
      {/* Input con lupa */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
        
        <input
          type="text"
          placeholder="Buscar proceso, subproceso..."
          value={query}
          onChange={(e) => handleSearch(e.target.value)}
          onFocus={() => setIsOpen(true)}
          className="w-full pl-10 pr-10 py-2 bg-white border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent text-sm"
        />

        {/* Botón limpiar */}
        {query && (
          <button
            onClick={() => {
              setQuery('');
              setResults([]);
            }}
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
          >
            <X className="w-4 h-4" />
          </button>
        )}
      </div>

      {/* Dropdown de resultados */}
      {isOpen && (query || results.length > 0) && (
        <>
          {/* Overlay para cerrar */}
          <div
            className="fixed inset-0 z-40"
            onClick={() => setIsOpen(false)}
          />

          {/* Lista de resultados */}
          <div className="absolute top-full left-0 right-0 mt-2 bg-white border border-gray-300 rounded-lg shadow-lg z-50 max-h-96 overflow-y-auto">
            {loading && (
              <div className="p-4 text-center text-gray-500">
                Buscando...
              </div>
            )}

            {!loading && results.length === 0 && query && (
              <div className="p-4 text-center text-gray-500 text-sm">
                No se encontraron resultados
              </div>
            )}

            {results.map((result) => (
              <div
                key={`${result.type}-${result.id}`}
                onClick={() => handleResultClick(result)}
                className="px-4 py-3 hover:bg-emerald-50 cursor-pointer border-b last:border-b-0 transition"
              >
                <div className="flex items-start gap-3">
                  <div className="flex-1">
                    <div className="font-semibold text-gray-900 text-sm">
                      {result.nombre}
                    </div>
                    {result.proceso && (
                      <div className="text-xs text-gray-500">
                        Proceso: {result.proceso}
                      </div>
                    )}
                    {result.codigo_ref && (
                      <div className="text-xs text-emerald-600 font-mono">
                        {result.codigo_ref}
                      </div>
                    )}
                  </div>
                  <span className="text-xs bg-emerald-100 text-emerald-700 px-2 py-1 rounded whitespace-nowrap">
                    {result.type === 'proceso' ? 'Proceso' : 'Subproceso'}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
