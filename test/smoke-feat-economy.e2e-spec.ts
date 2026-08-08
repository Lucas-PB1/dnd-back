/**
 * Smoke: catálogo feat economy + personagem com Lucky (se existir).
 * Uso: npx jest --config ./test/jest-e2e.config.js --runInBand smoke-feat-economy
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

describe('smoke feat combat economy', () => {
  let app: INestApplication<App>;
  let db: DataSource;
  let userId: string;

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
  }, 120_000);

  afterAll(async () => {
    await app.close();
  });

  it('exposes feat economy rows and luckPoints grant in catalog/DB', async () => {
    const auth = { 'X-Test-User-Id': userId };

    const catalog = await request(app.getHttpServer())
      .get('/combat-mechanical-catalog')
      .set(auth);
    expect(catalog.status).toBe(200);

    const lucky = catalog.body.economyActions.find(
      (a: { id: string }) => a.id === 'feat-lucky-advantage',
    );
    expect(lucky).toMatchObject({
      featSlug: 'lucky',
      resourceSlug: 'luckPoints',
      economy: 'free',
      tableAction: 'spend-resource',
    });

    const polearm = catalog.body.economyActions.find(
      (a: { id: string }) => a.id === 'feat-polearm-master-haft',
    );
    expect(polearm?.featSlug).toBe('polearm-master');

    const grants = await db.query<{ slug: string }[]>(
      `SELECT rd.slug
       FROM rpg.phb_resource_grant g
       JOIN rpg.phb_resource_definition rd ON rd.id = g.resource_id
       WHERE g.owner_kind = 'feat' AND rd.slug = 'luckPoints'`,
    );
    expect(grants.length).toBe(1);
  });

  it('loads luckPoints on a character that has the Lucky feat', async () => {
    const chars = await db.query<{ id: string }[]>(
      `SELECT c.id
       FROM rpg.player_character c
       JOIN rpg.player_character_feat f ON f.character_id = c.id
       WHERE c.user_id = $1 AND f.feat_slug = 'lucky'
       LIMIT 1`,
      [userId],
    );
    if (!chars[0]) {
      console.warn('No character with lucky feat — skipping resource smoke');
      return;
    }

    const auth = { 'X-Test-User-Id': userId };
    const state = await request(app.getHttpServer())
      .get(`/characters/${chars[0].id}/state`)
      .set(auth);
    expect(state.status).toBe(200);
    const luck = state.body.classResources.find(
      (r: { slug: string }) => r.slug === 'luckPoints',
    );
    expect(luck).toBeDefined();
    expect(luck.max).toBeGreaterThanOrEqual(2);
    expect(luck.remaining).toBe(luck.max);
  });
});
