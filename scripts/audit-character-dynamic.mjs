/**
 * Audita modelo híbrido: projeções vs sheet + sync runtime.
 */
const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const pg = await import("pg");
const c = new pg.default.Client({ connectionString: url });
await c.connect();

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

const drift = await c.query(`
  SELECT COUNT(*)::int AS n FROM rpg.player_character pc
  WHERE pc.hp_current IS DISTINCT FROM (pc.sheet->'hp'->>'current')::int
     OR pc.hp_max IS DISTINCT FROM (pc.sheet->'hp'->>'max')::int
     OR pc.ac_total IS DISTINCT FROM (pc.sheet->'armorClass'->>'total')::int
`);

if (drift.rows[0].n > 0) fail(`${drift.rows[0].n} personagens com drift colunas ↔ sheet`);

const before = await c.query(`
  SELECT hp_current, ac_total, sheet->'hp'->>'current' AS sheet_hp
  FROM rpg.player_character WHERE id = 'pc-001'
`);

await c.query(`UPDATE rpg.player_character SET hp_current = 12 WHERE id = 'pc-001'`);

const afterHp = await c.query(`
  SELECT hp_current, sheet->'hp'->>'current' AS sheet_hp
  FROM rpg.player_character WHERE id = 'pc-001'
`);

if (Number(afterHp.rows[0].hp_current) !== 12 || Number(afterHp.rows[0].sheet_hp) !== 12) {
  fail(`sync HP falhou: col=${afterHp.rows[0].hp_current} sheet=${afterHp.rows[0].sheet_hp}`);
}

const acBefore = await c.query(`
  SELECT ac_total FROM rpg.player_character WHERE id = 'pc-001'
`);

await c.query(`
  UPDATE rpg.player_character_equipment
  SET equipped = FALSE
  WHERE character_id = 'pc-001' AND slot = 'shield'
`);

const acAfter = await c.query(`
  SELECT ac_total, ac_detail->>'shieldBonus' AS shield
  FROM rpg.player_character WHERE id = 'pc-001'
`);

if (Number(acAfter.rows[0].shield) !== 0) {
  fail(`recalc CA deveria zerar escudo (shieldBonus=${acAfter.rows[0].shield})`);
}
if (Number(acAfter.rows[0].ac_total) >= Number(acBefore.rows[0].ac_total)) {
  fail(`CA deveria cair ao remover escudo (${acBefore.rows[0].ac_total} → ${acAfter.rows[0].ac_total})`);
}

const runtime = await c.query(`
  SELECT hp_current, ac_total FROM rpg.v_player_character_runtime WHERE id = 'pc-001'
`);
if (!runtime.rows.length) fail("v_player_character_runtime ausente");

// restaurar pc-001
await c.query(`UPDATE rpg.player_character SET hp_current = $1 WHERE id = 'pc-001'`, [
  before.rows[0].hp_current,
]);
await c.query(`
  UPDATE rpg.player_character_equipment
  SET equipped = TRUE
  WHERE character_id = 'pc-001' AND slot = 'shield'
`);

await c.end();

if (errors) {
  console.error(`\n${errors} falha(s) na auditoria dinâmica.`);
  process.exit(1);
}

console.log("✓ Auditoria dinâmica OK — sync HP, recalc CA, view runtime");
process.exit(0);
