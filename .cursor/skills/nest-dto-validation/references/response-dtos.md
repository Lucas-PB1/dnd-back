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

Service mapeia ViewEntity → DTO (não expor entity diretamente):

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

camelCase em JSON; snake_case só no banco.
