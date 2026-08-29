-- Propriedades de arma avançadas (Grim Hollow Cap. 5)

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
  ('armor-piercing', 'Perfuração de Armadura', 'Ataques com esta arma ou munição ignoram Resistência a dano não mágico.'),
  ('blackpowder', 'Pólvora', 'Arma de fogo de pólvora. Requer munição adequada; propriedades especiais exigem proficiência em Armas Avançadas.'),
  ('cumbersome', 'Desajeitada', 'Você tem Desvantagem em testes de Destreza e em testes de Destreza (Furtividade) enquanto empunha esta arma.'),
  ('damage', 'Dano', 'Esta arma pode causar tipos de dano adicionais indicados entre parênteses além do dano base.'),
  ('double', 'Dupla', 'Arma com duas extremidades distintas; cada extremidade pode ter dano, tipo e maestria próprios.'),
  ('hafted', 'Haste', 'Pode atacar com a lâmina ou com a extremidade da haste; a haste usa o dano e a maestria indicados para ela.'),
  ('magazine', 'Pente', 'Carrega várias munições de uma vez; o número entre parênteses é a capacidade do pente.'),
  ('momentum', 'Momentum', 'Enquanto montado, ao acertar um ataque você pode rolar dados de momentum extras (indicados entre parênteses) e somá-los ao dano.'),
  ('repeater', 'Repetição', 'Pode realizar múltiplos ataques com uma única ação Atacar, conforme as regras da arma repetidora.'),
  ('ranging', 'Alcance Estendido', 'Munição que aumenta o alcance normal e máximo da arma que a dispara.'),
  ('whistling', 'Assobio', 'Munição que emite assobio audível; útil para sinalização ou distração.'),
  ('blessed-ammo', 'Abençoada', 'Munição abençoada com propriedades contra criaturas profanas ou mortas-vivas.'),
  ('brutal-ammo', 'Brutal (munição)', 'Munição que maximiza o dano em acertos críticos ou adiciona efeito brutal conforme a descrição.'),
  ('desecrated-ammo', 'Profanada', 'Munição profanada com efeitos contra alvos sagrados ou vivos.'),
  ('incendiary-ammo', 'Incendiária', 'Munição que pode inflamar o alvo ou causar dano de Fogo adicional.'),
  ('alchemical-ammo', 'Alquímica', 'Munição alquímica com efeito especial descrito no item.')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
