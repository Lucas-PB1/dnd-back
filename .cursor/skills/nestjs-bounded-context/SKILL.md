---
name: nestjs-bounded-context
description: Cria módulos NestJS por bounded context (Catalog, Identity, Game) com limites de dependência. Use ao adicionar features, pastas em src/ ou decidir onde colocar código novo.
---

# NestJS — bounded contexts

Doc: [`docs/architecture.md`](../../../docs/architecture.md)

## Referências

- [`module-layout.md`](references/module-layout.md)
- [`dependency-rules.md`](references/dependency-rules.md)
- [`new-feature-checklist.md`](references/new-feature-checklist.md)

## Onde colocar código novo

| Pergunta | BC | Pasta |
|----------|-----|-------|
| Expõe dado PHB read-only? | Catalog | `src/catalog/<recurso>/` |
| Valida JWT / usuário? | Identity | `src/identity/` |
| Ficha, campanha, inventário? | Game | `src/game/<recurso>/` |

## Workflow

1. Identificar BC → [`dependency-rules.md`](references/dependency-rules.md)
2. Criar módulo Nest → [`module-layout.md`](references/module-layout.md)
3. Registrar em `app.module.ts` ou módulo pai do BC
4. Checklist → [`new-feature-checklist.md`](references/new-feature-checklist.md)
