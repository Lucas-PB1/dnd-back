-- Permite grants/resources com owner_kind/scope = item.

ALTER TYPE rpg.resource_scope ADD VALUE IF NOT EXISTS 'item';
ALTER TYPE rpg.resource_owner_kind ADD VALUE IF NOT EXISTS 'item';
