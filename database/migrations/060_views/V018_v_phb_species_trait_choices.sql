-- View rpg.v_phb_species_trait_choices
-- Lote B: usa phb_species_option_value em vez de tabelas de lineage/ancestry

CREATE OR REPLACE VIEW rpg.v_phb_species_trait_choices AS
-- Elf lineage (option_key = 'lineageId')
SELECT
  sp.slug AS species_slug,
  t.name AS trait_name,
  t.choice_kind,
  ov.value_id AS choice_slug,
  ov.label AS choice_name,
  ov.level1_benefit,
  s3.slug AS spell_level3_slug,
  s5.slug AS spell_level5_slug,
  NULL::text AS damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
  AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = ov.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = ov.spell_level5_id
UNION ALL
-- Infernal legacy (option_key = 'infernalLegacyId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  ov.level1_benefit,
  s3.slug,
  s5.slug,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
  AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = ov.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = ov.spell_level5_id
UNION ALL
-- Dragon ancestry (option_key = 'dragonAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  NULL::text,
  NULL::text,
  NULL::text,
  ov.damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'dragonAncestryId'
  AND t.choice_kind = 'dragon_ancestry'::rpg.species_choice_kind
UNION ALL
-- Gnome lineage (option_key = 'gnomeLineageId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  ov.level1_benefit,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
  AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
UNION ALL
-- Giant ancestry (option_key = 'giantAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'giantAncestryId'
  AND t.choice_kind = 'giant_ancestry'::rpg.species_choice_kind
UNION ALL
-- Geppettin construction (option_key = 'constructionId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'constructionId'
  AND t.choice_kind = 'geppettin_construction'::rpg.species_choice_kind
UNION ALL
-- Mandrake season (option_key = 'seasonId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'seasonId'
  AND t.choice_kind = 'mandrake_season'::rpg.species_choice_kind
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sk.slug,
  sk.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_skill sk ON t.choice_kind IN ('human_skill'::rpg.species_choice_kind, 'geppettin_skill'::rpg.species_choice_kind, 'mandrake_skill'::rpg.species_choice_kind)
  AND (
    (t.choice_kind = 'human_skill'::rpg.species_choice_kind)
    OR (t.choice_kind = 'geppettin_skill'::rpg.species_choice_kind AND sk.slug IN ('intimidation', 'performance', 'persuasion'))
    OR (t.choice_kind = 'mandrake_skill'::rpg.species_choice_kind AND sk.slug IN ('nature', 'survival'))
  )
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sk.slug,
  sk.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_skill sk
  ON t.choice_kind = 'elf_keen_senses'::rpg.species_choice_kind
 AND sk.slug IN ('insight', 'perception', 'survival')
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  f.slug,
  f.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_feat f ON t.choice_kind = 'human_origin_feat'::rpg.species_choice_kind
  AND f.category = 'origin'::rpg.feat_category
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ab.slug,
  ab.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_ability ab
  ON t.choice_kind IN (
    'elf_casting_ability'::rpg.species_choice_kind,
    'gnome_casting_ability'::rpg.species_choice_kind,
    'infernal_casting_ability'::rpg.species_choice_kind,
    'mandrake_casting_ability'::rpg.species_choice_kind
  )
 AND ab.slug IN ('inteligencia', 'sabedoria', 'carisma')
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sz.slug,
  sz.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN (
  VALUES
    ('medium', 'Médio'),
    ('small', 'Pequeno')
) AS sz(slug, name)
  ON t.choice_kind IN (
    'human_size'::rpg.species_choice_kind,
    'aasimar_size'::rpg.species_choice_kind,
    'tiefling_size'::rpg.species_choice_kind,
    'geppettin_size'::rpg.species_choice_kind
  )
UNION ALL
-- Truques swappable do Alto Elfo (opcional)
SELECT
  'elf'::text AS species_slug,
  'Truque de Alto Elfo'::text AS trait_name,
  'high_elf_cantrip'::rpg.species_choice_kind AS choice_kind,
  o.choice_slug,
  o.choice_name,
  NULL::text AS level1_benefit,
  NULL::text AS spell_level3_slug,
  NULL::text AS spell_level5_slug,
  NULL::text AS damage_type
FROM rpg.v_phb_high_elf_cantrip_options o;

