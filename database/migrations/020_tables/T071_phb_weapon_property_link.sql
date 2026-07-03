-- Tabela rpg.phb_weapon_property_link

CREATE TABLE rpg.phb_weapon_property_link (
  weapon_id BIGINT NOT NULL REFERENCES rpg.phb_weapon(item_id) ON DELETE CASCADE,
  property_id BIGINT NOT NULL REFERENCES rpg.phb_weapon_property(id) ON DELETE CASCADE,
  PRIMARY KEY (weapon_id, property_id)
);
