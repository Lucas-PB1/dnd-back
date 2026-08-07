-- Battle Master (Fighter) maneuvers catalog

CREATE TABLE rpg.phb_battle_master_maneuver (
  id                BIGSERIAL PRIMARY KEY,
  slug              TEXT UNIQUE NOT NULL,
  name              TEXT NOT NULL,
  description       TEXT NOT NULL,
  timing            rpg.battle_master_maneuver_timing NOT NULL,
  adds_to_damage    BOOLEAN NOT NULL DEFAULT false,
  adds_to_attack    BOOLEAN NOT NULL DEFAULT false
);

CREATE INDEX idx_battle_master_maneuver_slug ON rpg.phb_battle_master_maneuver(slug);
