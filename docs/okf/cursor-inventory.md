---
type: Inventory
title: Inventário Cursor (dnd-api)
description: Docs, skills, rules e commands — o que existe e o que falta para uniformidade.
tags: [cursor, skills, rules, docs]
timestamp: 2026-09-11
---

## Já existe (usar)

### Docs (`docs/`)

| Área | Peças-chave |
| --- | --- |
| Arquitetura | `architecture.md`, `game-module-structure.md`, `code-standards.md` |
| SQL | `sql-layout.md`, `catalog-patterns.md`, `data-model.md` |
| Effects | `adr-effect-engine.md`, `effect-dictionary.md`, `effect-engine-read-path.md` |
| Planos | `plans/backlog.md` (SSOT do que falta) |
| Testes | `test/README.md` |

### Cursor projeto

| Tipo | Path |
| --- | --- |
| Routing | `.cursor/SKILLS-ROUTING.md` (perfil nestjs) |
| Rule | `.cursor/rules/nestjs-project.mdc` |
| Rule | `.cursor/rules/game-folder-conventions.mdc` **(novo)** |
| Rule | `.cursor/rules/catalog-sql-first.mdc` **(novo)** |
| Skill | `.cursor/skills/catalog-sql-first/` **(novo)** |
| Command | `.cursor/commands/legado.md` **(novo)** |

### Skills globais (Shared AI) — priorizadas neste repo

`nestjs`, `typescript`, `typeorm`, `postgresql-sql`, `domain-driven-design`, `testing`, `clean-code`, `dry`, `solid`, `okf`

### Commands globais úteis

`/skills-why`, `/criar-skill`, `/criar-rule`, `/historico`, `/onboard`

## Gaps (ainda abertos)

| Gap | Ação sugerida | Onda |
| --- | --- | --- |
| Rule `file-size` citada em code-standards mas ausente no repo | Criar `.cursor/rules/file-size.mdc` ou remover citação | 1b |
| Skill `phb-query-views` citada em catalog-patterns | Localizar no Shared AI ou recriar no projeto | 2 |
| Mapa vivo “arquivo canônico por pasta” | Manter `/module-map.md` atualizado | 1 |
| Playbook legado automatizado | Command `/legado` + log OKF | 3 |
| `noUncheckedIndexedAccess` | Opt-in depois (~98 erros) | depois |

## Relacionados

- [Mapa de módulos](/module-map.md)
- [Plano em ondas](/waves-plan.md)
