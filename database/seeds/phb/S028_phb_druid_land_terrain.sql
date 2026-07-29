-- Seed rpg.phb_druid_land_terrain
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_druid_land_terrain (slug, label)
VALUES
  ('arid', 'arid'),
  ('polar', 'polar'),
  ('temperate', 'temperate'),
  ('tropical', 'tropical')
ON CONFLICT (slug) DO NOTHING;
