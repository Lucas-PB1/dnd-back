#!/usr/bin/env node
/**
 * Gera resource defs + grant_resource effects + economy Cap.6
 * a partir de cap6-economy.json.
 * Uso: node scripts/generate/cap6-economy-seeds.mjs
 */
import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, '../..');
const economy = JSON.parse(
  readFileSync(
    join(root, 'docs/source/extracts/grim-hollow/cap6-economy.json'),
    'utf8',
  ),
);

const PB_PLUS_STAGE = new Set(
  economy.resources
    .filter((r) => r.maxFormula === 'proficiency_bonus_plus_stage')
    .map((r) => r.slug),
);

function sqlEscape(value) {
  return value.replace(/'/g, "''");
}

function mapDbMaxFormula(resource) {
  if (resource.maxFormula === 'fixed' && resource.fixedMax == null) {
    return 'transformation_stage';
  }
  return resource.maxFormula;
}

function mapDbFixedMax(resource) {
  if (resource.maxFormula === 'fixed' && resource.fixedMax == null) {
    return 'NULL';
  }
  if (resource.fixedMax == null) {
    return 'NULL';
  }
  return String(resource.fixedMax);
}

function buildResourceDefinitionValues() {
  return economy.resources
    .map(
      (r) => `(
  '${sqlEscape(r.slug)}',
  '${sqlEscape(r.namePt)}',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = '${sqlEscape(r.transformationSlug)}'),
  ${r.minStage}
)`,
    )
    .join(',\n');
}

function buildEffectBlocks() {
  return economy.resources
    .map((r, index) => {
      const formula = mapDbMaxFormula(r);
      const fixed = mapDbFixedMax(r);
      const sortOrder = index + 1;
      return `
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = '${sqlEscape(r.transformationSlug)}'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = '${sqlEscape(r.slug)}'
    AND feat_id = (SELECT id FROM feat)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, ${r.minStage}, ${sortOrder},
         '${sqlEscape(r.namePt)}'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, '${formula}'::rpg.resource_max_formula, ${fixed},
       FALSE, ${r.recoverAllOnShort ? 'TRUE' : 'FALSE'}, ${r.recoverAllOnLong ? 'TRUE' : 'FALSE'}
FROM ins CROSS JOIN rd;`;
    })
    .join('\n');
}

function buildEconomyValues() {
  let sort = 600;
  return economy.actions
    .map((a) => {
      sort += 1;
      const reqKey =
        a.requiresOptionKey != null
          ? `'${sqlEscape(a.requiresOptionKey)}'`
          : 'NULL';
      const reqVal =
        a.requiresOptionValue != null
          ? `'${sqlEscape(a.requiresOptionValue)}'`
          : 'NULL';
      const resource =
        a.resourceSlug != null ? `'${sqlEscape(a.resourceSlug)}'` : 'NULL';
      return `(
  '${sqlEscape(a.actionId)}', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = '${sqlEscape(a.transformationSlug)}'), NULL,
  '${sqlEscape(a.namePt)}', '${sqlEscape(a.economy)}'::rpg.action_economy_bucket, ${a.minStage},
  ${resource}, NULL, ${a.alwaysSpendsResource ? 'TRUE' : 'FALSE'},
  '${sqlEscape(a.summary)}', '${sqlEscape(a.description)}',
  '${sqlEscape(a.tableAction)}', NULL, ${sort}, ${reqKey}, ${reqVal}
)`;
    })
    .join(',\n');
}

const outTransform = join(root, 'database/seeds/transformation/grim-hollow');
const outEconomy = join(root, 'database/seeds/economy/grim-hollow');

const j061 = `-- Recursos de transformação — Grim Hollow Cap. 6 (economy tipada)
-- Gerado por scripts/generate/cap6-economy-seeds.mjs
-- Grants: SSOT em phb_effect.grant-resource.gh-transformations.sql

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
${buildResourceDefinitionValues()}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;
`;

const e008 = `-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Transformações GH Cap. 6 — grant_resource (SSOT; defs em phb_resource_definition.gh-transformations.sql)
-- Gerado por scripts/generate/cap6-economy-seeds.mjs
${buildEffectBlocks()}
`;

const c078 = `-- Economy — transformações Grim Hollow Cap. 6
-- Gerado por scripts/generate/cap6-economy-seeds.mjs
-- table_action = \`{transformationSlug}/{boonId}\`; spend-resource quando alwaysSpendsResource.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
${buildEconomyValues()}
ON CONFLICT (action_id) DO UPDATE SET
  feat_id = EXCLUDED.feat_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
`;

writeFileSync(
  join(outTransform, 'phb_resource_definition.gh-transformations.sql'),
  j061,
);
writeFileSync(
  join(outTransform, 'phb_effect.grant-resource.gh-transformations.sql'),
  e008,
);
writeFileSync(
  join(outEconomy, 'phb_class_economy_action.gh-transformations.sql'),
  c078,
);

console.log(
  `Wrote Cap.6 defs + grant_resource (${economy.resources.length}) + economy (${economy.actions.length})`,
);
console.log(`PB+stage slugs (${PB_PLUS_STAGE.size}):`, [...PB_PLUS_STAGE].join(', '));
