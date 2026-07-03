/**
 * Gera database/seed-subclass-mechanics.sql a partir de subclass-mechanics-data.mjs
 * e dos traços já presentes no catálogo (data/phb/subclasses/*.json — somente leitura).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { SUBCLASS_SPELLS } from "./subclass-spell-data.mjs";
import { SUBCLASS_OPTIONS, SUBCLASS_RESOURCES, inferFeatureKind, subclassKey } from "./subclass-mechanics-data.mjs";
import { sqlStr, sqlInt } from "./lib/sql-escape.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const phb = path.join(root, "data/phb");
const outFile = path.join(root, "database", "seeds", "002_subclass_mechanics.sql");

const index = JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8"));
const subclassesDir = path.join(phb, "subclasses");

const lines = [];
lines.push("-- Mecânicas de subclasse — gerado por npm run generate:seed-subclass-mechanics");
lines.push("BEGIN;");

const spellSubclassKeys = new Set(
  Object.keys(SUBCLASS_SPELLS).map((k) => {
    const dash = k.indexOf("-");
    return subclassKey(k.slice(0, dash), k.slice(dash + 1));
  })
);

for (const classEntry of index.classes) {
  for (const sub of classEntry.subclasses) {
    const filePath = path.join(subclassesDir, `${classEntry.id}-${sub.id}.json`);
    if (!fs.existsSync(filePath)) continue;
    const doc = JSON.parse(fs.readFileSync(filePath, "utf8"));
    const key = subclassKey(classEntry.id, sub.id);
    const hasSpells = spellSubclassKeys.has(key);

    for (const feat of doc.features ?? []) {
      const kind = inferFeatureKind(feat.name, hasSpells);
      let optionKey = null;
      if (kind === "choice") {
        const opt = (SUBCLASS_OPTIONS[key] ?? []).find((o) => o.featureName === feat.name);
        optionKey = opt?.optionKey ?? null;
      }
      lines.push(
        `UPDATE rpg.phb_subclass_feature SET feature_kind = '${kind}'::rpg.subclass_feature_kind` +
          (optionKey ? `, option_key = ${sqlStr(optionKey)}` : "") +
          ` WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(sub.id)})` +
          ` AND level = ${feat.level} AND name = ${sqlStr(feat.name)};`
      );
    }
  }
}

for (const [key, resources] of Object.entries(SUBCLASS_RESOURCES)) {
  const [, subclassId] = key.split(":");
  for (const res of resources) {
    lines.push(
      `INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES (${sqlStr(res.slug)}, ${sqlStr(res.name)}, 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(subclassId)}),
         ${sqlInt(res.unlockLevel)})
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;`
    );
    lines.push(
      `INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, ${sqlInt(res.unlockLevel)}, '${res.maxFormula}'::rpg.resource_max_formula,
         ${res.fixedMax != null ? sqlInt(res.fixedMax) : "NULL"},
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = ${sqlStr(res.slug)}
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = ${sqlStr(res.featureName)}
       WHERE s.slug = ${sqlStr(subclassId)}
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;`
    );
  }
}

for (const [key, options] of Object.entries(SUBCLASS_OPTIONS)) {
  const [, subclassId] = key.split(":");
  for (const opt of options) {
    lines.push(
      `INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(subclassId)}),
         ${sqlStr(opt.optionKey)}, ${sqlStr(opt.label)}, ${sqlInt(opt.unlockLevel)}, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;`
    );
    for (let i = 0; i < opt.values.length; i++) {
      const v = opt.values[i];
      lines.push(
        `INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(subclassId)}),
           ${sqlStr(opt.optionKey)}, ${sqlStr(v.valueId)}, ${sqlStr(v.label)}, ${i + 1})
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;`
      );
    }
    if (opt.featureName) {
      lines.push(
        `UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = ${sqlStr(opt.optionKey)}
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(subclassId)})
           AND name = ${sqlStr(opt.featureName)};`
      );
    }
  }
}

for (const [fileKey, spellData] of Object.entries(SUBCLASS_SPELLS)) {
  const dash = fileKey.indexOf("-");
  const classId = fileKey.slice(0, dash);
  const subclassId = fileKey.slice(dash + 1);
  const sourceKey = spellData.preparedSpellSourceKey;

  lines.push(
    `INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES (${sqlStr(sourceKey)}, (SELECT name FROM rpg.phb_subclass WHERE slug = ${sqlStr(subclassId)}),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = ${sqlStr(classId)}),
       (SELECT id FROM rpg.phb_subclass WHERE slug = ${sqlStr(subclassId)}))
     ON CONFLICT (slug) DO NOTHING;`
  );

  if (spellData.preparedSpellsByLevel) {
    for (const [lvl, spellIds] of Object.entries(spellData.preparedSpellsByLevel)) {
      for (const spellId of spellIds) {
        lines.push(
          `INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, ${sqlInt(lvl)}, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = ${sqlStr(subclassId)} AND sp.slug = ${sqlStr(spellId)}
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;`
        );
      }
    }
  }

  if (spellData.preparedSpellsByTerrain) {
    for (const [terrainId, byLevel] of Object.entries(spellData.preparedSpellsByTerrain)) {
      for (const [lvl, spellIds] of Object.entries(byLevel)) {
        for (const spellId of spellIds) {
          lines.push(
            `INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, ${sqlInt(lvl)}, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = ${sqlStr(subclassId)} AND sp.slug = ${sqlStr(spellId)} AND t.slug = ${sqlStr(terrainId)}
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;`
          );
        }
      }
    }
  }
}

lines.push("COMMIT;");
lines.push("");

fs.writeFileSync(outFile, lines.join("\n"), "utf8");
console.log(`✓ ${path.relative(root, outFile)} — mecânicas de subclasse`);
