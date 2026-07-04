-- Instâncias repetíveis de talentos (ex.: Iniciado em Magia mais de uma vez)

ALTER TABLE rpg.player_character_feat
  ADD COLUMN IF NOT EXISTS instance_index INTEGER NOT NULL DEFAULT 0 CHECK (instance_index >= 0);

ALTER TABLE rpg.player_character_feat DROP CONSTRAINT IF EXISTS player_character_feat_pkey;
ALTER TABLE rpg.player_character_feat
  ADD PRIMARY KEY (character_id, feat_slug, instance_index);
