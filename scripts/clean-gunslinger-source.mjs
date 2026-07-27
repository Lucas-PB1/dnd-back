/**
 * Organiza o dump Beyond do Gunslinger em docs/sources/valda-gunslinger/
 * Uso: node scripts/clean-gunslinger-source.mjs
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');
const sources = path.join(root, 'docs/sources');
const outDir = path.join(sources, 'valda-gunslinger');
const imagesDir = path.join(outDir, 'images');

const entries = fs.readdirSync(sources);
const htmlName = entries.find(
  (e) => e.includes('Gunslinger') && e.endsWith('.html'),
);
const filesName = entries.find(
  (e) => e.includes('Gunslinger') && e.endsWith('_files'),
);

if (!htmlName || !filesName) {
  console.error('Dump Gunslinger não encontrado em docs/sources');
  process.exit(1);
}

const htmlPath = path.join(sources, htmlName);
const filesDir = path.join(sources, filesName);

fs.mkdirSync(imagesDir, { recursive: true });

let html = fs.readFileSync(htmlPath, 'utf8');

// Keep article content; rewrite local image refs to images/
const imgExt = /\.(png|jpe?g|gif|webp|svg)$/i;
const fileEntries = fs.readdirSync(filesDir, { withFileTypes: true });
const imageFiles = [];

function walk(dir) {
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) walk(full);
    else if (imgExt.test(ent.name)) imageFiles.push(full);
  }
}
walk(filesDir);

let imgIndex = 0;
const copied = new Map();
for (const full of imageFiles) {
  const base = path.basename(full);
  // Skip tiny chrome / icons if under 5kb and not content-looking
  const size = fs.statSync(full).size;
  if (size < 8_000 && !/gun|class|cover|deed|trick|firearm/i.test(base)) {
    continue;
  }
  imgIndex += 1;
  const safe = base
    .toLowerCase()
    .replace(/[^a-z0-9._-]+/g, '-')
    .replace(/-+/g, '-');
  const destName = `${String(imgIndex).padStart(2, '0')}-${safe}`;
  const dest = path.join(imagesDir, destName);
  fs.copyFileSync(full, dest);
  copied.set(base, destName);
}

// Rewrite src attributes that point at _files folder
const filesEsc = filesName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
html = html.replace(
  new RegExp(`${filesEsc}[/\\\\]([^"'\\s>]+)`, 'gi'),
  (match, filePart) => {
    const base = path.basename(decodeURIComponent(filePart));
    const mapped = copied.get(base);
    return mapped ? `images/${mapped}` : match;
  },
);

// Prefer article content wrapper if present; else keep full cleaned html
fs.writeFileSync(path.join(outDir, 'page.html'), html, 'utf8');

const readme = `# Valda’s Spire of Secrets — The Gunslinger Class

Fonte salva (compra D&D Beyond / Mage Hand Press) para ingestão no catálogo Grimoire.

## Conteúdo desta pasta

| Arquivo / pasta | Uso |
|-----------------|-----|
| [\`page.html\`](page.html) | Página salva do Beyond |
| [\`images/\`](images/) | Arte do pack |
| [\`extracted.json\`](extracted.json) | Extração estruturada (fonte dos seeds) |
| [\`INVENTORY.md\`](INVENTORY.md) | Inventário legível |

Edição: \`valda-spire-2024-en\` · citação: \`valda-spire-2024-en:gunslinger\`

## Pipeline

\`\`\`bash
node scripts/extract-gunslinger-source.mjs
node scripts/generate-gunslinger-seeds.mjs
npm run db:seed:gunslinger
\`\`\`

Uso interno do projeto; respeitar direitos do publisher.
`;

fs.writeFileSync(path.join(outDir, 'README.md'), readme, 'utf8');

console.log({
  outDir: path.relative(root, outDir),
  images: copied.size,
  htmlBytes: html.length,
});
console.log('Raw dump left in place — delete manually after verifying.');
