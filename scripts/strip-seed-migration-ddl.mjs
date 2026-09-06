#!/usr/bin/env node
/**
 * Remove DDL/DELETE de migração dos seeds (zero ALTER/DROP; truncate cobre limpeza).
 * Uso: node scripts/strip-seed-migration-ddl.mjs
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

// 1) combat-mod: cortar views/DROP após último INSERT de effect
{
  const p = path.join(seedsDir, 'effect/phb/phb_effect.combat-mod.sql');
  let t = fs.readFileSync(p, 'utf8');
  const idx = t.indexOf('-- Views passam a ler phb_effect');
  if (idx >= 0) {
    t = `${t.slice(0, idx).trimEnd()}\n`;
    fs.writeFileSync(p, t, 'utf8');
    console.log('Trimmed DDL from combat-mod');
  }
}

// 2) grant-resource Cap.6: remover DELETE phb_resource_grant
{
  const p = path.join(
    seedsDir,
    'transformation/grim-hollow/phb_effect.grant-resource.gh-transformations.sql',
  );
  let t = fs.readFileSync(p, 'utf8');
  const idx = t.indexOf('\nDELETE FROM rpg.phb_resource_grant');
  if (idx >= 0) {
    t = `${t.slice(0, idx).trimEnd()}\n`;
    fs.writeFileSync(p, t, 'utf8');
    console.log('Removed resource_grant DELETE from Cap.6 effects');
  }
}

let stripped = 0;
for (const filePath of walk(seedsDir)) {
  if (path.basename(filePath) === '000_truncate.sql') continue;
  let text = fs.readFileSync(filePath, 'utf8');
  const orig = text;

  // DROP anywhere in seeds
  if (/\bDROP\s+(TABLE|TYPE|SCHEMA|MATERIALIZED|VIEW)\b/i.test(text)) {
    text = text.replace(/^.*\bDROP\s+(TABLE|TYPE|SCHEMA|MATERIALIZED|VIEW)\b.*$/gim, '');
  }

  // CREATE OR REPLACE VIEW / CREATE MATERIALIZED VIEW in seeds
  if (/\bCREATE\s+(OR\s+REPLACE\s+)?(MATERIALIZED\s+)?VIEW\b/i.test(text)) {
    // cut from first CREATE VIEW to EOF if file also has inserts before — only if combat already handled
    const m = text.search(/\nCREATE\s+(OR\s+REPLACE\s+)?(MATERIALIZED\s+)?VIEW\b/i);
    if (m >= 0 && /\bINSERT\b/i.test(text.slice(0, m))) {
      text = `${text.slice(0, m).trimEnd()}\n`;
    }
  }

  // Leading / block DELETE FROM … (migration cleanup) — keep if mid-file complex? strip all DELETE lines/statements
  // Heuristic: remove DELETE … ; blocks (including multi-line until ;)
  text = text.replace(/\n?DELETE\s+FROM\b[\s\S]*?;/gi, '\n');

  if (text !== orig) {
    fs.writeFileSync(filePath, text.replace(/\n{3,}/g, '\n\n'), 'utf8');
    stripped += 1;
    console.log('Cleaned', path.relative(seedsDir, filePath));
  }
}

console.log(`Cleaned ${stripped} files`);
