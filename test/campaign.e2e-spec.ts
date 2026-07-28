import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { HttpExceptionFilter } from '../src/common/filters/http-exception.filter';
import { SupabaseAuthGuard } from '../src/identity/guards/supabase-auth.guard';
import { TestAuthGuard } from './helpers/test-auth.guard';
import { minimalFighterPayload } from './helpers/minimal-character';

const DM_USER_ID = '11111111-1111-1111-1111-111111111111';
const PLAYER_USER_ID = '22222222-2222-2222-2222-222222222222';
const STRANGER_USER_ID = '33333333-3333-3333-3333-333333333333';

describe('Campaigns & encounters API (e2e)', () => {
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

  const auth = (userId = DM_USER_ID) => ({ 'X-Test-User-Id': userId });

  async function createCharacter(userId: string, name: string) {
    const res = await request(app.getHttpServer())
      .post('/characters')
      .set(auth(userId))
      .send(minimalFighterPayload(name))
      .expect(201);
    return res.body.id as string;
  }

  it('GET /campaigns without auth returns 401', () =>
    request(app.getHttpServer()).get('/campaigns').expect(401));

  it('runs campaign MVP: create, join, link, encounter loop, close', async () => {
    const createCampaign = await request(app.getHttpServer())
      .post('/campaigns')
      .set(auth(DM_USER_ID))
      .send({ name: 'E2E Mesa', description: 'fluxo MVP' })
      .expect(201);

    const campaignId = createCampaign.body.id as string;
    const inviteCode = createCampaign.body.inviteCode as string;
    expect(campaignId).toBeDefined();
    expect(inviteCode).toMatch(/^[A-Z0-9]+$/i);

    const list = await request(app.getHttpServer())
      .get('/campaigns')
      .set(auth(DM_USER_ID))
      .expect(200);
    expect(list.body.some((c: { id: string }) => c.id === campaignId)).toBe(
      true,
    );

    await request(app.getHttpServer())
      .post('/campaigns/join')
      .set(auth(PLAYER_USER_ID))
      .send({ inviteCode, role: 'player' })
      .expect(201);

    const detail = await request(app.getHttpServer())
      .get(`/campaigns/${campaignId}`)
      .set(auth(DM_USER_ID))
      .expect(200);
    expect(detail.body.members).toEqual(
      expect.arrayContaining([
        expect.objectContaining({ userId: DM_USER_ID, role: 'dm' }),
        expect.objectContaining({ userId: PLAYER_USER_ID, role: 'player' }),
      ]),
    );

    const characterId = await createCharacter(PLAYER_USER_ID, 'E2E Combatente');
    await request(app.getHttpServer())
      .post(`/campaigns/${campaignId}/characters`)
      .set(auth(PLAYER_USER_ID))
      .send({ characterId })
      .expect(201);

    await request(app.getHttpServer())
      .post(`/campaigns/${campaignId}/encounters`)
      .set(auth(PLAYER_USER_ID))
      .send({ name: 'Sem permissão' })
      .expect(403);

    const encounterRes = await request(app.getHttpServer())
      .post(`/campaigns/${campaignId}/encounters`)
      .set(auth(DM_USER_ID))
      .send({ name: 'Emboscada E2E' })
      .expect(201);

    const encounterId = encounterRes.body.id as string;
    expect(encounterRes.body.name).toBe('Emboscada E2E');
    expect(encounterRes.body.status).toBe('active');
    expect(encounterRes.body.combatants.length).toBeGreaterThanOrEqual(1);

    await request(app.getHttpServer())
      .get(`/campaigns/${campaignId}/encounters/active`)
      .set(auth(PLAYER_USER_ID))
      .expect(403);

    await request(app.getHttpServer())
      .patch(`/campaigns/${campaignId}/encounters/${encounterId}`)
      .set(auth(DM_USER_ID))
      .send({ playersCanView: true, creatureHpVisibility: 'exact' })
      .expect(200);

    const activeForPlayer = await request(app.getHttpServer())
      .get(`/campaigns/${campaignId}/encounters/active`)
      .set(auth(PLAYER_USER_ID))
      .expect(200);
    expect(activeForPlayer.body.id).toBe(encounterId);

    const withCreature = await request(app.getHttpServer())
      .post(`/campaigns/${campaignId}/encounters/${encounterId}/creatures`)
      .set(auth(DM_USER_ID))
      .send({
        name: 'Goblin E2E',
        hpMax: 7,
        armorClass: 15,
        initiativeModifier: 2,
      })
      .expect(201);

    const creature = withCreature.body.combatants.find(
      (c: { kind: string; displayName: string }) =>
        c.kind === 'creature' && c.displayName === 'Goblin E2E',
    );
    expect(creature).toBeDefined();

    const rolled = await request(app.getHttpServer())
      .post(
        `/campaigns/${campaignId}/encounters/${encounterId}/roll-all-initiative`,
      )
      .set(auth(DM_USER_ID))
      .send({})
      .expect(201);
    expect(
      rolled.body.combatants.every(
        (c: { initiativeTotal: number | null }) =>
          typeof c.initiativeTotal === 'number',
      ),
    ).toBe(true);

    const afterTurn = await request(app.getHttpServer())
      .post(`/campaigns/${campaignId}/encounters/${encounterId}/next-turn`)
      .set(auth(DM_USER_ID))
      .expect(201);
    expect(afterTurn.body.round).toBeGreaterThanOrEqual(1);

    await request(app.getHttpServer())
      .post(`/campaigns/${campaignId}/encounters/${encounterId}/close`)
      .set(auth(DM_USER_ID))
      .expect(201);

    await request(app.getHttpServer())
      .get(`/campaigns/${campaignId}/encounters/active`)
      .set(auth(DM_USER_ID))
      .expect(404);

    await request(app.getHttpServer())
      .get(`/campaigns/${campaignId}`)
      .set(auth(STRANGER_USER_ID))
      .expect(403);

    await request(app.getHttpServer())
      .delete(`/campaigns/${campaignId}`)
      .set(auth(DM_USER_ID))
      .expect(204);
  });
});
