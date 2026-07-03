# TypeORM + Supabase na Vercel

## DATABASE_URL

Usar **transaction pooler** Supabase (porta **6543**):

```
postgresql://postgres.[ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true
```

Dashboard: Settings → Database → Connection string → Transaction pooler

## TypeORM config

```typescript
TypeOrmModule.forRoot({
  type: 'postgres',
  url: process.env.DATABASE_URL,
  schema: 'rpg',
  synchronize: false,
  autoLoadEntities: true,
  extra: {
    max: 1, // pool mínimo em serverless
  },
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
})
```

## Singleton

NestJS `@Global()` + `TypeOrmModule.forRoot` já reutiliza DataSource entre invocações quentes.

## Catálogo

- `synchronize: false` — schema vem de `database/migrations/`
- Entities mapeiam `rpg.phb_*`; views via `@ViewEntity`
