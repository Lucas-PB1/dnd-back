-- Subclasse: picks faltantes (Terra, Saber, BM Estudioso, Versado Mago)

-- Círculo da Terra — terreno
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
  'circleTerrain',
  'Terreno do Círculo',
  3,
  'terrain'::rpg.option_value_type
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 'circleTerrain', 'arid', 'Árido', 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 'circleTerrain', 'polar', 'Polar', 2),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 'circleTerrain', 'temperate', 'Temperado', 3),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 'circleTerrain', 'tropical', 'Tropical', 4)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

-- Colégio do Saber — 3 perícias L3 + 2 magias L6
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 'loreBonusSkill1', 'Proficiência Bônus 1', 3, 'skill_list'::rpg.option_value_type, 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 'loreBonusSkill2', 'Proficiência Bônus 2', 3, 'skill_list'::rpg.option_value_type, 2),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 'loreBonusSkill3', 'Proficiência Bônus 3', 3, 'skill_list'::rpg.option_value_type, 3),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 'magicalDiscovery1', 'Descoberta Mágica 1', 6, 'spell'::rpg.option_value_type, 4),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 'magicalDiscovery2', 'Descoberta Mágica 2', 6, 'spell'::rpg.option_value_type, 5)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

UPDATE rpg.phb_option_def
SET spell_max_level = 3
WHERE scope = 'subclass'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore')
  AND option_key IN ('magicalDiscovery1', 'magicalDiscovery2');

-- Mestre da Batalha — Estudioso da Guerra
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 'warScholarArtisanTool', 'Ferramenta de Artesão', 3, 'catalog'::rpg.option_value_type, 0),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 'warScholarSkill', 'Perícia de Guerreiro', 3, 'skill_list'::rpg.option_value_type, 0)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'subclass'::rpg.option_scope, s.id, 'warScholarArtisanTool', v.slug, v.name, v.ord
FROM rpg.phb_subclass s
CROSS JOIN (VALUES
  ('ferramentas-de-carpinteiro', 'Ferramentas de Carpinteiro', 1),
  ('ferramentas-de-cartografo', 'Ferramentas de Cartógrafo', 2),
  ('ferramentas-de-coureiro', 'Ferramentas de Coureiro', 3),
  ('ferramentas-de-entalhador', 'Ferramentas de Entalhador', 4),
  ('ferramentas-de-ferreiro', 'Ferramentas de Ferreiro', 5),
  ('ferramentas-de-funileiro', 'Ferramentas de Funileiro', 6),
  ('ferramentas-de-joalheiro', 'Ferramentas de Joalheiro', 7),
  ('ferramentas-de-oleiro', 'Ferramentas de Oleiro', 8),
  ('ferramentas-de-pedreiro', 'Ferramentas de Pedreiro', 9),
  ('ferramentas-de-sapateiro', 'Ferramentas de Sapateiro', 10),
  ('ferramentas-de-tecelao', 'Ferramentas de Tecelão', 11),
  ('ferramentas-de-vidreiro', 'Ferramentas de Vidreiro', 12)
) AS v(slug, name, ord)
WHERE s.slug = 'battle-master'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

-- Mago — Versado (4 escolas)
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, spell_max_level, spell_school_slugs, sort_order)
VALUES
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 'abjurationVersatility1', 'Versado em Abjuração 1', 3, 'spell'::rpg.option_value_type, 2, ARRAY['abjuracao']::text[], 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 'abjurationVersatility2', 'Versado em Abjuração 2', 3, 'spell'::rpg.option_value_type, 2, ARRAY['abjuracao']::text[], 2),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 'divinationVersatility1', 'Versado em Adivinhação 1', 3, 'spell'::rpg.option_value_type, 2, ARRAY['adivinhacao']::text[], 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 'divinationVersatility2', 'Versado em Adivinhação 2', 3, 'spell'::rpg.option_value_type, 2, ARRAY['adivinhacao']::text[], 2),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 'evocationVersatility1', 'Versado em Evocação 1', 3, 'spell'::rpg.option_value_type, 2, ARRAY['evocacao']::text[], 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 'evocationVersatility2', 'Versado em Evocação 2', 3, 'spell'::rpg.option_value_type, 2, ARRAY['evocacao']::text[], 2),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 'illusionVersatility1', 'Versado em Ilusão 1', 3, 'spell'::rpg.option_value_type, 2, ARRAY['ilusao']::text[], 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 'illusionVersatility2', 'Versado em Ilusão 2', 3, 'spell'::rpg.option_value_type, 2, ARRAY['ilusao']::text[], 2)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  spell_max_level = EXCLUDED.spell_max_level,
  spell_school_slugs = EXCLUDED.spell_school_slugs,
  sort_order = EXCLUDED.sort_order;
