-- Recursos de espécie — Manikin / Scourgeborne (Eldritch Hunt)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, min_level)
VALUES
  (
    'manikin-custodian-intercept',
    'Intercepção do Custódio',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    1
  ),
  (
    'manikin-thespian-bond',
    'Conexão Teatral',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    1
  ),
  (
    'scourgeborne-lineage',
    'Linhagem Monstruosa',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
    3
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  species_id = EXCLUDED.species_id,
  min_level = EXCLUDED.min_level;

-- Custódio: Reação PB / LR


-- Teatral: 1 conexão / SR+LR


-- Linhagem: L3 = 1/LR; L5 = PB/LR (Vespertilio também SR — MVP recupera em SR+LR)



