-- Companheiro Primal (Beast Master) — Terra / Mar / Céu (PHB 2024)
-- HP/AC de combate: companion_hp_* + companion_ac_ability_slug (aplicados no sync).
-- hit_points_avg / armor_class = piso de nível 1 (Wis 10) para spawn genérico.

-- Terra
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores,
  companion_hp_base, companion_hp_per_level, companion_ac_ability_slug
) VALUES (
  'primal-companion-earth',
  'phb-2024-pt',
  'Companheiro Primal (Terra)',
  'Média Fera, Neutro',
  'Neutro',
  'Beast',
  'medium',
  NULL,
  2,
  13,
  10,
  '5 + 5 × nível do patrulheiro',
  2,
  '{"forca":14,"destreza":14,"constituicao":15,"inteligencia":8,"sabedoria":14,"carisma":11}'::jsonb,
  5,
  5,
  'sabedoria'
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type,
  size_slug = EXCLUDED.size_slug,
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class,
  hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores,
  companion_hp_base = EXCLUDED.companion_hp_base,
  companion_hp_per_level = EXCLUDED.companion_hp_per_level,
  companion_ac_ability_slug = EXCLUDED.companion_ac_ability_slug;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'primal-companion-earth';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('primal-companion-earth', 'walk', 40),
  ('primal-companion-earth', 'climb', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'primal-companion-earth';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('primal-companion-earth', 'Vínculo Primal', 'Some o Bônus de Proficiência do patrulheiro a testes de habilidade e salvaguardas da fera.', 0),
  ('primal-companion-earth', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 12. Compreende os idiomas que você conhece.', 1);

DELETE FROM rpg.phb_creature_template_action
WHERE template_slug = 'primal-companion-earth' AND name IN ('Golpe da Fera', 'Golpe da Besta');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES (
  'primal-companion-earth',
  'Golpe da Besta',
  'action'::rpg.actor_action_bucket,
  NULL,
  '1d8+2',
  'Ataque corpo a corpo: bônus = modificador de ataque de magia do patrulheiro, alcance 1,5 m. Acerto: 1d8+2 + modificador de Sabedoria (concussão, perfurante ou cortante). Se a fera se moveu 6 m em linha reta até o alvo antes do acerto, +1d6 do mesmo tipo e o alvo (Grande ou menor) fica Caído.',
  1
);

-- Céu
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores,
  companion_hp_base, companion_hp_per_level, companion_ac_ability_slug
) VALUES (
  'primal-companion-sky',
  'phb-2024-pt',
  'Companheiro Primal (Céu)',
  'Pequena Fera, Neutro',
  'Neutro',
  'Beast',
  'small',
  NULL,
  2,
  13,
  8,
  '4 + 4 × nível do patrulheiro',
  3,
  '{"forca":6,"destreza":16,"constituicao":13,"inteligencia":8,"sabedoria":14,"carisma":11}'::jsonb,
  4,
  4,
  'sabedoria'
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type,
  size_slug = EXCLUDED.size_slug,
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class,
  hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores,
  companion_hp_base = EXCLUDED.companion_hp_base,
  companion_hp_per_level = EXCLUDED.companion_hp_per_level,
  companion_ac_ability_slug = EXCLUDED.companion_ac_ability_slug;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'primal-companion-sky';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('primal-companion-sky', 'walk', 10),
  ('primal-companion-sky', 'fly', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'primal-companion-sky';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('primal-companion-sky', 'Voo de Passagem', 'A fera não provoca Ataques de Oportunidade ao voar para fora do alcance de um inimigo.', 0),
  ('primal-companion-sky', 'Vínculo Primal', 'Some o Bônus de Proficiência do patrulheiro a testes de habilidade e salvaguardas da fera.', 1),
  ('primal-companion-sky', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 12. Compreende os idiomas que você conhece.', 2);

DELETE FROM rpg.phb_creature_template_action
WHERE template_slug = 'primal-companion-sky' AND name IN ('Golpe da Fera', 'Golpe da Besta');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES (
  'primal-companion-sky',
  'Golpe da Besta',
  'action'::rpg.actor_action_bucket,
  NULL,
  '1d4+3',
  'Ataque corpo a corpo: bônus = modificador de ataque de magia do patrulheiro, alcance 1,5 m. Acerto: 1d4+3 + modificador de Sabedoria (cortante).',
  1
);

-- Mar
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores,
  companion_hp_base, companion_hp_per_level, companion_ac_ability_slug
) VALUES (
  'primal-companion-sea',
  'phb-2024-pt',
  'Companheiro Primal (Mar)',
  'Média Fera, Neutro',
  'Neutro',
  'Beast',
  'medium',
  NULL,
  2,
  13,
  10,
  '5 + 5 × nível do patrulheiro',
  2,
  '{"forca":14,"destreza":14,"constituicao":15,"inteligencia":8,"sabedoria":14,"carisma":11}'::jsonb,
  5,
  5,
  'sabedoria'
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type,
  size_slug = EXCLUDED.size_slug,
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class,
  hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores,
  companion_hp_base = EXCLUDED.companion_hp_base,
  companion_hp_per_level = EXCLUDED.companion_hp_per_level,
  companion_ac_ability_slug = EXCLUDED.companion_ac_ability_slug;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'primal-companion-sea';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('primal-companion-sea', 'walk', 5),
  ('primal-companion-sea', 'swim', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'primal-companion-sea';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('primal-companion-sea', 'Anfíbio', 'A fera pode respirar ar e água.', 0),
  ('primal-companion-sea', 'Vínculo Primal', 'Some o Bônus de Proficiência do patrulheiro a testes de habilidade e salvaguardas da fera.', 1),
  ('primal-companion-sea', 'Sentidos', 'Visão no escuro 27 m; Percepção passiva 12. Compreende os idiomas que você conhece.', 2);

DELETE FROM rpg.phb_creature_template_action
WHERE template_slug = 'primal-companion-sea' AND name IN ('Golpe da Fera', 'Golpe da Besta');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES (
  'primal-companion-sea',
  'Golpe da Besta',
  'action'::rpg.actor_action_bucket,
  NULL,
  '1d6+2',
  'Ataque corpo a corpo: bônus = modificador de ataque de magia do patrulheiro, alcance 1,5 m. Acerto: 1d6+2 + modificador de Sabedoria (concussão ou perfurante); o alvo fica Agarrado (CD = CD de magia do patrulheiro).',
  1
);
