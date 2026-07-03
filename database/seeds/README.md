# Seeds — catálogo PHB

Dados gerados a partir de `data/phb/`. **Um arquivo por tabela.**

| Caminho | Conteúdo |
|---------|----------|
| `000_truncate.sql` | `TRUNCATE` global (ordem FK-safe) |
| `phb/S###_<tabela>.sql` | `INSERT` do catálogo PHB |
| `subclass/S###_<tabela>.sql` | Mecânicas de subclasse (`UPDATE`/`INSERT`) |

```bash
npm run generate:seed    # regenera database/seeds/
npm run seed:run         # dev-reset + migrations + seeds (1 transação)
```

Metadados: `database/seed-manifest.json`
