# Rotas por slug

## URL

```
GET /classes/guerreiro
GET /spells/bola-de-fogo
GET /species/elfo
```

## Parâmetro

```typescript
@Get(':slug')
findOne(@Param('slug') slug: string)
```

## Query

```typescript
await repo.findOne({ where: { classSlug: slug } });
// ou
await repo.findOneBy({ class_slug: slug }); // se coluna snake_case
```

## Slug vs id

- **Nunca** expor `id` BIGINT na URL pública
- Slug é estável e legível (PT-BR, kebab-case)

## 404

```typescript
if (!entity) throw new NotFoundException(`Class '${slug}' not found`);
```
