-- Magias concedidas por ancestria Feathren + Identificar / Aprimorar Atributo

CREATE OR REPLACE VIEW rpg.v_phb_species_granted_spell AS
SELECT * FROM (
  SELECT
    sp.slug AS species_slug,
    NULL::rpg.species_choice_kind AS choice_kind,
    NULL::text AS choice_slug,
    1 AS unlock_level,
    s.slug AS spell_slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_spell s ON s.id = t.spell_id
  WHERE t.spell_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 5, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level5_id
  WHERE ov.spell_level5_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 5, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level5_id
  WHERE ov.spell_level5_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
    AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_1_id
  WHERE ov.spell_1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
    AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_2_id
  WHERE ov.spell_2_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'giantkinAncestryId'
    AND t.choice_kind = 'giantkin_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL

  UNION ALL

  -- Feathren aviária L1 (truque)
  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenAvianAncestryId'
    AND t.choice_kind = 'feathren_avian_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  -- Feathren felina L3
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenFelineAncestryId'
    AND t.choice_kind = 'feathren_feline_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, NULL::rpg.species_choice_kind, NULL::text, g.unlock_level, s.slug
  FROM rpg.phb_spell_grant g
  JOIN rpg.phb_species sp ON sp.id = g.origin_id
  JOIN rpg.phb_spell s ON s.id = g.spell_id
  WHERE g.origin_type = 'species'::rpg.spell_grant_origin
) AS granted;
