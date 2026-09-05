#!/usr/bin/env node
/**
 * Aplica seeds SQL (catálogo PHB + Valdas). Destrutivo se tabelas já tiverem dados — preferir após dev-reset.
 *
 * Ordem de pastas (não lexicográfica pura entre packs):
 *   000_truncate → phb → … → combat → creatures → effects
 * `effects/` por último (depende de feats/resources de todos os packs).
 * Gunslinger depende de magias do Player Pack (ex.: finger-guns).
 *
 * Uso:
 *   node scripts/run-seeds.mjs
 *   node scripts/run-seeds.mjs --target=supabase
 *   node scripts/run-seeds.mjs --target=all
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles } from './lib/sql-files.mjs';

loadEnv();

const seedsDir = path.join(rootDir, 'database/seeds');

/** Packs na ordem de dependência (após 000_truncate.sql na raiz). */
const SEED_PACKS = [
  'phb',
  'subclass',
  'valdas',
  'valdas-gunslinger',
  'valdas-player-pack-2',
  'steinhardt-eldritch-hunt',
  'northlands-heroes',
  'griffons-saddlebag',
  'grim-hollow',
  'dmg',
  'combat',
  'creatures',
  'effects',
];

/** @param {string} arg */
function parseTarget(arg) {
  const value = arg?.split('=')[1] ?? 'local';
  if (!['local', 'supabase', 'all'].includes(value)) {
    console.error(`Target inválido: ${value}. Use local, supabase ou all.`);
    process.exit(1);
  }
  return value;
}

function resolveTargets(target) {
  /** @type {{ label: string, url: string }[]} */
  const targets = [];

  if (target === 'local' || target === 'all') {
    const url = process.env.DATABASE_URL;
    if (!url) {
      console.error('DATABASE_URL não definida.');
      process.exit(1);
    }
    targets.push({ label: 'local', url });
  }

  if (target === 'supabase' || target === 'all') {
    const url = process.env.SUPABASE_DATABASE_URL;
    if (!url) {
      console.error('SUPABASE_DATABASE_URL não definida.');
      process.exit(1);
    }
    targets.push({ label: 'supabase', url });
  }

  return targets;
}

/** @returns {string[]} */
function listSeedFilesInOrder() {
  const files = [];
  const truncate = path.join(seedsDir, '000_truncate.sql');
  if (fs.existsSync(truncate)) files.push(truncate);

  for (const pack of SEED_PACKS) {
    const packDir = path.join(seedsDir, pack);
    if (!fs.existsSync(packDir)) continue;
    files.push(...listSqlFiles(packDir));
  }

  return files;
}

/**
 * @param {string} label
 * @param {string} url
 */
async function seedOne(label, url) {
  console.log(`\n→ ${maskDatabaseUrl(url)}`);

  const client = createPgClient(url);
  await client.connect();

  try {
    const files = listSeedFilesInOrder();

    for (const filePath of files) {
      const relative = path.relative(rootDir, filePath).replace(/\\/g, '/');
      const sql = fs.readFileSync(filePath, 'utf8');

      process.stdout.write(`  seeding ${relative}... `);
      await client.query(sql);
      console.log('ok');
    }

    const materializedViews = [
      'mv_spell_by_class',
      'mv_phb_feat',
      'mv_phb_background',
      'mv_phb_species_trait_choices',
      'mv_phb_class_economy_action',
      'mv_phb_creature_template_bundle',
      'mv_phb_vehicle_template_bundle',
      'mv_phb_character_thread_bundle',
      'mv_phb_hp_bonus_source',
      'mv_phb_unarmored_defense',
      'mv_class_spell_slots',
      'mv_subclass_spell_slots',
      'mv_phb_class_ability_boost',
      'mv_phb_feat_granted_spell',
      'mv_phb_class_granted_spell',
      'mv_phb_species_granted_spell',
      'mv_phb_heritage_trait_choices',
    ];
    for (const name of materializedViews) {
      process.stdout.write(`  refresh rpg.${name}... `);
      await client.query(`REFRESH MATERIALIZED VIEW CONCURRENTLY rpg.${name}`);
      console.log('ok');
    }

    console.log(`  ${files.length} seed(s) aplicado(s)`);
  } finally {
    await client.end();
  }
}

const targetArg = process.argv.find((arg) => arg.startsWith('--target='));
const target = parseTarget(targetArg);
const targets = resolveTargets(target);

console.log(`Seeds — target: ${target}`);

for (const { label, url } of targets) {
  await seedOne(label, url);
}

console.log('\nConcluído.');
