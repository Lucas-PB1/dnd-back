#!/usr/bin/env node
/**
 * Gera SQL de abilityIncrease a partir de S022 (benefício ASI).
 * Uso: node scripts/generate-feat-asi-options.mjs > database/migrations/050_data/D003_feat_ability_increase_bulk.sql
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const s022 = fs.readFileSync(
  path.join(root, 'database/seeds/phb/S022_phb_feat_benefit.sql'),
  'utf8',
);

const ABILITY = {
  Força: 'forca',
  Destreza: 'destreza',
  Constituição: 'constituicao',
  Inteligência: 'inteligencia',
  Sabedoria: 'sabedoria',
  Carisma: 'carisma',
};
const ALL = Object.values(ABILITY);

/** Já têm abilityIncrease (ou ASI coberto por outro fluxo). */
const SKIP_SLUGS = new Set(['elemental-adept']);

const lineRe =
  /slug = '([^']+)'\), 1, 'Aumento no Valor de Atributo', '([^']*)'/g;

function parseAllowed(desc) {
  if (
    /aumente um valor de atributo à sua escolha/i.test(desc) ||
    /escolha um atributo no qual você não tenha proficiência/i.test(desc)
  ) {
    return ALL;
  }
  const slugs = [];
  for (const [label, slug] of Object.entries(ABILITY)) {
    if (desc.includes(label)) slugs.push(slug);
  }
  if (slugs.length === 0) {
    throw new Error(`Could not parse ASI abilities: ${desc}`);
  }
  return slugs;
}

const LABEL = {
  forca: 'Força',
  destreza: 'Destreza',
  constituicao: 'Constituição',
  inteligencia: 'Inteligência',
  sabedoria: 'Sabedoria',
  carisma: 'Carisma',
};

/** @type {{ slug: string, abilities: string[] }[]} */
const feats = [];
let match;
while ((match = lineRe.exec(s022)) !== null) {
  const slug = match[1];
  if (SKIP_SLUGS.has(slug)) continue;
  feats.push({ slug, abilities: parseAllowed(match[2]) });
}

const defLines = [];
const valueLines = [];
for (const { slug, abilities } of feats) {
  defLines.push(
    `  ((SELECT id FROM rpg.phb_feat WHERE slug = '${slug}'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1)`,
  );
  let order = 1;
  for (const abilitySlug of abilities) {
    valueLines.push(
      `  ((SELECT id FROM rpg.phb_feat WHERE slug = '${slug}'), 'abilityIncrease', '${abilitySlug}', '${LABEL[abilitySlug]}', ${order})`,
    );
    order += 1;
  }
}

const outPath = path.join(root, 'database/migrations/050_data/D003_feat_ability_increase_bulk.sql');
const body = [];
body.push(`-- Gerado por scripts/generate-feat-asi-options.mjs — ${feats.length} talentos`);
body.push('');
body.push('INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)');
body.push('VALUES');
body.push(defLines.join(',\n'));
body.push('ON CONFLICT (feat_id, option_key) DO NOTHING;');
body.push('');
body.push('INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)');
body.push('VALUES');
body.push(valueLines.join(',\n'));
body.push('ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;');
fs.writeFileSync(outPath, body.join('\n') + '\n', 'utf8');
console.error(`Wrote ${outPath} (${feats.length} feats)`);
