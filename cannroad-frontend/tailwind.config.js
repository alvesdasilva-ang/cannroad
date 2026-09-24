/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './index.html',
        './src/**/*.{js,jsx}',
    ],
    theme: {
        extend: {
            // ============================================================
            // COLORES — Sistema Liquid Glass (del prototipo Stitch)
            // ============================================================
            colors: {
                // Colores primarios de marca
                'liquid-jade': {
                    DEFAULT: '#478778',   // Primary
                    50:  '#EEF5F3',
                    100: '#D9E9E5',
                    200: '#B4D3CB',
                    300: '#8FBCB1',
                    400: '#6AA697',
                    500: '#478778',       // Base
                    600: '#396C60',
                    700: '#2B5148',
                    800: '#1E3630',
                    900: '#101B18',
                },
                'liquid-cream': {
                    DEFAULT: '#F2EDE1',   // Papel envejecido
                    50:  '#FBF9F4',
                    100: '#F8F5EC',
                    200: '#F2EDE1',       // Base
                    300: '#E8DFCB',
                    400: '#DDD0B4',
                    500: '#D2C09D',
                },
                'liquid-brass': {
                    DEFAULT: '#8B6B2E',   // Latón para acentos regulatorios
                    50:  '#F5EFDF',
                    100: '#EBDFBF',
                    200: '#D7BF7F',
                    300: '#C39F3F',
                    400: '#A98333',
                    500: '#8B6B2E',       // Base
                    600: '#6F5525',
                    700: '#53401C',
                },
                
                // Textos
                'navy-text': '#1A1A2E',
                'muted-text': '#6B6B7D',
                
                // Secundarios y estados
                'secondary': '#77591E',   // Módulo de Gestión
                'error': '#BA1A1A',       // Vencidos, críticos
                'warning': '#E8A33D',     // Alertas medias
                'success': '#478778',     // Aprobado, OK
                
                // Glass effect
                'glass-bg': 'rgba(255, 255, 255, 0.4)',
                'glass-border': 'rgba(255, 255, 255, 0.6)',
                'glass-bg-dark': 'rgba(26, 26, 46, 0.4)',
            },

            // ============================================================
            // TIPOGRAFÍA — Fraunces + IBM Plex
            // ============================================================
            fontFamily: {
                'display': ['Fraunces', 'Georgia', 'serif'],
                'sans': ['"IBM Plex Sans"', 'system-ui', 'sans-serif'],
                'mono': ['"IBM Plex Mono"', 'ui-monospace', 'monospace'],
            },
            fontSize: {
                'display-1': ['4rem',    { lineHeight: '1.1', letterSpacing: '-0.02em' }],
                'display-2': ['3rem',    { lineHeight: '1.15', letterSpacing: '-0.02em' }],
                'display-3': ['2.25rem', { lineHeight: '1.2', letterSpacing: '-0.01em' }],
                'heading':   ['1.5rem',  { lineHeight: '1.3', letterSpacing: '-0.01em' }],
                'subheading': ['1.125rem', { lineHeight: '1.4' }],
                'body':      ['1rem',    { lineHeight: '1.6' }],
                'small':     ['0.875rem', { lineHeight: '1.5' }],
                'caption':   ['0.75rem', { lineHeight: '1.4', letterSpacing: '0.05em' }],
            },

            // ============================================================
            // RADIOS — Shapes Liquid Glass
            // ============================================================
            borderRadius: {
                'card':  '24px',    // Cards principales
                'panel': '20px',    // Paneles internos
                'input': '8px',     // Inputs y selects
                'pill':  '9999px',  // Badges, pills
            },

            // ============================================================
            // SOMBRAS — Sutiles, editoriales
            // ============================================================
            boxShadow: {
                'glass':       '0 4px 16px rgba(26, 26, 46, 0.06), 0 1px 2px rgba(26, 26, 46, 0.04)',
                'glass-hover': '0 8px 24px rgba(26, 26, 46, 0.08), 0 2px 4px rgba(26, 26, 46, 0.05)',
                'card':        '0 2px 8px rgba(26, 26, 46, 0.04)',
                'inner-glow':  'inset 0 1px 0 rgba(255, 255, 255, 0.6)',
            },

            // ============================================================
            // BACKDROP FILTER — Efecto glass
            // ============================================================
            backdropBlur: {
                'glass': '12px',
            },

            // ============================================================
            // ANIMACIONES — Sutiles, para preparar React Bits en Fase 10
            // ============================================================
            animation: {
                'fade-in':    'fadeIn 0.4s ease-out',
                'slide-up':   'slideUp 0.5s ease-out',
                'aurora':     'aurora 20s ease-in-out infinite',
            },
            keyframes: {
                fadeIn: {
                    '0%':   { opacity: '0' },
                    '100%': { opacity: '1' },
                },
                slideUp: {
                    '0%':   { opacity: '0', transform: 'translateY(20px)' },
                    '100%': { opacity: '1', transform: 'translateY(0)' },
                },
                aurora: {
                    '0%, 100%': { transform: 'translate(0, 0) scale(1)' },
                    '50%':      { transform: 'translate(2%, -1%) scale(1.05)' },
                },
            },
        },
    },
    plugins: [],
};
