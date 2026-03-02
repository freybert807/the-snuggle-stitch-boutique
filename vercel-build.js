// vercel-build.js
// Genera boutique-config.js inyectando las variables de entorno de Vercel.
// Ejecutado automáticamente durante el build: node vercel-build.js
//
// En Vercel dashboard, configura:
//   SUPABASE_URL     → https://inaobamnnfpofjlhpzut.supabase.co
//   SUPABASE_ANON_KEY → sb_publishable_AiCHIxut58y_V3jwgocFaw_aLIUlG72

const fs = require('fs');
const path = require('path');

// Lee las variables de entorno (Vercel las inyecta automáticamente)
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.warn('[vercel-build] ⚠️  Variables SUPABASE_URL o SUPABASE_ANON_KEY no encontradas.');
    console.warn('[vercel-build]    Asegúrate de configurarlas en Vercel Dashboard > Settings > Environment Variables');
    console.warn('[vercel-build]    Usando valores de fallback para desarrollo local...');
}

const configContent = `// boutique-config.js — generado automáticamente por vercel-build.js
// NO editar manualmente. NO subir a Git (.gitignore).
window.BOUTIQUE_CONFIG = {
    supabaseUrl: '${supabaseUrl || 'https://inaobamnnfpofjlhpzut.supabase.co'}',
    supabaseKey: '${supabaseKey || 'sb_publishable_AiCHIxut58y_V3jwgocFaw_aLIUlG72'}'
};
`;

const outputPath = path.join(__dirname, 'boutique-config.js');
fs.writeFileSync(outputPath, configContent, 'utf8');
console.log('[vercel-build] ✅ boutique-config.js generado correctamente.');
