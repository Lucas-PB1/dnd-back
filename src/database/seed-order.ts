import fs from 'fs';
import path from 'path';

const SEED_DOMAINS = [
  'catalog',
  'class',
  'subclass',
  'species',
  'feat',
  'transformation',
  'heritage',
  'thread',
  'background',
  'item',
  'spell',
  'economy',
  'creature',
  'effect',
  'notes',
];

export type SeedFile = { version: string; filePath: string };

export function resolveSeedsDir(rootDir: string): string {
  return path.join(rootDir, 'database/seeds');
}

export function truncateSeedPath(seedsDir: string): string | null {
  const truncate = path.join(seedsDir, '000_truncate.sql');
  return fs.existsSync(truncate) ? truncate : null;
}

export function listCatalogSeedFiles(seedsDir: string): SeedFile[] {
  const orderFile = path.join(seedsDir, 'SEED_ORDER.txt');
  if (fs.existsSync(orderFile)) {
    const lines = fs
      .readFileSync(orderFile, 'utf8')
      .split(/\r?\n/)
      .map((l) => l.trim())
      .filter((l) => l && !l.startsWith('#'));
    const out: SeedFile[] = [];
    for (const rel of lines) {
      const abs = path.join(seedsDir, rel);
      if (!fs.existsSync(abs)) {
        console.warn(`  WARN SEED_ORDER missing: ${rel}`);
        continue;
      }
      out.push({ version: rel.replace(/\\/g, '/'), filePath: abs });
    }
    return out;
  }

  const out: SeedFile[] = [];
  for (const domain of SEED_DOMAINS) {
    const domainDir = path.join(seedsDir, domain);
    if (!fs.existsSync(domainDir)) continue;
    const sources = fs
      .readdirSync(domainDir, { withFileTypes: true })
      .filter((e) => e.isDirectory())
      .map((e) => e.name)
      .sort((a, b) => {
        if (a === 'phb' && b !== 'phb') return -1;
        if (b === 'phb' && a !== 'phb') return 1;
        return a < b ? -1 : a > b ? 1 : 0;
      });
    for (const source of sources) {
      walkSql(path.join(domainDir, source), seedsDir, out);
    }
  }
  out.sort((a, b) => (a.version < b.version ? -1 : a.version > b.version ? 1 : 0));
  return out;
}

function walkSql(dir: string, seedsDir: string, out: SeedFile[]): void {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walkSql(full, seedsDir, out);
    } else if (entry.isFile() && entry.name.endsWith('.sql')) {
      out.push({
        version: path.relative(seedsDir, full).replace(/\\/g, '/'),
        filePath: full,
      });
    }
  }
}

export function applyFromFilter(
  files: SeedFile[],
  fromRel: string | null,
): SeedFile[] {
  if (!fromRel) return files;
  const needle = fromRel.replace(/\\/g, '/').replace(/^database\/seeds\//, '');
  const idx = files.findIndex(
    (f) =>
      f.version === needle ||
      f.version.endsWith(needle) ||
      f.filePath.replace(/\\/g, '/').endsWith(needle),
  );
  if (idx < 0) {
    throw new Error(`--from não encontrado na ordem: ${fromRel}`);
  }
  console.log(`  resume from index ${idx}: ${files[idx].version}`);
  return files.slice(idx);
}
