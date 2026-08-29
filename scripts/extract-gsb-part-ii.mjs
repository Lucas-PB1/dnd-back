/**
 * Extrai Part II (Feathren + 12 subclasses) do scrape D&D Beyond GSB Book One.
 *
 * Uso: node scripts/extract-gsb-part-ii.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const sourceDir = path.join(apiRoot, 'docs/source');

const htmlPath = fs
  .readdirSync(sourceDir)
  .filter((n) => n.includes('Part II') && n.endsWith('.html'))
  .map((n) => path.join(sourceDir, n))[0];

if (!htmlPath) {
  console.error('HTML Part II não encontrado em docs/source');
  process.exit(1);
}

const SUBCLASS_META = [
  { anchorId: 'PathOfTheGlacier', slug: 'path-of-the-glacier', classSlug: 'barbarian' },
  { anchorId: 'CollegeOfChoreography', slug: 'college-of-choreography', classSlug: 'bard' },
  { anchorId: 'AstralDomain', slug: 'astral-domain', classSlug: 'cleric' },
  { anchorId: 'TheUnbrokenCircle', slug: 'the-unbroken-circle', classSlug: 'druid' },
  { anchorId: 'CouatlHerald', slug: 'couatl-herald', classSlug: 'fighter' },
  { anchorId: 'WarriorOfTheCelestial', slug: 'warrior-of-the-celestial', classSlug: 'monk' },
  { anchorId: 'OathOfTheHearth', slug: 'oath-of-the-hearth', classSlug: 'paladin' },
  { anchorId: 'WinterTrapper', slug: 'winter-trapper', classSlug: 'ranger' },
  { anchorId: 'Runetagger', slug: 'runetagger', classSlug: 'rogue' },
  { anchorId: 'FrostSorcery', slug: 'frost-sorcery', classSlug: 'sorcerer' },
  { anchorId: 'TheAstralGriffon', slug: 'astral-griffon-patron', classSlug: 'warlock' },
  { anchorId: 'Materializer', slug: 'materializer', classSlug: 'wizard' },
];

function decodeHtml(value) {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'");
}

function stripTags(html) {
  return decodeHtml(
    html
      .replace(/<br\s*\/?>/gi, '\n')
      .replace(/<\/p>/gi, '\n')
      .replace(/<\/li>/gi, '\n')
      .replace(/<\/tr>/gi, '\n')
      .replace(/<[^>]+>/g, '')
      .replace(/\n{3,}/g, '\n\n')
      .trim(),
  );
}

function extractBetween(html, startRe, endRe) {
  const start = html.search(startRe);
  if (start < 0) return '';
  const slice = html.slice(start);
  const end = slice.search(endRe);
  return end < 0 ? slice : slice.slice(0, end);
}

function extractHeadingBlock(html, tag, id) {
  const re = new RegExp(
    `<${tag}[^>]*id="${id}"[^>]*>[\\s\\S]*?</${tag}>`,
    'i',
  );
  const m = html.match(re);
  return m ? stripTags(m[0].replace(new RegExp(`^<${tag}[^>]*>`, 'i'), '')) : '';
}

function extractSectionAfterHeading(html, tag, id, untilTag = 'h2') {
  const re = new RegExp(`<${tag}[^>]*id="${id}"[^>]*>`, 'i');
  const start = html.search(re);
  if (start < 0) return '';
  const rest = html.slice(start);
  const endRe = new RegExp(`<${untilTag}\\b`, 'i');
  const end = rest.search(endRe);
  const chunk = end > 0 ? rest.slice(0, end) : rest;
  return chunk;
}

function parseFeatures(sectionHtml) {
  const features = [];
  const re =
    /<h4[^>]*id="([^"]+)"[^>]*>[\s\S]*?<\/h4>([\s\S]*?)(?=<h4\b|<h3\b|<h2\b|$)/gi;
  let m;
  while ((m = re.exec(sectionHtml))) {
    const heading = stripTags(m[0].match(/<h4[^>]*>[\s\S]*?<\/h4>/i)?.[0] ?? '');
    const levelMatch = heading.match(/Level\s+(\d+)\s*:\s*(.+)/i);
    if (!levelMatch) continue;
    const body = stripTags(m[2]);
    features.push({
      anchorId: m[1],
      level: Number(levelMatch[1]),
      name: levelMatch[2].trim(),
      description: body,
    });
  }
  return features;
}

function parseSpellTables(sectionHtml) {
  const tables = [];
  const tableRe =
    /<table[^>]*id="([^"]+)"[^>]*>[\s\S]*?<\/table>/gi;
  let m;
  while ((m = tableRe.exec(sectionHtml))) {
    const id = m[1];
    if (!/spell/i.test(id) && !/Spells$/i.test(stripTags(m[0]))) continue;
    const rows = [];
    const rowRe = /<tr[^>]*>([\s\S]*?)<\/tr>/gi;
    let row;
    while ((row = rowRe.exec(m[0]))) {
      const cells = [];
      const cellRe = /<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi;
      let cell;
      while ((cell = cellRe.exec(row[1]))) {
        cells.push(stripTags(cell[1]));
      }
      if (cells.length >= 2 && !/level/i.test(cells[0])) {
        const level = Number(cells[0]);
        if (!Number.isNaN(level)) {
          const spells = cells
            .slice(1)
            .join(', ')
            .split(',')
            .map((s) => s.trim())
            .filter(Boolean);
          rows.push({ level, spells });
        }
      }
    }
    if (rows.length) tables.push({ tableId: id, rows });
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
  const introParas = [];
  const pRe = /<p[^>]*>([\s\S]*?)<\/p>/gi;
  let p;
  while ((p = pRe.exec(introHtml))) {
    const text = stripTags(p[1]);
    if (text && text !== tagline) introParas.push(text);
  }
  const description = introParas.join('\n\n');
  const summary = introParas[0] ?? '';

  return {
    ...meta,
    name,
    tagline,
    summary,
    description,
    features: parseFeatures(afterH3),
    spellTables: parseSpellTables(afterH3),
  };
}

function parseFeathren(html) {
  const section = extractSectionAfterHeading(html, 'h2', 'Feathren', 'h2');
  const traitsSection = extractSectionAfterHeading(section, 'h3', 'FeathrenTraits', 'h2');

  const intro = stripTags(
    extractBetween(
      section,
      /<h2[^>]*id="Feathren"/i,
      /<h3[^>]*id="VariedHeritage"/i,
    ),
  );

  const variedHeritage = extractHeadingBlock(section, 'h3', 'VariedHeritage');
  const confident = extractHeadingBlock(section, 'h3', 'ConfidentAndCurious');
  const names = extractHeadingBlock(section, 'h3', 'FeathrenNames');

  const traitsHtml = traitsSection;
  const creatureType = stripTags(
    traitsHtml.match(/<strong>Creature Type:<\/strong>[^<]*/i)?.[0] ?? '',
  ).replace(/^Creature Type:\s*/i, '');
  const size = stripTags(
    traitsHtml.match(/<strong>Size:<\/strong>[^<]*/i)?.[0] ?? '',
  ).replace(/^Size:\s*/i, '');
  const speed = stripTags(
    traitsHtml.match(/<strong>Speed:<\/strong>[^<]*/i)?.[0] ?? '',
  ).replace(/^Speed:\s*/i, '');

  const traitBlocks = [];
  const traitRe =
    /<p[^>]*>\s*<strong><em>\s*([^<]+?)\s*<\/em><\/strong>\s*([\s\S]*?)<\/p>/gi;
  let t;
  while ((t = traitRe.exec(traitsHtml))) {
    traitBlocks.push({
      name: t[1].trim(),
      description: stripTags(t[2]),
    });
  }

  const avianTable = parseSpellTables(
    traitsHtml.match(/<table[^>]*id="AvianAncestry"[\s\S]*?<\/table>/i)?.[0] ?? '',
  );
  const felineTable = parseSpellTables(
    traitsHtml.match(/<table[^>]*id="FelineAncestry"[\s\S]*?<\/table>/i)?.[0] ?? '',
  );

  return {
    slug: 'feathren',
    name: 'Feathren',
    creatureType,
    size,
    speed,
    description: [intro, variedHeritage, confident].filter(Boolean).join('\n\n'),
    namesSection: names,
    traits: traitBlocks,
    avianAncestry: avianTable[0]?.rows ?? [],
    felineAncestry: felineTable[0]?.rows ?? [],
  };
}

const html = fs.readFileSync(htmlPath, 'utf8');

const subclasses = SUBCLASS_META.map((meta) => {
  const section = extractSectionAfterHeading(html, 'h3', meta.anchorId, 'h3');
  const full = extractSectionAfterHeading(html, 'h3', meta.anchorId, 'h2');
  return parseSubclass(full || section, meta);
});

const species = parseFeathren(html);

const outPath = path.join(apiRoot, 'docs/source/gsb1-part-ii-character-options-extract.json');
const payload = {
  source: path.basename(htmlPath),
  extractedAt: new Date().toISOString(),
  edition: {
    slug: 'griffons-saddlebag-book-one-2024-en',
    label: "Griffon's Saddlebag Book One 2024",
    book: "The Griffon's Saddlebag: Book One",
    citationSlug: 'griffons-saddlebag-book-one-2024-en:part-ii-character-options',
    chapterTitle: "The Griffon's Saddlebag: Book One — Part II: Character Options",
  },
  species,
  subclasses,
};

fs.writeFileSync(outPath, `${JSON.stringify(payload, null, 2)}\n`, 'utf8');

console.log(`Extract: ${outPath}`);
console.log(`Species: ${species.name} (${species.traits.length} traits)`);
for (const sc of subclasses) {
  console.log(
    `  ${sc.classSlug}/${sc.slug}: ${sc.features.length} features, ${sc.spellTables.length} spell table(s)`,
  );
}
