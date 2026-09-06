-- Opções Feathren — ancestria aviária/felina + magias concedidas

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Ancestria aviária (truque)
INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order,
  level1_benefit, spell_level1_id, edition_slug
)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'jay-owl-raven', 'Gaio, Coruja ou Corvo', 1,
  'Truque: Taumaturgia.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'taumaturgia'),
  'griffons-saddlebag-book-one-2024-en'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'eagle-falcon-hawk', 'Águia, Falcão ou Gavião', 2,
  'Truque: Mensagem.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'mensagem'),
  'griffons-saddlebag-book-one-2024-en'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'cardinal-mockingbird-parrot', 'Cardeal, Sabiá ou Papagaio', 3,
  'Truque: Prestidigitação Arcana.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'prestidigitacao-arcana'),
  'griffons-saddlebag-book-one-2024-en'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level1_id = EXCLUDED.spell_level1_id,
  edition_slug = EXCLUDED.edition_slug;

-- Ancestria felina (magia desbloqueada no 3º nível de personagem)
INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order,
  level1_benefit, spell_level3_id, edition_slug
)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'lion-panther-saber', 'Leão, Pantera ou Tigre-dentes-de-sabre', 1,
  'Magia (3º nível de personagem): Detectar o Bem e o Mal.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-o-bem-e-o-mal'),
  'griffons-saddlebag-book-one-2024-en'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'cheetah-serval-tiger', 'Guepardo, Serval ou Tigre', 2,
  'Magia (3º nível de personagem): Detectar Veneno e Doença.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-veneno-e-doenca'),
  'griffons-saddlebag-book-one-2024-en'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'jaguar-lynx-snow-leopard', 'Onça, Lince ou Leopardo-das-neves', 3,
  'Magia (3º nível de personagem): Detectar Magia.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-magia'),
  'griffons-saddlebag-book-one-2024-en'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level3_id = EXCLUDED.spell_level3_id,
  edition_slug = EXCLUDED.edition_slug;

-- Magias fixas da ancestria (Identificar L1, Aprimorar Atributo L5)
INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'identificar'),
    1
  ),
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'aprimorar-atributo'),
    5
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
