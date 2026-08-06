import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

// Configuración de Vite para CannRoad v3.0
// Preparada para desarrollo local + deploy a Cloudflare Pages
export default defineConfig({
    plugins: [react()],
    
    // Alias para imports limpios (ej: import x from '@/components/GlassPanel')
    resolve: {
        alias: {
            '@': path.resolve(process.cwd(), './src'),
        },
    },

    // Servidor de desarrollo
    server: {
        port: 5173,
        host: true,        // Permite acceso desde LAN (útil para probar en móvil)
        strictPort: false, // Si 5173 está ocupado, usa el siguiente disponible
        
        // Proxy hacia la API Fastify (evita problemas CORS en desarrollo)
        proxy: {
            '/api': {
                target: 'http://localhost:3000',
                changeOrigin: true,
                secure: false,
            },
            '/procesos': {
                target: 'http://localhost:3000',
                changeOrigin: true,
            },
            '/subprocesos': {
                target: 'http://localhost:3000',
                changeOrigin: true,
            },
            '/registros': {
                target: 'http://localhost:3000',
                changeOrigin: true,
            },
            '/admin': {
                target: 'http://localhost:3000',
                changeOrigin: true,
            },
        },
    },

    // Build para producción (Cloudflare Pages)
    build: {
        outDir: 'dist',
        sourcemap: false,           // Sin sourcemaps en producción (más liviano)
        minify: 'esbuild',          // Minificación rápida
        target: 'es2020',           // Compatible con navegadores modernos
        chunkSizeWarningLimit: 1000,
        
        rollupOptions: {
            output: {
                // Chunking manual para mejor caching en Cloudflare
                manualChunks: {
                    'react-vendor': ['react', 'react-dom', 'react-router-dom'],
                },
            },
        },
    },

    // Preview local del build (útil para probar antes de deploy)
    preview: {
        port: 4173,
        host: true,
    },
});
