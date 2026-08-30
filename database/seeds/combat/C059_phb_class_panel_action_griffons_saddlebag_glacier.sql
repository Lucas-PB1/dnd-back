-- Panel actions — Griffon's Saddlebag (piloto: Caminho da Glaciar)

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
(
  'barbarian|path-of-the-glacier|glacier-rage-extension',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  'glacier-rage-extension',
  'Extensão de Fúria',
  'Sem ação: estende Fúria (usos = Constituição)',
  3,
  'glacier-rage-extension',
  'subclass'::rpg.panel_action_section,
  false,
  50
),
(
  'barbarian|path-of-the-glacier|frostbite',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  'frostbite',
  'Geladura',
  'Fúria: 1×/turno +d6 Gélido no acerto de Força',
  3,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  51
),
(
  'barbarian|path-of-the-glacier|cold-fortress-entry',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  'cold-fortress-entry',
  'Fortaleza Gelada (entrada)',
  'Ao entrar em Fúria: PV temp. 1d12 + Constituição',
  6,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  52
),
(
  'barbarian|path-of-the-glacier|cold-fortress-renew',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  'cold-fortress-renew',
  'Fortaleza Gelada (renovar)',
  'Ação Bônus em Fúria: gasta 1 DV',
  6,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  53
),
(
  'barbarian|path-of-the-glacier|avalanche-stomp',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  'avalanche-stomp',
  'Pisoteio Glacial',
  'Ação Mágica: tremor 4,5 m',
  14,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  54
)
ON CONFLICT (panel_key) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  spends_focus = EXCLUDED.spends_focus,
  sort_order = EXCLUDED.sort_order;
