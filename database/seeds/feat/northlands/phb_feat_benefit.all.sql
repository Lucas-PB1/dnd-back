-- Benefícios dos talentos de origem Northlands

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
    1,
    'Égide Protetora',
    'Égide Protetora. Uma vez por Descanso Longo, quando você ou um aliado a até 3 metros sofrer dano, pode usar sua Reação para reduzir esse dano em um valor igual ao seu Bônus de Proficiência + seu modificador de Carisma (mínimo 1).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
    2,
    'Aura Radiante',
    'Aura Radiante. Como Ação Bônus, você emite luz plena dourada num raio de 3 metros e luz fraca por mais 3 metros. Pode apagar essa luz com outra Ação Bônus.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
    3,
    'Lança Solar',
    'Lança Solar. Você conhece o truque Chama Sagrada. Carisma é seu atributo de conjuração para essa magia.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
    1,
    'Égide do Frio',
    'Égide do Frio. Se sofrer dano de Frio, pode usar sua Reação para ganhar Resistência a dano de Frio até o fim do seu próximo turno. Pode usar essa Reação um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
    2,
    'Magia de Inverno',
    'Magia de Inverno. Você conhece o truque Raio de Gelo. Escolha a magia Armadura de Agathys ou Faca de Gelo. Você sempre a tem preparada. Pode conjurá-la uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo; também pode conjurá-la com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
    1,
    'Pontos de Vitalidade',
    'Pontos de Vitalidade. Você tem um número de Pontos de Vitalidade igual ao seu Bônus de Proficiência e pode gastá-los nos benefícios abaixo. Recupera os Pontos de Vitalidade gastos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
    2,
    'Surto de Vitalidade',
    'Surto de Vitalidade. Pode executar uma Ação Bônus e gastar 1 Ponto de Vitalidade para recuperar 1d4 Pontos de Vida. Se estiver Morrendo, pode gastar 1 Ponto de Vitalidade para se estabilizar (sem ação).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
    3,
    'Canalizar Vitalidade',
    'Canalizar Vitalidade. Pode executar uma Ação Bônus e gastar 1 Ponto de Vitalidade para fazer uma criatura que tocar recuperar 1d4 Pontos de Vida.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
    1,
    'Conhecimento Selvagem',
    'Conhecimento Selvagem. Você tem proficiência em Adestrar Animais ou Natureza.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
    2,
    'Magia Verde',
    'Magia Verde. Você aprende os truques Druidismo e Chicote de Espinhos. Escolha a magia Enredar ou Granizo de Espinhos. Você sempre a tem preparada. Pode conjurá-la uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo; também pode conjurá-la com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
    1,
    'Resiliência ao Veneno',
    'Resiliência ao Veneno. Se sofrer dano de Veneno, pode usar sua Reação para ganhar Resistência a dano de Veneno até o fim do seu próximo turno. Pode usar essa Reação um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
    2,
    'Afinidade Serpentina',
    'Afinidade Serpentina. Você sempre tem preparadas as magias Amizade com Animal e Falar com Animais. Pode conjurar cada uma uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo. Ao conjurá-las sem espaço, só pode mirar cobras e serpentes. Também pode conjurá-las com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração (escolha ao selecionar o talento).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
    3,
    'Língua da Serpente',
    'Língua da Serpente. Você conhece o idioma Dracônico.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
    1,
    'Mentiroso Experiente',
    'Mentiroso Experiente. Você tem proficiência em Enganação. Se já a tiver, ganha Expertise nela.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
    2,
    'Magia do Trapaceiro',
    'Magia do Trapaceiro. Você aprende os truques Ilusão Menor e Zombaria Perversa. Escolha a magia Disfarçar-se ou Enfeitiçar Pessoa. Você sempre a tem preparada. Pode conjurá-la uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo; também pode conjurá-la com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
    1,
    'Dádiva da Destreza',
    'Dádiva da Destreza. Ao fazer um teste de Destreza, pode adicionar seu Bônus de Proficiência à rolagem. Se já adicionar o Bônus de Proficiência a um teste de Destreza, pode adicioná-lo mais uma vez. Pode usar este benefício um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
    2,
    'Proeza de Sif',
    'Proeza de Sif. Você conhece o truque Golpe Certo. Escolha a magia Marca do Predador ou Passos Longos. Você sempre a tem preparada. Pode conjurá-la uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo; também pode conjurá-la com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
    1,
    'Dádiva da Força',
    'Dádiva da Força. Ao fazer um teste de Força, pode adicionar seu Bônus de Proficiência à rolagem. Se já adicionar o Bônus de Proficiência a um teste de Força, pode adicioná-lo mais uma vez. Pode usar este benefício um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
    2,
    'Magia da Tempestade',
    'Magia da Tempestade. Você conhece o truque Toque Chocante ou Trovoada (escolha ao selecionar o talento). Também sempre tem preparada a magia Golpe Trovejante. Pode conjurá-la uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo; também pode conjurá-la com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração (escolha ao selecionar o talento).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
    1,
    'Jeito de Artesão',
    'Jeito de Artesão. Você ganha proficiência com uma Ferramenta de Artesão à sua escolha. Se já tiver proficiência com ela, em vez disso tem Vantagem em testes com ela.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
    2,
    'Magia da Forja',
    'Magia da Forja. Você aprende os truques Elementalismo e Conserto. Escolha a magia Mãos Flamejantes ou Escudo. Você sempre a tem preparada. Pode conjurá-la uma vez sem gastar espaço de magia e recupera essa capacidade ao terminar um Descanso Longo; também pode conjurá-la com espaços que tiver. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
    1,
    'Amarrado ao Saber',
    'Amarrado ao Saber. Você ganha proficiência em uma das seguintes perícias: Arcanismo, História, Natureza ou Religião. Se já tiver proficiência na escolhida, ganha Expertise nela.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
    2,
    'Sabedoria Secreta',
    'Sabedoria Secreta. Você conhece o truque Orientação. Escolha uma magia de 1º círculo de qualquer escola. Você sempre a tem preparada. Pode conjurá-la sem gastar espaço de magia; depois disso, não pode conjurá-la assim novamente até terminar um Descanso Longo. Também pode conjurá-la com espaços do nível apropriado. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias deste talento (escolha ao selecioná-lo).'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
    1,
    'Proficiência com Ferramenta',
    'Proficiência com Ferramenta. Você ganha proficiência com Suprimentos de Cervejeiro.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
    2,
    'Desconto',
    'Desconto. Você obtém 50% de desconto ao comprar comida e bebidas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
    3,
    'Fermentação Rápida',
    'Fermentação Rápida. Ao terminar um Descanso Longo, pode preparar um hidromel revigorante se tiver Suprimentos de Cervejeiro disponíveis. Uma criatura pode usar a ação Usar Objeto para beber o hidromel, ganhando Pontos de Vida Temporários iguais ao seu Bônus de Proficiência. A potência do hidromel dura até você começar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-plunge-training'),
    1,
    'Treino em Água Fria',
    'Treino em Água Fria. Enquanto estiver na água, você tem Vantagem em salvaguardas contra frio extremo e em testes de Força (Atletismo) para nadar.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-plunge-training'),
    2,
    'Mergulho Ártico',
    'Mergulho Ártico. Num turno em que você mergulha da terra para a água, seu movimento na água usa seu Deslocamento normal em vez da metade.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fisher'),
    1,
    'Sobrevivencialista',
    'Sobrevivencialista. Você ganha proficiência em Sobrevivência.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fisher'),
    2,
    'Familiaridade com Embarcações',
    'Familiaridade com Embarcações. Você tem Vantagem em Testes de d20 feitos para operar veículos aquáticos.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fisher'),
    3,
    'Proeza de Pesca',
    'Proeza de Pesca. Ao explorar e ter acesso a um corpo d’água, pode gastar 1 hora pescando e obter comida suficiente para até 6 pessoas por 1 dia.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'norn-touched'),
    1,
    'Favor das Parcas',
    'Favor das Parcas. Uma vez por dia, ao fazer um Teste de d20, pode adicionar seu Bônus de Proficiência ao resultado. Pode ver o resultado da rolagem antes de usar este benefício.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'norn-touched'),
    2,
    'Desdém das Parcas',
    'Desdém das Parcas. Uma vez por dia, quando outra criatura rolar um d20 para um ataque ou teste de atributo, pode subtrair seu Bônus de Proficiência do resultado. Pode ver o resultado da rolagem antes de usar este benefício.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'northern-raider'),
    1,
    'Nascido na Água',
    'Nascido na Água. Você ganha proficiência com Ferramentas de Navegador.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'northern-raider'),
    2,
    'Sangue na Água',
    'Sangue na Água. Você tem Vantagem em ataques e testes de atributo que fizer no turno em que sair da água ou sair de um navio.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'sea-wolf'),
    1,
    'Abordagem Tática',
    'Abordagem Tática. Você tem Vantagem em testes de Força (Atletismo) e Destreza (Acrobacia) feitos para embarcar em veículos.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'sea-wolf'),
    2,
    'Ferocidade do Saqueador',
    'Ferocidade do Saqueador. Quando obtém um Acerto Crítico contra uma criatura com um ataque corpo a corpo, pode fazer outro ataque corpo a corpo contra a mesma criatura ou uma adjacente como Ação Bônus.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'snowrunner'),
    1,
    'Caminhada no Gelo',
    'Caminhada no Gelo. Você tem Vantagem em salvaguardas e testes de atributo para manter o equilíbrio em superfícies escorregadias e na neve.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'snowrunner'),
    2,
    'Fio do Inverno',
    'Fio do Inverno. Você tem Vantagem em testes de Sabedoria (Sobrevivência) em terreno nevado ou gelado.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'well-versed'),
    1,
    'Proficiência de Saber',
    'Proficiência de Saber. Você ganha proficiência em um instrumento musical e em uma das seguintes perícias: Arcanismo, História, Natureza ou Religião.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'well-versed'),
    2,
    'Conhecimento Útil',
    'Conhecimento Útil. Ao fazer um teste de Inteligência (Arcanismo, História, Natureza ou Religião), pode dar a si Vantagem na rolagem. Pode fazer isso um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.'
  )
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
