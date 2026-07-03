-- Tabela rpg.phb_background_ability_option

CREATE TABLE rpg.phb_background_ability_option (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (background_id, ability_id)
);
