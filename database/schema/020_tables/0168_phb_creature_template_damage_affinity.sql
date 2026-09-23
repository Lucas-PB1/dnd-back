-- Afinidades de dano do template (resistência / vulnerabilidade / imunidade).

CREATE TABLE rpg.phb_creature_template_damage_affinity (
  template_slug TEXT NOT NULL
    REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  damage_type_slug TEXT NOT NULL
    REFERENCES rpg.phb_damage_type(slug),
  kind rpg.damage_affinity_kind NOT NULL,
  PRIMARY KEY (template_slug, damage_type_slug, kind)
);

CREATE INDEX idx_creature_template_damage_affinity_slug
  ON rpg.phb_creature_template_damage_affinity(template_slug);
