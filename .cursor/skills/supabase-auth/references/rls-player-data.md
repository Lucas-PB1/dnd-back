# RLS — dados de jogador (fase futura)

## Padrão

```sql
ALTER TABLE rpg.player_character ENABLE ROW LEVEL SECURITY;

CREATE POLICY "owner_read" ON rpg.player_character
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "owner_write" ON rpg.player_character
  FOR ALL USING (auth.uid() = user_id);
```

## Catálogo PHB

Sem RLS restritivo — leitura pública:

```sql
CREATE POLICY "catalog_public_read" ON rpg.phb_class
  FOR SELECT USING (true);
```

## Nest + RLS

- API usa `DATABASE_URL` com role que respeita RLS, **ou**
- Service role só para catálogo; user JWT via Supabase client para fichas

Decidir na fase de fichas — documentar em migration TypeORM separada.
