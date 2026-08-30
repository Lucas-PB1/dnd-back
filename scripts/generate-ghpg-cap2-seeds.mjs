/**
 * Gera seeds J022–J029 (Grim Hollow Cap. 2 — Monster Hunter + subclasses).
 * Requer docs/source/extracts/grim-hollow/cap2-subclasses.json (extract-ghpg-cap2.mjs).
 *
 * Uso: node scripts/generate-ghpg-cap2-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';
import { SPELL_SLUG_MAP } from './lib/ghpg-cap2-spell-slug-map.mjs';
import { translateFeatureName } from './lib/ghpg-cap2-feature-names-pt.mjs';
import {
  CLASS_FEATURE_NAME_PT,
  MONSTER_HUNTER_CLASS_PT,
  SUBCLASS_PT,
} from './lib/ghpg-cap2-subclass-pt.mjs';
import { translateGhpgProse } from './lib/ghpg-mechanical-glossary.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');
const extractPathEn = extracts.grimHollow.cap2SubclassesEn;
const featuresPtPath = extracts.grimHollow.cap2FeaturesPt;

function loadFeaturesPtOverlay() {
  if (!fs.existsSync(featuresPtPath)) return null;
  return JSON.parse(fs.readFileSync(featuresPtPath, 'utf8'));
}

function loadExtractEn() {
  const p = fs.existsSync(extractPathEn) ? extractPathEn : extracts.grimHollow.cap2Subclasses;
  return JSON.parse(fs.readFileSync(p, 'utf8'));
}

const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION = `${EDITION}:chapter-2-character-classes`;

/** Sobrescreve textos EN → PT (refino editorial além do glossário automático). */
const CLASS_OVERRIDES = {
  name: 'Caçador de Monstros',
  tagline: 'Profissional treinado para rastrear e abater ameaças monstruosas',
  primary_ability_label: 'Força ou Destreza e Inteligência',
  subclass_label: 'Guilda de Caça',
};
const CLASS_FEATURE_OVERRIDES = {};
const SUBCLASS_OVERRIDES = {};
const FEATURE_OVERRIDES = {};

const MH_SKILL_SLUGS = [
  'athletics',
  'history',
  'investigation',
  'medicine',
  'nature',
  'perception',
  'religion',
  'survival',
];

function sqlStr(s) {
  return String(s ?? '').replace(/'/g, "''");
}

function writeFile(rel, content) {
  const p = path.join(apiRoot, rel);
  fs.mkdirSync(path.dirname(p), { recursive: true });
  fs.writeFileSync(p, content, 'utf8');
  console.log('wrote', rel);
}

function resolveSubclass(sc, overlay) {
  const o = { ...(SUBCLASS_PT[sc.slug] ?? {}), ...(SUBCLASS_OVERRIDES[sc.slug] ?? {}), ...(overlay?.subclasses?.[sc.slug] ?? {}) };
  const fromOverlay = overlay?.subclasses?.[sc.slug];
  const fallbackTagline = sc.summary?.split('\n\n')[0]?.trim() ?? '';
  return {
    ...sc,
    name: o.name ?? sc.name,
    tagline: o.tagline ?? sc.tagline ?? fallbackTagline,
    summary: fromOverlay?.summary ?? translateGhpgProse(o.summary ?? sc.summary),
    description: fromOverlay?.description ?? translateGhpgProse(o.description ?? sc.description),
  };
}

function resolveFeature(sc, feat, overlay) {
  const key = `${sc.slug}:${feat.level}:${feat.name}`;
  const fromOverlay = overlay?.subclassFeatures?.[key];
  const desc =
    FEATURE_OVERRIDES[key] ??
    fromOverlay?.description ??
    translateGhpgProse(feat.description);
  const name =
    FEATURE_OVERRIDES[`${key}:name`] ??
    fromOverlay?.name ??
    translateFeatureName(feat.name);
  return { ...feat, name, description: desc };
}

function resolveClassFeature(feat, overlay) {
  const key = `${feat.level}:${feat.name}`;
  const fromOverlay = overlay?.classFeatures?.[key];
  return {
    ...feat,
    name:
      CLASS_FEATURE_OVERRIDES[`${key}:name`] ??
      fromOverlay?.name ??
      CLASS_FEATURE_NAME_PT[feat.name] ??
      translateFeatureName(feat.name),
    description:
      CLASS_FEATURE_OVERRIDES[key] ??
      fromOverlay?.description ??
      translateGhpgProse(feat.description),
  };
}

function resolveMonsterHunter(mh) {
  if (!mh) return null;
  return {
    ...mh,
    name: CLASS_OVERRIDES.name ?? mh.name,
    summary: translateGhpgProse(MONSTER_HUNTER_CLASS_PT.summary ?? mh.summary),
    description: translateGhpgProse(
      MONSTER_HUNTER_CLASS_PT.description ?? mh.description,
    ),
  };
}

if (!fs.existsSync(extractPathEn) && !fs.existsSync(extracts.grimHollow.cap2Subclasses)) {
  console.error(`Extract ausente: rode extract-ghpg-cap2.mjs`);
  process.exit(1);
}

const featuresPtOverlay = loadFeaturesPtOverlay();
if (!featuresPtOverlay) {
  console.warn(
    `Overlay PT ausente (${featuresPtPath}) — rode build-ghpg-cap2-features-pt-overlay.mjs`,
  );
}

const extract = loadExtractEn();
const monsterHunter = resolveMonsterHunter(extract.monsterHunter);
const subclasses = extract.subclasses.map((sc) => resolveSubclass(sc, featuresPtOverlay));

if (!monsterHunter) {
  console.error('Extract sem monsterHunter — rode extract-ghpg-cap2.mjs novamente.');
  process.exit(1);
}

// J022 — citação Cap. 2
writeFile(
  'database/seeds/grim-hollow/J022_phb_edition_citation_cap2.sql',
  `-- Grim Hollow — citação Cap. 2 (subclasses)

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES (
  '${CITATION}',
  (SELECT id FROM rpg.phb_edition WHERE slug = '${EDITION}'),
  2,
  'Grim Hollow — Capítulo 2: Classes e Subclasses',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;

UPDATE rpg.phb_edition SET notes = 'Grim Hollow — heranças, subclasses, antecedentes, talentos, equipamento avançado e transformações; textos em PT-BR onde disponível'
WHERE slug = '${EDITION}';
`,
);

// J023 — classe Monster Hunter
writeFile(
  'database/seeds/grim-hollow/J023_phb_class_monster_hunter.sql',
  `-- Grim Hollow — classe Caçador de Monstros

INSERT INTO rpg.phb_class (
  slug, name, tagline, summary, description,
  primary_ability_label, primary_ability_operator,
  hit_die, hp_level1_die_value, hp_fixed_per_level,
  hp_minimum_gain_per_level, hp_constitution_mod_applies,
  subclass_unlock_level, subclass_label,
  skill_choice_count, skill_choice_from,
  source_citation_id, spell_slot_pattern_id
)
VALUES (
  'monster-hunter',
  '${sqlStr(monsterHunter.name)}',
  '${sqlStr(CLASS_OVERRIDES.tagline ?? '')}',
  '${sqlStr(monsterHunter.summary)}',
  '${sqlStr(monsterHunter.description)}',
  '${sqlStr(CLASS_OVERRIDES.primary_ability_label ?? 'Força ou Destreza e Inteligência')}',
  'and',
  'd10',
  10,
  6,
  1,
  TRUE,
  3,
  '${sqlStr(CLASS_OVERRIDES.subclass_label ?? 'Guilda de Caça')}',
  3,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = '${CITATION}'),
  NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  primary_ability_label = EXCLUDED.primary_ability_label,
  hit_die = EXCLUDED.hit_die,
  hp_level1_die_value = EXCLUDED.hp_level1_die_value,
  hp_fixed_per_level = EXCLUDED.hp_fixed_per_level,
  subclass_unlock_level = EXCLUDED.subclass_unlock_level,
  subclass_label = EXCLUDED.subclass_label,
  skill_choice_count = EXCLUDED.skill_choice_count,
  source_citation_id = EXCLUDED.source_citation_id;
`,
);

// J024 — proficiências (primária, salvaguardas, armadura, armas, perícias)
let j024 = `-- Grim Hollow — Caçador de Monstros proficiências

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 3),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 0),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), 0)
ON CONFLICT (class_id, kind, ref_id) WHERE ref_id IS NOT NULL DO NOTHING;

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_slug)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais')
ON CONFLICT (class_id, kind, ref_slug) WHERE ref_slug IS NOT NULL DO NOTHING;

`;
for (const skill of MH_SKILL_SLUGS) {
  j024 += `INSERT INTO rpg.phb_class_skill_pool (class_id, skill_id)
SELECT c.id, s.id FROM rpg.phb_class c, rpg.phb_skill s
WHERE c.slug = 'monster-hunter' AND s.slug = '${skill}'
ON CONFLICT DO NOTHING;

`;
}
writeFile('database/seeds/grim-hollow/J024_phb_class_monster_hunter_proficiency.sql', j024);

// J025 — progressão + maestria em armas
let j025 = `-- Grim Hollow — Caçador de Monstros progressão\n\n`;
for (const row of monsterHunter.progression ?? []) {
  j025 += `INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  ${row.level},
  ${row.proficiencyBonus},
  NULL,
  NULL,
  NULL,
  ${row.weaponMastery ?? 'NULL'}
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

`;
}
writeFile('database/seeds/grim-hollow/J025_phb_class_monster_hunter_progression.sql', j025);

// J026 — features de classe
let classFeatureCount = 0;
let j026 = `-- Grim Hollow — Caçador de Monstros features\n\n`;
for (const feat of monsterHunter.features ?? []) {
  const f = resolveClassFeature(feat, featuresPtOverlay);
  classFeatureCount += 1;
  j026 += `INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  ${f.level},
  '${sqlStr(f.name)}',
  '${sqlStr(f.description)}'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

`;
}
writeFile('database/seeds/grim-hollow/J026_phb_class_monster_hunter_feature.sql', j026);
console.log('class features:', classFeatureCount);

// J027 — subclasses
let j027 = `-- Grim Hollow Cap. 2 — subclasses (${subclasses.length})\n\n`;
for (const sc of subclasses) {
  j027 += `INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  '${sc.slug}',
  (SELECT id FROM rpg.phb_class WHERE slug = '${sc.classSlug}'),
  '${sqlStr(sc.name)}',
  '${sqlStr(sc.tagline)}',
  '${sqlStr(sc.summary)}',
  '${sqlStr(sc.description)}',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = '${CITATION}')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

`;
}
writeFile('database/seeds/grim-hollow/J027_phb_subclass.sql', j027);

// J028 — subclass features (DELETE + INSERT evita duplicatas por renomeação PT)
let featureCount = 0;
let j028 = `-- Grim Hollow Cap. 2 — subclass features\n-- Fonte: ${extractPathEn.replace(/\\/g, '/')}\n\n`;
j028 += `DELETE FROM rpg.phb_subclass_feature f
USING rpg.phb_subclass s, rpg.phb_source_citation sc
WHERE f.subclass_id = s.id
  AND s.source_citation_id = sc.id
  AND sc.slug = '${CITATION}';

`;
for (const sc of subclasses) {
  for (const feat of sc.features) {
    const f = resolveFeature(sc, feat, featuresPtOverlay);
    featureCount += 1;
    j028 += `INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${sc.slug}'),
  ${f.level},
  '${sqlStr(f.name)}',
  '${sqlStr(f.description)}'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

`;
  }
}
writeFile('database/seeds/grim-hollow/J028_phb_subclass_feature.sql', j028);
console.log('subclass features:', featureCount);

// J029 — prepared spells
let j029 = `-- Grim Hollow Cap. 2 — prepared spells\n\n`;
let preparedLinks = 0;
for (const sc of subclasses) {
  for (const table of sc.spellTables ?? []) {
    for (const row of table.rows ?? []) {
      const spells = row.spells
        .map((name) => SPELL_SLUG_MAP[name] ?? null)
        .filter(Boolean);
      if (spells.length === 0) continue;
      preparedLinks += spells.length;
      j029 += `-- ${sc.slug} L${row.level}\n`;
      j029 += `INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, ${row.level}, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = '${sc.slug}' AND sp.slug IN (
  ${spells.map((x) => `'${x}'`).join(', ')}
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

`;
    }
  }
}
if (preparedLinks === 0) {
  j029 += '-- (nenhum vínculo — preencha SPELL_SLUG_MAP no gerador após revisar tabelas do extract)\n';
}
writeFile('database/seeds/grim-hollow/J029_phb_subclass_prepared_spell.sql', j029);
console.log('prepared spell links:', preparedLinks);

// Extract PT (metadados + overrides aplicados)
const extractPt = {
  ...extract,
  language: 'pt',
  edition: {
    ...extract.edition,
    chapterTitle: 'Grim Hollow — Capítulo 2: Classes e Subclasses',
  },
  monsterHunter: {
    ...monsterHunter,
    features: (monsterHunter.features ?? []).map((f) => resolveClassFeature(f, featuresPtOverlay)),
  },
  subclasses: subclasses.map((sc) => ({
    ...sc,
    features: sc.features.map((f) => resolveFeature(sc, f, featuresPtOverlay)),
  })),
};
writeFile(
  'docs/source/extracts/grim-hollow/cap2-subclasses.json',
  `${JSON.stringify(extractPt, null, 2)}\n`,
);

console.log('Done. Output:', outDir);
