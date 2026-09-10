-- Golpes de Sangue (Blood Hound) — pacotes tipados em phb_effect.
-- requires_option_key = 'strikeOption', requires_option_value = slug do golpe.
-- Labels: phb_option_value (bloodStrike*).

DELETE FROM rpg.phb_effect e
USING rpg.phb_subclass s
WHERE e.owner_kind = 'subclass'
  AND e.owner_id = s.id
  AND s.slug = 'blood-hound'
  AND e.requires_option_key = 'strikeOption';

-- ─── helpers via CTEs por golpe ─────────────────────────────────────────────

-- bewitching-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
gate AS (
  SELECT owner.id AS owner_id, 'strikeOption'::text AS opt_key, 'bewitching-strike'::text AS opt_val,
         'Golpe Enfeitiçante'::text AS strike_label, 'blood-strike'::text AS res, 'blood-strike'::text AS act
  FROM owner
),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner_id, 'on_option_use', 3, 10, strike_label,
         res, act, opt_key, opt_val
  FROM gate
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d8', 'psychic' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe Enfeitiçante',
         'strikeOption', 'bewitching-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', '4d6', 18, 'psychic' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'feature_save', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe Enfeitiçante',
         'strikeOption', 'bewitching-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_save (effect_id, save_ability, dc_ability, dc_formula)
SELECT id, 'wisdom', NULL, 'eight_plus_mod_plus_pb' FROM ins;

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
  requires_option_key, requires_option_value
)
SELECT 'combat_note', 'subclass', owner.id, 'on_hit', 3, 40, 'Golpe Enfeitiçante',
       'strikeOption', 'bewitching-strike'
FROM rpg.phb_subclass owner
WHERE owner.slug = 'blood-hound';

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Efeito narrativo / mesa (note_only).'
FROM rpg.phb_effect e
JOIN rpg.phb_subclass s ON s.id = e.owner_id AND e.owner_kind = 'subclass'
WHERE s.slug = 'blood-hound'
  AND e.requires_option_value = 'bewitching-strike'
  AND e.kind = 'combat_note';

-- bloodboil-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe Ferver-Sangue',
         'blood-strike', 'blood-strike', 'strikeOption', 'bloodboil-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d6', 'fire' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe Ferver-Sangue',
         'strikeOption', 'bloodboil-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', '4d6', 18, 'fire' FROM ins;

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
  requires_option_key, requires_option_value
)
SELECT 'ignore_damage_resistance', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe Ferver-Sangue',
       'strikeOption', 'bloodboil-strike'
FROM rpg.phb_subclass owner
WHERE owner.slug = 'blood-hound';

-- bloodshard-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe Estilhaço-Sangue',
         'blood-strike', 'blood-strike', 'strikeOption', 'bloodshard-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d8', 'piercing' FROM cost;

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
  requires_option_key, requires_option_value
)
SELECT 'replace_attack_with_save', 'subclass', owner.id, 'on_hit', 3, 15, 'Golpe Estilhaço-Sangue',
       'strikeOption', 'bloodshard-strike'
FROM rpg.phb_subclass owner
WHERE owner.slug = 'blood-hound';

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 21, 'secondary',
         'strikeOption', 'bloodshard-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '1d6', '3d6', 18, 'piercing' FROM ins;

-- constraining-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe Constritor',
         'blood-strike', 'blood-strike', 'strikeOption', 'constraining-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d8', 'acid' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe Constritor',
         'strikeOption', 'constraining-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', '4d6', 18, 'acid' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'apply_condition', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe Constritor',
         'strikeOption', 'constraining-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, NULL, 'blood-constrain' FROM ins;

-- exiling-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe do Exílio',
         'blood-strike', 'blood-strike', 'strikeOption', 'exiling-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d10', 'radiant' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe do Exílio',
         'strikeOption', 'exiling-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', NULL, 18, 'radiant' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'feature_save', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe do Exílio',
         'strikeOption', 'exiling-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_save (effect_id, save_ability, dc_ability, dc_formula)
SELECT id, 'charisma', NULL, 'eight_plus_mod_plus_pb' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'apply_condition', 'subclass', owner.id, 'on_save_fail', 3, 40, 'Golpe do Exílio',
         'strikeOption', 'exiling-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'incapacitated', 'blood-exile' FROM ins;

-- hunting-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe da Caça',
         'blood-strike', 'blood-strike', 'strikeOption', 'hunting-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d4', 'slashing' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe da Caça',
         'strikeOption', 'hunting-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '1d6', '3d6', 18, 'slashing' FROM ins;

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
  requires_option_key, requires_option_value
)
SELECT 'ignore_target_armor', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe da Caça',
       'strikeOption', 'hunting-strike'
FROM rpg.phb_subclass owner
WHERE owner.slug = 'blood-hound';

-- shadowblood-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe Sangue-Sombra',
         'blood-strike', 'blood-strike', 'strikeOption', 'shadowblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d6', 'necrotic' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe Sangue-Sombra',
         'strikeOption', 'shadowblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', '4d6', 18, 'necrotic' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'add_arena_effect', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe Sangue-Sombra',
         'strikeOption', 'shadowblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'magical_darkness' FROM ins;

-- thunderblood-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe Sangue-Trovão',
         'blood-strike', 'blood-strike', 'strikeOption', 'thunderblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d4', 'thunder' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe Sangue-Trovão',
         'strikeOption', 'thunderblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', '4d6', 18, 'thunder' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'feature_save', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe Sangue-Trovão',
         'strikeOption', 'thunderblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_save (effect_id, save_ability, dc_ability, dc_formula)
SELECT id, 'strength', NULL, 'eight_plus_mod_plus_pb' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'apply_condition', 'subclass', owner.id, 'on_save_fail', 3, 40, 'Golpe Sangue-Trovão',
         'strikeOption', 'thunderblood-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, 'prone', NULL FROM ins;

-- withering-strike
WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
cost AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    resource_slug, action_slug, requires_option_key, requires_option_value
  )
  SELECT 'self_damage', 'subclass', owner.id, 'on_option_use', 3, 10, 'Golpe Definhante',
         'blood-strike', 'blood-strike', 'strikeOption', 'withering-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, damage_type_slug)
SELECT id, '1d6', 'necrotic' FROM cost;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'extra_damage_dice', 'subclass', owner.id, 'on_hit', 3, 20, 'Golpe Definhante',
         'strikeOption', 'withering-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_dice (effect_id, die, die_at_level, at_level, damage_type_slug)
SELECT id, '2d6', '4d6', 18, 'necrotic' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'feature_save', 'subclass', owner.id, 'on_hit', 3, 30, 'Golpe Definhante',
         'strikeOption', 'withering-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_save (effect_id, save_ability, dc_ability, dc_formula)
SELECT id, 'constitution', NULL, 'eight_plus_mod_plus_pb' FROM ins;

WITH owner AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'apply_condition', 'subclass', owner.id, 'on_save_fail', 3, 40, 'Golpe Definhante',
         'strikeOption', 'withering-strike'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT id, NULL, 'blood-withering' FROM ins;
