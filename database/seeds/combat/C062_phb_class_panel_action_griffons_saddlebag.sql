-- Panel actions — Griffon's Saddlebag Book One (11 subclasses restantes)

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
('bard|college-of-choreography|inspirational-dance', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'), 'inspirational-dance', 'Dança Inspiradora', 'AB: Inspiração → PV temp.', 3, 'bardicInspiration', 'subclass'::rpg.panel_action_section, false, 50),
('bard|college-of-choreography|endless-dance-attack', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'), 'endless-dance-attack', 'Dança Infinita (ataque)', 'Reação: ataque em vez de PV temp.', 14, NULL, 'subclass'::rpg.panel_action_section, false, 51),
('bard|college-of-choreography|endless-dodge', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'), 'endless-dodge', 'Dança Infinita (esquivar)', 'AB com Inspiração: Esquivar', 14, NULL, 'subclass'::rpg.panel_action_section, false, 52),

('cleric|astral-domain|create-void', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 'create-void', 'Criar Vazio', 'Canalizar: vácuo 4,5 m', 3, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 50),
('cleric|astral-domain|planar-reach', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 'planar-reach', 'Alcance Planar', 'Toque → 9 m (usos = SAB)', 3, 'planar-reach', 'subclass'::rpg.panel_action_section, false, 51),
('cleric|astral-domain|spatial-exchange', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 'spatial-exchange', 'Troca Espacial', 'Canalizar: Passo Nebuloso + troca', 6, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 52),

('druid|the-unbroken-circle|wild-recovery', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'), 'wild-recovery', 'Recuperação Selvagem', 'AB: gasta Forma → cura', 3, 'wildShape', 'subclass'::rpg.panel_action_section, false, 50),

('fighter|couatl-herald|benevolent-presence', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'benevolent-presence', 'Presença Benevolente', 'Teste: gasta Dados de Misericórdia', 3, 'mercy-dice', 'subclass'::rpg.panel_action_section, false, 50),
('fighter|couatl-herald|merciless-strike', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'merciless-strike', 'Golpe Implacável', '1×/turno: dano Radiante extra', 3, 'mercy-dice', 'subclass'::rpg.panel_action_section, false, 51),
('fighter|couatl-herald|peaceful-ward', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'peaceful-ward', 'Proteção Pacífica', 'AB: PV temp. = dado + CAR', 3, 'mercy-dice', 'subclass'::rpg.panel_action_section, false, 52),
('fighter|couatl-herald|paragon', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'paragon', 'Paragona', 'Ação Bônus: comando aliado', 15, 'mercy-dice', 'subclass'::rpg.panel_action_section, false, 53),

('monk|warrior-of-the-celestial|soul-searching-strike', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'), 'soul-searching-strike', 'Golpe de Busca da Alma', 'No acerto: 1 Foco — sonda alma', 3, NULL, 'subclass'::rpg.panel_action_section, true, 50),
('monk|warrior-of-the-celestial|stabilizing-focus', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'), 'stabilizing-focus', 'Foco Estabilizador', 'Ação Mágica: cura 5 PV/Foco', 6, NULL, 'subclass'::rpg.panel_action_section, true, 51),
('monk|warrior-of-the-celestial|stabilizing-focus-bonus', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'), 'stabilizing-focus-bonus', 'Foco Estabilizador (AB)', 'AB: cura a até 9 m', 17, NULL, 'subclass'::rpg.panel_action_section, true, 52),

('paladin|oath-of-the-hearth|burning-weapon', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'), 'burning-weapon', 'Arma Flamejante', 'Ao Atacar: Canalizar — arma ígnea', 3, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 50),
('paladin|oath-of-the-hearth|burning-spirit', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'), 'burning-spirit', 'Espírito Flamejante', 'AB: forma flamejante 10 min', 20, 'burning-spirit', 'subclass'::rpg.panel_action_section, false, 51),

('ranger|winter-trapper|magic-snare', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'), 'magic-snare', 'Armadilha Mágica', 'AB: armadilha no chão', 11, 'magic-snare', 'subclass'::rpg.panel_action_section, false, 50),
('ranger|winter-trapper|tripped-defenses', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'), 'tripped-defenses', 'Defesas Tropeçadas', 'Reação: desequilibra atacante', 15, NULL, 'subclass'::rpg.panel_action_section, false, 51),

('rogue|runetagger|impressionist-supplies', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'impressionist-supplies', 'Impressionista', 'Ação Mágica: suprimentos/tinta', 3, NULL, 'subclass'::rpg.panel_action_section, false, 50),
('rogue|runetagger|rune-mark', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'rune-mark', 'Marcar com Runa', 'No acerto: 1 Ponto de Runa', 3, 'rune-points', 'subclass'::rpg.panel_action_section, false, 51),
('rogue|runetagger|rune-hexxus', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'rune-hexxus', 'Runa Maldíx', 'Reação: −1d6 no sucesso', 3, NULL, 'subclass'::rpg.panel_action_section, false, 52),
('rogue|runetagger|escape-invisibility', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'escape-invisibility', 'Artista da Fuga', 'AB + Runa: Invisível 10 min', 9, 'rune-points', 'subclass'::rpg.panel_action_section, false, 53),

('sorcerer|frost-sorcery|create-ice', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'), 'create-ice', 'Criar Gelo', 'AB: terreno gelado 1,5 m', 3, NULL, 'subclass'::rpg.panel_action_section, false, 50),
('sorcerer|frost-sorcery|cryomancy-freeze', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'), 'cryomancy-freeze', 'Criomancia', 'PF: reduz Velocidade alvo', 6, NULL, 'subclass'::rpg.panel_action_section, false, 51),
('sorcerer|frost-sorcery|flash-freeze', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'), 'flash-freeze', 'Congelamento Súbito', 'Reação: dano Gélido + gelo', 14, NULL, 'subclass'::rpg.panel_action_section, false, 52),

('warlock|astral-griffon-patron|planar-escape', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 'planar-escape', 'Escape Planar', 'Reação: semiplano 1 turno', 6, NULL, 'subclass'::rpg.panel_action_section, false, 50),
('warlock|astral-griffon-patron|astral-clarity', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 'astral-clarity', 'Clareza Astral', 'Visão Verdadeira 9 m', 10, 'astral-clarity', 'subclass'::rpg.panel_action_section, false, 51),
('warlock|astral-griffon-patron|pocketeer-shunt', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 'pocketeer-shunt', 'Bolseiro', 'Ação Mágica: envia objeto', 14, NULL, 'subclass'::rpg.panel_action_section, false, 52),

('wizard|materializer|dismiss-cubes', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'dismiss-cubes', 'Dispersar Cubos', 'AB: dispersa Cubos', 3, NULL, 'subclass'::rpg.panel_action_section, false, 50),
('wizard|materializer|cube-detonation', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'cube-detonation', 'Detonação de Cubo', 'AB: detona Cubo (usos = INT)', 3, 'cube-detonation', 'subclass'::rpg.panel_action_section, false, 51),
('wizard|materializer|material-enhancement', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'material-enhancement', 'Aprimoramento Material', 'Ação Mágica: benefícios no objeto', 6, NULL, 'subclass'::rpg.panel_action_section, false, 52),
('wizard|materializer|rematerialize', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'rematerialize', 'Rematerializar', 'Reação: guarda e recria objeto', 14, 'rematerialize', 'subclass'::rpg.panel_action_section, false, 53)
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
