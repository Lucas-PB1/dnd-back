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

## Dívida restante

| Prioridade | Achado | Casa sugerida |
| --- | --- | --- |
| alta | Handlers de mesa com `switch (actionSlug)` por classe | `phb_class_economy_action` + `applyDeclaredEconomyTableAction` (+ effects `on_table_action`) |
| média | Gates booleanos (`hasAuraOfProtection`, `hasSlipperyMind`, `hasTacticalMind`…) | `phb_subclass_feature_gate` / feature_gate de classe |
| média | Schedules menores restantes (divine strike, masks, portent…) | mesmo `phb_class_feature_schedule` |
| baixa | Transformation Cap.6 / heritage notes | outro SSOT (já separado) |
| — | Fórmulas com mod/estado (`rageActive`, CD, smite por slot, magical cunning ceil) | **manter TS** |
| — | Channel Divinity / Focus (ki) / Wild Shape usos | já em progression / grant_resource — **não** duplicar |

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

**Onda bruxo/mago (fechada):** handlers POST = `applyDeclaredEconomyTableAction` (+ outlier inventário/mísseis). Seeds `phb_effect.warlock-mesa.sql`, `phb_effect.wizard-mesa.sql`. Wire `recover_spell_slot`, `heal_from_dice_pool` (Luz Medicinal). Outliers: `invoke-pact-weapon`, arm/disarm Escudo/Giga-Míssil.

**Onda ladino (fechada):** handler POST = `applyDeclaredEconomyTableAction` (+ Lâmina Psíquica). Seed `phb_effect.rogue-mesa.sql`. Soulknife: `check_boost` + free/paid psi (`usePsiDie`); subclasses `table_note`/`feature_dc`.

**Onda feiticeiro (fechada):** handler POST = `applyDeclaredEconomyTableAction` (+ Feitiçaria Inata/Asas fallback SP). Seed `phb_effect.sorcerer-mesa.sql`. Fonte de Magia via slug; `use-metamagic` → catálogo DB.

**Onda pistoleiro (fechada):** handler POST = `applyDeclaredEconomyTableAction` (default economy wired). Seed `phb_effect.gunslinger-mesa.sql`. `use-maneuver`/`recover-risk`/`reload-firearm`/`fire-chamber`.

**Onda druida (fechada):** handler POST = `applyDeclaredEconomyTableAction` (+ Lua combate, Restaurar Passo Lunar). Seed `phb_effect.druid-mesa.sql`. Forma Estelada state machine tipada; `natural-recovery-*` → `recover_spell_slot`.

### Gates `has*` vs schedule (dívida média)

`phb_class_feature_schedule` é **nível→número** (`value_num`: ataques, faces de dado, usos, limiares…).

Funções `hasStudiedAttacks` / `hasTacticalMind` / `hasAuraOfProtection` / `hasSlipperyMind` etc. são só **“desbloqueou no nível X?”** (booleano). Casa natural: `phb_subclass_feature_gate` ou equivalente de **classe** — o mesmo padrão já usado no Sabujo (`phb_subclass_feature_gate`).

- **Não** misturar gates com schedule (não inventar `value_num` 0/1 como SSOT de unlock).
- Por enquanto deixar em TS está ok; migrar gates é **próxima onda** após (ou em paralelo a) limpar handlers mesa, sem acoplar às waves de schedule.

Exemplos vivos em TS: `fighter/features/rules.ts` (`hasTactical*`, `hasStudiedAttacks`), paladin aura, rogue slippery mind, gates similares em outras classes.

## Padrão do piloto (repetir)

1. Schema SSOT + migration forward
2. Seed no `SEED_ORDER` após owners
3. Query Catalog + predicado puro
4. Remover Record/slug gates do Game
