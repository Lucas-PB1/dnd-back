/**
 * Extrai PNGs das exportações D&D Beyond em docs/source/_assets/montarias
 * e copia para dnd-api/public/catalog/mounts/{slug}.png
 *
 * Uso:
 *   node scripts/import-phb-mount-images.mjs
 *   node scripts/import-phb-mount-images.mjs --prune-source
 *   node scripts/import-phb-mount-images.mjs --seeds-only
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { assets, extracts } from './lib/docs-source.mjs';

const args = new Set(process.argv.slice(2));
const pruneSource = args.has('--prune-source');
const seedsOnly = args.has('--seeds-only');

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const sourceDir = assets.montarias;
const sourceImagesDir = assets.montariasImages;
const outDir = path.join(apiRoot, 'public/catalog/mounts');
const extractPath = extracts.phb.cap6Mounts;

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

function extractImageFromHtml(htmlPath) {
  const html = fs.readFileSync(htmlPath, 'utf8');
  const match = html.match(
    /<img\b[^>]*class="monster-image"[^>]*>/i,
  );
  if (!match) return null;
  const tag = match[0];
  const srcMatch = tag.match(/\bsrc="([^"]+)"/i);
  const altMatch = tag.match(/\balt="([^"]*)"/i);
  if (!srcMatch || !altMatch) return null;
  return { src: decodeHtml(srcMatch[1]), alt: decodeHtml(altMatch[1]) };
}

function resolveSourceFile(htmlPath, src) {
  const relative = src.replace(/^\.\//, '');
  const decoded = decodeHtml(relative);
  const base = path.dirname(htmlPath);
  const candidate = path.normalize(path.join(base, decoded));
  if (!candidate.startsWith(sourceDir)) {
    throw new Error(`Caminho inválido fora de montarias: ${candidate}`);
  }
  return candidate;
}

function writeSeeds(imported) {
  const itemSeedLines = [
    '-- PHB montarias — image_url em phb_item (itens da loja; templates em creatures/M006)',
    '-- Gerado por scripts/import-phb-mount-images.mjs',
    '',
  ];
  const creatureSeedLines = [
    '-- PHB montarias — image_url em phb_creature_template (após M005)',
    '-- Gerado por scripts/import-phb-mount-images.mjs',
    '',
  ];
  for (const row of imported) {
    creatureSeedLines.push(
      `UPDATE rpg.phb_creature_template SET image_url = '${row.publicPath}' WHERE slug = '${row.slug}';`,
    );
    itemSeedLines.push(
      `UPDATE rpg.phb_item SET image_url = '${row.publicPath}' WHERE slug = '${row.slug}';`,
    );
  }
  itemSeedLines.push('');
  creatureSeedLines.push('');

  const itemSeedPath = path.join(apiRoot, 'database/seeds/phb/S079_phb_mount_images.sql');
  const creatureSeedPath = path.join(
    apiRoot,
    'database/seeds/creatures/M006_phb_mount_images.sql',
  );
  fs.writeFileSync(itemSeedPath, itemSeedLines.join('\n'));
  fs.writeFileSync(creatureSeedPath, creatureSeedLines.join('\n'));
  console.log(`\nSeeds: ${itemSeedPath}`);
  console.log(`       ${creatureSeedPath}`);
}

function pruneSourceImages(imported) {
  for (const row of imported) {
    if (!row.sourceFile) continue;
    const full = path.join(apiRoot, row.sourceFile);
    if (fs.existsSync(full)) {
      fs.unlinkSync(full);
      console.log(`removido: ${row.sourceFile}`);
    }
  }
}

function loadFromPublic(extract) {
  return extract.mounts
    .filter((mount) => mount.imageUrl)
    .map((mount) => {
      const fileName = path.basename(mount.imageUrl);
      const publicFile = path.join(outDir, fileName);
      if (!fs.existsSync(publicFile)) {
        throw new Error(`PNG ausente no public: ${publicFile}`);
      }
      return {
        slug: mount.itemSlug,
        nameEn: mount.itemSlug,
        publicPath: mount.imageUrl,
        sourceFile: null,
      };
    });
}

fs.mkdirSync(outDir, { recursive: true });

const imported = [];

const imageFiles = fs.existsSync(sourceImagesDir)
  ? fs.readdirSync(sourceImagesDir).filter((name) => name.endsWith('.png'))
  : [];

if (imageFiles.length > 0) {
  for (const file of imageFiles) {
    const slug = path.basename(file, '.png');
    const sourcePng = path.join(sourceImagesDir, file);
    const dest = path.join(outDir, `${slug}.png`);
    fs.copyFileSync(sourcePng, dest);
    imported.push({
      slug,
      nameEn: slug,
      publicPath: `/catalog/mounts/${slug}.png`,
      sourceFile: path.relative(apiRoot, sourcePng),
    });
    console.log(`✓ ${slug} ← images/${file}`);
  }
} else {
  const htmlFiles = fs
    .readdirSync(sourceDir)
    .filter((name) => name.endsWith('.html'));

  for (const file of htmlFiles) {
    const htmlPath = path.join(sourceDir, file);
    const image = extractImageFromHtml(htmlPath);
    if (!image) {
      console.warn(`Sem monster-image em ${file}`);
      continue;
    }
    const slug = DDB_NAME_TO_SLUG[image.alt.trim()];
    if (!slug) {
      console.warn(`Slug desconhecido para alt="${image.alt}" em ${file}`);
      continue;
    }
    const sourcePng = resolveSourceFile(htmlPath, image.src);
    if (!fs.existsSync(sourcePng)) {
      console.warn(`PNG ausente: ${sourcePng}`);
      continue;
    }
    const dest = path.join(outDir, `${slug}.png`);
    fs.copyFileSync(sourcePng, dest);
    imported.push({
      slug,
      nameEn: image.alt.trim(),
      publicPath: `/catalog/mounts/${slug}.png`,
      sourceFile: path.relative(apiRoot, sourcePng),
    });
    console.log(`✓ ${slug} ← ${path.basename(sourcePng)}`);
  }
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));

if (imported.length === 0) {
  if (seedsOnly) {
    const fromPublic = loadFromPublic(extract);
    writeSeeds(fromPublic);
    console.log(`\nImagens: ${outDir} (${fromPublic.length} arquivos, seeds-only)`);
    process.exit(0);
  }
  throw new Error(
    'Nenhuma imagem importada — verifique docs/source/_assets/montarias ou use --seeds-only',
  );
}

extract.mounts = extract.mounts.map((mount) => {
  const row = imported.find((item) => item.slug === mount.itemSlug);
  return row ? { ...mount, imageUrl: row.publicPath } : mount;
});
extract.imagesImportedAt = new Date().toISOString();
fs.writeFileSync(extractPath, `${JSON.stringify(extract, null, 2)}\n`);

writeSeeds(imported);

if (pruneSource) {
  pruneSourceImages(imported);
}

console.log(`Imagens: ${outDir} (${imported.length} arquivos)`);
