-- Forward: tags de listagem MM + conversões 2014→2024 (DB já migrado).
CREATE TABLE IF NOT EXISTS rpg.phb_creature_template_list_tag (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (kind IN ('habitat', 'treasure', 'group')),
  value TEXT NOT NULL CHECK (char_length(value) BETWEEN 1 AND 120),
  PRIMARY KEY (template_slug, kind, value)
);

CREATE INDEX IF NOT EXISTS idx_phb_creature_template_list_tag_kind_value
  ON rpg.phb_creature_template_list_tag (kind, value);

CREATE TABLE IF NOT EXISTS rpg.phb_creature_stat_block_conversion (
  legacy_2014_name_en TEXT NOT NULL CHECK (char_length(legacy_2014_name_en) BETWEEN 1 AND 120),
  equivalent_2024_name_en TEXT NOT NULL CHECK (char_length(equivalent_2024_name_en) BETWEEN 1 AND 120),
  template_slug TEXT REFERENCES rpg.phb_creature_template(slug) ON DELETE SET NULL,
  PRIMARY KEY (legacy_2014_name_en, equivalent_2024_name_en)
);

CREATE INDEX IF NOT EXISTS idx_phb_creature_stat_block_conversion_slug
  ON rpg.phb_creature_stat_block_conversion (template_slug)
  WHERE template_slug IS NOT NULL;
