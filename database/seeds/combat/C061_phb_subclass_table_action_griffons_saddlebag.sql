-- Table actions — Griffon's Saddlebag Book One (11 subclasses restantes)

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'), 'inspirational-dance', 'Dança Inspiradora', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'), 'endless-dance-attack', 'Dança Infinita (ataque)', 14, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'), 'endless-dodge', 'Dança Infinita (esquivar)', 14, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 'create-void', 'Criar Vazio', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 'planar-reach', 'Alcance Planar', 3, 'planar-reach', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 'spatial-exchange', 'Troca Espacial', 6, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'), 'wild-recovery', 'Recuperação Selvagem', 3, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'benevolent-presence', 'Presença Benevolente', 3, 'mercy-dice', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'merciless-strike', 'Golpe Implacável', 3, 'mercy-dice', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'peaceful-ward', 'Proteção Pacífica', 3, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 'paragon', 'Paragona', 15, NULL, true, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'), 'soul-searching-strike', 'Golpe de Busca da Alma', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'), 'stabilizing-focus', 'Foco Estabilizador', 6, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'), 'stabilizing-focus-bonus', 'Foco Estabilizador (AB)', 17, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'), 'burning-weapon', 'Arma Flamejante', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'), 'burning-spirit', 'Espírito Flamejante', 20, 'burning-spirit', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'), 'magic-snare', 'Armadilha Mágica', 11, 'magic-snare', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'), 'tripped-defenses', 'Defesas Tropeçadas', 15, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'impressionist-supplies', 'Impressionista (suprimentos)', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'rune-mark', 'Marcar com Runa', 3, 'rune-points', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'rune-hexxus', 'Runa Maldíx', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 'escape-invisibility', 'Artista da Fuga (invisível)', 9, NULL, true, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'), 'create-ice', 'Criar Gelo', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'), 'cryomancy-freeze', 'Criomancia', 6, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'), 'flash-freeze', 'Congelamento Súbito', 14, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 'planar-escape', 'Escape Planar', 6, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 'astral-clarity', 'Clareza Astral', 10, 'astral-clarity', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 'pocketeer-shunt', 'Bolseiro (enviar)', 14, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'dismiss-cubes', 'Dispersar Cubos', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'cube-detonation', 'Detonação de Cubo', 3, 'cube-detonation', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'material-enhancement', 'Aprimoramento Material', 6, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 'rematerialize', 'Rematerializar', 14, 'rematerialize', true, false, false, NULL, NULL)
ON CONFLICT (subclass_id, slug) DO UPDATE
  SET name = EXCLUDED.name,
      unlock_level = EXCLUDED.unlock_level,
      free_resource_slug = EXCLUDED.free_resource_slug,
      always_spends_pool = EXCLUDED.always_spends_pool,
      rolls_pool_die = EXCLUDED.rolls_pool_die,
      spends_only_on_success = EXCLUDED.spends_only_on_success,
      always_pool_cost = EXCLUDED.always_pool_cost,
      repeat_pool_cost = EXCLUDED.repeat_pool_cost;
