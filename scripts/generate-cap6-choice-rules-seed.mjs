#!/usr/bin/env node
/**
 * Gera seeds Cap.6 choice rules a partir dos batches TS.
 * Uso: node scripts/generate-cap6-choice-rules-seed.mjs
 */
import { readFileSync, writeFileSync, readdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, '..');
const batchesDir = join(
  root,
  'src/game/sheet/domain/transformation/cap6-choice-rules/batches',
);

const RULE_TO_SLUG = {
  RULE_ABERRANT_HORROR: 'gh-transformation-aberrant-horror',
  RULE_FEY: 'gh-transformation-fey',
  RULE_FIEND: 'gh-transformation-fiend',
  RULE_HAG: 'gh-transformation-hag',
  RULE_LICH: 'gh-transformation-lich',
  RULE_LYCANTHROPE: 'gh-transformation-lycanthrope',
  RULE_OOZE: 'gh-transformation-ooze',
  RULE_PRIMORDIAL: 'gh-transformation-primordial',
  RULE_SERAPH: 'gh-transformation-seraph',
  RULE_SHADOWSTEEL_GHOUL: 'gh-transformation-shadowsteel-ghoul',
  RULE_SPECTER: 'gh-transformation-specter',
  RULE_VAMPIRE: 'gh-transformation-vampire',
};

function sqlEscape(value) {
  return String(value).replace(/'/g, "''");
}

function extractRules(src) {
  const out = {};
  const re =
    /export const (RULE_\w+)\s*:\s*Cap6TransformationRule\s*=\s*(\{[\s\S]*?\n\});/g;
  let match;
  while ((match = re.exec(src)) != null) {
    const name = match[1];
    const slug = RULE_TO_SLUG[name];
    if (!slug) throw new Error(`Unknown rule export ${name}`);
    out[slug] = Function(`"use strict"; return (${match[2]});`)();
  }
  return out;
}

const rulesBySlug = {};
for (const file of readdirSync(batchesDir).filter((f) => f.endsWith('.ts'))) {
  Object.assign(rulesBySlug, extractRules(readFileSync(join(batchesDir, file), 'utf8')));
}

const missing = Object.values(RULE_TO_SLUG).filter((s) => !rulesBySlug[s]);
if (missing.length) {
  throw new Error(`Missing rules for: ${missing.join(', ')}`);
}

const blocks = [];

for (const [slug, rule] of Object.entries(rulesBySlug).sort(([a], [b]) =>
  a.localeCompare(b),
)) {
  const parts = [];
  parts.push(`-- —— ${slug} ——`);
  parts.push(`WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = '${sqlEscape(slug)}')`);

  for (const [stageKey, stageRule] of Object.entries(rule.stages)) {
    const stage = Number(stageKey);
    parts.push(`, stage_${stage} AS (
  INSERT INTO rpg.phb_transformation_stage_rule (feat_id, stage, mode)
  SELECT feat.id, ${stage}, '${sqlEscape(stageRule.mode)}'::rpg.transformation_stage_mode
  FROM feat
  ON CONFLICT (feat_id, stage) DO UPDATE SET mode = EXCLUDED.mode
  RETURNING id
)`);

    for (let i = 0; i < stageRule.autoBoons.length; i += 1) {
      const boon = stageRule.autoBoons[i];
      parts.push(`, auto_${stage}_${i} AS (
  INSERT INTO rpg.phb_transformation_stage_auto_boon (stage_rule_id, boon_id, sort_order)
  SELECT stage_${stage}.id, '${sqlEscape(boon)}', ${i}
  FROM stage_${stage}
  ON CONFLICT (stage_rule_id, boon_id) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)`);
    }

    for (let i = 0; i < stageRule.pickKeys.length; i += 1) {
      const key = stageRule.pickKeys[i];
      parts.push(`, pick_${stage}_${i} AS (
  INSERT INTO rpg.phb_transformation_stage_pick_key (stage_rule_id, pick_key, sort_order)
  SELECT stage_${stage}.id, '${sqlEscape(key)}', ${i}
  FROM stage_${stage}
  ON CONFLICT (stage_rule_id, pick_key) DO UPDATE SET sort_order = EXCLUDED.sort_order
  RETURNING stage_rule_id
)`);
    }
  }

  for (let i = 0; i < rule.subOptions.length; i += 1) {
    const sub = rule.subOptions[i];
    const whenKey = sub.whenChoice
      ? `'${sqlEscape(sub.whenChoice.key)}'`
      : 'NULL';
    const whenVal = sub.whenChoice
      ? `'${sqlEscape(sub.whenChoice.value)}'`
      : 'NULL';
    parts.push(`, sub_${i} AS (
  INSERT INTO rpg.phb_transformation_sub_option (
    feat_id, option_key, from_stage, when_choice_key, when_choice_value
  )
  SELECT feat.id, '${sqlEscape(sub.key)}', ${sub.fromStage}, ${whenKey}, ${whenVal}
  FROM feat
  ON CONFLICT (feat_id, option_key) DO UPDATE SET
    from_stage = EXCLUDED.from_stage,
    when_choice_key = EXCLUDED.when_choice_key,
    when_choice_value = EXCLUDED.when_choice_value
  RETURNING id
)`);
  }

  for (let i = 0; i < rule.requireMatch.length; i += 1) {
    const match = rule.requireMatch[i];
    parts.push(`, match_${i} AS (
  INSERT INTO rpg.phb_transformation_require_match (feat_id, later_key, earlier_key)
  SELECT feat.id, '${sqlEscape(match.laterKey)}', '${sqlEscape(match.earlierKey)}'
  FROM feat
  ON CONFLICT (feat_id, later_key, earlier_key) DO UPDATE SET later_key = EXCLUDED.later_key
  RETURNING id
)`);
    const pairs = Object.entries(match.pairs);
    for (let j = 0; j < pairs.length; j += 1) {
      const [earlier, later] = pairs[j];
      parts.push(`, match_${i}_pair_${j} AS (
  INSERT INTO rpg.phb_transformation_require_match_pair (match_id, earlier_value, later_value)
  SELECT match_${i}.id, '${sqlEscape(earlier)}', '${sqlEscape(later)}'
  FROM match_${i}
  ON CONFLICT (match_id, earlier_value) DO UPDATE SET later_value = EXCLUDED.later_value
  RETURNING match_id
)`);
    }
  }

  // Final SELECT so the WITH chain executes
  parts.push(`SELECT 1 FROM feat;`);
  blocks.push(parts.join('\n'));
}

const out = `-- Cap.6 — choice rules (SSOT; gerado por scripts/generate-cap6-choice-rules-seed.mjs)

${blocks.join('\n\n')}
`;

const outPath = join(
  root,
  'database/seeds/transformation/grim-hollow/phb_transformation_choice_rules.all.sql',
);
writeFileSync(outPath, out);
console.log(
  `Wrote choice rules for ${Object.keys(rulesBySlug).length} transformations → ${outPath}`,
);
