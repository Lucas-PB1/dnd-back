# log

## 2026-09-11 — bootstrap bundle

- Criado bundle OKF de preparação (inventory, module-map, waves).
- Rules: `game-folder-conventions`, `catalog-sql-first`, `file-size`.
- Skill projeto: `catalog-sql-first`.
- Command: `/legado`.

## 2026-09-11 — /legado `src/game/companion/`

| path | status | ação | evidência |
| --- | --- | --- | --- |
| `domain/companion-profiles.ts` | vivo | manter; doc em game-module-structure | `actor/.../sync-character-companion.handler.ts` |
| `domain/companion-commands.ts` | vivo | manter | `session/.../companion-table-actions.ts` |
| `domain/companion-profiles.spec.ts` | só teste | manter | spec do profiles |

Conclusão: **não remover**. Sem `*.module.ts` de propósito (domain library). Candidato a mover sob `actor/domain/` numa onda de tidy — não urgente.

## 2026-09-11 — Onda 2 piloto: fighting_style_unlock_level

- Schema: `database/schema/020_tables/0017_phb_class.sql` (+ coluna nullable).
- Migration forward: `database/migrations/20260911_phb_class_fighting_style_unlock_level.sql`.
- Seed: `database/seeds/class/phb/phb_class.fighting-style-unlock.sql` (após monster-hunter no `SEED_ORDER`).
- Game: `resolveFightingStyleUnlockLevel` + predicado puro `classHasFightingStylePick(unlock, level)` — sem Record de slugs.
- Docs: [sql-first-audit.md](/sql-first-audit.md); waves-plan atualizado.

## 2026-09-11 — Onda 2: asi_or_feat em progression

- Schema: `database/schema/020_tables/0034_phb_class_progression.sql` (+ `asi_or_feat`).
- Migration forward: `database/migrations/20260911_phb_class_progression_asi_or_feat.sql`.
- Seed: `database/seeds/class/phb/phb_class_progression.asi-or-feat.sql` (base 4/8/12/16/19; fighter +6/14; rogue +10).
- Game: `loadAsiOrFeatLevels` + predicados puros sem Record de slugs; level-up preview/handler async.

## 2026-09-11 — Onda 2: expertise slots em option_def

- Seed: `database/seeds/class/phb/phb_class.expertise-option.sql` (rogue/bard/ranger/wizard + whitelist sábio).
- Migration forward: `database/migrations/20260911_phb_class_expertise_option.sql`.
- Game: `loadClassExpertiseSlots` / `loadExpertiseSkillWhitelist`; predicados puros; feature options excluem `expertiseSkill*`.
- Jack of All Trades permanece em TS (dívida).

## 2026-09-11 — Onda 2: Jack of All Trades + companion profiles

- Jack: coluna `jack_of_all_trades_level` + seed bard=2; mapper passa unlock para `computeDerivedStats`.
- Companion: `phb_companion_profile` + `phb_companion_template_map` (JSONB option_matches → template/label).
- Game: queries async; `resolveCompanionConfig(profile, maps, options)` puro.

## 2026-09-11 — Onda 2: Manikin AC + ancestry damage

- Tabela `phb_species_armor_preset` (fórmulas CA Manikin).
- `option_value.damage_type` normalizado para slug EN (dragonborn + tiefling).
- Game: `computeSpeciesArmorPreset` + `loadSpeciesOptionDamageTypes`; sem Records de ancestry.

## 2026-09-11 — Onda 2: initiative / bloodhound / companion / GH notes

- `phb_initiative_rule` — bônus de atributo e vantagem de iniciativa.
- `phb_subclass_feature_gate` — gates L7/L10/L15 do Sabujo.
- `phb_companion_command` — labels PT dos comandos de mesa.
- `phb_level_combat_note` — notas GH Cap.2 por nível.
- Game: predicados puros + load no mechanical catalog / combat slice / roll initiative.

## 2026-09-11 — Onda 2: Northlands/PHB notes + damage_type

- Seeds Northlands (36) + packs estáticos (gunslinger, sorcerer, barb/monk/paladin subclass).
- Tabela `phb_damage_type` (slug → label_pt); `speciesPassiveNotesFromEffects` lê o mapa.
- Aggregate usa só `filterLevelCombatNotes` do catálogo para textos estáticos.

## 2026-09-11 — Onda 2: remaining static PHB notes

- +165 literais (fighter/rogue/ranger/warlock/wizard/cleric/bard/druid).
- Funções *CombatNotes* só emitem templates dinâmicos (`${}`, schedules, ternários).
- Total `phb_level_combat_note` local ≈ 356 linhas.

## 2026-09-11 — Onda 2: class notes bárbaro/monge/paladino

- +26 literais de classe em `phb_level_combat_note.barb-monk-paladin-class.sql`.
- Depois: ex-templates dinâmicos viraram literais (+5); removidos `*CombatNotes` BMP.
- Números vivos ficam no motor (ataque, velocidade, `savingThrowAuraBonus`); Fúria ativa não vira nota.

## 2026-09-11 — Onda 2: remaining dynamic notes → static

- +25 literais (`remaining-dynamic-as-static`); aggregate só usa `filterLevelCombatNotes`.
- Removidos *CombatNotes* de fighter/rogue/ranger/cleric/bard/warlock/druid/wizard.
- **Onda notes fechada.**

## 2026-09-11 — Onda 2: piloto `phb_class_feature_schedule`

- Tabela EAV nível→`value_num` (class/subclass + `feature_key`).
- Seed piloto: `attacks_per_action` (fighter/monk/paladin/ranger), `martial_arts_die_faces`, `unarmored_speed_bonus_m` (monk).
- Predicado `scheduleValueAtLevel`; load no combat slice + mechanical catalog.
- Fallbacks TS só se `bands` omitido (callers legados).

## 2026-09-11 — Onda 2: `phb_class_feature_schedule` wave2

- Seed/migration: sneak, BI faces, rage bonus, indomitable, superiority, psi (psi-warrior+soulknife), champion crit, zealot heal.
- Regras aceitam `bands`; combat slice carrega classe+subclasse; catalog expõe `featureSchedulesBySubclassSlug`.
- Fallbacks TS mantidos para callers sem bands (session resources, actions).

## 2026-09-11 — Onda 2: feature schedule sem legado

- Wave3: brutal strike, gunslinger crit, warlock pact level/count + invocations, sorcerer metamagic.
- `bands`/`featureSchedules` **obrigatórios** nas rules; removidos fallbacks nível→valor em TS.
- Callers: weapon context, session actions, dice, validators, resources; fixtures no harness.
- Channel/Focus/Wild Shape continuam em progression/`grant_resource` (sem duplicar).

## 2026-09-11 — Dívida: handlers mesa `switch(actionSlug)`

- Registrado como **alta** em [sql-first-audit.md](/sql-first-audit.md): quase toda classe ainda roteia slug→TS; `default` já usa economy.
- Critério: economy-only (spend/nota/effect) vs custom (toggle, DTO extra, roll vivo, companion, conversão).
- Piloto sugerido: bárbaro ou fighter; referência `monster-hunter-actions.handler.ts`.

## 2026-09-11 — Dívida: gates `has*` ≠ schedule

- Documentado em audit § Gates: schedule = nível→`value_num`; `has*` = unlock booleano → `phb_subclass_feature_gate` / gate de classe.
- Não misturar com schedule; TS ok até a onda de gates.

## 2026-09-11 — Piloto mesa: bárbaro → economy

- Removidos 6 cases note/spend-only do switch (`retaliation`, `zealous-presence`, `rage-of-the-gods`, `traverse-the-tree`, `magic-missile-throws`, `shield-block`).
- Handlers TS mortos apagados; specs cobrem rota economy.

## 2026-09-11 — Economy spend→recover + mais cases fora do switch

- Schema/migration: `recover_resource_slug` + `recover_amount` em `phb_class_economy_action` (view/MV/entity).
- `applyDeclaredEconomyTableAction` recupera pool após spend.
- Fora do switch: bárbaro restores (intimidating/zealous/shape-of-the-wild); monge `recover-knockout`; feiticeiro `restore-balance`.
- Monge `default` → economy (antes BadRequest).

## 2026-09-11 — Mesa alinhada a talentos: economy + `recover_resource`

- Kind `recover_resource` no motor `phb_effect` (dicionário + execute + feat/declared apply).
- Removidas colunas recover_* da economy; gasto continua nas colunas do botão.
- Seed `phb_effect.mesa-recover.sql` (bárbaro restores, K.O., red-renewal).
- Handlers barb/monk/sorc passam `effectCatalog` no `default` economy.

## 2026-09-11 — Piloto bárbaro fechado (switch zero)

- Kinds: `toggle_combat_flag`, `sync_companion`, `companion_command`, `table_roll`, `recover_resource_to_max` (+ wire `feature_dc` / `heal_from_dice_pool`).
- `BarbarianActionsHandler` só access + `applyDeclaredEconomyTableAction`.
- Seed `phb_effect.barbarian-mesa.sql`; resolvers TS de base/subclass apagados.

## 2026-09-11 — Rename apply* (sem retrocompat resolve)

- Runners: `applyDeclaredEconomyTableAction` / `applyFeatEconomyTableAction` (arquivos `apply-*-economy-table-action.ts`).
- Helpers de kind: `applyCompanionSummon` / `applyCompanionCommand`.
- Pasta vazia `barbarian/subclass-actions` removida; dívida por slug continua só nas outras classes.

## 2026-09-11 — Onda guerreiro (mesa parcial)

- Fórmula `dice_1d10_plus_level`; wire `heal` no apply declarado; filtro unlock/subclass em effects.
- Seed `phb_effect.fighter-mesa.sql`; `alwaysSpends` em second-wind / action-surge.
- Fora do switch: `second-wind`, `action-surge`, `psi:mental-guard`. Dívida: mind / manobra / precaução / blood / psi free-paid.

## 2026-09-11 — Guerreiro switch zero (dívida tipada)

- Kinds: `check_boost`, `catalog_maneuver`, `strike_self_cost`; fórmula `schedule_die_plus_flat`.
- Apply: free_resource + `usePsiDie`; options tipadas; `spellSlug` precaução.
- `FighterActionsHandler` só access + apply (+ GET manobras). Resolvers tipados mortos removidos.

## 2026-09-11 — Clérigo mesa fechado (switch zero)

- Seed `phb_effect.cleric-mesa.sql`; fórmulas `level_times_5`, `dice_divine_spark_plus_flat`, `ability_mod_d8`, `dice_2d6_plus_flat`, `dice_2d10_plus_level`.
- Apply: castingMod (WIS/CHA/INT) para flatOverride de casters; `{saveDc}` em table_roll; table_roll com fórmula completa sem dice.
- `ClericActionsHandler` só `applyDeclaredEconomyTableAction`. Resolvers base/subclass removidos.

## 2026-09-11 — Paladino e Bardo mesa fechados (switch zero)

- Seeds `phb_effect.paladin-mesa.sql`, `phb_effect.bard-mesa.sql`; economy `cure-poison`, `set-persona-masks`.
- Apply: `amount` override (Mãos Consagradas/heal); `schedule_die_*` com faces BI; kind `set_tracker` (máscaras); wire `survive_at_zero`; gate `equipped_persona_mask`.
- Handlers POST = só `applyDeclaredEconomyTableAction`. Resolvers paladino/bardo removidos.

## 2026-09-11 — Patrulheiro e Monge mesa fechados (switch zero)

- Seeds `phb_effect.ranger-mesa.sql`, `phb_effect.monk-mesa.sql`; economy fixes (`alwaysSpends` foco/usos).
- Apply: `start_concentration`, `spend_resource`, `dice_2d/3d_schedule`, faces MA no schedule; `set_tracker` → Aspecto Bestial; `feral-howl` pós-roll.
- Handlers POST = só `applyDeclaredEconomyTableAction` (+ companion deps patrulheiro). Resolvers ranger/monk removidos.

## 2026-09-11 — Bruxo e Mago mesa fechados (switch mínimo)

- Seeds `phb_effect.warlock-mesa.sql`, `phb_effect.wizard-mesa.sql`; wire `recover_spell_slot`; fórmulas `pact_slots_recovery_count`, `portent_d20_count`.
- Apply: pact slot schedule (Astúcia Mágica); cura em `healing-light`; ward INT mín. 1.
- Outliers: `invoke-pact-weapon` (inventário); arm/disarm mísseis (`setMissileMageArmedFlags`).

## 2026-09-11 — Ladino, Feiticeiro, Pistoleiro e Druida mesa fechados

- Seeds `phb_effect.rogue-mesa.sql`, `phb_effect.sorcerer-mesa.sql`, `phb_effect.gunslinger-mesa.sql`, `phb_effect.druid-mesa.sql`.
- Apply: `check_boost` com dado psi (schedule); `convert_spell_points` via slug; `catalog_metamagic`; manobras/tiros pistoleiro; Forma Estelada / Ressurgimento Selvagem tipados.
- Handlers POST = `applyDeclaredEconomyTableAction` (+ outliers mínimos). Resolvers mortos removidos.
- Outliers: Lâmina Psíquica (ataque); Feitiçaria Inata/Asas de Dragão (fallback SP); Lua combate + Restaurar Passo Lunar.

## 2026-09-11 — Outliers mesa → kinds tipados

- Migration `20260911_phb_effect_outlier_kinds.sql`: 6 kinds + economy rows (arm/disarm mísseis, invoke-pact, psychic-blade, moon-combat, arcane-recovery 1–5, spell-mastery, fiendish-resilience).
- Seeds mesa: `missile_mage_arm`, `resource_fallback_spend`, `moon_combat_wild_shape`, `restore_resource_from_slot`, `bind_pact_weapon`, `psychic_blade_attack`.
- Apply structured dispatch **antes** de `resolveSpendPlan` (innate/dragon-wings não gastam pool errado).
- Handlers wizard/sorcerer/druid/warlock/rogue = só `applyDeclaredEconomyTableAction` (+ deps inventário warlock).
- Gunslinger feat path (reload/fire-chamber sem classe) mantido no handler.

## 2026-09-11 — Reorganização session/application/core

- Nova estrutura:
  - `session-commands/` — Nest handlers + spend side-effects (cast-spell, get/patch-state, rest, resource handlers).
  - `table-actions/primitives/` — heal, temp HP, guards.
  - `table-actions/feat/` — feat economy.
  - `table-actions/kinds/{martial,caster,form-state,attack}/` — applies tipados.
  - `table-actions/apply-declared-economy/` — orquestrador fatiado (produção ≤200 linhas/arquivo).
- Pasta `core/` removida; controller/module/handlers apontam para `session-commands` / `table-actions`.
- DTO: `TableActionOptionsDto` compartilhado; classes estendem o bag (incl. barbarian/feat/MH/transformation).
- SQL: migration `20260911_phb_effect_early_route_kinds.sql` (`convert_spell_points`, `catalog_metamagic`, `firearm_*`, `wild_resurgence`, `set_starry_form`); seeds mesa alinhados; early-routes = só validações.
- `effects/domain/execute/` — executeCatalogEffect fatiado; reexport estável via `domain/execute-catalog-effect`.
- Jest: 26 suites / 193 testes verdes (`session/application` + `effects/domain`).
