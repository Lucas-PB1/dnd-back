-- Runtime game_actor: tipos de ficha e conjuração inata

CREATE TYPE rpg.actor_kind AS ENUM (
  'creature',
  'mount',
  'vehicle',
  'companion'
);

CREATE TYPE rpg.innate_spell_usage AS ENUM (
  'at_will',
  'per_day',
  'recharge',
  'slot'
);

CREATE TYPE rpg.actor_action_bucket AS ENUM (
  'action',
  'bonus',
  'reaction',
  'legendary',
  'other'
);
