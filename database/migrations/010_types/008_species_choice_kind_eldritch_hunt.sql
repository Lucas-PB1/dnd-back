-- Escolhas de espécie Eldritch Hunt (Manikin / Scourgeborne).

ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'manikin_size';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'manikin_armor';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'manikin_service_model';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'scourgeborne_madness';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'scourgeborne_lineage';
