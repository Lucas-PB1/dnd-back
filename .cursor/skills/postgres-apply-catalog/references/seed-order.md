# Ordem dos seeds

1. `000_truncate.sql`
2. `phb/S000`–`S080` (`S000` = edição PHB; resto catálogo)
3. `subclass/S001`–`S007`
4. `valdas/V001`–`V023`
5. `valdas-gunslinger/G001`–`G028`
6. `valdas-player-pack-2/P001`–`P013`
7. `steinhardt-eldritch-hunt/H001`–`H025` — Steinhardt Eldritch Hunt Player Pack (subclasses, magias, feats, backgrounds, species, itens, resources)
8. `dmg/` — itens mágicos DMG 2024
9. `combat/C001`–… — catálogo mecânico de combate (manobras, Golpe Astuto, economy/painéis, …)

Packs aplicados nesta ordem (Gunslinger depende de magias do Player Pack, ex.: `finger-guns`; Pack 2 depende da edição Valdas e da classe Gunslinger; Eldritch Hunt é independente após classes PHB).

## Como aplicar

```bash
npm run db:setup              # local: reset → migrate → seed
npm run db:setup:all          # local + Supabase (wipe remoto com --confirm)
# ou só dados após schema:
npm run db:seed
npm run db:seed:supabase
```

Não use scripts avulsos `apply-*` / `reseed-*` — o SSOT é `database/seeds/` via `run-seeds.mjs`.
