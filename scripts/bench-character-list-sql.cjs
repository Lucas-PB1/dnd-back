/**
 * Benchmark SQL da listagem de personagens (antes/depois das otimizações).
 *
 * Uso:
 *   node scripts/bench-character-list-sql.cjs
 *   node scripts/bench-character-list-sql.cjs --label=before
 *   node scripts/bench-character-list-sql.cjs --label=after
 *
 * Escreve JSON em docs/plans/bench-character-list-{label}.json (relativo ao monorepo
 * se existir ../docs/plans, senão em ./bench-out/).
 *
 * Interpretação: com pooler remoto, latência de rede domina avg. Use p50Ms + bytes
 * como sinal principal; avg só com outlier grande pode enganar.
 */
const fs = require('fs');
const path = require('path');
const { Client } = require('pg');

function loadEnvFile(filePath) {
  if (!fs.existsSync(filePath)) return;
  const text = fs.readFileSync(filePath, 'utf8');
  for (const line of text.split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eq = trimmed.indexOf('=');
    if (eq < 0) continue;
    const key = trimmed.slice(0, eq).trim();
    let value = trimmed.slice(eq + 1).trim();
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    if (!(key in process.env)) process.env[key] = value;
  }
}

loadEnvFile(path.join(__dirname, '..', '.env'));

const labelArg = process.argv.find((a) => a.startsWith('--label='));
const label = labelArg ? labelArg.split('=')[1] : 'run';
const RUNS = 12;
const WARMUP = 2;

function stats(samples) {
  const sorted = [...samples].sort((a, b) => a - b);
  const sum = sorted.reduce((a, b) => a + b, 0);
  return {
    runs: sorted.length,
    minMs: Number(sorted[0].toFixed(2)),
    maxMs: Number(sorted[sorted.length - 1].toFixed(2)),
    avgMs: Number((sum / sorted.length).toFixed(2)),
    p50Ms: Number(sorted[Math.floor(sorted.length * 0.5)].toFixed(2)),
    p95Ms: Number(
      sorted[Math.min(sorted.length - 1, Math.ceil(sorted.length * 0.95) - 1)].toFixed(
        2,
      ),
    ),
  };
}

async function timeQuery(client, sql, params = []) {
  const t0 = performance.now();
  const result = await client.query(sql, params);
  const ms = performance.now() - t0;
  return { ms, rowCount: result.rowCount, bytes: JSON.stringify(result.rows).length };
}

/** Warmup + mede; devolve stats de tempo e meta da última amostra. */
async function measureSeries(client, sql, params, runs = RUNS) {
  for (let i = 0; i < WARMUP; i++) await timeQuery(client, sql, params);
  const times = [];
  let lastMeta = { rowCount: 0, bytes: 0 };
  for (let i = 0; i < runs; i++) {
    const r = await timeQuery(client, sql, params);
    times.push(r.ms);
    lastMeta = { rowCount: r.rowCount, bytes: r.bytes };
  }
  return { ...stats(times), ...lastMeta };
}

/**
 * Intercala A/B no mesmo loop para reduzir viés de cold/warm/rede.
 * Retorna { a, b } com same shape de measureSeries.
 */
async function measurePaired(client, sqlA, paramsA, sqlB, paramsB, runs = RUNS) {
  for (let i = 0; i < WARMUP; i++) {
    await timeQuery(client, sqlA, paramsA);
    await timeQuery(client, sqlB, paramsB);
  }
  const timesA = [];
  const timesB = [];
  let metaA = { rowCount: 0, bytes: 0 };
  let metaB = { rowCount: 0, bytes: 0 };
  for (let i = 0; i < runs; i++) {
    const a = await timeQuery(client, sqlA, paramsA);
    const b = await timeQuery(client, sqlB, paramsB);
    timesA.push(a.ms);
    timesB.push(b.ms);
    metaA = { rowCount: a.rowCount, bytes: a.bytes };
    metaB = { rowCount: b.rowCount, bytes: b.bytes };
  }
  return {
    a: { ...stats(timesA), ...metaA },
    b: { ...stats(timesB), ...metaB },
  };
}

function delta(full, slim) {
  return {
    avgMsSaved: Number((full.avgMs - slim.avgMs).toFixed(2)),
    avgMsPct:
      full.avgMs > 0
        ? Number((((full.avgMs - slim.avgMs) / full.avgMs) * 100).toFixed(1))
        : 0,
    p50MsSaved: Number((full.p50Ms - slim.p50Ms).toFixed(2)),
    p50MsPct:
      full.p50Ms > 0
        ? Number((((full.p50Ms - slim.p50Ms) / full.p50Ms) * 100).toFixed(1))
        : 0,
    bytesSaved: full.bytes - slim.bytes,
    bytesPct:
      full.bytes > 0
        ? Number((((full.bytes - slim.bytes) / full.bytes) * 100).toFixed(1))
        : 0,
  };
}

async function main() {
  const url = process.env.SUPABASE_DATABASE_URL || process.env.DATABASE_URL;
  if (!url) {
    console.error('Defina DATABASE_URL ou SUPABASE_DATABASE_URL');
    process.exit(1);
  }

  const client = new Client({
    connectionString: url,
    ssl: url.includes('supabase') ? { rejectUnauthorized: false } : undefined,
  });
  await client.connect();

  const userPick = await client.query(`
    SELECT user_id::text AS user_id, COUNT(*)::int AS n
    FROM rpg.player_character
    GROUP BY user_id
    ORDER BY n DESC
    LIMIT 1
  `);

  if (userPick.rowCount === 0) {
    console.error('Nenhum player_character no banco — seed necessário');
    await client.end();
    process.exit(1);
  }

  const userId = userPick.rows[0].user_id;
  const characterCount = userPick.rows[0].n;

  const listSqlFull = `
    SELECT *
    FROM rpg.player_character
    WHERE user_id = $1::uuid
    ORDER BY updated_at DESC
  `;
  const listSqlSlim = `
    SELECT
      id, name, level,
      class_slug, species_slug, background_slug, subclass_slug,
      created_at, updated_at
    FROM rpg.player_character
    WHERE user_id = $1::uuid
    ORDER BY updated_at DESC
  `;

  const listPaired = await measurePaired(
    client,
    listSqlFull,
    [userId],
    listSqlSlim,
    [userId],
  );
  const fullList = { name: 'list_player_character_FULL', ...listPaired.a };
  const slimList = { name: 'list_player_character_SLIM', ...listPaired.b };

  const campaignIds = await client.query(
    `
    SELECT DISTINCT cc.campaign_id::text AS id
    FROM rpg.campaign_character cc
    JOIN rpg.player_character pc ON pc.id = cc.character_id
    WHERE pc.user_id = $1::uuid
    `,
    [userId],
  );
  const ids = campaignIds.rows.map((r) => r.id);

  let campaignFull = null;
  let campaignSlim = null;
  if (ids.length > 0) {
    const campPaired = await measurePaired(
      client,
      `SELECT * FROM rpg.campaign WHERE id = ANY($1::uuid[])`,
      [ids],
      `
      SELECT id, name, allow_player_skip_payment
      FROM rpg.campaign
      WHERE id = ANY($1::uuid[])
      `,
      [ids],
    );
    campaignFull = { name: 'campaigns_FULL', ...campPaired.a };
    campaignSlim = { name: 'campaigns_SLIM', ...campPaired.b };
  }

  await client.end();

  const report = {
    label,
    at: new Date().toISOString(),
    method: 'paired-interleaved FULL/SLIM; prefer p50Ms + bytes over avgMs on remote pooler',
    sample: {
      userIdPrefix: `${userId.slice(0, 8)}…`,
      characterCount,
      campaignCount: ids.length,
    },
    results: [fullList, slimList, campaignFull, campaignSlim].filter(Boolean),
    deltas: {
      list: delta(fullList, slimList),
      campaigns:
        campaignFull && campaignSlim ? delta(campaignFull, campaignSlim) : null,
    },
  };

  console.log(JSON.stringify(report, null, 2));

  const outDirs = [
    path.join(__dirname, '..', '..', 'docs', 'plans'),
    path.join(__dirname, '..', 'bench-out'),
  ];
  let outDir = outDirs.find((d) => fs.existsSync(d));
  if (!outDir) {
    outDir = outDirs[1];
    fs.mkdirSync(outDir, { recursive: true });
  }
  const outFile = path.join(outDir, `bench-character-list-${label}.json`);
  fs.writeFileSync(outFile, `${JSON.stringify(report, null, 2)}\n`);
  console.error(`Wrote ${outFile}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
