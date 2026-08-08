-- Seed: Feat economy actions (UI Actions tab)
-- Cobertura: PHB + Valdas + Pack2. Skip ASI/treino/magias já na aba Magias.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Lucky
(
  'feat-lucky-advantage', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'lucky'), NULL,
  'Sorte · Vantagem', 'free'::rpg.action_economy_bucket, 1,
  'luckPoints', NULL, true,
  'Gaste 1 Ponto de Sorte: Vantagem em Teste D20',
  'Quando você joga um d20 para um Teste de D20, gaste 1 Ponto de Sorte para ter Vantagem na jogada. Pontos = PB; recupera no Descanso Longo.',
  'spend-resource', NULL, 300, NULL, NULL
),
(
  'feat-lucky-disadvantage', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'lucky'), NULL,
  'Sorte · Desvantagem', 'free'::rpg.action_economy_bucket, 1,
  'luckPoints', NULL, true,
  'Gaste 1 Ponto de Sorte: Desvantagem no ataque contra você',
  'Quando uma criatura joga um d20 para um ataque contra você, gaste 1 Ponto de Sorte para impor Desvantagem nessa jogada.',
  'spend-resource', NULL, 301, NULL, NULL
),
-- Healer
(
  'feat-healer-combat-medic', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'healer'), NULL,
  'Médico de Combate', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Objeto: Kit de Curandeiro + 1 DV do alvo',
  'Ação Usar Objeto (com Kit de Curandeiro): gaste um uso e cuide de uma criatura a até 1,5 m. Ela gasta 1 Dado de Vida; recupera o resultado + seu PB. Cura Garantida: rerole 1s nesses dados.',
  NULL, NULL, 302, NULL, NULL
),
-- Observant / Keen Mind
(
  'feat-observant-search', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), NULL,
  'Pesquisa Rápida', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Procurar como Ação Bônus',
  'Você pode executar a ação Procurar como uma Ação Bônus.',
  NULL, NULL, 303, NULL, NULL
),
(
  'feat-keen-mind-study', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), NULL,
  'Análise Rápida', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Analisar como Ação Bônus',
  'Você pode executar a ação Analisar como uma Ação Bônus.',
  NULL, NULL, 304, NULL, NULL
),
-- War Caster
(
  'feat-war-caster-reactive', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'war-caster'), NULL,
  'Magia Reativa', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: conjurar magia em vez de Ataque de Oportunidade',
  'Quando uma criatura provoca Ataque de Oportunidade ao sair do seu alcance, Reação: conjure uma magia (tempo = 1 ação, um único alvo = essa criatura) em vez do ataque.',
  NULL, NULL, 305, NULL, NULL
),
-- Defensive Duelist
(
  'feat-defensive-duelist-parry', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'defensive-duelist'), NULL,
  'Aparar', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: +PB na CA vs ataque corpo a corpo (Acuidade)',
  'Com arma de Acuidade: quando um ataque corpo a corpo acerta você, Reação: some seu PB à CA até o início do seu próximo turno (pode fazer o ataque errar).',
  NULL, NULL, 306, NULL, NULL
),
-- Polearm Master
(
  'feat-polearm-master-haft', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'polearm-master'), NULL,
  'Golpe de Haste', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Após atacar com haste: Ação Bônus d4 Contundente',
  'Como ação, imediatamente após atacar com Cajado, Lança ou arma Extensão+Pesado, Ação Bônus: ataque com a extremidade oposta (d4 Contundente).',
  NULL, NULL, 307, NULL, NULL
),
(
  'feat-polearm-master-reactive', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'polearm-master'), NULL,
  'Golpe Reativo', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: ataque quando criatura entra no alcance',
  'Com Cajado, Lança ou Extensão+Pesado: Reação para atacar uma criatura que entra no seu alcance.',
  NULL, NULL, 308, NULL, NULL
),
-- Great Weapon Master
(
  'feat-gwm-cleave', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'), NULL,
  'Cortar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Após crítico ou reduzir a 0 PV: ataque extra',
  'Imediatamente após Acerto Crítico ou reduzir uma criatura a 0 PV com arma Corpo a Corpo, Ação Bônus: ataque com a mesma arma.',
  NULL, NULL, 309, NULL, NULL
),
-- Dual Wielder
(
  'feat-dual-wielder-bonus', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'dual-wielder'), NULL,
  'Combate com Duas Armas Aprimorado', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: ataque com segunda arma (não Duas Mãos)',
  'Ao executar Atacar com arma Leve, Ação Bônus: ataque adicional com outra arma Corpo a Corpo que não seja Duas Mãos (sem mod. de atributo no dano, salvo negativo).',
  NULL, NULL, 310, NULL, NULL
),
-- Shield Master
(
  'feat-shield-master-bash', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-master'), NULL,
  'Golpe de Escudo', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '1×/turno após acertar: empurrar ou derrubar com Escudo',
  'Ao acertar com arma Corpo a Corpo na ação Atacar (a 1,5 m), pode forçar salvaguarda de Força com o Escudo: falha = empurrar 1,5 m ou Caído. 1×/turno.',
  NULL, NULL, 311, NULL, NULL
),
(
  'feat-shield-master-interpose', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-master'), NULL,
  'Interpor Escudo', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: sucesso em salvaguarda DES = 0 dano (com Escudo)',
  'Se um efeito permitir salvaguarda de Destreza para metade do dano e você segurar Escudo, Reação: em sucesso não sofre dano.',
  NULL, NULL, 312, NULL, NULL
),
-- Sentinel
(
  'feat-sentinel-guardian', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'sentinel'), NULL,
  'Diligente', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ataque de Oportunidade vs Desengajar / ataque a outro',
  'Imediatamente após criatura a 1,5 m executar Desengajar ou atingir outro alvo, você pode realizar Ataque de Oportunidade. Ao acertar, Deslocamento dela = 0 no turno.',
  NULL, NULL, 313, NULL, NULL
),
-- Durable
(
  'feat-durable-recovery', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'durable'), NULL,
  'Recuperação Rápida', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: gastar 1 DV e recuperar PV',
  'Ação Bônus: gaste um Dado de Pontos de Vida, role-o e recupere PV iguais ao resultado.',
  NULL, NULL, 314, NULL, NULL
),
-- Fighting styles (as feats)
(
  'feat-interception', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'interception'), NULL,
  'Interceptação', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: reduzir dano em 1d10 + PB (aliado a 1,5 m)',
  'Quando uma criatura atinge outra a até 1,5 m de você, Reação: reduza o dano em 1d10 + PB. Requer Escudo ou arma Simples/Marcial.',
  NULL, NULL, 315, NULL, NULL
),
(
  'feat-protection', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'protection'), NULL,
  'Proteção', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: Desvantagem no ataque (Escudo, aliado a 1,5 m)',
  'Quando uma criatura ataca um alvo a 1,5 m (não você), Reação com Escudo: Desvantagem nesse ataque e nos seguintes contra o alvo até o início do seu próximo turno enquanto permanecer a 1,5 m.',
  NULL, NULL, 316, NULL, NULL
),
-- Telekinetic
(
  'feat-telekinetic-shove', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'), NULL,
  'Empurrão Telecinético', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: empurrar 1,5 m (salvaguarda FOR)',
  'Ação Bônus: alvo à vista a até 9 m faz salvaguarda de Força ou é movido 1,5 m na sua direção ou para longe.',
  NULL, NULL, 317, NULL, NULL
),
-- Mage Slayer
(
  'feat-mage-slayer-guard', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'), NULL,
  'Resguardo Mental', 'free'::rpg.action_economy_bucket, 1,
  'mageSlayerGuard', NULL, true,
  'Falhou em INT/SAB/CAR: escolher sucesso (1×/SR)',
  'Se falhar em salvaguarda de Inteligência, Sabedoria ou Carisma, em vez disso escolha sucesso. 1× por Descanso Curto ou Longo.',
  'spend-resource', NULL, 318, NULL, NULL
),
-- Ritual Caster
(
  'feat-ritual-caster-quick', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), NULL,
  'Ritual Rápido', 'action'::rpg.action_economy_bucket, 1,
  'ritualQuick', NULL, true,
  'Conjurar Ritual no tempo normal sem espaço (1×/LR)',
  'Conjure uma magia Ritual preparada no tempo normal (sem o tempo prolongado), sem espaço de magia. 1× por Descanso Longo.',
  'spend-resource', NULL, 319, NULL, NULL
),
-- Charger
(
  'feat-charger-charge', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'charger'), NULL,
  'Ataque em Investida', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '1×/turno: +1d8 dano ou empurrar 3 m (após 3 m reto)',
  'Se mover ≥ 3 m em linha reta antes de acertar ataque corpo a corpo na ação Atacar: +1d8 de dano ou empurrar 3 m (alvo não maior que você). 1×/turno.',
  NULL, NULL, 320, NULL, NULL
),
-- Chef
(
  'feat-chef-treat', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'chef'), NULL,
  'Guloseima Revigorante', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: comer guloseima (PV temporários = PB)',
  'Ação Bônus: comer uma guloseima preparada (válida 8 h) e obter PV temporários iguais ao seu PB.',
  NULL, NULL, 321, NULL, NULL
),
-- Poisoner
(
  'feat-poisoner-apply', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'poisoner'), NULL,
  'Aplicar Veneno', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: aplicar dose em arma/munição',
  'Ação Bônus: aplique uma dose de veneno a uma arma ou munição (potência 1 min ou até causar dano).',
  NULL, NULL, 322, NULL, NULL
),
-- Epic boons
(
  'feat-boon-combat-prowess', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), NULL,
  'Pontaria Inigualável', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Erro vira acerto (1× até início do próximo turno)',
  'Quando errar uma jogada de ataque, em vez disso acerte. Após usar, não pode usar de novo até o início do seu próximo turno.',
  NULL, NULL, 330, NULL, NULL
),
(
  'feat-boon-recovery-death', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), NULL,
  'Até a Morte', 'free'::rpg.action_economy_bucket, 1,
  'boonDeathWard', NULL, true,
  'Ao cair a 0 PV: ficar com 1 + metade do máximo (1×/LR)',
  'Quando reduzido a 0 PV, escolha ficar com 1 PV e recuperar metade dos PV máximos. 1× por Descanso Longo.',
  'spend-resource', NULL, 331, NULL, NULL
),
(
  'feat-boon-recovery-vitality', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), NULL,
  'Recuperar Vitalidade', 'bonus'::rpg.action_economy_bucket, 1,
  'boonVitalityDice', NULL, true,
  'Ação Bônus: gastar d10s da reserva (10/LR)',
  'Ação Bônus: gaste dados da reserva de dez d10s, role-os e recupere PV iguais ao total. Reserva restaura no Descanso Longo.',
  'spend-resource', NULL, 332, NULL, NULL
),
(
  'feat-boon-energy-redirect', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), NULL,
  'Redirecionamento de Energia', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: redirecionar dano de resistência (2d12 + CON)',
  'Ao sofrer dano de um tipo escolhido nas Resistências à Energia, Reação: direcione o mesmo tipo a outra criatura à vista a até 18 m (salvaguarda DES; falha = 2d12 + CON).',
  NULL, NULL, 333, NULL, NULL
),
(
  'feat-boon-speed-disengage', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), NULL,
  'Artista de Fuga', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: Desengajar (+ encerra Imobilizado)',
  'Ação Bônus: execute Desengajar; também encerra a condição Imobilizado em você.',
  NULL, NULL, 334, NULL, NULL
),
(
  'feat-boon-dimensional-steps', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), NULL,
  'Passos Fugazes', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Após Atacar ou Usar Magia: teleporte 9 m',
  'Imediatamente após executar Atacar ou Usar Magia, teleporte-se até 9 m para espaço desocupado à vista.',
  NULL, NULL, 335, NULL, NULL
),
(
  'feat-boon-fate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), NULL,
  'Aprimorar Destino', 'free'::rpg.action_economy_bucket, 1,
  'boonFate', NULL, true,
  '±2d4 em Teste D20 (você ou aliado a 18 m)',
  'Quando você ou outra criatura a até 18 m for bem-sucedida ou falhar em Teste D20, role 2d4 como bônus ou penalidade. Recupera ao jogar Iniciativa ou completar Descanso Curto/Longo.',
  'spend-resource', NULL, 336, NULL, NULL
),
(
  'feat-boon-night-shadows', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), NULL,
  'Fundir-se com Sombras', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: Invisível (Meia-luz/Escuridão)',
  'Em Meia-luz ou Escuridão, Ação Bônus: condição Invisível (encerra ao executar ação, Ação Bônus ou Reação).',
  NULL, NULL, 337, NULL, NULL
),
-- Valdas
(
  'feat-field-commander', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'), NULL,
  'Comando', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação: aliado age imediatamente como Reação',
  'Ação: emita comando a um aliado a até 18 m que possa ouvi-lo. Ele pode realizar imediatamente uma ação como Reação (Atacar 1×, Correr, Esquivar, Esconder, Influenciar, Procurar, Estudar ou Utilizar).',
  NULL, NULL, 340, NULL, NULL
),
(
  'feat-iron-hero-intervention', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'), NULL,
  'Intervenção Heroica', 'reaction'::rpg.action_economy_bucket, 1,
  'ironHeroIntervention', NULL, true,
  'Reação: cancelar Ação Lendária (usos = PB)',
  'Quando um inimigo à vista realiza Ação Lendária, Reação: impeça-a. Usos = PB; Descanso Longo.',
  'spend-resource', NULL, 341, NULL, NULL
),
-- Pack 2
(
  'feat-familiar-distraction', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'familiar-keeper'), NULL,
  'Distração do Familiar', 'reaction'::rpg.action_economy_bucket, 1,
  'familiarDistraction', NULL, true,
  'Reação: familiar impõe Desvantagem (usos = PB)',
  'Quando uma criatura a até 1,5 m do familiar faz jogada de ataque, Reação: ordene Desvantagem. Usos = PB; Descanso Longo.',
  'spend-resource', NULL, 350, NULL, NULL
),
(
  'feat-showman-taunt', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'showman'), NULL,
  'Provocação', 'bonus'::rpg.action_economy_bucket, 1,
  'showmanTaunt', NULL, true,
  'Ação Bônus: Desvantagem no próximo ataque (não contra você)',
  'Ação Bônus: zombe de criatura a até 4,5 m. Se puder ouvi-lo, Desvantagem no próximo ataque contra outro alvo antes do fim do próximo turno dela. Usos = PB; LR.',
  'spend-resource', NULL, 351, NULL, NULL
),
(
  'feat-spellblade-channel', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'), NULL,
  'Ataque Canalizado', 'free'::rpg.action_economy_bucket, 1,
  'spellbladeChannel', NULL, true,
  '+mod INT/SAB/CAR na jogada de ataque (usos = PB)',
  'Ao atacar com arma (Força ou Destreza) com proficiência, some o modificador de INT, SAB ou CAR (mín. +1). Usos = PB; Descanso Longo.',
  'spend-resource', NULL, 352, NULL, NULL
),
(
  'feat-shock-trooper-first-strike', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'shock-trooper'), NULL,
  'Primeiro Golpe', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ao rolar Iniciativa (sem Desvantagem): sacar e atacar',
  'Ao rolar Iniciativa sem Desvantagem, você pode sacar uma arma e realizar um ataque com ela.',
  NULL, NULL, 353, NULL, NULL
),
(
  'feat-magitech-recharge', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magitechnician'), NULL,
  'Recarga de Item Mágico', 'free'::rpg.action_economy_bucket, 1,
  'magitechRecharge', NULL, true,
  'No Descanso Curto: recarregar item (1×/LR)',
  'Ao terminar Descanso Curto, faça um item mágico que recupera cargas recarregar como no próximo amanhecer. 1× por Descanso Longo.',
  'spend-resource', NULL, 354, NULL, NULL
),
(
  'feat-metabolistic-skill', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'metabolistic-magic'), NULL,
  'Perícia Arcana', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Após falhar Teste D20: gastar espaço (+2 + nível)',
  'Quando falhar em Teste D20, gaste um espaço de magia para bônus na jogada igual a 2 + nível do espaço.',
  NULL, NULL, 355, NULL, NULL
),
(
  'feat-metabolistic-fuel', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'metabolistic-magic'), NULL,
  'Combustível Vital', 'free'::rpg.action_economy_bucket, 1,
  'metabolisticFuel', NULL, true,
  'No Descanso Curto: gastar DV para recuperar espaços (1×/LR)',
  'Ao terminar Descanso Curto, gaste até PB Dados de Vida para recuperar espaços cujo nível combinado ≤ DV gastos. 1× por Descanso Longo.',
  'spend-resource', NULL, 356, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
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
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
