-- Tags de listagem MM (habitat, treasure, group) por template.
CREATE TABLE rpg.phb_creature_template_list_tag (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (kind IN ('habitat', 'treasure', 'group')),
  value TEXT NOT NULL CHECK (char_length(value) BETWEEN 1 AND 120),
  PRIMARY KEY (template_slug, kind, value)
);

CREATE INDEX idx_phb_creature_template_list_tag_kind_value
  ON rpg.phb_creature_template_list_tag (kind, value);
