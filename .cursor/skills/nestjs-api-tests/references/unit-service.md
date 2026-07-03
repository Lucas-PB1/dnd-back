# Unit — service

```typescript
describe('ClassesService', () => {
  let service: ClassesService;
  let repo: jest.Mocked<Repository<VPhbClass>>;

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      providers: [
        ClassesService,
        { provide: getRepositoryToken(VPhbClass), useValue: { find: jest.fn(), findOne: jest.fn() } },
      ],
    }).compile();
    service = module.get(ClassesService);
    repo = module.get(getRepositoryToken(VPhbClass));
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
```

Mock `@InjectRepository` — não precisa DB real para unit.
