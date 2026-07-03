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

  it('GET /backgrounds/invalid returns 404', () =>
    request(app.getHttpServer()).get('/backgrounds/invalid').expect(404));
});
