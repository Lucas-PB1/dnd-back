-- Migra escolhas GH legadas (player_character_species_choice) → tabelas dedicadas

INSERT INTO rpg.player_character_heritage_trait (character_id, slot_index, trait_id)
SELECT
  sc.character_id,
  substring(sc.choice_kind from 'heritage_trait_([0-9]+)')::int,
  ht.id
FROM rpg.player_character_species_choice sc
JOIN rpg.phb_heritage_trait ht ON ht.slug = sc.choice_slug
WHERE sc.choice_kind ~ '^heritage_trait_[0-9]+$'
ON CONFLICT (character_id, slot_index) DO NOTHING;

INSERT INTO rpg.player_character_heritage_config (character_id, speed_trade, size_choice)
SELECT
  sc.character_id,
  MAX(CASE WHEN sc.choice_kind = 'heritage_speed_trade' THEN sc.choice_slug END),
  MAX(CASE WHEN sc.choice_kind = 'heritage_size' THEN sc.choice_slug END)
FROM rpg.player_character_species_choice sc
WHERE sc.choice_kind IN ('heritage_speed_trade', 'heritage_size')
GROUP BY sc.character_id
ON CONFLICT (character_id) DO UPDATE SET
  speed_trade = COALESCE(EXCLUDED.speed_trade, rpg.player_character_heritage_config.speed_trade),
  size_choice = COALESCE(EXCLUDED.size_choice, rpg.player_character_heritage_config.size_choice);

DELETE FROM rpg.player_character_species_choice
WHERE choice_kind LIKE 'heritage_%';
