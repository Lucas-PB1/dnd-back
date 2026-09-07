CREATE MATERIALIZED VIEW rpg.mv_phb_heritage_trait_choices AS
  SELECT * FROM rpg.v_phb_heritage_trait_choices;

-- Ãndices adicionais do catÃ¡logo

CREATE INDEX idx_phb_species_trait_choice ON rpg.phb_species_trait(choice_kind);

CREATE INDEX idx_phb_option_value_spells ON rpg.phb_option_value(spell_level1_id, spell_level3_id, spell_level5_id)
  WHERE spell_level1_id IS NOT NULL OR spell_level3_id IS NOT NULL OR spell_level5_id IS NOT NULL;

CREATE INDEX idx_phb_feat_category ON rpg.phb_feat(category);

CREATE INDEX idx_phb_feat_source ON rpg.phb_feat(source_citation_id);

CREATE INDEX idx_phb_feat_benefit_feat ON rpg.phb_feat_benefit(feat_id);

CREATE INDEX idx_phb_subclass_class ON rpg.phb_subclass(class_id);

CREATE INDEX idx_phb_subclass_source ON rpg.phb_subclass(source_citation_id);

CREATE INDEX idx_phb_subclass_feature_sub ON rpg.phb_subclass_feature(subclass_id);

CREATE INDEX idx_subclass_prep_spell ON rpg.phb_subclass_prepared_spell(subclass_id);

CREATE INDEX idx_phb_spell_school ON rpg.phb_spell(school_id);

CREATE INDEX idx_phb_spell_source ON rpg.phb_spell(source_citation_id);

CREATE INDEX idx_phb_spell_level_school ON rpg.phb_spell (level, school_id);

CREATE INDEX idx_spell_class ON rpg.phb_spell_class(class_id);

CREATE INDEX idx_class_skill_pool_skill ON rpg.phb_class_skill_pool (skill_id);

CREATE INDEX idx_phb_item_type ON rpg.phb_item (item_type);

CREATE INDEX idx_phb_skill_ability ON rpg.phb_skill(ability_id);

CREATE INDEX idx_phb_class_hit_die ON rpg.phb_class(hit_die);

CREATE INDEX idx_phb_class_source ON rpg.phb_class(source_citation_id);

CREATE INDEX idx_phb_armor_category ON rpg.phb_armor(category_id);

CREATE INDEX idx_phb_tool_category ON rpg.phb_tool(category_id);

CREATE UNIQUE INDEX uq_resource_species ON rpg.phb_resource_definition (species_id, slug)
  WHERE scope = 'species';

CREATE UNIQUE INDEX uq_resource_class ON rpg.phb_resource_definition (class_id, slug)
  WHERE scope = 'class';

CREATE UNIQUE INDEX uq_resource_subclass ON rpg.phb_resource_definition (subclass_id, slug)
  WHERE scope = 'subclass';

CREATE UNIQUE INDEX uq_resource_heritage
  ON rpg.phb_resource_definition (heritage_trait_id, slug)
  WHERE scope = 'heritage';

CREATE UNIQUE INDEX uq_resource_character_thread
  ON rpg.phb_resource_definition (thread_slug, slug)
  WHERE scope = 'character_thread';

CREATE INDEX idx_phb_spell_name_trgm ON rpg.phb_spell USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_feat_name_trgm ON rpg.phb_feat USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_class_name_trgm ON rpg.phb_class USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_item_name_trgm ON rpg.phb_item USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_species_name_trgm ON rpg.phb_species USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_subclass_name_trgm ON rpg.phb_subclass USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_background_name_trgm ON rpg.phb_background USING gin (name gin_trgm_ops);

CREATE UNIQUE INDEX idx_mv_spell_by_class ON rpg.mv_spell_by_class (class_slug, spell_slug);

CREATE UNIQUE INDEX idx_mv_phb_feat ON rpg.mv_phb_feat (feat_slug);

CREATE UNIQUE INDEX idx_mv_phb_background ON rpg.mv_phb_background (background_slug);

CREATE UNIQUE INDEX idx_mv_phb_species_trait_choices
  ON rpg.mv_phb_species_trait_choices (species_slug, choice_kind, choice_slug);

CREATE UNIQUE INDEX idx_mv_phb_class_economy_action
  ON rpg.mv_phb_class_economy_action (action_id);

CREATE UNIQUE INDEX idx_mv_phb_creature_template_bundle
  ON rpg.mv_phb_creature_template_bundle (slug);

CREATE UNIQUE INDEX idx_mv_phb_vehicle_template_bundle
  ON rpg.mv_phb_vehicle_template_bundle (slug);

CREATE UNIQUE INDEX idx_mv_phb_character_thread_bundle
  ON rpg.mv_phb_character_thread_bundle (slug);

CREATE UNIQUE INDEX idx_mv_phb_hp_bonus_source
  ON rpg.mv_phb_hp_bonus_source (
    source_kind,
    source_slug,
    from_level,
    option_key_norm,
    option_value_norm
  );

CREATE UNIQUE INDEX idx_mv_phb_unarmored_defense
  ON rpg.mv_phb_unarmored_defense (source_kind, source_slug);

CREATE UNIQUE INDEX idx_mv_class_spell_slots
  ON rpg.mv_class_spell_slots (class_slug, class_level);

CREATE UNIQUE INDEX idx_mv_subclass_spell_slots
  ON rpg.mv_subclass_spell_slots (subclass_slug, class_level);

CREATE UNIQUE INDEX idx_mv_phb_class_ability_boost
  ON rpg.mv_phb_class_ability_boost (class_slug, ability_slug, from_level);

CREATE UNIQUE INDEX idx_mv_phb_feat_granted_spell
  ON rpg.mv_phb_feat_granted_spell (feat_slug, spell_slug);

CREATE UNIQUE INDEX idx_mv_phb_class_granted_spell
  ON rpg.mv_phb_class_granted_spell (class_slug, spell_slug, unlock_level);

CREATE UNIQUE INDEX idx_mv_phb_heritage_trait_choices
  ON rpg.mv_phb_heritage_trait_choices (heritage_slug, choice_kind, trait_slug);

-- Criticals: ownership FK (auth.users quando existir); subclass âˆˆ class; HP current â‰¤ max
