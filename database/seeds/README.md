# Seeds — catálogo PHB

Dados de referência gerados a partir de `data/phb/`. **Não incluem fichas de personagem.**

| Arquivo | Conteúdo | Gerado por |
|---------|----------|------------|
| `001_phb.sql` | Catálogo completo (magias, classes, espécies, itens, …) | `seed-phb.mjs` |
| `002_subclass_mechanics.sql` | Mecânicas de subclasse (recursos, opções, feature_kind) | `generate-seed-subclass-mechanics.mjs` |

```bash
npm run generate:seed    # regenera database/seeds/
npm run seed:run         # dev-reset + migrations + seeds
npm run seed:prod        # migrations + seeds (sem DROP)
```

Metadados: `database/seed-manifest.json`
