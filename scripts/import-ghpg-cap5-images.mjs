/**
 * Copia ilustrações do scrape GHPG Cap. 5 para public/catalog/equipment/
 * e gera database/seeds/grim-hollow/J008_catalog_images.sql
 *
 * Uso:
 *   node scripts/import-ghpg-cap5-images.mjs
 *   node scripts/import-ghpg-cap5-images.mjs --seeds-only
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const args = new Set(process.argv.slice(2));
const seedsOnly = args.has('--seeds-only');

import { extracts, scrapes } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const grimDir = scrapes.grimHollow;
const outDir = path.join(apiRoot, 'public/catalog/equipment');
const seedPath = path.join(apiRoot, 'database/seeds/grim-hollow/J008_catalog_images.sql');

/** @type {Array<{ slug: string; src: string; dest: string }>} */
const IMAGE_MAP = [
  { slug: 'catchpole', src: '06-004.catchpole.png', dest: 'catchpole.png' },
  { slug: 'smoke-bomb', src: '06-002.smoke-bomb.png', dest: 'smoke-bomb.png' },
  { slug: 'fire-bomb', src: '06-001.advanced-equipment.png', dest: 'fire-bomb.png' },
];

function findChapter5FilesDir() {
  const chapterDir = fs
    .readdirSync(grimDir)
    .find((name) => name.startsWith('Chapter 5') && name.endsWith('_files'));
  if (!chapterDir) {
    throw new Error('Pasta _files do Cap. 5 GHPG não encontrada');
  }
  return path.join(grimDir, chapterDir);
}

const sourceDir = findChapter5FilesDir();
fs.mkdirSync(outDir, { recursive: true });

if (!seedsOnly) {
  for (const { src, dest } of IMAGE_MAP) {
    const from = path.join(sourceDir, src);
    const to = path.join(outDir, dest);
    if (!fs.existsSync(from)) {
      console.warn(`  aviso: origem ausente ${src}`);
      continue;
    }
    fs.copyFileSync(from, to);
    console.log(`  ${src} → public/catalog/equipment/${dest}`);
  }
}

const updates = IMAGE_MAP.map(
  ({ slug, dest }) =>
    `UPDATE rpg.phb_item SET image_url = '/catalog/equipment/${dest}' WHERE slug = '${slug}';`,
);

const sql = `-- Grim Hollow Cap. 5 — image_url em phb_item
-- Gerado por scripts/import-ghpg-cap5-images.mjs

${updates.join('\n')}
`;

fs.mkdirSync(path.dirname(seedPath), { recursive: true });
fs.writeFileSync(seedPath, sql);
console.log(`Seed: ${path.relative(apiRoot, seedPath)}`);
