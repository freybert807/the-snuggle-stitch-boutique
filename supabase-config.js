// supabase-config.js — The Snuggle Stitch Boutique
// Cliente Supabase compartido (UMD) — se carga antes que los scripts de cada página
// Usage: el archivo HTML debe cargar primero el CDN UMD de Supabase, luego este script.
// Resultado: window._db queda disponible globalmente.

(function () {
    const SUPABASE_URL = 'https://inaobamnnfpofjlhpzut.supabase.co';
    const SUPABASE_KEY = 'sb_publishable_AiCHIxut58y_V3jwgocFaw_aLIUlG72';

    if (typeof window !== 'undefined' && window.supabase && window.supabase.createClient) {
        window._db = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);
    } else {
        console.warn('[Supabase Config] El CDN UMD aún no está cargado. Asegúrate de incluirlo antes de este script.');
    }
})();
