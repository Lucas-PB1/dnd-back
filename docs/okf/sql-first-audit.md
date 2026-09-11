---
type: Concept
title: Auditoria SQL-first — hardcodes em Game
description: Achados priorizados da onda 2; piloto e dívida restante.
tags: [sql-first, audit, game]
timestamp: 2026-09-11
---

# Auditoria — hardcodes em `src/game`

Varredura 2026-09-11. Critério: regra de catálogo (slug/nível/mapa) em TS que deveria viver em Postgres.

## Piloto (feito nesta onda)

| Achado | Destino SQL | Status |
| --- | --- | --- |
| Desbloqueio Estilo de Luta por classe | `rpg.phb_class.fighting_style_unlock_level` + seed + `resolveFightingStyleUnlockLevel` | **migrado** |
| ASI / feat levels por classe | `rpg.phb_class_progression.asi_or_feat` + seed + `loadAsiOrFeatLevels` | **migrado** |
| Expertise slots / níveis | `phb_option_def` (`expertiseSkill*`) + whitelist wizard em `option_value` | **migrado** |
| Jack of All Trades (bard≥2) | `phb_class.jack_of_all_trades_level` + `resolveJackOfAllTradesLevel` | **migrado** |
| Companion profiles (slug→config) | `phb_companion_profile` + `phb_companion_template_map` | **migrado** |
| Manikin AC / ancestry damage maps | `phb_species_armor_preset` + `option_value.damage_type` (slug EN) | **migrado** |
| Initiative gates (bônus/vantagem) | `phb_initiative_rule` | **migrado** |
| Bloodhound level gates | `phb_subclass_feature_gate` | **migrado** |
| Companion command labels | `phb_companion_command` | **migrado** |
| Notes de combate GH por nível | `phb_level_combat_note` | **migrado** |

## Dívida (próximos candidatos)

| Prioridade | Achado | Arquivo(s) tipicos | Casa SQL sugerida |
| --- | --- | --- | --- |
| baixa | Notes PHB/Northlands por nível | `*CombatNotes` em class folders | `phb_level_combat_note` |
| baixa | `DAMAGE_TYPE_PT` display map | `effects/.../species.ts` | i18n / damage_type catalog |

Detalhe da auditoria completa ficou no transcript da sessão; este concept é o índice vivo.

## Padrão do piloto (repetir)

1. Coluna nullable em `phb_class` (ou tabela de progression) no schema SSOT
2. Migration forward `ALTER` + `UPDATE` para DBs existentes
3. Seed `UPDATE` no `SEED_ORDER` **depois** de todas as classes afetadas
4. Campo em `PhbClassRef` + query em `class-meta.queries.ts`
5. Predicado puro em domain (nível vs unlock); zero `Record` de slugs
6. Validator async resolve + wire no create/update
