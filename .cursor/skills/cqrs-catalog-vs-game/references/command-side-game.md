# Command side — Game (futuro)

## Fluxo

```
POST /characters
  → @UseGuards(SupabaseAuthGuard)
  → CreateCharacterHandler
  → Character.create(props)   // aggregate
  → CharacterRepository.save()
  → Postgres player_character + RLS
  → CharacterResponseDto
```

## Características

- Valida invariantes no **aggregate** (ex.: nível 1–20, soma atributos método)
- Referência PHB: `classSlug`, `speciesSlug` — validar via CatalogLookupService
- Um command = uma transação
- Erros de domínio → 400; auth → 401; not found → 404

## Queries no Game

GET ficha pode ser:
- Query handler leve (projeção DTO), ou
- Read model denormalizado depois — **não** precisa agregado para GET simples

## RLS

Insert/update com JWT do usuário; Postgres garante `user_id = auth.uid()`.
