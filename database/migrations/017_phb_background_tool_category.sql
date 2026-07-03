-- Categoria de ferramenta em antecedentes com proficiência choice

ALTER TABLE rpg.phb_background
  ADD COLUMN IF NOT EXISTS tool_category_id BIGINT REFERENCES rpg.phb_tool_category(id);

UPDATE rpg.phb_background b
SET tool_category_id = tc.id
FROM rpg.phb_tool_category tc
WHERE b.tool_proficiency_kind = 'choice'
  AND b.tool_category_id IS NULL
  AND (
    (b.slug IN ('artisan') AND tc.slug = 'artisan')
    OR (b.slug IN ('entertainer') AND tc.slug = 'instrument')
    OR (b.slug IN ('guard', 'noble', 'soldier', 'wanderer') AND tc.slug = 'kit')
  );
