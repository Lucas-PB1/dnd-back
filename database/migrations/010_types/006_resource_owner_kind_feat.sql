-- Permite grants/resources com owner_kind/scope = feat.

ALTER TYPE rpg.resource_scope ADD VALUE IF NOT EXISTS 'feat';
ALTER TYPE rpg.resource_owner_kind ADD VALUE IF NOT EXISTS 'feat';
