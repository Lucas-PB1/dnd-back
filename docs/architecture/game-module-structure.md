# Game BC — submódulos e domínios

Complementa [`architecture.md`](architecture.md). Pendências de mesa/combate: [`backlog.md`](../plans/backlog.md).

## Problema (histórico — resolvido)

Antes do split, tudo em um único módulo de personagens virou **god module** (validator, repository, controller e inventário/progression no mesmo lugar).

## Princípio

**Um submódulo Nest = um agregado / capability do jogador**, no mesmo estilo do `catalog/` (classes, spells, …).

```
BC Game (modular monolith)
├── shared/           # ownership, repositório raiz player_character
├── sheet/            # ficha PHB (CRUD + escolhas persistidas) — CharacterSheetModule
├── combat/           # CA / ataques / compliance — CombatModule
├── spellcasting/     # grants + CD/ataque mágico — SpellcastingModule
├── build/            # criação: roll abilities
├── progression/      # level-up, preview
├── inventory/        # mochila + equipado
├── session/          # slots, condições, concentração
├── dice/             # motor de dados + rolls da ficha (ataque, dano, perícia, ST, iniciativa)
└── campaign/         # mesa + encontro (PCs enriquecidos + criaturas manuais; visão jogador)
```

Ownership combat/spellcasting: módulos Nest `combat/` e `spellcasting/` (use cases em `application/`).

Cada submódulo:

```
<submodulo>/
├── application/      # handlers / queries
├── domain/             # regras D&D deste agregado
├── infrastructure/     # entities + repos deste agregado
├── dto/
├── *.controller.ts     # @Controller('characters') — mesmas URLs
└── *.module.ts
```

## Dependências

```mermaid
flowchart TB
  subgraph shared [game/shared]
    R[CharacterRepository]
    A[PlayerCharacterAccessService]
  end

  subgraph catalog [BC Catalog]
    L[CatalogLookupService]
  end

  subgraph combat [game/combat]
    C[ResolveEquipped* / CombatCatalog]
  end

  subgraph spell [game/spellcasting]
    S[LoadGrantedSpellCatalog / stats]
  end

  sheet --> shared
  sheet --> catalog
  sheet --> combat
  sheet --> spell
  combat --> shared
  build --> catalog
  progression --> shared
  progression --> catalog
  progression --> sheet
  progression -.->|maxSpellLevel| spell
  inventory --> shared
  inventory --> catalog
  session --> shared
  session --> catalog
  dice --> shared
  dice --> combat
  dice --> sheet
```

| De | Para | Permitido |
|----|------|-----------|
| `sheet` | `shared`, `catalog`, `combat`, `spellcasting` | sim |
| `combat` | `shared`, `catalog`, `inventory` (entity) | sim |
| `spellcasting` | `catalog` (views); DTO/tipos type-only de sheet | sim |
| `spellcasting` | `sheet` Nest providers / infra | **não** |
| `dice` | `shared`, `combat`, `sheet` (domain/repo para perícia/ST) | sim |
| `dice` | `sheet/infrastructure/equipped-*` | **não** — usar `combat` |
| `combat` | `sheet` | **não** |
| `inventory` | `shared`, `catalog` | sim |
| `progression` | `shared`, `catalog`, `sheet` (domain), `spellcasting` (domain) | sim |
| `inventory` | `sheet/infrastructure` | **não** — só via shared |
| `catalog` | `game/*` | **não** |

## URLs (inalteradas)

Todos os controllers usam `@Controller('characters')`:

| Submódulo | Rotas |
|-----------|-------|
| **sheet** | `GET/POST/PATCH/DELETE /characters`, `GET /characters/:id` |
| **build** | `POST /characters/roll-abilities` |
| **progression** | `GET/POST /characters/:id/level-up/*` |
| **inventory** | `GET/POST/PATCH/DELETE /characters/:id/inventory/*` |
| **session** | `GET/PATCH /characters/:id/state`, `POST .../spells/cast`, `POST .../rest` |
| **dice** | `POST /characters/:id/rolls/{attack,damage,skill,saving-throw,initiative}` |

## O que fica onde

| Capability | Tabela(s) | Submódulo |
|------------|-----------|-----------|
| Núcleo da ficha | `player_character` | shared + sheet |
| Escolhas PHB | `player_character_skill`, `_species_choice`, … | sheet |
| CA / ataques / compliance | inventário equipado + views PHB | combat |
| Grants / CD / ataque mágico | views granted + ficha | spellcasting |
| Atributos roll | — (sem persistir) | build |
| Level-up | coluna `level` em `player_character` | progression |
| Inventário | `player_character_item` | inventory |
| Mesa ao vivo | `player_character_state` (7C) | session |

## Catalog BC (referência)

Já está dividido — **12 módulos** (`classes/`, `spells/`, …). Game deve espelhar isso.

## Checklist de migração

- [x] `game/shared` — `CharacterRepository` + `PlayerCharacterAccessService`
- [x] `game/inventory` — extrair inventário
- [x] `game/progression` — level-up
- [x] `game/build` — roll abilities
- [x] `game/sheet` — `CharacterSheetModule` em `src/game/sheet/`
- [x] `game/session` — fase 7C
- [x] Remover legado `characters.service.ts` (já removido)
- [x] `game/combat` — M1 (`CombatModule`; dice → combat)
- [x] `game/spellcasting` — M2 (`SpellcastingModule`; grants fora de sheet)

**Última revisão:** 2026-07-27 — M1 combat + M2 spellcasting extraídos de sheet
