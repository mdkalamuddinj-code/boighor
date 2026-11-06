-- BOIGHOR DIGITAL LIBRARY DATABASE

create extension if not exists pgcrypto;

-- User profiles
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  role text default 'member',
  created_at timestamptz default now()
);

-- Books database
create table public.books (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  author text,
  description text,
  category text,
  file_path text,
  visibility text default 'public',
  status text default 'pending',
  submitted_by uuid references auth.users(id),
  created_at timestamptz default now()
);

-- Security
alter table public.profiles enable row level security;
alter table public.books enable row level security;

-- Public approved books
create policy "Public books"
on public.books
for select
using (
  visibility = 'public'
  and status = 'approved'
);

-- Members submit books
create policy "Submit books"
on public.books
for insert
to authenticated
with check (
  auth.uid() = submitted_by
  and status = 'pending'
  and visibility = 'public'
);

-- Admin can manage books
create policy "Admin manage books"
on public.books
for all
to authenticated
using (
  exists (
    select 1 from public.profiles
    where id = auth.uid()
    and role = 'admin'
  )
)
with check (
  exists (
    select 1 from public.profiles
    where id = auth.uid()
    and role = 'admin'
  )
);
