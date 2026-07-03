# Endpoints (catálogo)

Base: `NEXT_PUBLIC_API_URL`

| Método | Path | Auth |
|--------|------|------|
| GET | `/classes` | Não |
| GET | `/classes/:slug` | Não |
| GET | `/spells` | Não (futuro) |
| GET | `/spells/:slug` | Não (futuro) |

## Slugs

Ingleses no seed (`fighter`, `wizard`) — `name` em PT na resposta.

## Exemplo Next

```typescript
const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/classes/fighter`);
const data = await res.json();
```

## Erros

```json
{ "message": "Class 'x' not found", "statusCode": 404 }
```
