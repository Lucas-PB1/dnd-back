/**
 * Aplica C011/C012/C013 linha a linha, pulando FKs ausentes (XOR).
 * Uso: node scripts/apply-economy-extras.mjs
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

/** Extrai tuplas de VALUES de um INSERT multi-row (heurística por parênteses). */
function extractValueTuples(sql) {
  const marker = /VALUES\s*/i;
  const m = marker.exec(sql);
  if (!m) return [];
  let i = m.index + m[0].length;
  const tuples = [];
  while (i < sql.length) {
    while (i < sql.length) {
      if (/\s|,/.test(sql[i])) {
        i += 1;
        continue;
      }
      // Comentários SQL entre tuplas (-- ...\n)
      if (sql[i] === '-' && sql[i + 1] === '-') {
        const nl = sql.indexOf('\n', i);
        i = nl === -1 ? sql.length : nl + 1;
        continue;
      }
      break;
    }
    if (sql[i] !== '(') break;
    let depth = 0;
    let inSingle = false;
    let inDollar = null;
    const start = i;
    for (; i < sql.length; i += 1) {
      const ch = sql[i];
      const next = sql[i + 1];
      if (inDollar) {
        if (sql.startsWith(inDollar, i)) {
          i += inDollar.length - 1;
          inDollar = null;
        }
        continue;
      }
      if (inSingle) {
        if (ch === "'" && next === "'") {
          i += 1;
          continue;
        }
        if (ch === "'") inSingle = false;
        continue;
      }
      if (ch === "'") {
        inSingle = true;
        continue;
      }
      if (ch === '$') {
        const dm = sql.slice(i).match(/^\$[A-Za-z0-9_]*\$/);
        if (dm) {
          inDollar = dm[0];
          i += dm[0].length - 1;
          continue;
        }
      }
      if (ch === '(') depth += 1;
      if (ch === ')') {
        depth -= 1;
        if (depth === 0) {
          tuples.push(sql.slice(start, i + 1));
          i += 1;
          break;
        }
      }
    }
    if (depth !== 0) break;
  }
  return tuples;
}

function headerBeforeValues(sql) {
  const idx = sql.search(/VALUES/i);
  return sql.slice(0, idx).trim();
}

async function applyMultiInsert(client, fileRel) {
  const file = path.join(rootDir, 'database/seeds', fileRel);
  const sql = fs.readFileSync(file, 'utf8');
  const header = headerBeforeValues(sql);
  const onConflict = sql.includes('ON CONFLICT')
    ? sql.slice(sql.search(/ON CONFLICT/i)).replace(/;\s*$/, '')
    : 'ON CONFLICT (action_id) DO NOTHING';
  const tuples = extractValueTuples(sql);
  console.log(`\n${fileRel}: ${tuples.length} rows`);
  let ok = 0;
  let skip = 0;
  for (const tuple of tuples) {
    const stmt = `${header} VALUES ${tuple} ${onConflict}`;
    try {
      await client.query(stmt);
      ok += 1;
    } catch (err) {
      skip += 1;
      const id = tuple.match(/'([a-z0-9-]+)'/)?.[1] ?? '?';
      console.error(`  skip ${id}: ${err.message.split('\n')[0]}`);
    }
  }
  console.log(`  ok=${ok} skip=${skip}`);
}

const client = createPgClient(process.env.DATABASE_URL);
await client.connect();
console.log('DB', maskDatabaseUrl(process.env.DATABASE_URL));

await applyMultiInsert(client, 'combat/C011_phb_species_economy_action.sql');
await applyMultiInsert(client, 'combat/C012_phb_feat_economy_action.sql');
await applyMultiInsert(client, 'combat/C013_phb_item_economy_action.sql');

await client.end();
