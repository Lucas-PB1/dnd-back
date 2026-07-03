# Endpoints read-only

## Controller padrão

```typescript
@Controller('classes')
export class ClassesController {
  constructor(private readonly service: ClassesService) {}

  @Get()
  findAll() {
    return this.service.findAll();
  }

  @Get(':slug')
  findOne(@Param('slug') slug: string) {
    return this.service.findBySlug(slug);
  }
}
```

## Service

- Query via `@ViewEntity` ou QueryBuilder na view `v_phb_*`
- Lançar `NotFoundException` se slug não existir
- Sem mutação de dados PHB

## Views preferidas

| Recurso | View |
|---------|------|
| Classes | `v_phb_class` |
| Magias | `v_phb_spell` |
| Subclasses | `v_phb_subclass` |
| Antecedentes | `v_phb_background` |
