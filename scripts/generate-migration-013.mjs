/**
 * Gera database/migrations/013_player_character_feat_unlock_level.sql
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

const schema = `-- Progressão de talentos de classe — unlock_level + ASI relacional

DO $$ BEGIN
  CREATE TYPE rpg.feat_asi_mode AS ENUM ('single_plus_2', 'double_plus_1', 'single_plus_1');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

ALTER TABLE rpg.player_character_feat
  ADD COLUMN IF NOT EXISTS unlock_level INTEGER NOT NULL DEFAULT 1;

ALTER TABLE rpg.player_character_feat
  DROP CONSTRAINT IF EXISTS player_character_feat_unlock_level_check;

ALTER TABLE rpg.player_character_feat
  ADD CONSTRAINT player_character_feat_unlock_level_check
  CHECK (unlock_level >= 1 AND unlock_level <= 20);

ALTER TABLE rpg.player_character_feat_magic_initiate
  DROP CONSTRAINT IF EXISTS player_character_feat_magic_in_character_id_feat_id_source_fkey;

ALTER TABLE rpg.player_character_feat
  DROP CONSTRAINT IF EXISTS player_character_feat_pkey;

ALTER TABLE rpg.player_character_feat
  ADD PRIMARY KEY (character_id, feat_id, source, unlock_level);

ALTER TABLE rpg.player_character_feat_magic_initiate
  ADD COLUMN IF NOT EXISTS unlock_level INTEGER NOT NULL DEFAULT 1;

ALTER TABLE rpg.player_character_feat_magic_initiate
  DROP CONSTRAINT IF EXISTS player_character_feat_magic_initiate_pkey;

ALTER TABLE rpg.player_character_feat_magic_initiate
  ADD PRIMARY KEY (character_id, feat_id, source, unlock_level);

ALTER TABLE rpg.player_character_feat_magic_initiate
  ADD CONSTRAINT player_character_feat_magic_initiate_feat_fkey
  FOREIGN KEY (character_id, feat_id, source, unlock_level)
  REFERENCES rpg.player_character_feat(character_id, feat_id, source, unlock_level)
  ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS rpg.player_character_feat_asi (
  character_id  TEXT NOT NULL,
  feat_id       BIGINT NOT NULL,
  source        rpg.feat_source NOT NULL,
  unlock_level  INTEGER NOT NULL,
  mode          rpg.feat_asi_mode NOT NULL,
  ability_id_1  BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  ability_id_2  BIGINT REFERENCES rpg.phb_ability(id),
  PRIMARY KEY (character_id, feat_id, source, unlock_level),
  FOREIGN KEY (character_id, feat_id, source, unlock_level)
    REFERENCES rpg.player_character_feat(character_id, feat_id, source, unlock_level)
    ON DELETE CASCADE,
  CONSTRAINT player_character_feat_asi_ability_2_chk CHECK (
    (mode = 'double_plus_1' AND ability_id_2 IS NOT NULL)
    OR (mode <> 'double_plus_1' AND ability_id_2 IS NULL)
  )
);

DROP VIEW IF EXISTS rpg.v_player_character_full;

`;

const out = `${schema}\n${fn};\n\n${view};\n`;

fs.writeFileSync(
  path.join(root, "database/migrations/013_player_character_feat_unlock_level.sql"),
  out,
  "utf8"
);
console.log("✓ migration 013 gerada");
