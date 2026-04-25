-- ═══════════════════════════════════════════════
-- E-MEDICINE B2B - SUPABASE DATABASE SETUP
-- Run this in your Supabase SQL Editor
-- ═══════════════════════════════════════════════

-- 1. PRODUCTS TABLE
create table if not exists products (
  id         serial primary key,
  name       text not null,
  price      numeric(10,2) not null default 0,
  stock      integer not null default 0,
  category   text default 'General',
  created_at timestamptz default now()
);

-- 2. ORDERS TABLE
create table if not exists orders (
  id             serial primary key,
  pharmacy_name  text not null,
  contact_person text,
  mobile         text,
  address        text,
  items          jsonb,
  total          numeric(10,2) default 0,
  status         text default 'pending' check (status in ('pending','delivered','cancelled')),
  created_at     timestamptz default now()
);

-- 3. SEED INITIAL 10 MEDICINES
insert into products (name, price, stock, category) values
  ('Napa (Paracetamol 500mg)',    1.50,  1200, 'Analgesic'),
  ('Amoxicillin 250mg Cap',       8.00,   800, 'Antibiotic'),
  ('Omeprazole 20mg',             6.50,   600, 'Antacid'),
  ('Metformin 500mg',             4.00,   900, 'Antidiabetic'),
  ('Amlodipine 5mg',              5.50,   700, 'Antihypertensive'),
  ('Cetirizine 10mg',             3.00,  1100, 'Antihistamine'),
  ('Azithromycin 500mg',         25.00,   400, 'Antibiotic'),
  ('Losartan 50mg',               7.00,   500, 'Antihypertensive'),
  ('Vitamin D3 1000IU',          12.00,   650, 'Supplement'),
  ('Pantoprazole 40mg',           9.00,   450, 'Antacid')
on conflict do nothing;

-- 4. ENABLE ROW LEVEL SECURITY (optional but recommended)
alter table products enable row level security;
alter table orders enable row level security;

-- Allow public read on products
create policy "Public read products" on products for select using (true);
-- Allow public insert/update (for demo; restrict in production)
create policy "Public insert products" on products for insert with check (true);
create policy "Public update products" on products for update using (true);

-- Allow public insert/read/update on orders
create policy "Public insert orders" on orders for insert with check (true);
create policy "Public read orders" on orders for select using (true);
create policy "Public update orders" on orders for update using (true);

-- ═══════════════════════════════════════════════
-- DONE! Your E-Medicine database is ready.
-- ═══════════════════════════════════════════════
