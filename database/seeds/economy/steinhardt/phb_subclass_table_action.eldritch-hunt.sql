-- Table actions — Steinhardt Eldritch Hunt (declarativo; handlers genéricos)

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'electrified-chains', 'Correntes Eletrificadas', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'fulgurant-strike', 'Golpe Fulgurante', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'lightning-step', 'Passo Relâmpago', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'roaring-crash', 'Queda Estrondosa', 6, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'), 'wickerbone-behemoth', 'Beemote de Osso-Vime', 3, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'), 'blood-strike', 'Golpe de Sangue', 3, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'), 'blood-explosion', 'Explosão de Sangue', 7, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'), 'hunt-the-prey', 'Caçar a Presa', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'), 'perfect-hunter', 'Caçador Perfeito', 20, 'perfect-hunter', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'torturer-technique', 'Técnica do Torturador', 3, 'torturer-technique', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'veil-of-pain', 'Véu de Dor', 11, 'veil-of-pain', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'mental-agony', 'Agonia Mental', 15, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'armor-of-the-faithful', 'Armadura dos Fiéis', 3, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'rend-the-blasphemous', 'Rasgar o Blasfemo', 3, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'chains-of-judgement', 'Correntes do Julgamento', 9, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'divine-retaliation', 'Retaliação Divina', 9, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'erupting-blades', 'Lâminas Eruptivas', 9, NULL, true, false, false, 2, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'final-judgement-spirits', 'Espíritos Divinos', 17, 'final-judgement-spirits', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'), 'brittle-bone-armor', 'Armadura de Osso Frágil', 3, 'brittle-bone-armor', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'), 'bone-puppetry', 'Marionetismo Ósseo', 6, 'bone-puppetry', false, false, false, NULL, NULL)
ON CONFLICT (subclass_id, slug) DO UPDATE
  SET name = EXCLUDED.name,
      unlock_level = EXCLUDED.unlock_level,
      free_resource_slug = EXCLUDED.free_resource_slug,
      always_spends_pool = EXCLUDED.always_spends_pool,
      rolls_pool_die = EXCLUDED.rolls_pool_die,
      spends_only_on_success = EXCLUDED.spends_only_on_success,
      always_pool_cost = EXCLUDED.always_pool_cost,
      repeat_pool_cost = EXCLUDED.repeat_pool_cost;
