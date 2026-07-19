# Exemplos

## Query — listar classes (implementado)

```typescript
// catalog/classes/queries/find-classes.query.ts
async execute(page: number, limit: number, q?: string): Promise<PaginatedResponse<ClassResponseDto>> {
  // QueryBuilder na view + mapper.toDto
}
```

Read model: `rpg.v_phb_class` · Sem command · Sem aggregate

## Query — magias do mago (implementado)

```sql
SELECT * FROM rpg.v_spell_by_class WHERE class_slug = 'wizard';
```

`FindClassSpellsQuery` / views equivalentes; lógica de join na view.

## Command — criar personagem (implementado)

```typescript
// game/sheet/application/create-character.handler.ts
async execute(userId: string, dto: CreateCharacterDto): Promise<CharacterResponseDto> {
  await this.catalogLookup.validateCharacterCatalogRefs({ ... });
  const characterFeats = resolveBackgroundOriginCharacterFeats(background, dto.characterFeats);
  // factory → save → sheetRepository.sync → mapper.toDto
}
```

Talentos via **`characterFeats`** (instâncias indexadas), não lista plana de slugs.

## Anti-pattern

```typescript
// ❌ Reimplementar tabela de magias em TS
const spells = HARDCODED_SPELL_LIST.filter(...);

// ✅ Usar view
const spells = await this.spellViewRepo.find({ where: { classSlug: 'wizard' } });
```
