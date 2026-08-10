/**
 * Aplica seeds pontuais sem truncate (para completar catálogo local).
 * Uso: node scripts/apply-seed-files.mjs path1 path2 ...
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles } from './lib/sql-files.mjs';

loadEnv();

const args = process.argv.slice(2);
if (!args.length) {
  console.error('Informe paths relativos a database/seeds ou packs (ex: phb/S074_phb_metamagic.sql)');
  process.exit(1);
}

const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida');
  process.exit(1);
}

const seedsDir = path.join(rootDir, 'database/seeds');
const files = [];

for (const arg of args) {
  const abs = path.isAbsolute(arg) ? arg : path.join(seedsDir, arg);
  if (fs.existsSync(abs) && fs.statSync(abs).isDirectory()) {
    files.push(...listSqlFiles(abs));
  } else if (fs.existsSync(abs)) {
    files.push(abs);
  } else {
    console.error('Não encontrado:', abs);
    process.exit(1);
  }
}

console.log('DB', maskDatabaseUrl(url, { preferPooler: true }));
console.log('Files', files.length);

let client = createPgClient(url);
try {
  await client.connect();
} catch (err) {
  const code = err && typeof err === 'object' && 'code' in err ? err.code : '';
  if (code === 'ENOTFOUND') {
    console.log('db.* inacessível; usando pooler…');
    client = createPgClient(url, { preferPooler: true });
    await client.connect();
  } else {
    throw err;
  }
}

let failed = 0;
for (const file of files) {
  const rel = path.relative(seedsDir, file);
  const sql = fs.readFileSync(file, 'utf8');
  try {
    await client.query(sql);
    console.log('OK', rel);
  } catch (err) {
    failed += 1;
    console.error('FAIL', rel, err.message.split('\n')[0]);
  }
}

await client.end();
console.log(`Done. falhas=${failed}`);
process.exitCode = failed ? 1 : 0;
