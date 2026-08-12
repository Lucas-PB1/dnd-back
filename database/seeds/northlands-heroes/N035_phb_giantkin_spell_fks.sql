-- Giantkin Nuvem / Tempestade — FKs de magia (Passo Aéreo / Personalidade Crepitante)

UPDATE rpg.phb_option_value ov
SET
  spell_level1_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'queda-suave'),
  spell_level3_id = NULL,
  spell_level5_id = NULL
WHERE ov.scope = 'species'::rpg.option_scope
  AND ov.owner_id = (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin')
  AND ov.option_key = 'giantkinAncestryId'
  AND ov.value_id = 'cloud';

UPDATE rpg.phb_option_value ov
SET
  spell_level1_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'levitacao'),
  spell_level3_id = NULL,
  spell_level5_id = NULL
WHERE ov.scope = 'species'::rpg.option_scope
  AND ov.owner_id = (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin')
  AND ov.option_key = 'giantkinAncestryId'
  AND ov.value_id = 'storm';
