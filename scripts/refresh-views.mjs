/**
 * REFRESH MATERIALIZED VIEW CONCURRENTLY — após seed ou alteração de catálogo.
 */
import { fileURLToPath } from "url";
import path from "path";
import { refreshMaterializedViews } from "./lib/refresh-views.mjs";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

let pg;
try {
  pg = await import("pg");
} catch {
  console.error("✗ Instale pg: npm install pg");
  process.exit(1);
}

const client = new pg.default.Client({ connectionString: url });
try {
  await client.connect();
  const ok = await refreshMaterializedViews(client);
  if (!ok) {
    console.error("✗ rpg.mv_spell_by_class ausente — rode npm run migrate:run");
    process.exit(1);
  }
  const { rows } = await client.query(
    "SELECT COUNT(*)::int AS n FROM rpg.mv_spell_by_class"
  );
  console.log(`✓ mv_spell_by_class — ${rows[0].n} linhas`);
} catch (err) {
  console.error(`✗ ${err.message}`);
  process.exit(1);
} finally {
  await client.end();
}
