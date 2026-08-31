/**
 * Final Cap.2 coverage snapshot for dashboard/report.
 * Run: node scripts/_audit-gh-cap2-final-report.mjs
 */
import fs from 'fs';

const en = JSON.parse(
  fs.readFileSync('docs/source/extracts/grim-hollow/cap2-subclasses-en.json', 'utf8'),
);
const pt = JSON.parse(
  fs.readFileSync('docs/source/extracts/grim-hollow/cap2-subclasses.json', 'utf8'),
);
const ptFeat = JSON.parse(
  fs.readFileSync('docs/source/extracts/grim-hollow/cap2-features-pt.json', 'utf8'),
);

function slugify(name) {
  return String(name)
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function read(p) {
  return fs.readFileSync(p, 'utf8');
}

const ecoSql = [
  read('database/seeds/combat/C063_phb_class_economy_action_grim_hollow_cap2.sql'),
  read('database/seeds/combat/C066_phb_class_economy_action_grim_hollow_cap2_bulk.sql'),
  read('database/seeds/combat/C068_phb_class_economy_action_sangromancer.sql'),
].join('\n');

const eco = [];
const ecoRe =
  /\(\s*'([^']+)'\s*,\s*\(SELECT id FROM rpg\.phb_class WHERE slug = '([^']+)'\)\s*,\s*(?:\(SELECT id FROM rpg\.phb_subclass WHERE slug = '([^']+)'\)|NULL)\s*,\s*'((?:\\'|[^'])*)'\s*,\s*'(\w+)'::rpg\.action_economy_bucket\s*,\s*(\d+)\s*,\s*(?:'([^']*)'|NULL)/g;
let m;
while ((m = ecoRe.exec(ecoSql))) {
  eco.push({
    id: m[1],
    classSlug: m[2],
    subclassSlug: m[3] || null,
    name: m[4],
    bucket: m[5],
    level: Number(m[6]),
    resourceSlug: m[7] || null,
  });
}

const tableSql =
  read('database/seeds/combat/C064_phb_subclass_table_action_grim_hollow_cap2.sql') +
  read('database/seeds/combat/C067_phb_subclass_table_action_grim_hollow_cap2_bulk.sql');
const tables = [];
const tr =
  /phb_subclass WHERE slug = '([^']+)'\)\s*,\s*'([^']+)'\s*,\s*'((?:\\'|[^'])*)'\s*,\s*(\d+)/g;
while ((m = tr.exec(tableSql))) {
  tables.push({
    subclassSlug: m[1],
    slug: m[2],
    name: m[3],
    level: Number(m[4]),
  });
}

const panelSql = read(
  'database/seeds/combat/C065_phb_class_panel_action_grim_hollow_cap2.sql',
);
const panels = [...panelSql.matchAll(/panel_key.*?VALUES|\(\s*'([^']+)'/g)]
  .map((x) => x[1])
  .filter(Boolean);
// simpler panel count
const panelCount = [
  ...panelSql.matchAll(
    /\(\s*'([^']+)'\s*,\s*\(SELECT id FROM rpg\.phb_class WHERE slug = '([^']+)'\)/g,
  ),
].length;

const featSql = read('database/seeds/grim-hollow/J028_phb_subclass_feature.sql');
const features = [];
for (const b of featSql.split(/INSERT INTO rpg\.phb_subclass_feature/i).slice(1)) {
  const mm = b.match(
    /slug = '([^']+)'\)\s*,\s*(\d+)\s*,\s*'((?:\\'|[^'])*)'\s*,\s*'((?:\\'|[^'])*)'/s,
  );
  if (mm) {
    features.push({
      slug: mm[1],
      level: Number(mm[2]),
      name: mm[3].replace(/\\'/g, "'"),
      desc: mm[4].replace(/\\'/g, "'"),
    });
  }
}

const prep = {};
for (const mm of read(
  'database/seeds/grim-hollow/J029_phb_subclass_prepared_spell.sql',
).matchAll(/WHERE s\.slug = '([^']+)' AND sp\.slug IN \(([^)]+)\)/g)) {
  prep[mm[1]] =
    (prep[mm[1]] || 0) + [...mm[2].matchAll(/'([^']+)'/g)].length;
}

const resourceOwner = {
  'devourer-guild': ['devourer-portion'],
  'trapper-guild': ['trapper-phase-leap'],
  sangromancer: ['sangromancy-dice'],
  'monster-hunter': ['grave-strike'],
};

const EN =
  /\b(?:You|your|When|While|creature|Advantage|Disadvantage|Bonus Action|Reaction|Long Rest|Short Rest|hit points|Armor Class)\b/g;
function leftover(d) {
  const h = (d.match(EN) || []).length;
  return (
    h >= 2 ||
    (/\b(?:você|Você)\b/.test(d) && /\b(?:you|You|your|When)\b/.test(d))
  );
}

const PILOT = new Set([
  'carver-guild',
  'devourer-guild',
  'occultist-guild',
  'trapper-guild',
]);

const PASSIVE = [
  ['AC', /\b(?:Armor Class|AC)\b/i],
  ['HP', /\bhit points?\b/i],
  ['resist', /\bresistance(?:s)? to\b|\bimmune to\b/i],
  ['speed', /\bspeed (?:increases|becomes)|flying speed|swim(?:ming)? speed/i],
  ['sense', /\bdarkvision\b|\bblindsight\b|\btruesight\b/i],
  ['prof', /\bgain (?:training|proficiency)|proficient with|training with/i],
  [
    'spell',
    /\byou (?:always )?have .+ prepared|learn .+ spell|you can cast|spellcasting/i,
  ],
  [
    'resource',
    /\buses? equal to\b|expend (?:a |one )?use|number of times|recover(?:s|ed)? (?:all )?uses/i,
  ],
];

function classifyFeature(f) {
  const ae = f.actionEconomy || [];
  const tags = [...ae];
  const text = `${f.name}\n${f.description || ''}`;
  for (const [k, re] of PASSIVE) if (re.test(text)) tags.push(`passive_${k}`);
  if (!ae.length && !tags.some((t) => t.startsWith('passive_'))) {
    tags.push('passive_other');
  }
  return tags;
}

function featureMatched(f, ptName, ecoFor) {
  const nPt = slugify(ptName || f.name);
  const nEn = slugify(f.name);
  const stop = new Set([
    'with',
    'from',
    'that',
    'this',
    'para',
    'de',
    'the',
    'and',
    'of',
    'for',
    'your',
  ]);
  const tokens = [...new Set([...nPt.split('-'), ...nEn.split('-')])].filter(
    (t) => t.length > 3 && !stop.has(t),
  );
  return ecoFor.some((e) => {
    if (e.id.includes(nPt) || e.id.includes(nEn)) return true;
    // glossary mutations: shield→escudo, strength→forca, ready→ready/preparado
    const hits = tokens.filter((t) => e.id.includes(t)).length;
    if (hits >= 2) return true;
    if (hits === 1 && tokens.length <= 2) return true;
    // single distinctive token length>=6
    return tokens.some((t) => t.length >= 6 && e.id.includes(t));
  });
}

const tagTotals = {};
let aeSlotTotal = 0;
const rows = [];

for (const sc of en.subclasses) {
  const p = pt.subclasses.find((x) => x.slug === sc.slug);
  const feats = sc.features || [];
  for (const f of feats) {
    for (const t of classifyFeature(f)) {
      tagTotals[t] = (tagTotals[t] || 0) + 1;
    }
  }
  const aeFeats = feats.filter((f) => (f.actionEconomy || []).length);
  const aeSlots = aeFeats.reduce((n, f) => n + f.actionEconomy.length, 0);
  aeSlotTotal += aeSlots;
  const ecoFor = eco.filter((e) => e.subclassSlug === sc.slug);
  const tabFor = tables.filter((t) => t.subclassSlug === sc.slug);
  const seedFeats = features.filter((f) => f.slug === sc.slug);
  const leftoverN = seedFeats.filter((f) => leftover(f.desc)).length;

  const missing = [];
  for (const f of aeFeats) {
    const pf = (p?.features || []).find(
      (x) =>
        x.level === f.level &&
        (x.anchorId === f.anchorId || x.name === f.name),
    );
    if (!featureMatched(f, pf?.name, ecoFor)) {
      missing.push(`${f.name}[${f.actionEconomy.join(',')}]`);
    }
  }

  const pass = [];
  const blob = feats.map((f) => f.description).join('\n');
  for (const [k, re] of PASSIVE) {
    if (['spell', 'resource'].includes(k)) continue;
    if (re.test(blob)) pass.push(k);
  }

  const gaps = [];
  if (PILOT.has(sc.slug)) gaps.push('MH-pilot curated partial');
  if (sc.slug === 'sangromancer') {
    gaps.push('Sangromancer: AE empty in extract; C068 free actions + resource');
  }
  if (aeSlots > ecoFor.length) {
    gaps.push(`AE-slots ${aeSlots}>eco ${ecoFor.length}`);
  }
  if (missing.length) gaps.push(`missingAE:${missing.join('|')}`);
  if (leftoverN) gaps.push(`EN-leftover ${leftoverN}/${seedFeats.length}`);
  if (
    !(resourceOwner[sc.slug] || []).length &&
    feats.some((f) => PASSIVE.find(([k]) => k === 'resource')[1].test(f.description))
  ) {
    gaps.push('resource-prose-only');
  }
  if (
    (prep[sc.slug] || 0) === 0 &&
    ((sc.spellTables && Object.keys(sc.spellTables).length) ||
      feats.some((f) =>
        PASSIVE.find(([k]) => k === 'spell')[1].test(f.description),
      ))
  ) {
    gaps.push('spell-grant-no-J029');
  }
  if (pass.length) gaps.push(`prose-passives:${pass.join(',')}`);
  if (ecoFor.length && !ecoFor.some((e) => e.resourceSlug)) {
    if (gaps.some((g) => g.includes('resource'))) {
      gaps.push('economy-null-resource_slug');
    }
  }

  rows.push({
    slug: sc.slug,
    name: p?.name || sc.name,
    classSlug: sc.classSlug,
    featureCount: feats.length,
    economyCount: ecoFor.length,
    tableActionCount: tabFor.length,
    resourceCount: (resourceOwner[sc.slug] || []).length,
    preparedSpellCount: prep[sc.slug] || 0,
    extractAeCount: aeFeats.length,
    expectedAeSlots: aeSlots,
    leftoverEnFeatureCount: leftoverN,
    missingAe: missing,
    gapNotes: gaps.join('; ') || 'ok',
  });
}

const mhFeats = en.monsterHunter.features || [];
const mhEco = eco.filter(
  (e) => e.classSlug === 'monster-hunter' && !e.subclassSlug,
);

const summary = {
  extract: {
    subclasses: 40,
    subclassFeatures: 218,
    featuresWithActionEconomy: rows.reduce((n, r) => n + r.extractAeCount, 0),
    aeSlots: aeSlotTotal,
    aeByBucket: {
      action: tagTotals.action || 0,
      bonus: tagTotals.bonus || 0,
      reaction: tagTotals.reaction || 0,
      free: 0,
    },
    passiveHints: Object.fromEntries(
      Object.entries(tagTotals).filter(([k]) => k.startsWith('passive_')),
    ),
    monsterHunterClassFeatures: mhFeats.length,
    ptOverlay: {
      subclasses: pt.subclasses.length,
      featureKeys: Object.keys(ptFeat.subclassFeatures || {}).length,
    },
  },
  seeds: {
    subclasses: 40,
    features: features.length,
    economyActions: eco.length,
    economyByBucket: eco.reduce((a, e) => {
      a[e.bucket] = (a[e.bucket] || 0) + 1;
      return a;
    }, {}),
    economyWithResourceSlug: eco.filter((e) => e.resourceSlug).length,
    tableActions: tables.length,
    panelActions: panelCount,
    resources: 4,
    preparedSpellSubclasses: Object.keys(prep).length,
    preparedSpellRows: Object.values(prep).reduce((a, b) => a + b, 0),
    featureEnLeftover: features.filter((f) => leftover(f.desc)).length,
    zeroEconomySubclasses: rows.filter((r) => r.economyCount === 0).length,
  },
  monsterHunter: {
    classEconomy: mhEco.length,
    classPanel: panelCount,
    classResource: 1,
    guildEconomy: eco.filter(
      (e) => e.classSlug === 'monster-hunter' && e.subclassSlug,
    ).length,
  },
  crossCutting: {
    realMissingAeFeatures: rows.reduce((n, r) => n + r.missingAe.length, 0),
    subclassesProseOnlyPassives: rows.filter((r) =>
      r.gapNotes.includes('prose-passives'),
    ).length,
    subclassesResourceProseOnly: rows.filter((r) =>
      r.gapNotes.includes('resource-prose-only'),
    ).length,
    subclassesSpellGrantNoJ029: rows.filter((r) =>
      r.gapNotes.includes('spell-grant-no-J029'),
    ).length,
  },
};

const top10 = [...rows]
  .map((r) => {
    let sev = 0;
    if (r.gapNotes.includes('MH-pilot') && r.missingAe.length) {
      sev += 80 + r.missingAe.length * 20;
    }
    sev += r.missingAe.length * 15;
    if (r.expectedAeSlots > r.economyCount) {
      sev += (r.expectedAeSlots - r.economyCount) * 10;
    }
    if (r.gapNotes.includes('resource-prose-only')) sev += 22;
    if (r.gapNotes.includes('spell-grant-no-J029')) sev += 10;
    sev += Math.min(r.leftoverEnFeatureCount, 6);
    if (r.gapNotes.includes('prose-passives')) sev += 8;
    if (r.slug === 'sangromancer') sev += 15;
    return { ...r, severity: sev };
  })
  .sort((a, b) => b.severity - a.severity)
  .slice(0, 10);

const report = {
  generatedAt: new Date().toISOString(),
  summary,
  top10Gaps: top10,
  perSubclass: rows,
  files: {
    extractEn: 'docs/source/extracts/grim-hollow/cap2-subclasses-en.json',
    extractPt: 'docs/source/extracts/grim-hollow/cap2-subclasses.json',
    featuresPt: 'docs/source/extracts/grim-hollow/cap2-features-pt.json',
    seeds: [
      'database/seeds/grim-hollow/J027_phb_subclass.sql',
      'database/seeds/grim-hollow/J028_phb_subclass_feature.sql',
      'database/seeds/grim-hollow/J029_phb_subclass_prepared_spell.sql',
      'database/seeds/grim-hollow/J030_phb_resource_monster_hunter.sql',
      'database/seeds/grim-hollow/J031_phb_class_monster_hunter_playable.sql',
      'database/seeds/grim-hollow/J033_phb_resource_sangromancer.sql',
      'database/seeds/grim-hollow/J035_phb_subclass_option_ghpg_cap2.sql',
      'database/seeds/combat/C063_phb_class_economy_action_grim_hollow_cap2.sql',
      'database/seeds/combat/C064_phb_subclass_table_action_grim_hollow_cap2.sql',
      'database/seeds/combat/C065_phb_class_panel_action_grim_hollow_cap2.sql',
      'database/seeds/combat/C066_phb_class_economy_action_grim_hollow_cap2_bulk.sql',
      'database/seeds/combat/C067_phb_subclass_table_action_grim_hollow_cap2_bulk.sql',
      'database/seeds/combat/C068_phb_class_economy_action_sangromancer.sql',
    ],
    runtime: [
      'src/game/combat/application/resolve-character-combat-slice.ts',
      'src/game/combat/domain/aggregate-class-combat.ts',
      'src/game/combat/application/load-combat-mechanical-catalog.ts',
      'src/game/session/infrastructure/character-state/resources/class-resources.ts',
      'src/game/spellcasting/application/resolve-character-spellcasting-slice.ts',
      'src/game/session/application/actions/monster-hunter-actions.handler.ts',
      '../dnd-front/src/features/character/character-sheet/lib/combat/class-action-economy.ts',
      '../dnd-front/src/features/character/character-sheet/ui/beyond/combat/panels/monster-hunter-panel.tsx',
      '../dnd-front/src/features/character/character-sheet/ui/sections/subclass-mechanics-section.tsx',
    ],
    generator: 'scripts/generate-ghpg-cap2-combat-seeds.mjs',
  },
};

fs.writeFileSync(
  'docs/source/extracts/grim-hollow/_audit-cap2-coverage.json',
  JSON.stringify(report, null, 2),
);

const tsv = [
  'slug\tname\tclass\tfeatureCount\teconomyCount\ttableActionCount\tresourceCount\tpreparedSpells\textractAe\texpectedAeSlots\tgapNotes',
  ...rows.map(
    (s) =>
      `${s.slug}\t${s.name}\t${s.classSlug}\t${s.featureCount}\t${s.economyCount}\t${s.tableActionCount}\t${s.resourceCount}\t${s.preparedSpellCount}\t${s.extractAeCount}\t${s.expectedAeSlots}\t${s.gapNotes.replace(/\t/g, ' ')}`,
  ),
].join('\n');
fs.writeFileSync(
  'docs/source/extracts/grim-hollow/_audit-cap2-per-subclass.tsv',
  tsv,
);

console.log(JSON.stringify({ summary, top10Gaps: top10 }, null, 2));
