CREATE TABLE rpg.phb_vehicle_template_trait (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_vehicle_template_trait_slug
  ON rpg.phb_vehicle_template_trait(template_slug);

-- IlustraÃ§Ãµes de catÃ¡logo (montarias, criaturas, veÃ­culos, itens da loja)







COMMENT ON COLUMN rpg.phb_creature_template.image_url IS
  'Caminho pÃºblico da ilustraÃ§Ã£o (ex. /catalog/mounts/camelo.png no front).';

COMMENT ON COLUMN rpg.phb_vehicle_template.image_url IS
  'Caminho pÃºblico da ilustraÃ§Ã£o no front.';

COMMENT ON COLUMN rpg.phb_item.image_url IS
  'Caminho pÃºblico da ilustraÃ§Ã£o no front (loja/compÃªndio).';

-- IlustraÃ§Ãµes de espÃ©cies e subclasses no compÃªndio





COMMENT ON COLUMN rpg.phb_species.image_url IS
  'Caminho pÃºblico da ilustraÃ§Ã£o (ex. /catalog/species/feathren.png).';

COMMENT ON COLUMN rpg.phb_subclass.image_url IS
  'Caminho pÃºblico da ilustraÃ§Ã£o (ex. /catalog/subclasses/path-of-the-glacier.png).';

-- Grim Hollow â€” build tradicional sugerido por heranÃ§a (preset 8 traÃ§os)
