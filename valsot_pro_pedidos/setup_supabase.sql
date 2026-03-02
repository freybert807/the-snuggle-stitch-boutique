-- ============================================================
-- VALSOT PRO · Setup SQL para Supabase
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- Proyecto: inaobamnnfpofjlhpzut
-- ============================================================

-- 1. Crear tabla pedidos_pendientes
CREATE TABLE IF NOT EXISTS public.pedidos_pendientes (
    id              BIGSERIAL PRIMARY KEY,
    articulo        TEXT NOT NULL,
    cantidad        INTEGER NOT NULL DEFAULT 1,
    estado          TEXT NOT NULL DEFAULT 'Pendiente'
                        CHECK (estado IN ('Pendiente', 'Aprobado', 'Procesando', 'Cancelado')),
    descripcion     TEXT,
    distribuidor_sugerido TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Trigger para updated_at automático
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_updated_at ON public.pedidos_pendientes;
CREATE TRIGGER set_updated_at
    BEFORE UPDATE ON public.pedidos_pendientes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 3. Habilitar Row Level Security (RLS)
ALTER TABLE public.pedidos_pendientes ENABLE ROW LEVEL SECURITY;

-- 4. Política: Lectura pública (anon key puede SELECT)
CREATE POLICY "Lectura pública pedidos"
    ON public.pedidos_pendientes
    FOR SELECT
    USING (true);

-- 5. Política: Inserción pública (anon key puede INSERT)
CREATE POLICY "Inserción pública pedidos"
    ON public.pedidos_pendientes
    FOR INSERT
    WITH CHECK (true);

-- 6. Política: Actualización pública (anon key puede UPDATE)
--    En producción, esto debería restringirse a usuarios autenticados con rol admin
CREATE POLICY "Actualización pública pedidos"
    ON public.pedidos_pendientes
    FOR UPDATE
    USING (true);

-- 7. Datos de prueba (opcional)
INSERT INTO public.pedidos_pendientes (articulo, cantidad, estado, distribuidor_sugerido, descripcion)
VALUES
    ('Producto Alpha 100mg', 2, 'Pendiente', 'Distribuidora Lima Norte', 'Pedido urgente'),
    ('Producto Beta 250mg', 5, 'Aprobado', 'Distribuidora Sur SAC', null),
    ('Producto Gamma 500g', 1, 'Procesando', 'Mayorista Central', 'Verificar stock antes de despacho'),
    ('Producto Delta 1L', 3, 'Pendiente', null, null);

-- ✅ Tabla lista. Accede via: #valsot-pro en la aplicación
