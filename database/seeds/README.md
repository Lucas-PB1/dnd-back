# Seeds — catálogo PHB + Valdas

Dados do catálogo PHB 2024 e Valdas Spire of Secrets. **Um arquivo por tabela.**

| Caminho | Conteúdo |
|---------|----------|
| `000_truncate.sql` | `TRUNCATE` global (ordem FK-safe) |
| `phb/S###_<tabela>.sql` | `INSERT` do catálogo PHB (`S001`–`S078`) |
| `subclass/S###_<tabela>.sql` | Mecânicas de subclasse (`S001`–`S007`) |
| `valdas/V###_<tabela>.sql` | Pack Valdas (`V001`–`V023`, edição em `V001`) |
| `valdas-gunslinger/G###_<tabela>.sql` | Classe Gunslinger (`G001`–`G028`) |
| `valdas-player-pack-2/P###_<tabela>.sql` | Valdas Player Pack 2 (`P001`–`P013`) |
| `steinhardt-eldritch-hunt/H###_<tabela>.sql` | Steinhardt Eldritch Hunt Player Pack (`H001`–`H025`) |
| `combat/C###_*.sql` | Economia (C009), painel (C010), recursos especiais, **armas concedidas** (ex. C015 Lâminas Psíquicas) |
| `dmg/D###_*.sql` | Itens mágicos DMG 2024 Cap. 7 A–Z (`D010_phb_item`) |

**Regra:** stats de arma (dano, tipo, propriedades, maestria) vivem no catálogo (`phb_item` / `phb_weapon`), nunca hardcoded no domain TypeScript.

## Baseline canônico

Numeração sequencial sem lacunas (ordem de dependência). Exemplos:

- `S074_phb_metamagic.sql` — opções de Metamagia (Feiticeiro)
- `S075` — recursos de espécie
- `S076_phb_class_option.sql` — escolhas de classe (`scope=class`: Ordem Divina, Golpes Abençoados, Ordem Primal, Fúria Elemental)
- `S011` / `S055` / `S056` — Combatente Abençoado e Druídico (estilo de luta + 2 truques)
- `V001_phb_edition_citation.sql` — edição/citações Valdas
- `V011`–`V013` — construções Geppettin, estações Mandrágora, grants

Ordem de aplicação dos packs: `phb` → `subclass` → `valdas` → `valdas-gunslinger` → `valdas-player-pack-2` → `steinhardt-eldritch-hunt` → `dmg` → `combat`.
