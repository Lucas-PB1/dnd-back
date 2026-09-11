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
