---
type: Architecture
title: Mapa de módulos (Game + Catalog)
description: Pasta → responsabilidade → ordem de tamanho; suspeitas de legado.
tags: [ddd, nestjs, modules]
timestamp: 2026-09-11
---

## Bounded contexts

| BC | Pasta | Papel |
| --- | --- | --- |
| Catalog | `src/catalog/` | PHB read-only + lookup |
| Identity | `src/identity/` | JWT Supabase |
| Game | `src/game/` | Ficha, mesa, combate |

Porta Catalog→Game: `@catalog/game-port` + `CatalogLookupService`.

## Game — submódulos (arquivos `.ts` produção, aprox.)

| Pasta | ~arq. | Módulo Nest? | Notas |
| --- | --- | --- | --- |
| `session/` | 229 | sim | Maior — actions por classe |
| `combat/` | 157 | sim | domain por classe |
| `sheet/` | 160 | sim | validators densos |
| `inventory/` | 84 | sim | |
| `dice/` | 40 | sim | |
| `campaign/` | 38 | sim | |
| `actor/` | 38 | sim | |
| `duel/` | 29 | sim | combat fatiado |
| `spellcasting/` | 24 | sim | |
| `effects/` | 17 | sim | |
| `progression/` | 9 | sim | |
| `shared/` | 8 | sim | ownership PC |
| `build/` | 7 | sim | |
| `companion/` | 2 | **não** | Suspeita legado / helpers órfãos |

## Catalog — features

Cada pasta ≈ resource HTTP + Query + ViewEntity (thin). Agregador: `catalog.module.ts`.  
`game-port/` = ACL estável para Game.

## Arquivos canônicos (checklist mental)

Ao abrir um submódulo Game, espere:

1. `*.module.ts`
2. `application/` e/ou `domain/` e/ou `infrastructure/`
3. `dto/` se houver HTTP
4. Specs `*.spec.ts` ao lado

Se faltar `*.module.ts` e não for `shared` domain-only documentado → investigar (`/legado`).

## Relacionados

- [Inventário Cursor](/cursor-inventory.md)
- Doc longa: [`../architecture/game-module-structure.md`](../architecture/game-module-structure.md)
