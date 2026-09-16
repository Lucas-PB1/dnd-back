-- Montaria Fantasmagórica (ritual 3º): Cavalo de Montaria com deslocamento 30 m;
-- some se sofrer dano. Spawn via phb_spell_spirit no cast.

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'montaria-fantasmagorica', 'phb-2024-pt',
  'Montaria Fantasmagórica', 'Grande Fera (ilusão), Neutro', 'Neutro',
  'Fera', 'large', '1/4', 2, 10, 13, '2d10+2', 0,
  '{"forca":16,"destreza":10,"constituicao":12,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type,
  size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating,
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class,
  hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES ('montaria-fantasmagorica', 3, 10, 0, 13, 0, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'montaria-fantasmagorica';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft)
VALUES ('montaria-fantasmagorica', 'walk', 100);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'montaria-fantasmagorica';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('montaria-fantasmagorica', 'Ilusão quase real',
   'Usa o bloco de Cavalo de Montaria, com Deslocamento de 30 m (20 km/h). Equipamento criado some a mais de 3 m. Quando a magia termina, o cavaleiro tem 1 minuto para desmontar.', 0),
  ('montaria-fantasmagorica', 'Dissipar no dano',
   'A magia se encerra se a montaria sofrer qualquer dano (despawn na ficha).', 1),
  ('montaria-fantasmagorica', 'Sentidos', 'Percepção passiva 10.', 2);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'montaria-fantasmagorica';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES (
  'montaria-fantasmagorica', 'Cascos', 'action'::rpg.actor_action_bucket, 5, '2d4+3',
  'Ataque corpo a corpo: +5, alcance 1,5 m., um alvo. Acerto: 8 (2d4 + 3) de dano de Concussão.', 1
);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('montaria-fantasmagorica', 'mount', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'montaria-fantasmagorica';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('montaria-fantasmagorica', 'padrao', 'montaria-fantasmagorica', 'Montaria Fantasmagórica');
