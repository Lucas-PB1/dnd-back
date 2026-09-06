-- Recursos de espécie — Northlands Heroes of the Sagas
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, min_level)
VALUES
  (
    'bearfolk-apex-predator',
    'Predador de Ápice',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    1
  ),
  (
    'bearfolk-bear-hug',
    'Abraço do Urso',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    1
  ),
  (
    'giantkin-burning-blood',
    'Sangue Ardente',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
    1
  ),
  (
    'trollkin-fey-charm',
    'Dado Fey',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
    1
  ),
  (
    'werekin-shift-aspect',
    'Mudar Aspecto',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    1
  ),
  (
    'baugsmidr-sense-magic',
    'Sentir Magia',
    'species'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  species_id = EXCLUDED.species_id,
  min_level = EXCLUDED.min_level;

-- Predador de Ápice: PB / LR


-- Abraço do Urso: CON mod / LR (Garhamr)


-- Sangue Ardente: PB / LR


-- Dado Fey: CHA mod / LR


-- Mudar Aspecto: 1 / LR


-- Sentir Magia: PB / LR

