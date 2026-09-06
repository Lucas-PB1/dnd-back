# Ordem dos seeds

Preferência: [`database/seeds/SEED_ORDER.txt`](../../../database/seeds/SEED_ORDER.txt) (ordem FK-safe dos packs históricos). Gerar: `node scripts/generate-seed-order.mjs`.

**Iteração:** Postgres local (`npm run db:up`). Após falha:

```bash
npm run db:seed -- --from=domínio/fonte/arquivo.sql --skip-truncate --skip-refresh
```

Fallback (sem `SEED_ORDER.txt`) em `scripts/run-seeds.mjs`:

1. `000_truncate.sql`
2. `catalog/` → `class/` → `subclass/` → `species/` → `feat/`
3. `transformation/` → `heritage/` → `thread/` → `background/` → `item/` → `spell/`
4. `economy/` → `creature/`
5. **`effect/`** — por último

Nome: `{tabela}.{conteudo-slug}.sql` — ver [`docs/architecture/sql-layout.md`](../../../docs/architecture/sql-layout.md).

## Motor de efeitos

SSOT: `database/seeds/effect/**` + Cap.6 em `transformation/grim-hollow/` + `economy/grim-hollow/`.  
Schema: `database/schema/` (`phb_effect` + satélites).

## Como aplicar

```bash
npm run db:setup          # local
npm run db:seed
npm run db:setup:all      # só quando local estiver verde
```

Não use scripts avulsos `apply-*` / `reseed-*`.
