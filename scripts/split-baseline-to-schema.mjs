#!/usr/bin/env node
/**
 * One-off: split database/baseline/001_full_schema.sql → database/schema/**
 * Uso: node scripts/split-baseline-to-schema.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const baselinePath = path.join(root, 'database/baseline/001_full_schema.sql');
const schemaRoot = path.join(root, 'database/schema');

const START_RE =
  /^(CREATE SCHEMA|CREATE EXTENSION|CREATE TYPE|CREATE TABLE|CREATE (?:OR REPLACE )?VIEW|CREATE MATERIALIZED VIEW|CREATE (?:OR REPLACE )?FUNCTION|DO \$\$)/gm;

/**
 * @param {string} sql
 * @param {number} index
 */
function classifyBlock(sql, index) {
  const head = sql.slice(index, index + 200);
  if (/^CREATE SCHEMA/i.test(head)) return { kind: 'bootstrap', name: 'rpg_schema' };
  if (/^CREATE EXTENSION/i.test(head)) return { kind: 'bootstrap', name: 'extensions' };
  const type = head.match(/^CREATE TYPE rpg\.(\w+)/i);
  if (type) return { kind: 'enum', name: type[1] };
  const table = head.match(/^CREATE TABLE (?:IF NOT EXISTS )?rpg\.(\w+)/i);
  if (table) return { kind: 'table', name: table[1] };
  const view = head.match(/^CREATE (?:OR REPLACE )?VIEW rpg\.(\w+)/i);
  if (view) return { kind: 'view', name: view[1] };
  const mv = head.match(/^CREATE MATERIALIZED VIEW rpg\.(\w+)/i);
  if (mv) return { kind: 'view', name: mv[1] };
  const fn = head.match(/^CREATE (?:OR REPLACE )?FUNCTION rpg\.(\w+)/i);
  if (fn) return { kind: 'function', name: fn[1] };
  if (/^DO \$\$/i.test(head)) {
    if (/ENABLE ROW LEVEL SECURITY|CREATE POLICY/i.test(sql.slice(index, index + 4000))) {
      return { kind: 'runtime', name: 'rls_policies' };
    }
    return { kind: 'runtime', name: `do_block_${index}` };
  }
  return { kind: 'runtime', name: `block_${index}` };
}

function pad(n) {
  return String(n).padStart(4, '0');
}

function ensureDir(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function wipeSchemaDir() {
  if (fs.existsSync(schemaRoot)) {
    fs.rmSync(schemaRoot, { recursive: true, force: true });
  }
  ensureDir(schemaRoot);
}

function main() {
  const raw = fs.readFileSync(baselinePath, 'utf8');
  const starts = [];
  for (const m of raw.matchAll(START_RE)) {
    starts.push(m.index ?? 0);
  }
  if (starts.length === 0) {
    console.error('Nenhum bloco CREATE encontrado.');
    process.exit(1);
  }

  /** @type {{ kind: string, name: string, sql: string }[]} */
  const blocks = [];
  for (let i = 0; i < starts.length; i++) {
    const start = starts[i];
    const end = i + 1 < starts.length ? starts[i + 1] : raw.length;
    const chunk = raw.slice(start, end).trimEnd() + '\n';
    const meta = classifyBlock(raw, start);
    // Prefixo de comentários imediatamente antes (só no 1º bloco bootstrap)
    let sql = chunk;
    if (i === 0 && start > 0) {
      const preamble = raw.slice(0, start).trim();
      if (preamble) sql = `${preamble}\n\n${chunk}`;
    }
    blocks.push({ ...meta, sql });
  }

  wipeSchemaDir();

  const counters = { enum: 0, table: 0, view: 0, function: 0, runtime: 0 };
  const dirs = {
    enum: path.join(schemaRoot, '010_enums'),
    table: path.join(schemaRoot, '020_tables'),
    view: path.join(schemaRoot, '030_views'),
    function: path.join(schemaRoot, '040_functions'),
    runtime: path.join(schemaRoot, '050_runtime'),
  };
  for (const d of Object.values(dirs)) ensureDir(d);

  let bootstrapSql = '';
  /** @type {string[]} */
  const written = [];

  for (const block of blocks) {
    if (block.kind === 'bootstrap') {
      bootstrapSql += `${block.sql.trim()}\n\n`;
      continue;
    }
    counters[block.kind] += 1;
    const n = pad(counters[block.kind]);
    const fileName = `${n}_${block.name}.sql`;
    const filePath = path.join(dirs[block.kind], fileName);
    fs.writeFileSync(filePath, `${block.sql.trim()}\n`, 'utf8');
    written.push(path.relative(root, filePath).replace(/\\/g, '/'));
  }

  const bootstrapPath = path.join(schemaRoot, '000_rpg_schema.sql');
  fs.writeFileSync(
    bootstrapPath,
    `${(bootstrapSql || '-- schema rpg').trim()}\n`,
    'utf8',
  );
  written.unshift(path.relative(root, bootstrapPath).replace(/\\/g, '/'));

  const readme = `# Schema \`rpg\` (declarative)

SSOT do DDL. Um arquivo ≈ um objeto (\`CREATE\`). Ordem = prefixo numérico + pasta.

| Pasta | Conteúdo |
|-------|----------|
| \`000_rpg_schema.sql\` | SCHEMA + extensions |
| \`010_enums/\` | \`CREATE TYPE\` |
| \`020_tables/\` | \`CREATE TABLE\` + indexes/comments da tabela |
| \`030_views/\` | views + materialized views |
| \`040_functions/\` | functions / triggers helpers |
| \`050_runtime/\` | RLS policies (\`DO $$ …\`), grants pontuais |

Mudou o modelo? Edite o \`CREATE\` e rode \`npm run db:setup\`. **Sem ALTER.**

Gerado a partir do baseline histórico; não editar \`database/baseline/\` (removido após migração).
`;
  fs.writeFileSync(path.join(schemaRoot, 'README.md'), readme, 'utf8');

  console.log(`Wrote ${written.length} SQL files under database/schema/`);
  console.log(
    `  enums=${counters.enum} tables=${counters.table} views=${counters.view} functions=${counters.function} runtime=${counters.runtime}`,
  );
}

main();
