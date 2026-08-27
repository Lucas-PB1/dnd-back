-- Northlands Worldbook — bestiário (Cap. 8)
-- Gerado por scripts/gen-northlands-stat-block-seeds.mjs

-- Avatar Leviatã (leviathan-avatar)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'leviathan-avatar',
  'northlands-heroes-2024-en',
  'Avatar Leviatã',
  'Enorme Monstruosidade, Neutro',
  'Neutro',
  'Monstruosidade',
  'huge',
  NULL,
  NULL,
  13,
  70,
  '70 + 10 por círculo acima de 7º',
  NULL,
  '{"forca":20,"destreza":10,"constituicao":18,"inteligencia":6,"sabedoria":14,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'leviathan-avatar';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('leviathan-avatar', 'swim', 50);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('leviathan-avatar', 'walk', 10);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'leviathan-avatar';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('leviathan-avatar', 'Pontos de Vida', '70 + 10 por círculo do espaço de magia acima de 7º', -1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('leviathan-avatar', 'Classe de Armadura', 'CA 13 + o nível da magia', -2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('leviathan-avatar', 'Imunidades', 'Charmed , exausto , amedrontado , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('leviathan-avatar', 'Anfíbio', 'O espírito pode respirar ar e água.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('leviathan-avatar', 'Sentidos', 'Visão no escuro 18 m, Percepção passiva 12', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('leviathan-avatar', 'Idiomas', 'Entende os idiomas que você conhece', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'leviathan-avatar';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('leviathan-avatar', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O espírito realiza um número de ataques de Dilacerar igual à metade do nível desta magia (arredondado para baixo).', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('leviathan-avatar', 'Dilacerar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de ataque corpo a corpo: bônus igual ao seu modificador de ataque de magia, alcance 3 m. Acerto: 1d10 + 5 + o nível da magia de dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('leviathan-avatar', 'Rugido', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD igual à sua CD de resistência a magia, cada criatura em um cone de 9 metros. Falha: o alvo fica amedrontado até o início do seu próximo turno. Sucesso: sem efeito.', 3);

-- Brunnmigi (brunnmigi)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'brunnmigi',
  'northlands-heroes-2024-en',
  'Brunnmigi',
  'Grande Monstruosidade, Caótico e Mau',
  'Caótico e Mau',
  'Monstruosidade',
  'large',
  '1',
  2,
  12,
  22,
  '3d10 + 6',
  3,
  '{"forca":15,"destreza":8,"constituicao":14,"inteligencia":6,"sabedoria":10,"carisma":6}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'brunnmigi';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('brunnmigi', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'brunnmigi';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('brunnmigi', 'Imunidades', 'Poison; envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('brunnmigi', 'Perícias', 'Percepção +4, Furtividade +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('brunnmigi', 'Sentidos', 'Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('brunnmigi', 'Idiomas', 'Compreende Comum e a Língua do Norte, mas não pode falar', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'brunnmigi';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('brunnmigi', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O brunnmigi realiza dois ataques de Garra.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('brunnmigi', 'Garra', 'action'::rpg.actor_action_bucket, 4, '5 (1d6 + 2) dano Cortante mais 2 dano Venenoso', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 5 (1d6 + 2) dano Cortante mais 2 dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('brunnmigi', 'Cuspe Fétido', 'action'::rpg.actor_action_bucket, 4, '4 (1d4 + 2) dano Venenoso, e o alvo é submetido ao seguinte efeito', 'Teste de ataque à distância: +4, alcance 9 m Acerto: 4 (1d4 + 2) dano Venenoso, e o alvo é submetido ao seguinte efeito. Teste de resistência de Constituição: CD 11. Falha: o alvo fica envenenado. O alvo pode repetir o teste de resistência sempre que completar um Descanso Longo para encerrar esta condição.', 3);

-- Fafnir (fafnir)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'fafnir',
  'northlands-heroes-2024-en',
  'Fafnir',
  'Enorme Dragão, Neutro e Mau',
  'Neutro e Mau',
  'Dragão',
  'huge',
  '12',
  4,
  20,
  151,
  '14d12 + 60',
  6,
  '{"forca":22,"destreza":14,"constituicao":20,"inteligencia":10,"sabedoria":12,"carisma":8}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'fafnir';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fafnir', 'climb', 40);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fafnir', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'fafnir';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fafnir', 'Armadura da Ganância (3/dia)', 'Quando Fafnir é atingido por um ataque, pode fazer o ataque errar em vez disso. Se o ataque for um Crítico, deve gastar dois usos deste traço para fazê-lo errar. Cada vez que Fafnir usa esta habilidade, criaturas têm vantagem em testes de ataque contra ele até o fim do próximo turno dele.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fafnir', 'Aura de Avareza', 'Criaturas a até 1,6 km do covil de Fafnir têm desvantagem em testes de resistência contra magias e efeitos que as compelam a tomar ou roubar coisas, e sentem-se profundamente protetoras de seus próprios pertences e cobiçosas dos pertences alheios.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fafnir', 'Resistência Lendária (3/dia, ou 4/dia no Covil)', 'Se Fafnir falhar em um teste de resistência, pode escolher ter sucesso em vez disso.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fafnir', 'Perícias', 'Enganação +3, Percepção +5, Persuasão +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fafnir', 'Sentidos', 'Percepção às cegas 18 m, Visão no escuro 18 m; Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fafnir', 'Idiomas', 'Comum, Dracônico, Anão, Língua do Norte', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'fafnir';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O dragão realiza três ataques, usando Mordida ou Constritor em qualquer combinação.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Mordida', 'action'::rpg.actor_action_bucket, 10, '15 (2d8 + 6) dano Perfurante mais 11 (2d10) dano Venenoso', 'Teste de ataque corpo a corpo: +10, alcance 3 m Acerto: 15 (2d8 + 6) dano Perfurante mais 11 (2d10) dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Constritor', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 18, uma criatura Enorme ou menor que Fafnir possa ver a até 3 m dele. Falha: 14 (4d6) dano Contundente, e o alvo fica agarrado (CD para escapar 16) e fica impedido até o fim do agarrão. Fafnir só pode agarrar uma criatura por vez com esta habilidade.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Sopro do Infortúnio (Recarga 4–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 17, cada criatura em uma linha de 18 metros . Falha: 31 (7d8) dano Venenoso, e a criatura tem desvantagem em testes d20 até o fim de próximo turno do Fafnir. Sucesso: metade do dano apenas.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Usos de Ação Lendária', 'legendary'::rpg.actor_action_bucket, NULL, NULL, '3 (4 no Covil). Imediatamente após o turno de outra criatura, O dragão pode gastar um uso para realizar uma das ações a seguir. O dragão recupera todos os usos gastos no início de cada um de seus turnos.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Jato de Sangue Tóxico', 'legendary'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 17, cada criatura a até 6 m de Fafnir. Falha: 10 (4d4) dano Venenoso, e o alvo fica envenenado até o fim do próximo turno dele. Falha ou Sucesso: Fafnir não pode realizar esta ação novamente até o início do próximo turno dele. Fafnir só pode usar esta habilidade se estiver faltando pelo menos 1 PV.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Inflamar Avareza', 'legendary'::rpg.actor_action_bucket, NULL, NULL, 'Fafnir conjura Compel Avarice, sem exigir componentes materiais or Concentration e using Wisdom as a magia-casting ability (CD de resistência a magia 13). Fafnir cannot take this action again até o início de his próximo turno.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fafnir', 'Enredar', 'legendary'::rpg.actor_action_bucket, NULL, NULL, 'Fafnir se move até metade do deslocamento dele e realiza um ataque de Constritor.', 4);

-- Nidhogg-Blooded Drake (nidhogg-blooded-drake)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'nidhogg-blooded-drake',
  'northlands-heroes-2024-en',
  'Nidhogg-Blooded Drake',
  'Médio Dragão, Caótico e Mau',
  'Caótico e Mau',
  'Dragão',
  'medium',
  '4',
  2,
  14,
  51,
  '6d8 + 24',
  2,
  '{"forca":18,"destreza":12,"constituicao":18,"inteligencia":18,"sabedoria":11,"carisma":14}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'nidhogg-blooded-drake';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('nidhogg-blooded-drake', 'fly', 60);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('nidhogg-blooded-drake', 'burrow', 20);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('nidhogg-blooded-drake', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'nidhogg-blooded-drake';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Imunidades', 'Poison; envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Aprisionamento Antigo', 'Rage e terror at Nidhogg''s imprisonment by Wotan reverberates down o generations a até his brood. quando rolling testes de resistência contra efeitos that cause impedido or condição agarrado, as well as any that would entrap it, o draco filhote de Nidhogg tem desvantagem.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Perícias', 'Percepção +4, Intimidação +6', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Sentidos', 'Percepção às cegas 6 m, Visão no escuro 18 m; Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Idiomas', 'Comum, Língua do Norte, Dracônico', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'nidhogg-blooded-drake';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O drake realiza um ataque de Mordida e um de Garra.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Mordida', 'action'::rpg.actor_action_bucket, 6, '9 (1d10 + 4) dano Perfurante mais 4 (1d8) dano Venenoso, e o alvo fica envenenado até o início do próximo turno do drake', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 9 (1d10 + 4) dano Perfurante mais 4 (1d8) dano Venenoso, e o alvo fica envenenado até o início do próximo turno do drake.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Garra', 'action'::rpg.actor_action_bucket, 6, '8 (1d8 + 4) dano Cortante', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 8 (1d8 + 4) dano Cortante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Cuspe Venenoso (Recarga 4–6)', 'action'::rpg.actor_action_bucket, 4, '16 (4d6 + 2) dano Venenoso', 'Teste de ataque à distância: +4, alcance 9/18 m Acerto: 16 (4d6 + 2) dano Venenoso.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('nidhogg-blooded-drake', 'Serpente Terrestre', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O drake escava 6 m.', 1);

-- Eikthyrnir (eikthyrnir)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'eikthyrnir',
  'northlands-heroes-2024-en',
  'Eikthyrnir',
  'Enorme Corruptor, Neutro e Mau',
  'Neutro e Mau',
  'Corruptor',
  'huge',
  '5',
  3,
  14,
  126,
  '12d12 + 48',
  3,
  '{"forca":18,"destreza":17,"constituicao":18,"inteligencia":12,"sabedoria":14,"carisma":13}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'eikthyrnir';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('eikthyrnir', 'climb', 30);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('eikthyrnir', 'walk', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'eikthyrnir';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('eikthyrnir', 'Perícias', 'Percepção +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('eikthyrnir', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('eikthyrnir', 'Idiomas', 'Compreende Comum, Anão, Élfico e a Língua do Norte, mas não pode falar', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'eikthyrnir';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('eikthyrnir', 'Aríete', 'action'::rpg.actor_action_bucket, 7, '17 (2d12 + 4) dano Perfurante mais 5 (2d4) dano Necrótico', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 17 (2d12 + 4) dano Perfurante mais 5 (2d4) dano Necrótico. Se o alvo for Enorme ou menor, e o eikthyrnir se moveu 6+ metros em linha reta em direção a ele imediatamente antes do acerto, o alvo sofre adicional de 9 (2d8) dano Perfurante e fica caída.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('eikthyrnir', 'Espinhos Agarradores', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 15, uma criatura Grande ou menor a até 9 m é puxada para adjacente ao eikthyrnir e fica agarrada (CD para escapar 15). Enquanto agarrado, o alvo fica impedido.', 1);

-- Fenrikyn (fenrikyn)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'fenrikyn',
  'northlands-heroes-2024-en',
  'Fenrikyn',
  'Grande Monstruosidade, Neutro e Mau',
  'Neutro e Mau',
  'Monstruosidade',
  'large',
  '6',
  3,
  15,
  127,
  '15d10 + 45',
  5,
  '{"forca":21,"destreza":14,"constituicao":16,"inteligencia":7,"sabedoria":14,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'fenrikyn';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fenrikyn', 'walk', 50);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'fenrikyn';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fenrikyn', 'Imunidades', 'Cold; amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fenrikyn', 'Corrente Mística', 'O mystical chain attached to o fenrikyn is sua maior fraqueza e can be severed by an ataque dealing 20 dano Cortante contra CA 17, sem causar dano ao fenrikyn. If do fenrikyn chain is destroyed, sofre 18 (4d8) dano Psíquico e fica atordoado até o fim de seu próximo turno. Também perde sua corrente ataque action, Whirling Chain action, e Deflecting Chain Reação.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fenrikyn', 'Perícias', 'Percepção +8, Sobrevivência +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fenrikyn', 'Sentidos', 'Visão no escuro 27 m; Percepção passiva 18', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fenrikyn', 'Idiomas', 'compreende Abissal e Gigante but não pode falar', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'fenrikyn';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fenrikyn', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fenrikyn realiza um ataque de Mordida e um de Corrente. Se sua Corrente Mística foi quebrada, em vez disso realiza two ataques de Mordida.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fenrikyn', 'Mordida', 'action'::rpg.actor_action_bucket, 8, '14 (2d8 + 5) dano Perfurante', 'Teste de ataque corpo a corpo: +8, alcance 1,5 m Acerto: 14 (2d8 + 5) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fenrikyn', 'Corrente', 'action'::rpg.actor_action_bucket, 8, '12 (2d6 + 5) dano Contundente', 'Teste de ataque corpo a corpo: +8, alcance 6 m Acerto: 12 (2d6 + 5) dano Contundente. Se o alvo for uma criatura Média ou menor, fica agarrado (CD para escapar 16). Enquanto agarrado, o alvo não pode se afastar mais de 6 m do fenrikyn, e seu deslocamento é reduzido em 3 m.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fenrikyn', 'Corrente Giratória (Recarga 6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 16, todas as criaturas a até 6 m do fenrikyn. Falha: 21 (6d6) dano Contundente, e o alvo é empurrado ou puxado 3 m. Sucesso: metade do dano apenas.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fenrikyn', 'Corrente Defletora', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o fenrikyn é atingido por um ataque. Resposta: o fenrikyn adiciona 3 à CA contra aquele ataque, possivelmente fazendo errar.', 1);

-- Fleshcrawler (fleshcrawler)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'fleshcrawler',
  'northlands-heroes-2024-en',
  'Fleshcrawler',
  'Médio Aberração, Caótico e Mau',
  'Caótico e Mau',
  'Aberração',
  'medium',
  '7',
  3,
  16,
  119,
  '14d8 + 56',
  2,
  '{"forca":18,"destreza":14,"constituicao":18,"inteligencia":18,"sabedoria":14,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'fleshcrawler';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fleshcrawler', 'climb', 20);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fleshcrawler', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'fleshcrawler';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fleshcrawler', 'Imunidades', 'Cold; exausto , amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fleshcrawler', 'Perícias', 'Enganação +7, Furtividade +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fleshcrawler', 'Sentidos', 'Sentido sísmico 9 m, Percepção passiva 12', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fleshcrawler', 'Idiomas', 'Speaks e compreende all idiomas, Telepatia 36 m (can communicate only com other fleshcrawlers or infected criaturas)', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'fleshcrawler';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fleshcrawler', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fleshcrawler realiza dois ataques, usando Fleshwarp Strike e Necrotic Bolt em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fleshcrawler', 'Golpe de Deformação de Carne', 'action'::rpg.actor_action_bucket, 7, '13 (2d8 + 4) dano Necrótico e o alvo fica impedido por 1 minuto', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 13 (2d8 + 4) dano Necrótico e o alvo fica impedido por 1 minuto. No fim de cada um de seus turnos, o alvo impedido rola um teste de resistência de Constituição (CD 15) para encerrar esta condição.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fleshcrawler', 'Raio Necrótico', 'action'::rpg.actor_action_bucket, 5, '9 (2d6 + 2) dano Necrótico', 'Teste de ataque à distância: +5, alcance 9 m Acerto: 9 (2d6 + 2) dano Necrótico.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fleshcrawler', 'Teias de Carne (Recarga 5–6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 15, uma criatura que o fleshcrawler possa ver a até 18 m. Falha: O alvo fica impedido até a teia ser destruída (CA 15; PV 15; imunidade a dano Venenoso e Psíquico).', 1);

-- Fossegrim (fossegrim)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'fossegrim',
  'northlands-heroes-2024-en',
  'Fossegrim',
  'Pequeno Fada, Caótico e Neutro',
  'Caótico e Neutro',
  'Fada',
  'small',
  '5',
  3,
  16,
  82,
  '15d6 + 30',
  6,
  '{"forca":12,"destreza":17,"constituicao":14,"inteligencia":12,"sabedoria":15,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'fossegrim';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fossegrim', 'swim', 40);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fossegrim', 'walk', 20);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'fossegrim';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fossegrim', 'Imunidades', 'Charmed', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fossegrim', 'Anfíbio', 'O fossegrim pode respirar ar e água.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fossegrim', 'Resistência Mágica', 'O fossegrim tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fossegrim', 'Perícias', 'Enganação +7, Percepção +5, Performance +10', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fossegrim', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fossegrim', 'Idiomas', 'Comum, Élfico, Silvestre', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'fossegrim';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fossegrim realiza dois ataques de Acorde Discordante.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Acorde Discordante', 'action'::rpg.actor_action_bucket, 6, '10 (2d6 + 3) dano Trovejante', 'Ataque corpo a corpo ou teste de ataque à distância: +6, alcance 1,5 m or alcance 18 m. Acerto: 10 (2d6 + 3) dano Trovejante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Aparência Ilusória', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fossegrim conjura Disfarçar-se . It pode aparecer como um Humanoide Pequeno ou Médio.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Melodia Torrencial (2/dia)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fossegrim toca seu instrumento musical, invocando uma onda de água que desaba sobre seus inimigos. Teste de resistência de Destreza: CD 15, todas as criaturas em um cone de 6 metros . Falha: 14 (4d6) dano Contundente, e o alvo fica caída. Sucesso: metade do dano apenas.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fossegrim conjura uma das magias a seguir com seu instrumento musical, sem exigir componentes materiais e usando Carisma como atributo de conjuração (CD de resistência a magia 15):', 5);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Harmônicos Desconcertantes', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 15, uma criatura que o fossegrim possa ver a até 9 m. Falha: O alvo fica confuso até o fim do próximo turno dele. O alvo não pode realizar Reações e deve rolar 1d8 para determinar o que faz no próximo turno:', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Passo Ventríloquo', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O fossegrim teletransporta-se até 9 m para um espaço desocupado que possa ver.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fossegrim', 'Nota Cacofônica (Recarga 5–6)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura passa em um teste d20 a até 9 m do fossegrim. Resposta: o criatura deve rolar novamente e usa o novo resultado.', 1);

-- Garmr (garmr)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'garmr',
  'northlands-heroes-2024-en',
  'Garmr',
  'Grande Corruptor, Neutro e Mau',
  'Neutro e Mau',
  'Corruptor',
  'large',
  '4',
  2,
  14,
  85,
  '10d10 + 30',
  2,
  '{"forca":19,"destreza":14,"constituicao":16,"inteligencia":8,"sabedoria":16,"carisma":8}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'garmr';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('garmr', 'walk', 50);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'garmr';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('garmr', 'Imunidades', 'Necrotic, Poison; exausto , paralisado , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('garmr', 'Peles Larvadas', 'Uma criatura que ataca o garmr corpo a corpo estando adjacente a ele fica sujeita às larvas rastejando sobre seu pelo fétido. Teste de resistência de Destreza: CD 13. Falha: o alvo fica infestado de larvas, sofrendo 3 (1d6) de dano Necrótico no início de cada um de seus turnos. Um alvo infestado pode repetir o teste de resistência no fim de cada um de seus turnos para encerrar o efeito, e as larvas são queimadas se sofrer pelo menos 5 de dano Ácido ou de Fogo. Depois que a criatura passa na resistência ou as larvas são queimadas, ela fica imune a este traço por 1 hora.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('garmr', 'Táticas de Matilha', 'O garmr tem vantagem em um teste de ataque contra uma criatura if at least um dos aliados do garmr is a até 1,5 m de a criatura e o aliado não tem a condição incapacitado.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('garmr', 'Perícias', 'Percepção +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('garmr', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 17', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('garmr', 'Idiomas', 'Compreende Infernal, mas não pode falar; telepatia 18 m', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'garmr';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('garmr', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O garmr realiza dois ataques de Mordida.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('garmr', 'Mordida', 'action'::rpg.actor_action_bucket, 6, '11 (2d6 + 4) dano Perfurante mais 7 (2d6) dano Necrótico', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 11 (2d6 + 4) dano Perfurante mais 7 (2d6) dano Necrótico.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('garmr', 'Uivo Racha-Terra (Recarga 6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 13, cada criatura em um cone de 6 metros . Falha: 17 (5d6) dano Trovejante, e o alvo fica surdo por 1 minuto. Sucesso: metade do dano apenas. Objetos e estruturas desguarnecidos na área não fazem teste de resistência, sofrem dobro do dano, e o uivo ignora seu limiar de dano.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('garmr', 'Sacudida Podre (Recarga 5–6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'teste de resistência de Destreza: CD 13, cada criatura a até 1,5 m do garmr. Falha: o alvo fica infestado de larvas (veja Peles Larvadas).', 1);

-- Jotun (jotun)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'jotun',
  'northlands-heroes-2024-en',
  'Jotun',
  'Imensa Gigante, Caótico e Neutro',
  'Caótico e Neutro',
  'Gigante',
  'gargantuan',
  '22',
  7,
  20,
  370,
  '20d20 + 160',
  NULL,
  '{"forca":30,"destreza":8,"constituicao":26,"inteligencia":18,"sabedoria":20,"carisma":14}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'jotun';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('jotun', 'walk', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'jotun';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Imunidades', 'Cold; Bludgeoning', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Resistência Lendária (4/dia)', 'Se o jotun falhar em um teste de resistência, pode escolher ter sucesso em vez disso.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Resistência Mágica', 'O jotun tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Preso ao Material', 'O jotun tem imunidade a qualquer magia ou efeito que o forçaria a deixar o Plano Material, a menos que queira sair. Tem desvantagem em testes de resistência contra efeitos que o devolveriam ao Plano Material de outro plano de existência.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Grande Demais para Notar', 'Enquanto o jotun permanecer imóvel em terreno natural não mágico, tem vantagem em testes de Destreza (Furtividade).', 3);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Perícias', 'Arcana +11, História +11, Natureza +11, Furtividade +6', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Sentidos', 'Visão no escuro 36 m; Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jotun', 'Idiomas', 'Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'jotun';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O jotun realiza três Greatclub or Rock ataques em qualquer combinação. Em vez de um daqueles ataques, pode usar Icy Sweep or cast Fear .', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Clava Grande', 'action'::rpg.actor_action_bucket, 17, '28 (4d8 + 10) dano Contundente mais 27 (6d8) dano de Frio', 'Ataque corpo a corpo com arma: +17, alcance 4.5 m, um alvo. Acerto: 28 (4d8 + 10) dano Contundente mais 27 (6d8) dano de Frio.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Pedra', 'action'::rpg.actor_action_bucket, 17, '32 (4d10 + 10) dano Contundente mais 27 (6d8) dano de Frio', 'Ataque à distância com arma: +17, alcance 60/72 m, um alvo. Acerto: 32 (4d10 + 10) dano Contundente mais 27 (6d8) dano de Frio.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Varredura Gelada (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 23, cada criatura a até 6 m do jotun. Falha: 36 (8d8) dano Contundente e 54 (12d8) dano de Frio, e o alvo é empurrado até 4.5 m para longe do jotun e fica caída. Sucesso: metade do dano apenas.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O jotun conjura uma das magias a seguir, sem exigir componentes materiais e usando Sabedoria como atributo de conjuração (CD de resistência a magia 20):', 5);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Apanhar Pedras', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o jotun é atingido por um ataque à distância com arma. Resposta: o jotun reduz o dano em 1d20 + 30. Se isso reduzir o dano a 0, O jotun pode arremessar o weapon or ammunition at a criatura a até 18 m dele, using o same total do teste de ataque e total de dano da criatura originária.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Usos de Ação Lendária', 'legendary'::rpg.actor_action_bucket, NULL, NULL, '3. Imediatamente após o turno de outra criatura, O jotun pode gastar um uso para realizar uma das ações a seguir. O jotun recupera todos os usos gastos no início de cada um de seus turnos.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Arremessar', 'legendary'::rpg.actor_action_bucket, NULL, NULL, 'O jotun realiza um ataque de Pedra.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Esmagar', 'legendary'::rpg.actor_action_bucket, NULL, NULL, 'O jotun realiza um ataque de Clava Grande.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jotun', 'Poder Titânico', 'legendary'::rpg.actor_action_bucket, NULL, NULL, 'O jotun conjura uma magia ou usa Varredura Gelada, se disponível.', 4);

-- Lightning Giant (lightning-giant)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'lightning-giant',
  'northlands-heroes-2024-en',
  'Lightning Giant',
  'Grande Gigante, Caótico e Neutro',
  'Caótico e Neutro',
  'Gigante',
  'large',
  '6',
  3,
  16,
  116,
  '13d10 + 45',
  7,
  '{"forca":22,"destreza":18,"constituicao":20,"inteligencia":14,"sabedoria":12,"carisma":15}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'lightning-giant';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('lightning-giant', 'fly', 60);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('lightning-giant', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'lightning-giant';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('lightning-giant', 'Imunidades', 'Lightning, Thunder', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('lightning-giant', 'Carne Eletrificante', 'A lightning giant''s flesh constantly sparks com electricity. Uma criatura striking a lightning giant com um arma corpo a corpo deve passar em um CD 16 teste de resistência de Constituição ou sofre 3 (1d6) dano Elétrico, or 5 (1d10) dano Se o weapon is made out of a conductive metal such as iron. A lightning giant pode suprimir esta habilidade com uma Ação Bônus.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('lightning-giant', 'Perícias', 'Acrobacia +7, Arcana +5, Atletismo +9, Percepção +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('lightning-giant', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('lightning-giant', 'Idiomas', 'Auran, Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'lightning-giant';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('lightning-giant', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O lightning giant realiza dois ataques, usando Lightning Staff ou Static Fling em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('lightning-giant', 'Cajado Elétrico', 'action'::rpg.actor_action_bucket, 9, '13 (2d6 + 6) dano Contundente mais 7 (2d6) dano Elétrico', 'Teste de ataque corpo a corpo: +9, alcance 3 m Acerto: 13 (2d6 + 6) dano Contundente mais 7 (2d6) dano Elétrico.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('lightning-giant', 'Arremesso Estático', 'action'::rpg.actor_action_bucket, 7, '18 (4d6 + 4) dano Elétrico, e o alvo é empurrado até 4.5 m', 'Teste de ataque à distância: +7, alcance 36 m Acerto: 18 (4d6 + 4) dano Elétrico, e o alvo é empurrado até 4.5 m.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('lightning-giant', 'Descarga Estática (Recarga 6 ou Especial)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 15, todas as criaturas em uma esfera de raio 6 metros ao redor do lightning giant. Falha: 21 (6d6) dano Elétrico, e o alvo fica atordoado até o fim do seu próximo turno. Sucesso: metade do dano apenas.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('lightning-giant', 'Absorver Relâmpago', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura o lightning giant possa ver a até 18 m (que não seja ele mesmo) causa dano Elétrico a uma criatura que não seja o gigante elétrico. Resposta: o gigante elétrico absorve o dano Elétrico em seu cajado, anulando esse dano contra o alvo original. Isso também recarrega sua habilidade Descarga Estática.', 1);

-- Thrudgelmir Giant (thrudgelmir-giant)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'thrudgelmir-giant',
  'northlands-heroes-2024-en',
  'Thrudgelmir Giant',
  'Enorme Gigante, Neutro e Mau',
  'Neutro e Mau',
  'Gigante',
  'huge',
  '10',
  4,
  18,
  175,
  '14d12 + 84',
  4,
  '{"forca":27,"destreza":10,"constituicao":22,"inteligencia":14,"sabedoria":16,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'thrudgelmir-giant';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('thrudgelmir-giant', 'walk', 50);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'thrudgelmir-giant';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Imunidades', 'cego , Charmed , surdo , amedrontado , atordoado , inconsciente', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Sempre Vigilante', 'At least two do thrudgelmir''s heads are awake at all times. O criatura tem vantagem em testes de Sabedoria (Percepção).', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Resistência Mágica', 'O thrudgelmir tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Tatuagens Rúnicas', 'O thrudgelmir giant''s body is covered in magical, runic tattoos. Um Dissipar Magia bem-sucedido nas tatuagens (contra CD 15) faz desaparecerem por 1 minuto. Durante esse tempo, o thrudgelmir perde Resistência Mágica e o dano de energia do ataque Martelo Elemental.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Perícias', 'Atletismo +12, Percepção +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Sentidos', 'Visão no escuro 36 m; Percepção passiva 17', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thrudgelmir-giant', 'Idiomas', 'Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'thrudgelmir-giant';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('thrudgelmir-giant', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O thrudgelmir realiza três Elemental Hammer ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('thrudgelmir-giant', 'Martelo Elemental', 'action'::rpg.actor_action_bucket, 12, '26 (4d8 + 8) dano Contundente mais 9 (2d8) dano (roll 1d6 to determine dano type: 1', 'Teste de ataque corpo a corpo: +12, alcance 3 m Acerto: 26 (4d8 + 8) dano Contundente mais 9 (2d8) dano (roll 1d6 to determine dano type: 1. Acid, 2. Cold, 3. Fire, 4. Lightning, 5. Poison, 6. Thunder).', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('thrudgelmir-giant', 'Faces do Mal (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Carisma: CD 16. Falha: Todas as criaturas a até 9 m do thrudgelmir que possa vê-lo são submetidas a uma das seguintes condições ou efeitos até o fim do próximo turno do giant.', 3);

-- Thursir Giant (thursir-giant)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'thursir-giant',
  'northlands-heroes-2024-en',
  'Thursir Giant',
  'Grande Gigante, Neutral Evil (50%) or Lawful Evil (50%)',
  'Neutral Evil (50%) or Lawful Evil (50%)',
  'Gigante',
  'large',
  '3',
  2,
  13,
  93,
  '11d10 + 33',
  0,
  '{"forca":19,"destreza":10,"constituicao":16,"inteligencia":13,"sabedoria":15,"carisma":11}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'thursir-giant';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('thursir-giant', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'thursir-giant';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thursir-giant', 'Estômago de Ferro', 'Thursir têm vantagem em testes de resistência para evitar ou encerrar a condição envenenado.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thursir-giant', 'Perícias', 'Atletismo +6, Percepção +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thursir-giant', 'Sentidos', 'Visão no escuro 18 m, Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('thursir-giant', 'Idiomas', 'Comum, Anão, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'thursir-giant';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('thursir-giant', 'Martelo de Guerra Rúnico Thurs', 'action'::rpg.actor_action_bucket, 6, '15 (2d10 + 4) dano Contundente mais 9 (2d8) dano Elétrico, e o alvo não pode realizar Reações até o início do próximo turno do giant', 'Ataque corpo a corpo com arma: +6, alcance 3 m, um alvo. Acerto: 15 (2d10 + 4) dano Contundente mais 9 (2d8) dano Elétrico, e o alvo não pode realizar Reações até o início do próximo turno do giant.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('thursir-giant', 'Pedra', 'action'::rpg.actor_action_bucket, 6, '15 (2d10 + 4) dano Contundente', 'Ataque à distância com arma: +6, alcance 60/72 m, um alvo. Acerto: 15 (2d10 + 4) dano Contundente.', 2);

-- Tundra Gnoll (tundra-gnoll)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'tundra-gnoll',
  'northlands-heroes-2024-en',
  'Tundra Gnoll',
  'Médio Corruptor, Neutro e Mau',
  'Neutro e Mau',
  'Corruptor',
  'medium',
  '1',
  2,
  15,
  38,
  '7d8 + 7',
  2,
  '{"forca":14,"destreza":14,"constituicao":12,"inteligencia":7,"sabedoria":12,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'tundra-gnoll';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('tundra-gnoll', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'tundra-gnoll';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('tundra-gnoll', 'Imunidades', 'Cold', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('tundra-gnoll', 'Camuflagem Ártica', 'O tundra gnoll tem vantagem em testes de Destreza (Furtividade) em condições de neve ou gelo.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('tundra-gnoll', 'Perícias', 'Percepção +3, Furtividade +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('tundra-gnoll', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('tundra-gnoll', 'Idiomas', 'Gnoll', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'tundra-gnoll';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('tundra-gnoll', 'Machado de Osso', 'action'::rpg.actor_action_bucket, 4, '6 (1d8 + 2) dano Cortante', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 6 (1d8 + 2) dano Cortante.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('tundra-gnoll', 'Arco de Osso', 'action'::rpg.actor_action_bucket, 4, '7 (1d10 + 2) dano Perfurante', 'Teste de ataque à distância: +4, alcance 150/180 m Acerto: 7 (1d10 + 2) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('tundra-gnoll', 'Olhar Congelante', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 12, uma criatura a até 6 m do tundra gnoll. Falha: A criatura''s Speed is reduced to 0 m até o fim de seu próximo turno by a supernatural chill.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('tundra-gnoll', 'Fúria (2/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Imediatamente após causar dano to a Ferido criatura, O tundra gnoll moves up to half seu deslocamento e realiza um Bone Axe ataque.', 1);

-- Grendelkyn (grendelkyn)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'grendelkyn',
  'northlands-heroes-2024-en',
  'Grendelkyn',
  'Grande Fada, Neutro e Mau',
  'Neutro e Mau',
  'Fada',
  'large',
  '4',
  2,
  17,
  76,
  '8d10 + 32',
  5,
  '{"forca":21,"destreza":17,"constituicao":19,"inteligencia":9,"sabedoria":15,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'grendelkyn';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('grendelkyn', 'swim', 40);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('grendelkyn', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'grendelkyn';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Imunidades', 'Cold; Charmed , amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Anfíbio', 'O grendelkyn pode respirar ar e água.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Armadura de Sombra', 'O grendelkyn é cercado por um manto de sombras ondulante. Este manto adiciona 3 à sua CA (incluído em suas estatísticas) e concede vantagem em testes de Destreza (Furtividade) em Escuridão ou Penumbra .', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Sensibilidade à Luz Solar', 'Enquanto estiver sob luz solar, o grendelkyn tem desvantagem em testes de atributo e testes de ataque, e perde Armadura de Sombra. Além disso, não pode usar a ação Armadilha de Sombra, e qualquer Armadilha de Sombra existente derrete.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Perícias', 'Percepção +4, Furtividade +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Sentidos', 'Visão no escuro 27 m; Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('grendelkyn', 'Idiomas', 'Silvestre', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'grendelkyn';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('grendelkyn', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O grendelkyn realiza um Bite e um ataque de Garras. Pode substituir seu ataque de Garras com Armadilha de Sombra.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('grendelkyn', 'Mordida', 'action'::rpg.actor_action_bucket, 7, '12 (2d6 + 5) dano Perfurante', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 12 (2d6 + 5) dano Perfurante. Em um crítico, o alvo fica amedrontado até o fim do próximo turno do grendelkyn.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('grendelkyn', 'Garras', 'action'::rpg.actor_action_bucket, 7, '10 (1d10 + 5) dano Cortante', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 10 (1d10 + 5) dano Cortante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('grendelkyn', 'Armadilha de Sombra', 'action'::rpg.actor_action_bucket, 7, '9 (2d8) dano de Frio, e o alvo fica envolto em tentáculos sombrios que se estendem do corpo do grendelkyn, e o alvo é submetido ao seguinte efeito', 'Teste de ataque corpo a corpo: +7, alcance 3 m Acerto: 9 (2d8) dano de Frio, e o alvo fica envolto em tentáculos sombrios que se estendem do corpo do grendelkyn, e o alvo é submetido ao seguinte efeito. Teste de resistência de Destreza: CD 14. Falha: O alvo fica cego e impedido. A criatura pode repetir o teste de resistência de Destreza no fim de cada um de seus turnos para se libertar. Caso contrário, permanece presa pelos tentáculos por 1 minuto. A Armadilha de Sombra também desaparece se for exposta à luz solar, O grendelkyn dies or fica incapacitado, or escolhe to use Armadilha de Sombra contra um novo alvo.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('grendelkyn', 'Portal Sombrio', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Um grendelkyn em uma área of Penumbra or Escuridão can teletransporta-se até 9 m para um espaço desocupado que possa ver em Penumbra ou Escuridão. Se o grendelkyn teleports enquanto tem uma criatura trapped in a Armadilha de Sombra, aquela criatura também se teletransporta 9 m, para um espaço desocupado a até 3 m do grendelkyn that is em Penumbra ou Escuridão. Se não houver espaço disponível, o grendelkyn liberta a criatura presa ao se teletransportar.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('grendelkyn', 'Grito Frenético', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o grendelkyn is Ferido . Resposta: Todas as criaturas a até 6 m do grendelkyn fazem um teste de resistência de Sabedoria CD 12. Falha: o alvo fica amedrontado por 1 minuto. Uma criatura afetada pelo grito pode repetir o teste de resistência de Sabedoria no fim de cada um de seus turnos para encerrar o efeito em si mesma.', 1);

-- Hafgufa (hafgufa)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'hafgufa',
  'northlands-heroes-2024-en',
  'Hafgufa',
  'Imensa Monstruosidade, Neutro e Mau',
  'Neutro e Mau',
  'Monstruosidade',
  'gargantuan',
  '12',
  4,
  16,
  217,
  '14d20 + 70',
  0,
  '{"forca":22,"destreza":10,"constituicao":20,"inteligencia":11,"sabedoria":14,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'hafgufa';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('hafgufa', 'swim', 60);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('hafgufa', 'walk', 10);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'hafgufa';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa', 'Anfíbio', 'O hafgufa pode respirar ar e água.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa', 'Espreitador Marinho', 'O hafgufa tem vantagem em testes de Furtividade submerso.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa', 'Monstro de Cerco', 'O hafgufa causa dobro de dano a objetos e estruturas.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa', 'Perícias', 'Furtividade +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 12', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'hafgufa';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O hafgufa realiza quatro ataques de Tentáculo. Pode substituir um ataque com seu Bite.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa', 'Mordida', 'action'::rpg.actor_action_bucket, 10, '28 (4d10 + 6) dano Perfurante', 'Teste de ataque corpo a corpo: +10, alcance 3 m Acerto: 28 (4d10 + 6) dano Perfurante. O hafgufa tem vantagem em este teste de ataque contra uma criatura agarrado by one deles tentacles.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa', 'Tentáculo', 'action'::rpg.actor_action_bucket, 10, '11 (1d10 + 6) dano Contundente', 'Teste de ataque corpo a corpo: +10, alcance 9 m Acerto: 11 (1d10 + 6) dano Contundente. Se o alvo for a Enorme ou menor criatura, o alvo fica agarrado (CD para escapar 18) de um dos quatro tentáculos, e O hafgufa pode puxar o alvo até 7.5 m em linha reta em direção a si.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa', 'Névoa Fétida (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 17, cada criatura em um 12 metros Cube . Falha: o alvo fica incapacitado por 10 minutos. No fim de cada um de seus turnos, o alvo pode repetir o teste de resistência, encerrando a condição se passar.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa', 'Engolir', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 18, uma criatura Grande ou menor a até 1.5 m that is agarrado by o hafgufa (pode ter até seis criaturas engolidas por vez). Falha: o alvo é engolido e a condição agarrado termina. Uma criatura engolida fica cego e impedido, Tem Cobertura Total contra ataques e outros efeitos originados de fora da hafgufa, e sofre 28 (8d6) dano Ácido no início de cada turno do hafgufa''s turns.', 1);

-- Hafgufa Spawn (hafgufa-spawn)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'hafgufa-spawn',
  'northlands-heroes-2024-en',
  'Hafgufa Spawn',
  'Grande Monstruosidade, Neutro e Mau',
  'Neutro e Mau',
  'Monstruosidade',
  'large',
  '6',
  3,
  14,
  105,
  '14d10 + 28',
  2,
  '{"forca":18,"destreza":14,"constituicao":14,"inteligencia":7,"sabedoria":10,"carisma":6}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'hafgufa-spawn';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('hafgufa-spawn', 'swim', 40);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('hafgufa-spawn', 'walk', 10);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'hafgufa-spawn';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa-spawn', 'Anfíbio', 'O hafgufa spawn pode respirar ar e água.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa-spawn', 'Espreitador Marinho', 'O hafgufa spawn tem vantagem em testes de Furtividade submerso.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa-spawn', 'Perícias', 'Furtividade +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa-spawn', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 10', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hafgufa-spawn', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'hafgufa-spawn';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa-spawn', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O hafgufa spawn realiza quatro ataques de Tentáculo. Pode substituir one ataque com Bite.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa-spawn', 'Mordida', 'action'::rpg.actor_action_bucket, 7, '15 (2d10 + 4) dano Perfurante', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 15 (2d10 + 4) dano Perfurante. O hafgufa spawn tem vantagem em este teste de ataque contra uma criatura agarrado by one deles tentacles.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa-spawn', 'Tentáculo', 'action'::rpg.actor_action_bucket, 7, '8 (1d8 + 4) dano Contundente', 'Teste de ataque corpo a corpo: +7, alcance 4.5 m Acerto: 8 (1d8 + 4) dano Contundente. Se o alvo for uma criatura Grande ou menor, fica agarrado (CD para escapar 15) de um dos quatro tentáculos, e O hafgufa spawn pode puxar o alvo até 3 m em linha reta em direção a si.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hafgufa-spawn', 'Névoa Fétida (1/dia)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 13, cada criatura em um 6 metros Cube . Falha: alvo fica incapacitado por 10 minutos. No fim de cada um de seus turnos, o alvo pode repetir o teste de resistência, encerrando a condição se passar.', 4);

-- Hamingja (hamingja)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'hamingja',
  'northlands-heroes-2024-en',
  'Hamingja',
  'Pequeno Celestial, Neutro e Bom',
  'Neutro e Bom',
  'Celestial',
  'small',
  '1',
  2,
  12,
  21,
  '6d6',
  4,
  '{"forca":6,"destreza":14,"constituicao":11,"inteligencia":13,"sabedoria":16,"carisma":14}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'hamingja';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('hamingja', 'fly', 20);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('hamingja', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'hamingja';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hamingja', 'Imunidades', 'Poison, Radiant; Charmed , exausto , amedrontado , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hamingja', 'Resistência Mágica', 'O hamingja tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hamingja', 'Perícias', 'História +3, Intuição +5, Percepção +5, Furtividade +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hamingja', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('hamingja', 'Idiomas', 'Comum, Celestial, Telepatia 18 m', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'hamingja';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hamingja', 'Mordida', 'action'::rpg.actor_action_bucket, 4, '5 (1d6 + 2) dano Perfurante', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 5 (1d6 + 2) dano Perfurante.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hamingja', 'Toque Radiante', 'action'::rpg.actor_action_bucket, 4, '7 (2d4 + 2) dano Radiante', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 7 (2d4 + 2) dano Radiante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hamingja', 'Metamorfose', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O hamingja muda de forma para se assemelhar a uma Besta ou Humanoide Média ou menor. Suas estatísticas de jogo são as mesmas em cada forma, exceto que seu deslocamento de voo só está disponível em sua forma verdadeira ou em uma forma com asas. Qualquer equipamento que veste ou carrega não é transformado.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hamingja', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O hamingja conjura uma das magias a seguir, sem exigir componentes materiais e usando Carisma como atributo de conjuração (CD de resistência a magia 12):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('hamingja', 'Golpe de Sorte (3/dia)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura o hamingja is bonded to fails an teste de ataque, teste de atributo, or teste de resistência. Resposta: o criatura adds 1d6 to sua rolagem, potencialmente transformando a falha em sucesso.', 1);

-- Jorumungkyn (jorumungkyn)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'jorumungkyn',
  'northlands-heroes-2024-en',
  'Jorumungkyn',
  'Imensa Dragão, Caótico e Mau',
  'Caótico e Mau',
  'Dragão',
  'gargantuan',
  '10',
  4,
  14,
  230,
  '20d12 + 100',
  3,
  '{"forca":25,"destreza":9,"constituicao":20,"inteligencia":5,"sabedoria":14,"carisma":8}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'jorumungkyn';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('jorumungkyn', 'swim', 80);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('jorumungkyn', 'walk', 5);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'jorumungkyn';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jorumungkyn', 'Imunidades', 'Cold, Veneno, Psíquico; Charmed , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jorumungkyn', 'Secreções Venenosas', 'O jorumungkyn constantemente exuda veneno em seus arredores. Uma criatura que inicia o turno a até 3 m de a jorumungkyn (ou 9 m na água) sofre 3 (1d6) dano Venenoso.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jorumungkyn', 'Sentidos', 'Visão no escuro 36 m; Percepção passiva 12', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jorumungkyn', 'Idiomas', 'compreende Dracônico but não pode falar it.', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'jorumungkyn';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jorumungkyn', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O jorumungkyn realiza um ataque de Mordida e one Tail ataque e uses Constrict.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jorumungkyn', 'Mordida', 'action'::rpg.actor_action_bucket, 11, '25 (4d8 + 7) dano Perfurante mais 7 (2d6) dano Venenoso', 'Teste de ataque corpo a corpo: +11, alcance 4.5 m Acerto: 25 (4d8 + 7) dano Perfurante mais 7 (2d6) dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jorumungkyn', 'Cauda', 'action'::rpg.actor_action_bucket, 11, '21 (4d6 + 7) dano Contundente mais 7 (2d6) dano Venenoso', 'Teste de ataque corpo a corpo: +11, alcance 4.5 m Acerto: 21 (4d6 + 7) dano Contundente mais 7 (2d6) dano Venenoso.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jorumungkyn', 'Constritor', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 19, uma criatura Enorme ou menor que o jorumungkyn possa ver a até 4,5 m. Falha: 21 (4d6 + 7) dano Contundente mais 7 (2d6) dano Venenoso. O alvo fica agarrado (CD para escapar 19) e fica impedido até o fim do agarrão.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jorumungkyn', 'Olhar do Abismo (2/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Inteligência: CD 14, uma criatura a até 18 m. Falha: 21 (6d6) dano Psíquico, e o alvo fica Enfeitiçado condição por 1 minuto. Enquanto enfeitiçado, o alvo fica incapacitado. Se o alvo for more than 1.5 m do jorumungkyn, o alvo se move no turno dele em direção ao jorumungkyn pela rota mais direta, tentando chegar a até 1,5 m do jorumungkyn. Antes de entrar em terreno causador de dano e sempre que sofrer dano de uma fonte que não seja o jorumungkyn, o alvo repete o teste de resistência. Sucesso: O alvo tem imunidade ao jorumungkyn''s Olhar do Abismo por 24 horas.', 1);

-- Sea Lindwurm (sea-lindwurm)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'sea-lindwurm',
  'northlands-heroes-2024-en',
  'Sea Lindwurm',
  'Enorme Dragão, Caótico e Mau',
  'Caótico e Mau',
  'Dragão',
  'huge',
  '7',
  3,
  16,
  153,
  '18d10 + 54',
  6,
  '{"forca":20,"destreza":16,"constituicao":16,"inteligencia":6,"sabedoria":13,"carisma":9}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'sea-lindwurm';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('sea-lindwurm', 'swim', 60);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('sea-lindwurm', 'walk', 10);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'sea-lindwurm';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-lindwurm', 'Imunidades', 'Cold', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-lindwurm', 'Anfíbio', 'O sea lindwurm pode respirar ar e água.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-lindwurm', 'Perícias', 'Percepção +4, Furtividade +9', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-lindwurm', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-lindwurm', 'Idiomas', 'Dracônico', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'sea-lindwurm';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sea-lindwurm', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O sea lindwurm realiza dois ataques de Mordida.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sea-lindwurm', 'Mordida', 'action'::rpg.actor_action_bucket, 8, '21 (3d10 + 5) dano Perfurante', 'Teste de ataque corpo a corpo: +8, alcance 3 m Acerto: 21 (3d10 + 5) dano Perfurante. O alvo também fica sujeito a do lindwurm marinho paralyzing toxin. Teste de resistência de Constituição: CD 14. Primeira falha: O criatura fica impedido. O alvo Repete o teste de resistência at o fim deles próximo turno if it''s still impedido, encerrando o efeito em si mesma se passar. Second Falha: o alvo fica paralisado por 1 hora.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sea-lindwurm', 'Bofetada de Nadadeira (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'teste de resistência de Destreza : CD 16, todas as criaturas em um 10-metros de raio, esfera ao redor do sea lindwurm. Falha: 14 (4d6) dano Contundente, e a criatura fica atordoado até o fim de seu próximo turno. Sucesso: metade do dano apenas.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sea-lindwurm', 'Mergulho Profundo', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O sea lindwurm moves up to half seu deslocamento without drawing Ataques de Oportunidade .', 1);

-- Malrgotr (malrgotr)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'malrgotr',
  'northlands-heroes-2024-en',
  'Malrgotr',
  'Grande Monstruosidade, Sem tendência',
  'Sem tendência',
  'Monstruosidade',
  'large',
  '3',
  2,
  17,
  68,
  '8d10 + 24',
  0,
  '{"forca":19,"destreza":11,"constituicao":17,"inteligencia":3,"sabedoria":12,"carisma":5}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'malrgotr';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('malrgotr', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'malrgotr';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('malrgotr', 'Imunidades', 'amedrontado , atordoado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('malrgotr', 'Cerdas', 'Uma criatura que hits o malrgotr com um ataque corpo a corpo enquanto um até 1,5 m de sofre 4 (1d8) dano Perfurante.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('malrgotr', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('malrgotr', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'malrgotr';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('malrgotr', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O malrgotr realiza um Gore ataque e one Hooves ataque.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('malrgotr', 'Investida', 'action'::rpg.actor_action_bucket, 6, '13 (2d8 + 4) dano Perfurante mais 3 (1d6) dano Radiante', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 13 (2d8 + 4) dano Perfurante mais 3 (1d6) dano Radiante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('malrgotr', 'Cascos', 'action'::rpg.actor_action_bucket, 6, '9 (1d10 + 4) dano Contundente', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 9 (1d10 + 4) dano Contundente.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('malrgotr', 'Clarão Glorioso (Recarga 5–6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 13, todas as criaturas em um raio de 4,5 m ao redor do malrgotr. Falha: 7 (2d6) dano Radiante, e o alvo fica cego até o fim de seu próximo turno.', 1);

-- Great Ogre (great-ogre)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'great-ogre',
  'northlands-heroes-2024-en',
  'Great Ogre',
  'Enorme Gigante, Caótico e Mau',
  'Caótico e Mau',
  'Gigante',
  'huge',
  '4',
  2,
  13,
  95,
  '10d12 + 30',
  NULL,
  '{"forca":21,"destreza":8,"constituicao":16,"inteligencia":7,"sabedoria":9,"carisma":9}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'great-ogre';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('great-ogre', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'great-ogre';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('great-ogre', 'Porte Massivo', 'O great ogre tem vantagem em teste de resistência de Forças e testes de Força (Atletismo).', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('great-ogre', 'Perícias', 'Atletismo +7, Percepção +1', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('great-ogre', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('great-ogre', 'Idiomas', 'Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'great-ogre';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('great-ogre', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O great ogre realiza dois greatclub ataques or throws two javelins.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('great-ogre', 'Clava Grande', 'action'::rpg.actor_action_bucket, 7, '19 (4d6 + 5) dano Contundente', 'Teste de ataque corpo a corpo: +7, alcance 3 m Acerto: 19 (4d6 + 5) dano Contundente.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('great-ogre', 'Azagaia', 'action'::rpg.actor_action_bucket, 7, '14 (2d8 + 5) dano Perfurante', 'Ataque corpo a corpo ou teste de ataque à distância: +7, alcance 3 m or alcance 50/60 m Acerto: 14 (2d8 + 5) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('great-ogre', 'Arroto Hediondo (Recarga 6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 13, todas as criaturas em um cone de 15 metros . Falha: 14 (4d6) dano Venenoso, e a criatura fica envenenado por 1 minuto. Sucesso: metade do dano apenas. Uma criatura envenenada pode repetir o teste de resistência no fim de cada um de seus turnos para encerrar o efeito em si mesma.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('great-ogre', 'Músculos Tensos (Recarga 6)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o ogro grande é atingido por um ataque que causa dano Contundente, Cortante ou Perfurante. Efeito: o ogro grande sofre metade do dano do ataque que disparou.', 1);

-- Runewright (runewright)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'runewright',
  'northlands-heroes-2024-en',
  'Runewright',
  'Médio Morto-vivo, Leal e Mau',
  'Leal e Mau',
  'Morto-vivo',
  'medium',
  '9',
  4,
  15,
  143,
  '26d8 + 26',
  2,
  '{"forca":16,"destreza":15,"constituicao":20,"inteligencia":20,"sabedoria":16,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'runewright';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('runewright', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'runewright';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('runewright', 'Imunidades', 'Necrotic, Poison; cego , Charmed , exausto , amedrontado , envenenado .', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('runewright', 'Resistência Mágica', 'O runewright tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('runewright', 'Perícias', 'Arcana +9, Intimidação +8, Percepção + 7, Persuasão +8', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('runewright', 'Sentidos', 'Visão no escuro 36 m, Percepção passiva 17', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('runewright', 'Idiomas', 'Comum mais dois outros idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'runewright';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('runewright', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O runewright realiza três Rune Blast ataques. Pode substituir one ataque com um use of Runic Gaze.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('runewright', 'Rajada Rúnica', 'action'::rpg.actor_action_bucket, 9, '21 (3d10 + 5) dano de Frio, Fogo, Elétrico ou Radiante (escolha do runewright com base na runa usada)', 'Ataque corpo a corpo ou teste de ataque à distância: +9, alcance 1,5 m or alcance 36 m Acerto: 21 (3d10 + 5) dano de Frio, Fogo, Elétrico ou Radiante (escolha do runewright com base na runa usada).', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('runewright', 'Olhar Rúnico', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 17, uma criatura o runewright possa ver com 18 m. Falha: 14 (2d8 + 5) dano Psíquico, e o alvo fica enfeitiçado ou amedrontado condição (do runewright choice) até o início do próximo turno do runewright. Sucesso: metade do dano apenas.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('runewright', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O runewright conjura uma das magias a seguir, sem exigir componentes materiais e usando Inteligência como atributo de conjuração (CD de resistência a magia 17):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('runewright', 'Passo Nebuloso', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O runewright conjura a magia Passo Nebuloso.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('runewright', 'Runa Solar', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o runewright é atingido por um ataque roll. Resposta: o attacking criatura deve passar em um CD 17 teste de resistência de Constituição or be cego até o fim de seu próximo turno.', 1);

-- Selkie (selkie)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'selkie',
  'northlands-heroes-2024-en',
  'Selkie',
  'Médio Fada, Neutro',
  'Neutro',
  'Fada',
  'medium',
  '3',
  2,
  12,
  82,
  '15d8 + 15',
  NULL,
  '{"forca":14,"destreza":15,"constituicao":12,"inteligencia":11,"sabedoria":12,"carisma":17}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'selkie';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('selkie', 'swim', 30);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('selkie', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'selkie';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('selkie', 'Resiliência Feérica', 'O selkie tem vantagem em saves to avoid or end enfeitiçado e inconsciente condições.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('selkie', 'Prender a Respiração', 'O selkie pode prender a respiração por 30 minutos.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('selkie', 'Falar com Pinípedes', 'O selkie can communicate com seals, sea lions, e walruses as if they shared a language.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('selkie', 'Perícias', 'Percepção +4, Furtividade +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('selkie', 'Sentidos', 'Visão no escuro 18 m, Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('selkie', 'Idiomas', 'Aquan, Comum, Silvestre', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'selkie';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('selkie', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O selkie realiza um ataque de Mordida e dois ataques de Cauda, ou realiza três ataques de Lança.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('selkie', 'Mordida (Apenas Forma de Foca)', 'action'::rpg.actor_action_bucket, 4, '9 (2d6 +2) dano Perfurante', 'Ataque corpo a corpo com arma: +4, alcance 1,5 m, um alvo. Acerto: 9 (2d6 +2) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('selkie', 'Lança (Apenas Forma Feérica)', 'action'::rpg.actor_action_bucket, 4, '5 (1d6 + 2) dano Perfurante', 'Melee or Ataque à distância com arma: +4, alcance 1,5 m or alcance 20/18 m, um alvo. Acerto: 5 (1d6 + 2) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('selkie', 'Cauda (Apenas Forma de Foca)', 'action'::rpg.actor_action_bucket, 4, '6 (1d8 + 2) dano Contundente', 'Ataque corpo a corpo com arma: +4, alcance 1,5 m, um alvo. Acerto: 6 (1d8 + 2) dano Contundente.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('selkie', 'Mudar Forma', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'A selkie muda magicamente de forma para uma foca Média ou de volta à sua forma verdadeira, que é Fada. Suas estatísticas, além da CA, tamanho e deslocamento, são as mesmas em cada forma. Qualquer equipamento que veste ou carrega transforma com ela. Reverte à forma verdadeira se morrer. Se a selkie estiver em sua forma verdadeira, não pode usar esta Ação Bônus a menos que esteja vestindo ou carregando sua pele de foca vinculada.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('selkie', 'Escape Encantador', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'A selkie realiza a ação Disparada ou Desengajar. Cada criatura a até 1,5 m de uma selkie quando ela realiza a ação Desengajar desta forma deve passar em um teste de resistência de Sabedoria CD 13. Falha: A criatura fica Enfeitiçado condição até o fim do próximo turno do selkie.', 2);

-- Skein Witch (skein-witch)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'skein-witch',
  'northlands-heroes-2024-en',
  'Skein Witch',
  'Médio Celestial, Neutro',
  'Neutro',
  'Celestial',
  'medium',
  '12',
  4,
  20,
  162,
  '25d8 +50',
  NULL,
  '{"forca":6,"destreza":12,"constituicao":14,"inteligencia":16,"sabedoria":20,"carisma":20}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'skein-witch';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skein-witch', 'fly', 30);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skein-witch', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'skein-witch';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skein-witch', 'Imunidades', 'Fire, Lightning, Psychic', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skein-witch', 'Resistência do Destino (3/dia)', 'Se o skein witch falhar em um teste de resistência, pode escolher ter sucesso em vez disso.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skein-witch', 'Resistência Mágica', 'O skein witch tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skein-witch', 'Perícias', 'História +7, Intuição +13, Percepção +13', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skein-witch', 'Sentidos', 'Visão verdadeira 18 m, Percepção passiva 23', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skein-witch', 'Idiomas', 'Celestial, Telepatia 36 m', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'skein-witch';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skein-witch', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skein witch realiza três Inexorable Thread ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skein-witch', 'Fio Inexorável', 'action'::rpg.actor_action_bucket, 9, '27 (5d8 + 5) dano Radiante', 'Ataque corpo a corpo ou à distância com magia: +9, alcance 1,5 m or alcance 18 m, uma criatura. Acerto: 27 (5d8 + 5) dano Radiante. Se o skein witch hits com esta ataque, pode teletransportar-se, junto com todo equipamento que veste ou carrega, up to 9 m para um espaço desocupado que possa ver.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skein-witch', 'Onda de Distorção do Destino (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 17, cada criatura à escolha dele em um cone de 60 metros . Falha: 55 dano de Força, e a criatura tem desvantagem em testes d20 por 1 minuto. Uma criatura pode fazer um teste de resistência no fim de cada um de seus turnos para encerrar este efeito. Sucesso: metade do dano apenas.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skein-witch', 'Atar Destinos (1/dia)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 17, uma criatura o skein witch possa ver a até 18 m. Falha: o destino do alvo is bound to that of um dos aliados da bruxa à escolha. Qualquer dano ou condição alvo sofre é infligido ao aliado ao qual está vinculado, em vez disso, e vice-versa. Uma criatura só pode estar vinculado a outra criatura por vez. Este vínculo dura até ser removido por a Restauração Superior, Heal, or Remover Maldição spell or magia similar.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skein-witch', 'Cortar o Fio', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O skein witch chooses a criatura a até 9 m dele que possa ver e that is com 0 pontos de vida. If a criatura estava Estável, deixa de estar Estável. Além disso, deve fazer um teste de resistência contra a morte imediato.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skein-witch', 'Aparar Magia', 'reaction'::rpg.actor_action_bucket, NULL, NULL, '. Gatilho: o skein witch passa em um teste de resistência contra uma magia de 4º nível ou inferior que afete apenas o skein witch. Resposta: A magia não tem efeito. Se o skein witch succeeds on o teste de resistência por 5 ou mais, a magia é refletida de volta ao conjurador, usando o nível do espaço, CD de resistência a magia, bônus de ataque, e atributo de conjuração do conjurador.', 1);

-- Skeljaskra (skeljaskra)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'skeljaskra',
  'northlands-heroes-2024-en',
  'Skeljaskra',
  'Grande Monstruosidade, Sem tendência',
  'Sem tendência',
  'Monstruosidade',
  'large',
  '3',
  2,
  18,
  66,
  '7d10 + 28',
  NULL,
  '{"forca":20,"destreza":6,"constituicao":18,"inteligencia":4,"sabedoria":12,"carisma":6}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'skeljaskra';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skeljaskra', 'climb', 20);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skeljaskra', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'skeljaskra';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skeljaskra', 'Imunidades', 'exausto', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skeljaskra', 'Monstro de Cerco', 'O skeljaskra causa dobro de dano a objetos e estruturas.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skeljaskra', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skeljaskra', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'skeljaskra';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeljaskra', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skeljaskra realiza dois ataques, usando Dilacerar, Cuspe Flamejante ou Cauda em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeljaskra', 'Dilacerar', 'action'::rpg.actor_action_bucket, 7, '12 (2d6 + 5) dano Cortante', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 12 (2d6 + 5) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeljaskra', 'Cuspe Flamejante', 'action'::rpg.actor_action_bucket, 7, '7 (1d6 + 4) dano Venenoso, e o alvo fica cego e envenenado até o início do próximo turno do skeljaskra', 'Teste de ataque à distância: +7, alcance 9 m Acerto: 7 (1d6 + 4) dano Venenoso, e o alvo fica cego e envenenado até o início do próximo turno do skeljaskra.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeljaskra', 'Cauda', 'action'::rpg.actor_action_bucket, 7, '9 (1d8 + 5) dano Perfurante, e o alvo é empurrado 1.5 m', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 9 (1d8 + 5) dano Perfurante, e o alvo é empurrado 1.5 m.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skeljaskra', 'Bola Blindada', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o skeljaskra sofre 10 ou mais de dano Contundente, Perfurante ou Cortante de uma única fonte. Resposta: o skeljaskra enrola-se em uma bola até o início do seu próximo turno. Enquanto este efeito durar, a criatura tem resistência a dano Contundente, Perfurante e Cortante e fica incapacitado.', 1);

-- Dread Skeljaskra (dread-skeljaskra)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'dread-skeljaskra',
  'northlands-heroes-2024-en',
  'Dread Skeljaskra',
  'Imensa Monstruosidade, Sem tendência',
  'Sem tendência',
  'Monstruosidade',
  'gargantuan',
  '10',
  4,
  18,
  186,
  '12d20 + 60',
  NULL,
  '{"forca":22,"destreza":6,"constituicao":20,"inteligencia":4,"sabedoria":12,"carisma":6}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'dread-skeljaskra';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('dread-skeljaskra', 'climb', 15);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('dread-skeljaskra', 'walk', 20);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'dread-skeljaskra';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('dread-skeljaskra', 'Imunidades', 'exausto', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('dread-skeljaskra', 'Monstro de Cerco', 'O dread skeljaskra causa dobro de dano a objetos e estruturas.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('dread-skeljaskra', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('dread-skeljaskra', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'dread-skeljaskra';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('dread-skeljaskra', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O dread skeljaskra realiza dois ataques, usando Dilacerar, Cuspe Flamejante ou Cauda Espinhosa em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('dread-skeljaskra', 'Dilacerar', 'action'::rpg.actor_action_bucket, 10, '33 (6d8 + 6) dano Cortante', 'Teste de ataque corpo a corpo: +10, alcance 3 m Acerto: 33 (6d8 + 6) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('dread-skeljaskra', 'Cuspe Flamejante', 'action'::rpg.actor_action_bucket, 10, '20 (4d6 + 6) dano Venenoso mais 10 (3d6) dano de Fogo, e o alvo fica cego e envenenado até o início do próximo turno do skeljaskra', 'Teste de ataque à distância: +10, alcance 27 m Acerto: 20 (4d6 + 6) dano Venenoso mais 10 (3d6) dano de Fogo, e o alvo fica cego e envenenado até o início do próximo turno do skeljaskra.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('dread-skeljaskra', 'Cauda Espinhosa', 'action'::rpg.actor_action_bucket, 10, '33 (5d10 + 6) dano Perfurante, e o alvo é empurrado 6 m', 'Teste de ataque corpo a corpo: +10, alcance 4.5 m Acerto: 33 (5d10 + 6) dano Perfurante, e o alvo é empurrado 6 m.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('dread-skeljaskra', 'Rolamento Esmagador (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Se o dread skeljaskra inicia o turno na forma Bola Blindada, pode rolar até 18 m. Teste de resistência de Destreza: CD 16, cada criatura em uma linha de 18 metros de 4,5 m de largura. Falha: 32 (5d12) dano Contundente, e o alvo fica caída.', 5);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('dread-skeljaskra', 'Bola Blindada', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o dread skeljaskra sofre 30 ou mais de dano. Resposta: o skeljaskra enrola-se em uma bola até o início do seu próximo turno. Enquanto este efeito durar, a criatura tem imunidade a dano Contundente, Perfurante e Cortante, e fica incapacitado.', 1);

-- Skogsra (skogsra)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'skogsra',
  'northlands-heroes-2024-en',
  'Skogsra',
  'Médio Fada, Neutro e Mau',
  'Neutro e Mau',
  'Fada',
  'medium',
  '8',
  3,
  16,
  130,
  '20d8 + 40',
  7,
  '{"forca":18,"destreza":18,"constituicao":14,"inteligencia":14,"sabedoria":16,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'skogsra';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skogsra', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'skogsra';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skogsra', 'Perícias', 'Enganação +7, Intuição +6, Percepção +6', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skogsra', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 16', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skogsra', 'Idiomas', 'Comum, Silvestre', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'skogsra';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skogsra', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skogsra realiza três ataques de Garra. In place of one ataque de Garra, pode usar Grasping Vines or Spellcasting.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skogsra', 'Garra', 'action'::rpg.actor_action_bucket, 7, '8 (1d8 + 4) dano Cortante mais 7 (2d6) dano Venenoso', 'Teste de ataque corpo a corpo: +7, alcance 3 m Acerto: 8 (1d8 + 4) dano Cortante mais 7 (2d6) dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skogsra', 'Vinhas Agarradoras', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 15, one Média ou menor criatura o skogsra possa ver a até 4.5 m. Falha: O alvo é puxado up to 3 m toward O skogsra e fica agarrado (CD para escapar 15).', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skogsra', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skogsra conjura uma das magias a seguir, usando Carisma como atributo de conjuração (CD de resistência a magia 15):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skogsra', 'Armadilha Oca', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O skogsra pulls a criatura com a condição agarrado para dentro de seu corpo oco. enquanto mantido assim, o alvo não está agarrado but fica cego e impedido, e sofre 7 (2d6) dano Cortante e 7 (2d6) dano Venenoso no início de cada um de seus turnos. If this dano reduces a Humanoid criatura to 0 Pontos de Vida, aquela criatura é considerado Estável e fica paralisado. Esta condição dura for 12 hours or até a criatura paralisada regains Pontos de Vida.', 1);

-- Fjord Troll (fjord-troll)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'fjord-troll',
  'northlands-heroes-2024-en',
  'Fjord Troll',
  'Grande Gigante, Neutro e Mau',
  'Neutro e Mau',
  'Gigante',
  'large',
  '5',
  3,
  15,
  85,
  '9d10 + 36',
  2,
  '{"forca":16,"destreza":15,"constituicao":18,"inteligencia":9,"sabedoria":9,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'fjord-troll';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fjord-troll', 'swim', 30);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('fjord-troll', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'fjord-troll';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fjord-troll', 'Prender a Respiração', 'O fjord troll pode prender a respiração por 30 minutos.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fjord-troll', 'Regeneração', 'O fjord troll regains 15 Pontos de Vida no início de cada um de seus turnos. Se o troll sofrer dano Ácido ou de Fogo, este traço não funciona no próximo turno do troll. O troll morre apenas se iniciar o turno com 0 pontos de vida e não regenerar.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fjord-troll', 'Perícias', 'Percepção +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fjord-troll', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('fjord-troll', 'Idiomas', 'Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'fjord-troll';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fjord-troll', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O fjord troll realiza dois Gouge ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fjord-troll', 'Escavar', 'action'::rpg.actor_action_bucket, 6, NULL, 'Teste de ataque corpo a corpo: +6, alcance 3 m em 7 (1d8 + 3) dano Cortante mais 7 (2d6) dano Venenoso. Se o alvo for a criatura, é submetido ao seguinte efeito. Teste de resistência de Constituição: CD 15. Falha: O alvo fica paralisado até o fim de seu próximo turno.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fjord-troll', 'Jato d’Água', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 14, cada criatura em um 9 metros-long, 1.5 metros-linha larga . Falha: 22 (4d10) dano de Frio. Se o alvo for a Enorme ou menor criatura, it é empurrado até 3 m para longe de o fjord troll. Sucesso: metade do dano apenas.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('fjord-troll', 'Investida Aquática', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O fjord troll nada até metade do deslocamento de natação.', 1);

-- Gilitrutt Troll (gilitrutt-troll)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'gilitrutt-troll',
  'northlands-heroes-2024-en',
  'Gilitrutt Troll',
  'Médio Gigante, Leal e Mau',
  'Leal e Mau',
  'Gigante',
  'medium',
  '3',
  2,
  15,
  58,
  '9d8 + 18',
  2,
  '{"forca":16,"destreza":14,"constituicao":17,"inteligencia":7,"sabedoria":12,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'gilitrutt-troll';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('gilitrutt-troll', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'gilitrutt-troll';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('gilitrutt-troll', 'Regeneração', 'O gilitrutt troll regains 10 Pontos de Vida no início de cada um de seus turnos. Se o troll sofrer dano Ácido ou de Fogo, este traço não funciona no próximo turno do troll. O troll morre apenas se iniciar o turno com 0 pontos de vida e não regenerar.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('gilitrutt-troll', 'Perícias', 'Percepção +3, Sobrevivência +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('gilitrutt-troll', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('gilitrutt-troll', 'Idiomas', 'Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'gilitrutt-troll';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('gilitrutt-troll', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O gilitrutt troll realiza dois Bite or three ataques de Garra.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('gilitrutt-troll', 'Mordida (Apenas Forma de Cão)', 'action'::rpg.actor_action_bucket, 5, '10 (2d6 + 3) dano Perfurante', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m Acerto: 10 (2d6 + 3) dano Perfurante. Se o alvo for uma criatura Grande ou menor, fica caída.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('gilitrutt-troll', 'Garra (Apenas Forma de Troll)', 'action'::rpg.actor_action_bucket, 5, '7 (1d8 + 3) dano Cortante', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m Acerto: 7 (1d8 + 3) dano Cortante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('gilitrutt-troll', 'Metamorfose', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O gilitrutt troll muda de forma para a Large hound (Speed 12 m), ou volta à forma de troll. Suas estatísticas de jogo, other than its size e Speed, são os mesmos em cada forma (exceto onde indicado). Qualquer equipamento que está vestindo ou carregando não é transformado.', 1);

-- Glacial Troll (glacial-troll)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'glacial-troll',
  'northlands-heroes-2024-en',
  'Glacial Troll',
  'Grande Gigante, Caótico e Mau',
  'Caótico e Mau',
  'Gigante',
  'large',
  '6',
  3,
  18,
  126,
  '12d10 + 60',
  1,
  '{"forca":20,"destreza":12,"constituicao":20,"inteligencia":7,"sabedoria":11,"carisma":7}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'glacial-troll';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('glacial-troll', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'glacial-troll';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Imunidades', 'Cold', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Aura Glacial', 'Chamas não mágicas a até 4.5 m do troll are snuffed out. Chamas mágicas persistentes, como as de Esfera Flamejante ou Muralha de Fogo, também podem ser apagadas. Se qualquer parte dessa chama mágica sobrepor com a aura, o conjurador deve fazer um CD 16 teste de resistência de Constituição. falha : a magia termina. Se o conjurador passar no teste de resistência, não precisa repetir testes de resistência para aquela conjuração da magia.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Carapaça Gelada', 'Uma criatura a até 1,5 m de O troll that hits it com um ataque corpo a corpo sofre 4 (1d8) dano de Frio.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Regeneração', 'O glacial troll regains 15 Pontos de Vida no início de cada um de seus turnos. Se o troll glacial sofrer dano Ácido ou de Fogo, este traço não funciona no glacial próximo turno do troll. O glacial troll morre apenas se iniciar o turno com 0 Pontos de Vida e não regenerar.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Perícias', 'Percepção +6', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 16', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('glacial-troll', 'Idiomas', 'Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'glacial-troll';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('glacial-troll', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O glacial troll realiza três ataques de Dilacerar Gélido. Pode substituir um ataque de Dilacerar Gélido com seu Sopro Gelado.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('glacial-troll', 'Dilacerar Gélido', 'action'::rpg.actor_action_bucket, 8, '14 (2d8 + 5) dano Cortante mais 4 (1d8) dano de Frio', 'Teste de ataque corpo a corpo: +8, alcance 3 m Acerto: 14 (2d8 + 5) dano Cortante mais 4 (1d8) dano de Frio.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('glacial-troll', 'Sopro Gelado (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 16, um alvo a até 1,5 m de it. Falha: 14 (3d6) dano de Frio, e o alvo fica impedido por 1 minuto por gelo se formando ao redor dele. Uma criatura com a condição impedido pode fazer a CD 16 teste de resistência de Força no fim de cada um de seus turnos to break free do ice, encerrando a condição impedido.', 3);

-- Wind Troll (wind-troll)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'wind-troll',
  'northlands-heroes-2024-en',
  'Wind Troll',
  'Pequeno Gigante, Caótico e Neutro',
  'Caótico e Neutro',
  'Gigante',
  'small',
  '6',
  3,
  16,
  105,
  '14d6 + 56',
  4,
  '{"forca":14,"destreza":18,"constituicao":18,"inteligencia":11,"sabedoria":12,"carisma":16}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'wind-troll';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('wind-troll', 'fly', 45);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('wind-troll', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'wind-troll';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wind-troll', 'Imunidades', 'Lightning, Thunder; surdo , exausto', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wind-troll', 'Regeneração', 'O wind troll regains 15 Pontos de Vida no início de cada um de seus turnos. Se o troll sofrer dano Ácido ou de Fogo, este traço não funciona no próximo turno do troll. O troll morre apenas se iniciar o turno com 0 pontos de vida e não regenerar.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wind-troll', 'Absorção de Tempestade', 'Whenever o wind troll é submetido a dano Elétrico ou Trovejante, recupera a number of Pontos de Vida igual ao dano Elétrico e Trovejante causado.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wind-troll', 'Perícias', 'Percepção +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wind-troll', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wind-troll', 'Idiomas', 'Gigante, Primordial (Auran)', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'wind-troll';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wind-troll', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O wind troll realiza três ataques, usando Dilacerar ou Golpe da Tempestade em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wind-troll', 'Dilacerar', 'action'::rpg.actor_action_bucket, 7, '11 (2d6 + 4) dano Cortante', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 11 (2d6 + 4) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wind-troll', 'Golpe da Tempestade', 'action'::rpg.actor_action_bucket, 7, '8 (1d8 + 4) dano Elétrico mais 4 (1d8) dano Trovejante', 'Teste de ataque à distância: +7, alcance 18 m. Acerto: 8 (1d8 + 4) dano Elétrico mais 4 (1d8) dano Trovejante. Se o alvo for uma criatura Média ou menor, fica caída.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wind-troll', 'Windstorm (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 15, cada criatura em um 6 metros radius ao redor do troll. Falha: 9 (2d8) dano Contundente mais 9 (2d8) dano Trovejante, e o alvo é empurrado até 3 m para longe de o troll. Sucesso: metade do dano apenas.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wind-troll', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O wind troll conjura uma das magias a seguir, sem exigir componentes materiais e usando Carisma como atributo de conjuração (CD de resistência a magia 14):', 5);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wind-troll', 'Investida Voadora', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O wind troll flies up to half seu deslocamento de voo.', 1);

-- Buried Lord Vaettir (buried-lord-vaettir)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'buried-lord-vaettir',
  'northlands-heroes-2024-en',
  'Buried Lord Vaettir',
  'Médio Morto-vivo, Leal e Mau',
  'Leal e Mau',
  'Morto-vivo',
  'medium',
  '4',
  2,
  16,
  90,
  '12d8 + 36',
  2,
  '{"forca":20,"destreza":15,"constituicao":16,"inteligencia":11,"sabedoria":12,"carisma":16}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'buried-lord-vaettir';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('buried-lord-vaettir', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'buried-lord-vaettir';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Imunidades', 'Necrotic, Poison; Charmed , exausto , amedrontado , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Aura de Autoridade', 'Enquanto estiver em uma emanacao de 3 m originada do senhor enterrado, os aliados do senhor enterrado têm vantagem em testes de ataque e testes de resistência, desde que o senhor enterrado não esteja incapacitado.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Sentido de Bens Funerários', 'O senhor enterrado pode localizar com precisão criaturas vestindo ou carregando um dos itens pessoais ou bens funerários do vættr a até 18 m dele, e o vættr pode sentir a direção geral de seus itens pessoais e bens funerários a até 1,6 km dele.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Rejuvenescimento', 'A destroyed buried lord vættr ganha um novo corpo em 24 horas, recuperando todos os seus Pontos de Vida e ficando ativo novamente. O novo corpo se forma em um espaço desocupado aleatório a até 30 m de onde caiu. Este traço não funciona Se o vættr é posto em descanso (geralmente devolvendo seus restos ao túmulo).', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Sensibilidade à Luz Solar', 'Enquanto estiver sob luz solar, O senhor enterrado vaettir tem desvantagem em teste de atributos e testes de ataque.', 3);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Perícias', 'Intimidação +5, Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Sentidos', 'Visão no escuro 18 m, Visão verdadeira 9 m; Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('buried-lord-vaettir', 'Idiomas', 'Os idiomas que conhecia em vida', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'buried-lord-vaettir';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O senhor enterrado vaettir realiza dois Longsword or two Longbow ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Espada Longa', 'action'::rpg.actor_action_bucket, 7, '14 (2d8 + 5) dano Cortante mais 3 (1d6) dano Necrótico', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 14 (2d8 + 5) dano Cortante mais 3 (1d6) dano Necrótico.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Arco Longo', 'action'::rpg.actor_action_bucket, 4, '11 (2d8 + 2) dano Perfurante', 'Teste de ataque à distância: +4, alcance 150/180 m. Acerto: 11 (2d8 + 2) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Sopro Cadavérico (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 13, cada criatura em um cone de 15 metros . Falha: O alvo fica envenenado por 1 minuto. It Repete o teste de resistência no fim de cada um de seus turnos, encerrando o efeito em si mesma se passar.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Olhar Desorientador', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Carisma: CD 13, uma criatura o senhor enterrado possa ver a até 9 m dele. Falha: Por 1 minuto, o alvo fica incapacitado e moves in a direção aleatória sempre que se move. It Repete o teste de resistência no fim de cada um de seus turnos, encerrando o efeito em si mesma se passar. Sucesso: O alvo tem imunidade a this do senhor enterrado Disorienting Gaze por 24 horas.', 5);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O senhor enterrado vaettir conjura uma das magias a seguir, sem exigir componentes materiais e usando Carisma como atributo de conjuração (CD de resistência a magia 13):', 6);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Caçador (2/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O senhor enterrado vaettir conjura Hunter''s Mark .', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('buried-lord-vaettir', 'Aparar', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o senhor enterrado vaettir is hit by a melee teste de ataque enquanto holding a weapon or shield. Resposta: o senhor enterrado vaettir adds 2 to sua CA contra aquele ataque, possivelmente fazendo errar.', 1);

-- Drowned Raider Vaettir (drowned-raider-vaettir)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'drowned-raider-vaettir',
  'northlands-heroes-2024-en',
  'Drowned Raider Vaettir',
  'Médio Morto-vivo, Caótico e Mau',
  'Caótico e Mau',
  'Morto-vivo',
  'medium',
  '3',
  2,
  14,
  65,
  '10d8 + 20',
  2,
  '{"forca":18,"destreza":11,"constituicao":14,"inteligencia":8,"sabedoria":12,"carisma":9}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'drowned-raider-vaettir';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('drowned-raider-vaettir', 'swim', 30);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('drowned-raider-vaettir', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'drowned-raider-vaettir';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Imunidades', 'Necrotic, Poison; Charmed , exausto , amedrontado , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Sentido de Bens Funerários', 'O saqueador afogado vættir pode localizar com precisão of criaturas vestindo ou carregando um dos itens pessoais ou bens funerários do vættr personal items or grave goods a até 18 m dele, e o vættr pode sentir a direção geral de seus itens pessoais e grave goods a até 1,6 km dele.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Rejuvenescimento', 'A destroyed saqueador afogado vættir ganha um novo corpo em 24 horas, recuperando todos os seus Pontos de Vida e ficando ativo novamente. O novo corpo se forma em um espaço desocupado aleatório a até 30 m de onde caiu. Este traço não funciona Se o vættir é posto em descanso (geralmente devolvendo seus restos ao túmulo).', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Sensibilidade à Luz Solar', 'Enquanto estiver sob luz solar, O drowned raider vaettir tem desvantagem em teste de atributos e testes de ataque.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Perícias', 'Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('drowned-raider-vaettir', 'Idiomas', 'Os idiomas que conhecia em vida', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'drowned-raider-vaettir';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drowned-raider-vaettir', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O drowned raider vaettir realiza dois ataques using Battleaxe or Javelin em qualquer combinação.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drowned-raider-vaettir', 'Machado de Batalha', 'action'::rpg.actor_action_bucket, 6, '10 (1d12 + 4) dano Cortante mais 3 (1d6) dano Necrótico', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 10 (1d12 + 4) dano Cortante mais 3 (1d6) dano Necrótico.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drowned-raider-vaettir', 'Azagaia', 'action'::rpg.actor_action_bucket, 6, '11 (2d6 + 4) dano Perfurante', 'Ataque corpo a corpo ou teste de ataque à distância: +6, alcance 1,5 m or alcance 30/36 m Acerto: 11 (2d6 + 4) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('drowned-raider-vaettir', 'Expurgar Água', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Destreza: CD 12, cada criatura em um 6 metros-long, 1.5 metros-linha larga . Falha: 7 (2d6) dano Necrótico, e o alvo fica envenenado até o fim de seu próximo turno. Sucesso: metade do dano apenas.', 4);

-- Vedaja (vedaja)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'vedaja',
  'northlands-heroes-2024-en',
  'Vedaja',
  NULL,
  'Neutro',
  'Constructo',
  'tiny',
  '2',
  2,
  14,
  33,
  '6d6 + 12',
  3,
  '{"forca":8,"destreza":16,"constituicao":15,"inteligencia":10,"sabedoria":12,"carisma":13}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'vedaja';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('vedaja', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'vedaja';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('vedaja', 'Imunidades', 'Veneno, Psíquico; Charmed , surdo , exausto , amedrontado , paralisado , petrificado , envenenado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('vedaja', 'Forma Imutável', 'A forma de um vedaja não pode ser alterada.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('vedaja', 'Resistência Mágica', 'O vedaja tem vantagem em testes de resistência contra magias e outros efeitos mágicos.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('vedaja', 'Perícias', 'Enganação +3, Percepção + 3, Furtividade + 5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('vedaja', 'Sentidos', 'Visão no escuro 18 m, Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('vedaja', 'Idiomas', 'compreende o language deles creator mais um outro idioma but não pode falar', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'vedaja';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('vedaja', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O vedaja realiza dois Hand ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('vedaja', 'Mão', 'action'::rpg.actor_action_bucket, 5, '7 (1d8 + 3) dano Contundente ou Perfurante (do vedaja choice)', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m Acerto: 7 (1d8 + 3) dano Contundente ou Perfurante (do vedaja choice).', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('vedaja', 'Olhar Aterrorizante', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 11, uma criatura o vedaja possa ver a até 9 m. Falha: O alvo fica amedrontado até o fim do próximo turno do vedaja. enquanto Amedrontado, o alvo fica paralisado.', 3);

-- Andahestur (andahestur)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'andahestur',
  'northlands-heroes-2024-en',
  'Andahestur',
  'Grande Celestial, Leal e Neutro',
  'Leal e Neutro',
  'Celestial',
  'large',
  '1',
  2,
  12,
  37,
  '5d10 +10',
  2,
  '{"forca":16,"destreza":14,"constituicao":14,"inteligencia":8,"sabedoria":12,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'andahestur';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('andahestur', 'fly', 60);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('andahestur', 'walk', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'andahestur';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('andahestur', 'Imunidades', 'amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('andahestur', 'Perícias', 'Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('andahestur', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('andahestur', 'Idiomas', 'Compreende Celestial e a Língua do Norte, mas não pode falar.', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'andahestur';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('andahestur', 'Cascos', 'action'::rpg.actor_action_bucket, 5, '7 (1d8 + 3) dano Contundente', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m, uma criatura. Acerto: 7 (1d8 + 3) dano Contundente.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('andahestur', 'Golpe Divino (3/dia)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o andahestur acerta com Cascos. Resposta: O Andahestur adiciona 7 (2d6) dano Radiante ao ataque que desencadeou a reação.', 1);

-- Moose (moose)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'moose',
  'northlands-heroes-2024-en',
  'Moose',
  'Grande Besta, Sem tendência',
  'Sem tendência',
  'Besta',
  'large',
  '1/2',
  2,
  13,
  22,
  '3d10 + 6',
  2,
  '{"forca":19,"destreza":10,"constituicao":14,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'moose';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('moose', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'moose';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('moose', 'Forest Walker', 'enquanto estiver em forest terrain, O moose tem vantagem em testes de Destreza (Furtividade).', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('moose', 'Perícias', 'Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('moose', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('moose', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'moose';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('moose', 'Cascos', 'action'::rpg.actor_action_bucket, 6, '8 (1d8 + 4) dano Contundente', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m, uma criatura. Acerto: 8 (1d8 + 4) dano Contundente. Se o alvo for uma criatura Grande ou menor e o alce moved 10+ feet em linha reta em direção a ele imediatamente before o acerto, o alvo sofre adicional de 3 (1d6) dano Contundente e fica caída.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('moose', 'Fury', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o moose sofre 5 ou mais de dano. Resposta: o moose tem vantagem em o próximo teste de ataque realiza before o fim deles próximo turno.', 1);

-- Reindeer (reindeer)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'reindeer',
  'northlands-heroes-2024-en',
  'Reindeer',
  'Grande Besta, Sem tendência',
  'Sem tendência',
  'Besta',
  'large',
  '1/4',
  2,
  12,
  15,
  '2d10 + 4',
  2,
  '{"forca":14,"destreza":16,"constituicao":14,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'reindeer';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('reindeer', 'walk', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'reindeer';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('reindeer', 'Agile', 'A rena não provoca Ataques de Oportunidade quando sai do alcance de um inimigo.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('reindeer', 'Snowstrider', 'Snow e ice are not Terreno Difícil for o reindeer.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('reindeer', 'Perícias', 'Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('reindeer', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('reindeer', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'reindeer';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('reindeer', 'Cascos', 'action'::rpg.actor_action_bucket, 4, '7 (1d8 + 2) dano Contundente', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m, uma criatura. Acerto: 7 (1d8 + 2) dano Contundente.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('reindeer', 'Rajada de Velocidade (3/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'do reindeer Speed doubles até o início de seu próximo turno.', 1);

-- Sea Serpent (sea-serpent)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'sea-serpent',
  'northlands-heroes-2024-en',
  'Sea Serpent',
  'Enorme Besta, Sem tendência',
  'Sem tendência',
  'Besta',
  'huge',
  '3',
  2,
  13,
  76,
  '9d10 + 27',
  3,
  '{"forca":22,"destreza":16,"constituicao":16,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'sea-serpent';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('sea-serpent', 'swim', 50);
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('sea-serpent', 'walk', 0);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'sea-serpent';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-serpent', 'Constrictor', 'quando o sea serpent hits com its ataque de Mordida, it may make a Constrict ataque as a Ação Bônus.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-serpent', 'Perícias', 'Percepção +3, Furtividade +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-serpent', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sea-serpent', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'sea-serpent';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sea-serpent', 'Mordida', 'action'::rpg.actor_action_bucket, 8, '19 (3d8 + 6) dano Perfurante', 'Teste de ataque corpo a corpo: +8, alcance 3 m, uma criatura. Acerto: 19 (3d8 + 6) dano Perfurante.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sea-serpent', 'Constritor', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 14, uma criatura Enorme ou menor o serpent possa ver a até 3 m. Falha: 10 (4d4) dano Contundente, e o alvo fica agarrado (CD para escapar 16).', 2);

-- Sleipnirspringr (sleipnirspringr)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'sleipnirspringr',
  'northlands-heroes-2024-en',
  'Sleipnirspringr',
  'Grande Monstruosidade, Caótico e Neutro',
  'Caótico e Neutro',
  'Monstruosidade',
  'large',
  '4',
  2,
  14,
  59,
  '7d10 +21',
  5,
  '{"forca":17,"destreza":16,"constituicao":17,"inteligencia":7,"sabedoria":8,"carisma":14}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'sleipnirspringr';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('sleipnirspringr', 'walk', 60);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'sleipnirspringr';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sleipnirspringr', 'Preternatural Balance', 'Sleipnirspringr automatically succeed on testes de resistência contra o condição caído, e they cannot be Pushed or Pulled through nonmagical means.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sleipnirspringr', 'Perícias', 'Percepção +1, Intuição +1', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sleipnirspringr', 'Sentidos', 'Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('sleipnirspringr', 'Idiomas', 'Nenhum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'sleipnirspringr';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sleipnirspringr', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O horse realiza 3 Hoof ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sleipnirspringr', 'Casco', 'action'::rpg.actor_action_bucket, 5, '12 (2d8 + 3) dano Contundente', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m, uma criatura. Acerto: 12 (2d8 + 3) dano Contundente.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('sleipnirspringr', 'Trickster Spawn', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O horse pode usar a Ação Bônus realizar a ação Disparada, Disengage, ou Esquivar.', 1);

-- Boreas’s Chosen (boreass-chosen)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'boreass-chosen',
  'northlands-heroes-2024-en',
  'Boreas’s Chosen',
  'Médio ou Pequeno Humanoide, Any Evil',
  'Any Evil',
  'Humanoide',
  'medium',
  '7',
  3,
  15,
  102,
  '12d8 + 48',
  2,
  '{"forca":17,"destreza":14,"constituicao":19,"inteligencia":8,"sabedoria":14,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'boreass-chosen';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('boreass-chosen', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'boreass-chosen';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('boreass-chosen', 'Imunidades', 'Cold', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('boreass-chosen', 'Ice Walk', 'O chosen moves across e climbs icy surfaces without needing to make an teste de atributo. Additionally, snow e ice are not Terreno Difícil for o chosen.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('boreass-chosen', 'Perícias', 'Atletismo +6, Intimidação +6, Sobrevivência +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('boreass-chosen', 'Sentidos', 'Percepção passiva 12', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('boreass-chosen', 'Idiomas', 'Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'boreass-chosen';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('boreass-chosen', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O chosen realiza dois Spear ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('boreass-chosen', 'Lança', 'action'::rpg.actor_action_bucket, 7, '12 (2d8 + 3) dano Perfurante mais 7 (2d6) dano de Frio', 'Ataque corpo a corpo ou teste de ataque à distância: +7, alcance 1,5 m, or alcance 20/18 m Acerto: 12 (2d8 + 3) dano Perfurante mais 7 (2d6) dano de Frio.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('boreass-chosen', 'Sopro do Vento Norte (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 14, cada criatura em um cone de 15 metros . Falha: 28 (8d6) dano de Frio, e O deslocamento do alvo é reduzido by 3 m até o fim de seu próximo turno. Uma criatura que falhar no teste de resistência por 5 ou mais fica petrificado, fica sepultado no gelo até o fim de seu próximo turno instead. Sucesso: metade do dano apenas.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('boreass-chosen', 'Sangue Congelante', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o chosen é atingido por um ataque. Resposta: criaturas a até 1,5 m do chosen take 4 (1d8) dano de Frio.', 1);

-- Frost-Afflicted (frost-afflicted)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'frost-afflicted',
  'northlands-heroes-2024-en',
  'Frost-Afflicted',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '3',
  2,
  15,
  65,
  '10d8 + 48',
  2,
  '{"forca":13,"destreza":14,"constituicao":12,"inteligencia":12,"sabedoria":17,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'frost-afflicted';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('frost-afflicted', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'frost-afflicted';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('frost-afflicted', 'Imunidades', 'Cold; petrificado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('frost-afflicted', 'Gelo Flamejante', 'Uma criatura com resistência a dano de Frio não tem resistência ao dano de Frio causado pelo aflito pelo gelo. Uma criatura com imunidade a dano de Frio não é afetada por este traço.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('frost-afflicted', 'Iced Skin', 'Uma criatura que hits o frost-afflicted com um ataque corpo a corpo enquanto um até 1,5 m de sofre 4 (1d8) dano Perfurante.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('frost-afflicted', 'Perícias', 'Intimidação +6, Sobrevivência +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('frost-afflicted', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('frost-afflicted', 'Idiomas', 'Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'frost-afflicted';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('frost-afflicted', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O frost-afflicted realiza dois ataques, usando Frigid Punch ou Frost Bolt em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('frost-afflicted', 'Frigid Punch', 'action'::rpg.actor_action_bucket, 4, '7 (2d4 + 2) dano Contundente mais 5 (2d4) dano de Frio', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 7 (2d4 + 2) dano Contundente mais 5 (2d4) dano de Frio.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('frost-afflicted', 'Frost Bolt', 'action'::rpg.actor_action_bucket, 4, '13 (2d10 + 2) dano de Frio', 'Teste de ataque à distância: +4, alcance 18 m Acerto: 13 (2d10 + 2) dano de Frio.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('frost-afflicted', 'Clarão Glacial (Recarga 5–6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Constituição: CD 12, cada criatura a até 1,5 m do frost-afflicted. Falha: O alvo sofre 4 (1d8) dano de Frio, e seu deslocamento is reduced by 10 até o fim do próximo turno do frost-afflicted.', 1);

-- Huskarl (huskarl)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'huskarl',
  'northlands-heroes-2024-en',
  'Huskarl',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '2',
  2,
  18,
  60,
  '8d8 + 24',
  1,
  '{"forca":15,"destreza":12,"constituicao":16,"inteligencia":12,"sabedoria":14,"carisma":1}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'huskarl';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('huskarl', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'huskarl';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('huskarl', 'Perícias', 'Atletismo +4, Intimidação +3, Percepção +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('huskarl', 'Sentidos', 'Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('huskarl', 'Idiomas', 'Comum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'huskarl';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('huskarl', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O huskarl realiza dois ataques, usando Battle Axe e Javelin em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('huskarl', 'Battle Axe', 'action'::rpg.actor_action_bucket, 4, '7 (1d10 + 2) dano Cortante', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 7 (1d10 + 2) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('huskarl', 'Azagaia', 'action'::rpg.actor_action_bucket, 4, '6 (1d8 + 2) dano Perfurante', 'Ataque corpo a corpo ou teste de ataque à distância: +4, alcance 1,5 m or alcance 30/36 m Acerto: 6 (1d8 + 2) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('huskarl', 'Interpose', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: um ally a até 1,5 m de O huskarl sofre dano. Resposta: o huskarl sofre o dano instead.', 1);

-- Jarl (jarl)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'jarl',
  'northlands-heroes-2024-en',
  'Jarl',
  'Médio ou Pequeno Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '7',
  3,
  18,
  112,
  '15d8 + 45',
  2,
  '{"forca":18,"destreza":15,"constituicao":16,"inteligencia":13,"sabedoria":12,"carisma":16}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'jarl';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('jarl', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'jarl';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Imunidades', 'Charmed , amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Aura de Comando', 'o jarl e Criaturas amistosas a até 3 m de it não podem ficar enfeitiçado ou amedrontado enquanto o jarl não estiver incapacitado .', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Fortaleza Mental', 'O jarl tem imunidade a any effect que sentiria suas emoções ou leria seus pensamentos. Além disso, tem vantagem em testes de Sabedoria (Intuição) made to ascertain a intenções ou sinceridade de uma criatura.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Líder Resiliente (Recarrega após Descanso Curto ou Longo)', 'Se o jarl falha em um teste de resistência, Pode rerrolar o dado e deve usar a nova rolagem.', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Perícias', 'Atletismo +7, Percepção + 4, Persuasão +6', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Sentidos', 'Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('jarl', 'Idiomas', 'Comum, mais three other idiomas.', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'jarl';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jarl', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O jarl realiza três ataques, usando Longsword e Arco Longo em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jarl', 'Espada Longa', 'action'::rpg.actor_action_bucket, 7, '8 (1d8 + 4) dano Cortante mais 7 (2d6) dano de Força', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 8 (1d8 + 4) dano Cortante mais 7 (2d6) dano de Força.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jarl', 'Arco Longo', 'action'::rpg.actor_action_bucket, 5, '7 (1d8 + 2) dano Perfurante mais 7 (2d6) dano de Força', 'Teste de ataque à distância: +5, alcance 150/180 m. Acerto: 7 (1d8 + 2) dano Perfurante mais 7 (2d6) dano de Força.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jarl', 'Loyal Heroism', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'o jarl inspires up to two Criaturas amistosas que possa ver a até 9 m dele. cada alvo tem vantagem em o próximo teste de ataque ou teste de resistência que realizar antes de o início do próximo turno do jarl.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('jarl', 'Evade', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o jarl is Ferido e é atingido por um ataque. Resposta: o jarl adiciona 3 à CA contra aquele ataque. If that causes o ataque to miss, o jarl can move up to half seu deslocamento para longe de o atacante without provoking Ataques de Oportunidade .', 1);

-- Merchant (merchant)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'merchant',
  'northlands-heroes-2024-en',
  'Merchant',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '3',
  2,
  14,
  55,
  '10d8 + 10',
  3,
  '{"forca":15,"destreza":8,"constituicao":14,"inteligencia":6,"sabedoria":10,"carisma":6}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'merchant';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('merchant', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'merchant';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant', 'Trader''s Eye', 'O merchant tem vantagem em testes de Inteligência (Investigação) to determine if goods are of poor quality or a forgery, e tem vantagem em testes de Sabedoria (Intuição) to recognize quando um criatura is attempting to sell it poor quality or forged goods.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant', 'Perícias', 'Intuição +3, Persuasão +5, Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant', 'Idiomas', 'Comum, mais dois outros idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'merchant';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O chosen realiza dois ataques, usando Shortsword ou Quip em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant', 'Espada Curta', 'action'::rpg.actor_action_bucket, 5, '12 (2d8 + 3) dano Perfurante', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m Acerto: 12 (2d8 + 3) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant', 'Réplica', 'action'::rpg.actor_action_bucket, 5, '13 (3d6 + 3) dano Psíquico', 'Teste de ataque à distância: +5, alcance 18 m Acerto: 13 (3d6 + 3) dano Psíquico.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant', 'Best Bargain', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Carisma: CD 13, a criatura o mercador possa ver a até 9 m dele. Falha: O alvo is Enfeitiçado até o início do próximo turno do merchant.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant', 'Chamar Reforços (1/dia)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura hits o mercador com an ataque enquanto estiver em a populated area. Resposta: On Initiative count 20 seguintes round, 1d4 bandits or 1d4 guards (do merchant choice) arrive, acting as allies do merchant e defending it to o best of their abilities. O called allies remain por 1 hora, até o mercador dies, or até o mercador dismisses them as a Ação Bônus.', 1);

-- Merchant Captain (merchant-captain)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'merchant-captain',
  'northlands-heroes-2024-en',
  'Merchant Captain',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '6',
  3,
  16,
  102,
  '12d8 + 48',
  3,
  '{"forca":11,"destreza":16,"constituicao":18,"inteligencia":16,"sabedoria":12,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'merchant-captain';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('merchant-captain', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'merchant-captain';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant-captain', 'Trader''s Eye', 'O merchant tem vantagem em testes de Inteligência (Investigação) to determine if goods are of poor quality or a forgery, e tem vantagem em testes de Sabedoria (Intuição) to recognize quando um criatura is attempting to sell it poor quality or forged goods.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant-captain', 'Perícias', 'Intuição +4, Persuasão +7, Percepção +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant-captain', 'Sentidos', 'Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('merchant-captain', 'Idiomas', 'Comum, mais three other idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'merchant-captain';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant-captain', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O merchant captain realiza quatro ataques, usando Shortsword ou Quip em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant-captain', 'Espada Curta', 'action'::rpg.actor_action_bucket, 6, '12 (2d8 + 3) dano Perfurante', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 12 (2d8 + 3) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant-captain', 'Réplica', 'action'::rpg.actor_action_bucket, 7, '14 (3d6 + 4) dano Psíquico', 'Teste de ataque à distância: +7, alcance 18 m Acerto: 14 (3d6 + 4) dano Psíquico.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant-captain', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O merchant captain conjura uma das magias a seguir, usando Carisma como atributo de conjuração (CD de resistência a magia 15):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant-captain', 'Conversa Rápida', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Carisma: CD 15, a criatura o capitão mercador possa ver a até 9 m dele. Falha: O alvo tem desvantagem em o próximo teste de ataque ou teste de resistência que realizar antes de o início do merchant próximo turno do captain.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('merchant-captain', 'Gracejo (4/dia)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura a até 9 m do merchant captain fails an teste de ataque, teste de atributo or teste de resistência. Resposta: o criatura rerolls o rolagem que disparou e deve usar o novo resultado.', 1);

-- Northern Hunter (northern-hunter)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'northern-hunter',
  'northlands-heroes-2024-en',
  'Northern Hunter',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '10',
  4,
  17,
  171,
  '18d8 + 90',
  3,
  '{"forca":20,"destreza":16,"constituicao":20,"inteligencia":14,"sabedoria":16,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'northern-hunter';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('northern-hunter', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'northern-hunter';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('northern-hunter', 'Imunidades', 'amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('northern-hunter', 'Rastreador Ártico', 'O Northern hunter tem vantagem em testes de Sabedoria (Sobrevivência) para rastrear criaturas em floresta, pradaria fria e terreno glacial. Além disso, Terreno Difícil composto principalmente de neve ou gelo não custa o caçador do norte movimento extra.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('northern-hunter', 'Perícias', 'Atletismo +9, Intuição +7, Percepção +7, Sobrevivência +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('northern-hunter', 'Sentidos', 'Percepção passiva 12', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('northern-hunter', 'Idiomas', 'Comum, mais dois outros idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'northern-hunter';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('northern-hunter', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O Northern hunter realiza quatro ataques, usando Arco Longo ou Lança em qualquer combinação caçador pode escolher causar dano de Força em vez do tipo de dano normal da arma.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('northern-hunter', 'Arco Longo', 'action'::rpg.actor_action_bucket, 7, '12 (2d8 + 3) dano Perfurante mais 3 (1d6) dano Venenoso', 'Teste de ataque à distância: +7, alcance 80/96 m Acerto: 12 (2d8 + 3) dano Perfurante mais 3 (1d6) dano Venenoso. O deslocamento do alvo é reduzido by 3 m até o início do próximo turno do hunter. Reduções múltiplas não são cumulativas.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('northern-hunter', 'Lança', 'action'::rpg.actor_action_bucket, 9, '12 (2d6 + 5) dano Cortante', 'Ataque corpo a corpo ou teste de ataque à distância: +9, alcance 1,5 m Acerto: 12 (2d6 + 5) dano Cortante. O alvo tem desvantagem em its next teste de ataque before o início do Northern próximo turno do Hunter.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('northern-hunter', 'Matador (3/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'o próximo ataque o caçador do norte realiza ignora todas as resistências e imunidades a dano.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('northern-hunter', 'Caçador Veloz', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'o caçador do norte moves up to seu deslocamento toward a criatura hostil que possa ver.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('northern-hunter', 'Sem Escapatória', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura o caçador do norte possa ver a até 12 m dele moves into a space more than 3 m para longe de it. Resposta: Teste de resistência de Força: CD 16, o hunter flings a bola, tangle of rope, or similar object at a criatura. falha : O alvo fica caída.', 1);

-- Shaman (shaman)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'shaman',
  'northlands-heroes-2024-en',
  'Shaman',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '4',
  2,
  15,
  84,
  '13d8 + 26',
  1,
  '{"forca":14,"destreza":13,"constituicao":14,"inteligencia":10,"sabedoria":16,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'shaman';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('shaman', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'shaman';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('shaman', 'Perícias', 'Enganação +3, Medicina +5, Percepção +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('shaman', 'Sentidos', 'Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('shaman', 'Idiomas', 'Comum, mais um outro idioma', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'shaman';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shaman', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O shaman realiza três ataques, usando Ritual Staff ou Cursed Bolt em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shaman', 'Ritual Staff', 'action'::rpg.actor_action_bucket, 4, '6 (1d8 + 2) dano Contundente mais 7 (2d6) dano Venenoso', 'Ataque corpo a corpo com arma: +4, alcance 1,5 m, um alvo. Acerto: 6 (1d8 + 2) dano Contundente mais 7 (2d6) dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shaman', 'Cursed Bolt', 'action'::rpg.actor_action_bucket, 5, '10 (2d6 + 3) dano Necrótico, e o alvo fica envenenado até o fim de seu próximo turno', 'Ataque à distância com magia: +5, alcance 18 m, um alvo. Acerto: 10 (2d6 + 3) dano Necrótico, e o alvo fica envenenado até o fim de seu próximo turno.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shaman', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O shaman conjura uma das magias a seguir, usando Sabedoria como atributo de conjuração (CD de resistência a magia 15):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shaman', 'Inspire Ferocity (Recarga 4–6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O shaman inspires ferocity in up to three criaturas que possa ver. Those alvos têm vantagem em testes de ataque e testes de resistência até o fim do próximo turno do shaman e gain 10 pontos de vida temporários .', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shaman', 'Absorção Elemental Menor (3/dia)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o xamã sofre dano Ácido, de Frio, Fogo, Elétrico ou Trovejante. Resposta: o xamã concede a si resistência àquela instância de dano.', 1);

-- Shield-Maiden (shield-maiden)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'shield-maiden',
  'northlands-heroes-2024-en',
  'Shield-Maiden',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '3',
  2,
  16,
  65,
  '10d8 + 20',
  2,
  '{"forca":16,"destreza":14,"constituicao":14,"inteligencia":10,"sabedoria":12,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'shield-maiden';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('shield-maiden', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'shield-maiden';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('shield-maiden', 'Perícias', 'Intimidação +3, Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('shield-maiden', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('shield-maiden', 'Idiomas', 'Comum, mais um outro idioma', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'shield-maiden';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shield-maiden', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O shield-maiden realiza três ataques, usando Longsword ou Javelin em qualquer combinação O shield maiden can replace one ataque com Shield Bash.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shield-maiden', 'Espada Longa', 'action'::rpg.actor_action_bucket, 5, '7 (1d8 + 3) dano Cortante', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m Acerto: 7 (1d8 + 3) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shield-maiden', 'Azagaia', 'action'::rpg.actor_action_bucket, 5, '6 (1d6 + 3) dano Perfurante', 'Teste de ataque à distância: +5, alcance 30/36 m Acerto: 6 (1d6 + 3) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shield-maiden', 'Shield Bash', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Força: CD 12, uma criatura a até 1.5 m that o shield-maiden possa ver. Falha: 5 (1d4 + 3) dano Contundente. Se o alvo for uma criatura Média ou menor, fica caída.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shield-maiden', 'Chamado às Armas (Recarga 6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Up to three criaturas do shield-maiden''s choice that are a até 9 m de her e can hear her gain vantagem em testes de ataque até o início do próximo turno do shield-maiden.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('shield-maiden', 'Interpose Shield', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura a até 1,5 m do shield-maiden is hit by a melee teste de ataque. Resposta: o alvo adds 2 to sua CA contra aquele ataque, possivelmente fazendo errar. Se o ataque misses, O shield-maiden pode fazer one ataque com arma contra o attacker.', 1);

-- Skald (skald)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'skald',
  'northlands-heroes-2024-en',
  'Skald',
  'Médio ou Pequeno Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '5',
  3,
  14,
  97,
  '15d8 + 30',
  3,
  '{"forca":10,"destreza":16,"constituicao":14,"inteligencia":14,"sabedoria":12,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'skald';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('skald', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'skald';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skald', 'Perícias', 'Enganação +7, História +5, Percepção + 4, Performance +7, Persuasão +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skald', 'Sentidos', 'Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('skald', 'Idiomas', 'Comum mais um outro idioma', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'skald';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skald', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skald realiza dois Shortword or two Shortbow ataques.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skald', 'Espada Curta', 'action'::rpg.actor_action_bucket, 6, '10 (2d6 + 3) dano Perfurante', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 10 (2d6 + 3) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skald', 'Arco Curto', 'action'::rpg.actor_action_bucket, 6, '10 (2d6 + 3) dano Perfurante', 'Teste de ataque à distância: +6, alcance 80/96 m. Acerto: 10 (2d6 + 3) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skald', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O skald conjura uma das magias a seguir, sem exigir componentes materiais e usando Carisma como atributo de conjuração (CD de resistência a magia 15):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('skald', 'Heroic Oration (Recarga 5–6)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'One criatura do skald''s choice a até 9 m dele that can hear tem vantagem em testes de ataque e teste de atributos até o início do próximo turno do skald.', 1);

-- Berserker Trollkin (berserker-trollkin)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'berserker-trollkin',
  'northlands-heroes-2024-en',
  'Berserker Trollkin',
  'Médio Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '8',
  3,
  16,
  136,
  '16d8 + 64',
  2,
  '{"forca":18,"destreza":15,"constituicao":18,"inteligencia":10,"sabedoria":12,"carisma":11}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'berserker-trollkin';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('berserker-trollkin', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'berserker-trollkin';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('berserker-trollkin', 'Imunidades', 'Charmed , amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('berserker-trollkin', 'Ferido Frenzy', 'enquanto Ferido, O trollkin tem vantagem em testes de ataque e testes de resistência.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('berserker-trollkin', 'Regeneração', 'O trollkin recupera 5 pontos de vida no início do turno dele. Se o trollkin sofrer dano Ácido ou de Fogo, este traço não funciona no início do próximo turno do trollkin. O trollkin morre apenas se iniciar o turno com 0 pontos de vida e não regenerar.', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('berserker-trollkin', 'Perícias', 'Atletismo +7, Intimidação +3, Percepção +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('berserker-trollkin', 'Sentidos', 'Visão no escuro 18 m; Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('berserker-trollkin', 'Idiomas', 'Comum, Gigante', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'berserker-trollkin';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('berserker-trollkin', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O trollkin berserker realiza quatro ataques, usando Freezing Bryntroll ou Freezing Handaxe em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('berserker-trollkin', 'Bryntroll Congelante', 'action'::rpg.actor_action_bucket, 7, '10 (1d12 + 4) dano Cortante mais 4 (1d8) dano de Frio', 'Teste de ataque corpo a corpo: +7, alcance 3 m Acerto: 10 (1d12 + 4) dano Cortante mais 4 (1d8) dano de Frio. Uma vez por rodada, se o berserker acertar com sua bryntroll, pode fazer um teste de ataque corpo a corpo com a arma contra uma segunda criatura a até 1,5 m da primeira, e que esteja ao alcance. Em um acerto, A segunda criatura sofre 13 (2d12) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('berserker-trollkin', 'Machado de Mão Congelante', 'action'::rpg.actor_action_bucket, 7, '7 (1d6 + 4) dano Cortante mais 4 (1d8) dano de Frio', 'Ataque corpo a corpo ou teste de ataque à distância: +7, alcance 1,5 m or alcance 20/18 m. Acerto: 7 (1d6 + 4) dano Cortante mais 4 (1d8) dano de Frio.', 3);

-- Trollkin Raider (trollkin-raider)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'trollkin-raider',
  'northlands-heroes-2024-en',
  'Trollkin Raider',
  'Médio Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '1',
  2,
  14,
  39,
  '6d8 + 12',
  1,
  '{"forca":16,"destreza":12,"constituicao":15,"inteligencia":9,"sabedoria":12,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'trollkin-raider';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('trollkin-raider', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'trollkin-raider';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('trollkin-raider', 'Regeneração', 'O trollkin recupera 5 PV no início do turno dele. Se o trollkin sofrer dano Ácido ou de Fogo, este traço não funciona no início do próximo turno do trollkin. O trollkin morre apenas se iniciar o turno com 0 PV e não regenerar.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('trollkin-raider', 'Perícias', 'Atletismo +5, Intimidação +2, Sobrevivência +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('trollkin-raider', 'Sentidos', 'Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('trollkin-raider', 'Idiomas', 'Comum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'trollkin-raider';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('trollkin-raider', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O trollkin realiza dois ataques, usando Lança e Arco Longo em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('trollkin-raider', 'Lança', 'action'::rpg.actor_action_bucket, 5, '6 (1d6 + 3) dano Perfurante', 'Ataque corpo a corpo ou teste de ataque à distância: +5, alcance 1,5 m or alcance 20/18 m Acerto: 6 (1d6 + 3) dano Perfurante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('trollkin-raider', 'Arco Longo', 'action'::rpg.actor_action_bucket, 3, '5 (1d8 + 1) dano Perfurante', 'Teste de ataque à distância: +3, alcance 150/180 m. Acerto: 5 (1d8 + 1) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('trollkin-raider', 'Aim', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O raider tem vantagem em o próximo ranged teste de ataque realiza during o turno atual.', 1);

-- Viking (viking)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'viking',
  'northlands-heroes-2024-en',
  'Viking',
  'Médio ou Pequeno Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '1',
  2,
  14,
  39,
  '6d8 + 12',
  1,
  '{"forca":16,"destreza":13,"constituicao":15,"inteligencia":9,"sabedoria":12,"carisma":10}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'viking';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('viking', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'viking';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('viking', 'Táticas de Matilha', 'O viking tem vantagem em um teste de ataque contra uma criatura if at least um dos aliados do viking is a até 1,5 m de a criatura e o aliado não tem a condição incapacitado.', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('viking', 'Perícias', 'Atletismo +5, Intimidação +2', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('viking', 'Sentidos', 'Percepção passiva 11', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('viking', 'Idiomas', 'Comum', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'viking';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('viking', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O viking realiza dois ataques, usando Battleaxe e Arco Longo em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('viking', 'Machado de Batalha', 'action'::rpg.actor_action_bucket, 5, '7 (1d8 + 3) dano Cortante', 'Teste de ataque corpo a corpo: +5, alcance 1,5 m Acerto: 7 (1d8 + 3) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('viking', 'Arco Curto', 'action'::rpg.actor_action_bucket, 3, '5 (1d6 + 1) dano Perfurante', 'Teste de ataque à distância: +3, alcance 80/96 m. Acerto: 5 (1d6 + 1) dano Perfurante.', 3);

-- Wandering Druid (wandering-druid)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'wandering-druid',
  'northlands-heroes-2024-en',
  'Wandering Druid',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '6',
  3,
  17,
  84,
  '13d8 + 26',
  3,
  '{"forca":13,"destreza":16,"constituicao":14,"inteligencia":12,"sabedoria":18,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'wandering-druid';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('wandering-druid', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'wandering-druid';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wandering-druid', 'Golpe Primal', 'Uma vez em cada um de seus turnos, quando o druida acerta uma criatura com um ataque, causa adicional de 1d8 de dano de Frio, Fogo, Elétrico ou Trovejante (escolhido no acerto).', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wandering-druid', 'Perícias', 'Adestrar Animais +7, Intuição +7, Medicina +7, Percepção +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wandering-druid', 'Sentidos', 'Percepção passiva 17', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('wandering-druid', 'Idiomas', 'Comum, mais um outro idioma', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'wandering-druid';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O druid realiza três ataques, ou conjura uma magia.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Presa e Garra (Apenas Forma Selvagem)', 'action'::rpg.actor_action_bucket, 7, NULL, 'Teste de ataque corpo a corpo : +7, alcance 1,5 m Acerto: 17 (4d6 + 3) dano Radiante, e o alvo fica caída.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Machado de Mão (Apenas Forma Humanoide)', 'action'::rpg.actor_action_bucket, 4, '8 (2d6 + 1) dano Cortante', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 8 (2d6 + 1) dano Cortante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Arco Curto (Apenas Forma Humanoide)', 'action'::rpg.actor_action_bucket, 6, '10 (2d6 + 3) dano Perfurante', 'Teste de ataque à distância: +6, alcance 80/96 m Acerto: 10 (2d6 + 3) dano Perfurante.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Raio Verdejante', 'action'::rpg.actor_action_bucket, 7, '14 (3d6 + 4) dano Radiante', 'Teste de ataque à distância: +7, alcance 27 m Acerto: 14 (3d6 + 4) dano Radiante.', 5);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Conjuração (Apenas Forma Humanoide)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O druid conjura uma das magias a seguir, usando Sabedoria como atributo de conjuração (CD de resistência a magia 15):', 6);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('wandering-druid', 'Forma Selvagem', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O druid shapeshifts into a forma de besta or back to forma humanoide. Suas estatísticas de jogo são os mesmos em cada forma, exceto onde indicado. Qualquer equipamento que está vestindo ou carregando é absorvido em seu corpo quando shifts into forma de besta. quando o druid shifts into a forma de besta, ganha 18 pontos de vida temporários .', 1);

-- War Chaplain (war-chaplain)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'war-chaplain',
  'northlands-heroes-2024-en',
  'War Chaplain',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '3',
  2,
  16,
  65,
  '10d8 + 20',
  0,
  '{"forca":14,"destreza":10,"constituicao":14,"inteligencia":11,"sabedoria":14,"carisma":11}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'war-chaplain';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('war-chaplain', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'war-chaplain';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('war-chaplain', 'Perícias', 'Medicina +4, Percepção +4, Persuasão +4', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('war-chaplain', 'Sentidos', 'Percepção passiva 14', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('war-chaplain', 'Idiomas', 'Comum, mais dois outros idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'war-chaplain';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('war-chaplain', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O chosen realiza dois ataques, usando Longsword ou Radiant Bolt em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('war-chaplain', 'Espada Longa', 'action'::rpg.actor_action_bucket, 4, '6 (1d8 + 2) dano Perfurante mais 7 (2d6) dano Radiante', 'Teste de ataque corpo a corpo: +4, alcance 1,5 m Acerto: 6 (1d8 + 2) dano Perfurante mais 7 (2d6) dano Radiante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('war-chaplain', 'Raio Radiante', 'action'::rpg.actor_action_bucket, 4, '13 (2d10 + 2) dano Radiante', 'Teste de ataque à distância: +4, alcance 27 m Acerto: 13 (2d10 + 2) dano Radiante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('war-chaplain', 'War God''s Healing (Recarga 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'One ally a até 9 m do chaplain regains 10 (3d6) Pontos de Vida.', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('war-chaplain', 'Ordens Divinas', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O war chaplain commands an ally a até 9 m. O alvo pode usar its Reação to make one ataque contra uma criatura o chaplain attacked this round.', 1);

-- Warlord (warlord)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'warlord',
  'northlands-heroes-2024-en',
  'Warlord',
  'Médio ou Pequeno Humanoide, Neutro',
  'Neutro',
  'Humanoide',
  'medium',
  '5',
  3,
  18,
  112,
  '15d8 + 45',
  2,
  '{"forca":18,"destreza":15,"constituicao":16,"inteligencia":11,"sabedoria":14,"carisma":16}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'warlord';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('warlord', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'warlord';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warlord', 'Perícias', 'Atletismo +7, Intimidação +6, Percepção +5', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warlord', 'Sentidos', 'Percepção passiva 15', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warlord', 'Idiomas', 'Comum, mais um outro idioma', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'warlord';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warlord', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O warlord realiza três ataques, usando Battleaxe ou Arco Longo em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warlord', 'Machado de Batalha', 'action'::rpg.actor_action_bucket, 7, '13 (2d8 + 4) dano Cortante', 'Teste de ataque corpo a corpo: +7, alcance 1,5 m Acerto: 13 (2d8 + 4) dano Cortante.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warlord', 'Arco Longo', 'action'::rpg.actor_action_bucket, 5, '11 (2d8 + 2) dano Perfurante', 'Teste de ataque à distância: +5, alcance 150/180 m Acerto: 11 (2d8 + 2) dano Perfurante.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warlord', 'Comandar', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O warlord orders one ally a até 18 m that possa ver e hear o warlord. O ally can imediatamente use its Reação to make a melee or ranged ataque com arma contra um alvo o warlord chooses.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warlord', 'Intimidate', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Teste de resistência de Sabedoria: CD 14, uma criatura o warlord possa ver a até 9 m. Falha: O alvo tem desvantagem em testes de ataque até o início do próximo turno do warlord.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warlord', 'Reflexive Strike', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o warlord é atingido por um ataque roll. Resposta: o warlord pode fazer one Battle Axe ataque contra o attacker. Em um acerto, o atacante deve passar em um CD 15 testes de Força (Atletismo) or have o condição caído.', 1);

-- Warpriest (warpriest)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'warpriest',
  'northlands-heroes-2024-en',
  'Warpriest',
  'Médio ou Pequeno Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '8',
  3,
  18,
  142,
  '19d8 + 57',
  0,
  '{"forca":16,"destreza":10,"constituicao":16,"inteligencia":11,"sabedoria":18,"carisma":12}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'warpriest';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('warpriest', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'warpriest';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warpriest', 'Imunidades', 'amedrontado', 0);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warpriest', 'Perícias', 'Religião +3, Medicina +7, Percepção +7', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warpriest', 'Sentidos', 'Percepção passiva 17', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('warpriest', 'Idiomas', 'Comum mais dois outros idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'warpriest';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warpriest', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O warpriest realiza três ataques, usando Blessed Warhammer ou Divine Flame em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warpriest', 'Martelo de Guerra Abençoado', 'action'::rpg.actor_action_bucket, 6, '7 (1d8 + 3) dano Contundente mais 13 (3d8) dano Radiante ou Necrótico (escolha do sacerdote de guerra)', 'Teste de ataque corpo a corpo: +6, alcance 1,5 m Acerto: 7 (1d8 + 3) dano Contundente mais 13 (3d8) dano Radiante ou Necrótico (escolha do sacerdote de guerra).', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warpriest', 'Chama Divina', 'action'::rpg.actor_action_bucket, 7, '18 (4d6 + 4) dano Radiante ou Necrótico (escolha do sacerdote de guerra)', 'Teste de ataque à distância: +7, alcance 36 m Acerto: 18 (4d6 + 4) dano Radiante ou Necrótico (escolha do sacerdote de guerra)', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warpriest', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O warpriest conjura uma das magias a seguir, requiring no spell components e usando Sabedoria como atributo de conjuração (CD de resistência a magia 15):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warpriest', 'Auxílio Divino (3/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O warpriest conjura Bless, Dispel Magic, Healing Word, or Lesser Restoration .', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('warpriest', 'War Blessing', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura que o sacerdote de guerra possa ver a até 9 m acerta com um ataque corpo a corpo com arma. Resposta: a arma que disparou causa adicional de 9 (2d8) de dano Radiante ou Necrótico (escolha do sacerdote de guerra).', 1);

-- Witch, Apprentice (witch-apprentice)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'witch-apprentice',
  'northlands-heroes-2024-en',
  'Witch, Apprentice',
  'Médio Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '3',
  2,
  17,
  58,
  '9d8 + 18',
  2,
  '{"forca":10,"destreza":15,"constituicao":14,"inteligencia":11,"sabedoria":12,"carisma":16}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'witch-apprentice';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('witch-apprentice', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'witch-apprentice';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('witch-apprentice', 'Perícias', 'Arcana +2, Enganação +5, Natureza +2, Percepção +3', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('witch-apprentice', 'Sentidos', 'Percepção passiva 13', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('witch-apprentice', 'Idiomas', 'Comum mais dois outros idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'witch-apprentice';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch-apprentice', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O witch realiza dois ataques, usando Dagger ou Eldritch Burst em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch-apprentice', 'Adaga', 'action'::rpg.actor_action_bucket, 4, '4 (1d4 + 2) dano Perfurante mais 7 (2d6) dano Venenoso', 'Ataque corpo a corpo ou teste de ataque à distância: +4, alcance 1,5 m or alcance 20/60. Acerto: 4 (1d4 + 2) dano Perfurante mais 7 (2d6) dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch-apprentice', 'Explosão Sobrenatural', 'action'::rpg.actor_action_bucket, 5, '11 (2d6 + 4) dano de Força', 'Ataque corpo a corpo ou teste de ataque à distância: +5, alcance 1,5 m, or alcance 36 m Acerto: 11 (2d6 + 4) dano de Força.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch-apprentice', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O witch conjura uma das magias a seguir, requiring no spell components e usando Carisma como atributo de conjuração (CD de resistência a magia 13):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch-apprentice', 'Passo Nebuloso (1/dia)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O witch conjura Misty Step .', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch-apprentice', 'Reflexive Hex', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura a bruxa possa ver a até 18 m realiza an teste de atributo, teste de ataque or teste de resistência. Resposta: o alvo deve rolar a d4 e subtract o número rolado do rolagem que disparou.', 1);

-- Witch (witch)
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES (
  'witch',
  'northlands-heroes-2024-en',
  'Witch',
  'Médio Humanoide, Qualquer tendência',
  'Qualquer tendência',
  'Humanoide',
  'medium',
  '9',
  4,
  17,
  136,
  '21d8 + 42',
  3,
  '{"forca":10,"destreza":16,"constituicao":14,"inteligencia":11,"sabedoria":15,"carisma":18}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET
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

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'witch';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES ('witch', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'witch';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('witch', 'Perícias', 'Arcana +4, Enganação +8, Natureza +4, Percepção +6', 1);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('witch', 'Sentidos', 'Percepção passiva 16', 2);
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES ('witch', 'Idiomas', 'Comum mais three other idiomas', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'witch';
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Ataques Múltiplos', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O witch realiza três ataques, usando Dagger ou Eldritch Burst em qualquer combinação', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Adaga', 'action'::rpg.actor_action_bucket, 7, '10 (2d4 + 3) dano Perfurante mais 14 (4d6) dano Venenoso', 'Ataque corpo a corpo ou teste de ataque à distância: +7, alcance 1,5 m or alcance 20/60. Acerto: 10 (2d4 + 3) dano Perfurante mais 14 (4d6) dano Venenoso.', 2);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Explosão Sobrenatural', 'action'::rpg.actor_action_bucket, 8, '18 (4d6 + 4) dano de Força', 'Ataque corpo a corpo ou teste de ataque à distância: +8, alcance 1,5 m, or alcance 36 m Acerto: 18 (4d6 + 4) dano de Força.', 3);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Conjuração', 'action'::rpg.actor_action_bucket, NULL, NULL, 'O witch conjura uma das magias a seguir, requiring no spell components e usando Carisma como atributo de conjuração (CD de resistência a magia 16):', 4);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Passo Nebuloso', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'O witch conjura Misty Step .', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Vinhas Retributivas', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: o witch sofre 5 ou mais de dano from an attacker que possa ver. Resposta: Vines grow out do ground to wrap ao redor do attacker. O alvo fica impedido até o início de seu próximo turno.', 1);
INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES ('witch', 'Reflexive Hex', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Gatilho: uma criatura a bruxa possa ver a até 18 m passa em um teste d20 . Resposta: o alvo deve rolar a d6 e subtract o número rolado do rolagem que disparou.', 2);
