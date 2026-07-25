#!/usr/bin/env node
/**
 * Smoke da Classe de Armadura (CA).
 *
 * Parte 1: lista as fontes de CA existentes no catálogo (classe, subclasse,
 *          talento, magia) para saber o que a ficha deveria considerar.
 * Parte 2: cria fichas reais, equipa itens e compara a CA devolvida pela API
 *          com o valor esperado pelas regras.
 *
 * Uso:
 *   node scripts/smoke-armor-class.mjs
 *   KEEP=1 node scripts/smoke-armor-class.mjs   # não apaga as fichas
 */
import { createRequire } from 'module';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';

loadEnv();

const require = createRequire(import.meta.url);
const { NestFactory } = require('@nestjs/core');
const { DataSource } = require('typeorm');
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
const { AddInventoryItemHandler } = require(
  path.join(rootDir, 'dist/game/inventory/application/add-inventory-item.handler.js'),
);
const { PatchInventoryItemHandler } = require(
  path.join(rootDir, 'dist/game/inventory/application/patch-inventory-item.handler.js'),
);

const USER_ID = process.env.SMOKE_USER_ID ?? '22222222-2222-2222-2222-222222222222';
const KEEP = process.env.KEEP === '1';
const LEVEL = 3;

const mod = (score) => Math.floor((score - 10) / 2);

/** Perícias fora do pool do criminal (stealth, sleight-of-hand). */
const CLASS_SKILLS = {
  fighter: ['acrobatics', 'athletics'],
  barbarian: ['athletics', 'intimidation'],
  monk: ['acrobatics', 'athletics'],
  sorcerer: ['arcana', 'deception'],
  bard: ['athletics', 'insight', 'perception'],
};

const SCENARIOS = [
  {
    id: 'armadura/sem-armadura',
    source: 'base',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    scores: { forca: 15, destreza: 14, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    rule: '10 + DES',
    expected: (s) => 10 + mod(s.destreza),
  },
  {
    id: 'armadura/leve-couro',
    source: 'base',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    scores: { forca: 15, destreza: 14, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    equip: [{ itemSlug: 'leather', slot: 'armor' }],
    rule: '11 + DES',
    expected: (s) => 11 + mod(s.destreza),
  },
  {
    id: 'armadura/media-peitoral-cap-des',
    source: 'base',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    scores: { forca: 15, destreza: 18, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    equip: [{ itemSlug: 'breastplate', slot: 'armor' }],
    rule: '14 + min(DES, 2)',
    expected: (s) => 14 + Math.min(mod(s.destreza), 2),
  },
  {
    id: 'armadura/pesada-cota-de-malha',
    source: 'base',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    scores: { forca: 15, destreza: 18, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    equip: [{ itemSlug: 'chain-mail', slot: 'armor' }],
    rule: '16 (ignora DES)',
    expected: () => 16,
  },
  {
    id: 'armadura/couro-mais-escudo',
    source: 'base',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    scores: { forca: 15, destreza: 14, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    equip: [
      { itemSlug: 'leather', slot: 'armor' },
      { itemSlug: 'shield', slot: 'shield' },
    ],
    rule: '11 + DES + 2 (escudo)',
    expected: (s) => 11 + mod(s.destreza) + 2,
  },
  {
    id: 'classe/barbaro-defesa-sem-armadura',
    source: 'classe',
    classSlug: 'barbarian',
    subclassSlug: 'berserker',
    scores: { forca: 15, destreza: 14, constituicao: 16, inteligencia: 10, sabedoria: 12, carisma: 8 },
    rule: '10 + DES + CON (Defesa sem Armadura)',
    expected: (s) => 10 + mod(s.destreza) + mod(s.constituicao),
  },
  {
    id: 'classe/barbaro-defesa-sem-armadura-mais-escudo',
    source: 'classe',
    classSlug: 'barbarian',
    subclassSlug: 'berserker',
    scores: { forca: 15, destreza: 14, constituicao: 16, inteligencia: 10, sabedoria: 12, carisma: 8 },
    equip: [{ itemSlug: 'shield', slot: 'shield' }],
    rule: '10 + DES + CON + 2 (escudo é permitido)',
    expected: (s) => 10 + mod(s.destreza) + mod(s.constituicao) + 2,
  },
  {
    id: 'classe/monge-defesa-sem-armadura',
    source: 'classe',
    classSlug: 'monk',
    subclassSlug: 'open-hand',
    scores: { forca: 12, destreza: 16, constituicao: 13, inteligencia: 10, sabedoria: 16, carisma: 8 },
    rule: '10 + DES + SAB (Defesa sem Armadura)',
    expected: (s) => 10 + mod(s.destreza) + mod(s.sabedoria),
  },
  {
    id: 'subclasse/feiticeiro-draconico',
    source: 'subclasse',
    classSlug: 'sorcerer',
    subclassSlug: 'draconic',
    scores: { forca: 10, destreza: 14, constituicao: 14, inteligencia: 10, sabedoria: 12, carisma: 16 },
    rule: '10 + DES + CAR (Resiliência Dracônica)',
    expected: (s) => 10 + mod(s.destreza) + mod(s.carisma),
  },
  {
    id: 'subclasse/bardo-danca',
    source: 'subclasse',
    classSlug: 'bard',
    subclassSlug: 'dance',
    scores: { forca: 10, destreza: 14, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 16 },
    rule: '10 + DES + CAR (Ginga / Defesa sem Armadura)',
    expected: (s) => 10 + mod(s.destreza) + mod(s.carisma),
  },
  {
    id: 'talento/estilo-defensivo',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    scores: { forca: 15, destreza: 14, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    feats: [{ featSlug: 'defense', instanceIndex: 0 }],
    equip: [{ itemSlug: 'leather', slot: 'armor' }],
    rule: '11 + DES + 1 (Defensivo, usando armadura)',
    expected: (s) => 11 + mod(s.destreza) + 1,
  },
  {
    id: 'talento/mestre-armadura-media',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    // DES 14 + boost background +2 = 16 → cap 3
    scores: { forca: 15, destreza: 14, constituicao: 13, inteligencia: 12, sabedoria: 10, carisma: 8 },
    feats: [{ featSlug: 'medium-armor-master', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'medium-armor-master',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'forca',
      },
    ],
    equip: [{ itemSlug: 'breastplate', slot: 'armor' }],
    rule: '14 + min(DES, 3) com DES ≥ 16',
    expected: (s) => 14 + Math.min(mod(s.destreza), 3),
  },
];

function buildPayload(scenario) {
  return {
    name: `SMOKE CA ${scenario.id}`.slice(0, 100),
    level: LEVEL,
    classSlug: scenario.classSlug,
    subclassSlug: scenario.subclassSlug,
    speciesSlug: 'dwarf',
    backgroundSlug: 'criminal',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: scenario.scores,
    classSkillSlugs: CLASS_SKILLS[scenario.classSlug],
    languageSlugs: ['common', 'dwarvish'],
    speciesChoices: [],
    subclassOptions: [],
    characterFeats: [
      { featSlug: 'alert', instanceIndex: 0 },
      ...(scenario.feats ?? []),
    ],
    featOptions: scenario.featOptions ?? [],
    characterSpells: scenario.spells ?? [],
    equipment: [],
  };
}

async function listCatalogAcSources(dataSource) {
  const like = `%classe de armadura%`;
  const [classFeatures, subclassFeatures, feats, spells] = await Promise.all([
    dataSource.query(
      `SELECT c.slug AS owner, f.name, f.level
       FROM rpg.phb_class_feature f
       JOIN rpg.phb_class c ON c.id = f.class_id
       WHERE lower(f.description) LIKE $1
       ORDER BY c.slug, f.level`,
      [like],
    ),
    dataSource.query(
      `SELECT s.slug AS owner, f.name, f.level
       FROM rpg.phb_subclass_feature f
       JOIN rpg.phb_subclass s ON s.id = f.subclass_id
       WHERE lower(f.description) LIKE $1
       ORDER BY s.slug, f.level`,
      [like],
    ),
    dataSource.query(
      `SELECT DISTINCT f.slug AS owner, b.name
       FROM rpg.phb_feat_benefit b
       JOIN rpg.phb_feat f ON f.id = b.feat_id
       WHERE lower(b.description) LIKE $1
       ORDER BY f.slug`,
      [like],
    ),
    dataSource.query(
      `SELECT slug AS owner, name, level
       FROM rpg.phb_spell
       WHERE lower(description) LIKE $1
       ORDER BY level, slug`,
      [like],
    ),
  ]);

  return { classFeatures, subclassFeatures, feats, spells };
}

async function main() {
  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const create = app.get(CreateCharacterHandler);
  const del = app.get(DeleteCharacterHandler);
  const get = app.get(GetCharacterQuery);
  const addItem = app.get(AddInventoryItemHandler);
  const patchItem = app.get(PatchInventoryItemHandler);
  const dataSource = app.get(DataSource);

  console.log('=== Fontes de CA no catálogo ===');
  const sources = await listCatalogAcSources(dataSource);
  console.log(
    `Características de classe: ${sources.classFeatures.length}` +
      (sources.classFeatures.length
        ? ` → ${sources.classFeatures.map((r) => `${r.owner}/${r.name} (nv.${r.level})`).join('; ')}`
        : ''),
  );
  console.log(
    `Características de subclasse: ${sources.subclassFeatures.length}` +
      (sources.subclassFeatures.length
        ? ` → ${sources.subclassFeatures.map((r) => `${r.owner}/${r.name} (nv.${r.level})`).join('; ')}`
        : ''),
  );
  console.log(
    `Talentos: ${sources.feats.length}` +
      (sources.feats.length ? ` → ${sources.feats.map((r) => r.owner).join(', ')}` : ''),
  );
  console.log(
    `Magias: ${sources.spells.length}` +
      (sources.spells.length ? ` → ${sources.spells.map((r) => r.owner).join(', ')}` : ''),
  );

  console.log('\n=== Cenários de CA ===');
  const createdIds = [];
  const results = [];

  for (const scenario of SCENARIOS) {
    try {
      const created = await create.execute(USER_ID, buildPayload(scenario));
      createdIds.push(created.id);

      for (const piece of scenario.equip ?? []) {
        await addItem.execute(USER_ID, created.id, {
          itemSlug: piece.itemSlug,
          quantity: 1,
        });
        await patchItem.execute(USER_ID, created.id, piece.itemSlug, {
          location: 'equipped',
          equipmentSlot: piece.slot,
        });
      }

      const detail = await get.execute(USER_ID, created.id);
      const expected = scenario.expected(detail.abilityScores);
      const actual = detail.armorClass;
      const ok = actual === expected;

      console.log(
        `${ok ? 'OK  ' : 'FAIL'} [${scenario.source}] ${scenario.id}: CA=${actual} esperado=${expected} (${scenario.rule}) nota="${detail.armorClassNote}"`,
      );
      results.push({
        id: scenario.id,
        source: scenario.source,
        rule: scenario.rule,
        expected,
        actual,
        note: detail.armorClassNote,
        ok,
      });
    } catch (error) {
      const msg = error?.response?.message ?? error?.message ?? String(error);
      const text = Array.isArray(msg) ? msg.join('; ') : msg;
      console.log(`ERRO [${scenario.source}] ${scenario.id}: ${text}`);
      results.push({
        id: scenario.id,
        source: scenario.source,
        rule: scenario.rule,
        ok: false,
        error: text,
      });
    }
  }

  if (!KEEP) {
    for (const id of createdIds) {
      try {
        await del.execute(USER_ID, id);
      } catch {
        // ignore
      }
    }
  } else {
    console.log(`\nKEEP=1 — ${createdIds.length} fichas preservadas`);
  }

  await app.close();

  const okCount = results.filter((r) => r.ok).length;
  console.log('\n=== Resumo ===');
  console.log(`Cenários: ${okCount}/${results.length} OK`);
  for (const source of ['base', 'classe', 'subclasse', 'talento', 'magia']) {
    const group = results.filter((r) => r.source === source);
    if (!group.length) continue;
    const groupOk = group.filter((r) => r.ok).length;
    console.log(`  ${source}: ${groupOk}/${group.length}`);
  }

  const fails = results.filter((r) => !r.ok);
  if (fails.length) {
    console.log('\nFalhas:');
    for (const f of fails) {
      console.log(
        `  - [${f.source}] ${f.id}: ${f.error ?? `CA=${f.actual}, esperado ${f.expected} (${f.rule})`}`,
      );
    }
  }

  const fs = await import('fs');
  const reportPath = path.join(rootDir, 'scripts', 'smoke-armor-class-report.json');
  fs.writeFileSync(
    reportPath,
    JSON.stringify({ at: new Date().toISOString(), sources, results }, null, 2),
  );
  console.log(`\nRelatório: ${reportPath}`);

  if (fails.length > 0) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
