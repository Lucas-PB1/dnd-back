-- Traços do humano exigem escolhas (perícia, talento de origem, tamanho)

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

UPDATE rpg.phb_feat
SET name = 'Conjurador de Guerra'
WHERE slug = 'war-caster';

UPDATE rpg.phb_ability_generation_method
SET description = 'Jogue 4d6, descarte o menor dado e some os três restantes. Repita seis vezes. A soma dos seis atributos costuma ficar entre 72 e 80 (média ~73).'
WHERE slug = 'roll';
