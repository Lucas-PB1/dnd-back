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

/** Escolhas mínimas PHB 2024 para humano nos testes e2e. */
const HUMAN_SPECIES_CHOICES = [
  { choiceKind: 'human_skill', choiceSlug: 'athletics' },
  { choiceKind: 'human_origin_feat', choiceSlug: 'alert' },
  { choiceKind: 'human_size', choiceSlug: 'medium' },
];

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
    expect(res.body.classSkillSlugs).toEqual([]);
    expect(res.body.backgroundSkillSlugs).toEqual(['insight', 'religion']);
    return res.body.id as string;
  });

  it('POST /characters accepts starting level with subclass', async () => {
    const res = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'E2E Level 5',
        level: 5,
        classSlug: 'fighter',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
        subclassSlug: 'champion',
      })
      .expect(201);

    expect(res.body.level).toBe(5);
    expect(res.body.proficiencyBonus).toBe(3);
    expect(res.body.subclassSlug).toBe('champion');
    expect(res.body.hitPointsMax).toBeGreaterThan(10);
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
        speciesChoices: HUMAN_SPECIES_CHOICES,
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

  it('POST /characters with valid class skills', async () => {
    const res = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Skilled Hero',
        classSlug: 'fighter',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
        classSkillSlugs: ['athletics', 'perception'],
      })
      .expect(201);

    expect(res.body.classSkillSlugs).toEqual(['athletics', 'perception']);
  });

  it('POST /characters rejects skill outside class pool', () =>
    request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Bad Skills',
        classSlug: 'fighter',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
        classSkillSlugs: ['athletics', 'arcana'],
      })
      .expect(400));

  it('POST /characters rejects wrong skill count for class', () =>
    request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Bad Count',
        classSlug: 'fighter',
        speciesSlug: 'dwarf',
        backgroundSlug: 'acolyte',
        classSkillSlugs: ['athletics'],
      })
      .expect(400));

  it('POST /characters/roll-abilities standard array', async () => {
    const res = await request(app.getHttpServer())
      .post('/characters/roll-abilities')
      .set(auth())
      .send({ method: 'standard-array' })
      .expect(200);

    expect(res.body.abilityScores.forca).toBe(15);
    expect(res.body.rawValues).toEqual([15, 14, 13, 12, 10, 8]);
  });

  it('GET /characters/:id/level-up/preview and POST level-up', async () => {
    const created = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Level Hero',
        classSlug: 'fighter',
        speciesSlug: 'human',
        backgroundSlug: 'acolyte',
        speciesChoices: HUMAN_SPECIES_CHOICES,
        classSkillSlugs: ['athletics', 'perception'],
      })
      .expect(201);

    const id = created.body.id as string;

    const preview = await request(app.getHttpServer())
      .get(`/characters/${id}/level-up/preview`)
      .set(auth())
      .expect(200);

    expect(preview.body.currentLevel).toBe(1);
    expect(preview.body.nextLevel).toBe(2);
    expect(preview.body.estimatedHpGain).toBeGreaterThan(0);

    const leveled = await request(app.getHttpServer())
      .post(`/characters/${id}/level-up`)
      .set(auth())
      .send({})
      .expect(200);

    expect(leveled.body.level).toBe(2);
    expect(leveled.body.hitPointsMax).toBeGreaterThan(created.body.hitPointsMax);
  });

  it('GET /characters/:id/state, cast, rest', async () => {
    const created = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Session Wizard',
        classSlug: 'wizard',
        speciesSlug: 'elf',
        backgroundSlug: 'acolyte',
        characterSpells: [
          { spellSlug: 'alarme', listType: 'prepared' },
          { spellSlug: 'amigos', listType: 'known' },
        ],
      })
      .expect(201);

    const id = created.body.id as string;

    const initial = await request(app.getHttpServer())
      .get(`/characters/${id}/state`)
      .set(auth())
      .expect(200);

    expect(initial.body.spellSlotsMax['1']).toBe(2);
    expect(initial.body.spellSlotsUsed).toEqual({});
    expect(initial.body.spellSlotsRemaining['1']).toBe(2);

    await request(app.getHttpServer())
      .post(`/characters/${id}/spells/cast`)
      .set(auth())
      .send({ spellSlug: 'alarme' })
      .expect(200)
      .expect((res) => {
        expect(res.body.slotLevelUsed).toBe(1);
        expect(res.body.state.spellSlotsUsed['1']).toBe(1);
        expect(res.body.state.spellSlotsRemaining['1']).toBe(1);
      });

    await request(app.getHttpServer())
      .post(`/characters/${id}/spells/cast`)
      .set(auth())
      .send({ spellSlug: 'amigos' })
      .expect(200)
      .expect((res) => {
        expect(res.body.slotLevelUsed).toBeNull();
        expect(res.body.state.concentratingOn).toBe('amigos');
      });

    await request(app.getHttpServer())
      .patch(`/characters/${id}/state`)
      .set(auth())
      .send({ conditions: ['poisoned'], tempHp: 3 })
      .expect(200)
      .expect((res) => {
        expect(res.body.conditions).toEqual(['poisoned']);
        expect(res.body.tempHp).toBe(3);
      });

    await request(app.getHttpServer())
      .post(`/characters/${id}/rest`)
      .set(auth())
      .send({ type: 'long' })
      .expect(200)
      .expect((res) => {
        expect(res.body.type).toBe('long');
        expect(res.body.state.spellSlotsUsed).toEqual({});
        expect(res.body.state.conditions).toEqual([]);
        expect(res.body.state.tempHp).toBe(0);
        expect(res.body.state.concentratingOn).toBeNull();
      });
  });

  it('inventory add, equip, unequip, remove', async () => {
    const created = await request(app.getHttpServer())
      .post('/characters')
      .set(auth())
      .send({
        name: 'Inventory Hero',
        classSlug: 'fighter',
        speciesSlug: 'human',
        backgroundSlug: 'acolyte',
        speciesChoices: HUMAN_SPECIES_CHOICES,
      })
      .expect(201);

    const id = created.body.id as string;

    await request(app.getHttpServer())
      .get(`/characters/${id}/inventory`)
      .set(auth())
      .expect(200)
      .expect((res) => {
        expect(res.body.items).toEqual([]);
      });

    await request(app.getHttpServer())
      .post(`/characters/${id}/inventory`)
      .set(auth())
      .send({ itemSlug: 'longsword', quantity: 1 })
      .expect(201)
      .expect((res) => {
        expect(res.body.itemSlug).toBe('longsword');
        expect(res.body.location).toBe('backpack');
      });

    await request(app.getHttpServer())
      .patch(`/characters/${id}/inventory/longsword`)
      .set(auth())
      .send({ location: 'equipped', equipmentSlot: 'main_hand' })
      .expect(200)
      .expect((res) => {
        expect(res.body.location).toBe('equipped');
        expect(res.body.equipmentSlot).toBe('main_hand');
      });

    await request(app.getHttpServer())
      .patch(`/characters/${id}/inventory/longsword`)
      .set(auth())
      .send({ location: 'backpack' })
      .expect(200)
      .expect((res) => {
        expect(res.body.location).toBe('backpack');
        expect(res.body.equipmentSlot).toBeNull();
      });

    await request(app.getHttpServer())
      .delete(`/characters/${id}/inventory/longsword`)
      .set(auth())
      .expect(204);

    await request(app.getHttpServer())
      .get(`/characters/${id}/inventory`)
      .set(auth())
      .expect(200)
      .expect((res) => {
        expect(res.body.items).toEqual([]);
      });
  });
});
