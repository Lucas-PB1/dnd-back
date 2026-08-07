/**
 * One-shot: gera seeds C009/C010 a partir do catálogo TS do front.
 * Run: node scripts/generate-economy-panel-seeds.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { createRequire } from "module";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, "..");
const frontRoot = path.resolve(root, "../dnd-front");

// Dynamic import of TS via vitest/tsx isn't available — parse the TS file as text.
const economyPath = path.join(
  frontRoot,
  "src/features/character/character-sheet/lib/combat/class-action-economy.ts",
);
const src = fs.readFileSync(economyPath, "utf8");

function extractObjects(source) {
  const results = [];
  const idRe = /id:\s*"([^"]+)"/g;
  let match;
  while ((match = idRe.exec(source))) {
    const id = match[1];
    // find start of object containing this id
    let start = match.index;
    while (start > 0 && source[start] !== "{") start--;
    let depth = 0;
    let end = start;
    for (; end < source.length; end++) {
      if (source[end] === "{") depth++;
      if (source[end] === "}") {
        depth--;
        if (depth === 0) {
          end++;
          break;
        }
      }
    }
    const block = source.slice(start, end);
    if (!block.includes(`id: "${id}"`)) continue;
    if (results.some((r) => r.id === id)) continue;

    const get = (key) => {
      const m = block.match(new RegExp(`${key}:\\s*"([^"]*)"`));
      return m ? m[1] : null;
    };
    const getNum = (key) => {
      const m = block.match(new RegExp(`${key}:\\s*(\\d+)`));
      return m ? Number(m[1]) : null;
    };
    const getBool = (key) => {
      const m = block.match(new RegExp(`${key}:\\s*(true|false)`));
      return m ? m[1] === "true" : false;
    };
    // multiline description/summary with possible escapes
    const getStr = (key) => {
      const m = block.match(
        new RegExp(`${key}:\\s*"((?:\\\\.|[^"\\\\])*)"`, "s"),
      );
      if (m) return m[1].replace(/\\n/g, "\n").replace(/\\"/g, '"');
      return null;
    };
    results.push({
      id,
      name: get("name"),
      economy: get("economy"),
      classSlug: get("classSlug"),
      minLevel: getNum("minLevel") ?? 1,
      subclassSlug: get("subclassSlug"),
      resourceSlug: get("resourceSlug"),
      freeResourceSlug: get("freeResourceSlug"),
      alwaysSpendsResource: getBool("alwaysSpendsResource"),
      summary: getStr("summary"),
      description: getStr("description"),
      tableAction: get("tableAction"),
      spendAmount: getNum("spendAmount"),
    });
  }
  return results;
}

function sqlStr(v) {
  if (v == null || v === "") return "NULL";
  return "'" + String(v).replace(/'/g, "''") + "'";
}

function classId(slug) {
  return `(SELECT id FROM rpg.phb_class WHERE slug = ${sqlStr(slug)})`;
}
function subclassId(slug) {
  if (!slug) return "NULL";
  return `(SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(slug)})`;
}

const economy = extractObjects(src);
console.log("economy actions:", economy.length);

let sort = 0;
const economyRows = economy.map((a, i) => {
  sort = i + 1;
  return `(${sqlStr(a.id)}, ${classId(a.classSlug)}, ${subclassId(a.subclassSlug)}, ${sqlStr(a.name)}, '${a.economy}'::rpg.action_economy_bucket, ${a.minLevel}, ${sqlStr(a.resourceSlug)}, ${sqlStr(a.freeResourceSlug)}, ${a.alwaysSpendsResource}, ${sqlStr(a.summary)}, ${sqlStr(a.description)}, ${sqlStr(a.tableAction)}, ${a.spendAmount == null ? "NULL" : a.spendAmount}, ${sort})`;
});

const c009 = `-- Seed: Class economy actions (UI Actions tab)
-- Generated from dnd-front class-action-economy.ts

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
${economyRows.join(",\n")}
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order;
`;

fs.writeFileSync(
  path.join(root, "database/seeds/combat/C009_phb_class_economy_action.sql"),
  c009,
);

// Panel actions from embedded JSON (extracted from panels)
const panelActions = JSON.parse(
  fs.readFileSync(path.join(__dirname, "panel-actions.json"), "utf8"),
);

const panelRows = panelActions.map((a) => {
  const panelKey = a.subclassSlug
    ? `${a.classSlug}|${a.subclassSlug}|${a.slug}`
    : `${a.classSlug}|${a.slug}`;
  return `(${sqlStr(panelKey)}, ${classId(a.classSlug)}, ${subclassId(a.subclassSlug)}, ${sqlStr(a.slug)}, ${sqlStr(a.name)}, ${sqlStr(a.title)}, ${a.unlockLevel}, ${sqlStr(a.resourceSlug)}, ${sqlStr(a.section)}::rpg.panel_action_section, ${a.spendsFocus}, ${a.sortOrder})`;
});

const c010 = `-- Seed: Class panel actions (combat class panels)
-- Generated from dnd-front combat-*-panel.tsx ACTION arrays

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
${panelRows.join(",\n")}
ON CONFLICT (panel_key) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  spends_focus = EXCLUDED.spends_focus,
  sort_order = EXCLUDED.sort_order;
`;

fs.writeFileSync(
  path.join(root, "database/seeds/combat/C010_phb_class_panel_action.sql"),
  c010,
);

console.log("panel actions:", panelActions.length);
console.log("wrote C009 and C010");
