-- Run once in the SQL editor of each Supabase project.
create table if not exists public.keep_alive (
  id integer primary key check (id = 1)
);

insert into public.keep_alive (id) values (1) on conflict (id) do nothing;

alter table public.keep_alive enable row level security;
revoke all on public.keep_alive from anon, authenticated;
grant select on public.keep_alive to anon;
drop policy if exists "Allow anonymous heartbeat read" on public.keep_alive;
create policy "Allow anonymous heartbeat read"
  on public.keep_alive for select to anon using (id = 1);
