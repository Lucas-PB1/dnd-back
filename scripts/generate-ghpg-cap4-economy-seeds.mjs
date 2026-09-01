#!/usr/bin/env node
/**
 * Gera C075 (economy) + J042b (recursos de talento) — GH Cap. 4 Fase C.
 * Uso: node scripts/generate-ghpg-cap4-economy-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import {
  CAP4_ECONOMY_P0,
  CAP4_FEAT_RESOURCES,
} from './lib/ghpg-cap4-economy-config.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const combatDir = path.join(apiRoot, 'database/seeds/combat');
const ghDir = path.join(apiRoot, 'database/seeds/grim-hollow');

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

function buildEconomySql() {
  const valueRows = CAP4_ECONOMY_P0.map((row) => {
    const resource = row.resourceSlug ? sqlLiteral(row.resourceSlug) : 'NULL';
    const tableAction = row.tableAction ? sqlLiteral(row.tableAction) : 'NULL';
    const alwaysSpend = row.alwaysSpendsResource ? 'TRUE' : 'FALSE';
    return `(
  ${sqlLiteral(row.actionId)}, NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(row.featSlug)}), NULL,
  ${sqlLiteral(row.name)}, ${sqlLiteral(row.economy)}::rpg.action_economy_bucket, ${row.unlockLevel},
  ${resource}, NULL, ${alwaysSpend},
  ${sqlLiteral(row.summary)}, ${sqlLiteral(row.description)},
  ${tableAction}, NULL, ${row.sortOrder}, NULL, NULL
)`;
  });

  return `-- Economy — talentos Grim Hollow Cap. 4 (Fase C)
-- Gerado por scripts/generate-ghpg-cap4-economy-seeds.mjs

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
${valueRows.join(',\n')}
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
`;
}

function buildResourceSql() {
  const defRows = CAP4_FEAT_RESOURCES.map(
    (row) => `(
  ${sqlLiteral(row.slug)},
  ${sqlLiteral(row.name)},
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = ${sqlLiteral(row.featSlug)}),
  ${row.unlockLevel}
)`,
  );

  const grantBlocks = CAP4_FEAT_RESOURCES.map((row) => {
    const fixedMax = row.maxFormula === 'fixed' ? (row.fixedMax ?? 1) : 'NULL';
    const maxFormula =
      row.maxFormula === 'fixed'
        ? `'fixed'::rpg.resource_max_formula`
        : `'proficiency_bonus'::rpg.resource_max_formula`;
    const recoverShort = row.recoverAllOnShort ? 'TRUE' : 'FALSE';
    const recoverLong = row.recoverAllOnLong !== false ? 'TRUE' : 'FALSE';
    return `INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, ${row.unlockLevel},
  ${maxFormula}, ${fixedMax},
  FALSE, ${recoverShort}, ${recoverLong}
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = ${sqlLiteral(row.slug)} AND rd.feat_id = f.id
WHERE f.slug = ${sqlLiteral(row.featSlug)}
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;`;
  });

  return `-- Recursos de talento — Grim Hollow Cap. 4 (Fase C)
-- Gerado por scripts/generate-ghpg-cap4-economy-seeds.mjs

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
${defRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;

${grantBlocks.join('\n\n')}
`;
}

fs.mkdirSync(combatDir, { recursive: true });
fs.mkdirSync(ghDir, { recursive: true });

const economyPath = path.join(
  combatDir,
  'C075_phb_feat_economy_ghpg_cap4.sql',
);
const resourcePath = path.join(
  ghDir,
  'J042b_phb_resource_ghpg_cap4_feats.sql',
);

fs.writeFileSync(economyPath, buildEconomySql(), 'utf8');
fs.writeFileSync(resourcePath, buildResourceSql(), 'utf8');

console.log(`Wrote ${economyPath}`);
console.log(`Wrote ${resourcePath}`);
console.log(`  economy actions: ${CAP4_ECONOMY_P0.length}`);
console.log(`  feat resources: ${CAP4_FEAT_RESOURCES.length}`);
