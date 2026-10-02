-- REAL TECHNOLOGY V2
-- Ejecuta todo en Supabase > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.products (
 id text primary key,
 brand text not null,
 name text not null,
 category text not null check(category in ('iPhone','Android')),
 type text not null default 'Nuevo',
 commission numeric(12,2) not null default 0,
 active boolean not null default true,
 created_at timestamptz not null default now()
);
create table if not exists public.sales (
 id text primary key,
 product_id text references public.products(id) on delete set null,
 seller_name text not null default '',
 sale_date date not null,
 sale_time time not null default current_time,
 commission numeric(12,2) not null default 0,
 note text default '',
 created_at timestamptz not null default now()
);
create index if not exists sales_date_idx on public.sales(sale_date);
alter table public.products enable row level security;
alter table public.sales enable row level security;
drop policy if exists products_select on public.products;
drop policy if exists products_insert on public.products;
drop policy if exists products_update on public.products;
drop policy if exists products_delete on public.products;
drop policy if exists sales_select on public.sales;
drop policy if exists sales_insert on public.sales;
drop policy if exists sales_update on public.sales;
drop policy if exists sales_delete on public.sales;
create policy products_select on public.products for select to anon,authenticated using(true);
create policy products_insert on public.products for insert to anon,authenticated with check(true);
create policy products_update on public.products for update to anon,authenticated using(true) with check(true);
create policy products_delete on public.products for delete to anon,authenticated using(true);
create policy sales_select on public.sales for select to anon,authenticated using(true);
create policy sales_insert on public.sales for insert to anon,authenticated with check(true);
create policy sales_update on public.sales for update to anon,authenticated using(true) with check(true);
create policy sales_delete on public.sales for delete to anon,authenticated using(true);
-- Estas políticas son adecuadas para una instalación personal inicial.
-- Si se agregan varios vendedores, conviene activar Supabase Auth y RLS por usuario/rol.


-- Permisos explícitos para que la aplicación web pueda eliminar ventas.
grant select, insert, update, delete on table public.sales to anon, authenticated;
grant select, insert, update, delete on table public.products to anon, authenticated;
