-- Forward: fórmulas clérigo / casters (WIS casting, spark, preserve life).

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'level_times_5';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_divine_spark_plus_flat';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'ability_mod_d8';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_2d6_plus_flat';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_2d10_plus_level';
