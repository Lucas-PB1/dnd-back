# Endpoints — referência rápida

Base: `NEXT_PUBLIC_API_URL` · Swagger completo: `{API}/api`

Plano detalhado: [`docs/rpg-web-plan.md`](../../../docs/rpg-web-plan.md#6-mapa-de-rotas-next--api)

## Catálogo (sem auth)

| Método | Path |
|--------|------|
| GET | `/classes`, `/classes/:slug` |
| GET | `/classes/:slug/subclasses`, `/subclasses/:slug`, `/subclasses/:slug/mechanics`, `/subclasses/:slug/spells` |
| GET | `/classes/:slug/spells`, `/classes/:slug/spell-slots`, `/classes/:slug/equipment` |
| GET | `/species`, `/species/:slug`, `/species/:slug/traits` |
| GET | `/backgrounds`, `/backgrounds/:slug`, `/backgrounds/:slug/equipment` |
| GET | `/spells`, `/spells/:slug` |
| GET | `/feats`, `/feats/:slug`, `/feats/:slug/options` |
| GET | `/skills`, `/skills/:slug` |
| GET | `/abilities` |
| GET | `/weapons`, `/weapons/:slug`, `/armor`, `/armor/:slug` |
| GET | `/items`, `/items/:slug` |
| GET | `/alignments`, `/languages`, `/character-levels` |
| GET | `/ability-generation-methods` |

## Game (Bearer JWT)

| Método | Path |
|--------|------|
| GET/POST/PATCH/DELETE | `/characters`, `/characters/:id` |
| POST | `/characters/roll-abilities` |
| GET/POST | `/characters/:id/level-up/preview`, `/characters/:id/level-up` |
| GET/POST/PATCH/DELETE | `/characters/:id/inventory`, `.../inventory/:itemSlug` |
| GET/PATCH | `/characters/:id/state` |
| POST | `/characters/:id/spells/cast`, `/characters/:id/rest` |

## Slugs

Classes/species/etc.: inglês no seed (`fighter`, `wizard`, `dwarf`). Nomes de exibição em **PT** no JSON (`name`).

## Exemplo (RSC)

```typescript
const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/classes/fighter`, {
  next: { revalidate: 3600 },
});
if (!res.ok) throw new Error((await res.json()).message);
const data = await res.json();
```

## Erros

```json
{ "statusCode": 404, "message": "Class 'x' not found", "path": "/classes/x", "timestamp": "..." }
```
