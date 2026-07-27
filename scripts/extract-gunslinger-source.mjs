/**
 * Extrai conteúdo estruturado do page.html do Gunslinger (D&D Beyond).
 * Uso: node scripts/extract-gunslinger-source.mjs
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');
const sourceDir = path.join(root, 'docs/sources/valda-gunslinger');
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

if (!fs.existsSync(htmlPath)) {
  console.error('Missing', htmlPath, '— run clean-gunslinger-source.mjs first');
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');
const contentMatch = html.match(
  /<div class="p-article-content[^"]*"[^>]*>([\s\S]*?)<\/div>\s*(?:<\/article>|<!--)/i,
);
const content = contentMatch?.[1] ?? html;

const headingRe = /<h([1-4])([^>]*)>([\s\S]*?)<\/h\1>/gi;
const headingMatches = [];
let match;
while ((match = headingRe.exec(content)) !== null) {
  headingMatches.push({
    level: Number(match[1]),
    attrs: match[2],
    inner: match[3],
    index: match.index,
    end: match.index + match[0].length,
  });
}

const parts = [];
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
    book: "Valda's Spire of Secrets: The Gunslinger Class",
    language: 'en',
    notes: 'Mage Hand Press — Gunslinger Class on D&D Beyond (2024 rules)',
  },
  citation: {
    slug: 'valda-spire-2024-en:gunslinger',
    chapter: 2,
    chapterTitle: "Valda's Spire of Secrets: The Gunslinger Class",
  },
  class: null,
  features: [],
  maneuvers: [],
  subclasses: [],
  feats: [],
  spells: [],
  firearmEras: [],
  weaponProperties: [],
  masteryProperties: [],
  weapons: [],
  ammunition: [],
  headings: parts.map((p) => ({ level: p.level, id: p.id, title: p.title })),
};

function parseLevelFeature(title) {
  const m = title.match(/^Level\s+(\d+)\s*:\s*(.+)$/i);
  if (!m) return null;
  return { level: Number(m[1]), name: m[2].trim() };
}

function parseClassSubclass(title) {
  const m = title.match(/^([^:]+):\s*(.+)$/);
  if (!m) return null;
  return { className: m[1].trim(), subclassName: m[2].trim() };
}

let section = null;
let currentSubclass = null;

for (const part of parts) {
  const id = part.id.toLowerCase();
  const title = part.title;

  // Section switches (H2 or H3 structural)
  if (part.level <= 3) {
    if (/^gunslinger class features$/i.test(title) || id === 'gunslingerclassfeatures') {
      section = 'features';
      continue;
    }
    if (/^maneuver options$/i.test(title) || id === 'maneuveroptions') {
      section = 'maneuvers';
      continue;
    }
    if (
      /^gunslinger subclasses$/i.test(title) ||
      id === 'gunslingersubclasses' ||
      id === 'gunslingersubclassestable'
    ) {
      section = 'subclasses';
      currentSubclass = null;
      continue;
    }
    if (/^core gunslinger traits$/i.test(title) || id === 'coregunslingertraits') {
      section = 'traits';
      if (!inventory.class) {
        inventory.class = {
          slug: 'gunslinger',
          name: 'Gunslinger',
          tagline: null,
          summary: null,
          description: '',
          sourceAnchor: part.id,
        };
      }
      inventory.class.coreTraits = part.body;
      continue;
    }
    // End of class/subclass content — firearms, feats, spells, etc.
    if (part.level === 2 && /^firearms$/i.test(title)) {
      section = 'firearms';
      currentSubclass = null;
      continue;
    }
    if (part.level === 2 && /^new feats$/i.test(title)) {
      section = 'feats';
      currentSubclass = null;
      continue;
    }
    if (part.level === 2 && /^new spells$/i.test(title)) {
      section = 'spells';
      currentSubclass = null;
      continue;
    }
    if (/credit/i.test(title)) {
      section = 'credits';
      continue;
    }
  }

  if (part.level === 2 && /^gunslinger$/i.test(title)) {
    inventory.class = {
      slug: 'gunslinger',
      name: 'Gunslinger',
      tagline: null,
      summary: null,
      description: part.body,
      sourceAnchor: part.id,
    };
    section = 'lore';
    continue;
  }

  if (part.level === 3 && section === 'lore') {
    if (inventory.class && part.body) {
      inventory.class.description = [
        inventory.class.description,
        `## ${title}\n\n${part.body}`,
      ]
        .filter(Boolean)
        .join('\n\n');
    }
    continue;
  }

  if (section === 'features' && part.level === 4) {
    if (/^gunslinger features$/i.test(title)) continue; // table
    const lvl = parseLevelFeature(title);
    if (!lvl) continue;
    inventory.features.push({
      level: lvl.level,
      name: lvl.name,
      description: part.body,
      sourceAnchor: part.id,
    });
    continue;
  }

  if (section === 'maneuvers' && part.level === 4) {
    inventory.maneuvers.push({
      slug: slugify(title),
      name: title,
      description: part.body,
      sourceAnchor: part.id,
    });
    continue;
  }

  if (section === 'subclasses' && part.level === 3) {
    if (/^gunslinger subclasses$/i.test(title)) continue;
    const ALLOWED = new Set([
      'deadeye',
      'high-roller',
      'secret-agent',
      'spellslinger',
      'trick-shot',
      'white-hat',
    ]);
    const parsed = parseClassSubclass(title);
    const name = parsed?.subclassName ?? title;
    const slug = slugify(name);
    if (!ALLOWED.has(slug)) continue;
    currentSubclass = {
      slug,
      classSlug: 'gunslinger',
      name,
      tagline: null,
      summary: null,
      description: part.body,
      sourceAnchor: part.id,
      features: [],
    };
    const paragraphs = part.body.split(/\n\n+/).filter(Boolean);
    const short = paragraphs.find((p) => p.length < 100 && p.length > 8);
    if (short) currentSubclass.tagline = short;
    currentSubclass.summary =
      paragraphs.slice(short ? 1 : 0, short ? 2 : 1).join(' ').slice(0, 280) ||
      null;
    inventory.subclasses.push(currentSubclass);
    continue;
  }

  if (section === 'subclasses' && part.level === 4 && currentSubclass) {
    const lvl = parseLevelFeature(title);
    currentSubclass.features.push({
      level: lvl?.level ?? 3,
      name: lvl?.name ?? title,
      description: part.body,
      sourceAnchor: part.id,
    });
  }

  if (section === 'firearms' && part.level === 3) {
    if (/firearm eras/i.test(title)) {
      inventory.firearmEras.push({
        name: title,
        description: part.body,
        sourceAnchor: part.id,
      });
    } else if (/weapon properties/i.test(title)) {
      // properties are H4 children
    } else if (/mastery properties/i.test(title)) {
      // mastery H4 children
    } else if (/weapon descriptions/i.test(title)) {
      // lore
    } else if (/firearm ammunition/i.test(title)) {
      inventory.ammunition.push({
        name: title,
        description: part.body,
        sourceAnchor: part.id,
      });
    }
    continue;
  }

  if (section === 'firearms' && part.level === 4) {
    if (/renaissance|industrial|modern/i.test(title) && /firearm/i.test(title)) {
      inventory.firearmEras.push({
        name: title,
        description: part.body,
        sourceAnchor: part.id,
      });
      continue;
    }
    // Property / mastery definition headings
    const cleanName = title.replace(/\*+$/, '').trim();
    if (
      /ammunition|finesse|firearm|heavy|light|range|recoil|reload|two-handed/i.test(
        cleanName,
      )
    ) {
      inventory.weaponProperties.push({
        slug: slugify(cleanName),
        name: cleanName,
        description: part.body,
        sourceAnchor: part.id,
      });
    } else if (
      /automatic|explode|push|sap|scatter|sighted|slow|vex/i.test(cleanName)
    ) {
      inventory.masteryProperties.push({
        slug: slugify(cleanName),
        name: cleanName,
        description: part.body,
        sourceAnchor: part.id,
      });
    }
    continue;
  }

  if (section === 'feats' && part.level === 3) {
    if (/^iron hero$/i.test(title)) continue; // already in Player Pack
    inventory.feats.push({
      slug: slugify(title),
      name: title,
      description: part.body,
      sourceAnchor: part.id,
    });
    continue;
  }

  if (section === 'spells' && (part.level === 3 || part.level === 4)) {
    if (/spell descriptions|credits/i.test(title)) continue;
    if (/^finger guns$/i.test(title)) continue; // already in Player Pack
    inventory.spells.push({
      slug: slugify(title),
      name: title,
      description: part.body,
      sourceAnchor: part.id,
    });
  }
}

// Heuristics from intro body for hit die / primary ability / etc.
const traits = inventory.class?.coreTraits ?? '';
const blob = [
  traits,
  inventory.class?.description ?? '',
  ...inventory.features.map((f) => f.description),
].join('\n');

function pick(re, source = blob) {
  const m = source.match(re);
  return m ? m[1].trim() : null;
}

const skillChoiceMatch = traits.match(
  /Skill Proficiencies\s*\n+Choose\s+(\d+):\s*([^\n]+)/i,
);
const skillChoiceCount = skillChoiceMatch ? Number(skillChoiceMatch[1]) : 2;
const skillNamesRaw = skillChoiceMatch?.[2] ?? '';
const skillNameToSlug = {
  Acrobatics: 'acrobatics',
  'Animal Handling': 'animal-handling',
  Athletics: 'athletics',
  Deception: 'deception',
  Insight: 'insight',
  Intimidation: 'intimidation',
  Perception: 'perception',
  Persuasion: 'persuasion',
  'Sleight of Hand': 'sleight-of-hand',
  Stealth: 'stealth',
  Stealth: 'stealth',
};
const skillSlugs = skillNamesRaw
  .replace(/\band\b/gi, ',')
  .split(',')
  .map((s) => s.trim())
  .filter(Boolean)
  .map((name) => skillNameToSlug[name])
  .filter(Boolean);

const abilityNameToSlug = {
  Strength: 'forca',
  Dexterity: 'destreza',
  Constitution: 'constituicao',
  Intelligence: 'inteligencia',
  Wisdom: 'sabedoria',
  Charisma: 'carisma',
};

const savesRaw =
  pick(/Saving Throw Proficiencies\s*\n+([^\n]+)/i, traits) ?? '';
const savingThrowSlugs = savesRaw
  .replace(/\band\b/gi, ',')
  .split(',')
  .map((s) => s.trim())
  .map((name) => abilityNameToSlug[name])
  .filter(Boolean);

const hitDieRaw =
  pick(/Hit Point Die\s*\n+(D\d+)/i, traits) ??
  pick(/Hit (?:Point )?Die[s]?:?\s*(d\d+)/i) ??
  'd8';
const hitDie = hitDieRaw.toLowerCase();

const primaryAbility =
  pick(/Primary Ability\s*\n+([^\n]+)/i, traits) ?? 'Dexterity';
const primaryAbilitySlug = abilityNameToSlug[primaryAbility] ?? 'destreza';

const meta = {
  hitDie,
  primaryAbility,
  primaryAbilitySlug,
  subclassUnlockLevel: 3,
  subclassLabel: 'Creed',
  skillChoiceCount,
  skillSlugs,
  savingThrowSlugs,
  armorCategories: ['light'],
  weaponProficiencies: ['armas-simples', 'armas-marciais'],
  weaponNote: 'Simple weapons and Martial Ranged weapons (mapped to simple+martial)',
  savingThrowsLabel: savesRaw || null,
  armor: pick(/Armor Training\s*\n+([^\n]+)/i, traits),
  weapons: pick(/Weapon Proficiencies\s*\n+([^\n]+)/i, traits),
  startingEquipment: pick(/Starting Equipment\s*\n+([^\n]+)/i, traits),
};

if (inventory.class) {
  const paras = (inventory.class.description || '').split(/\n\n+/).filter(Boolean);
  inventory.class.tagline =
    inventory.class.tagline ??
    paras.find((p) => p.length > 10 && p.length < 90) ??
    'Deadeye with firearms and deeds';
  inventory.class.summary =
    inventory.class.summary ??
    paras.find((p) => p.length >= 40)?.slice(0, 280) ??
    null;
}

const summary = {
  class: inventory.class ? 1 : 0,
  features: inventory.features.length,
  maneuvers: inventory.maneuvers.length,
  subclasses: inventory.subclasses.length,
  subclassFeatures: inventory.subclasses.reduce((n, s) => n + s.features.length, 0),
  feats: inventory.feats.length,
  spells: inventory.spells.length,
  weaponProperties: inventory.weaponProperties.length,
  masteryProperties: inventory.masteryProperties.length,
  firearmEras: inventory.firearmEras.length,
  headings: parts.length,
  meta,
};

fs.writeFileSync(
  outJson,
  JSON.stringify({ summary, ...inventory, meta }, null, 2),
  'utf8',
);

const md = [
  '# Gunslinger — inventário extraído',
  '',
  `Gerado em ${new Date().toISOString().slice(0, 10)} a partir de \`page.html\`.`,
  '',
  '## Contagens',
  '',
  `| Tipo | Qtd |`,
  `|---|---|`,
  `| Classe | ${summary.class} |`,
  `| Features | ${summary.features} |`,
  `| Maneuvers | ${summary.maneuvers} |`,
  `| Subclasses | ${summary.subclasses} |`,
  `| Features de subclasse | ${summary.subclassFeatures} |`,
  '',
  '## Meta',
  '',
  `- Hit die: ${meta.hitDie}`,
  `- Primary: ${meta.primaryAbility} (${meta.primaryAbilitySlug})`,
  `- Subclass unlock: ${meta.subclassUnlockLevel} (${meta.subclassLabel})`,
  `- Skills: ${meta.skillChoiceCount} — ${meta.skillSlugs.join(', ')}`,
  `- Saves: ${meta.savingThrowSlugs.join(', ') || '?'}`,
  `- Armor: ${meta.armor ?? '?'}`,
  `- Weapons: ${meta.weapons ?? '?'}`,
  `- Starting: ${meta.startingEquipment ?? '?'}`,
  '',
  '## Features',
  '',
  ...inventory.features.map((f) => `- **N${f.level}** ${f.name}`),
  '',
  '## Maneuvers',
  '',
  ...inventory.maneuvers.map((m) => `- **${m.name}** (\`${m.slug}\`)`),
  '',
  '## Subclasses',
  '',
  ...inventory.subclasses.flatMap((s) => [
    `### ${s.name} (\`${s.slug}\`)`,
    '',
    ...s.features.map((f) => `- **N${f.level}** ${f.name}`),
    '',
  ]),
  '## Feats',
  '',
  ...inventory.feats.map((f) => `- **${f.name}** (\`${f.slug}\`)`),
  '',
  '## Spells',
  '',
  ...inventory.spells.map((s) => `- **${s.name}** (\`${s.slug}\`)`),
  '',
  '## Weapon / mastery properties (from HTML)',
  '',
  ...inventory.weaponProperties.map((p) => `- prop **${p.name}**`),
  ...inventory.masteryProperties.map((p) => `- mastery **${p.name}**`),
  '',
  'Arquivo completo: [`extracted.json`](extracted.json)',
].join('\n');

fs.writeFileSync(outMd, md, 'utf8');

console.log(JSON.stringify(summary, null, 2));
console.log('Wrote', path.relative(root, outJson));
console.log('Wrote', path.relative(root, outMd));
