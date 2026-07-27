-- Seed Gunslinger pack feats

INSERT INTO rpg.phb_feat (
  slug, name, category_id, repeatable, prerequisite, source_citation_id
)
VALUES (
  'marksman-s-luck',
  'Marksman’s Luck',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Level 4+, Dexterity 13+',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'Gun-Mage Adept',
  (SELECT id FROM rpg.phb_feat_category WHERE slug = 'general'),
  FALSE,
  'Level 4+, Spellcasting or Pact Magic Feature',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
