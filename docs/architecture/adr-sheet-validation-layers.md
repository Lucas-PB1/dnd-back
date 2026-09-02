# ADR: camadas de validação da ficha (`sheet`)

## Status

Aceito — 2026-09-01 (Fase 3.6)

## Contexto

Validators de create/update da ficha vivem em `sheet/domain/validation/` como services Nest (`@Injectable`, `BadRequestException`). Até a Fase 3.4–3.5, ~18 arquivos usavam `dataSource.query` inline — duplicando JOINs já cobertos por views TypeORM e fugindo do padrão de leitura runtime ([`catalog-patterns.md` §10](./catalog-patterns.md#10-runtime-game-reads)).

Duas opções estavam em aberto ([`code-health-audit.md` §5](../plans/code-health-audit.md#5-solid--domain-híbrido)):

1. **Mover** validators inteiros para `sheet/infrastructure/validation/` (ports/adapters).
2. **Extrair** regras puras + adapter Nest fino, mantendo orquestração no domain.

Mover pasta inteira teria alto custo de wiring Nest/module paths **depois** de já ter isolado o I/O — sem ganho proporcional para pré-prod.

## Decisão

Adotar **separação por responsabilidade**, não por mover a pasta:

| Camada | Pasta | Responsabilidade |
|--------|-------|------------------|
| **Regras puras** | `sheet/domain/validation/**` (helpers irmãos: `*-slots.ts`, `*-options.ts`, `assert-*.ts`) | Slots, whitelist, asserts sem I/O |
| **Orquestração Nest** | `sheet/domain/validation/**` (`*.validator.ts`) | `@Injectable`, fluxo por concern, `BadRequestException` |
| **Leitura catálogo/DB** | `sheet/infrastructure/queries/*.queries.ts` | TypeORM `@ViewEntity` / entities; **zero** `dataSource.query` cru |
| **Lookup fino de escrita** | `CatalogLookupService` + queries catalog | Existe slug? (unificar na Fase 4.5) |

**Validators permanecem em `domain/validation/`** — são orquestradores de regra de negócio da ficha, não adapters de persistência.

**SQL / repositório não entra no domain.** Validators injetam `DataSource` ou queries catalog **apenas** para chamar funções em `infrastructure/queries/` (ou `ClassProficienciesQuery` exportado pelo catalog).

### Módulos de query (SSOT pós 3.4–3.5)

| Arquivo | Uso |
|---------|-----|
| `spell-progression.queries.ts` | Cotas / slots de magia |
| `feat-option.queries.ts` | Feat options, fighting style, skill/tool |
| `spell-catalog.queries.ts` | Magia por classe, nível, escola, sangromancy |
| `background-origin.queries.ts` | Perícias/idiomas fixos do antecedente |
| `skill-catalog.queries.ts` | Perícias e pool de classe |
| `metamagic-catalog.queries.ts` | Catálogo metamagic |
| `eldritch-invocation.queries.ts` | Invocações + feats de origem |
| `class-meta.queries.ts` | Subclass unlock, weapon mastery progression |
| `class-option.queries.ts` | Opções class/subclass, peça de arma |

Specs: `*.queries.spec.ts` (smoke TypeORM); validators mockam queries ou `getRepository`, não re-testam SQL.

### O que **não** fazer

- Novo `dataSource.query` em `domain/validation/` ou application handlers.
- Pasta `sheet/infrastructure/validation/` espelhando validators (rejeitado por ora).
- Duplicar JOIN de catálogo no TS quando existe view `v_phb_*` ou entity.

### Evolução permitida (sem ADR novo)

- Extrair função pura de um validator quando o arquivo passar de 200 linhas ou precisar de teste sem DB.
- Mover **um** validator para infrastructure só se virar adapter puro (sem regra D&D) — caso excepcional, documentar no PR.

## Consequências

- **Positivas:** inventário validators com **0** SQL cru; matriz runtime alinhada; testes de query isolados.
- **Aceitas:** domain continua acoplado a Nest + TypeORM na borda (pragmático para monolith Nest).
- **Backlog:** `CatalogLookupService` vs catalog queries → Fase 4.5; `level-up.service.ts` ainda com SQL cru (migrar ao tocar).

## Referências

- [`code-standards.md`](./code-standards.md) — layout `validation/` + queries
- [`catalog-patterns.md` §10](./catalog-patterns.md#10-runtime-game-reads)
- [`code-health-audit.md` § Inventário validators](../plans/code-health-audit.md#inventário-sql-cru--validators-fase-30)
