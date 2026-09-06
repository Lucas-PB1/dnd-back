CREATE TYPE rpg.effect_trigger AS ENUM (
  'passive',
  'on_build',
  'on_table_action',
  'on_resource_spend',
  'on_cast',
  'on_purchase',
  'on_damage_roll',
  'on_d20_nat1',
  'on_bloodied',
  'on_rest_short',
  'on_rest_long',
  'on_death_save',
  'on_critical_hit'
);
