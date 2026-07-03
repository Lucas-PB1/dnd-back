# CORS, sessões e proxy

## CORS

Frontend separado exige CORS explícito:

```typescript
app.enableCors({
  origin: process.env.FRONTEND_URL ?? true,
  credentials: true,
});
```

## Trust proxy

Se usar cookies/sessões no futuro:

```typescript
app.set('trust proxy', 1);
```

## Sessões

- **Não** usar sessão in-memory na Vercel
- `express-session` + store externo (Redis, Supabase)
- Múltiplas instâncias serverless = conflito sem store compartilhado

## Cookies cross-origin

Frontend deve enviar `credentials: 'include'` se usar cookies.

## Este projeto (fase 2)

Catálogo read-only — **sem sessão necessária** por enquanto. CORS básico suficiente.
