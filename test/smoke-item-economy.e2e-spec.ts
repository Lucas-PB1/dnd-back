/**
 * Smoke: catálogo item economy + personagem com anel ativo (se existir).
 * Uso: npx jest --config ./test/jest-e2e.config.js --runInBand smoke-item-economy
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

describe('smoke item combat economy', () => {
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

  it('exposes item economy rows and ring grant in catalog/DB', async () => {
    const auth = { 'X-Test-User-Id': userId };

    const catalog = await request(app.getHttpServer())
      .get('/combat-mechanical-catalog')
      .set(auth);
    expect(catalog.status).toBe(200);

    const ring = catalog.body.economyActions.find(
      (a: { id: string }) => a.id === 'item-ring-of-barrels',
    );
    expect(ring).toMatchObject({
      itemSlug: 'ring-of-barrels',
      resourceSlug: 'ringBarrelCharges',
      economy: 'action',
      tableAction: 'spend-resource',
    });

    const hook = catalog.body.economyActions.find(
      (a: { id: string }) => a.id === 'item-weapon-charm-hook',
    );
    expect(hook?.itemSlug).toBe('weapon-charm-hook');

    const grants = await db.query<{ slug: string }[]>(
      `SELECT rd.slug
       FROM rpg.phb_resource_grant g
       JOIN rpg.phb_resource_definition rd ON rd.id = g.resource_id
       WHERE g.owner_kind = 'item' AND rd.slug = 'ringBarrelCharges'`,
    );
    expect(grants.length).toBe(1);
  });

  it('loads ringBarrelCharges when ring is equipped and attuned', async () => {
    const chars = await db.query<{ id: string }[]>(
      `SELECT c.id
       FROM rpg.player_character c
       JOIN rpg.player_character_item i ON i.character_id = c.id
       WHERE c.user_id = $1
         AND i.item_slug = 'ring-of-barrels'
         AND i.location = 'equipped'
         AND i.attuned = true
       LIMIT 1`,
      [userId],
    );
    if (!chars[0]) {
      console.warn(
        'No character with active ring-of-barrels — skipping resource smoke',
      );
      return;
    }

    const auth = { 'X-Test-User-Id': userId };
    const state = await request(app.getHttpServer())
      .get(`/characters/${chars[0].id}/state`)
      .set(auth);
    expect(state.status).toBe(200);
    const charges = state.body.classResources.find(
      (r: { slug: string }) => r.slug === 'ringBarrelCharges',
    );
    expect(charges).toBeDefined();
    expect(charges.max).toBe(6);
    expect(charges.remaining).toBe(charges.max);
  });
});
