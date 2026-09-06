-- Benefícios dos talentos gerais / estilos Northlands

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'axe-fighter'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'axe-fighter'),
    2,
    'Rajada de Machado',
    'Rajada de Machado. Uma vez em cada um dos seus turnos, se você acertar uma criatura com uma Machadinha, pode realizar um ataque extra com uma Machadinha como Ação Bônus.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'axe-fighter'),
    3,
    'Derrubada Precisa',
    'Derrubada Precisa. Quando você acerta uma criatura com um Machado de Batalha, essa criatura tem Desvantagem na salvaguarda de Constituição para evitar a condição Caído causada pela propriedade Derrubar do Machado de Batalha.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'axe-fighter'),
    4,
    'Trespassar Interminável',
    'Trespassar Interminável. O número de criaturas adicionais que você pode atacar usando a propriedade Trespassar de um Machado Grande aumenta em um valor igual à metade do seu Bônus de Proficiência (arredondado para baixo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'axe-thrower'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'axe-thrower'),
    2,
    'Arremesso de Retorno',
    'Arremesso de Retorno. Quando você realiza um ataque à distância com arma com uma Machadinha e erra a jogada de ataque, pode usar uma Ação Bônus no mesmo turno para agarrar a arma conforme ela gira de volta até você.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'battle-cry'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'battle-cry'),
    2,
    'Grito Trovejante',
    'Grito Trovejante. Você pode usar uma Ação Bônus para soltar um grito de guerra aterrorizante. Faça um teste de Carisma (Intimidação). Uma criatura à sua escolha que possa ouvi-lo a até 9 metros de você deve fazer uma salvaguarda de Sabedoria com CD igual ao resultado do seu teste de Carisma (Intimidação) ou tem a condição Amedrontado por 1d4 rodadas. O alvo pode fazer uma nova salvaguarda no final de cada um dos seus turnos para encerrar o efeito. Depois de usar essa capacidade, você não pode usá-la novamente até completar um Descanso Curto. Em níveis mais altos, você pode mirar um número adicional de criaturas com essa capacidade. No 9º nível, pode mirar duas criaturas. No 15º nível, pode mirar três criaturas, e o alcance dessa capacidade aumenta para 18 metros.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-angrboda-and-bergelmir'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Sabedoria em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-angrboda-and-bergelmir'),
    2,
    'Golpe Trovejante',
    'Golpe Trovejante. Quando você acerta com um ataque corpo a corpo com arma, pode escolher causar 1d6 de dano Trovejante extra. Você pode usar seu Golpe Trovejante um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-angrboda-and-bergelmir'),
    3,
    'Visão Profética',
    'Visão Profética. Como uma ação Usar Magia, você pode escolher uma magia de Adivinhação com tempo de conjuração de 1 ação (de qualquer lista de magias) de um círculo que você possa conjurar e que não seja maior que a metade do seu nível de personagem e conjurá-la sem gastar um espaço de magia. Sabedoria é seu atributo de conjuração. Depois de usar este talento para conjurar a magia, você não pode usá-lo novamente até completar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-bragi'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-bragi'),
    2,
    'Amor dos Vanir',
    'Amor dos Vanir. Você ganha Proficiência com a perícia Persuasão se ainda não a tiver, e tem Vantagem em testes de Carisma (Persuasão).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-heimdall'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-heimdall'),
    2,
    'Consciência do Guardião',
    'Consciência do Guardião. Você tem Proficiência na perícia Sabedoria (Percepção). Se já tiver Proficiência, ganha Expertise nessa perícia. Além disso, quando faz um teste de Sabedoria (Percepção), pode decidir conceder a si mesmo Vantagem. Você pode fazer isso um número de vezes por dia igual ao seu Bônus de Proficiência, e recupera todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-heimdall'),
    3,
    'Trompa do Arauto',
    'Trompa do Arauto. Você ganha proficiência com a Trompa.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-heimdall'),
    4,
    'Vigilância',
    'Vigilância. Quando você joga Iniciativa, pode rerrolar o teste, mas deve usar o novo resultado. Depois de usar essa característica, deve terminar um Descanso Longo antes de poder usá-la novamente.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-hel'),
    1,
    'Adiar o Fim',
    'Adiar o Fim. Você tem Vantagem em salvaguardas contra a morte.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-hel'),
    2,
    'Ressurgimento',
    'Ressurgimento. Se você ficar Estável após a terceira salvaguarda contra a morte bem-sucedida, ou se for estabilizado por outra criatura, recupera imediatamente Pontos de Vida iguais a 1d6 mais o seu Bônus de Proficiência.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-hel'),
    3,
    'O Sino Toca',
    'O Sino Toca. Você conhece os truques Acudir os Moribundos e Badalar Fúnebre. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-njord'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força, Destreza ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-njord'),
    2,
    'Convocar Serpente Marinha',
    'Convocar Serpente Marinha. Você pode conjurar Convocar Montaria sem gastar um espaço de magia. Você pode conjurá-la uma vez sem espaço de magia, e recupera a capacidade de conjurá-la dessa forma ao terminar um Descanso Longo. Também pode conjurar esta magia usando quaisquer espaços de magia que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para esta magia (escolha ao selecionar este talento).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-njord'),
    3,
    'Proteção de Njord',
    'Proteção de Njord. Você pode respirar água além de ar, e obtém sucesso automático em salvaguardas contra frio extremo enquanto estiver submerso na água. Você também tem um Deslocamento de Natação igual ao seu Deslocamento.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-skadi'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-skadi'),
    2,
    'Olho do Caçador',
    'Olho do Caçador. Quando você usa a ação Atacar para realizar um ataque à distância com arma, pode escolher conceder a si mesmo Vantagem na jogada de ataque. Depois de usar essa característica, deve terminar um Descanso Curto ou Longo antes de poder usá-la novamente.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-skadi'),
    3,
    'Passo na Neve',
    'Passo na Neve. Seu Deslocamento aumenta em 3 metros quando você se move sobre gelo ou neve, e você nunca trata esses tipos de terreno como Terreno Difícil.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-the-snow-queen'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-the-snow-queen'),
    2,
    'Gume Congelado',
    'Gume Congelado. Você conhece a magia Faca de Gelo. Pode conjurá-la sem usar um espaço de magia um número de vezes por dia igual ao seu Bônus de Proficiência, e recupera todos os usos ao terminar um Descanso Longo. Também pode conjurar esta magia usando quaisquer espaços de magia que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para esta magia (escolha ao selecionar este talento).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-the-snow-queen'),
    3,
    'Escudo do Vento do Norte',
    'Escudo do Vento do Norte. Se você falhar em uma salvaguarda contra uma magia ou efeito que cause dano Gélido, pode escolher ter sucesso em vez disso. Depois de usar essa característica, deve terminar um Descanso Longo antes de poder usá-la novamente.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-tyr'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-tyr'),
    2,
    'Bravura',
    'Bravura. Você tem Vantagem em salvaguardas feitas para evitar ou encerrar a condição Amedrontado.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-tyr'),
    3,
    'Justicar',
    'Justicar. Como uma ação Usar Magia, você pode tocar uma criatura e compelí-la a dizer a verdade. A criatura deve fazer uma salvaguarda de Carisma. Em caso de falha, a criatura não pode falar uma mentira deliberada por 1 minuto. Você sabe se a criatura tem sucesso ou falha nessa salvaguarda. Uma criatura afetada está ciente da magia e pode evitar responder a perguntas às quais normalmente responderia com uma mentira. Tal criatura pode ser evasiva, mas deve ser veraz. Você pode usar essa característica à vontade, mas ao usá-la em uma criatura, deve terminar um Descanso Longo antes de poder usá-la nessa criatura novamente.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blood-of-the-berserker'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blood-of-the-berserker'),
    2,
    'Fúria do Berserker',
    'Fúria do Berserker. Quando você está Ensanguentado, pode usar uma Ação Bônus para entrar em um estado frenético. Enquanto nessa fúria, seus ataques corpo a corpo com arma causam dano extra igual ao seu Bônus de Proficiência, e você não tem a condição Inconsciente quando é reduzido a 0 PV (embora ainda faça salvaguardas contra a morte normalmente). Sua Fúria do Berserker dura 1 minuto ou até você terminá-la (sem ação necessária), ou se tiver a condição Incapacitado. Depois de usar essa característica, você não pode usá-la novamente até terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'bloodied-resilience'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'bloodied-resilience'),
    2,
    'Reação Ensanguentada',
    'Reação Ensanguentada. Enquanto estiver Ensanguentado e sofrer qualquer dano, você pode gastar um dos seus Dados de Vida como Reação e reduzir o dano que sofre pelo valor rolado. Você só pode gastar um Dado de Vida por vez dessa forma, a cada vez que sofrer dano.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'bloodied-resilience'),
    3,
    'Salvaguardas Ensanguentadas',
    'Salvaguardas Ensanguentadas. Se você tiver sucesso em uma salvaguarda de Força ou Constituição que normalmente faria você sofrer metade do dano, em vez disso não sofre dano algum.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'bloody-resolve'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'bloody-resolve'),
    2,
    'Fogo Interior',
    'Fogo Interior. A dor reforça sua resolução. Quando você sofre dano, ganha um bônus de +1 em salvaguardas até o final do seu próximo turno. Enquanto estiver Ensanguentado, o bônus nas salvaguardas aumenta para +2, e você também ganha um bônus de +1 em jogadas de ataque e de dano até o final do seu próximo turno.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'boisterous-roar'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'boisterous-roar'),
    2,
    'Grito Poderoso',
    'Grito Poderoso. Quando você obtém um Acerto Crítico contra um alvo, solta um rugido estrondoso. Você e aliados a até 1,5 metro de você têm Resistência a todo dano até o final do seu próximo turno, e inimigos a até 1,5 metro de você têm Vulnerabilidade a todo dano até o final do seu próximo turno.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brazen-courage'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brazen-courage'),
    2,
    'Vontade Firme',
    'Vontade Firme. Você tem Vantagem em salvaguardas contra a condição Amedrontado. Além disso, pode usar uma Ação Bônus para encerrar a condição Amedrontado em si mesmo um número de vezes por dia igual ao seu Bônus de Proficiência. Você recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'chosen-by-fate'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'chosen-by-fate'),
    2,
    'Ressurgimento Heroico',
    'Ressurgimento Heroico. Se você usar Inspiração Heroica e a rolagem do dado falhar, seu uso de Inspiração Heroica não é gasto (embora você não possa usá-la novamente para o mesmo Teste de D20).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'chosen-by-fate'),
    3,
    'Bonança Heroica',
    'Bonança Heroica. Sempre que você usar Inspiração Heroica, recupera um número de Pontos de Vida igual à rolagem do dado. Se já estiver no seu máximo de Pontos de Vida ao usar Inspiração Heroica, em vez disso ganha Pontos de Vida Temporários iguais à rolagem do dado. Se você usar Inspiração Heroica e rolar no dado um valor maior do que o necessário para restaurá-lo ao máximo de Pontos de Vida, ganha qualquer excesso como Pontos de Vida Temporários.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'clout'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'clout'),
    2,
    'Influência Forte',
    'Influência Forte. Você tem Vantagem em testes de Carisma (Enganação, Intimidação e Persuasão) ao interagir com vikings, guerreiros profissionais e outros povos marciais. Ao usar o talento Líder Inspirador, você também adiciona seu modificador de Força aos Pontos de Vida Temporários que concede.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-water-warrior'),
    1,
    'Contra a Corrente',
    'Contra a Corrente. Você obtém sucesso automático em testes de Força para se mover por águas turbulentas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-water-warrior'),
    2,
    'Resistência à Água Fria',
    'Resistência à Água Fria. Você tem Imunidade aos efeitos de imersão em água gélida por um número de horas igual ao seu Bônus de Proficiência.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-water-warrior'),
    3,
    'Salto Nadando',
    'Salto Nadando. Você pode fazer Saltos em Distância e Saltos em Altura enquanto nada. Se nadar pelo menos 3 metros antes de um salto, é considerado como tendo corrida de impulso.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-water-warrior'),
    4,
    'Combatente Aquático',
    'Combatente Aquático. Você tem Vantagem na Iniciativa se começar o combate pelo menos parcialmente submerso em um corpo d''água.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'combat-flyting'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'combat-flyting'),
    2,
    'Provocação',
    'Provocação. Como Ação Bônus no seu turno, você pode humilhar e provocar um oponente a até 9 metros de você que possa ouvi-lo e compreendê-lo. O alvo deve ser bem-sucedido em uma salvaguarda de Carisma (CD 8 mais seu modificador de Carisma mais seu Bônus de Proficiência). Em caso de falha, o alvo sofre uma penalidade de −1 nas jogadas de ataque contra você. Você pode usar outra Ação Bônus em cada um dos seus turnos subsequentes para impor outra penalidade de −1; esses efeitos se acumulam até um máximo igual ao seu modificador de Carisma. O alvo tem direito a uma salvaguarda contra cada um desses usos. Este efeito termina se você cair a 0 Pontos de Vida, tiver a condição Incapacitado, deixar de usar uma Ação Bônus a cada rodada para mantê-lo, ou se o alvo se afastar mais de 9 metros de você. Caso contrário, continua por um número máximo de rodadas igual ao seu Bônus de Proficiência. Uma criatura que tenha sucesso na salvaguarda tem Imunidade às suas Provocações por 24 horas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cut-down-the-nithingr'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cut-down-the-nithingr'),
    2,
    'Flagelo dos Covardes',
    'Flagelo dos Covardes. Você tem um bônus de +2 nas jogadas de dano que faz contra criaturas com a condição Amedrontado.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cut-down-the-nithingr'),
    3,
    'Visagem Aterradora',
    'Visagem Aterradora. Quando você usa uma magia ou efeito que causa a condição Amedrontado, a duração é dobrada.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'endurance-conditioning'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'endurance-conditioning'),
    2,
    'Recuperação Rápida',
    'Recuperação Rápida. Uma vez por dia, você pode se recuperar de 1 nível de Exaustão após completar um Descanso Curto. Além disso, um Descanso Longo remove 2 níveis de Exaustão (em vez de 1).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faster-crafting'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente um valor de atributo à sua escolha em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faster-crafting'),
    2,
    'Proficiência Artesanal Aumentada',
    'Proficiência Artesanal Aumentada. Você pode ganhar proficiência com uma Ferramenta de Artesão à sua escolha ou Vantagem em testes de atributo com uma única Ferramenta de Artesão com a qual já seja proficiente.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faster-crafting'),
    3,
    'Criação Rápida em Combate',
    'Criação Rápida em Combate. Enquanto estiver em combate, você pode usar uma Ação Bônus para fabricar uma peça de equipamento da tabela Fabricação Rápida, desde que tenha as Ferramentas de Artesão associadas a esse item, tenha proficiência com essas ferramentas e não tenha a condição Incapacitado. O item dura até o final do seu próximo turno, ou até você fabricar um item adicional, momento em que se desfaz.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faster-crafting'),
    4,
    'Criação em Descanso Curto',
    'Criação em Descanso Curto. Você pode fabricar um item da tabela Fabricação Rápida durante um Descanso Curto. Ele dura até o fim do dia, até você usar novamente este aspecto do talento, ou até o seu próximo Descanso Longo, o que ocorrer primeiro, momento em que se desfaz.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fjord-jumper'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fjord-jumper'),
    2,
    'Salto de Penhasco',
    'Salto de Penhasco. Sua distância de salto (seja em altura ou em distância) aumenta em 3 metros. Você também tem Vantagem em qualquer jogada de ataque, teste de Destreza (Acrobacia) ou teste de Força (Atletismo) que fizer após saltar pelo menos 3 metros de altura ou 6 metros de distância.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fjord-jumper'),
    3,
    'Mergulho Seguro',
    'Mergulho Seguro. Se você cair em um líquido, como água, e gastar sua Reação e tiver sucesso em um teste de Força (Atletismo) ou Destreza (Acrobacia) CD 15, não sofre dano da queda. Você também tem Vantagem nesse teste.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'frost-eyed'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Sabedoria em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'frost-eyed'),
    2,
    'Olhos Brilhantes',
    'Olhos Brilhantes. Você tem Vantagem em testes de Sabedoria (Percepção) sob Luz Plena, e não tem Desvantagem em testes de Sabedoria (Percepção) sob Meia-luz.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'frost-eyed'),
    3,
    'Rastreador do Gelo',
    'Rastreador do Gelo. Você é proficiente na perícia Sobrevivência. Você trata tanto neve quanto terreno gelado como terreno normal. Você tem Vantagem em testes de Sobrevivência feitos na neve ou no gelo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'frost-touched'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'frost-touched'),
    2,
    'Magia de Geada',
    'Magia de Geada. Você conhece, à sua escolha, o truque Queimadura de Geada ou Raio de Gelo. Escolha uma magia de 1º círculo que cause dano Gélido das listas de magias de Druida, Feiticeiro ou Mago. Você sempre tem essa magia e a magia Lufada de Vento preparadas. Você pode conjurar cada uma dessas magias sem gastar um espaço de magia. Depois de conjurar qualquer uma delas dessa forma, não pode conjurar essa magia novamente até completar um Descanso Longo. Também pode conjurar essas magias usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração dessas magias é o atributo aumentado por este talento.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'giant-slayer'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Destreza em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'giant-slayer'),
    2,
    'Esquivar e Tecer',
    'Esquivar e Tecer. Se você estiver a até 1,5 metro de uma criatura Grande ou maior, pode executar a ação Esquivar como Ação Bônus.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'giant-slayer'),
    3,
    'Quanto Maior, Mais Forte Cai',
    'Quanto Maior, Mais Forte Cai. Você é hábil em derrubar criaturas Grandes ou maiores. Quando usa a característica de Maestria em Arma Derrubar contra uma criatura de tamanho Grande ou maior, ela tem Desvantagem na salvaguarda.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-baldur'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Destreza ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-baldur'),
    2,
    'Resiliência Divina',
    'Resiliência Divina. Ao terminar um Descanso Longo, você tem Resistência a um tipo de dano à sua escolha. Essa Resistência dura até você terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-boreas'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-boreas'),
    2,
    'Forjado no Frio',
    'Forjado no Frio. Você tem Resistência a dano Gélido. Além disso, pode invocar um escudo de frio para bloquear efeitos baseados em fogo. Como Reação, quando sofreria dano Ígneo, pode ganhar Resistência a dano Ígneo até o início do seu próximo turno.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-freyr-and-freyja'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-freyr-and-freyja'),
    2,
    'Magia Curativa',
    'Magia Curativa. Você sempre tem a magia Curar Ferimentos preparada. Pode conjurá-la sem usar um espaço de magia um número de vezes por dia igual ao seu Bônus de Proficiência, e recupera todos os usos ao terminar um Descanso Longo. Também pode conjurá-la usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração da magia é o atributo que você escolheu ao adquirir o talento Bênção de Freyr e Freyja. Quando conjura a magia em uma criatura do tipo Fera ou Planta, a quantidade curada é dobrada.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-jormungandr'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-jormungandr'),
    2,
    'Aspecto da Serpente',
    'Aspecto da Serpente. Você pode canalizar o medo inspirado por serpentes e dragões. Pode usar uma Ação para forçar um número de criaturas à sua escolha igual ao seu Bônus de Proficiência a até 9 metros de você que possam vê-lo a fazer uma salvaguarda de Sabedoria (CD 8 mais seu modificador de Carisma e seu Bônus de Proficiência). Em caso de falha, um alvo tem a condição Amedrontado por 1 minuto. Tal criatura pode repetir a salvaguarda no final de cada um dos seus turnos, encerrando o efeito em si mesma em caso de sucesso. Você pode usar essa característica um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-loki'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-loki'),
    2,
    'Senhor das Mentiras',
    'Senhor das Mentiras. Você tem Vantagem em testes de Carisma (Enganação).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-loki'),
    3,
    'Magia da Máscara',
    'Magia da Máscara. Você sempre tem a magia Alterar-se preparada. Pode conjurá-la sem gastar um espaço de magia. Depois de conjurar a magia dessa forma, não pode conjurá-la assim novamente até terminar um Descanso Longo. Também pode conjurá-la usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração da magia é o que você escolheu ao adquirir o talento Bênção de Loki.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-sif'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Destreza ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-sif'),
    2,
    'Flecha de Sif',
    'Flecha de Sif. Como Ação Bônus, você pode canalizar o poder da deusa Sif por 1 minuto. Durante esse tempo, quando acerta com um ataque à distância com arma, causa dano extra do tipo da arma igual ao seu Bônus de Proficiência. Você pode causar esse dano extra no máximo uma vez em cada um dos seus turnos. Pode canalizar o poder de Sif dessa forma um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-thor'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-thor'),
    2,
    'Golpe da Tempestade',
    'Golpe da Tempestade. Como Ação Bônus, você pode canalizar o poder do deus Thor por 1 minuto. Durante esse tempo, quando acerta com um ataque corpo a corpo com arma, causa dano extra do tipo da arma igual ao seu Bônus de Proficiência. Você pode causar esse dano extra no máximo uma vez em cada um dos seus turnos. Pode canalizar o poder de Thor dessa forma um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-wotan'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-wotan'),
    2,
    'Mestre do Saber',
    'Mestre do Saber. Você tem Vantagem ao fazer testes da perícia que selecionou para seu traço Amarrado ao Saber do talento Bênção de Wotan.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-wotan'),
    3,
    'Presságio Mágico',
    'Presságio Mágico. Você sempre tem a magia Augúrio preparada. Pode conjurá-la sem gastar um espaço de magia. Depois de conjurar a magia dessa forma, não pode conjurá-la assim novamente até terminar um Descanso Longo. Também pode conjurar esta magia usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração da magia é o atributo que você escolheu ao adquirir o talento Bênção de Wotan.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'heroic-rush'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'heroic-rush'),
    2,
    'Impulso Triunfante',
    'Impulso Triunfante. Quando você obtém um Acerto Crítico, seu Deslocamento aumenta em 3 metros e você tem Vantagem em jogadas de ataque. Esses benefícios duram até o final do seu próximo turno.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'heroic-rush'),
    3,
    'Inspiração Vitoriosa',
    'Inspiração Vitoriosa. Quando você reduz uma criatura a 0 Pontos de Vida com um ataque, pode escolher um aliado a até 9 metros de você para receber Inspiração Heroica. O aliado deve usar essa Inspiração Heroica antes do final do próximo turno dele, ou ela é desperdiçada. Você pode usar essa característica duas vezes, recuperando todos os usos gastos ao terminar um Descanso Curto ou Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'holmganga-master'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força, Constituição ou Destreza em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'holmganga-master'),
    2,
    'Pronto para a Batalha',
    'Pronto para a Batalha. Você tem Vantagem na Iniciativa no início de um Holmgang ou outro duelo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'holmganga-master'),
    3,
    'Intimidação de Duelo',
    'Intimidação de Duelo. Como Ação Bônus, você pode fazer um teste de Carisma (Intimidação) contra seu oponente de holmgang. Se o teste for bem-sucedido (a critério do Mestre), você tem Vantagem no seu próximo ataque contra o alvo, e o alvo tem Desvantagem no próximo ataque dele contra você.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'hunter'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Sabedoria ou Inteligência em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'hunter'),
    2,
    'Rastreamento Aprimorado',
    'Rastreamento Aprimorado. Você tem Vantagem em testes de Sabedoria (Percepção) e Sabedoria (Sobrevivência) para seguir ou identificar rastros.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'hunter'),
    3,
    'Furtividade Superior',
    'Furtividade Superior. Você tem Vantagem em testes de Destreza (Furtividade) enquanto estiver ao ar livre.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ice-mastery'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ice-mastery'),
    2,
    'Garras do Fimbulvetr',
    'Garras do Fimbulvetr. Suas magias de gelo carregam a força do Fimbulvetr. Sempre que causar dano Gélido a uma criatura com uma magia de pelo menos 1º círculo, pode escolher um dos seguintes efeitos adicionais. • A criatura tem Desvantagem em testes de Destreza por 1 minuto enquanto um frio terrível entorpece o corpo dela. • A criatura fica coberta de gelo. Ela tem a condição Imobilizado até ter sucesso em uma salvaguarda de Destreza para se libertar (igual à CD de salvaguarda das suas magias) ou sofrer pelo menos 10 pontos de dano Contundente ou Ígneo. Ela pode fazer a salvaguarda para encerrar este efeito no final de cada um dos seus turnos. • A criatura tem Vulnerabilidade a dano Gélido por 1 minuto. Ela pode fazer uma salvaguarda de Constituição (igual à CD de salvaguarda das suas magias) para encerrar este efeito no final de cada um dos seus turnos. Você pode usar Garras do Fimbulvetr um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-mastery'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-mastery'),
    2,
    'Fúria de Thor',
    'Fúria de Thor. Suas magias de relâmpago estão impregnadas de poder extra. Sempre que causar dano Elétrico a uma criatura com uma magia de pelo menos 1º círculo, pode escolher um dos seguintes efeitos adicionais. • A criatura tem a condição Atordoado até o final do seu próximo turno, se falhou na salvaguarda contra a magia. • A criatura sofre novamente metade do dano Elétrico que sofreu inicialmente no início do próximo turno dela. Ela pode fazer uma salvaguarda contra a CD de salvaguarda das suas magias para anular esse dano adicional. • A criatura ganha Vulnerabilidade a dano Elétrico por 1 minuto. Ela pode fazer uma salvaguarda de Constituição (igual à CD de salvaguarda das suas magias) para encerrar este efeito no final de cada um dos seus turnos. Você pode usar Fúria de Thor um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'living-off-the-land'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição ou Sabedoria em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'living-off-the-land'),
    2,
    'Herbalista',
    'Herbalista. Quando você faz um Descanso Longo em uma área natural (cavernas naturais, floresta, tundra etc.), pode localizar materiais para criar um Kit de Curandeiro, e cogumelos, bagas ou raízes suficientes para alimentar uma criatura Média por um dia.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'living-off-the-land'),
    3,
    'Abrigo de Sobrevivência',
    'Abrigo de Sobrevivência. Você pode gastar 30 minutos para criar um abrigo temporário — como um tapiri, bivaque, poço de árvore, iglu ou similar — de neve, galhos, pedras e gravetos, adequado para 4–5 humanoides Médios. Enquanto estiverem dentro do seu abrigo de sobrevivência, as criaturas obtêm sucesso automático em salvaguardas de Constituição contra frio extremo e calor extremo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'long-haft-strike'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'long-haft-strike'),
    2,
    'Contornar Escudo',
    'Contornar Escudo. Quando você faz um ataque com uma arma com a propriedade Extensão contra uma criatura empunhando um Escudo, essa criatura não se beneficia do bônus de Classe de Armadura do Escudo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'long-haft-strike'),
    3,
    'Defesa de Alcance',
    'Defesa de Alcance. Enquanto empunha uma arma com Extensão, você tem um bônus de +1 na sua Classe de Armadura.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'moon-touched'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'moon-touched'),
    2,
    'Magia Lunar',
    'Magia Lunar. Você conhece, à sua escolha, o truque Luzes Dançantes ou Luz. Escolha uma magia de 1º círculo que crie ou emita luz, como Leque Cromático ou Fogo das Fadas, das listas de magias de Druida, Feiticeiro ou Mago. Você sempre tem essa magia e a magia Raio Lunar preparadas. Você pode conjurar cada uma dessas magias sem gastar um espaço de magia. Depois de conjurar qualquer uma delas dessa forma, não pode conjurar essa magia assim novamente até terminar um Descanso Longo. Também pode conjurar essas magias usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração dessas magias é o atributo aumentado por este talento.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-leap'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Destreza em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-leap'),
    2,
    'Proeza Equestre',
    'Proeza Equestre. Enquanto você monta uma montaria, a distância de salto dessa montaria é dobrada.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-leap'),
    3,
    'Ataque de Investida em Salto',
    'Ataque de Investida em Salto. Enquanto salta de uma montaria em movimento, sua distância de salto é calculada usando o Deslocamento da montaria no lugar do seu (se o Deslocamento dela for melhor que o seu). Se você fizer uma jogada de ataque corpo a corpo bem-sucedida contra uma criatura após saltar, escolha um dos seguintes efeitos: ganhar um bônus de 1d8 na jogada de dano do ataque, ou fazer o alvo ter a condição Caído se o alvo for de uma categoria de tamanho maior que a sua ou menor. Você pode usar este benefício apenas uma vez em cada um dos seus turnos.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'northlands-hardiness'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'northlands-hardiness'),
    2,
    'Resiliência ao Clima Frio',
    'Resiliência ao Clima Frio. Você tem Vantagem em salvaguardas contra frio extremo. Se já tiver Resistência a dano Gélido, também ganha Vantagem em salvaguardas contra dano Gélido.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'northlands-hardiness'),
    3,
    'Inesgotável',
    'Inesgotável. Na primeira vez em um dia que você recebe um nível de Exaustão, seu Deslocamento não é reduzido. Além disso, você pode ignorar os efeitos de Exaustão em um Teste de D20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'primal'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'primal'),
    2,
    'Magia Primordial',
    'Magia Primordial. Escolha duas das seguintes magias: Amizade Animal, Emaranhar, Bom Fruto ou Falar com Animais. Você sempre tem essas duas magias e a magia Pele-Casca preparadas. Você pode conjurar cada uma dessas magias sem gastar um espaço de magia. Depois de conjurar uma magia dessa forma, não pode conjurar essa magia assim novamente até terminar um Descanso Longo. Também pode conjurar essas magias usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração dessas magias é o atributo aumentado por este talento.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ravens-friend'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência ou Sabedoria em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ravens-friend'),
    2,
    'Estudo Rápido',
    'Estudo Rápido. Você ganha proficiência em uma das seguintes perícias à sua escolha: Arcanismo, História, Investigação, Natureza ou Religião.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ravens-friend'),
    3,
    'Sussurros do Corvo',
    'Sussurros do Corvo. Corvos às vezes lhe contam segredos. Quando você executa a ação Analisar, pode conceder a si mesmo Vantagem na rolagem. Você pode fazer isso um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Destreza em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
    2,
    'Haste Defletora',
    'Haste Defletora. Você pode usar uma Lança para defletir ataques recebidos. Enquanto segura uma Lança, ganha um bônus de +1 na sua CA.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
    3,
    'Arremessador Experiente',
    'Arremessador Experiente. O alcance de qualquer Lança que você arremessar é 9/27 metros.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
    4,
    'Lança Pronta',
    'Lança Pronta. Se você executar a ação Preparar para atacar com a Lança, tem Vantagem no ataque disparado.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'surtrs-touch'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Constituição em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'surtrs-touch'),
    2,
    'Toque da Chama',
    'Toque da Chama. Como Ação Bônus, você pode imbuir seu toque com o poder do fogo por 1 minuto. Durante esse tempo, quando acerta com um ataque corpo a corpo com arma, causa dano Ígneo extra igual ao seu Bônus de Proficiência. Você pode usar este talento um número de vezes igual ao seu Bônus de Proficiência, e recupera todos os usos gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'tricksters-toolbox'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'tricksters-toolbox'),
    2,
    'Magia Trapaceira',
    'Magia Trapaceira. Escolha duas magias de 1º círculo da escola de Encantamento ou Ilusão. Você sempre tem essas magias e a magia Gargalhada Nefasta de Tasha preparadas. Você pode conjurar cada uma dessas magias sem gastar um espaço de magia. Depois de conjurar uma dessas magias dessa forma, não pode conjurar essa magia assim novamente até terminar um Descanso Longo. Também pode conjurar essas magias usando espaços de magia do círculo apropriado que tiver. O atributo de conjuração dessas magias é o atributo aumentado por este talento.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'wild-lore'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Inteligência em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'wild-lore'),
    2,
    'Conhecimento da Terra',
    'Conhecimento da Terra. Você tem Vantagem em todos os testes de Inteligência (Natureza).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'wild-lore'),
    3,
    'Provedor',
    'Provedor. Você pode usar seu conhecimento da terra para encontrar comida e água fresca para si e até mais 3 pessoas a cada dia.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'glima'),
    1,
    'Glima',
    'Glima é o nome de um estilo de luta desarmada nas Terras do Norte semelhante à luta corpo a corpo. Quando você acerta com um ataque desarmado contra uma criatura a até 1,5 metro de você, se essa criatura for de um tamanho maior que o seu ou menor, pode escolher forçar essa criatura a fazer uma salvaguarda de Força (CD igual a 8 + seu Bônus de Proficiência + seu modificador de Força). Em caso de falha, a criatura alvo tem a condição Caído.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'raiders-rush'),
    1,
    'Investida do Saqueador',
    'Investida do Saqueador. Você tem Vantagem em jogadas de ataque contra qualquer criatura a até 1,5 metro de um dos seus aliados se você se mover pelo menos 4,5 metros e parar a até 1,5 metro desse aliado.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'savagery'),
    1,
    'Selvageria',
    'Selvageria. Quando você faz sua primeira jogada de ataque corpo a corpo com arma no seu turno, pode decidir atacar com selvageria. Isso permite adicionar seu Bônus de Proficiência às suas jogadas de dano corpo a corpo com arma, mas reduz sua CA em 2 até o início do seu próximo turno.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-wall'),
    1,
    'Proteger Aliado',
    'Proteger Aliado. Quando uma criatura que você possa ver acerta um aliado adjacente a você com um ataque, você pode executar uma Reação para conceder ao seu aliado o bônus de Classe de Armadura do seu Escudo contra o ataque desencadeador.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-wall'),
    2,
    'Ombro a Ombro',
    'Ombro a Ombro. Quando você e um aliado estão ambos empunhando um escudo e adjacentes um ao outro, ambos ganham um bônus de +1 na Classe de Armadura.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'skirmisher'),
    1,
    'Mobilidade',
    'Mobilidade. Seu Deslocamento aumenta em 3 metros.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'skirmisher'),
    2,
    'Golpear e Desaparecer',
    'Golpear e Desaparecer. Uma vez em cada um dos seus turnos, você pode causar dano extra igual ao seu Bônus de Proficiência a uma criatura que acertar com um ataque que cause dano Contundente, Perfurante ou Cortante, desde que tenha se movido 4,5 metros antes de fazer o ataque.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'underfoot'),
    1,
    'Pelos Pés',
    'Pelos Pés. Você pode terminar seu movimento em um espaço ocupado por uma criatura dois tamanhos maior que você. Se atacar essa criatura enquanto compartilha o espaço dela, tem Vantagem na jogada de ataque. Se essa criatura atacá-lo enquanto compartilha o seu espaço, ela tem Desvantagem na jogada de ataque.'
  )
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
