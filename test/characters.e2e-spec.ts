import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { HttpExceptionFilter } from '../src/common/filters/http-exception.filter';
import { SupabaseAuthGuard } from '../src/identity/guards/supabase-auth.guard';
import { TestAuthGuard } from './helpers/test-auth.guard';

const TEST_USER_ID = '11111111-1111-1111-1111-111111111111';
const OTHER_USER_ID = '22222222-2222-2222-2222-222222222222';

describe('Characters API (e2e)', () => {
  let app: INestApplication<App>;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    })
      .overrideGuard(SupabaseAuthGuard)
      .useClass(TestAuthGuard)
      .compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalFilters(new HttpExceptionFilter());
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        transform: true,
        transformOptions: { enableImplicitConversion: true },
      }),
    );
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  const auth = (userId = TEST_USER_ID) => ({ 'X-Test-User-Id': userId });

  it('GET /characters without auth returns 401', () =>
    request(app.getHttpServer()).get('/characters').expect(401));

  it('POST /characters creates a character', async () => {
    const res = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'E2E Hero',
        classSlug: 'fighter',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
      })
      .expect(201);

    expect(res.body.name).toBe('E2E Hero');
    expect(res.body.classSlug).toBe('fighter');
    return res.body.id as string;
  });

  it('GET /characters lists user characters', async () => {
    await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'List Test',
        classSlug: 'wizard',
        speciesSlug: 'elf',
        backgroundSlug: 'acolyte',
      })
      .expect(201);

    const res = await request(app.getHttpServer())
      .get('/characters')
      .set(auth())
      .expect(200);

    expect(Array.isArray(res.body)).toBe(true);
    expect(res.body.length).toBeGreaterThan(0);
  });

  it('PATCH and DELETE character lifecycle', async () => {
    const created = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Lifecycle',
        classSlug: 'fighter',
        speciesSlug: 'human',
        backgroundSlug: 'acolyte',
        alignmentSlug: 'neutral-good',
      })
      .expect(201);

    const id = created.body.id as string;

    await request(app.getHttpServer())
      .patch(`/characters/${id}`)
      .set(auth())
      .send({ name: 'Lifecycle Updated', level: 2 })
      .expect(200)
      .expect((res) => {
        expect(res.body.name).toBe('Lifecycle Updated');
        expect(res.body.level).toBe(2);
      });

    await request(app.getHttpServer()).delete(`/characters/${id}`).set(auth()).expect(204);

    await request(app.getHttpServer()).get(`/characters/${id}`).set(auth()).expect(404);
  });

  it('GET /characters/:id returns 403 for another user', async () => {
    const created = await request(app.getHttpServer())
      .post('/characters')
      .set(auth(TEST_USER_ID))
      .send({
        name: 'Private',
        classSlug: 'fighter',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
      })
      .expect(201);

    await request(app.getHttpServer())
      .get(`/characters/${created.body.id}`)
      .set(auth(OTHER_USER_ID))
      .expect(403);
  });

  it('POST /characters with invalid class returns 400', () =>
    request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Bad',
        classSlug: 'invalid-class',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
      })
      .expect(400));
});
