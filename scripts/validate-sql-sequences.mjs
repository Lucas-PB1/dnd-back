/**
 * Valida numeração sequencial sem lacunas em migrations/seeds.
 * Uso: node scripts/validate-sql-sequences.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
let failed = false;

function fail(msg) {
  console.error(`FAIL: ${msg}`);
  failed = true;
}

function checkSeq(dir, prefix, expectedCount) {
  const abs = path.join(root, dir);
  const files = fs
    .readdirSync(abs)
    .filter((n) => n.endsWith('.sql') && n.startsWith(prefix))
    .sort((a, b) => a.localeCompare(b, undefined, { sensitivity: 'base' }));

  if (expectedCount != null && files.length !== expectedCount) {
    fail(`${dir}: expected ${expectedCount} ${prefix}* files, got ${files.length}`);
  }

  const nums = [];
  for (const name of files) {
    const m = name.match(new RegExp(`^${prefix}(\\d{3})[a-z]?_`));
    if (!m) {
      fail(`${dir}/${name}: bad name pattern`);
      continue;
    }
    if (/[a-z]_/.test(name.slice(prefix.length + 3, prefix.length + 5))) {
      // allow only digit after prefix+digits — reject G011b style
    }
    if (/^\d{3}[a-z]_/.test(name.slice(prefix.length))) {
      fail(`${dir}/${name}: suffix letter in number (use pure sequential)`);
    }
    nums.push(Number(m[1]));
  }

  for (let i = 0; i < nums.length; i += 1) {
    if (nums[i] !== i + 1) {
      fail(`${dir}: expected ${prefix}${String(i + 1).padStart(3, '0')} at index ${i}, got ${prefix}${String(nums[i]).padStart(3, '0')}`);
      break;
    }
  }

  const set = new Set(nums);
  if (set.size !== nums.length) fail(`${dir}: duplicate numbers`);

  console.log(`OK ${dir}: ${files.length} file(s)`);
}

checkSeq('database/migrations/020_tables', 'T', 80);
checkSeq('database/migrations/060_views', 'V', 32);
checkSeq('database/migrations/090_player', 'P', 16);
checkSeq('database/seeds/phb', 'S', 80);
checkSeq('database/seeds/subclass', 'S', 7);
checkSeq('database/seeds/valda', 'V', 15);
checkSeq('database/seeds/valda-gunslinger', 'G', 28);

// Stale path references
const stale = [
  'S014' + 'a_',
  'G000' + '_',
  'G011' + 'b_',
  'V038_v_class_spell_slots_progression_' + 'fix',
  'T081_species_feat_granted_' + 'spells',
  'V039_v_species_feat_granted_' + 'spell',
  '050_' + 'data/',
];

function walk(dir, out = []) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    if (
      e.name === 'node_modules' ||
      e.name === 'dist' ||
      e.name.startsWith('_renumber') ||
      e.name === 'validate-sql-sequences.mjs'
    ) {
      continue;
    }
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (/\.(mjs|js|ts|md|json)$/.test(e.name)) out.push(p);
  }
  return out;
}

for (const file of walk(path.join(root, 'scripts')).concat(
  walk(path.join(root, 'docs')),
  walk(path.join(root, '.cursor')),
  walk(path.join(root, 'database')),
)) {
  const text = fs.readFileSync(file, 'utf8');
  for (const s of stale) {
    if (text.includes(s)) fail(`stale "${s}" in ${path.relative(root, file)}`);
  }
}

if (failed) {
  process.exit(1);
}
console.log('\nAll sequence checks passed.');
