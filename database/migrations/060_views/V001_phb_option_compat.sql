-- Lote C: views de compatibilidade (nomes legados → phb_option_*)
-- Leitura para TypeORM / queries antigas; escrita vai para phb_option_*

CREATE OR REPLACE VIEW rpg.phb_subclass_option_def AS
SELECT
  owner_id AS subclass_id,
  option_key,
  COALESCE(label, option_key) AS label,
  COALESCE(unlock_level, 3) AS unlock_level,
  value_type
FROM rpg.phb_option_def
WHERE scope = 'subclass'::rpg.option_scope;

CREATE OR REPLACE VIEW rpg.phb_subclass_option_value AS
SELECT
  owner_id AS subclass_id,
  option_key,
  value_id,
  label,
  sort_order
FROM rpg.phb_option_value
WHERE scope = 'subclass'::rpg.option_scope;

CREATE OR REPLACE VIEW rpg.phb_species_option_def AS
SELECT
  owner_id AS species_id,
  option_key,
  value_type
FROM rpg.phb_option_def
WHERE scope = 'species'::rpg.option_scope;

CREATE OR REPLACE VIEW rpg.phb_species_option_value AS
SELECT
  owner_id AS species_id,
  option_key,
  value_id,
  label,
  benefit,
  level1_benefit,
  damage_type,
  spell_level1_id,
  spell_level3_id,
  spell_level5_id,
  spell_1_id,
  spell_2_id
FROM rpg.phb_option_value
WHERE scope = 'species'::rpg.option_scope;

CREATE OR REPLACE VIEW rpg.phb_feat_option_def AS
SELECT
  owner_id AS feat_id,
  option_key,
  COALESCE(label, option_key) AS label,
  value_type,
  sort_order,
  depends_on_option_key,
  spell_max_level,
  spell_school_slugs,
  spell_ritual_only
FROM rpg.phb_option_def
WHERE scope = 'feat'::rpg.option_scope;

CREATE OR REPLACE VIEW rpg.phb_feat_option_value AS
SELECT
  owner_id AS feat_id,
  option_key,
  value_id,
  label,
  sort_order
FROM rpg.phb_option_value
WHERE scope = 'feat'::rpg.option_scope;

-- Lote F: views de compatibilidade (nomes legados → phb_class_proficiency)
-- Leitura para SQL legado; seeds escrevem em phb_class_proficiency

CREATE OR REPLACE VIEW rpg.phb_class_saving_throw AS
SELECT class_id, ref_id AS ability_id
FROM rpg.phb_class_proficiency
WHERE kind = 'saving_throw'::rpg.class_proficiency_kind;

CREATE OR REPLACE VIEW rpg.phb_class_primary_ability AS
SELECT class_id, ref_id AS ability_id, sort_order
FROM rpg.phb_class_proficiency
WHERE kind = 'primary_ability'::rpg.class_proficiency_kind;

CREATE OR REPLACE VIEW rpg.phb_class_armor_training AS
SELECT class_id, ref_id AS category_id
FROM rpg.phb_class_proficiency
WHERE kind = 'armor_training'::rpg.class_proficiency_kind;

CREATE OR REPLACE VIEW rpg.phb_class_weapon_proficiency AS
SELECT class_id, ref_slug AS proficiency_slug
FROM rpg.phb_class_proficiency
WHERE kind = 'weapon'::rpg.class_proficiency_kind;

CREATE OR REPLACE VIEW rpg.phb_class_fighting_style AS
SELECT class_id, ref_id AS fighting_style_id
FROM rpg.phb_class_proficiency
WHERE kind = 'fighting_style'::rpg.class_proficiency_kind;
