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

Três famílias paralelas — **intencional**, não unificar em tabela genérica:

| Tabela | Pai | Colunas extras |
|--------|-----|----------------|
| `phb_species_option_def` / `_value` | `species_id` | mínimo (sem label na def) |
| `phb_feat_option_def` / `_value` | `feat_id` | `label`, `sort_order`, `depends_on_option_key`, `spell_max_level`, `spell_school_slugs[]`, `spell_ritual_only` |
| `phb_subclass_option_def` / `_value` | `subclass_id` | `label`, `unlock_level`, `sort_order` |

**ENUM compartilhado:** `rpg.option_value_type` (`catalog`, `skill`, `ability`, …).

**Regra ao estender:** novas opções de talento → colunas em `phb_feat_option_def` (como filtros de magia) **antes** de criar tabela satélite. Novas opções de espécie/subclasse → par def/value existente.

Migrations: `T069`–`T074`, `T040`–`T041`.

---

## 2. Linhagens e legados de espécie

Catálogos de escolha com shapes parecidos:

| Tabela | Magias estruturadas | Outros |
|--------|---------------------|--------|
| `phb_elf_lineage` | L1 / L3 / L5 (`spell_level*_id`) | `level1_benefit` |
| `phb_infernal_legacy` | idem | idem |
| `phb_gnome_lineage` | L1 (`spell_1_id`, `spell_2_id`) | `level1_benefit` |
| `phb_dragon_ancestry` | — | `damage_type` |
| `phb_giant_ancestry` | — | `benefit` |

**Não consolidar** em uma mega-tabela: shapes PHB diferem; custo de migration > ganho.

**DRY de leitura (obrigatório para novos conteúdos):**

- `v_phb_species_trait_choices` — UI/API de escolhas (evolução incremental V024 → V036; estado final = última migration aplicada).
- `v_phb_species_granted_spell` — merge de magias always_prepared na ficha (trait fixo + linhagens).
- Domain: `collectSpeciesGrantedSpellSlugs` consome só a view via catálogo.

Ao adicionar linhagem nova: estender **as duas views** + ENUM `species_choice_kind` se necessário — não copiar UNION em TypeScript.

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

## Checklist — nova tabela de catálogo

1. Existe entidade pai clara (`phb_*` + FK)?
2. A leitura repete JOIN de 3+ migrations? → criar/atualizar view `v_phb_*`.
3. A ficha precisa da regra? → consumir view no domain, não duplicar SQL no TS.
4. É “cópia” de linhagem/espécie? → estender views de granted spell / trait choices.
5. Migration aplicada em prod? → **nova** migration; não editar arquivos já aplicados.

---

## Fora do escopo SQL (nota)

`CatalogLookupService` (~206 linhas) repete `findOne` + `requireFound` — DRY de **aplicação**, não de schema. Aceitável como facade; split só se passar de 250 linhas ou ganhar segundo concern.
