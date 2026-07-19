# JWT no NestJS

## Header

```
Authorization: Bearer <supabase_access_token>
```

## Guard (implementado)

`src/identity/guards/supabase-auth.guard.ts` + `supabase-jwt.service.ts` (JWKS).

```typescript
@UseGuards(SupabaseAuthGuard)
@Get(':id')
async get(@CurrentUser() user: AuthUser, @Param('id') id: string) { ... }
```

## Rotas

| Tipo | Guard |
|------|-------|
| `GET /classes`, `/spells`, … | Nenhum (público) |
| `/characters`, inventory, session, level-up, roll-abilities | `SupabaseAuthGuard` |

## Pacotes

- Validação via JWKS (`jose` / implementação em `SupabaseJwtService`)
- Não usar service role para validar token de usuário
