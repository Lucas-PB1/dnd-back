-- Pré-requisitos estruturados — Valdas Player Pack 2.

INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id, requires_fighting_style
)
SELECT
  f.id,
  4,
  f.slug IN ('flex-caster', 'metabolistic-magic'),
  NULL,
  FALSE
FROM rpg.phb_feat f
WHERE f.slug IN (
  'familiar-keeper',
  'flex-caster',
  'magitechnician',
  'metabolistic-magic',
  'pyromaniac',
  'shock-trooper',
  'showman',
  'spellblade'
)
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level,
  requires_spellcasting = EXCLUDED.requires_spellcasting;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT feat.id, ability.id, 13
FROM (
  VALUES
    ('shock-trooper', 'forca'),
    ('shock-trooper', 'destreza'),
    ('showman', 'carisma'),
    ('spellblade', 'inteligencia'),
    ('spellblade', 'sabedoria'),
    ('spellblade', 'carisma')
) AS requirement(feat_slug, ability_slug)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_ability ability ON ability.slug = requirement.ability_slug
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;
