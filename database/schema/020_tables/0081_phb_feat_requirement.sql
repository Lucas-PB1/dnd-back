CREATE TABLE rpg.phb_feat_requirement (
  feat_id BIGINT PRIMARY KEY REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  minimum_level INTEGER CHECK (minimum_level BETWEEN 1 AND 20),
  requires_spellcasting BOOLEAN NOT NULL DEFAULT FALSE,
  required_armor_category_id BIGINT REFERENCES rpg.phb_armor_category(id),
  requires_fighting_style BOOLEAN NOT NULL DEFAULT FALSE,
  requires_weapon_mastery BOOLEAN NOT NULL DEFAULT FALSE
);
