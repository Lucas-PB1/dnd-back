# Seeds — catálogo PHB + Valdas

Dados do catálogo PHB 2024 e Valdas Spire of Secrets. **Um arquivo por tabela.**

| Caminho | Conteúdo |
|---------|----------|
| `000_truncate.sql` | `TRUNCATE` global (ordem FK-safe) |
| `phb/S###_<tabela>.sql` | `INSERT` do catálogo PHB (`S001`–`S078`) |
| `subclass/S###_<tabela>.sql` | Mecânicas de subclasse (`S001`–`S007`) |
| `valdas/V###_<tabela>.sql` | Pack Valdas (`V001`–`V023`, edição em `V001`) |
| `valdas-gunslinger/G###_<tabela>.sql` | Classe Gunslinger (`G001`–`G028`) |
| `valdas-player-pack-2/P###_<tabela>.sql` | Valdas Player Pack 2 (`P001`–`P014`) |
| `steinhardt-eldritch-hunt/H###_<tabela>.sql` | Steinhardt Eldritch Hunt Player Pack (`H001`–`H025`) |
| `northlands-heroes/N###_<tabela>.sql` | Northlands Worldbook — Heroes of the Sagas (`N001`–`N037`; Cap. 5 + Character Threads + longships em `N037`; veículos/templates em `creatures/M003`) |
| `griffons-saddlebag/R###_<tabela>.sql` | The Griffon's Saddlebag: Book One — Part II Character Options (`R001`–`R011`: Feathren + 12 subclasses + stubs de magia + `image_url` + recursos de combate GSB) |
| `grim-hollow/J###_<tabela>.sql` | Grim Hollow Player's Guide (`J001`–`J035`: heranças, antecedentes, feats, MH + 40 subclasses Cap. 2, imagens, opções wizard; Cap. 5: `J005` armas, `J006` gear/foco/upgrades, `J007` munição, `J036` escudos GH; Cap. 6: `J019` shells transformações + `J048`–`J059` benefícios + `J060` option_def/value de boons + `J061` resources economy) |
| `combat/C###_*.sql` | Economia/painel/recursos |
| `dmg/D###_*.sql` | Itens mágicos DMG 2024 |
| `creatures/M###_*.sql` | Templates criatura/veículo |
| **`effects/E###_*.sql`** | Motor `phb_effect` (todos os packs; **último**) — ver [`effect-engine-read-path.md`](../../docs/architecture/effect-engine-read-path.md) |

**Regra:** stats de arma (dano, tipo, propriedades, maestria) vivem no catálogo (`phb_item` / `phb_weapon`), nunca hardcoded no domain TypeScript.

Ordem de packs: ver `scripts/db/run-seeds.mjs` / skill `postgres-apply-catalog` → `seed-order.md`.
