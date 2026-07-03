-- Tabela rpg.phb_class_weapon_proficiency

CREATE TABLE rpg.phb_class_weapon_proficiency (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  proficiency_id BIGINT NOT NULL REFERENCES rpg.phb_weapon_proficiency(id),
  PRIMARY KEY (class_id, proficiency_id)
);
