/**
 * Gera database/migrations/018_player_character_tool_bg_flag.sql
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const ddl = fs.readFileSync(path.join(root, "scripts/lib/player-character-ddl.mjs"), "utf8");
const fnStart = ddl.indexOf("CREATE OR REPLACE FUNCTION rpg.character_document");
const fnEnd = ddl.indexOf("CREATE OR REPLACE VIEW rpg.v_player_character_full", fnStart);
const fn = ddl.slice(fnStart, fnEnd).trim();

const viewStart = fnEnd;
const viewEnd = ddl.indexOf("CREATE OR REPLACE VIEW rpg.v_character_resources", viewStart);
const view = ddl.slice(viewStart, viewEnd).trim();

const schema = `-- Marca a ferramenta escolhida do antecedente (round-trip backgroundChoices)

ALTER TABLE rpg.player_character_tool
  ADD COLUMN IF NOT EXISTS is_background_proficiency BOOLEAN NOT NULL DEFAULT FALSE;

DROP VIEW IF EXISTS rpg.v_player_character_full;

`;

const out = `${schema}\n${fn};\n\n${view};\n`;

fs.writeFileSync(
  path.join(root, "database/migrations/018_player_character_tool_bg_flag.sql"),
  out,
  "utf8"
);
console.log("✓ migration 018 gerada");
