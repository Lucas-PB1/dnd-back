# Padrões do catálogo — DRY SQL

Auditoria P7 (2026-07-27). Fonte de verdade: [`database/migrations/`](../../database/migrations/) + [`database/seeds/`](../../database/seeds/).

## Princípio

Repetir **estrutura** entre domínios é aceitável quando cada tabela tem FK e colunas extras distintas. Duplicação problemática é **regra de leitura** copiada em 3+ lugares sem view — evitar.

| Camada | Onde DRY |
|--------|----------|
| Escrita (seeds/migrations) | Tabelas normalizadas por entidade pai |
| Leitura (API/domain) | Views `v_phb_*` e [`phb-query-views`](../../.cursor/skills/phb-query-views/SKILL.md) |
| Runtime da ficha | [`LoadGrantedSpellCatalog`](../../src/game/spellcasting/application/load-granted-spell-catalog.ts) + views de magia concedida |

---

## 1. Padrão `option_def` / `option_value`

**ADR consolidação (Aceito):** unificar famílias em `phb_option_def` / `phb_option_value` com `scope` (`subclass` | `species` | `feat`) — Lote C em andamento.

Até o Lote C fechar, o código pode ainda referenciar as três famílias legadas. Pós-C: um par genérico + colunas nullable por scope (filtros de magia no feat, `unlock_level` na subclass, lineages tipadas na species — Lote B).

**ENUM compartilhado:** `rpg.option_value_type` (`catalog`, `skill`, `ability`, …).

---

## 2. Linhagens e legados de espécie (Lote B — DONE)

Tabelas dedicadas (`phb_elf_lineage`, …) **removidas**. Dados em `phb_species_option_value` (colunas tipadas: spells L1/L3/L5, `damage_type`, `benefit`, …).

**DRY de leitura:**

- `v_phb_species_trait_choices` — UI/API de escolhas
- `v_phb_species_granted_spell` — magias always_prepared
- Domain: `collectSpeciesGrantedSpellSlugs` consome só a view

`species_choice_kind` permanece estável no TS.

---

## 3. Magias concedidas (feat / espécie / subclasse)

| Origem | Tabela base | View read model |
|--------|-------------|-----------------|
| Talentos fixos | `phb_feat_granted_spell` | `v_phb_feat_granted_spell` |
| Espécie + linhagem | traits + lineage tables | `v_phb_species_granted_spell` |
| Subclasse | `phb_subclass_prepared_spell` | `v_phb_subclass_prepared_spell` |

`phb_spell_source` é **metadado de origem** (enum + FKs polimórficas) — não substitui as views de concessão mecânica.

---

## 4. Flavor (`tagline` / `summary`)

Colunas em entidades raiz (paridade PHB):

- `phb_class`, `phb_subclass`, `phb_background`, `phb_species` (colunas `tagline`/`summary` no CREATE)

Views enriquecidas: `v_phb_class`, `v_phb_background`, `v_phb_subclass` — flavor já incluído onde a API precisa.

**Evitar:** tabela `phb_*_flavor` separada salvo necessidade de i18n ou múltiplas edições por entidade.

---

## 5. Pacotes de equipamento inicial

Padrão package → items:

| Domínio | Package | Items |
|---------|---------|-------|
| Classe | `phb_class_starting_package` | `phb_class_starting_item` (+ `gold_amount`) |
| Antecedente | `phb_background_starting_package` | `phb_background_starting_item` |

Views: `v_phb_class_equipment`, `v_phb_background_equipment`.

Diferença `gold_amount` só na classe — regra PHB, não bug DRY.

---

## 6. Recursos polimórficos

`phb_resource_definition` + `resource_scope` (`species` | `class` | `subclass`) — um de três FKs preenchido.

Mesmo padrão conceitual que `phb_spell_source`, escopos diferentes.

---

## 7. Whitelists M:N simples

- `phb_background_skill`, `phb_background_ability_option`, `phb_background_tool_option`
- `phb_class_skill_pool`, `phb_class_saving_throw`, …

Repetição estrutural OK: cada uma amarra entidades distintas. Views agregadoras onde a API lista (`v_phb_class_skill_choice`, `v_phb_background_tool_option_whitelist`).

---

## 8. Catálogo mecânico de combate

Tabelas tipadas para a **engine** (mesa/dados), distintas da prosa em `phb_class_feature`.

| Tabela | View |
|--------|------|
| `phb_gunslinger_maneuver` | `v_phb_gunslinger_maneuver` |
| `phb_battle_master_maneuver` | `v_phb_battle_master_maneuver` |
| `phb_cunning_strike_effect` | `v_phb_cunning_strike_effect` |
| `phb_subclass_table_action` | `v_phb_subclass_table_action` |
| `phb_persona_mask` | `v_phb_persona_mask` |
| `phb_beastborne_aspect_benefit` | `v_phb_beastborne_aspect_benefit` |
| `phb_dungeoneer_slayer_type` | `v_phb_dungeoneer_slayer_type` |
| `phb_subclass_precaution_spell` | `v_phb_subclass_precaution_spell` |
| `phb_class_economy_action` | `v_phb_class_economy_action` |
| `phb_class_panel_action` | `v_phb_class_panel_action` |

Seeds: `database/seeds/combat/C00*.sql`. Plano: [`docs/plans/combat-mechanical-catalog.md`](../plans/combat-mechanical-catalog.md).

**Não** colocar mecânica em JSONB genérico. `option_value` do Battle Master continua como escolha da ficha; a tabela tipada é SSOT de timing/efeitos.

HTTP público: `GET /combat-mechanical-catalog` (Catalog BC → `LoadCombatMechanicalCatalog`).

---
## Checklist — nova tabela de catálogo

1. Existe entidade pai clara (`phb_*` + FK)?
2. A leitura repete JOIN de 3+ migrations? → criar/atualizar view `v_phb_*`.
3. A ficha precisa da regra? → consumir view no domain, não duplicar SQL no TS.
4. É “cópia” de linhagem/espécie? → estender views de granted spell / trait choices.
5. Migration aplicada em prod? → **nova** migration; não editar arquivos já aplicados.

---

## Fora do escopo SQL (nota)

`CatalogLookupService` (~206 linhas) repete `findOne` + `requireFound` — DRY de **aplicação**, não de schema. Aceitável como facade; split só se passar de 250 linhas ou ganhar segundo concern.
