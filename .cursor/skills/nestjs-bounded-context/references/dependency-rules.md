# Regras de dependência

## Permitido

```
catalog → entities/views, config, shared
identity → config, @nestjs/*
game → catalog (CatalogLookupService), identity (guards), TypeORM
```

## Proibido

```
catalog → game
catalog → domain/ com regras de ficha
game → mutação de phb_* via API
identity → game (identity é transversal, não conhece ficha)
```

## CatalogLookupService (futuro, em catalog/)

```typescript
@Injectable()
export class CatalogLookupService {
  async classExists(slug: string): Promise<boolean> { ... }
}
```

Game usa para validar escolhas — não duplica SQL do PHB.

## Comunicação entre BCs

- **Preferir:** injeção de service read-only do catalog
- **Evitar:** importar entities TypeORM de `phb_*` dentro de `game/domain/`
- **Nunca:** event bus entre BCs nesta fase — YAGNI
