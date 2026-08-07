/**
 * One-shot: cria 1 personagem Nv20 por classe na conta local.
 * Uso: npx jest --config ./test/jest-e2e.config.js --runInBand create-class-review-characters
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
const LEVEL = 20;

const CLASS_LABEL: Record<string, string> = {
  barbarian: 'Bárbaro',
  bard: 'Bardo',
  cleric: 'Clérigo',
  druid: 'Druida',
  fighter: 'Guerreiro',
  gunslinger: 'Pistoleiro',
  monk: 'Monge',
  paladin: 'Paladino',
  ranger: 'Guardião',
  rogue: 'Ladino',
  sorcerer: 'Feiticeiro',
  warlock: 'Bruxo',
  wizard: 'Mago',
};

const BARD_SKILLS = [
  'acrobatics',
  'animal-handling',
  'arcana',
  'athletics',
  'deception',
  'insight',
  'intimidation',
  'investigation',
  'medicine',
  'nature',
  'perception',
  'performance',
  'persuasion',
  'religion',
  'sleight-of-hand',
  'stealth',
] as const;

const SOLDIER_SKILLS = new Set(['athletics', 'intimidation']);

const MASTERY_PICKS: Record<string, string[]> = {
  barbarian: [
    'greataxe',
    'battleaxe',
    'maul',
    'longsword',
    'handaxe',
    'javelin',
    'greatsword',
    'flail',
  ],
  fighter: [
    'longsword',
    'greataxe',
    'longbow',
    'rapier',
    'battleaxe',
    'greatsword',
    'dagger',
    'warhammer',
  ],
  gunslinger: [
    'pistol',
    'revolver',
    'musket',
    'longbow',
    'handgun',
    'light-crossbow',
  ],
  paladin: [
    'longsword',
    'warhammer',
    'battleaxe',
    'javelin',
    'flail',
    'greatsword',
  ],
  ranger: [
    'longbow',
    'shortsword',
    'longsword',
    'dagger',
    'scimitar',
    'handaxe',
  ],
  rogue: [
    'dagger',
    'rapier',
    'shortsword',
    'longsword',
    'hand-crossbow',
    'club',
    'mace',
    'spear',
  ],
};

const PRIMARY_SCORES: Record<
  string,
  {
    forca: number;
    destreza: number;
    constituicao: number;
    inteligencia: number;
    sabedoria: number;
    carisma: number;
  }
> = {
  barbarian: {
    forca: 15,
    constituicao: 14,
    destreza: 13,
    sabedoria: 12,
    carisma: 10,
    inteligencia: 8,
  },
  bard: {
    carisma: 15,
    destreza: 14,
    constituicao: 13,
    sabedoria: 12,
    inteligencia: 10,
    forca: 8,
  },
  cleric: {
    sabedoria: 15,
    constituicao: 14,
    forca: 13,
    carisma: 12,
    destreza: 10,
    inteligencia: 8,
  },
  druid: {
    sabedoria: 15,
    constituicao: 14,
    destreza: 13,
    inteligencia: 12,
    forca: 10,
    carisma: 8,
  },
  fighter: {
    forca: 15,
    constituicao: 14,
    destreza: 13,
    sabedoria: 12,
    carisma: 10,
    inteligencia: 8,
  },
  gunslinger: {
    destreza: 15,
    constituicao: 14,
    sabedoria: 13,
    carisma: 12,
    inteligencia: 10,
    forca: 8,
  },
  monk: {
    destreza: 15,
    sabedoria: 14,
    constituicao: 13,
    forca: 12,
    carisma: 10,
    inteligencia: 8,
  },
  paladin: {
    forca: 15,
    carisma: 14,
    constituicao: 13,
    sabedoria: 12,
    destreza: 10,
    inteligencia: 8,
  },
  ranger: {
    destreza: 15,
    sabedoria: 14,
    constituicao: 13,
    forca: 12,
    inteligencia: 10,
    carisma: 8,
  },
  rogue: {
    destreza: 15,
    inteligencia: 14,
    constituicao: 13,
    sabedoria: 12,
    carisma: 10,
    forca: 8,
  },
  sorcerer: {
    carisma: 15,
    constituicao: 14,
    destreza: 13,
    sabedoria: 12,
    inteligencia: 10,
    forca: 8,
  },
  warlock: {
    carisma: 15,
    constituicao: 14,
    destreza: 13,
    sabedoria: 12,
    inteligencia: 10,
    forca: 8,
  },
  wizard: {
    inteligencia: 15,
    constituicao: 14,
    destreza: 13,
    sabedoria: 12,
    carisma: 10,
    forca: 8,
  },
};

function pickRandom<T>(items: T[]): T {
  return items[Math.floor(Math.random() * items.length)]!;
}

function pickN<T>(items: T[], n: number): T[] {
  const copy = [...items];
  const out: T[] = [];
  while (out.length < n && copy.length > 0) {
    const idx = Math.floor(Math.random() * copy.length);
    out.push(copy.splice(idx, 1)[0]!);
  }
  return out;
}

describe('Create class review characters (L20)', () => {
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

    const users = await db.query<{ id: string }[]>(
      `SELECT id FROM auth.users WHERE email = $1 LIMIT 1`,
      [OWNER_EMAIL],
    );
    if (!users[0]) {
      throw new Error(`User not found: ${OWNER_EMAIL}`);
    }
    userId = users[0].id;

    // Remove tentativas anteriores deste script
    await db.query(
      `DELETE FROM rpg.player_character
       WHERE user_id = $1 AND name LIKE 'Review · %'`,
      [userId],
    );

    // Pool do bardo faltando no seed S026 — garante criação local.
    for (const skill of BARD_SKILLS) {
      await db.query(
        `INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
         SELECT c.id, s.id
         FROM rpg.phb_class c, rpg.phb_skill s
         WHERE c.slug = 'bard' AND s.slug = $1
         ON CONFLICT DO NOTHING`,
        [skill],
      );
    }
  }, 120_000);

  afterAll(async () => {
    await app.close();
  });

  const auth = () => ({ 'X-Test-User-Id': userId });

  it('creates one L20 character per class', async () => {
    const classes = await db.query<{ slug: string; skill_choice_count: number }[]>(
      `SELECT slug, skill_choice_count FROM rpg.phb_class ORDER BY slug`,
    );

    const skillPools = await db.query<{ class_slug: string; skill_slug: string }[]>(`
      SELECT c.slug AS class_slug, s.slug AS skill_slug
      FROM rpg.phb_class_skill_pool p
      JOIN rpg.phb_class c ON c.id = p.class_id
      JOIN rpg.phb_skill s ON s.id = p.skill_id
      ORDER BY 1, 2
    `);
    const poolByClass = new Map<string, string[]>();
    for (const row of skillPools) {
      const list = poolByClass.get(row.class_slug) ?? [];
      list.push(row.skill_slug);
      poolByClass.set(row.class_slug, list);
    }

    const subclasses = await db.query<{ class_slug: string; slug: string }[]>(`
      SELECT c.slug AS class_slug, s.slug
      FROM rpg.phb_subclass s
      JOIN rpg.phb_class c ON c.id = s.class_id
      ORDER BY 1, 2
    `);
    const subclassByClass = new Map<string, string[]>();
    for (const row of subclasses) {
      const list = subclassByClass.get(row.class_slug) ?? [];
      list.push(row.slug);
      subclassByClass.set(row.class_slug, list);
    }

    const created: { name: string; classSlug: string; subclassSlug: string; id: string }[] =
      [];

    for (const cls of classes) {
      const subclassPool = subclassByClass.get(cls.slug) ?? [];
      const subclassSlug =
        cls.slug === 'wizard' && subclassPool.includes('magic-missile-mage')
          ? 'magic-missile-mage'
          : pickRandom(subclassPool);
      if (!subclassSlug) {
        throw new Error(`No subclass for ${cls.slug}`);
      }

      const poolRaw = poolByClass.get(cls.slug) ?? [];
      let pool = poolRaw.filter((s) => !SOLDIER_SKILLS.has(s));
      if (cls.slug === 'wizard') {
        const scholar = [
          'arcana',
          'history',
          'investigation',
          'medicine',
          'nature',
          'religion',
        ];
        pool = pool.filter((s) => scholar.includes(s));
      }
      const classSkillSlugs = pickN(pool, cls.skill_choice_count);
      if (classSkillSlugs.length !== cls.skill_choice_count) {
        throw new Error(
          `Not enough skills for ${cls.slug}: need ${cls.skill_choice_count}, got ${classSkillSlugs.length} from ${pool.join(',')}`,
        );
      }

      // Lote C: query unified phb_option_def/value with scope='subclass'
      const optionKeys = await db.query<{ option_key: string }[]>(
        `SELECT def.option_key
         FROM rpg.phb_option_def def
         JOIN rpg.phb_subclass s ON s.id = def.owner_id
         WHERE def.scope = 'subclass' AND s.slug = $1 AND def.unlock_level <= $2
         ORDER BY def.option_key`,
        [subclassSlug, LEVEL],
      );

      const subclassOptions: { optionKey: string; valueId: string }[] = [];
      for (const { option_key } of optionKeys) {
        const values = await db.query<{ value_id: string }[]>(
          `SELECT v.value_id
           FROM rpg.phb_option_value v
           JOIN rpg.phb_subclass s ON s.id = v.owner_id
           WHERE v.scope = 'subclass' AND s.slug = $1 AND v.option_key = $2
           ORDER BY v.sort_order, v.value_id`,
          [subclassSlug, option_key],
        );
        if (!values[0]) {
          throw new Error(`No values for ${subclassSlug}.${option_key}`);
        }
        subclassOptions.push({
          optionKey: option_key,
          valueId: values[0].value_id,
        });
      }

      const classOptions: { optionKey: string; valueId: string }[] = [];

      // Expertise
      const expertiseCount =
        cls.slug === 'rogue'
          ? 4
          : cls.slug === 'bard'
            ? 4
            : cls.slug === 'ranger'
              ? 3
              : cls.slug === 'wizard'
                ? 1
                : 0;
      if (expertiseCount > 0) {
        let expertisePool =
          cls.slug === 'wizard'
            ? [...classSkillSlugs]
            : [...new Set([...classSkillSlugs, ...SOLDIER_SKILLS])];
        const picks = pickN(expertisePool, expertiseCount);
        if (picks.length < expertiseCount) {
          throw new Error(
            `Expertise short for ${cls.slug}: ${picks.join(',')} need ${expertiseCount} from ${expertisePool.join(',')}`,
          );
        }
        picks.forEach((skill, i) => {
          classOptions.push({
            optionKey: `expertiseSkill${i + 1}`,
            valueId: skill,
          });
        });
      }

      // Weapon mastery
      const masteryRows = await db.query<{ weaponMastery: number | null }[]>(
        `SELECT cp.weapon_mastery AS "weaponMastery"
         FROM rpg.phb_class_progression cp
         JOIN rpg.phb_class c ON c.id = cp.class_id
         WHERE c.slug = $1 AND cp.level = $2`,
        [cls.slug, LEVEL],
      );
      const masteryCount = masteryRows[0]?.weaponMastery ?? 0;
      if (masteryCount > 0) {
        const weaponList = MASTERY_PICKS[cls.slug] ?? [
          'dagger',
          'club',
          'mace',
          'quarterstaff',
          'spear',
          'handaxe',
        ];
        const weapons = pickN(weaponList, masteryCount);
        if (weapons.length < masteryCount) {
          throw new Error(
            `Mastery weapons short for ${cls.slug}: need ${masteryCount}, have ${weaponList.length}`,
          );
        }
        weapons.forEach((weapon, i) => {
          classOptions.push({
            optionKey: `masteryWeapon${i + 1}`,
            valueId: weapon,
          });
        });
      }

      // Dominância de Magias (mago nv. 18+): 1º + 2º à vontade.
      if (cls.slug === 'wizard') {
        classOptions.push(
          { optionKey: 'spellMastery1', valueId: 'misseis-magicos' },
          { optionKey: 'spellMastery2', valueId: 'invisibilidade' },
        );
      }

      const characterFeats: { featSlug: string; instanceIndex: number }[] = [];
      if (cls.slug === 'fighter' || cls.slug === 'gunslinger') {
        characterFeats.push({ featSlug: 'defense', instanceIndex: 0 });
      }

      // Mago: grimório (known) + preparadas do dia; Mísseis vem always_prepared via subclasse.
      const characterSpells =
        cls.slug === 'wizard'
          ? [
              { spellSlug: 'misseis-magicos', listType: 'known' as const },
              { spellSlug: 'escudo-arcano', listType: 'known' as const },
              { spellSlug: 'escudo-arcano', listType: 'prepared' as const },
              { spellSlug: 'detectar-magia', listType: 'known' as const },
              { spellSlug: 'detectar-magia', listType: 'prepared' as const },
              { spellSlug: 'invisibilidade', listType: 'known' as const },
              { spellSlug: 'invisibilidade', listType: 'prepared' as const },
              { spellSlug: 'raio-de-fogo', listType: 'known' as const },
              { spellSlug: 'maos-magicas', listType: 'known' as const },
              { spellSlug: 'luz', listType: 'known' as const },
            ]
          : undefined;

      const name = `Review · ${CLASS_LABEL[cls.slug] ?? cls.slug}`;
      const payload = {
        name,
        level: LEVEL,
        classSlug: cls.slug,
        speciesSlug: 'dwarf',
        backgroundSlug: 'soldier',
        subclassSlug,
        classSkillSlugs,
        languageSlugs: ['common', 'dwarvish', 'elvish'],
        backgroundAbilityBoostMode: 'plus2plus1',
        // Soldier: só STR/DEX/CON
        backgroundAbilityBoostPlus2Slug: 'forca',
        backgroundAbilityBoostPlus1Slug: 'constituicao',
        backgroundToolItemSlug: 'conjunto-de-dados',
        abilityGenerationMethodSlug: 'roll',
        abilityScores: PRIMARY_SCORES[cls.slug] ?? PRIMARY_SCORES.fighter,
        subclassOptions,
        classOptions,
        characterFeats,
        characterSpells,
        // kit vazio — escolher/reroll depois
        equipment: [],
      };

      const res = await request(app.getHttpServer())
        .post('/characters')
        .set(auth())
        .send(payload);

      if (res.status !== 201) {
        // eslint-disable-next-line no-console
        console.error(
          `FAIL ${cls.slug}/${subclassSlug}`,
          res.status,
          JSON.stringify(res.body, null, 2),
        );
      }
      expect(res.status).toBe(201);
      created.push({
        name,
        classSlug: cls.slug,
        subclassSlug,
        id: res.body.id as string,
      });
    }

    // eslint-disable-next-line no-console
    console.log('\nCreated characters:');
    for (const c of created) {
      // eslint-disable-next-line no-console
      console.log(`- ${c.name} (${c.classSlug}/${c.subclassSlug}) id=${c.id}`);
    }
    expect(created).toHaveLength(classes.length);
  }, 300_000);
});
