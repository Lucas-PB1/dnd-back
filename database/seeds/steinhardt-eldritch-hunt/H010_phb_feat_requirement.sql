-- Pré-requisitos estruturados — talentos gerais Eldritch Hunt

INSERT INTO rpg.phb_feat_requirement (feat_id, minimum_level)
SELECT id, 4
FROM rpg.phb_feat
WHERE slug = 'brutalizer'
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level;

INSERT INTO rpg.phb_feat_requirement (feat_id, minimum_level)
SELECT id, 8
FROM rpg.phb_feat
WHERE slug = 'cannoneer'
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT feat.id, ability.id, requirement.minimum_score
FROM (
  VALUES
    ('brutalizer', 'forca', 16),
    ('cannoneer', 'forca', 18)
) AS requirement(feat_slug, ability_slug, minimum_score)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_ability ability ON ability.slug = requirement.ability_slug
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;
