/**
 * Divide SQL de seed em arquivos por tabela: database/seeds/<grupo>/S###_<tabela>.sql
 */
import fs from "fs";
import path from "path";

function pad(n, w = 3) {
  return String(n).padStart(w, "0");
}

function normalizeStatement(raw) {
  const lines = raw.split("\n");
  while (lines.length && (/^\s*--/.test(lines[0]) || lines[0].trim() === "")) {
    lines.shift();
  }
  return lines.join("\n").trim();
}

/** @param {string} sql */
export function parseSeedStatements(sql) {
  const statements = [];
  let current = "";
  let inString = false;
  let inDollar = false;

  for (let i = 0; i < sql.length; i++) {
    const ch = sql[i];
    const next = sql[i + 1];

    if (!inString && ch === "$" && next === "$") {
      inDollar = !inDollar;
      current += "$$";
      i += 1;
      continue;
    }

    if (inDollar) {
      current += ch;
      continue;
    }

    if (ch === "'") {
      if (inString && next === "'") {
        current += "''";
        i += 1;
        continue;
      }
      inString = !inString;
      current += ch;
      continue;
    }

    if (ch === ";" && !inString) {
      const stmt = normalizeStatement(current);
      if (stmt) statements.push(stmt);
      current = "";
      continue;
    }

    current += ch;
  }

  const tail = normalizeStatement(current);
  if (tail) statements.push(tail);
  return statements;
}

function tableFromStatement(stmt) {
  const insert = stmt.match(/^INSERT INTO rpg\.(\w+)/i);
  if (insert) return insert[1];
  const update = stmt.match(/^UPDATE rpg\.(\w+)/i);
  if (update) return update[1];
  return null;
}

function wipeSeedGroup(seedsRoot, group) {
  const dir = path.join(seedsRoot, group);
  if (fs.existsSync(dir)) fs.rmSync(dir, { recursive: true, force: true });
}

/**
 * @param {string} sql
 * @param {string} seedsRoot
 * @param {{ group: string, start?: number, truncate?: string }} opts
 */
export function writeSplitSeedGroup(sql, seedsRoot, opts) {
  const { group, start = 10, truncate = null } = opts;
  const groupDir = path.join(seedsRoot, group);
  fs.mkdirSync(groupDir, { recursive: true });

  /** @type {Map<string, string[]>} */
  const byTable = new Map();
  /** @type {string[]} */
  const order = [];

  for (const stmt of parseSeedStatements(sql)) {
    if (/^TRUNCATE/i.test(stmt)) continue;
    if (/^(BEGIN|COMMIT)/i.test(stmt)) continue;

    const table = tableFromStatement(stmt);
    if (!table) continue;

    if (!byTable.has(table)) {
      byTable.set(table, []);
      order.push(table);
    }
    byTable.get(table).push(stmt);
  }

  const written = [];
  let n = start;
  for (const table of order) {
    const body = byTable
      .get(table)
      .map((s) => (s.trimEnd().endsWith(";") ? s.trimEnd() : `${s.trimEnd()};`))
      .join("\n\n");
    const rel = `${group}/S${pad(n)}_${table}.sql`;
    fs.writeFileSync(
      path.join(seedsRoot, rel),
      `-- Seed rpg.${table}\n-- Gerado automaticamente — não editar à mão\n\n${body}\n`,
      "utf8"
    );
    written.push(rel);
    n += 1;
  }

  return { written, truncate };
}

export function writeTruncateFile(seedsRoot, truncateSql) {
  if (!truncateSql?.trim()) return null;
  const rel = "000_truncate.sql";
  fs.writeFileSync(
    path.join(seedsRoot, rel),
    `-- Truncate catálogo PHB (ordem FK-safe)\n-- Gerado automaticamente\n\n${truncateSql.trim()}\n`,
    "utf8"
  );
  return rel;
}

export function prepareSeedsDir(seedsRoot) {
  if (fs.existsSync(seedsRoot)) {
    for (const entry of fs.readdirSync(seedsRoot, { withFileTypes: true })) {
      const p = path.join(seedsRoot, entry.name);
      if (entry.isDirectory()) fs.rmSync(p, { recursive: true, force: true });
      else if (entry.name.endsWith(".sql")) fs.unlinkSync(p);
    }
  } else {
    fs.mkdirSync(seedsRoot, { recursive: true });
  }
}

export function collectSeedFiles(seedsRoot) {
  /** @type {string[]} */
  const files = [];
  if (!fs.existsSync(seedsRoot)) return files;

  for (const entry of fs.readdirSync(seedsRoot, { withFileTypes: true })) {
    const p = path.join(seedsRoot, entry.name);
    if (entry.isDirectory()) files.push(...collectSeedFiles(p));
    else if (entry.name.endsWith(".sql")) files.push(p);
  }
  return files.sort((a, b) => a.localeCompare(b));
}

export function removeEmptyDirs(dir) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (!entry.isDirectory()) continue;
    const p = path.join(dir, entry.name);
    removeEmptyDirs(p);
    if (fs.readdirSync(p).length === 0) fs.rmdirSync(p);
  }
}
