-- Seed rpg.phb_subclass_feature
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'), 3, 'Vitalidade da Árvore', 'Sua Fúria se conecta à força vital da Árvore do Mundo.
Você adquire os seguintes benefícios.
Força Revigorante. No início de cada um dos seus
turnos enquanto sua Fúria estiver ativa, você pode
escolher outra criatura a até 3 metros de você para
receber Pontos de Vida Temporários. Para determinar
a quantidade de Pontos de Vida Temporários, jogue um
número de d6s igual ao seu bônus de Dano da Fúria e
some os valores. Se qualquer um desses Pontos de Vida
Temporários ainda estiverem ativos quando sua Fúria
terminar, eles desaparecem.
Surto de Vitalidade. Ao ativar sua Fúria, você recebe
um número de Pontos de Vida Temporários igual ao
seu nível de Bárbaro.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'), 6, 'Ramos da Árvore', 'Sempre que uma criatura que você pode ver começar
o turno a até 9 metros de você enquanto sua Fúria
estiver ativa, você pode executar uma Reação para convocar ramos espectrais da Árvore do Mundo ao redor
dela. O alvo deve ser bem-sucedido em uma salvaguarda de Força (CD 8 mais seu modificador de Força e
seu Bônus de Proficiência) ou é teleportado para um
espaço desocupado à sua vista a até 1,5 metro de você
ou no espaço desocupado mais próximo à sua vista.
Depois que o alvo se teleportar, você pode reduzir o
Deslocamento dele a 0 até o final do turno atual.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'), 10, 'Raízes Devastadoras', 'Durante o seu turno, seu alcance é 3 metros maior com
qualquer arma corpo a corpo que tenha a propriedade
Pesada ou Versátil, à medida que as raízes da Árvore do Mundo se estendem a partir de você. Quando
você atinge com tal arma no seu turno, pode ativar a
propriedade de maestria Derrubar ou Empurrar, além
de outra propriedade de maestria que você estiver
utilizando com a arma.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree'), 14, 'Percorrer a Árvore', 'Ao ativar sua Fúria e, como uma Ação Bônus enquanto
ela estiver ativa, você pode se teleportar a até 18 metros para um espaço desocupado à sua vista.
Além disso, uma vez por Fúria, você pode aumentar
o alcance desse teleporte para 45 metros. Ao fazer isso,
você também pode levar até seis criaturas voluntárias
que estejam a até 3 metros de você. Cada criatura se
teleporta para um espaço desocupado à sua escolha a
até 3 metros do seu destino.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'), 3, 'Frenesi', 'Se você usar Ataque Imprudente enquanto sua Fúria
estiver ativa, você causa dano adicional ao primeiro
alvo atingido no seu turno com um ataque baseado
em Força. Para determinar o dano adicional, jogue um
número de d6s igual ao seu bônus de Dano da Fúria e
some os resultados. O dano tem o mesmo tipo da arma
ou do Ataque Desarmado utilizado para o ataque.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'), 6, 'Fúria Irracional', 'Você tem Imunidade às condições Amedrontado e
Enfeitiçado enquanto sua Fúria estiver ativa. Se você
estiver sob efeito de uma dessas condições ao entrar
em Fúria, a condição encerra.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'), 10, 'Retaliação', 'Quando você sofrer dano de uma criatura que esteja a
até 1,5 metro de você, pode executar uma Reação para
realizar um ataque corpo a corpo contra essa criatura,
usando uma arma ou um Ataque Desarmado.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'), 14, 'Presença Intimidante', 'Como uma Ação Bônus, você pode causar terror em
outros com sua presença ameaçadora e poder primitivo. Quando fizer isso, cada criatura à sua escolha em
uma Emanação de 9 metros originada de você deve
realizar uma salvaguarda de Sabedoria (CD 8 + seu
modificador de Força + seu Bônus de Proficiência). Se
falhar, a criatura tem a condição Amedrontado por 1
minuto. No final de cada turno da criatura Amedrontada, ela repete a salvaguarda, e encerra o efeito em caso
de sucesso.
Uma vez que você usa essa característica, não pode
usá-la novamente até completar um Descanso Longo, a
menos que gaste um uso de sua Fúria (nenhuma ação é
necessária) para restaurar o uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 3, 'Arauto da Fauna', 'Você pode conjurar as magias Falar com Animais e
Sentido Feral, mas apenas como Rituais. Sabedoria é seu
atributo de conjuração para elas.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 3, 'Fúria dos Selvagens', 'Sua Fúria se conecta ao poder primitivo dos animais.
Sempre que você ativar sua Fúria, adquire uma das
seguintes opções à sua escolha.
Águia. Ao ativar sua Fúria, você pode executar as
ações Correr e Desengajar como parte dessa Ação
Bônus. Enquanto sua Fúria estiver ativa, você pode
executar uma Ação Bônus para realizar ambas as
ações.
Lobo. Enquanto sua Fúria estiver ativa, seus aliados
têm Vantagem em jogadas de ataque contra qualquer
inimigo seu a até 1,5 metro de você.
Urso. Enquanto em Fúria, você tem Resistência a
todos os tipos de dano, exceto Energético, Necrótico,
Psíquico e Radiante.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 6, 'Aspecto dos Selvagens', 'Você recebe uma das seguintes opções à sua escolha.
Sempre que completar um Descanso Longo, você pode
alterar sua escolha.
Coruja. Você tem Visão no Escuro com um alcance
de 18 metros. Se você já tem Visão no Escuro, seu
alcance aumenta em 18 metros.
Pantera. Você tem um Deslocamento de Escalada
igual ao seu Deslocamento.
Salmão. Você tem um Deslocamento de Natação
igual ao seu Deslocamento.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 10, 'Arauto da Natureza', 'Você pode conjurar a magia Comunhão com a Natureza,
mas apenas como um Ritual. Sabedoria é seu atributo
de conjuração para isso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 14, 'Poder dos Selvagens', 'Sempre que você ativar sua Fúria, recebe uma das
seguintes opções à sua escolha.
Carneiro. Enquanto sua Fúria estiver ativa, você pode
impor a condição Caído em uma criatura Grande ou
menor quando você a atinge com um ataque corpo a
corpo.
Falcão. Enquanto sua Fúria estiver ativa, você tem
um Deslocamento de Voo igual ao seu Deslocamento
se não estiver usando nenhuma armadura.
Leão. Enquanto sua Fúria estiver ativa, qualquer um
de seus inimigos a até 1,5 metro de você tem Desvantagem em jogadas de ataque contra alvos que não sejam
você ou outro Bárbaro que tenha essa opção ativa.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'), 3, 'Campeão dos Deuses', 'Uma entidade divina assegura que você possa continuar lutando. Você tem uma reserva de quatro d12s
que pode gastar para se curar. Como uma Ação Bônus,
você pode gastar dados da reserva, jogá-los e recuperar
uma quantidade de Pontos de Vida igual ao total do
resultado.
Sua reserva restaura todos os dados gastos quando
você completa um Descanso Longo.
O número máximo de dados na reserva aumenta
em um quando você atinge os níveis de Bárbaro 6 (5
dados), 12 (6 dados) e 17 (7 dados).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'), 3, 'Fúria Divina', 'Você pode canalizar poder divino em seus golpes. Em
cada um dos seus turnos, enquanto sua Fúria estiver
ativa, a primeira criatura que você atingir com uma
arma ou com um Ataque Desarmado sofre dano adicional igual a 1d6 pontos mais metade do seu nível de
Bárbaro (arredondado para baixo). O dano adicional é
do tipo Necrótico ou Radiante, à sua escolha, cada vez
que causar dano.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'), 6, 'Concentração Fanática', 'Uma vez por Fúria ativa, se você falhar em uma salvaguarda, pode jogá-la novamente com um bônus igual
ao seu bônus de Dano da Fúria, e deve usar o novo
resultado.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'), 10, 'Presença Zelosa', 'Como uma Ação Bônus, você libera um grito de
batalha infundido com energia divina. Até dez outras
criaturas à sua escolha a até 18 metros de você obtêm
Vantagem em jogadas de ataque e salvaguardas até o
início do seu próximo turno.
Uma vez que você usa essa característica, não pode
usá-la novamente até completar um Descanso Longo, a
menos que gaste um uso de sua Fúria (nenhuma ação é
necessária) para restaurar o uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'), 14, 'Fúria dos Deuses', 'Quando você ativa sua Fúria, pode assumir a forma de
um combatente divino. Essa forma dura 1 minuto ou
até você atingir 0 Pontos de Vida. Uma vez que você
use essa característica, não pode fazê-lo novamente até
completar um Descanso Longo.
Enquanto estiver nesta forma, você adquire os benefícios a seguir.
Resistência. Você tem Resistência a dano Necrótico,
Psíquico e Radiante.
Revivificação. Quando uma criatura a até 9 metros
de você atingir 0 Pontos de Vida, você pode executar
uma Reação para gastar um uso da sua Fúria e, em vez
disso, mudar os Pontos de Vida do alvo para um número igual ao seu nível de Bárbaro.
Voo. Você tem um Deslocamento de Voo igual ao seu
Deslocamento e pode pairar.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'valor'), 3, 'Inspiração em Combate', 'Você pode usar sua astúcia para virar o rumo da batalha. Uma criatura que possui um dado de Inspiração
de Bardo seu pode utilizá-lo para um dos seguintes
efeitos.
Defensivo. Quando a criatura é atingida por uma
jogada de ataque, pode executar a própria Reação
para jogar o dado da Inspiração de Bardo e adicionar
o resultado jogado à própria CA contra aquele ataque,
potencialmente fazendo com que o ataque erre.
Ofensivo. Imediatamente após a criatura atingir um
alvo com uma jogada de ataque, ela pode jogar o dado
da Inspiração de Bardo e adicionar o resultado jogado
ao dano do ataque contra o alvo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'valor'), 3, 'Treinamento Marcial', 'Você adquire proficiência com armas Marciais, armaduras Médias e treinamento com Escudos.
Além disso, você pode usar uma arma Simples ou
Marcial como Foco de Conjuração para conjurar magias da sua lista de magias de Bardo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'valor'), 6, 'Ataque Extra', 'Você pode atacar duas vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.
Além disso, você pode conjurar um de seus truques
que tenha um tempo de conjuração de uma ação no
lugar de um desses ataques.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'valor'), 14, 'Magia de Batalha', 'Após conjurar uma magia que tenha um tempo de
conjuração de uma ação, você pode realizar um ataque
com uma arma como uma Ação Bônus.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'), 3, 'Ginga Fascinante', 'Enquanto você não estiver vestindo armadura ou empunhando um Escudo, adquire os seguintes benefícios.
Dança Virtuosa. Você tem Vantagem em qualquer teste de Carisma (Atuação) que envolva você
dançando.
Dano de Bardo. Você pode usar Destreza em vez de
Força para as jogadas de ataque de seus Ataques Desarmados. Quando você causar dano com um Ataque
Desarmado, pode causar dano Contundente igual ao
resultado do dado da sua Inspiração de Bardo mais seu
modificador de Destreza, em vez do dano normal do
ataque. Esse uso não gasta o dado.
Defesa sem Armadura. Sua Classe de Armadura base
é igual a 10 mais seus modificadores de Destreza e
Carisma.
Golpes Ágeis. Quando você gastar um uso da sua Inspiração de Bardo como parte de uma ação, Ação Bônus
ou Reação, pode realizar um Ataque Desarmado como
parte dessa ação, Ação Bônus ou Reação.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'), 6, 'Gingado Coordenado', 'Ao jogar Iniciativa, você pode gastar um uso da sua
Inspiração de Bardo se não estiver com a condição
Incapacitado. Ao realizar isso, jogue o dado da sua
Inspiração de Bardo; você e cada aliado a até 9 metros
de você que puder ver ou ouvir você adquire um bônus
na Iniciativa igual ao número jogado.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'), 6, 'Movimento Inspirador', 'Quando um inimigo à sua vista encerra o turno dele a
até 1,5 metro de você, você pode executar uma Reação
e gastar um uso da sua Inspiração de Bardo para se
mover até metade do seu Deslocamento. Em seguida,
um aliado à sua escolha a até 9 metros de você também
pode se mover até metade do Deslocamento dele usando a própria Reação.
Nenhum movimento dessa característica provoca
Ataques de Oportunidade.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'), 14, 'Evasão Liderada', 'Se você for alvo de um efeito que permita uma salvaguarda de Destreza para receber apenas metade do
dano, você não recebe dano algum se for bem-sucedido
e apenas metade se falhar. Se criaturas até 1,5 metro
de você também realizarem a salvaguarda, você pode
compartilhar esse benefício com elas.
Você não pode usar esta característica se estiver com
a condição Incapacitado.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 3, 'Palavras de Interrupção', 'Você aprende a usar sua sagacidade para distrair,
confundir e diminuir sobrenaturalmente a confiança
e a competência dos outros. Quando uma criatura à
sua vista a até 18 metros de você realizar uma jogada
de dano, ou for bem-sucedida em um teste de atributo
ou jogada de ataque, você pode executar uma Reação
para gastar um uso da sua Inspiração de Bardo. Jogue
o dado de Inspiração de Bardo e subtraia o número
jogado do resultado da criatura, reduzindo o dano ou
transformando potencialmente o sucesso em fracasso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 3, 'Proficiências Bônus', 'Você adquire proficiência em três perícias à sua
escolha.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 6, 'Descobertas Mágicas', 'Você aprende duas magias à sua escolha. Essas magias
podem vir da lista de magias de Clérigo, Druida ou
Mago, ou uma combinação dessas listas (veja a seção
da classe para a respectiva lista de magias). A magia escolhida deve ser um truque ou uma magia para a qual
você tenha espaços de magia disponíveis, conforme
mostrado na tabela Características de Bardo.
Você sempre tem as magias escolhidas preparadas
e, sempre que adquirir um novo nível de Bardo, pode
substituir uma das magias por outra que atenda a esses
requisitos.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'lore'), 14, 'Perícia Inigualável', 'Quando você realizar um teste de atributo ou uma
jogada de ataque e falhar, pode gastar um uso da Inspiração de Bardo; jogue o dado da Inspiração de Bardo
e adicione o resultado jogado ao d20, transformando
potencialmente a falha em sucesso. Se falhar, o uso da
Inspiração de Bardo não é gasto.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 3, 'Magia Fascinante', 'Você sempre está com as magias Enfeitiçar Pessoa e
Reflexos preparadas.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 3, 'Manto de Inspiração', 'Você pode canalizar magia feérica em uma canção ou
dança, revigorando os outros. Como um Ação Bônus,
você pode usar uma das suas Inspirações de Bardo,
jogando um dado de Inspiração de Bardo. Escolha um
número de criaturas a até 18 metros de você igual ao
seu modificador de Carisma (no mínimo uma criatura).
Cada uma dessas criaturas recebe um número de Pontos de Vida Temporários igual a duas vezes o número
jogado no dado de Inspiração de Bardo e, então, cada
uma pode executar uma Reação para se mover até o
máximo do Deslocamento sem provocar Ataques de
Oportunidade.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 6, 'Manto de Majestade', 'Você tem sempre a magia Comando preparada.
Como uma Ação Bônus, você pode conjurar Comando
sem gastar um espaço de magia e assumir uma aparência sobrenatural por 1 minuto ou até que sua Concentração se quebre. Durante esse tempo, você pode
conjurar Comando como uma Ação Bônus sem gastar
um espaço de magia.
Qualquer criatura que está com a condição Enfeitiçado por você falha automaticamente em uma salvaguarda contra o Comando que você conjurar com esta
característica.
Após usar esta característica, você não pode utilizá-la
novamente até completar um Descanso Longo. Você
também pode restaurar seu uso gastando um espaço
de magia de 3º círculo ou superior (nenhuma ação é
necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 14, 'Majestade Inquebrável', 'Como uma Ação Bônus, você pode assumir uma presença majestosamente mágica por 1 minuto ou até que
tenha a condição Incapacitado. Por essa duração, sempre que qualquer criatura o atinge com uma jogada de
ataque pela primeira vez em um turno, o atacante deve
ser bem-sucedido em uma salvaguarda de Carisma contra a CD para evitar sua magia, ou o ataque falha, pois
a criatura retrai diante de sua majestade.
Uma vez que você assume essa presença majestosa,
não pode fazê-lo novamente até completar um Descanso Curto ou Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 3, 'Magias de Pacto da Arquifada', 'A magia do seu patrono assegura que você sempre
tenha algumas magias disponíveis; ao atingir um nível
de Bruxo indicado na tabela Magias da Arquifada, você
sempre tem essas magias preparadas.
Magias da Arquifada
Nível de Bruxo Magias
3 Acalmar Emoções, Fogo das Fadas, Força
Espectral, Passo Nebuloso, Sono
5 Crescimento de Plantas, Piscar
7 Dominar Fera, Invisibilidade Maior
9 Dominar Pessoa, Similaridade') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 3, 'Passos Feéricos', 'Seu patrono lhe confere a habilidade de transitar entre
os planos. Você pode conjurar Passo Nebuloso sem
gastar um espaço de magia um número de vezes igual
ao seu modificador de Carisma (mínimo de uma vez) e
restaura todos os usos gastos ao completar um Descanso Longo.
Além disso, ao conjurar essa magia, você pode escolher um dos seguintes efeitos adicionais.
Passo Provocante. Criaturas a até 1,5 metro do
espaço que você deixou devem ser bem-sucedidas em
uma salvaguarda de Sabedoria contra a CD para evitar
sua magia ou têm Desvantagem em jogadas de ataque
contra criaturas diferentes de você até o início do seu
próximo turno.
Passo Revigorante. Imediatamente após você se teleportar, você ou uma criatura à sua vista a até 3 metros
de você, adquire 1d10 Pontos de Vida Temporários.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 6, 'Fuga em Névoa', 'Você pode conjurar Passo Nebuloso como uma Reação
ao sofrer dano.
Além disso, os seguintes efeitos agora estão entre
suas opções de Passos Feéricos.
Passo Desvanecedor. Você tem a condição Invisível
até o início do seu próximo turno ou até imediatamente após realizar uma jogada de ataque, causar dano ou
conjurar uma magia.
Passo Terrível. Criaturas a até 1,5 metro do espaço
que você deixou ou do espaço em que você aparece (à
sua escolha) devem ser bem-sucedidas em uma salvaguarda de Sabedoria contra a CD para evitar sua magia
ou sofrem 2d10 pontos de dano Psíquico.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 10, 'Defesas Sedutoras', 'Seu patrono ensina como proteger sua mente e corpo.
Você é imune à condição Enfeitiçado.
Além disso, imediatamente após uma criatura à sua
vista acertar você com uma jogada de ataque, você
pode executar uma Reação para reduzir o dano sofrido
pela metade (arredondado para baixo) e pode forçar
quem o atacou a realizar uma salvaguarda de Sabedoria contra a CD para evitar sua magia. Se falhar, o
atacante sofre dano Psíquico igual ao dano que você
sofreu. Após executar esta Reação, você não pode
usá-la novamente até completar um Descanso Longo, a
menos que gaste um espaço de Magia de Pacto (nenhuma ação é necessária) para restaurar seu uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 14, 'Magia Sedutora', 'Seu patrono concede a você a capacidade de tecer sua
magia com teleporte. Imediatamente após conjurar
uma magia de Encantamento ou Ilusão usando uma
ação e um espaço de magia, você pode conjurar Passo
Nebuloso como parte da mesma ação e sem gastar um
espaço de magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 3, 'Luz Medicinal', 'Você adquire a habilidade de canalizar energia celestial
para curar feridas. Você tem uma reserva de d6s que
podem ser gastos nessa cura. O número de dados na
reserva é igual a 1 mais seu nível de Bruxo.
Como uma Ação Bônus, você pode curar a si ou uma
criatura à sua vista a até 18 metros de você, gastando
dados da reserva. O número máximo de dados que
você pode gastar de uma só vez é igual ao seu modificador de Carisma (mínimo de um dado). Jogue os
dados que deseja e restaure um número de Pontos de
Vida igual ao resultado. Sua reserva recupera todos os
dados gastos ao completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 3, 'Magia de Pacto do Celestial', 'A magia do seu patrono assegura que você sempre
tenha algumas magias disponíveis; ao atingir um nível
de Bruxo indicado na tabela Magias do Celestial, você
sempre tem essas magias preparadas.
Magias do Celestial
Nível de Bruxo Magias
3 Auxílio, Chama Sagrada, Curar Ferimentos,
Luz, Raio Guia, Restauração Menor
5 Luz do Dia, Revivificar
7 Defensor da Fé, Muralha de Fogo
9 Convocar Celestial, Restauração Maior') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 6, 'Alma Radiante', 'Seu vínculo com seu patrono permite que você sirva
como condutor de energia radiante. Você tem Resistência a Dano Radiante. Uma vez por turno, quando
conjurar uma magia que cause dano Ígneo ou Radiante, você pode adicionar seu modificador de Carisma ao
dano dessa magia contra um dos alvos da magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 10, 'Resiliência Celestial', 'Você recebe Pontos de Vida Temporários sempre que
usar sua característica Astúcia Mágica ou completar
um Descanso Curto ou Longo. Esses Pontos de Vida
Temporários são iguais ao seu nível de Bruxo mais seu
modificador de Carisma. Além disso, escolha até cinco
criaturas à sua vista quando receber os pontos. Cada
uma dessas criaturas recebe Pontos de Vida Temporários iguais à metade do seu nível de Bruxo mais seu
modificador de Carisma.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 14, 'Vingança Calcinante', 'Quando você ou um aliado a até 18 metros de você estiver prestes a realizar uma Salvaguarda Contra Morte,
você pode liberar energia radiante para salvar a criatura. A criatura restaura Pontos de Vida iguais à metade
de seus Pontos de Vida máximos e pode encerrar a
condição Caído em si. Cada criatura à sua escolha que
esteja a até 9 metros da criatura sofre dano Radiante
igual a 2d8 mais seu modificador de Carisma e cada
uma tem a condição Cego até o final do turno atual.
Você pode usar esta característica novamente após
completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 3, 'Magias de Pacto do Grande Antigo', 'A magia do seu patrono assegura que você sempre
tenha algumas magias disponíveis; ao atingir um nível
de Bruxo indicado na tabela Magias do Grande Antigo,
você sempre tem essas magias preparadas.
Magias do Grande Antigo
Nível de Bruxo Magias
3 Detectar Pensamentos, Força Espectral,
Gargalhada Nefasta de Tasha, Sussurros
Dissonantes
5 Clarividência, Fome de Hadar
7 Confusão, Invocar Aberração
9 Modificar Memória, Telecinese') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 3, 'Magias Psíquicas', 'Ao conjurar uma magia de Bruxo que cause dano,
você pode mudar seu tipo de dano para Psíquico. Além
disso, você pode conjurar uma magia de Bruxo que seja
Encantamento ou Ilusão sem componentes Verbais ou
Somáticos.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 3, 'Mente Desperta', 'Você pode estabelecer uma conexão telepática com
outra criatura. Como uma Ação Bônus, escolha uma
criatura à sua vista a até 9 metros de você. Vocês
podem se comunicar telepaticamente a uma distância
máxima de 1,5 quilômetros vezes o seu modificador de
Carisma (mínimo de 1,5 quilômetro). Para que a comunicação funcione, ambos devem usar mentalmente um
idioma comum.
A conexão telepática dura um número de minutos
igual ao seu nível de Bruxo. Ela encerra mais cedo se
você usar esta característica para se conectar com uma
criatura diferente.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 6, 'Combatente Clarividente', 'Ao formar uma ligação telepática com uma criatura
usando Mente Desperta, você pode forçar essa criatura
a realizar uma salvaguarda de Sabedoria contra a CD
para evitar sua magia. Se falhar, a criatura tem Desvantagem em jogadas de ataque contra você e você tem
Vantagem em jogadas de ataque contra essa criatura
pela duração da ligação.
Você pode usar esta característica novamente após
completar um Descanso Curto ou Longo ou gastar um
espaço de magia de Pacto (nenhuma ação é necessária)
para restaurar seu uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 10, 'Danação Mística', 'Seu patrono alienígena lhe concede uma maldição
poderosa. Você sempre tem a magia Danação preparada. Ao conjurar Danação e escolher um atributo, o
alvo também tem Desvantagem nas salvaguardas do
atributo escolhido pela duração da magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 10, 'Escudo Mental', 'Seus pensamentos não podem ser lidos por telepatia ou
outros meios, a menos que você permita. Você também
tem Resistência a Dano Psíquico e sempre que uma
criatura causar Dano Psíquico a você, essa criatura
sofre a mesma quantidade de dano que você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 14, 'Criar Servo', 'Ao conjurar Invocar Aberração, você pode modificá-la
para não exigir Concentração. Ao fazer isso, a duração
da magia se torna 1 minuto para essa conjuração e,
quando invocada, a Aberração tem um número de Pontos de Vida Temporários igual ao seu nível de Bruxo
mais seu modificador de Carisma.
Além disso, na primeira vez de cada turno que a
Aberração atinge uma criatura sob o efeito da sua Danação, a Aberração causa um dano Psíquico adicional
ao alvo igual ao dano bônus dessa magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 3, 'Bênção do Tenebroso', 'Ao reduzir um inimigo a 0 Pontos de Vida, você adquire
Pontos de Vida Temporários iguais ao seu modificador
de Carisma mais seu nível de Bruxo (mínimo de 1
Ponto de Vida Temporário). Você também recebe esse
benefício se outra pessoa reduzir um inimigo a até 3
metros de você a 0 Pontos de Vida.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 3, 'Magias de Pacto do Ínfero', 'A magia do seu patrono assegura que você sempre
tenha algumas magias disponíveis; ao atingir um nível
de Bruxo indicado na tabela Magias do Ínfero, você
sempre tem essas magias preparadas.
Magias do Ínfero
Nível de Bruxo Magias
3 Comando, Mãos Flamejantes, Raio Ardente,
Sugestão
5 Bola de Fogo, Nuvem Fétida
7 Escudo Ardente, Muralha de Fogo
9 Missão, Praga de Insetos') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 6, 'A Sorte do Próprio Tenebroso', 'Você pode chamar seu patrono Ínfero para alterar o
destino a seu favor. Ao realizar um teste de atributo
ou uma salvaguarda, você pode usar essa característica
para adicionar 1d10 à sua jogada. Você pode fazer
isso após ver a jogada, mas antes que qualquer um dos
efeitos da jogada ocorra.
Você pode usar essa característica um número de
vezes igual ao seu modificador de Carisma (mínimo de
uma vez), no máximo uma vez por jogada, e restaura
todos os usos gastos ao completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 10, 'Resistência Ínfera', 'Ao completar um Descanso Curto ou Longo, escolha
um tipo de dano, exceto Energético. Você tem Resistência a esse tipo de dano até escolher um tipo de dano
diferente com esta característica.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 14, 'Lançar no Inferno', 'Uma vez por turno, ao atingir uma criatura com uma
jogada de ataque, você pode tentar transportar instantaneamente o alvo para os Planos Inferiores. O alvo
deve ser bem-sucedido em uma salvaguarda de Carisma
contra a CD para evitar sua magia, ou ele desaparece
e atravessa uma paisagem de pesadelo. O alvo sofre
8d10 pontos de dano Psíquico se não for um Ínfero e tem
a condição Incapacitado até o final do seu próximo
turno, quando retorna ao espaço que ocupava anteriormente ou ao espaço desocupado mais próximo.
Você pode usar esta característica novamente após
completar um Descanso Longo, a menos que gaste um
espaço de Magia de Pacto (nenhuma ação é necessária)
para restaurar seu uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'life'), 3, 'Magias de Domínio da Vida', 'Sua conexão com este domínio divino garante que
você sempre tenha certas magias preparadas. Ao
atingir um nível de Clérigo especificado na tabela Magias de Domínio da Vida, você sempre tem as magias
listadas preparadas.
Magias de Domínio da Vida
Nível de Clérigo Magias Preparadas
3 Auxílio, Bênção, Curar Ferimentos,
Restauração Menor
5 Palavra Curativa em Massa, Revivificar
7 Aura de Vida, Proteção
Contra a Morte
9 Curar Ferimentos em Massa,
Restauração Maior') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'life'), 3, 'Discípulo da Vida', 'Ao conjurar uma magia com um espaço de magia que
restaura Pontos de Vida em uma criatura, essa criatura recupera Pontos de Vida adicionais no turno da
conjuração. Os Pontos de Vida adicionais são iguais a
2 mais o nível do espaço de magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'life'), 3, 'Preservar a Vida', 'Com uma ação Usar Magia, você exibe seu Símbolo
Sagrado e usa seu Canalizar Divindade para evocar
uma energia de cura que pode restaurar um número
de Pontos de Vida igual a cinco vezes seu nível de
Clérigo. Escolha criaturas Sangrando a até 9 metros
de você (que pode incluir você) e divida esses Pontos
de Vida entre elas. Esta característica pode restaurar
uma criatura a não mais que a metade dos Pontos de
Vida máximo dela.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'life'), 6, 'Curandeiro Abençoado', 'Magias de cura que você conjurar nos outros também
o curam. Imediatamente após conjurar uma magia
com um espaço de magia que restaure Pontos de Vida
em uma criatura que não seja você, você recupera
Pontos de Vida iguais a 2 mais o círculo do espaço de
magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'life'), 17, 'Cura Suprema', 'Ao usar uma magia ou Canalizar Divindade para
restaurar Pontos de Vida em uma criatura, não jogue
os dados normalmente; em vez disso, utilize o maior
resultado de cada dado. Por exemplo, ao restaurar
2d6 Pontos de Vida, você restaura 12.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'light'), 3, 'Brilho do Amanhecer', 'Como uma ação Usar Magia, você ergue seu Símbolo
Sagrado e gasta o uso de seu Canalizar Divindade
para emitir um feixe de luz em uma Emanação de 9
metros originada em você. Qualquer Escuridão mágica, como a criada pela magia Escuridão, nessa área
é dissipada. Além disso, cada criatura à sua escolha
nessa área deve realizar uma salvaguarda de Constituição, sofrendo dano Radiante igual a 2d10 mais seu
nível de Clérigo se falhar ou metade desse dano em
caso de sucesso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'light'), 3, 'Labareda Protetora', 'Quando uma criatura à sua vista a até 9 metros de
você realiza uma jogada de ataque, você pode executar uma Reação para impor Desvantagem na jogada
de ataque, fazendo com que a luz brilhe antes de acertar ou errar.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'light'), 3, 'Magias de Domínio da Luz', 'Sua conexão com este domínio divino garante que
você sempre tenha certas magias preparadas. Ao
atingir um nível de Clérigo especificado na tabela Magias de Domínio da Luz, você sempre tem as magias
listadas preparadas.
Magias de Domínio da Luz
Nível de Clérigo Magias Preparadas
3 Fogo das Fadas, Mãos Ardentes, Raio
Ardente, Ver o Invisível
5 Bola de Fogo, Luz do Dia
7 Muralha de Fogo, Olho Arcano
9 Coluna de Chamas, Vidência') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'light'), 6, 'Labareda Protetora Aprimorada', 'Você restaura todos os usos gastos da sua Labareda Protetora ao completar um Descanso Curto ou
Longo.
Além disso, sempre que usar Labareda Protetora,
você pode conceder ao alvo do ataque desencadeado
um número de Pontos de Vida Temporários igual a
2d6 mais seu modificador de Sabedoria.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'light'), 17, 'Coroa de Luz', 'Como uma ação Usar Magia, você emite uma aura de
luz solar que dura 1 minuto ou até que você a encerre
(nenhuma ação é necessária). Você emite Luz Plena em um raio de 18 metros e Meia-luz por mais 9
metros. Seus inimigos na Luz Plena têm Desvantagem
em salvaguardas contra seu Brilho do Amanhecer e
qualquer magia que cause dano Ígneo ou Radiante.
Você pode usar esta característica um número de
vezes igual ao seu modificador de Sabedoria (mínimo
de uma vez) e restaura todos os usos gastos ao completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'), 3, 'Magias de Domínio da Trapaça', 'Sua conexão com este domínio divino garante que
você sempre tenha certas magias preparadas. Ao atingir um nível de Clérigo especificado na tabela Magias
de Domínio da Trapaça, você sempre tem as magias
listadas preparadas.
Magias de Domínio da Trapaça
Nível de Clérigo Magias Preparadas
3 Disfarçar-se, Enfeitiçar Pessoa,
Invisibilidade, Passo Sem Rastro
5 Indetectável, Padrão Hipnótico
7 Confusão, Porta Dimensional
9 Dominar Pessoa, Modificar Memória') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'), 3, 'Bênção do Trapaceiro', 'Com uma ação Usar Magia, você pode escolher a si ou
a uma criatura voluntária a até 9 metros de você para
ter Vantagem em testes de Destreza (Furtividade).
Essa bênção permanece até você completar um Descanso Longo ou usar esta característica novamente.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'), 3, 'Invocar Duplicidade', 'Como uma Ação Bônus, você pode gastar um uso de
seu Canalizar Divindade para criar uma ilusão visual
perfeita de si em um espaço desocupado à sua vista a
até 9 metros de si. A ilusão é intangível e não ocupa
seu espaço. Ela permanece por 1 minuto e acaba se
você tiver a condição Incapacitado ou a encerrar (nenhuma ação é necessária). A ilusão é animada e imita
suas expressões e gestos. Enquanto ela persistir, você
adquire os seguintes benefícios.
Conjurar Magias. Você pode conjurar magias como
se estivesse no espaço da ilusão, mas deve usar seus
próprios sentidos.
Distração. Quando você e sua ilusão estão a até 1,5
metro de uma criatura que pode ver a ilusão, você
tem Vantagem em jogadas de ataque contra essa
criatura, considerando quão perturbadora a ilusão é
para o alvo.
Mover. Como uma Ação Bônus, você pode
mover a ilusão até 9 metros para um espaço
desocupado que esteja a até 36 metros de
você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'), 6, 'Transposição do Trapaceiro', 'Ao executar a Ação Bônus para criar ou mover a ilusão de seu Invocar Duplicidade, você
pode se teleportar, trocando de lugar com a
ilusão.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'), 17, 'Duplicidade Aprimorada', 'A ilusão de seu Invocar Duplicidade ficou mais poderosa das seguintes maneiras.
Distração Compartilhada. Quando você e seus aliados realizam jogadas de ataque contra uma criatura
a até 1,5 metro da ilusão, as jogadas de ataque têm
Vantagem.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'war'), 3, 'Magias de Domínio da Guerra', 'Sua conexão com este domínio divino garante que
você sempre tenha certas magias preparadas. Ao atingir um nível de Clérigo especificado na tabela Magias
de Domínio da Guerra, você sempre tem as magias
listadas preparadas.
Magias de Domínio da Guerra
Nível de Clérigo Magias Preparadas
3 Arma Espiritual, Arma Mágica, Escudo
da Fé, Raio Guia
5 Guardiões Espirituais, Manto do Cruzado
7 Escudo Ardente, Movimentação Livre
9 Golpe de Arço, Paralisar Monstro') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'war'), 3, 'Ataque Direcionado', 'Quando você ou uma criatura a até 9 metros de você
erra uma jogada de ataque, você pode gastar um uso
de seu Canalizar Divindade e dar a essa jogada um
bônus de +10, potencialmente fazendo-o acertar. Você
usa sua Reação para conceder esse bônus a uma jogada de ataque a outra criatura.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'war'), 3, 'Sacerdote da Guerra', 'Como uma Ação Bônus, você pode realizar um ataque
com uma arma ou um Ataque Desarmado. Você pode
usar essa Ação Bônus um número de vezes igual ao
seu modificador de Sabedoria (mínimo de uma vez).
Você restaura todos os usos gastos ao completar um
Descanso Curto ou Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'war'), 6, 'Bênção do Deus da Guerra', 'Você pode gastar um uso de seu Canalizar Divindade
para conjurar Arma Espiritual ou Escudo da Fé em vez
de gastar um espaço de magia. Uma magia conjurada dessa maneira não requer Concentração. Em vez
disso, a magia permanece por 1 minuto, mas encerra
se você conjurá-la novamente, ter a condição Incapacitado ou morrer.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'war'), 17, 'Avatar da Guerra', 'Você adquire Resistência a dano Contundente, Cortante e Perfurante.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 3, 'Auxílio da Terra', 'Como uma ação Usar Magia, você pode gastar um
uso de sua Forma Selvagem e escolher um ponto a até
18 metros de você. Flores que concedem vitalidade e
espinhos drenadores de vida surgem momentaneamente em uma Esfera de 3 metros de raio, centrada nesse
ponto. Cada criatura à sua escolha na Esfera deve
realizar uma salvaguarda de Constituição contra a CD
para evitar sua magia, sofrendo 2d6 pontos de dano
Necrótico se falhar ou metade desse dano em caso de
sucesso. Uma criatura à sua escolha na área restaura
2d6 Pontos de Vida.
O dano e cura aumentam em 1d6 quando você atinge
o nível 10 (3d6) e 14 (4d6) de Druida.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 3, 'Magias do Círculo da Terra', 'Sempre que completar um Descanso Longo, escolha
um tipo de terreno: árido, polar, temperado ou tropical. Consulte a tabela abaixo correspondente ao tipo
escolhido; você tem a lista de magias preparadas de seu
nível de Druida e inferior.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 6, 'Recuperação Natural', 'Você pode conjurar uma das magias de 1º círculo ou
superior que preparou de sua característica Magias
de Círculo Druídico sem gastar um espaço de magia, e
deve completar um Descanso Longo antes de fazê-lo
novamente.
Além disso, ao completar um Descanso Curto, pode
escolher recuperar espaços de magia gastos. A somatória dos círculos desses espaços deve ser menor ou
igual à metade do seu nível como Druida (arredondado para cima), e nenhum deles pode ser de 6º círculo
ou superior. Por exemplo, se você for um Druida de
nível 6, pode recuperar até três círculos de espaços de
magia. Você pode recuperar um espaço de magia de 3º
círculo, ou um de 2º círculo e um de 1º círculo, ou três
de 1º círculo. Após recuperar espaços de magia com
esta característica, você não pode fazê-lo novamente
até completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 10, 'Proteção Natural', 'Você é imune à condição Envenenado e tem Resistência a um tipo de dano associado à sua escolha atual de
terreno na característica Magias de Círculo Druídico,
conforme mostrado na tabela Proteção Natural.
Proteção Natural
Tipo de
Terreno Resistência
Tipo de
Terreno Resistência
Árido Ígneo Temperado Elétrico
Polar Gélido Tropical Venenoso') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'land'), 14, 'Santuário Natural', 'Como uma ação Usar Magia, você pode gastar um uso
de sua Forma Selvagem e produzir árvores e vinhas
espectrais que aparecem em um Cubo de 4,5 metros de
lados no chão a até 36 metros de você. Elas permanecem por 1 minuto ou até você morrer, ou ter a condição Incapacitado. Você e seus aliados têm Cobertura
Parcial enquanto estiverem nessa área, e seus aliados
adquirem a Resistência atual da sua Proteção Natural
enquanto estão lá.
Como uma Ação Bônus, você pode mover o Cubo até
18 metros para o chão a até 36 metros de você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'), 3, 'Formas Animais dos Círculos Druídicos', 'Você pode canalizar a magia lunar ao assumir uma
Forma Selvagem, obtendo os seguintes benefícios.
Nível de Desafio. O Nível de Desafio máximo para
a forma é igual ao seu nível de Druida dividido por 3
(arredondado para baixo).
Classe de Armadura. Até sair da forma, sua CA passa
a ser 13 + seu modificador de Sabedoria, se esse valor
for maior que a CA da Fera.
Pontos de Vida Temporários. Você adquire um número de Pontos de Vida Temporários igual a três vezes o
seu nível de Druida.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'), 3, 'Magias do Círculo da Lua', 'Ao atingir um nível de Druida detalhado na tabela
Magias do Círculo da Lua, você tem a as magias da lista
sempre preparadas.
Além disso, você pode conjurar as magias dessa característica enquanto estiver em uma Forma Selvagem.
Magias do Círculo da Lua
Nível de Druida Magias de Círculo Druídico
3 Curar Ferimentos, Fagulha Estelar,
Raio Lunar
5 Invocar Animais
7 Fonte do Luar
9 Curar Ferimentos em Massa') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'), 6, 'Formas Animais dos Círculos Druídicos Aprimorada', 'Enquanto estiver em uma Forma Selvagem, você adquire os seguintes benefícios.
Radiância Lunar. Cada um de seus ataques na Forma
Selvagem pode causar seu tipo de dano normal ou
dano Radiante. Você escolhe cada vez que acerta com
esses ataques.
Vigor Aumentado. Você pode adicionar seu modificador de Sabedoria às suas salvaguardas de Constituição.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'), 10, 'Passo Lunar', 'Você se transporta magicamente, reaparecendo em
meio a uma explosão de luar. Como uma Ação Bônus,
você se teleporta até 9 metros para um espaço desocupado à sua vista e tem Vantagem na próxima jogada de
ataque que realizar antes do final deste turno.
Você pode usar essa característica um número de
vezes igual ao seu modificador de Sabedoria (mínimo
de uma vez) e restaura todos os usos gastos ao completar um Descanso Longo. Você também pode recuperar
usos gastando um espaço de magia de 2º círculo ou
superior para cada uso que deseja recuperar (nenhuma
ação é necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'), 14, 'Forma Lunar', 'O poder da lua permeia você, concedendo os seguintes
benefícios.
Radiância Lunar Aprimorada. Uma vez por turno,
você pode causar 2d10 pontos de dano Radiante
adicional a um alvo que você acerta com o ataque da
Forma Selvagem.
Luar Compartilhado. Sempre que usar Passo Lunar,
você também pode teleportar uma criatura voluntária.
Essa criatura deve estar a até 3 metros de você, e você
a teleporta para um espaço desocupado à sua vista a
até 3 metros do seu destino.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 3, 'Forma Estrelada', 'Como uma Ação Bônus, você pode gastar um uso de
sua característica Forma Selvagem para assumir uma
forma estrelada em vez de multimorfar.
Enquanto em sua forma estrelada, você mantém suas
estatísticas de jogo, mas seu corpo se torna luminoso,
com articulações que brilham como estrelas e linhas
brilhantes conectando-as, como em um mapa estelar.
Essa forma emite Luz Plena em um raio de 3 metros e
Meia-luz por mais 3 metros. A forma dura 10 minutos
e encerra se você a dispensar (nenhuma ação é necessária), ter a condição Incapacitado ou se você usar essa
característica novamente.
Sempre que você assumir sua forma estrelada, escolha qual das constelações a seguir brilha em seu corpo;
sua escolha concede certos benefícios enquanto estiver
na forma.
Arqueiro. Uma constelação de um arqueiro aparece
em você. Ao ativar e nos turnos subsequentes como
uma Ação Bônus, você pode realizar um ataque mágico
à distância, disparando uma flecha luminosa que atinge
uma criatura a até 18 metros. Em caso de acerto, o
ataque causa 1d8 pontos de dano Radiante + seu modificador de Sabedoria.
Dragão. Uma constelação de um dragão sábio aparece em você. Quando realizar um teste de Inteligência
ou Sabedoria, ou uma salvaguarda de Constituição
para manter a Concentração, você trata um resultado
9 ou menor no d20 como um 10.
Taça. Uma constelação de um cálice vivificante aparece em você. Sempre que você conjurar uma magia,
usando um espaço de que restaure Pontos de Vida em
uma criatura, você ou outra criatura a até 9 metros de
você pode restaurar Pontos de Vida iguais a 1d8 + seu
modificador de Sabedoria.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 3, 'Mapa Estelar', 'Você cria um mapa estelar como parte de seus estudos celestiais. Ele é um objeto Minúsculo, e você pode
usá-lo como Foco de Conjuração para suas magias de
Druida. Você determina sua forma jogando na tabela
Mapa Estelar ou escolhendo uma.
Enquanto estiver segurando o mapa, você tem as magias Orientação e Raio Guia preparadas, e pode conjurar
Raio Guia sem gastar um espaço de magia. Você pode
conjurá-la dessa forma um número de vezes igual ao
seu modificador de Sabedoria (mínimo de uma vez), e
restaura todos os usos gastos ao completar um Descanso Longo.
Se você perder o mapa, pode realizar uma cerimônia
de 1 hora para criar magicamente um substituto. Essa
cerimônia pode ser realizada durante um Descanso
Curto ou Longo e destrói o mapa anterior.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 6, 'Presságio Cósmico', 'Sempre que você completar um Descanso Longo, pode
consultar seu Mapa Estelar em busca de presságios
e jogar um dado. Até completar o próximo Descanso
Longo, você tem acesso a uma Reação especial com
base no número que obteve:
Prosperidade (par). Sempre que uma criatura à
sua vista a até 9 metros de você realizar um Teste de
D20, você pode executar uma Reação para jogar 1d6 e
adicionar o resultado jogado ao total.
Infortúnio (ímpar). Sempre que uma criatura à sua
vista a até 9 metros de você realizar um Teste de D20,
você pode executar uma Reação para jogar 1d6 e subtrair o resultado jogado do total.
Você pode usar essa Reação um número de vezes
igual ao seu modificador de Sabedoria (mínimo de uma
vez) e restaura todos os usos gastos ao completar um
Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 10, 'Constelações Cintilantes', 'As constelações da sua Forma Estrelada melhoram. O
1d8 do Arqueiro e da Taça torna-se 2d8, e enquanto o
Dragão estiver ativo, você adquire um Deslocamento
de Voo de 6 metros e pode pairar.
Além disso, no início de cada um dos seus turnos
enquanto estiver na sua Forma Estrelada, você pode
alterar qual constelação brilha em seu corpo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 14, 'Repleto de Estrelas', 'Enquanto estiver em sua Forma Estrelada, você se
torna parcialmente incorpóreo e tem Resistência a
dano Contundente, Cortante e Perfurante.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'), 3, 'Ira do Mar', 'Como uma Ação Bônus, você pode gastar um uso da
sua Forma Selvagem para manifestar uma Emanação
de 1,5 metro, que toma a forma de respingos de água
do oceano ao seu redor por 10 minutos. Ela se encerra
caso você a disperse (nenhuma ação é necessária), manifeste-a novamente ou tenha a condição Incapacitado.
Ao manifestar a Emanação e como uma Ação Bônus
em seus turnos subsequentes, você pode escolher outra
criatura à sua vista na Emanação. O alvo deve ser bem-
-sucedido em uma salvaguarda de Constituição contra
a sua CD para evitar magia ou sofre dano Gélido e, se
a criatura for Grande ou menor, é empurrada até 4,5
metros para longe de você. Para determinar esse dano,
jogue um número de d6s igual ao seu modificador de
Sabedoria (mínimo de um dado).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'), 3, 'Magias do Círculo do Mar', 'Ao atingir um nível de Druida detalhado na tabela Magias do Círculo do Mar, você tem a as magias da lista
sempre preparadas.
Magias do Círculo do Mar
Nível de Druida Magias de Círculo Druídico
3 Despedaçar, Lufada de Vento, Névoa
Obscurecente, Onda Trovejante, Raio
de Gelo
5 Relâmpago, Respirar na Água
7 Controlar Água, Tempestade Glacial
9 Invocar Elemental, Paralisar Monstro') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'), 6, 'Afinidade Aquática', 'O tamanho da Emanação criada pela sua Ira do Mar
aumenta para 3 metros.
Além disso, você adquire um Deslocamento de Natação igual ao seu Deslocamento.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'), 10, 'Filho da Tempestade', 'Sua Ira do Mar confere dois benefícios adicionais enquanto estiver ativa, conforme detalhado abaixo.
Voo. Você adquire um Deslocamento de Voo igual ao
seu Deslocamento.
Resistência. Você tem Resistência a dano Elétrico,
Gélido e Trovejante.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'), 14, 'Manifestação Oceânica', 'Em vez de manifestar a Emanação da Ira do Mar ao
seu redor, você pode manifestá-la ao redor de uma
criatura voluntária a até 18 metros de você. Essa
criatura adquire todos os benefícios da Emanação,
usando sua CD para evitar magia e seu modificador de
Sabedoria.
Além disso, você pode manifestar a Emanação ao redor de si mesmo e da outra criatura ao gastar dois usos
da sua Forma Selvagem, em vez de um, ao manifestá-la.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'), 3, 'Fala Telepática', 'Você pode estabelecer comunicação telepática com
outras criaturas. Como uma Ação Bônus, escolha
uma criatura que esteja à sua vista e a até 9 metros de
você. Você e a criatura escolhida podem se comunicar
telepaticamente um com o outro enquanto vocês dois
estão a um número de quilômetros um do outro igual
1,5 vezes o seu modificador de Carisma (mínimo de 1,5
quilômetro). Para se entender reciprocamente, cada
um deve usar mentalmente um idioma que o outro
conheça.
A conexão telepática dura um número de minutos
igual ao seu nível de Feiticeiro. Ele encerra mais cedo
se você usar essa habilidade para se conectar com uma
criatura diferente.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'), 3, 'Magias Psiônicas', 'Ao atingir um nível de Feiticeiro detalhado na tabela
Magias Psiônicas, você tem as magias listadas sempre
preparadas.
Magias Psiônicas
Nível de Feiticeiro Magias
3 Acalmar Emoções, Braços de Hadar,
Detectar Pensamentos, Sussurros
Dissonantes, Talho Mental
5 Fome de Hadar, Remeter
7 Invocar Aberração, Tentáculos Negros
de Evard
9 Ligação Telepática de Rary, Telecinese') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'), 6, 'Defesas Psíquicas', 'Você tem Resistência a dano Psíquico e Vantagem
em salvaguardas para evitar ou encerrar as condições
Amedrontado ou Enfeitiçado.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'), 6, 'Feitiçaria Psiônica', 'Ao conjurar qualquer magia de 1º círculo ou superior
com sua característica Magias Psiônicas, você pode
conjurá-la gastando um espaço de magia normal ou
gastando um número de Pontos de Feitiçaria igual
ao círculo da magia. Se você conjurar a magia usando Pontos de Feitiçaria, ela não requer componentes
Verbais ou Somáticos e não requer componentes
Materiais, a menos que sejam consumidos pela magia
ou tenham um custo detalhado nela.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'), 14, 'Revelação em Carne', 'Você pode revelar a verdade oculta dentro de você.
Como uma Ação Bônus, você pode gastar 1 Ponto de
Feitiçaria ou mais para alterar magicamente seu corpo
por 10 minutos. Para cada Ponto de Feitiçaria gasto,
você adquire um dos seguintes benefícios à sua escolha, cujos efeitos duram até que a alteração termine.
Adaptação Aquática. Você adquire Deslocamento de
Natação igual ao dobro do seu Deslocamento e pode
respirar debaixo d’água. Guelras crescem do seu pescoço ou se alargam atrás das orelhas e seus dedos ficam
palmados ou você desenvolve cílios contorcidos.
Movimento Vermiforme. Seu corpo, com qualquer
equipamento que você esteja usando ou carregando,
se torna viscoso e flexível. Você pode se mover por
qualquer espaço tão estreito quanto 2,5 centímetros e
pode gastar 1,5 metro de movimento para escapar de
restrições não mágicas ou da condição Imobilizado.
Ver o Invisível. Você pode ver qualquer criatura
Invisível a até 18 metros de você que não esteja atrás
de Cobertura Total. Seus olhos também se tornam
negros ou se transformam em filamentos sensoriais
contorcidos.
Voo Reluzente. Você adquire um Deslocamento de
Voo igual ao seu Deslocamento e pode pairar. Durante
o voo, sua pele brilha com muco ou luz sobrenatural.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'), 18, 'Implosão de Distorção', 'Você pode liberar uma anomalia de deformação espacial. Como uma ação Usar Magia, você se teleporta
para um espaço desocupado à sua vista a até 36 metros
de distância de si. Imediatamente após desaparecer,
cada criatura a até 9 metros do espaço abandonado
deve realizar uma salvaguarda de Força contra a CD
para evitar sua magia. Se falhar, a criatura sofre 3d10
pontos de dano Energético e é puxada para o espaço
que você deixou, terminando no espaço desocupado
mais próximo. Em caso de sucesso, a criatura sofre
apenas metade do dano.
Você pode usar esta característica novamente após
completar um Descanso Longo ou gastando 5 Pontos
de Feitiçaria (nenhuma ação é necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'), 3, 'Magias Dracônicas', 'Ao atingir um nível de Feiticeiro detalhado na tabela
Magias Dracônicas, você tem as magias listadas sempre
preparadas.
Magias Dracônicas
Nível de Feiticeiro Magias
3 Alterar-se, Comando, Orbe Cromático,
Sopro de Dragão
5 Medo, Voo
7 Enfeitiçar Monstro, Olho Arcano
9 Invocar Dragão, Lendas e Histórias') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'), 3, 'Resiliência Dracônica', 'A magia em seu corpo manifesta traços físicos da bênção dracônica. Seus Pontos de Vida máximos aumentam em 3, e aumentam em 1 sempre que você atinge
outro nível de Feiticeiro.
Partes da sua pele são cobertas por finas escamas reluzentes, semelhantes às de um dragão. Enquanto não
estiver vestindo armadura, sua Classe de Armadura
base é igual a 10 mais seus modificadores de Destreza
e Carisma.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'), 6, 'Afinidade Elemental', 'Sua magia dracônica tem relação com um tipo de dano
associado a dragões. Escolha um desses tipos: Ácido,
Elétrico, Gélido, Ígneo ou Venenoso.
Você tem Resistência a esse tipo de dano e ao conjurar uma magia que cause dano do tipo associado com a
sua ancestralidade dracônica, pode adicionar seu modificador de Carisma a uma jogada de dano dessa magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'), 14, 'Asas de Dragão', 'Como uma Ação Bônus, você pode fazer com que asas
dracônicas apareçam em suas costas. As asas duram 1
hora ou até você encerrar este efeito (nenhuma ação é
necessária). Pela duração, você tem um Deslocamento
de Voo de 18 metros.
Você pode usar esta característica novamente após
completar um Descanso Longo ou gastando 3 Pontos
de Feitiçaria (nenhuma ação é necessária) para restaurar seu uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'), 18, 'Companheiro Dracônico', 'Você pode conjurar Invocar Dragão sem um componente Material. Além disso, pode conjurá-la uma vez sem
gastar um espaço de magia, recuperando a capacidade
de conjurá-la deste modo ao completar um Descanso
Longo.
Ao começar a conjurar a magia, você pode modificá-
-la para não exigir Concentração e a duração da magia
se torna 1 minuto para esta conjuração.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'), 3, 'Magias Mecânicas', 'Ao atingir um nível de Feiticeiro detalhado na tabela
Magias Mecânicas, você tem as magias listadas sempre
preparadas.
Magias Mecânicas
Nível de Feiticeiro Magias
3 Alarme, Auxílio, Proteção Contra o Bem e o
Mal, Restauração Menor
5 Dissipar Magia, Proteção contra Energia
7 Invocar Constructo, Movimentação Livre
9 Muralha de Energia, Restauração Maior
Além disso, consulte a tabela Manifestações da Ordem
e escolha ou determine aleatoriamente a maneira como
sua conexão com a ordem se manifesta enquanto você
conjura suas magias de Feiticeiro.
Manifestações da Ordem
1d6 Manifestação
1 Engrenagens espectrais pairam atrás de você.
2 Os ponteiros de um relógio giram em seus olhos.
3 Sua pele brilha com um reflexo acobreado.
4 Equações flutuantes e objetos geométricos se
sobrepõem ao seu corpo.
5 Seu Foco de Conjuração assume temporariamente a
forma de um mecanismo de relógio Minúsculo.
6 O tique-taque das engrenagens ou o toque de um
relógio podem ser ouvidos por você e por aqueles
afetados por sua magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'), 3, 'Restaurar Equilíbrio', 'Sua conexão com o plano de ordem absoluta permite
equalizar momentos caóticos. Quando uma criatura
à sua vista a até 18 metros de você estiver prestes a
jogar um d20 com Vantagem ou Desvantagem, você
pode executar uma Reação para evitar que o teste seja
afetado por Vantagem e Desvantagem.
Você pode usar essa característica um número de
vezes igual ao seu modificador de Carisma (mínimo de
uma vez) e restaura todos os usos gastos ao completar
um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'), 6, 'Bastião da Lei', 'Você pode acessar a grande equação da existência para
imbuir uma criatura com um escudo cintilante de ordem. Como uma ação Usar Magia, você pode gastar de
1 a 5 Pontos de Feitiçaria para criar uma proteção mágica ao seu redor ou de outra criatura à sua vista a até
9 metros de você. A proteção é representada por um
número de d8s igual ao número de Pontos de Feitiçaria
gastos para criá-la. Quando a criatura protegida sofre
dano, ela pode gastar um número desses dados, jogá-los
e reduzir o dano sofrido pelo resultado desses dados.
A proteção dura até você completar um Descanso
Longo ou até usar esta característica novamente.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'), 14, 'Transe da Ordem', 'Você adquire a capacidade de alinhar sua consciência
com os infinitos cálculos de Mecânos. Como uma Ação
Bônus, você pode entrar neste estado por 1 minuto.
Pela duração, as jogadas de ataque contra você não
podem se beneficiar de Vantagem e sempre que você
realizar um Teste de D20, você pode tratar um resultado de 9 ou menor no d20 como um 10.
Você pode usar esta característica novamente após
completar um Descanso Longo ou gastando 5 Pontos
de Feitiçaria (nenhuma ação é necessária) para restaurar seu uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'), 18, 'Cavalgada Mecânica', 'Você invoca momentaneamente espíritos de ordem
para eliminar a desordem ao seu redor. Como uma
ação Usar Magia, você convoca os espíritos em um
Cubo de 9 metros de lado originado em você. Os espíritos se parecem com modrons ou outros Construtos à
sua escolha. Os espíritos são intangíveis e invulneráveis
e criam os efeitos a seguir no Cubo antes de desaparecerem. Você pode executar esta ação novamente após
completar um Descanso Longo ou gastando 7 Pontos
de Feitiçaria (nenhuma ação é necessária) para restaurar seu uso.
Cura. Os espíritos restauram até 100 Pontos de Vida,
divididos conforme você escolher entre qualquer número de criaturas à sua escolha no Cubo.
Dissipar. Cada magia de 6º círculo ou inferior encerra em criaturas e objetos à sua escolha no Cubo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'), 3, 'Marés do Caos', 'Você pode manipular o caos para garantir Vantagem em um Teste de D20 à sua escolha antes de
jogá-lo. Após utilizar esta característica, você deve
conjurar uma magia de Feiticeiro com um espaço
de magia ou concluir um Descanso Longo para
recuperá-la.
Além disso, ao conjurar uma magia de Feiticeiro
utilizando um espaço de magia antes de concluir um
Descanso Longo, ocorre automaticamente um Surto
de Magia Selvagem, e sua capacidade de usar esta
característica é recarregada.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'), 3, 'Surto de Magia Selvagem', 'Sua conjuração pode desencadear surtos de magia
incontrolável. Uma vez por turno, você pode jogar
1d20 imediatamente após conjurar uma magia de Feiticeiro com um espaço de magia. Se o resultado for
20, jogue na tabela Surto de Magia Selvagem para
criar um efeito mágico.
Se o efeito mágico for uma magia, ele é selvagem
demais para ser afetado por sua Metamagia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'), 6, 'Distorcer a Sorte', 'Você consegue distorcer o destino usando sua magia
selvagem. Imediatamente após outra criatura à sua
vista jogar o d20 para um Teste de D20, você pode
executar uma Reação e gastar 1 Ponto de Feitiçaria
para jogar 1d4 e aplicar o resultado jogado como
bônus ou penalidade (à sua escolha) no teste de
d20.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'), 14, 'Caos Controlado', 'Você adquire um pequeno controle sobre seus surtos de magia selvagem. Ao jogar na tabela Surto de
Magia Selvagem, você pode jogar duas vezes e usar
qualquer um dos resultados.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'), 18, 'Surto Controlado', 'Imediatamente após conjurar uma magia Feiticeiro
com um espaço de magia, você pode criar um efeito à
sua escolha da tabela Surto de Magia Selvagem em vez
de jogar na tabela. Você pode escolher qualquer efeito
na tabela, exceto a linha final e se o efeito escolhido
envolver uma jogada, você deve realizá-la.
Você pode usar esta característica novamente após
completar um Descanso Longo.
Surto de Magia Selvagem
1d100 Efeito
01-04 Jogue nesta tabela no início de cada um dos seus
turnos pelo próximo minuto, ignorando este
resultado nas jogadas subsequentes.
05-08 Uma criatura Amigável aparece em um espaço
desocupado aleatório a até 18 metros de você. A
criatura está sob o controle do Mestre e desaparece
depois de 1 minuto. Jogue 1d4 para determinar a
criatura: em um 1, aparece um Modron Duodrone;
em um 2, aparece um Flunf; em um 3, aparece
um Modron Monodrone; em um 4, aparece um
Unicórnio. Veja o Livro dos Monstros para o bloco de
estatísticas da criatura.
09-12 Pelo próximo minuto, você recupera 5 Pontos de Vida
no início de cada um dos seus turnos.
13-16 Criaturas têm Desvantagem em salvaguardas contra
a próxima magia que você conjurar no minuto
seguinte, que envolva uma salvaguarda.
17-20 Você está sujeito a um efeito que dura 1 minuto, a
menos que a descrição diga o contrário. Jogue 1d8
para determinar o efeito: em um 1, você é cercado
por uma música fraca e etérea que apenas você e
criaturas a até 1,5 metro de você podem ouvir; em
um 2, seu tamanho aumenta em uma categoria
de tamanho; em um 3, cresce em você uma longa
barba de plumas que permanecem até você espirrar,
momento em que as plumas explodem do seu rosto
e desaparecem; em um 4, você deve gritar quando
fala; em um 5, borboletas ilusórias tremulam no ar
a até 3 metros de você; em um 6, um olho aparece
em sua testa, concedendo-lhe Vantagem em testes
de Sabedoria (Percepção); em um 7, bolhas rosas
flutuam da sua boca sempre que você fala; em um
8, sua pele adquire um tom vibrante de azul por 24
horas ou até que o efeito seja encerrado por uma
magia Remover Maldição.
21-24 Pelo próximo minuto, todas as suas magias com um
tempo de conjuração de uma ação têm um tempo de
conjuração de uma Ação Bônus.
1d100 Efeito
25-28 Você é transportado para o Plano Astral até o final
do seu próximo turno. Em seguida, você retorna ao
espaço que ocupava anteriormente ou ao espaço
desocupado mais próximo, se esse espaço estiver
ocupado.
29-32 Na próxima vez que você conjurar uma magia que
cause dano no minuto seguinte, não jogue os dados
de dano da magia para o dano. Em vez disso, use o
número mais alto possível para cada dado de dano.
33-36 Você tem Resistência a todos os tipos de dano pelo
próximo minuto.
37-40 Você se transforma em um vaso de plantas até
o início do seu próximo turno. Enquanto é uma
planta, você tem a condição Incapacitado e tem
Vulnerabilidade a todos os tipos de dano. Se você
atingir 0 Pontos de Vida, o seu vaso quebra e você
reverte à sua forma original.
41-44 Pelo próximo minuto, você pode se teleportar a até 6
metros como uma Ação Bônus em cada um dos seus
turnos.
45-48 Você e até três criaturas à sua escolha a até 9 metros
de você têm a condição Invisível por 1 minuto.
Essa invisibilidade se encerra em uma criatura
imediatamente após ela realizar uma jogada de
ataque, causar dano ou conjurar uma magia.
49-52 Um escudo espectral paira perto de você pelo
próximo minuto, concedendo um bônus de +2 na CA
e imunidade a Mísseis Mágicos.
53-56 Você pode executar uma ação adicional neste turno.
57-60 Você conjura uma magia aleatória. Se a magia
normalmente requer Concentração, ela não requer
Concentração neste caso; a magia se mantém pela
duração total. Jogue 1d10 para determinar a magia:
em um 1, Confusão; em um 2, Bola de Fogo; em um
3, Névoa Obscurecente; em um 4, Voo (conjurado
em uma criatura aleatória a até 18 metros de você);
em um 5, Graxa; em um 6, Levitação (conjurado em
si); em um 7, Mísseis Mágicos (conjurado como uma
magia de 5º círculo); em um 8, Reflexos; em um 9,
Polimorfia (conjurado em si), e se você falhar na
salvaguarda, você se transforma em uma Cabra (veja
o apêndice B); em um 10, Ver o Invisível.
61-64 Pelo próximo minuto, qualquer objeto inflamável e
não mágico que você toque que não esteja sendo
usado ou carregado por outra criatura irrompe em
chamas, sofre 1d4 pontos de dano Ígneo e está em
combustão.
1d100 Efeito
65-68 Se você morrer na próxima hora, você imediatamente
revive como se estivesse usando a magia Reencarnar.
69-72 Você tem a condição Amedrontado até o final do
seu próximo turno. O Mestre determina a fonte do
seu medo.
73-76 Você se teleporta até 18 metros para um espaço
desocupado à sua vista.
77-80 Uma criatura aleatória a até 18 metros de você tem a
condição Envenenado por 1d4 horas.
81-84 Você irradia Luz Plena em um raio de 9 metros pelo
próximo minuto. Qualquer criatura que termine o
turno a até 1,5 metro de você tem a condição Cego
até o final do próximo turno dela.
85-88 Até três criaturas à sua escolha, à sua vista e a até
9 metros de você, sofrem 1d10 pontos de dano
Necrótico. Você recupera Pontos de Vida iguais à
soma do dano Necrótico causado.
1d100 Efeito
89-92 Até três criaturas à sua escolha, à sua vista e a até
9 metros de você, sofrem 4d10 pontos de dano
Elétrico.
93-96 Você e todas as criaturas a até 9 metros de você têm
Vulnerabilidade a Dano Perfurante pelo próximo
minuto.
97-00 Jogue 1d6. Em um 1, você recupera 2d10 Pontos
de Vida; em um 2, um aliado à sua escolha a até 90
metros de você recupera 2d10 Pontos de Vida; em
um 3, você recupera seu espaço de magia gasto de
menor círculo; em um 4, um aliado à sua escolha a
até 90 metros de você recupera o espaço de magia
gasto de menor círculo; em um 5, você restaura todos
os seus Pontos de Feitiçaria gastos; em um 6, todos
os efeitos da linha 17–20 o afetam simultaneamente.
A Feiticeira Delina
manipula magia selvagem
para criar maravilhas
imprevisíveis.

i | " S = & SN A ” a) A |
r TR ir à, » À =e - o É "e ° FEI E & |
” ix à Mar T" he, - Wo ”» lp e! O
a - nie. “wy re pt b 4 ly. = "SA no. 4
La = OST | i . DO à e (A A
no a. = "|B Taree. NR
Vi c \ 4 À VW" p=
2’ | "RS O Y 7d ) '' W X a
D ASS
PÁ p= E E 15 1 Ss | (
ae FE * 7. \ abt
PF ii A - Es E + * / X q 2 > 7 /
À y x NE E. De % WN é " Vá
% S ” fe : — É À
a. o e | Sy 4
| 2 Pp 0
"Lue on
3 » ” |
AA
orl 1
À foe
#4 GUARDIAO
À OO
Um Combatente Errante Imbuído de Magia Primitiva Í A
-') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'), 3, 'Glamour Transcendental', 'Sempre que você realiza um teste de Carisma, recebe
um bônus no teste igual ao seu modificador de Sabedoria (mínimo de +1).
Você também adquire proficiência em uma dessas perícias à sua escolha: Atuação, Enganação ou
Persuasão.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'), 3, 'Golpes Terríveis', 'Você pode potencializar seus golpes com arma com
a magia traumatizante tirada dos cantos sombrios de
Faéria. Uma vez por turno, ao atingir uma criatura com
uma arma, você pode causar 1d4 pontos de dano Psíquico adicional ao alvo. O dano adicional aumenta para
1d6 quando você atinge o nível 11 de Guardião.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'), 3, 'Magias do Andarilho Feérico', 'Ao atingir um nível de Guardião detalhado na tabela
Magias do Andarilho Feérico, você tem a lista de magias sempre preparadas.
Magias do Andarilho Feérico
Nível de Guardião Magias
3 Enfeitiçar Pessoa
5 Passo Nebuloso
9 Convocar Feérico
13 Porta Dimensional
17 Despistar
Você também possui uma bênção feérica. Escolha-a
na tabela de Dádivas de Faéria ou determine-a
aleatoriamente.
Dádivas de Faéria
1d6 Dádiva
1 Borboletas ilusórias flutuam ao seu redor enquanto
você realiza um Descanso Curto ou Longo.
2 Flores desabrocham do seu cabelo a cada amanhecer.
3 Você cheira levemente a canela, lavanda, noz-moscada
ou outra erva ou fragrância natural.
4 Sua sombra dança enquanto ninguém está olhando
diretamente para ela.
5 Chifres ou galhadas brotam da sua cabeça.
6 Sua pele e cabelo mudam de cor a cada amanhecer.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'), 7, 'Detalhe Sedutor', 'A magia de Faéria protege sua mente. Você tem
Vantagem nas salvaguardas para evitar ou encerrar a
condição Amedrontado ou Enfeitiçado.
Além disso, sempre que você ou uma criatura à sua
vista a até 36 metros de você for bem-sucedido em
uma salvaguarda para evitar ou encerrar a condição
Amedrontado ou Enfeitiçado, você pode executar uma
Reação para forçar uma criatura diferente à sua vista
a até 36 metros de você realizar uma salvaguarda de
Sabedoria contra a CD para evitar sua magia. Se falhar,
o alvo tem a condição Amedrontado ou Enfeitiçado (à
sua escolha) por 1 minuto. O alvo repete a salvaguarda no final de cada um dos turnos dele, encerrando o
efeito em si em caso de sucesso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'), 11, 'Reforços Feéricos', 'Você pode conjurar a magia Convocar Feérico sem um
componente Material. Você também pode conjurá-la
uma vez sem um espaço de magia, e restaura a capacidade de conjurá-la deste modo ao completar um
Descanso Longo.
Ao começar a conjurar a magia, você pode modificá-
-la para não exigir Concentração e a duração da magia
se torna 1 minuto para esta conjuração.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'), 15, 'Andarilho Nebuloso', 'Você pode conjurar Passo Nebuloso sem gastar um espaço de magia. Você pode fazer isso um número de vezes
igual ao seu modificador de Sabedoria (mínimo de uma
vez) e restaura todos os usos gastos ao completar um
Descanso Longo.
Além disso, sempre que você conjurar Passo Nebuloso,
pode levar junto uma criatura voluntária à sua vista a
até 1,5 metro de você. Essa criatura se teleporta para
um espaço desocupado à sua escolha a até 1,5 metro do
seu destino.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'), 3, 'Conhecimento do Caçador', 'Você pode recorrer às forças da natureza para revelar
certos pontos fortes e fracos de sua presa. Enquanto
uma criatura está marcada pela Marca do Predador,
você sabe se essa criatura tem Imunidades, Resistências ou Vulnerabilidades, e se a criatura tiver
alguma, você sabe quais são.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'), 3, 'Presa do Caçador', 'Você recebe uma das seguintes opções de
características à sua escolha. Ao completar um
Descanso Curto ou Longo, você pode substituir a opção escolhida pela outra.
Assassino de Colossos. Sua tenacidade pode
derrubar até mesmo os inimigos mais poderosos. Ao atingir com arma uma criatura com
os Pontos de Vida menor que o máximo, você
causa 1d8 pontos de dano adicional. Você pode
causar esse dano adicional apenas uma vez por
turno.
Destruidor de Hordas. Uma vez em cada um dos
seus turnos, ao realizar um ataque com uma arma,
você pode realizar outro ataque com a mesma arma
contra uma criatura diferente que está a 1,5 metro
do alvo original, que está dentro do alcance da arma e
que você não atacou neste turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'), 7, 'Táticas Defensivas', 'Você recebe uma das seguintes opções de características à sua escolha. Ao completar um Descanso
Curto ou Longo, você pode substituir a opção
escolhida pela outra.
Defesa Contra Ataques Múltiplos. Ao ser atingido por
uma criatura com uma jogada de ataque, essa criatura
tem Desvantagem em todas as outras jogadas de ataque contra você neste turno.
Escapar de Hordas. Ataques de Oportunidade têm
Desvantagem contra você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'), 11, 'Presa do Caçador Superior', 'Uma vez por turno, ao causar dano a uma criatura
marcada pela Marca do Predador, você também
pode causar dano adicional dessa magia a uma
criatura diferente à sua vista e a até 9 metros da
primeira criatura.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'), 15, 'Defesa do Caçador', 'Superior
Ao sofrer dano, você pode executar uma Reação
para conceder a si mesmo Resistência a esse dano e
a qualquer outro dano do mesmo tipo até o final do
turno atual.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'), 3, 'Companheiro Primal', 'Você invoca magicamente uma fera primal, que extrai
força de seu vínculo com a natureza. Escolha o bloco
de estatísticas da fera: Fera da Terra, Fera do Céu
ou Fera do Mar. Você também determina o tipo de
animal, escolhendo um tipo apropriado para o bloco
de estatísticas. Seja qual for a fera que você escolher,
ela apresenta sinais primais que indicam a origem
sobrenatural dela.
A fera é Amigável a você e seus aliados e obedece
aos seus comandos. Ela desaparece se você morrer.
A Fera em Combate. Em combate, a fera age durante seu turno. Ela pode se mover e usar a própria
Reação, embora a única ação padrão que ela execute
seja Esquivar, a menos que você use uma Ação Bônus
para comandá-la a executar uma ação do bloco de
estatísticas dela ou alguma outra ação.
Você também pode sacrificar um ataque ao
executar a ação Atacar para ordenar a fera a realizar
a ação Golpe da Fera. Se você tem a condição
Incapacitado, a fera age sozinha e não se restringe à
ação Esquivar.
Restaurar ou Substituir a Fera. Se a fera
morreu na última hora, você pode executar uma
ação Usar Magia para tocá-la e gastar um espaço
de magia. A fera retorna à vida após 1 minuto
com todos os Pontos de Vida restaurados.
Sempre que completar um Descanso Longo, você
pode invocar uma Fera primal diferente, que aparece
em um espaço desocupado a até 1,5 metro de você.
Você escolhe o bloco de estatísticas e aparência dela.
Se você já tem uma fera devido a esta característica, a
antiga desaparece quando a nova surge.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'), 7, 'Treinamento Excepcional', 'Ao executar uma Ação Bônus para ordenar sua fera
Companheira Primal, você também pode ordená-la
executar a ação Ajudar, Correr, Desengajar ou Esquivar
usando a Ação Bônus dela.
Além disso, sempre que a fera acertar com uma jogada
de ataque e causar dano, ela pode causar dano Energético ou o tipo de dano normal dela, à sua escolha.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'), 11, 'Fúria Bestial', 'Ao ordenar sua fera Companheira Primal a executar a
ação Golpe da Fera, ela pode usá-la duas vezes.
Além disso, na primeira vez em cada turno que ela
atinge uma criatura sob o efeito da magia Marca do
Predador, a fera causa dano Energético adicional igual
ao dano bônus dessa magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'), 15, 'Compartilhar Magias', 'Ao conjurar uma magia em si, você também pode afetar
sua fera Companheira Primal com a magia se a Fera
estiver a até 9 metros de você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'), 3, 'Emboscador das Sombras', 'Você dominou a arte de criar emboscadas temíveis,
concedendo-lhe os seguintes benefícios.
Bônus de Iniciativa. Ao jogar Iniciativa, pode adicionar
seu modificador de Sabedoria à jogada.
Golpe Terrível. Ao atacar e atingir uma criatura
com uma arma, você pode causar 2d6 pontos de dano
Psíquico adicional. Você pode usar este benefício uma
vez por turno e um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez) e restaura
todos os usos gastos ao completar um Descanso Longo.
Impulso do Emboscador. No início do seu primeiro
turno de cada combate, seu Deslocamento aumenta em
3 metros até o final deste turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'), 3, 'Magias do Vigilante das Sombras', 'Ao atingir um nível de Guardião detalhado na tabela
Magias do Vigilante das Sombras, você tem a lista de
magias sempre preparadas.
Magias do Vigilante das Sombras
Nível de Guardião Magias
3 Disfarçar-se
5 Corda Extradimensional
9 Medo
13 Invisibilidade Maior
17 Similaridade') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'), 3, 'Visão Umbrosa', 'Você adquire Visão no Escuro com um alcance de
18 metros. Se você já tem Visão no Escuro, o alcance
aumenta em 18 metros.
Você também se torna capaz de escapar de criaturas
que utilizem Visão no Escuro. Enquanto estiver inteiramente na Escuridão, você tem a condição Invisível
para qualquer criatura que dependa da Visão no Escuro
para vê-lo nessa Escuridão.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'), 7, 'Mente de Ferro', 'Você desenvolveu a capacidade de resistir a poderes
que alteram a mente. Você adquire proficiência em
salvaguardas de Sabedoria. Se você já tem essa proficiência, adquire proficiência em salvaguardas de Carisma
ou Inteligência (à sua escolha).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'), 11, 'Torrente do Vigilante', 'O dano psíquico do seu Golpe Terrível se torna 2d8.
Além disso, ao usar o efeito Golpe Terrível da sua
característica Emboscador das Sombras, você pode
causar um dos seguintes efeitos adicionais.
Golpe Repentino. Você pode realizar outro ataque
com a mesma arma contra uma criatura diferente que
esteja a até 1,5 metro do alvo original e que esteja dentro do alcance da arma.
Medo em Massa. O alvo e cada criatura a até 3
metros dele deve realizar uma salvaguarda de Sabedoria
contra a CD para evitar sua magia. Ao falhar, uma
criatura tem a condição Amedrontado até o início do
seu próximo turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'), 15, 'Esquiva Sombria', 'Quando uma criatura realiza uma jogada de ataque
contra você, você pode executar uma Reação para
impor Desvantagem nessa jogada. Se o ataque acertar
ou errar, você pode se teleportar até 9 metros para um
espaço desocupado à sua vista.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'), 3, 'Atleta Extraordinário', 'Graças ao seu atletismo, você tem Vantagem em jogadas de Iniciativa e testes de Força (Atletismo).
Além disso, imediatamente após obter um Acerto
Crítico, você pode se mover até metade do seu Deslocamento sem provocar Ataques de Oportunidade.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'), 3, 'Crítico Aprimorado', 'Suas jogadas de ataque com armas e Ataques Desarmados obtém Acerto Crítico em jogadas com resultados
19 ou 20 no d20.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'), 7, 'Estilo de Luta Adicional', 'Você adquire outro talento de Estilo de Luta à sua
escolha.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'), 10, 'Combatente Heroico', 'A emoção da batalha leva você à vitória. Durante o
combate, você pode se conceder Inspiração Heroica
sempre que começar seu turno sem ela.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'), 15, 'Crítico Superior', 'Suas jogadas de ataque com armas e Ataques Desarmados agora obtém Acerto Crítico em jogadas com
resultados 18 a 20 no d20.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'), 18, 'Sobrevivente', 'Você atinge o auge da resiliência em batalha, concedendo-lhe os seguintes benefícios.
Desafie a Morte. Você tem Vantagem em Salvaguardas Contra Morte. Além disso, ao obter um 18–20 em
uma Salvaguarda Contra Morte, você obtém um 20
como resultado.
Regeneração Heroica. No início de cada um dos seus
turnos, você recupera Pontos de Vida iguais a 5 mais
seu modificador de Constituição se estiver Sangrando
e ter ao menos 1 Ponto de Vida.
Um Guerreiro fica entre
um aliado e o ataque de um
dragão negro.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'), 3, 'Conjuração', 'Você aprendeu a conjurar magias. Veja o capítulo 7
para as regras sobre conjuração de magias. As informações abaixo detalham como você usa essas regras como
um Cavaleiro Místico.
Truques. Você conhece dois truques à sua escolha da
lista de magias de Mago (veja a seção desta classe para
a lista de magias). Raio de Gelo e Toque Chocante são
recomendados. Sempre que você atinge um nível de
Guerreiro, pode substituir um desses truques por outro
truque à sua escolha da lista de magias de Mago.
Ao atingir o nível 10 de Guerreiro, você aprende mais
um truque de Mago à sua escolha.
Espaços de Magia. A tabela Conjuração de Cavaleiro
Místico apresenta quantos espaços de magia você tem
para conjurar suas magias de 1º círculo ou superior.
Você restaura todos os espaços gastos ao completar
um Descanso Longo.
Conjuração de Cavaleiro Místico
Nível de
Guerreiro
Magias
Preparadas
Espaços de Magia por Círculo de Magia
1 2 3 4
3 3 2 — — —
4 4 3 — — —
5 4 3 — — —
6 4 3 — — —
7 5 4 2 — —
8 6 4 2 — —
9 6 4 2 — —
10 7 4 3 — —
11 8 4 3 — —
12 8 4 3 — —
13 9 4 3 2 —
14 10 4 3 2 —
15 10 4 3 2 —
16 11 4 3 3 —
17 11 4 3 3 —
18 11 4 3 3 —
19 12 4 3 3 1
20 13 4 3 3 1
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior
que estão disponíveis para você ao conjurar com essa
característica. Para começar, escolha três magias de') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'), 3, 'Vínculo com Arma', 'Você aprende um ritual que cria um vínculo mágico
entre você e uma arma. Você realiza o ritual ao longo
de 1 hora, o que pode ser concluído durante um Descanso Curto. A arma deve estar ao seu alcance durante
todo o ritual e, ao concluí-lo, você toca a arma e estabelece o vínculo. O vínculo falha se outro Guerreiro
estiver ligado à arma ou se a arma for um item mágico
com o qual outra pessoa está sintonizada.
Após ter vinculado uma arma a si, ela não pode ser
desarmada de você, a menos que você tenha a condição
Incapacitado. Se ela estiver no mesmo plano de existência, você pode invocar essa arma como uma Ação
Bônus, teleportando-a instantaneamente para sua mão.
Você pode ter até dois vínculos com armas, mas pode
invocar apenas uma de cada vez com uma Ação Bônus.
Se você tentar se vincular com uma terceira arma, você
deve quebrar o vínculo com uma das outras duas.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'), 7, 'Magia de Guerra', 'Ao executar a ação Atacar no seu turno, você pode
substituir um dos ataques por uma conjuração de um
de seus truques de Mago que tenha um tempo de conjuração de uma ação.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'), 10, 'Golpe Místico', 'Você aprende a usar seus ataques com armas para reduzir a resistência de uma criatura às suas magias. Ao
atingir uma criatura com um ataque usando uma arma,
essa criatura sofre Desvantagem na próxima salvaguarda que realizar contra uma magia que você conjurar
antes do final do seu próximo turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'), 15, 'Investida Mística', 'Ao usar seu Surto de Ação, você pode se teleportar até
9 metros para um espaço desocupado à sua vista. Você
pode se teleportar antes ou depois da ação adicional.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'), 18, 'Magia de Guerra Aprimorada', 'Ao executar a ação Atacar no seu turno, você pode
substituir dois ataques pela conjuração de uma das
suas magias de Mago de 1º ou 2º círculo que tenha um
tempo de conjuração de uma ação.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 3, 'Poder Psiônico', 'Você possui uma fonte de energia psiônica, representada pelos seus Dados de Energia Psiônica, que alimenta
os poderes desta subclasse. A tabela Dados de Energia
do Combatente Psíquico indica o tipo e a quantidade
desses dados conforme você atinge certos níveis de
Guerreiro.
Dados de Energia do Combatente Psíquico
Nível de Guerreiro Tipo de Dado Quantidade
3 D6 4
5 D8 6
9 D8 8
11 D10 8
13 D10 10
17 D12 12
Qualquer característica desta subclasse que utilize
um Dado de Energia Psiônica emprega apenas os
dados dessa subclasse. Alguns poderes consomem esse
Dado, conforme detalhado na respectiva descrição, e
você não pode usar um poder se ele exigir um dado
e todos os seus Dados de Energia Psiônica estiverem
esgotados.
Você recupera um de seus Dados de Energia Psiônica
gastos ao completar um Descanso Curto, e restaura
todos ao completar um Descanso Longo.
Golpe Psiônico. Você pode impulsionar suas armas
com força psiônica. Uma vez em cada um dos seus turnos, imediatamente após atingir um alvo a até 9 metros
de você com um ataque e causar dano a ele com uma
arma, você pode gastar um Dado de Energia Psiônica,
jogá-lo e causar dano Energético ao alvo igual ao resultado obtido mais seu modificador de Inteligência.
Movimento Telecinético. Você pode mover um objeto
ou uma criatura com sua mente. Como uma ação Usar
Magia, escolha um alvo à sua vista a até 9 metros de
você; o alvo deve ser um objeto solto que seja Grande
ou menor, ou uma criatura voluntária que não seja') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 7, 'Adepto Telecinético', 'Você dominou novas maneiras de usar suas habilidades
telecinéticas, detalhadas abaixo.
Estocada Telecinética. Ao causar dano a um alvo com
seu Golpe Psiônico, você pode forçá-lo a realizar uma
salvaguarda de Força (CD 8 mais seu modificador de
Inteligência e seu Bônus de Proficiência). Se falhar,
você pode impor ao alvo a condição Caído ou transportá-lo horizontalmente até 3 metros.
Salto com Impulsão Psíquica. Como uma Ação Bônus,
você adquire um Deslocamento de Voo igual ao dobro
do seu Deslocamento até o final do turno atual. Após
executar essa Ação Bônus, você não pode fazer isso
novamente até completar um Descanso Curto ou Longo, a menos que gaste um Dado de Energia Psiônica
(nenhuma ação é necessária) para recuperar o uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 10, 'Resguardo Mental', 'Você tem Resistência a Dano Psíquico. Além disso,
ao iniciar seu turno com a condição Amedrontado ou
Enfeitiçado, você pode gastar um Dado de Energia
Psiônica (nenhuma ação é necessária) e encerrar todos
os efeitos em você que lhe impõe essas condições.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 15, 'Baluarte de Energia', 'Você pode proteger a si e aos outros com força telecinética. Como uma Ação Bônus, você pode escolher
criaturas, incluindo você mesmo, a até 9 metros, até
um número de criaturas igual ao seu modificador de
Inteligência (mínimo de uma criatura). Cada uma das
criaturas escolhidas tem Cobertura Parcial por 1 minuto ou até você ter a condição Incapacitado.
Após usar essa característica, você não pode fazer
isso novamente até completar um Descanso Longo, a
menos que gaste um Dado de Energia Psiônica (nenhuma ação é necessária) para recuperar seu uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 18, 'Mestre Telecinético', 'Você sempre tem a magia Telecinese preparada. Com
esta característica, você pode conjurá-la sem um espaço de magia ou componentes, e seu atributo de conjuração para ela é a Inteligência. Em cada um dos seus
turnos enquanto você mantém a Concentração nela,
incluindo o turno quando a conjura, você pode realizar
um ataque com arma como uma Ação Bônus.
Após conjurar a magia por meio dessa característica,
você não pode fazer isso deste modo até completar
um Descanso Longo, a menos que gaste um Dado de
Energia Psiônica (nenhuma ação é necessária) para
recuperar o uso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 3, 'Estudioso da Guerra', 'Você adquire proficiência com um tipo de Ferramentas de Artesão à sua escolha e adquire proficiência em
uma perícia à sua escolha das perícias disponíveis para
Guerreiros no nível 1.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 3, 'Superioridade em Combate', 'Sua experiência em combate aprimorou suas técnicas de luta, permitindo que você aprenda manobras
com base em dados especiais chamados Dados de
Superioridade.
Manobras. Você aprende três manobras à sua escolha
na seção “Opções de Manobras” mais adiante na descrição desta subclasse. Muitas manobras aprimoram,
de alguma forma, um ataque. Você pode usar apenas
uma manobra por ataque.
Você aprende duas manobras adicionais à sua escolha quando atinge os níveis 7, 10 e 15 de Guerreiro.
Cada vez que aprende novas manobras, você também
pode substituir uma manobra que você conhece por
uma diferente.
Dados de Superioridade. Você tem quatro Dados de
Superioridade, os quais são d8s. Um Dado de Superioridade é gasto ao usá-lo. Você restaura todos os Dados
de Superioridade gastos quando completa um Descanso Curto ou Longo.
Você adquire um Dado de Superioridade adicional
ao atingir os níveis 7 (cinco dados no total) e 15 (seis
dados no total) de Guerreiro.
Salvaguardas. Se uma manobra exigir uma salvaguarda, a CD é igual a 8 mais seu modificador de Força ou
Destreza (à sua escolha) e seu Bônus de Proficiência.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 7, 'Conheça Seu Inimigo', 'Como uma Ação Bônus, você pode examinar certos
pontos fortes e fracos de uma criatura à sua vista a até
9 metros de você; você sabe se essa criatura tem Imunidades, Resistências ou Vulnerabilidades, e se a criatura
tiver alguma, você sabe quais são.
Após usar essa característica, você não pode fazer
isso novamente até completar um Descanso Longo.
Você também pode recuperar um uso da característica
gastando um Dado de Superioridade (nenhuma ação é
necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 10, 'Superioridade em Combate Aprimorada', 'Seu Dado de Superioridade se torna um d10.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 15, 'Implacável', 'Uma vez por turno, ao usar uma manobra, você pode
jogar 1d8 e usar o resultado em vez de gastar um Dado
de Superioridade.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'), 18, 'Superioridade em Combate Suprema', 'Seu Dado de Superioridade se torna um d12.
Opções de Manobra
As manobras são apresentadas em ordem alfabética.
Aparar. Ao receber dano de outra criatura em uma
jogada de ataque corpo a corpo, você pode executar
uma Reação e gastar um Dado de Superioridade para
reduzir o dano pelo número obtido no Dado de Superioridade mais seu modificador de Força ou Destreza
(à sua escolha).
Ataque Ameaçador. Ao atingir uma criatura com
uma jogada de ataque, você pode gastar um Dado de
Superioridade para tentar amedrontar o alvo. Adicione o resultado do Dado de Superioridade à jogada de
dano do ataque. O alvo deve ser bem-sucedido em uma
salvaguarda de Sabedoria ou tem a condição Amedrontado até o final do seu próximo turno.
Ataque de Varredura. Ao atingir uma criatura com
uma jogada de ataque corpo a corpo usando uma arma
ou um Ataque Desarmado, você pode gastar um Dado
de Superioridade para tentar causar dano a outra
criatura. Escolha outra criatura a até 1,5 metro do alvo
original e ao seu alcance. Se a jogada de ataque original
atingir a segunda criatura, ela sofre dano igual ao resultado do Dado de Superioridade. O dano é do mesmo
tipo causado pelo ataque original.
Ataque Estendido. Como uma Ação Bônus, você pode
gastar um Dado de Superioridade e executar a ação
Correr. Se você se mover pelo menos 1,5 metro em
linha reta imediatamente antes de realizar um ataque
corpo a corpo como parte da ação Atacar neste turno,
pode adicionar o resultado do Dado de Superioridade à
jogada de dano do ataque.
Ataque para Distrair. Ao atingir uma criatura com
uma jogada de ataque, você pode gastar um Dado de
Superioridade para distrair o alvo. Adicione o resultado do Dado de Superioridade à jogada de dano do ataque. A próxima jogada de ataque contra o alvo por um
atacante diferente de você tem Vantagem se o ataque
for realizado antes do início do seu próximo turno.
Ataque Preciso. Ao errar uma jogada de ataque, você
pode gastar um Dado de Superioridade e adicionar o
resultado à jogada de ataque, fazendo potencialmente
o ataque acertar.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 3, 'Lâminas Psíquicas', 'Você pode manifestar lâminas cintilantes de energia
psíquica. Ao executar a ação Atacar ou realizar um
Ataque de Oportunidade, você pode manifestar uma
Lâmina Psíquica em sua mão livre e atacar com essa lâmina. A lâmina mágica tem as seguintes características:
Categoria de Arma: Simples Corpo a Corpo
Dano em Caso de Acerto: 1d6 Psíquico mais o modificador
de atributo usado na jogada de ataque
Propriedades: Acuidade, Arremesso (alcance 18/36 metros)
Maestria: Afligir (você pode usar esta propriedade, e ela
não conta para o número de propriedades que você pode
usar com Maestria em Armas)
A lâmina desaparece imediatamente após atingir ou
errar o alvo, e não deixa marca se causar dano.
Após atacar com a lâmina no seu turno, você pode
realizar um ataque corpo a corpo ou à distância com
uma segunda lâmina psíquica como uma Ação Bônus
no mesmo turno, se sua outra mão estiver livre para
criá-la. O dado de dano deste ataque bônus é 1d4 em
vez de 1d6.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 3, 'Poder Psiônico', 'Você possui uma fonte de energia psiônica, representada pelos seus Dados de Energia Psiônica, que alimenta
certos poderes desta subclasse. A tabela Dados de
Energia do Adaga Espiritual indica o tipo e a quantidade desses dados conforme você atinge certos níveis de
Ladino.
Dados de Energia do Adaga Espiritual
Nível de Ladino Tipo de Dado Quantidade
3 D6 4
5 D8 6
9 D8 8
11 D10 8
13 D10 10
17 D12 12
Qualquer característica desta subclasse que utilize
um Dado de Energia Psiônica emprega apenas os
dados dessa subclasse. Alguns poderes consomem esse
Dado, conforme detalhado na respectiva descrição, e
você não pode usar um poder se ele exigir um dado
e todos os seus Dados de Energia Psiônica estiverem
esgotados.
Você recupera um de seus Dados de Energia Psiônica
gastos ao completar um Descanso Curto, e restaura
todos ao completar um Descanso Longo.
Aptidão Reforçada Psiquicamente. Ao falhar em um
teste de atributo usando uma perícia ou ferramenta

com a qual você tem proficiência, você pode jogar um
Dado de Energia Psiônica e adicionar o resultado do
teste, transformando potencialmente a falha em sucesso. O dado é gasto apenas se o teste for bem-sucedido.
Sussurros Psíquicos. Você pode estabelecer comunicação telepática com outras criaturas. Como uma
ação Usar Magia, escolha até um número de criaturas
igual ao seu Bônus de Proficiência que estejam à vista
e jogue um Dado de Energia Psiônica. Por um número de horas igual ao resultado, essas criaturas podem
se comunicar telepaticamente com você e vice-versa.
Para enviar ou receber mensagens (nenhuma ação é
necessária), você e a outra criatura devem estar a até
1,5 km de distância. Qualquer criatura pode encerrar
a conexão telepática a qualquer momento (nenhuma
ação é necessária).
Na primeira vez que você usa este poder após um
Descanso Longo, não gasta o Dado de Energia Psiônica; nas demais vezes, você o gasta.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 9, 'Lâminas da Alma', 'Agora você pode usar os seguintes poderes com suas
Lâminas Psíquicas.
Golpes Teleguiados. Ao realizar uma jogada de ataque
com sua Lâmina Psíquica e errar o alvo, você pode
jogar um Dado de Energia Psiônica e adicionar o resultado jogado à jogada de ataque. Caso o ataque atinja
devido a este bônus, o dado é gasto.
Teleporte Psíquico. Como uma Ação Bônus, você manifesta uma Lâmina Psíquica, gasta um dado de Energia Psíquica e o joga, então arremessa a lâmina em um
espaço desocupado à sua vista e a até uma distância em
metros igual a 3 vezes o resultado do dado. Você então
se teleporta para esse espaço, e a lâmina desaparece.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 13, 'Véu Psíquico', 'Você pode tecer um véu de estática psíquica para
se mascarar. Como uma ação Usar Magia, você tem
a condição Invisível por 1 hora ou até encerrar este
efeito (nenhuma ação é necessária). Essa invisibilidade
encerra se você causar dano a uma criatura ou forçar
uma criatura a realizar uma salvaguarda.
Você pode usar esta característica novamente gastando um Dado de Energia Psiônica (nenhuma ação é
necessária) ou após completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 17, 'Rasgar Mente', 'Você pode passar suas Lâminas Psíquicas diretamente
pela mente de uma criatura. Ao causar dano de Ataque
Furtivo com uma das suas Lâminas Psíquicas a uma
criatura, você pode forçá-la a realizar uma salvaguarda de Sabedoria (CD 8 + seu modificador de Destreza
+ seu Bônus de Proficiência). O alvo tem a condição
Atordoado por 1 minuto se falhar, e repete a salvaguarda no final de cada um dos turnos dele, encerrando o
efeito sobre si em caso de sucesso.
Você pode usar esta característica novamente gastando três Dados de Energia Psiônica (nenhuma ação é
necessária) ou após completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin'), 3, 'Assassinar', 'Você é adepto de emboscar um alvo, concedendo-lhe
os seguintes benefícios.
Iniciativa. Você tem Vantagem nas jogadas de
Iniciativa.
Golpe Surpreendente. Durante a primeira rodada de
cada combate, você tem Vantagem em jogadas de ataque contra qualquer criatura que não tenha realizado
o turno. Caso seu Ataque Furtivo atinja qualquer alvo
na rodada, o alvo sofre dano adicional do tipo da arma
igual ao seu nível de Ladino.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin'), 3, 'Ferramentas de Assassino', 'Você adquire um Kit de Disfarce e um Kit de Veneno, e
tem proficiência com eles.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin'), 9, 'Especialista em Infiltração', 'Você é especialista nas seguintes técnicas que auxiliam
suas infiltrações.
Mimetismo Magistral. Você pode imitar perfeitamente a fala, a caligrafia ou ambos de outra pessoa se tiver
passado pelo menos 1 hora estudando-os.
Mira Móvel. Ao usar Mira Firme, seu Deslocamento
não é reduzido a 0.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin'), 13, 'Armas Venenosas', 'Ao usar a opção Envenenar do seu Golpe Astuto, o
alvo também sofre 2d6 pontos de dano Venenoso
sempre que falhar na salvaguarda. Este dano ignora
Resistência a dano Venenoso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin'), 17, 'Golpe Mortal', 'Ao acertar com seu Ataque Furtivo na primeira rodada
de um combate, o alvo deve ser bem-sucedido em uma
salvaguarda de Constituição (CD 8 mais seu modificador de Destreza e seu Bônus de Proficiência) ou o dano
do ataque é dobrado contra o alvo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'), 3, 'Andarilho de Telhados', 'Você treinou para entrar em lugares especialmente
difíceis de alcançar, concedendo-lhe esses benefícios.
Escalador. Você adquire um Deslocamento de Escalada igual ao seu Deslocamento.
Saltador. Você pode determinar sua distância de salto
usando sua Destreza em vez de sua Força.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'), 3, 'Mão Leve', 'Como uma Ação Bônus, você pode executar uma das
seguintes coisas.
Prestidigitação. Realize um teste de Destreza (Prestidigitação) para abrir uma fechadura ou desarmar uma') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'), 9, 'Furtividade Suprema', 'Você adquire a seguinte opção de Golpe Astuto.
Ataque Escondido (Custo: 1d6). Se você tem a condição Invisível da ação Esconder, este ataque não
encerra essa condição se você encerrar seu turno atrás
da Cobertura de Três Quartos ou Cobertura Total.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'), 13, 'Usar Dispositivo Mágico', 'Você aprendeu a maximizar o uso de itens mágicos,
concedendo-lhe os seguintes benefícios.
Sintonização. Você pode sintonizar até quatro itens
mágicos ao mesmo tempo.
Cargas. Sempre que você usar uma propriedade de
item mágico que gaste cargas, jogue 1d6. Em um resultado de 6, você usa a propriedade sem gastar as cargas.
Pergaminhos. Você pode usar qualquer Pergaminho
Mágico usando Inteligência como seu atributo de
conjuração para a magia. Se a magia for um truque ou
uma magia de 1º círculo, você pode conjurá-la de forma confiável. Se o pergaminho possuir uma magia de
círculo superior, você deve primeiro ser bem-sucedido
em um teste de Inteligência (Arcanismo) (CD 10 mais
o círculo da magia). Em caso de sucesso, você conjura
a magia do pergaminho. Se falhar, o pergaminho se
desintegra.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'), 17, 'Reflexos de Ladrão', 'Você é habilidoso em emboscadas e rápida fuga do perigo. Em combate, você realiza dois turnos na primeira
rodada: o primeiro conforme sua Iniciativa normal e o
segundo em sua Iniciativa menos 10.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'), 3, 'Conjuração', 'Você aprendeu a conjurar magias. Veja o capítulo 7
para as regras sobre conjuração de magias. As informações abaixo detalham como você usa essas regras como
um Trapaceiro Arcano.
Truques. Você conhece três truques: Mãos Mágicas e
dois outros truques à sua escolha da lista de magias de
Mago (veja a seção desta classe para sua lista). Ilusão
Menor e Talho Mental são recomendadas.
Ao alcançar um nível de Ladino, você pode substituir
um dos seus truques, exceto Mãos Mágicas, por outro
truque de Mago à sua escolha.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'), 3, 'Mãos Mágicas Ligeiras', 'Ao conjurar Mãos Mágicas, você pode conjurá-la
como uma Ação Bônus e pode tornar a mão espectral Invisível. Você pode controlar a mão como uma
Ação Bônus e, através dela, pode realizar testes de
Destreza (Prestidigitação).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'), 9, 'Emboscada Mágica', 'Se você tem a condição de Invisível quando conjura
uma magia em uma criatura, ela tem Desvantagem
em qualquer salvaguarda que fizer contra a magia no
mesmo turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'), 13, 'Trapaceiro Versátil', 'Você adquire a capacidade de distrair os alvos com
suas Mãos Mágicas. Ao usar a opção Golpe Astuto em
seu Ataque em uma criatura, você também pode usar
essa opção em outra criatura a até 1,5 metro da mão
espectral.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'), 17, 'Ladrão de Magias', 'Você adquire a capacidade de roubar magicamente
o conhecimento de como conjurar uma magia de
outro conjurador.
Imediatamente após uma criatura conjurar
uma magia que tenha como alvo você ou a inclua
em sua área de efeito, você pode executar uma
Reação para forçá-la a realizar uma salvaguarda
de Inteligência, com CD equivalente à sua CD para
evitar sua magia. Se a criatura falhar, você nega o
efeito da magia contra si e rouba seu conhecimento
se a magia for de 1º círculo ou de um círculo que
você possa conjurar (não precisa ser uma magia
de Mago). Por 8 horas, você a terá preparada,
e a criatura não poderá conjurá-la durante esse
período.
Após roubar uma magia com essa característica,
você não pode usar esta característica novamente até
completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 3, 'Proteção Arcana', 'Você pode tecer magia ao seu redor para se proteger.
Ao conjurar uma magia de Abjuração com um espaço
de magia, você pode usar simultaneamente um fio da
magia para criar uma proteção mágica em si que dura
até você completar um Descanso Longo. A proteção
tem Pontos de Vida máximos iguais ao dobro do seu
nível de Mago mais seu modificador de Inteligência.
Ao sofrer dano, a proteção o absorve em vez de você.
Aplique qualquer Resistência ou Vulnerabilidade antes
de reduzir os Pontos de Vida da proteção. Se o dano
reduzir a proteção a 0 Pontos de Vida, você sofre o
dano restante. Com 0 Pontos de Vida, a proteção não
pode mais absorver dano, mas sua magia permanece.
Ao conjurar uma magia Abjuração com um espaço
de magia, a proteção restaura um número de Pontos
de Vida igual ao dobro do nível do espaço de magia.
Você também pode, como uma Ação Bônus, gastar um
espaço de magia, e a proteção recupera um número de
Pontos de Vida igual ao dobro do nível do espaço de
magia gasto.
Após conjurar a proteção, você não pode conjurá-la
novamente até completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 3, 'Versado em Abjuração', 'Escolha duas magias de Mago da escola de Abjuração,
cada uma deve ser de 2º círculo ou inferior e adicione-
-as gratuitamente ao seu livro de magias.
Além disso, ao adquirir acesso a um novo círculo de
espaços de magia nesta classe, você pode adicionar gratuitamente uma magia de Mago da escola de Abjuração
ao seu livro de magias. A magia escolhida deve ser de
um círculo para o qual você tenha espaços de magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 6, 'Proteção Projetada', 'Quando uma criatura à sua vista a até 9 metros de
você sofrer dano, você pode executar uma Reação para
que sua Proteção Arcana absorva esse dano. Caso isto') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 10, 'Rompe-Magia', 'Você sempre tem as magias Contramagia e Dissipar Magia preparadas. Além disso, você pode conjurar Dissipar
Magia como uma Ação Bônus e pode adicionar seu
Bônus de Proficiência ao seu teste de atributo.
Ao conjurar uma das magias com um espaço de
magia, esse espaço não é gasto se a magia falhar em
interromper uma magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 14, 'Resistência à Magia', 'Você tem Vantagem em salvaguardas contra magias e
Resistência ao dano proveniente de magias.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 3, 'Prodígio', 'Vislumbres do futuro começam a pressionar sua percepção. Ao completar um Descanso Longo, jogue dois
d20s e registre os números obtidos. Você pode substituir qualquer Teste de D20 realizado por você ou por
uma criatura à sua vista com uma dessas jogadas de
previsão. Você deve escolher fazer isso antes da jogada
do Teste de D20 e pode substituir uma jogada deste
modo apenas uma vez por turno.
Cada jogada de previsão pode ser usada apenas uma
vez. Ao completar um Descanso Longo você perde
quaisquer jogadas de previsão não utilizadas.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 3, 'Versado em Adivinhação', 'Escolha duas magias de Mago da escola de Adivinhação, cada uma deve ser de 2º círculo ou inferior, e
adicione-as gratuitamente ao seu livro de magias.
Além disso, ao adquirir acesso a um novo círculo de
espaços de magia nesta classe, você pode adicionar gratuitamente uma magia de Mago da escola de Adivinhação ao seu livro de magias. A magia escolhida deve ser
de um círculo para o qual você tenha espaços de magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 6, 'Perito em Adivinhação', 'Conjurar magias de Adivinhação é tão fácil para você
que gasta apenas uma fração de seus esforços de conjuração. Ao conjurar uma magia de Adivinhação usando um espaço de magia de 2º círculo ou superior, você
recupera um espaço de magia gasto. O espaço que você
recupera deve ser de um círculo inferior ao espaço que
você conjurou e não pode ser superior ao 5º círculo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 10, 'O Terceiro Olho', 'Você pode ampliar seus poderes de percepção. Como
uma Ação Bônus, escolha um dos seguintes benefícios,
que dura até você iniciar um Descanso Curto ou Longo. Você não pode usar essa característica novamente
até completar um Descanso Curto ou Longo.
Compreensão Superior. Você pode ler qualquer idioma.
Ver o Invisível. Você pode conjurar Ver o Invisível sem
gastar um espaço de magia.
Visão no Escuro. Você adquire Visão no Escuro com
um alcance de 36 metros.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'), 14, 'Prodígio Maior', 'As visões em seus sonhos se intensificam e formam
uma imagem mais precisa em sua mente do que está
por vir. Jogue três d20s para sua característica Prodígio em vez de dois.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 3, 'Truque Potente', 'Seus truques que causam dano afetam até criaturas
que evitam os efeitos deles. Ao conjurar um truque em
uma criatura e errar o ataque ou o alvo ser bem-sucedido na salvaguarda contra o truque, ele sofre metade
do dano (se houver), mas não sofre efeitos adicionais
do truque.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 3, 'Versado em Evocação', 'Escolha duas magias de Mago da escola de Evocação,
cada uma deve ser de 2º círculo ou inferior, e adicione-
-as gratuitamente ao seu livro de magias.
Além disso, ao adquirir acesso a um novo círculo de
espaços de magia nesta classe, você pode adicionar gratuitamente uma magia de Mago da escola de Evocação
ao seu livro de magias. A magia escolhida deve ser de
um círculo para o qual você tenha espaços de magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 6, 'Esculpir Magias', 'Você pode criar zonas de segurança nos efeitos das
suas evocações. Ao conjurar uma magia de Evocação
que afeta criaturas à sua vista, você pode escolher um
número delas igual a 1 mais o círculo da magia. Criaturas escolhidas são bem-sucedidas automaticamente em
suas salvaguardas e não sofrem dano se normalmente
sofreriam metade do dano em caso de sucesso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 10, 'Evocação Potencializada', 'Ao conjurar uma magia de Mago da escola de Evocação, você pode adicionar seu modificador de Inteligência a uma jogada de dano dessa magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'), 14, 'Sobrecarga', 'Você pode aumentar o poder de suas magias. Ao conjurar uma magia de Mago que cause dano com um espaço de magia de 1º a 5º círculo, você pode causar dano
máximo com essa magia no turno no qual a conjurar.
Ao fazer isso pela primeira vez, você não sofre
nenhum efeito adverso. Se usar esta característica novamente antes de completar um Descanso Longo, você
sofre 2d12 pontos de dano Necrótico para cada círculo
do espaço de magia imediatamente após conjurá-la.
Esse dano ignora Resistência e Imunidade.
Toda vez que você usa esta característica novamente
antes de completar um Descanso Longo, o dano Necrótico por círculo de magia aumenta em 1d12.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 3, 'Ilusões Aprimoradas', 'Você pode conjurar magias de Ilusão sem fornecer
componentes Verbais e se uma magia de Ilusão que
você conjurar tiver um alcance de 3 metros ou mais, o
alcance aumenta em 18 metros.
Você também conhece o truque Ilusão Menor. Se já o
conhece, você aprende um truque de Mago diferente
à sua escolha. O truque não conta para o seu número
de truques conhecidos. Você pode criar um som e uma
imagem com uma única conjuração de Ilusão Menor e
pode conjurá-la como uma Ação Bônus.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 3, 'Versado em Ilusão', 'Escolha duas magias de Mago da escola de Ilusão, cada
uma deve ser de 2º círculo ou inferior e adicione-as
gratuitamente ao seu livro de magias.
Além disso, ao adquirir acesso a um novo círculo de
espaços de magia nesta classe, você pode adicionar gratuitamente uma magia de Mago da escola de Ilusão ao
seu livro de magias. A magia escolhida deve ser de um
círculo para o qual você tenha espaços de magia.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 6, 'Criaturas Espectrais', 'Você sempre tem as magias Convocar Feérico e Invocar
Fera preparadas. Ao conjurar qualquer uma das magias,
você pode mudar sua escola para Ilusão, o que faz com
que a criatura invocada pareça espectral. Você pode
conjurar a versão Ilusão de cada magia sem gastar um
espaço de magia, mas conjurá-la sem um espaço de magia reduz pela metade os Pontos de Vida da criatura.
Após conjurar qualquer uma das magias sem um espaço de magia, você deve completar um Descanso Longo
antes de conjurar novamente a magia desta forma.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 10, 'Autoimagem Ilusória', 'Ao ser atingido pela jogada de ataque de uma criatura,
você pode usar uma Reação para criar uma duplicata
ilusória de si entre você e o atacante. O ataque erra
automaticamente e a ilusão se dissipa.
Após usar esta característica, você não pode utilizá-
-la novamente até completar um Descanso Curto ou
Longo. Você também pode restaurar seu uso gastando
um espaço de magia de 2º círculo ou superior (nenhuma ação é necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 14, 'Realidade Ilusória', 'Você aprendeu a tecer magia sombria em suas ilusões
para dar a elas uma semi-realidade. Ao conjurar uma
magia Ilusão com um espaço de magia, você pode escolher um objeto inanimado e não mágico que faça parte
da ilusão e tornar esse objeto real. Você pode executar
isso no seu turno como uma Ação Bônus, enquanto a
magia estiver em andamento. O objeto permanece real
por 1 minuto, durante o qual não pode causar dano ou
conferir quaisquer condições. Por exemplo, você pode
criar uma ilusão de uma ponte sobre um abismo e, em
seguida, torná-la real e atravessá-la.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'), 3, 'Manipular Elementos', 'Você conhece a magia Elementalismo. Sabedoria é seu
atributo de conjuração para ela.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'), 3, 'Sintonia Elemental', 'No início do seu turno, você pode gastar 1 Ponto de
Foco para imbuir-se de energia elemental. A energia
dura 10 minutos ou até você ter a condição Incapacitado. Você adquire os seguintes benefícios enquanto
esta característica estiver ativa.
Ataques Elementais. Ao acertar com seu Ataque
Desarmado, você pode causar com ele, à sua escolha,
dano Ácido, Elétrico, Gélido, Ígneo ou Trovejante, em
vez de seu tipo de dano normal. Ao causar um desses
tipos de dano, você também pode forçar o alvo a realizar
uma salvaguarda de Força. Se ele falhar, você pode
movê-lo até 3 metros em sua direção ou para longe de
você, enquanto a energia elemental gira em torno dele.
Extensão. Ao realizar um Ataque Desarmado, seu
alcance aumenta em 3 metros à medida que a energia
elemental se estende por você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'), 6, 'Explosão Elemental', 'Como uma ação Usar Magia, você pode gastar 2 Pontos
de Foco para fazer com que energia elemental exploda
em uma Esfera de 6 metros de raio centrada em
um ponto a até 36 metros de você. Escolha um tipo de
dano: Ácido, Elétrico, Gélido, Ígneo ou Trovejante.
Cada criatura na Esfera deve realizar uma salvaguarda
de Destreza. Se falhar, uma criatura sofre dano
do tipo escolhido igual a três jogadas de seus dados
de Artes Marciais. Em caso de sucesso, uma criatura
sofre metade do dano.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'), 11, 'Passo dos Elementos', 'Enquanto sua Sintonia Elemental estiver ativa, você
também tem um Deslocamento de Natação e de Voo
igual ao seu Deslocamento.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'), 17, 'Ápice Elemental', 'Enquanto sua Sintonia Elemental estiver ativa, você
também adquire os seguintes benefícios.
Golpes Potencializados. Uma vez em cada um dos
seus turnos, você pode causar dano adicional a um
alvo igual a uma jogada de seu dado de Artes Marciais
ao atingi-lo com um Ataque Desarmado. O dano adicional é do mesmo tipo causado por esse ataque.
Passo Destrutivo. Ao usar seu Passo do Vento, seu
Deslocamento aumenta em 6 metros até o final do turno.
Pela duração, qualquer criatura à sua escolha sofre
dano igual a uma jogada de seu dado de Artes Marciais
quando você entra em um espaço a até 1,5 metro
dela. O tipo de dano fica à sua escolha, entre Ácido,
Elétrico, Gélido, Ígneo ou Trovejante. Uma criatura
pode sofrer esse dano apenas uma vez por turno.
Resistência a Dano. Você adquire Resistência a um
dos seguintes tipos de dano à sua escolha: Ácido, Elétrico, Gélido, Ígneo ou Trovejante. No início de cada
um dos seus turnos, você pode alterar essa escolha.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'), 3, 'Técnica da Mão Espalmada', 'Ao atingir uma criatura com um ataque concedido
por sua Torrente de Golpes, você pode impor um dos
seguintes efeitos ao alvo.
Derrubar. O alvo deve ser bem-sucedido em uma
salvaguarda de Destreza ou tem a condição Caído.
Desorientar. O alvo não pode realizar Ataques de
Oportunidade até o início do próximo turno dele.
Empurrar. O alvo deve ser bem-sucedido em uma
salvaguarda de Força ou é empurrado até 4,5 metros
para longe de você.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'), 6, 'Integridade Corporal', 'Você adquire a capacidade de se curar. Como uma
Ação Bônus, você pode jogar seu dado de Artes Marciais.
Você recupera um número de Pontos de Vida
igual ao resultado mais seu modificador de Sabedoria
(mínimo de 1 Ponto de Vida recuperado).
Você pode usar essa característica um número de
vezes igual ao seu modificador de Sabedoria (mínimo
de uma vez) e restaura todos os usos gastos ao completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'), 11, 'Passo Veloz', 'Ao executar uma Ação Bônus diferente de Passo do
Vento, você também pode usar Passo do Vento imediatamente após essa Ação Bônus.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'), 17, 'Palma Vibrante', 'Você obtém a habilidade de infligir vibrações letais no
corpo de outra pessoa. Ao acertar uma criatura com
um Ataque Desarmado, você pode gastar 4 Pontos
de Foco para iniciar essas vibrações imperceptíveis,
que duram por um número de dias igual ao seu nível
de Monge. As vibrações são inofensivas, a menos que
você execute uma Ação para encerrá-las. Como alternativa, ao executar a ação Atacar no seu turno, você
pode renunciar a um dos ataques para acabar com
as vibrações. Para encerrá-las, você e o alvo devem
estar no mesmo plano de existência. Ao fazer isso, o
alvo deve realizar uma salvaguarda de Constituição,
sofrendo 10d12 pontos de dano Energético se falhar
ou metade do dano em caso de sucesso.
Você pode ter apenas uma criatura sob o efeito desta
característica por vez. Você pode encerrar as vibrações
inofensivamente (nenhuma ação é necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'), 3, 'Implementos de Misericórdia', 'Você adquire proficiência nas perícias Intuição e Medicina e proficiência com o Kit de Herbalismo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'), 3, 'Mão de Cura', 'Com uma ação Usar Magia, você pode gastar 1 Ponto
de Foco para tocar uma criatura e restaurar um número de Pontos de Vida igual a uma jogada de seu dado
de Artes Marciais mais seu modificador de Sabedoria.
Ao usar sua Torrente de Golpes, você pode substituir
um dos Ataques Desarmados pelo uso dessa característica sem gastar um Ponto de Foco para a cura.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'), 3, 'Mão de Dolo', 'Uma vez por turno, ao atingir uma criatura com um
Ataque Desarmado e causar dano, você pode gastar 1
Ponto de Foco para causar dano Necrótico adicional
igual a uma jogada de seu dado de Artes Marciais mais
seu modificador de Sabedoria.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'), 6, 'Toque de Médico', 'Sua Mão de Cura e Mão de Dolo melhoram, conforme
detalhado abaixo.
Mão de Cura. Ao usar Mão de Cura, você também
pode encerrar uma das seguintes condições na criatura
que você curar: Atordoado, Cego, Envenenado,
Paralisado ou Surdo.
Mão de Dolo. Ao usar Mão de Dolo em uma criatura,
você também pode impor a ela a condição Envenenado
até o final do seu próximo turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'), 11, 'Torrente de Cura e Dolo', 'Ao usar Torrente de Golpes, você pode substituir cada
um dos Ataques Desarmados pelo uso da Mão de Cura
sem gastar Pontos de Foco para a cura.
Além disso, ao realizar um Ataque Desarmado com
Torrente de Golpes e causar dano, você pode usar Mão
de Dolo com esse ataque sem gastar um Ponto de Foco
para Mão de Dolo. Você ainda pode usar Mão de Dolo
apenas uma vez por turno.
Você pode usar esses benefícios um número de vezes
igual ao seu modificador de Sabedoria (mínimo de
uma vez) e restaura todos os usos gastos ao completar
um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'), 17, 'Mão da Misericórdia Final', 'Seu domínio da energia vital abre a porta para a
misericórdia final. Como uma ação Usar Magia, você
pode tocar o cadáver de uma criatura que morreu nas
últimas 24 horas e gastar 5 Pontos de Foco. A criatura
então retorna à vida com um número de Pontos de
Vida igual a 4d10 mais seu modificador de Sabedoria.
Se a criatura morreu com quaisquer condições a
seguir, a criatura revive com as condições removidas:
Atordoado, Cego, Envenenado, Paralisado e Surdo.
Após usar essa característica, você não pode usá-la
novamente até completar um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'), 3, 'Artes das Sombras', 'Você aprendeu a aproveitar o poder do Sombral, obtendo os seguintes benefícios.
Visão no Escuro. Você adquire Visão no Escuro com
um alcance de 18 metros. Se você já tem Visão no
Escuro, seu alcance aumenta em 18 metros.
Escuridão. Você pode gastar 1 Ponto de Foco para
conjurar a magia Escuridão sem componentes de magia.
Você pode ver na área da magia ao conjurar com
esta característica. Enquanto a magia persistir, você
pode mover sua área de Escuridão para um espaço
a até 18 metros de si no início de cada um dos seus
turnos.
Ilusão Sombria. Você conhece a magia Ilusão Menor.
Sabedoria é seu atributo de conjuração para ela.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'), 6, 'Passo da Sombra', 'Enquanto estiver inteiramente em Meia-luz ou Escuridão, você pode executar uma Ação Bônus para se teleportar até 18 metros para um espaço desocupado à sua
vista que também esteja sob Meia-luz ou Escuridão.
Você então tem Vantagem no próximo ataque corpo a
corpo que realizar antes do final do turno atual.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'), 11, 'Passo da Sombra Aprimorado', 'Você pode usar sua conexão com o Sombral para
melhorar seu teleporte. Ao usar Passo da Sombra,
você pode gastar 1 Ponto de Foco para remover o
requisito no qual você deve iniciar ou encerrar seu
turno em Meia-luz ou Escuridão para usar esta
característica. Como parte desta Ação Bônus, você
pode realizar um Ataque Desarmado imediatamente
após se teleportar.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'), 17, 'Manto da Sombra', 'Como uma ação Usar Magia enquanto estiver inteiramente em Meia-luz ou Escuridão, você pode gastar
3 Pontos de Foco para envolver-se em sombras por
1 minuto, até ter a condição Incapacitado ou até
encerrar seu turno em Luz Plena. Enquanto estiver
envolto por essas sombras, você adquire os seguintes
benefícios.
Invisibilidade. Você tem a condição Invisível.
Parcialmente Incorpóreo. Você pode se mover por
espaços ocupados como se fossem Terrenos Difíceis.
Se você encerrar seu turno em tal espaço, é deslocado
para o último espaço desocupado em que estava.
Torrente de Sombras. Você pode usar sua Torrente
de Golpes sem gastar nenhum Ponto de Foco.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'), 3, 'A Ira da Natureza', 'Como uma ação Usar Magia, você pode gastar um uso
do seu Canalizar Divindade para conjurar videiras espectrais em torno de criaturas próximas. Cada criatura
à sua escolha que você possa ver a até 4,5 metros de
você deve ser bem-sucedida em uma salvaguarda de
Força ou tem a condição Contido por 1 minuto. Uma
criatura Contida repete a salvaguarda no final de cada
um dos turnos dela, encerrando o efeito em caso de
sucesso.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'), 3, 'Magias do Juramento dos Anciões', 'A magia do seu juramento garante que você sempre
tenha certas magias prontas; quando você atinge
um nível de Paladino detalhado na tabela Magias do
Juramento dos Anciões, você sempre tem as magias
apresentadas preparadas.
Magias do Juramento dos Anciões
Nível de Paladino Magias
3 Falar com Animais, Golpe Constritor
5 Passo Nebuloso, Raio Lunar
9 Crescimento de Plantas, Proteção
contra Energia
13 Pele-Rocha, Tempestade Glacial
17 Comunhão com a Natureza, Passo
Arbóreo') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'), 7, 'Aura de Resistência', 'Magia antiga repousa tão fortemente em você que
forma uma proteção mística, bloqueando a energia
que vem de fora do Plano Material; você e seus aliados
têm Resistência a dano Necrótico, Psíquico e Radiantes
enquanto estiverem em sua Aura de Proteção.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'), 15, 'Sentinela Imortal', 'Ao ser reduzido a 0 Pontos de Vida e não morto imediatamente, você fica com 1 Ponto de Vida e recupera
um número de Pontos de Vida igual a três vezes o seu
nível de Paladino. Após usar essa característica, você
não pode utilizá-la novamente até completar um Descanso Longo.
Além disso, você não pode envelhecer magicamente e
sua aparência não envelhece.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'), 20, 'Campeão Ancestral', 'Como uma Ação Bônus, você pode imbuir sua Aura de
Proteção com poder sagrado, concedendo os benefícios
abaixo por 1 minuto ou até a encerrar (nenhuma ação
é necessária). Após usar esta característica, você não
pode utilizá-la novamente até completar um Descanso
Longo. Você também pode restaurar seu uso gastando
um espaço de magia de 5º círculo (nenhuma ação é
necessária).
Aliviar Desafio. Inimigos na sua aura têm Desvantagem em salvaguardas contra suas magias e opções de
Canalizar Divindade.
Magias Ágeis. Sempre que conjurar uma magia que
tenha um tempo de conjuração de uma ação, você
pode conjurá-la usando uma Ação Bônus.
Regeneração. No início de cada um dos seus turnos,
você recupera 10 Pontos de Vida.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'), 3, 'Arma Sagrada', 'Ao executar a ação Atacar, você pode gastar um uso de
seu Canalizar Divindade para imbuir uma arma Corpo
a Corpo que você está empunhando com energia') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'), 7, 'Aura de Devoção', 'Você e seus aliados têm Imunidade à condição Enfeitiçado enquanto estiverem em sua Aura de Proteção.
Se um aliado Enfeitiçado entrar na aura, essa condição
não tem efeito sobre esse aliado enquanto ele estiver
na aura.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'), 15, 'Destruição Protetora', 'Sua destruição mágica agora irradia energia protetora.
Ao conjurar Destruição Divina, você e seus aliados têm
Cobertura Parcial enquanto estiverem em sua Aura de
Proteção. A aura mantém este benefício até o início do
seu próximo turno.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'), 20, 'Resplendor Sagrado', 'Como uma Ação Bônus, você pode imbuir sua Aura de
Proteção com poder sagrado, concedendo os benefícios abaixo por 10 minutos ou até a encerrar (nenhuma ação é necessária). Após usar esta característica,
você não pode utilizá-la novamente até completar um
Descanso Longo. Você também pode recuperar seu uso
gastando um espaço de magia de 5º círculo (nenhuma
ação é necessária).
Dano Radiante. Sempre que um inimigo inicia o
turno na sua aura, essa criatura sofre dano Radiante
igual ao seu modificador de Carisma mais seu Bônus de
Proficiência.
Luz Solar. A aura é preenchida com Luz Plena que é
luz solar.
Vigília Consagrada. Você tem Vantagem em qualquer
salvaguarda que seja forçado a realizar por um Ínfero
ou um Morto-Vivo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'), 3, 'Atleta Inigualável', 'Como uma Ação Bônus, você pode gastar um uso do
seu Canalizar Divindade para aprimorar seu atletismo.
Por 1 hora, você tem Vantagem em testes de Força
(Atletismo) e Destreza (Acrobacia), e a distância de
seus Saltos Longos e Salto em Altura aumenta em
3 metros (essa distância adicional custa movimento
padrão).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'), 3, 'Destruição Inspiradora', 'Imediatamente após conjurar Destruição Divina, você
pode gastar um uso do seu Canalizar Divindade e
distribuir Pontos de Vida Temporários para criaturas
à sua escolha a até 9 metros de si, incluindo você. O
número total de Pontos de Vida Temporários é igual
a 2d8 mais o seu nível de Paladino, dividido entre as
criaturas escolhidas, como preferir.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'), 3, 'Magias do Juramento da Glória', 'A magia do seu juramento garante que você sempre
tenha certas magias prontas; ao atingir um nível de
Paladino detalhado na tabela Magias do Juramento
da Glória, você sempre tem as magias apresentadas
preparadas.
Magias de Juramento da Glória
Nível de Paladino Magias
3 Heroísmo, Raio Guia
5 Aprimorar Atributo, Arma Mágica
9 Celeridade, Proteção contra Energia
13 Compulsão, Movimentação Livre
17 Lendas e Histórias, Presença Régia de
Yolande') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'), 7, 'Aura de Vivacidade', 'Seu Deslocamento aumenta em 3 metros.
Além disso, sempre que um aliado entra em sua Aura
de Proteção pela primeira vez em um turno ou inicia o
turno dele na aura, o Deslocamento do aliado aumenta
em 3 metros até o final do próximo turno dele.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'), 15, 'Defesa Gloriosa', 'Você pode transformar a defesa em um ataque repentino. Quando você ou outra criatura à sua vista
a até 3 metros de você é atingida por uma jogada de
ataque, você pode executar uma Reação para conceder
um bônus à CA do alvo contra esse ataque, fazendo
potencialmente com que o ataque erre. O bônus é igual
ao seu modificador de Carisma (mínimo de +1). Se o
ataque falhar, você pode realizar um ataque com uma
arma contra o atacante como parte desta Reação se o
atacante estiver no alcance da sua arma.
Você pode usar essa característica um número de
vezes igual ao seu modificador de Carisma (mínimo de
uma vez) e restaura todos os usos gastos ao completar
um Descanso Longo.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'), 20, 'Lenda Viva', 'Você pode se fortalecer com as lendas — verdadeiras
ou exageradas — de seus grandes feitos. Como uma
Ação Bônus, você recebe os benefícios abaixo por
10 minutos. Após usar essa característica, você não
pode utilizá-la novamente até completar um Descanso
Longo. Você também pode recuperar seu uso gastando
um espaço de magia de 5º círculo (nenhuma ação é
necessária).
Carismático. Você é abençoado com uma presença
sobrenatural e tem Vantagem em todos os testes de
Carisma.
Golpe Infalível. Uma vez em cada um dos seus turnos,
ao realizar uma jogada de ataque com uma arma e
errar, você pode fazer com que esse ataque atinja.
Jogar Novamente a Salvaguarda. Se você falhar em
uma salvaguarda, pode usar sua Reação para jogá-la
novamente. Você deve usar o novo resultado.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'), 3, 'Magias do Juramento da Vingança', 'A magia do seu juramento garante que você sempre
tenha certas magias prontas; quando você atinge
um nível de Paladino detalhado na tabela Magias do
Juramento da Vingança, você sempre tem as magias
apresentadas preparadas.
Magias do Juramento da Vingança
Nível de Paladino Magias
3 Marca do Predador, Perdição
5 Paralisar Pessoa, Passo Nebuloso
9 Celeridade, Proteção contra Energia
13 Banimento, Porta Dimensional
17 Paralisar Monstro, Vidência') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'), 3, 'Voto de Inimizade', 'Ao executar a ação Atacar, você pode gastar um uso de
seu Canalizar Divindade para proferir um voto de inimizade contra uma criatura à sua vista a até 9 metros
de si. Você tem Vantagem em jogadas de ataque contra
a criatura por 1 minuto ou até usar essa característica
novamente.
Caso a criatura caia a 0 Pontos de Vida antes que
o voto termine, você pode transferir o voto para uma
criatura diferente a até 9 metros de você (nenhuma
ação é necessária).') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'), 7, 'Vingador Implacável', 'Seu foco sobrenatural permite que você evite a retirada
de um inimigo. Ao atingir uma criatura com um
Ataque de Oportunidade, você pode reduzir o Deslocamento da criatura para 0 até o final do turno atual.
Você pode, então, se mover até metade de seu Deslocamento como parte da mesma Reação. Esse movimento
não provoca Ataques de Oportunidade.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'), 15, 'Alma Vingativa', 'Imediatamente após uma criatura sob o efeito do seu
Voto de Inimizade acertar ou errar com uma jogada de
ataque, você pode executar uma Reação para realizar
um ataque corpo a corpo contra essa criatura se ela
estiver ao seu alcance.') ON CONFLICT (subclass_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'), 20, 'Anjo Vingador', 'Como uma Ação Bônus, você adquire os benefícios
abaixo por 10 minutos ou até a encerrar (nenhuma
ação é necessária). Após usar esta característica, você
não pode utilizá-la novamente até completar um
Descanso Longo. Você também pode recuperar seu uso
gastando um espaço de magia de 5º círculo (nenhuma
ação é necessária).
Aura Amedrontadora. Sempre que um inimigo inicia
o turno dele em sua Aura de Proteção, ele deve ser
bem-sucedido em uma salvaguarda de Sabedoria ou
tem a condição Amedrontado por 1 minuto, ou até sofrer qualquer dano. Jogadas de ataque contra a criatura
Amedrontada têm Vantagem.
Voo. Você cria asas espectrais nas costas e tem um
Deslocamento de Voo de 18 metros, além de poder
pairar.') ON CONFLICT (subclass_id, level, name) DO NOTHING;
