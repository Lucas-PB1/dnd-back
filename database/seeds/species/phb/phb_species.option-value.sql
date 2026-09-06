-- Seed rpg.phb_option_value (scope = 'species')
-- Lote C: migrado de phb_species_option_value

-- Elf lineages (level1_benefit + spells L1/L3/L5)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, level1_benefit, spell_level1_id, spell_level3_id, spell_level5_id)
VALUES
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'high-elf', 'Alto Elfo',
    'Você conhece o truque Prestidigitação Arcana. Sempre que completar um Descanso Longo, você pode substituir este truque por um truque diferente da lista de magias de Mago.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'prestidigitacao-arcana'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-magia'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'passo-nebuloso')
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'drow', 'Drow',
    'O alcance da sua Visão no Escuro aumenta para 36 metros. Você também conhece o truque Luzes Dançantes.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'luzes-dancantes'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'fogo-das-fadas'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'escuridao')
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'wood-elf', 'Elfo Silvestre',
    'Seu Deslocamento aumenta para 10,5 metros. Você também conhece o truque Arte Druídica.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'arte-druidica'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'passos-largos'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'passo-sem-rastro')
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level1_id = EXCLUDED.spell_level1_id,
  spell_level3_id = EXCLUDED.spell_level3_id,
  spell_level5_id = EXCLUDED.spell_level5_id;

-- Infernal legacies (level1_benefit + spells L1/L3/L5)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, level1_benefit, spell_level1_id, spell_level3_id, spell_level5_id)
VALUES
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'abyssal', 'Abissal',
    'Você tem Resistência a dano Venenoso. Você também conhece o truque Rajada de Veneno.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'rajada-de-veneno'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-nauseante'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'paralisar-pessoa')
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'chthonic', 'Ctônico',
    'Você tem Resistência a dano Necrótico. Você também conhece o truque Toque Necrótico.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'toque-necrotico'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'vitalidade-vazia'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-do-enfraquecimento')
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'infernal', 'Infernal',
    'Você tem Resistência a dano Ígneo. Você também conhece o truque Raio de Fogo.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-de-fogo'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'repreensao-diabolica'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'escuridao')
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level1_id = EXCLUDED.spell_level1_id,
  spell_level3_id = EXCLUDED.spell_level3_id,
  spell_level5_id = EXCLUDED.spell_level5_id;

-- Gnome lineages (level1_benefit + spell_1 + spell_2)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, level1_benefit, spell_1_id, spell_2_id)
VALUES
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeLineageId', 'rock-gnome', 'Gnomo das Rochas',
    'Você conhece os truques Prestidigitação Arcana e Reparar. Além disso, pode fabricar dispositivos mecânicos minúsculos com Prestidigitação Arcana.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'prestidigitacao-arcana'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'reparar')
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeLineageId', 'forest-gnome', 'Gnomo do Bosque',
    'Você conhece o truque Ilusão Menor. Você também sempre tem a magia Falar com Animais preparada.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'falar-com-animais')
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_1_id = EXCLUDED.spell_1_id,
  spell_2_id = EXCLUDED.spell_2_id;

-- Dragon ancestry (damage_type)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, damage_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'blue', 'Azul', 'Elétrico'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'black', 'Negro', 'Ácido'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'white', 'Branco', 'Gélido'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'gold', 'Ouro', 'Ígneo'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'bronze', 'Bronze', 'Elétrico'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'silver', 'Prata', 'Gélido'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'copper', 'Cobre', 'Ácido'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'green', 'Verde', 'Venenoso'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'brass', 'Latão', 'Ígneo'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'red', 'Vermelho', 'Ígneo')
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  damage_type = EXCLUDED.damage_type;

-- Giant ancestry (benefit)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, benefit)
VALUES
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'ice', 'Arrepio do Gelo',
    'Ao atingir um alvo com uma jogada de ataque e causar dano a ele, você também pode infligir 1d6 pontos de dano Gélido a esse alvo e reduzir o Deslocamento dele em 3 metros até o início do seu próximo turno.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'fire', 'Queimadura de Fogo',
    'Ao atingir um alvo com uma jogada de ataque e causar dano a ele, você também pode causar 1d10 pontos de dano Ígneo a esse alvo.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'stone', 'Resistência da Pedra',
    'Ao sofrer dano, pode executar uma Reação para jogar 1d12. Adicione seu modificador de Constituição ao número obtido e reduza o dano desse total.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'cloud', 'Salto da Nuvem',
    'Como uma Ação Bônus, você se teleporta magicamente até 9 metros para um espaço desocupado à sua vista.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'hill', 'Tombo da Colina',
    'Ao atingir uma criatura Grande ou menor com uma jogada de ataque e causar dano a ela, você pode impor a esse alvo a condição Caído.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'storm', 'Trovão da Tempestade',
    'Ao sofrer dano de uma criatura a até 18 metros de você, você pode executar uma Reação para causar 1d8 pontos de dano Trovejante a essa criatura.'
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  benefit = EXCLUDED.benefit;

-- Aasimar revelations (sem colunas extras — só label)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'celestial-wings', 'Asas Celestiais'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'necrotic-shroud', 'Mortalha Necrótica'),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'radiant-consumption', 'Consumo Radiante')
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label;
