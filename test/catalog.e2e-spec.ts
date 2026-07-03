import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { HttpExceptionFilter } from '../src/common/filters/http-exception.filter';

describe('Catalog API (e2e)', () => {
  let app: INestApplication<App>;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalFilters(new HttpExceptionFilter());
    app.useGlobalPipes(
      new ValidationPipe({ whitelist: true, transform: true, transformOptions: { enableImplicitConversion: true } }),
    );
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('GET /health', () =>
    request(app.getHttpServer())
      .get('/health')
      .expect(200)
      .expect((res) => {
        expect(res.body.status).toBeDefined();
      }));

  it('GET /classes returns paginated list', () =>
    request(app.getHttpServer())
      .get('/classes')
      .expect(200)
      .expect((res) => {
        expect(res.body.data).toBeInstanceOf(Array);
        expect(res.body.meta.total).toBeGreaterThanOrEqual(12);
      }));

  it('GET /classes/fighter', () =>
    request(app.getHttpServer()).get('/classes/fighter').expect(200));

  it('GET /classes/fighter/subclasses', () =>
    request(app.getHttpServer())
      .get('/classes/fighter/subclasses')
      .expect(200)
      .expect((res) => {
        expect(res.body.data).toBeInstanceOf(Array);
        expect(res.body.meta.total).toBeGreaterThanOrEqual(4);
        expect(res.body.data.some((s: { slug: string }) => s.slug === 'champion')).toBe(true);
      }));

  it('GET /classes/invalid-slug/subclasses returns 404', () =>
    request(app.getHttpServer())
      .get('/classes/invalid-slug/subclasses')
      .expect(404));

  it('GET /classes/invalid returns 404 with body', () =>
    request(app.getHttpServer())
      .get('/classes/invalid-slug')
      .expect(404)
      .expect((res) => {
        expect(res.body.statusCode).toBe(404);
        expect(res.body.path).toContain('/classes/invalid-slug');
      }));

  it('GET /species', () =>
    request(app.getHttpServer())
      .get('/species')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(10);
      }));

  it('GET /species/dwarf', () =>
    request(app.getHttpServer()).get('/species/dwarf').expect(200));

  it('GET /backgrounds/acolyte', () =>
    request(app.getHttpServer()).get('/backgrounds/acolyte').expect(200));

  it('GET /backgrounds/acolyte/equipment', () =>
    request(app.getHttpServer())
      .get('/backgrounds/acolyte/equipment')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.length).toBeGreaterThan(0);
      }));

  it('GET /spells returns paginated list', () =>
    request(app.getHttpServer())
      .get('/spells')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(391);
      }));

  it('GET /spells/alarme', () =>
    request(app.getHttpServer()).get('/spells/alarme').expect(200));

  it('GET /classes/wizard/spells?maxLevel=1', () =>
    request(app.getHttpServer())
      .get('/classes/wizard/spells?maxLevel=1')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.every((s: { level: number }) => s.level <= 1)).toBe(true);
      }));

  it('GET /classes/wizard/spell-slots', () =>
    request(app.getHttpServer())
      .get('/classes/wizard/spell-slots')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThanOrEqual(20);
      }));

  it('GET /classes/fighter/equipment', () =>
    request(app.getHttpServer())
      .get('/classes/fighter/equipment')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.length).toBeGreaterThan(0);
      }));

  it('GET /classes/fighter/skills', () =>
    request(app.getHttpServer())
      .get('/classes/fighter/skills')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
      }));

  it('GET /feats/alert', () =>
    request(app.getHttpServer()).get('/feats/alert').expect(200));

  it('GET /skills/athletics', () =>
    request(app.getHttpServer()).get('/skills/athletics').expect(200));

  it('GET /abilities', () =>
    request(app.getHttpServer())
      .get('/abilities')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBe(6);
      }));

  it('GET /weapons/longsword', () =>
    request(app.getHttpServer()).get('/weapons/longsword').expect(200));

  it('GET /armor/leather', () =>
    request(app.getHttpServer()).get('/armor/leather').expect(200));

  it('GET /species/dwarf/traits', () =>
    request(app.getHttpServer())
      .get('/species/dwarf/traits')
      .expect(200)
      .expect((res) => {
        expect(res.body.meta.total).toBeGreaterThan(0);
      }));

  it('GET /species/elf/trait-choices', () =>
    request(app.getHttpServer())
      .get('/species/elf/trait-choices')
      .expect(200)
      .expect((res) => {
        expect(res.body.data.length).toBeGreaterThan(0);
      }));

  it('GET /backgrounds/invalid returns 404', () =>
    request(app.getHttpServer()).get('/backgrounds/invalid').expect(404));
});
