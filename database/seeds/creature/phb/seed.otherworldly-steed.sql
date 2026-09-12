-- Montaria Sobrenatural (Convocar Montaria / Find Steed) — 3 variantes tipadas.
-- Escala: phb_creature_scale_by_slot (AC = 10+L; HP = 5+10×L). Fly gate no sync se slot < 4.

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'montaria-sobrenatural-celestial', 'phb-2024-pt',
  'Montaria Sobrenatural (Celestial)', 'Grande Celestial, Neutro', 'Neutro',
  'Celestial', 'large', NULL, NULL, 12, 25,
  '5 + 10 × círculo do slot', 1,
  '{"forca":18,"destreza":12,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb
),
(
  'montaria-sobrenatural-feerico', 'phb-2024-pt',
  'Montaria Sobrenatural (Feérico)', 'Grande Feérico, Neutro', 'Neutro',
  'Fey', 'large', NULL, NULL, 12, 25,
  '5 + 10 × círculo do slot', 1,
  '{"forca":18,"destreza":12,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb
),
(
  'montaria-sobrenatural-infero', 'phb-2024-pt',
  'Montaria Sobrenatural (Ínfero)', 'Grande Ínfero, Neutro', 'Neutro',
  'Fiend', 'large', NULL, NULL, 12, 25,
  '5 + 10 × círculo do slot', 1,
  '{"forca":18,"destreza":12,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type,
  size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class,
  hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('montaria-sobrenatural-celestial', 2, 10, 1, 5, 10, 'per_slot'),
  ('montaria-sobrenatural-feerico', 2, 10, 1, 5, 10, 'per_slot'),
  ('montaria-sobrenatural-infero', 2, 10, 1, 5, 10, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;

DELETE FROM rpg.phb_creature_template_speed
WHERE template_slug LIKE 'montaria-sobrenatural-%';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('montaria-sobrenatural-celestial', 'walk', 60),
  ('montaria-sobrenatural-celestial', 'fly', 60),
  ('montaria-sobrenatural-feerico', 'walk', 60),
  ('montaria-sobrenatural-feerico', 'fly', 60),
  ('montaria-sobrenatural-infero', 'walk', 60),
  ('montaria-sobrenatural-infero', 'fly', 60);

DELETE FROM rpg.phb_creature_template_trait
WHERE template_slug LIKE 'montaria-sobrenatural-%';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('montaria-sobrenatural-celestial', 'Vínculo Vital',
   'Ao recuperar PV de uma magia de 1º círculo ou superior, a montaria recupera o mesmo número se você estiver a até 1,5 m dela.', 0),
  ('montaria-sobrenatural-celestial', 'Sentidos', 'Percepção passiva 11. Telepatia 1,5 km (apenas com você).', 1),
  ('montaria-sobrenatural-feerico', 'Vínculo Vital',
   'Ao recuperar PV de uma magia de 1º círculo ou superior, a montaria recupera o mesmo número se você estiver a até 1,5 m dela.', 0),
  ('montaria-sobrenatural-feerico', 'Sentidos', 'Percepção passiva 11. Telepatia 1,5 km (apenas com você).', 1),
  ('montaria-sobrenatural-infero', 'Vínculo Vital',
   'Ao recuperar PV de uma magia de 1º círculo ou superior, a montaria recupera o mesmo número se você estiver a até 1,5 m dela.', 0),
  ('montaria-sobrenatural-infero', 'Sentidos', 'Percepção passiva 11. Telepatia 1,5 km (apenas com você).', 1);

DELETE FROM rpg.phb_creature_template_action
WHERE template_slug LIKE 'montaria-sobrenatural-%';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
(
  'montaria-sobrenatural-celestial', 'Pancada Sobrenatural', 'action'::rpg.actor_action_bucket, NULL, '1d8',
  'Ataque corpo a corpo: bônus = modificador de ataque mágico, alcance 1,5 m. Dano: 1d8 + círculo do slot (Radiante).', 1
),
(
  'montaria-sobrenatural-celestial', 'Toque Curativo', 'bonus'::rpg.actor_action_bucket, NULL, '2d8',
  '1/Descanso Longo. Uma criatura a até 1,5 m recupera 2d8 + círculo do slot PV.', 2
),
(
  'montaria-sobrenatural-feerico', 'Pancada Sobrenatural', 'action'::rpg.actor_action_bucket, NULL, '1d8',
  'Ataque corpo a corpo: bônus = modificador de ataque mágico, alcance 1,5 m. Dano: 1d8 + círculo do slot (Psíquico).', 1
),
(
  'montaria-sobrenatural-feerico', 'Passo Feérico', 'bonus'::rpg.actor_action_bucket, NULL, NULL,
  '1/Descanso Longo. A montaria se teleporta, com o cavaleiro, até 18 m para um espaço desocupado.', 2
),
(
  'montaria-sobrenatural-infero', 'Pancada Sobrenatural', 'action'::rpg.actor_action_bucket, NULL, '1d8',
  'Ataque corpo a corpo: bônus = modificador de ataque mágico, alcance 1,5 m. Dano: 1d8 + círculo do slot (Necrótico).', 1
),
(
  'montaria-sobrenatural-infero', 'Derrubar Brilho', 'bonus'::rpg.actor_action_bucket, NULL, NULL,
  '1/Descanso Longo. Salvaguarda de Sabedoria (CD da magia), uma criatura a até 18 m à vista. Falha: Amedrontado até o fim do seu próximo turno.', 2
);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('convocar-montaria', 'mount', 'replace_same_spell', 4)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'convocar-montaria';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('convocar-montaria', 'celestial', 'montaria-sobrenatural-celestial', 'Celestial'),
  ('convocar-montaria', 'feerico', 'montaria-sobrenatural-feerico', 'Feérico'),
  ('convocar-montaria', 'infero', 'montaria-sobrenatural-infero', 'Ínfero');
