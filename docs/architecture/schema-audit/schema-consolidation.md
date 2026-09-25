# Enxugada do schema `rpg` — comparação profunda e consolidação

> **Trilha GEN fechada (2026-09-25):** decisões e resultado em [`../adr-schema-generics.md`](../adr-schema-generics.md).  
> Origem: auditoria 2026-09-23 (repo `check`); espelho em `docs/architecture/schema-audit/`.

Objetivo: **reduzir o número de tabelas e relações** sem destruir o domínio D&D / Dende.  
Base: `schema.sql` (177 tabelas, 41 views, 16 materialized views).  
Método: similaridade de colunas (Jaccard + acordo de tipos), famílias por prefixo, hubs de FK, cheiros DRY/DDD/Clean Code.

---

## 0. Norte de design: genérico > tabela específica

### O problema que você está nomeando

O schema atual cresceu no modo **“cada feature do livro ganha uma tabelinha”**:

| Específico demais (hoje) | Por que dói |
|--------------------------|-------------|
| `phb_battle_master_maneuver` vs `phb_gunslinger_maneuver` vs `phb_cunning_strike_effect` | Três “catálogos de manobra/golpe” com shapes diferentes |
| `phb_beastborne_aspect_benefit`, `phb_dungeoneer_slayer_type`, `phb_persona_mask` | Tabelas **de uma subclass/feature** |
| `phb_wild_shape_*`, `phb_spell_spirit*` | Mecânica nomeada virando DDL |
| `phb_effect_temp_hp`, `…_combat_flag`, `…_table_roll`, … (×27) | Um `effect_kind` ≈ uma tabela |
| `rage_active`, `starry_form_active`, `skinrider_trance_active` em `player_character_state` | Coluna específica por feature |
| `skirmish` / `duel` / `campaign_encounter` | Três produtos, três modelos |
| `player_character_species_choice` vs `…_transformation_choice` | Mesmo shape, domínio “escolha” fatiado |

Isso otimiza o *seed do PHB de hoje*, não um **sistema genérico de RPG tático** (que é o que o Dende quer ser).

### Princípio

> **O banco modela primitivas do jogo** (efeito, recurso, opção, escolha, ator, sessão de combate, nota de mesa).  
> **O livro/feature** entra como *dado* (slug, kind, payload) — não como *nova tabela*.

Regra prática de PR:

- ❌ “Preciso de Wild Shape → cria `phb_wild_shape_*`”
- ✅ “Wild Shape = efeitos + recursos + choices + actor template já existentes”
- ❌ “Nova subclass com manobra → `phb_foo_maneuver`”
- ✅ “Manobra = linha em catálogo genérico `phb_maneuver` / ou só `phb_effect` + option”

### Primitivas-alvo (poucas tabelas, muitos dados)

| Primitiva | Substitui (exemplos) |
|-----------|----------------------|
| **Effect** (+ payload genérico / JSONB tipado por `kind`) | 27× `phb_effect_*`, flags de state, vários one-offs |
| **Resource definition** | superiority dice, rage, psi, etc. sem tabela por classe |
| **Option def/value** | choices de espécie, invocação, metamágica como options |
| **Choice (runtime)** | species_choice, transformation_choice, heritage slots |
| **Catalog entry** (id/slug/name + kind) | fighting style, mastery, persona mask, slayer type, … |
| **Stat block child** polimórfico | creature/vehicle/actor action|speed|trait|spell |
| **Combat session + participant** | skirmish, duel, encounter |
| **Requirement clause** | 7× feat_requirement_* |
| **Combat note** | 3× `*_combat_note` |

Enums/`kind` + payload continuam dando tipagem — **sem** abrir tabela nova por feature.

### Consequência para a enxugada

Prioridade deixa de ser “juntar tabelas parecidas” e passa a ser:

1. **Matar tabelas de feature** (Beastborne, Dungeoneer, Persona Mask, Wild Shape bands como DDL dedicado, …).
2. **Colapsar famílias que só existem por kind** (`phb_effect_*`, manobras nomeadas).
3. **Um modelo de combate**, não três.
4. **Estado do PC** como mapa genérico (`flags` / `resources` / `trackers`), não coluna por poder.

As seções abaixo detalham *como* — alinhadas a esse norte.

---

## 1. Panorama (por que parece “muita tabela”)

| Camada | Qtd | Papel |
|--------|----:|-------|
| Tabelas | **177** | DDL persistido |
| Views | 41 | Contratos de leitura |
| Materialized views | 16 | Cache de catálogo |
| Enums | 46 | Vocabulário tipado |
| Indexes explícitos | ~173 | Performance |

### Famílias (contagem)

| Família | Tabelas | Leitura |
|---------|--------:|---------|
| `phb_misc` + satélites soltos | ~50+ | Catálogo pulverizado |
| `phb_effect_*` | **27** | Maior explosão (1 kind ≈ 1 payload table) |
| `player_character*` | 16 | Ficha + choices + estado |
| `phb_class*` / `phb_subclass*` | 11 / 8 | Espelhos de progressão |
| `phb_spell*` | 10 | Magia |
| `creature_template*` / `vehicle_template*` / `game_actor*` | 7 / 4 / 5 | Stat blocks espelhados |
| `feat_requirement*` | 7 | Prerequisites fatiados |
| Combate runtime (`skirmish`/`duel`/`campaign_encounter`) | 6 | **3 produtos de combate** |
| Resto (heritage, transformation, threads, dmg, …) | … | |

### Hubs de FK (quem mais é referenciado)

| Tabela | FKs inbound (aprox.) | Papel |
|--------|---------------------:|-------|
| `phb_effect` | 27 | Núcleo do motor de regras |
| `player_character` | 23 | Agregado da ficha |
| `phb_spell` | 20 | Catálogo de magia |
| `phb_subclass` / `phb_class` | 19 / 18 | Progressão |
| `phb_ability` / `phb_feat` / `phb_item` | 14 | Taxonomia |
| `phb_creature_template` | 11 | Stat blocks |

**Implicação:** enxugar satélites de `phb_effect` e espelhamentos de template/combat dá o maior ganho; mexer em `phb_class`/`spell` sem plano quebra o grafo inteiro.

---

## 2. O que a comparação automática encontrou

- **803** pares de tabelas com similaridade ≥ 0,45  
- **144** pares **cross-family** ≥ 0,55 (ouro para consolidação)  
- **1** tabela sem PK: `phb_class_proficiency`  
- **3** enums órfãos: `resource_owner_kind`, `combat_modifier_kind`, `combat_modifier_owner`  
- **29** junction tables (muitas legítimas)  
- **11 bools** em `player_character_state` (god-table de flags)  
- **~28** colunas `TEXT` + `CHECK IN (...)` que poderiam ser enums compartilhados

Similaridade alta em lookups (`id/slug/name`) **não** significa “juntar tudo” — significa shape comum.  
Similaridade alta **cross-family** em action/speed/trait **sim** significa candidato a unificar.

---

## 3. Roadmap de enxugada (priorizado)

Estimativas de **tabelas a menos** se a consolidação for completa nesse cluster.

| Prioridade | Cluster | Hoje | Depois (alvo) | Economia | Risco | Valor |
|------------|---------|-----:|--------------:|---------:|------:|------:|
| P0 | Stat-block children (creature/vehicle/actor) | 10 | 3–4 | **6–7** | Médio | Alto |
| P0 | Sessões de combate (skirmish/duel/encounter) | 6 | 2–3 | **3–4** | Alto | Alto |
| P1 | Choices PC idênticas | 2 | 1 | **1** | Baixo | Médio |
| P1 | Feat requirements | 7 | 2 | **5** | Médio | Médio |
| P1 | Combat notes | 3 | 1 | **2** | Baixo | Médio |
| P1 | Class↔subclass gates/features (polimórfico) | ~6 | ~3 | **3** | Médio | Médio |
| P2 | Effect satellites | 27 | 8–12 *ou* 1+JSONB | **15–26** | **Muito alto** | Alto se aguentar |
| P3 | Lookups mínimos | 7+ | 7+ | **0** | — | Não mesclar |
| P3 | Manobras BM vs Gunslinger | 2 | 2 | **0** | — | Não forçar |
| — | Limpeza enums/CHECK→enum / PK | — | — | 0 tabelas | Baixo | Higiene |

### Teto realista

| Cenário | Economia de tabelas | 177 vira |
|---------|--------------------:|---------:|
| Conservador (P0 parcial + P1) | ~12–15 | ~162–165 |
| Agressivo (P0+P1+P2 parcial) | ~25–35 | ~142–152 |
| Radical (effects→JSONB) | ~40–50 | ~127–137 |

Abaixo disso começa a destruir tipagem do motor de efeitos — em geral **não vale**.

---

## 4. Cluster A — Stat blocks espelhados (melhor ROI estrutural)

### Tabelas (10)

**Creature:** `…_speed`, `…_action`, `…_spell`, `…_trait`  
**Vehicle:** `…_speed`, `…_action`, `…_trait` (sem spell)  
**Runtime:** `game_actor_speed`, `game_actor_action`, `game_actor_spell`

### Matriz (similaridade)

| Par | Score | Diff |
|-----|------:|------|
| creature_speed ↔ vehicle_speed | **1.00** | idêntico |
| creature_action ↔ vehicle_action | **1.00** | idêntico |
| creature_trait ↔ vehicle_trait | **1.00** | idêntico |
| creature_action ↔ game_actor_action | **0.82** | `template_slug` vs `actor_id` |
| vehicle_action ↔ game_actor_action | **0.82** | idem |
| creature_spell ↔ game_actor_spell | **0.80** | idem |
| *_speed ↔ game_actor_speed | **0.65** | idem |

### Colunas canônicas

```
speed:   (owner_ref, movement_kind, speed_ft)
action:  (id, owner_ref, name, action_bucket, attack_bonus, damage_expression, reach_ft, sort_order, description)
spell:   (id, owner_ref, spell_slug, usage_kind, uses_per_day, slot_level, recharge_dice, sort_order)
trait:   (id, owner_ref, name, description, sort_order)
```

### Proposta de enxugada

**Opção A1 — Polimorfismo por kind (recomendada para catálogo)**

```text
phb_stat_block_speed (
  owner_kind  TEXT CHECK IN ('creature','vehicle'),  -- ou enum
  template_slug TEXT,
  movement_kind, speed_ft,
  PRIMARY KEY (owner_kind, template_slug, movement_kind)
)

phb_stat_block_action ( ... owner_kind, template_slug, ... )
phb_stat_block_trait  ( ... )
phb_stat_block_spell  ( ... )  -- só creature na prática
```

**10 → 4** no catálogo; `game_actor_*` pode permanecer (snapshot) **ou**:

**Opção A2 — Também unificar runtime**

```text
stat_block_action (
  owner_kind CHECK IN ('creature_template','vehicle_template','game_actor'),
  owner_key  TEXT  -- slug ou uuid textual
  ...
)
```

**10 → 3–4** no total do cluster.  
Trade-off: FK fraca (`owner_key` não referencia UUID tipado); precisa CHECK + app discipline.

**Opção A3 — Manter snapshot `game_actor_*`, só unificar creature/vehicle**

**10 → 7** (−3). Mais seguro; ainda remove a pior duplicação 1:1.

### O que *não* unificar aqui

Raízes `phb_creature_template` vs `phb_vehicle_template` (score ~0,37): colunas de CR/spellcasting vs crew/cargo — **domínios diferentes**.

### Falha atual relacionada

- FK por `template_slug` TEXT (sem `ON UPDATE`) nas filhas — typo de slug não quebra INSERT do filho se o pai mudar depois.

---

## 5. Cluster B — Três motores de combate (maior cheiro de domínio)

### Tabelas (6)

| Produto | Cabeçalho | Participantes |
|---------|-----------|---------------|
| Skirmish (PvE solo) | `skirmish` | `skirmish_combatant` |
| Duel (PvP) | `duel` | `duel_member` |
| Encounter (campanha) | `campaign_encounter` | `campaign_encounter_combatant` |

### Similaridade

| Par | Score | Leitura |
|-----|------:|---------|
| skirmish_combatant ↔ campaign_encounter_combatant | **0.67** | mesma ideia de fila de iniciativa |
| skirmish ↔ duel | **0.62** | sessão com round/log/arena |
| duel_member ↔ encounter_combatant | **0.52** | HP/conditions vs initiative sort |
| duel ↔ campaign_encounter | **0.51** | sessão “na mesa” |
| skirmish ↔ campaign_encounter | **0.45** | overlap menor |

### Colunas compartilhadas (conceito)

Sessão: `status`, `round`, `turn_attacks_remaining`, `combat_log`, `arena_effects`, `end_reason`, timestamps  
Combatant: `kind` (pc/actor), `character_id`/`actor_id`, iniciativa, `sort_order`, `is_active`  
HP de combate: às vezes no member (`duel_member`), às vezes no state do actor/PC (`skirmish`), às vezes no combatant (`encounter_combatant`) — **inconsistência de agregado**.

### Proposta de enxugada

**Opção B1 — Um agregado `combat_session` + `combat_participant`**

```text
combat_session (
  id UUID PK,
  mode ENUM ('skirmish','duel','encounter'),
  -- campos comuns
  status, round, turn_attacks_remaining, combat_log, arena_effects, ...
  -- campos opcionais por mode (NULL quando N/A):
  campaign_id, invite_code, character_id (skirmish host), ...
)

combat_participant (
  id UUID PK,
  session_id FK,
  kind ENUM ('pc','actor'),
  character_id, actor_id, user_id,
  display_name,
  initiative_*, sort_order, is_active, ready,
  hit_points_*, temp_hp, conditions, ...
)
```

**6 → 2** (−4).  
Views `v_skirmish`, `v_duel`, `v_encounter` restauram DX da API.

**Opção B2 — Unificar só combatants; manter 3 headers**

**6 → 4** (−2). Mais seguro se os fluxos de produto forem muito diferentes.

**Opção B3 — Extrair só value objects compartilhados**

Não corta tabela; corta enums/CHECKs duplicados (`status`, `end_reason`, `kind`). Economia 0 tabelas, ganho de consistência.

### Falhas / cheiros neste cluster

1. Três modelos mentais para “combate na mesa”.  
2. `status`/`end_reason`/`kind` como TEXT+CHECK repetido (deveriam ser enums únicos).  
3. `user_id` / `created_by` UUID sem FK no schema `rpg` (Supabase auth — documentar).  
4. Onde mora o HP? Resposta diferente por modo → bugs de sync garantidos a médio prazo.

### Recomendação

Para **enxugada séria**: B1 se o time puder migrar a API de uma vez; senão B2 + B3 agora, B1 depois.

---

## 6. Cluster C — Choices do personagem (vitória fácil)

### Tabelas

| Tabela | Colunas |
|--------|---------|
| `player_character_species_choice` | `character_id, choice_kind, choice_slug` |
| `player_character_transformation_choice` | `character_id, choice_kind, choice_slug` |
| `player_character_option` | scope/owner/option_key/value (mais rico) |
| `player_character_heritage_*` | slots / config específicos |
| `player_character_transformation` | slug + stage |

### Achado

`species_choice` ↔ `transformation_choice` = **similaridade 1.00** (colunas idênticas).

### Proposta

```text
player_character_choice (
  character_id,
  domain ENUM ('species','transformation', …),
  choice_kind,   -- pode continuar species_choice_kind ou TEXT tipado por domain
  choice_slug,
  PRIMARY KEY (character_id, domain, choice_kind)  -- ajustar se multi-value
)
```

**2 → 1** (−1). Baixo risco.  
**Não** fundir com `player_character_option` (shape e semântica diferentes: option é catálogo polimórfico).

---

## 7. Cluster D — `phb_feat_requirement*` (7 → 2)

### Hoje

| Tabela | Papel |
|--------|--------|
| `phb_feat_requirement` | Header (level, spellcasting, armor, …) |
| `…_ability` | ability + minimum_score |
| `…_feat` | feat requerido |
| `…_feat_option` | feat + option_key/value |
| `…_skill` | skill |
| `…_species` | species |
| `…_weapon_proficiency` | slug de proficiência |

### Proposta

```text
phb_feat_requirement (header — permanece)

phb_feat_requirement_clause (
  feat_id,
  clause_kind ENUM ('ability','feat','feat_option','skill','species','weapon_proficiency'),
  ref_id BIGINT NULL,
  ref_slug TEXT NULL,
  minimum_score INT NULL,
  option_key TEXT NULL,
  value_id TEXT NULL,
  ...
  CHECK coerente por clause_kind
)
```

**7 → 2** (−5).  
Mesmo padrão polimórfico já usado em `phb_effect` / `phb_option_def`.  
Custo: queries “liste abilities do feat” ficam `WHERE clause_kind = 'ability'`.

---

## 8. Cluster E — Combat notes (3 → 1)

### Hoje

| Tabela | Shape |
|--------|-------|
| `phb_level_combat_note` | owner_kind class/subclass + ids + unlock_level + note |
| `phb_heritage_combat_note` | trait_id + min_trait_takes + note |
| `phb_transformation_boon_combat_note` | boon_id + name_pt + economy + note_pt |

Similaridade estrutural baixa (0–0,3), mas **mesmo conceito de domínio**: “texto de mesa ligado a um unlock”.

### Proposta

```text
phb_combat_note (
  id,
  source_kind ENUM ('class_level','subclass_level','heritage_trait','transformation_boon'),
  source_id / trait_id / boon_id (nullable conforme kind),
  unlock_level INT NULL,
  min_trait_takes INT NULL,
  economy TEXT NULL,
  name_pt TEXT NULL,
  note / note_pt,
  sort_order
)
```

**3 → 1** (−2).  
Risco baixo se a UI já trata “nota de combate” como um componente só.

---

## 9. Cluster F — Class ↔ Subclass (espelhos seletivos)

### Pares fortes

| Par | Score | Diff |
|-----|------:|------|
| class_spellcasting ↔ subclass_spellcasting | 0.69 | subclass + list/pattern |
| class_feature ↔ subclass_feature | 0.65 | + feature_kind, option_key |
| class_feature_gate ↔ subclass_feature_gate | 0.65 | class_id vs subclass_id |
| class_progression ↔ subclass_progression | 0.53 | class tem PB/ASI/etc. |

### O que unificar faz sentido

**Gates** e talvez **features**:

```text
phb_feature_gate (
  owner_kind ENUM ('class','subclass'),
  owner_id BIGINT,
  gate_key, unlock_level, ...
)
```

**2 → 1** nos gates (−1). Features: **2 → 1** se aceitar colunas nullable extras (−1).

### O que *não* unificar

- `progression`: class é bem mais gorda.  
- `spellcasting`: subclass tem `spell_list_class_id` / pattern — fundir gera muitos NULLs.  
- `class_economy_action` vs `subclass_table_action`: nomes e colunas **divergentes** (score ~0,34) — parecem primos distantes, não gêmeos.

Também há `owner_kind IN ('class','subclass')` repetido em:

- `phb_level_combat_note`  
- `phb_initiative_rule`  
- `phb_class_feature_schedule`  

→ candidato a **um enum** `class_or_subclass_owner` (não corta tabela, corta inconsistência).

---

## 10. Cluster G — Satélites `phb_effect_*` (27 tabelas) — o elefante

### Por que existem

`phb_effect.kind` (`effect_kind`, **135 valores**) aponta para payloads tipados:

| Satélite | Colunas além de `effect_id` |
|----------|-----------------------------|
| `…_spell` | spell_id, option_key, spell_level |
| `…_numeric` | amount_formula, flat |
| `…_note` | note |
| `…_reach` | bonus_ft |
| `…_companion` | restore_hp |
| `…_temp_hp` | consume_spell_slot, amount_per_slot_level, ward_temp_hp_cap |
| `…_resource` | resource_id + fórmulas/flags de recover |
| `…_combat_mod` | mod_kind, flat/per_level, shield… |
| … | (27 no total) |

Todas têm `effect_id` → hub com **27 FKs inbound**.

### Opções de enxugada

**G1 — Manter (recomendado se motor depende de tipagem)**  
Economia: 0. Custo: muitas relações. Benefício: CHECK por kind, migrations claras.

**G2 — Agrupar por shape parecido** (meio-termo)

Exemplos de fusão:

| Nova tabela | Absorve |
|-------------|---------|
| `phb_effect_grant_ref` | spell, feat, language, proficiency, damage_type (refs + option_key) |
| `phb_effect_scalar` | numeric, reach, companion, purchase_discount (escalares) |
| `phb_effect_advantage` | check_advantage, save_advantage |
| `phb_effect_sense_env` | sense, environmental_immunity |
| `phb_effect_dice_damage` | damage_die, dice |
| payloads únicos | resource, combat_mod, rest_quirk, weapon, condition, save, forced_movement, combat_flag, table_roll, temp_hp, cast_economy, note |

Estimativa: **27 → ~10–12** (−15 a −17).  
Ainda tipado; menos JOINs mentais.

**G3 — JSONB `payload` em `phb_effect`**  
**27 → 0 satélites** (−27).  
Valida com JSON Schema na app.  
**Risco altíssimo** para o Dende (hoje SQL-first + seeds + views). Só se o time abandonar tipagem SQL do motor.

### Recomendação para enxugada

Começar por **G2** nos grupos claramente isomórficos (grant_ref / advantage / sense).  
Não ir a G3 sem reescrever o runner de efeitos.

---

## 11. Cluster H — Lookups mínimos (NÃO enxugar em uma tabela)

Shapes:

- `id, slug, name, sort_order` → ability, spell_school, tool_category  
- `id, slug, name, description` → fighting_style, weapon_property, weapon_mastery, spell_slot_pattern  

Score cross-family **1.00**, mas unificar em `phb_term(kind, …)`:

- quebra FKs claras (`ability_id` → vira polimórfico),  
- piora DDD / linguagem ubíqua,  
- economiza pouco (são tabelas miúdas).

**Decisão:** manter. “Parecido” ≠ “mesmo conceito”.

---

## 12. Cluster I — Manobras (NÃO forçar merge)

`phb_battle_master_maneuver` vs `phb_gunslinger_maneuver` (score **0.53**):

| BM | Gunslinger |
|----|------------|
| timing, mesa_roll_kind | effect_kind |
| adds_to_damage/attack | risk_cost, from_level, subclass_id |

Mesmo nome de domínio (“maneuver”), **contratos de runtime diferentes**.  
Tabela única geraria coluna morta em massa. Manter 2; no máximo interface TypeScript compartilhada `ManeuverBase { id, slug, name, description }`.

---

## 13. Outras similaridades úteis (não são clusters enormes)

### Heritage ↔ Species (0.73)

`phb_heritage` e `phb_species` compartilham cara de “ancestrais do personagem”, mas fontes (GH vs PHB) e traits diferem. **Não merge** sem produto único de “ancestry”.

### Subclass ↔ Species (0.72)

Overlap de colunas de catálogo (slug/name/…); conceitos distintos. Ignorar.

### Feat benefit ↔ template trait (0.77)

`name/description/sort` — shape de “texto ordenado”. Candidato fraco a `phb_named_blurb`; pouco ganho.

### Junctions (29)

Muitas `*_language`, `*_skill`, N:N legítimas. Enxugar junction só se virar JSON array — **piora integridade**. Manter.

---

## 14. Enxugada sem apagar tabela (higiene que reduz complexidade)

### Enums órfãos → remover

- `resource_owner_kind`  
- `combat_modifier_kind`  
- `combat_modifier_owner`  

(provável legado após `effect_combat_mod_kind` / views)

### TEXT+CHECK → enums compartilhados

Exemplos repetidos / candidatos:

| Conceito | Onde aparece |
|----------|----------------|
| `status` combate | skirmish, duel, campaign_encounter (valores **diferentes** — unificar com cuidado ou enum por mode) |
| `kind` pc/actor | skirmish_combatant (+ espírito no encounter) |
| `rank` thread | milestone + pc_thread_milestone (`least…superior`) — **enum único** |
| `owner_kind` class/subclass | level_combat_note, initiative_rule, feature_schedule |
| `list_type` spell | known/prepared/always_prepared |
| `campaign_member.role` | dm/player/assistant |
| damage affinity kind | resistance/vulnerability/immunity |

Isso não corta tabela, mas corta **superfície cognitiva** e typos.

### PK faltando

`phb_class_proficiency`: adicionar PK composta alinhada ao CHECK de `ref_id`/`ref_slug`.

### God-table `player_character_state`

11 booleans de feature (`rage_active`, `wild_shape_*`, `starry_form_*`, …) + vários JSONB.  
**Enxugada vertical:** 

```text
player_character_flag (character_id, flag ENUM, active BOOL, payload JSONB)
```

ou JSONB único `combat_flags` — **1 tabela a mais**, mas para de crescer a row a cada subclass.  
Trade-off: muda o sentido de “enxugar” (menos colunas, não menos tabelas).

### Views vs Matviews

16 `mv_*` espelham `v_*`. Não são tabelas base, mas **dobram** o catálogo mental.  
Política: API só lê `mv_*` *ou* só `v_*`; documentar refresh. Possível dropar views não usadas (−N objetos, não tabelas).

---

## 15. Mapa “pode virar X tabelas”

### Pacote Conservador (recomendado começar)

| Ação | Δ tabelas |
|------|----------:|
| A3: unificar só children creature/vehicle (speed/action/trait) | −3 |
| C: merge species_choice + transformation_choice | −1 |
| E: merge combat notes | −2 |
| D: feat_requirement clauses | −5 |
| F: merge feature_gates | −1 |
| Higiene enums/PK | 0 |
| **Total** | **≈ −12** |

177 → **~165**, com risco controlado.

### Pacote Agressivo

Conservador +  

| Ação | Δ |
|------|--:|
| A2: incluir game_actor_* no polimorfismo | −3 a −4 extra |
| B2 ou B1: combate | −2 a −4 |
| G2: agrupar effect satellites | −15 a −17 |
| **Total** | **≈ −32 a −37** |

177 → **~140–145**.

### Pacote Radical

Agressivo + G3 (JSONB effects) + B1 completo → **~125–135**.  
Só com rewrite do engine.

---

## 16. Ordem de execução sugerida (migração)

1. **Inventário de consumers** (API Nest, entities TypeORM, seeds, views) por tabela candidata.  
2. Higiene: PK + drop enums mortos + enums para CHECKs repetidos.  
3. **C** (choices idênticas) — PR pequeno.  
4. **E** (combat notes).  
5. **A3** (vehicle/creature children).  
6. **D** (feat requirements).  
7. **F** (gates).  
8. Decidir **B** (combate) com product — maior impacto de UX/API.  
9. Só então **G2** effects, kind por kind, com testes de seed/bundle.

Cada passo: editar `database/schema/**` no dnd-api + migration forward se cloud não puder wipe.

---

## 17. Critérios: quando *não* consolidar

- Score alto só por `id/slug/name` (lookup).  
- Domínios de produto diferentes (skirmish solo vs duel PvP) **sem** view de compatibilidade.  
- Payload de efeito com CHECKs ricos (perder tipagem SQL dói mais que JOIN).  
- Junction N:N clara.  
- Snapshot runtime vs template **se** a regra de jogo for “actor não atualiza quando o MM muda”.

---

## 18. Resposta direta à pergunta “dá para enxugar?”

**Sim.** O schema não está “errado”; está **explodido por tipagem e por três features de combate**.

Os maiores retornos:

1. **Stat-block children duplicados 1:1** (creature/vehicle[/actor])  
2. **Três árvores de combate**  
3. **27 satélites de effect** (agrupar, não necessariamente JSONB)  
4. **Feat requirements fatiados** + **choices PC idênticas** + **combat notes**

Começando pelo pacote conservador você remove **~12 tabelas** com risco baixo.  
O salto para **~140** exige coragem em combate + effects.

---

## Apêndice — Famílias e contagens (referência)

Ver também: `schema-inventory.md` (enums/extensões), `schema-quality.md` (primeira passagem).

Dados brutos desta rodada: comparador com 803 pares; clusters manuais acima alinhados aos maiores scores cross-family e às metas de enxugada.
