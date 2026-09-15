-- Gaps Monster Lists via SRD 5.2.1 (CC-BY).
-- Extract: docs/source/extracts/mm/list-gap-srd.json

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, creature_subtype, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores, image_url
) VALUES
(
  'cobra-voadora', 'phb-2024-pt', 'Cobra Voadora',
  'Minúscula Beast, Neutra', 'Neutra', 'Beast', NULL, 'tiny',
  '1/8', 2, 14, 5, '2d4', 4,
  '{"forca":4,"destreza":18,"constituicao":11,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'coruja-gigante', 'phb-2024-pt', 'Coruja Gigante',
  'Grande Beast, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1/4', 2, 12, 19, '3d10+3', 2,
  '{"forca":13,"destreza":15,"constituicao":12,"inteligencia":8,"sabedoria":13,"carisma":10}'::jsonb, NULL
),
(
  'aguia-gigante', 'phb-2024-pt', 'Águia Gigante',
  'Grande Beast, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1', 2, 13, 26, '4d10+4', 3,
  '{"forca":16,"destreza":17,"constituicao":13,"inteligencia":8,"sabedoria":14,"carisma":10}'::jsonb, NULL
),
(
  'alce-gigante', 'phb-2024-pt', 'Alce Gigante',
  'Enorme Beast, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '2', 2, 15, 42, '5d12+10', 3,
  '{"forca":19,"destreza":16,"constituicao":14,"inteligencia":7,"sabedoria":14,"carisma":10}'::jsonb, NULL
),
(
  'abutre-gigante', 'phb-2024-pt', 'Abutre Gigante',
  'Grande Beast, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1', 2, 10, 22, '3d10+6', 0,
  '{"forca":15,"destreza":10,"constituicao":15,"inteligencia":6,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'enxame-de-morcegos', 'phb-2024-pt', 'Enxame de Morcegos',
  'Média Enxame de Bestas, Neutra', 'Neutra', 'Beast', 'Swarm', 'medium',
  '1/4', 2, 12, 22, '5d8', 2,
  '{"forca":5,"destreza":15,"constituicao":10,"inteligencia":2,"sabedoria":12,"carisma":4}'::jsonb, NULL
),
(
  'enxame-de-ratos', 'phb-2024-pt', 'Enxame de Ratos',
  'Média Enxame de Bestas, Neutra', 'Neutra', 'Beast', 'Swarm', 'medium',
  '1/4', 2, 10, 24, '7d8-7', 0,
  '{"forca":9,"destreza":11,"constituicao":9,"inteligencia":2,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'enxame-de-corvos', 'phb-2024-pt', 'Enxame de Corvos',
  'Média Enxame de Bestas, Neutra', 'Neutra', 'Beast', 'Swarm', 'medium',
  '1/4', 2, 12, 24, '7d8-7', 2,
  '{"forca":6,"destreza":14,"constituicao":8,"inteligencia":3,"sabedoria":12,"carisma":6}'::jsonb, NULL
),
(
  'enxame-de-insetos', 'phb-2024-pt', 'Enxame de Insetos',
  'Média Enxame de Bestas, Neutra', 'Neutra', 'Beast', 'Swarm', 'medium',
  '1/2', 2, 12, 22, '5d8', 1,
  '{"forca":3,"destreza":13,"constituicao":10,"inteligencia":1,"sabedoria":7,"carisma":1}'::jsonb, NULL
),
(
  'enxame-de-cobras-venenosas', 'phb-2024-pt', 'Enxame de Cobras Venenosas',
  'Média Enxame de Bestas, Neutra', 'Neutra', 'Beast', 'Swarm', 'medium',
  '2', 2, 14, 36, '8d8', 4,
  '{"forca":8,"destreza":18,"constituicao":11,"inteligencia":1,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'enxame-de-piranhas', 'phb-2024-pt', 'Enxame de Piranhas',
  'Média Enxame de Bestas, Neutra', 'Neutra', 'Beast', 'Swarm', 'medium',
  '1', 2, 13, 28, '8d8-8', 3,
  '{"forca":13,"destreza":16,"constituicao":9,"inteligencia":1,"sabedoria":7,"carisma":2}'::jsonb, NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, creature_subtype = EXCLUDED.creature_subtype,
  size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('cobra-voadora', 1, 14, 0, 5, 0, 'per_slot'),
  ('coruja-gigante', 1, 12, 0, 19, 0, 'per_slot'),
  ('aguia-gigante', 1, 13, 0, 26, 0, 'per_slot'),
  ('alce-gigante', 1, 15, 0, 42, 0, 'per_slot'),
  ('abutre-gigante', 1, 10, 0, 22, 0, 'per_slot'),
  ('enxame-de-morcegos', 1, 12, 0, 22, 0, 'per_slot'),
  ('enxame-de-ratos', 1, 10, 0, 24, 0, 'per_slot'),
  ('enxame-de-corvos', 1, 12, 0, 24, 0, 'per_slot'),
  ('enxame-de-insetos', 1, 12, 0, 22, 0, 'per_slot'),
  ('enxame-de-cobras-venenosas', 1, 14, 0, 36, 0, 'per_slot'),
  ('enxame-de-piranhas', 1, 13, 0, 28, 0, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot, ac_base = EXCLUDED.ac_base, ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base, hp_per_slot = EXCLUDED.hp_per_slot, hp_mode = EXCLUDED.hp_mode;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug IN ('cobra-voadora', 'coruja-gigante', 'aguia-gigante', 'alce-gigante', 'abutre-gigante', 'enxame-de-morcegos', 'enxame-de-ratos', 'enxame-de-corvos', 'enxame-de-insetos', 'enxame-de-cobras-venenosas', 'enxame-de-piranhas');
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('cobra-voadora', 'fly', 60),
  ('cobra-voadora', 'swim', 30),
  ('cobra-voadora', 'walk', 30),
  ('coruja-gigante', 'fly', 60),
  ('coruja-gigante', 'walk', 5),
  ('aguia-gigante', 'fly', 80),
  ('aguia-gigante', 'walk', 10),
  ('alce-gigante', 'walk', 60),
  ('abutre-gigante', 'fly', 60),
  ('abutre-gigante', 'walk', 10),
  ('enxame-de-morcegos', 'fly', 30),
  ('enxame-de-ratos', 'walk', 30),
  ('enxame-de-corvos', 'fly', 50),
  ('enxame-de-corvos', 'walk', 10),
  ('enxame-de-insetos', 'climb', 20),
  ('enxame-de-insetos', 'walk', 20),
  ('enxame-de-cobras-venenosas', 'swim', 30),
  ('enxame-de-cobras-venenosas', 'walk', 30),
  ('enxame-de-piranhas', 'swim', 40);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug IN ('cobra-voadora', 'coruja-gigante', 'aguia-gigante', 'alce-gigante', 'abutre-gigante', 'enxame-de-morcegos', 'enxame-de-ratos', 'enxame-de-corvos', 'enxame-de-insetos', 'enxame-de-cobras-venenosas', 'enxame-de-piranhas');
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('cobra-voadora', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 11.', 0),
  ('cobra-voadora', 'Flyby', 'The snake doesn''t provoke opportunity attacks when it flies out of an enemy''s reach.', 1),
  ('coruja-gigante', 'Sentidos', 'Visão no Escuro 36 m. Percepção Passiva 15.', 0),
  ('coruja-gigante', 'Flyby', 'The owl doesn''t provoke opportunity attacks when it flies out of an enemy''s reach.', 1),
  ('coruja-gigante', 'Keen Hearing and Sight', 'The owl has advantage on Wisdom (Perception) checks that rely on hearing or sight.', 2),
  ('aguia-gigante', 'Sentidos', 'Percepção Passiva 14.', 0),
  ('aguia-gigante', 'Keen Sight', 'The eagle has advantage on Wisdom (Perception) checks that rely on sight.', 1),
  ('alce-gigante', 'Sentidos', 'Percepção Passiva 14.', 0),
  ('alce-gigante', 'Charge', 'If the elk moves at least 20 ft. straight toward a target and then hits it with a ram attack on the same turn, the target takes an extra 7 (2d6) damage. If the target is a creature, it must succeed on a DC 14 Strength saving throw or be knocked prone.', 1),
  ('abutre-gigante', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('abutre-gigante', 'Keen Sight and Smell', 'The vulture has advantage on Wisdom (Perception) checks that rely on sight or smell.', 1),
  ('abutre-gigante', 'Pack Tactics', 'The vulture has advantage on an attack roll against a creature if at least one of the vulture''s allies is within 5 ft. of the creature and the ally isn''t incapacitated.', 2),
  ('enxame-de-morcegos', 'Sentidos', 'Visão às Cegas 18 m. Percepção Passiva 11.', 0),
  ('enxame-de-morcegos', 'Echolocation', 'The swarm can''t use its blindsight while deafened.', 1),
  ('enxame-de-morcegos', 'Keen Hearing', 'The swarm has advantage on Wisdom (Perception) checks that rely on hearing.', 2),
  ('enxame-de-morcegos', 'Swarm', 'The swarm can occupy another creature''s space and vice versa, and the swarm can move through any opening large enough for a Tiny bat. The swarm can''t regain hit points or gain temporary hit points.', 3),
  ('enxame-de-ratos', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 10.', 0),
  ('enxame-de-ratos', 'Keen Smell', 'The swarm has advantage on Wisdom (Perception) checks that rely on smell.', 1),
  ('enxame-de-ratos', 'Swarm', 'The swarm can occupy another creature''s space and vice versa, and the swarm can move through any opening large enough for a Tiny rat. The swarm can''t regain hit points or gain temporary hit points.', 2),
  ('enxame-de-corvos', 'Sentidos', 'Percepção Passiva 15.', 0),
  ('enxame-de-corvos', 'Swarm', 'The swarm can occupy another creature''s space and vice versa, and the swarm can move through any opening large enough for a Tiny raven. The swarm can''t regain hit points or gain temporary hit points.', 1),
  ('enxame-de-insetos', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 8.', 0),
  ('enxame-de-insetos', 'Swarm', 'The swarm can occupy another creature''s space and vice versa, and the swarm can move through any opening large enough for a Tiny insect. The swarm can''t regain hit points or gain temporary hit points.', 1),
  ('enxame-de-cobras-venenosas', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 10.', 0),
  ('enxame-de-cobras-venenosas', 'Swarm', 'The swarm can occupy another creature''s space and vice versa, and the swarm can move through any opening large enough for a Tiny snake. The swarm can''t regain hit points or gain temporary hit points.', 1),
  ('enxame-de-piranhas', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 8.', 0),
  ('enxame-de-piranhas', 'Blood Frenzy', 'The swarm has advantage on melee attack rolls against any creature that doesn''t have all its hit points.', 1),
  ('enxame-de-piranhas', 'Swarm', 'The swarm can occupy another creature''s space and vice versa, and the swarm can move through any opening large enough for a Tiny quipper. The swarm can''t regain hit points or gain temporary hit points.', 2),
  ('enxame-de-piranhas', 'Water Breathing', 'The swarm can breathe only underwater.', 3);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug IN ('cobra-voadora', 'coruja-gigante', 'aguia-gigante', 'alce-gigante', 'abutre-gigante', 'enxame-de-morcegos', 'enxame-de-ratos', 'enxame-de-corvos', 'enxame-de-insetos', 'enxame-de-cobras-venenosas', 'enxame-de-piranhas');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('cobra-voadora', 'Bite', 'action'::rpg.actor_action_bucket, 6, '1', 'Melee Weapon Attack: +6 to hit, reach 5 ft., one target. Hit: 1 piercing damage plus 7 (3d4) poison damage.', 1),
  ('coruja-gigante', 'Talons', 'action'::rpg.actor_action_bucket, 3, '8', 'Melee Weapon Attack: +3 to hit, reach 5 ft., one target. Hit: 8 (2d6 + 1) slashing damage.', 1),
  ('aguia-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The eagle makes two attacks: one with its beak and one with its talons.', 1),
  ('aguia-gigante', 'Beak', 'action'::rpg.actor_action_bucket, 5, '6', 'Melee Weapon Attack: +5 to hit, reach 5 ft., one target. Hit: 6 (1d6 + 3) piercing damage.', 2),
  ('aguia-gigante', 'Talons', 'action'::rpg.actor_action_bucket, 5, '10', 'Melee Weapon Attack: +5 to hit, reach 5 ft., one target. Hit: 10 (2d6 + 3) slashing damage.', 3),
  ('alce-gigante', 'Ram', 'action'::rpg.actor_action_bucket, 6, '11', 'Melee Weapon Attack: +6 to hit, reach 10 ft., one target. Hit: 11 (2d6 + 4) bludgeoning damage.', 1),
  ('alce-gigante', 'Hooves', 'action'::rpg.actor_action_bucket, 6, '22', 'Melee Weapon Attack: +6 to hit, reach 5 ft., one prone creature. Hit: 22 (4d8 + 4) bludgeoning damage.', 2),
  ('abutre-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The vulture makes two attacks: one with its beak and one with its talons.', 1),
  ('abutre-gigante', 'Beak', 'action'::rpg.actor_action_bucket, 4, '7', 'Melee Weapon Attack: +4 to hit, reach 5 ft., one target. Hit: 7 (2d4 + 2) piercing damage.', 2),
  ('abutre-gigante', 'Talons', 'action'::rpg.actor_action_bucket, 4, '9', 'Melee Weapon Attack: +4 to hit, reach 5 ft., one target. Hit: 9 (2d6 + 2) slashing damage.', 3),
  ('enxame-de-morcegos', 'Bites', 'action'::rpg.actor_action_bucket, 4, '5', 'Melee Weapon Attack: +4 to hit, reach 0 ft., one creature in the swarm''s space. Hit: 5 (2d4) piercing damage, or 2 (1d4) piercing damage if the swarm has half of its hit points or fewer.', 1),
  ('enxame-de-ratos', 'Bites', 'action'::rpg.actor_action_bucket, 2, '7', 'Melee Weapon Attack: +2 to hit, reach 0 ft., one target in the swarm''s space. Hit: 7 (2d6) piercing damage, or 3 (1d6) piercing damage if the swarm has half of its hit points or fewer.', 1),
  ('enxame-de-corvos', 'Beaks', 'action'::rpg.actor_action_bucket, 4, '7', 'Melee Weapon Attack: +4 to hit, reach 5 ft., one target in the swarm''s space. Hit: 7 (2d6) piercing damage, or 3 (1d6) piercing damage if the swarm has half of its hit points or fewer.', 1),
  ('enxame-de-insetos', 'Bites', 'action'::rpg.actor_action_bucket, 3, '10', 'Melee Weapon Attack: +3 to hit, reach 0 ft., one target in the swarm''s space. Hit: 10 (4d4) piercing damage, or 5 (2d4) piercing damage if the swarm has half of its hit points or fewer.', 1),
  ('enxame-de-cobras-venenosas', 'Bites', 'action'::rpg.actor_action_bucket, 6, '7', 'Melee Weapon Attack: +6 to hit, reach 0 ft., one creature in the swarm''s space. Hit: 7 (2d6) piercing damage, or 3 (1d6) piercing damage if the swarm has half of its hit points or fewer. The target must make a DC 10 Constitution saving throw, taking 14 (4d6) poison damage on a failed save, or half as much damage on a successful one.', 1),
  ('enxame-de-piranhas', 'Bites', 'action'::rpg.actor_action_bucket, 5, '14', 'Melee Weapon Attack: +5 to hit, reach 0 ft., one creature in the swarm''s space. Hit: 14 (4d6) piercing damage, or 7 (2d6) piercing damage if the swarm has half of its hit points or fewer.', 1);
