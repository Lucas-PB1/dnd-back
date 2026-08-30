/**
 * Extrai Cap. 4 (Character Feats) do Grim Hollow Player's Guide.
 * Uso: node scripts/extract-ghpg-cap4.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import {
  anchorToSlug,
  detectActionEconomy,
  extractBlock,
  findGrimChapterHtml,
  parseFeatBenefits,
  stripTags,
} from './lib/ghpg-html-utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const grimDir = path.join(apiRoot, 'docs/source/new/grim');
const outPath = path.join(apiRoot, 'docs/source/ghpg-cap4-feats-extract.json');

const htmlPath = findGrimChapterHtml(grimDir, 4);
if (!htmlPath) {
  console.error('HTML Cap. 4 GHPG não encontrado em docs/source/new/grim');
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');

const SECTIONS = [
  { headingId: 'OriginFeats', category: 'origin', label: 'Origin Feats' },
  { headingId: 'GeneralFeats', category: 'general', label: 'General Feats' },
  { headingId: 'FightingStyleFeats', category: 'fighting-style', label: 'Fighting Style Feats' },
  { headingId: 'EpicBoonFeats', category: 'epic-boon', label: 'Epic Boon Feats' },
];

function parsePrerequisite(block) {
  const m = block.match(/<p[^>]*><em>Prerequisite:\s*([^<]+)<\/em><\/p>/i);
  return m ? stripTags(m[1]) : null;
}

function parseFeat(anchorId, nameEn, category) {
  const block = extractBlock(html, anchorId, 3);
  const { intro, benefits } = parseFeatBenefits(block);
  const prerequisite = parsePrerequisite(block);
  const fullText = stripTags(block);
  const repeatable = /repeatable/i.test(fullText);

  const actionEconomy = detectActionEconomy(fullText);
  const benefitsWithEconomy = benefits.map((b) => ({
    ...b,
    actionEconomy: b.actionEconomy.length ? b.actionEconomy : detectActionEconomy(b.description),
  }));

  return {
    slug: anchorToSlug(anchorId),
    anchorId,
    nameEn,
    category,
    repeatable,
    prerequisite,
    intro,
    benefits: benefitsWithEconomy,
    actionEconomy,
    description: [intro, ...benefitsWithEconomy.map((b) => `${b.name}. ${b.description}`)].filter(Boolean).join('\n\n'),
  };
}

const feats = [];
for (const section of SECTIONS) {
  const sectionBlock = extractBlock(html, section.headingId, 2);
  for (const m of sectionBlock.matchAll(/<h3[^>]*\sid="([^"]+)"[^>]*>([\s\S]*?)<\/h3>/gi)) {
    const anchorId = m[1];
    const nameEn = stripTags(m[2]);
    if (!nameEn) continue;
    feats.push(parseFeat(anchorId, nameEn, section.category));
  }
}

const output = {
  source: {
    editionSlug: 'grim-hollow-players-guide-2024-en',
    citationSlug: 'grim-hollow-players-guide-2024-en:chapter-4-character-feats',
    book: "Grim Hollow: Player's Guide",
    chapter: 4,
    chapterTitle: 'Character Feats',
    htmlFile: path.basename(htmlPath),
  },
  extractedAt: new Date().toISOString(),
  featCount: feats.length,
  byCategory: Object.fromEntries(
    SECTIONS.map((s) => [s.category, feats.filter((f) => f.category === s.category).length]),
  ),
  feats,
};

fs.writeFileSync(outPath, `${JSON.stringify(output, null, 2)}\n`, 'utf8');
console.log(`Wrote ${outPath}`);
console.log(`Feats: ${feats.length}`, output.byCategory);
