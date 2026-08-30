/**
 * Gera seeds Cap. 5 Northlands (magias + spell_class) a partir do JSON de extração.
 * Uso: node scripts/gen-northlands-cap5-spell-seeds.mjs
 *
 * Slugs EN kebab estáveis. Se existir docs/source/extracts/northlands/cap5-spells-pt.json,
 * usa name/description/higherLevels PT por slug; caso contrário, textos EN da fonte.
 */
import fs from 'fs';

import { extracts } from './lib/docs-source.mjs';

const JSON_PATH = extracts.northlands.cap5;
const PT_PATH = extracts.northlands.cap5SpellsPt;
const SPELL_OUT = 'database/seeds/northlands-heroes/N026_phb_spell_cap5.sql';
const CLASS_OUT = 'database/seeds/northlands-heroes/N027_phb_spell_class_cap5.sql';
const CITATION = 'northlands-heroes-2024-en:magic-and-miscellany';

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
  const m = r.match(/^(\d+)\s*feet?/i);
  if (m) {
    const ft = Number(m[1]);
    const meters = Math.round((ft * 1.5) / 5) * 1.5; // approx 5e grid: 5ft=1.5m
    const pretty = Number.isInteger(meters) ? String(meters) : meters.toFixed(1).replace(/\.0$/, '');
    return `${pretty.replace('.', ',')} metros`;
  }
  return r;
}

function castTimePt(ct) {
  if (!ct) return 'Ação';
  const t = ct.trim().toLowerCase();
  if (t === 'action') return 'Ação';
  if (t.includes('bonus')) return 'Ação Bônus';
  if (t.includes('reaction')) {
    return ct
      .replace(/^Reaction/i, 'Reação')
      .replace(/,\s*which you take when/i, ', que você executa quando')
      .replace(/\ba creature succeeds or fails on a d20 Test\b/i, 'uma criatura tem sucesso ou falha em um Teste de D20')
      .replace(/\byou see a creature make an attack or spell attack\b/i, 'você vê uma criatura fazer um ataque ou ataque mágico')
      .replace(/\byou or a creature you can see within \d+ feet is damaged\b/i, (m) =>
        m.replace(/within (\d+) feet/i, (_, ft) => {
          const meters = Math.round((Number(ft) * 1.5) / 5) * 1.5;
          return `a até ${String(meters).replace('.', ',')} metros`;
        }).replace(/^you or a creature you can see /i, 'você ou uma criatura que possa ver '),
      );
  }
  if (t.includes('minute')) return ct;
  if (t.includes('hour')) return ct;
  return ct;
}

function durationPt(d) {
  if (!d) return 'Instantânea';
  let out = d;
  out = out.replace(/Concentration,\s*up to/i, 'Concentração, até');
  out = out.replace(/\bInstantaneous\b/i, 'Instantânea');
  out = out.replace(/\b1 minute\b/i, '1 minuto');
  out = out.replace(/\b1 hour\b/i, '1 hora');
  out = out.replace(/\b8 hours\b/i, '8 horas');
  out = out.replace(/\b24 hours\b/i, '24 horas');
  out = out.replace(/\bminutes?\b/gi, (m) => (m.toLowerCase().startsWith('minute') ? 'minuto' : 'minutos'));
  return out;
}

function splitBody(spell) {
  const body = spell.body ?? '';
  const higher =
    body.match(
      /(?:At Higher Levels|Cantrip Upgrade)\.?\s*([\s\S]*)$/i,
    )?.[1]?.trim() ?? null;
  let description = body;
  if (higher) {
    description = body
      .replace(/(?:At Higher Levels|Cantrip Upgrade)\.?\s*[\s\S]*$/i, '')
      .trim();
  }
  // Drop header / casting block from description start
  description = description
    .replace(
      /^[^\n]+\n\nCasting time:[^\n]+\n\nRange:[^\n]+\n\nComponents:[^\n]+\n\nDuration:[^\n]+\n\n/i,
      '',
    )
    .trim();
  return { description, higherLevels: higher };
}

function components(spell) {
  const label = (spell.components ?? 'V, S').trim();
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
const ptOverlay = fs.existsSync(PT_PATH)
  ? JSON.parse(fs.readFileSync(PT_PATH, 'utf8'))
  : null;
const ptOverlayCount = ptOverlay ? Object.keys(ptOverlay).length : 0;

const spellSql = [];
spellSql.push('-- Magias Northlands Cap. 5 (Magic and Miscellany)');
if (ptOverlay) {
  spellSql.push(
    `-- Gerado por scripts/gen-northlands-cap5-spell-seeds.mjs — textos PT (overlay ${PT_PATH}, ${ptOverlayCount} slugs).`,
  );
} else {
  spellSql.push(
    '-- Gerado por scripts/gen-northlands-cap5-spell-seeds.mjs — textos EN da fonte; PT no refino.',
  );
}
spellSql.push(`-- Fonte: ${CITATION}`);
spellSql.push('');

for (const spell of spells) {
  if (spell.slug === 'leviathan-avatar') continue; // bloco de criatura aninhado
  const school = SCHOOL[spell.school];
  if (!school) {
    console.warn('unknown school', spell.name, spell.school);
    continue;
  }
  const enBody = splitBody(spell);
  const overlay = ptOverlay?.[spell.slug] ?? null;
  const name = overlay?.name ?? spell.name;
  const description = overlay?.description ?? enBody.description;
  const higherLevels =
    overlay && Object.prototype.hasOwnProperty.call(overlay, 'higherLevels')
      ? overlay.higherLevels
      : enBody.higherLevels;
  const comp = components(spell);
  const concentration = /concentration/i.test(spell.duration ?? '');
  const ritual = /\britual\b/i.test(spell.body ?? '');

  spellSql.push(`INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  ${sqlStr(spell.slug)},
  ${sqlStr(name)},
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

fs.writeFileSync(SPELL_OUT, spellSql.join('\n'));
console.log(
  'wrote',
  SPELL_OUT,
  'spells',
  spells.filter((s) => s.slug !== 'leviathan-avatar').length,
  ptOverlay ? `(PT overlay ${ptOverlayCount})` : '(EN)',
);

const classRows = [];
const seen = new Set();
for (const spell of spells) {
  if (spell.slug === 'leviathan-avatar') continue;
  const listed = spell.listedClasses?.length
    ? spell.listedClasses
    : (spell.classAccess ?? []).map((c) => {
        const key = Object.keys(CLASS).find(
          (k) => CLASS[k] === c.classSlug,
        );
        return key;
      }).filter(Boolean);

  for (const clsName of listed) {
    const classSlug = CLASS[clsName] ?? CLASS[clsName?.trim?.()] ?? null;
    if (!classSlug) {
      // try normalize
      const hit = Object.entries(CLASS).find(
        ([k]) => k.toLowerCase() === String(clsName).toLowerCase(),
      );
      if (!hit) {
        console.warn('unknown class', spell.slug, clsName);
        continue;
      }
      const slug = hit[1];
      const key = `${spell.slug}|${slug}`;
      if (seen.has(key)) continue;
      seen.add(key);
      classRows.push({ spellSlug: spell.slug, classSlug: slug });
      continue;
    }
    const key = `${spell.slug}|${classSlug}`;
    if (seen.has(key)) continue;
    seen.add(key);
    classRows.push({ spellSlug: spell.slug, classSlug });
  }
}

const classSql = [];
classSql.push('-- Listas de classe — magias Northlands Cap. 5');
classSql.push('-- Gerado por scripts/gen-northlands-cap5-spell-seeds.mjs');
classSql.push('');
classSql.push('INSERT INTO rpg.phb_spell_class (spell_id, class_id)');
classSql.push('VALUES');
classSql.push(
  classRows
    .map(
      (r) =>
        `  ((SELECT id FROM rpg.phb_spell WHERE slug = ${sqlStr(r.spellSlug)}), (SELECT id FROM rpg.phb_class WHERE slug = ${sqlStr(r.classSlug)}))`,
    )
    .join(',\n'),
);
classSql.push('ON CONFLICT DO NOTHING;');
classSql.push('');

fs.writeFileSync(CLASS_OUT, classSql.join('\n'));
console.log('wrote', CLASS_OUT, 'links', classRows.length);
