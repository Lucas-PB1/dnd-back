CREATE VIEW rpg.v_phb_background_skill AS
SELECT
  b.slug AS background_slug,
  s.slug AS skill_slug,
  s.name AS skill_name
FROM rpg.phb_background b
JOIN rpg.phb_background_skill bs ON bs.background_id = b.id
JOIN rpg.phb_skill s ON s.id = bs.skill_id
ORDER BY b.slug, s.slug;


-- Enriquece v_phb_background com talento de origem e proficiÃªncia em ferramenta

-- OpÃ§Ãµes de ferramenta quando o antecedente exige escolha (tool_proficiency_kind = choice)

-- Recria a view para incluir feature_description (CREATE OR REPLACE
-- nÃ£o permite inserir coluna no meio da lista existente).
