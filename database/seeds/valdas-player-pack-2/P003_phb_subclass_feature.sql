-- Seed Valdas Player Pack 2 subclass features

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero'),
  3,
  'Tiro a Queima-Roupa',
  'Estar a até 1,5 m de um inimigo não impõe Desvantagem às suas jogadas de ataque com armas à distância.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero'),
  3,
  'Abrir o Leque [Manobra]',
  'Quando você realiza a ação Atacar com uma arma à distância que não tenha a propriedade Duas Mãos, você pode gastar um Dado de Risco como Ação Bônus para fazer dois ataques à distância adicionais com aquela arma. Esses ataques adicionais sempre têm Desvantagem, independentemente das circunstâncias. Você não pode usar a propriedade de maestria Automática com esses ataques, e precisa ter uma mão livre para usar esta manobra.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero'),
  6,
  'Desarmar',
  'Quando você marca um Acerto Crítico e aciona seu recurso Tiro Intestinal contra uma criatura, você pode desarmar o alvo em vez de alojar um projétil nele. O alvo larga um objeto de sua escolha que esteja segurando, e o objeto cai em um espaço de sua escolha a até 4,5 m do alvo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero'),
  10,
  'Confronto [Manobra]',
  'Quando você rola Iniciativa, você pode gastar um Dado de Risco para sacar uma arma à distância e fazer um ataque com ela. Adicione o Dado de Risco à jogada de dano. Em um acerto, o alvo tem Desvantagem nas jogadas de ataque contra criaturas que não sejam você na primeira rodada de combate.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero'),
  14,
  'Tempo Bala',
  'Uma vez em cada um de seus turnos, quando você faz um ataque à distância usando uma arma, você pode ganhar Vantagem na jogada.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscaras de Persona',
  'Você aprende a criar máscaras mágicas, cada uma das quais permite assumir uma persona diferente e ganhar algum aspecto daquele personagem arquetípico.

Máscaras de Persona. Você ganha 3 máscaras de sua escolha da seção “Máscaras de Persona” mais adiante na descrição desta subclasse. Você ganha uma máscara adicional no nível 6 de Bardo (4 máscaras) e no nível 14 de Bardo (5 máscaras). Você pode trocar uma de suas máscaras por outra sempre que terminar um Descanso Longo.

Usar uma Máscara. Você pode colocar uma máscara ou trocar a máscara que está usando como Ação Bônus. Somente você pode obter os efeitos de suas máscaras.

Substituir uma Máscara. Se uma de suas máscaras for perdida ou roubada, você pode refazê-la ao longo de 8 horas, o que pode ser feito durante um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Artista Teatral',
  'Seus talentos teatrais concedem os seguintes benefícios.

Kits de Disfarce. Você ganha proficiência com o Kit de Disfarce.

Toque Dramático. Sempre que você fizer um teste de Carisma (Atuação), adicione seu dado de Inspiração de Bardo à jogada sem gastá-lo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  6,
  'Habilidade de Virtuoso',
  'Uma vez por turno, quando você fizer um Teste de D20, você pode optar por fazê-lo com Carisma se o teste ainda não o usar.

Você pode usar este recurso um número de vezes igual ao seu modificador de Carisma (mínimo de uma vez) e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  14,
  'Mestre de Muitas Faces',
  'Você pode usar duas máscaras simultaneamente, obtendo os benefícios de ambas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Anjo',
  'Anjo. Esta máscara impecável de alabastro retrata um Celestial sereno. Uma vez por turno, quando você causa dano a uma criatura com um ataque ou magia, você pode gastar um uso de sua Inspiração de Bardo para causar dano Radiante extra ao alvo igual a uma rolagem do seu dado de Inspiração de Bardo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Arquimago',
  'Arquimago. Esta máscara de argila coberta por um chapéu pontudo traz as rugas de um arquimago rabugento. Quando você alcança um nível de Bardo especificado na tabela a seguir, você passa a ter sempre as magias listadas preparadas enquanto usar esta máscara.

Magias da Persona Arquimago

Nível de Bardo
Magias

3
Raio de Fogo, Raio Abrasador, Onda Trovejante

5
Relâmpago

7
Tempestade de Gelo

9
Muralha de Pedra'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Diabo',
  'Diabo. Esta máscara de obsidiana exibe as presas e os chifres de um corruptor atraente. Quando você sofre dano de uma criatura a até 9 m de você, você pode gastar um uso de sua Inspiração de Bardo como Reação para causar dano de Fogo à criatura. Este dano é igual a duas rolagens do seu dado de Inspiração de Bardo, e você ganha PV temporários iguais ao dano causado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Dragão',
  'Dragão. Quando você coloca esta máscara, e como Ação Bônus em cada um de seus turnos enquanto a usar, você pode gastar um dado de Inspiração de Bardo para exalar chamas em um Cone de 4,5 m. Cada criatura no Cone faz uma salvaguarda de Destreza contra sua CD de magia. Em uma falha, a criatura sofre dano de Fogo igual a duas rolagens do seu dado de Inspiração de Bardo, ou metade desse dano em um sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Sem Rosto',
  'Sem Rosto. Dois orifícios oculares perfeitamente redondos olham desta máscara de porcelana, de resto sem feições. Enquanto usar esta máscara, você tem sempre a magia Disfarçar-se preparada. Sempre que começar a conjurá-la, você pode modificá-la para que não exija um espaço de magia. Se fizer isso, o tempo de conjuração da magia passa a ser de 1 minuto naquela conjuração e sua duração passa a ser de 8 horas. A magia termina mais cedo se você remover esta máscara.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Gladiador',
  'Gladiador. Este elmo metálico sombrio, marcado e riscado, oculta todo o rosto. Enquanto usar esta máscara, você tem proficiência com armas Marciais e treinamento com Escudos. Como Ação Bônus, você pode gastar um uso de sua Inspiração de Bardo para fazer um ataque com uma arma ou um Ataque Desarmado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Hierofante',
  'Hierofante. Em vez de um rosto, esta máscara de bronze traz a imagem de um símbolo sagrado, com as mais estreitas fendas para enxergar. Quando você alcança um nível de Bardo especificado na tabela a seguir, você passa a ter sempre as magias listadas preparadas enquanto usar esta máscara.

Magias da Persona Hierofante

Nível de Bardo
Magias

3
Auxílio, Curar Ferimentos, Poupar os Moribundos

5
Revivificar

7
Proteção contra a Morte

9
Curar Ferimentos em Massa'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Bufão',
  'Bufão. Esta máscara de pano de um bufão sorridente é adornada com guizos e padrões de xadrez. Quando você coloca esta máscara, e como Ação Bônus em cada um de seus turnos enquanto a usar, você pode se mover até metade do seu Deslocamento sem provocar Ataques de Oportunidade. Você também pode gastar um uso de Inspiração de Bardo para conjurar Escárnio Vicioso como parte da Ação Bônus desta máscara.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  3,
  'Máscara de Persona: Nobre',
  'Nobre. Esta máscara de prata reluzente tem dois rubis cravados nas órbitas. Você pode usar sua Inspiração de Bardo como parte da Ação Bônus para colocar esta máscara. Quando uma criatura com seu dado de Inspiração de Bardo falhar em um Teste de D20 enquanto você usar esta máscara, ela pode rolar o dado de Inspiração de Bardo duas vezes e adicionar o resultado mais alto ao d20.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  3,
  'Afinidade Cromática',
  'Sempre que terminar um Descanso Longo, escolha Ácido, Frio, Fogo, Relâmpago ou Veneno. Quando você conjurar uma magia de Clérigo ou usar um recurso de Clérigo que cause dano Necrótico ou Radiante, você pode mudar esse dano para o tipo escolhido.

Uma vez por turno, quando você causar dano do tipo escolhido a uma criatura, você pode causar dano extra daquele tipo igual ao seu nível de Clérigo a essa criatura. Você pode causar esse dano extra um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez). Você recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  3,
  'Magias do Domínio do Dragão',
  'Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas. Quando você alcança um nível de Clérigo especificado na tabela Magias do Domínio do Dragão, você passa a ter sempre as magias listadas preparadas.

Magias do Domínio do Dragão

Nível de Clérigo
Magias

3
Orbe Cromático, Comando, Visão no Escuro, Sopro do Dragão

5
Voar, Proteção contra Energia

7
Banimento, Enfeitiçar Monstro

9
Dominar Pessoa, Conjurar Dragão'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  3,
  'Majestade Dracônica',
  'Como Ação Mágica, você pode apresentar seu Símbolo Sagrado e gastar um uso de seu Canalizar Divindade para manifestar uma aura de autoridade dracônica ao seu redor em uma Emanação de 9 m. Escolha a condição Enfeitiçado ou Amedrontado. Cada criatura de sua escolha na Emanação deve ser bem-sucedida em uma salvaguarda de Sabedoria ou ter a condição escolhida por 1 minuto. Uma criatura Enfeitiçada ou Amedrontada por este recurso faz outra salvaguarda de Sabedoria no final de cada um de seus turnos, encerrando a condição em si mesma em um sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  6,
  'Bênção da Serpe',
  'Você pode gastar um uso de seu Canalizar Divindade para conjurar Sopro do Dragão ou Proteção contra Energia em si mesmo em vez de gastar um espaço de magia. Quando você conjura qualquer uma dessas magias dessa forma, a magia não exige Concentração. Esta magia termina mais cedo se você conjurar aquela magia novamente, tiver a condição Incapacitado ou morrer.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  17,
  'Aspecto Lendário',
  'Ao conjurar as asas, garras ou cauda de um dragão ancestral, você pode realizar uma das seguintes Ações Lendárias imediatamente após o turno de outra criatura. Depois de usar este recurso para realizar uma Ação Lendária, você não pode realizar aquela novamente até o início do seu próximo turno. Você pode usar este recurso três vezes e recupera todos os usos gastos ao terminar um Descanso Longo. Você também pode restaurar um uso gastando um espaço de magia de nível 2+ (nenhuma ação necessária).

Rasgar. Você se move até o seu Deslocamento e conjura um Truque de Clérigo com tempo de conjuração de uma ação ou faz um ataque corpo a corpo usando uma arma ou um Ataque Desarmado. O ataque usa sua Sabedoria para as jogadas de ataque e dano em vez de Força ou Destreza.

Golpe de Cauda. Cada criatura Grande ou menor de sua escolha a até 3 m de você ganha a condição Caído.

Bater de Asas. Você se move imediatamente até o seu Deslocamento. Durante este movimento, você tem um Deslocamento de Voo até o seu Deslocamento e não provoca Ataques de Oportunidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  3,
  'Magias do Círculo da Cidade',
  'Quando você alcança um nível de Druida especificado na tabela Magias do Círculo da Cidade, você passa a ter sempre as magias listadas preparadas.

Magias do Círculo da Cidade

Nível de Druida
Magias

3
Graxa, Saltar, Estilhaçar, Escalada Aracnídea

5
Fundir-se em Pedra, Enviar Mensagem

7
Fabricar, Moldar Pedra

9
Animar Objetos, Passagem'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  3,
  'Forma da Cidade',
  'Você pode gastar um uso de sua Forma Selvagem para conjurar Fundir-se em Pedra, Passagem ou Moldar Pedra sem um espaço de magia.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  3,
  'Druida Urbano',
  'Sua magia e habilidades são especializadas para a vida na cidade, concedendo os seguintes benefícios.

Esperteza das Ruas. Escolha Acrobacia, História, Intimidação, Investigação, Persuasão ou Furtividade. Você ganha um bônus em testes usando esta perícia igual ao seu modificador de Sabedoria (bônus mínimo de +1). Você pode mudar sua escolha ao terminar um Descanso Longo.

Magia Urbana. Sua magia assume as vestes estéticas da paisagem urbana. Magias como Emaranhar, Videira Agarradora, Crescimento de Espinhos e Muralha de Espinhos podem causar crescimento de paralelepípedos, tubos retorcidos ou vidro quebrado. As magias Falar com Plantas, Transporte via Plantas e Passo Arbóreo podem ter estruturas como alvo em vez de plantas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  6,
  'Forma de Objeto',
  'Quando você assume uma forma de Forma Selvagem, você pode escolher a forma de um Objeto Animado criado pela magia Animar Objetos. Você escolhe o tamanho do objeto (até Grande). No nível 10 de Druida, você também pode se transformar em um objeto Enorme.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  10,
  'Distorção de Muro',
  'Quando uma criatura que você possa ver a até 18 m de você sofrer dano de um ataque, você pode realizar uma Reação para conjurar Muralha de Pedra entre o alvo e o atacante. Quando você conjura a magia dessa forma, cria um único painel de 3 m por 3 m e 2,5 cm de espessura (CA 15, 30 PV e Imunidade a dano de Veneno e Psíquico), que desaparece no final do seu próximo turno. O painel sofre o dano do ataque e desaparece mais cedo se for reduzido a 0 Pontos de Vida.

Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Longo. Você também pode restaurar seu uso gastando um espaço de magia de nível 3+ (nenhuma ação necessária).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  14,
  'Colosso Urbano',
  'Enquanto transformado em um objeto animado, você ganha os seguintes benefícios.

Classe de Armadura. Até sair da forma, sua CA é igual a 18.

Limiar de Dano Limitado. Uma vez por turno, quando você sofrer menos de 10 de dano de um único ataque ou efeito, você pode reduzir esse dano a 0.

Ataque Múltiplo. Você pode usar Pancada duas vezes quando realizar a ação Atacar.

Imparável. Você pode se mover pelo espaço de qualquer criatura. Mover-se pelo espaço dela não custa movimento extra, mas você não pode parar no mesmo espaço. Se a criatura for do seu tamanho ou menor, ela sofre dano Contundente igual a 2d6 mais o seu modificador de Sabedoria e tem a condição Caído quando você entra no espaço dela. Uma criatura pode sofrer este dano uma vez por turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  3,
  'Licantropo',
  'Sua verdadeira forma é um híbrido bestial, concedendo os seguintes benefícios.

Garras. Você tem um conjunto de garras vorazes que pode usar para fazer Ataques Desarmados. Você pode usar seu modificador de Destreza em vez do modificador de Força para as jogadas de ataque e dano dos seus Ataques Desarmados. Quando você causa dano com um Ataque Desarmado, pode causar dano Cortante igual a 1d6 mais o seu modificador de Força ou Destreza em vez do dano normal do golpe.

Deslocamento de Escalada. Você ganha um Deslocamento de Escalada igual ao seu Deslocamento.

Visão no Escuro. Você ganha Visão no Escuro com alcance de 18 m. Se você já tiver Visão no Escuro, o alcance dela aumenta em 18 m.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  3,
  'Aspecto Bestial',
  'No auge do combate, você gradualmente perde o controle e escorrega para uma forma semelhante a uma fera. O grau da sua transformação é representado pelo seu Nível de Aspecto Bestial, que começa em 0. Seu Nível de Aspecto Bestial concede benefícios, conforme mostrado na tabela Aspecto Bestial. Você ganha todos os benefícios do seu Nível de Aspecto Bestial e dos níveis inferiores.

Quando você causa dano a um inimigo, pode realizar uma Ação Bônus para aumentar seu Nível de Aspecto Bestial em 1. Se você não causar dano a um inimigo por 1 minuto, seu Nível de Aspecto Bestial volta a 0.

Aspecto Bestial

Nível
Benefícios

0
—

1
Carnificina. Você ganha um bônus de +2 nas suas jogadas de dano com armas e Ataques Desarmados.

2
Movimento Rápido. Seu Deslocamento aumenta em 3 m.

3
Frenesi Sangrento. Você tem Vantagem nas jogadas de ataque contra qualquer criatura que não tenha todos os seus Pontos de Vida.

4
Pele Espessa. Se você não estiver empunhando um Escudo, ganha um bônus de +2 na CA.

5
Retaliação. Quando você sofre dano de uma criatura a até 1,5 m de você, pode realizar uma Reação para fazer um ataque corpo a corpo contra aquela criatura, usando uma arma ou um Ataque Desarmado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  7,
  'Uivo Feral',
  'Quando você rola Iniciativa, pode rolar um d4 e aumentar seu Nível de Aspecto Bestial para o número rolado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  11,
  'Fúria Sedenta de Sangue',
  'Você ganhou controle sobre sua fúria bestial, concedendo os seguintes benefícios.

Marca Bestial. Você pode conjurar Marca do Caçador como parte da Ação Bônus para aumentar seu Nível de Aspecto Bestial.

Carnificina Maior. O bônus de dano do seu benefício Carnificina aumenta para +3.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  15,
  'Resiliência Monstruosa',
  'Uma vez por turno, quando você sofrer dano, pode reduzir o dano total que sofre, até um mínimo de 0. A redução é igual ao seu modificador de Constituição mais o seu Nível de Aspecto Bestial.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  3,
  'Magias Heróicas',
  'Quando você alcança um nível de Feiticeiro especificado na tabela Magias Heróicas, você passa a ter sempre as magias listadas preparadas.

Magias Heróicas

Nível de Feiticeiro
Magias

3
Lâmina do Arco, Lâmina Flamejante, Lâmina Gélida, Heroísmo, Arma Mágica, Imagem Espelhada, Escudo

5
Acelerar, Corcel Fantasma

7
Proteção contra a Morte, Pele Rochosa

9
Conhecimento Lendário, Imobilizar Monstro'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  3,
  'Feitiçaria Marcial',
  'Sua vida heróica passada concede os seguintes benefícios.

Alma Heróica. No início de cada um de seus turnos, você pode gastar 1 Ponto de Feitiçaria para ganhar PV temporários iguais a 1d6 mais o seu nível de Feiticeiro (nenhuma ação necessária).

Lâmina Inata. Sempre que você atacar com uma arma com a qual tenha proficiência enquanto seu recurso Feitiçaria Inata estiver ativo, você pode usar seu modificador de Carisma para as jogadas de ataque e dano em vez de Força ou Destreza.

Treinamento Marcial. Você ganha proficiência com armas Marciais e treinamento com armadura Leve, armadura Média e Escudos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  6,
  'Ataque Extra',
  'Você pode atacar duas vezes, em vez de uma, sempre que realizar a ação Atacar no seu turno. Além disso, você pode conjurar um dos seus Truques de Feiticeiro com tempo de conjuração de uma ação no lugar de um desses ataques.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  14,
  'Manobras Místicas',
  'Você pode usar as seguintes manobras marciais.

Ataque Cegante. Quando você acerta uma criatura com um ataque usando uma arma ou Ataque Desarmado, pode gastar dois Pontos de Feitiçaria como Ação Bônus para tentar cegar o alvo. Adicione 2d8 à jogada de dano do ataque. O alvo deve ser bem-sucedido em uma salvaguarda de Constituição contra sua CD de magia ou ter a condição Cego por 1 minuto. No final de cada um de seus turnos, o alvo repete a salvaguarda, encerrando a condição em si mesmo em um sucesso.

Golpe Ruinoso. Quando você acerta uma criatura com um ataque usando uma arma ou Ataque Desarmado, pode gastar dois Pontos de Feitiçaria como Ação Bônus para romper suas defesas. Adicione 2d8 à jogada de dano do ataque. O alvo tem uma penalidade de −3 na CA até o final do seu próximo turno.

Golpe Ferino. Quando você acerta uma criatura com um ataque usando uma arma ou Ataque Desarmado, pode gastar dois Pontos de Feitiçaria como Ação Bônus para infligir uma ferida sangrenta ao alvo. Adicione 2d8 à jogada de dano do ataque. Uma criatura com uma ferida sangrenta não pode recuperar Pontos de Vida e sofre dano Necrótico igual a 1d8 por cada uma de suas feridas no início de cada um de seus turnos. Este dano ignora Resistência e Imunidade. Uma criatura pode realizar uma ação para estancar todas as suas feridas sangrentas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'heroic-sorcery'),
  18,
  'Aceleração Heróica',
  'Sempre que começar a conjurar Acelerar tendo a si mesmo como alvo, você pode modificá-la para que não exija Concentração. Se fizer isso, quando a magia terminar, você não tem a condição Incapacitado nem um Deslocamento de 0.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  3,
  'Sábio dos Mísseis Mágicos',
  'Adicione a magia Mísseis Mágicos ao seu grimório gratuitamente. Sua expertise nesta magia concede os seguintes benefícios.

Dardos Extra. Quando você conjura Mísseis Mágicos, cria um dardo extra de força mágica. Você cria dois dardos extras no nível 6 de Mago, três dardos extras no nível 10 de Mago e quatro dardos extras no nível 14 de Mago.

Conjuração Livre. Você pode conjurar Mísseis Mágicos sem um espaço de magia. Você pode fazer isso um número de vezes igual ao seu modificador de Inteligência (mínimo de uma vez). Você recupera um uso gasto ao terminar um Descanso Curto e recupera todos os usos gastos ao terminar um Descanso Longo.

Dardos Penetrantes. Seus dardos de Mísseis Mágicos ignoram qualquer efeito, como a magia Escudo, que bloqueie especificamente a magia Mísseis Mágicos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  6,
  'Mísseis Versáteis',
  'Você pode guiar com precisão seus dardos de Mísseis Mágicos para atingir um alvo onde escolher. Quando você conjura Mísseis Mágicos, pode adicionar um dos seguintes efeitos de Míssil Versátil a um alvo atingido pelos dardos. Cada efeito tem um custo, que é o número de dardos que você deve abrir mão para adicionar o efeito ao alvo. Você pode adicionar efeitos diferentes a alvos diferentes, pagando o custo de cada efeito separadamente.

Míssil de Tombo (Custo: 1 Dardo). O alvo deve ser bem-sucedido em uma salvaguarda de Força contra sua CD de magia ou ter a condição Caído.

Míssil Cegante (Custo: 3 Dardos). O alvo deve ser bem-sucedido em uma salvaguarda de Constituição contra sua CD de magia ou ter a condição Cego até o início do seu próximo turno.

Míssil Atordoante (Custo: 5 Dardos). O alvo deve ser bem-sucedido em uma salvaguarda de Constituição contra sua CD de magia ou ter a condição Atordoado até o início do seu próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  10,
  'Escudo de Mísseis',
  'Quando você conjura Mísseis Mágicos, pode direcionar os dardos em uma órbita apertada ao seu redor, criando uma Emanação protetora de 3 m originada de você, que dura até 1 minuto.

Você ganha um bônus na sua Classe de Armadura igual ao número de dardos orbitando você (bônus máximo de +5). Sempre que uma criatura a até 36 m errar você com uma jogada de ataque, um dardo atinge o atacante, causando dano normalmente e diminuindo em um o número de dardos orbitando você.

Sempre que a Emanação entrar no espaço de uma criatura que você possa ver e sempre que uma criatura que você possa ver entrar na Emanação ou terminar seu turno nela, você pode atingir o alvo com qualquer número de dardos orbitando você, causando dano normalmente e diminuindo o número de dardos orbitando você. Você só pode causar dano a uma criatura com a Emanação uma vez por turno.

Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Longo. Você também pode restaurar seu uso gastando um espaço de magia de nível 3+ (nenhuma ação necessária).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  14,
  'Giga-Míssil',
  'Quando você conjura Mísseis Mágicos, pode aprimorar o dano da magia. Você causa dano de Força extra com cada dardo igual ao seu modificador de Inteligência (mínimo de 1).

Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Longo. Você também pode restaurar seu uso gastando um espaço de magia de nível 6+ (nenhuma ação necessária).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
