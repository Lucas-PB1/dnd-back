-- Pré-requisitos estruturados dos talentos Valdas.

INSERT INTO rpg.phb_feat_requirement (feat_id, minimum_level)
SELECT id, 4
FROM rpg.phb_feat
WHERE slug IN ('brutal-grip', 'field-commander', 'focused-critical', 'iron-hero')
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT feat.id, ability.id, 13
FROM (
  VALUES
    ('brutal-grip', 'forca'),
    ('field-commander', 'carisma')
) AS requirement(feat_slug, ability_slug)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_ability ability ON ability.slug = requirement.ability_slug
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;
