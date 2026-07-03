# Exemplos

## Query — listar classes (implementado)

```typescript
// catalog/classes/classes.service.ts
async findAll(): Promise<ClassResponseDto[]> {
  const rows = await this.classesRepo.find({ order: { className: 'ASC' } });
  return rows.map((row) => this.toDto(row));
}
```

Read model: `rpg.v_phb_class` · Sem command · Sem aggregate

## Query — magias do mago (futuro)

```sql
SELECT * FROM rpg.v_spell_by_class WHERE class_slug = 'wizard';
```

Service retorna DTO; lógica de join está na view.

## Command — criar personagem (futuro)

```typescript
// game/characters/application/create-character.handler.ts
async execute(cmd: CreateCharacterCommand): Promise<string> {
  await this.catalog.assertClassExists(cmd.classSlug);
  const character = Character.create({
    userId: cmd.userId,
    name: cmd.name,
    classSlug: cmd.classSlug,
    speciesSlug: cmd.speciesSlug,
  });
  await this.repo.save(character);
  return character.id;
}
```

Invariantes (nome não vazio, slugs válidos) no aggregate + catalog lookup.

## Anti-pattern

```typescript
// ❌ Reimplementar tabela de magias em TS
const spells = HARDCODED_SPELL_LIST.filter(...);

// ✅ Usar view
const spells = await this.spellViewRepo.find({ where: { classSlug: 'wizard' } });
```
