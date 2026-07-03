# CORS — Nest para Next externo

## main.ts

```typescript
app.enableCors({
  origin: process.env.FRONTEND_URL ?? 'http://localhost:3001',
  credentials: true,
  methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE', 'OPTIONS'],
});
```

## Vercel

- `FRONTEND_URL` = domínio do Next na Vercel (ex. `https://rpg-web.vercel.app`)
- Preview: adicionar URL de preview ou regex se necessário

## Local

- API: `localhost:3000`
- Next: `localhost:3001` (porta típica separada)

## Preflight

Vercel proxy exige métodos e headers explícitos para POST/PATCH futuros.
