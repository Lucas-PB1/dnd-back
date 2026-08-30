-- Grim Hollow Cap. 2 — opções de subclasse (wizard create)
-- Gerado por scripts/generate-ghpg-cap2-subclass-options.mjs

-- collegeof-adventurers
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'Talento de Aventureiro 1',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'barbarian',
  'Bárbaro',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'cleric',
  'Clérigo',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'druid',
  'Druida',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'fighter',
  'Guerreiro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'monk',
  'Monge',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'paladin',
  'Paladino',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'ranger',
  'Patrulheiro',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'rogue',
  'Ladino',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'sorcerer',
  'Feiticeiro',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'warlock',
  'Bruxo',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent1',
  'wizard',
  'Mago',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'Talento de Aventureiro 2',
  6,
  'catalog'::rpg.option_value_type,
  2
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'barbarian',
  'Bárbaro',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'cleric',
  'Clérigo',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'druid',
  'Druida',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'fighter',
  'Guerreiro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'monk',
  'Monge',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'paladin',
  'Paladino',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'ranger',
  'Patrulheiro',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'rogue',
  'Ladino',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'sorcerer',
  'Feiticeiro',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'warlock',
  'Bruxo',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent2',
  'wizard',
  'Mago',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'Talento de Aventureiro 3',
  14,
  'catalog'::rpg.option_value_type,
  3
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'barbarian',
  'Bárbaro',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'cleric',
  'Clérigo',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'druid',
  'Druida',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'fighter',
  'Guerreiro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'monk',
  'Monge',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'paladin',
  'Paladino',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'ranger',
  'Patrulheiro',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'rogue',
  'Ladino',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'sorcerer',
  'Feiticeiro',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'warlock',
  'Bruxo',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  'adventurersTalent3',
  'wizard',
  'Mago',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;


-- misfortune-bringer
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'Desgraça 1',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-befuddled',
  'Maldição do Aturdido',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-clumsy',
  'Maldição do Desajeitado',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-debilitated',
  'Maldição do Debilitado',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-doomed',
  'Maldição do Condenado',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-fearful',
  'Maldição do Medroso',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-inept',
  'Maldição do Inábil',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-insensate',
  'Maldição do Insensível',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-maimed',
  'Maldição do Mutilado',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-marked',
  'Maldição do Marcado',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-plagued',
  'Maldição do Flagelado',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-somnolent',
  'Maldição do Sonolento',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune1',
  'curse-of-the-unlucky',
  'Maldição do Azarado',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'Desgraça 2',
  3,
  'catalog'::rpg.option_value_type,
  2
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-befuddled',
  'Maldição do Aturdido',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-clumsy',
  'Maldição do Desajeitado',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-debilitated',
  'Maldição do Debilitado',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-doomed',
  'Maldição do Condenado',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-fearful',
  'Maldição do Medroso',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-inept',
  'Maldição do Inábil',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-insensate',
  'Maldição do Insensível',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-maimed',
  'Maldição do Mutilado',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-marked',
  'Maldição do Marcado',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-plagued',
  'Maldição do Flagelado',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-somnolent',
  'Maldição do Sonolento',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune2',
  'curse-of-the-unlucky',
  'Maldição do Azarado',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'Desgraça 3',
  9,
  'catalog'::rpg.option_value_type,
  3
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-befuddled',
  'Maldição do Aturdido',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-clumsy',
  'Maldição do Desajeitado',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-debilitated',
  'Maldição do Debilitado',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-doomed',
  'Maldição do Condenado',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-fearful',
  'Maldição do Medroso',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-inept',
  'Maldição do Inábil',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-insensate',
  'Maldição do Insensível',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-maimed',
  'Maldição do Mutilado',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-marked',
  'Maldição do Marcado',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-plagued',
  'Maldição do Flagelado',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-somnolent',
  'Maldição do Sonolento',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune3',
  'curse-of-the-unlucky',
  'Maldição do Azarado',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'Desgraça 4',
  13,
  'catalog'::rpg.option_value_type,
  4
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-befuddled',
  'Maldição do Aturdido',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-clumsy',
  'Maldição do Desajeitado',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-debilitated',
  'Maldição do Debilitado',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-doomed',
  'Maldição do Condenado',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-fearful',
  'Maldição do Medroso',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-inept',
  'Maldição do Inábil',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-insensate',
  'Maldição do Insensível',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-maimed',
  'Maldição do Mutilado',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-marked',
  'Maldição do Marcado',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-plagued',
  'Maldição do Flagelado',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-somnolent',
  'Maldição do Sonolento',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune4',
  'curse-of-the-unlucky',
  'Maldição do Azarado',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'Desgraça 5',
  17,
  'catalog'::rpg.option_value_type,
  5
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-befuddled',
  'Maldição do Aturdido',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-clumsy',
  'Maldição do Desajeitado',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-debilitated',
  'Maldição do Debilitado',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-doomed',
  'Maldição do Condenado',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-fearful',
  'Maldição do Medroso',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-inept',
  'Maldição do Inábil',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-insensate',
  'Maldição do Insensível',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-maimed',
  'Maldição do Mutilado',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-marked',
  'Maldição do Marcado',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-plagued',
  'Maldição do Flagelado',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-somnolent',
  'Maldição do Sonolento',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  'misfortune5',
  'curse-of-the-unlucky',
  'Maldição do Azarado',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;


-- pathofthe-wrathful-dead
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'finalNightEmotion',
  'Emoção da Catarse da Noite Final',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'finalNightEmotion',
  'hate',
  'Ódio',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'finalNightEmotion',
  'jealousy',
  'Ciúme',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'finalNightEmotion',
  'terror',
  'Terror',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'darkDoomChannel',
  'Canal da Perdição Sombria',
  6,
  'catalog'::rpg.option_value_type,
  2
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'darkDoomChannel',
  'contamination',
  'Contaminação',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'darkDoomChannel',
  'hypothermia',
  'Hipotermia',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  'darkDoomChannel',
  'immolation',
  'Imolação',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;


-- living-crucible
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'Composto 1',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound1',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'Composto 2',
  3,
  'catalog'::rpg.option_value_type,
  2
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound2',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'Composto 3',
  3,
  'catalog'::rpg.option_value_type,
  3
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound3',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'Composto 4',
  7,
  'catalog'::rpg.option_value_type,
  4
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound4',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'Composto 5',
  7,
  'catalog'::rpg.option_value_type,
  5
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound5',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'Composto 6',
  10,
  'catalog'::rpg.option_value_type,
  6
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound6',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'Composto 7',
  10,
  'catalog'::rpg.option_value_type,
  7
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound7',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'Composto 8',
  15,
  'catalog'::rpg.option_value_type,
  8
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound8',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'Composto 9',
  15,
  'catalog'::rpg.option_value_type,
  9
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'adrenal-injection',
  'Injeção de Adrenalina',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'allsense-injection',
  'Injeção de Todos os Sentidos',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'arcane-eye-oil',
  'Óleo do Olho Arcano',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'draught-of-bulls-strength',
  'Elixir da Força do Touro',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'draught-of-cats-grace',
  'Elixir da Graça do Gato',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'draught-of-bears-endurance',
  'Elixir da Constituição do Urso',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'draught-of-foxs-cunning',
  'Elixir da Astúcia da Raposa',
  7
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'draught-of-owls-wisdom',
  'Elixir da Sabedoria da Coruja',
  8
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'draught-of-eagles-splendor',
  'Elixir do Esplendor da Águia',
  9
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'elfsight-oil',
  'Óleo da Visão Élfica',
  10
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'fleshknit-phosphate',
  'Fosfato de Costura de Carne',
  11
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'ironmind-injection',
  'Injeção de Mente de Ferro',
  12
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'liquid-courage',
  'Coragem Líquida',
  13
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'liquid-rage',
  'Fúria Líquida',
  14
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'presto-powder',
  'Pó Presto',
  15
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'spellshine-ointment',
  'Pomada Brilho Arcano',
  16
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'steelskin-ointment',
  'Pomada Pele de Aço',
  17
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  'compound9',
  'tenmen-tincture',
  'Tintura dos Dez Homens',
  18
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;


-- trapper-guild
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'Modificação de Armadura 1',
  15,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'damage-resistance',
  'Resistência a Dano',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'elemental-charge',
  'Carga Elemental',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'hardened-defense',
  'Defesa Endurecida',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'phase-leap',
  'Salto Fásico',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'regeneration',
  'Regeneração',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification1',
  'stealthy',
  'Furtividade',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'Modificação de Armadura 2',
  15,
  'catalog'::rpg.option_value_type,
  2
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'damage-resistance',
  'Resistência a Dano',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'elemental-charge',
  'Carga Elemental',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'hardened-defense',
  'Defesa Endurecida',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'phase-leap',
  'Salto Fásico',
  4
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'regeneration',
  'Regeneração',
  5
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  'armorModification2',
  'stealthy',
  'Furtividade',
  6
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;


-- pathofthe-primal-spirit
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionStatBlock',
  'Forma do Companheiro Primal',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionStatBlock',
  'primal-guardian',
  'Guardião Primal',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionStatBlock',
  'primal-striker',
  'Atacante Primal',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionEnvironment',
  'Ambiente do Companheiro',
  3,
  'catalog'::rpg.option_value_type,
  2
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionEnvironment',
  'land',
  'Terra',
  1
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionEnvironment',
  'sea',
  'Mar',
  2
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primalCompanionEnvironment',
  'sky',
  'Céu',
  3
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;


