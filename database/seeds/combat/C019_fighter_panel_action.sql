-- Painel do Guerreiro (base + Psi Warrior). BM/Dungeoneer: UI com seletor (manobra/magia).
-- Idempotente. Roda após C010.

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
(
  'fighter|second-wind',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  NULL,
  'second-wind',
  'Recuperar Fôlego',
  'Ação Bônus: cura 1d10 + nível (gasta 1 uso)',
  1,
  'secondWind',
  'base'::rpg.panel_action_section,
  false,
  1
),
(
  'fighter|action-surge',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  NULL,
  'action-surge',
  'Surto de Ação',
  'Ganha uma Ação adicional neste turno (gasta 1 uso)',
  2,
  'actionSurge',
  'base'::rpg.panel_action_section,
  false,
  2
),
(
  'fighter|tactical-mind',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  NULL,
  'tactical-mind',
  'Mente Tática',
  '+1d10 em teste (pode gastar Fôlego; mesa decide sucesso)',
  2,
  'secondWind',
  'base'::rpg.panel_action_section,
  false,
  3
),
(
  'fighter|psi-warrior|psi:protective-field',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  'psi:protective-field',
  'Campo Protetor',
  'Reação: reduz dano (1 dado psi + INT)',
  3,
  'psi-energy-dice',
  'subclass'::rpg.panel_action_section,
  false,
  10
),
(
  'fighter|psi-warrior|psi:telekinetic-movement',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  'psi:telekinetic-movement',
  'Movimento Telecinético',
  '1× gratuito / descanso; depois 1 dado psi',
  3,
  'psi-energy-dice',
  'subclass'::rpg.panel_action_section,
  false,
  11
),
(
  'fighter|psi-warrior|psi:psychic-leap',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  'psi:psychic-leap',
  'Salto com Impulsão Psíquica',
  'Ação Bônus: voo 2× deslocamento (1× gratuito / descanso)',
  7,
  'psi-energy-dice',
  'subclass'::rpg.panel_action_section,
  false,
  12
),
(
  'fighter|psi-warrior|psi:mental-guard',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  'psi:mental-guard',
  'Resguardo Mental',
  'Encerra Amedrontado/Enfeitiçado (1 dado psi)',
  10,
  'psi-energy-dice',
  'subclass'::rpg.panel_action_section,
  false,
  13
),
(
  'fighter|psi-warrior|psi:energy-bulwark',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  'psi:energy-bulwark',
  'Baluarte de Energia',
  'Cobertura Parcial (1× gratuito / DL; depois 1 dado)',
  15,
  'psi-energy-dice',
  'subclass'::rpg.panel_action_section,
  false,
  14
),
(
  'fighter|psi-warrior|psi:telekinetic-master',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  'psi:telekinetic-master',
  'Mestre Telecinético',
  'Telecinese (1× gratuito / DL; depois 1 dado)',
  18,
  'psi-energy-dice',
  'subclass'::rpg.panel_action_section,
  false,
  15
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
