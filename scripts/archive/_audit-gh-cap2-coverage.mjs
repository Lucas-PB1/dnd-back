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

const read = (p) => fs.readFileSync(p, 'utf8');

const seedFiles = {
  J027: read('database/seeds/grim-hollow/J027_phb_subclass.sql'),
  J028: read('database/seeds/grim-hollow/J028_phb_subclass_feature.sql'),
  J029: read('database/seeds/grim-hollow/J029_phb_subclass_prepared_spell.sql'),
  J030: read('database/seeds/grim-hollow/J030_phb_resource_monster_hunter.sql'),
  J033: read('database/seeds/grim-hollow/J033_phb_resource_sangromancer.sql'),
  J035: read('database/seeds/grim-hollow/J035_phb_subclass_option_ghpg_cap2.sql'),
  C063: read('database/seeds/combat/C063_phb_class_economy_action_grim_hollow_cap2.sql'),
  C064: read('database/seeds/combat/C064_phb_subclass_table_action_grim_hollow_cap2.sql'),
  C065: read('database/seeds/combat/C065_phb_class_panel_action_grim_hollow_cap2.sql'),
  C066: read('database/seeds/combat/C066_phb_class_economy_action_grim_hollow_cap2_bulk.sql'),
  C067: read('database/seeds/combat/C067_phb_subclass_table_action_grim_hollow_cap2_bulk.sql'),
  C068: read('database/seeds/combat/C068_phb_class_economy_action_sangromancer.sql'),
};

const j027Slugs = [...seedFiles.J027.matchAll(/VALUES\s*\(\s*'([a-z0-9-]+)'/g)].map(
  (m) => m[1],
);

function parseFeatures(sql) {
  const features = [];
  const blocks = sql.split(/INSERT INTO rpg\.phb_subclass_feature/i).slice(1);
  for (const b of blocks) {
    const m2 = b.match(
      /slug = '([^']+)'\)\s*,\s*(\d+)\s*,\s*'((?:\\'|[^'])*)'\s*,\s*'((?:\\'|[^'])*)'/s,
    );
    if (m2) {
      features.push({
        slug: m2[1],
        level: Number(m2[2]),
        name: m2[3].replace(/\\'/g, "'"),
        description: m2[4].replace(/\\'/g, "'"),
      });
    }
  }
  return features;
}
const seedFeatures = parseFeatures(seedFiles.J028);

function parseEconomy(sql) {
  const actions = [];
  const re =
    /\(\s*'([^']+)'\s*,\s*\(SELECT id FROM rpg\.phb_class WHERE slug = '([^']+)'\)\s*,\s*(?:\(SELECT id FROM rpg\.phb_subclass WHERE slug = '([^']+)'\)|NULL)\s*,\s*'((?:\\'|[^'])*)'\s*,\s*'(\w+)'::rpg\.action_economy_bucket\s*,\s*(\d+)\s*,\s*(?:'([^']*)'|NULL)\s*,\s*(?:'([^']*)'|NULL)\s*,\s*(true|false)\s*,\s*'((?:\\'|[^'])*)'\s*,\s*'((?:\\'|[^'])*)'\s*,\s*(?:'([^']*)'|NULL)/g;
  let m;
  while ((m = re.exec(sql))) {
    actions.push({
      actionId: m[1],
      classSlug: m[2],
      subclassSlug: m[3] || null,
      name: m[4].replace(/\\'/g, "'"),
      economy: m[5],
      unlockLevel: Number(m[6]),
      resourceSlug: m[7] || null,
      freeResourceSlug: m[8] || null,
      alwaysSpends: m[9] === 'true',
      summary: m[10].replace(/\\'/g, "'"),
      description: m[11].replace(/\\'/g, "'"),
      tableAction: m[12] || null,
    });
  }
  return actions;
}
const economy = [
  ...parseEconomy(seedFiles.C063),
  ...parseEconomy(seedFiles.C066),
  ...parseEconomy(seedFiles.C068),
];

function parseTableActions(sql) {
  const rows = [];
  const re =
    /phb_subclass WHERE slug = '([^']+)'\)\s*,\s*'([^']+)'\s*,\s*'((?:\\'|[^'])*)'\s*,\s*(\d+)/g;
  let m;
  while ((m = re.exec(sql))) {
    rows.push({
      subclassSlug: m[1],
      slug: m[2],
      name: m[3].replace(/\\'/g, "'"),
      unlockLevel: Number(m[4]),
    });
  }
  return rows;
}
const tableActions = [
  ...parseTableActions(seedFiles.C064),
  ...parseTableActions(seedFiles.C067),
];

function parsePanel(sql) {
  const rows = [];
  const re =
    /\(\s*'([^']+)'\s*,\s*\(SELECT id FROM rpg\.phb_class WHERE slug = '([^']+)'\)\s*,\s*(?:\(SELECT id FROM rpg\.phb_subclass WHERE slug = '([^']+)'\)|NULL)\s*,\s*'([^']+)'/g;
  let m;
  while ((m = re.exec(sql))) {
    rows.push({
      panelKey: m[1],
      classSlug: m[2],
      subclassSlug: m[3] || null,
      slug: m[4],
    });
  }
  return rows;
}
const panels = parsePanel(seedFiles.C065);

function parseResourceDefs(sql) {
  const defs = [];
  const re =
    /\(\s*'([a-z0-9-]+)'\s*,\s*'((?:\\'|[^'])*)'\s*,\s*'(\w+)'::rpg\.resource_scope[\s\S]*?(?:phb_subclass WHERE slug = '([^']+)'|phb_class WHERE slug = '([^']+)')/g;
  let m;
  while ((m = re.exec(sql))) {
    defs.push({
      slug: m[1],
      name: m[2],
      scope: m[3],
      subclassSlug: m[4] || null,
      classSlug: m[5] || null,
    });
  }
  return defs;
}
const resources = [
  ...parseResourceDefs(seedFiles.J030),
  ...parseResourceDefs(seedFiles.J033),
];

const prepBySub = {};
for (const m of seedFiles.J029.matchAll(
  /WHERE s\.slug = '([^']+)' AND sp\.slug IN \(([^)]+)\)/g,
)) {
  const slug = m[1];
  const spells = [...m[2].matchAll(/'([^']+)'/g)].map((x) => x[1]);
  prepBySub[slug] = (prepBySub[slug] || 0) + spells.length;
}

const optionBySub = {};
for (const m of seedFiles.J035.matchAll(/phb_subclass WHERE slug = '([^']+)'/g)) {
  optionBySub[m[1]] = (optionBySub[m[1]] || 0) + 1;
}

const PASSIVE_PATTERNS = [
  {
    k: 'ac',
    re: /\b(?:Armor Class|AC)\b|increase.*(?:AC|Armor Class)|AC equals|AC becomes|while .* (?:unarmored|not wearing)/i,
  },
  {
    k: 'hp',
    re: /\bhit points?\b|\bHP\b|temporary hit points|maximum hit points|hit point maximum/i,
  },
  {
    k: 'resistance',
    re: /\bresistance(?:s)? to\b|\bimmune to\b|\bimmunity to\b|\bvulnerability/i,
  },
  {
    k: 'sense',
    re: /\bdarkvision\b|\bblindsight\b|\btremorsense\b|\btruesight\b|\badvantage on.*Perception|\bpassive Perception/i,
  },
  {
    k: 'speed',
    re: /\bspeed (?:increases|becomes|equals)|flying speed|swim(?:ming)? speed|climb(?:ing)? speed|walk(?:ing)? speed/i,
  },
  {
    k: 'proficiency',
    re: /\bgain (?:training|proficiency)|proficient with|expertise|skill proficiency|tool proficiency|armor proficiency|weapon proficiency|training with/i,
  },
  {
    k: 'spell_grant',
    re: /\byou (?:always )?have .+ (?:prepared|known)|learn .+ spell|you know the .+ spell|cast .+ without|spellcasting|you gain .+ cantrip|prepared spells|you can cast/i,
  },
  {
    k: 'resource',
    re: /\buses? equal to\b|\brecover(?:s|ed)? (?:all )?(?:uses|expended)|expend (?:a |one )?use|number of times|charges?\b|dice pool|sangromancy|portions?\b/i,
  },
];

function classifyFeature(f) {
  const ae = new Set(f.actionEconomy || []);
  const text = `${f.name}\n${f.description || ''}`;
  const tags = new Set();
  if (ae.has('action')) tags.add('action');
  if (ae.has('bonus')) tags.add('bonus');
  if (ae.has('reaction')) tags.add('reaction');
  if (ae.has('free')) tags.add('free');
  if (
    /\bas a free action\b|without using an action/i.test(text) &&
    !ae.size
  ) {
    tags.add('free_implied');
  }
  for (const { k, re } of PASSIVE_PATTERNS) {
    if (re.test(text)) tags.add(`passive_${k}`);
  }
  if (
    !ae.size &&
    ![...tags].some((t) => t.startsWith('passive_') || t === 'free_implied')
  ) {
    if (/\byou (?:gain|have|are|can|know|learn)\b/i.test(text)) {
      tags.add('passive_other');
    }
  }
  if (!tags.size) tags.add('unclassified');
  return [...tags];
}

function englishLeftoverScore(desc) {
  const enHits = (
    desc.match(
      /\b(?:You|your|When|While|creature|Advantage|Disadvantage|Bonus Action|Reaction|Long Rest|Short Rest|hit points|Armor Class)\b/g,
    ) || []
  ).length;
  const mixed =
    /\b(?:você|Você)\b/.test(desc) && /\b(?:you|You|your|When)\b/.test(desc);
  return { enHits, mixed, leftover: enHits >= 2 || mixed };
}

function slugify(name) {
  return String(name)
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

const PILOT_MH_GUILDS = new Set([
  'carver-guild',
  'devourer-guild',
  'occultist-guild',
  'trapper-guild',
]);

const subclasses = en.subclasses.map((sc) => {
  const ptSc = pt.subclasses.find((p) => p.slug === sc.slug);
  const feats = (sc.features || []).map((f) => {
    const key = `${sc.slug}:${f.level}:${f.name}`;
    const ptF = ptFeat.subclassFeatures?.[key];
    return {
      ...f,
      tags: classifyFeature(f),
      ptName: ptF?.name,
      ptDesc: ptF?.description,
    };
  });
  return {
    slug: sc.slug,
    name: sc.name,
    ptName: ptSc?.name || sc.name,
    classSlug: sc.classSlug,
    featureCount: feats.length,
    features: feats,
    hasSpellTables: !!(sc.spellTables && Object.keys(sc.spellTables).length),
  };
});

const mhFeats = (en.monsterHunter.features || []).map((f) => ({
  ...f,
  tags: classifyFeature(f),
}));

function countBy(arr, key) {
  const m = {};
  for (const x of arr) {
    const k = x[key];
    if (!k) continue;
    m[k] = (m[k] || 0) + 1;
  }
  return m;
}

const ecoBySub = countBy(economy, 'subclassSlug');
const ecoClassOnly = economy.filter((e) => !e.subclassSlug);
const tableBySub = countBy(tableActions, 'subclassSlug');
const panelBySub = countBy(panels, 'subclassSlug');
const featBySub = countBy(seedFeatures, 'slug');
const resBySub = countBy(
  resources.filter((r) => r.subclassSlug),
  'subclassSlug',
);

const leftoverBySub = {};
for (const f of seedFeatures) {
  if (englishLeftoverScore(f.description).leftover) {
    leftoverBySub[f.slug] = (leftoverBySub[f.slug] || 0) + 1;
  }
}

const allFeats = subclasses.flatMap((s) => s.features);
const tagTotals = {};
for (const f of allFeats) {
  for (const t of f.tags) tagTotals[t] = (tagTotals[t] || 0) + 1;
}
const aeTotals = { action: 0, bonus: 0, reaction: 0, free: 0, none: 0 };
for (const f of allFeats) {
  const ae = f.actionEconomy || [];
  if (!ae.length) aeTotals.none++;
  for (const a of ae) aeTotals[a] = (aeTotals[a] || 0) + 1;
}

const ecoBucket = {};
for (const e of economy) ecoBucket[e.economy] = (ecoBucket[e.economy] || 0) + 1;

const perSubclass = subclasses.map((sc) => {
  const seedFeatCount = featBySub[sc.slug] || 0;
  const economyCount = ecoBySub[sc.slug] || 0;
  const tableActionCount = tableBySub[sc.slug] || 0;
  const panelCount = panelBySub[sc.slug] || 0;
  const resourceCount = resBySub[sc.slug] || 0;
  const preparedSpellCount = prepBySub[sc.slug] || 0;
  const optionCount = optionBySub[sc.slug] || 0;

  const aeFeatures = sc.features.filter((f) => (f.actionEconomy || []).length);
  const passiveFeatures = sc.features.filter(
    (f) => !(f.actionEconomy || []).length,
  );

  const ecoForSub = economy.filter((e) => e.subclassSlug === sc.slug);
  const expectedAeSlots = aeFeatures.reduce(
    (n, f) => n + (f.actionEconomy || []).length,
    0,
  );
  const missingAe = [];
  for (const f of aeFeatures) {
    const n = slugify(f.name);
    const hit = ecoForSub.some(
      (e) =>
        e.actionId.includes(n) ||
        (e.tableAction && String(e.tableAction).includes(n)) ||
        slugify(e.name).includes(n) ||
        n.split('-').filter((p) => p.length > 3).filter((p) => e.actionId.includes(p))
          .length >= 2,
    );
    // Pilot C063 uses Portuguese table_action slugs — match by economy count + level loosely
    const hitPilot =
      PILOT_MH_GUILDS.has(sc.slug) &&
      ecoForSub.some((e) => {
        // Close Quarters etc. — any shared significant token
        const tokens = n.split('-').filter((p) => p.length > 4);
        return tokens.some(
          (t) =>
            e.actionId.includes(t) ||
            slugify(e.name).includes(t) ||
            (e.tableAction && String(e.tableAction).includes(t)),
        );
      });
    if (!hit && !hitPilot) {
      missingAe.push({ name: f.name, level: f.level, ae: f.actionEconomy });
    }
  }

  const leftover = leftoverBySub[sc.slug] || 0;
  const gapNotes = [];
  const isPilot = PILOT_MH_GUILDS.has(sc.slug);
  if (isPilot) gapNotes.push('MH pilot (C063 curated)');
  if (economyCount === 0 && aeFeatures.length > 0) {
    gapNotes.push(`0 economy vs ${aeFeatures.length} AE features`);
  } else if (economyCount === 0) {
    gapNotes.push('0 economy (all passive?)');
  }
  if (expectedAeSlots > economyCount) {
    gapNotes.push(
      `AE slots ${expectedAeSlots} > economy ${economyCount} (gap ${expectedAeSlots - economyCount})`,
    );
  }
  if (missingAe.length) {
    gapNotes.push(`${missingAe.length} AE feat(s) missing economy`);
  }
  if (
    resourceCount === 0 &&
    sc.features.some((f) => f.tags.includes('passive_resource'))
  ) {
    gapNotes.push('resource implied, no seed resource');
  }
  const ecoWithRes = ecoForSub.filter((e) => e.resourceSlug).length;
  if (
    ecoForSub.length > 0 &&
    ecoWithRes === 0 &&
    sc.features.some((f) => f.tags.includes('passive_resource'))
  ) {
    gapNotes.push('economy rows lack resource_slug');
  }
  if (
    preparedSpellCount === 0 &&
    (sc.hasSpellTables ||
      sc.features.some((f) => f.tags.includes('passive_spell_grant')))
  ) {
    gapNotes.push('spell grant/table but 0 prepared_spell rows');
  }
  if (leftover) gapNotes.push(`${leftover} features EN leftover`);
  if (tableActionCount === 0 && economyCount > 0) {
    gapNotes.push('economy without table_action seed');
  }
  // Passives that imply sheet numbers
  const passiveSheetHints = [];
  for (const tag of [
    'passive_ac',
    'passive_hp',
    'passive_resistance',
    'passive_speed',
    'passive_sense',
    'passive_proficiency',
  ]) {
    if (sc.features.some((f) => f.tags.includes(tag))) {
      passiveSheetHints.push(tag.replace('passive_', ''));
    }
  }
  if (passiveSheetHints.length) {
    gapNotes.push(`prose-only passives: ${passiveSheetHints.join(',')}`);
  }

  return {
    slug: sc.slug,
    name: sc.ptName || sc.name,
    enName: sc.name,
    classSlug: sc.classSlug,
    featureCount: sc.featureCount,
    seedFeatureCount: seedFeatCount,
    extractAeCount: aeFeatures.length,
    expectedAeSlots,
    extractPassiveCount: passiveFeatures.length,
    economyCount,
    tableActionCount,
    panelCount,
    resourceCount,
    preparedSpellCount,
    optionCount,
    missingAeFeatures: missingAe,
    leftoverEnFeatureCount: leftover,
    isPilot,
    gapNotes: gapNotes.filter((g) => g !== 'ok').join('; ') || 'ok',
    tagCounts: sc.features.reduce((acc, f) => {
      for (const t of f.tags) acc[t] = (acc[t] || 0) + 1;
      return acc;
    }, {}),
  };
});

const zeroEco = perSubclass.filter((s) => s.economyCount === 0);

const worst = [...perSubclass]
  .map((s) => ({
    ...s,
    severity:
      (s.economyCount === 0 && s.extractAeCount > 0 ? 100 : 0) +
      Math.max(0, (s.expectedAeSlots || 0) - s.economyCount) * 12 +
      s.missingAeFeatures.length * 10 +
      (s.resourceCount === 0 && /resource implied/.test(s.gapNotes) ? 25 : 0) +
      (/economy rows lack resource_slug/.test(s.gapNotes) ? 15 : 0) +
      (s.leftoverEnFeatureCount > 0
        ? Math.min(s.leftoverEnFeatureCount, 15)
        : 0) +
      (/spell grant/.test(s.gapNotes) ? 8 : 0) +
      (/prose-only passives/.test(s.gapNotes) ? 5 : 0) +
      (s.isPilot && s.missingAeFeatures.length ? 20 : 0) -
      Math.min(s.economyCount, 3),
  }))
  .sort((a, b) => b.severity - a.severity);

const mhEco = economy.filter(
  (e) => e.classSlug === 'monster-hunter' && !e.subclassSlug,
);

const ecoEnLeftover = economy.filter((e) =>
  englishLeftoverScore(e.description || e.summary || '').leftover,
).length;
const ecoWithResource = economy.filter((e) => e.resourceSlug).length;
const expectedAeTotal = perSubclass.reduce(
  (n, s) => n + (s.expectedAeSlots || 0),
  0,
);
const missingAeFeatTotal = perSubclass.reduce(
  (n, s) => n + s.missingAeFeatures.length,
  0,
);
const prosePassiveSubs = perSubclass.filter((s) =>
  /prose-only passives/.test(s.gapNotes),
).length;
const resourceGapSubs = perSubclass.filter((s) =>
  /resource implied/.test(s.gapNotes),
).length;
const spellGapSubs = perSubclass.filter((s) =>
  /spell grant/.test(s.gapNotes),
).length;

const summary = {
  extract: {
    subclasses: subclasses.length,
    features: allFeats.length,
    featuresWithAe: allFeats.filter((f) => (f.actionEconomy || []).length)
      .length,
    featuresPassiveNoAe: aeTotals.none,
    expectedAeSlots: expectedAeTotal,
    aeTotals,
    tagTotals,
    monsterHunterFeatures: mhFeats.length,
    ptOverlaySubclasses: pt.subclasses.length,
    ptFeatureKeys: Object.keys(ptFeat.subclassFeatures || {}).length,
  },
  seeds: {
    subclassesJ027: j027Slugs.length,
    featuresJ028: seedFeatures.length,
    economyTotal: economy.length,
    economyByBucket: ecoBucket,
    economySubclassBound: economy.filter((e) => e.subclassSlug).length,
    economyClassOnly: ecoClassOnly.length,
    economyWithResourceSlug: ecoWithResource,
    economyEnLeftoverDesc: ecoEnLeftover,
    tableActions: tableActions.length,
    panelActions: panels.length,
    resources: resources.length,
    resourceDefs: resources,
    preparedSpellSubclasses: Object.keys(prepBySub).length,
    preparedSpellRows: Object.values(prepBySub).reduce((a, b) => a + b, 0),
    zeroEconomySubclasses: zeroEco.length,
    optionRefsJ035: Object.values(optionBySub).reduce((a, b) => a + b, 0),
    leftoverFeatureDescs: seedFeatures.filter((f) =>
      englishLeftoverScore(f.description).leftover,
    ).length,
  },
  crossCutting: {
    aeFeatureMissingEconomy: missingAeFeatTotal,
    subclassesWithProseOnlyPassives: prosePassiveSubs,
    subclassesResourceImpliedNoSeed: resourceGapSubs,
    subclassesSpellGrantNoPrepared: spellGapSubs,
    note:
      'Passives (AC/HP/resistance/speed/sense/proficiency) have NO GH combat_modifier / unarmored / resistance wiring — only catalog prose + optional classCombatNotes (none for GH). Economy bulk has NULL resource_slug. MH guilds are curated pilot with partial AE coverage. Sangromancer AE empty in extract; C068 adds free actions manually.',
  },
  mhSummary: {
    slug: 'monster-hunter',
    name: 'Monster Hunter (class)',
    featureCount: mhFeats.length,
    extractAeCount: mhFeats.filter((f) => (f.actionEconomy || []).length)
      .length,
    economyCount: mhEco.length,
    panelCount: panels.filter(
      (p) => p.classSlug === 'monster-hunter' && !p.subclassSlug,
    ).length,
    resourceCount: resources.filter((r) => r.classSlug === 'monster-hunter')
      .length,
    economyIds: mhEco.map((e) => e.actionId),
  },
  runtimeWiring: {
    economyFilter:
      'dnd-front/.../class-action-economy.ts resolveClassEconomyActions — filter by classSlug+subclassSlug+level',
    classCombatNotes:
      'aggregate-class-combat.ts — PHB class notes + northlands only; NO grim-hollow subclass notes',
    resources:
      'class-resources.ts loadSubclassResourceSchedule — only seeded grants (4 defs: devourer/trapper/grave-strike/sangromancy)',
    preparedSpells:
      'resolve-character-spellcasting-slice.ts via v_phb_subclass_prepared_spell (J029: 15 subclasses)',
    unarmoredHpResistance:
      'v_phb_unarmored_defense / v_phb_hp_bonus_source — no GH Cap.2 subclass rows in seeds',
    panelActions: 'C065 MH only (3); front monster-hunter-panel.tsx',
    subclassMechanicsSection:
      'catalog prose tiles only (useSubclassMechanics) — does not mutate AC/HP',
    neverBecomeSheetNumbers: [
      'passive AC bonuses',
      'passive HP max / temp HP formulas',
      'resistances/immunities',
      'senses (darkvision etc.)',
      'speed bonuses',
      'proficiencies (unless separate proficiency seed — not GH Cap.2)',
      'most resource pools (except 4 seeded)',
      'table_action effects beyond spend-resource / MH curated handlers',
    ],
  },
};

const out = {
  summary,
  perSubclass,
  topGaps: worst.slice(0, 15).map((w) => ({
    slug: w.slug,
    name: w.name,
    severity: w.severity,
    gapNotes: w.gapNotes,
    economyCount: w.economyCount,
    extractAeCount: w.extractAeCount,
    missingAe: w.missingAeFeatures.map((m) => `${m.name} [${m.ae.join(',')}]`),
    leftoverEn: w.leftoverEnFeatureCount,
  })),
  zeroEconomy: zeroEco.map((s) => ({
    slug: s.slug,
    ae: s.extractAeCount,
    feats: s.featureCount,
    gapNotes: s.gapNotes,
  })),
  prepBySub,
  leftoverTotal: seedFeatures.filter((f) =>
    englishLeftoverScore(f.description).leftover,
  ).length,
};

fs.writeFileSync(
  'docs/source/extracts/grim-hollow/_audit-cap2-coverage.json',
  JSON.stringify(out, null, 2),
);

console.log(JSON.stringify(summary, null, 2));
console.log('\n=== ZERO ECONOMY (' + zeroEco.length + ') ===');
console.log(
  zeroEco
    .map((s) => `${s.slug} ae=${s.extractAeCount} feats=${s.featureCount}`)
    .join('\n'),
);
console.log('\n=== TOP 10 GAPS ===');
for (const w of worst.slice(0, 10)) {
  console.log(
    `${w.severity}\t${w.slug}\teco=${w.economyCount}\tae=${w.extractAeCount}\t${w.gapNotes}`,
  );
  if (w.missingAeFeatures.length) {
    console.log(
      '   missing:',
      w.missingAeFeatures.map((m) => `${m.name}(${m.ae})`).join('; '),
    );
  }
}
console.log(
  '\nparse: features',
  seedFeatures.length,
  'economy',
  economy.length,
  'table',
  tableActions.length,
  'j027',
  j027Slugs.length,
  'leftover',
  out.leftoverTotal,
);

// TSV for dashboard table
const tsv = [
  'slug\tname\tclass\tfeatureCount\teconomyCount\ttableActionCount\tresourceCount\tpreparedSpells\textractAe\texpectedAeSlots\tgapNotes',
  ...perSubclass.map(
    (s) =>
      `${s.slug}\t${s.name}\t${s.classSlug}\t${s.featureCount}\t${s.economyCount}\t${s.tableActionCount}\t${s.resourceCount}\t${s.preparedSpellCount}\t${s.extractAeCount}\t${s.expectedAeSlots}\t${s.gapNotes.replace(/\t/g, ' ')}`,
  ),
].join('\n');
fs.writeFileSync(
  'docs/source/extracts/grim-hollow/_audit-cap2-per-subclass.tsv',
  tsv,
);
