# Response DTOs

```typescript
export class ClassResponseDto {
  slug: string;
  name: string;
  hitDie: string;
  primaryAbilitySlugs: string[];
  skillChoiceCount: number;
}
```

## Mapeamento

Mapper (`classes.mapper.ts`) mapeia ViewEntity → DTO — **não** expor entity/ORM cru:

```typescript
toDto(row: VPhbClass): ClassResponseDto {
  return {
    slug: row.classSlug,
    name: row.className,
    hitDie: row.hitDie,
    primaryAbilitySlugs: row.primaryAbilitySlugs ?? [],
    skillChoiceCount: row.skillChoiceCount,
  };
}
```

## Naming API

camelCase em JSON; snake_case só no banco. Slug string — sem BIGINT na response.
