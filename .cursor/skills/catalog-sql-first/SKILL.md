---
name: catalog-sql-first
description: >-
  Fluxo SQL-first do catálogo PHB/GH no dnd-api: schema, seeds, views e
  alinhamento TypeORM. Use ao criar raça, traço, feat, item, magia ou ao
  mover regra hardcoded de TS para o banco.
---

# Catalog SQL-first (dnd-api)

## Quando usar

- Adicionar espécie, linhagem/traço, feat, item, magia, effect
- Refatorar `if (slug === …)` / tabelas de nível em TS para dados
- Alterar contrato de view lida pela API

## Princípios

- **Postgres é SSOT** do catálogo; TypeORM só mapeia
- Uma mudança coerente = schema (ou migration forward) + seed + view/entity
- Game valida existência via `CatalogLookupService` / `@catalog/game-port`
- Evitar JSONB genérico quando já existe tabela/effect tipado (ver ADRs)

## Referências

| Tópico | Arquivo |
| --- | --- |
| Checklist novo conteúdo | [references/add-catalog-content.md](references/add-catalog-content.md) |

## Como aplicar

1. Localizar domínio em `database/schema/020_tables/` e `database/seeds/<domínio>/`
2. Preferir padrões existentes (`phb_option_*`, `phb_effect`, heritages) — `docs/architecture/catalog-patterns.md`
3. Atualizar/criar view em `030_views/` se a API lê por view
4. Alinhar `@Entity` / `@ViewEntity` em `src/entities/`
5. Expor leitura no feature module Catalog (Query) — não vazar regra para Game
6. Se Game precisar do helper: reexportar em `@catalog/game-port`

## Anti-padrões

- Hardcode de lista de slugs PHB em `src/game/**`
- Entity com coluna que não existe no SQL
- Import profundo `@catalog/<feature>/domain` a partir de Game
- Seed massivo dentro de migration de schema sem necessidade

## Relacionado

- Skills: `postgresql-sql`, `typeorm`, `nestjs`, `domain-driven-design`
- Docs: `docs/architecture/sql-layout.md`, `catalog-patterns.md`, `data-model.md`
- Rule: `.cursor/rules/catalog-sql-first.mdc`
