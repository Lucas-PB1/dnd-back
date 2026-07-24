# Unit — Catalog queries

Padrão atual: `src/catalog/classes/classes.queries.spec.ts` (não `ClassesService`).

```typescript
describe('Classes queries', () => {
  let findClassBySlug: FindClassBySlugQuery;
  let classesRepo: jest.Mocked<Pick<Repository<VPhbClass>, 'findOne'>>;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findClassOrFail'>>;

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      providers: [
        FindClassBySlugQuery,
        ClassesMapper,
        {
          provide: getRepositoryToken(VPhbClass),
          useValue: { findOne: jest.fn() },
        },
        {
          provide: CatalogLookupService,
          useValue: { findClassOrFail: jest.fn() },
        },
      ],
    }).compile();
    findClassBySlug = module.get(FindClassBySlugQuery);
    // …
  });

  it('findBySlug throws NotFoundException', async () => {
    catalogLookup.findClassOrFail.mockRejectedValue(
      new NotFoundException(`Class 'invalid' not found`),
    );
    await expect(findClassBySlug.execute('invalid')).rejects.toThrow(
      NotFoundException,
    );
  });
});
```

Mock `@InjectRepository` — sem DB real no unit. Slug de amostra: `fighter`.
