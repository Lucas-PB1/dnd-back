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
