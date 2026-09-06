-- Pré-requisitos estruturados dos talentos do Pistoleiro.

INSERT INTO rpg.phb_feat_requirement (
  feat_id,
  minimum_level,
  requires_spellcasting
)
SELECT
  id,
  4,
  slug = 'gun-mage-adept'
FROM rpg.phb_feat
WHERE slug IN ('marksman-s-luck', 'gun-mage-adept')
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level,
  requires_spellcasting = EXCLUDED.requires_spellcasting;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT feat.id, ability.id, 13
FROM rpg.phb_feat feat
JOIN rpg.phb_ability ability ON ability.slug = 'destreza'
WHERE feat.slug = 'marksman-s-luck'
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;
