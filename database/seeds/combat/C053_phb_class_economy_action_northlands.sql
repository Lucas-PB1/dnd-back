-- Economy actions — Northlands Heroes of the Sagas (declarativo)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
('bard-skald-bragi-rune', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 'Runa da Fala de Bragi', 'bonus'::rpg.action_economy_bucket, 6, 'bardicInspiration', NULL, true, 'AB: gasta Inspiração — Escárnio / Eloquência / Vitalidade', 'Ação Bônus: gaste 1 Inspiração Bárdica e escolha Escárnio, Eloquência ou Vitalidade (só um efeito ativo). Mesa.', 'bragi-rune', NULL, 100),
('bard-skald-battle-sagas', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 'Sagas de Batalha', 'action'::rpg.action_economy_bucket, 14, 'battle-sagas', NULL, true, '1 min: sagas 1 h (1× / DC ou DL)', 'Recite as Eddas 1 minuto: aliados a 18 m ganham benefícios por 1 h. 1× / Descanso Curto ou Longo.', 'battle-sagas', NULL, 101),

('cleric-norn-adjust-skein', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'Ajustar a Teia', 'reaction'::rpg.action_economy_bucket, 3, 'norn-skeins', NULL, true, 'Reação: ±1 Fio em rolagem a 18 m', 'Após ver resultado de ataque/dano/salvaguarda/teste a 18 m: some ou subtraia um Fio. Recupera no DL.', 'adjust-the-skein', NULL, 100),
('cleric-norn-pluck-threads', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'Puxar os Fios', 'bonus'::rpg.action_economy_bucket, 3, 'channelDivinity', NULL, true, 'AB: Canalizar — Vantagem a aliados 9 m', 'Ação Bônus: gaste Canalizar Divindade. Aliados a 9 m têm Vantagem em ataques e salvaguardas até o fim do seu próximo turno.', 'pluck-the-threads', NULL, 101),
('cleric-norn-intertwined-fate', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'Destino Entrelaçado', 'action'::rpg.action_economy_bucket, 6, NULL, NULL, false, 'Ação Mágica: gasta espaço — dano + cura', 'Gaste um espaço: primário sofre Força; secundário recebe PV iguais ao dano. Mesa — declare o círculo.', 'intertwined-fate', NULL, 102),

('druid-fenris-wolf-mantle', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'Manto do Lobo', 'action'::rpg.action_economy_bucket, 3, 'wildShape', NULL, true, 'Ação: gasta Forma → manto 10 min', 'Gaste 1 Forma Selvagem: cabeça espectral 10 min; bônus Atletismo/salv. Força; mordida espectral.', 'wolf-mantle', NULL, 100),
('druid-fenris-defend-pack', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'Defender a Alcateia', 'reaction'::rpg.action_economy_bucket, 10, 'wildShape', NULL, true, 'Reação: lobo fantasma 4d8 + Caído', 'Quando criatura atacar aliado a 9 m: gaste Forma Selvagem — 4d8 Força e Caído (6d8 no nv. 14+).', 'defend-the-pack', NULL, 101),
('druid-fenris-children-wolf', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'Filhos do Grande Lobo', 'free'::rpg.action_economy_bucket, 14, 'children-of-great-wolf', NULL, true, 'Ao assumir Manto: convoca fenrikyn (1×/dia)', 'Ao usar Manto do Lobo, 1×/dia convoque um fenrikyn (fonte Cap. 8). Mesa.', 'children-of-great-wolf', NULL, 102),

('fighter-viking-reprisal', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 'Represália do Saqueador', 'reaction'::rpg.action_economy_bucket, 15, 'marauders-reprisal', NULL, true, 'Reação: crítico + PV temp. (usos = PB)', 'Ao ficar Ensanguentado ou sofrer crítico: Reação atacar; acerto é crítico + PV temp. = metade do nível.', 'marauders-reprisal', NULL, 100),
('fighter-viking-unstoppable', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 'Assalto Imparável', 'action'::rpg.action_economy_bucket, 18, 'unstoppable-assault', NULL, true, 'Ação: ataques extras críticos (1×/DL)', 'Ataques extras = metade do PB; acertos críticos; empurrão 3 m (salv. Força). 1× / Descanso Longo.', 'unstoppable-assault', NULL, 101),

('paladin-valhalla-encouraging-smite', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'Destruição Encorajadora', 'free'::rpg.action_economy_bucket, 3, 'channelDivinity', NULL, true, 'Após Destruição Divina: Canalizar — buff', 'Imediatamente após Destruição Divina: gaste Canalizar; aliados a 9 m têm Vantagem vs o alvo +1d4 Trovão.', 'encouraging-smite', NULL, 100),
('paladin-valhalla-guardian-dead', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'Guardião dos Mortos', 'bonus'::rpg.action_economy_bucket, 3, 'channelDivinity', NULL, true, 'AB: Canalizar — vigília 1 h', 'Ação Bônus: gaste Canalizar Divindade por 1 h perto de criatura a 0 PV; Reação vs necromancia/reviver.', 'guardian-of-the-dead', NULL, 101),
('paladin-valhalla-spirit-valkyrie', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'Espírito da Valquíria', 'bonus'::rpg.action_economy_bucket, 20, 'spirit-of-the-valkyrie', NULL, true, 'AB: forma de valquíria 10 min (1×/DL)', 'Voo, Vantagem vs magias, aura trovejante, Destruições como 5º. Restaure com espaço de 5º.', 'spirit-of-the-valkyrie', NULL, 102),

('sorcerer-spirit-guidance', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'Orientação Espiritual', 'bonus'::rpg.action_economy_bucket, 3, 'spirit-guidance', NULL, true, 'AB: Vantagem em perícia (usos = CAR)', 'Ação Bônus: Vantagem num teste de perícia. Usos = mod. Carisma / Descanso Longo.', 'spirit-guidance', NULL, 100),
('sorcerer-spirit-aura', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'Aura Espiritual', 'bonus'::rpg.action_economy_bucket, 6, 'spirit-aura', NULL, true, 'AB: aura 3 m 1 min (2×/DL)', 'Ação Bônus: Sussurros Enlouquecedores ou Fortalecedores. 2×/DL ou 3 Pontos de Feitiçaria.', 'spirit-aura', NULL, 101),
('sorcerer-spirit-secrets', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'Segredos Espirituais', 'free'::rpg.action_economy_bucket, 14, 'spirit-secrets', NULL, true, 'Ao falhar: rerrolar (usos = CAR)', 'Ao falhar em teste/ataque/salvaguarda: rerrola. Sem usos: 3 Pontos de Feitiçaria.', 'spirit-secrets', NULL, 102),

('warlock-trickster-context-switch', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 'Troca de Contexto', 'reaction'::rpg.action_economy_bucket, 3, 'context-switch', NULL, true, 'Reação: troca de lugar com alvo (usos = CAR)', 'Ao ser alvo de ataque corpo a corpo: troca com criatura a 1,5 m (salv. Sabedoria). Usos = mod. Carisma / DL.', 'context-switch', NULL, 100),
('warlock-trickster-harbinger', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 'Arauto do Caos', 'bonus'::rpg.action_economy_bucket, 14, 'harbinger-of-chaos', NULL, true, 'AB: anuncia mudanças (1× / DC)', 'Inimigos que veem/ouvem: salvaguarda de Inteligência ou Desvantagem; aliados têm Vantagem contra eles. 1× / Descanso Curto.', 'harbinger-of-chaos', NULL, 101)
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
