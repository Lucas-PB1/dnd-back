# Schema genérico — backlog (primitivas, não tabelas de feature)

**Status:** aberto (GEN-0…7 feitos) · **Não é** mesa ficha · **Não é** combate tipado residual  
**Norte:** banco modela **primitivas**; feature do livro = **dado** (`kind` + payload), não tabela nova.

Auditoria 2026-09-23 (repo `check` → copiada para cá):

| Doc | Para quê |
|------|----------|
| [`../architecture/schema-audit/schema-inventory.md`](../architecture/schema-audit/schema-inventory.md) | Contagens + enums/extensões |
| [`../architecture/schema-audit/schema-quality.md`](../architecture/schema-audit/schema-quality.md) | Similaridade / falhas |
| [`../architecture/schema-audit/schema-consolidation.md`](../architecture/schema-audit/schema-consolidation.md) | Enxugada + §0 norte genérico |

Consolidação **anterior** (lotes A→G, 2026-08): [`adr-schema-consolidation.md`](../architecture/adr-schema-consolidation.md) **Aceito** / mapa histórico.  
Esta trilha é a **onda 2**: matar o que ainda é específico demais (~177 tabelas no dump atual).

Runner DDL: TypeORM — [`database/migrations/README.md`](../../database/migrations/README.md).

## Skills / rules

`postgresql-sql` · `catalog-sql-first` · `dry` · `domain-driven-design` · `clean-code` · `typeorm` · `nestjs` · `testing` · `okf`  
Rules: `catalog-sql-first.mdc` · `file-size.mdc` · `typescript-docs.mdc`

## Primitivas-alvo (lembrar em todo PR)

| Primitiva | Empurra para fora |
|-----------|-------------------|
| Effect (+ payload por kind, sem tabela/feature) | `phb_effect_*` explosão; flags de feature no state |
| Resource definition | pools por classe em DDL dedicado |
| Option def/value | choices/catálogos miúdos |
| Choice (runtime) | species_choice vs transformation_choice duplicados |
| Catalog entry genérico | persona_mask, slayer_type, beastborne_aspect… |
| Stat-block child polimórfico | creature/vehicle/actor action\|speed\|trait\|spell |
| Combat session + participant | skirmish / duel / encounter |
| Requirement clause | 7× `feat_requirement_*` |
| Combat note | 3× `*_combat_note` |

## Fila (fácil → difícil)

| # | Pacote | Tam. | Dep | Δ tabelas (est.) |
|---|--------|------|-----|-----------------:|
| **GEN-0** | ~~Docs no repo + link no backlog SSOT~~ **feito** | S | — | 0 |
| **GEN-1** | ~~Higiene: PK `phb_class_proficiency`; drop enums órfãos; CHECKs repetidos → enums~~ **feito** | S | GEN-0 | 0 |
| **GEN-2** | ~~Runtime choice única (`species` + `transformation` idênticos)~~ **feito** | S | GEN-1 | −1 |
| **GEN-3** | ~~Combat note única (class/subclass/heritage/boon)~~ **feito** | S | GEN-1 | −2 |
| **GEN-4** | ~~Feat requirement: header + `clause` polimórfica~~ **feito** | M | GEN-1 | −5 |
| **GEN-5** | ~~Feature gate class\|subclass polimórfico~~ **feito** | M | GEN-1 | −1 |
| **GEN-6** | ~~Stat-block children: unificar creature↔vehicle (+ opcional actor snapshot)~~ **feito** | M | GEN-1 | −3 |
| **GEN-7** | ~~Matar tabelas **de feature** → catalog/effect/option~~ **feito** (−5; manobras KEEP) | L | GEN-2…4 | −5 |
| **GEN-8** | ~~Combate: uma sessão + participantes (skirmish/duel/encounter)~~ **feito** | L | GEN-6 | −3 |
| **GEN-9** | ~~Effect satellites: **agrupar por shape** (não JSONB total sem ADR)~~ **feito** (G2) | L | GEN-7 | −10 |
| **GEN-10** | ~~`player_character_state`: flags/trackers genéricos (sem coluna por poder)~~ **feito** (−17 colunas) | M | GEN-7 | 0 |

Ordem sugerida: **GEN-0 → 1 → 2 → 3 → 4/5 → 6 → 7 → 10 → 8 → 9**.  
GEN-8 e GEN-9 são os de maior risco de API/engine — ADR curto antes de codar.

## Checklist por pacote

### GEN-0 — Docs

- [x] Pasta `docs/architecture/schema-audit/` com os 3 MDs da auditoria
- [x] Entrada em [`backlog.md`](backlog.md) (Feature futura) + [`docs/README.md`](../README.md)
- [x] Bloco OKF em [`docs/okf/log.md`](../okf/log.md)

### GEN-1 — Higiene

- [x] PK em `phb_class_proficiency` (`ref_key` gerado + PK `(class_id, kind, ref_key)`)
- [x] Removidos órfãos: `resource_owner_kind`, `combat_modifier_kind`, `combat_modifier_owner` (SSOT = `effect_combat_mod_kind` / `effect_owner_kind`)
- [x] Enums compartilhados: `thread_milestone_rank`, `class_subclass_owner`, `combatant_kind`, `damage_affinity_kind`, `spell_list_type`, `campaign_member_role`
- [x] `db:setup` / migrate local verde

### GEN-2 — Choice runtime

- [x] Uma tabela `player_character_choice` com `domain` (`character_choice_domain`)
- [x] Dropar `player_character_species_choice` + `player_character_transformation_choice`
- [x] Entities + seeds + consumers atualizados

### GEN-3 — Combat note

- [x] `phb_combat_note` com `source_kind` (`combat_note_source`)
- [x] Migrar 3 tabelas `*_combat_note` + seeds
- [x] Views/DTOs de mesa (queries + entity)

### GEN-4 — Feat requirements

- [x] `phb_feat_requirement` header KEEP
- [x] `phb_feat_requirement_clause` polimórfica
- [x] Dropar 6 satélites; seeds reescritos

### GEN-5 — Feature gates

- [x] Gate único `owner_kind` class|subclass (`phb_feature_gate`)
- [x] Dropar espelho duplicado

### GEN-6 — Stat-block children

- [x] Unificar speed/action/trait/spell → `phb_stat_block_*` (dual FK + `owner_kind`/`template_slug` gerados)
- [x] Manter `game_actor_*` como snapshot em spawn (A3; sem polimorfismo runtime)
- [x] `spawn_game_actor_from_template` + bundles + seeds criatura/veículo + `db:setup` verde

### GEN-7 — Sem tabela de feature

**Inventário → destino**

| Tabela | Destino |
|--------|---------|
| `phb_persona_mask` | `phb_option_*` (`personaMask`) |
| `phb_beastborne_aspect_benefit` | `phb_option_*` (`bestialAspect` + `benefit`) |
| `phb_dungeoneer_slayer_type` | `phb_option_*` (`slayerType`) |
| `phb_wild_shape_cr_band` / `_known_band` | `phb_class_feature_schedule` (`wild_shape_*`) |
| `phb_battle_master_maneuver` / `phb_gunslinger_maneuver` | **KEEP** (contratos runtime distintos — audit §12) |
| `phb_cunning_strike_effect` | **KEEP** por ora (shape ≠ option; candidato futuro effect/catalog) |
| `phb_subclass_precaution_spell` / `phb_spell_spirit*` | adiados (junction / spawn — não “catálogo de feature” puro) |

- [x] Inventário + destinos no backlog
- [x] Migrar trio Masks/Beastborne/Slayer + wild-shape bands (−5 tabelas)
- [x] Regra prática: sem `phb_<feature>_…` novo sem ADR (anti-padrão acima)
- [x] `db:setup` + testes mecânicos wild-shape/catalog verdes

### GEN-8 — Combat session

**ADR (inline)**

- **Decisão:** `rpg.combat_session(mode combat_session_mode)` + `rpg.combat_participant(session_mode)`; FK composta `(session_id, session_mode) → (id, mode)` impede participante de modo errado. Colunas específicas de modo são nullable, travadas por `CHECK combat_session_shape_by_mode` / `combat_participant_shape_by_mode`; status validado por modo (`open|ready|active|finished|cancelled` duel; `active|finished` skirmish; `active|closed` encounter).
- **Unicidade:** `invite_code` único; 1 encounter ativo por campanha; 1 skirmish ativa por `created_by`; `(session_id, character_id|actor_id)` e `(session_id, user_id)` em duel.
- **TypeORM:** Single Table Inheritance — `CombatSession` / `CombatParticipant` (`@TableInheritance`) em `game/shared/infrastructure`; `Duel`, `Skirmish`, `CampaignEncounter` e respectivos participantes viram `@ChildEntity(mode)`. Repositories/services **inalterados** (discriminador no INSERT + `mode IN (...)` no SELECT automáticos).
- **Renomes de coluna:** `duel_id|skirmish_id|encounter_id → session_id`; skirmish `user_id → created_by`; duel `initiative → initiative_total`; `current_combatant_id → current_participant_id`. Propriedades TS mantidas.
- **Sem views de compat** (wipe local via `db:setup`); RLS por modo na mesma tabela (políticas permissivas somam por OR).

- [x] ADR: mode skirmish|duel|encounter
- [x] `combat_session` + `combat_participant` (−5 +2 = −3 tabelas)
- [x] API skirmish/duel/encounter migrada via STI (sem views de compat)
- [x] RLS/policies (`0008`/`0011`/`0012` por modo; FK `created_by → auth.users` em `0007`)

### GEN-9 — Effect payloads

**ADR (inline)**

- **Decisão: G2.** G3 (JSONB) rejeitado — perde CHECK/FK por kind e exigiria reescrever o runner.
- **Grupos (15 → 5, −10 tabelas; 27 → 17 satélites):** `phb_effect_grant_ref(grant_kind)` = spell/feat/language/proficiency/damage_type; `phb_effect_scalar(scalar_kind)` = numeric/reach/companion/purchase_discount; `phb_effect_advantage(advantage_kind)` = check/save; `phb_effect_sense_env(sense_env_kind)` = sense/environmental_immunity; `phb_effect_dice(dice_kind)` absorve damage_die. PK segue `effect_id` (1 payload por grupo por effect — verificado nos dados antes do merge).
- **Integridade:** CHECK por kind obriga as colunas do payload e zera as dos outros (colunas sem default; seeds explícitos). FKs (`spell_id`, `language_slug`) preservadas.
- **TypeORM:** STI — pai por grupo em `phb-effect-payload-groups.entity.ts`; as 15 entities viram `@ChildEntity(valor)`. O JOIN eager `OneToOne` (lado inverso) recebe `AND <discriminador>='valor'` do próprio TypeORM ⇒ relações `PhbEffect.spell`, `.numeric`, … e **todos os consumidores inalterados**.
- **Mantidos 1:1** (shape único ou semântica própria): cast_economy, resource, combat_mod, note, weapon, rest_quirk, condition, save, forced_movement, combat_flag, table_roll, temp_hp. A estimativa −15…−17 da auditoria contava fundir parte desses; fica como follow-up só se aparecer shape comum real.
- **Seeds:** 310 INSERTs reescritos mecanicamente (`INSERT INTO <grupo> (<disc>, …) SELECT '<valor>', …`).

- [x] ADR: G2 (agrupar shapes) vs G3 (JSONB) — **G2**
- [x] Migrar satélites isomórficos (grant_ref, scalar, advantage, sense_env, dice)
- [x] Effect dictionary (tabela lógico→físico) + seeds + engine loaders (sem mudança de consumidor)
- [x] `db:setup` verde + smoke ORM: 1394 effects, 412 payloads, 0 cruzamentos entre kinds

### GEN-10 — PC state genérico

**ADR (inline)**

- **Decisão:** coluna `feature_state JSONB` **esparsa** (chave ausente = default) em vez de tabela `player_character_flag` — estado é 1:1 com o PC, lido/escrito sempre junto da row; tabela extra só traria JOIN. Sem versão no JSON: as chaves são opcionais e o default mora no código.
- **Movidas (17 colunas → 1):** `high_elf_cantrip_swap_available`, `firearm_chambers`, `rage_active`, `reckless_active`, `sacred_weapon_active`, `persona_masks`, `bestial_aspect_level`, `missile_shield_armed`, `giga_missile_armed`, `starry_form_active`, `stellar_constellation`, `wild_shape_active`, `wild_shape_template_slug`, `wild_shape_known_slugs`, `wild_shape_form_swap_available`, `aberrant_mutation_active`, `skinrider_trance_active`.
- **Mantidas como coluna:** estado genérico de ficha (slots, recursos, condições, PV temp., DV, death saves, inspiração, `granted_spell_uses`, `mesa_circumstances`) e **referências FK** a `game_actor` (`wild_shape_actor_id`, `boarded_actor_id`, `skinrider_actor_id`) — JSONB perderia `ON DELETE SET NULL`.
- **SSOT de chaves/defaults:** `src/game/session/domain/character-feature-state.ts` (`CharacterFeatureState`, `readFeature`/`writeFeature`). Escrita remove chave quando volta ao default.
- **TypeORM:** `PlayerCharacterState` expõe getters/setters com os nomes antigos sobre `featureState` ⇒ ~550 usos em session/combat/dice/effects **inalterados**. Limites: `select`/`where` do TypeORM precisam usar `featureState` (1 query ajustada); spread de instância não copia os getters (nenhum caso encontrado).
- **DB:** CHECK `jsonb_typeof = 'object'` + faixa 0–5 de `bestialAspectLevel`. SQL cru usa `feature_state->>'<chave>'` (troca de truque do alto-elfo).
- **Regra:** poder novo de classe/subclasse = chave nova em `CharacterFeatureState` (+ accessor se for ergonômico), **não** coluna.

- [x] Substituir bools de feature (`rage_active`, `starry_form_*`, …) por mapa tipado
- [x] JSONB esparso (`feature_state`) — sem `player_character_flag`
- [x] Consumers session/combat (API da entity preservada; 1 query + 1 SQL cru ajustados)
- [x] `db:setup` verde + smoke Postgres (round-trip, select, CHECK) + Jest sem regressão

## Anti-padrões

- Nova tabela porque “saiu no suplemento X”
- Fundir lookups `id/slug/name` num `phb_term` genérico (quebra FKs/DDD) — **fora desta trilha**
- JSONB total nos effects **sem** ADR GEN-9
- Misturar GEN-8 (combate) com polish de mesa no mesmo PR
- Cascata ALTER em cloud com dados se wipe for opção — preferir `db:setup` local; forward só se necessário ([`database/migrations/README.md`](../../database/migrations/README.md))

## DoD da trilha

- [x] GEN-0…1 fechados (higiene + docs)
- [x] Pelo menos pacote conservador GEN-2…6 feito (≈ −12 tabelas)
- [x] GEN-7: zero tabelas novas “de feature” no schema SSOT (purge Masks/Beastborne/Slayer/WS; manobras KEEP documentado)
- [x] GEN-8/9: ADR + implementação (inline acima)
- [x] GEN-10: `feature_state` esparso
- [ ] `data-model.md` / `catalog-patterns.md` atualizados (`data-model` ok; `catalog-patterns` pendente)
- [ ] Plano filho **apagado** quando a trilha fechar (política docs)

## Pacotes de economia (referência rápida)

| Cenário | Δ tabelas | Alvo ~ |
|---------|----------:|-------:|
| Conservador (GEN-1…6) | −12 | ~165 |
| Agressivo (+7,8,9 parcial) | −32…−37 | ~140 |
| Radical (effects JSONB) | −40…−50 | ~130 | só com ADR GEN-9 = G3 |
