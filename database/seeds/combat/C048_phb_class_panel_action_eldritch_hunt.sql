-- Panel actions — Steinhardt Eldritch Hunt (declarativo)

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
('barbarian|path-of-the-lightning-vessel|electrified-chains', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'electrified-chains', 'Correntes Eletrificadas', 'Fúria: AB — enreda com Dano do Recipiente', 3, NULL, 'subclass'::rpg.panel_action_section, false, 50),
('barbarian|path-of-the-lightning-vessel|fulgurant-strike', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'fulgurant-strike', 'Golpe Fulgurante', 'Fúria: AB após acerto — Emanação Elétrica', 3, NULL, 'subclass'::rpg.panel_action_section, false, 51),
('barbarian|path-of-the-lightning-vessel|lightning-step', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'lightning-step', 'Passo Relâmpago', 'Fúria: mover + dano elétrico', 3, NULL, 'subclass'::rpg.panel_action_section, false, 52),
('barbarian|path-of-the-lightning-vessel|roaring-crash', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'roaring-crash', 'Queda Estrondosa', 'Ao entrar em Fúria: salto e impacto', 6, NULL, 'subclass'::rpg.panel_action_section, false, 53),

('druid|circle-of-symbiosis|wickerbone-behemoth', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'), 'wickerbone-behemoth', 'Beemote de Osso-Vime', 'Gasta Forma Selvagem → beemote 10 min', 3, 'wildShape', 'subclass'::rpg.panel_action_section, false, 50),

('fighter|blood-hound|blood-strike', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'), 'blood-strike', 'Golpe de Sangue', 'Gasta 1 uso: aplica opção de golpe', 3, 'blood-strike', 'subclass'::rpg.panel_action_section, false, 50),
('fighter|blood-hound|blood-explosion', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'), 'blood-explosion', 'Explosão de Sangue', 'AB após errar com arma revestida', 7, NULL, 'subclass'::rpg.panel_action_section, false, 51),

('paladin|oath-of-the-eldritch-hunt|hunt-the-prey', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'), 'hunt-the-prey', 'Caçar a Presa', 'Canalizar: marca presa + teleporte', 3, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 50),
('paladin|oath-of-the-eldritch-hunt|perfect-hunter', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'), 'perfect-hunter', 'Caçador Perfeito', 'Forma de caçador 10 min (1×/DL)', 20, 'perfect-hunter', 'subclass'::rpg.panel_action_section, false, 51),

('ranger|torturer-conclave|torturer-technique', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'torturer-technique', 'Técnica do Torturador', 'No acerto: gasta 1 uso de técnica', 3, 'torturer-technique', 'subclass'::rpg.panel_action_section, false, 50),
('ranger|torturer-conclave|veil-of-pain', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'veil-of-pain', 'Véu de Dor', 'Invisível ao alvo danificado', 11, 'veil-of-pain', 'subclass'::rpg.panel_action_section, false, 51),
('ranger|torturer-conclave|mental-agony', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'mental-agony', 'Agonia Mental', 'Reação: −1d10 em salvaguarda mental', 15, NULL, 'subclass'::rpg.panel_action_section, false, 52),

('rogue|blade-of-radiance|armor-of-the-faithful', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'armor-of-the-faithful', 'Armadura dos Fiéis', 'Reação: 1 PD — desvia ataque', 3, 'divine-points', 'subclass'::rpg.panel_action_section, false, 50),
('rogue|blade-of-radiance|rend-the-blasphemous', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'rend-the-blasphemous', 'Rasgar o Blasfemo', 'AB: ataque extra (1 PD)', 3, 'divine-points', 'subclass'::rpg.panel_action_section, false, 51),
('rogue|blade-of-radiance|chains-of-judgement', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'chains-of-judgement', 'Correntes do Julgamento', 'No acerto: Contido (1 PD)', 9, 'divine-points', 'subclass'::rpg.panel_action_section, false, 52),
('rogue|blade-of-radiance|divine-retaliation', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'divine-retaliation', 'Retaliação Divina', 'Reação: contra-ataque (1 PD)', 9, 'divine-points', 'subclass'::rpg.panel_action_section, false, 53),
('rogue|blade-of-radiance|erupting-blades', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'erupting-blades', 'Lâminas Eruptivas', 'Troca Furtivo por linha radiante (2 PD)', 9, 'divine-points', 'subclass'::rpg.panel_action_section, false, 54),
('rogue|blade-of-radiance|final-judgement-spirits', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'final-judgement-spirits', 'Espíritos Divinos', 'Guardiões Espirituais sem espaço', 17, 'final-judgement-spirits', 'subclass'::rpg.panel_action_section, false, 55),

('wizard|osteomancer|brittle-bone-armor', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'), 'brittle-bone-armor', 'Armadura de Osso Frágil', 'PV temp. + Resistência +2 CA', 3, 'brittle-bone-armor', 'subclass'::rpg.panel_action_section, false, 50),
('wizard|osteomancer|bone-puppetry', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'), 'bone-puppetry', 'Marionetismo Ósseo', 'Controla esqueleto (gasta uso)', 6, 'bone-puppetry', 'subclass'::rpg.panel_action_section, false, 51)
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
