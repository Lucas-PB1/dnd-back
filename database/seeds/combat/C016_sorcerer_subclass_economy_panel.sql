-- Economia + painel das subclasses de Feiticeiro (gaps vs PHB / Valdas).
-- Roda após C009/C010. Idempotente (ON CONFLICT).

-- ---------------------------------------------------------------------------
-- Economia (C009)
-- ---------------------------------------------------------------------------
INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'sorcerer-tides-of-chaos',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
  'Marés do Caos',
  'free'::rpg.action_economy_bucket,
  3,
  'tides-of-chaos',
  NULL,
  true,
  'Vantagem em 1 Teste de D20 (1×; recarrega com Surto/DL)',
  'Antes de jogar um Teste de D20, ganhe Vantagem. Após usar, precisa conjurar magia de Feiticeiro com espaço ou concluir um Descanso Longo para recuperar (Surto de Magia Selvagem também recarrega).',
  'tides-of-chaos',
  NULL,
  77
),
(
  'sorcerer-restore-balance',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
  'Restaurar Equilíbrio',
  'reaction'::rpg.action_economy_bucket,
  3,
  'restore-balance',
  NULL,
  true,
  'Reação: cancela Vantagem/Desvantagem em d20 (usos = CAR)',
  'Quando uma criatura à sua vista a até 18 m estiver prestes a jogar um d20 com Vantagem ou Desvantagem, use sua Reação para evitar que o teste seja afetado.',
  'restore-balance',
  NULL,
  78
),
(
  'sorcerer-bastion-of-law',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
  'Bastião da Lei',
  'action'::rpg.action_economy_bucket,
  6,
  'sorceryPoints',
  NULL,
  true,
  'Gaste 1–5 SP: conceda N d8 de proteção a aliado (9 m)',
  'Como ação Usar Magia, gaste de 1 a 5 Pontos de Feitiçaria para criar proteção (N d8). A criatura protegida pode gastar os dados para reduzir dano. Dura até Descanso Longo ou novo uso.',
  'bastion-of-law',
  NULL,
  79
),
(
  'sorcerer-bend-luck',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
  'Distorcer a Sorte',
  'reaction'::rpg.action_economy_bucket,
  6,
  'sorceryPoints',
  NULL,
  true,
  'Reação: 1 SP → ±1d4 no d20 de outra criatura',
  'Imediatamente após outra criatura à sua vista jogar o d20 para um Teste de D20, use Reação e gaste 1 Ponto de Feitiçaria para aplicar +1d4 ou −1d4 (à sua escolha).',
  'bend-luck',
  1,
  80
),
(
  'sorcerer-dragon-wings',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
  'Asas de Dragão',
  'bonus'::rpg.action_economy_bucket,
  14,
  'dragon-wings',
  NULL,
  true,
  'Ação Bônus: voo 18 m por 1 h (1×/DL ou 3 SP para restaurar)',
  'Como Ação Bônus, asas dracônicas aparecem por 1 hora (Deslocamento de Voo 18 m). Recupera no Descanso Longo ou gastando 3 Pontos de Feitiçaria (sem ação) para restaurar o uso.',
  'dragon-wings',
  NULL,
  60
),
(
  'sorcerer-heroic-soul',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  'Alma Heróica',
  'free'::rpg.action_economy_bucket,
  3,
  'sorceryPoints',
  NULL,
  true,
  'Início do turno: 1 SP → PV temp. 1d6 + nível',
  'No início de cada um dos seus turnos, gaste 1 Ponto de Feitiçaria para ganhar PV temporários iguais a 1d6 + seu nível de Feiticeiro (sem ação).',
  'heroic-soul',
  1,
  61
),
(
  'sorcerer-mystical-maneuver',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  'Manobra Mística',
  'bonus'::rpg.action_economy_bucket,
  14,
  'sorceryPoints',
  NULL,
  true,
  '2 SP após acertar: Cegar / Ruinoso / Ferimento +2d8',
  'Ao acertar com arma ou Ataque Desarmado, gaste 2 Pontos de Feitiçaria como Ação Bônus: +2d8 no dano e Cegar, −3 CA ou ferimento sangrando (mesa).',
  'mystical-maneuver',
  2,
  62
),
(
  'sorcerer-warp-implosion',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'),
  'Implosão de Distorção',
  'action'::rpg.action_economy_bucket,
  18,
  'warp-implosion',
  NULL,
  true,
  'Usar Magia: teleporte + dano espacial (1×/DL)',
  'Como ação Usar Magia, libere a anomalia (teleporte e dano — aplique na mesa). 1 uso; recupera no Descanso Longo.',
  'warp-implosion',
  NULL,
  64
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order;

UPDATE rpg.phb_class_economy_action SET
  name = 'Asas de Dragão',
  resource_slug = 'dragon-wings',
  always_spends_resource = true,
  summary = 'Ação Bônus: voo 18 m por 1 h (1×/DL ou 3 SP para restaurar)',
  description = 'Como Ação Bônus, asas dracônicas aparecem por 1 hora (Deslocamento de Voo 18 m). Recupera no Descanso Longo ou gastando 3 Pontos de Feitiçaria (sem ação) para restaurar o uso.',
  table_action = 'dragon-wings'
WHERE action_id = 'sorcerer-dragon-wings';

UPDATE rpg.phb_class_economy_action SET
  table_action = 'heroic-soul',
  summary = 'Início do turno: 1 SP → PV temp. 1d6 + nível'
WHERE action_id = 'sorcerer-heroic-soul';

UPDATE rpg.phb_class_economy_action SET
  table_action = 'mystical-maneuver',
  summary = '2 SP após acertar: Cegar / Ruinoso / Ferimento +2d8'
WHERE action_id = 'sorcerer-mystical-maneuver';

-- ---------------------------------------------------------------------------
-- Painel (C010)
-- ---------------------------------------------------------------------------
INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
(
  'sorcerer|wild-magic|tides-of-chaos',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
  'tides-of-chaos',
  'Marés do Caos',
  'Vantagem em 1 Teste de D20 (gasta 1 uso)',
  3,
  'tides-of-chaos',
  'subclass'::rpg.panel_action_section,
  false,
  6
),
(
  'sorcerer|clockwork|restore-balance',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
  'restore-balance',
  'Restaurar Equilíbrio',
  'Reação: cancela Vantagem/Desvantagem (gasta 1 uso)',
  3,
  'restore-balance',
  'subclass'::rpg.panel_action_section,
  false,
  7
),
(
  'sorcerer|clockwork|bastion-of-law',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
  'bastion-of-law',
  'Bastião da Lei',
  'Gaste 1–5 SP (painel: escolha o custo) para N d8 de proteção',
  6,
  'sorceryPoints',
  'subclass'::rpg.panel_action_section,
  false,
  8
),
(
  'sorcerer|draconic|dragon-wings',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
  'dragon-wings',
  'Asas de Dragão',
  'Ação Bônus: voo 18 m / 1 h (1 uso ou 3 SP)',
  14,
  'dragon-wings',
  'subclass'::rpg.panel_action_section,
  false,
  9
),
(
  'sorcerer|heroic-sorcery|heroic-soul',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  'heroic-soul',
  'Alma Heróica',
  '1 SP: PV temp. 1d6 + nível (início do turno)',
  3,
  'sorceryPoints',
  'subclass'::rpg.panel_action_section,
  false,
  10
),
(
  'sorcerer|heroic-sorcery|mystical-maneuver',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  'mystical-maneuver',
  'Manobra Mística',
  'Ação Bônus após acertar: 2 SP → +2d8 e efeito',
  14,
  'sorceryPoints',
  'subclass'::rpg.panel_action_section,
  false,
  11
),
(
  'sorcerer|wild-magic|bend-luck',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
  'bend-luck',
  'Distorcer a Sorte',
  'Reação: 1 SP → ±1d4 no d20 de outra criatura',
  6,
  'sorceryPoints',
  'subclass'::rpg.panel_action_section,
  false,
  12
),
(
  'sorcerer|aberrant|warp-implosion',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'),
  'warp-implosion',
  'Implosão de Distorção',
  'Usar Magia: teleporte + dano espacial (1×/DL)',
  18,
  'warp-implosion',
  'subclass'::rpg.panel_action_section,
  false,
  13
)
ON CONFLICT (panel_key) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  spends_focus = EXCLUDED.spends_focus,
  sort_order = EXCLUDED.sort_order;
