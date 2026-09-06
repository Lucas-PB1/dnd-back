#!/usr/bin/env node
/**
 * Segunda passagem: ON CONFLICT em junction / PK compostos.
 * Uso: node scripts/fix-seed-upsert-pass2.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const seedsDir = path.join(root, 'database/seeds');

/** @type {Record<string, string>} */
const CONFLICT = {
  phb_background_skill: 'ON CONFLICT (background_id, skill_id) DO NOTHING',
  phb_background_ability_option: 'ON CONFLICT DO NOTHING',
  phb_background_boost_option: 'ON CONFLICT DO NOTHING',
  phb_class_skill_pool: 'ON CONFLICT DO NOTHING',
  phb_class_proficiency: 'ON CONFLICT DO NOTHING',
  phb_class_progression: 'ON CONFLICT (class_id, level) DO UPDATE SET proficiency_bonus = EXCLUDED.proficiency_bonus, cantrips = EXCLUDED.cantrips, prepared_spells = EXCLUDED.prepared_spells, channel_divinity = EXCLUDED.channel_divinity',
  phb_subclass_progression: 'ON CONFLICT (subclass_id, level) DO NOTHING',
  phb_class_ability_boost: 'ON CONFLICT DO NOTHING',
  phb_class_spellcasting: 'ON CONFLICT DO NOTHING',
  phb_feat_benefit: 'ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description',
  phb_spell_slot_by_level: 'ON CONFLICT DO NOTHING',
  phb_starting_item: 'ON CONFLICT DO NOTHING',
  phb_starting_package: 'ON CONFLICT DO NOTHING',
  phb_option_value: 'ON CONFLICT DO NOTHING',
  phb_option_def: 'ON CONFLICT DO NOTHING',
};

function walk(dir, out = []) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (e.name.endsWith('.sql')) out.push(p);
  }
  return out;
}

let fixed = 0;
const still = [];

for (const filePath of walk(seedsDir)) {
  if (path.basename(filePath) === '000_truncate.sql') continue;
  let text = fs.readFileSync(filePath, 'utf8');
  if (!/\bINSERT\b/i.test(text) || /\bON\s+CONFLICT\b/i.test(text)) continue;
  if (text.includes('seed-mode: truncate-scoped')) continue;

  const m = text.match(/INSERT INTO rpg\.(\w+)/i);
  if (!m) {
    still.push(path.relative(seedsDir, filePath));
    continue;
  }
  const clause = CONFLICT[m[1]];
  if (!clause) {
    still.push(`${path.relative(seedsDir, filePath)} (${m[1]})`);
    continue;
  }
  const trimmed = text.replace(/\s+$/, '');
  if (!trimmed.endsWith(';')) {
    still.push(path.relative(seedsDir, filePath));
    continue;
  }
  fs.writeFileSync(filePath, `${trimmed.slice(0, -1)}\n${clause};\n`, 'utf8');
  fixed += 1;
}

console.log(`Fixed: ${fixed}`);
console.log(`Still: ${still.length}`);
still.forEach((s) => console.log(' ', s));
