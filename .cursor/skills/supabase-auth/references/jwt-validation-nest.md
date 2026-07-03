# JWT no NestJS

## Header

```
Authorization: Bearer <supabase_access_token>
```

## Guard (fase futura)

```typescript
@Injectable()
export class SupabaseAuthGuard implements CanActivate {
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest();
    const token = req.headers.authorization?.replace('Bearer ', '');
    if (!token) throw new UnauthorizedException();
    // Validar com jose + JWKS ({SUPABASE_URL}/auth/v1/.well-known/jwks.json)
    const payload = await verifySupabaseJwt(token);
    req.user = { id: payload.sub, email: payload.email };
    return true;
  }
}
```

## Rotas

| Tipo | Guard |
|------|-------|
| `GET /classes`, `/spells`, … | Nenhum (público) |
| `/characters`, `/campaigns` (futuro) | `SupabaseAuthGuard` |

## Pacotes sugeridos

- `jose` ou `@nestjs/passport` + estratégia custom
- Não usar service role para validar token de usuário
