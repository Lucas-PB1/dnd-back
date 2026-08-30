/**
 * Extrai Cap. 6 (Transformations) do Grim Hollow Player's Guide.
 * Uso: node scripts/extract-ghpg-cap6.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import {
  anchorToSlug,
  detectActionEconomy,
  extractBlock,
  extractParagraphs,
  findGrimChapterHtml,
  slugify,
  stripTags,
} from './lib/ghpg-html-utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const grimDir = path.join(apiRoot, 'docs/source/new/grim');
const outPath = path.join(apiRoot, 'docs/source/ghpg-cap6-transformations-extract.json');

const htmlPath = findGrimChapterHtml(grimDir, 6);
if (!htmlPath) {
  console.error('HTML Cap. 6 GHPG não encontrado em docs/source/new/grim');
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

function parseBoonsAndFlaws(stageBlock) {
  const boons = [];
  const flaws = [];

  for (const m of stageBlock.matchAll(
    /<h5[^>]*\sid="([^"]+)"[^>]*>([\s\S]*?)<\/h5>\s*([\s\S]*?)(?=<h5|<h4|<h3|<h2|<hr|$)/gi,
  )) {
    const anchorId = m[1];
    const body = m[3];
    const label = stripTags(m[2] || anchorId);
    const text = extractParagraphs(body).join('\n\n');
    const entry = {
      anchorId,
      name: label,
      description: text,
      actionEconomy: detectActionEconomy(text),
    };
    if (/flaw/i.test(anchorId) || /flaw/i.test(label)) flaws.push(entry);
    else boons.push(entry);
  }

  return { boons, flaws };
}

function parseStages(typeBlock, typeName) {
  const stages = [];

  for (const m of typeBlock.matchAll(/<h4[^>]*\sid="([^"]*Stage(\d+))"[^>]*>[\s\S]*?<\/h4>\s*([^<]*)/gi)) {
    const anchorId = m[1];
    const stage = Number.parseInt(m[2], 10);
    const stageBlock = extractBlock(typeBlock, anchorId, 4);
    const { boons, flaws } = parseBoonsAndFlaws(stageBlock);
    const bodyText = extractParagraphs(stageBlock).join('\n\n');
    stages.push({
      stage,
      anchorId,
      title: stripTags(m[3]) || `${typeName} Stage ${stage}`,
      summary: bodyText.split('\n\n')[0] ?? '',
      body: bodyText,
      boons,
      flaws,
      actionEconomy: detectActionEconomy(bodyText),
    });
  }

  return stages.sort((a, b) => a.stage - b.stage);
}

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
    ? extractBlock(block, `BecomingAn${becomingId}`, 3) || extractBlock(block, `BecomingA${becomingId}`, 3)
    : '';
  const becoming = extractParagraphs(becomingBlock).join('\n\n');

  const stagesBlockMatch = block.match(/<h3[^>]*id="[^"]*Stages"[^>]*>/i);
  const stages = parseStages(block, nameEn);

  const fullText = stripTags(block);

  return {
    slug,
    anchorId,
    nameEn,
    namePt: TRANSFORMATION_NAME_PT[nameEn] ?? nameEn,
    becoming,
    stages,
    boonCount: stages.reduce((n, s) => n + s.boons.length, 0),
    flawCount: stages.reduce((n, s) => n + s.flaws.length, 0),
    actionEconomy: detectActionEconomy(fullText),
  };
}

const transformations = TRANSFORMATION_TYPES.map((id) => parseTransformation(id)).filter((t) => t.stages.length > 0);

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
  console.log(`  ${t.nameEn}: ${t.stages.length} stages, ${t.boonCount} boons, ${t.flawCount} flaws`);
}
