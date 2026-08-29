-- Ilustrações de espécies e subclasses no compêndio

ALTER TABLE rpg.phb_species
  ADD COLUMN IF NOT EXISTS image_url TEXT;

ALTER TABLE rpg.phb_subclass
  ADD COLUMN IF NOT EXISTS image_url TEXT;

COMMENT ON COLUMN rpg.phb_species.image_url IS
  'Caminho público da ilustração (ex. /catalog/species/feathren.png).';

COMMENT ON COLUMN rpg.phb_subclass.image_url IS
  'Caminho público da ilustração (ex. /catalog/subclasses/path-of-the-glacier.png).';
