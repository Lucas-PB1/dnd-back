#!/usr/bin/env node
/**
 * Smoke: cria Gunslinger L1 (skills + mastery + FS + pacote B),
 * sobe para L2, gasta Risk e recupera no short rest.
 *
 * Uso: node scripts/smoke-gunslinger.mjs
 *      KEEP=1 node scripts/smoke-gunslinger.mjs
 */
import { createRequire } from 'module';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';

loadEnv();

const require = createRequire(import.meta.url);
const { NestFactory } = require('@nestjs/core');
const { AppModule } = require(path.join(rootDir, 'dist/app.module.js'));
const { CreateCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/create-character.handler.js'),
);
const { DeleteCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/delete-character.handler.js'),
);
const { LevelUpHandler } = require(
  path.join(rootDir, 'dist/game/progression/application/level-up.handler.js'),
);
const { GetCharacterStateQuery } = require(
  path.join(
    rootDir,
    'dist/game/session/application/get-character-state.query.js',
  ),
);
const { UseClassResourceHandler } = require(
  path.join(
    rootDir,
    'dist/game/session/application/use-class-resource.handler.js',
  ),
);
const { RestHandler } = require(
  path.join(rootDir, 'dist/game/session/application/rest.handler.js'),
);

const USER_ID =
  process.env.SMOKE_USER_ID ?? '22222222-2222-2222-2222-222222222222';
const KEEP = process.env.KEEP === '1';

function assert(cond, msg) {
  if (!cond) throw new Error(msg);
}

function riskOf(state) {
  return (state.classResources ?? []).find((r) => r.slug === 'risk') ?? null;
}

async function main() {
  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const create = app.get(CreateCharacterHandler);
  const del = app.get(DeleteCharacterHandler);
  const levelUp = app.get(LevelUpHandler);
  const getState = app.get(GetCharacterStateQuery);
  const useResource = app.get(UseClassResourceHandler);
  const rest = app.get(RestHandler);

  let characterId = null;

  try {
    const created = await create.execute(USER_ID, {
      name: 'SMOKE Gunslinger',
      level: 1,
      classSlug: 'gunslinger',
      speciesSlug: 'orc',
      backgroundSlug: 'criminal',
      backgroundAbilityBoostPlus2Slug: 'destreza',
      backgroundAbilityBoostPlus1Slug: 'constituicao',
      abilityGenerationMethodSlug: 'standard-array',
      abilityScores: {
        forca: 10,
        destreza: 15,
        constituicao: 14,
        inteligencia: 12,
        sabedoria: 13,
        carisma: 8,
      },
      classSkillSlugs: ['perception', 'acrobatics'],
      languageSlugs: ['common', 'orc'],
      speciesChoices: [],
      characterSpells: [],
      characterFeats: [{ featSlug: 'archery', instanceIndex: 0 }],
      classOptions: [
        { optionKey: 'masteryWeapon1', valueId: 'revolver' },
        { optionKey: 'masteryWeapon2', valueId: 'dagger' },
      ],
      equipment: [{ source: 'class', packageSlug: 'b', sortOrder: 0 }],
    });

    characterId = created.id;
    console.log('created', {
      id: characterId,
      level: created.level,
      classSlug: created.classSlug,
      feats: (created.characterFeats ?? []).map((f) => f.featSlug),
      mastery: (created.classOptions ?? [])
        .filter((o) => String(o.optionKey).startsWith('masteryWeapon'))
        .map((o) => `${o.optionKey}=${o.valueId}`),
    });

    assert(created.level === 1, 'expected level 1');
    assert(
      (created.characterFeats ?? []).some((f) => f.featSlug === 'archery'),
      'expected archery fighting style',
    );

    const stateL1 = await getState.execute(USER_ID, characterId);
    assert(
      riskOf(stateL1) == null,
      'Risk should not exist at level 1',
    );

    const leveled = await levelUp.execute(USER_ID, characterId, {});
    assert(leveled.level === 2, 'expected level 2 after level-up');

    const stateL2 = await getState.execute(USER_ID, characterId);
    const risk = riskOf(stateL2);
    assert(risk != null, 'Risk should exist at level 2');
    assert(risk.max === 4, `expected Risk max 4, got ${risk.max}`);
    assert(risk.remaining === 4, `expected Risk remaining 4, got ${risk.remaining}`);
    assert(risk.dieFaces === 8, `expected dieFaces 8, got ${risk.dieFaces}`);
    assert(risk.dieLabel === 'd8', `expected dieLabel d8, got ${risk.dieLabel}`);
    console.log('risk L2', risk);

    const afterSpend = await useResource.execute(USER_ID, characterId, {
      resourceSlug: 'risk',
      amount: 1,
    });
    const spent = riskOf(afterSpend);
    assert(spent.remaining === 3, `expected remaining 3 after spend, got ${spent.remaining}`);
    console.log('after spend', spent);

    const afterRest = await rest.execute(USER_ID, characterId, {
      type: 'short',
      hitDiceSpent: 0,
    });
    const recovered = riskOf(afterRest.state);
    assert(
      recovered.remaining === 4,
      `expected Risk recovered to 4 on short rest, got ${recovered.remaining}`,
    );
    console.log('after short rest', recovered);

    console.log('SMOKE gunslinger OK');
  } finally {
    if (characterId && !KEEP) {
      await del.execute(USER_ID, characterId);
      console.log('deleted', characterId);
    }
    await app.close();
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
