-- Renomeia slugs PHB 2014 → 2024 (Velocista / Sorrateiro).
-- Roda antes de S011. Idempotente. Atualiza FKs de ficha.

-- player options (owner_slug)
UPDATE rpg.player_character_option
SET owner_slug = 'speedy'
WHERE scope = 'feat' AND owner_slug = 'mobile';

UPDATE rpg.player_character_option
SET owner_slug = 'skulker'
WHERE scope = 'feat' AND owner_slug = 'stealthy';

-- player feats (FK → phb_feat.slug)
UPDATE rpg.player_character_feat
SET feat_slug = 'speedy'
WHERE feat_slug = 'mobile'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.player_character_feat x
    WHERE x.character_id = player_character_feat.character_id
      AND x.feat_slug = 'speedy'
      AND x.instance_index = player_character_feat.instance_index
  );

DELETE FROM rpg.player_character_feat WHERE feat_slug = 'mobile';

UPDATE rpg.player_character_feat
SET feat_slug = 'skulker'
WHERE feat_slug = 'stealthy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.player_character_feat x
    WHERE x.character_id = player_character_feat.character_id
      AND x.feat_slug = 'skulker'
      AND x.instance_index = player_character_feat.instance_index
  );

DELETE FROM rpg.player_character_feat WHERE feat_slug = 'stealthy';

-- catálogo
UPDATE rpg.phb_feat SET slug = 'speedy' WHERE slug = 'mobile';
UPDATE rpg.phb_feat SET slug = 'skulker' WHERE slug = 'stealthy';
