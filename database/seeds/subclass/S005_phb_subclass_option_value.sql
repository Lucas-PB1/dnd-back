-- Seed rpg.phb_subclass_option_value
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'acid', 'Ácido', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'cold', 'Gélido', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'fire', 'Ígneo', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'lightning', 'Elétrico', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'poison', 'Venenoso', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '1', 'Engrenagens espectrais', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '2', 'Ponteiros de relógio nos olhos', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '3', 'Pele acobreada brilhante', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '4', 'Equações geométricas', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '5', 'Foco em forma de mecanismo', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '6', 'Tique-taque de engrenagens', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'acid', 'Ácido', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'cold', 'Gélido', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'fire', 'Ígneo', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'lightning', 'Elétrico', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'necrotic', 'Necrótico', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'poison', 'Venenoso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'psychic', 'Psíquico', 7)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'radiant', 'Radiante', 8)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'thunder', 'Trovejante', 9)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'scroll', 'Rolo de pergaminho', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'stone', 'Placa de pedra', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'palm', 'Palma da mão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'crystal', 'Orrery de cristal', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'tattoo', 'Tatuagem minuciosa', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'carving', 'Entalhe enrunado', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'stellarConstellation', 'archer', 'Arqueiro', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'stellarConstellation', 'dragon', 'Dragão', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'stellarConstellation', 'chalice', 'Taça', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'huntersPrey', 'colossus-slayer', 'Assassino de Colossos', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'huntersPrey', 'horde-breaker', 'Destruidor de Hordas', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'defensiveTactics', 'multiattack-defense', 'Defesa Contra Ataques Múltiplos', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'defensiveTactics', 'escape-the-horde', 'Escapar de Hordas', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
           'primalCompanion', 'earth', 'Fera da Terra', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
           'primalCompanion', 'sky', 'Fera do Céu', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
           'primalCompanion', 'sea', 'Fera do Mar', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '1', 'Borboletas ilusórias', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '2', 'Flores no cabelo', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '3', 'Fragrância natural', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '4', 'Sombra dançante', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '5', 'Chifres ou galhadas', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '6', 'Pele e cabelo mutáveis', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'glamourSkill', 'atuacao', 'Atuação', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'glamourSkill', 'enganacao', 'Enganação', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'glamourSkill', 'persuasao', 'Persuasão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
           'ironMindSave', 'carisma', 'Carisma', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
           'ironMindSave', 'inteligencia', 'Inteligência', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'archery', 'Arqueria', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'blind-fighting', 'Combate Cego', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'defense', 'Defesa', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'dueling', 'Duelo', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'great-weapon-fighting', 'Combate com Arma Grande', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'interception', 'Interceptação', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'protection', 'Proteção', 7)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'thrown-weapon-fighting', 'Combate com Arma Arremessável', 8)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'two-weapon-fighting', 'Combate com Duas Armas', 9)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'unarmed-fighting', 'Combate Desarmado', 10)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'parry', 'Aparar', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'menacing-attack', 'Ataque Ameaçador', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'sweeping-attack', 'Ataque de Varredura', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'lunging-attack', 'Ataque Estendido', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'distracting-attack', 'Ataque para Distrair', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'precision-attack', 'Ataque Preciso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'parry', 'Aparar', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'menacing-attack', 'Ataque Ameaçador', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'sweeping-attack', 'Ataque de Varredura', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'lunging-attack', 'Ataque Estendido', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'distracting-attack', 'Ataque para Distrair', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'precision-attack', 'Ataque Preciso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'parry', 'Aparar', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'menacing-attack', 'Ataque Ameaçador', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'sweeping-attack', 'Ataque de Varredura', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'lunging-attack', 'Ataque Estendido', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'distracting-attack', 'Ataque para Distrair', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'precision-attack', 'Ataque Preciso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildRageAspect', 'eagle', 'Águia', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildRageAspect', 'wolf', 'Lobo', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildRageAspect', 'bear', 'Urso', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildAspect', 'owl', 'Coruja', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildAspect', 'panther', 'Pantera', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildAspect', 'salmon', 'Salmão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildPower', 'ram', 'Carneiro', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildPower', 'hawk', 'Falcão', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildPower', 'lion', 'Leão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
           'divineFuryDamage', 'necrotic', 'Necrótico', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
           'divineFuryDamage', 'radiant', 'Radiante', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'acid', 'Ácido', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'cold', 'Gélido', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'fire', 'Ígneo', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'lightning', 'Elétrico', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'thunder', 'Trovejante', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
