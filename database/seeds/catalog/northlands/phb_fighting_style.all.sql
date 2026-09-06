-- Estilos de luta Northlands (tabela phb_fighting_style)

INSERT INTO rpg.phb_fighting_style (slug, name, description)
VALUES
  ('glima', 'Glima', 'Glima. Glima é o nome de um estilo de luta desarmada nas Terras do Norte semelhante à luta corpo a corpo. Quando você acerta com um ataque desarmado contra uma criatura a até 1,5 metro de você, se essa criatura for de um tamanho maior que o seu ou menor, pode escolher forçar essa criatura a fazer uma salvaguarda de Força (CD igual a 8 + seu Bônus de Proficiência + seu modificador de Força). Em caso de falha, a criatura alvo tem a condição Caído.'),
  ('raiders-rush', 'Investida do Saqueador', 'Investida do Saqueador. Você tem Vantagem em jogadas de ataque contra qualquer criatura a até 1,5 metro de um dos seus aliados se você se mover pelo menos 4,5 metros e parar a até 1,5 metro desse aliado.'),
  ('savagery', 'Selvageria', 'Selvageria. Quando você faz sua primeira jogada de ataque corpo a corpo com arma no seu turno, pode decidir atacar com selvageria. Isso permite adicionar seu Bônus de Proficiência às suas jogadas de dano corpo a corpo com arma, mas reduz sua CA em 2 até o início do seu próximo turno.'),
  ('shield-wall', 'Muralha de Escudos', 'Proteger Aliado. Quando uma criatura que você possa ver acerta um aliado adjacente a você com um ataque, você pode executar uma Reação para conceder ao seu aliado o bônus de Classe de Armadura do seu Escudo contra o ataque desencadeador. Ombro a Ombro. Quando você e um aliado estão ambos empunhando um escudo e adjacentes um ao outro, ambos ganham um bônus de +1 na Classe de Armadura.'),
  ('skirmisher', 'Escaramuçador', 'Mobilidade. Seu Deslocamento aumenta em 3 metros. Golpear e Desaparecer. Uma vez em cada um dos seus turnos, você pode causar dano extra igual ao seu Bônus de Proficiência a uma criatura que acertar com um ataque que cause dano Contundente, Perfurante ou Cortante, desde que tenha se movido 4,5 metros antes de fazer o ataque.'),
  ('underfoot', 'Pelos Pés', 'Pelos Pés. Você pode terminar seu movimento em um espaço ocupado por uma criatura dois tamanhos maior que você. Se atacar essa criatura enquanto compartilha o espaço dela, tem Vantagem na jogada de ataque. Se essa criatura atacá-lo enquanto compartilha o seu espaço, ela tem Desvantagem na jogada de ataque.')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
