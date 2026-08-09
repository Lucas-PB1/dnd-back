/**
 * Converte imports relativos profundos (../../…) em aliases @/…
 * Uso: node scripts/migrate-path-aliases.mjs [--dry]
 */
import { readdirSync, readFileSync, writeFileSync, statSync } from "fs";
import path from "path";

const DRY = process.argv.includes("--dry");
const SRC_ROOT = path.resolve("src");
const MIN_DEPTH = 2;

/** Preferência de alias semântico quando o path começa com a pasta. */
const SEMANTIC = [
  ["entities/", "@entities/"],
  ["common/", "@common/"],
  ["catalog/", "@catalog/"],
  ["game/", "@game/"],
  ["identity/", "@identity/"],
  ["config/", "@config/"],
];

function walk(dir, acc = []) {
  for (const name of readdirSync(dir)) {
    const p = path.join(dir, name);
    if (statSync(p).isDirectory()) walk(p, acc);
    else if (p.endsWith(".ts")) acc.push(p);
  }
  return acc;
}

function toAlias(absUnderSrc) {
  const rel = absUnderSrc.replace(/\\/g, "/");
  for (const [prefix, alias] of SEMANTIC) {
    if (rel.startsWith(prefix)) {
      return alias + rel.slice(prefix.length);
    }
  }
  return "@/" + rel;
}

function rewriteImportPath(fromFile, importPath) {
  if (!importPath.startsWith(".")) return null;
  const depth = (importPath.match(/\.\./g) || []).length;
  if (depth < MIN_DEPTH && !importPath.startsWith("./")) {
    // ../ once only — keep
  }
  if (depth < MIN_DEPTH) return null;

  const resolved = path.resolve(path.dirname(fromFile), importPath);
  const normalized = path.normalize(resolved);
  if (!normalized.startsWith(SRC_ROOT + path.sep) && normalized !== SRC_ROOT) {
    return null;
  }
  const underSrc = path.relative(SRC_ROOT, normalized).replace(/\\/g, "/");
  return toAlias(underSrc);
}

const IMPORT_RE =
  /((?:import|export)(?:[\s\S]*?\sfrom\s+)|(?:import\s*\(\s*))['"]([^'"]+)['"]/g;

let filesChanged = 0;
let importsChanged = 0;

for (const file of walk(SRC_ROOT)) {
  const original = readFileSync(file, "utf8");
  let next = original;
  let fileHits = 0;

  next = next.replace(IMPORT_RE, (full, prefix, importPath) => {
    const alias = rewriteImportPath(file, importPath);
    if (!alias) return full;
    fileHits += 1;
    return `${prefix}'${alias}'`;
  });

  // jest.mock('rel') / jest.requireActual('rel')
  next = next.replace(
    /(jest\.(?:mock|requireActual|unstable_mockModule)\(\s*)['"]([^'"]+)['"]/g,
    (full, prefix, importPath) => {
      const alias = rewriteImportPath(file, importPath);
      if (!alias) return full;
      fileHits += 1;
      return `${prefix}'${alias}'`;
    },
  );

  if (fileHits > 0 && next !== original) {
    filesChanged += 1;
    importsChanged += fileHits;
    if (!DRY) writeFileSync(file, next, "utf8");
  }
}

console.log(
  `${DRY ? "[dry] " : ""}files=${filesChanged} imports=${importsChanged} (depth>=${MIN_DEPTH})`,
);
