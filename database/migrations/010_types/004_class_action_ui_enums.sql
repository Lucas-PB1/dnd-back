-- Action economy bucket for class economy catalog (UI Actions tab)

CREATE TYPE rpg.action_economy_bucket AS ENUM (
  'action',
  'bonus',
  'reaction',
  'free'
);

CREATE TYPE rpg.panel_action_section AS ENUM (
  'base',
  'subclass',
  'metamagic',
  'channel'
);
