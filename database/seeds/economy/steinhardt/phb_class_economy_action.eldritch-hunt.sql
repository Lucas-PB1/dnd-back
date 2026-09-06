-- Economy actions — Steinhardt Eldritch Hunt (declarativo)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
('barbarian-lightning-electrified-chains', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'Correntes Eletrificadas', 'bonus'::rpg.action_economy_bucket, 3, NULL, NULL, false, 'Fúria: AB — enreda com Dano do Recipiente', 'Enquanto em Fúria: Ação Bônus envolve a arma em correntes; no próximo acerto, Dano do Recipiente e enreda. Mesa — sem pool.', 'electrified-chains', NULL, 100),
('barbarian-lightning-fulgurant-strike', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'Golpe Fulgurante', 'bonus'::rpg.action_economy_bucket, 3, NULL, NULL, false, 'Fúria: AB após acerto — Emanação Elétrica', 'Após acerto corpo a corpo: Ação Bônus, Dano do Recipiente + Emanação. Mesa.', 'fulgurant-strike', NULL, 101),
('barbarian-lightning-step', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'Passo Relâmpago', 'bonus'::rpg.action_economy_bucket, 3, NULL, NULL, false, 'Fúria: AB mover + dano elétrico', 'Ação Bônus: move metade da Velocidade; se terminar a 1,5 m, Dano do Recipiente. Nv. 10+: 1×/turno sem AB.', 'lightning-step', NULL, 102),
('barbarian-lightning-roaring-crash', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'), 'Queda Estrondosa', 'free'::rpg.action_economy_bucket, 6, NULL, NULL, false, 'Ao entrar em Fúria: salto e impacto', 'Como parte de entrar em Fúria: salta e causa Dano do Recipiente em área. Mesa.', 'roaring-crash', NULL, 103),

('druid-symbiosis-wickerbone', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'), 'Beemote de Osso-Vime', 'bonus'::rpg.action_economy_bucket, 3, 'wildShape', NULL, true, 'AB: gasta Forma Selvagem → beemote 10 min', 'Ação Bônus sem armadura/escudo: gasta 1 Forma Selvagem e assume a forma de beemote (braços Bordão Místico, Pele-Casca, etc.).', 'wickerbone-behemoth', NULL, 100),

('fighter-blood-strike', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'), 'Golpe de Sangue', 'free'::rpg.action_economy_bucket, 3, 'blood-strike', NULL, true, '1×/turno: opção de Golpe (custo de sangue)', 'Aplica uma opção de Golpe de Sangue a um ataque; sofre o Custo de Sangue. Pool na Economia.', 'blood-strike', NULL, 100),
('fighter-blood-explosion', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'), 'Explosão de Sangue', 'bonus'::rpg.action_economy_bucket, 7, NULL, NULL, false, 'AB após errar com arma revestida', 'Ao errar com arma revestida de sangue: Ação Bônus detona. Mesa.', 'blood-explosion', NULL, 101),

('paladin-eldritch-hunt-prey', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'), 'Caçar a Presa', 'bonus'::rpg.action_economy_bucket, 3, 'channelDivinity', NULL, true, 'AB: Canalizar — marca presa + teleporte', 'Gasta Canalizar Divindade: marca presa 1 min; teleporte até 18 m a 1,5 m dela.', 'hunt-the-prey', NULL, 100),
('paladin-eldritch-perfect-hunter', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'), 'Caçador Perfeito', 'bonus'::rpg.action_economy_bucket, 20, 'perfect-hunter', NULL, true, 'AB: forma de caçador 10 min (1×/DL)', 'Devorar / Partir / Sumir por 10 minutos. Restaure com espaço de 5º.', 'perfect-hunter', NULL, 101),

('ranger-torturer-technique', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'Técnica do Torturador', 'free'::rpg.action_economy_bucket, 3, 'torturer-technique', NULL, true, 'No acerto corpo a corpo: aplica técnica', 'Gasta 1 uso de técnica (2× cada; recupera no DL). Pode empoderar com espaço/Inimigo Favorito.', 'torturer-technique', NULL, 100),
('ranger-torturer-veil', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'Véu de Dor', 'free'::rpg.action_economy_bucket, 11, 'veil-of-pain', NULL, true, 'Ao danificar com técnica: Invisível ao alvo', 'Sem ação: salvaguarda de Sabedoria ou você fica Invisível para o alvo 1 min.', 'veil-of-pain', NULL, 101),
('ranger-torturer-agony', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'), 'Agonia Mental', 'reaction'::rpg.action_economy_bucket, 15, NULL, NULL, false, 'Reação: −1d10 em salvaguarda mental', 'Alvo que falhou técnica recentemente: Reação −1d10 em salvaguarda de INT/SAB/CAR.', 'mental-agony', NULL, 102),

('rogue-blade-armor-faithful', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Armadura dos Fiéis', 'reaction'::rpg.action_economy_bucket, 3, 'divine-points', NULL, true, 'Reação: 1 PD — desvia ataque', 'Reação ao ser alvo de ataque: gasta 1 Ponto Divino; salvaguarda de Sabedoria ou o ataque falha / muda de alvo.', 'armor-of-the-faithful', NULL, 100),
('rogue-blade-rend-blasphemous', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Rasgar o Blasfemo', 'bonus'::rpg.action_economy_bucket, 3, 'divine-points', NULL, true, 'AB após Atacar: +ataque (1 PD)', 'Após ação Atacar com lâmina santificada: Ação Bônus + 1 PD para outro ataque (+mod. Sabedoria).', 'rend-the-blasphemous', NULL, 101),
('rogue-blade-chains-judgement', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Correntes do Julgamento', 'free'::rpg.action_economy_bucket, 9, 'divine-points', NULL, true, 'No acerto: Contido (1 PD)', 'Ao acertar com a lâmina santificada: gaste 1 PD; salvaguarda de Força ou Contido + dano Radiante (mod. Sabedoria) até o fim do seu próximo turno.', 'chains-of-judgement', NULL, 102),
('rogue-blade-divine-retaliation', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Retaliação Divina', 'reaction'::rpg.action_economy_bucket, 9, 'divine-points', NULL, true, 'Reação: contra-ataque (1 PD)', 'Reação ao sofrer dano corpo a corpo com a lâmina: gaste 1 PD e ataque; bônus no dano = mod. Sabedoria.', 'divine-retaliation', NULL, 103),
('rogue-blade-erupting-blades', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Lâminas Eruptivas', 'free'::rpg.action_economy_bucket, 9, 'divine-points', NULL, true, 'Troca Furtivo por linha radiante (2 PD)', 'Ao acertar com ataque que poderia aplicar Furtivo: abra mão do Furtivo e gaste 2 PD; linha 13,5 m — salvaguarda de Destreza, dano = Furtivo (metade no sucesso).', 'erupting-blades', 2, 104),
('rogue-blade-divine-points', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Pontos Divinos', 'free'::rpg.action_economy_bucket, 3, 'divine-points', NULL, false, 'Pool de Pontos Divinos (Lâmina do Esplendor)', 'Controle ± dos Pontos Divinos. Recupera no Descanso Curto/Longo; +1 ao matar certos tipos com a lâmina.', NULL, NULL, 105),
('rogue-blade-spirits', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'), 'Espíritos Divinos', 'action'::rpg.action_economy_bucket, 17, 'final-judgement-spirits', NULL, true, 'Guardiões Espirituais sem espaço (1×/DL)', 'Ação Usar Magia: Guardiões Espirituais. Restaure com 3 Pontos Divinos.', 'final-judgement-spirits', NULL, 106),

('wizard-osteo-brittle-armor', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'), 'Armadura de Osso Frágil', 'action'::rpg.action_economy_bucket, 3, 'brittle-bone-armor', NULL, true, 'Ação: PV temp. + Resistência +2 CA', 'Sem armadura/escudo: PV temp. = 2× nível de Mago, 1 h. Restaure com espaço de 2º+.', 'brittle-bone-armor', NULL, 100),
('wizard-osteo-puppetry', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'), 'Marionetismo Ósseo', 'action'::rpg.action_economy_bucket, 6, 'bone-puppetry', NULL, true, 'Ação: controla esqueleto (CD magia)', 'Alvo com esqueleto a 18 m: salvaguarda de Força ou controle até o fim do próximo turno (nv. 14+: 1 min).', 'bone-puppetry', NULL, 101)
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
