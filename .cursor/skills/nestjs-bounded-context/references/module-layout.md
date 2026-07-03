# Layout por BC

## Catalog (thin)

```
src/catalog/spells/
├── spells.module.ts
├── spells.controller.ts
├── spells.service.ts
└── dto/
    └── spell-response.dto.ts
```

Entities: `src/entities/views/v-phb-spell.entity.ts`

## Identity

```
src/identity/
├── identity.module.ts
├── guards/
│   └── supabase-auth.guard.ts
└── decorators/
    └── current-user.decorator.ts
```

## Game (futuro — DDD tático)

```
src/game/characters/
├── characters.module.ts
├── domain/
│   ├── character.aggregate.ts
│   └── value-objects/
├── application/
│   ├── create-character.handler.ts
│   └── get-character.query.ts
├── infrastructure/
│   ├── character.entity.ts
│   └── character.repository.ts
└── characters.controller.ts
```

## app.module.ts

```typescript
@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot(databaseConfig()),
    CatalogModule,
    // IdentityModule,  // fase auth
    // GameModule,      // fase fichas
  ],
})
export class AppModule {}
```
