# Variáveis Supabase Auth

## API (Vercel)

| Var | Uso |
|-----|-----|
| `SUPABASE_URL` | `https://xxx.supabase.co` |
| `SUPABASE_JWT_SECRET` | Validar JWT no Nest |
| `SUPABASE_SERVICE_ROLE_KEY` | Só server-side; nunca client |

## Frontend (repo Next — outro repo)

| Var | Uso |
|-----|-----|
| `NEXT_PUBLIC_SUPABASE_URL` | Client SDK |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Client SDK |
| `NEXT_PUBLIC_API_URL` | Base URL desta API Nest |

## .env.example (este repo)

```
DATABASE_URL=
SUPABASE_URL=
SUPABASE_JWT_SECRET=
FRONTEND_URL=http://localhost:3001
PORT=3000
```
