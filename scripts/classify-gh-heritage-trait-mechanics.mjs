/**
 * Classifica traços GH Cap.1 → seeds tipados (combat_modifier / economy_action / resources).
 * Uso: node scripts/classify-gh-heritage-trait-mechanics.mjs
 *
 * Regras:
 * - Detecta economia no benefitBase (min_takes=1) e benefitImproved (min_takes=2) em separado.
 * - Passivos CORE (HP etc.) em C070; ações/reações em C071; recursos limitados em C072.
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';
import { translateGhpgBody } from './lib/ghpg-mechanical-glossary.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap1 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap1Heritages, 'utf8'));
const ptOverlay = fs.existsSync(extracts.grimHollow.cap1HeritagesPt)
  ? JSON.parse(fs.readFileSync(extracts.grimHollow.cap1HeritagesPt, 'utf8'))
  : null;

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

/** @param {typeof cap1.traits[0]} trait */
function traitDisplayName(trait) {
  const pt = ptOverlay?.traits?.[trait.slug];
  return (pt?.name ?? trait.name ?? trait.slug).replace(/\.$/, '').trim();
}

/**
 * @param {string} text
 * @returns {'action'|'bonus'|'reaction'|null}
 */
function detectEconomyBucket(text) {
  if (!text?.trim()) return null;
  if (/as a reaction\b|use a reaction\b|your reaction\b/i.test(text)) {
    return 'reaction';
  }
  if (/as a magic action\b|magic action to\b/i.test(text)) {
    return 'action';
  }
  if (/as an action\b/i.test(text) && !/can't take actions/i.test(text)) {
    return 'action';
  }
  if (/as a bonus action\b|bonus action\b/i.test(text)) {
    return 'bonus';
  }
  return null;
}

/**
 * @param {string} text
 * @returns {{ limited: boolean, pb: boolean, shortRest: boolean, longRest: boolean }}
 */
function detectResourceLimits(text) {
  const pb =
    /proficiency bonus/i.test(text) &&
    /number of times|regaining all expended|regain all expended/i.test(text);
  const shortRest =
    /finish a short rest|when you finish a short rest/i.test(text) &&
    (/regain the use|regaining|once/i.test(text) || /short rest/i.test(text));
  const longRest =
    !pb &&
    /finish a long rest|when you finish a long rest/i.test(text) &&
    /regain|regaining|use this feature/i.test(text);
  return {
    limited: pb || shortRest || longRest,
    pb,
    shortRest: shortRest && !pb,
    longRest: longRest && !pb,
  };
}

/**
 * @param {typeof cap1.traits[0]} trait
 * @param {'base'|'improved'} section
 */
function sectionText(trait, section) {
  if (section === 'improved') {
    return trait.benefitImproved ?? '';
  }
  // Sopro: mecânica de uso está no campo improved do extract — usa description.
  if (trait.slug === 'potent-breath') {
    return `${trait.benefitBase ?? ''}\n${trait.description ?? ''}`;
  }
  return trait.benefitBase ?? trait.description ?? '';
}

/**
 * @typedef {{
 *   traitSlug: string,
 *   actionId: string,
 *   name: string,
 *   economy: 'action'|'bonus'|'reaction',
 *   minTakes: number,
 *   summary: string,
 *   description: string,
 *   resourceSlug: string | null,
 *   alwaysSpends: boolean,
 *   resource?: { pb: boolean, shortRest: boolean, longRest: boolean, name: string }
 * }} EconomyRow
 */

/**
 * @param {typeof cap1.traits[0]} trait
 * @returns {EconomyRow[]}
 */
function classifyEconomyRows(trait) {
  /** @type {EconomyRow[]} */
  const rows = [];
  const name = traitDisplayName(trait);

  for (const section of /** @type {const} */ (['base', 'improved'])) {
    const text = sectionText(trait, section);
    const economy = detectEconomyBucket(text);
    if (!economy) continue;

    const minTakes = section === 'improved' ? 2 : 1;
    // Evita duplicar a mesma bucket se o improved só reforça o mesmo uso base
    // (ex.: mobile-bastion improved cita bonus só para encerrar — ainda útil).
    const limits = detectResourceLimits(text);
    const actionId =
      minTakes >= 2
        ? `heritage-${trait.slug}-${economy}-x2`
        : `heritage-${trait.slug}-${economy}`;

    if (rows.some((row) => row.actionId === actionId)) continue;

    const resourceSlug = limits.limited
      ? `gh-${trait.slug}${minTakes >= 2 ? '-x2' : ''}`.slice(0, 60)
      : null;

    const descSource =
      section === 'improved'
        ? (trait.benefitImproved ?? text)
        : (trait.benefitBase ?? text);
    const description = translateGhpgBody(descSource).slice(0, 450);
    const summary =
      minTakes >= 2
        ? `${name} (aprimorado)`
        : name;

    rows.push({
      traitSlug: trait.slug,
      actionId,
      name: minTakes >= 2 ? `${name} (2×)` : name,
      economy,
      minTakes,
      summary,
      description,
      resourceSlug,
      alwaysSpends: Boolean(resourceSlug),
      resource: resourceSlug
        ? {
            pb: limits.pb,
            shortRest: limits.shortRest,
            longRest: limits.longRest || (!limits.shortRest && !limits.pb),
            name: summary,
          }
        : undefined,
    });
  }

  // Hardcode: sopro sempre ação mágica 1× (PB/LR), mesmo se o parser falhar no base.
  if (trait.slug === 'potent-breath' && !rows.some((r) => r.minTakes === 1)) {
    rows.unshift({
      traitSlug: trait.slug,
      actionId: 'heritage-potent-breath',
      name: name,
      economy: 'action',
      minTakes: 1,
      summary: 'Sopro elemental (PB usos/LR)',
      description: translateGhpgBody(trait.description ?? '').slice(0, 450),
      resourceSlug: 'potentBreath',
      alwaysSpends: true,
      resource: {
        pb: true,
        shortRest: false,
        longRest: true,
        name: name,
      },
    });
  } else if (trait.slug === 'potent-breath') {
    const base = rows.find((r) => r.minTakes === 1);
    if (base) {
      base.actionId = 'heritage-potent-breath';
      base.resourceSlug = 'potentBreath';
      base.alwaysSpends = true;
      base.resource = {
        pb: true,
        shortRest: false,
        longRest: true,
        name: name,
      };
    }
  }

  return rows;
}

/** @param {EconomyRow} row */
function emitEconomyInsert(row) {
  const resourceSql = row.resourceSlug
    ? sqlLiteral(row.resourceSlug)
    : 'NULL';
  const tableAction = row.alwaysSpends ? "'spend-resource'" : 'NULL';
  return `INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  ${sqlLiteral(row.actionId)},
  ht.id,
  ${sqlLiteral(row.name)},
  ${sqlLiteral(row.economy)}::rpg.action_economy_bucket,
  1,
  ${resourceSql},
  ${row.alwaysSpends ? 'TRUE' : 'FALSE'},
  ${sqlLiteral(row.summary)},
  ${sqlLiteral(row.description)},
  ${tableAction},
  ${row.minTakes >= 2 ? 760 : 750},
  ${row.minTakes}
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = ${sqlLiteral(row.traitSlug)}
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;`;
}

/** @param {EconomyRow} row */
function emitResourceInserts(row) {
  if (!row.resourceSlug || !row.resource) return '';
  const maxFormula = row.resource.pb
    ? `'proficiency_bonus'::rpg.resource_max_formula`
    : `'fixed'::rpg.resource_max_formula`;
  const fixedMax = row.resource.pb ? 'NULL' : '1';
  const recoverShort = row.resource.shortRest ? 'TRUE' : 'FALSE';
  const recoverLong = row.resource.longRest || row.resource.pb ? 'TRUE' : 'FALSE';

  return `-- ${row.traitSlug} @${row.minTakes}× → ${row.resourceSlug}
INSERT INTO rpg.phb_resource_definition (slug, name, scope, heritage_trait_id, min_level)
SELECT
  ${sqlLiteral(row.resourceSlug)},
  ${sqlLiteral(row.resource.name)},
  'heritage'::rpg.resource_scope,
  ht.id,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = ${sqlLiteral(row.traitSlug)}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  heritage_trait_id = EXCLUDED.heritage_trait_id;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, min_trait_takes
)
SELECT
  'heritage'::rpg.resource_owner_kind,
  ht.id,
  rd.id,
  1,
  ${maxFormula},
  ${fixedMax},
  FALSE,
  ${recoverShort},
  ${recoverLong},
  ${row.minTakes}
FROM rpg.phb_heritage_trait ht
JOIN rpg.phb_resource_definition rd ON rd.slug = ${sqlLiteral(row.resourceSlug)}
WHERE ht.slug = ${sqlLiteral(row.traitSlug)}
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long,
  min_trait_takes = EXCLUDED.min_trait_takes;`;
}

const modifierLines = [];
const economyRows = [];
const report = {
  total: 0,
  economyActions: 0,
  withResource: 0,
  byBucket: { action: 0, bonus: 0, reaction: 0 },
  byMinTakes: { 1: 0, 2: 0 },
};

for (const trait of cap1.traits) {
  report.total += 1;

  if (trait.slug === 'extra-tough') {
    modifierLines.push(`INSERT INTO rpg.phb_combat_modifier (
  kind, owner_kind, owner_id, heritage_trait_id, label, per_level_bonus, min_trait_takes
)
SELECT
  'hp_bonus'::rpg.combat_modifier_kind,
  'heritage'::rpg.combat_modifier_owner,
  ht.id,
  ht.id,
  'Robustez extra',
  1,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'extra-tough'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_combat_modifier cm
    WHERE cm.heritage_trait_id = ht.id
      AND cm.kind = 'hp_bonus'::rpg.combat_modifier_kind
      AND cm.min_trait_takes = 1
  );`);
  }

  for (const row of classifyEconomyRows(trait)) {
    economyRows.push(row);
    report.economyActions += 1;
    report.byBucket[row.economy] += 1;
    report.byMinTakes[row.minTakes] =
      (report.byMinTakes[row.minTakes] ?? 0) + 1;
    if (row.resourceSlug) report.withResource += 1;
  }
}

// Deduplicate actionIds (keep first)
const seenIds = new Set();
const uniqueEconomy = [];
for (const row of economyRows) {
  if (seenIds.has(row.actionId)) continue;
  seenIds.add(row.actionId);
  uniqueEconomy.push(row);
}

const outCombat = path.join(apiRoot, 'database/seeds/combat');
fs.mkdirSync(outCombat, { recursive: true });

const coreBody = `-- GH heritage traits — passivos CORE (Cap. 1)
-- Gerado por scripts/classify-gh-heritage-trait-mechanics.mjs

${modifierLines.join('\n\n')}
`;

fs.writeFileSync(
  path.join(outCombat, 'C070_phb_heritage_trait_mechanics_core.sql'),
  `${coreBody}\n`,
  'utf8',
);

const bulkBody = `-- GH heritage traits — economia Cap. 1 (${uniqueEconomy.length} ações)
-- Gerado por scripts/classify-gh-heritage-trait-mechanics.mjs

${uniqueEconomy.map(emitEconomyInsert).join('\n\n')}
`;

fs.writeFileSync(
  path.join(outCombat, 'C071_phb_heritage_trait_mechanics_bulk.sql'),
  `${bulkBody}\n`,
  'utf8',
);

const resourceRows = uniqueEconomy.filter((row) => row.resourceSlug);
const resourceBody = `-- GH heritage traits — recursos Cap. 1 (${resourceRows.length} grants)
-- Gerado por scripts/classify-gh-heritage-trait-mechanics.mjs
-- Requer T093 (scope/owner heritage + min_trait_takes em grant).

${resourceRows.map(emitResourceInserts).filter(Boolean).join('\n\n')}
`;

fs.writeFileSync(
  path.join(outCombat, 'C072_phb_heritage_trait_resources.sql'),
  `${resourceBody}\n`,
  'utf8',
);

console.log('Classificação:', report);
console.log('Ações únicas:', uniqueEconomy.length);
console.log('Gerado C070 / C071 / C072');
