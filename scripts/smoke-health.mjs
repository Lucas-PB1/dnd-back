#!/usr/bin/env node
/**
 * Smoke test — GET /health (local, vercel dev ou produção).
 * Uso: node scripts/smoke-health.mjs [baseUrl]
 */
const baseUrl = (process.argv[2] ?? process.env.SMOKE_URL ?? 'http://localhost:3000').replace(
  /\/$/,
  '',
);

async function main() {
  const url = `${baseUrl}/health`;
  console.log(`GET ${url}`);

  const response = await fetch(url);
  const body = await response.text();

  console.log(`Status: ${response.status}`);
  console.log(`Body: ${body}`);

  if (!response.ok) {
    process.exit(1);
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
