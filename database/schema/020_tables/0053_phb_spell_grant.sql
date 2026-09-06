CREATE TABLE rpg.phb_spell_grant (
  origin_type rpg.spell_grant_origin NOT NULL,
  origin_id BIGINT NOT NULL,
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  unlock_level INT NOT NULL DEFAULT 1,
  PRIMARY KEY (origin_type, origin_id, spell_id, unlock_level)
);

CREATE INDEX idx_phb_spell_grant_origin ON rpg.phb_spell_grant(origin_type, origin_id);

-- phb_combat_modifier: DROP — SSOT = phb_effect.combat_mod
