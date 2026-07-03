# Env vars — repo Next.js (separado)

Criar no repo frontend, não aqui.

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
NEXT_PUBLIC_API_URL=http://localhost:3000
```

## Produção

```
NEXT_PUBLIC_API_URL=https://sua-api.vercel.app
```

## Auth flow

1. `supabase.auth.signInWithPassword()` no Next
2. `session.access_token` → header nas rotas protegidas da API
3. Catálogo: fetch direto sem token
