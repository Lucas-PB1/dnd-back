/**
 * Copia ilustrações do scrape GHPG Cap. 5 + aplica fallbacks PHB.
 * Gera database/seeds/grim-hollow/J008_catalog_images.sql e
 * docs/source/extracts/grim-hollow/cap5-advanced-equipment-images.json
 *
 * Uso:
 *   node scripts/import-ghpg-cap5-images.mjs
 *   node scripts/import-ghpg-cap5-images.mjs --seeds-only
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import {
  SCRAPE_IMAGE_BUNDLES,
  buildCap5ImageManifest,
  resolveCap5ImagePath,
} from './lib/ghpg-cap5-image-fallbacks.mjs';
import { extracts, scrap, scrapes } from './lib/docs-source.mjs';

const args = new Set(process.argv.slice(2));
const seedsOnly = args.has('--seeds-only');

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const outDir = path.join(apiRoot, 'public/catalog/equipment');
const seedPath = path.join(apiRoot, 'database/seeds/grim-hollow/J008_catalog_images.sql');
const manifestPath = extracts.grimHollow.cap5AdvancedEquipmentImages;
const extractPath = extracts.grimHollow.cap5AdvancedEquipment;

function findChapter5FilesDir() {
  for (const grimDir of [scrap.grimHollow, scrapes.grimHollow, path.join(apiRoot, 'docs/source/scrap')]) {
    if (!grimDir || !fs.existsSync(grimDir)) continue;
    const chapterDir = fs
      .readdirSync(grimDir)
      .find((name) => name.startsWith('Chapter 5') && name.endsWith('_files'));
    if (chapterDir) return path.join(grimDir, chapterDir);
  }
  return null;
}

function loadCatalogSlugs() {
  const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
  const slugs = [
    ...(extract.meleeWeapons ?? []).map((row) => row.slug),
    ...(extract.rangedWeapons ?? []).map((row) => row.slug),
    ...(extract.equipment ?? []).map((row) => row.slug),
    ...(extract.ammunition ?? []).map((row) => row.slug),
  ];
  return [...new Set(slugs)].sort();
}

if (!fs.existsSync(extractPath)) {
  console.error(`Extract ausente: ${extractPath}`);
  process.exit(1);
}

const catalogSlugs = loadCatalogSlugs();
const sourceDir = findChapter5FilesDir();
fs.mkdirSync(outDir, { recursive: true });

let copied = 0;
if (!seedsOnly && sourceDir) {
  for (const bundle of SCRAPE_IMAGE_BUNDLES) {
    const from = path.join(sourceDir, bundle.src);
    const to = path.join(outDir, bundle.dest);
    if (!fs.existsSync(from)) {
      console.warn(`  aviso: origem ausente ${bundle.src}`);
      continue;
    }
    fs.copyFileSync(from, to);
    copied += 1;
    console.log(`  ${bundle.src} → public/catalog/equipment/${bundle.dest} (${bundle.slugs.length} slugs)`);
  }
} else if (!seedsOnly && !sourceDir) {
  console.warn('Pasta _files do Cap. 5 não encontrada — só fallbacks PHB no seed.');
}

const manifest = buildCap5ImageManifest(catalogSlugs);
fs.mkdirSync(path.dirname(manifestPath), { recursive: true });
fs.writeFileSync(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`);

const updates = catalogSlugs
  .map((slug) => {
    const imageUrl = resolveCap5ImagePath(slug);
    if (!imageUrl) return null;
    return `UPDATE rpg.phb_item SET image_url = '${imageUrl}' WHERE slug = '${slug}';`;
  })
  .filter(Boolean);

const uncovered = catalogSlugs.filter((slug) => !manifest.items[slug]);
if (uncovered.length > 0) {
  console.warn(`  aviso: ${uncovered.length} slugs sem imagem: ${uncovered.join(', ')}`);
}

const sql = `-- Grim Hollow Cap. 5 — image_url em phb_item
-- Gerado por scripts/import-ghpg-cap5-images.mjs
-- Cobertura: ${manifest.covered}/${manifest.total} (${copied} PNG/JPG copiados do scrape)

${updates.join('\n')}
`;

fs.mkdirSync(path.dirname(seedPath), { recursive: true });
fs.writeFileSync(seedPath, sql);
console.log(`Manifest: ${path.relative(apiRoot, manifestPath)}`);
console.log(`Seed: ${path.relative(apiRoot, seedPath)} (${updates.length} itens)`);
