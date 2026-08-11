/**
 * Inventário de gaps C009 (economy actions) — description / table_action / cobertura de sub.
 * Uso: node scripts/audit-economy-action-gaps.cjs
 */
const fs = require('fs');
const path = require('path');
const { Client } = require('pg');

function loadEnv(filePath) {
  if (!fs.existsSync(filePath)) return;
  for (const line of fs.readFileSync(filePath, 'utf8').split(/\r?\n/)) {
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

loadEnv(path.join(__dirname, '..', '.env'));

async function main() {
  const url = process.env.DATABASE_URL || process.env.SUPABASE_DATABASE_URL;
  if (!url) {
    console.error('Defina DATABASE_URL');
    process.exit(1);
  }
  const client = new Client({
    connectionString: url,
    ssl: url.includes('supabase') ? { rejectUnauthorized: false } : undefined,
  });
  await client.connect();

  const noDescription = await client.query(`
    SELECT a.action_id, a.name, a.summary, a.table_action, a.resource_slug,
           c.slug AS class_slug, s.slug AS subclass_slug
    FROM rpg.phb_class_economy_action a
    LEFT JOIN rpg.phb_class c ON c.id = a.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = a.subclass_id
    WHERE a.description IS NULL OR btrim(a.description) = ''
    ORDER BY c.slug NULLS LAST, a.action_id
  `);

  const noTableAction = await client.query(`
    SELECT a.action_id, a.name, a.summary, a.resource_slug,
           c.slug AS class_slug, s.slug AS subclass_slug
    FROM rpg.phb_class_economy_action a
    LEFT JOIN rpg.phb_class c ON c.id = a.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = a.subclass_id
    WHERE a.class_id IS NOT NULL
      AND (a.table_action IS NULL OR btrim(a.table_action) = '')
    ORDER BY c.slug, a.action_id
  `);

  const emptySubs = await client.query(`
    SELECT c.slug AS class_slug, s.slug AS subclass_slug,
           (SELECT COUNT(*)::int FROM rpg.phb_class_economy_action e
            WHERE e.subclass_id = s.id) AS economy_rows
    FROM rpg.phb_subclass s
    JOIN rpg.phb_class c ON c.id = s.class_id
    WHERE c.slug IN (
      'fighter','rogue','wizard','paladin','warlock','barbarian',
      'bard','cleric','druid','monk','ranger','sorcerer','gunslinger'
    )
    ORDER BY c.slug, s.slug
  `);

  const report = {
    at: new Date().toISOString(),
    counts: {
      noDescription: noDescription.rowCount,
      noTableActionClassOwned: noTableAction.rowCount,
      subclassesWithZeroEconomy: emptySubs.rows.filter((r) => r.economy_rows === 0)
        .length,
    },
    noDescription: noDescription.rows,
    noTableActionClassOwned: noTableAction.rows,
    subclassesWithZeroEconomy: emptySubs.rows.filter((r) => r.economy_rows === 0),
    subclassEconomyCounts: emptySubs.rows,
  };

  console.log(JSON.stringify(report, null, 2));

  const outDir = path.join(__dirname, '..', '..', 'docs', 'plans');
  const out = fs.existsSync(outDir)
    ? path.join(outDir, 'audit-economy-action-gaps.json')
    : path.join(__dirname, '..', 'bench-out', 'audit-economy-action-gaps.json');
  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, `${JSON.stringify(report, null, 2)}\n`);
  console.error(`Wrote ${out}`);
  await client.end();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
