-- PHB 2024: cada antecedente concede Comum + 2 idiomas à escolha

UPDATE rpg.phb_background
SET language_choice_count = 2
WHERE language_choice_count = 0;

INSERT INTO rpg.phb_background_language (background_id, language_id)
SELECT b.id, l.id
FROM rpg.phb_background b
CROSS JOIN rpg.phb_language l
WHERE l.slug = 'common'
ON CONFLICT DO NOTHING;
