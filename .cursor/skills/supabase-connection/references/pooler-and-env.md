# Pooler e variáveis

## Connection strings

| Modo | Porta | Uso |
|------|-------|-----|
| Direct | 5432 | Migrations locais, psql |
| Transaction pooler | **6543** | TypeORM / Nest / Vercel |
| Session pooler | 5432 | Evitar com TypeORM |

## DATABASE_URL (app)

```
postgresql://postgres.[project-ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true
```

## Env vars

| Var | Onde | Uso |
|-----|------|-----|
| `DATABASE_URL` | Backend Nest, Vercel | App runtime (local ou pooler 6543) |
| `SUPABASE_DATABASE_URL` | `.env` local, CI | Migrations/seeds direct 5432 |
| `SUPABASE_SERVICE_ROLE_KEY` | Só backend, nunca client | Admin API (futuro) |
| `SUPABASE_ANON_KEY` | Frontend (fase futura) | Client SDK |

## .env.example

```
DATABASE_URL=
SUPABASE_DATABASE_URL=
SUPABASE_URL=
PORT=3000
NODE_ENV=development
```

Nunca commitar `.env`.
