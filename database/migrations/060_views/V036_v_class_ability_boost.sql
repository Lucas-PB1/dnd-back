-- Aumentos de atributo por classe/nível com a classe normalizada (slug).
CREATE OR REPLACE VIEW rpg.v_phb_class_ability_boost AS
SELECT
  c.slug AS class_slug,
  b.ability_slug,
  b.label,
  b.bonus,
  b.score_max,
  b.from_level
FROM rpg.phb_class_ability_boost b
JOIN rpg.phb_class c ON c.id = b.class_id;
