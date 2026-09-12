#!/usr/bin/env node
/**
 * Gera SEED_ORDER.txt na ordem histórica dos packs (git HEAD).
 * Casa legado → path atual por source+stem, depois hash normalizado.
 *
 * Uso: node scripts/generate/seed-order.mjs
 */
import { execSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const seedsDir = path.join(root, 'database/seeds');

const OLD_PACKS = [
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

const PACK_SOURCE = {
  phb: 'phb',
  subclass: 'phb',
  valdas: 'valdas',
  'valdas-gunslinger': 'valdas',
  'valdas-player-pack-2': 'valdas',
  'steinhardt-eldritch-hunt': 'steinhardt',
  'northlands-heroes': 'northlands',
  'griffons-saddlebag': 'griffons-saddlebag',
  'grim-hollow': 'grim-hollow',
  dmg: 'dmg',
  combat: null,
  creatures: 'phb',
  effects: null,
};

/** Basename legado → path relativo atual. */
const EXACT_MAP = {
  'E001_phb.sql': 'effect/phb/phb_effect.phb.sql',
  'E002_steinhardt.sql': 'effect/steinhardt/phb_effect.steinhardt.sql',
  'E003_grim_hollow.sql': 'effect/grim-hollow/phb_effect.grim-hollow.sql',
  'E004_northlands.sql': 'effect/northlands/phb_effect.northlands.sql',
  'E005_valdas.sql': 'effect/valdas/phb_effect.valdas.sql',
  'E006_mesa_spend.sql': 'effect/phb/phb_effect.mesa-spend.sql',
  'E007_species.sql': 'effect/phb/phb_effect.species.sql',
  'E008_ghpg_transform.sql':
    'transformation/grim-hollow/phb_effect.grant-resource.gh-transformations.sql',
  'E014_combat_mod.sql': 'effect/phb/phb_effect.combat-mod.sql',
  'E015_ghpg_transform_table_action.sql':
    'transformation/grim-hollow/phb_effect.table-note.gh-transformations.sql',
  'E016_ghpg_transform_combat_mod.sql':
    'transformation/grim-hollow/phb_effect.combat-mod.gh-transformations.sql',
  'J019_phb_feat_ghpg_transformations.sql':
    'transformation/grim-hollow/phb_feat.gh-transformations.sql',
  'J060_phb_feat_option_ghpg_transformations.sql':
    'transformation/grim-hollow/phb_feat_option.gh-transformations.sql',
  'J061_phb_resource_ghpg_cap6_transformations.sql':
    'transformation/grim-hollow/phb_resource_definition.gh-transformations.sql',
  'C078_phb_feat_economy_ghpg_cap6_transformations.sql':
    'economy/grim-hollow/phb_class_economy_action.gh-transformations.sql',
  'C075_phb_feat_economy_ghpg_cap4.sql':
    'economy/grim-hollow/phb_class_economy_action.gh-cap4-feats.sql',
  'S013_phb_spell_school.sql': 'catalog/phb/phb_spell.01-school.sql',
  'S014_phb_spell.sql': 'catalog/phb/phb_spell.02-all.sql',
  'S015_phb_spell_slot_pattern.sql': 'catalog/phb/phb_spell_slot.01-pattern.sql',
  'S016_phb_spell_slot_by_level.sql': 'catalog/phb/phb_spell_slot.02-by-level.sql',
  'S025_phb_spell_class.sql': 'class/phb/phb_spell_class.all.sql',
  'S039_phb_background_starting_package.sql':
    'item/phb/phb_background.starting.01-package.sql',
  'S040_phb_background_starting_item.sql':
    'item/phb/phb_background.starting.02-item.sql',
  'S042_phb_class_starting_package.sql':
    'item/phb/phb_class.starting.01-package.sql',
  'S043_phb_class_starting_item.sql': 'item/phb/phb_class.starting.02-item.sql',
  'G006_phb_class_weapon_proficiency.sql':
    'class/valdas/phb_class.weapon-proficiency.sql',
  'P009_phb_item_familiars.sql': 'item/valdas/phb_item.familiars.sql',
  'N020_phb_class_fighting_style.sql':
    'class/northlands/phb_class.fighting-style.sql',
  'N036_phb_character_threads.sql':
    'thread/northlands/phb_character.threads.sql',
  'J014_phb_feat_ghpg_cap4.sql': 'feat/grim-hollow/phb_feat.gh-cap4.sql',
  'J042b_phb_resource_ghpg_cap4_feats.sql':
    'economy/grim-hollow/phb_resource.ghpg-cap4-feats.sql',
  'J043_phb_spell_cap7.sql': 'spell/grim-hollow/phb_spell.cap7.sql',
  'C045_phb_item_economy_action_dmg_artifacts_fix.sql':
    'item/dmg/phb_item.economy-action-dmg-artifacts-fix.sql',
  'N017_phb_feat.sql': 'feat/northlands/phb_feat.all.02.sql',
  'N018_phb_feat_benefit.sql': 'feat/northlands/phb_feat_benefit.all.02.sql',
  'S002_phb_resource_definition.sql':
    'economy/phb/phb_resource_definition.all.02.sql',
  'S006_phb_spell_source.sql': 'class/phb/phb_spell_source.all.02.sql',
};

function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (e.name.endsWith('.sql') && e.name !== '000_truncate.sql') out.push(p);
  }
  return out;
}

function normalize(sql) {
  return sql
    .replace(/^\uFEFF/, '')
    .replace(/\r\n/g, '\n')
    .replace(/^-- seed-mode:.*\n/gm, '')
    .replace(/;?\s*ON CONFLICT[\s\S]*$/i, '')
    .replace(/;\s*$/m, '')
    .trim();
}

function hashOf(sql) {
  return crypto.createHash('sha1').update(normalize(sql)).digest('hex');
}

function stripPrefix(name) {
  return name.replace(/^[A-Z]\d{3}[a-z]?_/, '').replace(/\.sql$/i, '');
}

/** @type {Map<string, string[]>} */
const byStem = new Map();
/** @type {Map<string, string[]>} */
const byHash = new Map();
/** @type {string[]} */
const allRels = [];

for (const f of walk(seedsDir)) {
  const rel = path.relative(seedsDir, f).replace(/\\/g, '/');
  if (rel === 'SEED_ORDER.txt') continue;
  allRels.push(rel);
  const base = path.basename(f, '.sql');
  const parts = base.split('.');
  const table = parts[0];
  for (const key of [table, base, parts.slice(0, 2).join('.')]) {
    if (!byStem.has(key)) byStem.set(key, []);
    if (!byStem.get(key).includes(rel)) byStem.get(key).push(rel);
  }
  const h = hashOf(fs.readFileSync(f, 'utf8'));
  if (!byHash.has(h)) byHash.set(h, []);
  if (!byHash.get(h).includes(rel)) byHash.get(h).push(rel);
}

function benefitDest(base) {
  const m = base.match(
    /^J\d{3}[a-z]?_phb_feat_benefit_ghpg_transformation_(.+)\.sql$/i,
  );
  if (!m) return null;
  return `transformation/grim-hollow/phb_feat_benefit.${m[1].replace(/_/g, '-')}.sql`;
}

/**
 * @param {string} base
 * @param {string | null} preferredSource
 * @param {string[]} unused
 */
function resolveByName(base, preferredSource, unused) {
  if (EXACT_MAP[base] && unused.includes(EXACT_MAP[base])) {
    return EXACT_MAP[base];
  }
  const benefit = benefitDest(base);
  if (benefit && unused.includes(benefit)) return benefit;

  const stem = stripPrefix(base);
  const candidates = [];
  for (const key of [stem, `${stem}.all`, stem.replace(/_/g, '-')]) {
    for (const rel of byStem.get(key) || []) {
      if (unused.includes(rel) && !candidates.includes(rel)) candidates.push(rel);
    }
  }
  if (candidates.length === 0) return null;

  candidates.sort((a, b) => {
    const score = (rel) => {
      let s = 0;
      if (preferredSource && rel.includes(`/${preferredSource}/`)) s += 100;
      if (/\.all\.sql$/.test(rel) || /\.all\.\d+\.sql$/.test(rel) === false && rel.endsWith('.all.sql'))
        s += 10;
      if (rel.includes('.all.sql')) s += 10;
      if (!/\.\d{2}\.sql$/.test(rel)) s += 5;
      return s;
    };
    const d = score(b) - score(a);
    if (d !== 0) return d;
    return a < b ? -1 : a > b ? 1 : 0;
  });

  const best = candidates[0];
  if (preferredSource && !best.includes(`/${preferredSource}/`)) {
    // Name match sem source certo → deixa hash decidir
    return null;
  }
  return best;
}

const oldList = execSync('git ls-tree -r HEAD --name-only database/seeds', {
  cwd: root,
  encoding: 'utf8',
})
  .split('\n')
  .map((l) => l.trim())
  .filter((l) => l.endsWith('.sql') && !l.includes('000_truncate'));

const ordered = [];
const used = new Set();
let matchedName = 0;
let matchedHash = 0;
let missed = 0;

for (const pack of OLD_PACKS) {
  const preferredSource = PACK_SOURCE[pack] ?? null;
  const packFiles = oldList
    .filter((l) => l.startsWith(`database/seeds/${pack}/`))
    .sort((a, b) => (a < b ? -1 : a > b ? 1 : 0));
  for (const oldPath of packFiles) {
    const base = path.basename(oldPath);
    if (
      /deprecated|cleanup|_rename|_migrate_/i.test(base) ||
      base === 'S010b_phb_feat_slug_rename.sql' ||
      base === 'S061_phb_hp_bonus_source.sql' ||
      base === 'S062_phb_unarmored_defense.sql'
    ) {
      continue;
    }
    const unused = allRels.filter((r) => !used.has(r));
    let hit = resolveByName(base, preferredSource, unused);
    if (hit) {
      ordered.push(hit);
      used.add(hit);
      matchedName += 1;
      continue;
    }
    let content;
    try {
      content = execSync(`git show HEAD:${oldPath}`, {
        cwd: root,
        encoding: 'utf8',
        maxBuffer: 30 * 1024 * 1024,
      });
    } catch {
      missed += 1;
      continue;
    }
    const h = hashOf(content);
    const hashHits = (byHash.get(h) || []).filter((c) => !used.has(c));
    if (hashHits.length === 0) {
      missed += 1;
      console.warn(`MISS ${pack}/${base}`);
      continue;
    }
    // Prefer same source among hash hits
    hashHits.sort((a, b) => {
      const as = preferredSource && a.includes(`/${preferredSource}/`) ? 0 : 1;
      const bs = preferredSource && b.includes(`/${preferredSource}/`) ? 0 : 1;
      return as - bs || (a < b ? -1 : a > b ? 1 : 0);
    });
    hit = hashHits[0];
    ordered.push(hit);
    used.add(hit);
    matchedHash += 1;
  }
}

for (const rel of allRels) {
  if (!used.has(rel)) {
    ordered.push(rel);
    used.add(rel);
  }
}

fs.writeFileSync(
  path.join(seedsDir, 'SEED_ORDER.txt'),
  `# Ordem FK-safe (packs históricos). Gerar: node scripts/generate/seed-order.mjs\n${ordered.join('\n')}\n`,
  'utf8',
);
console.log(
  `name=${matchedName} hash=${matchedHash} missed=${missed} total=${ordered.length}`,
);
console.log('first25:');
for (const line of ordered.slice(0, 25)) console.log(`  ${line}`);
