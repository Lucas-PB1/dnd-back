-- PHB 2024 — montarias animais (Cap. 6 + Apêndice B)
-- Slug do template = slug do item em S031 (spawn via itemSlug na ficha)
-- Fonte: docs/source/extracts/phb/cap6-mounts.json + SRD 5.2.1 (CC-BY)
-- Gerado por scripts/gen-phb-mount-seeds.mjs

-- Camelo (camelo)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'camelo',
  'phb-2024-pt',
  'Camelo',
  'Grande Fera, Neutro',
  'Neutro',
  'Fera',
  'large',
  '1/8',
  2,
  9,
  15,
  '2d10+4',
  -1,
  '{"forca":16,"destreza":8,"constituicao":14,"inteligencia":2,"sabedoria":8,"carisma":5}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'camelo';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('camelo', 'walk', 50);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'camelo';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('camelo', 'Capacidade de carga', '225 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('camelo', 'Sentidos', 'Percepção passiva 9', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'camelo';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('camelo', 'Mordida', 'action'::rpg.actor_action_bucket, 5, '1d4+0', 'Ataque corpo a corpo: +5, alcance 1,5 m., um alvo. Acerto: 2 (1d4) de dano de Concussão.', 1);

-- Elefante (elefante)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'elefante',
  'phb-2024-pt',
  'Elefante',
  'Enorme Fera, Neutro',
  'Neutro',
  'Fera',
  'huge',
  '4',
  2,
  12,
  76,
  '8d12+24',
  -1,
  '{"forca":22,"destreza":9,"constituicao":17,"inteligencia":3,"sabedoria":11,"carisma":6}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'elefante';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('elefante', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'elefante';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('elefante', 'Capacidade de carga', '660 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('elefante', 'Sentidos', 'Percepção passiva 10', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'elefante';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('elefante', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O elefante realiza dois ataques de Chifrar.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('elefante', 'Chifrar', 'action'::rpg.actor_action_bucket, 8, '15 (2d8+6)', 'Ataque corpo a corpo: +8, alcance 1,5 m. Acerto: 15 (2d8 + 6) de dano Perfurante. Se o elefante se moveu pelo menos 6 m em linha reta em direção ao alvo imediatamente antes do acerto, o alvo também fica Caído.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('elefante', 'Atropelar', 'bonus'::rpg.actor_action_bucket, NULL, '17 (2d10+6)', 'Teste de resistência de Destreza: CD 16, uma criatura a até 1,5 m que esteja Caída. Falha: 17 (2d10 + 6) de dano de Concussão. Sucesso: metade do dano.', 3);

-- Cavalo de Carga (cavalo-de-carga)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'cavalo-de-carga',
  'phb-2024-pt',
  'Cavalo de Carga',
  'Grande Fera, Neutro',
  'Neutro',
  'Fera',
  'large',
  '1/4',
  2,
  10,
  19,
  '3d10+3',
  0,
  '{"forca":18,"destreza":10,"constituicao":12,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'cavalo-de-carga';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('cavalo-de-carga', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'cavalo-de-carga';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('cavalo-de-carga', 'Capacidade de carga', '270 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('cavalo-de-carga', 'Sentidos', 'Percepção passiva 10', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'cavalo-de-carga';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('cavalo-de-carga', 'Cascos', 'action'::rpg.actor_action_bucket, 6, '2d4+4', 'Ataque corpo a corpo: +6, alcance 1,5 m., um alvo. Acerto: 9 (2d4 + 4) de dano de Concussão.', 1);

-- Cavalo de Montaria (cavalo-de-montaria)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'cavalo-de-montaria',
  'phb-2024-pt',
  'Cavalo de Montaria',
  'Grande Fera, Neutro',
  'Neutro',
  'Fera',
  'large',
  '1/4',
  2,
  10,
  13,
  '2d10+2',
  0,
  '{"forca":16,"destreza":10,"constituicao":12,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'cavalo-de-montaria';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('cavalo-de-montaria', 'walk', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'cavalo-de-montaria';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('cavalo-de-montaria', 'Capacidade de carga', '240 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('cavalo-de-montaria', 'Sentidos', 'Percepção passiva 10', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'cavalo-de-montaria';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('cavalo-de-montaria', 'Cascos', 'action'::rpg.actor_action_bucket, 5, '2d4+3', 'Ataque corpo a corpo: +5, alcance 1,5 m., um alvo. Acerto: 8 (2d4 + 3) de dano de Concussão.', 1);

-- Mastim (mastim)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'mastim',
  'phb-2024-pt',
  'Mastim',
  'Médio Fera, Neutro',
  'Neutro',
  'Fera',
  'medium',
  '1/8',
  2,
  12,
  5,
  '1d8+1',
  2,
  '{"forca":13,"destreza":14,"constituicao":12,"inteligencia":3,"sabedoria":12,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'mastim';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('mastim', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'mastim';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mastim', 'Capacidade de carga', '97.5 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mastim', 'Audição e Faro Aguçados', 'O mastim tem vantagem em testes de Sabedoria (Percepção) que dependam de audição ou olfato.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mastim', 'Perícias', 'Percepção +3', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mastim', 'Sentidos', 'Percepção passiva 13', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'mastim';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('mastim', 'Mordida', 'action'::rpg.actor_action_bucket, 3, '1d6+1', 'Ataque corpo a corpo: +3, alcance 1,5 m., um alvo. Acerto: 4 (1d6 + 1) de dano Perfurante. Se o alvo for uma criatura, deve passar em um teste de resistência de Força CD 11 ou ficar Caído.', 1);

-- Mula (mula)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'mula',
  'phb-2024-pt',
  'Mula',
  'Médio Fera, Neutro',
  'Neutro',
  'Fera',
  'medium',
  '1/8',
  2,
  10,
  11,
  '2d8+2',
  0,
  '{"forca":14,"destreza":10,"constituicao":13,"inteligencia":2,"sabedoria":10,"carisma":5}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'mula';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('mula', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'mula';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mula', 'Capacidade de carga', '210 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mula', 'Animal de Carga', 'A mula conta como uma categoria de tamanho maior para determinar sua capacidade de carga.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mula', 'Pé Firme', 'A mula tem vantagem em testes de resistência de Força e Destreza contra efeitos que a derrubariam.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('mula', 'Sentidos', 'Percepção passiva 10', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'mula';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('mula', 'Cascos', 'action'::rpg.actor_action_bucket, 4, '1d4+2', 'Ataque corpo a corpo: +2, alcance 1,5 m., um alvo. Acerto: 4 (1d4 + 2) de dano de Concussão.', 1);

-- Pônei (ponei)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'ponei',
  'phb-2024-pt',
  'Pônei',
  'Médio Fera, Neutro',
  'Neutro',
  'Fera',
  'medium',
  '1/8',
  2,
  10,
  11,
  '2d8+2',
  0,
  '{"forca":15,"destreza":10,"constituicao":13,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'ponei';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('ponei', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'ponei';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('ponei', 'Capacidade de carga', '112.5 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('ponei', 'Sentidos', 'Percepção passiva 10', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'ponei';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('ponei', 'Cascos', 'action'::rpg.actor_action_bucket, 4, '2d4+2', 'Ataque corpo a corpo: +4, alcance 1,5 m., um alvo. Acerto: 7 (2d4 + 2) de dano de Concussão.', 1);

-- Cavalo de Guerra (cavalo-de-guerra)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'cavalo-de-guerra',
  'phb-2024-pt',
  'Cavalo de Guerra',
  'Grande Fera, Neutro',
  'Neutro',
  'Fera',
  'large',
  '1/2',
  2,
  11,
  19,
  '3d10+3',
  1,
  '{"forca":18,"destreza":12,"constituicao":13,"inteligencia":2,"sabedoria":12,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'cavalo-de-guerra';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('cavalo-de-guerra', 'walk', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'cavalo-de-guerra';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('cavalo-de-guerra', 'Capacidade de carga', '270 kg', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('cavalo-de-guerra', 'Sentidos', 'Percepção passiva 11', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'cavalo-de-guerra';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('cavalo-de-guerra', 'Cascos', 'action'::rpg.actor_action_bucket, 6, '9 (2d4+4)', 'Ataque corpo a corpo: +6, alcance 1,5 m. Acerto: 9 (2d4 + 4) de dano de Concussão. Se o cavalo se moveu pelo menos 6 m em linha reta em direção ao alvo imediatamente antes do acerto, o alvo sofre 5 (2d4) de dano de Concussão extra e, se for Enorme ou menor, fica Caído.', 1);
