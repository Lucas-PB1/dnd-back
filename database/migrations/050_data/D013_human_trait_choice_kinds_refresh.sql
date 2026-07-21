-- Reaplica choice_kinds do humano após re-seed (D001 já aplicada não roda de novo)

UPDATE rpg.phb_species_trait t
SET choice_kind = 'human_skill'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'human'
  AND t.name = 'Hábil';

UPDATE rpg.phb_species_trait t
SET choice_kind = 'human_origin_feat'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'human'
  AND t.name = 'Versátil';

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Tamanho',
  'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
  'human_size'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'human'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
