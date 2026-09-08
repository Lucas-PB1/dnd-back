import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Client } = require("../node_modules/pg");

/**
 * Reaplica views de labels (mojibake) e recria MVs/views dependentes
 * que o DROP … CASCADE derruba (species trait choices, feat, heritage).
 */
const labelViews = [
  "030_views/0001_v_phb_ability_generation_method.sql",
  "030_views/0002_v_phb_feat_category.sql",
  "030_views/0003_v_phb_weapon_proficiency.sql",
  "030_views/0036_v_phb_species_trait_choices.sql",
  "030_views/0037_v_phb_heritage_trait_choices.sql",
  "030_views/0056_v_phb_condition.sql",
];

/** Dependentes de label views — ordem: views base → MVs → índices únicos. */
const dependents = [
  {
    file: "030_views/0024_v_phb_feat.sql",
    drop: "DROP VIEW IF EXISTS rpg.v_phb_feat CASCADE",
  },
  {
    file: "030_views/0040_mv_phb_feat.sql",
    drop: "DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_feat CASCADE",
    uniqueIndex:
      "CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_phb_feat ON rpg.mv_phb_feat (feat_slug)",
  },
  {
    file: "030_views/0042_mv_phb_species_trait_choices.sql",
    drop: "DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_species_trait_choices CASCADE",
    uniqueIndex:
      "CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_phb_species_trait_choices ON rpg.mv_phb_species_trait_choices (species_slug, choice_kind, choice_slug)",
  },
  {
    file: "030_views/0055_mv_phb_heritage_trait_choices.sql",
    // arquivo também cria índices de catálogo; aplicamos só a MV via SQL mínimo
    sql: `CREATE MATERIALIZED VIEW rpg.mv_phb_heritage_trait_choices AS
  SELECT * FROM rpg.v_phb_heritage_trait_choices`,
    drop: "DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_heritage_trait_choices CASCADE",
    uniqueIndex:
      "CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_phb_heritage_trait_choices ON rpg.mv_phb_heritage_trait_choices (heritage_slug, choice_kind, trait_slug)",
  },
];

function viewNameFromSql(sql) {
  const m = sql.match(
    /CREATE\s+(?:OR\s+REPLACE\s+)?(?:MATERIALIZED\s+)?VIEW\s+([^\s(]+)/i,
  );
  return m?.[1] ?? null;
}

const client = new Client({
  connectionString: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});

await client.connect();

await client.query(
  "DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_heritage_trait_choices CASCADE",
);
await client.query(
  "DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_species_trait_choices CASCADE",
);
await client.query("DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_feat CASCADE");

for (const rel of labelViews) {
  const file = path.resolve("database/schema", rel);
  const sql = fs.readFileSync(file, "utf8");
  const name = viewNameFromSql(sql);
  if (!name) throw new Error(`No view name in ${rel}`);
  console.log("recreate", name);
  await client.query(`DROP VIEW IF EXISTS ${name} CASCADE`);
  await client.query(sql);
}

for (const step of dependents) {
  console.log("restore dependent", step.file);
  await client.query(step.drop);
  if (step.sql) {
    await client.query(step.sql);
  } else {
    const sql = fs.readFileSync(
      path.resolve("database/schema", step.file),
      "utf8",
    );
    // 0055 traz índices extras; se vier o arquivo completo, pega só a 1ª statement MV
    if (step.file.includes("0055_mv_phb_heritage")) {
      await client.query(`
CREATE MATERIALIZED VIEW rpg.mv_phb_heritage_trait_choices AS
  SELECT * FROM rpg.v_phb_heritage_trait_choices`);
    } else {
      await client.query(sql);
    }
  }
  if (step.uniqueIndex) {
    await client.query(step.uniqueIndex);
  }
}

const checks = await client.query(`
  SELECT 'heritage_size' AS src, choice_slug, choice_name
  FROM rpg.v_phb_heritage_trait_choices
  WHERE choice_kind = 'heritage_size'
  ORDER BY choice_slug
`);
for (const row of checks.rows) {
  console.log(row.src, row.choice_slug, "=>", row.choice_name);
}

const human = await client.query(`
  SELECT COUNT(*)::int AS n
  FROM rpg.mv_phb_species_trait_choices
  WHERE species_slug = 'human'
`);
console.log("human trait choices:", human.rows[0].n);

await client.end();
