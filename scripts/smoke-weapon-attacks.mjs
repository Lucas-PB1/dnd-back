#!/usr/bin/env node
/**
 * Smoke dos ataques com arma (bônus + dados).
 *
 * Parte 1: confere dados de amostra do catálogo (PHB).
 * Parte 2: cria fichas, equipa armas/estilos e compara weaponAttacks da API.
 *
 * Uso:
 *   node scripts/smoke-weapon-attacks.mjs
 *   KEEP=1 node scripts/smoke-weapon-attacks.mjs
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

const SCORES = {
  forca: 16,
  destreza: 14,
  constituicao: 13,
  inteligencia: 10,
  sabedoria: 12,
  carisma: 8,
};

const CATALOG_DICE = [
  { slug: 'longsword', damage: '1d8', category: 'martial' },
  { slug: 'greataxe', damage: '1d12', category: 'martial' },
  { slug: 'greatsword', damage: '2d6', category: 'martial' },
  { slug: 'dagger', damage: '1d4', category: 'simple' },
  { slug: 'longbow', damage: '1d8', category: 'martial' },
  { slug: 'shortbow', damage: '1d6', category: 'simple' },
  { slug: 'rapier', damage: '1d8', category: 'martial' },
  { slug: 'mace', damage: '1d6', category: 'simple' },
];

const SCENARIOS = [
  {
    id: 'base/espada-longa-guerreiro',
    source: 'base',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    equip: [{ itemSlug: 'longsword', slot: 'main_hand' }],
    rule: 'FOR + PB / 1d8 + FOR',
    expected: (s, pb) => [
      {
        mode: 'melee',
        attackBonus: mod(s.forca) + pb,
        damageDice: '1d8',
        damageBonus: mod(s.forca),
      },
    ],
  },
  {
    id: 'base/mago-sem-proficiencia-marciais',
    source: 'base',
    classSlug: 'wizard',
    subclassSlug: 'evoker',
    equip: [{ itemSlug: 'longsword', slot: 'main_hand' }],
    rule: 'FOR apenas (sem PB marcial)',
    expected: (s) => [
      {
        mode: 'melee',
        attackBonus: mod(s.forca),
        damageDice: '1d8',
        damageBonus: mod(s.forca),
      },
    ],
  },
  {
    id: 'estilo/arquearia-arco-longo',
    source: 'estilo',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    feats: [{ featSlug: 'archery', instanceIndex: 0 }],
    equip: [{ itemSlug: 'longbow', slot: 'main_hand' }],
    rule: 'DES + PB + 2 Arquearia',
    expected: (s, pb) => [
      {
        mode: 'ranged',
        attackBonus: mod(s.destreza) + pb + 2,
        damageDice: '1d8',
        damageBonus: mod(s.destreza),
      },
    ],
  },
  {
    id: 'estilo/duelismo-rapieira',
    source: 'estilo',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    feats: [{ featSlug: 'dueling', instanceIndex: 0 }],
    equip: [{ itemSlug: 'rapier', slot: 'main_hand' }],
    rule: 'melhor FOR/DES + PB; dano +2 Duelismo',
    expected: (s, pb) => {
      const ability = Math.max(mod(s.forca), mod(s.destreza));
      return [
        {
          mode: 'melee',
          attackBonus: ability + pb,
          damageDice: '1d8',
          damageBonus: ability + 2,
        },
      ];
    },
  },
  {
    id: 'estilo/arremesso-adaga',
    source: 'estilo',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    feats: [{ featSlug: 'thrown-weapon-fighting', instanceIndex: 0 }],
    equip: [{ itemSlug: 'dagger', slot: 'main_hand' }],
    rule: 'melee sem +2; ranged com +2 dano de arremesso',
    expected: (s, pb) => {
      const ability = Math.max(mod(s.forca), mod(s.destreza));
      return [
        {
          mode: 'melee',
          attackBonus: ability + pb,
          damageDice: '1d4',
          damageBonus: ability,
        },
        {
          mode: 'ranged',
          attackBonus: ability + pb,
          damageDice: '1d4',
          damageBonus: ability + 2,
        },
      ];
    },
  },
  {
    id: 'combo/arquearia-via-subclass-option',
    source: 'estilo',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    level: 7,
    fightingStyleOption: 'archery',
    equip: [{ itemSlug: 'shortbow', slot: 'main_hand' }],
    rule: 'Arquearia via opção de subclasse Champion (nv.7)',
    expected: (s, pb) => [
      {
        mode: 'ranged',
        attackBonus: mod(s.destreza) + pb + 2,
        damageDice: '1d6',
        damageBonus: mod(s.destreza),
      },
    ],
  },
  {
    id: 'talento/mestre-armas-grandes',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    level: 4,
    feats: [{ featSlug: 'great-weapon-master', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'great-weapon-master',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'forca',
      },
    ],
    equip: [{ itemSlug: 'greataxe', slot: 'main_hand' }],
    rule: '1d12 + FOR + PB (Maestria em Armas Pesadas)',
    expected: (s, pb) => [
      {
        mode: 'melee',
        attackBonus: mod(s.forca) + pb,
        damageDice: '1d12',
        damageBonus: mod(s.forca) + pb,
      },
    ],
  },
  {
    id: 'talento/mestre-armas-grandes-nao-pesa',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    level: 4,
    feats: [{ featSlug: 'great-weapon-master', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'great-weapon-master',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'forca',
      },
    ],
    equip: [{ itemSlug: 'longsword', slot: 'main_hand' }],
    rule: 'espada longa sem Pesada: sem +PB de dano',
    expected: (s, pb) => [
      {
        mode: 'melee',
        attackBonus: mod(s.forca) + pb,
        damageDice: '1d8',
        damageBonus: mod(s.forca),
      },
    ],
  },
  {
    id: 'talento/treino-marciais-mago',
    source: 'talento',
    classSlug: 'wizard',
    subclassSlug: 'evoker',
    level: 4,
    feats: [{ featSlug: 'martial-weapon-training', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'martial-weapon-training',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'forca',
      },
    ],
    equip: [{ itemSlug: 'longsword', slot: 'main_hand' }],
    rule: 'mago com Treinamento Marcial ganha PB na marcial',
    expected: (s, pb) => [
      {
        mode: 'melee',
        attackBonus: mod(s.forca) + pb,
        damageDice: '1d8',
        damageBonus: mod(s.forca),
      },
    ],
  },
];

async function resolveSubclassOptions(dataSource, subclassSlug, level, preferredStyle) {
  if (!subclassSlug) return undefined;
  const rows = await dataSource.query(
    `SELECT DISTINCT ON (d.option_key) d.option_key AS "optionKey", v.value_id AS "valueId"
     FROM rpg.phb_subclass_option_def d
     JOIN rpg.phb_subclass s ON s.id = d.subclass_id
     JOIN rpg.phb_subclass_option_value v
       ON v.subclass_id = d.subclass_id AND v.option_key = d.option_key
     WHERE s.slug = $1 AND d.unlock_level <= $2
     ORDER BY d.option_key,
       CASE WHEN v.value_id = $3 THEN 0 ELSE 1 END,
       v.value_id`,
    [subclassSlug, level, preferredStyle ?? ''],
  );
  return rows;
}

async function buildPayload(dataSource, scenario) {
  const skills =
    scenario.classSlug === 'wizard'
      ? ['arcana', 'history']
      : ['acrobatics', 'athletics'];

  const fightingStyleFeats = new Set([
    'archery',
    'dueling',
    'defense',
    'thrown-weapon-fighting',
    'two-weapon-fighting',
    'great-weapon-fighting',
    'protection',
    'interception',
    'blind-fighting',
    'unarmed-fighting',
  ]);
  const takenStyles = (scenario.feats ?? [])
    .map((f) => f.featSlug)
    .filter((slug) => fightingStyleFeats.has(slug));
  const preferredStyle =
    scenario.fightingStyleOption ??
    (takenStyles.includes('defense') ? 'archery' : 'defense');

  return {
    name: `SMOKE ATK ${scenario.id}`.slice(0, 100),
    level: scenario.level ?? LEVEL,
    classSlug: scenario.classSlug,
    subclassSlug: scenario.subclassSlug,
    speciesSlug: 'orc',
    backgroundSlug: 'criminal',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: SCORES,
    classSkillSlugs: skills,
    languageSlugs: ['common', 'orc'],
    speciesChoices: [],
    subclassOptions: await resolveSubclassOptions(
      dataSource,
      scenario.subclassSlug,
      scenario.level ?? LEVEL,
      preferredStyle,
    ),
    characterFeats: [
      { featSlug: 'alert', instanceIndex: 0 },
      ...(scenario.feats ?? []),
    ],
    featOptions: scenario.featOptions ?? [],
    characterSpells: [],
    equipment: [],
  };
}

function matchAttack(actual, expected) {
  return (
    actual.mode === expected.mode &&
    actual.attackBonus === expected.attackBonus &&
    actual.damageDice === expected.damageDice &&
    actual.damageBonus === expected.damageBonus
  );
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

  console.log('=== Dados de arma no catálogo ===');
  const catalogResults = [];
  for (const sample of CATALOG_DICE) {
    const rows = await dataSource.query(
      `SELECT w.damage, w.category
       FROM rpg.phb_weapon w
       JOIN rpg.phb_item i ON i.id = w.item_id
       WHERE i.slug = $1`,
      [sample.slug],
    );
    const row = rows[0];
    const ok =
      row && row.damage === sample.damage && row.category === sample.category;
    console.log(
      `${ok ? 'OK  ' : 'FAIL'} catalog/${sample.slug}: dano=${row?.damage} cat=${row?.category}`,
    );
    catalogResults.push({ id: `catalog/${sample.slug}`, source: 'catalog', ok });
  }

  console.log('\n=== Cenários de ataque ===');
  const createdIds = [];
  const results = [...catalogResults];

  for (const scenario of SCENARIOS) {
    try {
      const created = await create.execute(
        USER_ID,
        await buildPayload(dataSource, scenario),
      );
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
      const expected = scenario.expected(detail.abilityScores, detail.proficiencyBonus);
      const actual = detail.weaponAttacks ?? [];
      const ok =
        actual.length === expected.length &&
        expected.every((exp) =>
          actual.some((atk) => matchAttack(atk, exp)),
        );

      console.log(
        `${ok ? 'OK  ' : 'FAIL'} [${scenario.source}] ${scenario.id}: ` +
          `ataques=${JSON.stringify(actual.map((a) => ({
            mode: a.mode,
            atk: a.attackBonus,
            dmg: `${a.damageDice}+${a.damageBonus}`,
          })))} (${scenario.rule})`,
      );
      results.push({
        id: scenario.id,
        source: scenario.source,
        ok,
        expected,
        actual,
        rule: scenario.rule,
      });
    } catch (error) {
      const msg = error?.response?.message ?? error?.message ?? String(error);
      const text = Array.isArray(msg) ? msg.join('; ') : msg;
      console.log(`ERRO [${scenario.source}] ${scenario.id}: ${text}`);
      results.push({ id: scenario.id, source: scenario.source, ok: false, error: text });
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
  }

  await app.close();

  const okCount = results.filter((r) => r.ok).length;
  console.log('\n=== Resumo ===');
  console.log(`Cenários: ${okCount}/${results.length} OK`);
  for (const source of ['catalog', 'base', 'estilo', 'talento']) {
    const group = results.filter((r) => r.source === source);
    if (!group.length) continue;
    console.log(`  ${source}: ${group.filter((r) => r.ok).length}/${group.length}`);
  }

  const fails = results.filter((r) => !r.ok);
  if (fails.length) {
    console.log('\nFalhas:');
    for (const f of fails) {
      console.log(`  - [${f.source}] ${f.id}: ${f.error ?? JSON.stringify(f.actual)}`);
    }
  }

  const fs = await import('fs');
  const reportPath = path.join(rootDir, 'scripts', 'smoke-weapon-attacks-report.json');
  fs.writeFileSync(
    reportPath,
    JSON.stringify({ at: new Date().toISOString(), results }, null, 2),
  );
  console.log(`\nRelatório: ${reportPath}`);
  if (fails.length > 0) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
