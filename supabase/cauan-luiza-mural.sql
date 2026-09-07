-- Mural de Recados Cauan & Luiza
-- Cada visitante recebe uma sessão anônima do Supabase.
-- Mensagens ficam visíveis por 24 horas e só podem ser editadas/excluídas pelo autor.

create extension if not exists pgcrypto;

create table if not exists public.cauan_luiza_messages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid(),
  display_name text not null check (char_length(trim(display_name)) between 1 and 40),
  message text not null check (char_length(trim(message)) between 1 and 280),
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '24 hours'),
  updated_at timestamptz not null default now()
);

create index if not exists cauan_luiza_messages_active_idx
  on public.cauan_luiza_messages (expires_at desc, created_at desc);

alter table public.cauan_luiza_messages enable row level security;

create or replace function public.cauan_luiza_message_metadata()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if tg_op = 'INSERT' then
    new.user_id := coalesce(auth.uid(), new.user_id);
    new.created_at := coalesce(new.created_at, now());
    new.expires_at := new.created_at + interval '24 hours';
  else
    new.user_id := old.user_id;
    new.created_at := old.created_at;
    new.expires_at := old.expires_at;
  end if;

  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists cauan_luiza_message_metadata on public.cauan_luiza_messages;
create trigger cauan_luiza_message_metadata
before insert or update on public.cauan_luiza_messages
for each row execute function public.cauan_luiza_message_metadata();

drop policy if exists "Anyone can read active messages" on public.cauan_luiza_messages;
create policy "Anyone can read active messages"
on public.cauan_luiza_messages
for select
to anon, authenticated
using (expires_at > now());

drop policy if exists "Anonymous visitors can create messages" on public.cauan_luiza_messages;
create policy "Anonymous visitors can create messages"
on public.cauan_luiza_messages
for insert
to authenticated
with check (auth.uid() is not null and user_id = auth.uid());

drop policy if exists "Authors can update their messages" on public.cauan_luiza_messages;
create policy "Authors can update their messages"
on public.cauan_luiza_messages
for update
to authenticated
using (user_id = auth.uid() and expires_at > now())
with check (user_id = auth.uid());

drop policy if exists "Authors can delete their messages" on public.cauan_luiza_messages;
create policy "Authors can delete their messages"
on public.cauan_luiza_messages
for delete
to authenticated
using (user_id = auth.uid());


-- Mural de memórias com foto anexada em data URL otimizada pelo navegador.
create table if not exists public.cauan_luiza_memories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid(),
  display_name text not null check (char_length(trim(display_name)) between 1 and 40),
  caption text not null check (char_length(trim(caption)) between 1 and 280),
  photo_data text not null check (char_length(photo_data) between 20 and 4500000),
  created_at timestamptz not null default now()
);

create index if not exists cauan_luiza_memories_created_idx
  on public.cauan_luiza_memories (created_at desc);

alter table public.cauan_luiza_memories enable row level security;

drop policy if exists "Anyone can read memories" on public.cauan_luiza_memories;
create policy "Anyone can read memories"
on public.cauan_luiza_memories
for select
to anon, authenticated
using (true);

drop policy if exists "Anonymous visitors can create memories" on public.cauan_luiza_memories;
create policy "Anonymous visitors can create memories"
on public.cauan_luiza_memories
for insert
to authenticated
with check (auth.uid() is not null and user_id = auth.uid());

drop policy if exists "Authors can delete memories" on public.cauan_luiza_memories;
create policy "Authors can delete memories"
on public.cauan_luiza_memories
for delete
to authenticated
using (user_id = auth.uid());

create or replace function public.cauan_luiza_memory_metadata()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  new.user_id := coalesce(auth.uid(), new.user_id);
  new.created_at := coalesce(new.created_at, now());
  return new;
end;
$$;

drop trigger if exists cauan_luiza_memory_metadata on public.cauan_luiza_memories;
create trigger cauan_luiza_memory_metadata
before insert on public.cauan_luiza_memories
for each row execute function public.cauan_luiza_memory_metadata();


-- Reações compartilhadas para cada recado ativo.
create table if not exists public.cauan_luiza_message_reactions (
  id uuid primary key default gen_random_uuid(),
  message_id uuid not null references public.cauan_luiza_messages(id) on delete cascade,
  user_id uuid not null default auth.uid(),
  reaction text not null check (reaction in ('heart', 'anatomical_heart', 'sparkles')),
  created_at timestamptz not null default now(),
  unique (message_id, user_id, reaction)
);

create index if not exists cauan_luiza_message_reactions_message_idx
  on public.cauan_luiza_message_reactions (message_id, reaction);

alter table public.cauan_luiza_message_reactions enable row level security;

drop policy if exists "Anyone can read message reactions" on public.cauan_luiza_message_reactions;
create policy "Anyone can read message reactions"
on public.cauan_luiza_message_reactions
for select
to anon, authenticated
using (exists (
  select 1 from public.cauan_luiza_messages message
  where message.id = message_id and message.expires_at > now()
));

drop policy if exists "Visitors can create message reactions" on public.cauan_luiza_message_reactions;
create policy "Visitors can create message reactions"
on public.cauan_luiza_message_reactions
for insert
to authenticated
with check (
  auth.uid() is not null
  and user_id = auth.uid()
  and exists (
    select 1 from public.cauan_luiza_messages message
    where message.id = message_id and message.expires_at > now()
  )
);

drop policy if exists "Visitors can remove their message reactions" on public.cauan_luiza_message_reactions;
create policy "Visitors can remove their message reactions"
on public.cauan_luiza_message_reactions
for delete
to authenticated
using (user_id = auth.uid());
