-- Bestas CR0 do bestiário (identidade de monstro).
-- Find Familiar (convocar-familiar) só mapeia variantes → estes templates.
-- Stats: SRD 5.2.1; imagens do scrap Beyond.
-- Escala flat (sync spirit exige scale_by_slot; AC/PV não sobem com círculo).
-- Flavor Celestial/Feérico/Ínfero = escolha no cast, não no template.

-- Remove legado familiar-* (nome misturava vínculo com identidade).
DELETE FROM rpg.phb_spell_spirit_variant WHERE template_slug LIKE 'familiar-%';
DELETE FROM rpg.phb_creature_template WHERE slug LIKE 'familiar-%';

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores, image_url
) VALUES
(
  'aranha', 'phb-2024-pt', 'Aranha',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 12, 1, '1d4-1', 2,
  '{"forca":2,"destreza":14,"constituicao":8,"inteligencia":1,"sabedoria":10,"carisma":2}'::jsonb, '/catalog/beasts/aranha.png'
),
(
  'coruja', 'phb-2024-pt', 'Coruja',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 11, 1, '1d4-1', 1,
  '{"forca":3,"destreza":13,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":7}'::jsonb, '/catalog/beasts/coruja.png'
),
(
  'corvo', 'phb-2024-pt', 'Corvo',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 12, 1, '1d4-1', 2,
  '{"forca":2,"destreza":14,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":6}'::jsonb, '/catalog/beasts/corvo.png'
),
(
  'doninha', 'phb-2024-pt', 'Doninha',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 13, 1, '1d4-1', 3,
  '{"forca":3,"destreza":16,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":3}'::jsonb, '/catalog/beasts/doninha.png'
),
(
  'falcao', 'phb-2024-pt', 'Falcão',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 13, 1, '1d4-1', 3,
  '{"forca":5,"destreza":16,"constituicao":8,"inteligencia":2,"sabedoria":14,"carisma":6}'::jsonb, '/catalog/beasts/falcao.png'
),
(
  'gato', 'phb-2024-pt', 'Gato',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 12, 2, '1d4', 2,
  '{"forca":3,"destreza":15,"constituicao":10,"inteligencia":3,"sabedoria":12,"carisma":7}'::jsonb, '/catalog/beasts/gato.png'
),
(
  'lagarto', 'phb-2024-pt', 'Lagarto',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 10, 2, '1d4', 0,
  '{"forca":2,"destreza":11,"constituicao":10,"inteligencia":1,"sabedoria":8,"carisma":3}'::jsonb, '/catalog/beasts/lagarto.jpg'
),
(
  'morcego', 'phb-2024-pt', 'Morcego',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 12, 1, '1d4-1', 2,
  '{"forca":2,"destreza":15,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":4}'::jsonb, '/catalog/beasts/morcego.png'
),
(
  'polvo', 'phb-2024-pt', 'Polvo',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', 'small',
  0, 2, 12, 3, '1d6', 2,
  '{"forca":4,"destreza":15,"constituicao":11,"inteligencia":3,"sabedoria":10,"carisma":4}'::jsonb, '/catalog/beasts/polvo.png'
),
(
  'rato', 'phb-2024-pt', 'Rato',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 10, 1, '1d4-1', 0,
  '{"forca":2,"destreza":11,"constituicao":9,"inteligencia":2,"sabedoria":10,"carisma":4}'::jsonb, '/catalog/beasts/rato.jpg'
),
(
  'sapo', 'phb-2024-pt', 'Sapo',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  0, 2, 11, 1, '1d4-1', 1,
  '{"forca":1,"destreza":13,"constituicao":8,"inteligencia":1,"sabedoria":8,"carisma":3}'::jsonb, '/catalog/beasts/sapo.png'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores,
  image_url = EXCLUDED.image_url;

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('aranha', 1, 12, 0, 1, 0, 'per_slot'),
  ('coruja', 1, 11, 0, 1, 0, 'per_slot'),
  ('corvo', 1, 12, 0, 1, 0, 'per_slot'),
  ('doninha', 1, 13, 0, 1, 0, 'per_slot'),
  ('falcao', 1, 13, 0, 1, 0, 'per_slot'),
  ('gato', 1, 12, 0, 2, 0, 'per_slot'),
  ('lagarto', 1, 10, 0, 2, 0, 'per_slot'),
  ('morcego', 1, 12, 0, 1, 0, 'per_slot'),
  ('polvo', 1, 12, 0, 3, 0, 'per_slot'),
  ('rato', 1, 10, 0, 1, 0, 'per_slot'),
  ('sapo', 1, 11, 0, 1, 0, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug IN ('aranha', 'coruja', 'corvo', 'doninha', 'falcao', 'gato', 'lagarto', 'morcego', 'polvo', 'rato', 'sapo');
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('aranha', 'climb', 20),
  ('aranha', 'walk', 20),
  ('coruja', 'fly', 60),
  ('coruja', 'walk', 5),
  ('corvo', 'fly', 50),
  ('corvo', 'walk', 10),
  ('doninha', 'walk', 30),
  ('falcao', 'fly', 60),
  ('falcao', 'walk', 10),
  ('gato', 'climb', 30),
  ('gato', 'walk', 40),
  ('lagarto', 'climb', 20),
  ('lagarto', 'walk', 20),
  ('morcego', 'fly', 30),
  ('morcego', 'walk', 5),
  ('polvo', 'swim', 30),
  ('polvo', 'walk', 5),
  ('rato', 'walk', 20),
  ('sapo', 'swim', 20),
  ('sapo', 'walk', 20);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug IN ('aranha', 'coruja', 'corvo', 'doninha', 'falcao', 'gato', 'lagarto', 'morcego', 'polvo', 'rato', 'sapo');
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('aranha', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 12.', 0),
  ('aranha', 'Escalada de Aranha', 'Pode escalar superfícies difíceis, inclusive de cabeça para baixo, sem teste.', 1),
  ('aranha', 'Sentido de Teia', 'Em contato com uma teia, sabe a localização exata de qualquer criatura em contato com a mesma teia.', 2),
  ('aranha', 'Andarilho de Teias', 'Ignora restrições de movimento causadas por teias.', 3),
  ('coruja', 'Sentidos', 'Visão no Escuro 36 m. Percepção Passiva 13.', 0),
  ('coruja', 'Voo de Passagem', 'Não provoca Ataques de Oportunidade ao voar para fora do alcance de um inimigo.', 1),
  ('coruja', 'Audição e Visão Aguçadas', 'Vantagem em testes de Sabedoria (Percepção) que dependem da audição ou visão.', 2),
  ('corvo', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('corvo', 'Mimetismo', 'Pode imitar sons simples. Criatura ouvinte: teste de Sabedoria (Intuição) CD 10 para perceber a imitação.', 1),
  ('doninha', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('doninha', 'Audição e Olfato Aguçados', 'Vantagem em testes de Sabedoria (Percepção) que dependem da audição ou olfato.', 1),
  ('falcao', 'Sentidos', 'Percepção Passiva 14.', 0),
  ('falcao', 'Visão Aguçada', 'Vantagem em testes de Sabedoria (Percepção) que dependem da visão.', 1),
  ('gato', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('gato', 'Olfato Aguçado', 'Vantagem em testes de Sabedoria (Percepção) que dependem do olfato.', 1),
  ('lagarto', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 9.', 0),
  ('morcego', 'Sentidos', 'Visão às Cegas 18 m. Percepção Passiva 11.', 0),
  ('morcego', 'Ecolocalização', 'Não pode usar Visão às Cegas enquanto estiver Surdo.', 1),
  ('morcego', 'Audição Aguçada', 'Vantagem em testes de Sabedoria (Percepção) que dependem da audição.', 2),
  ('polvo', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 12.', 0),
  ('polvo', 'Prender a Respiração', 'Fora da água, pode prender a respiração por 30 minutos.', 1),
  ('polvo', 'Camuflagem Subaquática', 'Vantagem em testes de Destreza (Furtividade) debaixo d’água.', 2),
  ('polvo', 'Respiração Aquática', 'Só respira debaixo d’água.', 3),
  ('rato', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 10.', 0),
  ('rato', 'Olfato Aguçado', 'Vantagem em testes de Sabedoria (Percepção) que dependem do olfato.', 1),
  ('sapo', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 11.', 0),
  ('sapo', 'Anfíbio', 'Pode respirar ar e água.', 1),
  ('sapo', 'Salto em Pé', 'Salto em distância até 3 m e em altura até 1,5 m, com ou sem corrida.', 2);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug IN ('aranha', 'coruja', 'corvo', 'doninha', 'falcao', 'gato', 'lagarto', 'morcego', 'polvo', 'rato', 'sapo');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('aranha', 'Mordida', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Weapon Attack: +4 to hit, reach 5 ft., one creature. Hit: 1 piercing damage, and the target must succeed on a DC 9 Constitution saving throw or take 2 (1d4) poison damage.', 1),
  ('coruja', 'Garras', 'action'::rpg.actor_action_bucket, 3, '1', 'Melee Weapon Attack: +3 to hit, reach 5 ft., one target. Hit: 1 slashing damage.', 1),
  ('corvo', 'Bico', 'action'::rpg.actor_action_bucket, NULL, '1', 'Melee Weapon Attack: +4 to hit, reach 5 ft., one target. Hit: 1 piercing damage.', 1),
  ('doninha', 'Mordida', 'action'::rpg.actor_action_bucket, 5, '1', 'Melee Weapon Attack: +5 to hit, reach 5 ft., one creature. Hit: 1 piercing damage.', 1),
  ('falcao', 'Garras', 'action'::rpg.actor_action_bucket, 5, '1', 'Melee Weapon Attack: +5 to hit, reach 5 ft., one target. Hit: 1 slashing damage.', 1),
  ('gato', 'Garras', 'action'::rpg.actor_action_bucket, NULL, '1', 'Melee Weapon Attack: +0 to hit, reach 5 ft., one target. Hit: 1 slashing damage.', 1),
  ('lagarto', 'Mordida', 'action'::rpg.actor_action_bucket, NULL, '1', 'Melee Weapon Attack: +0 to hit, reach 5 ft., one target. Hit: 1 piercing damage.', 1),
  ('morcego', 'Mordida', 'action'::rpg.actor_action_bucket, NULL, '1', 'Melee Weapon Attack: +0 to hit, reach 5 ft., one creature. Hit: 1 piercing damage.', 1),
  ('polvo', 'Tentáculos', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Weapon Attack: +4 to hit, reach 5 ft., one target. Hit: 1 bludgeoning damage, and the target is grappled (escape DC 10). Until this grapple ends, the octopus can''t use its tentacles on another target.', 1),
  ('polvo', 'Nuvem de Tinta (recarrega após Descanso)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'A 5-foot-radius cloud of ink extends all around the octopus if it is underwater. The area is heavily obscured for 1 minute, although a significant current can disperse the ink. After releasing the ink, the octopus can use the Dash action as a bonus action.', 2),
  ('rato', 'Mordida', 'action'::rpg.actor_action_bucket, NULL, '1', 'Melee Weapon Attack: +0 to hit, reach 5 ft., one target. Hit: 1 piercing damage.', 1);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('convocar-familiar', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'convocar-familiar';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('convocar-familiar', 'aranha', 'aranha', 'Aranha'),
  ('convocar-familiar', 'coruja', 'coruja', 'Coruja'),
  ('convocar-familiar', 'corvo', 'corvo', 'Corvo'),
  ('convocar-familiar', 'doninha', 'doninha', 'Doninha'),
  ('convocar-familiar', 'falcao', 'falcao', 'Falcão'),
  ('convocar-familiar', 'gato', 'gato', 'Gato'),
  ('convocar-familiar', 'lagarto', 'lagarto', 'Lagarto'),
  ('convocar-familiar', 'morcego', 'morcego', 'Morcego'),
  ('convocar-familiar', 'polvo', 'polvo', 'Polvo'),
  ('convocar-familiar', 'rato', 'rato', 'Rato'),
  ('convocar-familiar', 'sapo', 'sapo', 'Sapo');

