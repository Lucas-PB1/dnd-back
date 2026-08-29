-- Ilustrações de catálogo (montarias, criaturas, veículos, itens da loja)

ALTER TABLE rpg.phb_creature_template
  ADD COLUMN IF NOT EXISTS image_url TEXT;

ALTER TABLE rpg.phb_vehicle_template
  ADD COLUMN IF NOT EXISTS image_url TEXT;

ALTER TABLE rpg.phb_item
  ADD COLUMN IF NOT EXISTS image_url TEXT;

COMMENT ON COLUMN rpg.phb_creature_template.image_url IS
  'Caminho público da ilustração (ex. /catalog/mounts/camelo.png no front).';

COMMENT ON COLUMN rpg.phb_vehicle_template.image_url IS
  'Caminho público da ilustração no front.';

COMMENT ON COLUMN rpg.phb_item.image_url IS
  'Caminho público da ilustração no front (loja/compêndio).';
