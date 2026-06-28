/**
 * Atualiza materialized views do catálogo após seed.
 */
export async function refreshMaterializedViews(client) {
  const { rows } = await client.query(`
    SELECT 1 FROM pg_matviews
    WHERE schemaname = 'rpg' AND matviewname = 'mv_spell_by_class'
  `);
  if (!rows.length) return false;

  await client.query(
    "REFRESH MATERIALIZED VIEW CONCURRENTLY rpg.mv_spell_by_class"
  );
  return true;
}
