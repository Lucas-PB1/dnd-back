CREATE VIEW rpg.v_phb_class_skill_choice AS
SELECT
  c.slug AS class_slug,
  c.skill_choice_count,
  c.skill_choice_from,
  s.slug AS skill_slug,
  s.name AS skill_name
FROM rpg.phb_class c
JOIN rpg.phb_class_skill_pool p ON p.class_id = c.id
JOIN rpg.phb_skill s ON s.id = p.skill_id
ORDER BY c.slug, s.slug;

-- OpÃ§Ãµes de truque para Alto Elfo (lista de cantrips de Mago).
-- Kind opcional: nÃ£o entra nos requiredKinds da validaÃ§Ã£o padrÃ£o;
-- validado no application quando presente.
