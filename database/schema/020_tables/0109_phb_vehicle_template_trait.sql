CREATE TABLE rpg.phb_vehicle_template_trait (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_vehicle_template_trait_slug
  ON rpg.phb_vehicle_template_trait(template_slug);

-- Ilustrações de catálogo (montarias, criaturas, veículos, itens da loja)







COMMENT ON COLUMN rpg.phb_creature_template.image_url IS
  'Caminho público da ilustração (ex. /catalog/mounts/camelo.png no front).';

COMMENT ON COLUMN rpg.phb_vehicle_template.image_url IS
  'Caminho público da ilustração no front.';

COMMENT ON COLUMN rpg.phb_item.image_url IS
  'Caminho público da ilustração no front (loja/compêndio).';

-- Ilustrações de espécies e subclasses no compêndio





COMMENT ON COLUMN rpg.phb_species.image_url IS
  'Caminho público da ilustração (ex. /catalog/species/feathren.png).';

COMMENT ON COLUMN rpg.phb_subclass.image_url IS
  'Caminho público da ilustração (ex. /catalog/subclasses/path-of-the-glacier.png).';

-- Grim Hollow — build tradicional sugerido por herança (preset 8 traços)
