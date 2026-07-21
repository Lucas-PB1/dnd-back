-- Escolhas de traço — Humano (PHB 2024)

ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'human_skill';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'human_origin_feat';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'human_size';
