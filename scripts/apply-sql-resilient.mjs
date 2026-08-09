/**
 * Aplica um seed SQL statement-a-statement com suporte a aspas e $-quotes.
 * Continua após erro (útil quando um INSERT depende de espécie/feat ausente).
 *
 * Uso: node scripts/apply-sql-resilient.mjs combat/C011_phb_species_economy_action.sql
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

function splitStatements(sql) {
  const out = [];
  let buf = '';
  let i = 0;
  let inSingle = false;
  let inDollar = null;

  while (i < sql.length) {
    const ch = sql[i];
    const next = sql[i + 1];

    if (inDollar) {
      if (sql.startsWith(inDollar, i)) {
        buf += inDollar;
        i += inDollar.length;
        inDollar = null;
        continue;
      }
      buf += ch;
      i += 1;
      continue;
    }

    if (inSingle) {
      if (ch === "'" && next === "'") {
        buf += "''";
        i += 2;
        continue;
      }
      if (ch === "'") {
        inSingle = false;
        buf += ch;
        i += 1;
        continue;
      }
      buf += ch;
      i += 1;
      continue;
    }

    if (ch === '-' && next === '-') {
      const nl = sql.indexOf('\n', i);
      i = nl === -1 ? sql.length : nl + 1;
      continue;
    }

    if (ch === "'") {
      inSingle = true;
      buf += ch;
      i += 1;
      continue;
    }

    if (ch === '$') {
      const m = sql.slice(i).match(/^\$[A-Za-z0-9_]*\$/);
      if (m) {
        inDollar = m[0];
        buf += m[0];
        i += m[0].length;
        continue;
      }
    }

    if (ch === ';') {
      const stmt = buf.trim();
      if (stmt) out.push(stmt);
      buf = '';
      i += 1;
      continue;
    }

    buf += ch;
    i += 1;
  }

  const tail = buf.trim();
  if (tail) out.push(tail);
  return out;
}

const rel = process.argv[2];
if (!rel) {
  console.error('Uso: node scripts/apply-sql-resilient.mjs <path-relativo-seeds>');
  process.exit(1);
}

const file = path.isAbsolute(rel)
  ? rel
  : path.join(rootDir, 'database/seeds', rel);
const sql = fs.readFileSync(file, 'utf8');
const stmts = splitStatements(sql);

const client = createPgClient(process.env.DATABASE_URL);
await client.connect();
console.log('DB', maskDatabaseUrl(process.env.DATABASE_URL));
console.log(path.basename(file), 'stmts', stmts.length);

let ok = 0;
let fail = 0;
for (let n = 0; n < stmts.length; n += 1) {
  try {
    await client.query(stmts[n]);
    ok += 1;
  } catch (err) {
    fail += 1;
    console.error(`FAIL #${n + 1}:`, err.message.split('\n')[0]);
  }
}
await client.end();
console.log(`ok=${ok} fail=${fail}`);
process.exitCode = fail ? 1 : 0;
