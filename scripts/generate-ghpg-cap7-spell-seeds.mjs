/**
 * Gera seeds Cap. 7 GHPG (magias + spell_class) a partir de cap7-spells.json.
 * Uso: node scripts/generate-ghpg-cap7-spell-seeds.mjs
 *
 * Textos EN da fonte (PT editorial = Fase F / overlay futuro).
 * Ranges e prosa em SI (tabela PHB 2024 PT).
 */
import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';

const JSON_PATH = extracts.grimHollow.cap7Spells;
const CITATION_OUT =
  'database/seeds/grim-hollow/J042_phb_edition_citation_cap7.sql';
const SPELL_OUT = 'database/seeds/grim-hollow/J043_phb_spell_cap7.sql';
const CLASS_OUT = 'database/seeds/grim-hollow/J044_phb_spell_class_cap7.sql';
const CITATION = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses';

const SCHOOL = {
  Evocation: 'evocacao',
  Transmutation: 'transmutacao',
  Conjuration: 'invocacao',
  Illusion: 'ilusao',
  Enchantment: 'encantamento',
  Divination: 'adivinhacao',
  Necromancy: 'necromancia',
  Abjuration: 'abjuracao',
};

const CLASS = {
  Bard: 'bard',
  Cleric: 'cleric',
  Druid: 'druid',
  Paladin: 'paladin',
  Ranger: 'ranger',
  Sorcerer: 'sorcerer',
  Warlock: 'warlock',
  Wizard: 'wizard',
};

function sqlStr(s) {
  return `'${String(s ?? '').replace(/'/g, "''")}'`;
}

function levelLabel(level) {
  if (level === 0) return 'Truque';
  return `${level}º círculo`;
}

function feetToMetersLabel(range) {
  if (!range) return 'Toque';
  const r = range.trim();
  if (/^self$/i.test(r)) return 'Pessoal';
  if (/^touch$/i.test(r)) return 'Toque';
  if (/^special$/i.test(r)) return 'Especial';
  const m = r.match(/^(\d+)\s*feet?/i);
  if (m) {
    const ft = Number(m[1]);
    const meters = Math.round((ft * 0.3) * 100) / 100;
    const pretty = Number.isInteger(meters)
      ? String(meters)
      : String(meters).replace('.', ',');
    return `${pretty} m`;
  }
  const selfSphere = r.match(/^Self\s*\((\d+)\s*-?\s*foot\s+([^)]+)\)/i);
  if (selfSphere) {
    const ft = Number(selfSphere[1]);
    const meters = Math.round((ft * 0.3) * 100) / 100;
    const pretty = Number.isInteger(meters)
      ? String(meters)
      : String(meters).replace('.', ',');
    const kind = selfSphere[2].trim();
    const kindPt = /radius/i.test(kind)
      ? 'raio'
      : /cone/i.test(kind)
        ? 'cone'
        : /line/i.test(kind)
          ? 'linha'
          : /cube/i.test(kind)
            ? 'cubo'
            : /emanation/i.test(kind)
              ? 'emanação'
              : kind;
    return `Pessoal (${pretty} m ${kindPt})`;
  }
  return toMetricProse(r);
}

function castTimePt(ct) {
  if (!ct) return 'Ação';
  const t = ct.trim();
  if (/^action$/i.test(t)) return 'Ação';
  if (/bonus/i.test(t)) return 'Ação Bônus';
  if (/reaction/i.test(t)) {
    return t
      .replace(/^Reaction/i, 'Reação')
      .replace(/,\s*which you take when/i, ', que você executa quando');
  }
  if (/minute/i.test(t)) return t.replace(/minute/gi, 'minuto');
  if (/hour/i.test(t)) return t.replace(/hour/gi, 'hora');
  return t;
}

function durationPt(d) {
  if (!d) return 'Instantânea';
  let out = d;
  out = out.replace(/Concentration,\s*up to/i, 'Concentração, até');
  out = out.replace(/\bInstantaneous\b/i, 'Instantânea');
  out = out.replace(/Until dispelled/i, 'Até ser dissipada');
  out = out.replace(/\b1 minute\b/i, '1 minuto');
  out = out.replace(/\b1 hour\b/i, '1 hora');
  out = out.replace(/\b8 hours\b/i, '8 horas');
  out = out.replace(/\b24 hours\b/i, '24 horas');
  out = out.replace(/\b(\d+)\s*minutes?\b/gi, (_, n) =>
    Number(n) === 1 ? '1 minuto' : `${n} minutos`,
  );
  out = out.replace(/\b(\d+)\s*hours?\b/gi, (_, n) =>
    Number(n) === 1 ? '1 hora' : `${n} horas`,
  );
  return toMetricProse(out);
}

/** Conversão SI de prosa (pés → m), alinhada à regra PHB 2024 PT. */
function toMetricProse(text) {
  if (!text) return text;
  return text
    .replace(/\b(\d+)\s*-?\s*foot\b/gi, (_, n) => {
      const m = Math.round(Number(n) * 0.3 * 100) / 100;
      const pretty = Number.isInteger(m) ? String(m) : String(m).replace('.', ',');
      return `${pretty} m`;
    })
    .replace(/\b(\d+)\s*feet\b/gi, (_, n) => {
      const m = Math.round(Number(n) * 0.3 * 100) / 100;
      const pretty = Number.isInteger(m) ? String(m) : String(m).replace('.', ',');
      return `${pretty} m`;
    })
    .replace(/\b(\d+)\s*ft\.?\b/gi, (_, n) => {
      const m = Math.round(Number(n) * 0.3 * 100) / 100;
      const pretty = Number.isInteger(m) ? String(m) : String(m).replace('.', ',');
      return `${pretty} m`;
    });
}

function components(labelRaw) {
  const label = (labelRaw ?? 'V, S').trim();
  const hasV = /\bV\b/i.test(label);
  const hasS = /\bS\b/i.test(label);
  const hasM = /\bM\b/i.test(label);
  let material = null;
  const m = label.match(/M\s*\(([^)]+)\)/i);
  if (m) material = m[1].trim();
  return { label, hasV, hasS, hasM, material };
}

const data = JSON.parse(fs.readFileSync(JSON_PATH, 'utf8'));
const spells = data.spells ?? [];

fs.writeFileSync(
  CITATION_OUT,
  `-- Grim Hollow — citação Cap. 7 (Spells & Curses)

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES (
  '${CITATION}',
  (SELECT id FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'),
  7,
  'Grim Hollow — Capítulo 7: Magias e Maldições',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
`,
  'utf8',
);
console.log('wrote', CITATION_OUT);

const spellSql = [];
spellSql.push('-- Magias Grim Hollow Cap. 7 (Spells & Curses)');
spellSql.push(
  '-- Gerado por scripts/generate-ghpg-cap7-spell-seeds.mjs — textos EN; ranges SI.',
);
spellSql.push(`-- Fonte: ${CITATION}`);
spellSql.push('-- Tag Sangromancy: prefixo na description quando aplicável.');
spellSql.push('');
spellSql.push(
  `-- Remove órfão de extract antigo (heading de regras confundido com magia)
DELETE FROM rpg.phb_spell_class
WHERE spell_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'shadowsteel-focus');
DELETE FROM rpg.phb_spell WHERE slug = 'shadowsteel-focus';
`,
);

for (const spell of spells) {
  const school = SCHOOL[spell.school];
  if (!school) {
    console.warn('unknown school', spell.name, spell.school);
    continue;
  }
  const comp = components(spell.components);
  const concentration = /concentration/i.test(spell.duration ?? '');
  const ritual = /\britual\b/i.test(
    `${spell.description ?? ''} ${spell.components ?? ''}`,
  );
  let description = toMetricProse(spell.description ?? '');
  if (spell.sangromancy) {
    description = `[Sangromancia] ${description}`;
  }
  const higherLevels = spell.higherLevels
    ? toMetricProse(spell.higherLevels)
    : null;

  spellSql.push(`INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  ${sqlStr(spell.slug)},
  ${sqlStr(spell.name)},
  ${spell.level ?? 0},
  ${sqlStr(levelLabel(spell.level ?? 0))},
  (SELECT id FROM rpg.phb_spell_school WHERE slug = ${sqlStr(school)}),
  ${sqlStr(castTimePt(spell.castingTime))},
  ${sqlStr(feetToMetersLabel(spell.range))},
  ${comp.hasV},
  ${comp.hasS},
  ${comp.hasM},
  ${comp.material ? sqlStr(comp.material) : 'NULL'},
  ${sqlStr(comp.label)},
  ${sqlStr(durationPt(spell.duration))},
  ${concentration},
  ${ritual},
  ${sqlStr(description)},
  ${higherLevels ? sqlStr(higherLevels) : 'NULL'},
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlStr(CITATION)})
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
}

fs.writeFileSync(SPELL_OUT, spellSql.join('\n'), 'utf8');
console.log('wrote', SPELL_OUT, 'spells', spells.length);

const classRows = [];
const seen = new Set();
for (const spell of spells) {
  for (const clsName of spell.listedClasses ?? []) {
    const classSlug = CLASS[clsName];
    if (!classSlug) {
      console.warn('unknown class', clsName, 'on', spell.slug);
      continue;
    }
    const key = `${spell.slug}|${classSlug}`;
    if (seen.has(key)) continue;
    seen.add(key);
    classRows.push({ spellSlug: spell.slug, classSlug });
  }
}

const classSql = [];
classSql.push('-- Listas de classe — magias Grim Hollow Cap. 7');
classSql.push('-- Gerado por scripts/generate-ghpg-cap7-spell-seeds.mjs');
classSql.push('');
for (const row of classRows) {
  classSql.push(`INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = ${sqlStr(row.spellSlug)}
  AND c.slug = ${sqlStr(row.classSlug)}
ON CONFLICT DO NOTHING;
`);
}

fs.writeFileSync(CLASS_OUT, classSql.join('\n'), 'utf8');
console.log('wrote', CLASS_OUT, 'links', classRows.length);
