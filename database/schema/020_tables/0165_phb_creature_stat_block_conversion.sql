-- Conversões de stat block 2014 → equivalente MM 2024 (nome EN).
CREATE TABLE rpg.phb_creature_stat_block_conversion (
  legacy_2014_name_en TEXT NOT NULL CHECK (char_length(legacy_2014_name_en) BETWEEN 1 AND 120),
  equivalent_2024_name_en TEXT NOT NULL CHECK (char_length(equivalent_2024_name_en) BETWEEN 1 AND 120),
  template_slug TEXT REFERENCES rpg.phb_creature_template(slug) ON DELETE SET NULL,
  PRIMARY KEY (legacy_2014_name_en, equivalent_2024_name_en)
);

CREATE INDEX idx_phb_creature_stat_block_conversion_slug
  ON rpg.phb_creature_stat_block_conversion (template_slug)
  WHERE template_slug IS NOT NULL;
