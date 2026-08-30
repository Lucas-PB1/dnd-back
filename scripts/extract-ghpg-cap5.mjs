/**
 * Extrai Cap. 5 (Advanced Weapons & Equipment) do Grim Hollow Player's Guide.
 *
 * Pré-requisito: HTML do Cap. 5 em docs/source/scrap/ ou _scrapes/grim-hollow/
 *
 * Uso: node scripts/extract-ghpg-cap5.mjs
 */
import fs from 'fs';

import {
  ADVANCED_AMMUNITION_REQUIREMENT,
  ADVANCED_WEAPON_REQUIREMENT,
  GEAR_ANCHOR_BY_SLUG,
  equipmentCatalogMeta,
  gearAdvancedRequirement,
  isArmorShieldKind,
} from './lib/ghpg-cap5-catalog.mjs';
import {
  extractBlock,
  extractParagraphs,
  findGhpgCap5Html,
  slugify,
  stripTags,
} from './lib/ghpg-html-utils.mjs';
import { extracts, scrap, scrapes } from './lib/docs-source.mjs';

const outPath = extracts.grimHollow.cap5AdvancedEquipment;

const htmlPath = findGhpgCap5Html(scrap.grimHollow, scrapes.grimHollow);

if (!htmlPath) {
  console.error(
    'HTML Cap. 5 GHPG não encontrado em docs/source/scrap/ nem _scrapes/grim-hollow',
  );
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');

function parseItemCell(cellHtml) {
  const hrefMatch = cellHtml.match(/href="[^"]*\/equipment\/\d+-([^"?]+)"/i);
  const tooltipMatch = cellHtml.match(/data-tooltip-href="\/\/www\.dndbeyond\.com\/([^/]+)\//i);
  const text = stripTags(cellHtml);
  const slug = hrefMatch ? hrefMatch[1] : slugify(text);
  const ddbKind = tooltipMatch?.[1] ?? null;
  return { name: text, slug, ddbKind };
}

function parseItemName(cellHtml) {
  return parseItemCell(cellHtml);
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
    return kg < 1
      ? `${Math.round(kg * 1000)} g`
      : `${kg % 1 === 0 ? kg : kg.toFixed(1).replace('.', ',')} kg`;
  }
  const lb = Number.parseFloat(raw);
  if (Number.isNaN(lb)) return lbText;
  const kg = lb / 2;
  return kg < 1
    ? `${Math.round(kg * 1000)} g`
    : `${kg % 1 === 0 ? kg : kg.toFixed(1).replace('.', ',')} kg`;
}

function parseCost(cell) {
  const text = cell.trim();
  return { text: text.replace(/\s+GP\b/gi, ' PO').replace(/\s+gp\b/g, ' PO') };
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

const WEAPON_DESCRIPTION_PT =
  'Arma avançada de Grim Hollow. Sem proficiência em Armas Avançadas, você tem Desvantagem nos ataques. ' +
  'Propriedades marcadas com * e maestrias exigem o talento Proficiência em Armas Avançadas ' +
  '(Estilo de Luta ou talento Geral a partir do nível 8).';

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
      catalogKind: 'advanced-weapon',
      itemType: 'weapon',
      ddbKind: 'weapons',
      requirement: { ...ADVANCED_WEAPON_REQUIREMENT },
      description: WEAPON_DESCRIPTION_PT,
    };
  });
}

function enrichEquipmentItem(base) {
  const catalog = equipmentCatalogMeta(base.slug);
  const requirement = gearAdvancedRequirement(base.slug);
  return {
    ...base,
    kind: 'equipment',
    catalogKind: catalog.catalogKind,
    itemType: catalog.itemType,
    ddbKind: base.ddbKind ?? catalog.ddbKind ?? null,
    listInCatalog: catalog.listInCatalog ?? true,
    armor: catalog.armor ?? null,
    upgrade: catalog.upgrade ?? null,
    weaponLike: catalog.weaponLike ?? false,
    requirement,
  };
}

function parseGearTable(captionId) {
  return parseTableAfterCaption(captionId).map((cells) => {
    const { name, slug, ddbKind } = parseItemCell(cells[0]);
    return enrichEquipmentItem({
      slug,
      name,
      ddbKind,
      cost: parseCost(stripTags(cells[1])),
      weight: lbToKg(stripTags(cells[2])),
    });
  });
}

/** @param {string} section @param {string} name */
function inferAmmoProperties(section, name) {
  const propertySlugs = [];
  const propertyMeta = { section };
  const lower = name.toLowerCase();

  if (lower.includes('bludgeoning')) {
    propertyMeta.damageType = 'bludgeoning';
    propertyMeta.halvesMaxRange = true;
  }
  if (lower.includes('slashing')) {
    propertyMeta.damageType = 'slashing';
    propertyMeta.halvesMaxRange = true;
  }
  if (lower.includes('piercing')) {
    propertyMeta.damageType = 'piercing';
    propertyMeta.halvesMaxRange = true;
  }
  if (lower.includes('ranging')) propertySlugs.push('ranging');
  if (lower.includes('whistling')) {
    propertySlugs.push('whistling');
    propertyMeta.damageType = 'bludgeoning';
    propertyMeta.halvesMaxRange = true;
  }
  if (section === 'alchemical-ammunition') propertyMeta.alchemical = true;
  if (section === 'specialized-ammunition') propertyMeta.specialized = true;

  return { propertySlugs, propertyMeta };
}

function parseAmmoTable() {
  let currentSection = 'ammunition';
  const rows = [];

  const idx = html.indexOf('id="AmmunitionTable"');
  const tbodyStart = html.indexOf('<tbody>', idx);
  const tbodyEnd = html.indexOf('</tbody>', tbodyStart);
  const tbody = html.slice(tbodyStart, tbodyEnd);

  for (const tr of tbody.matchAll(/<tr>([\s\S]*?)<\/tr>/gi)) {
    const rowHtml = tr[1];
    const sectionMatch = rowHtml.match(/<td[^>]*colspan[^>]*><em>([^<]+)<\/em>/i);
    if (sectionMatch) {
      currentSection = slugify(sectionMatch[1]);
      continue;
    }

    const cells = [...rowHtml.matchAll(/<td[^>]*>([\s\S]*?)<\/td>/gi)].map((m) => m[1]);
    if (cells.length < 3) continue;

    const { name, slug } = parseItemName(cells[0]);
    const cost = parseCost(stripTags(cells[1] ?? ''));
    const weightCell = stripTags(cells[2] ?? '');
    const weight = weightCell ? lbToKg(weightCell) : null;
    if (!cost?.text?.trim()) continue;

    const ammoProps = inferAmmoProperties(currentSection, name);

    rows.push({
      slug: `${currentSection}-${slug}`,
      name,
      cost,
      weight,
      propertySlugs: ammoProps.propertySlugs,
      propertyMeta: ammoProps.propertyMeta,
      propertiesRaw: null,
      kind: 'ammunition',
      catalogKind: 'ammunition',
      itemType: 'gear',
      ddbKind: null,
      section: currentSection,
      requirement: { ...ADVANCED_AMMUNITION_REQUIREMENT },
    });
  }

  return rows;
}

function extractDescriptionsByAnchor() {
  const map = {};
  for (const m of html.matchAll(
    /<h4\b([^>]*)>[\s\S]*?<\/h4>\s*([\s\S]*?)(?=<h4\b|<h3\b|<h2\b|<div class="table-overflow|<hr)/gi,
  )) {
    const idMatch = m[1].match(/\sid="([^"]+)"/i);
    if (!idMatch) continue;
    const anchor = idMatch[1];
    const prose = stripTags(m[2]).slice(0, 8000);
    if (prose.length > 20) map[anchor] = prose;
  }
  return map;
}

function extractH4Blocks(blockHtml) {
  const items = [];
  for (const m of blockHtml.matchAll(
    /<h4\b([^>]*)>[\s\S]*?<\/h4>\s*([\s\S]*?)(?=<h4\b|<h3\b|<h2\b)/gi,
  )) {
    const idMatch = m[1].match(/\sid="([^"]+)"/i);
    if (!idMatch) continue;
    items.push({
      anchor: idMatch[1],
      descriptionEn: stripTags(m[2]).slice(0, 4000),
    });
  }
  return items;
}

function extractPropertyRules() {
  const block = extractBlock(html, 'AdvancedWeaponProperties', 3);
  return extractH4Blocks(block).map(({ anchor, descriptionEn }) => {
    const slug = anchor
      .replace(/^wprop/i, '')
      .replace(/([A-Z])/g, (c) => `-${c.toLowerCase()}`)
      .replace(/^-/, '');
    return {
      anchor,
      slug: slugify(slug.replace(/-/g, ' ')),
      descriptionEn,
    };
  });
}

function extractMasteryRules() {
  const block = extractBlock(html, 'NewWeaponMasteryProperties', 3);
  return extractH4Blocks(block).map(({ anchor, descriptionEn }) => ({
    anchor,
    slug: slugify(anchor.replace(/^wprop/i, '').replace(/2$/, '')),
    descriptionEn,
  }));
}

function extractChapterRules() {
  const weaponBlock = extractBlock(html, 'AdvancedWeaponTraining', 2);
  const ammoBlock = extractBlock(html, 'AdvancedWeaponTrainingAmmunition', 2);
  const equipmentBlock = extractBlock(html, 'AdvancedEquipment', 2);

  return {
    advancedWeaponTraining: {
      ...ADVANCED_WEAPON_REQUIREMENT,
      introEn: extractParagraphs(weaponBlock).join('\n\n'),
    },
    advancedAmmunition: {
      ...ADVANCED_AMMUNITION_REQUIREMENT,
      introEn: extractParagraphs(ammoBlock).slice(0, 2).join('\n\n'),
    },
    advancedEquipment: {
      introEn: extractParagraphs(equipmentBlock).slice(0, 4).join('\n\n'),
      tiersEn: extractParagraphs(equipmentBlock).slice(4, 8),
    },
    weaponProperties: extractPropertyRules(),
    weaponMasteries: extractMasteryRules(),
  };
}

const descriptionsByAnchor = extractDescriptionsByAnchor();

function attachGearDescription(item) {
  const anchor = GEAR_ANCHOR_BY_SLUG[item.slug];
  if (anchor && descriptionsByAnchor[anchor]) {
    item.description = descriptionsByAnchor[anchor];
    return item;
  }

  const keys = [slugify(item.name), item.slug, item.name.replace(/,/g, '').replace(/\s+/g, '')];
  for (const key of keys) {
    const hit = Object.entries(descriptionsByAnchor).find(([anchorId]) =>
      anchorId.toLowerCase().includes(key.replace(/-/g, '')),
    );
    if (hit) {
      item.description = hit[1];
      return item;
    }
  }

  item.description = `Equipamento avançado de Grim Hollow (${item.name}).`;
  return item;
}

const AMMO_DESCRIPTION_PT =
  'Munição avançada de Grim Hollow. Exige proficiência na arma que dispara a munição e nível 3 ou superior.';

function attachAmmoDescription(item) {
  const keys = [
    slugify(item.name),
    item.name.replace(/,/g, '').replace(/\s+/g, ''),
    item.slug.replace(/^[^-]+-/, ''),
  ];
  for (const key of keys) {
    const hit = Object.entries(descriptionsByAnchor).find(([anchorId]) =>
      anchorId.toLowerCase().includes(key.replace(/-/g, '')),
    );
    if (hit) {
      item.description = hit[1];
      return item;
    }
  }
  item.description = AMMO_DESCRIPTION_PT;
  return item;
}

const extract = {
  source: {
    editionSlug: 'grim-hollow-players-guide-2024-en',
    citationSlug: 'grim-hollow-players-guide-2024-en:chapter-5-advanced-weapons-equipment',
    book: "Grim Hollow: Player's Guide",
    chapter: 5,
    chapterTitle: 'Advanced Weapons & Equipment',
    htmlPath,
  },
  rules: extractChapterRules(),
  meleeWeapons: parseWeaponTable('AdvancedMeleeWeaponsTable'),
  rangedWeapons: parseWeaponTable('Advanced Ranged WeaponsTable'),
  equipment: parseGearTable('EquipmentTable').map(attachGearDescription),
  ammunition: parseAmmoTable().map(attachAmmoDescription),
  extractedAt: new Date().toISOString(),
};

fs.writeFileSync(outPath, `${JSON.stringify(extract, null, 2)}\n`);

const gearWithRealDesc = extract.equipment.filter(
  (g) => !g.description.startsWith('Equipamento avançado de Grim Hollow ('),
);
const ammoWithProps = extract.ammunition.filter((a) => (a.propertySlugs?.length ?? 0) > 0);

console.log(`Extract: ${outPath}`);
console.log(`  HTML: ${htmlPath}`);
console.log(
  `  melee=${extract.meleeWeapons.length} ranged=${extract.rangedWeapons.length} gear=${extract.equipment.length} ammo=${extract.ammunition.length}`,
);
console.log(
  `  gear com prosa real: ${gearWithRealDesc.length}/${extract.equipment.length}`,
);
const shields = extract.equipment.filter((g) => isArmorShieldKind(g.catalogKind));
const gearOnly = extract.equipment.filter((g) => !isArmorShieldKind(g.catalogKind));
console.log(`  escudos (armor): ${shields.length} · demais equipamento: ${gearOnly.length}`);
console.log(`  munição com props inferidas: ${ammoWithProps.length}/${extract.ammunition.length}`);
console.log(
  `  regras: props=${extract.rules.weaponProperties.length} maestrias=${extract.rules.weaponMasteries.length}`,
);
