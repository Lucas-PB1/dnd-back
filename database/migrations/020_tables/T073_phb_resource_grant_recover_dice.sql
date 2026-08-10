-- Recover 1dN ao Descanso Longo (amanhecer) para pools de cargas de item.
ALTER TABLE rpg.phb_resource_grant
  ADD COLUMN IF NOT EXISTS recover_on_long_dice TEXT NULL;

COMMENT ON COLUMN rpg.phb_resource_grant.recover_on_long_dice IS
  'Expressão NdM[+K] recuperada no long rest (ex. 1d6+1). NULL = usa recover_all_on_long.';
