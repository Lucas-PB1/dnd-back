# DMG item mesa — status dos lotes

SSOT operacional = **seeds SQL** (`database/seeds/dmg` + `combat`).  
Este arquivo substitui as antigas `dmg-item-mesa-taxonomy-*.yaml` (planejamento).

Modelo: [`docs/architecture/dmg-item-mesa.md`](../architecture/dmg-item-mesa.md).  
MVP recover: `recover_all_on_long` ≈ amanhecer; 1dN parcial via `D041`.

| Lote | Padrão | Seeds (resource / PE) | Economy | Status |
|------|--------|----------------------|---------|--------|
| §0 #1 consumíveis | consumable-reminder | `D011` | `C016` | feito |
| §0 #2 passivos | passive-numeric | `D012` | — | feito (anel/manto) |
| §3.1 coberturas | coverage | `D013` (+ overlay `P021+`) | `C043` armas | feito |
| §0 #4 1×/amanhecer | once-per-dawn | `D015` | `C017` | feito |
| §0 #4b elementais | once-per-dawn | `D016` | `C018` | feito |
| §0 #5 1 pool + 1 botão | charge-pool-single | `D017` | `C019` | feito |
| §0 #6 Estrelas Cadentes | multi-action-shared-pool | `D018` | `C020` | feito |
| §0 #7 varinhas | wand-multi-spell | `D019` | `C021` + `C042` slug | feito (cast fase 6) |
| §0 #8 cajados | staff-multi-spell | `D020`–`D025` | `C022`–`C027` + Magi `C044` | feito |
| §0 #9a–i maravilhosos | marvelous-simple | `D026`–`D033` | `C028`–`C036` | feito (parcial por item) |
| §0 #9g anéis | rings | `D031`/`D032` | `C034`+ | feito |
| §0 #9j escudos/armaduras | armor-shields | `D034` | `C037` | feito |
| §0 #9k armas únicas | unique-weapons | `D035` | `C038` | feito; artefatos cast → `C045` |
| §0 #9l densos / Orcus | marvelous-dense | `D036` | `C039` | feito; lumps → `C045` |
| Artefatos fix cast | 1 row/magia + slug | `D042` | `C045` | feito |
| Artefato roll + senciência | instance_properties + tabelas 1d100 | `D043`–`D045` + `P027`/`T075`/`T076` | cast/regen na ficha | feito (1ª sintonia + magia/regen/−2) |
| Enspelled arma/armadura | bound spell | `D037`/`D039` | `C040`/`C041` | feito |
| Recover 1dN (DL) | recover_on_long_dice | `D041` | — | feito (MVP DL) |
| Coberturas arma resources | weapon coverages | `D040` | `C043` | feito |

## Notas

- Cast de item: `spell_slug` + `itemCast*` (`POST …/spells/cast`). Backfill geral varinhas/cajados: `C042`.
- Artefatos (11): ver [`docs/plans/audit-dmg-artifacts.md`](../../docs/plans/audit-dmg-artifacts.md).
- 1ª sintonia: rola `artifactRandomQuota` + copia `sentience` → `player_character_item.instance_properties` (`P027`). Tabelas: `dmg_artifact_random_property` / `dmg_sentient_trait_table`.
- Props expandido: magia rolada do catálogo (`artifactSpell`, CD 18, 1× até DL via `artifactRandomCast`); regen `1d6` (`POST …/inventory/actions` com `actionSlug: artifact-regen`); `abilityPenalty` persiste em `abilityPenalties` até `restauracao-maior` (não é cursed).
- Gaps de regra geral (dawn real, curse, conflict senciente, d6 1–5 RAW na magia): [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).
- Não editar `D010` à mão — regenerar com `scripts/generate-dmg-item-seeds.mjs` (preenche `cost` pela tabela DMG de raridade; consumível ×½; artefato/varies/+N = NULL).
- Loja (inventário Beyond): preços PHB em `S031`; `POST …/inventory/purchase` (carrinho atômico); PATCH qty cobrado; DELETE `?quantity=&mode=sell|discard`; serviços (`kind:service`) debitam sem criar item; stats `phb_item_catalog_stats` (view/purchase); compartimentos `contained_in_item_slug` (P028). Cap. 6 (variantes, montarias, veículos, serviços, pergaminhos 2–9) seedado em `S031`.
