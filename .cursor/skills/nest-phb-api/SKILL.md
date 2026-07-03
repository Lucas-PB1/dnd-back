---
name: nest-phb-api
description: Scaffold módulos NestJS read-only para catálogo PHB — controllers, services, rotas por slug. Use quando criar endpoints de API para classes, magias, espécies ou antecedentes.
---

# API PHB read-only

## Workflow

1. [`module-structure.md`](references/module-structure.md) — organização por domínio
2. [`read-only-endpoints.md`](references/read-only-endpoints.md) — padrão GET
3. [`slug-routing.md`](references/slug-routing.md) — URLs com slug

## Padrão por recurso

```
catalog/<recurso>/
├── <recurso>.module.ts
├── <recurso>.controller.ts
├── <recurso>.service.ts
└── dto/
    └── <recurso>-response.dto.ts
```

## Endpoints

- `GET /<recurso>` — lista (paginação opcional)
- `GET /<recurso>/:slug` — detalhe

Sem POST/PATCH/DELETE em catálogo sem aprovação explícita.
