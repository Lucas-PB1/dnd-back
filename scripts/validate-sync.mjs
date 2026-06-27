/**
 * Testa sync sheet ↔ projeções no PostgreSQL (requer banco populado).
 */
import pg from "pg";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const client = new pg.Client({ connectionString: url });
let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

try {
  await client.connect();

  const { rows: orig } = await client.query(
    `SELECT passive_perception, sheet->>'passivePerception' AS sheet_pp
     FROM rpg.player_character WHERE id = 'bjorn'`
  );
  const origPp = orig[0].passive_perception;

  // coluna → sheet
  await client.query(
    `UPDATE rpg.player_character SET passive_perception = 42 WHERE id = 'bjorn'`
  );
  const { rows: afterCol } = await client.query(
    `SELECT passive_perception, sheet->>'passivePerception' AS sheet_pp
     FROM rpg.player_character WHERE id = 'bjorn'`
  );
  if (Number(afterCol[0].sheet_pp) !== 42) {
    fail(`coluna→sheet: passive_perception=42, sheet=${afterCol[0].sheet_pp}`);
  }

  // sheet → coluna
  await client.query(
    `UPDATE rpg.player_character
     SET sheet = jsonb_set(sheet, '{passivePerception}', '17'::jsonb)
     WHERE id = 'bjorn'`
  );
  const { rows: afterSheet } = await client.query(
    `SELECT passive_perception FROM rpg.player_character WHERE id = 'bjorn'`
  );
  if (afterSheet[0].passive_perception !== 17) {
    fail(`sheet→coluna: passive_perception=${afterSheet[0].passive_perception}, esperado 17`);
  }

  // restaurar
  await client.query(
    `UPDATE rpg.player_character SET passive_perception = $1 WHERE id = 'bjorn'`,
    [origPp]
  );
  if (origPp != null) {
    await client.query(
      `UPDATE rpg.player_character
       SET sheet = jsonb_set(sheet, '{passivePerception}', to_jsonb($1::int))
       WHERE id = 'bjorn'`,
      [origPp]
    );
  }

  if (errors) {
    console.error(`\n${errors} falha(s) no sync.`);
    process.exit(1);
  }

  console.log("✓ Sync bidirecional OK (passivePerception, bjorn)");
} catch (err) {
  console.error(`✗ ${err.message}`);
  process.exit(1);
} finally {
  await client.end();
}
