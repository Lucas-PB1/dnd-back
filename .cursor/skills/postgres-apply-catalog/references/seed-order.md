# Ordem dos seeds

1. `000_truncate.sql`
2. `phb/S000`–`S080` (`S000` = edição PHB; resto catálogo)
3. `subclass/S001`–`S007`
4. `valdas/V001`–`V023`
5. `valdas-gunslinger/G001`–`G028`
6. `valdas-player-pack-2/P001`–`P011`
7. `dmg/` — itens mágicos DMG 2024
8. `combat/C001`–… — catálogo mecânico de combate (manobras, Golpe Astuto, economy/painéis, …)

Packs aplicados nesta ordem (Gunslinger depende de magias do Player Pack, ex.: `finger-guns`; Pack 2 depende da edição Valdas e da classe Gunslinger).

## Como aplicar

```bash
npm run db:setup              # local: reset → migrate → seed
npm run db:setup:all          # local + Supabase (wipe remoto com --confirm)
# ou só dados após schema:
npm run db:seed
npm run db:seed:supabase
```

Não use scripts avulsos `apply-*` / `reseed-*` — o SSOT é `database/seeds/` via `run-seeds.mjs`.
