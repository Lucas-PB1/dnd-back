# Inventário do schema `rpg`

> Auditoria 2026-09-23 · trilha GEN fechada — decisões em [`adr-schema-generics.md`](../adr-schema-generics.md). Contagens refletem o dump **antes** da trilha.

Análise do arquivo `schema.sql` (DDL extraído do dnd-api).

## Resumo

| Tipo | Quantidade |
|------|------------:|
| Schema | 1 (`rpg`) |
| Extensões | 2 |
| Enums (`CREATE TYPE … AS ENUM`) | 46 |
| Tabelas | 177 |
| Views | 41 |
| Materialized views | 16 |
| Functions | 6 |
| Triggers | 15 |
| Indexes | 173 |
| Policies (RLS) | 44 |
| Tabelas com RLS habilitado | 26 |
| `COMMENT ON` (metadados DDL) | 26 |

---

## Extensões (2) — análise

Extensão = plugin do PostgreSQL que libera tipos, operadores, funções ou indexes especiais. Neste schema só entram duas, ambas com uso concreto no DDL.

### `pg_trgm` — busca fuzzy por nome

**Para quê:** trigramas (pedaços de 3 caracteres) para comparar textos parecidos — acelera `LIKE '%termo%'`, `ILIKE` e similaridade.

**Onde aparece no schema:** 7 indexes GIN em colunas `name` do catálogo:

| Index | Tabela |
|-------|--------|
| `idx_phb_spell_name_trgm` | `phb_spell` |
| `idx_phb_feat_name_trgm` | `phb_feat` |
| `idx_phb_class_name_trgm` | `phb_class` |
| `idx_phb_item_name_trgm` | `phb_item` |
| `idx_phb_species_name_trgm` | `phb_species` |
| `idx_phb_subclass_name_trgm` | `phb_subclass` |
| `idx_phb_background_name_trgm` | `phb_background` |

Todos no formato `USING gin (name gin_trgm_ops)`.

**Leitura de produto:** autocomplete / busca “digitei metade do nome da magia/classe/item” sem full-text search pesado.

### `pgcrypto` — criptografia e UUIDs

**Para quê (no geral):** hashes, encrypt, e geração de IDs aleatórios.

**Onde aparece de fato aqui:** quase só `gen_random_uuid()` como default de PK UUID em tabelas de runtime (personagem, campanha, game_actor, skirmish, duel, threads, etc.) e dentro de `spawn_game_actor_from_template`.

Não há no schema uso de `crypt()`, `digest()`, `pgp_*`, etc. — a extensão está ligada pelo UUID, não por senha/criptografia de coluna.

**Nota:** em Postgres ≥ 13, `gen_random_uuid()` também existe no core (`pgcrypto` fica redundante nesse ponto). No Supabase/Postgres do projeto, manter a extension é o caminho que o DDL já assume.

### Em uma linha

| Extensão | Papel neste banco |
|----------|-------------------|
| `pg_trgm` | Busca por nome no catálogo PHB |
| `pgcrypto` | IDs UUID aleatórios no runtime |

---

## Enums (46) — para que servem?

### Ideia geral

Um **enum** no Postgres é uma lista fechada de valores permitidos numa coluna (em vez de `TEXT` livre).

Neste schema eles fazem três trabalhos:

1. **Classificar** coisas do D&D (tipo de item, categoria de feat, kind de ator).
2. **Parametrizar regras** que o código/SQL interpreta (fórmula de max de recurso, kind de efeito, trigger).
3. **Restringir choices** da ficha (qual escolha de espécie, qual bucket de ação na UI).

Sem enums, o catálogo viraria string solta (`'weapon'` vs `'Weapon'` vs typo) e o motor de efeitos não saberia quais kinds existem.

Não são “tabelas de lookup”: são **tipos**. A tabela guarda a linha; o enum trava o vocabulário da coluna.

---

### Por família (o que cada grupo resolve)

#### 1. Catálogo de item / arma / feat (classificação)

| Enum | Valores (n) | Serve para |
|------|------------:|------------|
| `item_type` | 6 | Separar item em weapon/armor/gear/tool/focus/other (`phb_item`) |
| `weapon_category` | 3 | Simple / martial / advanced |
| `feat_category` | 5 | Origin, general, fighting-style, epic-boon, gh-transformation |
| `hit_die` | 4 | Dado de vida da classe (d6…d12) |
| `casting_type` | 5 | Full / half / pact / third / none — ritmo de slots |
| `starting_package_source` | 2 | Equipamento inicial veio de class ou background |
| `class_proficiency_kind` | 5 | Que tipo de proficiência a classe concede |
| `druid_land_terrain` | 4 | Terrenos do Circle of the Land |

#### 2. Choices da ficha (o que o jogador escolhe)

| Enum | Valores (n) | Serve para |
|------|------------:|------------|
| `species_choice_kind` | **47** | Qual “slot” de escolha da espécie/herança (elf lineage, human feat, gh_heritage_trait_N, …) |
| `option_scope` | 5 | De onde vem uma option def (subclass/species/feat/class/heritage) |
| `option_value_type` | 9 | Que tipo de valor a option carrega (skill, spell, json, …) |
| `ability_generation_method` | 3 | Standard array / roll / point-buy (mais view/cast que coluna) |
| `transformation_stage_mode` | 5 | Como o estágio de transformação GH escolhe boons (auto/pick) |
| `heritage_category` | 3 | Common / rare / eldritch |
| `heritage_trait_category` | 3 | Combat / exploration / roleplaying |
| `heritage_trait_take_mode` | 2 | Trait empilha ou escolha-a-cada-take |

`species_choice_kind` é o maior desse grupo: cada valor é um *tipo de pergunta* na criação/level-up, não a resposta.

#### 3. Magia e concessões

| Enum | Valores (n) | Serve para |
|------|------------:|------------|
| `spell_source_origin` | 4 | De onde a magia entra na lista (class_list/subclass/species/feat) |
| `spell_grant_origin` | 3 | Origem de grant explícito (feat/species/class) |
| `innate_spell_usage` | 4 | At will / per day / recharge / slot (criaturas e actors) |
| `eldritch_invocation_kind` | 6 | Como a invocação se comporta na mesa (passive, free_cast, action…) |
| `subclass_feature_kind` | 6 | Natureza da feature de subclass (passive, resource, always_prepared…) |

#### 4. Recursos e “donos” de poder

| Enum | Valores (n) | Serve para |
|------|------------:|------------|
| `resource_scope` | 7 | Escopo da definição de recurso |
| `resource_owner_kind` | 7 | Quem “possui” o recurso (class…character_thread) |
| `resource_max_formula` | 13 | Como calcular o máximo (PB, mod, superiority dice…) |
| `effect_owner_kind` | 9 | Quem dono do efeito no catálogo `phb_effect` |

#### 5. Motor de efeitos (o coração mecânico)

Aqui o enum **não descreve o livro** — descreve o **contrato do engine**.

| Enum | Valores (n) | Serve para |
|------|------------:|------------|
| `effect_kind` | **135** | *O que* o efeito faz (grant_spell, temp_hp, wild_shape, …) |
| `effect_trigger` | 17 | *Quando* dispara (passive, on_hit, on_rest_long, …) |
| `effect_amount_formula` | 35 | *Quanto* (fixed, PB, rage_bonus, dice_…) |
| `effect_uses_formula` | 2 | Quantas uses (fixed vs PB) |
| `effect_cast_economy` | 3 | Economia de cast gratuito vs slot |
| `effect_combat_mod_kind` | 2 | HP bonus vs unarmored defense |
| `effect_proficiency_kind` | 3 | Skill / tool / instrument |
| `effect_damage_applies_to` | 2 | Unarmed vs weapon |
| `effect_sense_slug` | 4 | Darkvision, blindsight… |
| `effect_env_hazard` | 4 | Imunidade a hazard ambiental |

`effect_kind` é o enum mais importante do sistema: cada valor é um “opcode” que a API/SQL sabe aplicar.

#### 6. Combate na mesa / UI de ações

| Enum | Valores (n) | Serve para |
|------|------------:|------------|
| `action_economy_bucket` | 4 | Action / bonus / reaction / free (catálogo de economy actions) |
| `panel_action_section` | 4 | Seção do painel (base, subclass, metamagic, channel) |
| `actor_kind` | 4 | Creature / mount / vehicle / companion |
| `actor_action_bucket` | 5 | Buckets do stat block (inclui legendary) |
| `condition_slug` | 15 | Condições clássicas do PHB |
| `save_ability` | 6 | Qual atributo no save |
| `maneuver_effect_kind` | 8 | Efeito de manobra (BM / gunslinger) |
| `battle_master_maneuver_timing` | 5 | Quando a manobra ocorre |
| `battle_master_mesa_roll_kind` | 4 | Tipo de roll na mesa (parry, rally, precision…) |
| `combat_modifier_kind` / `_owner` | 2 / 5 | Modificadores de combate e de quem vêm (também em views) |

---

### Em uma frase

Os **46 enums** são o **vocabulário tipado** do Dende: classificam o catálogo PHB, fecham as choices da ficha e, sobretudo, definem o dialeto do **motor de efeitos** (`effect_kind` + trigger + fórmulas).

O outlier de tamanho: `effect_kind` (135) e `species_choice_kind` (47). O resto é pequeno e estável.

---

## Tabelas (177)

### Por papel

| Papel | Quantidade | O que é |
|-------|------------:|---------|
| Catálogo PHB (`phb_*`) | 144 | Dados de referência do livro / suplementos (classe, magia, espécie, efeito, etc.) |
| Runtime / sessão | 29 | Estado vivo: personagem, campanha, ator de jogo, skirmish, ledger de seed |
| Outros | 4 | DMG auxiliar + duelo (`dmg_*`, `duel_*`) |

### Runtime (29)

Personagem e choices: `player_character`, `player_character_state`, `player_character_equipment`, `player_character_item`, `player_character_feat`, `player_character_spell`, `player_character_skill`, `player_character_language`, `player_character_option`, `player_character_species_choice`, `player_character_heritage_config`, `player_character_heritage_trait`, `player_character_thread`, `player_character_thread_milestone`, `player_character_transformation`, `player_character_transformation_choice`.

Campanha: `campaign`, `campaign_member`, `campaign_character`, `campaign_encounter`, `campaign_encounter_combatant`.

Game actors: `game_actor`, `game_actor_state`, `game_actor_action`, `game_actor_speed`, `game_actor_spell`.

Skirmish: `skirmish`, `skirmish_combatant`.

Infra: `seed_migration`.

### Outros (4)

- `dmg_artifact_random_property`
- `dmg_sentient_trait_table`
- `duel`
- `duel_member`

### Catálogo PHB (144)

Base / taxonomia: edição, abilities, skills, languages, alignments, damage types, conditions (via enum + views), armor/weapon/tool/item, spell school, etc.

Progressão: class, subclass, features, schedules, gates, spellcasting, spell slots, starting packages.

Conteúdo rico: spells, feats, species, backgrounds, heritages, transformations, creatures/vehicles templates, effects (e satélites), economy actions, companions, wild shape, threads, etc.

---

## Views (41)

Views “normais” (`CREATE VIEW` / `CREATE OR REPLACE VIEW`) — contratos de leitura sobre o catálogo.

Famílias aproximadas:

| Família | Exemplos |
|---------|----------|
| Classe / subclass / slots | `v_phb_class`, `v_phb_subclass`, `v_class_spell_slots`, `v_subclass_spell_slots`, `v_spell_by_class` |
| Background / feat / species | `v_phb_background*`, `v_phb_feat*`, `v_phb_species_trait_choices` |
| Heritage | `v_phb_heritage_*` |
| Items / armas / tools | `v_phb_armor`, `v_phb_weapon_*`, `v_phb_tool_pool_item`, `v_phb_item_type` |
| Bundles | `v_phb_creature_template_bundle`, `v_phb_vehicle_template_bundle`, `v_phb_character_thread_bundle` |
| Outros | `v_phb_spell`, `v_phb_condition`, `v_phb_unarmored_defense`, `v_phb_hp_bonus_source`, … |

---

## Materialized views (16)

Pré-computadas (`CREATE MATERIALIZED VIEW`) — espelhos pesados de algumas views de catálogo.

| Materialized view |
|-------------------|
| `rpg.mv_class_spell_slots` |
| `rpg.mv_subclass_spell_slots` |
| `rpg.mv_spell_by_class` |
| `rpg.mv_phb_background` |
| `rpg.mv_phb_feat` |
| `rpg.mv_phb_feat_granted_spell` |
| `rpg.mv_phb_class_ability_boost` |
| `rpg.mv_phb_class_economy_action` |
| `rpg.mv_phb_class_granted_spell` |
| `rpg.mv_phb_creature_template_bundle` |
| `rpg.mv_phb_vehicle_template_bundle` |
| `rpg.mv_phb_character_thread_bundle` |
| `rpg.mv_phb_heritage_trait_choices` |
| `rpg.mv_phb_species_trait_choices` |
| `rpg.mv_phb_hp_bonus_source` |
| `rpg.mv_phb_unarmored_defense` |

Padrão: quase todas têm uma view `v_*` correspondente; a `mv_*` é a versão materializada para leitura mais rápida.

---

## Functions (6)

| Function | Papel |
|----------|--------|
| `rpg.set_updated_at` | Trigger helper (`updated_at`) |
| `rpg.enforce_pc_subclass_belongs_to_class` | Validação de subclass × class |
| `rpg.spawn_game_actor_from_template` | Cria actor a partir de template |
| `rpg.get_character_sheet_bundle` | Bundle da ficha |
| `rpg.get_character_combat_bundle` | Bundle de combate |
| `rpg.get_game_actor_bundle` | Bundle do game actor |

---

## Triggers (15)

- 13× `updated_at` em tabelas de catálogo/runtime (`tr_*_updated_at`)
- 1× `tr_player_character_subclass_class` (integridade subclass/class)
- Cobertura típica: class, subclass, spell, feat, species, heritage, item, background, campaign, game_actor, etc.

---

## Indexes (173)

Inclui indexes explícitos (`CREATE INDEX` / `UNIQUE INDEX`) além das PKs/UNIQUE embutidas nas tabelas. Concentrados no catálogo `phb_*` e nas FKs de runtime.

---

## Segurança (RLS)

- **26** tabelas com `ENABLE ROW LEVEL SECURITY`
- **44** policies (`CREATE POLICY`) — dono, membro de campanha, skirmish, etc.

---

## Leitura rápida

Em uma frase: o schema é **1 namespace `rpg`**, com **46 enums**, **177 tabelas** (maioria catálogo PHB), **41 views**, **16 materialized views**, mais **6 functions**, **15 triggers**, **173 indexes** e uma camada de **RLS** (44 policies).
