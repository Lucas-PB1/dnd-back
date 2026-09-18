# log

## 2026-09-18 — LEGAC-2 seeds stub Grants legado

* **Update** (13:55 UTC): removidos 16 seeds no-op (`SELECT 1` / “Grants legado aposentado” / placeholders heritage GH) do disco e do `SEED_ORDER`; defs/grants vivos (DMG/Valdas/GSB) mantidos. `db:validate:sequences` ainda falha por dívidas pré-existentes (ON CONFLICT / DELETE / domain `notes`) — fora deste pacote.

| path | status | ação |
|------|--------|------|
| `feat/**/phb_feat.resource*.sql` stubs | morto | DELETE + order |
| `item/phb/phb_item.resource-grant.sql` | morto | DELETE + order |
| `item/dmg/...recover-dice.sql` | morto | DELETE + order |
| `species/phb/...resource-grant.sql` | morto | DELETE + order |
| `subclass/phb/phb_subclass.resource.sql` | morto | DELETE + order |
| `economy/**` modifier/resource stubs | morto | DELETE + order |
| `species/grim-hollow/phb_species.heritage*.sql` | morto | DELETE + order |
| `heritage/...mechanics-core.sql` | morto | DELETE + order |
| `item/dmg/phb_item.resource-grant-*.sql` (INSERT) | vivo | manter |

— refs: [`SEED_ORDER.txt`](../../database/seeds/SEED_ORDER.txt), [`legac-pattern-backlog.md`](../plans/legac-pattern-backlog.md) — motivo: fechar LEGAC-2 sem tocar seeds de `phb_resource_definition` reais.

## 2026-09-18 — LEGAC-1 inventário + docs stale

* **Update** (13:40 UTC): inventário `legacy|legado|legac` em docs/src/scripts; architecture já tratava dual-read como DROP; polish de prosa; links mortos `source/extracts/mm/no-image*` no log → `catalog-images.md`.

| kind | ~hits | ação |
|------|-------|------|
| canônico (`infernal_legacy`, `legacy_2014`) | 17 | manter |
| trilha LEG / planos | 47 | OK (backlogs) |
| histórico OKF / “fechado” | 24 | OK |
| dívida docs (mapa/dual-read “vivo”) | 0 em architecture | confirmado; planos LEGAC só |
| dívida scripts `legacy*` | 11 | → LEGAC-3 |
| seeds “Grants legado aposentado” | vários | → LEGAC-2 |

| path | status | ação |
|------|--------|------|
| `effect-dictionary` “mapa TS legado” | prosa | → “sem hardcode de slug” |
| `adr-effect-engine` “convívio dual-read” | prosa | → histórico / DROP |
| `code-standards` § Legado | stale | aponta LEG fechado + LEGAC |
| `okf/log` no-image*.md | link morto | → `catalog-images.md` |

— refs: [`legac-pattern-backlog.md`](../plans/legac-pattern-backlog.md), [`effect-dictionary.md`](../architecture/effect-dictionary.md), [`adr-effect-engine.md`](../architecture/adr-effect-engine.md) — motivo: fechar LEGAC-1 sem tocar seeds/scripts.

## 2026-09-18 — LEG-4 session + docs planos

* **Update** (13:25 UTC): `/legado` LEG-4 — `session/application` barrels/helpers **zero mortos**; apagados planos PVE-7b/8 (`Status: feito`); `mm-cast-options-modal` status corrigido (adiado); links quebrados de skills/paths em architecture + source DMG.

| path | status | ação | evidência |
|------|--------|------|-----------|
| `session/application/**/index.ts` | vivo | — | 10 barrels; 0 exports mortos |
| `session/application/**` (non-index) | vivo | — | 0 arquivos órfãos |
| `plans/pve-7b-spiritual-conjure.md` | feito | DELETE | índice PVE já ~~feito~~ |
| `plans/pve-8-surface-parity.md` | feito | DELETE | índice PVE já ~~feito~~ |
| `plans/mm-cast-options-modal.md` | adiado | status | backlog ainda `[ ]` |
| `architecture/*` skill links | errado | apontar `catalog-sql-first` | skills antigas inexistentes no repo |
| `okf/log` extracts MM | residual | → LEGAC-1 | links históricos `source/extracts/mm/no-image*` |

— refs: [`legado-cleanup-backlog.md`](../plans/legado-cleanup-backlog.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: fechar trilha LEG; residual docs stale em LEGAC.

## 2026-09-18 — LEG-3 entities + catalog

* **Update** (13:15 UTC): `/legado` em `src/entities/` — 4 entities sem `forFeature` registradas nos módulos consumidores; vercel trace alinhado (table-roll/temp-hp/affinity). Catalog queries: zero órfãs. Game→`@catalog/.../domain`: zero.

| path | status | ação | evidência |
|------|--------|------|-----------|
| `PhbInitiativeRule` | vivo (raw SQL) | `forFeature` sheet | `initiative-rule.queries` |
| `PhbCreatureTemplateDamageAffinity` | vivo (raw SQL) | `forFeature` combat | `load-creature-damage-defenses` |
| `PhbWildShapeCrBand` | vivo (raw SQL) | `forFeature` session | `wild-shape.queries` |
| `PhbWildShapeKnownBand` | vivo (seed; helper TS ainda) | `forFeature` session | tabela SSOT; `maxWildShapeKnownForms` residual |
| catalog `*.query.ts` | vivo | — | 0 classes sem import |
| Game `@catalog/*/domain` | — | N/A | 0 hits |

— refs: [`legado-cleanup-backlog.md`](../plans/legado-cleanup-backlog.md), [`character-sheet.module.ts`](../../src/game/sheet/character-sheet.module.ts), [`combat.module.ts`](../../src/game/combat/combat.module.ts), [`character-session.module.ts`](../../src/game/session/character-session.module.ts) — motivo: fechar LEG-3 sem apagar mapeamentos SQL-first.

## 2026-09-18 — LEG-2 / RES-2 combat domain trim

* **Update** (13:00 UTC): `/legado` em `combat/domain/<classe>/` — removidos helpers/consts mortos pós-economy (zero imports de produção); resolvers de mesa em `session/actions` já inexistentes; BM/`maneuver-resolve` vivos → RES-4.

| path | status | ação | evidência |
|------|--------|------|-----------|
| `druid/features` wrath/wickerbone/landAid/wildShapeMaxUses | morto | removidos | só defs/specs |
| `wizard` THIRD_EYE/SPECTRAL/ILLUSORY/SCULPT + ward/portent | morto | removidos | DTOs usam string literal |
| `bard` bardicInspiration* helpers | morto | removidos | economy usa schedule key |
| `bard` knownPersonaMaskCount | morto | removido | só teste; schedule key fica |
| `cleric` destroyUndead + divineSparkDiceCount fn | morto | removidos | schedule key vivo no loop |
| `sorcerer` SORCEROUS_RESTORATION_RESOURCE | morto | removido | zero import |
| `warlock` resource consts + healingLightDiceMax | morto | removidos | handlers usam slug string |
| `session/actions/**` class resolvers | morto | N/A | já zero pós-economy |
| `fighter` table-actions / BM on-hit | vivo | manter | → RES-4 |

— refs: [`legado-cleanup-backlog.md`](../plans/legado-cleanup-backlog.md), [`resolve-pattern-backlog.md`](../plans/resolve-pattern-backlog.md) — motivo: fechar LEG-2 + RES-2 sem tocar símbolos vivos de combat.

## 2026-09-18 — LEG-1 pastas Game sem module

* **Update** (12:45 UTC): `/legado` em `companion/` + `spirit/` — **zero mortos**; ambas domain libraries vivas. `module-map` e `game-module-structure` atualizados (companion não é “suspeita”; spirit documentado; skirmish listado).

| path | status | ação | evidência |
|------|--------|------|-----------|
| `src/game/companion/**` | vivo | documentar | session companion-table-actions + actor sync |
| `src/game/spirit/**` | vivo | documentar | actor.module SyncSpellSpirit + cast/rest/skirmish |
| demais pastas `src/game/` | vivo | — | todas têm `*.module.ts` |
| deletes TS | — | nenhum | sem órfãos seguros |

— refs: [`module-map.md`](module-map.md), [`game-module-structure.md`](../architecture/game-module-structure.md), [`legado-cleanup-backlog.md`](../plans/legado-cleanup-backlog.md) — motivo: fechar LEG-1 sem apagar código vivo.

## 2026-09-18 — PVE-10b /legado combat+duel + DoD 100%

* **Update** (12:30 UTC): pasta `duel`/`combat` — removidos `pending-arena-bridge.ts`, re-exports mortos em `duel-spell-resolve`, helpers órfãos `find/listSubclassTableAction`; `effect-dictionary` sem “mapa legado deprecated”; dual-read grants confirmado morto em `src/`. Índice PVE fechado.

| path | status | ação | evidência |
|------|--------|------|-----------|
| `duel/domain/pending-arena-bridge.ts` | morto | DELETE | nenhum importer |
| `duel/domain/duel-spell-resolve.ts` re-exports | morto | removidos | importers só usam `mergeConditions` / `assertValid…` |
| `combat/domain/catalog/subclass-table-action.ts` helpers | morto | removidos | type ainda vivo via catalog load |
| `effect-dictionary.md` combat_note | errado | texto catálogo-only | `featCombatNotes` → `combatNotesFromEffects` |
| dual-read grants | morto | confirmado | `rg` src sem `phb_resource_grant` / `phb_combat_modifier` |

— refs: [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md), [`backlog.md`](../plans/backlog.md), [`legado-cleanup-backlog.md`](../plans/legado-cleanup-backlog.md) — motivo: DoD 100% PVE + limpeza `/legado` do escopo pós-motor.

## 2026-09-18 — PVE-10a residuals skirmish

* **Update** (12:20 UTC): SW/AS via `POST …/table-actions` (economy); `pc_savage_attacker_used` 1×/turno; Parry em `resolveIncomingHit`; PAM reativo/craft = nunca; Ward/Spark/Gunslinger/PAM cabo/Bloodied = defer. — refs: [`skirmishes.controller.ts`](../../src/game/skirmish/skirmishes.controller.ts), [`resolve-incoming-hit.ts`](../../src/game/combat/domain/resolve-incoming-hit.ts), [`skirmish-residuals-pve-10a.md`](../architecture/skirmish-residuals-pve-10a.md), [`combat-real-deferred.md`](../plans/combat-real-deferred.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: residuals tipáveis sem mapa fechados; irredutíveis justificados.

## 2026-09-18 — PVE-9b slug branches apply tipados

* **Update** (12:00 UTC): `phb_effect_table_roll` (`result_scale` / `apply_bestial_aspect`) + `phb_effect_temp_hp` (slot→PV temp.); removidos `actionSlug ===` em `apply-one-effect-*` para Uivo Feral / Teleporte / Sussurros / Recarregar Proteção. Residual flat-override/early/structured listado no ADR. — refs: [`0169_phb_effect_table_roll.sql`](../../database/schema/020_tables/0169_phb_effect_table_roll.sql), [`0170_phb_effect_temp_hp.sql`](../../database/schema/020_tables/0170_phb_effect_temp_hp.sql), [`apply-one-effect-table.ts`](../../src/game/session/application/table-actions/apply-declared-economy/apply-one-effect-table.ts), [`adr-effect-engine.md`](../architecture/adr-effect-engine.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: features de mesa tipadas por satélite, sem hardcode de slug no apply.

## 2026-09-18 — PVE-9a Sacred Weapon toggle_combat_flag

* **Update** (11:55 UTC): `sacred_weapon` em `phb_effect_combat_flag`; Devoção liga/desliga via effect (sem hardcode `oath-channel` / early-route). — refs: [`0155_phb_effect_combat_flag.sql`](../../database/schema/020_tables/0155_phb_effect_combat_flag.sql), [`apply-one-effect.ts`](../../src/game/session/application/table-actions/apply-declared-economy/apply-one-effect.ts), [`phb_effect.paladin-mesa.sql`](../../database/seeds/effect/phb/phb_effect.paladin-mesa.sql), [`effect-dictionary.md`](../architecture/effect-dictionary.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: flag sticky de combate só pelo kind genérico + satélite.

## 2026-09-18 — PVE-8 paridade superfícies

* **Update** (11:40 UTC): `POST …/encounters/:id/cast` via `resolveCombatSpell`; docs sem “só 2 magias”; duelo aponta para catálogo `phb_spell_combat`. — refs: [`campaign-encounter-cast.service.ts`](../../src/game/campaign/application/campaign-encounter-cast.service.ts), [`surface-combat-parity.md`](../architecture/surface-combat-parity.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: MM/Fireball (e demais tipadas) nas 3 superfícies com o mesmo motor.

## 2026-09-18 — PVE-7b Arma Espiritual + Conjure 1-actor

* **Update** (11:30 UTC): `arma-espiritual` e `conjurar-animais` spawnam 1 companion no skirmish; removido one-shot de combate; `injectCasterDamageMod` para `NdX+0`. — refs: [`seed.spiritual-conjure.sql`](../../database/seeds/creature/phb/seed.spiritual-conjure.sql), [`inject-caster-damage-mod.ts`](../../src/game/spirit/domain/inject-caster-damage-mod.ts), [`spiritual-conjure-skirmish.md`](../architecture/spiritual-conjure-skirmish.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: efeitos flutuantes/auras jogáveis sem mapa nem N tokens.

## 2026-09-17 — PVE-7a spirits na iniciativa

* **Update** (22:50 UTC): Invocar Fera / companions entram na iniciativa do skirmish; turno automático aliado→foe; bônus de ataque do invocador; prune no break de concentração. — refs: [`skirmish-alliance.ts`](../../src/game/skirmish/domain/skirmish-alliance.ts), [`sync-allied-actors-into-skirmish.ts`](../../src/game/skirmish/application/sync-allied-actors-into-skirmish.ts), [`spirits-skirmish-initiative.md`](../architecture/spirits-skirmish-initiative.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: summons tipados na fila de turnos, não só nota de mesa.

## 2026-09-17 — PVE-6c resist/vuln/imune

* **Update** (22:35 UTC): `applyDamageTypeModifiers` + tabela `phb_creature_template_damage_affinity`; skirmish cast passa `damageTypeSlug`; imunidade zera / resist metade. Piloto Elemental do Fogo + Azer. — refs: [`apply-damage-type-modifiers.ts`](../../src/game/combat/domain/apply-damage-type-modifiers.ts), [`0168_phb_creature_template_damage_affinity.sql`](../../database/schema/020_tables/0168_phb_creature_template_damage_affinity.sql), [`damage-type-defenses.md`](../architecture/damage-type-defenses.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: dano tipado respeita afinidades do alvo no HP.

## 2026-09-17 — PVE-6b itens charges combate

* **Update** (22:20 UTC): `itemCastResourceSlug` / `itemCastSpendAmount` / `itemCastItemSlug` no cast skirmish/duelo; overrides CD/ataque do Treasure no resolve. Piloto Varinha de Mísseis → `auto_damage`. — refs: [`pick-combat-surface-cast-command.ts`](../../src/game/combat/application/pick-combat-surface-cast-command.ts), [`spell-combat-bonuses-from-cast.ts`](../../src/game/combat/application/spell-combat-bonuses-from-cast.ts), [`item-charge-combat.md`](../architecture/item-charge-combat.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: charges de item disparam o mesmo motor tipado de magia no combatente.

## 2026-09-17 — PVE-6a Metamagia + Eldritch Smite

* **Update** (22:10 UTC): `heightened-spell` / `seeking-spell` no `resolveCombatSpell` + gasto SP no cast skirmish/duelo; `eldritchSmite` no pipeline de dano (Nv8/círculo, invocação). Doc [`metamagic-eldritch-combat.md`](../architecture/metamagic-eldritch-combat.md). — refs: [`spend-combat-metamagic.ts`](../../src/game/combat/application/spend-combat-metamagic.ts), [`apply-warlock.ts`](../../src/game/dice/application/rolls/damage/apply-warlock.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: metamagia e smite de bruxo tipados no combate, não só nota de mesa.

## 2026-09-17 — PVE-5c estilos no roll

* **Update** (21:55 UTC): GWF 1–2→3 sem empilhar Elemental 1→2; TWF via effects + `fightingStyleSlugs`; Charger +1d8 gated (feat+melee); load `ownedFeatSlugs = feat ∪ style`. PAM residual PVE-10a. Specs + [`fighting-style-combat.md`](../architecture/fighting-style-combat.md). — refs: [`roll-weapon-context.ts`](../../src/game/dice/application/rolls/roll-weapon-context.ts), [`roll-damage.ts`](../../src/game/dice/application/rolls/roll-damage.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: estilos de combate tipados no path de dano skirmish/ficha.

## 2026-09-17 — PVE-5b Battle Master no acerto

* **Update** (21:45 UTC): `resolveBattleMasterOnHit` (trip / menacing / pushing); gasta `superiority-dice`; condição no alvo ou nota de empurrão; DTO `battleMasterManeuverSlug`. Specs. — refs: [`resolve-battle-master-on-hit.ts`](../../src/game/combat/domain/fighter/resolve-battle-master-on-hit.ts), [`apply-battle-master-maneuver.ts`](../../src/game/skirmish/application/apply-battle-master-maneuver.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: manobras BM tipadas no skirmish, não só nota de mesa.

## 2026-09-17 — PVE-5a DTO parity + smites

* **Update** (21:35 UTC): `CombatAttackFlagsDto` + `pickCombatAttackCommand`; skirmish/encontro estendem o DTO; Destruição Divina já gasta slot no roll. Doc [`combat-attack-flags.md`](../architecture/combat-attack-flags.md). — refs: [`combat-attack-flags.dto.ts`](../../src/game/combat/dto/combat-attack-flags.dto.ts), [`pick-combat-attack-command.ts`](../../src/game/combat/application/pick-combat-attack-command.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: front declara as mesmas flags do motor sem drift.

## 2026-09-17 — PVE-4b opportunity attack

* **Update** (21:25 UTC): Gate OA sem mapa; `pc_oa_available`; `POST /skirmishes/:id/react` (`opportunity_attack`); end-turn pausa no turno da criatura. Specs + Swagger. — refs: [`resolve-opportunity-attack-gate.ts`](../../src/game/skirmish/domain/resolve-opportunity-attack-gate.ts), [`skirmishes.controller.ts`](../../src/game/skirmish/skirmishes.controller.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: reação tipada de OA no skirmish sem grade.

## 2026-09-17 — PVE-4a incoming hit (Escudo / Uncanny)

* **Update** (21:20 UTC): `resolveIncomingHit` (+5 CA Escudo Arcano / metade Esquiva Sobrenatural); `pc_reaction_available` no skirmish; `POST end-turn` com `defenderReaction`; specs. — refs: [`resolve-incoming-hit.ts`](../../src/game/combat/domain/resolve-incoming-hit.ts), [`skirmish.service.ts`](../../src/game/skirmish/application/skirmish.service.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: reações de defesa tipadas no skirmish com CA/HP corretos.

## 2026-09-17 — PVE-3b arena + conditions

* **Update** (21:00 UTC): `arena_effects` no skirmish (paridade duelo); Escuridão altera visão/vantagem; `apply_condition` + seeds Paralisar Pessoa / Medo; specs. — refs: [`0166_skirmish.sql`](../../database/schema/020_tables/0166_skirmish.sql), [`phb_spell_combat.conditions.sql`](../../database/seeds/spell/phb/phb_spell_combat.conditions.sql), [`resolve-combat-spell.ts`](../../src/game/combat/domain/resolve-combat-spell.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: escuridão e condições tipadas no skirmish sem hardcode.

## 2026-09-17 — PVE-3a quebra de concentração

* **Update** (20:35 UTC): `resolveConcentrationCheck` (CD max(10, dano/2)); hook em `applyCombatantHpDamage` e `applyDuelDamageToTarget`; limpa concentração (+ espíritos via patch); Escuridão some da arena no duelo. Specs sucesso/falha. — refs: [`resolve-concentration-check.ts`](../../src/game/combat/domain/resolve-concentration-check.ts), [`apply-combatant-hp-damage.ts`](../../src/game/combat/application/apply-combatant-hp-damage.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: dano em concentrador quebra magia conforme PHB.

## 2026-09-17 — PVE-2b Nv 7–9 + auditoria

* **Update** (20:05 UTC): Seeds `level-7-9.sql` + `gaps-backfill.sql` → 102 rows combate; auditoria PHB: ~139 com dados, ~40 residual (smite/summon/condição/exploração). — refs: [`phb_spell_combat.level-7-9.sql`](../../database/seeds/spell/phb/phb_spell_combat.level-7-9.sql), [`spell-combat-audit.md`](../architecture/spell-combat-audit.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: fechar ofensivas de cast direto no skirmish e responder o gap residual.

## 2026-09-17 — PVE-2a magias Nv 4–6

* **Update** (19:50 UTC): Seed `phb_spell_combat.level-4-6.sql` (23 ofensivas/cura: Cone de Frio, Coluna de Chamas, Círculo da Morte, Corrente de Relâmpagos…); meta save/attack. Summons e smites-addon ficam fora. — refs: [`phb_spell_combat.level-4-6.sql`](../../database/seeds/spell/phb/phb_spell_combat.level-4-6.sql), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: magias médias tipadas no skirmish.

## 2026-09-17 — PVE-1c magias Nv 2–3

* **Update** (19:40 UTC): Seed `phb_spell_combat.level-2-3.sql` (21 magias: Bola de Fogo, Relâmpago, Despedaçar, Raio Ardente…); `auto_damage` usa `spell_level` na escala; meta save/attack. Condições puras (Paralisar Pessoa) ficam `slot_only` → PVE-3b. — refs: [`phb_spell_combat.level-2-3.sql`](../../database/seeds/spell/phb/phb_spell_combat.level-2-3.sql), [`resolve-combat-spell.ts`](../../src/game/combat/domain/resolve-combat-spell.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: ofensivas 2º–3º círculo tipadas no skirmish.

## 2026-09-17 — PVE-1b magias Nv 1

* **Update** (19:15 UTC): Colunas `dice_count_*` / `spell_level` / `include_spellcasting_mod`; seed `phb_spell_combat.level-1.sql` (cura, ataques e saves Nv 1 PHB). — refs: [`phb_spell_combat.level-1.sql`](../../database/seeds/spell/phb/phb_spell_combat.level-1.sql), [`resolve-combat-spell.ts`](../../src/game/combat/domain/resolve-combat-spell.ts), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: magias de 1º círculo tipadas no skirmish.

## 2026-09-17 — PVE-1a cantrips combate

* **Update** (18:55 UTC): Extensão `save_damage` / `heal_combatant` / `per_die_attack`; seed `phb_spell_combat.cantrips.sql` (16 ofensivos PHB); meta save/attack de cantrips; wire skirmish/duelo com CD e save do alvo. — refs: [`0167_phb_spell_combat.sql`](../../database/schema/020_tables/0167_phb_spell_combat.sql), [`phb_spell_combat.cantrips.sql`](../../database/seeds/spell/phb/phb_spell_combat.cantrips.sql), [`resolve-combat-spell.ts`](../../src/game/combat/domain/resolve-combat-spell.ts), [`spell-combat.md`](../architecture/spell-combat.md) — motivo: truques ofensivos tipados no skirmish sem hardcode.

## 2026-09-17 — PVE-0 motor magia combate (+ RES-3)

* **Update** (18:35 UTC): Tabela `rpg.phb_spell_combat` + seed piloto (MM, Raio de Fogo, Escuridão); `resolveCombatSpell` / `LoadSpellCombat`; skirmish+duelo sem hardcode de slug; docs `spell-combat.md` + links dicionário/read-path/data-model. Planos `pve-0` e `resolve-3` apagados. — refs: [`0167_phb_spell_combat.sql`](../../database/schema/020_tables/0167_phb_spell_combat.sql), [`resolve-combat-spell.ts`](../../src/game/combat/domain/resolve-combat-spell.ts), [`spell-combat.md`](../architecture/spell-combat.md), [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) — motivo: SSOT tipado para magia em arena sem if por slug.

## 2026-09-17 — QA-1 auditoria planos

* **Update** (18:20 UTC): Índice `pve-skirmish-index.md` — 45 links `.md` ok; 0 missing; 0 órfãos. DB-0 pacotes apagados pós-fechamento. — refs: [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md), [`quality-gate-backlog.md`](../plans/quality-gate-backlog.md) — motivo: validar fila gerada antes de seguir PVE.

## 2026-09-17 — DB-0 greenfield: fold + esvaziar migrations

* **Update** (18:05 UTC): Auditoria 53 migrations vs `database/schema/**` — enums/effects/kinds e quase todo DDL já estavam no CREATE; único drift de coluna: `sacred_weapon_active` → fold em `0129_player_character_state.sql` (entity já tinha). Colunas spirit/companion em template foram supersedidas por `0161_phb_creature_scale.sql` (migration intermediária ADD+DROP). Apagados todos `database/migrations/*.sql`; README política greenfield. Seeds disfarçados não precisaram mover (DML já em `database/seeds/`). — refs: [`0129_player_character_state.sql`](../../database/schema/020_tables/0129_player_character_state.sql), [`0161_phb_creature_scale.sql`](../../database/schema/020_tables/0161_phb_creature_scale.sql), [`sql-layout.md`](../architecture/sql-layout.md) — motivo: sem prod; histórico ALTER não agrega.

## 2026-09-16 — §H Item: charges, dawn MVP, poções de ficha

* **Update** (15:20 UTC): `POST …/item/table-action` gasta cargas de item ativo; poções de cura/heroísmo/saúde aplicam PV/PV temp./condições e consomem qty; DL já recarrega pools; cast de item já existia; arma/alvo e dawn real ficam fora — refs: [`apply-item-economy-table-action.ts`](../../src/game/session/application/table-actions/item/apply-item-economy-table-action.ts), [`phb_effect.item-mesa.sql`](../../database/seeds/effect/dmg/phb_effect.item-mesa.sql), [`item.routes.ts`](../../src/game/session/controllers/table-actions/item.routes.ts), [`backlog.md`](../plans/backlog.md) — motivo: economy de item sem rota de apply deixava charges e poções só como lembrete.

## 2026-09-16 — §N Magias / cast: apply de ficha

* **Update** (15:05 UTC): Slots, concentração e cast de item já existiam; Recordação reembolsa espaço 1–4 no 1d4; Curar Ferimentos / Palavra Curativa curam a ficha e Vitalidade Vazia dá PV temp. (ajuste se aliado); dano/alvo ficam no combate — refs: [`apply-cast-sheet-effects.ts`](../../src/game/session/infrastructure/character-state/spell/apply-cast-sheet-effects.ts), [`apply-slot-refund-on-cast.ts`](../../src/game/session/infrastructure/character-state/spell/apply-slot-refund-on-cast.ts), [`phb_effect.spell-mesa.sql`](../../database/seeds/effect/phb/phb_effect.spell-mesa.sql), [`backlog.md`](../plans/backlog.md) — motivo: o cast precisa fechar PV/slots na ficha, não só gastar espaço.

## 2026-09-16 — §B Classe: apply de ficha PHB

* **Update** (15:10 UTC): Pool de dados (Zelote/Celestial) cura na ficha; recarga da Proteção Arcana gasta slot e soma PV temp. (teto 2×nível+INT); Rally, Recuperar Fôlego, Mãos, Centelha, Incansável já aplicavam — refs: [`apply-one-effect-resources.ts`](../../src/game/session/application/table-actions/apply-declared-economy/apply-one-effect-resources.ts), [`phb_effect.wizard-mesa.sql`](../../database/seeds/effect/phb/phb_effect.wizard-mesa.sql), [`backlog.md`](../plans/backlog.md) — motivo: spend+nota não fecha mesa quando a regra mexe em PV/PV temp. na ficha.

## 2026-09-16 — §C Subclass: apply de ficha em packs

* **Update** (14:55 UTC): Table-actions de pack que curam/PV temp./recuperam pool/limpam Amedrontado na ficha; Caçador passa a carregar `phb_effect`; Escudo Mágico gasta Canalizar; dano/aliado/forma ficam no combate — refs: [`phb_effect.subclass-pack-mesa.sql`](../../database/seeds/effect/phb/phb_effect.subclass-pack-mesa.sql), [`monster-hunter-actions.handler.ts`](../../src/game/session/application/actions/monster-hunter/monster-hunter-actions.handler.ts), [`flat-override.ts`](../../src/game/session/application/table-actions/apply-declared-economy/flat-override.ts), [`backlog.md`](../plans/backlog.md) — motivo: spend+nota não fecha mesa quando a regra mexe em PV/pool na ficha.

## 2026-09-16 — §K Companheiro: tracker / summon / command

* **Update** (14:50 UTC): Tracker leve no estado da ficha e GET companions; sync/restore já existiam; command exige fera viva; dismiss remove o actor; Golpe da Fera e combate ficam fora — refs: [`companion-tracker.ts`](../../src/game/companion/domain/companion-tracker.ts), [`character-companions.controller.ts`](../../src/game/actor/controllers/character-companions.controller.ts), [`companion-table-actions.ts`](../../src/game/session/application/actions/shared/companion-table-actions.ts), [`backlog.md`](../plans/backlog.md) — motivo: mesa precisa ver PV da fera e comandar só declare, não o ataque.

## 2026-09-16 — §L Veículo: bundle, board, métrica

* **Update** (14:40 UTC): Estado ao vivo de tripulação/passageiros/carga no actor; PATCH + sheet-actions (board, métricas, leme); aríete/atropelo ficam no combate — refs: [`apply-vehicle-sheet-action.handler.ts`](../../src/game/actor/application/apply-vehicle-sheet-action.handler.ts), [`actor-state.dto.ts`](../../src/game/actor/dto/actor-state.dto.ts), [`20260916_game_actor_state_vehicle_metrics.sql`](../../database/migrations/20260916_game_actor_state_vehicle_metrics.sql), [`backlog.md`](../plans/backlog.md) — motivo: mesa precisa de ficha do veículo e ocupação, não de combate naval.

## 2026-09-16 — §J Montaria: template, board, ficha

* **Update** (14:25 UTC): Link/board de montaria; Vínculo Vital na cura da ficha; Toque Curativo 1/DL; declare Passo Feérico/Derrubar Brilho; spawn de Montaria Fantasmagórica no cast; 0 PV desmonta; dano na fantasma despawna; combate montado fica fora — refs: [`character-mounts.controller.ts`](../../src/game/actor/controllers/character-mounts.controller.ts), [`apply-mount-sheet-action.handler.ts`](../../src/game/actor/application/apply-mount-sheet-action.handler.ts), [`apply-heal-hit-points.ts`](../../src/game/session/application/table-actions/primitives/apply-heal-hit-points.ts), [`seed.phantom-steed.sql`](../../database/seeds/creature/phb/seed.phantom-steed.sql), [`backlog.md`](../plans/backlog.md) — motivo: mesa precisa de actor + estado de embarque e curas da ficha, não de combate montado.

## 2026-09-16 — §P Campanha / encontro: combatentes leves

* **Update** (14:20 UTC): DTO com PV temp. e tipo de actor; PATCH de temp HP/condições em criatura; incluir PC ligado e actor existente no board; combate simulado fica fora — refs: [`combatant-ops.ts`](../../src/game/campaign/application/campaign-encounter.service/combatant-ops.ts), [`campaign-encounters.controller.ts`](../../src/game/campaign/campaign-encounters.controller.ts), [`backlog.md`](../plans/backlog.md) — motivo: encontro de mesa precisa de roster e tracker, não de motor de acerto.

## 2026-09-16 — §I Feat / boon: apply de ficha

* **Update** (14:10 UTC): Recuperar Vitalidade gasta `diceCount` e cura; Até a Morte define 1+metade do máximo; Chef e Líder Inspirador aplicam PV temp.; Healer/Músico/Eir/Clemência já aplicavam; estilo no ataque fica no combate — refs: [`apply-feat-economy-executed-effect.ts`](../../src/game/session/application/table-actions/feat/apply-feat-economy-executed-effect.ts), [`phb_feat.economy-action.sql`](../../database/seeds/feat/phb/phb_feat.economy-action.sql), [`phb_effect.phb.sql`](../../database/seeds/effect/phb/phb_effect.phb.sql), [`backlog.md`](../plans/backlog.md) — motivo: table-action de feat que mexe em PV/PV temp. não pode ficar só em spend-resource genérico.

## 2026-09-16 — §O Condições: declare na ficha

* **Update** (13:55 UTC): PATCH incremental `addConditions`/`removeConditions`; table-action `apply_condition`/`clear_condition` na ficha do PC; Curar Veneno, Resguardo Mental, véus de Invisível; alvo/duração no inimigo ficam no combate — refs: [`apply-sheet-conditions.ts`](../../src/game/session/application/table-actions/primitives/apply-sheet-conditions.ts), [`patch-state.ts`](../../src/game/session/infrastructure/character-state/core/patch-state.ts), [`backlog.md`](../plans/backlog.md) — motivo: declare de condição na mesa é estado da ficha, não combate.

## 2026-09-16 — §E Heritage: apply de ficha GH

* **Update** (13:45 UTC): Fio Inabalável aplica PBd4 de PV temp.; Resistência Incomparável ganhou pool + 1 PV (2×: 1d6+PB); Fio Concentrado já existia; §E saiu da fila — refs: [`apply-origin-resource-spend-effects.ts`](../../src/game/session/application/session-commands/apply-origin-resource-spend-effects.ts), [`phb_effect.mesa-spend.sql`](../../database/seeds/effect/phb/phb_effect.mesa-spend.sql), [`phb_effect.heritage.sql`](../../database/seeds/effect/grim-hollow/phb_effect.heritage.sql), [`backlog.md`](../plans/backlog.md) — motivo: spends de heritage que mexem em PV/PV temp. não podem ficar só em nota (sopro/ataque/HD extra 2× ficam no combate).

## 2026-09-16 — §D Espécie: Vigor Implacável na ficha

* **Update** (13:35 UTC): spend de `relentlessEndurance` aplica 1 PV, limpa Inconsciente e death saves; `survive_at_zero` deixa de usar a fórmula de Paladino por omissão; §D saiu da fila — refs: [`apply-origin-resource-spend-effects.ts`](../../src/game/session/application/session-commands/apply-origin-resource-spend-effects.ts), [`apply-survive-at-zero.ts`](../../src/game/session/application/table-actions/primitives/apply-survive-at-zero.ts), [`phb_effect.species.sql`](../../database/seeds/effect/phb/phb_effect.species.sql), [`backlog.md`](../plans/backlog.md) — motivo: único apply de ficha da espécie que ainda era só nota (Adrenalina/Mãos/Werekin já existiam; sopro/ancestralidade são combate).

## 2026-09-16 — §F Thread: apply de ficha

* **Update** (13:25 UTC): Tenacidade limpa condições; Lealdade Extrema tira Enfeitiçado + dano = nível; Lealdade Imortal (recurso novo) PV = nível; Fatebound já aplicava Ruína/Último Ato; §F saiu da fila — refs: [`apply-thread-sheet-spend.ts`](../../src/game/session/application/session-commands/apply-thread-sheet-spend.ts), [`phb_effect.thread.sql`](../../database/seeds/effect/northlands/phb_effect.thread.sql), [`backlog.md`](../plans/backlog.md) — motivo: spend de thread que mexe na ficha não pode ficar só em nota.

## 2026-09-16 — §G Antecedente: idiomas concedidos no create

* **Update** (13:20 UTC): create passa a mesclar idiomas fixos do antecedente + concedidos de classe (`common`, Gíria dos Ladrões, Druídico) como o talento de origem; §G saiu da fila Ativo — refs: [`background-origin.ts`](../../src/game/sheet/domain/origin/background-origin.ts), [`resolve-create-origin.ts`](../../src/game/sheet/application/create-character/resolve-create-origin.ts), [`backlog.md`](../plans/backlog.md) — motivo: último gap de ficha do antecedente (pacote/perícia/ferramenta já estavam).

## 2026-09-16 — Backlog fácil → difícil

* **Update** (13:10 UTC): `backlog.md` passou a fila numerada por custo (Ativo §G…§H, Adiado Ulfberht…Companheiro Primal, combate por último); checklist só aponta a ordem — refs: [`backlog.md`](../plans/backlog.md), [`effect-mesa-checklist.md`](../plans/effect-mesa-checklist.md) — motivo: pegar o próximo barato sem misturar Adiado nem combate.

## 2026-09-16 — Backlog: saiu o concluído

* **Update** (13:05 UTC): `backlog.md` ficou só o aberto (snapshot Ativo §B/C + §H; Adiado Motor/UI e Qualidade vazios removidos); §A saiu do checklist mesa; link morto `dmg-wiring-status.md` — refs: [`backlog.md`](../plans/backlog.md), [`effect-mesa-checklist.md`](../plans/effect-mesa-checklist.md) — motivo: política do plano — concluído não acumula histórico.

## 2026-09-16 — Limpeza pós-lote de imagens

* **Update** (12:55 UTC): removidos `no-image-*` e `*-images-report.json` / wire-report em `extracts/mm/` (caça concluída); SSOT permanece seeds + `public/catalog/` + extracts de monstro — refs: [`catalog-images.md`](../source/catalog-images.md) — motivo: artefatos de backlog/import não são mais necessários.

## 2026-09-16 — Veículos PHB com imagem (12/12)

* **Update** (12:25 UTC): 12 artes → `public/catalog/vehicles/` + `seed.mm-vehicles-images.sql` (`phb_vehicle_template`); backlog imagens **0** — refs: [`seed.mm-vehicles-images.sql`](../../database/seeds/creature/phb/seed.mm-vehicles-images.sql), [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: fechar veículos após rename Navio a Remo.

## 2026-09-16 — Galley: Galera → Navio a Remo

* **Update** (12:15 UTC): slug `galera` → `navio-a-remo`; nome **Navio a Remo** (item + veículo + glossário) — refs: [`phb_vehicles.all.sql`](../../database/seeds/creature/phb/phb_vehicles.all.sql), [`20260916_galera_to_navio_a_remo.sql`](../../database/migrations/20260916_galera_to_navio_a_remo.sql) — motivo: “Galera” soa gíria em PT-BR; alinhar a `Navio a Vela` / `Navio Longo`.

## 2026-09-16 — Backlog real: wire 286 + 12 veículos

* **Update** (12:05 UTC): audit seeds mostrou ~298 sem `image_url`; **286** já tinham arquivo em `public/catalog/` e foram ligados (`seed.mm-catalog-wire-images.sql`); restam **12 veículos** PHB — refs: [`no-image-ddb-links.md`](../source/catalog-images.md), [`seed.mm-catalog-wire-images.sql`](../../database/seeds/creature/phb/seed.mm-catalog-wire-images.sql) — motivo: lista “fechada” ignorava arte órfã sem UPDATE.

## 2026-09-16 — Summons fechados (37/37)

* **Update** (12:00 UTC): lote final elemental+skeletal+montaria+primal → `public/catalog/summons/`; lista sem imagem **0** — refs: [`seed.mm-summons-images.sql`](../../database/seeds/creature/phb/seed.mm-summons-images.sql), [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: usuário entregou o resto (nomes com typo mapeados).

## 2026-09-16 — 20 artes de summons importadas

* **Update** (11:40 UTC): 20 retratos → `public/catalog/summons/` + `seed.mm-summons-images.sql`; restam elemental×4, skeletal, montaria×3, primal×9 — refs: [`seed.mm-summons-images.sql`](../../database/seeds/creature/phb/seed.mm-summons-images.sql), [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: lote Google por forma (aberration→undead parcial).

## 2026-09-15 — Summons caça por forma EN

* **Update** (22:40 UTC): doc reorganizado magia→forma (Beholderkin/Slaad/Star Spawn, Mirthful/Fuming/Tricksy, etc.) + Google por nome da forma; primal = 3 ambientes — refs: [`no-image-ddb-links.md`](../source/catalog-images.md), [`summon-vs-conjure.md`](./summon-vs-conjure.md) — motivo: Beyond só tem símbolo; forma tem nome pesquisável.

## 2026-09-15 — Links Google Imagens para summons

* **Update** (22:35 UTC): Beyond só tem símbolo nas magias; doc com busca Google Imagens por família e por variante — refs: [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: caçar arte fora do Beyond.

## 2026-09-15 — Docs sem-imagem só summons

* **Update** (22:30 UTC): `no-image-list.md` + `no-image-ddb-links.json` alinhados — total **37** summons; bestas/jovens removidos da lista aberta — refs: [`no-image-list.md`](../source/catalog-images.md), [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: doc batia com estado real pós import cobra/crocodilo.

## 2026-09-15 — Últimas bestas + lista só summons

* **Update** (22:25 UTC): `cobra-voadora` + `crocodilo-gigante` → `public/catalog/beasts/` + seed; lista sem imagem agora só **37** summons — refs: [`seed.mm-beasts-manual-images.sql`](../../database/seeds/creature/phb/seed.mm-beasts-manual-images.sql), [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: fechar gaps MM/beasts; usuário caça summons nas magias.

## 2026-09-15 — Lista sem imagem atualizada

* **Update** (22:20 UTC): após bestas manuais + jovens→adulto, restam **2** fichas para caçar (Flying Snake, Giant Crocodile) + summons sem arte — refs: [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: orientar scrap residual.

## 2026-09-15 — Dragões jovens reusam arte do adulto

* **Update** (22:15 UTC): 10 `*-jovem` + `dragao-sombra-juvenil` → mesmo `image_url` do adulto correspondente — refs: [`seed.mm-dragons-young-reuse-adult-images.sql`](../../database/seeds/creature/phb/seed.mm-dragons-young-reuse-adult-images.sql) — motivo: Beyond não publica arte Young; usuário pediu reutilizar a do Adulto.

## 2026-09-15 — Retratos manuais de bestas (fichas Beyond)

* **Update** (20:10 UTC): 41 arquivos em `scrap/` → `public/catalog/beasts/` + **42** `image_url` — refs: [`seed.mm-beasts-manual-images.sql`](../../database/seeds/creature/phb/seed.mm-beasts-manual-images.sql) — motivo: arte baixada das fichas individuais; restam ~49 (summons + young dragons + poucos gaps).

## 2026-09-15 — Links Beyond para fichas sem imagem

* **Update** (17:45 UTC): lista navegável com busca DDB das criaturas sem `image_url` — refs: [`no-image-ddb-links.md`](../source/catalog-images.md) — motivo: acelerar download manual da arte nas fichas individuais.

## 2026-09-15 — Imagens Animals do scrap Beyond

* **Update** (17:35 UTC): capítulo Animals → `public/catalog/beasts/`; **17** `image_url` novos (variantes/gigantes + enxames que compartilham arte do capítulo) — refs: [`seed.mm-animals-images.sql`](../../database/seeds/creature/phb/seed.mm-animals-images.sql) — motivo: Beyond só tem ~24 artes no capítulo Animals; restante ainda sem ilustração própria.

## 2026-09-15 — Imagens Monsters (U–Z) do scrap Beyond

* **Update** (17:25 UTC): artes U–Z → `public/catalog/monsters/`; **~12** `image_url` novos (ultrolote, vampiro traz-noite, guerreiros, licantropos, worg dire, zumbis) — refs: `seed.mm-monsters-{u..z}-images.sql` — motivo: fechar alfabeto MM 2024; A–Z completo no scrap.

## 2026-09-15 — Imagens Monsters (N–T) do scrap Beyond

* **Update** (17:20 UTC): artes N–T → `public/catalog/monsters/`; **~36** `image_url` novos (sahuagin, slaadi, esqueletos, pirates, performers, thri-kreen, etc.) — refs: `seed.mm-monsters-{n..t}-images.sql` — motivo: continuar lote MM 2024; restam ~119 sem imagem (beasts/summons/jovens dragão).

## 2026-09-15 — Imagens Monsters (I–M) do scrap Beyond

* **Update** (17:15 UTC): artes I–M → `public/catalog/monsters/`; **21** `image_url` novos (kobolds, cavaleiro em missão, homens-lagarto, mephits, tritões, micônideos, etc.) — refs: `seed.mm-monsters-{i..m}-images.sql` — motivo: continuar lote MM 2024.

## 2026-09-15 — Imagens Monsters (E–H) do scrap Beyond

* **Update** (17:10 UTC): artes E–H → `public/catalog/monsters/`; **30** `image_url` novos (gith, gnolls, goblins, hobgoblins, dragões-fada, fungos, etc.) — refs: `seed.mm-monsters-{e,f,g,h}-images.sql` — motivo: continuar lote MM 2024; micônideos ainda sem arte no scrap F.

## 2026-09-15 — Imagens Monsters (C–D) do scrap Beyond

* **Update** (17:00 UTC): artes C (21) + D (16) → `public/catalog/monsters/`; **13** `image_url` novos (centauros, cocatrice regente, couatl, enxames, cultistas, ciclopes, aspirante cav. morte, druida) — refs: [`seed.mm-monsters-c-images.sql`](../../database/seeds/creature/phb/seed.mm-monsters-c-images.sql), [`seed.mm-monsters-d-images.sql`](../../database/seeds/creature/phb/seed.mm-monsters-d-images.sql) — motivo: continuar lote de imagens MM 2024; jovens dragão cobre ainda sem arte.

## 2026-09-15 — Imagens Monsters (B) do scrap Beyond

* **Update** (16:55 UTC): 33 artes do scrap `Monsters (B)` → `public/catalog/monsters/` + 9 `image_url` novos (bandidos variantes, berserker comandante, praga de galho, bugbears, bullywugs) — refs: [`seed.mm-monsters-b-images.sql`](../../database/seeds/creature/phb/seed.mm-monsters-b-images.sql) — motivo: arte MM 2024; jovens dragões B ainda sem arte própria no scrap (só wyrmling/adulto/ancião).

## 2026-09-15 — Imagens Monsters (A) do scrap Beyond

* **Update** (16:50 UTC): 12 artes do scrap `Monsters (A)` → `public/catalog/monsters/` + `image_url` em 14 templates que estavam NULL (aarakocra, objetos animados, plantas despertadas, azer, bico-de-machado gigante) — refs: [`seed.mm-monsters-a-images.sql`](../../database/seeds/creature/phb/seed.mm-monsters-a-images.sql), [`monsters-a-images-report.json`](../source/extracts/mm/monsters-a-images-report.json) — motivo: preencher arte MM 2024 a partir do HTML salvo; PNGs já existentes (abolete, ankheg…) só atualizados no arquivo.

## 2026-09-15 — Nomes UTF-8 + inventário sem imagem

* **Fix** (16:30 UTC): 29 nomes com `??` no DB (espíritos/companions/montarias/objeto animado) corrigidos para acentos PT — refs: [`no-image-list.md`](../source/catalog-images.md) — motivo: encoding corrompido na apply anterior; seeds SQL já estavam corretas.
* **Update** (16:30 UTC): inventário 240 sem `image_url` + busca web de fontes MM 2024 — refs: [`no-image-sources.md`](../source/catalog-images.md) — motivo: arte oficial está em Roll20/DDB (sem CDN pública); scrap local já limpo.

## 2026-09-15 — Gaps da lista via SRD

- 11 templates do SRD 5.2.1 (swarms, Giant Owl/Eagle/Elk/Vulture, Flying Snake) → `list-gap-srd.json` / `seed.mm-list-gap-srd.sql`.
- Nomes EN alinhados à lista MM (Venomous Snakes / Piranhas).
- Alias `Yuan-ti Malison` → 3 tipos no relink de tags; agrupadores `(all)` continuam ignorados.

## 2026-09-15 — Lists: bestas faltantes + ignorar agrupadores

- Aplicou `seed.phb-beasts.sql` + `seed.mm-animals.sql` (25 slugs da lista que faltavam no DB).
- Relink tags: habitats 935→998; agrupadores `(all)` ignorados de propósito.
- Sem template ainda (só no extract): swarms, Giant Eagle/Owl/Elk/Vulture, Flying Snake, Yuan-ti Malison genérico.

## 2026-09-14 — MM Monsters M–Z + Monster Lists

- Extract/seed `monsters-mz.json` / `seed.mm-monsters-mz.sql` (**186** templates; delta).
- Habitat/Treasure dos stat blocks + listagens Appendix B em `monster-lists.json` / `seed.mm-monster-lists.sql`.
- Schema: `phb_creature_template_list_tag` (habitat|treasure|group) + `phb_creature_stat_block_conversion` (2014→2024).
- Scrap `docs/source/scrap/` limpo após import.

## 2026-09-14 — MM Monsters C–L → catálogo

- Extract `monsters-cl.json` + seed `seed.mm-monsters-cl.sql` (**156** templates; delta, sem repetir A–B/Animals/PHB).
- 15 lendárias com `Legendary Action Uses` (incl. Empírico, Kraken, Lich, Dracolich).
- Scrap `docs/source/scrap/monster/` limpo após import.

## 2026-09-14 — MM A–B: usos lendários

- Completou `Legendary Action Uses` nas 13 criaturas lendárias (extract + seed).
- MM 2024: sem Lair Actions separadas; covil = usos extras (ex. 3 → 4 in Lair) + Legendary Resistance.
- Próximas fichas scrap: **não repetir** slugs já no catálogo (só deltas). Ver rule `creature-scrap-import`.

## 2026-09-14 — MM Monsters A–B → catálogo

- Extract `docs/source/extracts/mm/monsters-ab.json` + seed `seed.mm-monsters-ab.sql` (65 templates A–B).
- Scrap `docs/source/scrap/monster/alfabeto/` limpo após import; artes em `public/catalog/monsters/`.

## 2026-09-14 — MM Animals → catálogo Beast

- Extract + seed `seed.mm-animals.sql` (42 Beasts novas; skip Swarm / Celestial / Monstrosity).
- Artes MM também atualizam algumas bestas já no PHB App. B.

## 2026-09-14 — PHB Appendix B Beasts → catálogo

- Extract + seed `seed.phb-beasts.sql` (43 Beasts) a partir do scrap Beyond.
- Wild Shape passa a ter CR > 0 no catálogo (ex.: lobo 1/4, urso-pardo 1).

## 2026-09-14 — Companheiro Selvagem (Wild Companion)

- Table-action `wild-companion`: gasta Forma ou espaço → `convocar-familiar` (Fey).
- Despawn no Descanso Longo.

## 2026-09-14 — Wild Shape modular onda 2

- Known forms (4/6/8) + 1 troca pós–Descanso Longo; gate no apply.
- `GET …/druid/wild-shape/eligible`; painel/economy set/replace.
- `SyncWildShapeActorHandler`: spawn/delete `game_actor` na Forma Selvagem.

## 2026-09-14 — Wild Shape modular onda 1

- Faixas CR SQL (`phb_wild_shape_cr_band`) + domínio elegibilidade; apply `wild_shape` / Moon com `templateSlug`.
- Estado na ficha (`wild_shape_active`, `wild_shape_template_slug`); clear no long rest + `wild-shape-end`.
- Dívida: known forms, listagem/painel, game_actor.

## 2026-09-14 — Wild Shape: OKF modular + arte Morcego

- Concept [wild-shape.md](/wild-shape.md): elegibilidade CR × Beast do catálogo; sem lista hardcodada.
- Arte `public/catalog/beasts/morcego.png` a partir do scrap Bat; gerador com `scrap: 'Bat'`.
- Sem implementação de eligibility/transform nesta onda.

## 2026-09-12 — Find Familiar: templates = monstros

- Identidade: slugs de besta (`gato`, `coruja`…), não `familiar-*`.
- Vínculo: só `phb_spell_spirit_variant` (convocar-familiar → template).
- Imagens em `public/catalog/beasts/`; removido traço “Espírito Familiar” do template.

## 2026-09-12 — Find Familiar (CR0)

- Seed `seed.find-familiar.sql`: 11 formas listadas na magia (stats SRD 5.2.1; imagens Beyond no scrap).
- Mapa `convocar-familiar` + escala flat; gerador `scripts/generate/seed-find-familiar.mjs`.

## 2026-09-12 — fey-reinforcements: sem timer de 1 min

- Decisão: duração 1 min fica na mesa/nota; sem despawn automático por clock.

## 2026-09-12 — Multi-token Animar Objetos + wire spectral/fey

- `budget_cost` em `phb_spell_spirit_variant`; cast aceita `spiritCount` / `spiritSelections`.
- Sync spawna N actors no orçamento (mod × 1/2/3); resposta `spirits[]`.
- Table-actions `spectral-summon` (½ PV + concentração) e `fey-reinforcements` (sem concentração) reusam mapas Summon.

## 2026-09-12 — Animar Objetos: ficha alinhada ao scrap

- Fonte: `docs/source/scrap/Animate Objects - Spells - D&D Beyond.html`.
- Traits/ações dos `objeto-animado-*` completados (imunidades, sentidos, idiomas, PB do conjurador, Pancada).
- Orçamento (mod × custo 1/2/3) documentado; multi-token continua opcional.

## 2026-09-12 — Summon rest + despawn concentração

- Seeds: Aberração / Constructo / Dragão / Ínfero / Morto-Vivo / Inseto Gigante / Animar Objetos (`seed.summon-spirit-rest.sql`).
- Despawn de spirit actors ao trocar/encerrar concentração (cast, patch, long rest).
- Fora: Familiar CR0, Wild Shape, MM genérico; Conjure\* sem ficha.

## 2026-09-12 — Template: escala fora da identidade

- Concept: [creature-template-scale-control.md](/creature-template-scale-control.md) — identidade / variante / escala / controle.
- SQL: `phb_creature_scale_by_level` + `phb_creature_scale_by_slot`; colunas `companion_*` / `spirit_*` removidas do template.
- Sync companion/spirit lê as tabelas de escala; seeds alinhados.

## 2026-09-12 — spirit_actor fichas (Steed + Summon core)

- Schema/migration: `spirit_*` em `phb_creature_template`; `phb_spell_spirit` + variantes.
- Domain: `scaleSpiritCombatStats` + `SyncSpellSpiritHandler`; cast exige `spiritVariantKey`.
- Seeds: Montaria Sobrenatural ×3; espíritos Bestial/Feérico/Elemental/Celestial + mapas.
- Doc: [summon-vs-conjure.md](/summon-vs-conjure.md) — core mapeado; rest + despawn na entrada do topo.

## 2026-09-12 — Summon vs Conjure (nomenclatura)

- Convenção: Summon→**Invocar** (`spirit_actor`), Conjure→**Conjurar** (`area_effect`), Find→**Convocar**.
- Doc: [summon-vs-conjure.md](/summon-vs-conjure.md); glossário alinhado; slugs `conjurar-*` / `invocar-*` + migration.
- Seed: bloco Bestial Spirit devolvido a `invocar-fera` (estava colado em `invocar-infero`).

## 2026-09-12 — Gaps veículos / companions / game-port

- Item `barco-de-quilla` → `barco-de-quilha` (migration + seed align); drawn-vehicles PHB têm `phb_vehicle_template` + properties alinhadas.
- Companions BM: ability scores / speeds / traits PHB 2024; colunas `companion_hp_base|per_level` + `companion_ac_ability_slug`; sync aplica escala.
- GH Primal Spirit: stats melhores + escala provisória (dívida extract).
- `@catalog/game-port`: assert/find creature/vehicle + `resolveTransportActorKind`; link vehicle/sync companion via `CatalogLookupService`.
- SRD/MM genérico **adiado**.

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

## 2026-09-11 — Reorganização `src/entities` por domínio

- Pastas: `effect/`, `class/`, `subclass-feature/`, `species/`, `heritage/`, `equipment/`, `spell/`, `feat/`, `companion/`, `template/`, `reference/` (+ `views/` mantida).
- Imports `@entities/<domínio>/<arquivo>` e relativos `../entities/<domínio>/…`; barrels `index.ts` por pasta; `trace-entities-for-vercel.ts` atualizado.
- Sem mudança de schema SQL — só layout TypeORM/TS.

## 2026-09-11 — Faxina P0 pós-mesa (mortos + wire dice)

- Delete: resolvers Psi/Soulknife; DTOs session órfãos; cadeia `applySecondWind`/`ActionSurge`/`TacticalMind` (session); `divineSparkDice`; pastas vazias `sorcerer/feature-actions`.
- Dice usa helpers `has*` (evasion, slippery mind, diamond soul, studied attacks, door kick, indomitable, assassin mobile aim) em vez de `level >= N` inline.
- Duel Second Wind / Action Surge **intactos** (implementação própria).

## 2026-09-11 — Gates `has*` → SQL (`phb_class_feature_gate`)

- Schema + migration `0155` / `20260911_phb_class_feature_gate.sql`.
- Seeds classe (studied/tactical/indomitable/evasion/slippery/diamond/aura/precise…) + subclass wave (door_kick, assassin_mobile_aim, divine_fury, psychic_blades).
- `featureGatesByClassSlug` no mechanical catalog; helpers `CLASS_GATE` / `SUBCLASS_GATE` / `unlockFromGates`.
- Dice, duel, combat slice e weapon attacks passam unlock do catálogo.

## 2026-09-12 — Schedules wave4 (menores restantes)

- Seed: `catalog/phb/phb_class_feature_schedule.wave4.sql` (cleric divine strike/spark; paladin radiant/aura; college-of-masks; diviner portent).
- Keys: `FEATURE_SCHEDULE_KEYS` + fixtures; helpers com `bands`; `scheduleCount` em effect loop / `resolveEffectAmount`.
- Call sites: damage cleric/paladin; `set-persona-masks` via mechanical catalog.

## 2026-09-12 — Transformations + threads SQL-first

- Enum: `proficiency_bonus_plus_stage` + `transformation_stage`; grants Cap.6 regenerados; removido Set TS `CAP6_PB_PLUS_STAGE_*`.
- Tables: `phb_heritage_combat_note`, `phb_transformation_boon_combat_note`; colunas bracket/spend em `phb_character_thread_milestone_benefit`.
- Wire: heritage/transformation notes via catalog; Cursemarked brackets + Fatebound spend notes via SQL; motor HP Fatebound permanece TS.
- Dívida: `CAP6_CHOICE_RULES` ainda em TS (batches).
- Docs: audit + waves-plan mesa stale → fechado.

## 2026-09-12 — Cap.6 choice rules → SQL

- Schema: `transformation_stage_mode` + stage_rule / auto_boon / pick_key / sub_option / require_match(+pair).
- Seed gerado: `phb_transformation_choice_rules.all.sql` (12 transformações).
- Wire: `loadTransformationChoiceRule`; validator + combat notes sem `CAP6_CHOICE_RULES` runtime (batches só fixture/gerador).
