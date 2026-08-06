-- Combat mechanical enums for subclass features

CREATE TYPE rpg.maneuver_effect_kind AS ENUM (
  'temp_hp',
  'miss_damage',
  'ac_bonus',
  'ability_check_bonus',
  'descriptive',
  'reload_move'
);

CREATE TYPE rpg.battle_master_maneuver_timing AS ENUM (
  'on_hit',
  'on_miss',
  'reaction',
  'bonus_action',
  'other'
);

CREATE TYPE rpg.save_ability AS ENUM (
  'strength',
  'dexterity',
  'constitution',
  'intelligence',
  'wisdom',
  'charisma'
);
