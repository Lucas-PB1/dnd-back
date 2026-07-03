-- Seed rpg.phb_fighting_style
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_fighting_style (slug, name, description)
VALUES
  ('archery', 'Arquearia', 'Você recebe um bônus de +2 nas jogadas de ataque com armas à Distância.'),
  ('blind-fighting', 'Luta às Cegas', 'Você tem Visão às Cegas com um alcance de 3 metros.'),
  ('defense', 'Defensivo', 'Enquanto estiver usando armadura Leve, Média ou Pesada, você recebe um bônus de +1 na Classe de Armadura.'),
  ('dueling', 'Duelismo', 'Quando você segura uma arma Corpo a Corpo em uma mão e nenhuma outra arma, você recebe um bônus de +2 nas jogadas de dano desta arma.'),
  ('great-weapon-fighting', 'Combate com Armas Grandes', 'Quando você joga dano para um ataque que realiza com uma arma Corpo a Corpo que está empunhando com as duas mãos, pode tratar qualquer 1 ou 2 em um dado de dano como um 3. A arma deve ter a propriedade Duas Mãos ou Versátil para obter este benefício.'),
  ('interception', 'Interceptação', 'Quando uma criatura à sua vista atinge outra criatura a até 1,5 metro de você com uma jogada de ataque, você pode executar uma Reação para reduzir o dano causado ao alvo em 1d10 mais seu Bônus de Proficiência. Você deve estar segurando um Escudo ou uma arma Simples ou Marcial para executar esta Reação.'),
  ('protection', 'Protetivo', 'Quando uma criatura à sua vista ataca um alvo que não é você e que está a até 1,5 metro de distância, você pode executar uma Reação para interpor seu Escudo, se o estiver segurando. Isso impõe Desvantagem na jogada de ataque que acionou a reação e em todas as jogadas contra o alvo até o início do seu próximo turno, enquanto você estiver a até 1,5 metro do alvo.'),
  ('thrown-weapon-fighting', 'Combate com Armas de Arremesso', 'Quando você atinge com uma jogada de ataque à distância usando uma arma com a propriedade Arremesso, você obtém um bônus de +2 na jogada de dano.'),
  ('two-weapon-fighting', 'Combate com Duas Armas', 'Quando você realiza um ataque adicional como resultado de usar uma arma com a propriedade Leve, você pode adicionar seu modificador de atributo ao dano desse ataque, se já não estiver adicionando-o ao dano.'),
  ('unarmed-fighting', 'Combate Desarmado', 'Quando você atinge com seu Ataque Desarmado e causa dano, pode causar dano Contundente igual a 1d6 mais seu modificador de Força em vez do dano normal de um Ataque Desarmado. Se você não estiver segurando nenhuma arma ou Escudo quando realizar a jogada de ataque, o d6 se torna um d8. No início de cada um dos seus turnos, você pode causar 1d4 pontos de dano Contundente a uma criatura Imobilizada por você.'),
  ('blessed-warrior', 'Combatente Abençoado', 'Estilo de luta alternativo do Paladino (PHB 2024).'),
  ('druidic-warrior', 'Combatente Druídico', 'Estilo de luta alternativo do Guardião (PHB 2024).');
