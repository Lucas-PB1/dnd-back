-- Grim Hollow — tipos de herança e traços modulares

CREATE TYPE rpg.heritage_category AS ENUM ('common', 'rare', 'eldritch');

CREATE TYPE rpg.heritage_trait_category AS ENUM ('combat', 'exploration', 'roleplaying');

CREATE TYPE rpg.heritage_trait_take_mode AS ENUM ('stack', 'choice_each_take');

ALTER TYPE rpg.combat_modifier_owner ADD VALUE IF NOT EXISTS 'heritage';
