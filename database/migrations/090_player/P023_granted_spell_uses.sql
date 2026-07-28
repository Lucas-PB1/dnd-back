-- Usos free de magias concedidas + flag de troca do truque Alto Elfo

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS granted_spell_uses JSONB NOT NULL DEFAULT '{}'::jsonb;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS high_elf_cantrip_swap_available BOOLEAN NOT NULL DEFAULT false;
