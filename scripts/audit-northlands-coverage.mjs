/**
 * Cheque final: JSON → seeds (cobertura Northlands).
 * Scrape HTML descartado; baseline = docs/source/northlands-stat-blocks.json.
 * Uso: node scripts/audit-northlands-coverage.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.join(__dirname, '..');

const JSON_IN = path.join(rootDir, 'docs/source/northlands-stat-blocks.json');
const M003 = path.join(rootDir, 'database/seeds/creatures/M003_nwb_longships.sql');
const M004 = path.join(rootDir, 'database/seeds/creatures/M004_nwb_bestiary.sql');

function seedTemplateSlugs(sql, table) {
  const re = new RegExp(
    `INSERT INTO rpg\\.${table} \\([^)]+\\) VALUES\\s*\\(\\s*'([^']+)'`,
    'g',
  );
  return [...sql.matchAll(re)].map((m) => m[1]);
}

function main() {
  const data = JSON.parse(fs.readFileSync(JSON_IN, 'utf8'));
  const m003 = fs.readFileSync(M003, 'utf8');
  const m004 = fs.readFileSync(M004, 'utf8');

  const jsonCreatureSlugs = data.creatures.map((c) => c.slug);
  const jsonVehicleSlugs = data.vehicles.map((v) => v.slug);
  const seedCreatures = seedTemplateSlugs(m004, 'phb_creature_template');
  const seedVehicles = seedTemplateSlugs(m003, 'phb_vehicle_template');

  let legendaryExtracted = 0;
  const legendaryOnlyUses = [];
  const emptyAbilities = [];
  const noActions = [];
  const noSpeeds = [];

  for (const c of data.creatures) {
    const leg = (c.actions ?? []).filter((a) => a.actionBucket === 'legendary');
    const abilities = Object.keys(c.abilityScores ?? {}).length;
    if (abilities < 6) emptyAbilities.push({ slug: c.slug, abilities });
    if (!(c.actions?.length)) noActions.push(c.slug);
    if (!(c.speeds?.length)) noSpeeds.push(c.slug);

    const abilityLegs = leg.filter(
      (a) => !/^Usos de Ação Lendária:?$/i.test(a.name),
    );
    legendaryExtracted += abilityLegs.length;
    if (leg.length && abilityLegs.length === 0) {
      legendaryOnlyUses.push(c.slug);
    }
  }

  const missSeedC = jsonCreatureSlugs.filter((s) => !seedCreatures.includes(s));
  const missSeedV = jsonVehicleSlugs.filter((s) => !seedVehicles.includes(s));

  console.log('=== COBERTURA (JSON → seeds) ===');
  console.log(
    `JSON: ${data.creatures.length} creatures, ${data.vehicles.length} vehicles`,
  );
  console.log(
    `Seeds: M004 ${seedCreatures.length} creatures, M003 ${seedVehicles.length} vehicles`,
  );

  console.log('\n=== JSON → Seeds ===');
  console.log(`Criaturas sem seed: ${missSeedC.length || 0}`);
  if (missSeedC.length) console.log(' ', missSeedC.join(', '));
  console.log(`Veículos sem seed: ${missSeedV.length || 0}`);
  if (missSeedV.length) console.log(' ', missSeedV.join(', '));
  console.log(`Veículos seed: ${seedVehicles.join(', ')}`);
  console.log(`Veículos JSON: ${jsonVehicleSlugs.join(', ')}`);

  console.log('\n=== LENDÁRIAS (JSON) ===');
  console.log(`Ações lendárias (sem usos): ${legendaryExtracted}`);
  console.log(
    `Só "Usos" sem habilidades: ${legendaryOnlyUses.length ? legendaryOnlyUses.join(', ') : 'nenhum'}`,
  );

  console.log('\n=== LACUNAS DE DADOS ===');
  console.log(`Ability scores incompletos (<6): ${emptyAbilities.length}`);
  for (const row of emptyAbilities) {
    console.log(`  ${row.slug} (${row.abilities}/6)`);
  }
  console.log(`Sem ações: ${noActions.length ? noActions.join(', ') : 'nenhum'}`);
  console.log(`Sem speeds: ${noSpeeds.length ? noSpeeds.join(', ') : 'nenhum'}`);

  const issues =
    missSeedC.length +
    missSeedV.length +
    legendaryOnlyUses.length +
    emptyAbilities.length;

  console.log('\n=== VEREDITO ===');
  if (issues === 0) {
    console.log('OK — JSON alinhado com seeds, sem lacunas detectadas.');
  } else {
    console.log(`Atenção — ${issues} sinal(is) de lacuna (ver seções acima).`);
  }

  process.exit(issues ? 1 : 0);
}

main();
