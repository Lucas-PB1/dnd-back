#!/usr/bin/env node
/**
 * Mede latência HTTP dos hot paths (header X-Response-Time).
 *
 * Uso:
 *   node scripts/measure-latency.mjs
 *   node scripts/measure-latency.mjs --rounds=10 --warm=1
 *   node scripts/measure-latency.mjs --token=eyJ... --character=uuid
 *
 * Env: API_BASE_URL, MEASURE_TOKEN, MEASURE_CHARACTER_ID
 */
import { loadEnv } from './lib/load-env.mjs';

loadEnv();

function argValue(prefix, fallback) {
  const hit = process.argv.find((arg) => arg.startsWith(prefix));
  return hit ? hit.slice(prefix.length) : fallback;
}

const base = argValue(
  '--base=',
  process.env.API_BASE_URL ?? 'http://localhost:3000',
).replace(/\/$/, '');
const token = argValue('--token=', process.env.MEASURE_TOKEN ?? '');
const characterId = argValue(
  '--character=',
  process.env.MEASURE_CHARACTER_ID ?? '',
);
const rounds = Math.max(1, Number(argValue('--rounds=', '10')) || 10);
const warmDiscard = Math.max(0, Number(argValue('--warm=', '1')) || 0);

/** @type {{ name: string, path: string, auth?: boolean }[]} */
const targets = [
  { name: 'GET /spells', path: '/spells?limit=20' },
  { name: 'GET /spells summary', path: '/spells?limit=50&fields=summary' },
  { name: 'GET /classes/wizard/spells', path: '/classes/wizard/spells?limit=20' },
  {
    name: 'GET /classes/wizard/spells maxLevel',
    path: '/classes/wizard/spells?limit=20&maxLevel=1',
  },
];

if (characterId) {
  targets.push({
    name: 'GET /characters/:id',
    path: `/characters/${characterId}`,
    auth: true,
  });
}

/**
 * @param {string} path
 * @param {boolean} [auth]
 */
async function timedFetch(path, auth = false) {
  /** @type {Record<string, string>} */
  const headers = { Accept: 'application/json' };
  if (auth) {
    if (!token) throw new Error('MEASURE_TOKEN / --token obrigatório para ficha');
    headers.Authorization = `Bearer ${token}`;
  }

  const started = performance.now();
  const res = await fetch(`${base}${path}`, { headers });
  const wallMs = performance.now() - started;
  const headerMs = res.headers.get('x-response-time');
  const body = await res.text();
  return {
    status: res.status,
    wallMs,
    headerMs,
    bytes: body.length,
  };
}

function avg(values) {
  if (values.length === 0) return 0;
  return values.reduce((a, b) => a + b, 0) / values.length;
}

function pct(values, p) {
  if (values.length === 0) return 0;
  const sorted = [...values].sort((a, b) => a - b);
  const idx = Math.min(
    sorted.length - 1,
    Math.floor((p / 100) * sorted.length),
  );
  return sorted[idx];
}

/**
 * @param {number[]} all
 */
function statsAfterWarm(all) {
  const warm = all.slice(0, Math.min(warmDiscard, Math.max(0, all.length - 1)));
  const measured = all.slice(warm.length);
  return { warm, measured };
}

console.log(
  `Measure latency — base=${base} rounds=${rounds} warmDiscard=${warmDiscard}\n`,
);

for (const target of targets) {
  /** @type {number[]} */
  const wallsAll = [];
  /** @type {number[]} */
  const headersAll = [];
  let lastStatus = 0;
  let lastBytes = 0;

  for (let i = 0; i < rounds; i++) {
    const result = await timedFetch(target.path, target.auth);
    lastStatus = result.status;
    lastBytes = result.bytes;
    wallsAll.push(result.wallMs);
    if (result.headerMs) {
      const parsed = Number.parseFloat(result.headerMs);
      if (!Number.isNaN(parsed)) headersAll.push(parsed);
    }
  }

  const walls = statsAfterWarm(wallsAll);
  const headers = statsAfterWarm(headersAll);

  const server =
    headers.measured.length > 0
      ? `server avg=${avg(headers.measured).toFixed(1)}ms p95=${pct(headers.measured, 95).toFixed(1)}ms` +
        (headers.warm.length
          ? ` (cold ${headers.warm.map((v) => v.toFixed(0)).join(',')}ms)`
          : '')
      : 'server=(sem X-Response-Time — reinicie a API)';

  console.log(
    `${target.name}\n` +
      `  status=${lastStatus} bytes≈${lastBytes}\n` +
      `  wall avg=${avg(walls.measured).toFixed(1)}ms p95=${pct(walls.measured, 95).toFixed(1)}ms` +
      (walls.warm.length
        ? ` (cold ${walls.warm.map((v) => v.toFixed(0)).join(',')}ms)`
        : '') +
      `\n  ${server}\n`,
  );
}

console.log(
  'Stats ignoram os primeiros --warm rounds (cold). Compare no mesmo --base.',
);
