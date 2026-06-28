/**
 * Audita runtime relacional: HP, CA e view de combate.
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

const before = await c.query(`
  SELECT hp_current, ac_total
  FROM rpg.player_character WHERE id = 'pc-001'
`);

await c.query(`UPDATE rpg.player_character SET hp_current = 12 WHERE id = 'pc-001'`);

const afterHp = await c.query(`
  SELECT pc.hp_current, (f.document->'hp'->>'current')::int AS doc_hp
  FROM rpg.player_character pc
  JOIN rpg.v_player_character_full f ON f.id = pc.id
  WHERE pc.id = 'pc-001'
`);

if (Number(afterHp.rows[0].hp_current) !== 12 || Number(afterHp.rows[0].doc_hp) !== 12) {
  fail(`HP diverge: col=${afterHp.rows[0].hp_current} document=${afterHp.rows[0].doc_hp}`);
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
  SELECT ac_total, ac_shield_bonus AS shield
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

console.log("✓ Auditoria dinâmica OK — HP relacional, recalc CA, views runtime/full");
process.exit(0);
