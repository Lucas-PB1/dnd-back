/**
 * Gera seeds SQL Valda a partir de extracted.json
 * Uso: node scripts/generate-valda-seeds.mjs
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');
const sourceDir = path.join(root, 'docs/sources/valda-spire-of-secrets');
const data = JSON.parse(
  fs.readFileSync(path.join(sourceDir, 'extracted.json'), 'utf8'),
);

const seedDir = path.join(root, 'database/seeds/valda');
fs.mkdirSync(seedDir, { recursive: true });

function sqlString(value) {
  if (value == null) return 'NULL';
  return `'${String(value).replace(/'/g, "''")}'`;
}

const citationSlug = data.citation.slug;
const edition = data.edition;

const editionSql = `-- Valda's Spire of Secrets: Player Pack — edição + citação

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  ${sqlString(edition.slug)},
  ${sqlString(edition.label)},
  ${sqlString(edition.book)},
  ${sqlString(edition.language)},
  NOW(),
  ${sqlString(edition.notes)}
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  book = EXCLUDED.book,
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
  path.join(root, 'database/migrations/050_data/D018_valda_edition.sql'),
  editionSql,
  'utf8',
);

const subclassLines = [
  `-- Seed Valda subclasses (Player Pack)`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];

for (const sc of data.subclasses) {
  subclassLines.push(`INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  ${sqlString(sc.slug)},
  (SELECT id FROM rpg.phb_class WHERE slug = ${sqlString(sc.classSlug)}),
  ${sqlString(sc.name)},
  ${sqlString(sc.tagline)},
  ${sqlString(sc.summary)},
  ${sqlString(sc.description)},
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
  path.join(seedDir, 'V001_phb_subclass.sql'),
  subclassLines.join('\n'),
  'utf8',
);

const featureLines = [
  `-- Seed Valda subclass features`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];

for (const sc of data.subclasses) {
  for (const f of sc.features) {
    featureLines.push(`INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlString(sc.slug)}),
  ${f.level},
  ${sqlString(f.name)},
  ${sqlString(f.description)}
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
`);
  }
}

fs.writeFileSync(
  path.join(seedDir, 'V002_phb_subclass_feature.sql'),
  featureLines.join('\n'),
  'utf8',
);

/** Extrai traços nomeados do bloco "* Traits" usando nomes conhecidos. */
function splitNamedTraits(blockText, knownNames) {
  const cleaned = blockText
    .replace(/^Creature Type:[\s\S]*?(?=Darkvision\.|Plant Nature\.)/i, '')
    .trim();
  const escaped = knownNames.map((n) =>
    n.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'),
  );
  const re = new RegExp(`(?:^|\\n)(${escaped.join('|')})\\.\\s+`, 'g');
  const matches = [...cleaned.matchAll(re)];
  const traits = [];
  for (let i = 0; i < matches.length; i += 1) {
    const name = matches[i][1].trim();
    const start = matches[i].index + matches[i][0].length;
    const end = i + 1 < matches.length ? matches[i + 1].index : cleaned.length;
    const body = cleaned.slice(start, end).trim();
    traits.push({ name, description: `${name}. ${body}`.trim() });
  }
  return traits;
}

function normalizeSize(raw) {
  if (!raw) return 'Medium';
  if (/Small.*Medium|Medium.*Small/i.test(raw)) {
    return 'Small or Medium (Marionette construction only for Medium)';
  }
  if (/^Medium/i.test(raw)) return 'Medium';
  if (/^Small/i.test(raw)) return 'Small';
  return raw;
}

function normalizeSpeed(raw) {
  if (!raw) return '30 feet';
  const m = raw.match(/(\d+)\s*feet/i);
  return m ? `${m[1]} feet` : raw;
}

const SPECIES_TRAIT_NAMES = {
  geppettin: [
    'Darkvision',
    'Construct Nature',
    'Handcrafted Quality',
    'Gepettin Construction',
  ],
  mandrake: [
    'Plant Nature',
    'Natural Connection',
    'Root Magic',
    'Entangling Vines',
  ],
};

const sourceMeta = {
  editionSlug: edition.slug,
  book: edition.book,
  language: edition.language,
  citationSlug,
  source: 'valda-spire-player-pack',
};

const speciesLines = [
  `-- Seed Valda species`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];
const traitLines = [
  `-- Seed Valda species traits`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];
const optionDefLines = [
  `-- Seed Valda species option defs`,
  ``,
];
const optionValueLines = [
  `-- Seed Valda species option values`,
  ``,
];

let traitCount = 0;

for (const species of data.species) {
  speciesLines.push(`INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  ${sqlString(species.slug)},
  ${sqlString(species.name)},
  ${sqlString(species.creatureType ?? 'Humanoid')},
  ${sqlString(normalizeSize(species.size))},
  ${sqlString(normalizeSpeed(species.speed))},
  ${sqlString(species.description)},
  ${sqlString(JSON.stringify(sourceMeta))}::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
`);

  const traitsBlock = species.traits.find((t) => /traits$/i.test(t.name));
  const known = SPECIES_TRAIT_NAMES[species.slug] ?? [];
  const mechanical = traitsBlock
    ? splitNamedTraits(traitsBlock.description, known)
    : [];

  // Flavor constructions / lineages (H4 sections that aren't the traits block)
  for (const lore of species.traits.filter((t) => !/traits$/i.test(t.name))) {
    const desc = lore.description
      .replace(/\n*Moniek Schilder\s*$/i, '')
      .replace(/\n*Martin Kirby-Jackson\s*$/i, '')
      .trim();
    if (!desc || desc.length < 20) continue;
    mechanical.push({ name: lore.name, description: desc });
  }

  for (const trait of mechanical) {
    traitLines.push(`INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = ${sqlString(species.slug)}),
  ${sqlString(trait.name)},
  ${sqlString(trait.description)},
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;
`);
    traitCount += 1;
  }

  if (species.slug === 'geppettin') {
    optionDefLines.push(`INSERT INTO rpg.phb_species_option_def (species_id, option_key, value_type)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'skill'::rpg.option_value_type)
ON CONFLICT (species_id, option_key) DO UPDATE SET value_type = EXCLUDED.value_type;
`);
    optionValueLines.push(`INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'bisque', 'Bisque'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'marionette', 'Marionette'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'plushie', 'Plushie'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'intimidation', 'Intimidation'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'performance', 'Performance'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'persuasion', 'Persuasion')
ON CONFLICT (species_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
`);
  }

  if (species.slug === 'mandrake') {
    optionDefLines.push(`INSERT INTO rpg.phb_species_option_def (species_id, option_key, value_type)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'skill'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'ability'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'catalog'::rpg.option_value_type)
ON CONFLICT (species_id, option_key) DO UPDATE SET value_type = EXCLUDED.value_type;
`);
    optionValueLines.push(`INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'nature', 'Nature'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'survival', 'Survival'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'inteligencia', 'Intelligence'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'sabedoria', 'Wisdom'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'carisma', 'Charisma'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'spring', 'Spring'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'summer', 'Summer'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'autumn', 'Autumn'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'winter', 'Winter')
ON CONFLICT (species_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
`);
  }
}

fs.writeFileSync(path.join(seedDir, 'V003_phb_species.sql'), speciesLines.join('\n'), 'utf8');
fs.writeFileSync(path.join(seedDir, 'V004_phb_species_trait.sql'), traitLines.join('\n'), 'utf8');
fs.writeFileSync(path.join(seedDir, 'V005_phb_species_option_def.sql'), optionDefLines.join('\n'), 'utf8');
fs.writeFileSync(path.join(seedDir, 'V006_phb_species_option_value.sql'), optionValueLines.join('\n'), 'utf8');

function parseFeatPrerequisite(description) {
  const m = description.match(
    /General Feat\s*\(\s*Prerequisite:\s*([^)]+)\)/i,
  );
  return m ? m[1].trim() : null;
}

function parseFeatBenefits(description) {
  const cleaned = description
    .replace(/^General Feat[\s\S]*?You gain the following benefits\.\s*/i, '')
    .replace(/\n*[A-Z][a-z]+ [A-Z][a-z]+\s*$/g, '') // artist credit
    .trim();
  const re = /(?:^|\n)([A-Z][A-Za-z'’ /-]{1,80})\.\s+/g;
  const matches = [...cleaned.matchAll(re)];
  const benefits = [];
  for (let i = 0; i < matches.length; i += 1) {
    const name = matches[i][1].trim();
    const start = matches[i].index + matches[i][0].length;
    const end = i + 1 < matches.length ? matches[i + 1].index : cleaned.length;
    const body = cleaned.slice(start, end).trim();
    benefits.push({
      name,
      description: `${name}. ${body}`.trim(),
    });
  }
  if (benefits.length === 0 && cleaned) {
    benefits.push({ name: null, description: cleaned });
  }
  return benefits;
}

const featLines = [
  `-- Seed Valda feats`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];
const benefitLines = [
  `-- Seed Valda feat benefits`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];

let benefitCount = 0;
for (const feat of data.feats) {
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
  category_id = EXCLUDED.category_id,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
`);

  const benefits = parseFeatBenefits(feat.description);
  benefits.forEach((benefit, index) => {
    benefitCount += 1;
    benefitLines.push(`INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
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

fs.writeFileSync(path.join(seedDir, 'V007_phb_feat.sql'), featLines.join('\n'), 'utf8');
fs.writeFileSync(path.join(seedDir, 'V008_phb_feat_benefit.sql'), benefitLines.join('\n'), 'utf8');

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

function stripArtistCredit(text) {
  return String(text)
    .replace(
      /(?:^|\n)\s*[A-Z][a-z]+(?:-[A-Z][a-z]+)? [A-Z][a-z]+(?:-[A-Z][a-z]+)?(?:\s+CM)?\s*(?=\n|$)/g,
      '\n',
    )
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function fieldValue(block, label) {
  const re = new RegExp(
    `${label}:\\s*([\\s\\S]*?)(?=\\n(?:Casting Time|Range|Components|Duration):|\\n\\n|$)`,
    'i',
  );
  const m = block.match(re);
  return m ? m[1].replace(/\s+/g, ' ').trim() : null;
}

function parseSpell(raw) {
  const cleaned = stripArtistCredit(raw.description);
  const lines = cleaned.split(/\n+/);
  const header = lines[0] ?? '';

  let level = 0;
  let schoolEn = null;
  let subclassTag = null;
  let classNames = [];

  const leveled = header.match(
    /^Level\s+(\d)\s+(\w+)(?:\s+\[([^\]]+)\])?\s*\(([^)]+)\)/i,
  );
  const cantrip = header.match(
    /^(\w+)\s+Cantrip(?:\s+\[([^\]]+)\])?\s*\(([^)]+)\)/i,
  );

  if (leveled) {
    level = Number(leveled[1]);
    schoolEn = leveled[2];
    subclassTag = leveled[3] ?? null;
    classNames = leveled[4].split(',').map((s) => s.trim());
  } else if (cantrip) {
    level = 0;
    schoolEn = cantrip[1];
    subclassTag = cantrip[2] ?? null;
    classNames = cantrip[3].split(',').map((s) => s.trim());
  } else {
    throw new Error(`Spell header não reconhecido: ${raw.slug} → ${header}`);
  }

  const schoolSlug = SCHOOL_SLUG[schoolEn];
  if (!schoolSlug) {
    throw new Error(`Escola desconhecida em ${raw.slug}: ${schoolEn}`);
  }

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
    componentParts.push(
      materialDescription ? `M (${materialDescription})` : 'M',
    );
  }
  const componentsLabel = componentParts.join(', ') || componentsRaw;

  const concentration = /^Concentration/i.test(duration);
  const ritual =
    /\bor Ritual\b/i.test(castingTime) || /^Ritual\b/i.test(castingTime);

  const bodyStart = cleaned.search(
    /\n\n(?!Casting Time:|Range:|Components:|Duration:)/,
  );
  let body = bodyStart >= 0 ? cleaned.slice(bodyStart).trim() : cleaned;
  // Remove header + casting block if still present
  body = body
    .replace(/^(?:Level \d .+|[\w]+ Cantrip.+)\n+/i, '')
    .replace(/^Casting Time:[\s\S]*?Duration:[^\n]+\n*/i, '')
    .trim();

  let higherLevels = null;
  const higherSplit = body.split(
    /\n(?=Using a Higher-Level Spell Slot\.|Cantrip Upgrade\.)/i,
  );
  if (higherSplit.length > 1) {
    body = higherSplit[0].trim();
    higherLevels = higherSplit.slice(1).join('\n').trim();
  }

  const levelLabel = level === 0 ? 'Cantrip' : `Level ${level}`;
  const classSlugs = classNames.map((name) => {
    const slug = CLASS_SLUG[name];
    if (!slug) throw new Error(`Classe desconhecida em ${raw.slug}: ${name}`);
    return slug;
  });

  return {
    slug: raw.slug,
    name: raw.name,
    level,
    levelLabel,
    schoolSlug,
    subclassTag,
    castingTime,
    range,
    hasVerbal,
    hasSomatic,
    hasMaterial,
    materialDescription,
    componentsLabel,
    duration,
    concentration,
    ritual,
    description: body,
    higherLevels,
    classSlugs,
  };
}

const spellLines = [
  `-- Seed Valda spells`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];
const spellClassLines = [
  `-- Seed Valda spell ↔ class`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
  `INSERT INTO rpg.phb_spell_class (spell_id, class_id)`,
  `VALUES`,
];

const parsedSpells = data.spells.map(parseSpell);
let spellClassCount = 0;
const spellClassValues = [];

for (const spell of parsedSpells) {
  const descriptionWithTag = spell.subclassTag
    ? `[${spell.subclassTag}]\n\n${spell.description}`
    : spell.description;

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
  ${sqlString(descriptionWithTag)},
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
    spellClassCount += 1;
    spellClassValues.push(
      `  ((SELECT id FROM rpg.phb_spell WHERE slug = ${sqlString(spell.slug)}), (SELECT id FROM rpg.phb_class WHERE slug = ${sqlString(classSlug)}))`,
    );
  }
}

spellClassLines.push(`${spellClassValues.join(',\n')}`);
spellClassLines.push(`ON CONFLICT DO NOTHING;`);
spellClassLines.push(``);

fs.writeFileSync(path.join(seedDir, 'V009_phb_spell.sql'), spellLines.join('\n'), 'utf8');
fs.writeFileSync(
  path.join(seedDir, 'V010_phb_spell_class.sql'),
  spellClassLines.join('\n'),
  'utf8',
);

const RARITY_SLUG = {
  common: 'common',
  uncommon: 'uncommon',
  rare: 'rare',
  'very rare': 'very-rare',
  legendary: 'legendary',
  artifact: 'artifact',
};

function parseMagicItem(raw) {
  const cleaned = stripArtistCredit(
    raw.description.replace(/[ \t]+\n/g, '\n').replace(/\n{3,}/g, '\n\n'),
  );
  const lines = cleaned.split(/\n+/).map((l) => l.trim()).filter(Boolean);
  const header = lines[0] ?? '';

  const headerMatch = header.match(
    /^(.+?),\s*(Common|Uncommon|Rare|Very Rare|Legendary|Artifact)(?:\s*\((Requires Attunement[^)]*)\))?$/i,
  );
  if (!headerMatch) {
    throw new Error(`Item header não reconhecido: ${raw.slug} → ${header}`);
  }

  const categoryRaw = headerMatch[1].trim();
  const rarityLabel = headerMatch[2];
  const attunementRaw = headerMatch[3] ?? null;
  const requiresAttunement = Boolean(attunementRaw);
  const raritySlug =
    RARITY_SLUG[rarityLabel.toLowerCase()] ?? rarityLabel.toLowerCase();

  let itemType = 'other';
  let weaponSubtype = null;
  const weaponMatch = categoryRaw.match(/^Weapon\s*\(([^)]+)\)/i);
  if (weaponMatch) {
    itemType = 'weapon';
    weaponSubtype = weaponMatch[1].trim();
  } else if (/^Armor/i.test(categoryRaw)) {
    itemType = 'armor';
  } else if (/^Ring$/i.test(categoryRaw)) {
    itemType = 'other';
  } else if (/^Wondrous/i.test(categoryRaw)) {
    itemType = 'other';
  }

  const body = lines.slice(1).join('\n\n').trim();
  const weightMatch = body.match(/weighs?\s+([\d./]+\s*(?:pounds?|lb\.?))/i);
  const weight = weightMatch ? weightMatch[1].replace(/\s+/g, ' ') : null;

  const properties = {
    magic: true,
    category: categoryRaw,
    rarity: raritySlug,
    rarityLabel,
    requiresAttunement,
    ...(attunementRaw ? { attunement: attunementRaw.trim() } : {}),
    ...(weaponSubtype ? { weaponSubtype } : {}),
    source: 'valda-spire-player-pack',
    editionSlug: edition.slug,
    citationSlug,
  };

  return {
    slug: raw.slug,
    name: raw.name,
    itemType,
    weight,
    description: body || cleaned,
    properties,
  };
}

const itemLines = [
  `-- Seed Valda magic items`,
  `-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json`,
  ``,
];

const parsedItems = data.magicItems.map(parseMagicItem);
for (const item of parsedItems) {
  itemLines.push(`INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  ${sqlString(item.slug)},
  ${sqlString(item.itemType)}::rpg.item_type,
  ${sqlString(item.name)},
  NULL,
  ${sqlString(item.weight)},
  ${sqlString(item.description)},
  ${sqlString(JSON.stringify(item.properties))}::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
`);
}

fs.writeFileSync(path.join(seedDir, 'V011_phb_item.sql'), itemLines.join('\n'), 'utf8');

console.log('Wrote D018_valda_edition.sql');
console.log('Wrote seeds/valda/V001_phb_subclass.sql');
console.log('Wrote seeds/valda/V002_phb_subclass_feature.sql');
console.log('Wrote seeds/valda/V003_phb_species.sql');
console.log('Wrote seeds/valda/V004_phb_species_trait.sql');
console.log('Wrote seeds/valda/V005_phb_species_option_def.sql');
console.log('Wrote seeds/valda/V006_phb_species_option_value.sql');
console.log('Wrote seeds/valda/V007_phb_feat.sql');
console.log('Wrote seeds/valda/V008_phb_feat_benefit.sql');
console.log('Wrote seeds/valda/V009_phb_spell.sql');
console.log('Wrote seeds/valda/V010_phb_spell_class.sql');
console.log('Wrote seeds/valda/V011_phb_item.sql');
console.log({
  subclasses: data.subclasses.length,
  features: data.summary.subclassFeatures,
  species: data.species.length,
  traits: traitCount,
  feats: data.feats.length,
  featBenefits: benefitCount,
  spells: parsedSpells.length,
  spellClassLinks: spellClassCount,
  magicItems: parsedItems.length,
  attunedItems: parsedItems.filter((i) => i.properties.requiresAttunement)
    .length,
});
