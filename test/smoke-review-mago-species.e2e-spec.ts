/**
 * Smoke: Review · Mago (anão) tem stonecunning + economy species.
 * Uso: npx jest --config ./test/jest-e2e.config.js --runInBand smoke-review-mago-species
 */
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { HttpExceptionFilter } from '../src/common/filters/http-exception.filter';
import { SupabaseAuthGuard } from '../src/identity/guards/supabase-auth.guard';
import { TestAuthGuard } from './helpers/test-auth.guard';
import { LoadCombatMechanicalCatalog } from '../src/game/combat/application/load-combat-mechanical-catalog';

const OWNER_EMAIL = 'lucasoaresnet@gmail.com';

describe('smoke Review · Mago species economy', () => {
  let app: INestApplication<App>;
  let db: DataSource;
  let userId: string;
  let characterId: string;

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
    db = app.get(DataSource);
    app.get(LoadCombatMechanicalCatalog).clearCache();

    const users = await db.query<{ id: string }[]>(
      `SELECT id FROM auth.users WHERE email = $1 LIMIT 1`,
      [OWNER_EMAIL],
    );
    userId = users[0]?.id;
    if (!userId) throw new Error(`User not found: ${OWNER_EMAIL}`);

    const chars = await db.query<{ id: string; species_slug: string }[]>(
      `SELECT id, species_slug FROM rpg.player_character
       WHERE user_id = $1 AND name = $2 LIMIT 1`,
      [userId, 'Review · Mago'],
    );
    if (!chars[0]) throw new Error('Review · Mago not found');
    characterId = chars[0].id;
    expect(chars[0].species_slug).toBe('dwarf');
  }, 120_000);

  afterAll(async () => {
    await app.close();
  });

  it('exposes stonecunning resource and dwarf economy action', async () => {
    const auth = { 'X-Test-User-Id': userId };

    const state = await request(app.getHttpServer())
      .get(`/characters/${characterId}/state`)
      .set(auth);
    expect(state.status).toBe(200);
    const stone = state.body.classResources.find(
      (r: { slug: string }) => r.slug === 'stonecunning',
    );
    expect(stone).toBeDefined();
    expect(stone.max).toBeGreaterThanOrEqual(2);
    expect(stone.remaining).toBe(stone.max);

    const sheet = await request(app.getHttpServer())
      .get(`/characters/${characterId}`)
      .set(auth);
    expect(sheet.status).toBe(200);
    expect(
      (sheet.body.classCombatNotes as string[]).some((n) =>
        /Visão no Escuro 36/i.test(n),
      ),
    ).toBe(true);

    const catalog = await request(app.getHttpServer())
      .get('/combat-mechanical-catalog')
      .set(auth);
    expect(catalog.status).toBe(200);
    const dwarfAction = catalog.body.economyActions.find(
      (a: { id: string }) => a.id === 'species-dwarf-stonecunning',
    );
    expect(dwarfAction?.speciesSlug).toBe('dwarf');
    expect(dwarfAction?.economy).toBe('bonus');
  }, 60_000);

  it('spends stonecunning via spend-resource path', async () => {
    const auth = { 'X-Test-User-Id': userId };

    const spend = await request(app.getHttpServer())
      .post(`/characters/${characterId}/resources/use`)
      .set(auth)
      .send({ resourceSlug: 'stonecunning', amount: 1 });
    expect(spend.status).toBe(200);
    const resources =
      spend.body.classResources ?? spend.body.state?.classResources;
    const stone = resources.find(
      (r: { slug: string }) => r.slug === 'stonecunning',
    );
    expect(stone.used).toBeGreaterThanOrEqual(1);
  }, 60_000);
});
