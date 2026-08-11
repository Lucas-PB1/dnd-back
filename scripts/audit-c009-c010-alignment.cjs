/**
 * Auditoria de alinhamento C009 (economy) ↔ C010 (panel).
 * Uso: node scripts/audit-c009-c010-alignment.cjs
 *
 * Aceite pós-fix: hardGap === 0 · c010TitleNull === 0 ·
 * economyUsarNoPanel só allowlist (ranger pools documentados).
 */
const fs = require('fs');
const path = require('path');
const { Client } = require('pg');

/** Usar na Economia sem atalho C010 de propósito. */
const ECONOMY_USAR_NO_PANEL_ALLOWLIST = new Set([
  'hunters-mark-free',
  'tireless',
  'natures-veil',
  // Painel paladino: UI com amount hardcoded (não C010)
  'lay-on-hands',
]);

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

function isProtocolTableAction(tableAction) {
  if (!tableAction) return true;
  if (tableAction === 'spend-resource') return true;
  return /^(cast:|arm:|psi:)/.test(tableAction);
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

  const panelRows = await client.query(`
    SELECT p.panel_key, p.slug, p.name, p.title, p.unlock_level,
           c.slug AS class_slug, s.slug AS subclass_slug
    FROM rpg.phb_class_panel_action p
    JOIN rpg.phb_class c ON c.id = p.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = p.subclass_id
    ORDER BY c.slug, p.panel_key
  `);

  const economyRows = await client.query(`
    SELECT a.action_id, a.name, a.summary, a.description, a.table_action,
           c.slug AS class_slug, s.slug AS subclass_slug
    FROM rpg.phb_class_economy_action a
    LEFT JOIN rpg.phb_class c ON c.id = a.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = a.subclass_id
    WHERE a.class_id IS NOT NULL
    ORDER BY c.slug, a.action_id
  `);

  const enrichKeys = new Set();
  for (const row of economyRows.rows) {
    if (!row.class_slug || !row.table_action) continue;
    if (isProtocolTableAction(row.table_action)) continue;
    enrichKeys.add(`${row.class_slug}|${row.table_action}`);
  }

  const panelKeys = new Set();
  for (const row of panelRows.rows) {
    panelKeys.add(`${row.class_slug}|${row.slug}`);
  }

  const titleNull = panelRows.rows.filter(
    (r) => r.title == null || String(r.title).trim() === '',
  );

  const panelNoEconomyEnrichment = panelRows.rows.filter(
    (r) => !enrichKeys.has(`${r.class_slug}|${r.slug}`),
  );

  const hardGap = titleNull.filter(
    (r) => !enrichKeys.has(`${r.class_slug}|${r.slug}`),
  );

  const economyUsarNoPanel = economyRows.rows.filter((r) => {
    if (!r.table_action || isProtocolTableAction(r.table_action)) return false;
    if (ECONOMY_USAR_NO_PANEL_ALLOWLIST.has(r.table_action)) return false;
    return !panelKeys.has(`${r.class_slug}|${r.table_action}`);
  });

  const economyUsarNoPanelAllowlisted = economyRows.rows.filter(
    (r) =>
      r.table_action &&
      ECONOMY_USAR_NO_PANEL_ALLOWLIST.has(r.table_action) &&
      !panelKeys.has(`${r.class_slug}|${r.table_action}`),
  );

  let duplicateShortcutCount = 0;
  for (const row of panelRows.rows) {
    if (enrichKeys.has(`${row.class_slug}|${row.slug}`)) {
      duplicateShortcutCount += 1;
    }
  }

  const byClass = (rows) => {
    const map = {};
    for (const r of rows) {
      const key = r.class_slug || '?';
      if (!map[key]) map[key] = [];
      map[key].push({
        panel_key: r.panel_key,
        slug: r.slug,
        name: r.name,
        title: r.title,
        subclass_slug: r.subclass_slug,
      });
    }
    return map;
  };

  const report = {
    at: new Date().toISOString(),
    counts: {
      panelTotal: panelRows.rowCount,
      economyClassOwned: economyRows.rowCount,
      c010TitleNull: titleNull.length,
      hardGap: hardGap.length,
      panelNoEconomyEnrichment: panelNoEconomyEnrichment.length,
      economyUsarNoPanel: economyUsarNoPanel.length,
      economyUsarNoPanelAllowlisted: economyUsarNoPanelAllowlisted.length,
      duplicateShortcutCount,
    },
    hardGap: hardGap.map((r) => ({
      panel_key: r.panel_key,
      class_slug: r.class_slug,
      slug: r.slug,
      name: r.name,
    })),
    c010TitleNull: titleNull.map((r) => ({
      panel_key: r.panel_key,
      class_slug: r.class_slug,
      slug: r.slug,
      name: r.name,
    })),
    panelNoEconomyEnrichmentByClass: byClass(panelNoEconomyEnrichment),
    economyUsarNoPanel: economyUsarNoPanel.map((r) => ({
      action_id: r.action_id,
      class_slug: r.class_slug,
      table_action: r.table_action,
      name: r.name,
    })),
    economyUsarNoPanelAllowlisted: economyUsarNoPanelAllowlisted.map((r) => ({
      action_id: r.action_id,
      class_slug: r.class_slug,
      table_action: r.table_action,
      name: r.name,
    })),
  };

  console.log(JSON.stringify(report.counts, null, 2));

  const outDir = path.join(__dirname, '..', '..', 'docs', 'plans');
  const out = fs.existsSync(outDir)
    ? path.join(outDir, 'audit-c009-c010-alignment.json')
    : path.join(__dirname, '..', 'bench-out', 'audit-c009-c010-alignment.json');
  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, `${JSON.stringify(report, null, 2)}\n`);
  console.error(`Wrote ${out}`);
  await client.end();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
