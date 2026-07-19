# Layout por BC

Estado atual do repo + convenções para evitar services inchados. Rule: `application-layer`.

## Catalog (thin)

### Módulo padrão (queries + mapper)

```
src/catalog/classes/
├── classes.module.ts
├── classes.controller.ts
├── classes.mapper.ts
├── queries/
│   ├── find-classes.query.ts
│   ├── find-class-by-slug.query.ts
│   └── …
└── dto/
    └── class-response.dto.ts
```

Entities/views: `src/entities/` e `src/entities/views/`.

Cada `*Query` é `@Injectable()` com um método `execute()`. O controller injeta queries diretamente.

Lookup compartilhado: [`src/catalog/catalog-lookup.service.ts`](../../../src/catalog/catalog-lookup.service.ts).

## Identity

```
src/identity/
├── identity.module.ts
├── auth-user.ts
├── supabase-jwt.service.ts
├── guards/
│   └── supabase-auth.guard.ts
└── decorators/
    └── current-user.decorator.ts
```

## Game (DDD tático + application layer)

Submódulos ativos:

```
src/game/
├── game.module.ts
├── sheet/              # CRUD ficha (CharacterSheetModule)
├── build/              # geração de atributos
├── progression/        # level-up
├── inventory/
├── session/
└── shared/             # PlayerCharacter, CharacterRepository
```

### `sheet/` (padrão a seguir)

```
src/game/sheet/
├── character-sheet.module.ts
├── characters.controller.ts      # HTTP + guard + @CurrentUser
├── application/
│   ├── create-character.handler.ts
│   ├── update-character.handler.ts
│   ├── delete-character.handler.ts
│   ├── list-characters.query.ts
│   └── get-character.query.ts
├── domain/
│   ├── character-domain.service.ts
│   ├── character-sheet.validator.ts
│   └── …
├── infrastructure/
│   ├── character-sheet.repository.ts
│   ├── character.mapper.ts
│   └── …
└── dto/
    └── …
```

Fluxo de escrita:

```
POST /characters
  → CreateCharacterHandler.execute(userId, dto)
  → CatalogLookupService.validateCharacterCatalogRefs()
  → domain / factory
  → CharacterRepository.save()
  → CharacterSheetRepository.sync()
  → CharacterMapper.toDto()
```

Talentos: input/output via **`characterFeats`** (+ `featOptions`). Handlers manuais — sem `@nestjs/cqrs` obrigatório.

## app.module.ts

```typescript
@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot(databaseConfig()),
    IdentityModule,
    HealthModule,
    CatalogModule,
    GameModule,
  ],
})
export class AppModule {}
```
