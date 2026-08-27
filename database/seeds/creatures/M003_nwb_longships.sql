-- Northlands Worldbook — longships + veículos terrestres (Cap. 5)
-- Gerado por scripts/gen-northlands-stat-block-seeds.mjs

-- Trenó de Guerra Ogre (puxado por dois Worgs) (ogre-war-sled)
INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,
  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,
  initiative_modifier, ability_scores
) VALUES (
  'ogre-war-sled',
  'northlands-heroes-2024-en',
  'Trenó de Guerra Ogre (puxado por dois Worgs)',
  'Enorme Veículo Terrestre, incomum',
  17,
  175,
  10,
  2,
  0,
  2000,
  '1 tonelada',
  NULL,
  '{}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  armor_class = EXCLUDED.armor_class,
  hit_points = EXCLUDED.hit_points,
  damage_threshold = EXCLUDED.damage_threshold,
  crew_capacity = EXCLUDED.crew_capacity,
  passenger_capacity = EXCLUDED.passenger_capacity,
  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,
  cargo_capacity_label = EXCLUDED.cargo_capacity_label,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = 'ogre-war-sled';
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('ogre-war-sled', 'mph', 40);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('ogre-war-sled', 'walk', 40);

DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = 'ogre-war-sled';
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('ogre-war-sled', 'Construção Massiva', 'Criaturas que não sejam Grandes devem passar em um teste de Sabedoria CD 13 (Adestrar Animais) a cada turno para controlar o trenó em combate. Se falhar, o trenó se move pelo seu deslocamento numa direção aleatória (exceto para trás).', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('ogre-war-sled', 'Vantagem Montada', 'Passageiros em um trenó de guerra em movimento recebem +2 em rolagens de dano de arma contra criaturas que também não estejam em uma montaria ou veículo.', 1);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('ogre-war-sled', 'Escudo de Crânio', 'Criaturas Grandes montadas no trenó de guerra têm meia cobertura contra ataques à distância.', 2);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('ogre-war-sled', 'Regras de turno', 'No turno dele, o condutor do trenó de guerra pode usar uma das ações abaixo no lugar das ações normais.', 99);

DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = 'ogre-war-sled';
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('ogre-war-sled', 'Atropelamento do Trenó', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O trenó se move pelo menos 9 metros em linha reta. Cada criatura atropelada deve passar em um teste de resistência de Destreza CD 15. Se falhar, sofre 2d10 de dano Contundente e 2d10 de dano Cortante e fica caída. Se passar, sofre metade do dano e não fica caída.', 1);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('ogre-war-sled', 'Ataque dos Worgs', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O trenó se move pelo menos 3 metros em linha reta, terminando adjacente a uma criatura ou objeto. Os dois worgs que puxam o trenó podem cada um fazer um ataque contra o alvo. Se ambos acertarem, o condutor também pode fazer um ataque corpo a corpo com arma contra o alvo.', 2);

-- Drakkar (drakkar)
INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,
  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,
  initiative_modifier, ability_scores
) VALUES (
  'drakkar',
  'northlands-heroes-2024-en',
  'Drakkar',
  'Imensa, Veículo Aquático, (140 pés × 20  pés)',
  15,
  400,
  20,
  80,
  20,
  120000,
  '60 toneladas',
  4,
  '{"forca":26,"destreza":4,"constituicao":20,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  armor_class = EXCLUDED.armor_class,
  hit_points = EXCLUDED.hit_points,
  damage_threshold = EXCLUDED.damage_threshold,
  crew_capacity = EXCLUDED.crew_capacity,
  passenger_capacity = EXCLUDED.passenger_capacity,
  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,
  cargo_capacity_label = EXCLUDED.cargo_capacity_label,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = 'drakkar';
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('drakkar', 'mph', 40);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('drakkar', 'remo', 20);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('drakkar', 'vela', 50);

DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = 'drakkar';
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('drakkar', 'Imunidades', 'Veneno, Psíquico; cego , surdo , exausto , amedrontado , incapacitado , paralisado , petrificado , envenenado , caído , atordoado , inconsciente', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('drakkar', 'Velas e Remo', 'Enquanto estiver em iniciativa, o deslocamento listado do drakkar é o de navegação à vela. Reduza pela metade ao navegar contra o vento. Ao remar, o deslocamento do drakkar é 6 m.', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('drakkar', 'Regras de turno', 'No turno dele, o drakkar pode realizar duas ações, escolhendo entre as opções abaixo (pode repetir a mesma ação). Se tiver menos de 40 tripulantes, só pode realizar uma ação. Se tiver menos de 3 tripulantes, não pode se mover nem realizar ações.', 99);

DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = 'drakkar';
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drakkar', 'Disparar Balista', 'action'::rpg.actor_action_bucket, 8, '24 (3d10 + 8) dano Perfurante', 'Ataque à distância com arma: +8 de acerto, alcance 36/144 m, um alvo. Acerto: 24 (3d10 + 8) de dano Perfurante.', 1);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drakkar', 'Remar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O drakkar realiza a ação Disparada.', 2);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drakkar', 'Salva', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Arqueiros lançam uma salva de flechas em um ponto a até 180 m. Criaturas a até 9 m daquele ponto devem fazer um teste de resistência de Destreza CD 13. Se falharem, sofrem 13 (3d8) de dano Perfurante; se passarem, metade do dano. Criaturas que falharem por 5 ou mais têm deslocamento reduzido em 3 m até o início do próximo turno do drakkar.', 3);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drakkar', 'Muro de Escudos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Os remadores erguem os escudos em defesa. Isso concede às criaturas no navio +5 de bônus na Classe de Armadura e em testes de resistência de Destreza, mas o deslocamento atual do navio é reduzido pela metade até o fim da próxima rodada.', 4);

-- Karvi (karvi)
INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,
  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,
  initiative_modifier, ability_scores
) VALUES (
  'karvi',
  'northlands-heroes-2024-en',
  'Karvi',
  'Imensa, Veículo Aquático, (55 pés × 12  pés)',
  15,
  100,
  10,
  16,
  4,
  50000,
  '25 toneladas',
  7,
  '{"forca":16,"destreza":6,"constituicao":12,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  armor_class = EXCLUDED.armor_class,
  hit_points = EXCLUDED.hit_points,
  damage_threshold = EXCLUDED.damage_threshold,
  crew_capacity = EXCLUDED.crew_capacity,
  passenger_capacity = EXCLUDED.passenger_capacity,
  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,
  cargo_capacity_label = EXCLUDED.cargo_capacity_label,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = 'karvi';
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('karvi', 'mph', 30);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('karvi', 'vela', 45);

DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = 'karvi';
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('karvi', 'Imunidades', 'Veneno, Psíquico; cego , surdo , exausto , amedrontado , incapacitado , paralisado , petrificado , envenenado , caído , atordoado , inconsciente', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('karvi', 'Velas', 'Enquanto estiver em iniciativa, o deslocamento do karvi é reduzido a 4,5 m ao navegar contra o vento. Ao navegar a favor do vento, seu deslocamento passa a ser 16,5 m.', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('karvi', 'Regras de turno', 'No turno dele, o karvi pode realizar uma ação, escolhendo entre as opções abaixo. Se tiver menos de 2 tripulantes, não pode se mover nem realizar ações.', 99);

DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = 'karvi';
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('karvi', 'Remar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O karvi realiza a ação Disparada.', 1);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('karvi', 'Salva', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Arqueiros lançam uma salva de flechas em um ponto a até 180 m. Criaturas a até 9 m daquele ponto devem fazer um teste de resistência de Destreza CD 12. Se falharem, sofrem 13 (3d8) de dano Perfurante; se passarem, metade do dano. Criaturas que falharem por 5 ou mais têm deslocamento reduzido em 3 m até o início do próximo turno do karvi.', 2);

-- Knarr (knarr)
INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,
  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,
  initiative_modifier, ability_scores
) VALUES (
  'knarr',
  'northlands-heroes-2024-en',
  'Knarr',
  'Imensa, Veículo Aquático, (50 pés × 15  pés)',
  15,
  200,
  10,
  10,
  15,
  100000,
  '50 toneladas',
  7,
  '{"forca":16,"destreza":6,"constituicao":12,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  armor_class = EXCLUDED.armor_class,
  hit_points = EXCLUDED.hit_points,
  damage_threshold = EXCLUDED.damage_threshold,
  crew_capacity = EXCLUDED.crew_capacity,
  passenger_capacity = EXCLUDED.passenger_capacity,
  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,
  cargo_capacity_label = EXCLUDED.cargo_capacity_label,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = 'knarr';
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('knarr', 'mph', 20);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('knarr', 'vela', 25);

DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = 'knarr';
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('knarr', 'Imunidades', 'Veneno, Psíquico; cego , surdo , exausto , amedrontado , incapacitado , paralisado , petrificado , envenenado , caído , atordoado , inconsciente', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('knarr', 'Quilha Profunda', 'A quilha mais profunda do barco não permite que o knarr seja usado em rios rasos.', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('knarr', 'Velas', 'Enquanto estiver em iniciativa, o deslocamento do knarr é reduzido a 4,5 m ao navegar contra o vento. Ao navegar a favor do vento, seu deslocamento passa a ser 15 m.', 1);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('knarr', 'Regras de turno', 'No turno dele, o knarr pode realizar uma ação, escolhendo entre as opções abaixo. Se tiver menos de 2 tripulantes, não pode se mover nem realizar ações.', 99);

DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = 'knarr';
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('knarr', 'Remar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O knarr realiza a ação Disparada.', 1);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('knarr', 'Salva', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Arqueiros lançam uma salva de flechas em um ponto a até 180 m. Criaturas a até 9 m daquele ponto devem fazer um teste de resistência de Destreza CD 12. Se falharem, sofrem 9 (2d8) de dano Perfurante; se passarem, metade do dano. Criaturas que falharem por 5 ou mais têm deslocamento reduzido em 3 m até o início do próximo turno do knarr.', 2);

-- Skeid (skeid)
INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,
  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,
  initiative_modifier, ability_scores
) VALUES (
  'skeid',
  'northlands-heroes-2024-en',
  'Skeid',
  'Imensa, Veículo Aquático, (100 pés × 15  pés)',
  15,
  350,
  15,
  50,
  30,
  40000,
  '20 toneladas',
  6,
  '{"forca":22,"destreza":6,"constituicao":16,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  armor_class = EXCLUDED.armor_class,
  hit_points = EXCLUDED.hit_points,
  damage_threshold = EXCLUDED.damage_threshold,
  crew_capacity = EXCLUDED.crew_capacity,
  passenger_capacity = EXCLUDED.passenger_capacity,
  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,
  cargo_capacity_label = EXCLUDED.cargo_capacity_label,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = 'skeid';
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skeid', 'mph', 50);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skeid', 'vela', 55);

DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = 'skeid';
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('skeid', 'Imunidades', 'Veneno, Psíquico; cego , surdo , exausto , amedrontado , incapacitado , paralisado , petrificado , envenenado , caído , atordoado , inconsciente', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('skeid', 'Velas', 'Enquanto estiver em iniciativa, o deslocamento do skeid é reduzido a 4,5 m ao navegar contra o vento. Ao navegar a favor do vento, seu deslocamento passa a ser 21 m.', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('skeid', 'Regras de turno', 'No turno dele, o skeid pode realizar duas ações, escolhendo entre as opções abaixo (pode repetir a mesma ação). Se tiver menos de 25 tripulantes, só pode realizar uma ação. Se tiver menos de 3 tripulantes, não pode se mover nem realizar ações.', 99);

DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = 'skeid';
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeid', 'Disparar Balista', 'action'::rpg.actor_action_bucket, 6, '22 (3d10 + 6) dano Perfurante', 'Ataque à distância com arma: +6 de acerto, alcance 36/144 m, um alvo. Acerto: 22 (3d10 + 6) de dano Perfurante.', 1);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeid', 'Remar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skeid realiza a ação Disparada.', 2);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeid', 'Salva', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Arqueiros lançam uma salva de flechas em um ponto a até 180 m. Criaturas a até 9 m daquele ponto devem fazer um teste de resistência de Destreza CD 13. Se falharem, sofrem 13 (3d8) de dano Perfurante; se passarem, metade do dano. Criaturas que falharem por 5 ou mais têm deslocamento reduzido em 3 m até o início do próximo turno do skeid.', 3);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeid', 'Muro de Escudos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Os remadores erguem os escudos em defesa. Isso concede às criaturas no navio +5 de bônus na Classe de Armadura e em testes de resistência de Destreza, mas o deslocamento atual do navio é reduzido pela metade até o fim da próxima rodada.', 4);

-- Snekkja (snekkja)
INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, subtitle, armor_class, hit_points, damage_threshold,
  crew_capacity, passenger_capacity, cargo_capacity_lb, cargo_capacity_label,
  initiative_modifier, ability_scores
) VALUES (
  'snekkja',
  'northlands-heroes-2024-en',
  'Snekkja',
  'Imensa, Veículo Aquático, (60 pés × 8  pés)',
  15,
  250,
  10,
  30,
  10,
  20000,
  '10 toneladas',
  6,
  '{"forca":18,"destreza":6,"constituicao":18,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  armor_class = EXCLUDED.armor_class,
  hit_points = EXCLUDED.hit_points,
  damage_threshold = EXCLUDED.damage_threshold,
  crew_capacity = EXCLUDED.crew_capacity,
  passenger_capacity = EXCLUDED.passenger_capacity,
  cargo_capacity_lb = EXCLUDED.cargo_capacity_lb,
  cargo_capacity_label = EXCLUDED.cargo_capacity_label,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_vehicle_template_speed WHERE template_slug = 'snekkja';
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('snekkja', 'mph', 50);
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft) VALUES ('snekkja', 'vela', 55);

DELETE FROM rpg.phb_vehicle_template_trait WHERE template_slug = 'snekkja';
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('snekkja', 'Imunidades', 'Veneno, Psíquico; cego , surdo , exausto , amedrontado , incapacitado , paralisado , petrificado , envenenado , caído , atordoado , inconsciente', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('snekkja', 'Velas', 'Enquanto estiver em iniciativa, o deslocamento do snekkja é reduzido a 4,5 m ao navegar contra o vento. Ao navegar a favor do vento, seu deslocamento passa a ser 21 m.', 0);
INSERT INTO rpg.phb_vehicle_template_trait (template_slug, name, description, sort_order) VALUES ('snekkja', 'Regras de turno', 'No turno dele, o snekkja pode realizar duas ações, escolhendo entre as opções abaixo (pode repetir a mesma ação). Se tiver menos de 15 tripulantes, só pode realizar uma ação. Se tiver menos de 3 tripulantes, não pode se mover nem realizar ações.', 99);

DELETE FROM rpg.phb_vehicle_template_action WHERE template_slug = 'snekkja';
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('snekkja', 'Remar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O snekkja realiza a ação Disparada.', 1);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('snekkja', 'Salva', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Arqueiros lançam uma salva de flechas em um ponto a até 180 m. Criaturas a até 9 m daquele ponto devem fazer um teste de resistência de Destreza CD 12. Se falharem, sofrem 13 (3d8) de dano Perfurante; se passarem, metade do dano. Criaturas que falharem por 5 ou mais têm deslocamento reduzido em 3 m até o início do próximo turno do snekkja.', 2);
INSERT INTO rpg.phb_vehicle_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('snekkja', 'Muro de Escudos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Os remadores erguem os escudos em defesa. Isso concede às criaturas no navio +5 de bônus na Classe de Armadura e em testes de resistência de Destreza, mas o deslocamento atual do navio é reduzido pela metade até o fim da próxima rodada.', 3);
