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

## Dívida (próximos candidatos)

| Prioridade | Achado | Arquivo(s) tipicos | Casa SQL sugerida |
| --- | --- | --- | --- |
| alta | ASI / feat levels por classe | `progression/domain/asi-feat-levels.ts` | `phb_class_progression` / coluna dedicada |
| alta | Expertise slots / níveis | validators class-expertise | progression / option_def |
| média | Companion profiles (slug→config) | `companion/domain/companion-profiles.ts` | tabela companion / effects |
| média | Manikin AC / ancestry damage maps | `combat/domain/species/*` | effects (`ac_*`, damage type) |
| média | Initiative gates / bloodhound etc. | duel / combat notes | effects / subclass features |
| baixa | Notes de combate por nível | textos em TS | `combat_note` effect / catalog text |

Detalhe da auditoria completa ficou no transcript da sessão; este concept é o índice vivo.

## Padrão do piloto (repetir)

1. Coluna nullable em `phb_class` (ou tabela de progression) no schema SSOT
2. Migration forward `ALTER` + `UPDATE` para DBs existentes
3. Seed `UPDATE` no `SEED_ORDER` **depois** de todas as classes afetadas
4. Campo em `PhbClassRef` + query em `class-meta.queries.ts`
5. Predicado puro em domain (nível vs unlock); zero `Record` de slugs
6. Validator async resolve + wire no create/update
