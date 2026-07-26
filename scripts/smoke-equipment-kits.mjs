#!/usr/bin/env node
/**
 * Smoke: cria feiticeiro com pacote A (adagas) + antecedente criminal (adagas).
 * Reproduz o bug "Item 'dagger' is not in class package 'a'".
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
const { GetCharacterQuery } = require(
  path.join(rootDir, 'dist/game/sheet/application/get-character.query.js'),
);
const { GetCharacterInventoryQuery } = require(
  path.join(
    rootDir,
    'dist/game/inventory/application/get-character-inventory.query.js',
  ),
);

const USER_ID =
  process.env.SMOKE_USER_ID ?? '22222222-2222-2222-2222-222222222222';

async function main() {
  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const create = app.get(CreateCharacterHandler);
  const del = app.get(DeleteCharacterHandler);
  const get = app.get(GetCharacterQuery);
  const inventory = app.get(GetCharacterInventoryQuery);

  // Mesmo shape do smoke-sheet-matrix (dwarf + criminal), só com equipment.
  const payload = {
    name: 'SMOKE sorcerer-equipment',
    level: 1,
    classSlug: 'sorcerer',
    subclassSlug: null,
    speciesSlug: 'dwarf',
    backgroundSlug: 'criminal',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 13,
      inteligencia: 12,
      sabedoria: 10,
      carisma: 15,
    },
    classSkillSlugs: ['arcana', 'deception'],
    languageSlugs: ['common', 'dwarvish'],
    speciesChoices: [],
    characterSpells: [],
    equipment: [
      { source: 'class', packageSlug: 'a', sortOrder: 0 },
      {
        source: 'class',
        packageSlug: 'a',
        itemSlug: 'dagger',
        quantity: 2,
        sortOrder: 1,
      },
      {
        source: 'class',
        packageSlug: 'a',
        itemSlug: 'foco-arcano',
        quantity: 1,
        sortOrder: 2,
      },
      {
        source: 'class',
        packageSlug: 'a',
        itemSlug: 'kit-de-explorador-de-masmorras',
        quantity: 1,
        sortOrder: 3,
      },
      { source: 'background', packageSlug: 'a', sortOrder: 0 },
      {
        source: 'background',
        packageSlug: 'a',
        itemSlug: 'dagger',
        quantity: 2,
        sortOrder: 1,
      },
      {
        source: 'background',
        packageSlug: 'a',
        itemSlug: 'ferramentas-de-ladrao',
        quantity: 1,
        sortOrder: 2,
      },
      {
        source: 'background',
        packageSlug: 'a',
        itemSlug: 'algibeira',
        quantity: 2,
        sortOrder: 3,
      },
      {
        source: 'background',
        packageSlug: 'a',
        itemSlug: 'pe-de-cabra',
        quantity: 1,
        sortOrder: 4,
      },
      {
        source: 'background',
        packageSlug: 'a',
        itemSlug: 'roupas-viagem',
        quantity: 1,
        sortOrder: 5,
      },
    ],
    featOptions: [],
    characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
  };

  let id = null;
  try {
    const created = await create.execute(USER_ID, payload);
    id = created.id;
    console.log(`OK create ${id}`);

    const detail = await get.execute(USER_ID, id);
    const eq = detail.equipment ?? [];
    const daggerRows = eq.filter((e) => e.itemSlug === 'dagger');
    console.log(
      `equipment dagger rows: ${daggerRows.length} → ${JSON.stringify(daggerRows)}`,
    );
    if (daggerRows.length < 2) {
      throw new Error('Esperava dagger no pacote de classe e de antecedente');
    }

    const inv = await inventory.execute(USER_ID, id);
    const daggerInv = (inv.items ?? inv ?? []).filter?.(
      (i) => i.itemSlug === 'dagger' || i.slug === 'dagger',
    );
    // inventory shape may vary — log raw relevant bits
    const items = inv?.items ?? inv?.inventory ?? inv;
    console.log(
      'inventory dagger:',
      Array.isArray(items)
        ? items.filter((i) => (i.itemSlug ?? i.slug) === 'dagger')
        : items,
    );

    console.log('SMOKE equipment OK');
  } catch (error) {
    const msg = error?.response?.message ?? error?.message ?? String(error);
    console.error('FAIL:', Array.isArray(msg) ? msg.join('; ') : msg);
    process.exitCode = 1;
  } finally {
    if (id) {
      try {
        await del.execute(USER_ID, id);
        console.log('cleaned');
      } catch {
        // ignore
      }
    }
    await app.close();
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
