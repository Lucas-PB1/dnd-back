# Command side — Game

## Fluxo

```
POST /characters
  → @UseGuards(SupabaseAuthGuard)
  → CreateCharacterHandler (game/sheet/application/)
  → CatalogLookupService + domain/factory
  → CharacterRepository.save()
  → CharacterSheetRepository.sync()
  → CharacterMapper.toDto()
```

## Características

- Invariantes em `game/<submodulo>/domain/` (nível, HP, feats, AC)
- Referência PHB: `classSlug`, `speciesSlug`, … via `CatalogLookupService`
- Talentos: **`characterFeats`** + **`featOptions`**
- Um command = uma transação lógica (save ficha + sync sheet)
- Erros de domínio → 400; auth → 401; not found → 404

## Queries no Game

GET ficha: `GetCharacterQuery` / `ListCharactersQuery` → repository + mapper.

## Auth / ownership

JWT Supabase; API garante `user_id` do personagem = usuário autenticado.
