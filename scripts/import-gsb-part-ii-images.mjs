/**
 * Copia ilustrações do scrape GSB Part II para public/catalog/
 * e gera database/seeds/griffons-saddlebag/R009_catalog_images.sql
 *
 * Uso:
 *   node scripts/import-gsb-part-ii-images.mjs
 *   node scripts/import-gsb-part-ii-images.mjs --seeds-only
 *   node scripts/import-gsb-part-ii-images.mjs --prune-source
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const args = new Set(process.argv.slice(2));
const pruneSource = args.has('--prune-source');
const seedsOnly = args.has('--seeds-only');

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const sourceRoot = path.join(apiRoot, 'docs/source');
const speciesOutDir = path.join(apiRoot, 'public/catalog/species');
const subclassesOutDir = path.join(apiRoot, 'public/catalog/subclasses');
const seedPath = path.join(
  apiRoot,
  'database/seeds/griffons-saddlebag/R009_catalog_images.sql',
);

/** @type {Array<{ slug: string; table: 'species' | 'subclass'; src: string; outDir: 'species' | 'subclasses' }>} */
const IMAGE_MAP = [
  {
    slug: 'feathren',
    table: 'species',
    src: '12-03.feathren.png',
    outDir: 'species',
  },
  {
    slug: 'path-of-the-glacier',
    table: 'subclass',
    src: '12-07.barbarian-path-of-the-glacier.png',
    outDir: 'subclasses',
  },
  {
    slug: 'college-of-choreography',
    table: 'subclass',
    src: '12-09.bard-college-of-choreography.png',
    outDir: 'subclasses',
  },
  {
    slug: 'astral-domain',
    table: 'subclass',
    src: '12-10.cleric-astral-domain.png',
    outDir: 'subclasses',
  },
  {
    slug: 'the-unbroken-circle',
    table: 'subclass',
    src: '12-12.druid-the-unbroken-circle.png',
    outDir: 'subclasses',
  },
  {
    slug: 'couatl-herald',
    table: 'subclass',
    src: '12-14.fighter-couatl-herald.png',
    outDir: 'subclasses',
  },
  {
    slug: 'warrior-of-the-celestial',
    table: 'subclass',
    src: '12-15.monk-warrior-of-the-celestial.png',
    outDir: 'subclasses',
  },
  {
    slug: 'oath-of-the-hearth',
    table: 'subclass',
    src: '12-16.paladin-oath-of-the-hearth.png',
    outDir: 'subclasses',
  },
  {
    slug: 'winter-trapper',
    table: 'subclass',
    src: '12-18.ranger-winter-trapper-background.png',
    outDir: 'subclasses',
  },
  {
    slug: 'runetagger',
    table: 'subclass',
    src: '12-21.rogue-runetagger.png',
    outDir: 'subclasses',
  },
  {
    slug: 'frost-sorcery',
    table: 'subclass',
    src: '12-23.sorcerer-frost-sorcery.png',
    outDir: 'subclasses',
  },
  {
    slug: 'astral-griffon-patron',
    table: 'subclass',
    src: '12-24.warlock-the-astral-griffon.png',
    outDir: 'subclasses',
  },
  {
    slug: 'materializer',
    table: 'subclass',
    src: '12-25.wizard-materializer.png',
    outDir: 'subclasses',
  },
];

function findSourceFilesDir() {
  const dir = fs
    .readdirSync(sourceRoot)
    .find(
      (name) =>
        name.includes('Part II_ Character Options') && name.endsWith('_files'),
    );
  if (!dir) {
    throw new Error(
      'Pasta _files do scrape GSB Part II não encontrada em docs/source',
    );
  }
  return path.join(sourceRoot, dir);
}

function outDirFor(kind) {
  return kind === 'species' ? speciesOutDir : subclassesOutDir;
}

function writeSeed(imported) {
  const lines = [
    "-- GSB Book One Part II — image_url em phb_species e phb_subclass",
    '-- Gerado por scripts/import-gsb-part-ii-images.mjs',
    '',
  ];

  for (const row of imported) {
    const table =
      row.table === 'species' ? 'rpg.phb_species' : 'rpg.phb_subclass';
    lines.push(
      `UPDATE ${table} SET image_url = '${row.publicPath}' WHERE slug = '${row.slug}';`,
    );
  }
  lines.push('');

  fs.writeFileSync(seedPath, lines.join('\n'));
  console.log(`\nSeed: ${seedPath}`);
}

function loadFromPublic() {
  return IMAGE_MAP.map((entry) => {
    const dest = path.join(outDirFor(entry.outDir), `${entry.slug}.png`);
    if (!fs.existsSync(dest)) {
      throw new Error(`PNG ausente no public: ${dest}`);
    }
    return {
      slug: entry.slug,
      table: entry.table,
      publicPath: `/catalog/${entry.outDir}/${entry.slug}.png`,
      sourceFile: null,
    };
  });
}

function pruneSourceImages(imported) {
  for (const row of imported) {
    if (!row.sourceFile) continue;
    if (fs.existsSync(row.sourceFile)) {
      fs.unlinkSync(row.sourceFile);
      console.log(`removido: ${path.relative(apiRoot, row.sourceFile)}`);
    }
  }
}

fs.mkdirSync(speciesOutDir, { recursive: true });
fs.mkdirSync(subclassesOutDir, { recursive: true });

const imported = [];

if (!seedsOnly) {
  const sourceFilesDir = findSourceFilesDir();

  for (const entry of IMAGE_MAP) {
    const sourcePng = path.join(sourceFilesDir, entry.src);
    const dest = path.join(outDirFor(entry.outDir), `${entry.slug}.png`);

    if (!fs.existsSync(sourcePng)) {
      throw new Error(`PNG ausente no scrape: ${sourcePng}`);
    }

    fs.copyFileSync(sourcePng, dest);
    imported.push({
      slug: entry.slug,
      table: entry.table,
      publicPath: `/catalog/${entry.outDir}/${entry.slug}.png`,
      sourceFile: sourcePng,
    });
    console.log(`✓ ${entry.slug} ← ${entry.src}`);
  }
} else {
  imported.push(...loadFromPublic());
}

writeSeed(imported);

if (pruneSource && !seedsOnly) {
  pruneSourceImages(imported);
}

console.log(
  `\nImagens: species=${speciesOutDir}, subclasses=${subclassesOutDir} (${imported.length} arquivos)`,
);
