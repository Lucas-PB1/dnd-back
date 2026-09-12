-- Espíritos Summon core: Bestial / Feérico / Elemental / Celestial.
-- Escala: phb_creature_scale_by_slot; variantes tipadas + mapa phb_spell_spirit.

-- ─── Bestial (Invocar Fera) ─────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-bestial-ar', 'phb-2024-pt', 'Espírito Bestial (Ar)',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', 'small', NULL, NULL, 13, 20,
  '20 + 5 × (círculo − 2)', 3,
  '{"forca":13,"destreza":16,"constituicao":15,"inteligencia":10,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-bestial-terra', 'phb-2024-pt', 'Espírito Bestial (Terra)',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', 'small', NULL, NULL, 13, 30,
  '30 + 5 × (círculo − 2)', 3,
  '{"forca":13,"destreza":16,"constituicao":15,"inteligencia":10,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-bestial-agua', 'phb-2024-pt', 'Espírito Bestial (Água)',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', 'small', NULL, NULL, 13, 30,
  '30 + 5 × (círculo − 2)', 3,
  '{"forca":13,"destreza":16,"constituicao":15,"inteligencia":10,"sabedoria":10,"carisma":16}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-bestial-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-bestial-ar', 'walk', 30),
  ('espirito-bestial-ar', 'fly', 60),
  ('espirito-bestial-terra', 'walk', 30),
  ('espirito-bestial-terra', 'climb', 30),
  ('espirito-bestial-agua', 'walk', 30),
  ('espirito-bestial-agua', 'swim', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-bestial-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-bestial-ar', 'Sobrevoo', 'Não provoca Ataques de Oportunidade ao voar para fora do alcance de um inimigo.', 0),
  ('espirito-bestial-ar', 'Sentidos', 'Visão no Escuro 18 m; Percepção passiva 12. Compreende os idiomas que você fala.', 1),
  ('espirito-bestial-terra', 'Táticas de Grupo', 'Vantagem no ataque se um aliado estiver a 1,5 m do alvo e não Incapacitado.', 0),
  ('espirito-bestial-terra', 'Sentidos', 'Visão no Escuro 18 m; Percepção passiva 12. Compreende os idiomas que você fala.', 1),
  ('espirito-bestial-agua', 'Respirar na Água', 'O espírito só pode respirar debaixo d’água.', 0),
  ('espirito-bestial-agua', 'Táticas de Grupo', 'Vantagem no ataque se um aliado estiver a 1,5 m do alvo e não Incapacitado.', 1),
  ('espirito-bestial-agua', 'Sentidos', 'Visão no Escuro 18 m; Percepção passiva 12. Compreende os idiomas que você fala.', 2);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-bestial-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-bestial-ar', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Dilacerar = metade do círculo do slot (arredondado para baixo).', 1),
  ('espirito-bestial-ar', 'Dilacerar', 'action'::rpg.actor_action_bucket, NULL, '1d8+4',
   'Ataque corpo a corpo: bônus = ataque mágico, alcance 1,5 m. Dano: 1d8+4 + círculo (Perfurante).', 2),
  ('espirito-bestial-terra', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Dilacerar = metade do círculo do slot (arredondado para baixo).', 1),
  ('espirito-bestial-terra', 'Dilacerar', 'action'::rpg.actor_action_bucket, NULL, '1d8+4',
   'Ataque corpo a corpo: bônus = ataque mágico, alcance 1,5 m. Dano: 1d8+4 + círculo (Perfurante).', 2),
  ('espirito-bestial-agua', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Dilacerar = metade do círculo do slot (arredondado para baixo).', 1),
  ('espirito-bestial-agua', 'Dilacerar', 'action'::rpg.actor_action_bucket, NULL, '1d8+4',
   'Ataque corpo a corpo: bônus = ataque mágico, alcance 1,5 m. Dano: 1d8+4 + círculo (Perfurante).', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-fera', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-fera';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-fera', 'ar', 'espirito-bestial-ar', 'Ar'),
  ('invocar-fera', 'terra', 'espirito-bestial-terra', 'Terra'),
  ('invocar-fera', 'agua', 'espirito-bestial-agua', 'Água');

-- ─── Feérico (Invocar Feérico) ──────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-feerico-alegre', 'phb-2024-pt', 'Espírito Feérico (Alegre)',
  'Pequeno Feérico, Neutro', 'Neutro', 'Fey', 'small', NULL, NULL, 15, 30,
  '30 + 10 × (círculo − 3)', 3,
  '{"forca":13,"destreza":16,"constituicao":14,"inteligencia":14,"sabedoria":11,"carisma":16}'::jsonb
),
(
  'espirito-feerico-enfurecido', 'phb-2024-pt', 'Espírito Feérico (Enfurecido)',
  'Pequeno Feérico, Neutro', 'Neutro', 'Fey', 'small', NULL, NULL, 15, 30,
  '30 + 10 × (círculo − 3)', 3,
  '{"forca":13,"destreza":16,"constituicao":14,"inteligencia":14,"sabedoria":11,"carisma":16}'::jsonb
),
(
  'espirito-feerico-malandro', 'phb-2024-pt', 'Espírito Feérico (Malandro)',
  'Pequeno Feérico, Neutro', 'Neutro', 'Fey', 'small', NULL, NULL, 15, 30,
  '30 + 10 × (círculo − 3)', 3,
  '{"forca":13,"destreza":16,"constituicao":14,"inteligencia":14,"sabedoria":11,"carisma":16}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-feerico-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-feerico-alegre', 'walk', 30),
  ('espirito-feerico-alegre', 'fly', 30),
  ('espirito-feerico-enfurecido', 'walk', 30),
  ('espirito-feerico-enfurecido', 'fly', 30),
  ('espirito-feerico-malandro', 'walk', 30),
  ('espirito-feerico-malandro', 'fly', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-feerico-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-feerico-alegre', 'Imunidades', 'Enfeitiçado. Visão no Escuro 18 m; Percepção passiva 10. Silvestre + idiomas que você fala.', 0),
  ('espirito-feerico-enfurecido', 'Imunidades', 'Enfeitiçado. Visão no Escuro 18 m; Percepção passiva 10. Silvestre + idiomas que você fala.', 0),
  ('espirito-feerico-malandro', 'Imunidades', 'Enfeitiçado. Visão no Escuro 18 m; Percepção passiva 10. Silvestre + idiomas que você fala.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-feerico-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-feerico-alegre', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Lâmina Feérica = metade do círculo (arredondado para baixo).', 1),
  ('espirito-feerico-alegre', 'Lâmina Feérica', 'action'::rpg.actor_action_bucket, NULL, '2d6+3',
   'Ataque corpo a corpo: bônus = ataque mágico, alcance 1,5 m. Dano: 2d6+3 + círculo (Energético).', 2),
  ('espirito-feerico-alegre', 'Passo Feérico', 'bonus'::rpg.actor_action_bucket, NULL, NULL,
   'Teleporta até 9 m. Alegre: Salvaguarda de Sabedoria (CD da magia) em criatura a 3 m — Falha: Enfeitiçado por 1 minuto ou até sofrer dano.', 3),
  ('espirito-feerico-enfurecido', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Lâmina Feérica = metade do círculo (arredondado para baixo).', 1),
  ('espirito-feerico-enfurecido', 'Lâmina Feérica', 'action'::rpg.actor_action_bucket, NULL, '2d6+3',
   'Ataque corpo a corpo: bônus = ataque mágico, alcance 1,5 m. Dano: 2d6+3 + círculo (Energético).', 2),
  ('espirito-feerico-enfurecido', 'Passo Feérico', 'bonus'::rpg.actor_action_bucket, NULL, NULL,
   'Teleporta até 9 m. Enfurecido: Vantagem na próxima jogada de ataque neste turno.', 3),
  ('espirito-feerico-malandro', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Lâmina Feérica = metade do círculo (arredondado para baixo).', 1),
  ('espirito-feerico-malandro', 'Lâmina Feérica', 'action'::rpg.actor_action_bucket, NULL, '2d6+3',
   'Ataque corpo a corpo: bônus = ataque mágico, alcance 1,5 m. Dano: 2d6+3 + círculo (Energético).', 2),
  ('espirito-feerico-malandro', 'Passo Feérico', 'bonus'::rpg.actor_action_bucket, NULL, NULL,
   'Teleporta até 9 m. Malandro: Cubo de 3 m de Escuridão mágica até o fim do próximo turno dele.', 3);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-feerico', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-feerico';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-feerico', 'alegre', 'espirito-feerico-alegre', 'Alegre'),
  ('invocar-feerico', 'enfurecido', 'espirito-feerico-enfurecido', 'Enfurecido'),
  ('invocar-feerico', 'malandro', 'espirito-feerico-malandro', 'Malandro');

-- ─── Elemental (Invocar Elemental) ──────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-elemental-ar', 'phb-2024-pt', 'Espírito Elemental (Ar)',
  'Elemental Médio, Neutro', 'Neutro', 'Elemental', 'medium', NULL, NULL, 15, 50,
  '50 + 10 × (círculo − 4)', 2,
  '{"forca":18,"destreza":15,"constituicao":17,"inteligencia":4,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-elemental-terra', 'phb-2024-pt', 'Espírito Elemental (Terra)',
  'Elemental Médio, Neutro', 'Neutro', 'Elemental', 'medium', NULL, NULL, 15, 50,
  '50 + 10 × (círculo − 4)', 2,
  '{"forca":18,"destreza":15,"constituicao":17,"inteligencia":4,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-elemental-fogo', 'phb-2024-pt', 'Espírito Elemental (Fogo)',
  'Elemental Médio, Neutro', 'Neutro', 'Elemental', 'medium', NULL, NULL, 15, 50,
  '50 + 10 × (círculo − 4)', 2,
  '{"forca":18,"destreza":15,"constituicao":17,"inteligencia":4,"sabedoria":10,"carisma":16}'::jsonb
),
(
  'espirito-elemental-agua', 'phb-2024-pt', 'Espírito Elemental (Água)',
  'Elemental Médio, Neutro', 'Neutro', 'Elemental', 'medium', NULL, NULL, 15, 50,
  '50 + 10 × (círculo − 4)', 2,
  '{"forca":18,"destreza":15,"constituicao":17,"inteligencia":4,"sabedoria":10,"carisma":16}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-elemental-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-elemental-ar', 'walk', 40),
  ('espirito-elemental-ar', 'fly', 40),
  ('espirito-elemental-terra', 'walk', 40),
  ('espirito-elemental-terra', 'burrow', 40),
  ('espirito-elemental-fogo', 'walk', 40),
  ('espirito-elemental-agua', 'walk', 40),
  ('espirito-elemental-agua', 'swim', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-elemental-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-elemental-ar', 'Estado Amorfo', 'Move-se por espaço de 2,5 cm sem terreno difícil. Resistências: Elétrico e Trovejante.', 0),
  ('espirito-elemental-terra', 'Resistências', 'Cortante e Perfurante. Imunidades: Venenoso; Envenenado, Exaustão, Paralisado, Petrificado.', 0),
  ('espirito-elemental-fogo', 'Estado Amorfo', 'Move-se por espaço de 2,5 cm sem terreno difícil. Imunidade Ígneo.', 0),
  ('espirito-elemental-agua', 'Estado Amorfo', 'Move-se por espaço de 2,5 cm sem terreno difícil. Resistência Ácido.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-elemental-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-elemental-ar', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Pancada = metade do círculo (arredondado para baixo).', 1),
  ('espirito-elemental-ar', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d10+4',
   'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d10+4 + círculo (Elétrico).', 2),
  ('espirito-elemental-terra', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Pancada = metade do círculo (arredondado para baixo).', 1),
  ('espirito-elemental-terra', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d10+4',
   'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d10+4 + círculo (Contundente).', 2),
  ('espirito-elemental-fogo', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Pancada = metade do círculo (arredondado para baixo).', 1),
  ('espirito-elemental-fogo', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d10+4',
   'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d10+4 + círculo (Ígneo).', 2),
  ('espirito-elemental-agua', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de Pancada = metade do círculo (arredondado para baixo).', 1),
  ('espirito-elemental-agua', 'Pancada', 'action'::rpg.actor_action_bucket, NULL, '1d10+4',
   'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d10+4 + círculo (Gélido).', 2);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-elemental', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-elemental';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-elemental', 'ar', 'espirito-elemental-ar', 'Ar'),
  ('invocar-elemental', 'terra', 'espirito-elemental-terra', 'Terra'),
  ('invocar-elemental', 'fogo', 'espirito-elemental-fogo', 'Fogo'),
  ('invocar-elemental', 'agua', 'espirito-elemental-agua', 'Água');

-- ─── Celestial (Invocar Celestial) ──────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'espirito-celestial-defensor', 'phb-2024-pt', 'Espírito Celestial (Defensor)',
  'Celestial Grande, Neutro', 'Neutro', 'Celestial', 'large', NULL, NULL, 18, 40,
  '40 + 10 × (círculo − 5); CA 11 + círculo + 2', 2,
  '{"forca":16,"destreza":14,"constituicao":16,"inteligencia":10,"sabedoria":14,"carisma":16}'::jsonb
),
(
  'espirito-celestial-vingador', 'phb-2024-pt', 'Espírito Celestial (Vingador)',
  'Celestial Grande, Neutro', 'Neutro', 'Celestial', 'large', NULL, NULL, 16, 40,
  '40 + 10 × (círculo − 5); CA 11 + círculo', 2,
  '{"forca":16,"destreza":14,"constituicao":16,"inteligencia":10,"sabedoria":14,"carisma":16}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug LIKE 'espirito-celestial-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('espirito-celestial-defensor', 'walk', 30),
  ('espirito-celestial-defensor', 'fly', 40),
  ('espirito-celestial-vingador', 'walk', 30),
  ('espirito-celestial-vingador', 'fly', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug LIKE 'espirito-celestial-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('espirito-celestial-defensor', 'Resistências / Imunidades',
   'Resistência Radiante. Imune a Amedrontado e Enfeitiçado. Visão no Escuro 18 m; Percepção passiva 12. Celestial + idiomas que você fala.', 0),
  ('espirito-celestial-vingador', 'Resistências / Imunidades',
   'Resistência Radiante. Imune a Amedrontado e Enfeitiçado. Visão no Escuro 18 m; Percepção passiva 12. Celestial + idiomas que você fala.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug LIKE 'espirito-celestial-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('espirito-celestial-defensor', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de ataques = metade do círculo (arredondado para baixo).', 1),
  ('espirito-celestial-defensor', 'Maça Radiante', 'action'::rpg.actor_action_bucket, NULL, '1d10+3',
   'Ataque corpo a corpo: bônus = ataque mágico. Dano: 1d10+3 + círculo (Radiante); concede 1d10 PV temporários a si ou aliado a 3 m do alvo.', 2),
  ('espirito-celestial-defensor', 'Toque Curativo', 'action'::rpg.actor_action_bucket, NULL, '2d8',
   '1/Dia. Toca outra criatura: recupera 2d8 + círculo PV.', 3),
  ('espirito-celestial-vingador', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL,
   'Número de ataques = metade do círculo (arredondado para baixo).', 1),
  ('espirito-celestial-vingador', 'Arco Radiante', 'action'::rpg.actor_action_bucket, NULL, '2d6+2',
   'Ataque à distância: bônus = ataque mágico, alcance 180 m. Dano: 2d6+2 + círculo (Radiante).', 2),
  ('espirito-celestial-vingador', 'Toque Curativo', 'action'::rpg.actor_action_bucket, NULL, '2d8',
   '1/Dia. Toca outra criatura: recupera 2d8 + círculo PV.', 3);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('invocar-celestial', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'invocar-celestial';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('invocar-celestial', 'defensor', 'espirito-celestial-defensor', 'Defensor'),
  ('invocar-celestial', 'vingador', 'espirito-celestial-vingador', 'Vingador');

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('espirito-bestial-ar', 2, 11, 1, 20, 5, 'above_min'),
  ('espirito-bestial-terra', 2, 11, 1, 30, 5, 'above_min'),
  ('espirito-bestial-agua', 2, 11, 1, 30, 5, 'above_min'),
  ('espirito-feerico-alegre', 3, 12, 1, 30, 10, 'above_min'),
  ('espirito-feerico-enfurecido', 3, 12, 1, 30, 10, 'above_min'),
  ('espirito-feerico-malandro', 3, 12, 1, 30, 10, 'above_min'),
  ('espirito-elemental-ar', 4, 11, 1, 50, 10, 'above_min'),
  ('espirito-elemental-terra', 4, 11, 1, 50, 10, 'above_min'),
  ('espirito-elemental-fogo', 4, 11, 1, 50, 10, 'above_min'),
  ('espirito-elemental-agua', 4, 11, 1, 50, 10, 'above_min'),
  ('espirito-celestial-defensor', 5, 13, 1, 40, 10, 'above_min'),
  ('espirito-celestial-vingador', 5, 11, 1, 40, 10, 'above_min')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;
