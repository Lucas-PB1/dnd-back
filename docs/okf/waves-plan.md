---
type: Playbook
title: Plano em ondas — preparação dnd-api
description: Convenções → SQL-first → legado morto; ordem e critérios de pronto.
tags: [roadmap, sql-first, legacy]
timestamp: 2026-09-11
---

## Onda 1 — Convenções (feita)

**Meta:** o agente (e humanos) saberem *onde* criar cada arquivo.

| Entrega | Status |
| --- | --- |
| Rule `game-folder-conventions.mdc` | feito |
| Rule `catalog-sql-first.mdc` | feito |
| OKF inventory + module-map | feito |
| Command `/legado` | feito |
| Atualizar `SKILLS-ROUTING.md` + `docs/README.md` | feito nesta onda |
| Rule `file-size.mdc` (ou corrigir citação) | feito |
| Primeira varredura `/legado` → `companion/` | feito (vivo) |

**Pronto quando:** criar feature nova sem inventar pasta `utils/`; checklist da rule aplicado.

## Onda 2 — SQL-first (dados mandam)

**Meta:** nova raça/traço/feat = schema+seed+view; zero lista hardcoded em Game.

| Entrega | Status |
| --- | --- |
| Skill `catalog-sql-first` + checklist | feito |
| Auditar `src/game/**` por slugs/level gates mágicos | feito — [sql-first-audit.md](/sql-first-audit.md) |
| Migrar 1 caso piloto (fighting style unlock) | feito — coluna + seed + query + validator |
| Migrar ASI / feat levels | feito — `asi_or_feat` em progression + `loadAsiOrFeatLevels` |
| Migrar expertise slots | feito — `phb_option_def` + `loadClassExpertiseSlots` |
| Migrar Jack of All Trades | feito — `jack_of_all_trades_level` |
| Migrar companion profiles | feito — `phb_companion_profile` + template map |
| Migrar Manikin AC / ancestry | feito — armor preset + damage_type EN |
| Migrar initiative / bloodhound / companion labels / GH notes | feito — tabelas + seeds + predicados |
| Migrar Northlands + packs PHB estáticos + damage_type PT | feito — `phb_level_combat_note` + `phb_damage_type` |
| Migrar literais PHB restantes (8 classes) | feito — `remaining-static.sql`; dinâmicos ficam no TS |
| Migrar feature schedules (piloto→wave4) + matar fallbacks | feito — `phb_class_feature_schedule` (wave4: divine/masks/portent/aura) |
| Handlers mesa `switch(actionSlug)` → economy | **dívida alta** (bárbaro **fechado** — kinds genéricos); outras classes — [sql-first-audit.md](/sql-first-audit.md) § Mesa |
| Reforçar `@catalog/game-port` se novos helpers | sob demanda |

**Pronto quando:** playbook “add species” executável só com SQL + Query Catalog.

## Onda 3 — Legado morto

**Meta:** pasta a pasta, evidência de imports, remoção segura.

| Entrega | Status |
| --- | --- |
| Primeira pasta: `src/game/companion/` | feito — vivo (domain library) |
| Próxima pasta suspeita | pendente — pastas leaf gordas / generated |
| Log em `docs/okf/log.md` | contínuo |
| PRs pequenos (1 pasta / 1 concern) | — |

**Pronto quando:** sem pastas Game sem módulo (exceto domain libraries documentadas).

## Fora de ordem (não bloquear)

- `noUncheckedIndexedAccess`
- Reduzir tamanho `session/` / `combat/domain` (já parcialmente fatiado)
- Events para residual Session↔Actor (opcional)

## Relacionados

- [Inventário](/cursor-inventory.md)
- [Mapa](/module-map.md)
- Command: `.cursor/commands/legado.md`
