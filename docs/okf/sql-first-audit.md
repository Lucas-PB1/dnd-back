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

## Dívida restante

| Prioridade | Achado | Casa sugerida |
| --- | --- | --- |
| baixa | Notes PHB dinâmicas (dados, templates `${}`, rageActive) | manter TS ou `table_note` com placeholders |
| baixa | Notes fighter/rogue/ranger/warlock/wizard base e subclass mistos | migrar só literais estáticos restantes |

## Padrão do piloto (repetir)

1. Schema SSOT + migration forward
2. Seed no `SEED_ORDER` após owners
3. Query Catalog + predicado puro
4. Remover Record/slug gates do Game
