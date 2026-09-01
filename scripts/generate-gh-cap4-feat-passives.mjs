#!/usr/bin/env node
/**
 * Gera grim-hollow-feat-combat-notes-data.ts a partir do config curado.
 * Uso: node scripts/generate-gh-cap4-feat-passives.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';
import {
  GH_CAP4_FEAT_PASSIVE_NOTES,
  GH_CAP4_ECONOMY_ONLY_FEATS,
} from './lib/ghpg-cap4-feat-passive-config.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap4Path = extracts.grimHollow.cap4Feats;
const outPath = path.join(
  apiRoot,
  'src/game/combat/domain/grim-hollow-feat-combat-notes-data.ts',
);

const cap4 = JSON.parse(fs.readFileSync(cap4Path, 'utf8'));
const cap4Slugs = cap4.feats.map((f) => f.slug);
const configSlugs = Object.keys(GH_CAP4_FEAT_PASSIVE_NOTES);

const missing = cap4Slugs.filter(
  (s) => !configSlugs.includes(s) && !GH_CAP4_ECONOMY_ONLY_FEATS.has(s),
);
const extra = configSlugs.filter((s) => !cap4Slugs.includes(s));

if (missing.length) {
  console.error('Slugs sem passivos no config:', missing);
  process.exit(1);
}
if (extra.length) {
  console.warn('Slugs extras no config (ignorados):', extra);
}

function formatNotesBlock(slug, notes) {
  const lines = notes.map((n) => `    ${JSON.stringify(n)},`).join('\n');
  return `  ${JSON.stringify(slug)}: [\n${lines}\n  ],`;
}

const blocks = cap4Slugs
  .filter((slug) => (GH_CAP4_FEAT_PASSIVE_NOTES[slug] ?? []).length > 0)
  .map((slug) => formatNotesBlock(slug, GH_CAP4_FEAT_PASSIVE_NOTES[slug]));

const content = `/** Gerado por scripts/generate-gh-cap4-feat-passives.mjs — não editar à mão. */
export const GH_CAP4_FEAT_PASSIVE_NOTES: Record<string, readonly string[]> = {
${blocks.join('\n')}
};

/** Feats com mecânica só na aba Ações (C075). */
export const GH_CAP4_ECONOMY_ONLY_FEATS = new Set<string>([
${[...GH_CAP4_ECONOMY_ONLY_FEATS].map((s) => `  ${JSON.stringify(s)},`).join('\n')}
]);
`;

fs.writeFileSync(outPath, content, 'utf8');

const withNotes = cap4Slugs.filter(
  (s) => (GH_CAP4_FEAT_PASSIVE_NOTES[s] ?? []).length > 0,
).length;

console.log(`Wrote ${outPath}`);
console.log(`  feats: ${cap4Slugs.length}, com passivos: ${withNotes}, economy-only: ${GH_CAP4_ECONOMY_ONLY_FEATS.size}`);
