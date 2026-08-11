/**
 * Valida numeração sequencial sem lacunas/duplicatas em migrations/seeds.
 * Aceita início em 000 (ex.: S000_phb_edition).
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

/**
 * @param {string} dir relative to repo root
 * @param {string} prefix T|V|P|S|G|C
 * @param {{ allowZero?: boolean }} [opts]
 */
function checkSeq(dir, prefix, opts = {}) {
  const abs = path.join(root, dir);
  if (!fs.existsSync(abs)) {
    fail(`${dir}: directory missing`);
    return;
  }

  const files = fs
    .readdirSync(abs)
    .filter((n) => n.endsWith('.sql') && n.startsWith(prefix))
    .sort((a, b) => a.localeCompare(b, undefined, { sensitivity: 'base' }));

  const nums = [];
  for (const name of files) {
    const m = name.match(new RegExp(`^${prefix}(\\d{3})_`));
    if (!m) {
      fail(`${dir}/${name}: bad name pattern (want ${prefix}NNN_…)`);
      continue;
    }
    if (/^\d{3}[a-z]_/.test(name.slice(prefix.length))) {
      fail(`${dir}/${name}: suffix letter in number (use pure sequential)`);
    }
    nums.push(Number(m[1]));
  }

  if (nums.length === 0) {
    console.log(`OK ${dir}: 0 file(s)`);
    return;
  }

  const counts = new Map();
  for (const n of nums) counts.set(n, (counts.get(n) || 0) + 1);
  for (const [n, c] of counts) {
    if (c > 1) {
      const dups = files.filter((f) =>
        f.startsWith(`${prefix}${String(n).padStart(3, '0')}`),
      );
      fail(
        `${dir}: duplicate ${prefix}${String(n).padStart(3, '0')} → ${dups.join(', ')}`,
      );
    }
  }

  const sorted = [...new Set(nums)].sort((a, b) => a - b);
  const start = sorted[0];
  const end = sorted[sorted.length - 1];

  if (start > 1 || (start === 0 && !opts.allowZero)) {
    if (!(opts.allowZero && start === 0)) {
      fail(
        `${dir}: sequence should start at ${opts.allowZero ? '000 or 001' : '001'}, got ${prefix}${String(start).padStart(3, '0')}`,
      );
    }
  }

  const gaps = [];
  for (let i = start; i <= end; i += 1) {
    if (!counts.has(i)) gaps.push(i);
  }
  if (gaps.length) {
    fail(
      `${dir}: gaps ${gaps
        .slice(0, 12)
        .map((n) => `${prefix}${String(n).padStart(3, '0')}`)
        .join(', ')}${gaps.length > 12 ? '…' : ''}`,
    );
  }

  console.log(
    `OK ${dir}: ${files.length} file(s) (${prefix}${String(start).padStart(3, '0')}–${prefix}${String(end).padStart(3, '0')})`,
  );
}

checkSeq('database/migrations/020_tables', 'T');
checkSeq('database/migrations/060_views', 'V');
checkSeq('database/migrations/090_player', 'P');
checkSeq('database/seeds/phb', 'S', { allowZero: true });
checkSeq('database/seeds/subclass', 'S');
checkSeq('database/seeds/valdas', 'V');
checkSeq('database/seeds/valdas-gunslinger', 'G');
checkSeq('database/seeds/valdas-player-pack-2', 'P');
checkSeq('database/seeds/combat', 'C');

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
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    if (
      e.name === 'node_modules' ||
      e.name === 'dist' ||
      e.name.startsWith('_renumber') ||
      e.name === 'validate-sql-sequences.mjs' ||
      e.name.startsWith('_tmp-')
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
