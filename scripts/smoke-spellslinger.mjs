#!/usr/bin/env node
/**
 * Smoke: Gunslinger Spellslinger L3 — lista Wizard, Finger Guns, slots, cast/rest.
 *
 * Uso: node scripts/smoke-spellslinger.mjs
 *      KEEP=1 node scripts/smoke-spellslinger.mjs
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
const { GetCharacterStateQuery } = require(
  path.join(
    rootDir,
    'dist/game/session/application/get-character-state.query.js',
  ),
);
const { CastSpellHandler } = require(
  path.join(rootDir, 'dist/game/session/application/cast-spell.handler.js'),
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

async function main() {
  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const create = app.get(CreateCharacterHandler);
  const del = app.get(DeleteCharacterHandler);
  const getState = app.get(GetCharacterStateQuery);
  const cast = app.get(CastSpellHandler);
  const rest = app.get(RestHandler);

  let characterId = null;

  try {
    const created = await create.execute(USER_ID, {
      name: 'SMOKE Spellslinger',
      level: 3,
      classSlug: 'gunslinger',
      subclassSlug: 'spellslinger',
      speciesSlug: 'orc',
      backgroundSlug: 'criminal',
      backgroundAbilityBoostPlus2Slug: 'destreza',
      backgroundAbilityBoostPlus1Slug: 'inteligencia',
      abilityGenerationMethodSlug: 'standard-array',
      abilityScores: {
        forca: 10,
        destreza: 15,
        constituicao: 13,
        inteligencia: 14,
        sabedoria: 12,
        carisma: 8,
      },
      classSkillSlugs: ['perception', 'acrobatics'],
      languageSlugs: ['common', 'orc'],
      speciesChoices: [],
      characterFeats: [{ featSlug: 'archery', instanceIndex: 0 }],
      classOptions: [
        { optionKey: 'masteryWeapon1', valueId: 'revolver' },
        { optionKey: 'masteryWeapon2', valueId: 'dagger' },
      ],
      characterSpells: [
        { spellSlug: 'raio-de-fogo', listType: 'known' },
        { spellSlug: 'mensagem', listType: 'known' },
        { spellSlug: 'escudo-arcano', listType: 'prepared' },
        { spellSlug: 'orbe-cromatico', listType: 'prepared' },
        { spellSlug: 'salto', listType: 'prepared' },
      ],
      equipment: [{ source: 'class', packageSlug: 'b', sortOrder: 0 }],
    });

    characterId = created.id;
    const spells = (created.characterSpells ?? []).map(
      (s) => `${s.spellSlug}:${s.listType}`,
    );
    console.log('created', {
      id: characterId,
      level: created.level,
      subclass: created.subclassSlug,
      spells,
    });

    assert(created.subclassSlug === 'spellslinger', 'expected spellslinger');
    assert(
      spells.includes('finger-guns:always_prepared'),
      'expected Finger Guns always_prepared',
    );

    const state = await getState.execute(USER_ID, characterId);
    assert(
      state.spellSlotsMax?.['1'] === 2,
      `expected 2×1st slots, got ${JSON.stringify(state.spellSlotsMax)}`,
    );
    assert(
      (state.spellSlotsRemaining?.['1'] ?? 0) === 2,
      'expected 2 remaining 1st slots',
    );
    console.log('slots', state.spellSlotsMax);

    const afterCast = await cast.execute(USER_ID, characterId, {
      spellSlug: 'escudo-arcano',
      slotLevel: 1,
    });
    assert(
      afterCast.state.spellSlotsRemaining?.['1'] === 1,
      `expected 1 remaining after cast, got ${afterCast.state.spellSlotsRemaining?.['1']}`,
    );

    const afterRest = await rest.execute(USER_ID, characterId, {
      type: 'long',
    });
    assert(
      afterRest.state.spellSlotsRemaining?.['1'] === 2,
      'expected slots restored on long rest',
    );

    console.log('SMOKE spellslinger OK');
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
