/**
 * Limpa scrapes D&D Beyond em docs/source:
 * - Extrai PNGs de montarias → _assets/montarias/images/{slug}.png
 * - Extrai ilustrações PHB equipamento (07-*.png) → _assets/phb-equipment/
 * - Remove HTML, pastas *_files e lixo de scrape
 *
 * Uso:
 *   node scripts/cleanup-docs-source-scrapes.mjs
 *   node scripts/cleanup-docs-source-scrapes.mjs --purge-all-scrapes
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { assets, docsSource, scrapesDir } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sourceRoot = docsSource;
const purgeAll = process.argv.includes('--purge-all-scrapes');

const DDB_NAME_TO_SLUG = {
  Camel: 'camelo',
  Elephant: 'elefante',
  'Draft Horse': 'cavalo-de-carga',
  'Riding Horse': 'cavalo-de-montaria',
  Mastiff: 'mastim',
  Mule: 'mula',
  Pony: 'ponei',
  Warhorse: 'cavalo-de-guerra',
};

function decodeHtml(value) {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"');
}

function rmrf(target) {
  if (!fs.existsSync(target)) return;
  const stat = fs.statSync(target);
  if (stat.isDirectory()) {
    for (const entry of fs.readdirSync(target)) {
      rmrf(path.join(target, entry));
    }
    fs.rmdirSync(target);
    return;
  }
  fs.unlinkSync(target);
}

function ensureDir(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function copyFile(src, dest) {
  ensureDir(path.dirname(dest));
  fs.copyFileSync(src, dest);
}

function extractMountImages() {
  const montariasDir = assets.montarias;
  const outDir = assets.montariasImages;
  ensureDir(outDir);

  if (!fs.existsSync(montariasDir)) return [];

  const htmlFiles = fs
    .readdirSync(montariasDir)
    .filter((name) => name.endsWith('.html'));

  const imported = [];

  for (const file of htmlFiles) {
    const htmlPath = path.join(montariasDir, file);
    const html = fs.readFileSync(htmlPath, 'utf8');
    const match = html.match(/<img\b[^>]*class="monster-image"[^>]*>/i);
    if (!match) {
      console.warn(`Sem monster-image: ${file}`);
      continue;
    }
    const tag = match[0];
    const srcMatch = tag.match(/\bsrc="([^"]+)"/i);
    const altMatch = tag.match(/\balt="([^"]*)"/i);
    if (!srcMatch || !altMatch) continue;

    const slug = DDB_NAME_TO_SLUG[decodeHtml(altMatch[1]).trim()];
    if (!slug) {
      console.warn(`Slug desconhecido: ${file} alt=${altMatch[1]}`);
      continue;
    }

    const relative = decodeHtml(srcMatch[1]).replace(/^\.\//, '');
    const sourcePng = path.normalize(path.join(path.dirname(htmlPath), relative));
    if (!fs.existsSync(sourcePng)) {
      console.warn(`PNG ausente: ${sourcePng}`);
      continue;
    }

    const dest = path.join(outDir, `${slug}.png`);
    copyFile(sourcePng, dest);
    imported.push({ slug, source: path.relative(sourceRoot, sourcePng) });
    console.log(`montaria: ${slug} ← ${path.basename(sourcePng)}`);
  }

  return imported;
}

function extractEquipmentImages() {
  const outDir = assets.phbEquipment;
  ensureDir(outDir);

  const searchRoots = [scrapesDir, path.join(sourceRoot, 'new'), sourceRoot];
  let filesDir = null;

  for (const root of searchRoots) {
    if (!fs.existsSync(root)) continue;
    const hit = fs
      .readdirSync(root, { withFileTypes: true })
      .find((entry) => entry.isDirectory() && entry.name.includes('Equipment') && entry.name.endsWith('_files'));
    if (hit) {
      filesDir = path.join(root, hit.name);
      break;
    }
  }

  if (!filesDir) {
    console.log('Pasta Equipment _files não encontrada — pulando equipamento.');
    return [];
  }

  const copied = [];
  for (const name of fs.readdirSync(filesDir)) {
    if (!/^07-\d+\./.test(name) || !name.endsWith('.png')) continue;
    const dest = path.join(outDir, name);
    copyFile(path.join(filesDir, name), dest);
    copied.push(name);
    console.log(`equipamento: ${name}`);
  }
  return copied;
}

function removeScrapeArtifacts() {
  const removed = [];

  const roots = [sourceRoot, scrapesDir, path.join(sourceRoot, 'new')];
  for (const root of roots) {
    if (!fs.existsSync(root)) continue;
    for (const name of fs.readdirSync(root)) {
      const full = path.join(root, name);
      if (name.endsWith('.html')) {
        rmrf(full);
        removed.push(path.relative(sourceRoot, full));
        continue;
      }
      if (name.endsWith('_files')) {
        rmrf(full);
        removed.push(path.relative(sourceRoot, full));
      }
    }
  }

  const montariasDir = assets.montarias;
  if (fs.existsSync(montariasDir)) {
    for (const name of fs.readdirSync(montariasDir)) {
      if (name === 'images') continue;
      const full = path.join(montariasDir, name);
      if (name.endsWith('.html') || name.endsWith('_files')) {
        rmrf(full);
        removed.push(path.relative(sourceRoot, full));
      }
    }
  }

  if (purgeAll) {
    for (const legacy of ['new', '_scrapes']) {
      const full = path.join(sourceRoot, legacy);
      if (fs.existsSync(full)) {
        rmrf(full);
        removed.push(legacy);
      }
    }
  }

  return removed;
}

const mounts = extractMountImages();
const equipment = extractEquipmentImages();
const removed = removeScrapeArtifacts();

console.log(`\nMontarias extraídas: ${mounts.length}`);
console.log(`Imagens equipamento: ${equipment.length}`);
console.log(`Artefatos removidos: ${removed.length}`);
for (const item of removed) {
  console.log(`  - ${item}`);
}
