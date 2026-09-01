-- Grim Hollow Cap. 4 — pré-requisitos estruturados (phb_feat_requirement)
-- Gerado por scripts/generate-ghpg-cap3-seeds.mjs
--   syndicate-spy: antecedente gh-syndicate-smuggler (só texto em prerequisite)

INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id,
  requires_fighting_style, requires_weapon_mastery
)
SELECT
  feat.id,
  requirement.minimum_level,
  requirement.requires_spellcasting,
  NULL,
  requirement.requires_fighting_style,
  FALSE
FROM (
  VALUES
    (
  'blackpowder-pistol-expert',
  4,
  FALSE,
  FALSE
),
    (
  'expanded-grip',
  4,
  FALSE,
  FALSE
),
    (
  'hulking-figure',
  4,
  FALSE,
  FALSE
),
    (
  'iron-gut',
  4,
  FALSE,
  FALSE
),
    (
  'lightning-caster',
  4,
  TRUE,
  FALSE
),
    (
  'medicianofthe-morbus-doctore',
  4,
  FALSE,
  FALSE
),
    (
  'nimble-physique',
  4,
  FALSE,
  FALSE
),
    (
  'sangromantic-initiate',
  4,
  TRUE,
  FALSE
),
    (
  'shadowsteel-adept',
  4,
  TRUE,
  FALSE
),
    (
  'shadowsteel-master',
  8,
  FALSE,
  FALSE
),
    (
  'syndicate-spy',
  4,
  FALSE,
  FALSE
),
    (
  'thrown-weapon-master',
  4,
  FALSE,
  FALSE
),
    (
  'witch-hunter',
  4,
  FALSE,
  FALSE
),
    (
  'close-combat-artillerist',
  NULL,
  FALSE,
  TRUE
),
    (
  'dual-shot',
  NULL,
  FALSE,
  TRUE
),
    (
  'flurry',
  NULL,
  FALSE,
  TRUE
),
    (
  'mobile-combatant',
  NULL,
  FALSE,
  TRUE
),
    (
  'opportunist',
  NULL,
  FALSE,
  TRUE
),
    (
  'prone-defense',
  NULL,
  FALSE,
  TRUE
),
    (
  'boonofthe-archlich',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-ascended-vampire',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-earthly-tether',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-elder-horror',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-elder-fey',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-elder-fiend',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-elemental-temperance',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-high-seraph',
  19,
  FALSE,
  FALSE
),
    (
  'boonof-magic-resistance',
  19,
  FALSE,
  FALSE
),
    (
  'boonof-perfect-flight',
  19,
  FALSE,
  FALSE
),
    (
  'boonof-shadowsteel-mastery',
  19,
  FALSE,
  FALSE
),
    (
  'boonofthe-wilds',
  19,
  FALSE,
  FALSE
),
    (
  'advanced-weapon-proficiency',
  NULL,
  FALSE,
  TRUE
)
) AS requirement(feat_slug, minimum_level, requires_spellcasting, requires_fighting_style)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_source_citation sc ON sc.id = feat.source_citation_id
WHERE sc.slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats'
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = EXCLUDED.minimum_level,
  requires_spellcasting = EXCLUDED.requires_spellcasting,
  required_armor_category_id = EXCLUDED.required_armor_category_id,
  requires_fighting_style = EXCLUDED.requires_fighting_style,
  requires_weapon_mastery = EXCLUDED.requires_weapon_mastery;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT feat.id, ability.id, requirement.minimum_score
FROM (
  VALUES
    ('expanded-grip', 'forca', 13),
    ('hulking-figure', 'forca', 13),
    ('iron-gut', 'constituicao', 13),
    ('nimble-physique', 'destreza', 13),
    ('thrown-weapon-master', 'forca', 13),
    ('thrown-weapon-master', 'destreza', 13)
) AS requirement(feat_slug, ability_slug, minimum_score)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_ability ability ON ability.slug = requirement.ability_slug
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;

INSERT INTO rpg.phb_feat_requirement_feat (feat_id, required_feat_id)
SELECT feat.id, required.id
FROM (
  VALUES
    ('medicianofthe-morbus-doctore', 'triage-expert'),
    ('shadowsteel-master', 'shadowsteel-adept'),
    ('boonofthe-archlich', 'gh-transformation-lich'),
    ('boonofthe-ascended-vampire', 'gh-transformation-vampire'),
    ('boonofthe-earthly-tether', 'gh-transformation-specter'),
    ('boonofthe-elder-horror', 'gh-transformation-aberrant-horror'),
    ('boonofthe-elder-fey', 'gh-transformation-fey'),
    ('boonofthe-elder-fiend', 'gh-transformation-fiend'),
    ('boonofthe-elemental-temperance', 'gh-transformation-primordial'),
    ('boonofthe-high-seraph', 'gh-transformation-seraph'),
    ('boonof-shadowsteel-mastery', 'gh-transformation-shadowsteel-ghoul'),
    ('boonofthe-wilds', 'gh-transformation-lycanthrope')
) AS dep(feat_slug, required_slug)
JOIN rpg.phb_feat feat ON feat.slug = dep.feat_slug
JOIN rpg.phb_feat required ON required.slug = dep.required_slug
ON CONFLICT (feat_id, required_feat_id) DO NOTHING;

