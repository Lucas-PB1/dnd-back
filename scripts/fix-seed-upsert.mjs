#!/usr/bin/env node
/**
 * Acrescenta ON CONFLICT (slug) DO NOTHING em seeds VALUES simples sem upsert.
 * Effects CTE: marca -- seed-mode: truncate-scoped
 * Uso: node scripts/fix-seed-upsert.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const seedsDir = path.join(root, 'database/seeds');

function walk(dir, out = []) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (e.name.endsWith('.sql')) out.push(p);
  }
  return out;
}

function needsFix(text) {
  return /\bINSERT\b/i.test(text) && !/\bON\s+CONFLICT\b/i.test(text);
}

function isEffectCte(text, rel) {
  return (
    (rel.startsWith('effect/') || rel.startsWith('transformation/')) &&
    /INSERT INTO rpg\.phb_effect\b/i.test(text)
  );
}

/**
 * Append ON CONFLICT (slug) DO NOTHING before terminating ; of last INSERT VALUES
 * when the INSERT lists slug as a column.
 */
function addSlugConflict(text) {
  if (!/INSERT INTO rpg\.\w+\s*\([^)]*\bslug\b/i.test(text)) {
    return null;
  }
  // Already ends with conflict
  if (/\bON\s+CONFLICT\b/i.test(text)) return text;

  const trimmed = text.replace(/\s+$/, '');
  if (!trimmed.endsWith(';')) return null;

  return `${trimmed.slice(0, -1)}\nON CONFLICT (slug) DO NOTHING;\n`;
}

let fixed = 0;
let marked = 0;
let skipped = [];

for (const filePath of walk(seedsDir)) {
  if (path.basename(filePath) === '000_truncate.sql') continue;
  const rel = path.relative(seedsDir, filePath).replace(/\\/g, '/');
  let text = fs.readFileSync(filePath, 'utf8');
  if (!needsFix(text)) continue;

  if (isEffectCte(text, rel)) {
    if (!text.includes('seed-mode: truncate-scoped')) {
      text = `-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)\n${text}`;
      fs.writeFileSync(filePath, text, 'utf8');
      marked += 1;
    }
    continue;
  }

  const next = addSlugConflict(text);
  if (next) {
    fs.writeFileSync(filePath, next, 'utf8');
    fixed += 1;
  } else {
    skipped.push(rel);
  }
}

console.log(`Fixed slug upsert: ${fixed}`);
console.log(`Marked truncate-scoped effects: ${marked}`);
console.log(`Still missing: ${skipped.length}`);
skipped.forEach((s) => console.log(' ', s));
