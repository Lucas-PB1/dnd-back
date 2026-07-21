-- Seed rpg.phb_giant_ancestry

INSERT INTO rpg.phb_giant_ancestry (slug, name, benefit)
VALUES
  (
    'ice',
    'Arrepio do Gelo',
    'Ao atingir um alvo com uma jogada de ataque e causar dano a ele, você também pode infligir 1d6 pontos de dano Gélido a esse alvo e reduzir o Deslocamento dele em 3 metros até o início do seu próximo turno.'
  ),
  (
    'fire',
    'Queimadura de Fogo',
    'Ao atingir um alvo com uma jogada de ataque e causar dano a ele, você também pode causar 1d10 pontos de dano Ígneo a esse alvo.'
  ),
  (
    'stone',
    'Resistência da Pedra',
    'Ao sofrer dano, pode executar uma Reação para jogar 1d12. Adicione seu modificador de Constituição ao número obtido e reduza o dano desse total.'
  ),
  (
    'cloud',
    'Salto da Nuvem',
    'Como uma Ação Bônus, você se teleporta magicamente até 9 metros para um espaço desocupado à sua vista.'
  ),
  (
    'hill',
    'Tombo da Colina',
    'Ao atingir uma criatura Grande ou menor com uma jogada de ataque e causar dano a ela, você pode impor a esse alvo a condição Caído.'
  ),
  (
    'storm',
    'Trovão da Tempestade',
    'Ao sofrer dano de uma criatura a até 18 metros de você, você pode executar uma Reação para causar 1d8 pontos de dano Trovejante a essa criatura.'
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  benefit = EXCLUDED.benefit;
