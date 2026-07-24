# Rotas por slug

## URL (exemplos reais do seed)

```
GET /classes/fighter
GET /spells/bola-de-fogo
GET /species/dwarf
GET /armor/leather-armor
GET /weapons/longsword
```

| Recurso | Convenção de slug no banco |
|---------|----------------------------|
| Classes, species, backgrounds, items, armor, weapons | **EN** kebab (`fighter`, `dwarf`, `leather-armor`) |
| Magias (muitas) | **PT** kebab (`bola-de-fogo`) |
| Atributos | **PT** sem acento (`forca`, `destreza`) |

Nome de exibição (`name`) vem em **PT** no JSON.

## Parâmetro

```typescript
@Get(':slug')
findOne(@Param('slug') slug: string)
```

## Query

Preferir queries injetáveis (`FindClassBySlugQuery.execute(slug)`), não services inchados.

## Slug vs id

- **Nunca** expor `id` BIGINT na URL pública
- Slug é estável e legível

## 404

```typescript
if (!entity) throw new NotFoundException(`Class '${slug}' not found`);
```
