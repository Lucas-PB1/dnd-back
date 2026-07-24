## Variáveis de Auth + DB

### API (este repo)

| Var | Uso |
|-----|-----|
| `SUPABASE_URL` | JWKS + issuer (ES256) |
| `DATABASE_URL` | TypeORM — local ou pooler **6543** + `pgbouncer=true` |
| `SUPABASE_DATABASE_URL` | Migrations/seeds (5432) |
| `FRONTEND_URL` | CORS |
| `SUPABASE_SERVICE_ROLE_KEY` | Só server-side; nunca client |

### Frontend (`dnd-front`)

| Var | Uso |
|-----|-----|
| `NEXT_PUBLIC_SUPABASE_URL` | Client SDK |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Client SDK |
| `NEXT_PUBLIC_API_URL` | Base desta API |

Ver também [`pooler-and-env.md`](pooler-and-env.md).
