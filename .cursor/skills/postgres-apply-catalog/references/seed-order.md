# Ordem dos seeds

Aplicados por `scripts/run-seeds.mjs` na ordem de **packs** (não lexicográfica pura entre pastas):

1. `000_truncate.sql`
2. `phb/`
3. `subclass/`
4. `valdas/` → `valdas-gunslinger/` → `valdas-player-pack-2/`
5. `steinhardt-eldritch-hunt/`
6. `northlands-heroes/`
7. `griffons-saddlebag/`
8. `grim-hollow/`
9. `dmg/`
10. `combat/`
11. `creatures/`
12. **`effects/`** — por último (`phb_effect` de todos os packs; depende de feats/resources)

Dentro de cada pack: ordem lexicográfica do path.

## Motor de efeitos

SSOT de dados: `database/seeds/effects/E00*.sql` (… combat_mod E014; Cap.6 table_action E015). Tabelas `phb_resource_grant` / `phb_combat_modifier` **DROP**.
Schema: baseline (`phb_effect` + satélites).  
Docs: [`docs/plans/effect-engine.md`](../../../docs/plans/effect-engine.md) · [`docs/architecture/effect-engine-read-path.md`](../../../docs/architecture/effect-engine-read-path.md).

## Como aplicar

```bash
npm run db:setup              # local: reset → migrate → seed
npm run db:setup:all          # local + Supabase (wipe remoto com --confirm)
npm run db:seed
npm run db:seed:supabase
```

Não use scripts avulsos `apply-*` / `reseed-*` — SSOT = `database/seeds/` via `run-seeds.mjs`.
