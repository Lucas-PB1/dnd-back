# RLS — fase futura

## Catálogo PHB (fase 2)

Tabelas `phb_*` podem ter SELECT público:

```sql
ALTER TABLE rpg.phb_class ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read" ON rpg.phb_class FOR SELECT USING (true);
```

## Fichas de personagem (fase futura)

```sql
CREATE POLICY "owner_only" ON rpg.player_character
  FOR ALL USING (auth.uid() = user_id);
```

## NestJS

- Catálogo: service role ou anon com policy read
- Dados de jogador: validar `auth.uid()` via Supabase JWT ou RLS

## Este projeto

Fase 2 = só catálogo read-only. RLS opcional no catálogo; obrigatório quando houver `player_character_*`.
