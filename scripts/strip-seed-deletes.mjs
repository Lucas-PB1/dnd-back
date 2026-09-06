#!/usr/bin/env node
/**
 * Remove DELETE FROM … em seeds de domínio (truncate + upsert cobrem).
 * Uso: node scripts/strip-seed-deletes.mjs [--dry-run]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const seedsDir = path.join(root, 'database/seeds');
const dry = process.argv.includes('--dry-run');

function walk(dir, out = []) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (e.name.endsWith('.sql') && e.name !== '000_truncate.sql') out.push(p);
  }
  return out;
}

/** Remove statements DELETE FROM … ; (incl. multilinha até ;) */
function stripDeletes(sql) {
  return sql.replace(/\bDELETE\s+FROM\b[\s\S]*?;\s*/gi, '');
}

let n = 0;
for (const f of walk(seedsDir)) {
  const before = fs.readFileSync(f, 'utf8');
  if (!/\bDELETE\s+FROM\b/i.test(before)) continue;
  const after = stripDeletes(before);
  n += 1;
  const rel = path.relative(seedsDir, f).replace(/\\/g, '/');
  console.log(`${dry ? '[dry] ' : ''}${rel}`);
  if (!dry) fs.writeFileSync(f, after, 'utf8');
}
console.log(`stripped deletes in ${n} file(s)`);
