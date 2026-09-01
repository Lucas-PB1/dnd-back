/**
 * Extrai Cap. 6 (Transformations) do Grim Hollow Player's Guide.
 * Uso: node scripts/extract-ghpg-cap6.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts, scrapDir, scrapes } from './lib/docs-source.mjs';
import {
  detectActionEconomy,
  extractBlock,
  extractParagraphs,
  findGhpgChapterHtml,
  slugify,
  stripTags,
} from './lib/ghpg-html-utils.mjs';
import {
  parseAppendices,
  parseStages,
} from './lib/ghpg-cap6-extract-helpers.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const outPath = extracts.grimHollow.cap6Transformations;

const htmlPath = findGhpgChapterHtml(6, scrapDir, scrapes.grimHollow);
if (!htmlPath) {
  console.error(
    'HTML Cap. 6 GHPG não encontrado em docs/source/scrap nem _scrapes/grim-hollow',
  );
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');

const TRANSFORMATION_TYPES = [
  'AbberantHorror',
  'Fey',
  'Fiend',
  'Hag',
  'Lich',
  'Lycanthrope',
  'Ooze',
  'Primordial',
  'Seraph',
  'ShadowsteelGhoul',
  'Specter',
  'Vampire',
];

const TRANSFORMATION_NAME_PT = {
  'Aberrant Horror': 'Horror Aberrante',
  Fey: 'Fada',
  Fiend: 'Corruptor',
  Hag: 'Bruxa',
  Lich: 'Lich',
  Lycanthrope: 'Licantropo',
  Ooze: 'Gosma',
  Primordial: 'Primordial',
  Seraph: 'Serafim',
  'Shadowsteel Ghoul': 'Carniçal de Aço Sombrio',
  Specter: 'Espectro',
  Vampire: 'Vampiro',
};

function anchorIdToDisplayName(anchorId) {
  const fixed = anchorId.replace(/^Abberant/, 'Aberrant');
  return fixed.replace(/([a-z])([A-Z])/g, '$1 $2');
}

function parseTransformation(anchorId) {
  const block = extractBlock(html, anchorId, 2);
  const nameEn = anchorIdToDisplayName(anchorId);
  const slug = `gh-transformation-${slugify(nameEn)}`;

  const becomingId = block.match(/<h3[^>]*\sid="BecomingAn?([^"]+)"[^>]*>/i)?.[1];
  const becomingBlock = becomingId
    ? extractBlock(block, `BecomingAn${becomingId}`, 3) ||
      extractBlock(block, `BecomingA${becomingId}`, 3)
    : '';
  const becoming = extractParagraphs(becomingBlock).join('\n\n');

  const stages = parseStages(block, nameEn);
  const appendices = parseAppendices(block);

  const fullText = stripTags(block);

  return {
    slug,
    anchorId,
    nameEn,
    namePt: TRANSFORMATION_NAME_PT[nameEn] ?? nameEn,
    becoming,
    stages,
    appendices,
    boonCount: stages.reduce((n, s) => n + s.boons.length, 0),
    flawCount: stages.reduce((n, s) => n + s.flaws.length, 0),
    appendixCount: appendices.length,
    actionEconomy: detectActionEconomy(fullText),
  };
}

const transformations = TRANSFORMATION_TYPES.map((id) =>
  parseTransformation(id),
).filter((t) => t.stages.length > 0);

const output = {
  source: {
    editionSlug: 'grim-hollow-players-guide-2024-en',
    citationSlug: 'grim-hollow-players-guide-2024-en:chapter-6-transformations',
    book: "Grim Hollow: Player's Guide",
    chapter: 6,
    chapterTitle: 'Transformations',
    htmlFile: path.basename(htmlPath),
  },
  extractedAt: new Date().toISOString(),
  transformationCount: transformations.length,
  transformations,
};

fs.writeFileSync(outPath, `${JSON.stringify(output, null, 2)}\n`, 'utf8');
console.log(`Wrote ${outPath}`);
console.log(`Transformations: ${transformations.length}`);
for (const t of transformations) {
  console.log(
    `  ${t.nameEn}: ${t.stages.length} stages, ${t.boonCount} boons, ${t.flawCount} flaws, ${t.appendixCount} appendices`,
  );
}
