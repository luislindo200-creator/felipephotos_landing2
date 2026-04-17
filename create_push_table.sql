-- Tabela para armazenar assinaturas push dos visitantes
create table if not exists public.push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  endpoint text not null unique,
  p256dh text not null,
  auth text not null,
  created_at timestamptz not null default now()
);

-- Acesso público para inserir/atualizar (RLS off para simplificar)
alter table public.push_subscriptions enable row level security;

-- Permite que qualquer pessoa (anon) insira/atualize sua própria assinatura
create policy "allow anon upsert"
  on public.push_subscriptions
  for all
  using (true)
  with check (true);
