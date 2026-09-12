#!/usr/bin/env node
/**
 * Gera seed de phb_transformation_boon_combat_note a partir dos batches TS Cap.6.
 * Uso: node scripts/generate-cap6-boon-combat-notes-seed.mjs
 */
import { readFileSync, writeFileSync, readdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, '..');
const batchesDir = join(
  root,
  'src/game/combat/domain/notes/grim-hollow/transformation-combat-notes-data/batches',
);

function sqlEscape(value) {
  return String(value).replace(/'/g, "''");
}

function extractNotesObject(src) {
  const all = {};
  const re =
    /export const NOTES_\w+\s*:\s*Record<string,\s*Cap6BoonCombatNote>\s*=\s*(\{[\s\S]*?\n\});/g;
  let match;
  while ((match = re.exec(src)) != null) {
    const obj = Function(`"use strict"; return (${match[1]});`)();
    Object.assign(all, obj);
  }
  return all;
}

const notes = {};
for (const file of readdirSync(batchesDir).filter((f) => f.endsWith('.ts'))) {
  Object.assign(notes, extractNotesObject(readFileSync(join(batchesDir, file), 'utf8')));
}

const values = Object.entries(notes)
  .sort(([a], [b]) => a.localeCompare(b))
  .map(([boonId, meta]) => {
    const economy = (meta.economy ?? [])
      .map((e) => `'${sqlEscape(e)}'`)
      .join(', ');
    const notePt =
      meta.notePt != null ? `'${sqlEscape(meta.notePt)}'` : 'NULL';
    return `  ('${sqlEscape(boonId)}', '${sqlEscape(meta.namePt)}', ARRAY[${economy}]::text[], ${notePt})`;
  })
  .join(',\n');

const out = `-- Cap.6 — notas de combate por boon (SSOT; gerado por scripts/generate-cap6-boon-combat-notes-seed.mjs)

INSERT INTO rpg.phb_transformation_boon_combat_note (boon_id, name_pt, economy, note_pt)
VALUES
${values}
ON CONFLICT (boon_id) DO UPDATE SET
  name_pt = EXCLUDED.name_pt,
  economy = EXCLUDED.economy,
  note_pt = EXCLUDED.note_pt;
`;

const outPath = join(
  root,
  'database/seeds/transformation/grim-hollow/phb_transformation_boon_combat_note.all.sql',
);
writeFileSync(outPath, out);
console.log(`Wrote ${Object.keys(notes).length} boon combat notes → ${outPath}`);
