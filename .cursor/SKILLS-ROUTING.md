# Roteamento — complemento do projeto (NestJS)

Perfil: `nestjs` (`npm run bootstrap -- <repo> --profile=nestjs`).

Complementa `~/.cursor/SKILLS-ROUTING.md`.

## Stack

- NestJS — `package.json` (`@nestjs/core`), `src/`, `nest-cli.json`

## Skills priorizadas

| Skill | Reforçar quando |
| --- | --- |
| `nestjs` | Módulos, controllers, guards, DTOs, Swagger |
| `typescript` | Tipos, DTOs, handlers (linguagem — **não** substituída por `nestjs`) |
| `typeorm` | Entities, repositories, QueryBuilder |
| `postgresql-sql` | Migrations/seeds SQL (SQL — **não** substituída por `typeorm`) |
| `catalog-sql-first` | Nova raça/traço/feat/item — projeto (`.cursor/skills/`) |
| `domain-driven-design` | Bounded contexts, agregados |
| `testing` | Jest + `@nestjs/testing` |
| `okf` | Bundles em `docs/okf/` |

> Pares complementares: `typescript`+`nestjs`, `postgresql-sql`+`typeorm`. Manter ambos no merge.

## Rules do projeto

| Rule | Glob / uso |
| --- | --- |
| `nestjs-project.mdc` | Nest geral |
| `game-folder-conventions.mdc` | `src/game/**` — onde criar arquivos |
| `catalog-sql-first.mdc` | `database/**`, `src/catalog/**` |
| `file-size.mdc` | limites de linhas |
| `typescript-docs.mdc` | `src/**/*.ts` — sem `//` docs; só TSDoc raro |

## Commands do projeto

| Command | Uso |
| --- | --- |
| `/legado` | Varredura de código morto pasta a pasta |
