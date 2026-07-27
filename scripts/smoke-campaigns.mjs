#!/usr/bin/env node
/**
 * Smoke MVP campanhas: criar, join auxiliar, vincular personagem, ler ficha.
 */
import { createRequire } from 'module';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';

loadEnv();

const require = createRequire(import.meta.url);
const { NestFactory } = require('@nestjs/core');
const { AppModule } = require(path.join(rootDir, 'dist/app.module.js'));
const { CampaignService } = require(
  path.join(rootDir, 'dist/game/campaign/application/campaign.service.js'),
);
const { CreateCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/create-character.handler.js'),
);
const { GetCharacterQuery } = require(
  path.join(rootDir, 'dist/game/sheet/application/get-character.query.js'),
);
const { DeleteCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/delete-character.handler.js'),
);
const { FindEditionsQuery } = require(
  path.join(
    rootDir,
    'dist/catalog/reference/queries/find-editions.query.js',
  ),
);

const DM = '22222222-2222-2222-2222-222222222222';
const ASSISTANT = '33333333-3333-3333-3333-333333333333';

async function main() {
  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const campaigns = app.get(CampaignService);
  const create = app.get(CreateCharacterHandler);
  const get = app.get(GetCharacterQuery);
  const del = app.get(DeleteCharacterHandler);
  const editions = app.get(FindEditionsQuery);

  const editionRows = await editions.execute();
  const phb = editionRows.find((e) => e.slug === 'phb-2024-pt');
  if (!phb?.book?.includes('Livro do Jogador')) {
    throw new Error(`Edition PHB missing: ${JSON.stringify(editionRows)}`);
  }
  console.log(`OK editions: ${phb.book}`);

  let campaignId = null;
  let characterId = null;

  try {
    const created = await campaigns.create(DM, {
      name: 'SMOKE Ruínas',
      description: 'mesa de teste',
    });
    campaignId = created.id;
    console.log(`OK create campaign ${campaignId} code=${created.inviteCode}`);

    const joined = await campaigns.join(ASSISTANT, {
      inviteCode: created.inviteCode,
      role: 'assistant',
    });
    if (joined.myRole !== 'assistant') {
      throw new Error(`Expected assistant, got ${joined.myRole}`);
    }
    console.log('OK assistant joined');

    const character = await create.execute(DM, {
      name: 'SMOKE Camp PC',
      level: 1,
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'criminal',
      backgroundAbilityBoostPlus2Slug: 'destreza',
      backgroundAbilityBoostPlus1Slug: 'constituicao',
      abilityGenerationMethodSlug: 'standard-array',
      abilityScores: {
        forca: 15,
        destreza: 14,
        constituicao: 13,
        inteligencia: 10,
        sabedoria: 12,
        carisma: 8,
      },
      classSkillSlugs: ['athletics', 'perception'],
      languageSlugs: ['common', 'dwarvish'],
      characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
      equipment: [],
    });
    characterId = character.id;
    console.log(`OK create character ${characterId}`);

    await campaigns.linkCharacter(DM, campaignId, {
      characterId,
    });
    console.log('OK link character');

    const detail = await campaigns.getDetail(ASSISTANT, campaignId);
    if (!detail.characters.some((c) => c.characterId === characterId)) {
      throw new Error('Character not visible to assistant');
    }
    console.log('OK assistant sees roster');

    const sheet = await get.execute(ASSISTANT, characterId);
    if (sheet.name !== 'SMOKE Camp PC') {
      throw new Error('Assistant cannot read linked character');
    }
    console.log('OK assistant reads character sheet');

    console.log('SMOKE campaigns OK');
  } catch (error) {
    const msg = error?.response?.message ?? error?.message ?? String(error);
    console.error('FAIL:', Array.isArray(msg) ? msg.join('; ') : msg);
    process.exitCode = 1;
  } finally {
    if (campaignId) {
      try {
        await campaigns.remove(DM, campaignId);
      } catch {
        // ignore
      }
    }
    if (characterId) {
      try {
        await del.execute(DM, characterId);
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
