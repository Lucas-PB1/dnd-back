-- Campanhas: mesa, membros (mestre/jogador/auxiliar) e personagens vinculados.
-- Personagem continua do dono; pode estar em várias campanhas.

CREATE TABLE rpg.campaign (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT,
  invite_code TEXT NOT NULL UNIQUE CHECK (char_length(invite_code) BETWEEN 6 AND 16),
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_campaign_created_by ON rpg.campaign(created_by);
CREATE INDEX idx_campaign_invite_code ON rpg.campaign(invite_code);

CREATE TRIGGER tr_campaign_updated_at
  BEFORE UPDATE ON rpg.campaign
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- Papéis na mesa: dm (mestre), player (jogador), assistant (auxiliar).
CREATE TABLE rpg.campaign_member (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('dm', 'player', 'assistant')),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, user_id)
);

CREATE INDEX idx_campaign_member_user_id ON rpg.campaign_member(user_id);
CREATE INDEX idx_campaign_member_campaign_id ON rpg.campaign_member(campaign_id);

-- Personagem do jogador vinculado à campanha (N:N — várias campanhas).
CREATE TABLE rpg.campaign_character (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  linked_by UUID NOT NULL,
  linked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, character_id)
);

CREATE INDEX idx_campaign_character_character_id ON rpg.campaign_character(character_id);
CREATE INDEX idx_campaign_character_campaign_id ON rpg.campaign_character(campaign_id);

-- Criticals: ownership FKs quando auth.users existir
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign ownership FKs — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.campaign
    ADD CONSTRAINT campaign_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
  ALTER TABLE rpg.campaign_member
    ADD CONSTRAINT campaign_member_user_id_fkey
    FOREIGN KEY (user_id) REFERENCES auth.users(id);
  ALTER TABLE rpg.campaign_character
    ADD CONSTRAINT campaign_character_linked_by_fkey
    FOREIGN KEY (linked_by) REFERENCES auth.users(id);
END $$;

