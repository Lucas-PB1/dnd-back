-- Seed rpg.phb_subclass_option_def
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
         'elementalAffinity', 'Afinidade Elemental', 6, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         'orderManifestation', 'Manifestação da Ordem', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
         'infernalResilience', 'Resistência Ínfera', 10, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         'starMapForm', 'Forma do Mapa Estelar', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         'stellarConstellation', 'Constelação da Forma Estrelada', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
         'huntersPrey', 'Presa do Caçador', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
         'defensiveTactics', 'Táticas Defensivas', 7, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
         'primalCompanion', 'Companheiro Primal', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         'feyGift', 'Dádiva de Faéria', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         'glamourSkill', 'Perícia do Glamour Transcendental', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
         'ironMindSave', 'Salvaguarda da Mente de Ferro', 7, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
         'additionalFightingStyle', 'Estilo de Luta Adicional', 7, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         'maneuver1', 'Manobra 1', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         'maneuver2', 'Manobra 2', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         'maneuver3', 'Manobra 3', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
         'wildRageAspect', 'Aspecto da Fúria dos Selvagens', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
         'wildAspect', 'Aspecto dos Selvagens', 6, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
         'wildPower', 'Poder dos Selvagens', 14, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         'divineFuryDamage', 'Tipo de Dano da Fúria Divina', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
         'elementalResistance', 'Resistência do Ápice Elemental', 17, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
