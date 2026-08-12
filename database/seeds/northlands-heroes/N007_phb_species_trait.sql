-- Traços de espécie — Northlands Heroes of the Sagas

-- Bearfolk
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    'Predador de Ápice',
    'Ao fazer um teste de Carisma, pode somar o modificador de Força ou Constituição (escolha na criação). Usos = PB; recupera todos no Descanso Longo.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    'Linhagem do Povo-urso',
    'Você faz parte de uma linhagem que concede habilidades sobrenaturais. Escolha Andari ou Garhamr.',
    'bearfolk_lineage'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    'Coração Selvagem',
    'Você e aliados a 1,5 m têm Vantagem em salvaguardas contra Amedrontado enquanto você estiver consciente e sem a condição Incapacitado.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
    'Pelagem Espessa',
    'Você tem Resistência a dano Gélido e Imunidade aos efeitos de frio extremo.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Beastkin
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
    'Tamanho',
    'Escolha Médio (cerca de 1,20–2,40 m) ou Pequeno (cerca de 0,60–1,20 m) ao selecionar esta espécie.',
    'beastkin_size'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
    'Instinto Animal',
    'Você tem proficiência em Percepção ou Sobrevivência (à sua escolha).',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
    'Armas Naturais',
    'Você tem garras, chifres, cascos, presas, espinhos ou adaptação similar. Com o Mestre, defina o tipo de dano (Contundente, Perfurante ou Cortante). Ataques Desarmados com essa arma causam 1d6 + mod. Força ou Destreza (escolha na criação) do tipo escolhido, em vez do dano normal.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
    'Adaptação Natural',
    'Você herda um dos traços abaixo conforme as características animais desejadas: Aviário, Ágil, Aquático ou Robusto.',
    'beastkin_adaptation'::rpg.species_choice_kind
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Giantkin
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
    'Pegar e Arremessar',
    'Se for atingido por um ataque com arma à distância, pode usar a Reação para somar 3 à CA. Se isso fizer o ataque errar, pode pegar o projétil (ou arma pequena arremessada, a critério do Mestre) e arremessá-lo de volta no atacante, usando seu bônus de ataque à distância e o dano normal da arma.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
    'Ancestria Giganteide',
    'Escolha uma ancestria (Nuvem, Fogo, Geada, Colina, Pedra ou Tempestade). Você obtém resistência natural a certos ambientes/condições e o benefício indicado.

Se um benefício conceder conjurar magia, você a tem sempre preparada; pode conjurá-la 1× sem espaço e recupera essa forma no Descanso Longo (também pode usar espaços). CD de salvaguarda = 8 + PB + mod. Inteligência, Sabedoria ou Carisma (escolha na criação).',
    'giantkin_ancestry'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
    'Constituição Poderosa',
    'Você tem Vantagem em salvaguardas para encerrar a condição Agarrado. Também conta como um tamanho maior ao determinar capacidade de carga.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Trollkin
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
    'Visão no Escuro',
    'Você tem Visão no Escuro com alcance de 36 metros.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
    'Adaptação Natural',
    'Manifeste traços conforme o ancestral não humano. Escolha Fey, Ogro ou Troll.',
    'trollkin_ancestry'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
    'Arma Natural',
    'Você tem presas, cascos ou garras. Com o Mestre, defina Contundente, Perfurante ou Cortante. Ataques Desarmados causam 1d6 + mod. Força ou Destreza (escolha na criação) do tipo escolhido, em vez do Contundente normal.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
    'Regeneração Trollística',
    'Como Ação Bônus, gaste qualquer número de Dados de Vida até o seu PB para recuperar PV. Se sofrer dano Ácido ou Ígneo, perde o acesso a esta habilidade até terminar um Descanso Curto.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Werekin
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    'Visão no Escuro',
    'Você tem Visão no Escuro com alcance de 18 metros.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    'Garras',
    'Você pode usar garras afiadas em Ataques Desarmados. No acerto, causa 1d6 + mod. Força de dano Cortante, em vez do Contundente normal.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    'Proeza Predatória',
    'Você tem proficiência em Atletismo, Intimidação, Percepção ou Sobrevivência (à sua escolha).',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    'Faro',
    'Você tem Vantagem em testes de Sabedoria (Percepção) relacionados a detectar odores e rastrear.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
    'Mudar Aspecto',
    'Como Ação Bônus, transforme-se por 1 minuto (ou até encerrar sem ação). 1× / Descanso Longo.

Ao transformar, escolha uma opção (a cada uso): Força Bestial (PV temp. = 2× PB; Vantagem em testes de Força e para resistir/encerrar Agarrado); Selvageria Primal (rugido: criaturas não aliadas a 3 m — salvaguarda de Carisma CD 8+PB+Carisma ou Amedrontado até o fim do próximo turno; sucesso = imune 24 h; pode rugir de novo como AB nos turnos seguintes); Caçador Veloz (Velocidade +3 m; Vantagem em Força (Atletismo) e Sabedoria (Sobrevivência)).',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Baugsmidr Dwarf
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'baugsmidr-dwarf'),
    'Lore Arcano',
    'Você tem Vantagem em testes de Inteligência (Arcanismo).',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'baugsmidr-dwarf'),
    'Visão no Escuro',
    'Você tem Visão no Escuro com alcance de 36 metros.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'baugsmidr-dwarf'),
    'Resiliência Anã',
    'Você tem Resistência a dano Venenoso e Vantagem em salvaguardas para evitar ou encerrar a condição Envenenado.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'baugsmidr-dwarf'),
    'Artesão Mágico',
    'Você tem Vantagem em quaisquer testes feitos para criar itens mágicos.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'baugsmidr-dwarf'),
    'Sentir Magia',
    'Como Ação Bônus, sinta a presença de magia a até 36 m até o fim do próximo turno. Você vê aura fraca em objetos mágicos visíveis ou magias ativas e conhece a escola. Também detecta presença e localização de Aberrações, Celestiais, Fey, Ínferos e Mortos-Vivos. Bloqueado por 30 cm de material sólido. Usos = PB / Descanso Longo.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Fjord Dwarf
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'fjord-dwarf'),
    'Visão no Escuro',
    'Você tem Visão no Escuro com alcance de 27 metros.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'fjord-dwarf'),
    'Tenacidade Anã',
    'Seu máximo de Pontos de Vida aumenta em 1, e aumenta em 1 novamente sempre que você sobe de nível.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'fjord-dwarf'),
    'Guerreiro dos Fiordes',
    'Você não sofre penalidades nas jogadas de ataque enquanto se equilibra ou escala.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'fjord-dwarf'),
    'Maestria das Ondas',
    'Você tem Deslocamento de Natação igual ao seu Deslocamento e pode prender a respiração pelo dobro do tempo normal.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
