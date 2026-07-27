/**
 * Gera seeds SQL do Gunslinger a partir de extracted.json
 * Uso: node scripts/generate-gunslinger-seeds.mjs
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  AMMUNITION,
  FIGHTING_STYLE_SLUGS,
  FIREARMS,
  NEW_WEAPON_MASTERIES,
  NEW_WEAPON_PROPERTIES,
  RISK_COUNT_SCHEDULE,
  SKIP_FEAT_SLUGS,
  SKIP_SPELL_SLUGS,
  WEAPON_MASTERY_BY_LEVEL,
} from './lib/gunslinger-catalog-data.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');
const sourceDir = path.join(root, 'docs/sources/valda-gunslinger');
const data = JSON.parse(
  fs.readFileSync(path.join(sourceDir, 'extracted.json'), 'utf8'),
);

const seedDir = path.join(root, 'database/seeds/valda-gunslinger');
fs.mkdirSync(seedDir, { recursive: true });

function sqlString(value) {
  if (value == null) return 'NULL';
  return `'${String(value).replace(/'/g, "''")}'`;
}

function stripArtist(text) {
  return String(text ?? '')
    .replace(
      /(?:^|\n)\s*[A-Z][a-z]+(?:-[A-Z][a-z]+)? [A-Z][a-z]+(?:-[A-Z][a-z]+)?(?:\s+CM)?\s*(?=\n|$)/g,
      '\n',
    )
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

const citationSlug = data.citation.slug;
const edition = data.edition;
const meta = data.meta;
const klass = data.class;

if (!klass) {
  console.error('extracted.json sem class');
  process.exit(1);
}

const editionSql = `-- Valda Gunslinger — citação (reusa edição valda-spire-2024-en)

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  ${sqlString(edition.slug)},
  ${sqlString(edition.label)},
  ${sqlString("Valda's Spire of Secrets")},
  ${sqlString(edition.language)},
  NOW(),
  ${sqlString(edition.notes)}
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  language = EXCLUDED.language,
  notes = EXCLUDED.notes,
  extracted_at = EXCLUDED.extracted_at;

INSERT INTO rpg.phb_source_citation (
  slug, edition_id, chapter, chapter_title, extracted_at
)
VALUES (
  ${sqlString(citationSlug)},
  (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlString(edition.slug)}),
  ${data.citation.chapter},
  ${sqlString(data.citation.chapterTitle)},
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
`;

fs.writeFileSync(
  path.join(root, 'database/migrations/050_data/D019_valda_gunslinger_citation.sql'),
  editionSql,
  'utf8',
);

const hitDie = (meta.hitDie || 'd8').toLowerCase();
const dieValue = Number(hitDie.replace('d', '')) || 8;
const fixedPerLevel = Math.floor(dieValue / 2) + 1;

const classDesc = stripArtist(
  [klass.description, klass.coreTraits ? `## Core Traits\n\n${klass.coreTraits}` : '']
    .filter(Boolean)
    .join('\n\n'),
);

const classSql = `-- Seed Valda Gunslinger class
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_class (
  slug, name, tagline, summary, description,
  primary_ability_label, primary_ability_operator,
  hit_die_id, hp_level1_die_value, hp_fixed_per_level,
  hp_minimum_gain_per_level, hp_constitution_mod_applies,
  subclass_unlock_level, subclass_label,
  skill_choice_count, skill_choice_from,
  source_citation_id, spell_slot_pattern_id
)
VALUES (
  'gunslinger',
  ${sqlString(klass.name)},
  ${sqlString(klass.tagline)},
  ${sqlString(klass.summary)},
  ${sqlString(classDesc)},
  ${sqlString(meta.primaryAbility)},
  NULL,
  (SELECT id FROM rpg.phb_hit_die WHERE slug = ${sqlString(hitDie)}),
  ${dieValue},
  ${fixedPerLevel},
  1,
  TRUE,
  ${meta.subclassUnlockLevel ?? 3},
  ${sqlString(meta.subclassLabel ?? 'Creed')},
  ${meta.skillChoiceCount ?? 2},
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlString(citationSlug)}),
  NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  primary_ability_label = EXCLUDED.primary_ability_label,
  hit_die_id = EXCLUDED.hit_die_id,
  hp_level1_die_value = EXCLUDED.hp_level1_die_value,
  hp_fixed_per_level = EXCLUDED.hp_fixed_per_level,
  subclass_unlock_level = EXCLUDED.subclass_unlock_level,
  subclass_label = EXCLUDED.subclass_label,
  skill_choice_count = EXCLUDED.skill_choice_count,
  source_citation_id = EXCLUDED.source_citation_id;
`;

fs.writeFileSync(path.join(seedDir, 'G001_phb_class.sql'), classSql, 'utf8');

const primarySlug = meta.primaryAbilitySlug ?? 'destreza';
const primarySql = `-- Seed Gunslinger primary ability

INSERT INTO rpg.phb_class_primary_ability (class_id, ability_id, sort_order)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  (SELECT id FROM rpg.phb_ability WHERE slug = ${sqlString(primarySlug)}),
  1
)
ON CONFLICT (class_id, ability_id) DO UPDATE SET sort_order = EXCLUDED.sort_order;
`;
fs.writeFileSync(
  path.join(seedDir, 'G002_phb_class_primary_ability.sql'),
  primarySql,
  'utf8',
);

const saveSlugs = meta.savingThrowSlugs?.length
  ? meta.savingThrowSlugs
  : ['destreza', 'carisma'];
const saveSql = `-- Seed Gunslinger saving throws

INSERT INTO rpg.phb_class_saving_throw (class_id, ability_id)
VALUES
${saveSlugs
  .map(
    (slug) =>
      `  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_ability WHERE slug = ${sqlString(slug)}))`,
  )
  .join(',\n')}
ON CONFLICT DO NOTHING;
`;
fs.writeFileSync(
  path.join(seedDir, 'G003_phb_class_saving_throw.sql'),
  saveSql,
  'utf8',
);

const armorSql = `-- Seed Gunslinger armor training

INSERT INTO rpg.phb_class_armor_training (class_id, category_id)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')
)
ON CONFLICT DO NOTHING;
`;
fs.writeFileSync(
  path.join(seedDir, 'G004_phb_class_armor_training.sql'),
  armorSql,
  'utf8',
);

const weaponSql = `-- Seed Gunslinger weapon proficiencies
-- RAW: Simple weapons and Martial Ranged weapons

INSERT INTO rpg.phb_weapon_proficiency (slug, label)
VALUES ('armas-marciais-a-distancia', 'Armas Marciais (à Distância)')
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;

DELETE FROM rpg.phb_class_weapon_proficiency
WHERE class_id = (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger')
  AND proficiency_id = (
    SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais'
  );

INSERT INTO rpg.phb_class_weapon_proficiency (class_id, proficiency_id)
VALUES
  (
    (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
    (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')
  ),
  (
    (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
    (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais-a-distancia')
  )
ON CONFLICT DO NOTHING;
`;
fs.writeFileSync(
  path.join(seedDir, 'G005_phb_class_weapon_proficiency.sql'),
  weaponSql,
  'utf8',
);

const skillSlugs = meta.skillSlugs?.length
  ? meta.skillSlugs
  : [
      'acrobatics',
      'animal-handling',
      'athletics',
      'deception',
      'insight',
      'intimidation',
      'perception',
      'persuasion',
      'sleight-of-hand',
      'stealth',
    ];
const skillSql = `-- Seed Gunslinger skill pool

INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
VALUES
${skillSlugs
  .map(
    (slug) =>
      `  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_skill WHERE slug = ${sqlString(slug)}))`,
  )
  .join(',\n')}
ON CONFLICT DO NOTHING;
`;
fs.writeFileSync(
  path.join(seedDir, 'G006_phb_class_skill_pool.sql'),
  skillSql,
  'utf8',
);

function pbForLevel(level) {
  if (level >= 17) return 6;
  if (level >= 13) return 5;
  if (level >= 9) return 4;
  if (level >= 5) return 3;
  return 2;
}

const progValues = [];
for (let level = 1; level <= 20; level += 1) {
  progValues.push(
    `  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), ${level}, ${pbForLevel(level)}, NULL, NULL, NULL)`,
  );
}
const progSql = `-- Seed Gunslinger progression (PB only)

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity)
VALUES
${progValues.join(',\n')}
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus;
`;
fs.writeFileSync(
  path.join(seedDir, 'G007_phb_class_progression.sql'),
  progSql,
  'utf8',
);

const featureLines = [
  `-- Seed Gunslinger class features + maneuvers`,
  `-- Gerado de docs/sources/valda-gunslinger/extracted.json`,
  ``,
];

for (const f of data.features) {
  featureLines.push(`INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  ${f.level},
  ${sqlString(f.name)},
  ${sqlString(stripArtist(f.description))}
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;
`);
}

for (const m of data.maneuvers ?? []) {
  featureLines.push(`INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  ${sqlString(`Maneuver: ${m.name}`)},
  ${sqlString(stripArtist(m.description))}
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;
`);
}

fs.writeFileSync(
  path.join(seedDir, 'G008_phb_class_feature.sql'),
  featureLines.join('\n'),
  'utf8',
);

const subclassLines = [
  `-- Seed Gunslinger subclasses`,
  `-- Gerado de docs/sources/valda-gunslinger/extracted.json`,
  ``,
];
for (const sc of data.subclasses) {
  subclassLines.push(`INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  ${sqlString(sc.slug)},
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  ${sqlString(sc.name)},
  ${sqlString(sc.tagline)},
  ${sqlString(sc.summary)},
  ${sqlString(stripArtist(sc.description))},
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlString(citationSlug)})
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
`);
}
fs.writeFileSync(
  path.join(seedDir, 'G009_phb_subclass.sql'),
  subclassLines.join('\n'),
  'utf8',
);

const scFeatureLines = [
  `-- Seed Gunslinger subclass features`,
  `-- Gerado de docs/sources/valda-gunslinger/extracted.json`,
  ``,
];
let scFeatureCount = 0;
for (const sc of data.subclasses) {
  for (const f of sc.features) {
    scFeatureCount += 1;
    scFeatureLines.push(`INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlString(sc.slug)}),
  ${f.level},
  ${sqlString(f.name)},
  ${sqlString(stripArtist(f.description))}
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
`);
  }
}
fs.writeFileSync(
  path.join(seedDir, 'G010_phb_subclass_feature.sql'),
  scFeatureLines.join('\n'),
  'utf8',
);

const SCHOOL_SLUG = {
  Abjuration: 'abjuracao',
  Divination: 'adivinhacao',
  Enchantment: 'encantamento',
  Evocation: 'evocacao',
  Illusion: 'ilusao',
  Conjuration: 'invocacao',
  Necromancy: 'necromancia',
  Transmutation: 'transmutacao',
};

const CLASS_SLUG = {
  Bard: 'bard',
  Cleric: 'cleric',
  Druid: 'druid',
  Paladin: 'paladin',
  Ranger: 'ranger',
  Sorcerer: 'sorcerer',
  Warlock: 'warlock',
  Wizard: 'wizard',
};

// Prefer extracted property text when present
const propBySlug = new Map(
  (data.weaponProperties ?? []).map((p) => [p.slug, p.description]),
);
const masteryBySlug = new Map(
  (data.masteryProperties ?? []).map((p) => [p.slug, p.description]),
);

const propSql = [
  `-- Seed Valda firearm weapon properties`,
  ``,
  `INSERT INTO rpg.phb_weapon_property (slug, name, description)`,
  `VALUES`,
  NEW_WEAPON_PROPERTIES.map(
    (p) =>
      `  (${sqlString(p.slug)}, ${sqlString(p.name)}, ${sqlString(propBySlug.get(p.slug) ?? p.description)})`,
  ).join(',\n'),
  `ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
  ``,
].join('\n');
fs.writeFileSync(path.join(seedDir, 'G011_phb_weapon_property.sql'), propSql, 'utf8');

const masterySql = [
  `-- Seed Valda firearm mastery properties`,
  ``,
  `INSERT INTO rpg.phb_weapon_mastery (slug, name, description)`,
  `VALUES`,
  NEW_WEAPON_MASTERIES.map(
    (p) =>
      `  (${sqlString(p.slug)}, ${sqlString(p.name)}, ${sqlString(masteryBySlug.get(p.slug) ?? p.description)})`,
  ).join(',\n'),
  `ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;`,
  ``,
].join('\n');
fs.writeFileSync(path.join(seedDir, 'G011b_phb_weapon_mastery.sql'), masterySql, 'utf8');

const weaponLines = [
  `-- Seed Valda firearms (items + weapons + property links)`,
  ``,
];
for (const w of FIREARMS) {
  const props = {
    propertyIds: w.propertyIds,
    masteryId: w.masteryId,
    range: { normal: w.rangeNormal, max: w.rangeMax },
    ammoType: w.ammoType,
    era: w.era,
    source: 'valda-gunslinger',
    editionSlug: edition.slug,
    citationSlug,
    ...(w.reload != null ? { reload: w.reload } : {}),
  };
  weaponLines.push(`INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  ${sqlString(w.slug)},
  'weapon'::rpg.item_type,
  ${sqlString(w.name)},
  ${sqlString(JSON.stringify({ text: `${w.costGp} GP` }))}::jsonb,
  ${sqlString(w.weight)},
  ${sqlString(w.description)},
  ${sqlString(JSON.stringify(props))}::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = ${sqlString(w.slug)}),
  ${sqlString(w.category)}::rpg.weapon_category,
  ${sqlString(w.damage)},
  ${sqlString(w.damageType)},
  (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = ${sqlString(w.masteryId)})
)
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;
`);

  for (const propSlug of w.propertyIds) {
    weaponLines.push(`INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id)
VALUES (
  (SELECT id FROM rpg.phb_item WHERE slug = ${sqlString(w.slug)}),
  (SELECT id FROM rpg.phb_weapon_property WHERE slug = ${sqlString(propSlug)})
)
ON CONFLICT DO NOTHING;
`);
  }
}
fs.writeFileSync(path.join(seedDir, 'G012_phb_firearm.sql'), weaponLines.join('\n'), 'utf8');

const ammoLines = [`-- Seed Valda firearm ammunition`, ``];
for (const a of AMMUNITION) {
  ammoLines.push(`INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  ${sqlString(a.slug)},
  'gear'::rpg.item_type,
  ${sqlString(a.name)},
  ${sqlString(JSON.stringify({ text: `${a.costGp} GP` }))}::jsonb,
  ${sqlString(a.weight)},
  ${sqlString(a.description)},
  ${sqlString(JSON.stringify({
    magic: false,
    ammunition: true,
    amount: a.amount,
    source: 'valda-gunslinger',
    citationSlug,
  }))}::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
`);
}
fs.writeFileSync(path.join(seedDir, 'G013_phb_ammunition.sql'), ammoLines.join('\n'), 'utf8');

function parseFeatPrerequisite(description) {
  const m = description.match(/General Feat\s*\(\s*Prerequisite[s]?:?\s*([^)]+)\)/i);
  return m ? m[1].trim() : null;
}

function parseFeatBenefits(description) {
  const cleaned = stripArtist(description)
    .replace(/^General Feat[\s\S]*?You gain the following benefits\.\s*/i, '')
    .trim();
  const re = /(?:^|\n)([A-Z][A-Za-z'’ /-]{1,80})\.\s+/g;
  const matches = [...cleaned.matchAll(re)];
  const benefits = [];
  for (let i = 0; i < matches.length; i += 1) {
    const name = matches[i][1].trim();
    const start = matches[i].index + matches[i][0].length;
    const end = i + 1 < matches.length ? matches[i + 1].index : cleaned.length;
    benefits.push({
      name,
      description: `${name}. ${cleaned.slice(start, end).trim()}`.trim(),
    });
  }
  if (benefits.length === 0 && cleaned) {
    benefits.push({ name: null, description: cleaned });
  }
  return benefits;
}

const featLines = [`-- Seed Gunslinger pack feats`, ``];
const featBenefitLines = [`-- Seed Gunslinger pack feat benefits`, ``];
let featBenefitCount = 0;
for (const feat of data.feats ?? []) {
  if (SKIP_FEAT_SLUGS.has(feat.slug)) continue;
  const prerequisite = parseFeatPrerequisite(feat.description);
  featLines.push(`INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  ${sqlString(feat.slug)},
  ${sqlString(feat.name)},
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  ${sqlString(prerequisite)},
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlString(citationSlug)})
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
`);
  const benefits = parseFeatBenefits(feat.description);
  benefits.forEach((benefit, index) => {
    featBenefitCount += 1;
    featBenefitLines.push(`INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = ${sqlString(feat.slug)}),
  ${index + 1},
  ${sqlString(benefit.name)},
  ${sqlString(benefit.description)}
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
`);
  });
}
fs.writeFileSync(path.join(seedDir, 'G014_phb_feat.sql'), featLines.join('\n'), 'utf8');
fs.writeFileSync(path.join(seedDir, 'G015_phb_feat_benefit.sql'), featBenefitLines.join('\n'), 'utf8');

function fieldValue(block, label) {
  const re = new RegExp(
    `${label}:\\s*([\\s\\S]*?)(?=\\n(?:Casting Time|Range|Components|Duration):|\\n\\n|$)`,
    'i',
  );
  const m = block.match(re);
  return m ? m[1].replace(/\s+/g, ' ').trim() : null;
}

function parseSpell(raw) {
  const cleaned = stripArtist(raw.description);
  const header = (cleaned.split(/\n+/)[0] ?? '').trim();
  let level = 0;
  let schoolEn = null;
  let classNames = [];
  const leveled = header.match(/^Level\s+(\d)\s+(\w+)\s*\(([^)]+)\)/i);
  const cantrip = header.match(/^(\w+)\s+Cantrip\s*\(([^)]+)\)/i);
  if (leveled) {
    level = Number(leveled[1]);
    schoolEn = leveled[2];
    classNames = leveled[3].split(',').map((s) => s.trim());
  } else if (cantrip) {
    schoolEn = cantrip[1];
    classNames = cantrip[2].split(',').map((s) => s.trim());
  } else {
    return null;
  }
  const schoolSlug = SCHOOL_SLUG[schoolEn];
  if (!schoolSlug) return null;

  const castingTime = fieldValue(cleaned, 'Casting Time') ?? 'Action';
  const range = fieldValue(cleaned, 'Range') ?? 'Self';
  const componentsRaw = fieldValue(cleaned, 'Components') ?? '';
  const duration = fieldValue(cleaned, 'Duration') ?? 'Instantaneous';
  const hasVerbal = /\bV\b/.test(componentsRaw);
  const hasSomatic = /\bS\b/.test(componentsRaw);
  const materialMatch = componentsRaw.match(/\bM\s*\((.+)\)\s*$/i);
  const hasMaterial = /\bM\b/.test(componentsRaw);
  const materialDescription = materialMatch ? materialMatch[1].trim() : null;
  const componentParts = [];
  if (hasVerbal) componentParts.push('V');
  if (hasSomatic) componentParts.push('S');
  if (hasMaterial) {
    componentParts.push(materialDescription ? `M (${materialDescription})` : 'M');
  }
  let body = cleaned
    .replace(/^(?:Level \d .+|[\w]+ Cantrip.+)\n+/i, '')
    .replace(/^Casting Time:[\s\S]*?Duration:[^\n]+\n*/i, '')
    .trim();
  let higherLevels = null;
  const higherSplit = body.split(/\n(?=Using a Higher-Level Spell Slot\.|Cantrip Upgrade\.)/i);
  if (higherSplit.length > 1) {
    body = higherSplit[0].trim();
    higherLevels = higherSplit.slice(1).join('\n').trim();
  }
  return {
    slug: raw.slug,
    name: raw.name,
    level,
    levelLabel: level === 0 ? 'Cantrip' : `Level ${level}`,
    schoolSlug,
    castingTime,
    range,
    hasVerbal,
    hasSomatic,
    hasMaterial,
    materialDescription,
    componentsLabel: componentParts.join(', ') || componentsRaw,
    duration,
    concentration: /^Concentration/i.test(duration),
    ritual: /\bor Ritual\b/i.test(castingTime),
    description: body,
    higherLevels,
    classSlugs: classNames.map((n) => CLASS_SLUG[n]).filter(Boolean),
  };
}

const spellLines = [`-- Seed Gunslinger pack spells`, ``];
const spellClassValues = [];
let spellCount = 0;
for (const raw of data.spells ?? []) {
  if (SKIP_SPELL_SLUGS.has(raw.slug)) continue;
  const spell = parseSpell(raw);
  if (!spell) {
    console.warn('Spell parse failed:', raw.slug);
    continue;
  }
  spellCount += 1;
  spellLines.push(`INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  ${sqlString(spell.slug)},
  ${sqlString(spell.name)},
  ${spell.level},
  ${sqlString(spell.levelLabel)},
  (SELECT id FROM rpg.phb_spell_school WHERE slug = ${sqlString(spell.schoolSlug)}),
  ${sqlString(spell.castingTime)},
  ${sqlString(spell.range)},
  ${spell.hasVerbal},
  ${spell.hasSomatic},
  ${spell.hasMaterial},
  ${sqlString(spell.materialDescription)},
  ${sqlString(spell.componentsLabel)},
  ${sqlString(spell.duration)},
  ${spell.concentration},
  ${spell.ritual},
  ${sqlString(spell.description)},
  ${sqlString(spell.higherLevels)},
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlString(citationSlug)})
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;
`);
  for (const classSlug of spell.classSlugs) {
    spellClassValues.push(
      `  ((SELECT id FROM rpg.phb_spell WHERE slug = ${sqlString(spell.slug)}), (SELECT id FROM rpg.phb_class WHERE slug = ${sqlString(classSlug)}))`,
    );
  }
}
fs.writeFileSync(path.join(seedDir, 'G016_phb_spell.sql'), spellLines.join('\n'), 'utf8');
fs.writeFileSync(
  path.join(seedDir, 'G017_phb_spell_class.sql'),
  [
    `-- Seed Gunslinger pack spell ↔ class`,
    ``,
    `INSERT INTO rpg.phb_spell_class (spell_id, class_id)`,
    `VALUES`,
    spellClassValues.join(',\n'),
    `ON CONFLICT DO NOTHING;`,
    ``,
  ].join('\n'),
  'utf8',
);

const equipSql = `-- Seed Gunslinger starting packages A/B
-- Explorer's Pack (EN) → kit-de-aventureiro (PHB PT)

INSERT INTO rpg.phb_class_starting_package (class_id, slug, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 'a', 'A', 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), 'b', 'B', 2)
ON CONFLICT (class_id, slug) DO NOTHING;

DELETE FROM rpg.phb_class_starting_item
WHERE package_id IN (
  SELECT p.id
  FROM rpg.phb_class_starting_package p
  JOIN rpg.phb_class c ON c.id = p.class_id
  WHERE c.slug = 'gunslinger'
);

-- Package A: Leather Armor, 2 Daggers, Revolver, 50 Bullets, Explorer's Pack, 11 GP
INSERT INTO rpg.phb_class_starting_item (package_id, item_id, choice_text, gold_amount, quantity, sort_order)
VALUES
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'leather'), NULL, NULL, 1, 1),
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), NULL, NULL, 2, 2),
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'revolver'), NULL, NULL, 1, 3),
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'bullets'), NULL, NULL, 5, 4),
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'a'),
   (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-aventureiro'), NULL, NULL, 1, 5),
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'a'),
   NULL, NULL, 11, 1, 6),
  ((SELECT p.id FROM rpg.phb_class_starting_package p JOIN rpg.phb_class c ON c.id = p.class_id WHERE c.slug = 'gunslinger' AND p.slug = 'b'),
   NULL, NULL, 175, 1, 1);
`;
fs.writeFileSync(path.join(seedDir, 'G018_phb_class_starting_equipment.sql'), equipSql, 'utf8');

const masteryCases = WEAPON_MASTERY_BY_LEVEL.ranges
  .map(
    (r) =>
      `  WHEN cp.level BETWEEN ${r.from} AND ${r.to} THEN ${r.count}`,
  )
  .join('\n');

const playableSql = `-- Gunslinger P0: mastery eligibility/progression + Risk resource

UPDATE rpg.phb_class
SET weapon_mastery_eligibility = 'any'
WHERE slug = 'gunslinger';

UPDATE rpg.phb_class_progression cp
SET weapon_mastery = CASE
${masteryCases}
  ELSE cp.weapon_mastery
END
FROM rpg.phb_class c
WHERE cp.class_id = c.id AND c.slug = 'gunslinger';

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES (
  'risk',
  'Risk',
  'class'::rpg.resource_scope,
  NULL,
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  class_id = EXCLUDED.class_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'risk' AND rd.class_id = c.id
CROSS JOIN (VALUES
${RISK_COUNT_SCHEDULE.map((r) => `  (${r.unlockLevel}, ${r.fixedMax})`).join(',\n')}
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'gunslinger'
ON CONFLICT DO NOTHING;
`;
fs.writeFileSync(path.join(seedDir, 'G019_gunslinger_playable.sql'), playableSql, 'utf8');

const fsSql = `-- Seed Gunslinger fighting style allowlist (same breadth as fighter)

INSERT INTO rpg.phb_class_fighting_style (class_id, fighting_style_id)
VALUES
${FIGHTING_STYLE_SLUGS.map(
  (slug) =>
    `  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_fighting_style WHERE slug = ${sqlString(slug)}))`,
).join(',\n')}
ON CONFLICT DO NOTHING;
`;
fs.writeFileSync(path.join(seedDir, 'G020_phb_class_fighting_style.sql'), fsSql, 'utf8');

console.log('Wrote D019_valda_gunslinger_citation.sql');
console.log('Wrote seeds in database/seeds/valda-gunslinger/');
console.log({
  class: klass.slug,
  features: data.features.length,
  maneuvers: data.maneuvers?.length ?? 0,
  subclasses: data.subclasses.length,
  subclassFeatures: scFeatureCount,
  firearms: FIREARMS.length,
  ammunition: AMMUNITION.length,
  feats: (data.feats ?? []).filter((f) => !SKIP_FEAT_SLUGS.has(f.slug)).length,
  featBenefits: featBenefitCount,
  spells: spellCount,
  spellClassLinks: spellClassValues.length,
});
