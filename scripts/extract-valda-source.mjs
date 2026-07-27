/**
 * Extrai conteúdo estruturado do page.html do Valda Player Pack (D&D Beyond).
 * Uso: node scripts/extract-valda-source.mjs
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');
const sourceDir = path.join(root, 'docs/sources/valda-spire-of-secrets');
const htmlPath = path.join(sourceDir, 'page.html');
const outJson = path.join(sourceDir, 'extracted.json');
const outMd = path.join(sourceDir, 'INVENTORY.md');

function stripTags(html) {
  return html
    .replace(/<br\s*\/?>/gi, '\n')
    .replace(/<\/p>/gi, '\n\n')
    .replace(/<\/(h[1-6]|li|tr)>/gi, '\n')
    .replace(/<[^>]+>/g, '')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/\u00a0/g, ' ')
    .replace(/[ \t]+\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function slugify(text) {
  return text
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '')
    .replace(/-+/g, '-');
}

function parseLevelFromTitle(title) {
  const m = title.match(/^Level\s+(\d+)\s*:\s*(.+)$/i);
  if (!m) return null;
  return { level: Number(m[1]), name: m[2].trim() };
}

function parseClassSubclass(title) {
  const m = title.match(/^([^:]+):\s*(.+)$/);
  if (!m) return null;
  return {
    className: m[1].trim(),
    subclassName: m[2].trim(),
  };
}

const CLASS_SLUG = {
  Barbarian: 'barbarian',
  Fighter: 'fighter',
  Monk: 'monk',
  Paladin: 'paladin',
  Rogue: 'rogue',
  Warlock: 'warlock',
};

const html = fs.readFileSync(htmlPath, 'utf8');
const contentMatch = html.match(
  /<div class="p-article-content[^"]*"[^>]*>([\s\S]*?)<\/div>\s*(?:<\/article>|<!--)/i,
);
if (!contentMatch) {
  console.error('Could not find p-article-content');
  process.exit(1);
}

const content = contentMatch[1];
const headingRe =
  /<h([1-4])([^>]*)>([\s\S]*?)<\/h\1>/gi;
const parts = [];
let lastIndex = 0;
let match;
const headingMatches = [];

while ((match = headingRe.exec(content)) !== null) {
  headingMatches.push({
    level: Number(match[1]),
    attrs: match[2],
    inner: match[3],
    index: match.index,
    end: match.index + match[0].length,
  });
}

for (let i = 0; i < headingMatches.length; i += 1) {
  const h = headingMatches[i];
  const idMatch = h.attrs.match(/\bid="([^"]+)"/);
  const title = stripTags(h.inner);
  const bodyHtml = content.slice(
    h.end,
    i + 1 < headingMatches.length ? headingMatches[i + 1].index : content.length,
  );
  parts.push({
    level: h.level,
    id: idMatch?.[1] ?? slugify(title),
    title,
    body: stripTags(bodyHtml),
  });
}

const inventory = {
  edition: {
    slug: 'valda-spire-2024-en',
    label: 'Valda Spire 2024 EN',
    book: "Valda's Spire of Secrets: Player Pack",
    language: 'en',
    notes: 'Mage Hand Press — Player Pack on D&D Beyond (2024 rules)',
  },
  citation: {
    slug: 'valda-spire-2024-en:player-pack',
    chapter: 1,
    chapterTitle: "Valda's Spire of Secrets: Player Pack",
  },
  subclasses: [],
  species: [],
  feats: [],
  spells: [],
  magicItems: [],
};

let section = null;
let currentSubclass = null;
let currentSpecies = null;
let currentFeat = null;
let currentSpell = null;
let currentItem = null;

for (const part of parts) {
  if (part.level === 2) {
    const key = part.id.toLowerCase();
    if (key === 'subclasses') section = 'subclasses';
    else if (key === 'species') section = 'species';
    else if (key === 'feats') section = 'feats';
    else if (key === 'spells') section = 'spells';
    else if (key === 'magicitems') section = 'magicItems';
    else if (key === 'credits') section = 'credits';
    else section = null;
    currentSubclass = null;
    currentSpecies = null;
    currentFeat = null;
    currentSpell = null;
    currentItem = null;
    continue;
  }

  if (section === 'subclasses' && part.level === 3) {
    const parsed = parseClassSubclass(part.title);
    if (!parsed) continue;
    const classSlug = CLASS_SLUG[parsed.className];
    if (!classSlug) {
      console.warn('Unknown class:', parsed.className);
      continue;
    }
    const paragraphs = part.body.split(/\n\n+/).filter(Boolean);
    const tagline = paragraphs[0]?.startsWith('Be ') || paragraphs[0]?.startsWith('Survive') || paragraphs[0]?.startsWith('Fight') || paragraphs[0]?.match(/^[A-Z].{0,80}$/)
      ? paragraphs[0].replace(/^\*|^\*/g, '').replace(/\*$/g, '')
      : null;
    // tagline is usually italic first line
    const italicLine = paragraphs.find((p) => p.length < 80) ?? null;
    currentSubclass = {
      slug: slugify(parsed.subclassName),
      classSlug,
      name: parsed.subclassName,
      tagline: italicLine,
      summary: paragraphs.slice(italicLine ? 1 : 0, (italicLine ? 1 : 0) + 1).join(' ').slice(0, 280) || null,
      description: paragraphs.slice(italicLine ? 1 : 0).join('\n\n'),
      sourceAnchor: part.id,
      features: [],
    };
    inventory.subclasses.push(currentSubclass);
    continue;
  }

  if (section === 'subclasses' && part.level === 4 && currentSubclass) {
    const lvl = parseLevelFromTitle(part.title);
    currentSubclass.features.push({
      level: lvl?.level ?? 3,
      name: lvl?.name ?? part.title,
      description: part.body,
      sourceAnchor: part.id,
    });
    continue;
  }

  if (section === 'species' && part.level === 3) {
    const paragraphs = part.body.split(/\n\n+/).filter(Boolean);
    currentSpecies = {
      slug: slugify(part.title),
      name: part.title,
      description: part.body,
      traits: [],
      sourceAnchor: part.id,
      // filled later from trait blocks / first lines if present
      creatureType: null,
      size: null,
      speed: null,
    };
    // Heuristics from common Beyond layout lines
    for (const p of paragraphs.slice(0, 12)) {
      const type = p.match(/^Creature Type[:\s]+(.+)/i);
      const size = p.match(/^Size[:\s]+(.+)/i);
      const speed = p.match(/^Speed[:\s]+(.+)/i);
      if (type) currentSpecies.creatureType = type[1].trim();
      if (size) currentSpecies.size = size[1].trim();
      if (speed) currentSpecies.speed = speed[1].trim();
    }
    inventory.species.push(currentSpecies);
    continue;
  }

  if (section === 'species' && part.level === 4 && currentSpecies) {
    currentSpecies.traits.push({
      name: part.title,
      description: part.body,
      sourceAnchor: part.id,
    });
    continue;
  }

  if (section === 'feats' && part.level === 3) {
    currentFeat = {
      slug: slugify(part.title),
      name: part.title,
      description: part.body,
      benefits: [],
      sourceAnchor: part.id,
    };
    inventory.feats.push(currentFeat);
    continue;
  }

  if (section === 'feats' && part.level === 4 && currentFeat) {
    currentFeat.benefits.push({
      name: part.title,
      description: part.body,
      sourceAnchor: part.id,
    });
    continue;
  }

  if (section === 'spells' && (part.level === 3 || part.level === 4)) {
    // Spells may be h3 or h4 depending on school grouping
    if (/chronomancy|school|spell descriptions/i.test(part.title)) {
      continue;
    }
    const name = part.title.replace(/\s*\([^)]*\)\s*$/, '').trim();
    const levelFromTitle = part.title.match(/\(([^)]+)\)/);
    const levelFromBody = part.body.match(
      /^(Cantrip|\d+(?:st|nd|rd|th)[-\s]level [A-Za-z]+)/i,
    );
    currentSpell = {
      slug: slugify(name),
      name,
      levelLabel: levelFromTitle?.[1] ?? levelFromBody?.[1] ?? null,
      description: part.body,
      sourceAnchor: part.id,
    };
    inventory.spells.push(currentSpell);
    continue;
  }

  if (section === 'magicItems' && part.level === 3) {
    currentItem = {
      slug: slugify(part.title),
      name: part.title,
      description: part.body,
      sourceAnchor: part.id,
    };
    inventory.magicItems.push(currentItem);
  }
}

// Post-process: promote General Feats h4 → feats
const flattenedFeats = [];
for (const feat of inventory.feats) {
  if (/^general feats$/i.test(feat.name) && feat.benefits.length > 0) {
    for (const benefit of feat.benefits) {
      flattenedFeats.push({
        slug: slugify(benefit.name),
        name: benefit.name,
        description: benefit.description,
        benefits: [],
        sourceAnchor: benefit.sourceAnchor,
        categoryHint: 'general',
      });
    }
  } else {
    flattenedFeats.push(feat);
  }
}
inventory.feats = flattenedFeats;

// Post-process: fill species type/size/speed from "* Traits" blocks
for (const species of inventory.species) {
  const traitsBlock = species.traits.find((t) => /traits$/i.test(t.name));
  const blob = `${species.description}\n${traitsBlock?.description ?? ''}`;
  const type = blob.match(/Creature Type:\s*([^\n]+)/i);
  const size = blob.match(/Size:\s*([^\n]+)/i);
  const speed = blob.match(/Speed:\s*([^\n]+)/i);
  if (type) species.creatureType = type[1].trim();
  if (size) species.size = size[1].trim();
  if (speed) species.speed = speed[1].trim();
}

const summary = {
  subclasses: inventory.subclasses.length,
  subclassFeatures: inventory.subclasses.reduce((n, s) => n + s.features.length, 0),
  species: inventory.species.length,
  speciesTraits: inventory.species.reduce((n, s) => n + s.traits.length, 0),
  feats: inventory.feats.length,
  spells: inventory.spells.length,
  magicItems: inventory.magicItems.length,
};

fs.writeFileSync(outJson, JSON.stringify({ summary, ...inventory }, null, 2), 'utf8');

const md = [
  '# Valda Player Pack — inventário extraído',
  '',
  `Gerado em ${new Date().toISOString().slice(0, 10)} a partir de \`page.html\`.`,
  '',
  '## Contagens',
  '',
  `| Tipo | Qtd |`,
  `|---|---|`,
  `| Subclasses | ${summary.subclasses} |`,
  `| Features de subclasse | ${summary.subclassFeatures} |`,
  `| Espécies | ${summary.species} |`,
  `| Traços de espécie | ${summary.speciesTraits} |`,
  `| Feats | ${summary.feats} |`,
  `| Magias | ${summary.spells} |`,
  `| Itens mágicos | ${summary.magicItems} |`,
  '',
  '## Subclasses',
  '',
  ...inventory.subclasses.flatMap((s) => [
    `### ${s.classSlug} / ${s.name} (\`${s.slug}\`)`,
    '',
    ...(s.tagline ? [`*${s.tagline}*`, ''] : []),
    ...s.features.map((f) => `- **N${f.level}** ${f.name}`),
    '',
  ]),
  '## Espécies',
  '',
  ...inventory.species.flatMap((s) => [
    `### ${s.name} (\`${s.slug}\`)`,
    '',
    `- Tipo: ${s.creatureType ?? '?'}`,
    `- Tamanho: ${s.size ?? '?'}`,
    `- Deslocamento: ${s.speed ?? '?'}`,
    ...s.traits.map((t) => `- Traço: **${t.name}**`),
    '',
  ]),
  '## Feats',
  '',
  ...inventory.feats.map((f) => `- **${f.name}** (\`${f.slug}\`)`),
  '',
  '## Magias',
  '',
  ...inventory.spells.map(
    (s) => `- **${s.name}** (\`${s.slug}\`)${s.levelLabel ? ` — ${s.levelLabel}` : ''}`,
  ),
  '',
  '## Itens mágicos',
  '',
  ...inventory.magicItems.map((i) => `- **${i.name}** (\`${i.slug}\`)`),
  '',
  'Arquivo completo: [`extracted.json`](extracted.json)',
].join('\n');

fs.writeFileSync(outMd, md, 'utf8');

console.log(JSON.stringify(summary, null, 2));
console.log('Wrote', path.relative(root, outJson));
console.log('Wrote', path.relative(root, outMd));
