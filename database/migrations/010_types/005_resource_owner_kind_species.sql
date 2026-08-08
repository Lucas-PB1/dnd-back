-- Permite grants de recurso com owner_kind = species (recursos de espécie).

ALTER TYPE rpg.resource_owner_kind ADD VALUE IF NOT EXISTS 'species';
