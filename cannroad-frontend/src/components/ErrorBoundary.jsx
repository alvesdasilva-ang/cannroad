import { Component } from 'react';
import GlassPanel from '@/components/shared/GlassPanel';

export class ErrorBoundary extends Component {
    constructor(props) {
        super(props);
        this.state = { error: null };
    }

    static getDerivedStateFromError(error) {
        return { error };
    }

    componentDidCatch(error, info) {
        console.error('[ErrorBoundary]', error, info);
    }

    render() {
        if (this.state.error) {
            return (
                <div className="min-h-screen flex items-center justify-center p-8">
                    <GlassPanel className="p-8 max-w-md text-center">
                        <h2 className="text-subheading font-display mb-4">⚠️ Error</h2>
                        <p className="text-muted-text mb-6 text-sm">
                            {this.state.error?.message || 'Algo salió mal'}
                        </p>
                        <button
                            onClick={() => window.location.reload()}
                            className="btn-primary w-full"
                        >
                            Recargar página
                        </button>
                    </GlassPanel>
                </div>
            );
        }

        return this.props.children;
    }
}

export default ErrorBoundary;