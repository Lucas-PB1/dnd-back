/**
 * Extrai Cap. 2 (Monster Hunter + subclasses) do Grim Hollow Player's Guide.
 *
 * Pré-requisito: HTML do Cap. 2 em docs/source/scrap/ ou _scrapes/grim-hollow/
 *
 * Uso: node scripts/extract-ghpg-cap2.mjs
 */
import fs from 'fs';
import path from 'path';
import {
  anchorToSlug,
  detectActionEconomy,
  extractBlock,
  extractParagraphs,
  findGhpgCap2Html,
  stripTags,
} from './lib/ghpg-html-utils.mjs';
import { extracts, scrap, scrapes } from './lib/docs-source.mjs';

const outPath = extracts.grimHollow.cap2Subclasses;
const outPathEn = extracts.grimHollow.cap2SubclassesEn;

const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION = `${EDITION}:chapter-2-character-classes`;

/** id do h2 → slug da classe no catálogo (subclasses). */
const SUBCLASS_SECTION_BY_H2_ID = {
  MonsterHunterGuilds: 'monster-hunter',
  BarbarianSubclasses: 'barbarian',
  BardSubclasses: 'bard',
  ClericSubclasses: 'cleric',
  DruidSubclasses: 'druid',
  FighterSubclasses: 'fighter',
  MonkSubclasses: 'monk',
  PaladinSubclasses: 'paladin',
  RangerSubclasses: 'ranger',
  RogueSubclasses: 'rogue',
  SorcererSubclasses: 'sorcerer',
  WarlockSubclasses: 'warlock',
  WizardSubclasses: 'wizard',
};

function parseFeatures(sectionHtml) {
  const features = [];
  const re =
    /<h4[^>]*id="([^"]+)"[^>]*>[\s\S]*?<\/h4>([\s\S]*?)(?=<h4\b|<h3\b|<h2\b|$)/gi;
  let m;
  while ((m = re.exec(sectionHtml))) {
    const heading = stripTags(m[0].match(/<h4[^>]*>[\s\S]*?<\/h4>/i)?.[0] ?? '');
    const levelMatch =
      heading.match(/Level\s+(\d+)\s*:\s*(.+)/i) ??
      heading.match(/(\d+)(?:st|nd|rd|th)\s+Level\s*:\s*(.+)/i);
    if (!levelMatch) continue;
    const body = cleanFeatureDescription(stripTags(m[2]));
    features.push({
      anchorId: m[1],
      level: Number(levelMatch[1]),
      name: levelMatch[2].trim(),
      description: body,
      actionEconomy: detectActionEconomy(body),
    });
  }
  return features;
}

function cleanFeatureDescription(text) {
  return text
    .replace(/\s+Matt DeMino\b/g, '')
    .replace(/\s+Veli Nyström\b/g, '')
    .replace(/\s+Ona Kristensen\b/g, '')
    .replace(/\s+Gaston S\. Garcia\b/g, '')
    .replace(/\s+—Mercenary Veteran[\s\S]*$/s, '')
    .replace(/\s+—Wandering Bard[\s\S]*$/s, '')
    .replace(/\s+[A-Z][a-z]+(?:\s+[A-Z][a-z]+){1,2}$/, '')
    .replace(/\s+—The Red Book of Sangromancy[\s\S]*$/s, '')
    .replace(/\s+Remember, you only have[\s\S]*$/s, '')
    .replace(/\/\/ #site[\s\S]*$/s, '')
    .trim();
}

function parseSpellTables(sectionHtml) {
  const tables = [];
  const tableRe = /<table[^>]*(?:id="([^"]*)")?[^>]*>[\s\S]*?<\/table>/gi;
  let m;
  while ((m = tableRe.exec(sectionHtml))) {
    const id = m[1] ?? '';
    if (/spellcasting|features table|class features/i.test(id)) continue;
    const rows = [];
    const rowRe = /<tr[^>]*>([\s\S]*?)<\/tr>/gi;
    let row;
    while ((row = rowRe.exec(m[0]))) {
      const cells = [];
      const cellRe = /<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi;
      let cell;
      while ((cell = cellRe.exec(row[1]))) {
        const linkSpells = [
          ...cell[1].matchAll(/spell-tooltip[^>]*>([^<]+)</gi),
        ].map((match) => stripTags(match[1]));
        if (linkSpells.length) {
          cells.push(...linkSpells);
        } else {
          cells.push(stripTags(cell[1]));
        }
      }
      if (cells.length >= 2 && !/level/i.test(cells[0])) {
        const level = Number(cells[0]);
        if (!Number.isNaN(level)) {
          const spells = cells
            .slice(1)
            .flatMap((s) => s.split(','))
            .map((s) => s.trim())
            .filter((s) => s && s !== '-');
          if (spells.length && !spells.every((s) => /^[\d.]+$/.test(s))) {
            rows.push({ level, spells });
          }
        }
      }
    }
    if (rows.length && rows.some((r) => r.spells.some((s) => /^[A-Za-z]/.test(s) && s.length < 60))) {
      tables.push({ tableId: id || 'inline', rows });
    }
  }
  return tables;
}

function parseSubclass(sectionHtml, meta) {
  const nameMatch = sectionHtml.match(
    new RegExp(`<h3[^>]*id="${meta.anchorId}"[^>]*>[\\s\\S]*?</h3>`, 'i'),
  );
  const name = nameMatch ? stripTags(nameMatch[0]) : meta.anchorId;
  const afterH3 = sectionHtml.slice(
    sectionHtml.search(new RegExp(`<h3[^>]*id="${meta.anchorId}"`, 'i')),
  );
  const taglineMatch = afterH3.match(/<p[^>]*>\s*<em>([\s\S]*?)<\/em>\s*<\/p>/i);
  const tagline = taglineMatch ? stripTags(taglineMatch[1]) : '';
  const introEnd = afterH3.search(/<h4\b/i);
  const introHtml = introEnd > 0 ? afterH3.slice(0, introEnd) : afterH3;
  const imageMatch = sectionHtml.match(/\/(03-\d{3}\.[a-z0-9-]+\.png)/i);
  const imageFile = imageMatch ? imageMatch[1] : null;
  const introParas = extractParagraphs(introHtml).filter((p) => p !== tagline);
  const description = introParas.join('\n\n');
  const summary = introParas[0] ?? '';

  return {
    ...meta,
    name,
    tagline,
    summary,
    description,
    imageFile,
    features: parseFeatures(afterH3),
    spellTables: parseSpellTables(afterH3),
  };
}

function discoverSubclassAnchors(chunkHtml, classSlug) {
  const anchors = [];
  const h3Re =
    /<h3[^>]*\bwith-metadata\b[^>]*\sid="([^"]+)"[^>]*>|<h3[^>]*\sid="([^"]+)"[^>]*\bwith-metadata\b[^>]*>/gi;
  let m;
  while ((m = h3Re.exec(chunkHtml))) {
    const id = m[1] ?? m[2];
    const block = extractBlock(chunkHtml, id, 3);
    if (!block || !/<h4\b/i.test(block)) continue;
    anchors.push({
      anchorId: id,
      slug: anchorToSlug(id),
      classSlug,
    });
  }
  return anchors;
}

function parseTraitsTable(sectionHtml) {
  const traits = {};
  const tableMatch = sectionHtml.match(
    /<table[^>]*>[\s\S]*?Core Monster Hunter Traits[\s\S]*?<\/table>/i,
  );
  if (!tableMatch) return traits;
  for (const row of tableMatch[0].matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)) {
    const cells = [];
    for (const cell of row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)) {
      cells.push(stripTags(cell[1]));
    }
    if (cells.length >= 2 && cells[0] && !/^\d+$/.test(cells[0])) {
      traits[cells[0].replace(/:$/, '').trim()] = cells[1].trim();
    }
  }
  return traits;
}

function parseProgressionTable(sectionHtml) {
  const progression = [];
  const tableMatch = sectionHtml.match(
    /<table[^>]*id="MonsterHunterClassFeaturesTable"[\s\S]*?<\/table>/i,
  );
  if (!tableMatch) return progression;
  for (const row of tableMatch[0].matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)) {
    const cells = [];
    for (const cell of row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)) {
      cells.push(stripTags(cell[1]));
    }
    if (cells.length < 4) continue;
    const level = Number(cells[0]);
    const pb = Number(cells[1].replace('+', ''));
    const weaponMastery = Number(cells[3]);
    if (!Number.isNaN(level) && !Number.isNaN(pb)) {
      progression.push({
        level,
        proficiencyBonus: pb,
        featureSummary: cells[2],
        weaponMastery: Number.isNaN(weaponMastery) ? null : weaponMastery,
      });
    }
  }
  return progression;
}

function parseMonsterHunterClass(html) {
  const start = html.search(/<h2[^>]*id="NewClassMonsterHunter"/i);
  const end = html.search(/<h2[^>]*id="MonsterHunterGuilds"/i);
  if (start < 0 || end < 0) return null;

  const section = html.slice(start, end);
  const introEnd = section.search(/<h3[^>]*id="MonsterHunterClassFeatures"/i);
  const introSection = introEnd >= 0 ? section.slice(0, introEnd) : section;
  const introParas = extractParagraphs(introSection);
  const summary = introParas[0] ?? '';
  const description = introParas.join('\n\n');
  const traits = parseTraitsTable(section);
  const progression = parseProgressionTable(section);

  const featuresStart = section.search(/<h3[^>]*id="MonsterHunterClassFeatures"/i);
  const featuresHtml = featuresStart >= 0 ? section.slice(featuresStart) : section;

  return {
    slug: 'monster-hunter',
    name: 'Monster Hunter',
    summary,
    description,
    traits,
    progression,
    features: parseFeatures(featuresHtml),
  };
}

function parseSubclasses(html) {
  const subclasses = [];
  const h2Re = /<h2\b[\s\S]*?\sid="([^"]+)"/gi;
  const h2Starts = [];
  let m;
  while ((m = h2Re.exec(html))) {
    h2Starts.push({ index: m.index, id: m[1] });
  }

  for (let i = 0; i < h2Starts.length; i += 1) {
    const classSlug = SUBCLASS_SECTION_BY_H2_ID[h2Starts[i].id];
    if (!classSlug) continue;

    const start = h2Starts[i].index;
    const end = h2Starts[i + 1]?.index ?? html.length;
    const chunk = html.slice(start, end);

    for (const meta of discoverSubclassAnchors(chunk, classSlug)) {
      const full = extractBlock(html, meta.anchorId, 3);
      if (!full) continue;
      const parsed = parseSubclass(full, meta);
      if (parsed.features.length === 0) continue;
      subclasses.push(parsed);
    }
  }

  return subclasses;
}

const htmlPath = findGhpgCap2Html(scrap.grimHollow, scrapes.grimHollow);
if (!htmlPath) {
  console.error(
    'HTML Cap. 2 GHPG não encontrado.\n' +
      'Salve o export do D&D Beyond em:\n' +
      `  docs/source/scrap/Chapter 2_ ….html\n` +
      `  ou ${scrapes.grimHollow}/Chapter 2_ ….html`,
  );
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');
const monsterHunter = parseMonsterHunterClass(html);
const subclasses = parseSubclasses(html);

if (!monsterHunter?.features?.length) {
  console.error('Monster Hunter não detectado — revise o HTML ou os seletores.');
  process.exit(1);
}
if (subclasses.length === 0) {
  console.error('Nenhuma subclasse detectada — revise o HTML ou os seletores.');
  process.exit(1);
}

const payload = {
  source: path.basename(htmlPath),
  extractedAt: new Date().toISOString(),
  language: 'en',
  edition: {
    slug: EDITION,
    label: "Grim Hollow Player's Guide 2024",
    book: "Grim Hollow: Player's Guide",
    citationSlug: CITATION,
    chapterTitle: 'Grim Hollow — Capítulo 2: Classes e Subclasses',
  },
  monsterHunter,
  subclasses,
};

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPathEn, `${JSON.stringify(payload, null, 2)}\n`, 'utf8');
fs.writeFileSync(outPath, `${JSON.stringify(payload, null, 2)}\n`, 'utf8');

console.log(`Extract: ${outPath}`);
console.log(`Source: ${htmlPath}`);
console.log(`Monster Hunter: ${monsterHunter.features.length} features, ${monsterHunter.progression.length} levels`);
console.log(`Subclasses: ${subclasses.length}`);
const byClass = new Map();
for (const sc of subclasses) {
  byClass.set(sc.classSlug, (byClass.get(sc.classSlug) ?? 0) + 1);
}
for (const [cls, n] of [...byClass.entries()].sort()) {
  console.log(`  ${cls}: ${n}`);
}
