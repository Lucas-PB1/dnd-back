# Seeds — catálogo PHB

Dados do catálogo PHB 2024. **Um arquivo por tabela.**

| Caminho | Conteúdo |
|---------|----------|
| `000_truncate.sql` | `TRUNCATE` global (ordem FK-safe) |
| `phb/S###_<tabela>.sql` | `INSERT` do catálogo PHB |
| `subclass/S###_<tabela>.sql` | Mecânicas de subclasse (`UPDATE`/`INSERT`) |

Metadados: `database/seed-manifest.json`
