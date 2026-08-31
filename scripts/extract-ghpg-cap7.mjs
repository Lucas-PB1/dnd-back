/**
 * Extrai Cap. 7 GHPG (Spells & Curses) do HTML Beyond → extracts/grim-hollow/cap7-spells.json
 * Uso: node scripts/extract-ghpg-cap7.mjs
 *
 * Lê `docs/source/scrap` primeiro, depois `_scrapes/grim-hollow`.
 */
import fs from 'fs';
import path from 'path';
import { extracts, scrapDir, scrapes } from './lib/docs-source.mjs';
import {
  anchorToSlug,
  extractParagraphs,
  findGhpgChapterHtml,
  stripTags,
} from './lib/ghpg-html-utils.mjs';

const htmlPath = findGhpgChapterHtml(7, scrapDir, scrapes.grimHollow);
if (!htmlPath) {
  console.error(
    'HTML Cap. 7 GHPG não encontrado em docs/source/scrap nem _scrapes/grim-hollow',
  );
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');

const SCHOOLS = [
  'Abjuration',
  'Conjuration',
  'Divination',
  'Enchantment',
  'Evocation',
  'Illusion',
  'Necromancy',
  'Transmutation',
];

const CLASS_NAMES = [
  'Artificer',
  'Bard',
  'Cleric',
  'Druid',
  'Paladin',
  'Ranger',
  'Sorcerer',
  'Warlock',
  'Wizard',
];

/**
 * @param {string} italic
 * @returns {{ level: number, school: string|null, sangromancy: boolean, listedClasses: string[] }}
 */
function parseItalicMeta(italic) {
  const text = italic.replace(/\s+/g, ' ').trim();
  let level = 0;
  const cantrip = /Cantrip/i.test(text);
  if (!cantrip) {
    const lm = text.match(/Level\s+(\d+)/i);
    level = lm ? Number(lm[1]) : 0;
  }
  const sangromancy = /\(Sangromancy\)/i.test(text);
  let school = null;
  for (const s of SCHOOLS) {
    if (new RegExp(`\\b${s}\\b`, 'i').test(text)) {
      school = s;
      break;
    }
  }
  const listedClasses = [];
  for (const c of CLASS_NAMES) {
    if (new RegExp(`\\b${c}\\b`, 'i').test(text)) listedClasses.push(c);
  }
  return { level, school, sangromancy, listedClasses };
}

function fieldValue(block, label) {
  const re = new RegExp(
    `<strong>${label}:</strong>\\s*([\\s\\S]*?)</p>`,
    'i',
  );
  const m = block.match(re);
  return m ? stripTags(m[1]) : null;
}

/**
 * Blocos de magia: cada h4 é parseado isoladamente (evita cruzar headings
 * de regras tipo Shadowsteel Focus / Stages of Progression).
 */
function extractSpellBlocks(pageHtml) {
  const spells = [];
  const h4Re = /<h4 class="compendium-hr[^"]*"[^>]*>([\s\S]*?)<\/h4>/gi;
  const h4Matches = [...pageHtml.matchAll(h4Re)];

  for (let i = 0; i < h4Matches.length; i++) {
    const m = h4Matches[i];
    const inner = m[1];
    const tip = inner.match(
      /<a class="tooltip-hover spell-tooltip"[^>]*>([^<]+)<\/a>/i,
    );
    if (!tip) continue; // heading de regras, não magia

    const name = stripTags(tip[1]);
    const start = m.index ?? 0;
    const end =
      i + 1 < h4Matches.length
        ? (h4Matches[i + 1].index ?? pageHtml.length)
        : pageHtml.length;
    const block = pageHtml.slice(start, end);

    const anchorFromId = (m[0].match(/\sid="([^"]+)"/i) || [])[1] ?? null;
    const anchorFromHref = (
      inner.match(/chapter-7-spells-curses#([A-Za-z0-9]+)/i) || []
    )[1];
    const anchorId = anchorFromId || anchorFromHref || null;
    const tipHref = (
      inner.match(/\/spells\/\d+-([^"?]+)/i) || []
    )[1];
    const slug =
      tipHref ||
      (anchorId ? anchorToSlug(anchorId) : slugifyFallback(name));

    const italic = block.match(/<p[^>]*><em>([\s\S]*?)<\/em><\/p>/i);
    const meta = parseItalicMeta(italic ? stripTags(italic[1]) : '');

    const castingTime = fieldValue(block, 'Casting Time') ?? 'Action';
    const range = fieldValue(block, 'Range') ?? 'Self';
    const components = fieldValue(block, 'Components') ?? 'V, S';
    const duration = fieldValue(block, 'Duration') ?? 'Instantaneous';

    const afterComponents = block.split(/<\/div>/i).slice(1).join('</div>');
    const paras = extractParagraphs(
      afterComponents.length ? afterComponents : block,
      { skipAside: true },
    ).filter((p) => {
      if (/^(Casting Time|Range|Components|Duration):/i.test(p)) return false;
      if (/^Level\s+\d+/i.test(p) || /Cantrip/i.test(p)) return false;
      if (p === name) return false;
      return true;
    });

    let higherLevels = null;
    const bodyParts = [];
    for (const p of paras) {
      if (
        /^(At Higher Levels|Using a Higher-Level Spell Slot|Cantrip Upgrade)\b/i.test(
          p,
        )
      ) {
        higherLevels = p
          .replace(
            /^(At Higher Levels|Using a Higher-Level Spell Slot|Cantrip Upgrade)\.?\s*/i,
            '',
          )
          .trim();
      } else if (higherLevels) {
        higherLevels = `${higherLevels} ${p}`.trim();
      } else {
        bodyParts.push(p);
      }
    }

    const description = bodyParts.join('\n\n').trim();
    if (!description || !meta.school) {
      console.warn('skip incomplete', name, {
        school: meta.school,
        len: description.length,
      });
      continue;
    }

    spells.push({
      name,
      slug,
      anchorId,
      level: meta.level,
      school: meta.school,
      sangromancy: meta.sangromancy,
      listedClasses: meta.listedClasses,
      castingTime,
      range,
      components,
      duration,
      description,
      higherLevels,
      summary: description.slice(0, 200),
    });
  }

  return spells;
}

function slugifyFallback(name) {
  return name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

const outPath = extracts.grimHollow.cap7Spells;
const spells = extractSpellBlocks(html);
const sangromancyCount = spells.filter((s) => s.sangromancy).length;

const payload = {
  source: {
    editionSlug: 'grim-hollow-players-guide-2024-en',
    chapter: 7,
    title: 'Spells & Curses',
    scrapedHtml: path.relative(process.cwd(), htmlPath).replace(/\\/g, '/'),
    extractedAt: new Date().toISOString().slice(0, 10),
  },
  summary: {
    spellCount: spells.length,
    sangromancyCount,
  },
  spells,
};

fs.writeFileSync(outPath, JSON.stringify(payload, null, 2) + '\n', 'utf8');
console.log('wrote', outPath);
console.log('spells', spells.length, 'sangromancy', sangromancyCount);
console.log(
  'levels',
  Object.fromEntries(
    [...new Set(spells.map((s) => s.level))]
      .sort((a, b) => a - b)
      .map((l) => [l, spells.filter((s) => s.level === l).length]),
  ),
);
