-- Nível em que a classe exige talento de Estilo de Luta (PHB / Valdas / GH).
-- NULL = classe sem pick obrigatório de fighting style.

UPDATE rpg.phb_class
SET fighting_style_unlock_level = 1
WHERE slug IN ('fighter', 'gunslinger');

UPDATE rpg.phb_class
SET fighting_style_unlock_level = 2
WHERE slug IN ('paladin', 'ranger', 'monster-hunter');
