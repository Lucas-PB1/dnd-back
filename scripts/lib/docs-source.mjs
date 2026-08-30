/**
 * Caminhos canônicos de docs/source.
 *
 * - extracts/  — JSON/MD versionados (SSOT pós-scrape → seeds)
 * - _scrapes/  — HTML Beyond temporário (gitignored)
 * - _assets/   — PNGs temporários de import (gitignored)
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export const apiRoot = path.join(__dirname, '../..');
export const docsSource = path.join(apiRoot, 'docs/source');
export const extractsDir = path.join(docsSource, 'extracts');
export const scrapesDir = path.join(docsSource, '_scrapes');
export const assetsDir = path.join(docsSource, '_assets');

/** @param {...string} segments */
export function extractPath(...segments) {
  return path.join(extractsDir, ...segments);
}

/** @param {...string} segments */
export function scrapePath(...segments) {
  return path.join(scrapesDir, ...segments);
}

/** @param {...string} segments */
export function assetPath(...segments) {
  return path.join(assetsDir, ...segments);
}

export const extracts = {
  dmg: {
    itemsAz: extractPath('dmg/items-az.json'),
    itemsAzTxt: extractPath('dmg/items-az.txt'),
    itemsAzIndex: extractPath('dmg/items-az-index.md'),
    wiringStatus: extractPath('dmg/wiring-status.md'),
  },
  grimHollow: {
    cap1Heritages: extractPath('grim-hollow/cap1-heritages.json'),
    cap3Backgrounds: extractPath('grim-hollow/cap3-backgrounds.json'),
    cap4Feats: extractPath('grim-hollow/cap4-feats.json'),
    cap5AdvancedEquipment: extractPath('grim-hollow/cap5-advanced-equipment.json'),
    cap6Transformations: extractPath('grim-hollow/cap6-transformations.json'),
  },
  griffonsSaddlebag: {
    bookOnePartIi: extractPath('griffons-saddlebag/book-one-part-ii.json'),
  },
  northlands: {
    cap5: extractPath('northlands/cap5.json'),
    cap5SpellsPt: extractPath('northlands/cap5-spells-pt.json'),
    cap5MagicItemsPt: extractPath('northlands/cap5-magic-items-pt.json'),
    statBlocks: extractPath('northlands/stat-blocks.json'),
  },
  phb: {
    cap6Mounts: extractPath('phb/cap6-mounts.json'),
    cap6Barding: extractPath('phb/cap6-barding.json'),
    cap7EquipmentSprites: extractPath('phb/cap7-equipment-sprites.json'),
    cap7EquipmentImagesStatus: extractPath('phb/cap7-equipment-images-status.json'),
  },
  srd: {
    monsters521: extractPath('srd/monsters-5.2.1.json'),
  },
};

export const scrapes = {
  grimHollow: scrapePath('grim-hollow'),
  griffonsSaddlebag: scrapePath('griffons-saddlebag'),
  phb: scrapePath('phb'),
  northlands: scrapePath('northlands'),
  dmg: scrapePath('dmg'),
};

export const assets = {
  montarias: assetPath('montarias'),
  montariasImages: assetPath('montarias/images'),
  phbEquipment: assetPath('phb-equipment'),
};

/**
 * Primeiro HTML em `dir` cujo nome contém `needle` (case-insensitive).
 * @param {string} dir
 * @param {string} needle
 */
export function findScrapeHtml(dir, needle) {
  if (!fs.existsSync(dir)) return null;
  const match = fs
    .readdirSync(dir)
    .filter((name) => name.endsWith('.html'))
    .find((name) => name.toLowerCase().includes(needle.toLowerCase()));
  return match ? path.join(dir, match) : null;
}
