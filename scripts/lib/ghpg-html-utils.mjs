/**
 * Utilitários compartilhados para extração HTML do Grim Hollow Player's Guide.
 */
import fs from 'fs';
import path from 'path';

export function decodeHtml(value) {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&nbsp;/g, ' ');
}

export function stripTags(fragment) {
  return decodeHtml(fragment.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim());
}

export function slugify(name) {
  return name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

/** CamelCase anchor id → kebab slug (BloodHound → blood-hound). */
export function anchorToSlug(anchorId) {
  return slugify(
    anchorId
      .replace(/([a-z])([A-Z])/g, '$1 $2')
      .replace(/([A-Z]+)([A-Z][a-z])/g, '$1 $2'),
  );
}

export function extractBetween(htmlText, startRe, endRe) {
  const start = htmlText.search(startRe);
  if (start < 0) return '';
  const slice = htmlText.slice(start);
  const end = slice.search(endRe);
  return end < 0 ? slice : slice.slice(0, end);
}

/**
 * Extrai bloco HTML a partir de um heading com id conhecido até o próximo heading do mesmo nível ou superior.
 * @param {string} html
 * @param {string} headingId
 * @param {2 | 3 | 4 | 5} level
 */
export function extractBlock(html, headingId, level = 3) {
  const tag = `h${level}`;
  const startRe = new RegExp(`<${tag}[^>]*\\sid="${headingId}"`, 'i');
  const start = html.search(startRe);
  if (start < 0) return '';
  const after = html.slice(start + 1);
  const endRe = new RegExp(`<h[1-${level}][^>]*id="`, 'i');
  const end = after.search(endRe);
  return end < 0 ? html.slice(start) : html.slice(start, start + 1 + end);
}

export function findGrimChapterHtml(grimDir, chapterNumber) {
  if (!grimDir || !fs.existsSync(grimDir)) return undefined;
  const needle = `Chapter ${chapterNumber}`;
  return fs
    .readdirSync(grimDir)
    .filter((n) => n.includes(needle) && n.endsWith('.html'))
    .map((n) => path.join(grimDir, n))[0];
}

/** Cap. N GHPG: `docs/source/scrap` primeiro, depois `_scrapes/grim-hollow`. */
export function findGhpgChapterHtml(chapterNumber, ...dirs) {
  for (const dir of dirs) {
    const found = findGrimChapterHtml(dir, chapterNumber);
    if (found) return found;
  }
  return undefined;
}

/** @deprecated Use findGhpgChapterHtml(2, ...) */
export function findGhpgCap2Html(...dirs) {
  return findGhpgChapterHtml(2, ...dirs);
}

export function findGhpgCap5Html(...dirs) {
  return findGhpgChapterHtml(5, ...dirs);
}

export const ABILITY_SLUG_MAP = {
  Strength: 'forca',
  Dexterity: 'destreza',
  Constitution: 'constituicao',
  Intelligence: 'inteligencia',
  Wisdom: 'sabedoria',
  Charisma: 'carisma',
};

export const SKILL_SLUG_MAP = {
  Acrobatics: 'acrobatics',
  'Animal Handling': 'animal-handling',
  Arcana: 'arcana',
  Athletics: 'athletics',
  Deception: 'deception',
  History: 'history',
  Insight: 'insight',
  Intimidation: 'intimidation',
  Investigation: 'investigation',
  Medicine: 'medicine',
  Nature: 'nature',
  Perception: 'perception',
  Performance: 'performance',
  Persuasion: 'persuasion',
  Religion: 'religion',
  'Sleight of Hand': 'sleight-of-hand',
  Stealth: 'stealth',
  Survival: 'survival',
};

/** D&D Beyond equipment URL slug → phb_item.slug (PT). */
export const DDB_ITEM_SLUG_MAP = {
  'forgery-kit': 'kit-de-falsificacao',
  book: 'livro',
  'magnifying-glass': 'lupa',
  parchment: 'pergaminho',
  robe: 'tunica',
  dagger: 'dagger',
  'tinkers-tools': 'ferramentas-de-funileiro',
  spear: 'spear',
  'leatherworkers-tools': 'ferramentas-de-coureiro',
  'hunting-trap': 'armadilha-de-caca',
  'travelers-clothes': 'roupas-viagem',
  'disguise-kit': 'kit-de-disfarce',
  shield: 'shield',
  'fine-clothes': 'roupas-finas',
  'calligraphers-supplies': 'suprimentos-de-caligrafo',
  'navigators-tools': 'ferramentas-de-navegador',
  'smiths-tools': 'ferramentas-de-ferreiro',
  'poisoners-kit': 'kit-de-veneno',
  map: 'mapa',
  maps: 'mapa',
  'holy-symbol': 'simbolo-sagrado',
  'herbalism-kit': 'kit-de-herbalismo',
  'healers-kit': 'kit-de-curandeiro',
  'thieves-tools': 'ferramentas-de-ladrao',
  'woodcarvers-tools': 'ferramentas-de-carpinteiro',
  'cartographers-tools': 'ferramentas-de-cartografo',
  'carpenters-tools': 'ferramentas-de-carpinteiro',
  'masons-tools': 'ferramentas-de-pedreiro',
  mule: 'mula',
  cart: 'carroca',
  club: 'club',
  manacles: 'grilhoes',
  ink: 'tinta',
  chest: 'bau',
};

/** Nome exibido no HTML (EN) → phb_item.slug quando não há link DDB. */
export const NAME_ITEM_MAP = {
  "Forgery Kit": 'kit-de-falsificacao',
  "Tinker's Tools": 'ferramentas-de-funileiro',
  "Tinker’s Tools": 'ferramentas-de-funileiro',
  "Leatherworker's Tools": 'ferramentas-de-coureiro',
  "Leatherworker’s Tools": 'ferramentas-de-coureiro',
  "Navigator's Tools": 'ferramentas-de-navegador',
  "Navigator’s Tools": 'ferramentas-de-navegador',
  "Smith's Tools": 'ferramentas-de-ferreiro',
  "Smith’s Tools": 'ferramentas-de-ferreiro',
  "Poisoner's Kit": 'kit-de-veneno',
  "Poisoner’s Kit": 'kit-de-veneno',
  "Calligrapher's Supplies": 'suprimentos-de-caligrafo',
  "Calligrapher’s Supplies": 'suprimentos-de-caligrafo',
  "Disguise Kit": 'kit-de-disfarce',
  "Herbalism Kit": 'kit-de-herbalismo',
  "Healer's Kit": 'kit-de-curandeiro',
  "Healer’s Kit": 'kit-de-curandeiro',
  "Thieves' Tools": 'ferramentas-de-ladrao',
  "Thieves’ Tools": 'ferramentas-de-ladrao',
  "Woodcarver's Tools": 'ferramentas-de-carpinteiro',
  "Woodcarver’s Tools": 'ferramentas-de-carpinteiro',
  "Cartographer's Tools": 'ferramentas-de-cartografo',
  "Cartographer’s Tools": 'ferramentas-de-cartografo',
  'Holy Symbol': 'simbolo-sagrado',
  Book: 'livro',
  Dagger: 'dagger',
  Spear: 'spear',
  Shield: 'shield',
  Robe: 'tunica',
  Parchment: 'pergaminho',
  'Magnifying Glass': 'lupa',
  'Hunting Trap': 'armadilha-de-caca',
  "Traveler's Clothes": 'roupas-viagem',
  "Traveler’s Clothes": 'roupas-viagem',
  'Fine Clothes': 'roupas-finas',
  Maps: 'mapa',
  Map: 'mapa',
  Club: 'club',
  Manacles: 'grilhoes',
  Ink: 'tinta',
  Chest: 'bau',
  Costume: 'roupas-fantasia',
  'Signet Ring': null,
};

export const PHB_FEAT_ANCHOR_MAP = {
  Skilled: 'skilled',
  SavageAttacker: 'savage-attacker',
  Alert: 'alert',
  MagicInitiate: 'magic-initiate',
  Lucky: 'lucky',
  Healer: 'healer',
  Tough: 'tough',
  TavernBrawler: 'tavern-brawler',
  Musician: 'musician',
  Artisan: 'artisan',
};

export const ACTION_ECONOMY_KEYWORDS = [
  { pattern: /\bBonus Action\b/gi, bucket: 'bonus' },
  { pattern: /\bReaction\b/gi, bucket: 'reaction' },
  { pattern: /\bFree Action\b/gi, bucket: 'free' },
  { pattern: /\bAction\b/gi, bucket: 'action' },
];

export function detectActionEconomy(text) {
  const found = new Set();
  const ordered = [];
  for (const { pattern, bucket } of ACTION_ECONOMY_KEYWORDS) {
    if (pattern.test(text) && !found.has(bucket)) {
      found.add(bucket);
      ordered.push(bucket);
    }
    pattern.lastIndex = 0;
  }
  return ordered;
}

export function parseAbilityScores(text) {
  return text
    .replace(/^Ability Scores:\s*/i, '')
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean)
    .map((name) => ABILITY_SLUG_MAP[name])
    .filter(Boolean);
}

export function parseSkillLink(htmlFragment) {
  const m = htmlFragment.match(/>([^<]+)</);
  return m ? SKILL_SLUG_MAP[stripTags(m[1])] ?? slugify(stripTags(m[1])) : null;
}

export function parseFeatHref(href, linkText = '') {
  const gh = href.match(/chapter-4-character-feats#([^"?]+)/i);
  if (gh) {
    const anchor = gh[1];
    return { slug: anchorToSlug(anchor), source: 'ghpg', variant: null };
  }
  const phb = href.match(/br-2024\/feats#([^"?]+)/i);
  if (phb) {
    const anchor = phb[1];
    const base = PHB_FEAT_ANCHOR_MAP[anchor] ?? anchorToSlug(anchor);
    const variantMatch = linkText.match(/\(([^)]+)\)/);
    return { slug: base, source: 'phb', variant: variantMatch ? variantMatch[1].trim() : null };
  }
  return { slug: slugify(linkText || href), source: 'unknown', variant: null };
}

export function parseEquipmentOption(rawHtml) {
  const text = stripTags(rawHtml.replace(/<a[^>]*>([^<]*)<\/a>/gi, '$1'));
  const goldB = text.match(/\(B\)\s*(\d+)\s*GP/i);
  const optionA = text.match(/\(A\)\s*(.+?);\s*or\s*\(B\)/i);
  const items = [];

  if (!optionA) {
    return { goldOptionB: goldB ? Number.parseInt(goldB[1], 10) : null, optionA: { gold: 0, items } };
  }

  const segment = optionA[1];
  const goldA = segment.match(/(\d+)\s*GP\s*$/i);
  const gold = goldA ? Number.parseInt(goldA[1], 10) : 0;
  const body = goldA ? segment.slice(0, goldA.index).trim() : segment.trim();

  for (const m of rawHtml.matchAll(/<a[^>]*href="[^"]*\/(?:equipment|weapons|armor)\/\d+-([^"?]+)"[^>]*>([^<]*)<\/a>/gi)) {
    const ddbSlug = m[1];
    const name = stripTags(m[2]);
    const qtyMatch = name.match(/\((\d+)\s*sheet/i) || segment.match(new RegExp(`${name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\s*\\((\\d+)`, 'i'));
    items.push({
      name: name.replace(/\s*\(\d+.*\)/i, '').trim(),
      itemSlug: DDB_ITEM_SLUG_MAP[ddbSlug] ?? null,
      ddbSlug,
      quantity: qtyMatch ? Number.parseInt(qtyMatch[1], 10) : 1,
      choiceText: DDB_ITEM_SLUG_MAP[ddbSlug] ? null : name.replace(/\s*\(\d+.*\)/i, '').trim(),
    });
  }

  const plainParts = body
    .split(',')
    .map((p) => p.trim())
    .filter((p) => p && !/^\d+\s*GP$/i.test(p));

  for (const part of plainParts) {
    if (items.some((i) => part.toLowerCase().includes(i.name.toLowerCase()))) continue;
    const cleanName = part.replace(/\s*\(\d+.*\)/i, '').trim();
    const mapped = NAME_ITEM_MAP[cleanName] ?? NAME_ITEM_MAP[part.trim()];
    const qty = part.match(/\((\d+)\s*sheet/i);
    items.push({
      name: cleanName,
      itemSlug: mapped ?? DDB_ITEM_SLUG_MAP[slugify(cleanName)] ?? null,
      ddbSlug: null,
      quantity: qty ? Number.parseInt(qty[1], 10) : 1,
      choiceText: /choose|same as above|or/i.test(part) ? part : mapped ? null : part,
    });
  }

  return {
    goldOptionB: goldB ? Number.parseInt(goldB[1], 10) : 50,
    optionA: { gold, items },
  };
}

export function parseMechanicalFields(block) {
  const fields = {};
  const mechanicalKeys = new Set([
    'Ability Scores',
    'Feat',
    'Skill Proficiencies',
    'Tool Proficiency',
    'Equipment',
  ]);

  for (const m of block.matchAll(/<p[^>]*><strong>([^<:]+):<\/strong>\s*([\s\S]*?)<\/p>/gi)) {
    const key = stripTags(m[1]);
    if (mechanicalKeys.has(key)) {
      fields[key] = m[2];
    }
  }

  return fields;
}

/** @deprecated Use parseMechanicalFields — alguns backgrounds têm Equipment fora do condensed-group */
export function parseCondensedGroup(block) {
  return parseMechanicalFields(block);
}

export function extractParagraphs(block, { skipAside = true } = {}) {
  const paras = [];
  for (const m of block.matchAll(/<p[^>]*>([\s\S]*?)<\/p>/gi)) {
    const text = stripTags(m[1]);
    if (!text || text.startsWith('—')) continue;
    if (skipAside && /<aside/i.test(m[0])) continue;
    paras.push(text);
  }
  return paras;
}

export function parseFeatBenefits(block) {
  const benefits = [];
  const introParts = [];
  let seenBenefit = false;

  for (const m of block.matchAll(/<p[^>]*>([\s\S]*?)<\/p>/gi)) {
    const raw = m[1];
    const text = stripTags(raw);
    if (!text) continue;
    if (/^(Origin|General|Fighting Style|Epic Boon) Feat$/i.test(text)) continue;

    const benefit = raw.match(/<strong><em>([^<]+)\.<\/em><\/strong>\s*(.*)/i);
    if (benefit) {
      seenBenefit = true;
      benefits.push({
        name: stripTags(benefit[1]),
        description: stripTags(benefit[2] || ''),
        actionEconomy: detectActionEconomy(stripTags(raw)),
      });
    } else if (!seenBenefit) {
      introParts.push(text);
    } else if (seenBenefit && benefits.length) {
      const last = benefits[benefits.length - 1];
      last.description = `${last.description} ${text}`.trim();
      last.actionEconomy = detectActionEconomy(last.description);
    }
  }

  return { intro: introParts.join('\n\n'), benefits };
}
