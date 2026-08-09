#!/usr/bin/env node
/**
 * Cria 1 ficha L20 completa por classe (Review · …) — rápido, sem Jest.
 *
 * Usa o Nest já compilado em dist/ + CreateCharacterHandler em paralelo.
 * Pré-requisito: `npm run build` ou `start:dev` já ter gerado dist/.
 *
 * Uso:
 *   npm run sheets:review
 *   node scripts/create-review-l20.mjs
 *   node scripts/create-review-l20.mjs --concurrency=4
 */
import { createRequire } from 'module';
import path from 'path';
import { fileURLToPath } from 'url';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { loadCatalog, indexCatalog } from './lib/l20-sheet/catalog.mjs';
import { buildL20Payload } from './lib/l20-sheet/build-payload.mjs';

const require = createRequire(import.meta.url);
const __dirname = path.dirname(fileURLToPath(import.meta.url));

const OWNER_EMAIL = 'lucasoaresnet@gmail.com';

const CLASS_LABEL = {
  barbarian: 'Bárbaro',
  bard: 'Bardo',
  cleric: 'Clérigo',
  druid: 'Druida',
  fighter: 'Guerreiro',
  gunslinger: 'Pistoleiro',
  monk: 'Monge',
  paladin: 'Paladino',
  ranger: 'Guardião',
  rogue: 'Ladino',
  sorcerer: 'Feiticeiro',
  warlock: 'Bruxo',
  wizard: 'Mago',
};

const PREFERRED_SUBCLASS = {
  wizard: 'magic-missile-mage',
};

function parseArgs(argv) {
  let concurrency = 4;
  for (const arg of argv) {
    if (arg.startsWith('--concurrency=')) {
      concurrency = Math.max(1, Number(arg.slice('--concurrency='.length)) || 4);
    }
  }
  return { concurrency };
}

async function mapPool(items, concurrency, fn) {
  const results = new Array(items.length);
  let next = 0;
  async function worker() {
    while (next < items.length) {
      const i = next;
      next += 1;
      results[i] = await fn(items[i], i);
    }
  }
  await Promise.all(
    Array.from({ length: Math.min(concurrency, items.length) }, () => worker()),
  );
  return results;
}

loadEnv();
const args = parseArgs(process.argv.slice(2));
const databaseUrl = process.env.DATABASE_URL;
if (!databaseUrl) {
  console.error('DATABASE_URL não definida');
  process.exit(1);
}

const distRegister = path.join(rootDir, 'dist', 'register-path-aliases.js');
const distAppModule = path.join(rootDir, 'dist', 'app.module.js');
try {
  require(distRegister);
} catch {
  console.error(
    'dist/ não encontrado ou incompleto. Rode `npm run build` (ou deixe start:dev gerar dist/) e tente de novo.',
  );
  process.exit(1);
}

const { NestFactory } = require('@nestjs/core');
const { AppModule } = require(distAppModule);
const {
  CreateCharacterHandler,
} = require(path.join(rootDir, 'dist', 'game', 'sheet', 'application', 'create-character.handler.js'));
const { DataSource } = require('typeorm');

const t0 = Date.now();
console.log(`Catálogo ${maskDatabaseUrl(databaseUrl)}`);
console.log(`Concorrência: ${args.concurrency}`);

const pg = createPgClient(databaseUrl);
await pg.connect();

let payloads;
try {
  const catalog = await loadCatalog(pg);
  const idx = indexCatalog(catalog);
  payloads = [];
  for (const cls of catalog.classes) {
    const name = `Review · ${CLASS_LABEL[cls.slug] ?? cls.slug}`;
    const payload = await buildL20Payload(pg, idx, {
      classSlug: cls.slug,
      seedLabel: name,
      preferredSubclassSlug: PREFERRED_SUBCLASS[cls.slug],
    });
    payloads.push(payload);
    console.log(
      `payload ${name} (${payload.subclassSlug}) spells=${payload.characterSpells?.length ?? 0} eq=${payload.equipment?.length ?? 0}`,
    );
  }
} finally {
  await pg.end();
}

console.log(`Payloads: ${payloads.length} em ${((Date.now() - t0) / 1000).toFixed(1)}s`);

const app = await NestFactory.createApplicationContext(AppModule, {
  logger: ['error', 'warn'],
});

try {
  const db = app.get(DataSource);
  const create = app.get(CreateCharacterHandler);

  const users = await db.query(
    `SELECT id FROM auth.users WHERE email = $1 LIMIT 1`,
    [OWNER_EMAIL],
  );
  if (!users[0]) {
    throw new Error(`User not found: ${OWNER_EMAIL}`);
  }
  const userId = users[0].id;

  await db.query(
    `DELETE FROM rpg.player_character
     WHERE user_id = $1 AND name LIKE 'Review · %'`,
    [userId],
  );
  console.log('Removidos Review · anteriores');

  const created = await mapPool(payloads, args.concurrency, async (payload) => {
    try {
      const char = await create.execute(userId, payload);
      console.log(`OK ${payload.name} id=${char.id}`);
      return {
        ok: true,
        name: payload.name,
        classSlug: payload.classSlug,
        subclassSlug: payload.subclassSlug,
        id: char.id,
      };
    } catch (err) {
      const message = err?.response?.message ?? err?.message ?? String(err);
      console.error(`FAIL ${payload.classSlug}/${payload.subclassSlug}:`, message);
      return {
        ok: false,
        name: payload.name,
        classSlug: payload.classSlug,
        subclassSlug: payload.subclassSlug,
        error: message,
      };
    }
  });

  const failed = created.filter((c) => !c.ok);
  console.log('\nResumo:');
  for (const c of created.filter((x) => x.ok)) {
    console.log(`- ${c.name} (${c.classSlug}/${c.subclassSlug})`);
  }
  console.log(
    `\nTotal ${created.length} · ok ${created.length - failed.length} · falhas ${failed.length} · ${((Date.now() - t0) / 1000).toFixed(1)}s`,
  );
  if (failed.length) process.exitCode = 1;
} finally {
  await app.close();
}
