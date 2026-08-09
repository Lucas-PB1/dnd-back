-- Bruxo: economia + painel (Celestial e base) com table_action corretas
-- Idempotente: ON CONFLICT atualiza.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'warlock-magical-cunning',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  NULL,
  'Astúcia Mágica',
  'free'::rpg.action_economy_bucket,
  2,
  'magical-cunning',
  NULL,
  true,
  'Recupera metade dos slots de Pacto (rito 1 min; 1×/DL)',
  NULL,
  'magical-cunning',
  NULL,
  63
),
(
  'warlock-healing-light',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
  'Luz Medicinal',
  'bonus'::rpg.action_economy_bucket,
  3,
  'healing-light',
  NULL,
  false,
  'Cura com reserva de d6s (1–CAR)',
  'Como Ação Bônus, gaste 1 até o seu modificador de Carisma em d6s da reserva de Luz Medicinal para curar uma criatura a até 18 m.',
  'healing-light',
  NULL,
  64
),
(
  'warlock-searing-vengeance',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
  'Vingança Calcinante',
  'reaction'::rpg.action_economy_bucket,
  14,
  'searing-vengeance',
  NULL,
  true,
  'Salvaguarda contra morte (você/aliado 18 m)',
  NULL,
  'searing-vengeance',
  NULL,
  75
)
ON CONFLICT (action_id) DO UPDATE SET
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  subclass_id = EXCLUDED.subclass_id,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
(
  'warlock|magical-cunning',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  NULL,
  'magical-cunning',
  'Astúcia Mágica',
  NULL,
  2,
  'magical-cunning',
  'base'::rpg.panel_action_section,
  false,
  1
),
(
  'warlock|celestial|healing-light',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
  'healing-light',
  'Luz Medicinal',
  'Ação Bônus: gaste 1–CAR d6s da reserva para curar a até 18 m',
  3,
  'healing-light',
  'subclass'::rpg.panel_action_section,
  false,
  2
),
(
  'warlock|celestial|searing-vengeance',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
  'searing-vengeance',
  'Vingança Calcinante',
  'Quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL)',
  14,
  'searing-vengeance',
  'subclass'::rpg.panel_action_section,
  false,
  7
)
ON CONFLICT (panel_key) DO UPDATE SET
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  subclass_id = EXCLUDED.subclass_id,
  sort_order = EXCLUDED.sort_order;
