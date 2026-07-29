-- Seed rpg.phb_species_trait.choice_kind — quais traços de espécie são escolhas
--
-- S045 insere os traços com choice_kind NULL (exceto elf_lineage/infernal_legacy/
-- dragon_ancestry). Este seed roda depois e marca as demais escolhas do PHB 2024,
-- além de criar os traços que existem apenas como escolha (Tamanho, Atributo de
-- conjuração). Fica no seed — e não numa migration de dados — para sobreviver a
-- re-seed: migration já aplicada não roda de novo e a escolha se perderia.

UPDATE rpg.phb_species_trait t
SET choice_kind = v.choice_kind::rpg.species_choice_kind
FROM rpg.phb_species sp,
  (VALUES
    ('human', 'Hábil', 'human_skill'),
    ('human', 'Versátil', 'human_origin_feat'),
    ('elf', 'Sentidos Aguçados', 'elf_keen_senses'),
    ('gnome', 'Linhagem Gnômica', 'gnome_lineage'),
    ('goliath', 'Ancestralidade Gigante', 'giant_ancestry')
  ) AS v(species_slug, trait_name, choice_kind)
WHERE sp.id = t.species_id
  AND sp.slug = v.species_slug
  AND t.name = v.trait_name
  AND t.choice_kind IS DISTINCT FROM v.choice_kind::rpg.species_choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT sp.id, v.trait_name, v.description, v.choice_kind::rpg.species_choice_kind
FROM rpg.phb_species sp
JOIN (VALUES
  (
    'human',
    'Tamanho',
    'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
    'human_size'
  ),
  (
    'tiefling',
    'Tamanho',
    'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
    'tiefling_size'
  ),
  (
    'aasimar',
    'Tamanho',
    'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
    'aasimar_size'
  ),
  (
    'elf',
    'Atributo de conjuração',
    'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração das magias da Linhagem Élfica.',
    'elf_casting_ability'
  ),
  (
    'gnome',
    'Atributo de conjuração',
    'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração das magias da Linhagem Gnômica.',
    'gnome_casting_ability'
  ),
  (
    'tiefling',
    'Atributo de conjuração',
    'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração do Legado Ínfero e da Presença Sobrenatural.',
    'infernal_casting_ability'
  )
) AS v(species_slug, trait_name, description, choice_kind) ON sp.slug = v.species_slug
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
