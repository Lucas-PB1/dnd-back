/**
 * Extrai Cap. 5 (Advanced Weapons & Equipment) do Grim Hollow Player's Guide.
 *
 * Uso: node scripts/extract-ghpg-cap5.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts, scrapes } from './lib/docs-source.mjs';

const grimDir = scrapes.grimHollow;
const outPath = extracts.grimHollow.cap5AdvancedEquipment;

const htmlPath = fs
  .readdirSync(grimDir)
  .filter((n) => n.includes('Chapter 5') && n.endsWith('.html'))
  .map((n) => path.join(grimDir, n))[0];

if (!htmlPath) {
  console.error('HTML Cap. 5 GHPG não encontrado em docs/source/_scrapes/grim-hollow');
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');

function decodeHtml(value) {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&nbsp;/g, ' ');
}

function stripTags(fragment) {
  return decodeHtml(fragment.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim());
}

function slugify(name) {
  return name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function parseItemName(cellHtml) {
  const hrefMatch = cellHtml.match(/href="[^"]*\/equipment\/\d+-([^"?]+)"/i);
  const text = stripTags(cellHtml);
  const slug = hrefMatch ? hrefMatch[1] : slugify(text);
  return { name: text, slug };
}

function parseDamage(cell) {
  const m = cell.match(/^(\d+d\d+)\s+(\w+)/i);
  if (!m) return { damage: cell.trim(), damageType: null };
  const typeMap = {
    piercing: 'Perfurante',
    slashing: 'Cortante',
    bludgeoning: 'Contundente',
  };
  return {
    damage: m[1],
    damageType: typeMap[m[2].toLowerCase()] ?? m[2],
  };
}

function parseProperties(cellHtml) {
  const text = stripTags(cellHtml);
  const propertySlugs = [];
  const meta = {};

  const add = (slug) => {
    if (!propertySlugs.includes(slug)) propertySlugs.push(slug);
  };

  const patterns = [
    [/Armor-Piercing/i, 'armor-piercing'],
    [/Blackpowder/i, 'blackpowder'],
    [/Cumbersome/i, 'cumbersome'],
    [/Damage\s*\(([^)]+)\)/i, 'damage'],
    [/Double/i, 'double'],
    [/Hafted/i, 'hafted'],
    [/Magazine/i, 'magazine'],
    [/Momentum/i, 'momentum'],
    [/Repeater/i, 'repeater'],
    [/Finesse/i, 'finesse'],
    [/Light/i, 'light'],
    [/Heavy/i, 'heavy'],
    [/Reach/i, 'reach'],
    [/Two-Handed/i, 'two-handed'],
    [/Thrown/i, 'thrown'],
    [/Versatile/i, 'versatile'],
    [/Loading/i, 'loading'],
    [/Ammunition/i, 'ammunition'],
    [/Ranging/i, 'ranging'],
    [/Whistling/i, 'whistling'],
    [/Blessed/i, 'blessed-ammo'],
    [/Brutal/i, 'brutal-ammo'],
    [/Desecrated/i, 'desecrated-ammo'],
    [/Incendiary/i, 'incendiary-ammo'],
    [/Alchemical/i, 'alchemical-ammo'],
  ];

  for (const [re, slug] of patterns) {
    if (re.test(text)) add(slug);
  }

  const momentum = text.match(/Momentum\s*\*?\s*\(([^)]+)\)/i);
  if (momentum) meta.momentumDice = momentum[1].trim();

  const versatile = text.match(/Versatile\s*\(([^)]+)\)/i);
  if (versatile) meta.versatileDamage = versatile[1].trim();

  const thrownRange = text.match(/Thrown\s*\(Range\s*([^)]+)\)/i);
  if (thrownRange) {
    const parts = thrownRange[1].split('/').map((n) => Number.parseInt(n.trim(), 10));
    if (parts.length === 2) {
      meta.range = { normal: parts[0] * 1.5, max: parts[1] * 1.5 };
    }
  }

  const magazine = text.match(/Magazine\s*\(([^)]+)\)/i);
  if (magazine) meta.magazine = magazine[1].trim();

  const ammoRange = text.match(/Ammunition\s*\(Range\s*(\d+)\s*\/\s*(\d+)/i);
  if (ammoRange) {
    meta.range = {
      normal: Number.parseInt(ammoRange[1], 10) * 1.5,
      max: Number.parseInt(ammoRange[2], 10) * 1.5,
    };
  }

  const damageTypes = text.match(/Damage\s*\(([^)]+)\)/i);
  if (damageTypes) meta.damageTypes = damageTypes[1].split(/,|\s+or\s+/i).map((s) => s.trim());

  return { propertySlugs, meta, raw: text };
}

function parseMastery(cellHtml) {
  const text = stripTags(cellHtml);
  const map = {
    Entangling: 'entangling',
    Swift: 'swift',
    Slow: 'slow',
    Sap: 'sap',
    Brutal: 'brutal',
    Set: 'set',
    Disarming: 'disarming',
    Defending: 'defending',
    Returning: 'returning',
    Scatter: 'scatter',
    Graze: 'graze',
    Cleave: 'cleave',
    Topple: 'topple',
    Vex: 'vex',
    Nick: 'nick',
  };
  for (const [label, slug] of Object.entries(map)) {
    if (text.includes(label)) return slug;
  }
  return null;
}

function lbToKg(lbText) {
  const raw = lbText.replace(/lb\.?/i, '').trim();
  if (raw === '*') return null;
  if (raw.includes('/')) {
    const [a, b] = raw.split('/').map((n) => Number.parseFloat(n));
    const lb = a / b;
    const kg = lb / 2;
    return kg < 1 ? `${Math.round(kg * 1000)} g` : `${kg % 1 === 0 ? kg : kg.toFixed(1).replace('.', ',')} kg`;
  }
  const lb = Number.parseFloat(raw);
  if (Number.isNaN(lb)) return lbText;
  const kg = lb / 2;
  return kg < 1 ? `${Math.round(kg * 1000)} g` : `${kg % 1 === 0 ? kg : kg.toFixed(1).replace('.', ',')} kg`;
}

function parseCost(cell) {
  const text = cell.trim();
  if (text.startsWith('+')) return { text: text.replace(' GP', ' PO').replace(' gp', ' PO') };
  return { text: text.replace(' GP', ' PO').replace(' gp', ' PO') };
}

function parseTableAfterCaption(captionId) {
  const idx = html.indexOf(`id="${captionId}"`);
  if (idx < 0) return [];
  const tbodyStart = html.indexOf('<tbody>', idx);
  const tbodyEnd = html.indexOf('</tbody>', tbodyStart);
  if (tbodyStart < 0 || tbodyEnd < 0) return [];
  const tbody = html.slice(tbodyStart, tbodyEnd);
  const rows = [];
  for (const tr of tbody.matchAll(/<tr>([\s\S]*?)<\/tr>/gi)) {
    const cells = [...tr[1].matchAll(/<td[^>]*>([\s\S]*?)<\/td>/gi)].map((m) => m[1]);
    if (cells.length) rows.push(cells);
  }
  return rows;
}

function parseWeaponTable(captionId) {
  return parseTableAfterCaption(captionId).map((cells) => {
    const { name, slug } = parseItemName(cells[0]);
    const { damage, damageType } = parseDamage(stripTags(cells[1]));
    const props = parseProperties(cells[2]);
    const masterySlug = parseMastery(cells[3]);
    return {
      slug,
      name,
      damage,
      damageType,
      propertySlugs: props.propertySlugs,
      propertyMeta: props.meta,
      propertiesRaw: props.raw,
      masterySlug,
      weight: lbToKg(stripTags(cells[4])),
      cost: parseCost(stripTags(cells[5])),
      kind: 'weapon',
    };
  });
}

function parseGearTable(captionId) {
  return parseTableAfterCaption(captionId).map((cells) => {
    const { name, slug } = parseItemName(cells[0]);
    return {
      slug,
      name,
      cost: parseCost(stripTags(cells[1])),
      weight: lbToKg(stripTags(cells[2])),
      kind: 'gear',
    };
  });
}

function parseAmmoTable() {
  const sectionHeaders = new Set([
    'arrows-and-bolts',
    'alchemical-ammunition',
    'specialized-ammunition',
    'other-ranged-ammunition',
  ]);

  let currentSection = 'ammo';
  const rows = [];

  const idx = html.indexOf('id="AmmunitionTable"');
  const tbodyStart = html.indexOf('<tbody>', idx);
  const tbodyEnd = html.indexOf('</tbody>', tbodyStart);
  const tbody = html.slice(tbodyStart, tbodyEnd);

  for (const tr of tbody.matchAll(/<tr>([\s\S]*?)<\/tr>/gi)) {
    const rowHtml = tr[1];
    const colspan = rowHtml.match(/<td[^>]*colspan[^>]*><em>([^<]+)<\/em>/i);
    if (colspan) {
      currentSection = slugify(colspan[1]);
      continue;
    }

    const cells = [...rowHtml.matchAll(/<td[^>]*>([\s\S]*?)<\/td>/gi)].map((m) => m[1]);
    if (cells.length < 3) continue;

    const { name, slug } = parseItemName(cells[0]);
    if (sectionHeaders.has(slug)) {
      currentSection = slug;
      continue;
    }

    const props = parseProperties(cells[2] ?? '');
    const cost = parseCost(stripTags(cells[1] ?? ''));
    const weight = lbToKg(stripTags(cells[2] ?? ''));
    if (!cost?.text?.trim()) continue;
    if (!weight || /ammunition/i.test(weight)) continue;

    rows.push({
      slug: `${currentSection}-${slug}`,
      name,
      cost,
      weight,
      propertySlugs: props.propertySlugs,
      propertyMeta: props.meta,
      propertiesRaw: props.raw,
      kind: 'ammunition',
      section: currentSection,
    });
  }

  return rows;
}

function extractDescriptions() {
  const map = {};
  for (const m of html.matchAll(
    /<h4[^>]*id="([^"]+)"[^>]*>[\s\S]*?<\/h4>\s*([\s\S]*?)(?=<h4|<h3|<h2|<div class="table-overflow|<hr)/gi,
  )) {
    const anchor = m[1];
    const prose = stripTags(m[2]).slice(0, 4000);
    if (prose.length > 20) map[anchor] = prose;
  }
  return map;
}

const descriptions = extractDescriptions();

function attachDescription(item) {
  const keys = [
    slugify(item.name),
    item.slug,
    item.name.replace(/,/g, '').replace(/\s+/g, ''),
  ];
  for (const key of keys) {
    const hit = Object.entries(descriptions).find(([anchor]) =>
      anchor.toLowerCase().includes(key.replace(/-/g, '')),
    );
    if (hit) {
      item.description = hit[1];
      return item;
    }
  }
  item.description =
    item.kind === 'weapon'
      ? `Arma avançada de Grim Hollow (${item.name}). Requer proficiência em Armas Avançadas para usar propriedades especiais e maestria.`
      : `Equipamento avançado de Grim Hollow (${item.name}).`;
  return item;
}

const extract = {
  source: {
    editionSlug: 'grim-hollow-players-guide-2024-en',
    citationSlug: 'grim-hollow-players-guide-2024-en:chapter-5-advanced-weapons-equipment',
    book: "Grim Hollow: Player's Guide",
    chapter: 5,
    chapterTitle: 'Advanced Weapons & Equipment',
  },
  meleeWeapons: parseWeaponTable('AdvancedMeleeWeaponsTable').map(attachDescription),
  rangedWeapons: parseWeaponTable('Advanced Ranged WeaponsTable').map(attachDescription),
  equipment: parseGearTable('EquipmentTable').map(attachDescription),
  ammunition: parseAmmoTable().map(attachDescription),
  extractedAt: new Date().toISOString(),
};

fs.writeFileSync(outPath, `${JSON.stringify(extract, null, 2)}\n`);
console.log(`Extract: ${outPath}`);
console.log(
  `  melee=${extract.meleeWeapons.length} ranged=${extract.rangedWeapons.length} gear=${extract.equipment.length} ammo=${extract.ammunition.length}`,
);
