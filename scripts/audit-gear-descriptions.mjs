#!/usr/bin/env node
/**
 * Heurística: gear/focus em S046 com description que não termina em . ! ?
 * Cruza com S070 UPDATEs (WHERE slug = '…').
 *
 * Uso: node scripts/audit-gear-descriptions.mjs [--strict]
 */
import { readFileSync } from 'node:fs';
import { join } from 'node:path';

const seedsDir = join(process.cwd(), 'database', 'seeds', 'phb');
const s046 = readFileSync(join(seedsDir, 'S046_phb_item.sql'), 'utf8');
let s070 = '';
try {
  s070 = readFileSync(join(seedsDir, 'S070_phb_item_gear_descriptions.sql'), 'utf8');
} catch {
  /* optional */
}

// ('slug', 'gear'::rpg.item_type, 'Name', cost, weight, 'description…' | NULL, props)
const rowRe =
  /\(\s*'([^']+)'\s*,\s*'(gear|focus)'::rpg\.item_type\s*,\s*'((?:\\'|[^'])*)'\s*,\s*[^,]+,\s*[^,]+,\s*(?:'((?:\\'|[^'])*)'|NULL)/g;

/** @type {{ slug: string; type: string; description: string }[]} */
const truncated = [];

for (const row of s046.matchAll(rowRe)) {
  const slug = row[1];
  const type = row[2];
  const description = row[4];
  if (description == null) continue;
  const trimmed = description.replace(/\\'/g, "'").trim();
  if (!/[.!?]$/.test(trimmed)) {
    truncated.push({ slug, type, description: trimmed.slice(0, 80) });
  }
}

const fixedByS070 = new Set([
  ...[...s070.matchAll(/WHERE\s+(?:i\.)?slug\s*=\s*'([^']+)'/gi)].map((m) => m[1]),
  ...[...s070.matchAll(/\(\s*'([^']+)'\s*,\s*\$d\$/g)].map((m) => m[1]),
]);

const stillBroken = truncated.filter((row) => !fixedByS070.has(row.slug));

console.log(`Truncated in S046 (gear/focus): ${truncated.length}`);
console.log(
  `Covered by S070 UPDATEs: ${truncated.filter((r) => fixedByS070.has(r.slug)).length}`,
);
console.log(`Still truncated after S070: ${stillBroken.length}`);
for (const row of stillBroken.slice(0, 25)) {
  console.log(`  - ${row.slug} (${row.type}): ${row.description}…`);
}
if (stillBroken.length > 25) {
  console.log(`  … +${stillBroken.length - 25} more`);
}

if (process.argv.includes('--strict') && stillBroken.length > 0) {
  process.exit(1);
}
