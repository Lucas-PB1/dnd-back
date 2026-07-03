---
name: nest-dto-validation
description: DTOs de resposta NestJS alinhados ao schema PHB — paginação, filtros por slug, class-validator. Use quando definir contratos de API ou validar responses.
---

# DTOs de API

## Referências

- [`response-dtos.md`](references/response-dtos.md)
- [`pagination-filters.md`](references/pagination-filters.md)

## Princípios

- DTOs de **resposta** espelham views ou subset seguro
- Slug string, não expor id BIGINT
- `class-validator` em query params quando aplicável
