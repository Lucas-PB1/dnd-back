#!/usr/bin/env node
/**
 * Gera J061 (resources) + C078 (economy) a partir de cap6-economy.json.
 * Uso: node scripts/generate-ghpg-cap6-economy-seeds.mjs
 */
import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, '..');
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
  if (resource.maxFormula === 'proficiency_bonus_plus_stage') {
    return 'proficiency_bonus';
  }
  // DB exige fixed_max quando max_formula=fixed; estágio → level (resolve com stage como level).
  if (resource.maxFormula === 'fixed' && resource.fixedMax == null) {
    return 'level';
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

function buildResourceGrantBlocks() {
  return economy.resources
    .map((r) => {
      const formula = mapDbMaxFormula(r);
      const fixed = mapDbFixedMax(r);
      return `
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind, f.id, rd.id, ${r.minStage},
  '${formula}'::rpg.resource_max_formula, ${fixed},
  FALSE, ${r.recoverAllOnShort ? 'TRUE' : 'FALSE'}, ${r.recoverAllOnLong ? 'TRUE' : 'FALSE'}
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.slug = '${sqlEscape(r.slug)}' AND rd.feat_id = f.id
WHERE f.slug = '${sqlEscape(r.transformationSlug)}'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;`;
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

const j061 = `-- Recursos de transformação — Grim Hollow Cap. 6 (economy tipada)
-- Gerado por scripts/generate-ghpg-cap6-economy-seeds.mjs

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES
${buildResourceDefinitionValues()}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;
${buildResourceGrantBlocks()}
`;

const c078 = `-- Economy — transformações Grim Hollow Cap. 6
-- Gerado por scripts/generate-ghpg-cap6-economy-seeds.mjs
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
  join(root, 'database/seeds/grim-hollow/J061_phb_resource_ghpg_cap6_transformations.sql'),
  j061,
);
writeFileSync(
  join(root, 'database/seeds/combat/C078_phb_feat_economy_ghpg_cap6_transformations.sql'),
  c078,
);

console.log(
  `Wrote J061 (${economy.resources.length} resources) + C078 (${economy.actions.length} actions)`,
);
console.log(`PB+stage slugs (${PB_PLUS_STAGE.size}):`, [...PB_PLUS_STAGE].join(', '));
