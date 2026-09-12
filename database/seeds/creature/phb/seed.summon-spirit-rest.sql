-- Summon restantes + Inseto Gigante + Animar Objetos (blocos no texto da magia).
-- Escala: phb_creature_scale_by_slot; mapa phb_spell_spirit*.

-- ─── Aberração ──────────────────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-aberrante-devorador', 'phb-2024-pt', 'Espírito Aberrante (Devorador)',
  'Aberração Média, Neutra', 'Neutra', 'Aberration', 'medium', NULL, NULL, 15, 40,
  '40 + 10 × (círculo − 4)', 0,
  '{"forca":16,"destreza":10,"constituicao":15,"inteligencia":16,"sabedoria":10,"carisma":6}'::jsonb
),
(
  'espirito-aberrante-pseudo-observador', 'phb-2024-pt', 'Espírito Aberrante (Pseudo-observador)',
  'Aberração Média, Neutra', 'Neutra', 'Aberration', 'medium', NULL, NULL, 15, 40,
  '40 + 10 × (círculo − 4)', 0,
  '{"forca":16,"destreza":10,"constituicao":15,"inteligencia":16,"sabedoria":10,"carisma":6}'::jsonb
),
(
  'espirito-aberrante-slaad', 'phb-2024-pt', 'Espírito Aberrante (Slaad)',
  'Aberração Média, Neutra', 'Neutra', 'Aberration', 'medium', NULL, NULL, 15, 40,
  '40 + 10 × (círculo − 4)', 0,
  '{"forca":16,"destreza":10,"constituicao":15,"inteligencia":16,"sabedoria":10,"carisma":6}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-aberrante-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-aberrante-devorador', 'walk', 30),
  ('espirito-aberrante-pseudo-observador', 'walk', 30),
  ('espirito-aberrante-pseudo-observador', 'fly', 30),
  ('espirito-aberrante-slaad', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-aberrante-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-aberrante-devorador', 'Aura Sussurrante', 'No início do turno: Salvaguarda de Sabedoria (CD da magia) em cada criatura (exceto você) a 1,5 m — Falha: 2d6 Psíquico.', 0),
  ('espirito-aberrante-devorador', 'Imunidades', 'Psíquico. Visão no Escuro 18 m; Percepção passiva 10. Dialeto Obscuro + idiomas que você fala.', 1),
  ('espirito-aberrante-pseudo-observador', 'Imunidades', 'Psíquico. Visão no Escuro 18 m; Percepção passiva 10. Dialeto Obscuro + idiomas que você fala. Voo (pairar).', 0),
  ('espirito-aberrante-slaad', 'Regeneração', 'Recupera 5 PV no início do turno se tiver ≥1 PV.', 0),
  ('espirito-aberrante-slaad', 'Imunidades', 'Psíquico. Visão no Escuro 18 m; Percepção passiva 10. Dialeto Obscuro + idiomas que você fala.', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-aberrante-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-aberrante-devorador', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo (arredondado para baixo).', 1),
  ('espirito-aberrante-devorador', 'Pancada Psíquica', 'action'::rpg.actor_action_bucket, NULL, '1d8+3', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d8+3 + círculo (Psíquico).', 2),
  ('espirito-aberrante-pseudo-observador', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo (arredondado para baixo).', 1),
  ('espirito-aberrante-pseudo-observador', 'Raio Ocular', 'action'::rpg.actor_action_bucket, NULL, '1d8+3', 'Ataque à distância: bônus = ataque mágico, alcance 45 m. Dano: 1d8+3 + círculo (Psíquico).', 2),
  ('espirito-aberrante-slaad', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo (arredondado para baixo).', 1),
  ('espirito-aberrante-slaad', 'Garras', 'action'::rpg.actor_action_bucket, NULL, '1d10+3', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d10+3 + círculo (Cortante); alvo não recupera PV até o início do próximo turno do espírito.', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-aberracao', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-aberracao';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-aberracao', 'devorador', 'espirito-aberrante-devorador', 'Devorador de Mentes'),
  ('invocar-aberracao', 'pseudo-observador', 'espirito-aberrante-pseudo-observador', 'Pseudo-observador'),
  ('invocar-aberracao', 'slaad', 'espirito-aberrante-slaad', 'Slaad');

-- ─── Constructo ─────────────────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-constructo-argila', 'phb-2024-pt', 'Espírito do Constructo (Argila)',
  'Constructo Médio, Neutro', 'Neutro', 'Construct', 'medium', NULL, NULL, 17, 40,
  '40 + 15 × (círculo − 4)', 0,
  '{"forca":18,"destreza":10,"constituicao":18,"inteligencia":14,"sabedoria":11,"carisma":5}'::jsonb
),
(
  'espirito-constructo-metal', 'phb-2024-pt', 'Espírito do Constructo (Metal)',
  'Constructo Médio, Neutro', 'Neutro', 'Construct', 'medium', NULL, NULL, 17, 40,
  '40 + 15 × (círculo − 4)', 0,
  '{"forca":18,"destreza":10,"constituicao":18,"inteligencia":14,"sabedoria":11,"carisma":5}'::jsonb
),
(
  'espirito-constructo-pedra', 'phb-2024-pt', 'Espírito do Constructo (Pedra)',
  'Constructo Médio, Neutro', 'Neutro', 'Construct', 'medium', NULL, NULL, 17, 40,
  '40 + 15 × (círculo − 4)', 0,
  '{"forca":18,"destreza":10,"constituicao":18,"inteligencia":14,"sabedoria":11,"carisma":5}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-constructo-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-constructo-argila', 'walk', 30),
  ('espirito-constructo-metal', 'walk', 30),
  ('espirito-constructo-pedra', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-constructo-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-constructo-argila', 'Resistências / Imunidades', 'Resistência Venenoso. Imune a Amedrontado, Enfeitiçado, Envenenado, Exaustão, Paralisado.', 0),
  ('espirito-constructo-metal', 'Corpo Aquecido', 'Criatura que acerta corpo a corpo ou inicia turno imobilizando o espírito: 1d10 Ígneo.', 0),
  ('espirito-constructo-metal', 'Resistências / Imunidades', 'Resistência Venenoso. Imune a Amedrontado, Enfeitiçado, Envenenado, Exaustão, Paralisado.', 1),
  ('espirito-constructo-pedra', 'Letargia Empedernida', 'Criatura a 3 m no início do turno: Salvaguarda de Sabedoria (CD da magia) — Falha: sem AoO e deslocamento pela metade até o próximo turno do espírito.', 0),
  ('espirito-constructo-pedra', 'Resistências / Imunidades', 'Resistência Venenoso. Imune a Amedrontado, Enfeitiçado, Envenenado, Exaustão, Paralisado.', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-constructo-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-constructo-argila', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo em Pancada.', 1),
  ('espirito-constructo-argila', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d8+4', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d8+4 + círculo (Contundente).', 2),
  ('espirito-constructo-argila', 'Reação Violenta', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Ao sofrer dano de uma criatura: Pancada contra ela ou move metade do deslocamento sem AoO.', 3),
  ('espirito-constructo-metal', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo em Pancada.', 1),
  ('espirito-constructo-metal', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d8+4', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d8+4 + círculo (Contundente).', 2),
  ('espirito-constructo-pedra', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo em Pancada.', 1),
  ('espirito-constructo-pedra', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d8+4', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d8+4 + círculo (Contundente).', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-constructo', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-constructo';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-constructo', 'argila', 'espirito-constructo-argila', 'Argila'),
  ('invocar-constructo', 'metal', 'espirito-constructo-metal', 'Metal'),
  ('invocar-constructo', 'pedra', 'espirito-constructo-pedra', 'Pedra');

-- ─── Dragão (1 bloco; resistência/sopro escolhidos na mesa) ─────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'espirito-draconico', 'phb-2024-pt', 'Espírito Dracônico',
  'Dragão Grande, Neutro', 'Neutro', 'Dragon', 'large', NULL, NULL, 19, 50,
  '50 + 10 × (círculo − 5)', 2,
  '{"forca":19,"destreza":14,"constituicao":17,"inteligencia":10,"sabedoria":14,"carisma":14}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'espirito-draconico';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-draconico', 'walk', 30),
  ('espirito-draconico', 'swim', 30),
  ('espirito-draconico', 'fly', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'espirito-draconico';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-draconico', 'Resistências Compartilhadas', 'Ao invocar, escolha uma resistência (Ácido/Elétrico/Gélido/Ígneo/Venenoso); você ganha essa resistência até a magia terminar.', 0),
  ('espirito-draconico', 'Imunidades', 'Amedrontado, Enfeitiçado, Envenenado. Visão às Cegas 9 m; Visão no Escuro 18 m; Percepção passiva 12.', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'espirito-draconico';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-draconico', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo em Dilacerar + Ataque de Sopro.', 1),
  ('espirito-draconico', 'Dilacerar', 'action'::rpg.actor_action_bucket, NULL, '1d6+4', 'Ataque corpo a corpo: bônus = ataque mágico, alcance 3 m. Dano: 1d6+4 + círculo (Perfurante).', 2),
  ('espirito-draconico', 'Ataque de Sopro', 'action'::rpg.actor_action_bucket, NULL, '2d6', 'Salvaguarda de Destreza (CD da magia), Cone 9 m. Falha: 2d6 do tipo de resistência escolhido. Sucesso: metade.', 3);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-dragao', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-dragao';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-dragao', 'padrao', 'espirito-draconico', 'Espírito Dracônico');

-- ─── Ínfero ─────────────────────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-infero-demonio', 'phb-2024-pt', 'Espírito Ínfero (Demônio)',
  'Ínfero Grande, Neutro', 'Neutro', 'Fiend', 'large', NULL, NULL, 18, 50,
  '50 + 15 × (círculo − 6)', 3,
  '{"forca":13,"destreza":16,"constituicao":16,"inteligencia":10,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-infero-diabo', 'phb-2024-pt', 'Espírito Ínfero (Diabo)',
  'Ínfero Grande, Neutro', 'Neutro', 'Fiend', 'large', NULL, NULL, 18, 40,
  '40 + 15 × (círculo − 6)', 3,
  '{"forca":13,"destreza":16,"constituicao":16,"inteligencia":10,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-infero-yugoloth', 'phb-2024-pt', 'Espírito Ínfero (Yugoloth)',
  'Ínfero Grande, Neutro', 'Neutro', 'Fiend', 'large', NULL, NULL, 18, 60,
  '60 + 15 × (círculo − 6)', 3,
  '{"forca":13,"destreza":16,"constituicao":16,"inteligencia":10,"sabedoria":10,"carisma":16}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-infero-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-infero-demonio', 'walk', 40),
  ('espirito-infero-demonio', 'climb', 40),
  ('espirito-infero-diabo', 'walk', 40),
  ('espirito-infero-diabo', 'fly', 60),
  ('espirito-infero-yugoloth', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-infero-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-infero-demonio', 'Espasmos da Morte', 'Ao 0 PV ou fim da magia: explode; Salvaguarda de Destreza (CD da magia) em Emanação 3 m — Falha: 2d10 + círculo Ígneo.', 0),
  ('espirito-infero-demonio', 'Resistência à Magia', 'Vantagem em salvaguardas contra magias e efeitos mágicos. Resistência Ígneo; Imune Venenoso/Envenenado.', 1),
  ('espirito-infero-diabo', 'Visão Diabólica', 'Escuridão mágica não impede Visão no Escuro. Resistência à Magia; Resistência Ígneo; Imune Venenoso/Envenenado.', 0),
  ('espirito-infero-yugoloth', 'Resistência à Magia', 'Vantagem em salvaguardas contra magias. Resistência Ígneo; Imune Venenoso/Envenenado.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-infero-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-infero-demonio', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('espirito-infero-demonio', 'Mordida', 'action'::rpg.actor_action_bucket, NULL, '1d12+3', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d12+3 + círculo (Necrótico).', 2),
  ('espirito-infero-diabo', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('espirito-infero-diabo', 'Arremesso de Chamas', 'action'::rpg.actor_action_bucket, NULL, '2d6+3', 'Ataque corpo a corpo ou à distância (45 m): bônus = ataque mágico. Dano: 2d6+3 + círculo (Ígneo).', 2),
  ('espirito-infero-yugoloth', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('espirito-infero-yugoloth', 'Garras', 'action'::rpg.actor_action_bucket, NULL, '1d8+3', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d8+3 + círculo (Cortante); teleporta até 9 m após acertar ou errar.', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-infero', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-infero';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-infero', 'demonio', 'espirito-infero-demonio', 'Demônio'),
  ('invocar-infero', 'diabo', 'espirito-infero-diabo', 'Diabo'),
  ('invocar-infero', 'yugoloth', 'espirito-infero-yugoloth', 'Yugoloth');

-- ─── Morto-Vivo ─────────────────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-morto-vivo-esqueletico', 'phb-2024-pt', 'Espírito Morto-Vivo (Esquelético)',
  'Morto-vivo Médio, Neutro', 'Neutro', 'Undead', 'medium', NULL, NULL, 14, 20,
  '20 + 10 × (círculo − 3)', 3,
  '{"forca":12,"destreza":16,"constituicao":15,"inteligencia":4,"sabedoria":10,"carisma":9}'::jsonb
),
(
  'espirito-morto-vivo-fantasmagorico', 'phb-2024-pt', 'Espírito Morto-Vivo (Fantasmagórico)',
  'Morto-vivo Médio, Neutro', 'Neutro', 'Undead', 'medium', NULL, NULL, 14, 30,
  '30 + 10 × (círculo − 3)', 3,
  '{"forca":12,"destreza":16,"constituicao":15,"inteligencia":4,"sabedoria":10,"carisma":9}'::jsonb
),
(
  'espirito-morto-vivo-putrido', 'phb-2024-pt', 'Espírito Morto-Vivo (Pútrido)',
  'Morto-vivo Médio, Neutro', 'Neutro', 'Undead', 'medium', NULL, NULL, 14, 30,
  '30 + 10 × (círculo − 3)', 3,
  '{"forca":12,"destreza":16,"constituicao":15,"inteligencia":4,"sabedoria":10,"carisma":9}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-morto-vivo-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-morto-vivo-esqueletico', 'walk', 30),
  ('espirito-morto-vivo-fantasmagorico', 'walk', 30),
  ('espirito-morto-vivo-fantasmagorico', 'fly', 40),
  ('espirito-morto-vivo-putrido', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-morto-vivo-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-morto-vivo-esqueletico', 'Imunidades', 'Necrótico, Venenoso; Amedrontado, Envenenado, Exaustão, Paralisado.', 0),
  ('espirito-morto-vivo-fantasmagorico', 'Passagem Incorpórea', 'Move-se através de criaturas/objetos como terreno difícil; se terminar dentro de objeto, é desviado e sofre 1d10 Energético / 1,5 m.', 0),
  ('espirito-morto-vivo-fantasmagorico', 'Imunidades', 'Necrótico, Venenoso; Amedrontado, Envenenado, Exaustão, Paralisado. Voo (pairar).', 1),
  ('espirito-morto-vivo-putrido', 'Aura Purulenta', 'Criatura (exceto você) que inicia turno a 1,5 m: Salvaguarda de Constituição (CD da magia) — Falha: Envenenado até o início do próximo turno.', 0),
  ('espirito-morto-vivo-putrido', 'Imunidades', 'Necrótico, Venenoso; Amedrontado, Envenenado, Exaustão, Paralisado.', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-morto-vivo-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-morto-vivo-esqueletico', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('espirito-morto-vivo-esqueletico', 'Raio da Cova', 'action'::rpg.actor_action_bucket, NULL, '2d4+3', 'Ataque à distância: bônus = ataque mágico, alcance 45 m. Dano: 2d4+3 + círculo (Necrótico).', 2),
  ('espirito-morto-vivo-fantasmagorico', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('espirito-morto-vivo-fantasmagorico', 'Toque Mortal', 'action'::rpg.actor_action_bucket, NULL, '1d8+3', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d8+3 + círculo (Necrótico); Amedrontado até o fim do próximo turno.', 2),
  ('espirito-morto-vivo-putrido', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('espirito-morto-vivo-putrido', 'Garra Podre', 'action'::rpg.actor_action_bucket, NULL, '1d6+3', 'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d6+3 + círculo (Cortante); se Envenenado, Paralisado até o fim do próximo turno.', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-morto-vivo', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-morto-vivo';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-morto-vivo', 'esqueletico', 'espirito-morto-vivo-esqueletico', 'Esquelético'),
  ('invocar-morto-vivo', 'fantasmagorico', 'espirito-morto-vivo-fantasmagorico', 'Fantasmagórico'),
  ('invocar-morto-vivo', 'putrido', 'espirito-morto-vivo-putrido', 'Pútrido');

-- ─── Inseto Gigante ─────────────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'inseto-gigante-aranha', 'phb-2024-pt', 'Inseto Gigante (Aranha)',
  'Fera Grande, Sem Alinhamento', 'Sem Alinhamento', 'Beast', 'large', NULL, NULL, 15, 30,
  '30 + 10 × (círculo − 4)', 1,
  '{"forca":17,"destreza":13,"constituicao":15,"inteligencia":4,"sabedoria":3,"carisma":14}'::jsonb
),
(
  'inseto-gigante-centopeia', 'phb-2024-pt', 'Inseto Gigante (Centopeia)',
  'Fera Grande, Sem Alinhamento', 'Sem Alinhamento', 'Beast', 'large', NULL, NULL, 15, 30,
  '30 + 10 × (círculo − 4)', 1,
  '{"forca":17,"destreza":13,"constituicao":15,"inteligencia":4,"sabedoria":3,"carisma":14}'::jsonb
),
(
  'inseto-gigante-vespa', 'phb-2024-pt', 'Inseto Gigante (Vespa)',
  'Fera Grande, Sem Alinhamento', 'Sem Alinhamento', 'Beast', 'large', NULL, NULL, 15, 30,
  '30 + 10 × (círculo − 4)', 1,
  '{"forca":17,"destreza":13,"constituicao":15,"inteligencia":4,"sabedoria":3,"carisma":14}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'inseto-gigante-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('inseto-gigante-aranha', 'walk', 40),
  ('inseto-gigante-aranha', 'climb', 40),
  ('inseto-gigante-centopeia', 'walk', 40),
  ('inseto-gigante-centopeia', 'climb', 40),
  ('inseto-gigante-vespa', 'walk', 40),
  ('inseto-gigante-vespa', 'climb', 40),
  ('inseto-gigante-vespa', 'fly', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'inseto-gigante-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('inseto-gigante-aranha', 'Escalada de Aranha', 'Escala superfícies difíceis e tetos sem teste.', 0),
  ('inseto-gigante-centopeia', 'Escalada de Aranha', 'Escala superfícies difíceis e tetos sem teste.', 0),
  ('inseto-gigante-vespa', 'Escalada de Aranha', 'Escala superfícies difíceis e tetos sem teste. Voo 12 m.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'inseto-gigante-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('inseto-gigante-aranha', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('inseto-gigante-aranha', 'Punição Venenosa', 'action'::rpg.actor_action_bucket, NULL, '1d6+3', 'Ataque corpo a corpo: bônus = ataque mágico, alcance 3 m. Dano: 1d6+3 + círculo Perfurante + 1d4 Venenoso.', 2),
  ('inseto-gigante-aranha', 'Raio de Teia', 'action'::rpg.actor_action_bucket, NULL, '1d10+3', 'Ataque à distância: bônus = ataque mágico, alcance 18 m. Dano: 1d10+3 + círculo Contundente; deslocamento 0 até o início do próximo turno.', 3),
  ('inseto-gigante-centopeia', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('inseto-gigante-centopeia', 'Punição Venenosa', 'action'::rpg.actor_action_bucket, NULL, '1d6+3', 'Ataque corpo a corpo: bônus = ataque mágico, alcance 3 m. Dano: 1d6+3 + círculo Perfurante + 1d4 Venenoso.', 2),
  ('inseto-gigante-centopeia', 'Cuspe Venenoso', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Salvaguarda de Constituição (CD da magia), criatura a 3 m — Falha: Envenenado até o início do próximo turno do inseto.', 3),
  ('inseto-gigante-vespa', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Metade do círculo.', 1),
  ('inseto-gigante-vespa', 'Punição Venenosa', 'action'::rpg.actor_action_bucket, NULL, '1d6+3', 'Ataque corpo a corpo: bônus = ataque mágico, alcance 3 m. Dano: 1d6+3 + círculo Perfurante + 1d4 Venenoso.', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('inseto-gigante', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'inseto-gigante';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('inseto-gigante', 'aranha', 'inseto-gigante-aranha', 'Aranha'),
  ('inseto-gigante', 'centopeia', 'inseto-gigante-centopeia', 'Centopeia'),
  ('inseto-gigante', 'vespa', 'inseto-gigante-vespa', 'Vespa');

-- ─── Animar Objetos (CA/HP fixos por tamanho; dano sobe no texto, não no scale) ─
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'objeto-animado-medio', 'phb-2024-pt', 'Objeto Animado (Médio ou menor)',
  'Constructo Médio ou Menor, Sem Alinhamento', 'Sem Alinhamento', 'Construct', 'medium', NULL, NULL, 15, 10,
  '10 (fixo)', 0,
  '{"forca":16,"destreza":10,"constituicao":10,"inteligencia":3,"sabedoria":3,"carisma":1}'::jsonb
),
(
  'objeto-animado-grande', 'phb-2024-pt', 'Objeto Animado (Grande)',
  'Constructo Grande, Sem Alinhamento', 'Sem Alinhamento', 'Construct', 'large', NULL, NULL, 15, 20,
  '20 (fixo)', 0,
  '{"forca":16,"destreza":10,"constituicao":10,"inteligencia":3,"sabedoria":3,"carisma":1}'::jsonb
),
(
  'objeto-animado-enorme', 'phb-2024-pt', 'Objeto Animado (Enorme)',
  'Constructo Enorme, Sem Alinhamento', 'Sem Alinhamento', 'Construct', 'huge', NULL, NULL, 15, 40,
  '40 (fixo)', 0,
  '{"forca":16,"destreza":10,"constituicao":10,"inteligencia":3,"sabedoria":3,"carisma":1}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'objeto-animado-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('objeto-animado-medio', 'walk', 30),
  ('objeto-animado-grande', 'walk', 30),
  ('objeto-animado-enorme', 'walk', 30);

-- Fonte: PHB 2024 Animated Object (D&D Beyond scrap em docs/source/scrap).
-- Orçamento do cast (não no template): máx. objetos = mod. conjuração;
-- Médio ou menor = 1, Grande = 2, Enorme = 3. PB = PB do conjurador.
DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'objeto-animado-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('objeto-animado-medio', 'Imunidades', 'Venenoso, Psíquico; Amedrontado, Enfeitiçado, Envenenado, Exaustão, Paralisado.', 0),
  ('objeto-animado-medio', 'Sentidos', 'Visão às Cegas 9 m; Percepção Passiva 6.', 1),
  ('objeto-animado-medio', 'Idiomas', 'Compreende os idiomas que você conhece.', 2),
  ('objeto-animado-medio', 'Bônus de Proficiência', 'Igual ao Bônus de Proficiência do conjurador.', 3),
  ('objeto-animado-grande', 'Imunidades', 'Venenoso, Psíquico; Amedrontado, Enfeitiçado, Envenenado, Exaustão, Paralisado.', 0),
  ('objeto-animado-grande', 'Sentidos', 'Visão às Cegas 9 m; Percepção Passiva 6.', 1),
  ('objeto-animado-grande', 'Idiomas', 'Compreende os idiomas que você conhece.', 2),
  ('objeto-animado-grande', 'Bônus de Proficiência', 'Igual ao Bônus de Proficiência do conjurador.', 3),
  ('objeto-animado-enorme', 'Imunidades', 'Venenoso, Psíquico; Amedrontado, Enfeitiçado, Envenenado, Exaustão, Paralisado.', 0),
  ('objeto-animado-enorme', 'Sentidos', 'Visão às Cegas 9 m; Percepção Passiva 6.', 1),
  ('objeto-animado-enorme', 'Idiomas', 'Compreende os idiomas que você conhece.', 2),
  ('objeto-animado-enorme', 'Bônus de Proficiência', 'Igual ao Bônus de Proficiência do conjurador.', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'objeto-animado-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('objeto-animado-medio', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d4+3',
   'Ataque corpo a corpo (alcance 1,5 m): bônus = seu bônus de ataque mágico. Acerto: dano Energético 1d4+3. Usando slot acima de 5º: +1d4 por círculo.', 1),
  ('objeto-animado-grande', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '2d6+3',
   'Ataque corpo a corpo (alcance 1,5 m): bônus = seu bônus de ataque mágico. Acerto: dano Energético 2d6+3 + seu modificador de conjuração. Usando slot acima de 5º: +1d6 por círculo.', 1),
  ('objeto-animado-enorme', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '2d12+3',
   'Ataque corpo a corpo (alcance 1,5 m): bônus = seu bônus de ataque mágico. Acerto: dano Energético 2d12+3 + seu modificador de conjuração. Usando slot acima de 5º: +1d12 por círculo.', 1);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('animar-objetos', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET actor_kind = EXCLUDED.actor_kind, replace_policy = EXCLUDED.replace_policy, fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'animar-objetos';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label, budget_cost) VALUES
  ('animar-objetos', 'medio', 'objeto-animado-medio', 'Médio ou menor', 1),
  ('animar-objetos', 'grande', 'objeto-animado-grande', 'Grande', 2),
  ('animar-objetos', 'enorme', 'objeto-animado-enorme', 'Enorme', 3);

-- Escalas
INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('espirito-aberrante-devorador', 4, 11, 1, 40, 10, 'above_min'),
  ('espirito-aberrante-pseudo-observador', 4, 11, 1, 40, 10, 'above_min'),
  ('espirito-aberrante-slaad', 4, 11, 1, 40, 10, 'above_min'),
  ('espirito-constructo-argila', 4, 13, 1, 40, 15, 'above_min'),
  ('espirito-constructo-metal', 4, 13, 1, 40, 15, 'above_min'),
  ('espirito-constructo-pedra', 4, 13, 1, 40, 15, 'above_min'),
  ('espirito-draconico', 5, 14, 1, 50, 10, 'above_min'),
  ('espirito-infero-demonio', 6, 12, 1, 50, 15, 'above_min'),
  ('espirito-infero-diabo', 6, 12, 1, 40, 15, 'above_min'),
  ('espirito-infero-yugoloth', 6, 12, 1, 60, 15, 'above_min'),
  ('espirito-morto-vivo-esqueletico', 3, 11, 1, 20, 10, 'above_min'),
  ('espirito-morto-vivo-fantasmagorico', 3, 11, 1, 30, 10, 'above_min'),
  ('espirito-morto-vivo-putrido', 3, 11, 1, 30, 10, 'above_min'),
  ('inseto-gigante-aranha', 4, 11, 1, 30, 10, 'above_min'),
  ('inseto-gigante-centopeia', 4, 11, 1, 30, 10, 'above_min'),
  ('inseto-gigante-vespa', 4, 11, 1, 30, 10, 'above_min'),
  ('objeto-animado-medio', 5, 15, 0, 10, 0, 'per_slot'),
  ('objeto-animado-grande', 5, 15, 0, 20, 0, 'per_slot'),
  ('objeto-animado-enorme', 5, 15, 0, 40, 0, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;
