# Game BC — submódulos e domínios

Complementa [`architecture.md`](architecture.md) e [`game-advanced-plan.md`](game-advanced-plan.md).

## Problema

Tudo em `src/game/characters/` virou um **god module**:

| Arquivo | Linhas | Papel |
|---------|--------|-------|
| `character-sheet.validator.ts` | ~270 | Validação PHB da ficha |
| `character-sheet.repository.ts` | ~210 | 7 tabelas `player_character_*` |
| `characters.controller.ts` | ~190 | CRUD + inventário + level-up + roll |
| `characters.module.ts` | ~95 | Registra 20+ providers |

Inventário, progression e **state (7C)** no mesmo módulo não escala. Campanha (7D) pioraria mais.

## Princípio

**Um submódulo Nest = um agregado / capability do jogador**, no mesmo estilo do `catalog/` (classes, spells, …).

```
BC Game (modular monolith)
├── shared/           # ownership, repositório raiz player_character
├── sheet/            # ficha PHB — pasta atual: `characters/`
├── build/            # criação: roll abilities, generate (futuro)
├── progression/      # level-up, preview, ASI (futuro)
├── inventory/        # mochila + equipado
└── session/          # 7C: slots, condições, concentração (futuro)
```

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

  sheet --> shared
  sheet --> catalog
  build --> catalog
  progression --> shared
  progression --> catalog
  progression --> sheet
  inventory --> shared
  inventory --> catalog
  session --> shared
  session --> catalog
```

| De | Para | Permitido |
|----|------|-----------|
| `sheet` | `shared`, `catalog` | sim |
| `inventory` | `shared`, `catalog` | sim |
| `progression` | `shared`, `catalog`, `sheet` (domain) | sim |
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
| **session** (futuro) | `GET/PATCH /characters/:id/state`, `POST .../rest` |

## O que fica onde

| Capability | Tabela(s) | Submódulo |
|------------|-----------|-----------|
| Núcleo da ficha | `player_character` | shared + sheet |
| Escolhas PHB | `player_character_skill`, `_species_choice`, … | sheet |
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
- [x] `game/sheet` — núcleo em `characters/` (`CharacterSheetModule`)
- [ ] `game/session` — fase 7C
- [x] Remover legado `characters.service.ts` (já removido)

**Última revisão:** 2026-07-03
