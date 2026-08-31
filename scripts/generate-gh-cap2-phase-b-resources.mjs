/**
 * Gera J041 (defs/grants) + C073 (UPDATE economy) + patch C067 para Fase B Cap. 2.
 * Uso: node scripts/generate-gh-cap2-phase-b-resources.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');

/** @typedef {{
 *  slug: string,
 *  name: string,
 *  subclass: string,
 *  unlock: number,
 *  formula: 'fixed'|'proficiency_bonus'|'wisdom_mod'|'charisma_mod'|'constitution_mod'|'intelligence_mod',
 *  fixedMax?: number|null,
 *  recoverOneShort?: boolean,
 *  recoverAllShort?: boolean,
 *  recoverAllLong?: boolean,
 *  featureName: string,
 *  tableActions?: string[],
 *  classSlug?: string,
 *  insertEconomy?: { actionId: string, economy: string, name: string, summary: string, tableAction: string, sort: number },
 * }} ResourceSpec */

/** @type {ResourceSpec[]} */
const RESOURCES = [
  // barbarian — pathofthe-primal-spirit
  {
    slug: 'beast-kinship',
    name: 'Parentesco a Feras',
    subclass: 'pathofthe-primal-spirit',
    unlock: 6,
    formula: 'fixed',
    fixedMax: 2,
    recoverAllShort: true,
    featureName: 'Parentesco a Feras',
    classSlug: 'barbarian',
    insertEconomy: {
      actionId: 'gh-barbarian-pathofthe-primal-spirit-beast-kinship',
      economy: 'free',
      name: 'Parentesco a Feras',
      summary: 'Conjure Amizade com Animais / Falar com Animais sem espaço (2 usos)',
      tableAction: 'beast-kinship',
      sort: 280,
    },
    tableActions: ['beast-kinship'],
  },
  {
    slug: 'skinrider-trance',
    name: 'Transe do Cavaleiro da Pele',
    subclass: 'pathofthe-primal-spirit',
    unlock: 10,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Skinrider’s Trance',
    tableActions: ['skinrider-s-trance'],
  },
  {
    slug: 'shape-of-the-wild',
    name: 'Forma do Selvagem',
    subclass: 'pathofthe-primal-spirit',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Forma de the Selvagem',
    tableActions: ['shape-of-the-wild', 'shape-of-the-wild-action'],
  },

  // bard
  {
    slug: 'gallows-humor',
    name: 'Humor da Forca',
    subclass: 'collegeof-fools',
    unlock: 6,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Forca Humor',
    tableActions: ['gallows-humor'],
  },
  {
    slug: 'last-laugh',
    name: 'Última Risada',
    subclass: 'collegeof-fools',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Última Risada',
    tableActions: ['last-laugh'],
  },
  {
    slug: 'dual-death',
    name: 'Dupla Morte',
    subclass: 'collegeof-requiems',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Dupla Morte',
    tableActions: ['dual-death'],
  },

  // cleric — inquisition / purification
  {
    slug: 'witch-hunters-strike',
    name: 'Golpe do Caçador de Bruxas',
    subclass: 'inquisition-domain',
    unlock: 3,
    formula: 'wisdom_mod',
    featureName: 'Bruxa Hunter’s Golpe',
    classSlug: 'cleric',
    insertEconomy: {
      actionId: 'gh-cleric-inquisition-domain-witch-hunters-strike',
      economy: 'free',
      name: 'Golpe do Caçador de Bruxas',
      summary: '1×/acerto: dano de Força extra (mod. Sab/LR)',
      tableAction: 'witch-hunters-strike',
      sort: 310,
    },
    tableActions: ['witch-hunters-strike'],
  },
  {
    slug: 'rebuke-invoker',
    name: 'Repreender Invocador',
    subclass: 'inquisition-domain',
    unlock: 6,
    formula: 'wisdom_mod',
    featureName: 'Repreender Invoker',
    tableActions: ['rebuke-invoker'],
  },
  {
    slug: 'purify-with-fire',
    name: 'Purificar com Fogo',
    subclass: 'purification-domain',
    unlock: 3,
    formula: 'proficiency_bonus',
    recoverAllShort: true,
    featureName: 'Purificar Com Fogo',
    classSlug: 'cleric',
    insertEconomy: {
      actionId: 'gh-cleric-purification-domain-purify-with-fire',
      economy: 'free',
      name: 'Purificar com Fogo',
      summary: 'Dano de Fogo extra em truque/ataque (PB usos; S/L)',
      tableAction: 'purify-with-fire',
      sort: 312,
    },
    tableActions: ['purify-with-fire'],
  },

  // druid
  {
    slug: 'blood-boon',
    name: 'Dádiva de Sangue',
    subclass: 'circleof-blood',
    unlock: 6,
    formula: 'wisdom_mod',
    recoverOneShort: true,
    featureName: 'Sangue Dádiva',
    tableActions: ['blood-boon'],
  },
  {
    slug: 'exsanguinate',
    name: 'Exsanguinar',
    subclass: 'circleof-blood',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Exsanguinar',
    classSlug: 'druid',
    insertEconomy: {
      actionId: 'gh-druid-circleof-blood-exsanguinate',
      economy: 'free',
      name: 'Exsanguinar',
      summary: 'Ao usar Dádiva de Sangue: cura DV + PV temp. (1/LR)',
      tableAction: 'exsanguinate',
      sort: 360,
    },
    tableActions: ['exsanguinate'],
  },
  {
    slug: 'shake-the-earth',
    name: 'Sacudir a Terra',
    subclass: 'circleof-entropy',
    unlock: 10,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Sacudir the Terra',
    tableActions: ['shake-the-earth'],
  },
  // L14 World Breaker: same pool, recover on short
  {
    slug: 'shake-the-earth',
    name: 'Sacudir a Terra',
    subclass: 'circleof-entropy',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Entropy’s Ápice',
    skipDef: true,
  },

  // paladin L20
  {
    slug: 'plaguebringer',
    name: 'Portador da Peste',
    subclass: 'oathof-pestilence',
    unlock: 20,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Portador da Peste',
    tableActions: ['plaguebringer', 'plaguebringer-action'],
  },
  {
    slug: 'blood-knight',
    name: 'Cavaleiro de Sangue',
    subclass: 'oathof-slaughter',
    unlock: 20,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Sangue Cavaleiro',
    tableActions: ['blood-knight', 'blood-knight-action', 'blood-knight-reaction'],
  },
  {
    slug: 'apocalyptic-revelation',
    name: 'Revelação Apocalíptica',
    subclass: 'oathof-zeal',
    unlock: 20,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Apocalíptica Revelação',
    tableActions: ['apocalyptic-revelation', 'apocalyptic-revelation-action'],
  },

  // ranger
  {
    slug: 'envenomed-attack',
    name: 'Ataque Envenenado',
    subclass: 'green-reaper',
    unlock: 3,
    formula: 'wisdom_mod',
    recoverAllShort: true,
    featureName: 'Envenenado Ataque',
    tableActions: ['envenomed-attack', 'envenomed-attack-action'],
  },
  {
    slug: 'poison-control',
    name: 'Controle de Veneno',
    subclass: 'green-reaper',
    unlock: 7,
    formula: 'wisdom_mod',
    featureName: 'Veneno Controle',
    classSlug: 'ranger',
    insertEconomy: {
      actionId: 'gh-ranger-green-reaper-poison-control',
      economy: 'free',
      name: 'Controle de Veneno',
      summary: 'Conjure magia de veneno sem espaço (mod. Sab/LR)',
      tableAction: 'poison-control',
      sort: 390,
    },
    tableActions: ['poison-control'],
  },
  {
    slug: 'elemental-arrows',
    name: 'Flechas Elementais',
    subclass: 'primordial-archer',
    unlock: 3,
    formula: 'wisdom_mod',
    featureName: 'Flechas Elementais',
    tableActions: ['flechas-elementais', 'flechas-elementais-action', 'elemental-arrows', 'elemental-arrows-action'],
  },
  {
    slug: 'herbal-lore',
    name: 'Conhecimento Herbal',
    subclass: 'primordial-archer',
    unlock: 3,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Herbal Conhecimento',
    tableActions: ['herbal-lore', 'herbal-lore-action'],
  },
  {
    slug: 'primordial-magic',
    name: 'Magia Primordial',
    subclass: 'primordial-archer',
    unlock: 15,
    formula: 'wisdom_mod',
    featureName: 'Primordial Magic',
    tableActions: ['primordial-magic', 'primordial-magic-action'],
  },
  {
    slug: 'verminkin',
    name: 'Verminata',
    subclass: 'vermin-lord',
    unlock: 3,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Verminata',
    tableActions: ['verminkin', 'verminkin-action', 'verminkin-reaction'],
  },
  {
    slug: 'swarming-strikes',
    name: 'Golpes do Enxame',
    subclass: 'vermin-lord',
    unlock: 3,
    formula: 'proficiency_bonus',
    recoverAllShort: true,
    featureName: 'Enxame Golpes',
    tableActions: ['swarming-strikes', 'swarming-strikes-action'],
  },

  // rogue — sanguine-thief
  {
    slug: 'steal-blood',
    name: 'Roubar Sangue',
    subclass: 'sanguine-thief',
    unlock: 3,
    formula: 'intelligence_mod',
    featureName: 'Roubar Sangue',
    classSlug: 'rogue',
    insertEconomy: {
      actionId: 'gh-rogue-sanguine-thief-steal-blood',
      economy: 'free',
      name: 'Roubar Sangue',
      summary: 'Ao Furtivo: recuperar dado de sangromancia / cura (mod. Int/LR)',
      tableAction: 'steal-blood',
      sort: 420,
    },
    tableActions: ['steal-blood'],
  },
  {
    slug: 'bloodstitch',
    name: 'Costura Sangrenta',
    subclass: 'sanguine-thief',
    unlock: 13,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Costura Sangrenta',
    tableActions: ['bloodstitch'],
  },
  {
    slug: 'bloody-exit',
    name: 'Saída Sanguinária',
    subclass: 'sanguine-thief',
    unlock: 17,
    formula: 'fixed',
    fixedMax: 1,
    recoverAllShort: true,
    featureName: 'Sanguinário Saída',
    tableActions: ['bloody-exit'],
  },

  // warlock — coven / vampire
  {
    slug: 'hags-eye',
    name: 'Olho da Bruxa',
    subclass: 'the-coven',
    unlock: 3,
    formula: 'charisma_mod',
    featureName: 'Hag’s Olho',
    classSlug: 'warlock',
    insertEconomy: {
      actionId: 'gh-warlock-the-coven-hag-s-eye',
      economy: 'free',
      name: 'Olho da Bruxa (Hex)',
      summary: 'Conjure Hex sem espaço (mod. Car/LR)',
      tableAction: 'hag-s-eye',
      sort: 430,
    },
    tableActions: ['hag-s-eye'],
  },
  {
    slug: 'hags-guile',
    name: 'Astúcia da Bruxa',
    subclass: 'the-coven',
    unlock: 6,
    formula: 'charisma_mod',
    recoverAllShort: true,
    featureName: 'Hag’s Astúcia',
    tableActions: ['hag-s-guile', 'hag-s-guile-action'],
  },
  {
    slug: 'hags-visage',
    name: 'Semblante da Bruxa',
    subclass: 'the-coven',
    unlock: 10,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Hag’s Semblante',
    tableActions: ['hag-s-visage', 'hag-s-visage-action'],
  },
  {
    slug: 'hags-craft',
    name: 'Ofício da Bruxa',
    subclass: 'the-coven',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Hag’s Ofício',
    classSlug: 'warlock',
    insertEconomy: {
      actionId: 'gh-warlock-the-coven-hag-s-craft',
      economy: 'free',
      name: 'Ofício da Bruxa (Caldeirão)',
      summary: 'Caldeirão de poções (1/LR; gasta espaço)',
      tableAction: 'hag-s-craft',
      sort: 432,
    },
    tableActions: ['hag-s-craft'],
  },
  {
    slug: 'creature-of-the-night',
    name: 'Criatura da Noite',
    subclass: 'the-first-vampire-patron',
    unlock: 6,
    formula: 'charisma_mod',
    featureName: 'Criatura de the Noite',
    classSlug: 'warlock',
    insertEconomy: {
      actionId: 'gh-warlock-the-first-vampire-patron-creature-of-the-night',
      economy: 'free',
      name: 'Criatura da Noite',
      summary: 'Polimorfia em morcego/rato/lobo sem espaço (mod. Car/LR)',
      tableAction: 'creature-of-the-night',
      sort: 440,
    },
    tableActions: ['creature-of-the-night'],
  },
  {
    slug: 'eldritch-appetite',
    name: 'Apetite Eldritch',
    subclass: 'the-first-vampire-patron',
    unlock: 10,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Eldritch Appetite',
    tableActions: ['eldritch-appetite'],
  },
  {
    slug: 'eternal-night',
    name: 'Eterna Noite',
    subclass: 'the-first-vampire-patron',
    unlock: 14,
    formula: 'fixed',
    fixedMax: 1,
    featureName: 'Eterna Noite',
    tableActions: ['eternal-night', 'eternal-night-action'],
  },
];

/** Dados de Furtivo por nível de ladino (máx. do pool Roubado Poder). */
const STOLEN_POWER_BY_LEVEL = [
  [3, 2],
  [5, 3],
  [7, 4],
  [9, 5],
  [11, 6],
  [13, 7],
  [15, 8],
  [17, 9],
  [19, 10],
];

function sqlStr(s) {
  return s.replace(/'/g, "''");
}

function buildJ041() {
  const defs = new Map();
  for (const r of RESOURCES) {
    if (r.skipDef) continue;
    if (!defs.has(r.slug)) {
      defs.set(r.slug, r);
    }
  }

  defs.set('stolen-power', {
    slug: 'stolen-power',
    name: 'Poder Roubado (Dados de Sangromancia)',
    subclass: 'sanguine-thief',
    unlock: 3,
  });

  let out = `-- Recursos tipados — Grim Hollow Cap. 2 (Fase B, 17 subclasses resource-prose-only)
-- Gerado por scripts/generate-gh-cap2-phase-b-resources.mjs
-- Padrão: J030 / R011. feature_id via nome exato J028.

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES
`;
  const defRows = [...defs.values()].map(
    (r) => `  (
    '${r.slug}',
    '${sqlStr(r.name)}',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = '${r.subclass}'),
    ${r.unlock}
  )`,
  );
  out += defRows.join(',\n');
  out += `
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

`;

  for (const r of RESOURCES) {
    const oneShort = r.recoverOneShort ? 'TRUE' : 'FALSE';
    const allShort = r.recoverAllShort ? 'TRUE' : 'FALSE';
    const allLong = r.recoverAllLong === false ? 'FALSE' : 'TRUE';
    const fixed =
      r.formula === 'fixed' ? String(r.fixedMax ?? 1) : 'NULL';
    out += `
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  ${r.unlock},
  '${r.formula}'::rpg.resource_max_formula,
  ${fixed},
  sf.id,
  ${oneShort},
  ${allShort},
  ${allLong}
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = '${r.slug}'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = '${sqlStr(r.featureName)}'
WHERE s.slug = '${r.subclass}'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
`;
  }

  // stolen-power grants by SA dice
  out += `
-- Roubado Poder: máx. = dados de Furtivo (faixas fixed; sem enum sneak_attack)
`;

  for (const [level, dice] of STOLEN_POWER_BY_LEVEL) {
    out += `
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  ${level},
  'fixed'::rpg.resource_max_formula,
  ${dice},
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
`;
  }

  return out;
}

function buildC073() {
  let out = `-- C073: Wire resource_slug + always_spends nas economy Cap. 2 (Fase B)
-- Gerado por scripts/generate-gh-cap2-phase-b-resources.mjs
-- Não regenera C066; UPDATE + INSERT mínimos para cotas tipadas.

`;

  for (const r of RESOURCES) {
    if (!r.tableActions?.length || r.skipDef) continue;
    const actions = r.tableActions.map((a) => `'${a}'`).join(', ');
    out += `
UPDATE rpg.phb_class_economy_action a
SET resource_slug = '${r.slug}',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = '${r.subclass}'
  AND a.table_action IN (${actions});
`;
  }

  for (const r of RESOURCES) {
    if (!r.insertEconomy || !r.classSlug) continue;
    const e = r.insertEconomy;
    out += `
INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  '${e.actionId}',
  (SELECT id FROM rpg.phb_class WHERE slug = '${r.classSlug}'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${r.subclass}'),
  '${sqlStr(e.name)}',
  '${e.economy}'::rpg.action_economy_bucket,
  ${r.unlock},
  '${r.slug}',
  NULL,
  true,
  '${sqlStr(e.summary)}',
  '${sqlStr(e.summary)}',
  '${e.tableAction}',
  NULL,
  ${e.sort}
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;
`;
  }

  out += `
-- Table actions: espelhar pool gastoido
`;
  for (const r of RESOURCES) {
    if (!r.tableActions?.length || r.skipDef) continue;
    const actions = r.tableActions.map((a) => `'${a}'`).join(', ');
    out += `
UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = '${r.slug}',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = '${r.subclass}'
  AND t.slug IN (${actions});
`;
  }

  // INSERT missing table actions for new economy rows
  const newTable = RESOURCES.filter((r) => r.insertEconomy);
  for (const r of newTable) {
    const ta = r.insertEconomy.tableAction;
    out += `
INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${r.subclass}'),
  '${ta}',
  '${sqlStr(r.name)}',
  ${r.unlock},
  '${r.slug}',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;
`;
  }

  return out;
}

const j041Path = path.join(
  root,
  'database/seeds/grim-hollow/J041_phb_resource_grim_hollow_cap2.sql',
);
const c073Path = path.join(
  root,
  'database/seeds/combat/C073_phb_class_economy_action_gh_cap2_resources.sql',
);

fs.writeFileSync(j041Path, buildJ041(), 'utf8');
fs.writeFileSync(c073Path, buildC073(), 'utf8');
console.log('Wrote', j041Path);
console.log('Wrote', c073Path);
console.log(
  'Resources:',
  new Set(RESOURCES.map((r) => r.slug)).size + 1,
  '(+ stolen-power)',
);
