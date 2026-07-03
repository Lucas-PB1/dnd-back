/**
 * Divide database/schema.sql em migrations granulares:
 *   migrations/001_schema.sql
 *   migrations/types/002_types.sql
 *   migrations/tables/T###_<nome>.sql   — uma tabela por arquivo (+ índices inline)
 *   migrations/alters/A###_<nome>.sql
 *   migrations/functions/F001_set_updated_at.sql
 *   migrations/triggers/TR001_audit.sql
 *   migrations/views/V###_<nome>.sql
 *   migrations/materialized/MV001_mv_spell_by_class.sql
 *   migrations/indexes/IX001_catalog.sql
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaFile = path.join(root, "database", "schema.sql");
const migrationsRoot = path.join(root, "database", "migrations");

/** @param {string} sql */
function parseStatements(sql) {
  const statements = [];
  let buf = "";
  let inDollar = false;

  for (const line of sql.split("\n")) {
    if (/^\s*\$\$\s*;?\s*$/.test(line)) inDollar = !inDollar;
    buf += `${line}\n`;
    if (inDollar) continue;
    const t = line.trim();
    if (t.endsWith(";") && !t.startsWith("--")) {
      const stmt = buf.trim();
      if (stmt && !/^--/.test(stmt.split("\n")[0]?.trim() ?? "")) {
        statements.push(stmt);
      }
      buf = "";
    }
  }
  const tail = buf.trim();
  if (tail) statements.push(tail);
  return statements;
}

function classify(stmt) {
  if (/^CREATE SCHEMA/i.test(stmt)) return "schema";
  if (/^CREATE EXTENSION/i.test(stmt)) return "schema";
  if (/^CREATE TYPE rpg\./i.test(stmt)) return "type";
  if (/^CREATE TABLE rpg\.(\w+)/i.test(stmt)) {
    return { kind: "table", name: stmt.match(/^CREATE TABLE rpg\.(\w+)/i)[1] };
  }
  if (/^ALTER TABLE rpg\.(\w+)/i.test(stmt)) {
    return { kind: "alter", name: stmt.match(/^ALTER TABLE rpg\.(\w+)/i)[1] };
  }
  if (/^CREATE OR REPLACE VIEW rpg\.(\w+)/i.test(stmt)) {
    return { kind: "view", name: stmt.match(/^CREATE OR REPLACE VIEW rpg\.(\w+)/i)[1] };
  }
  if (/^CREATE MATERIALIZED VIEW rpg\.(\w+)/i.test(stmt)) {
    return { kind: "materialized", name: stmt.match(/^CREATE MATERIALIZED VIEW rpg\.(\w+)/i)[1] };
  }
  if (/^CREATE OR REPLACE FUNCTION rpg\./i.test(stmt)) return "function";
  if (/^CREATE TRIGGER/i.test(stmt)) return "trigger";
  if (/^CREATE (UNIQUE )?INDEX/i.test(stmt)) return "index";
  if (/^COMMENT ON/i.test(stmt)) return "comment";
  return "other";
}

function wipeMigrations() {
  if (!fs.existsSync(migrationsRoot)) return;
  for (const entry of fs.readdirSync(migrationsRoot, { withFileTypes: true })) {
    const p = path.join(migrationsRoot, entry.name);
    if (entry.isDirectory()) {
      fs.rmSync(p, { recursive: true, force: true });
    } else if (entry.name.endsWith(".sql")) {
      fs.unlinkSync(p);
    }
  }
}

function writeMigration(relPath, header, body) {
  const file = path.join(migrationsRoot, relPath);
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, `${header}\n\n${body.trim()}\n`, "utf8");
  return relPath;
}

function pad(n, w = 3) {
  return String(n).padStart(w, "0");
}

export function writeSplitMigrations(schemaSql) {
  wipeMigrations();

  const body = schemaSql.replace(/^[\s\S]*?(?=CREATE SCHEMA)/i, "").trim();
  const stmts = parseStatements(body);

  const schemaParts = [];
  const types = [];
  /** @type {Map<string, string[]>} */
  const tableBlocks = new Map();
  const alters = [];
  const views = [];
  const materialized = [];
  const functions = [];
  const triggers = [];
  const indexes = [];
  const comments = [];

  /** @type {string|null} */
  let pendingTable = null;

  for (const stmt of stmts) {
    const c = classify(stmt);
    if (c === "schema") {
      schemaParts.push(stmt);
      pendingTable = null;
    } else if (c === "type") {
      types.push(stmt);
      pendingTable = null;
    } else if (c?.kind === "table") {
      pendingTable = c.name;
      tableBlocks.set(c.name, [stmt]);
    } else if (c === "index" && pendingTable) {
      tableBlocks.get(pendingTable)?.push(stmt);
    } else if (c?.kind === "alter") {
      alters.push({ name: c.name, stmt });
      pendingTable = null;
    } else if (c?.kind === "view") {
      views.push({ name: c.name, stmt });
      pendingTable = null;
    } else if (c?.kind === "materialized") {
      materialized.push({ name: c.name, stmt });
      pendingTable = null;
    } else if (c === "function") {
      functions.push(stmt);
      pendingTable = null;
    } else if (c === "trigger") {
      triggers.push(stmt);
      pendingTable = null;
    } else if (c === "index") {
      indexes.push(stmt);
      pendingTable = null;
    } else if (c === "comment") {
      comments.push(stmt);
      pendingTable = null;
    }
  }

  const written = [];

  written.push(
    writeMigration(
      "001_schema.sql",
      "-- Schema rpg + extensão pg_trgm",
      schemaParts.join("\n\n")
    )
  );

  written.push(
    writeMigration("types/002_types.sql", "-- ENUMs do catálogo PHB", types.join("\n\n"))
  );

  let t = 10;
  for (const [name, blocks] of tableBlocks) {
    written.push(
      writeMigration(
        `tables/T${pad(t)}_${name}.sql`,
        `-- Tabela rpg.${name}`,
        blocks.join("\n\n")
      )
    );
    t += 1;
  }

  let a = 10;
  for (const { name, stmt } of alters) {
    written.push(
      writeMigration(
        `alters/A${pad(a)}_${name}.sql`,
        `-- ALTER rpg.${name}`,
        stmt
      )
    );
    a += 1;
  }

  functions.forEach((stmt, i) => {
    written.push(
      writeMigration(
        `functions/F${pad(i + 1)}_set_updated_at.sql`,
        "-- Função de auditoria updated_at",
        stmt
      )
    );
  });

  if (triggers.length) {
    written.push(
      writeMigration(
        "triggers/TR001_audit.sql",
        "-- Triggers updated_at em tabelas PHB",
        triggers.join("\n\n")
      )
    );
  }

  let v = 10;
  for (const { name, stmt } of views) {
    written.push(
      writeMigration(`views/V${pad(v)}_${name}.sql`, `-- View rpg.${name}`, stmt)
    );
    v += 1;
  }

  materialized.forEach(({ name, stmt }, i) => {
    written.push(
      writeMigration(
        `materialized/MV${pad(i + 1)}_${name}.sql`,
        `-- Materialized view rpg.${name}`,
        stmt
      )
    );
  });

  if (indexes.length) {
    written.push(
      writeMigration(
        "indexes/IX001_catalog.sql",
        "-- Índices adicionais do catálogo",
        indexes.join("\n\n")
      )
    );
  }

  if (comments.length) {
    written.push(
      writeMigration(
        "comments/C001_schema.sql",
        "-- Comentários de schema/colunas",
        comments.join("\n\n")
      )
    );
  }

  return written;
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  if (!fs.existsSync(schemaFile)) {
    console.error("✗ database/schema.sql ausente — rode npm run generate:sql-schema");
    process.exit(1);
  }
  const schemaSql = fs.readFileSync(schemaFile, "utf8");
  const files = writeSplitMigrations(schemaSql);
  console.log(`✓ ${files.length} migrations em database/migrations/`);
  console.log(`  tabelas: ${files.filter((f) => f.startsWith("tables/")).length}`);
  console.log(`  views: ${files.filter((f) => f.startsWith("views/")).length}`);
}
