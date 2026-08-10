# Padrões do catálogo — DRY SQL

Auditoria P7 (2026-07-27); atualizado com consolidação A–G (2026-08-07).  
Fonte: [`database/migrations/`](../../database/migrations/) + [`database/seeds/`](../../database/seeds/).  
ADR: [`adr-schema-consolidation.md`](adr-schema-consolidation.md).

## Princípio

Repetir **estrutura** entre domínios é aceitável quando cada tabela tem FK e colunas extras distintas. Duplicação problemática é **regra de leitura** copiada em 3+ lugares sem view — evitar.

| Camada | Onde DRY |
|--------|----------|
| Escrita (seeds/migrations) | Tabelas normalizadas / unificadas por ADR |
| Leitura (API/domain) | Views `v_phb_*` e [`phb-query-views`](../../.cursor/skills/phb-query-views/SKILL.md) |
| Runtime da ficha | Loaders de domínio + views de magia concedida |

---

## 1. Padrão `option_def` / `option_value` (Lote C — DONE)

**Tabela canônica:** `phb_option_def` / `phb_option_value` com `scope` (`subclass` | `species` | `feat` | `class`) + `owner_id`.

Colunas extras nullable por scope (filtros de magia no feat, `unlock_level` na subclass, spells/benefits tipados na species — Lote B).

**ENUM:** `rpg.option_value_type`, `rpg.option_scope`.

Runtime: `player_character_option` (RLS em P004).

---

## 2. Linhagens e legados de espécie (Lote B — DONE)

Tabelas dedicadas (`phb_elf_lineage`, …) **removidas**. Dados em `phb_option_value` (`scope='species'`) com colunas tipadas.

**DRY de leitura:**

- `v_phb_species_trait_choices`
- `v_phb_species_granted_spell`
- Domain consome só as views

`species_choice_kind` permanece estável no TS.

---

## 3. Magias concedidas (Lote E — DONE)

| Origem | Tabela base | View |
|--------|-------------|------|
| Talentos fixos | `phb_spell_grant` (`origin_type=feat`) | `v_phb_feat_granted_spell` |
| Espécie + linhagem | grant + option_value + traits | `v_phb_species_granted_spell` |
| Subclasse | `phb_subclass_prepared_spell` | `v_phb_subclass_prepared_spell` |

`phb_spell_source` é **metadado** (listas/origem) — não substitui as views de concessão mecânica.

---

## 4. Flavor (`tagline` / `summary`)

Colunas em entidades raiz: `phb_class`, `phb_subclass`, `phb_background`, `phb_species`.

**Evitar:** tabela `phb_*_flavor` separada salvo i18n / múltiplas edições.

---

## 5. Pacotes de equipamento inicial (Lote D — DONE)

| Domínio | Tabelas |
|---------|---------|
| Unificado | `phb_starting_package` (`source` class\|background) + `phb_starting_item` |

Views: `v_phb_class_equipment`, `v_phb_background_equipment` (contratos preservados).  
Runtime: `player_character_equipment.package_id` FK nullable + `package_slug` / `source`.

---

## 6. Recursos e modifiers (Lote G — DONE)

- `phb_resource_definition` — definição
- `phb_resource_grant` — cotas class/subclass
- `phb_combat_modifier` — HP bonus + unarmored defense (views `v_phb_hp_bonus_source` / `v_phb_unarmored_defense`)

---

## 7. Afinidades de class (Lote F — DONE)

`phb_class_proficiency` com `kind` (`saving_throw`, `primary_ability`, `armor_training`, `weapon`, `fighting_style`).

`class-proficiencies.query.ts` e SQL de combat/sheet leem a tabela unificada diretamente.

**KEEP separados:** `phb_class_skill_pool`, `phb_class_spellcasting`, `phb_subclass_spellcasting`.

---

## 8. Whitelists M:N simples

- `phb_background_skill`, `phb_background_ability_option`, `phb_background_tool_option`
- `phb_class_skill_pool`

Repetição estrutural OK. Views agregadoras onde a API lista.

---

## 9. Catálogo mecânico de combate

Tabelas tipadas para a **engine** (mesa/dados). Seeds: `database/seeds/combat/C00*.sql` (C001 manobras, C009 economia, C010 painel, C014 recursos mago).

**Não** colocar mecânica em JSONB genérico.

**Não** manter no TypeScript `Set`/`array` paralelo de slugs de subclasse, manobra ou feature — o filtro e a listagem leem o catálogo carregado do banco. Nova sub/manobra = seed; o código não lista slugs.

HTTP: `GET /combat-mechanical-catalog` (`economyActions` + `panelActions` + manobras, …).

---

## Checklist — nova tabela de catálogo

1. Existe entidade pai clara (`phb_*` + FK)?
2. Cabe em `option_*`, `starting_*`, `spell_grant`, `class_proficiency`, `resource_grant` ou `combat_modifier`?
3. A leitura repete JOIN de 3+ migrations? → view `v_phb_*`.
4. A ficha precisa da regra? → consumir view no domain.
5. Migration já aplicada em prod? → **nova** migration (neste repo: rewrite + `db:setup` enquanto sem produção).
