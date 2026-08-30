/**
 * Copia retratos de subclasses GH Cap. 2 para public/catalog/subclasses/
 * e gera database/seeds/grim-hollow/J034_catalog_subclass_images.sql
 *
 * Uso: node scripts/import-ghpg-cap2-subclass-images.mjs [--seeds-only]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts, scrap } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const extractPath = extracts.grimHollow.cap2SubclassesEn;
const outDir = path.join(apiRoot, 'public/catalog/subclasses');
const seedPath = path.join(
  apiRoot,
  'database/seeds/grim-hollow/J034_catalog_subclass_images.sql',
);

const args = new Set(process.argv.slice(2));
const seedsOnly = args.has('--seeds-only');

function findChapter2FilesDir() {
  for (const base of [scrap.grimHollow, path.join(apiRoot, 'docs/source/scrap')]) {
    if (!fs.existsSync(base)) continue;
    const chapterDir = fs
      .readdirSync(base)
      .find((name) => name.includes('Chapter 2') && name.endsWith('_files'));
    if (chapterDir) return path.join(base, chapterDir);
  }
  return null;
}

if (!fs.existsSync(extractPath)) {
  console.error(`Extract ausente: ${extractPath}`);
  console.error('Rode: node scripts/extract-ghpg-cap2.mjs');
  process.exit(1);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const sourceDir = findChapter2FilesDir();
if (!sourceDir && !seedsOnly) {
  console.warn('Pasta _files do Cap. 2 GHPG não encontrada — use --seeds-only se PNGs já foram importados.');
}

fs.mkdirSync(outDir, { recursive: true });

/** @type {string[]} */
const updates = [];
let copied = 0;

for (const sc of extract.subclasses ?? []) {
  if (!sc.imageFile) continue;
  const dest = `${sc.slug}.png`;
  const from = sourceDir ? path.join(sourceDir, sc.imageFile) : null;
  const to = path.join(outDir, dest);
  if (!seedsOnly && from) {
    if (!fs.existsSync(from)) {
      console.warn(`  aviso: ${sc.imageFile} ausente`);
    } else {
      fs.copyFileSync(from, to);
      copied += 1;
      console.log(`  ${sc.imageFile} → catalog/subclasses/${dest}`);
    }
  }
  updates.push(
    `UPDATE rpg.phb_subclass SET image_url = '/catalog/subclasses/${dest}' WHERE slug = '${sc.slug}';`,
  );
}

const sql = `-- Grim Hollow Cap. 2 — image_url em phb_subclass
-- Gerado por scripts/import-ghpg-cap2-subclass-images.mjs

${updates.join('\n')}
`;

fs.writeFileSync(seedPath, sql, 'utf8');
console.log(
  `Seed ${path.relative(apiRoot, seedPath)} (${updates.length} subclasses, ${copied} PNGs copiados)`,
);
