-- Variante cultural anã: mesma espécie dwarf, pacotes substitutos (PHB + Northlands).

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), 'dwarfCultureId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit, edition_slug)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), 'dwarfCultureId', 'phb', 'Anão (Livro do Jogador)', 1,
  'Visão no Escuro 36 m; Resistência a Veneno; Tenacidade Anã (+1 PV máx./nível); Conhecimento de Pedras.',
  'Visão no Escuro 36 m; Resistência a Veneno; Tenacidade Anã (+1 PV máx./nível); Conhecimento de Pedras.',
  NULL
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), 'dwarfCultureId', 'baugsmidr', 'Anão dos Anéis (Baugsmidr)', 2,
  'Substitui o pacote PHB: Lore Arcano; Visão no Escuro 36 m; Resiliência Anã; Artesão Mágico; Sentir Magia.',
  'Substitui o pacote PHB: Lore Arcano; Visão no Escuro 36 m; Resiliência Anã; Artesão Mágico; Sentir Magia.',
  'northlands-heroes-2024-en'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), 'dwarfCultureId', 'fjord', 'Anão dos Fiordes', 3,
  'Substitui o pacote PHB: Visão no Escuro 27 m; Tenacidade Anã; Guerreiro dos Fiordes; Maestria das Ondas.',
  'Substitui o pacote PHB: Visão no Escuro 27 m; Tenacidade Anã; Guerreiro dos Fiordes; Maestria das Ondas.',
  'northlands-heroes-2024-en'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit,
  edition_slug = EXCLUDED.edition_slug;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
    'Variante cultural',
    'Escolha o pacote de traços desta espécie. As variantes de Northlands substituem integralmente os traços anões do Livro do Jogador.',
    'dwarf_culture'::rpg.species_choice_kind
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Recurso Sentir Magia passa a pertencer à espécie-base dwarf (gate por dwarfCultureId).
UPDATE rpg.phb_resource_definition
SET species_id = (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf')
WHERE slug = 'baugsmidr-sense-magic';

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'species'::rpg.resource_owner_kind, sp.id, rd.id, 1,
  'proficiency_bonus'::rpg.resource_max_formula, NULL,
  FALSE, FALSE, TRUE
FROM rpg.phb_species sp
JOIN rpg.phb_resource_definition rd ON rd.slug = 'baugsmidr-sense-magic' AND rd.species_id = sp.id
WHERE sp.slug = 'dwarf'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
