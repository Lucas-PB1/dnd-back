/**
 * Gera seeds SQL a partir de docs/source/extracts/northlands/stat-blocks.json
 * Uso: node scripts/gen-northlands-stat-block-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.join(__dirname, '..');
const JSON_IN = extracts.northlands.statBlocks;
const OUT_DIR = path.join(rootDir, 'database/seeds/creatures');

function sqlStr(value) {
  if (value == null) return 'NULL';
  return `'${String(value).replace(/'/g, "''")}'`;
}

function sqlJson(value) {
  if (value == null) return 'NULL';
  return `'${JSON.stringify(value).replace(/'/g, "''")}'::jsonb`;
}

function parseAlignment(subtitle) {
  if (!subtitle) return null;
  const parts = subtitle.split(',');
  return parts.length > 1 ? parts.slice(1).join(',').trim() : null;
}

function creatureTypeFromSubtitle(subtitle) {
  if (!subtitle) return { type: 'Unknown', subtype: null };
  const m = subtitle.match(/^(?:Large|Medium|Small|Tiny|Huge|Gargantuan)\s+([^,\n]+)(?:,\s*(.+))?$/i);
  return {
    type: m?.[1]?.trim() ?? 'Unknown',
    alignment: m?.[2]?.trim() ?? null,
  };
}

function generateCreatureSeed(block) {
  const lines = [];
  lines.push(`-- ${block.name} (${block.slug})`);
  lines.push(`INSERT INTO rpg.phb_creature_template (`);
  lines.push(`  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,`);
  lines.push(`  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,`);
  lines.push(`  initiative_modifier, ability_scores`);
  lines.push(`) VALUES (`);
  lines.push(`  ${sqlStr(block.slug)},`);
  lines.push(`  ${sqlStr(block.editionSlug)},`);
  lines.push(`  ${sqlStr(block.name)},`);
  lines.push(`  ${sqlStr(block.subtitle)},`);
  lines.push(`  ${sqlStr(block.creatureSubtype ?? block.alignment ?? null)},`);
  lines.push(`  ${sqlStr(block.creatureType)},`);
  lines.push(`  ${sqlStr(block.sizeSlug)},`);
  lines.push(`  ${sqlStr(block.challengeRating)},`);
  lines.push(`  ${block.proficiencyBonus ?? 'NULL'},`);
  lines.push(`  ${block.armorClass ?? 'NULL'},`);
  lines.push(`  ${block.hitPoints ?? 'NULL'},`);
  lines.push(`  ${sqlStr(block.hitPointsFormula)},`);
  lines.push(`  ${block.initiativeModifier ?? 'NULL'},`);
  lines.push(`  ${sqlJson(block.abilityScores)}`);
  lines.push(`) ON CONFLICT (slug) DO UPDATE SET`);
  lines.push(`  name = EXCLUDED.name,`);
  lines.push(`  subtitle = EXCLUDED.subtitle,`);
  lines.push(`  alignment = EXCLUDED.alignment,`);
  lines.push(`  creature_type = EXCLUDED.creature_type,`);
  lines.push(`  size_slug = EXCLUDED.size_slug,`);
  lines.push(`  challenge_rating = EXCLUDED.challenge_rating,`);
  lines.push(`  proficiency_bonus = EXCLUDED.proficiency_bonus,`);
  lines.push(`  armor_class = EXCLUDED.armor_class,`);
  lines.push(`  hit_points_avg = EXCLUDED.hit_points_avg,`);
  lines.push(`  hit_points_formula = EXCLUDED.hit_points_formula,`);
  lines.push(`  initiative_modifier = EXCLUDED.initiative_modifier,`);
  lines.push(`  ability_scores = EXCLUDED.ability_scores;`);
  lines.push('');

  if (block.speeds.length) {
    lines.push(`DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = ${sqlStr(block.slug)};`);
    for (const speed of block.speeds) {
      lines.push(
        `INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES (${sqlStr(block.slug)}, ${sqlStr(speed.movementKind)}, ${speed.speedFt});`,
      );
    }
    lines.push('');
  }

  lines.push(`DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = ${sqlStr(block.slug)};`);
  for (const trait of block.traits.filter((t) => t.name !== 'Regras de turno')) {
    lines.push(
      `INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES (${sqlStr(block.slug)}, ${sqlStr(trait.name)}, ${sqlStr(trait.description)}, ${trait.sortOrder ?? 0});`,
    );
  }
  lines.push('');

  lines.push(`DELETE FROM rpg.phb_creature_template_action WHERE template_slug = ${sqlStr(block.slug)};`);
  for (const action of block.actions) {
    lines.push(
      `INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES (${sqlStr(block.slug)}, ${sqlStr(action.name)}, ${sqlStr(action.actionBucket)}::rpg.actor_action_bucket, ${action.attackBonus ?? 'NULL'}, ${sqlStr(action.damageExpression)}, ${sqlStr(action.description)}, ${action.sortOrder});`,
    );
  }
  lines.push('');
  return lines.join('\n');
}

function generateVehicleSeed(block) {
  const lines = [];
  lines.push(`-- ${block.name} (${block.slug})`);
  lines.push(`INSERT INTO rpg.phb_vehicle_template (`);
  lines.push(`  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,`);
  lines.push(`  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,`);
  lines.push(`  initiative_modifier, ability_scores`);
  lines.push(`) VALUES (`);
  lines.push(`  ${sqlStr(block.slug)},`);
  lines.push(`  ${sqlStr(block.editionSlug)},`);
  lines.push(`  ${sqlStr(block.name)},`);
  lines.push(`  ${sqlStr(block.subtitle)},`);
  lines.push(`  ${block.armorClass ?? 'NULL'},`);
  lines.push(`  ${block.hitPoints ?? 'NULL'},`);
  lines.push(`  ${block.damageThreshold ?? 'NULL'},`);
  lines.push(`  ${block.crewCapacity ?? 'NULL'},`);
  lines.push(`  ${block.passengerCapacity ?? 'NULL'},`);
  lines.push(`  ${block.cargoCapacityLb ?? 'NULL'},`);
  lines.push(`  ${sqlStr(block.cargoCapacityLabel)},`);
  lines.push(`  ${block.initiativeModifier ?? 'NULL'},`);
  lines.push(`  ${sqlJson(block.abilityScores)}`);
  lines.push(`) ON CONFLICT (slug) DO UPDATE SET`);
  lines.push(`  name = EXCLUDED.name,`);
  lines.push(`  subtitle = EXCLUDED.subtitle,`);
  lines.push(`  armor_class = EXCLUDED.armor_class,`);
  lines.push(`  hit_points = EXCLUDED.hit_points,`);
  lines.push(`  damage_threshold = EXCLUDED.damage_threshold,`);
  lines.push(`  crew_capacity = EXCLUDED.crew_capacity,`);
  lines.push(`  passenger_capacity = EXCLUDED.passenger_capacity,`);
  lines.push(`  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,`);
  lines.push(`  cargo_capacity_label = EXCLUDED.cargo_capacity_label,`);
  lines.push(`  initiative_modifier = EXCLUDED.initiative_modifier,`);
  lines.push(`  ability_scores = EXCLUDED.ability_scores;`);
  lines.push('');

  if (block.speeds.length) {
    lines.push(`DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = ${sqlStr(block.slug)};`);
    for (const speed of block.speeds) {
      lines.push(
        `INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES (${sqlStr(block.slug)}, ${sqlStr(speed.movementKind)}, ${speed.speedFt});`,
      );
    }
    lines.push('');
  }

  lines.push(`DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = ${sqlStr(block.slug)};`);
  for (const trait of block.traits) {
    lines.push(
      `INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES (${sqlStr(block.slug)}, ${sqlStr(trait.name)}, ${sqlStr(trait.description)}, ${trait.sortOrder ?? 0});`,
    );
  }
  lines.push('');

  lines.push(`DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = ${sqlStr(block.slug)};`);
  for (const action of block.actions) {
    lines.push(
      `INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES (${sqlStr(block.slug)}, ${sqlStr(action.name)}, ${sqlStr(action.actionBucket)}::rpg.actor_action_bucket, ${action.attackBonus ?? 'NULL'}, ${sqlStr(action.damageExpression)}, ${sqlStr(action.description)}, ${action.sortOrder});`,
    );
  }
  lines.push('');
  return lines.join('\n');
}

function main() {
  const data = JSON.parse(fs.readFileSync(JSON_IN, 'utf8'));

  const longshipSlugs = new Set(['drakkar', 'karvi', 'knarr', 'skeid', 'snekkja', 'ogre-war-sled']);
  const vehicles = data.vehicles.filter((v) => longshipSlugs.has(v.slug));

  const m003 = [
    '-- Northlands Worldbook — longships + veículos terrestres (Cap. 5)',
    '-- Gerado por scripts/gen-northlands-stat-block-seeds.mjs',
    '',
    ...vehicles.flatMap((v) => [generateVehicleSeed(v)]),
  ].join('\n');

  const m004 = [
    '-- Northlands Worldbook — bestiário (Cap. 8)',
    '-- Gerado por scripts/gen-northlands-stat-block-seeds.mjs',
    '',
    ...data.creatures.flatMap((c) => [generateCreatureSeed(c)]),
  ].join('\n');

  fs.writeFileSync(path.join(OUT_DIR, 'M003_nwb_longships.sql'), m003, 'utf8');
  fs.writeFileSync(path.join(OUT_DIR, 'M004_nwb_bestiary.sql'), m004, 'utf8');

  console.log(`Wrote M003 (${vehicles.length} longships) and M004 (${data.creatures.length} creatures)`);
}

main();
