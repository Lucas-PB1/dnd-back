-- Propriedades de arma Eldritch Hunt (Player Pack)

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
  (
    'artillery',
    'Artilharia',
    'Você deve usar Força em vez de Destreza nas jogadas de ataque e dano de uma arma com a propriedade Artilharia, e só pode fazer um ataque à distância com ela se tiver munição para disparar. O tipo de munição exigido é indicado com o alcance da arma. Cada ataque gasta uma peça de munição. Armas com Artilharia devem ser recarregadas com uma ação. Após um combate, você pode gastar 1 minuto para recuperar metade da munição (arredondada para baixo) usada no combate; o restante é perdido.'
  ),
  (
    'barrel',
    'Cano',
    'Uma arma com Cano pode ser disparada um número de vezes igual ao número de balas que o cano comporta (escrito como Cano X) antes de precisar ser recarregada. Pode ser recarregada como uma ação ou no lugar de um ataque como parte da ação Atacar. Se a arma também tiver a propriedade Leve, também pode ser recarregada como Ação Bônus. Você precisa de uma mão livre para recarregar a arma.'
  ),
  (
    'blaring',
    'Estridente',
    'Disparar uma arma Estridente produz um estalo trovejante. O som pode ser ouvido a até 30 m. Fazer um ataque à distância com esta propriedade dificulta passar despercebido: você tem Desvantagem em testes de Destreza (Furtividade) feitos como parte da ação Esconder-se até o início do seu próximo turno. Além disso, se uma criatura estiver na área do estrondo sonoro, ela tem Vantagem em testes de Sabedoria (Percepção) feitos contra você como parte da ação Procurar.'
  ),
  (
    'booming',
    'Estrondoso',
    'A deflagração ao disparar uma arma Estrondosa produz um estrondo formidável. O som pode ser ouvido a até 150 m. Fazer um ataque à distância com esta propriedade torna impossível passar despercebido: você falha automaticamente em testes de Destreza (Furtividade) feitos como parte da ação Esconder-se até o início do seu próximo turno. Além disso, se uma criatura estiver na área do estrondo sonoro, ela tem sucesso automático em testes de Sabedoria (Percepção) feitos contra você como parte da ação Procurar.'
  ),
  (
    'spread-fire',
    'Fogo Espalhado',
    'Uma arma com Fogo Espalhado não pode fazer um ataque normal. Em vez disso, pulveriza um Cone com comprimento igual ao seu alcance (por exemplo, um bacamarte com alcance de 6 m dispara num Cone de 6 m). Cada criatura na área deve ser bem-sucedida numa salvaguarda de Destreza (CD 8 + seu modificador de Destreza + seu Bônus de Proficiência) ou sofrer o dano normal da arma.'
  ),
  (
    'twinned-barrel',
    'Cano Duplo',
    'Uma arma de Cano Duplo tem dois canos, cada um capaz de conter uma bala de arma de fogo, e ambos podem ser carregados como parte de recarregar a arma. Você pode disparar ambos os canos como parte de um ataque, em vez de cada cano individualmente. Isso esvazia ambos os canos (conforme a propriedade Cano), mas aumenta o dado de dano da arma no acerto (de d4 para d6, d8, d10 ou d12).'
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
