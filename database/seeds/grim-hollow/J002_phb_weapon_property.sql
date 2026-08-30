-- Propriedades de arma avançadas (Grim Hollow Cap. 5)

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
  ('armor-piercing', 'Perfuração de Armadura', 'Uma arma com Perfuração de Armadura é uma arma corpo a corpo feita para atravessar armadura ou couro grosso. Ao fazer uma jogada de ataque com uma arma com Perfuração de Armadura, você ganha +1 na jogada se o alvo estiver usando armadura ou tiver Classe de Armadura 18 ou superior.'),
  ('blackpowder', 'Pólvora', 'Armas de pólvora disparam projéteis com estrondo ensurdecedor, rasgando armaduras com força letal. Ao disparar, emitem um estalo audível em até 90 m. Uma arma de pólvora exposta a chuva forte, submersa ou encharcada de outro modo não pode disparar até secar por 1 hora. Usam projéteis de cartucho de papel como munição.'),
  ('cumbersome', 'Desajeitada', 'Armas Desajeitadas são difíceis de manejar, mas ferramentas à distância eficazes para quem tem força suficiente. Ao atacar com uma arma Desajeitada, você deve usar o modificador de Força nas jogadas de ataque e de dano.'),
  ('damage', 'Dano', 'Uma arma com a propriedade Dano pode causar tipos de dano diferentes. Ao acertar um ataque com esta arma, escolha um dos tipos de dano permitidos.'),
  ('double', 'Dupla', 'Uma arma Dupla funciona como duas armas Leves, uma em cada mão, para combate com duas armas. Se uma arma Dupla tiver a propriedade Alcance, você só pode usar uma dessas propriedades por turno.'),
  ('hafted', 'Haste', 'A haste de uma arma com Haste serve bem para um ataque com a mão secundária. Depois de usar a ação Atacar com uma arma com Haste, você pode usar uma Ação Bônus para fazer um ataque corpo a corpo com a haste. A haste causa 1d6 de dano Contundente e você adiciona o modificador de atributo ao dano.'),
  ('magazine', 'Pente', 'Uma arma com Pente também indica um número e um tipo de munição. A arma comporta essa quantidade e tipo, que você gasta antes de precisar recarregar. Como Ação Bônus, você pode remover um pente e recarregar com um pente novo. Uma arma com Pente vem com dois pentes vazios incluídos no custo e peso. Um pente vazio adicional custa 25 PO. Carregar um pente vazio leva 1 minuto.'),
  ('momentum', 'Momentum', 'Armas com Momentum permitem golpes devastadores em movimento rápido. Ao acertar com uma arma com Momentum depois de se mover 6 m ou mais em linha reta no mesmo turno, melhore os dados de dano para o valor de Dados de Momentum da arma.'),
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
