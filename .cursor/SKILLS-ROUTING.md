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
| `domain-driven-design` | Bounded contexts, agregados |
| `testing` | Jest + `@nestjs/testing` |

> Pares complementares: `typescript`+`nestjs`, `postgresql-sql`+`typeorm`. Manter ambos no merge.

## Rule do projeto

- `.cursor/rules/nestjs-project.mdc` — editável e versionável neste repo
