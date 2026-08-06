# Seeds — catálogo PHB + Valdas

Dados do catálogo PHB 2024 e Valdas Spire of Secrets. **Um arquivo por tabela.**

| Caminho | Conteúdo |
|---------|----------|
| `000_truncate.sql` | `TRUNCATE` global (ordem FK-safe) |
| `phb/S###_<tabela>.sql` | `INSERT` do catálogo PHB (`S001`–`S078`) |
| `subclass/S###_<tabela>.sql` | Mecânicas de subclasse (`S001`–`S007`) |
| `valdas/V###_<tabela>.sql` | Pack Valdas (`V001`–`V013`, edição em `V001`) |
| `valdas-gunslinger/G###_<tabela>.sql` | Classe Gunslinger (`G001`–`G028`) |

Metadados: `database/seed-manifest.json`

## Baseline canônico

Numeração sequencial sem lacunas (ordem de dependência). Exemplos:

- `S074_phb_species_trait_choice_kind.sql` — choice_kinds PHB
- `S075`–`S077` — weapon mastery + class resources
- `V001_phb_edition_citation.sql` — edição/citações Valdas
- `V011`–`V013` — construções Geppettin, estações Mandrágora, grants

Ordem de aplicação dos packs: `phb` → `subclass` → `valdas` → `valdas-gunslinger`.
