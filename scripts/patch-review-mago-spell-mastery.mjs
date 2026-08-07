/**
 * One-shot: Review · Mago — magia 2º prepared + Dominância (spellMastery1/2).
 * Uso (em dnd-api): node scripts/patch-review-mago-spell-mastery.mjs
 */
import "dotenv/config";
import pg from "pg";

const OWNER_EMAIL = "lucasoaresnet@gmail.com";
const CHAR_NAME = "Review · Mago";

const url = process.env.DATABASE_URL;
if (!url) {
  console.error("DATABASE_URL missing");
  process.exit(1);
}

const client = new pg.Client({ connectionString: url });
await client.connect();

try {
  const users = await client.query(
    `SELECT id FROM auth.users WHERE email = $1 LIMIT 1`,
    [OWNER_EMAIL],
  );
  const userId = users.rows[0]?.id;
  if (!userId) throw new Error(`User not found: ${OWNER_EMAIL}`);

  const chars = await client.query(
    `SELECT id FROM rpg.player_character
     WHERE user_id = $1 AND name = $2 LIMIT 1`,
    [userId, CHAR_NAME],
  );
  const characterId = chars.rows[0]?.id;
  if (!characterId) throw new Error(`${CHAR_NAME} not found`);

  for (const listType of ["known", "prepared"]) {
    await client.query(
      `INSERT INTO rpg.player_character_spell (character_id, spell_slug, list_type)
       VALUES ($1, 'invisibilidade', $2)
       ON CONFLICT DO NOTHING`,
      [characterId, listType],
    );
  }

  for (const [key, value] of [
    ["spellMastery1", "misseis-magicos"],
    ["spellMastery2", "invisibilidade"],
  ]) {
    await client.query(
      `INSERT INTO rpg.player_character_class_option (character_id, option_key, value_id)
       VALUES ($1, $2, $3)
       ON CONFLICT (character_id, option_key) DO UPDATE SET value_id = EXCLUDED.value_id`,
      [characterId, key, value],
    );
  }

  console.log(
    `Patched ${CHAR_NAME} (${characterId}): spellMastery + invisibilidade`,
  );
} finally {
  await client.end();
}
