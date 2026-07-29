-- Recuperação de recursos de subclasse (Superioridade, Psi, etc.).
ALTER TABLE rpg.phb_subclass_resource
  ADD COLUMN IF NOT EXISTS recover_one_on_short BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.phb_subclass_resource
  ADD COLUMN IF NOT EXISTS recover_all_on_short BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.phb_subclass_resource
  ADD COLUMN IF NOT EXISTS recover_all_on_long BOOLEAN NOT NULL DEFAULT TRUE;
