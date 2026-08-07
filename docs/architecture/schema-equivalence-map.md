# Mapa de equivalência — schema atual → alvo consolidado

Uso: checklist ao portar o plano da auditoria (`analise`) para o **dnd-api** (ou greenfield).  
Status do redesign: ver [`adr-schema-consolidation.md`](adr-schema-consolidation.md) (**Aceito**).  
Baseline (pré-consolidação): ~91 CREATE em `020_tables` + runtime em `090_player` (~160 arquivos SQL de migration).

Legenda da coluna **Ação**:

| Ação | Significado |
|------|-------------|
| **KEEP** | Mantém tabela (talvez com constraints novas) |
| **ENUM** | Vira ENUM / CHECK / coluna — sem tabela |
| **MERGE→X** | Funde na tabela/alvo X |
| **RUNTIME** | Continua no runtime; aplicar Criticals |
| **DECIDE** | Conflito com padrão atual — decidir no ADR follow-up |

---

## Lote A — Lookups → ENUM / coluna (DONE 2026-08-07)

| Atual | Ação | Alvo | Notas |
|-------|------|------|-------|
| `phb_hit_die` | ENUM | `rpg.hit_die` em `phb_class.hit_die` | view `UPPER(hit_die)` |
| `phb_weapon_proficiency` | VALUES view | `v_phb_weapon_proficiency` + `proficiency_slug` | |
| `phb_divine_order` | DROP | — | órfã |
| `phb_druid_land_terrain` | ENUM | `rpg.druid_land_terrain` | |
| `phb_ability_generation_method` | ENUM + view | `v_phb_ability_generation_method` | |
| `phb_feat_category` | ENUM + view | `rpg.feat_category` + `v_phb_feat_category` | |
| `phb_condition` | ENUM + view | `v_phb_condition` | |
| `phb_character_level` | KEEP | — | |

**Delta:** −6 tabelas (+ VALUES views)

---

## Lote B — Lineages / ancestries → options (DONE 2026-08-07)

| Atual | Ação | Alvo sugerido | Status |
|-------|------|---------------|--------|
| `phb_elf_lineage` | MERGE→options | `phb_species_option_value` | ✅ Deletada; dados em option_value.lineageId |
| `phb_gnome_lineage` | MERGE→options | idem | ✅ Deletada; dados em option_value.gnomeLineageId |
| `phb_infernal_legacy` | MERGE→options | idem | ✅ Deletada; dados em option_value.infernalLegacyId |
| `phb_dragon_ancestry` | MERGE→options | idem | ✅ Deletada; dados em option_value.dragonAncestryId |
| `phb_giant_ancestry` | MERGE→options | idem | ✅ Deletada; dados em option_value.giantAncestryId |
| `phb_geppettin_construction` | MERGE→options | idem | ✅ Deletada; dados em option_value.constructionId |
| `phb_mandrake_season` | MERGE→options | idem | ✅ Deletada; dados em option_value.seasonId |
| `phb_species_option_def` | KEEP | núcleo do padrão | ✅ Expandido com kinds |
| `phb_species_option_value` | KEEP | núcleo do padrão | ✅ Colunas tipadas adicionadas |
| `phb_species` | KEEP | — | — |
| `phb_species_trait` | KEEP | — | — |

**Delta real:** −7 tabelas, −5 seeds; views `v_phb_species_trait_choices` e `v_phb_species_granted_spell` reescritas

---

## Lote C — Options unificadas (DONE 2026-08-07)

| Atual | Ação | Alvo | Notas |
|-------|------|------|-------|
| `phb_subclass_option_def` / `_value` | MERGE→option | `phb_option_def` / `phb_option_value` | `scope='subclass'` |
| `phb_species_option_def` / `_value` | MERGE→option | idem | `scope='species'` (+ colunas Lote B) |
| `phb_feat_option_def` / `_value` | MERGE→option | idem | `scope='feat'` (filtros de magia em def) |
| Runtime choices | MERGE→option | `player_character_option` | Sem views compat (P007 stub) |
| `player_character_species_choice` | KEEP | tipado | Ainda separado |

**Delta real:** −4 tabelas catálogo; **views compat removidas** (código aponta só a `phb_option_*` / `player_character_option`)

---

## Lote D — Starting packages ✅ DONE

| Atual | Ação | Alvo sugerido | Notas |
|-------|------|---------------|-------|
| `phb_class_starting_package` | MERGE→package | `phb_starting_package(source='class')` | UNIQUE(source, owner_id, slug) |
| `phb_class_starting_item` | MERGE→item | `phb_starting_item` | |
| `phb_background_starting_package` | MERGE→package | `source='background'` | gold no pacote |
| `phb_background_starting_item` | MERGE→item | idem | |
| `player_character_equipment` | RUNTIME | `package_id` FK nullable + `package_slug` | compat app |

**Delta real:** −2 tabelas catálogo (T037/T038 unificados; T044/T045 removidos); views V013/V014 reescritas; seeds S039/S040/S042/S043 + G020; migrate+seed validados

---

## Lote E — Spell grants ✅ DONE

| Atual | Ação | Alvo sugerido | Notas |
|-------|------|---------------|-------|
| `phb_feat_granted_spell` | MERGE→grant | `phb_spell_grant` | origin=feat |
| `phb_species_granted_spell` | MERGE→grant | idem | origin=species |
| `phb_spell_source` | KEEP | — | origem de listas de subclasse; concern distinto |
| `phb_spell_class` | KEEP | lista de classe | |
| `phb_subclass_prepared_spell` | KEEP | + UNIQUE natural | Warning duplicatas |

**Delta real:** −1 tabela catálogo (`phb_spell_grant` unifica feat+species; `phb_spell_source` mantido); views `v_phb_species_granted_spell` e `v_phb_feat_granted_spell` reescritas; migrate+seed validados

---

## Lote F — Afinidades de class ✅ DONE

| Atual | Ação | Alvo sugerido | Notas |
|-------|------|---------------|-------|
| `phb_class_saving_throw` | MERGE→prof | `phb_class_proficiency(kind=saving_throw)` | view compat V001 |
| `phb_class_primary_ability` | MERGE→prof | idem | view compat V001 |
| `phb_class_armor_training` | MERGE→prof | idem | view compat V001 |
| `phb_class_weapon_proficiency` | MERGE→prof | idem | view compat V001 |
| `phb_class_fighting_style` | MERGE→prof | idem | view compat V001 |
| `phb_class_skill_pool` | KEEP | path quente | |
| `phb_class_spellcasting` | KEEP | — | |
| `phb_subclass_spellcasting` | KEEP | — | |
| `phb_class` / `phb_subclass` | KEEP | + UNIQUE(id, class_id) p/ FK composta | Critical PC |

**Delta real:** −4 tabelas catálogo (`phb_class_proficiency`); **sem** views compat — SQL/TS usam a tabela unificada

---

## Lote G — Resources / modifiers ✅ DONE

| Atual | Ação | Alvo sugerido | Notas |
|-------|------|---------------|-------|
| `phb_resource_definition` | KEEP | — | catálogo de definição |
| `phb_class_resource` | MERGE→grant | `phb_resource_grant` | sem view compat |
| `phb_subclass_resource` | MERGE→grant | idem | sem view compat |
| `phb_hp_bonus_source` | MERGE→modifier | `phb_combat_modifier` | kind=hp_bonus |
| `phb_unarmored_defense` | MERGE→modifier | idem | kind=unarmored_defense |

**Delta real:** −2 tabelas catálogo (`phb_resource_grant` + `phb_combat_modifier`); T053/T061 removidos (65 T); V033 reescrita; seeds S061/S062/S068 + subclass/valdas; migrate+seed validados

---

## Núcleo a manter (KEEP)

| Atual | Notas |
|-------|--------|
| `phb_edition`, `phb_source_citation` | |
| `phb_ability`, `phb_skill`, `phb_language`, `phb_alignment` | |
| `phb_fighting_style`, `phb_weapon_property`, `phb_weapon_mastery` | |
| `phb_spell`, `phb_spell_slot_pattern`, `phb_spell_slot_by_level` | |
| `phb_feat`, `phb_feat_benefit`, `phb_feat_requirement`, `phb_feat_requirement_ability` | requirement pode enxugar depois |
| `phb_item`, `phb_weapon`, `phb_armor`, `phb_tool`, `phb_weapon_property_link` | herança por extensão |
| `phb_background` + skill / ability_option / tool_option / language / boost_option | links KEEP; packages → lote D |
| `phb_class_feature`, `phb_class_progression`, `phb_subclass_feature`, `phb_subclass_progression` | |
| `phb_class_ability_boost` | |
| `schema_migration` | infra |

---

## Runtime — KEEP + Criticals

| Atual | Ação | Mudança mínima no alvo |
|-------|------|------------------------|
| `player_character` | RUNTIME | FK composta class↔subclass; HP current≤max; FK `user_id` |
| `player_character_state` | RUNTIME | concentration → spell; conditions tipadas |
| `player_character_skill` | KEEP | |
| `player_character_spell` | KEEP | |
| `player_character_language` | KEEP | |
| `player_character_item` | RUNTIME | FK `attached_charm_slug` → item |
| `player_character_feat` | KEEP | |
| `campaign` | RUNTIME | FK `created_by` |
| `campaign_member` | RUNTIME | UNIQUE(campaign,user) + FK user |
| `campaign_character` | RUNTIME | UNIQUE(campaign,character) + FK linked_by |
| `campaign_encounter` | RUNTIME | FK `created_by` |
| `campaign_encounter_combatant` | RUNTIME | CHECK XOR kind/character/display_name |

---

## Contagem final (dnd-api, pós A–G)

| Prefixo / escopo | Count |
|------------------|-------|
| Migrations `020_tables` (T*) | 65 |
| `phb_*` base tables (live) | 65 |
| Runtime player + campaign | ~15 |
| Total `rpg` base (incl. `schema_migration`) | **~81** |

Meta 45–60: **fora** — justificativa no ADR (combat mechanical + runtime KEEP).

## Checklist de porte

- [x] ADR aceito lote a lote  
- [x] Equivalências A–G no DDL  
- [x] Criticals runtime no DDL  
- [x] `data-model.md` + `catalog-patterns.md`  
- [x] Seeds + migrate Supabase  
- [x] Contagem final registrada  

## Origem

Auditoria: repo `analise` (2026-08-07), dump `sql.sql`, plano `consolidacao-tabelas.md`.
