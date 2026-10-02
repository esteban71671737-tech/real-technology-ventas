-- Ejecuta este SQL una sola vez en Supabase > SQL Editor

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.sales TO anon, authenticated;

DROP POLICY IF EXISTS sales_delete ON public.sales;
CREATE POLICY sales_delete
ON public.sales
FOR DELETE
TO anon, authenticated
USING (true);
