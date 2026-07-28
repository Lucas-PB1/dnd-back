#!/usr/bin/env node
/**
 * Exporta OpenAPI JSON.
 *
 * Preferência:
 * 1) FETCH de servidor rodando: `OPENAPI_URL=http://localhost:3000/api-json`
 * 2) Boot Nest (precisa DATABASE_URL): `node --import tsx` não disponível —
 *    use fetch em CI após start, ou rode com app up.
 *
 * Uso:
 *   node scripts/export-openapi.mjs [outPath]
 *   OPENAPI_URL=http://127.0.0.1:3000/api-json node scripts/export-openapi.mjs
 */
import { writeFileSync, mkdirSync } from 'node:fs';
import { dirname, resolve } from 'node:path';

const outPath = resolve(
  process.argv[2] ?? process.env.OPENAPI_OUT ?? 'openapi.json',
);
const openApiUrl = (
  process.env.OPENAPI_URL ?? 'http://127.0.0.1:3000/api-json'
).replace(/\/$/, '');

async function main() {
  console.log(`GET ${openApiUrl}`);
  const response = await fetch(openApiUrl);
  if (!response.ok) {
    throw new Error(
      `Failed to fetch OpenAPI (${response.status}). Start the API (npm run start:dev) or set OPENAPI_URL.`,
    );
  }
  const document = await response.json();
  mkdirSync(dirname(outPath), { recursive: true });
  writeFileSync(outPath, `${JSON.stringify(document, null, 2)}\n`, 'utf8');
  console.log(`Wrote ${outPath}`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
});
