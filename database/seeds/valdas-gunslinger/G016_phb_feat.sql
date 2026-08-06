-- Seed Pistoleiro pack feats

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'marksman-s-luck',
  'Sorte do Atirador',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, Destreza 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'gun-mage-adept',
  'Adepto do Mago-Pistoleiro',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Nível 4+, recurso Conjuração ou Magia de Pacto',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
