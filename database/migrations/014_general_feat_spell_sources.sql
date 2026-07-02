-- Fontes de magia para talentos gerais com conjuração

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, feat_id)
VALUES
  ('fey-touched', 'Tocado pelas Fadas', 'feat', (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')),
  ('shadow-touched', 'Tocado pela Sombra', 'feat', (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')),
  ('telekinetic', 'Telecinético', 'feat', (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')),
  ('telepathic', 'Telepático', 'feat', (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'))
ON CONFLICT (slug) DO NOTHING;
