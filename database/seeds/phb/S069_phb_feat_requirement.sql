-- Pré-requisitos estruturados dos talentos PHB.

INSERT INTO rpg.phb_feat_requirement (
  feat_id,
  minimum_level,
  requires_spellcasting,
  required_armor_category_id,
  requires_fighting_style
)
SELECT
  feat.id,
  CASE category.slug
    WHEN 'general' THEN 4
    WHEN 'epic-boon' THEN 19
    ELSE NULL
  END,
  feat.slug IN (
    'elemental-adept',
    'spell-sniper',
    'war-caster',
    'boon-of-spell-recall'
  ),
  CASE
    WHEN feat.slug = 'moderately-armored' THEN (
      SELECT id FROM rpg.phb_armor_category WHERE slug = 'light'
    )
    WHEN feat.slug IN ('heavily-armored', 'medium-armor-master') THEN (
      SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'
    )
    WHEN feat.slug = 'heavy-armor-master' THEN (
      SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'
    )
    WHEN feat.slug = 'shield-master' THEN (
      SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'
    )
    ELSE NULL
  END,
  category.slug = 'fighting-style'
FROM rpg.phb_feat feat
JOIN rpg.v_phb_feat_category category ON category.slug = feat.category
WHERE category.slug IN ('general', 'epic-boon', 'fighting-style')
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level,
  requires_spellcasting = EXCLUDED.requires_spellcasting,
  required_armor_category_id = EXCLUDED.required_armor_category_id,
  requires_fighting_style = EXCLUDED.requires_fighting_style;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT
  feat.id,
  ability.id,
  13
FROM (
  VALUES
    ('charger', 'forca'),
    ('charger', 'destreza'),
    ('observant', 'inteligencia'),
    ('observant', 'sabedoria'),
    ('athlete', 'forca'),
    ('athlete', 'destreza'),
    ('actor', 'carisma'),
    ('ritual-caster', 'inteligencia'),
    ('ritual-caster', 'sabedoria'),
    ('ritual-caster', 'carisma'),
    ('defensive-duelist', 'destreza'),
    ('dual-wielder', 'forca'),
    ('dual-wielder', 'destreza'),
    ('crossbow-expert', 'destreza'),
    ('grappler', 'forca'),
    ('grappler', 'destreza'),
    ('inspiring-leader', 'sabedoria'),
    ('inspiring-leader', 'carisma'),
    ('keen-mind', 'inteligencia'),
    ('polearm-master', 'forca'),
    ('polearm-master', 'destreza'),
    ('great-weapon-master', 'forca'),
    ('sharpshooter', 'destreza'),
    ('sentinel', 'forca'),
    ('sentinel', 'destreza'),
    ('stealthy', 'destreza'),
    ('mobile', 'destreza'),
    ('mobile', 'constituicao')
) AS requirement(feat_slug, ability_slug)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_ability ability ON ability.slug = requirement.ability_slug
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;
