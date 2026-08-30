-- Panel actions — Grim Hollow Cap. 2 (piloto: Caçador de Monstros)

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
(
  'monster-hunter|studied-response',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  NULL,
  'studied-response',
  'Resposta Estudada',
  'Reação: ataque antes do ataque inimigo',
  2,
  NULL,
  'base'::rpg.panel_action_section,
  false,
  60
),
(
  'monster-hunter|slayer-aid',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  NULL,
  'slayer-aid',
  'Auxílio do Exterminador',
  'Com Resposta Estudada: aliado ataca',
  17,
  NULL,
  'base'::rpg.panel_action_section,
  false,
  61
),
(
  'monster-hunter|grave-strike',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  NULL,
  'grave-strike',
  'Golpe Sepulcral',
  'Crítico: salvaguarda ou 0 PV',
  20,
  'grave-strike',
  'base'::rpg.panel_action_section,
  false,
  62
)
ON CONFLICT (panel_key) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  sort_order = EXCLUDED.sort_order;
