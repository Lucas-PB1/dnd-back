#!/usr/bin/env node
/**
 * One-shot: gera S084_phb_spell_save_attack.sql a partir das descrições.
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const spellSeed = path.join(root, 'database/seeds/phb/S024_phb_spell.sql');
const outPath = path.join(root, 'database/seeds/phb/S084_phb_spell_save_attack.sql');

const abilityMap = {
  Força: 'forca',
  Destreza: 'destreza',
  Constituição: 'constituicao',
  Inteligência: 'inteligencia',
  Sabedoria: 'sabedoria',
  Carisma: 'carisma',
};

const text = fs.readFileSync(spellSeed, 'utf8');
const slugMatches = [...text.matchAll(/\(\s*'([a-z0-9-]+)'\s*,\s*'/g)].map((m) => m[1]);

const results = [];
const multi = [];

for (let i = 0; i < slugMatches.length; i += 1) {
  const slug = slugMatches[i];
  const needle = `('${slug}'`;
  const idx = text.indexOf(needle);
  if (idx < 0) continue;
  const nextSlug = slugMatches[i + 1];
  const end =
    nextSlug != null ? text.indexOf(`('${nextSlug}'`, idx + needle.length) : text.length;
  const chunk = text.slice(idx, end < 0 ? text.length : end);

  const abilities = [];
  const saveRe =
    /salvaguarda de (Força|Destreza|Constituição|Inteligência|Sabedoria|Carisma)/g;
  let m;
  while ((m = saveRe.exec(chunk))) {
    const slugAbility = abilityMap[m[1]];
    if (slugAbility && !abilities.includes(slugAbility)) abilities.push(slugAbility);
  }
  const attack = /jogada de ataque/i.test(chunk);
  if (abilities.length > 1) multi.push({ slug, abilities });
  if (abilities.length > 0 || attack) {
    results.push({
      slug,
      save: abilities[0] ?? null,
      attack,
    });
  }
}

const lines = [
  '-- Seed rpg.phb_spell save_ability / requires_attack_roll',
  '-- Gerado por scripts/generate-spell-save-seed.mjs — revisar ambíguos se necessário',
  '',
];

for (const row of results) {
  const abilitySql = row.save
    ? `(SELECT id FROM rpg.phb_ability WHERE slug = '${row.save}')`
    : 'NULL';
  lines.push(
    `UPDATE rpg.phb_spell`,
    `SET save_ability_id = ${abilitySql},`,
    `    requires_attack_roll = ${row.attack ? 'TRUE' : 'FALSE'}`,
    `WHERE slug = '${row.slug}';`,
    '',
  );
}

fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
console.log(
  JSON.stringify(
    {
      updated: results.length,
      withSave: results.filter((r) => r.save).length,
      withAttack: results.filter((r) => r.attack).length,
      multi,
      outPath,
    },
    null,
    2,
  ),
);
