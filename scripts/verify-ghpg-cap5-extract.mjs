/**
 * Valida classificação do extract Cap. 5 (sem DB).
 * Uso: node scripts/verify-ghpg-cap5-extract.mjs
 */
import fs from 'fs';

import { CAP5_EQUIPMENT_CATALOG, isArmorShieldKind } from './lib/ghpg-cap5-catalog.mjs';
import { extracts } from './lib/docs-source.mjs';

const extractPath = extracts.grimHollow.cap5AdvancedEquipment;
const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));

let ok = true;

function fail(msg) {
  ok = false;
  console.log(`✗ ${msg}`);
}

function pass(msg) {
  console.log(`✓ ${msg}`);
}

const weapons = [...(extract.meleeWeapons ?? []), ...(extract.rangedWeapons ?? [])];
if (weapons.length !== 42) fail(`armas: esperado 42, got ${weapons.length}`);
else pass(`armas avançadas: ${weapons.length}`);

const badWeapons = weapons.filter((w) => w.catalogKind !== 'advanced-weapon' || w.ddbKind !== 'weapons');
if (badWeapons.length) fail(`armas sem catalogKind/ddbKind: ${badWeapons.map((w) => w.slug).join(', ')}`);
else pass('todas as armas com catalogKind=advanced-weapon e ddbKind=weapons');

const equipment = extract.equipment ?? [];
if (equipment.length !== 18) fail(`equipamento: esperado 18, got ${equipment.length}`);
else pass(`equipamento: ${equipment.length}`);

const shields = equipment.filter((g) => isArmorShieldKind(g.catalogKind));
if (shields.length !== 3) fail(`escudos: esperado 3, got ${shields.length}`);
else pass(`escudos (armor-shield): ${shields.map((s) => s.slug).join(', ')}`);

for (const [slug, expected] of Object.entries(CAP5_EQUIPMENT_CATALOG)) {
  const row = equipment.find((g) => g.slug === slug);
  if (!row) {
    fail(`faltando no extract: ${slug}`);
    continue;
  }
  if (row.catalogKind !== expected.catalogKind) {
    fail(`${slug}: catalogKind ${row.catalogKind} ≠ ${expected.catalogKind}`);
  }
  if (row.itemType !== expected.itemType) {
    fail(`${slug}: itemType ${row.itemType} ≠ ${expected.itemType}`);
  }
  if (expected.ddbKind && row.ddbKind !== expected.ddbKind) {
    fail(`${slug}: ddbKind ${row.ddbKind} ≠ ${expected.ddbKind}`);
  }
}
if (ok) pass('catalogKind/itemType/ddbKind batem com CAP5_EQUIPMENT_CATALOG');

const ammo = extract.ammunition ?? [];
if (ammo.length !== 18) fail(`munição: esperado 18, got ${ammo.length}`);
else pass(`munição: ${ammo.length}`);

const badAmmo = ammo.filter((a) => a.catalogKind !== 'ammunition');
if (badAmmo.length) fail(`munição sem catalogKind ammunition`);
else pass('munição com catalogKind=ammunition');

const stubs = equipment.filter((g) =>
  g.description?.startsWith('Equipamento avançado de Grim Hollow ('),
);
if (stubs.length) fail(`equipamento com descrição stub: ${stubs.map((g) => g.slug).join(', ')}`);
else pass('equipamento com prosa do HTML');

process.exit(ok ? 0 : 1);
