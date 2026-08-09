/**
 * Audita catálogo de mesa no DB vs seeds C009/C010 (+ recursos subclass).
 * Uso: node scripts/audit-combat-catalog.mjs
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

function extractActionIds(sql) {
  const ids = [];
  const re = /\('([a-z0-9-]+)'\s*,\s*\(SELECT id FROM rpg\.phb_class/gi;
  let m;
  while ((m = re.exec(sql))) ids.push(m[1]);
  return [...new Set(ids)];
}

function extractPanelKeys(sql) {
  const ids = [];
  const re = /\('((?:[a-z0-9|-]+))'\s*,\s*\(SELECT id FROM rpg\.phb_class/gi;
  let m;
  while ((m = re.exec(sql))) {
    if (m[1].includes('|') || m[1].startsWith('warlock') || m[1].includes('-')) {
      // panel keys look like class|...
      if (m[1].includes('|')) ids.push(m[1]);
    }
  }
  // more reliable: lines with panel_key pattern in first value
  const re2 = /^\('([^']+\|[^']+)'/gm;
  while ((m = re2.exec(sql))) ids.push(m[1]);
  return [...new Set(ids)];
}

const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida');
  process.exit(1);
}

const c009 = fs.readFileSync(
  path.join(rootDir, 'database/seeds/combat/C009_phb_class_economy_action.sql'),
  'utf8',
);
const c010 = fs.readFileSync(
  path.join(rootDir, 'database/seeds/combat/C010_phb_class_panel_action.sql'),
  'utf8',
);

const expectedEco = extractActionIds(c009);
const expectedPanel = extractPanelKeys(c010);

const client = createPgClient(url);
await client.connect();
console.log('DB', maskDatabaseUrl(url));

const eco = (
  await client.query(`
    SELECT e.action_id, c.slug AS class_slug, s.slug AS subclass_slug, e.table_action
    FROM rpg.phb_class_economy_action e
    JOIN rpg.phb_class c ON c.id = e.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = e.subclass_id
    ORDER BY c.slug, e.sort_order, e.action_id
  `)
).rows;

const panel = (
  await client.query(`
    SELECT p.panel_key, c.slug AS class_slug, s.slug AS subclass_slug
    FROM rpg.phb_class_panel_action p
    JOIN rpg.phb_class c ON c.id = p.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = p.subclass_id
    ORDER BY c.slug, p.sort_order, p.panel_key
  `)
).rows;

const ecoIds = new Set(eco.map((r) => r.action_id));
const panelKeys = new Set(panel.map((r) => r.panel_key));

const missingEco = expectedEco.filter((id) => !ecoIds.has(id));
const missingPanel = expectedPanel.filter((id) => !panelKeys.has(id));

function byClass(rows, key) {
  const m = new Map();
  for (const r of rows) {
    const list = m.get(r.class_slug) ?? [];
    list.push(r);
    m.set(r.class_slug, list);
  }
  return m;
}

const ecoByClass = byClass(eco, 'class_slug');
const panelByClass = byClass(panel, 'class_slug');

console.log('\n=== Contagem por classe ===');
const classes = [
  ...new Set([...ecoByClass.keys(), ...panelByClass.keys()]),
].sort();
for (const cls of classes) {
  console.log(
    `${cls.padEnd(12)} eco=${(ecoByClass.get(cls) ?? []).length}  panel=${(panelByClass.get(cls) ?? []).length}`,
  );
}

console.log(`\nSeed C009 action_ids: ${expectedEco.length}`);
console.log(`DB economy: ${eco.length} · faltam ${missingEco.length}`);
if (missingEco.length) {
  console.log('  missing eco:', missingEco.join(', '));
}

console.log(`\nSeed C010 panel_keys: ${expectedPanel.length}`);
console.log(`DB panel: ${panel.length} · faltam ${missingPanel.length}`);
if (missingPanel.length) {
  console.log('  missing panel:', missingPanel.join(', '));
}

const nullTa = eco.filter((r) => !r.table_action && r.action_id.includes('-'));
const spendWorthy = eco.filter(
  (r) =>
    r.resource_slug &&
    !r.table_action &&
    ['warlock', 'sorcerer', 'cleric', 'bard', 'druid', 'paladin', 'monk', 'ranger'].some(
      (p) => r.action_id.startsWith(p),
    ),
);
console.log(`\nEconomy sem table_action: ${eco.filter((r) => !r.table_action).length}`);

const subRes = (
  await client.query(`
    SELECT count(*)::int AS n FROM rpg.phb_resource_definition WHERE scope = 'subclass'
  `)
).rows[0].n;
console.log(`Resource defs subclass: ${subRes}`);

await client.end();

const report = {
  ecoTotal: eco.length,
  panelTotal: panel.length,
  missingEco,
  missingPanel,
  byClass: Object.fromEntries(
    classes.map((cls) => [
      cls,
      {
        eco: (ecoByClass.get(cls) ?? []).length,
        panel: (panelByClass.get(cls) ?? []).length,
      },
    ]),
  ),
};
fs.mkdirSync(path.join(rootDir, 'tmp'), { recursive: true });
fs.writeFileSync(
  path.join(rootDir, 'tmp', 'combat-catalog-audit.json'),
  JSON.stringify(report, null, 2),
);
console.log('\nRelatório: tmp/combat-catalog-audit.json');
process.exitCode = missingEco.length || missingPanel.length ? 1 : 0;
