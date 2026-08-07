#!/usr/bin/env node
/**
 * Gera fichas aleatórias de nível 20 (payload completo) a partir do catálogo no Postgres.
 *
 * Uso:
 *   npm run sheets:l20
 *   npm run sheets:l20 -- --class=wizard
 *   npm run sheets:l20 -- --class=all --count=1
 *   npm run sheets:l20 -- --class=fighter --count=3 --out=tmp/l20-sheets
 *   npm run sheets:l20 -- --post --api=http://localhost:3000 --token=$TOKEN
 *   npm run sheets:l20 -- --target=supabase
 *
 * Sem --post: só grava JSON em --out (default tmp/l20-sheets).
 * Com --post: POST /characters (Bearer JWT Supabase).
 *
 * Relacionado: test/create-class-review-characters.e2e-spec.ts (cria via Nest + TestAuth).
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { loadCatalog, indexCatalog } from './lib/l20-sheet/catalog.mjs';
import { buildL20Payload } from './lib/l20-sheet/build-payload.mjs';

loadEnv();

function parseArgs(argv) {
  const out = {
    classSlug: 'all',
    count: 1,
    outDir: path.join(rootDir, 'tmp', 'l20-sheets'),
    post: false,
    api: process.env.API_BASE_URL ?? 'http://localhost:3000',
    token: process.env.SUPABASE_ACCESS_TOKEN ?? process.env.SHEETS_L20_TOKEN ?? '',
    target: 'supabase',
    seed: Date.now().toString(36),
  };
  for (const arg of argv) {
    if (arg === '--post') out.post = true;
    else if (arg.startsWith('--class=')) out.classSlug = arg.slice('--class='.length);
    else if (arg.startsWith('--count=')) out.count = Math.max(1, Number(arg.slice('--count='.length)) || 1);
    else if (arg.startsWith('--out=')) out.outDir = path.resolve(arg.slice('--out='.length));
    else if (arg.startsWith('--api=')) out.api = arg.slice('--api='.length).replace(/\/$/, '');
    else if (arg.startsWith('--token=')) out.token = arg.slice('--token='.length);
    else if (arg.startsWith('--target=')) out.target = arg.slice('--target='.length);
    else if (arg.startsWith('--seed=')) out.seed = arg.slice('--seed='.length);
    else if (arg === '--help' || arg === '-h') out.help = true;
  }
  return out;
}

function resolveDbUrl(target) {
  if (target === 'local') {
    const url = process.env.DATABASE_URL;
    if (!url) throw new Error('DATABASE_URL não definida');
    return url;
  }
  const url = process.env.SUPABASE_DATABASE_URL ?? process.env.DATABASE_URL;
  if (!url) throw new Error('SUPABASE_DATABASE_URL (ou DATABASE_URL) não definida');
  return url;
}

function printHelp() {
  console.log(`generate-l20-sheets — fichas aleatórias Nv20

Opções:
  --class=all|slug   Classe(s) a gerar (default: all)
  --count=N          Quantidade por classe (default: 1)
  --out=DIR          Pasta de saída JSON (default: tmp/l20-sheets)
  --target=supabase|local  Banco do catálogo (default: supabase)
  --post             POST /characters após gerar
  --api=URL          Base da API (default: http://localhost:3000)
  --token=JWT        Bearer Supabase (ou env SUPABASE_ACCESS_TOKEN)

Exemplos:
  npm run sheets:l20
  npm run sheets:l20 -- --class=wizard --count=2
  npm run sheets:l20 -- --post --token=eyJ...`);
}

async function postCharacter(api, token, payload) {
  const res = await fetch(`${api}/characters`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(payload),
  });
  const text = await res.text();
  let body;
  try {
    body = JSON.parse(text);
  } catch {
    body = { raw: text };
  }
  return { status: res.status, body };
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  if (args.help) {
    printHelp();
    return;
  }

  if (args.post && !args.token) {
    console.error('Para --post informe --token=JWT ou SUPABASE_ACCESS_TOKEN');
    process.exit(1);
  }

  const url = resolveDbUrl(args.target);
  console.log(`Catálogo: ${maskDatabaseUrl(url)}`);
  console.log(`Saída: ${args.outDir}`);
  console.log(`Seed: ${args.seed}`);

  const client = createPgClient(url);
  await client.connect();

  try {
    const catalog = await loadCatalog(client);
    const idx = indexCatalog(catalog);
    const classList =
      args.classSlug === 'all'
        ? catalog.classes.map((c) => c.slug)
        : catalog.classes.filter((c) => c.slug === args.classSlug).map((c) => c.slug);

    if (!classList.length) {
      throw new Error(
        `Nenhuma classe para '${args.classSlug}'. Disponíveis: ${catalog.classes.map((c) => c.slug).join(', ')}`,
      );
    }

    fs.mkdirSync(args.outDir, { recursive: true });
    const index = [];

    for (const classSlug of classList) {
      for (let i = 0; i < args.count; i += 1) {
        const label = `L20 · ${classSlug}${args.count > 1 ? ` · ${i + 1}` : ''}`;
        let payload;
        try {
          payload = await buildL20Payload(client, idx, {
            classSlug,
            seedLabel: `${label} · ${args.seed}`,
          });
        } catch (err) {
          console.error(`FAIL build ${classSlug}#${i + 1}:`, err.message);
          index.push({ classSlug, ok: false, error: err.message });
          continue;
        }

        const fileSafe = `${classSlug}-${i + 1}-${args.seed}`.replace(/[^\w.-]+/g, '_');
        const filePath = path.join(args.outDir, `${fileSafe}.json`);
        fs.writeFileSync(filePath, JSON.stringify(payload, null, 2), 'utf8');

        const entry = {
          classSlug,
          subclassSlug: payload.subclassSlug,
          speciesSlug: payload.speciesSlug,
          backgroundSlug: payload.backgroundSlug,
          file: filePath,
          spells: payload.characterSpells?.length ?? 0,
          feats: payload.characterFeats?.length ?? 0,
          ok: true,
        };

        if (args.post) {
          const res = await postCharacter(args.api, args.token, payload);
          entry.postStatus = res.status;
          entry.id = res.body?.id;
          if (res.status !== 201) {
            entry.ok = false;
            entry.error = res.body;
            console.error(`FAIL POST ${classSlug}:`, res.status, JSON.stringify(res.body));
            fs.writeFileSync(
              path.join(args.outDir, `${fileSafe}.error.json`),
              JSON.stringify(res.body, null, 2),
              'utf8',
            );
          } else {
            console.log(`OK POST ${payload.name} id=${res.body.id}`);
          }
        } else {
          console.log(
            `OK ${payload.name} → ${path.relative(rootDir, filePath)} (spells=${entry.spells}, feats=${entry.feats})`,
          );
        }

        index.push(entry);
      }
    }

    const indexPath = path.join(args.outDir, `_index-${args.seed}.json`);
    fs.writeFileSync(indexPath, JSON.stringify(index, null, 2), 'utf8');
    const failed = index.filter((e) => !e.ok).length;
    console.log(`\nÍndice: ${indexPath}`);
    console.log(`Total: ${index.length} · falhas: ${failed}`);
    if (failed) process.exitCode = 1;
  } finally {
    await client.end();
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
