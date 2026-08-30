/**
 * Gera J035 — opções de subclasse GH Cap. 2 (wizard create).
 * Uso: node scripts/generate-ghpg-cap2-subclass-options.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import {
  GHPG_CAP2_SUBCLASS_OPTIONS,
  valuesForOptionKey,
} from './lib/ghpg-cap2-subclass-options.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const outFile = path.join(
  apiRoot,
  'database/seeds/grim-hollow/J035_phb_subclass_option_ghpg_cap2.sql',
);

function sqlStr(s) {
  return String(s ?? '').replace(/'/g, "''");
}

let sql = `-- Grim Hollow Cap. 2 — opções de subclasse (wizard create)
-- Gerado por scripts/generate-ghpg-cap2-subclass-options.mjs

`;

for (const [subclassSlug, group] of Object.entries(GHPG_CAP2_SUBCLASS_OPTIONS)) {
  sql += `-- ${subclassSlug}\n`;
  for (const def of group.defs) {
    sql += `INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${subclassSlug}'),
  '${sqlStr(def.optionKey)}',
  '${sqlStr(def.label)}',
  ${def.unlockLevel},
  'catalog'::rpg.option_value_type,
  ${def.sortOrder}
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

`;
    const values = valuesForOptionKey(subclassSlug, def.optionKey);
    for (const v of values) {
      sql += `INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${subclassSlug}'),
  '${sqlStr(def.optionKey)}',
  '${sqlStr(v.valueId)}',
  '${sqlStr(v.label)}',
  ${v.sortOrder}
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

`;
    }
  }
  sql += '\n';
}

fs.writeFileSync(outFile, sql, 'utf8');
console.log('wrote', path.relative(apiRoot, outFile).replace(/\\/g, '/'));
