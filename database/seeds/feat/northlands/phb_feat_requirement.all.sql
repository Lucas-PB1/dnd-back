-- Pré-requisitos estruturados Northlands (nível/atributo/FS/armadura/perícia/espécie/maestria + talentos).
-- Deps talento→talento (únicos no catálogo atual — PHB/Valdas/Steinhardt não têm feat→feat):
--   Greater Blessings → Bênção Origin correspondente
--   Clout → inspiring-leader
--   Faster Crafting → artisan
--   Holmganga Master → dueling
--   Ice/Lightning Mastery → elemental-adept
-- Ainda só no texto: (nenhum — arma/item e tipo elemental estruturados abaixo).

-- Estilos de luta
INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id,
  requires_fighting_style, requires_weapon_mastery
)
SELECT
  f.id,
  NULL,
  FALSE,
  CASE WHEN f.slug = 'shield-wall'
    THEN (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')
    ELSE NULL
  END,
  TRUE,
  FALSE
FROM rpg.phb_feat f
JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
WHERE sc.slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'
  AND f.category = 'fighting-style'
ON CONFLICT (feat_id) DO UPDATE SET
  requires_fighting_style = TRUE,
  required_armor_category_id = EXCLUDED.required_armor_category_id,
  requires_weapon_mastery = FALSE;

-- Gerais com Nível 4+ (exceto os que só pedem atributo)
INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id,
  requires_fighting_style, requires_weapon_mastery
)
SELECT
  f.id,
  4,
  FALSE,
  NULL,
  FALSE,
  f.slug IN ('giant-slayer', 'spear-expert')
FROM rpg.phb_feat f
JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
WHERE sc.slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'
  AND f.category = 'general'
  AND f.slug NOT IN (
    'bloody-resolve',
    'boisterous-roar',
    'combat-flyting',
    'endurance-conditioning'
  )
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = 4,
  requires_fighting_style = FALSE,
  requires_weapon_mastery = EXCLUDED.requires_weapon_mastery;

-- Gerais só com atributo (sem nível mínimo estruturado)
INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id,
  requires_fighting_style, requires_weapon_mastery
)
SELECT f.id, NULL, FALSE, NULL, FALSE, FALSE
FROM rpg.phb_feat f
WHERE f.slug IN (
  'bloody-resolve',
  'boisterous-roar',
  'combat-flyting',
  'endurance-conditioning'
)
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = NULL,
  requires_weapon_mastery = FALSE;

INSERT INTO rpg.phb_feat_requirement_ability (feat_id, ability_id, minimum_score)
SELECT feat.id, ability.id, requirement.minimum_score
FROM (
  VALUES
    ('axe-fighter', 'forca', 13),
    ('bloody-resolve', 'constituicao', 13),
    ('boisterous-roar', 'carisma', 13),
    ('clout', 'forca', 13),
    ('cold-water-warrior', 'forca', 13),
    ('cold-water-warrior', 'destreza', 13),
    ('combat-flyting', 'carisma', 13),
    ('endurance-conditioning', 'constituicao', 13),
    ('fjord-jumper', 'forca', 13),
    ('mounted-leap', 'forca', 13),
    ('mounted-leap', 'destreza', 13),
    ('spear-expert', 'forca', 13),
    ('spear-expert', 'destreza', 13)
) AS requirement(feat_slug, ability_slug, minimum_score)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_ability ability ON ability.slug = requirement.ability_slug
ON CONFLICT (feat_id, ability_id) DO UPDATE SET
  minimum_score = EXCLUDED.minimum_score;

-- Perícias exigidas (todas as listadas)
INSERT INTO rpg.phb_feat_requirement_skill (feat_id, skill_id)
SELECT feat.id, skill.id
FROM (
  VALUES
    ('combat-flyting', 'deception'),
    ('endurance-conditioning', 'athletics'),
    ('mounted-leap', 'animal-handling')
) AS requirement(feat_slug, skill_slug)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_skill skill ON skill.slug = requirement.skill_slug
ON CONFLICT (feat_id, skill_id) DO NOTHING;

-- Espécies aceitas (OR — Giganteide ou Trollide)
INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id,
  requires_fighting_style, requires_weapon_mastery
)
SELECT f.id, 4, FALSE, NULL, FALSE, FALSE
FROM rpg.phb_feat f
WHERE f.slug = 'blessing-of-angrboda-and-bergelmir'
ON CONFLICT (feat_id) DO UPDATE SET
  minimum_level = 4;

INSERT INTO rpg.phb_feat_requirement_species (feat_id, species_id)
SELECT feat.id, species.id
FROM (
  VALUES
    ('blessing-of-angrboda-and-bergelmir', 'giantkin'),
    ('blessing-of-angrboda-and-bergelmir', 'trollkin')
) AS requirement(feat_slug, species_slug)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_species species ON species.slug = requirement.species_slug
ON CONFLICT (feat_id, species_id) DO NOTHING;

-- Garante linha em phb_feat_requirement antes das FKs de feat (deps)
INSERT INTO rpg.phb_feat_requirement (
  feat_id, minimum_level, requires_spellcasting, required_armor_category_id,
  requires_fighting_style, requires_weapon_mastery
)
SELECT f.id, COALESCE(r.minimum_level, 4), FALSE, NULL, FALSE, FALSE
FROM rpg.phb_feat f
LEFT JOIN rpg.phb_feat_requirement r ON r.feat_id = f.id
WHERE f.slug IN (
  'clout',
  'faster-crafting',
  'greater-blessing-of-baldur',
  'greater-blessing-of-boreas',
  'greater-blessing-of-freyr-and-freyja',
  'greater-blessing-of-jormungandr',
  'greater-blessing-of-loki',
  'greater-blessing-of-sif',
  'greater-blessing-of-thor',
  'greater-blessing-of-wotan',
  'holmganga-master',
  'ice-mastery',
  'lightning-mastery'
)
ON CONFLICT (feat_id) DO NOTHING;

INSERT INTO rpg.phb_feat_requirement_feat (feat_id, required_feat_id)
SELECT feat.id, required.id
FROM (
  VALUES
    ('clout', 'inspiring-leader'),
    ('faster-crafting', 'artisan'),
    ('greater-blessing-of-baldur', 'blessing-of-baldur'),
    ('greater-blessing-of-boreas', 'blessing-of-boreas'),
    ('greater-blessing-of-freyr-and-freyja', 'blessing-of-freyr-and-freyja'),
    ('greater-blessing-of-jormungandr', 'blessing-of-jormungandr'),
    ('greater-blessing-of-loki', 'blessing-of-loki'),
    ('greater-blessing-of-sif', 'blessing-of-sif'),
    ('greater-blessing-of-thor', 'blessing-of-thor'),
    ('greater-blessing-of-wotan', 'blessing-of-wotan'),
    ('holmganga-master', 'dueling'),
    ('ice-mastery', 'elemental-adept'),
    ('lightning-mastery', 'elemental-adept')
) AS dep(feat_slug, required_slug)
JOIN rpg.phb_feat feat ON feat.slug = dep.feat_slug
JOIN rpg.phb_feat required ON required.slug = dep.required_slug
ON CONFLICT (feat_id, required_feat_id) DO NOTHING;

-- Proficiência de arma/item
INSERT INTO rpg.phb_feat_requirement_weapon_proficiency (feat_id, proficiency_slug)
SELECT feat.id, requirement.proficiency_slug
FROM (
  VALUES
    ('axe-fighter', 'armas-marciais'),
    ('axe-thrower', 'machadinhas')
) AS requirement(feat_slug, proficiency_slug)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
ON CONFLICT (feat_id, proficiency_slug) DO NOTHING;

-- Opção de talento pré-requisito (Adepto Elemental → tipo de dano)
INSERT INTO rpg.phb_feat_requirement_feat_option (
  feat_id, required_feat_id, option_key, value_id
)
SELECT feat.id, required.id, requirement.option_key, requirement.value_id
FROM (
  VALUES
    ('ice-mastery', 'elemental-adept', 'damageType', 'cold'),
    ('lightning-mastery', 'elemental-adept', 'damageType', 'lightning')
) AS requirement(feat_slug, required_slug, option_key, value_id)
JOIN rpg.phb_feat feat ON feat.slug = requirement.feat_slug
JOIN rpg.phb_feat required ON required.slug = requirement.required_slug
ON CONFLICT (feat_id, required_feat_id, option_key, value_id) DO NOTHING;
