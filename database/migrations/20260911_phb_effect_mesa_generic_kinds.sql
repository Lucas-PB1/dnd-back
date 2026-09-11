-- Forward: kinds mesa genéricos (toggle / companion / table_roll / recover to max) + fórmulas.

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'recover_resource';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'toggle_combat_flag';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'sync_companion';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'companion_command';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'table_roll';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'recover_resource_to_max';

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'rage_bonus';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'rage_bonus_d6';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'half_level_if_rage';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'ability_mod';

CREATE TABLE IF NOT EXISTS rpg.phb_effect_combat_flag (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  flag TEXT NOT NULL CHECK (flag IN ('rage', 'reckless')),
  spend_on_enter BOOLEAN NOT NULL DEFAULT true,
  force_enter BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS rpg.phb_effect_companion (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  restore_hp BOOLEAN NOT NULL DEFAULT false
);

UPDATE rpg.phb_class_economy_action
SET always_spends_resource = false
WHERE action_id IN (
  'barbarian-rage',
  'barbarian-champion-of-the-gods'
)
  AND always_spends_resource IS DISTINCT FROM false;
