/**
 * Smoke: conjura Mísseis gratuitos no Review · Mago.
 * Uso: npx jest --config ./test/jest-e2e.config.js --runInBand smoke-review-mago-mm
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

const OWNER_EMAIL = 'lucasoaresnet@gmail.com';

describe('smoke Review · Mago MM', () => {
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

    const users = await db.query<{ id: string }[]>(
      `SELECT id FROM auth.users WHERE email = $1 LIMIT 1`,
      [OWNER_EMAIL],
    );
    userId = users[0]?.id;
    if (!userId) throw new Error(`User not found: ${OWNER_EMAIL}`);

    const chars = await db.query<{ id: string; subclass_slug: string }[]>(
      `SELECT id, subclass_slug FROM rpg.player_character
       WHERE user_id = $1 AND name = $2 LIMIT 1`,
      [userId, 'Review · Mago'],
    );
    if (!chars[0]) throw new Error('Review · Mago not found');
    characterId = chars[0].id;
    expect(chars[0].subclass_slug).toBe('magic-missile-mage');
  }, 120_000);

  afterAll(async () => {
    await app.close();
  });

  it('casts free magic missile and arms shield', async () => {
    const auth = { 'X-Test-User-Id': userId };

    const rest = await request(app.getHttpServer())
      .post(`/characters/${characterId}/rest`)
      .set(auth)
      .send({ type: 'long' });
    expect(rest.status).toBe(200);

    const arm = await request(app.getHttpServer())
      .post(`/characters/${characterId}/wizard/table-action`)
      .set(auth)
      .send({ actionSlug: 'arm-missile-shield' });
    expect(arm.status).toBe(200);
    expect(arm.body.state.missileShieldArmed).toBe(true);

    const cast = await request(app.getHttpServer())
      .post(`/characters/${characterId}/spells/cast`)
      .set(auth)
      .send({
        spellSlug: 'misseis-magicos',
        freeCastResourceSlug: 'magic-missile-free',
      });

    expect(cast.status).toBe(200);
    expect(cast.body.slotLevelUsed).toBeNull();
    expect(cast.body.note).toMatch(/dardo/i);
    expect(cast.body.note).toMatch(/Escudo de Mísseis/i);
    expect(cast.body.state.missileShieldArmed).toBe(false);

    const free = cast.body.state.classResources.find(
      (r: { slug: string }) => r.slug === 'magic-missile-free',
    );
    expect(free.used).toBeGreaterThanOrEqual(1);
  }, 60_000);

  it('casts spell mastery without spending a slot', async () => {
    const auth = { 'X-Test-User-Id': userId };

    const before = await request(app.getHttpServer())
      .get(`/characters/${characterId}/state`)
      .set(auth);
    expect(before.status).toBe(200);
    const slotsBefore = before.body.spellSlotsRemaining?.['1'] ?? 0;

    const cast = await request(app.getHttpServer())
      .post(`/characters/${characterId}/spells/cast`)
      .set(auth)
      .send({ spellSlug: 'misseis-magicos' });

    expect(cast.status).toBe(200);
    expect(cast.body.slotLevelUsed).toBeNull();
    expect(cast.body.note).toMatch(/Dominância/i);
    expect(cast.body.state.spellSlotsRemaining?.['1'] ?? 0).toBe(slotsBefore);
  }, 60_000);
});
