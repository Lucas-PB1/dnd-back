CREATE TYPE rpg.effect_amount_formula AS ENUM (
  'fixed',
  'proficiency_bonus',
  'proficiency_bonus_times_2',
  'level',
  'level_times_2',
  'level_div_2',
  'dice_pb_d4',
  'dice_pb_d6',
  'dice_hit_die_plus_pb',
  'proficiency_bonus_plus_cha',
  'dice_1d4',
  'dice_2d4_plus_flat',
  'attack_ability_mod',
  'eight_plus_mod_plus_pb'
);
