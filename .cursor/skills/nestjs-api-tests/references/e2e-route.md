# E2E — rota

```typescript
describe('ClassesController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const module = await Test.createTestingModule({ imports: [AppModule] }).compile();
    app = module.createNestApplication();
    await app.init();
  });

  afterAll(() => app.close());

  it('GET /classes', () => request(app.getHttpServer()).get('/classes').expect(200));

  it('GET /classes/fighter', () =>
    request(app.getHttpServer()).get('/classes/fighter').expect(200));

  it('GET /classes/invalid returns 404', () =>
    request(app.getHttpServer()).get('/classes/invalid').expect(404));
});
```

Requer `DATABASE_URL` com catálogo aplicado ou módulo de teste com mock.

Config: `test/jest-e2e.json`
