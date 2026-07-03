# Layout por BC

Estado atual do repo + convenções para evitar services inchados. Rule: `application-layer`.

## Catalog (thin)

### Módulo simples (padrão atual)

```
src/catalog/spells/
├── spells.module.ts
├── spells.controller.ts
├── spells.service.ts          # < ~80 linhas
└── dto/
    └── spell-response.dto.ts
```

Entities: `src/entities/views/v-phb-spell.entity.ts`

### Módulo com rotas aninhadas (convenção futura)

Quando o service passar de ~80 linhas ou tiver 3+ repos — extrair:

```
src/catalog/classes/
├── classes.module.ts
├── classes.controller.ts
├── classes.mapper.ts                    # toClassDto, toSubclassDto, …
├── queries/
│   ├── find-class-by-slug.query.ts
│   ├── find-class-subclasses.query.ts
│   ├── find-class-spells.query.ts
│   ├── find-class-spell-slots.query.ts
│   ├── find-class-equipment.query.ts
│   └── find-class-skills.query.ts
└── dto/
    └── class-response.dto.ts
```

Cada `*Query` é `@Injectable()` com um método `execute()`. O controller injeta queries diretamente ou um facade fino que só delega.

**Estado atual (ainda monolítico):** [`src/catalog/classes/classes.service.ts`](../../../src/catalog/classes/classes.service.ts) — candidato a refatoração quando incomodar.

Lookup compartilhado: [`src/catalog/catalog-lookup.service.ts`](../../../src/catalog/catalog-lookup.service.ts) (`assertClassSlug`, etc.).

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

### Estado atual (fase 5 — service monolítico)

```
src/game/characters/
├── characters.module.ts
├── characters.controller.ts
├── characters.service.ts       # refatorar na fase 6
├── characters.application.spec.ts
├── player-character.entity.ts
└── dto/
    ├── create-character.dto.ts
    ├── update-character.dto.ts
    └── character-response.dto.ts
```

### Alvo (fase 6 — handlers + domain)

```
src/game/characters/
├── characters.module.ts
├── characters.controller.ts      # HTTP + guard + @CurrentUser apenas
├── application/
│   ├── create-character.handler.ts
│   ├── update-character.handler.ts
│   ├── delete-character.handler.ts
│   └── list-characters.query.ts
├── domain/
│   ├── character.aggregate.ts
│   └── value-objects/
│       ├── ability-scores.vo.ts
│       └── hit-points.vo.ts
├── infrastructure/
│   ├── player-character.entity.ts
│   ├── character.repository.ts   # findOwnedOrFail, save, remove
│   └── character.mapper.ts
└── dto/
    └── …
```

Fluxo de escrita:

```
POST /characters
  → CreateCharacterHandler.execute(dto, userId)
  → CatalogLookupService.validateCharacterCatalogRefs()
  → Character.create(props)                    // domain
  → CharacterRepository.save()
  → CharacterMapper.toDto()
```

Handlers manuais — sem `@nestjs/cqrs` obrigatório.

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
