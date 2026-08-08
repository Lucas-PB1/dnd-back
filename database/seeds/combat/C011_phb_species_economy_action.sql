-- Seed: Species economy actions (UI Actions tab)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'species-aasimar-healing-hands', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), NULL,
  'Mãos Curativas', 'action'::rpg.action_economy_bucket, 1,
  'healingHands', NULL, true,
  'Toque: PB × d4 de cura (1×/LR)',
  'Ação Usar Magia: toque uma criatura e role um número de d4s igual ao seu Bônus de Proficiência; ela recupera PV iguais ao total. 1 uso por Descanso Longo.',
  'spend-resource', NULL, 200, NULL, NULL
),
(
  'species-aasimar-celestial-revelation', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), NULL,
  'Revelação Celestial', 'bonus'::rpg.action_economy_bucket, 3,
  'celestialRevelation', NULL, true,
  'Transformação 1 min (Asas / Manto / Transfiguração)',
  'Ação Bônus (nv. 3+): transforme-se por 1 minuto. Escolha Asas Celestiais, Manto Necrótico ou Transfiguração Radiante a cada uso. 1×/LR. Enquanto transformado, +PB de dano (Necrótico ou Radiante) 1×/turno.',
  'spend-resource', NULL, 201, NULL, NULL
),
(
  'species-dwarf-stonecunning', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), NULL,
  'Conhecimento de Pedras', 'bonus'::rpg.action_economy_bucket, 1,
  'stonecunning', NULL, true,
  'Sismiconsciência 18 m (10 min; em pedra)',
  'Ação Bônus: ganhe Sismiconsciência 18 m por 10 minutos enquanto estiver em ou tocando pedra (natural ou trabalhada). Usos = PB; recupera no Descanso Longo.',
  'spend-resource', NULL, 202, NULL, NULL
),
(
  'species-dragonborn-breath', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), NULL,
  'Ataque de Sopro', 'action'::rpg.action_economy_bucket, 1,
  'breathWeapon', NULL, true,
  'Substitui 1 ataque: cone 4,5 m ou linha 9 m',
  'Ao executar a ação Atacar, substitua um ataque por sopro (cone 4,5 m ou linha 9×1,5 m). Salvaguarda DES; dano da Herança Dracônica (1d10→4d10 nos níveis 5/11/17). Usos = PB; LR.',
  'spend-resource', NULL, 203, NULL, NULL
),
(
  'species-dragonborn-flight', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), NULL,
  'Voo Dracônico', 'bonus'::rpg.action_economy_bucket, 5,
  'dragonFlight', NULL, true,
  'Asas espectrais 10 min (Desloc. de Voo)',
  'Ação Bônus (nv. 5+): asas espectrais por 10 minutos; Deslocamento de Voo igual ao seu Deslocamento. 1×/LR.',
  'spend-resource', NULL, 204, NULL, NULL
),
(
  'species-goliath-ice', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Arrepio do Gelo', 'free'::rpg.action_economy_bucket, 1,
  'giantAncestry', NULL, true,
  'Ao acertar: +1d6 Gélido e −3 m Desloc.',
  'Ao atingir e causar dano com um ataque, você também pode causar 1d6 Gélido e reduzir o Deslocamento do alvo em 3 m até o início do seu próximo turno. Usos = PB; LR.',
  'spend-resource', NULL, 210, 'giantAncestryId', 'ice'
),
(
  'species-goliath-fire', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Queimadura de Fogo', 'free'::rpg.action_economy_bucket, 1,
  'giantAncestry', NULL, true,
  'Ao acertar: +1d10 Ígneo',
  'Ao atingir e causar dano com um ataque, você também pode causar 1d10 Ígneo. Usos = PB; LR.',
  'spend-resource', NULL, 211, 'giantAncestryId', 'fire'
),
(
  'species-goliath-stone', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Resistência da Pedra', 'reaction'::rpg.action_economy_bucket, 1,
  'giantAncestry', NULL, true,
  'Reação: 1d12 + CON reduz dano',
  'Ao sofrer dano, Reação: role 1d12 + modificador de Constituição e reduza o dano desse total. Usos = PB; LR.',
  'spend-resource', NULL, 212, 'giantAncestryId', 'stone'
),
(
  'species-goliath-cloud', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Salto da Nuvem', 'bonus'::rpg.action_economy_bucket, 1,
  'giantAncestry', NULL, true,
  'Teleporte mágico até 9 m',
  'Ação Bônus: teleporte magicamente até 9 m para um espaço desocupado à sua vista. Usos = PB; LR.',
  'spend-resource', NULL, 213, 'giantAncestryId', 'cloud'
),
(
  'species-goliath-hill', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Tombo da Colina', 'free'::rpg.action_economy_bucket, 1,
  'giantAncestry', NULL, true,
  'Ao acertar (≤ Grande): Caído',
  'Ao atingir criatura Grande ou menor e causar dano, você pode impor a condição Caído. Usos = PB; LR.',
  'spend-resource', NULL, 214, 'giantAncestryId', 'hill'
),
(
  'species-goliath-storm', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Trovão da Tempestade', 'reaction'::rpg.action_economy_bucket, 1,
  'giantAncestry', NULL, true,
  'Reação: 1d8 Trovejante (18 m)',
  'Ao sofrer dano de uma criatura a até 18 m, Reação: cause 1d8 Trovejante a ela. Usos = PB; LR.',
  'spend-resource', NULL, 215, 'giantAncestryId', 'storm'
),
(
  'species-goliath-large-form', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL,
  'Forma Grande', 'bonus'::rpg.action_economy_bucket, 5,
  'largeForm', NULL, true,
  'Tamanho Grande 10 min (+3 m, Vant. FOR)',
  'Ação Bônus (nv. 5+): torne-se Grande por 10 minutos (espaço permitindo). Vantagem em testes de Força; +3 m Deslocamento. 1×/LR.',
  'spend-resource', NULL, 216, NULL, NULL
),
(
  'species-orc-adrenaline', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'orc'), NULL,
  'Pico de Adrenalina', 'bonus'::rpg.action_economy_bucket, 1,
  'adrenalineSurge', NULL, true,
  'Correr + PV temp. = PB',
  'Ação Bônus: execute Correr e ganhe PV temporários iguais ao PB. Usos = PB; recupera no Descanso Curto ou Longo.',
  'spend-resource', NULL, 220, NULL, NULL
),
(
  'species-orc-relentless', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'orc'), NULL,
  'Vigor Implacável', 'free'::rpg.action_economy_bucket, 1,
  'relentlessEndurance', NULL, true,
  'Ao cair a 0 PV: fica com 1 PV',
  'Ao ser reduzido a 0 PV sem morrer imediatamente, você fica com 1 PV. 1×/LR.',
  'spend-resource', NULL, 221, NULL, NULL
),
(
  'species-mandrake-vines', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), NULL,
  'Vinhas Enredantes', 'bonus'::rpg.action_economy_bucket, 1,
  'entanglingVines', NULL, true,
  'Velocidade 0 (9 m; ≤ Grande)',
  'Ação Bônus: ervas e vinhas prendem uma criatura Grande ou menor a até 9 m (Velocidade 0 até o fim do próximo turno dela). Usos = PB; LR. No nv. 3+, efeito extra conforme a estação.',
  'spend-resource', NULL, 230, NULL, NULL
),
(
  'species-geppettin-bisque', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), NULL,
  'Surpresa de Porcelana', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '1º turno: +PB no dano de arma',
  'No primeiro turno de combate, ao causar dano com ataque de arma, a criatura sofre dano extra igual ao PB (mesmo tipo da arma).',
  NULL, NULL, 240, 'constructionId', 'bisque'
),
(
  'species-geppettin-plushie', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), NULL,
  'Penugem Resistente', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação a Contundente: Resistência + empurrão 1,5 m',
  'Ao sofrer dano Contundente, Reação: Resistência a esse dano e empurrão de 1,5 m da fonte (se puder ser afastado).',
  NULL, NULL, 241, 'constructionId', 'plushie'
),
(
  'species-halfling-luck', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'halfling'), NULL,
  'Sorte', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ao tirar 1 no d20: rerrola',
  'Ao tirar 1 no D20 de um Teste de D20, você pode jogar novamente e deve usar a nova jogada.',
  NULL, NULL, 250, NULL, NULL
),
(
  'species-halfling-naturally-stealthy', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'halfling'), NULL,
  'Furtividade Natural', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Esconder atrás de criatura ≥ 1 tamanho maior',
  'Você pode executar a ação Esconder mesmo quando estiver encoberto apenas por uma criatura pelo menos um tamanho maior que você.',
  NULL, NULL, 251, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
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
