/**
 * Gera database/migrations/016_player_character_tool.sql
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

const schema = `-- Proficiências em ferramentas — player_character_tool + character_document

DO $$ BEGIN
  CREATE TYPE rpg.tool_source AS ENUM ('background', 'class', 'general', 'other');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS rpg.player_character_tool (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  item_id      BIGINT NOT NULL REFERENCES rpg.phb_item(id),
  source       rpg.tool_source NOT NULL,
  PRIMARY KEY (character_id, item_id)
);

DROP VIEW IF EXISTS rpg.v_player_character_full;

`;

const out = `${schema}\n${fn};\n\n${view};\n`;

fs.writeFileSync(
  path.join(root, "database/migrations/016_player_character_tool.sql"),
  out,
  "utf8"
);
console.log("✓ migration 016 gerada");
