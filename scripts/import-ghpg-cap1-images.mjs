/**
 * Copia retratos de heranças GH Cap. 1 para public/catalog/species/
 * e gera database/seeds/grim-hollow/J013_catalog_heritage_images.sql
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts, scrapes } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const grimDir = scrapes.grimHollow;
const extractPath = extracts.grimHollow.cap1Heritages;
const outDir = path.join(apiRoot, 'public/catalog/species');
const seedPath = path.join(apiRoot, 'database/seeds/grim-hollow/J013_catalog_heritage_images.sql');

const args = new Set(process.argv.slice(2));
const seedsOnly = args.has('--seeds-only');

function findChapter1FilesDir() {
  const chapterDir = fs
    .readdirSync(grimDir)
    .find((name) => name.startsWith('Chapter 1') && name.endsWith('_files'));
  if (!chapterDir) throw new Error('Pasta _files do Cap. 1 GHPG não encontrada');
  return path.join(grimDir, chapterDir);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const sourceDir = findChapter1FilesDir();
fs.mkdirSync(outDir, { recursive: true });

/** @type {string[]} */
const updates = [];

for (const h of extract.heritages) {
  if (!h.imageFile) continue;
  const dest = `${h.slug.replace(/^gh-/, '')}.png`;
  const from = path.join(sourceDir, h.imageFile);
  const to = path.join(outDir, dest);
  if (!seedsOnly) {
    if (!fs.existsSync(from)) {
      console.warn(`  aviso: ${h.imageFile} ausente`);
      continue;
    }
    fs.copyFileSync(from, to);
    console.log(`  ${h.imageFile} → catalog/species/${dest}`);
  }
  updates.push(
    `UPDATE rpg.phb_species SET image_url = '/catalog/species/${dest}' WHERE slug = '${h.slug}';`,
  );
}

const sql = `-- Grim Hollow Cap. 1 — image_url em phb_species (heritages)
-- Gerado por scripts/import-ghpg-cap1-images.mjs

${updates.join('\n')}
`;

fs.writeFileSync(seedPath, sql, 'utf8');
console.log(`Seed ${path.relative(apiRoot, seedPath)}`);
