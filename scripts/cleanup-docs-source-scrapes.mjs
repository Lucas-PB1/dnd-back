/**
 * Limpa scrapes D&D Beyond em docs/source:
 * - Extrai PNGs de montarias → docs/source/montarias/images/{slug}.png
 * - Extrai ilustrações PHB equipamento (07-*.png) → docs/source/phb-equipment-images/
 * - Remove HTML, pastas *_files, JS/CSS/.download e demais lixo do scrape
 *
 * Uso: node scripts/cleanup-docs-source-scrapes.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sourceRoot = path.join(__dirname, '../docs/source');

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
  const montariasDir = path.join(sourceRoot, 'montarias');
  const outDir = path.join(montariasDir, 'images');
  ensureDir(outDir);

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
  const entries = fs.readdirSync(sourceRoot);
  const filesDir = entries.find(
    (name) => name.includes('Equipment') && name.endsWith('_files'),
  );
  if (!filesDir) {
    console.log('Pasta Equipment _files não encontrada — pulando equipamento.');
    return [];
  }

  const srcDir = path.join(sourceRoot, filesDir);
  const outDir = path.join(sourceRoot, 'phb-equipment-images');
  ensureDir(outDir);

  const copied = [];
  for (const name of fs.readdirSync(srcDir)) {
    if (!/^07-\d+\./.test(name) || !name.endsWith('.png')) continue;
    const dest = path.join(outDir, name);
    copyFile(path.join(srcDir, name), dest);
    copied.push(name);
    console.log(`equipamento: ${name}`);
  }
  return copied;
}

function removeScrapeArtifacts() {
  const removed = [];

  for (const name of fs.readdirSync(sourceRoot)) {
    const full = path.join(sourceRoot, name);
    if (name.endsWith('.html')) {
      rmrf(full);
      removed.push(name);
      continue;
    }
    if (name.endsWith('_files')) {
      rmrf(full);
      removed.push(name);
    }
  }

  const montariasDir = path.join(sourceRoot, 'montarias');
  if (fs.existsSync(montariasDir)) {
    for (const name of fs.readdirSync(montariasDir)) {
      if (name === 'images') continue;
      const full = path.join(montariasDir, name);
      if (name.endsWith('.html') || name.endsWith('_files')) {
        rmrf(full);
        removed.push(`montarias/${name}`);
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
