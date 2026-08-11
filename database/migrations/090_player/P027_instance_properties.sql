-- Props de instância (artefato rolado na 1ª sintonia, senciência copiada, etc.)
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS instance_properties JSONB NULL;

COMMENT ON COLUMN rpg.player_character_item.instance_properties IS
  'Estado por instância: artifactRandom (1ª sintonia), sentience copiada do catálogo, etc.';
