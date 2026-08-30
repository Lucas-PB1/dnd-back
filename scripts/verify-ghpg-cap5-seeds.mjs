/**
 * Valida seeds Cap. 5 (sem DB).
 * Uso: node scripts/verify-ghpg-cap5-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { isArmorShieldKind } from './lib/ghpg-cap5-catalog.mjs';
import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const seedsDir = path.join(__dirname, '..', 'database/seeds/grim-hollow');

let ok = true;

function fail(msg) {
  ok = false;
  console.log(`✗ ${msg}`);
}

function pass(msg) {
  console.log(`✓ ${msg}`);
}

function readSeed(name) {
  const filePath = path.join(seedsDir, name);
  if (!fs.existsSync(filePath)) {
    fail(`seed ausente: ${name}`);
    return '';
  }
  return fs.readFileSync(filePath, 'utf8');
}

const extract = JSON.parse(fs.readFileSync(extracts.grimHollow.cap5AdvancedEquipment, 'utf8'));
const shieldSlugs = (extract.equipment ?? [])
  .filter((g) => isArmorShieldKind(g.catalogKind))
  .map((g) => g.slug);
const gearSlugs = (extract.equipment ?? [])
  .filter((g) => !isArmorShieldKind(g.catalogKind))
  .map((g) => g.slug);

const j006 = readSeed('J006_phb_gear_advanced.sql');
const j036 = readSeed('J036_phb_armor_advanced_shields.sql');
const j005 = readSeed('J005_phb_weapon_advanced.sql');
const j007 = readSeed('J007_phb_ammunition_advanced.sql');

for (const slug of shieldSlugs) {
  if (j006.includes(`'${slug}'`)) fail(`J006 ainda contém escudo: ${slug}`);
  if (!j036.includes(`'${slug}'`)) fail(`J036 sem escudo: ${slug}`);
}
if (shieldSlugs.length === 3) pass('escudos só em J036, não em J006');

for (const slug of gearSlugs) {
  if (!j006.includes(`'${slug}'`)) fail(`J006 sem gear: ${slug}`);
  if (j036.includes(`'${slug}'`)) fail(`J036 contém gear indevido: ${slug}`);
}
if (gearSlugs.length === 15) pass(`gear (${gearSlugs.length}) só em J006`);

if (j006.includes("'shadowsteel-focus', 'focus'::rpg.item_type")) {
  pass('Shadowsteel Focus como item_type focus');
} else {
  fail('Shadowsteel Focus não está como focus em J006');
}

if (j006.includes("'hunters-armor', 'other'::rpg.item_type")) {
  pass("Hunter's Armor como item_type other (upgrade)");
} else {
  fail("Hunter's Armor não está como other em J006");
}

if (j036.includes('INSERT INTO rpg.phb_armor')) {
  pass('J036 cria linhas em phb_armor');
} else {
  fail('J036 sem INSERT em phb_armor');
}

const weaponCount = (j005.match(/'weapon'::rpg\.item_type/g) ?? []).length;
if (weaponCount === 42) pass(`J005: ${weaponCount} armas`);
else fail(`J005: esperado 42 armas, got ${weaponCount}`);

const ammoCount = (j007.match(/'gear'::rpg\.item_type/g) ?? []).length;
if (ammoCount === 18) pass(`J007: ${ammoCount} munições`);
else fail(`J007: esperado 18 munições, got ${ammoCount}`);

if (j005.includes('"catalogKind":"advanced-weapon"')) {
  pass('J005 inclui catalogKind nas properties');
} else {
  fail('J005 sem catalogKind nas properties');
}

const j008 = readSeed('J008_catalog_images.sql');
const imageUpdates = (j008.match(/UPDATE rpg\.phb_item SET image_url/g) ?? []).length;
if (imageUpdates === 78) pass(`J008: ${imageUpdates} image_url`);
else fail(`J008: esperado 78 image_url, got ${imageUpdates}`);

process.exit(ok ? 0 : 1);
