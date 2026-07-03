-- Índices adicionais do catálogo

CREATE INDEX idx_phb_elf_lineage_spells ON rpg.phb_elf_lineage(spell_level3_id, spell_level5_id);

CREATE INDEX idx_phb_feat_category ON rpg.phb_feat(category_id);

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

CREATE INDEX idx_phb_class_hit_die ON rpg.phb_class(hit_die_id);

CREATE INDEX idx_phb_class_source ON rpg.phb_class(source_citation_id);

CREATE INDEX idx_phb_armor_category ON rpg.phb_armor(category_id);

CREATE INDEX idx_phb_tool_category ON rpg.phb_tool(category_id);

CREATE UNIQUE INDEX uq_resource_species ON rpg.phb_resource_definition (species_id, slug)
  WHERE scope = 'species';

CREATE UNIQUE INDEX uq_resource_class ON rpg.phb_resource_definition (class_id, slug)
  WHERE scope = 'class';

CREATE UNIQUE INDEX uq_resource_subclass ON rpg.phb_resource_definition (subclass_id, slug)
  WHERE scope = 'subclass';

CREATE INDEX idx_phb_feat_name_trgm ON rpg.phb_feat USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_class_name_trgm ON rpg.phb_class USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_item_name_trgm ON rpg.phb_item USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_species_name_trgm ON rpg.phb_species USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_subclass_name_trgm ON rpg.phb_subclass USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_background_name_trgm ON rpg.phb_background USING gin (name gin_trgm_ops);
