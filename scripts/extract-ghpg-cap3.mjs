/**
 * Extrai Cap. 3 (Backgrounds PHB 2024 style) do Grim Hollow Player's Guide.
 * Uso: node scripts/extract-ghpg-cap3.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import {
  anchorToSlug,
  decodeHtml,
  detectActionEconomy,
  extractBlock,
  extractParagraphs,
  findGrimChapterHtml,
  parseAbilityScores,
  parseMechanicalFields,
  parseCondensedGroup,
  parseEquipmentOption,
  DDB_ITEM_SLUG_MAP,
  parseFeatHref,
  parseSkillLink,
  slugify,
  stripTags,
} from './lib/ghpg-html-utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const grimDir = path.join(apiRoot, 'docs/source/new/grim');
const outPath = path.join(apiRoot, 'docs/source/ghpg-cap3-backgrounds-extract.json');

const htmlPath = findGrimChapterHtml(grimDir, 3);
if (!htmlPath) {
  console.error('HTML Cap. 3 GHPG não encontrado em docs/source/new/grim');
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');

const BACKGROUND_NAME_PT = {
  'Agent of the Augustine': 'Agente da Augustine',
  Antiquarian: 'Antiquário',
  'Beast Hunter': 'Caçador de Feras',
  Beggar: 'Mendigo',
  'Chapter Knight': 'Cavaleiro de Capítulo',
  Courtier: 'Cortesão',
  'Disgraced Raider': 'Saqueador Desonrado',
  Envoy: 'Enviado',
  Executioner: 'Carrasco',
  Explorer: 'Explorador',
  Exterminator: 'Exterminador',
  'Fey-Blessed': 'Abençoado pelas Fadas',
  'Free Swords Mercenary': 'Mercenário das Espadas Livres',
  Heretic: 'Herege',
  'Inquisitor of the Faithful': 'Inquisidor dos Fiéis',
  'Lapsed Inquisitor': 'Inquisidor Desviado',
  'One of the Taken': 'Um dos Tomados',
  Physician: 'Médico',
  Pioneer: 'Pioneiro',
  'Pit Fighter': 'Lutador de Arena',
  'Pox-Touched': 'Tocado pela Peste',
  Prisoner: 'Prisioneiro',
  'Released Thrall': 'Servo Libertado',
  'Scion of the Thaumaturge': 'Herdeiro do Taumaturgo',
  'Syndicate Smuggler': 'Contrabandista do Sindicato',
};

function parseToolProficiency(valueHtml) {
  const text = stripTags(valueHtml);
  if (/carpenter/i.test(text) && /mason/i.test(text)) {
    return {
      kind: 'choice',
      description: text,
      itemSlug: null,
      toolCategorySlug: 'artisan',
      choiceItemSlugs: ['ferramentas-de-carpinteiro', 'ferramentas-de-pedreiro'],
    };
  }
  if (/gaming set/i.test(text)) {
    return {
      kind: 'choice',
      description: text,
      itemSlug: null,
      toolCategorySlug: null,
      choiceItemSlugs: [
        'conjunto-de-dados',
        'xadrez-do-dragao',
        'baralho',
        'ante-dos-tres-dragoes',
      ],
    };
  }
  const link = valueHtml.match(/href="[^"]*\/equipment\/\d+-([^"?]+)"/i);
  if (link) {
    return {
      kind: 'fixed',
      description: text,
      itemSlug: DDB_ITEM_SLUG_MAP[link[1]] ?? null,
      ddbSlug: link[1],
      toolCategorySlug: null,
    };
  }
  if (/musical instrument/i.test(text) && /artisan/i.test(text)) {
    return {
      kind: 'choice',
      description: text,
      itemSlug: null,
      toolCategorySlug: null,
      choiceOptions: ['instrument', 'artisan'],
    };
  }
  if (/musical instrument/i.test(text)) {
    return {
      kind: 'choice',
      description: text,
      itemSlug: null,
      toolCategorySlug: 'instrument',
    };
  }
  if (/artisan/i.test(text)) {
    return {
      kind: 'choice',
      description: text,
      itemSlug: null,
      toolCategorySlug: 'artisan',
    };
  }
  return { kind: 'text', description: text, itemSlug: null, toolCategorySlug: null };
}

function parseBackground(anchorId, nameEn) {
  const block = extractBlock(html, anchorId, 3);
  const fields = parseMechanicalFields(block);
  const slug = `gh-${slugify(nameEn)}`;

  const abilitySlugs = fields['Ability Scores']
    ? parseAbilityScores(stripTags(fields['Ability Scores']))
    : [];

  let feat = null;
  if (fields.Feat) {
    const featLink = fields.Feat.match(/href="([^"]+)"[^>]*>([^<]*)/i);
    if (featLink) {
      feat = parseFeatHref(featLink[1], stripTags(featLink[2]));
    }
  }

  const skillSlugs = [];
  if (fields['Skill Proficiencies']) {
    for (const sm of fields['Skill Proficiencies'].matchAll(/<a[^>]*class="[^"]*skill-tooltip[^"]*"[^>]*>([^<]+)<\/a>/gi)) {
      const skill = parseSkillLink(`>${sm[1]}<`);
      if (skill) skillSlugs.push(skill);
    }
    if (!skillSlugs.length) {
      for (const part of stripTags(fields['Skill Proficiencies']).split(' and ')) {
        const skill = parseSkillLink(`>${part.trim()}<`);
        if (skill) skillSlugs.push(skill);
      }
    }
  }

  const toolProficiency = fields['Tool Proficiency']
    ? parseToolProficiency(fields['Tool Proficiency'])
    : null;

  const equipment = fields.Equipment ? parseEquipmentOption(fields.Equipment) : null;

  const loreStart = block.indexOf('</div>');
  const loreBlock = loreStart >= 0 ? block.slice(loreStart) : block;
  const loreParagraphs = extractParagraphs(loreBlock).filter(
    (p) =>
      !p.startsWith('Ability Scores') &&
      !p.startsWith('Feat:') &&
      !p.startsWith('Equipment:'),
  );

  const fullText = [stripTags(block), ...loreParagraphs].join(' ');

  return {
    slug,
    anchorId,
    nameEn,
    namePt: BACKGROUND_NAME_PT[nameEn] ?? nameEn,
    abilitySlugs,
    feat,
    skillSlugs,
    toolProficiency,
    equipment,
    loreParagraphs,
    description: loreParagraphs.join('\n\n'),
    actionEconomy: detectActionEconomy(fullText),
  };
}

const sectionStart = html.search(/<h2[^>]*id="GrimHollowBackgrounds"/i);
const sectionEnd = html.search(/<div id="comp-next-nav"/i);
const section = html.slice(sectionStart, sectionEnd > sectionStart ? sectionEnd : undefined);

const backgrounds = [];
for (const m of section.matchAll(/<h3[^>]*\sid="([^"]+)"[^>]*>([\s\S]*?)<\/h3>/gi)) {
  const anchorId = m[1];
  const nameEn = stripTags(m[2]);
  if (!nameEn || anchorId === 'GrimHollowBackgrounds') continue;
  backgrounds.push(parseBackground(anchorId, nameEn));
}

const sidebarMatch = html.match(
  /<aside class="grim--rules-sidebar" id="BackgroundsandAbilityScoresAside"[\s\S]*?<\/aside>/i,
);
const optionalRule = sidebarMatch
  ? {
      id: 'BackgroundsandAbilityScoresAside',
      title: 'Backgrounds and Ability Scores',
      text: stripTags(sidebarMatch[0]),
      heritageAbilityScoresUnlimited: true,
      chapterReference: 'chapter-1-heritages-traits',
    }
  : null;

const output = {
  source: {
    editionSlug: 'grim-hollow-players-guide-2024-en',
    citationSlug: 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds',
    book: "Grim Hollow: Player's Guide",
    chapter: 3,
    chapterTitle: 'Backgrounds',
    htmlFile: path.basename(htmlPath),
  },
  extractedAt: new Date().toISOString(),
  backgroundCount: backgrounds.length,
  optionalRule,
  backgrounds,
};

fs.writeFileSync(outPath, `${JSON.stringify(output, null, 2)}\n`, 'utf8');
console.log(`Wrote ${outPath}`);
console.log(`Backgrounds: ${backgrounds.length}`);
console.log(
  `Unique feats referenced: ${[...new Set(backgrounds.map((b) => b.feat?.slug).filter(Boolean))].length}`,
);
