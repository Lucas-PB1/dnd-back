---
type: Concept
title: Auditoria SQL-first — hardcodes em Game
description: Achados priorizados da onda 2; piloto e dívida restante.
tags: [sql-first, audit, game]
timestamp: 2026-09-11
---

# Auditoria — hardcodes em `src/game`

Varredura 2026-09-11. Critério: regra de catálogo (slug/nível/mapa) em TS que deveria viver em Postgres.

## Migrado nesta onda

| Achado | Destino SQL | Status |
| --- | --- | --- |
| Desbloqueio Estilo de Luta por classe | `fighting_style_unlock_level` | **migrado** |
| ASI / feat levels | `asi_or_feat` | **migrado** |
| Expertise slots | `phb_option_def` expertiseSkill* | **migrado** |
| Jack of All Trades | `jack_of_all_trades_level` | **migrado** |
| Companion profiles / commands | `phb_companion_*` | **migrado** |
| Manikin AC / ancestry | armor preset + `damage_type` | **migrado** |
| Initiative / bloodhound gates | `phb_initiative_rule` / `phb_subclass_feature_gate` | **migrado** |
| Notes GH / Northlands / packs PHB estáticos | `phb_level_combat_note` | **migrado** |
| Labels PT de tipo de dano | `phb_damage_type` | **migrado** |
| Notes PHB restantes (literais) | `phb_level_combat_note.remaining-static` | **migrado** |
| Notes classe bárbaro/monge/paladino | `phb_level_combat_note.barb-monk-paladin-class` | **migrado** (sem templates TS) |
| Notes dinâmicas restantes (fighter…wizard) | `phb_level_combat_note.remaining-dynamic-as-static` | **migrado** |
| Schedules nível→valor (piloto) | `phb_class_feature_schedule` | **migrado** (attacks, martial arts, unarmored) |
| Schedules onda 2 | `phb_class_feature_schedule` | **migrado** (sneak, BI, rage, indomitable, superiority, psi, champion, zealot) |
| Schedules onda 3 | `phb_class_feature_schedule` | **migrado** (brutal, gunslinger crit, warlock pact/invocations, metamagic) |
| Schedules onda 4 | `phb_class_feature_schedule` | **migrado** (divine strike/spark, radiant strikes, aura range, masks, portent) |

## Dívida restante

| Prioridade | Achado | Casa sugerida |
| --- | --- | --- |
| baixa | Transformation Cap.6 / heritage notes | outro SSOT (já separado) |
| — | Gates booleanos `has*` (fighter/rogue/monk/paladin/ranger + subclass) | **migrado** → `phb_class_feature_gate` + `phb_subclass_feature_gate` |
| — | Schedules menores (divine strike, masks, portent, aura, radiant) | **migrado** → wave4 `phb_class_feature_schedule` |
| — | Fórmulas com mod/estado (`rageActive`, CD, smite por slot, magical cunning ceil) | **manter TS** |
| — | Channel Divinity / Focus (ki) / Wild Shape usos | já em progression / grant_resource — **não** duplicar |
| — | Handlers mesa `switch (actionSlug)` | **fechado** (todas as classes → economy) |

### Faxina P0 (2026-09-11) — mortos + wire dice

- Removidos resolvers mortos Psi/Soulknife (`combat/domain/*/table-actions` só BM+dungeoneer).
- Removidos DTOs órfãos (`UsePsiWarrior*`, `UseBattleMasterManeuverDto`, Second Wind/Tactical Mind DTOs de session).
- Removida cadeia session `applySecondWind` / `applyActionSurge` / `applyTacticalMind` (duel mantém os próprios).
- Removido `divineSparkDice` (SSOT = fórmula effect).
- Dice: `roll-saving-throw` / `build-attack-advantage` passam pelos helpers `has*` (Slippery Mind, Diamond Soul, Evasion, Studied Attacks, Door Kick, Indomitable, Assassin mobile aim).

### Escopo notes (fechado)

Aggregate de classe só lê `filterLevelCombatNotes`. Sem `*CombatNotes` de classe no motor.

### Mesa — handlers `switch` (dívida alta)

**Hoje:** quase toda classe em `session/application/actions/*/…handler.ts` roteia slug→função TS; o `default` já cai em `applyDeclaredEconomyTableAction` (SSOT SQL). Referência boa: `monster-hunter-actions.handler.ts` (quase só economy).

**Critério — pode virar só economy (+ effect opcional)**

- Gasta recurso fixo / recupera recurso / devolve nota de mesa
- Sem toggle de flag de combate, sem input extra além do slug
- Sem side-effect fora de `CharacterStateRepository` + `phb_effect` (`temp_hp` / `heal` / `table_note`)
- Exemplos candidatos: presença zelosa “só gasta e nota”, restore de recurso 1/descanso, várias ações GH já seedadas em economy que ainda têm case duplicado no switch

**Critério — permanece handler custom (motor TS)**

| Tipo | Por quê | Exemplos |
| --- | --- | --- |
| Toggle / estado de combate | Mutação de flags (`rageActive`, reckless, starry form…) | `toggle-rage`, `toggle-reckless` |
| Input estruturado | DTO além do slug (dados, máscaras, manobra, companion command) | `champion-of-the-gods` + `diceCount`, `use-maneuver`, `set-persona-masks` |
| Rolagem / cálculo vivo | Dice + mods / CD / escolha de alvo | BI com roll, protective field, soulknife |
| Companheiro / sync actor | Orquestra `SyncCharacterCompanionHandler` + dataSource | `primal-companion-*`, `shape-of-the-wild` |
| Conversão / multi-recurso | Lógica que não cabe em `alwaysSpendsResource` | slot↔sorcery points, arcane recovery N |

**Onda sugerida:** 1 classe piloto (bárbaro ou fighter) — inventariar cases vs rows em `phb_class_economy_action`; remover do switch o que já tem row equivalente; expandir `executeCatalogEffect` só se faltar kind. Não misturar com schedules/gates.

**Piloto bárbaro (fechado):** handler sem `switch` — só `applyDeclaredEconomyTableAction` + kinds genéricos (`toggle_combat_flag`, `table_roll`, `feature_dc`, `heal_from_dice_pool`, `sync_companion`, `companion_command`, `recover_resource*`). Seed `phb_effect.barbarian-mesa.sql`.

**Onda guerreiro (fechada):** handler POST = só `applyDeclaredEconomyTableAction` (kinds tipados inclusos). Economy BM: **um** botão `use-maneuver` (sem rows `fighter-bm-*` lembrete). GET `listBattleMasterManeuvers` = picker read-model, não switch de apply. Seed `phb_effect.fighter-mesa.sql`.

**Onda clérigo (fechada):** handler POST = só `applyDeclaredEconomyTableAction`. Seed `phb_effect.cleric-mesa.sql` (spark/preserve/fulminar/warding + notes de domínio).

**Onda paladino (fechada):** handler POST = só `applyDeclaredEconomyTableAction` (+ `amount` para Mãos Consagradas). Seed `phb_effect.paladin-mesa.sql` (lay-on-hands/cure-poison/channel/juramentos).

**Onda bardo (fechada):** handler POST = só `applyDeclaredEconomyTableAction` (+ `masks` via kind `set_tracker`). Seed `phb_effect.bard-mesa.sql` (BI/colégios/Bragi). Gate `equipped_persona_mask` no apply para ações de máscara.

**Onda patrulheiro (fechada):** handler POST = só `applyDeclaredEconomyTableAction` (+ companion deps). Seed `phb_effect.ranger-mesa.sql`. Outliers: `set-bestial-aspect` (`set_tracker` + `level`), `feral-howl` (roll + patch aspecto), `start_concentration` (Marca gratuita).

**Onda monge (fechada):** handler POST = só `applyDeclaredEconomyTableAction`. Seed `phb_effect.monk-mesa.sql` (~23 cases). Outlier: `hand-of-ultimate-mercy` (`spend_resource` 5 Foco + heal 4d10 + note).

**Onda bruxo/mago (fechada):** handlers POST = `applyDeclaredEconomyTableAction`. Seeds `phb_effect.warlock-mesa.sql`, `phb_effect.wizard-mesa.sql`. Wire `recover_spell_slot`, `heal_from_dice_pool` (Luz Medicinal). Kinds: `bind_pact_weapon`, `missile_mage_arm`.

**Onda ladino (fechada):** handler POST = `applyDeclaredEconomyTableAction`. Seed `phb_effect.rogue-mesa.sql`. Soulknife: `check_boost` + free/paid psi (`usePsiDie`); kind `psychic_blade_attack`.

**Onda feiticeiro (fechada):** handler POST = `applyDeclaredEconomyTableAction`. Seed `phb_effect.sorcerer-mesa.sql`. Fonte de Magia via slug; `use-metamagic` → catálogo DB; kind `resource_fallback_spend` (innate/dragon-wings).

**Onda pistoleiro (fechada):** handler POST = `applyDeclaredEconomyTableAction` (default economy wired). Seed `phb_effect.gunslinger-mesa.sql`. `use-maneuver`/`recover-risk`/`reload-firearm`/`fire-chamber`.

**Onda druida (fechada):** handler POST = `applyDeclaredEconomyTableAction`. Seed `phb_effect.druid-mesa.sql`. Forma Estelada state machine tipada; `natural-recovery-*` → `recover_spell_slot`. Kinds: `moon_combat_wild_shape`, `restore_resource_from_slot`.

**Outliers mesa → kinds tipados (2026-09-11):** `missile_mage_arm`, `resource_fallback_spend`, `moon_combat_wild_shape`, `restore_resource_from_slot`, `bind_pact_weapon`, `psychic_blade_attack` — structured apply antes de `resolveSpendPlan`. Handlers classe = zero `if (actionSlug)`. Gunslinger non-class feat path (`reload-firearm`/`fire-chamber`) permanece no handler.

### Gates `has*` vs schedule (dívida média) — **onda gates fechada 2026-09-11**

- Tabela nova: `phb_class_feature_gate` (class_id, gate_key, unlock_level).
- Seeds: `phb_class.feature-gate.all.sql` + `phb_subclass.feature-gate.wave.sql` (door_kick, assassin_mobile_aim, divine_fury, psychic_blades).
- Catálogo mecânico: `featureGatesByClassSlug` + `featureGatesBySubclassSlug`.
- Predicados: `meetsFeatureGate` / `unlockFromGates` em `combat/domain/feature-gates.ts`; `has*(level, unlockLevel)`.
- Callers (dice, duel, combat slice, weapon attacks) leem unlock do catálogo — sem `level >= N` nos helpers.

**Schedules menores (fechado 2026-09-12):** seed `phb_class_feature_schedule.wave4.sql` — divine strike/spark, radiant strikes, aura range, persona masks, portent. Helpers exigem `bands`; effect amount usa `scheduleCount`.

## Reorganização session/application/core (2026-09-11)

Nova estrutura pós-consolidação de table actions:

```
session/application/
  session-commands/          # Nest handlers (cast, state, rest, resources)
  table-actions/
    apply-declared-economy/  # orquestrador fatiado (≤200 linhas/arquivo)
    kinds/
      martial/               # maneuver, check_boost, strike_self_cost, gunslinger
      caster/                # metamagic, convert, sorcerer-fallback, missile, pact
      form-state/            # starry, wild-resurgence, bestial, masks
      attack/                # psychic_blade
    primitives/              # heal, temp HP, guards, circumstances
    feat/                    # feat economy actions
```

- `core/` removida; imports atualizados (controller → `session-commands`).
- DTO unificado: `dto/table-actions/table-action-options.dto.ts`.
- Early-route kinds: migration `20260911_phb_effect_early_route_kinds.sql` + seeds sorcerer/gunslinger/druid mesa.
- `effects/domain/execute/` — executeCatalogEffect fatiado (resource/table/structured + facade).
- Specs: fixtures `CatalogEffect` com `combatFlag`/`companion` null.

## Reorganização `src/entities` por domínio (2026-09-11)

```
src/entities/
  effect/              # PhbEffect + satélites
  class/               # class-ref, feature, progression, metamagic, …
  subclass-feature/    # subclass-ref, gates, manobras, masks, …
  species/ heritage/ equipment/ spell/ feat/
  companion/ template/ reference/
  views/               # ViewEntity (inalterado flat)
```

- Alias: `@entities/<domínio>/phb-….entity` (tsconfig/jest já resolvem `*` em profundidade).
- TypeORM: `autoLoadEntities` — sem glob; módulos `forFeature` atualizados via imports.

## Padrão do piloto (repetir)

1. Schema SSOT + migration forward
2. Seed no `SEED_ORDER` após owners
3. Query Catalog + predicado puro
4. Remover Record/slug gates do Game
