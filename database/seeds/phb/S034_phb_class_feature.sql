-- Seed rpg.phb_class_feature
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 1, 'Fúria', 'Você pode se imbuir com um poder primitivo chamado
Fúria, uma força que lhe concede força e resiliência
extraordinárias. Você pode entrar em Fúria como uma
Ação Bônus, desde que não esteja vestindo armadura
Pesada.
Você pode entrar em Fúria o número de vezes
indicado na coluna Fúrias da tabela Características de
Bárbaro para seu nível de Bárbaro. Você recupera um
uso gasto ao completar um Descanso Curto, e restaura
todos os usos gastos ao completar um Descanso Longo.
Enquanto ativa, sua Fúria segue as regras abaixo.
Resistência a Dano. Você tem Resistência a dano
Contundente, Cortante e Perfurante.
Dano da Fúria. Quando você realiza um ataque com
Força — seja com uma arma ou um Ataque Desarmado — e causar dano ao alvo, você recebe um bônus no
dano, que aumenta conforme você adquire níveis como
Bárbaro, conforme mostrado na coluna Dano da Fúria
da tabela Características de Bárbaro.
Vantagem com Força. Você tem Vantagem em testes
de Força e salvaguardas de Força.
Sem Concentração ou Magias. Você não pode manter
a Concentração e não pode conjurar magias.
Duração. A Fúria dura até o final do seu próximo
turno, e encerra se você vestir armadura Pesada ou
ter a condição Incapacitado. Se sua Fúria ainda estiver
ativa no próximo turno, você pode estendê-la por mais
um turno ao realizar uma das seguintes ações:
• Realizar uma jogada de ataque contra um inimigo.
• Forçar um inimigo a realizar uma salvaguarda.
• Executar uma Ação Bônus para estender sua Fúria.
Cada vez que a Fúria é estendida, ela permanece até
o final do seu próximo turno. Você pode manter uma
Fúria por até 10 minutos.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 1, 'Defesa sem Armadura', 'Enquanto você não estiver vestindo nenhuma armadura, sua Classe de Armadura base é igual a 10 mais seus
modificadores de Destreza e Constituição. Você pode
usar um Escudo e ainda receber este benefício.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 1, 'Maestria em Arma', 'Seu treinamento com armas permite que você utilize
as propriedades de maestria com dois tipos de armas
Corpo a Corpo Simples ou Marciais à sua escolha,
como Machados Grandes e Machadinhas. Sempre que 
completar um Descanso Longo, você pode praticar
movimentos com armas e alterar uma dessas escolhas
de armas.
Ao alcançar certos níveis de Bárbaro, você adquire a
habilidade de usar as propriedades de maestria de mais
tipos de armas, conforme mostrado na coluna Maestria
em Armas da tabela Características de Bárbaro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 2, 'Ataque Imprudente', 'Você pode descartar toda preocupação com a defesa
para atacar com ferocidade intensificada. Ao realizar
sua primeira jogada de ataque no seu turno, você
pode decidir atacar de forma imprudente. Fazer isso
lhe concede Vantagem em jogadas de ataque usando
Força até o início do seu próximo turno, mas jogadas
de ataque contra você também têm Vantagem durante
esse tempo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 2, 'Sentido de Perigo', 'Você adquire uma sensibilidade extraordinária de
quando as coisas não estão como deveriam, o que lhe
dá um benefício ao desviar de perigos. Você tem Vantagem em salvaguardas de Destreza, a menos que tenha a
condição Incapacitado.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 3, 'Conhecimento Primordial', 'Você adquire proficiência em outra perícia à sua escolha da lista de perícias disponíveis para Bárbaros no
nível 1.
Além disso, enquanto sua Fúria estiver ativa, você
pode canalizar poder primitivo ao tentar realizar certas
tarefas. Sempre que realizar um teste de atributo usando uma das seguintes perícias, pode realizá-lo como um
teste de Força, mesmo que normalmente utilize outro
atributo: Acrobacia, Furtividade, Intimidação, Percepção ou Sobrevivência. Quando você usa essa habilidade, sua Força representa o poder primitivo fluindo em
você, refinando sua agilidade, postura e sentidos.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 3, 'Subclasse de Bárbaro', 'Você adquire uma subclasse de Bárbaro à sua escolha.
As subclasses Trilha da Árvore do Mundo, Trilha do
Berserker, Trilha do Coração Selvagem e Trilha do
Fanático estão detalhadas após a descrição desta classe.
Uma subclasse é uma especialização que lhe concede
características em determinados níveis de Bárbaro.
Durante toda sua jornada, você adquire cada característica da sua subclasse que corresponda ao seu nível
de Bárbaro ou inferior.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Bárbaro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 5, 'Ataque Extra', 'Você pode atacar duas vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 5, 'Movimento Rápido', 'Seu Deslocamento aumenta em 3 metros enquanto
você não estiver usando Armadura Pesada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 7, 'Bote Instintivo', 'Como parte da Ação Bônus que você realiza para
entrar em Fúria, você pode se mover até metade do
seu Deslocamento.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 7, 'Instintos Primitivos', 'Seus instintos estão tão apurados que você tem Vantagem nas jogadas de Iniciativa.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 9, 'Golpe Brutal', 'Se você usar Ataque Imprudente, pode renunciar à
Vantagem em uma jogada de ataque com Força à sua
escolha no seu turno. A jogada de ataque escolhida
não deve ter Desvantagem. Se a jogada de ataque atingir o alvo, este sofre 1d10 pontos de dano adicional do
mesmo tipo causado pela arma ou Ataque Desarmado,
e você pode causar um efeito de Golpe Brutal à sua
escolha.
Você tem as seguintes opções de efeito.
Golpe Debilitador. O Deslocamento do alvo é
reduzido em 4,5 metros até o início do seu próximo
turno. Um alvo pode ser afetado por apenas um Golpe
Debilitador de cada vez — o mais recente.
Golpe Poderoso. O alvo é empurrado 4,5 metros
diretamente para longe de você. Em seguida, você
pode se mover até metade do seu Deslocamento diretamente em direção ao alvo sem provocar Ataques de
Oportunidade.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 11, 'Fúria Implacável', 'Sua Fúria pode mantê-lo lutando, apesar de ferimentos
graves. Se você atingir 0 Pontos de Vida enquanto sua
Fúria estiver ativa e não morrer imediatamente, você
pode realizar uma salvaguarda de Constituição CD 10.
Em caso de sucesso, seus Pontos de Vida mudam para
um número igual a duas vezes seu nível de Bárbaro.
A cada vez que usar essa característica após a primeira, a CD aumenta em 5. Ao completar um Descanso
Curto ou Longo, a CD volta para 10.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 13, 'Golpe Brutal Fortalecido', 'Você aperfeiçoou novas formas de atacar com ferocidade. Os seguintes efeitos agora estão entre suas
opções de Golpe Brutal.
Golpe Atordoante. O alvo tem Desvantagem na
próxima salvaguarda que realizar e não pode realizar
Ataques de Oportunidade até o início do seu próximo
turno.
Golpe Destruidor. Antes do início do seu próximo
turno, a próxima jogada de ataque realizada por outra
criatura contra o alvo recebe um bônus de +5. Uma
jogada de ataque só pode receber um bônus de Golpe
Destruidor por vez.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 15, 'Fúria Persistente', 'Ao jogar Iniciativa, você pode recuperar todos os usos
gastos de Fúria. Após recuperar a Fúria deste modo,
você não pode fazê-lo novamente até completar um
Descanso Longo.
Além disso, sua Fúria é tão feroz que agora dura 10
minutos sem a necessidade de estender a duração de
rodada em rodada. Sua Fúria encerra se você estiver
com a condição Inconsciente (não apenas Incapacitado) ou vestir armadura Pesada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 17, 'Golpe Brutal Fortalecido', 'O dano adicional de seu Golpe Brutal aumenta para
2d10 pontos. Além disso, você pode usar dois efeitos
diferentes de Golpe Brutal sempre que utilizar esta
característica.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 18, 'Força Indomável', 'Se o total de seu teste de Força ou de sua salvaguarda
de Força for menor que seu valor de Força, você pode
usar esse valor no lugar do resultado total.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 19, 'Dádiva Épica', 'Você adquire um talento Dádiva Épica (veja o capítulo
5) ou outro talento à sua escolha para o qual atenda
os pré-requisitos. A Dádiva do Ataque Irresistível é
recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 20, 'Campeão Primitivo', 'Você incorpora o poder primitivo. Seus valores de
Força e Constituição aumentam em 4, até um máximo
de 25.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 1, 'Inspiração de Bardo', 'Você pode inspirar outros sobrenaturalmente por
meio de palavras, música ou dança. Essa inspiração é
representada pelo seu dado de Inspiração de Bardo,
que é um d6.
Usando Inspiração de Bardo. Como uma Ação Bônus,
você pode inspirar outra criatura a até 18 metros de
você que possa vê-lo ou ouvi-lo. Essa criatura recebe
um de seus dados de Inspiração de Bardo. Uma criatura pode ter apenas um dado de Inspiração de Bardo de
cada vez.
Uma vez, dentro da próxima uma hora, após a criatura falhar em um Teste de D20, ela pode jogar o dado
de Inspiração de Bardo e adicionar o resultado ao D20,
transformando potencialmente a falha em sucesso.
O dado de Inspiração de Bardo é gasto quando for
jogado.
Quantidade de Usos. Você pode conceder um dado de
Inspiração de Bardo um número de vezes igual ao seu
modificador de Carisma (mínimo de uma vez), e você
restaura todos os usos gastos ao completar um Descanso Longo.
Em Níveis Superiores. Seu dado de Inspiração de Bardo muda quando você atinge certos níveis de Bardo,
conforme mostrado na coluna Dados de Inspiração da
tabela Características de Bardo. O dado se torna um d8
no nível 5, um d10 no nível 10 e um d12 no nível 15.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 1, 'Conjuração', 'Você aprendeu a conjurar magias através de suas artes
bárdicas. Veja o capítulo 7 para as regras sobre conjuração de magias. As informações abaixo detalham
como você utiliza essas regras com as magias de Bardo,
explicadas na lista de magias de Bardo mais adiante na
descrição da classe.
Truques. Você conhece dois truques à sua escolha
da lista de magias de Bardo. Luzes Dançantes e Zombaria
Perversa são recomendadas.
Sempre que você alcança um nível de Bardo, pode
substituir um dos seus truques por outro truque à sua
escolha da lista de magias de Bardo.
Ao atingir os níveis 4 e 10, você aprende mais um
truque à sua escolha da lista de magias de Bardo, conforme mostrado na coluna Truques da tabela Características de Bardo.
Espaços de Magia. A tabela Características de Bardo
mostra quantos espaços de magia você tem para conjurar suas magias de 1º círculo ou superior. Você restaura
todos os espaços gastos quando completa um Descanso
Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior que
estão disponíveis para você conjurar com esta característica. Para começar, escolha quatro magias de 1º
círculo da lista de magias de Bardo. Enfeitiçar Pessoa,
Leque Cromático, Palavra Curativa e Sussurros Dissonantes são recomendadas.
O número de magias em sua lista aumenta à medida
que você alcança níveis de Bardo, conforme mostrado
na coluna Magias Preparadas da tabela Características
de Bardo. Sempre que esse número aumentar, escolha magias adicionais da lista de magias de Bardo até
que o número de magias em sua lista corresponda ao
número da tabela. As magias escolhidas devem ser de
um círculo para o qual você possui espaços de magia.
Por exemplo, se você é um Bardo de nível 3, sua lista de
magias preparadas pode incluir seis magias de 1º ou 2º
círculo em qualquer combinação.
Se outra característica de Bardo lhe der magias que
você sempre tem preparadas, essas magias não contam
para o número de magias que você pode preparar com
esta característica, mas essas magias, de outra forma,
contam como magias de Bardo para você.
Mudando Suas Magias Preparadas. Sempre que você
obtém um nível de Bardo, pode substituir uma magia
em sua lista por outra magia de Bardo para a qual você
tem espaços de magia.
Atributo de Conjuração. Carisma é seu atributo de
conjuração para suas magias de Bardo.
Foco de Conjuração. Você pode usar um Instrumento
Musical como Foco de Conjuração para suas magias de
Bardo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 2, 'Especialista', 'Você obtém Especialização (veja o glossário de regras)
em duas de suas perícias, à sua escolha, nas quais já
seja proficiente. Atuação e Persuasão são recomendadas se você tiver proficiência nelas.
No nível 9 de Bardo, você obtém Especialização em
mais duas perícias nas quais já seja proficiente à sua
escolha.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 2, 'Pau pra Toda Obra', 'Você pode adicionar metade do seu Bônus de Proficiência (arredondado para baixo) a qualquer teste
de atributo que realizar que use uma perícia à qual
não possua proficiência e que não use seu Bônus de
Proficiência.
Por exemplo, se você realizar um teste de Força
(Atletismo) e não tiver proficiência em Atletismo, pode
adicionar metade do seu Bônus de Proficiência ao
teste.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 3, 'Subclasse de Bardo', 'Você adquire uma subclasse de Bardo à sua escolha. As
subclasses Colégio da Bravura, Colégio da Dança, Colégio do Conhecimento e Colégio do Glamour estão detalhadas após a descrição desta classe. Uma subclasse é
uma especialização que lhe concede características em
determinados níveis de Bardo. Durante toda sua jornada, você adquire cada característica de sua subclasse
que corresponda ao seu nível de Bardo ou inferior.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Bardo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 5, 'Fonte de Inspiração', 'Você agora restaura todos os seus usos gastos de Inspiração de Bardo quando completa um Descanso Curto
ou Longo.
Além disso, você pode gastar um espaço de magia
(nenhuma ação necessária) para recuperar um uso
gasto de Inspiração de Bardo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 7, 'Contra-Encantamento', 'Você pode usar notas musicais ou palavras de poder
para interromper efeitos que influenciam a mente. Se
você ou uma criatura a até 9 metros de você falhar em
uma salvaguarda contra um efeito que aplica as condições Amedrontado ou Enfeitiçado, você pode executar
uma Reação para jogar novamente a salvaguarda, e a
nova jogada tem Vantagem.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 10, 'Segredos Mágicos', 'Você aprendeu segredos de várias tradições mágicas.
Sempre que você alcançar um nível de Bardo (incluindo este nível) e o número de Magias Preparadas na
tabela Características de Bardo aumentar, você pode
escolher qualquer uma das novas magias preparadas
da lista de magias de Bardo, Clérigo, Druida e Mago,
e as magias escolhidas contam como magias de Bardo
para você (veja a seção de cada classe para a respectiva
lista de magias). Além disso, sempre que você substituir
uma magia preparada para esta classe, pode trocá-la
por uma magia dessas listas.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 18, 'Inspiração Superior', 'Quando você jogar Iniciativa, recupera usos gastos de
Inspiração de Bardo até ter dois, se tiver menos do que
isso.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 19, 'Dádiva Épica', 'Você adquire um talento Dádiva Épica (veja o capítulo
5) ou outro talento à sua escolha para o qual atenda
os pré-requisitos. A Dádiva da Recordação de Magia é
recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 20, 'Palavras de Criação', 'Você dominou duas das Palavras de Criação: as palavras de vida e morte. Portanto, você sempre tem as
magias Palavra de Poder: Matar e Palavra de Poder: Salvar
preparadas. Quando você conjura qualquer uma dessas
magias, pode escolher uma segunda criatura que está a
até 3 metros do primeiro alvo.
O Repertório do Bardo
Seu Bardo bate um tambor enquanto entoa os feitos
de heróis antigos? Dedilha um alaúde enquanto canta
canções românticas? Realiza árias de poder comovente?
Recita monólogos dramáticos de tragédias clássicas?
Usa o ritmo de uma dança folclórica para coordenar o
movimento dos aliados em batalha? Compõe poemas
curtos e ousados?
Ao interpretar um Bardo, considere o estilo de
apresentação artística que você prefere, os humores
que pode evocar e os temas que inspiram suas próprias
criações. Seus poemas são inspirados por momentos de
beleza natural ou são reflexões sombrias sobre o luto?
Você prefere hinos elevados ou canções animadas de
taberna? É atraído por lamentos pelos que pereceram
ou por celebrações de alegria? Dança baladas alegres ou
realiza coreografias interpretativas elaboradas? Foca em
um estilo de apresentação ou busca dominar todos?
Um Bardo Molda Inspiração e
Imaginação em Magia.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 1, 'Invocações Místicas', 'Você descobriu Invocações Místicas, fragmentos de
conhecimento proibido que lhe conferem uma habilidade mágica permanente ou outros ensinamentos.
Você recebe uma invocação à sua escolha, como Pacto
do Tomo. As invocações são descritas na seção “Opções de Invocações Místicas” mais adiante na descrição
desta classe.
Pré-requisitos. Se uma invocação tiver um pré-requisito, você deve atendê-lo para aprender essa invocação.
Por exemplo, se uma invocação exigir que você seja um
Bruxo de nível 5 ou superior, você pode selecionar a
invocação quando alcançar o nível 5 de Bruxo.
Substituindo e Recebendo outras Invocações. Ao
alcançar um nível de Bruxo, você pode substituir uma
de suas invocações por outra para a qual se qualifica.
Você não pode substituir uma invocação se ela for um
pré-requisito para outra invocação que você tenha.
Ao alcançar certos níveis de Bruxo, você adquire
mais invocações à sua escolha, conforme mostrado na
coluna Invocações da tabela Características de Bruxo.
Você não pode escolher a mesma invocação mais de
uma vez, a menos que a descrição da invocação indique
o contrário.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 1, 'Magia de Pacto', 'Por meio de uma cerimônia oculta, você realizou um
pacto com uma entidade misteriosa para obter poderes
mágicos. Essa voz nas sombras é enigmática, mas a dádiva concedida por ela é clara: a habilidade de conjurar
magias. Veja o capítulo 7 para as regras de conjuração.
As informações a seguir explicam como aplicar essas
regras às magias de Bruxo, que estão listadas mais
adiante na descrição da classe.
Truques. Você conhece dois truques de Bruxo
à sua escolha. Prestidigitação Arcana e Raio Místico
são recomendados. Ao alcançar um nível de Bruxo, 
você pode substituir um dos seus truques dessa
característica por outro truque de Bruxo à sua escolha.
Ao atingir os níveis 4 e 10 de Bruxo, você aprende
mais um truque de Bruxo à sua escolha, conforme
detalhado na coluna Truques da tabela Características
de Bruxo.
Espaços de Magia. A tabela Características de Bruxo
mostra quantos espaços de magia você tem para
conjurar suas magias de Bruxo de 1º a 5º círculo. A
tabela também mostra o círculo desses espaços, todos
do mesmo círculo. Você restaura todos os espaços
de Magia de Pacto gastos ao completar um Descanso
Curto ou Longo.
Por exemplo, quando você é um Bruxo de nível 5,
você tem dois espaços de magia de 3º círculo. Para
conjurar a magia Raio de Bruxa de 1º círculo, você deve
gastar um desses espaços e conjurá-la como uma magia
de 3º círculo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior
que estão disponíveis para você conjurar com essa
característica. Para começar, escolha duas magias de
Bruxo de 1º círculo. Danação e Enfeitiçar Pessoa são
recomendadas.
O número de magias em sua lista aumenta à medida
que você alcança níveis de Bruxo, conforme mostrado
na coluna Magias Preparadas da tabela Características
de Bruxo. Quando esse número aumentar, escolha magias adicionais de Bruxo até que o número de magias
em sua lista corresponda ao número da tabela. As magias escolhidas devem ser de um círculo não superior
mostrado na coluna círculo do Espaço da tabela para o
seu nível. Quando você atinge o nível 6, por exemplo,
você aprende uma nova magia de Bruxo, que pode ser
de 1º a 3º círculo.
Se outra característica de Bruxo lhe concede magias
sempre preparadas, elas não contam para o número de
magias que você pode preparar com essa característica,
mas ainda são consideradas magias de Bruxo para você.
Mudando Suas Magias Preparadas. Sempre que você
ganha um nível de Bruxo, pode substituir uma magia
da sua lista por outra magia de Bruxo de um nível
elegível.
Atributo de Conjuração. Carisma é o atributo de
conjuração para suas magias de Bruxo.
Foco de Conjuração. Você pode usar um Foco Arcano
como um Foco de Conjuração para suas magias de
Bruxo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 2, 'Astúcia Mágica', 'Ao final de um rito esotérico que você pode realizar
por 1 minuto, você recupera os espaços de magia das
Magias de Pacto gastos em um número igual à metade
da sua quantidade máxima (arredondado para cima).
Você pode usar esta característica novamente após
completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 3, 'Subclasse de Bruxo', 'Você adquire uma subclasse de Bruxo à sua escolha.
As subclasses Patrono Arquifada, Patrono Celestial,
Patrono Grande Antigo e Patrono Ínfero estão detalhadas após a descrição desta classe. Uma subclasse é
uma especialidade que concede a você características
em determinados níveis de Bruxo. Durante toda sua
jornada, você adquire cada uma das características de
sua subclasse de seu nível de Bruxo ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Bruxo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 9, 'Contatar Patrono', 'No passado, você entrava em contato com seu patrono
por meio de intermediários. Agora, você pode se comunicar diretamente com ele. Você sempre tem a magia Contato Extraplanar preparada. Com esta característica, você
pode conjurar a magia sem gastar um espaço de magia
para entrar em contato com seu patrono, e você é bem-sucedido automaticamente na salvaguarda da magia.
Você pode conjurar a magia com esta característica
novamente após completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 11, 'Arcana Mística', 'Seu patrono lhe concede um segredo mágico chamado
arcanum. Escolha uma magia de Bruxo de 6º círculo
com este arcanum.
Você pode conjurar sua magia arcanum uma vez sem
gastar um espaço de magia, e novamente desta forma
após completar um Descanso Longo.
Conforme mostrado na tabela Características de
Bruxo, você recebe outra magia de Bruxo à sua escolha
que pode ser conjurada deste modo ao atingir os níveis
de Bruxo 13 (magia de 7º círculo), 15 (magia de 8º círculo) e 17 (magia de 9º círculo). Você restaura todos os
usos da sua Arcana Mística ao completar um Descanso
Longo.
Ao alcançar um nível de Bruxo, você pode substituir
uma de suas magias de arcanum por outra magia de
Bruxo do mesmo círculo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
O talento Dádiva do Destino é recomendado.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 20, 'Mestre Místico', 'Ao usar sua característica Astúcia Mágica, você restaura todos os seus espaços de magia gastos das suas
Magias de Pacto.
Opções de Invocações Místicas
As opções de Invocações Místicas aparecem em ordem
alfabética.
Armadura de Sombras
Você pode conjurar Armadura Arcana em si sem gastar
um espaço de magia.
Explosão Agonizante
Pré-requisitos: Bruxo Nível 2 ou superior, um Truque de
Bruxo que Cause Dano
Escolha um dos seus truques conhecidos de Bruxo que
cause dano. Você pode adicionar seu modificador de
Carisma às jogadas de dano dessa magia.
Repetível. Você pode adquirir esta invocação mais
de uma vez, escolhendo um truque elegível diferente a
cada vez.
Explosão Repulsiva
Pré-requisitos: Bruxo Nível 2 ou superior, um Truque de
Bruxo que Cause Dano com uma Jogada de Ataque
Escolha um dos seus truques conhecidos de Bruxo que
exija uma jogada de ataque. Ao atingir uma criatura
Grande ou menor com esse truque, você pode empurrá-la até 3 metros para longe de você.
Repetível. Você pode adquirir esta invocação mais
de uma vez, escolhendo um truque elegível diferente a
cada vez.
Investimento do Mestre da Corrente
Pré-requisitos: Bruxo Nível 5 ou superior, Pacto da Corrente
Ao conjurar Convocar Familiar, você infunde o familiar
invocado com uma dose de seu poder místico, concedendo à criatura os seguintes benefícios.
Aéreo ou Aquático. O familiar obtém um Deslocamento de Voo ou um Deslocamento de Natação (à sua
escolha) de 12 metros.
Ataque Rápido. Como uma Ação Bônus, você pode
ordenar o familiar a executar a ação Atacar.
CD para Evitar sua Magia. Se o familiar forçar uma
criatura a realizar uma salvaguarda, ela usa a CD para
evitar sua magia.
Dano Necrótico ou Radiante. Sempre que o familiar
causar dano Contundente, Cortante ou Perfurante,
você pode substituir o dano por Necrótico ou Radiante.
Resistência. Quando o familiar sofre dano, você pode
executar uma Reação para conceder Resistência contra
esse dano.
Lamento das Sepulturas
Pré-requisito: Bruxo Nível 7 ou superior
Você pode conjurar Falar com Mortos sem gastar um
espaço de magia.
Lâmina Devoradora
Pré-requisito: Bruxo Nível 12 ou superior, Lâmina
Sedenta
O Ataque Extra da sua invocação Lâmina Sedenta
concede dois ataques extras em vez de um.
Lâmina Sedenta
Pré-requisitos: Bruxo Nível 5 ou superior, Pacto da Lâmina
Você adquire a característica Ataque Extra apenas
para sua arma de pacto e você pode atacar duas vezes
com ela, em vez de uma, quando executar a ação Atacar no seu turno.

Lança Mística
Pré-requisitos: Bruxo Nível 2 ou superior, um Truque de
Bruxo que Cause Dano
Escolha um dos seus truques conhecidos de Bruxo que
cause dano e tenha um alcance de 3 metros ou mais.
Ao conjurar essa magia, seu alcance aumenta em um
número de metros igual a 9 vezes o seu nível de Bruxo.
Repetível. Você pode adquirir esta invocação mais
de uma vez, escolhendo um truque elegível diferente a
cada vez.
Lições dos Grandes Antigos
Pré-requisito: Bruxo Nível 2 ou superior
Você recebeu conhecimento de uma entidade antiga do
multiverso, permitindo que você obtenha um talento
de Origem à sua escolha.
Repetível. Você pode adquirir esta invocação mais de
uma vez, escolhendo um talento de Origem diferente
cada vez.
Máscara das Muitas Faces
Pré-requisito: Bruxo Nível 2 ou superior
Você pode conjurar Disfarçar-se sem gastar um espaço
de magia.
Mente Mística
Você tem Vantagem em salvaguardas de Constituição
que realiza para manter a Concentração.
Mestre das Infindáveis Formas
Pré-requisito: Bruxo Nível 5 ou superior
Você pode conjurar Alterar-se sem gastar um espaço de
magia.
Olhar de Duas Mentes
Pré-requisito: Bruxo Nível 5 ou superior
Como uma Ação Bônus, você pode tocar uma criatura
voluntária e perceber através de seus sentidos até o
final do seu próximo turno. Enquanto a criatura estiver
no mesmo plano de existência que você, você pode executar uma Ação Bônus nos turnos subsequentes para
manter essa conexão, estendendo a duração até o final
do seu próximo turno. A conexão encerra se você não
a mantiver deste modo.
Ao perceber através dos sentidos da outra criatura,
você se beneficia de quaisquer sentidos especiais possuídos por ela e pode conjurar magias como se estivesse em seu espaço ou no espaço da outra criatura se
vocês dois estiverem a até 18 metros um do outro.
Pacto da Corrente
Você aprende a magia Convocar Familiar e pode conjurá-la como uma ação Usar Magia sem gastar um espaço
de magia.
Ao conjurar a magia, você escolhe uma das formas
normais para o seu familiar ou uma das seguintes formas especiais: Cobra Peçonhenta, Diabrete, Esfinge
Maravilhosa, Esqueleto, Pseudodragão, Quasit,
Slaad Girino, Sprite (veja o apêndice B para o bloco
de estatísticas do familiar).
Além disso, ao executar ação Atacar, você pode
renunciar a um de seus próprios ataques para permitir
que seu familiar realize um ataque próprio como uma
Reação dele.
Pacto da Lâmina
Como uma Ação Bônus, você pode conjurar uma arma
de pacto em sua mão — uma arma Corpo a Corpo
Simples ou Marcial à sua escolha com a qual você se
vincula — ou cria um vínculo com uma arma mágica
que você toca; você não pode se vincular a uma arma
mágica se outra pessoa estiver sintonizada ou outro
Bruxo tiver vínculo com ela. Até que o vínculo encerre,
você tem proficiência com a arma e pode usá-la como
Foco de Conjuração.
Ao atacar com a arma vinculada, você pode usar seu
modificador de Carisma para as jogadas de ataque e
dano em vez de usar Força ou Destreza; e você pode
causar dano Necrótico, Psíquico ou Radiante ou o tipo
de dano normal da arma.
Seu vínculo com a arma encerra se você executar a
Ação Bônus desta característica novamente, se a arma
estiver a mais de 1,5 metro de você por 1 minuto ou
mais, ou se você morrer. Uma arma conjurada desaparece quando o vínculo encerra.
Pacto do Tomo
Ao costurar fios de sombra, você conjura um livro em
sua mão ao final de um Descanso Curto ou Longo. Este
Livro das Sombras (você determina a aparência dele)
contém magia mística que só você pode acessar, concedendo-lhe os benefícios abaixo. O livro desaparece se
você conjurar outro livro com essa característica ou se
você morrer.
Truques e Rituais. Quando o livro surgir, escolha três
truques e duas magias de 1º círculo que tenham o marcador Ritual. As magias podem ser da lista de magias
de qualquer classe e devem ser magias que você ainda
não tem preparadas. Enquanto o livro estiver com
você, você tem as magias escolhidas preparadas e elas
funcionam como magias de Bruxo para você.
Foco de Conjuração. Você pode usar o livro como um
Foco de Conjuração.
Passo Ascendente
Pré-requisito: Bruxo Nível 5 ou superior
Você pode conjurar Levitação em si sem gastar um
espaço de magia.
Presente das Profundezas
Pré-requisito: Bruxo Nível 5 ou superior
Você pode respirar debaixo d’água e obter um Deslocamento de Natação igual ao seu Deslocamento.

Você também pode conjurar Respirar na Água uma
vez sem gastar um espaço de magia e novamente sempre que completar um Descanso Longo.
Presente dos Protetores
Pré-requisitos: Bruxo Nível 9 ou superior, Pacto do Tomo
Uma nova página aparece em seu Livro das Sombras
quando você o conjura. Com sua permissão, uma
criatura pode executar uma ação para escrever o nome
dela nesta página, que pode conter um número de
nomes igual ao seu modificador de Carisma (mínimo
de um nome).
Quando qualquer criatura cujo nome está na página
é reduzida a 0 Pontos de Vida, mas não morta imediatamente, a criatura magicamente tem 1 Ponto de Vida.
Uma vez que essa magia é acionada, nenhuma criatura pode se beneficiar dela até que você complete um
Descanso Longo.
Como uma ação Usar Magia, você pode apagar um
nome na página tocando nele.
Punição Mística
Pré-requisitos: Bruxo Nível 5 ou superior, Pacto da Lâmina
Uma vez por turno, ao atingir uma criatura com sua
arma de pacto, você pode gastar um espaço de Magia
de Pacto para causar 1d8 pontos de dano Energético
adicionais ao alvo, mais 1d8 por círculo do espaço de
magia, e pode impor ao alvo a condição Caído se ele for
Enorme ou menor.
Salto Sobrenatural
Pré-requisito: Bruxo Nível 2 ou superior
Você pode conjurar Salto em si sem gastar um espaço
de magia.
Sorvedouro de Vida
Pré-requisitos: Bruxo Nível 9 ou superior, Pacto da Lâmina
Uma vez por turno, ao atingir uma criatura com sua
arma de pacto, você pode causar à criatura 1d6 pontos
de dano Necrótico, Psíquico ou Radiante adicionais (à
sua escolha) e você pode gastar um de seus Dados de
Pontos de Vida para jogá-lo e recuperar um número de
Pontos de Vida igual ao resultado mais seu modificador
de Constituição (mínimo de 1 Ponto de Vida).
Uno com as Sombras
Pré-requisito: Bruxo Nível 5 ou superior
Enquanto estiver em uma área de Meia-luz ou Escuridão, você pode conjurar Invisibilidade em si sem gastar
um espaço de magia.
Vigor Ínfero
Pré-requisito: Bruxo Nível 2 ou superior
Você pode conjurar Vitalidade Vazia em si sem gastar
um espaço de magia. Ao conjurar a magia com essa
característica, você não joga o dado para os Pontos
de Vida Temporários, pois recebe automaticamente o
número máximo no dado.
Visão da Bruxa
Pré-requisito: Bruxo Nível 15 ou superior
Você tem Visão Verdadeira com um alcance de 9 metros.
Visão Diabólica
Pré-requisito: Bruxo Nível 2 ou superior
Você pode ver normalmente em Meia-luz e Escuridão
— mágicas e não mágicas — a até 36 metros de você.
Visões de Reinos Distantes
Pré-requisito: Bruxo Nível 9 ou superior
Você pode conjurar Olho Arcano sem gastar um espaço
de magia.
Visões Nebulosas
Pré-requisito: Bruxo Nível 2 ou superior
Você pode conjurar Imagem Silenciosa sem gastar um
espaço de magia.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 1, 'Conjuração', 'Você aprendeu a conjurar magias por meio de oração
e meditação. Veja o capítulo 7 para as regras sobre
conjuração de magias. As informações abaixo detalham como você usa essas regras com as magias de
Clérigo, explicadas na lista de magias de Clérigo mais
adiante na descrição da classe.
Truques. Você conhece três truques à sua escolha
da lista de magias de Clérigo. Chama Sagrada, Orientação e Taumaturgia são recomendados.
Sempre que você alcança um nível de Clérigo, pode
substituir um dos seus truques por outro truque à sua
escolha da lista de magias de Clérigo.
Quando alcançar os níveis 4 e 10 de Clérigo, você
aprende mais um truque à sua escolha da lista de
magias de Clérigo, conforme mostrado na coluna
Truques da tabela Características de Clérigo.
Espaços de Magia. A tabela Características de Clérigo mostra quantos espaços de magia você tem para
conjurar suas magias de 1º círculo ou superior. Você
recupera todos os espaços gastos quando completa
um Descanso Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de nível 1º circulo ou superior que estão disponíveis para você conjurar com
essa característica. Para começar, escolha quatro
magias de 1º círculo da lista de magias de Clérigo.
Bênção, Curar Ferimentos, Escudo da Fé e Raio Guia são
recomendadas.
O número de magias em sua lista aumenta à medida
que você alcança níveis de Clérigo, conforme mostrado na coluna Magias Preparadas da tabela Características de Clérigo. Sempre que esse número aumentar, escolha magias adicionais da lista de magias de
Clérigo até que o número de magias em sua lista seja
o mesmo do número da tabela. As magias escolhidas
devem ser de um círculo para o qual você possui
espaços de magia. Por exemplo, se você é um Clérigo de nível 3, sua lista de magias preparadas pode
incluir seis magias de 1º ou 2º círculo em qualquer
combinação.
Se outra característica de Clérigo lhe der magias
que você sempre tem preparadas, essas magias não
contam para o número de magias que você pode preparar com esta característica, mas que contam como
magias de Clérigo para você.
Mudando Suas Magias Preparadas. Sempre que
completar um Descanso Longo, você pode definir
sua lista de magias preparadas, substituindo qualquer
uma das magias por outras magias de Clérigo para as
quais você tem espaços de magia.
Atributo de Conjuração. Sabedoria é seu atributo de
conjuração para suas magias de Clérigo.
Foco de Conjuração. Você pode usar um Símbolo Sagrado como um Foco de Conjuração para suas magias
de Clérigo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 1, 'Ordem Divina', 'Você se dedicou a um dos seguintes papéis sagrados à
sua escolha.
Protetor. Treinado para a batalha, você adquire
proficiência com armas Marciais e treinamento com
Armadura Pesada.
Taumaturgo. Você conhece um truque adicional da
lista de magias de Clérigo. Além disso, sua conexão
mística com o divino lhe dá um bônus em seus testes
de Inteligência (Arcanismo ou Religião). O bônus é
igual ao seu modificador de Sabedoria (mínimo de +1).') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 2, 'Canalizar Divindade', 'Você pode canalizar energia divina diretamente dos
Planos Externos para alimentar efeitos mágicos. Você
começa com dois desses efeitos: Centelha Divina e Expulsar Mortos-Vivos, cada um descrito a seguir. Cada
vez que você usar o Canalizar Divindade desta classe,
escolha qual efeito de Canalizar Divindade deseja
realizar. Você obtém opções adicionais de efeitos em
níveis mais altos de Clérigo.
Você pode usar o Canalizar Divindade desta classe
duas vezes. Você recupera um uso gasto ao completar
um Descanso Curto e todos os usos gastos ao completar um Descanso Longo. Você adquire usos adicionais
ao atingir certos níveis de Clérigo, conforme mostrado na coluna Canalizar Divindade da tabela Características de Clérigo.
Se um efeito de Canalizar Divindade exigir uma
salvaguarda, a CD é igual a CD para evitar magia da
característica Conjuração desta classe.
Centelha Divina. Como uma ação Usar Magia, você
expõe seu Símbolo Sagrado para outra criatura à sua
vista a até 9 metros e canaliza energia divina nela.
Jogue 1d8 e adicione seu modificador de Sabedoria.
Você pode restaurar Pontos de Vida da criatura igual
ao resultado total ou forçar a criatura a realizar uma
salvaguarda de Constituição. Se falhar, a criatura sofre dano Necrótico ou Radiante (à sua escolha) igual
ao total. Em caso de sucesso, a criatura recebe metade
do dano (arredondado para baixo).
Você joga um d8 adicional quando atinge os níveis
de 7 (2d8), 13 (3d8) e 18 (4d8) de Clérigo.
Expulsar Mortos-Vivos. Como uma ação Usar Magia,
você mostra seu Símbolo Sagrado e repreende criaturas Mortas-Vivas. Cada Morto-Vivo à sua escolha
a até 9 metros de você deve realizar uma salvaguarda
de Sabedoria. Se a criatura falhar, ela está com as condições Amedrontado e Incapacitado por 1 minuto.
Pela duração da canalização, ela tenta se mover o mais
longe possível de você nos turnos dela. Este efeito se
encerra na criatura se ela sofrer algum dano, se você
está com a condição Incapacitado ou se você morrer.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 3, 'Subclasse de Clérigo', 'Você adquire uma subclasse de Clérigo à sua escolha.
Uma subclasse é uma especialização que lhe concede
características em determinados níveis de Clérigo. As
subclasses Domínio da Guerra, Domínio da Luz, Domínio da Trapaça e Domínio da Vida estão detalhadas
após a descrição desta classe. Para o resto de sua jornada, você recebe cada uma das características de sua
subclasse que são de seu nível de Clérigo ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo (veja o capítulo 5) ou outro talento à sua escolha
para o qual atenda os pré-requisitos. Você adquire
essa característica novamente nos níveis 8, 12 e 16 de
Clérigo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 5, 'Fulminar Mortos-Vivos', 'Ao usar Expulsar Mortos-Vivos, você pode jogar
uma quantidade de d8s igual ao seu modificador de
Sabedoria (mínimo de 1d8) e somar os resultados
jogados. Cada Morto-Vivo que falhar na salvaguarda
sofre dano Radiante igual ao resultado da soma dos
dados jogados. Esse dano não encerra o efeito de
Expulsar Mortos-Vivos.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 7, 'Golpes Abençoados', 'Você se infunde de poder divino em combate. Você
adquire uma das seguintes opções à sua escolha (se
você já tiver qualquer uma dessas opções de uma
subclasse de Clérigo em um livro antigo de D&D, use
apenas a opção escolhida para esta característica).
Conjuração Poderosa. Adicione seu modificador de
Sabedoria ao dano causado com qualquer truque de
Clérigo.
Golpe Divino. Uma vez em cada um dos seus turnos,
quando você atinge uma criatura com uma jogada de
ataque usando uma arma, você pode causar ao alvo
1d8 pontos de dano Necrótico ou Radiante (à sua
escolha) adicionais.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 10, 'Intervenção Divina', 'Você pode convocar sua divindade ou panteão para
intervir em seu nome. Como uma ação Usar Magia,
escolha qualquer magia de Clérigo de 5º círculo ou
inferior que não exija uma Reação para ser conjurada.
Como parte da mesma ação, você conjura essa magia
sem gastar espaço de magia ou precisar de componentes Materiais. Você não pode usar essa característica
novamente até completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 14, 'Golpes Abençoados Aprimorados', 'A opção que você escolheu para Golpes Abençoados
fica mais poderosa.
Conjuração Poderosa. Quando conjurar um truque
de Clérigo e causar dano a uma criatura com ele, você
pode conferir vitalidade a si ou a outra criatura a até
18 metros de você, concedendo um número de Pontos
de Vida Temporários igual ao dobro do seu modificador de Sabedoria.
Golpe Divino. O dano adicional de seu Golpe Divino
aumenta para 2d8.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo
5) ou outro talento à sua escolha para o qual se qualifica. Dádiva do Destino é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 20, 'Intervenção Divina Maior', 'Você pode convocar uma intervenção divina ainda mais poderosa. Quando usar sua característica
Intervenção Divina, você pode escolher Desejo como
opção de magia. Se fizer isso, não pode usar Intervenção Divina novamente até completar 2d4 Descansos
Longos.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 1, 'Conjuração', 'Você aprendeu a conjurar magias através do estudo
das forças místicas da natureza. Veja o capítulo 7
para as regras de conjuração. As informações abaixo
detalham como você usa essas regras com magias de
Druida, que aparecem na lista de magias de Druida
mais adiante na descrição da classe.
Truques. Você conhece dois truques à sua escolha da
lista de magias de Druida. Arte Druídica e Criar Chamas
são recomendadas.
Sempre que você alcança um nível de Druida, pode
substituir um de seus truques por outro truque à sua
escolha da lista de magias de Druida.
Ao atingir os níveis 4 e 10 de Druida, você aprende
mais um truque à sua escolha da lista de magias de
Druida, conforme mostrado na coluna Truques da
tabela Características de Druida.
Espaços de Magia. A tabela Características de Druida
mostra quantos espaços de magia você tem para conjurar suas magias de 1º círculo ou superior. Você restaura todos os espaços gastos ao completar um Descanso
Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior que
estão disponíveis para você conjurar com esta característica. Para começar, escolha quatro magias de 1º
círculo da lista de magias de Druida. Amizade Animal,
Curar Ferimentos, Fogo das Fadas e Onda Trovejante são
recomendadas.
O número de magias em sua lista aumenta à medida
que você alcança níveis de Druida, conforme mostrado
na coluna Magias Preparadas da tabela Características
de Druida. Sempre que esse número aumentar, escolha magias adicionais da lista de magias de Druida até
que o número de magias em sua lista corresponda ao
número da tabela. As magias escolhidas devem ser de
um círculo para o qual você possui espaços de magia.
Por exemplo, se você é um Druida de nível 3, sua lista
de magias preparadas pode incluir seis magias de 1º ou
2º círculo em qualquer combinação.
Se outra característica de Druida lhe der magias que
você sempre tem preparadas, essas magias não contam
para o número de magias que você pode preparar com 
esta característica, mas essas magias, de outra forma,
contam como magias de Druida para você.
Mudando Suas Magias Preparadas. Sempre que completar um Descanso Longo, você pode mudar sua lista
de magias preparadas, substituindo qualquer uma das
magias por outras magias de Druida para as quais você
tem espaços de magia.
Atributo de Conjuração. Sabedoria é seu atributo de
conjuração para suas magias de Druida.
Foco de Conjuração. Você pode usar um Foco Druídico como um Foco de Conjuração para suas magias de
Druida.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 1, 'Idioma Druídico', 'Você domina Druídico, o idioma secreto dos Druidas.
Ao aprender esse idioma antigo, você também adquiriu
a habilidade mágica de se comunicar com animais; você
sempre tem a magia Falar com Animais preparada.
Você pode usar Druídico para deixar mensagens
ocultas. Você e outros que conhecem Druídico identificam automaticamente tal mensagem. Outros podem
perceber a presença da mensagem com um teste de
Inteligência (Investigação) CD 15, mas não podem
decifrá-la sem magia.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 1, 'Ordem Primal', 'Você se dedicou a uma das seguintes funções sagradas
à sua escolha.
Protetor. Treinado para a batalha, você adquire
proficiência com armas Marciais e treinamento com
armadura Média.
Xamã. Você conhece um truque adicional da lista de
magias de Druida. Além disso, sua conexão mística com
a natureza lhe concede um bônus em seus testes de
Inteligência (Arcanismo ou Natureza). O bônus é igual
ao seu modificador de Sabedoria (bônus mínimo de +1).') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 2, 'Companheiro Selvagem', 'Você pode invocar um espírito da natureza que assume
a forma de um animal para auxiliá-lo. Como uma ação
Usar Magia, você pode gastar um espaço de magia ou
um uso de Forma Selvagem para conjurar a magia
Convocar Familiar sem componentes Materiais.
Ao conjurar a magia deste modo, o familiar é uma
criatura Feérica e desaparece ao completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 2, 'Forma Selvagem', 'O poder da natureza permite que você assuma a forma
de um animal. Como uma Ação Bônus, você multimorfa para uma forma Animal que você aprendeu com
esta característica (veja “Formas Conhecidas”, abaixo). Você fica nessa forma por um número de horas
igual à metade do seu nível de Druida, até usar Forma
Selvagem novamente, ter a condição Incapacitado ou
morrer. Você também pode sair da forma antes como
uma Ação Bônus.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 3, 'Subclasse de Druida', 'Você adquire uma subclasse de Druida à sua escolha.
As subclasses Círculo da Lua, Círculo da Terra, Círculo
das Estrelas e Círculo do Mar são detalhadas a seguir
neste capítulo. Uma subclasse é uma especialidade que
lhe concede características em determinados níveis de
Druida. Durante toda sua carreira, você recebe cada
uma das características de sua subclasse que são de seu
nível de Druida ou inferior.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Druida.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 5, 'Ressurgimento Selvagem', 'Uma vez em cada um de seus turnos, se você não tiver
mais usos de Forma Selvagem, pode recuperar um
uso gastando um espaço de magia (nenhuma ação é
necessária).
Além disso, você pode gastar um uso de Forma Selvagem (nenhuma ação é necessária) para recuperar um
espaço de magia de 1º círculo, mas não pode fazê-lo
novamente até completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 7, 'Fúria Elemental', 'O poder dos elementos flui através de você. Você recebe uma das seguintes opções à sua escolha.
Ataque Primal. Uma vez em cada um dos seus turnos,
ao atingir uma criatura com uma jogada de ataque
usando uma arma ou um ataque da forma Animal em
Forma Selvagem, pode causar 1d8 pontos de dano
Elétrico, Gélido, Ígneo ou Trovejante (à sua escolha
quando você atinge) adicional ao alvo.
Conjuração Poderosa. Adicione seu modificador de
Sabedoria ao dano causado com qualquer truque de
Druida.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 15, 'Fúria Elemental Aprimorada', 'A opção que você escolheu para Fúria Elemental fica
mais poderosa, conforme detalhado abaixo.
Ataque Primal. O dano adicional de seu Ataque Primal aumenta para 2d8.
Conjuração Poderosa. Ao conjurar um truque de
Druida com um alcance de 3 metros ou mais, o alcance
da magia aumenta para 90 metros.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 18, 'Magias Bestiais', 'Ao usar Forma Selvagem, você pode conjurar magias
na forma Animal, exceto magias que tenham um com-

ponente Material com um custo especificado ou que
consuma seu componente Material.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
Dádiva da Viagem Dimensional é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 20, 'Arquidruida', 'A vitalidade da natureza floresce constantemente dentro de você, concedendo-lhe os seguintes benefícios.
Forma Selvagem Eterna. Sempre que você joga Iniciativa e não tem mais usos de Forma Selvagem, você
recupera um uso gasto dela.
Natureza Xamânica. Você pode converter usos de
Forma Selvagem em um espaço de magia (nenhuma
ação é necessária). Escolha um número de seus usos
não gastos de Forma Selvagem e transforme-os em
um único espaço de magia, com cada uso contribuindo
com espaços de magia de 2º círculo. Por exemplo, se
você transformar dois usos de Forma Selvagem, você
produz um espaço de magia de 4º círculo. Após usar
este benefício, você não pode fazê-lo novamente até
completar um Descanso Longo.
Longevidade. A magia primitiva que você utiliza permite que você envelheça mais lentamente: para cada
dez anos que passam, seu corpo envelhece apenas um.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 1, 'Conjuração', 'Através da sua magia inata, você pode conjurar magias.
Veja o capítulo 7 para as regras sobre conjuração de
magias. As informações abaixo detalham como você
usa essas regras com magias de Feiticeiro, que aparecem na lista de magias de Feiticeiro mais adiante na
descrição da classe.
Truques. Você conhece quatro truques de Feiticeiro
à sua escolha. Explosão Elemental, Luz, Prestidigitação Arcana e Toque Chocante são recomendados. Ao alcançar
um nível de Feiticeiro, você pode substituir um dos
seus truques dessa característica por outro truque de
Feiticeiro à sua escolha.
Ao atingir os níveis 4 e 10 de Feiticeiro, você aprende
mais um truque de Feiticeiro à sua escolha, conforme
detalhado na coluna Truques da tabela Características
de Feiticeiro.
Espaços de Magia. A tabela Características de Feiticeiro mostra quantos espaços de magia você tem para
conjurar suas magias de 1º círculo ou superior. Você
restaura todos os espaços gastos ao completar um
Descanso Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior que
estão disponíveis para você conjurar com essa característica. Para começar, escolha duas magias de Feiticeiro
de 1º círculo. Detectar Magia e Mãos Flamejantes são
recomendadas.
O número de magias em sua lista aumenta à medida que você atinge níveis de Feiticeiro, conforme
mostrado na coluna Magias Preparadas da tabela
Características de Feiticeiro. Sempre que esse número
aumentar, escolha magias adicionais da lista de magias
de Feiticeiro até que o número de magias em sua lista
corresponda ao número da tabela. As magias escolhidas devem ser de um círculo para o qual você possui
espaços de magia. Por exemplo, se você é um Feiticeiro
de nível 3, sua lista de magias preparadas pode incluir
seis magias de Feiticeiro de 1º ou 2º círculo em qualquer combinação.
Se outra característica de Feiticeiro lhe concede
magias sempre preparadas, elas não contam para o
número de magias que você pode preparar com essa
característica, mas ainda são consideradas magias de
Feiticeiro para você.
Mudando Suas Magias Preparadas. Sempre que você
obtém um nível de Feiticeiro, pode substituir uma
magia em sua lista por outra magia de Feiticeiro para a
qual você tem espaços de magia.
Atributo de Conjuração. Carisma é seu atributo de
conjuração para suas magias de Feiticeiro.
Foco de Conjuração. Você pode usar um Foco Arcano
como um Foco de Conjuração para suas magias de
Feiticeiro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 1, 'Feitiçaria Inata', 'Um evento em seu passado deixou uma marca permanente em você, lhe infundindo magia latente. Como
uma Ação Bônus, você pode liberar essa magia por
1 minuto, durante o qual você adquire os seguintes
benefícios:
A CD para evitar suas magias de Feiticeiro aumenta
em 1.
Você tem Vantagem nas jogadas de ataque das magias de Feiticeiro que conjurar.
Você pode usar essa característica duas vezes e restaura todos os usos gastos ao completar um Descanso
Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 2, 'Fonte de Magia', 'Você pode aproveitar a fonte de magia dentro de si.
Essa fonte é representada por Pontos de Feitiçaria,
que permitem que você crie uma variedade de efeitos
mágicos.
Você tem 2 Pontos de Feitiçaria e adquire mais à medida que atinge níveis mais altos, conforme detalhado
na coluna Pontos de Feitiçaria da tabela Características
de Feiticeiro. Você não pode ter mais Pontos de Feitiçaria do que o número mostrado na tabela para o seu
nível e restaura todos os Pontos de Feitiçaria gastos ao
completar um Descanso Longo.
Você pode usar seus Pontos de Feitiçaria para abastecer as opções abaixo, juntamente com outras características, como Metamagia, que usam esses pontos.
Convertendo Espaços de Magia em Pontos de Feitiçaria. Você pode gastar um espaço de magia para receber
um número de Pontos de Feitiçaria igual ao círculo do
espaço (nenhuma ação é necessária).
Criando Espaços de Magia. Como uma Ação Bônus,
você pode transformar Pontos de Feitiçaria não gastos
em um espaço de magia. A tabela Criando Espaços de
Magia mostra o custo de criar um espaço de magia
de um determinado círculo e lista o nível mínimo de
Feiticeiro que você deve ter para criar um espaço. Você
pode criar um espaço de magia não superior ao 5º
círculo.
Qualquer espaço de magia que você criar com essa
característica desaparece ao completar um Descanso
Longo.
Criando Espaços de Magia
Círculo de Espaço de Magia Custo de Ponto de Feitiçaria Nível Mín. de Feiticeiro
1 2 2
2 3 3
3 5 5
4 6 7
5 7 9') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 2, 'Metamagia', 'Sua magia flui de dentro para fora, permitindo que
você ajuste suas magias conforme necessário. Você
adquire duas opções de Metamagia à sua escolha em
“Opções de Metamagia”, que são apresentadas mais
adiante na descrição desta classe. Essas opções podem
ser usadas para modificar temporariamente as magias
que conjura, consumindo a quantidade correspondente
de Pontos de Feitiçaria.
Você pode usar apenas uma opção de Metamagia
em uma magia ao conjurá-la, a menos que indicado de
outra forma em uma dessas opções.
Ao atingir um nível de Feiticeiro, você pode substituir
uma de suas opções de Metamagia por uma que não
conhece. Você adquire mais duas opções no nível 10 de
Feiticeiro e mais duas opções no nível 17 de Feiticeiro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 3, 'Subclasse de Feiticeiro', 'Você adquire uma subclasse de Feiticeiro à sua escolha.
As subclasses Feitiçaria Aberrante, Feitiçaria Dracônica, Feitiçaria Mecânica, Feitiçaria Selvagem estão detalhadas após a descrição desta classe. Uma subclasse
é uma especialidade que concede a você características
em determinados níveis de Feiticeiro. Durante toda sua
jornada, você adquire cada uma das características de
sua subclasse de seu nível de Feiticeiro ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para o
qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Feiticeiro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 5, 'Restauração Feiticeira', 'Ao completar um Descanso Curto, você pode recuperar
os Pontos de Feitiçaria gastos, mas não mais do que um
número igual à metade do seu nível de Feiticeiro (arredondado para baixo). Você só pode usar esta característica novamente após completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 7, 'Feitiçaria Encarnada', 'Quando não houver mais usos de Feitiçaria Inata, você
pode usá-la se gastar 2 Pontos de Feitiçaria ao executar
a Ação Bônus para ativá-la.
Além disso, enquanto sua característica Feitiçaria
Inata estiver ativa, você pode usar até duas de suas
opções de Metamagia em cada magia conjurada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
Dádiva da Viagem Dimensional é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 20, 'Apoteose Arcana', 'Enquanto sua característica Feitiçaria Inata estiver
ativa, você pode usar uma opção de Metamagia em
cada um de seus turnos sem gastar Pontos de Feitiçaria
com ela.
Opções de Metamagia
As seguintes opções estão disponíveis para sua característica Metamagia. As opções são apresentadas em
ordem alfabética.
Magia Acelerada
Custo: 2 Pontos de Feitiçaria
Ao conjurar uma magia que tenha um tempo de
conjuração de uma ação, você pode gastar 2 Pontos
de Feitiçaria para alterar o tempo de conjuração para
uma Ação Bônus para esta conjuração. Você não pode
modificar uma magia deste modo se já conjurou uma
magia de 1º círculo ou superior no turno atual, nem
pode conjurar uma magia de 1º círculo ou superior
neste turno após modificar uma magia deste modo.
Magia Agravada
Custo: 2 Pontos de Feitiçaria
Ao conjurar uma magia que força uma criatura a
realizar uma salvaguarda, você pode gastar 2 Pontos de
Feitiçaria para conceder a um alvo da magia Desvantagem em salvaguardas contra a magia.
Magia Buscadora
Custo: 1 Ponto de Feitiçaria
Ao realizar uma jogada de ataque com uma magia e
errar, você pode gastar 1 Ponto de Feitiçaria para jogar
novamente o d20 e deve usar o novo resultado.

Você pode usar Magia Buscadora mesmo que já tenha usado uma opção diferente de Metamagia durante
a conjuração da magia.
Magia Cautelosa
Custo: 1 Ponto de Feitiçaria
Ao conjurar uma magia que força outras criaturas a
realizar uma salvaguarda, você pode proteger algumas dessas criaturas da força total da magia. Para
isso, gaste 1 Ponto de Feitiçaria e escolha um número
dessas criaturas igual até seu modificador de Carisma
(mínimo de uma criatura). Uma criatura escolhida é
automaticamente bem-sucedida na salvaguarda contra
a magia, e não sofre dano se normalmente sofreria
metade do dano em caso de sucesso.
Magia Distante
Custo: 1 Ponto de Feitiçaria
Ao conjurar uma magia que tenha um alcance de pelo
menos 1,5 metro, você pode gastar 1 Ponto de Feitiçaria para dobrar o alcance da magia. Ou quando você
conjura uma magia que tem um alcance de Toque, você
pode gastar 1 Ponto de Feitiçaria para que o alcance da
magia seja 9 metros.
Magia Duplicada
Custo: 1 Ponto de Feitiçaria
Ao conjurar uma magia, como Enfeitiçar Pessoa, que
pode ser conjurada com um espaço de magia de círculo
superior para atingir uma criatura adicional, você pode
gastar 1 Ponto de Feitiçaria para aumentar o círculo
efetivo da magia em 1.
Magia Persistente
Custo: 1 Ponto de Feitiçaria
Ao conjurar uma magia que tenha uma duração de 1
minuto ou mais, você pode gastar 1 Ponto de Feitiçaria para dobrar sua duração para até o máximo de 24
horas.
Se a magia afetada exigir Concentração, você tem
Vantagem em qualquer salvaguarda que realizar para
manter essa Concentração.
Magia Potencializada
Custo: 1 Ponto de Feitiçaria
Ao jogar dano para uma magia, você pode gastar 1 Ponto de Feitiçaria para jogar novamente um número de
dados de dano igual a até seu modificador de Carisma
(mínimo de um), e deve usar os novos resultados.
Você pode usar Magia Potencializada mesmo que
já tenha usado uma opção diferente de Metamagia
durante a conjuração da magia.
Magia Sutil
Custo: 1 Ponto de Feitiçaria
Ao conjurar uma magia, você pode gastar 1 Ponto de
Feitiçaria para conjurá-la sem quaisquer componentes
Verbais, Somáticos ou Materiais, exceto componentes
Materiais consumidos pela magia ou que têm um custo
detalhado na magia.
Magia Transmutada
Custo: 1 Ponto de Feitiçaria
Ao conjurar uma magia que cause um tipo de dano da
lista a seguir, você pode gastar 1 Ponto de Feitiçaria
para alterar esse tipo de dano para um dos outros tipos
listados: Ácido, Elétrico, Gélido, Ígneo, Trovejante,
Venenoso.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 1, 'Conjuração', 'Você aprendeu a canalizar a essência mágica da natureza para conjurar magias. Veja o capítulo 7 para as
regras sobre conjuração de magias. As informações
abaixo detalham como você usa essas regras com as
magias de Guardião, explicadas na lista de magias de
Guardião mais adiante na descrição da classe.
Espaços de Magia. A tabela Características de Guardião mostra quantos espaços de magia você tem para
conjurar suas magias de 1º círculo ou superior. Você
restaura todos os espaços gastos ao completar um
Descanso Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior que
estão disponíveis para você conjurar com esta característica. Para começar, escolha duas magias de Guardião
de 1º círculo. Curar Ferimentos e Golpe Constritor são
recomendadas.
O número de magias em sua lista aumenta à medida que você atinge níveis de Guardião, conforme
mostrado na coluna Magias Preparadas da tabela
Características de Guardião. Sempre que esse número
aumentar, escolha magias adicionais da lista de magias
de Guardião até que o número de magias em sua lista
corresponda ao número da tabela. As magias escolhidas devem ser de um círculo para o qual você possui
espaços de magia. Por exemplo, se você é um Guardião
de nível 5, sua lista de magias preparadas pode incluir
seis magias de Guardião de 1º ou 2º círculo em qualquer combinação.
Se outra característica de Guardião lhe der magias
que você sempre tem preparadas, essas magias não
contam para o número de magias que você pode preparar com esta característica, mas essas magias, de outra
forma, contam como magias de Guardião para você.
Mudando Suas Magias Preparadas. Sempre que completar um Descanso Longo, você pode substituir uma
magia em sua lista por outra magia de Guardião para a
qual você tem espaços de magia.
Atributo de Conjuração. Sabedoria é seu atributo de
conjuração para suas magias de Guardião.
Foco de Conjuração. Você pode usar um Foco Druídico como um Foco de Conjuração para suas magias de
Guardião.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 1, 'Inimigo Favorito', 'Você sempre tem a magia Marca do Predador preparada.
Você pode conjurá-la duas vezes sem gastar um espaço
de magia, e você restaura todos os usos gastos desta
característica ao completar um Descanso Longo.
O número de vezes que você pode conjurar a magia
sem um espaço de magia aumenta ao atingir certos
níveis de Guardião, conforme mostrado na coluna Inimigo Favorito da tabela Características de Guardião.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 1, 'Maestria em Arma', 'Seu treinamento com armas permite que você use
as propriedades de maestria de dois tipos de armas à
sua escolha com as quais você tem proficiência, como
Arcos Longos e Espadas Curtas.
Sempre que completar um Descanso Longo, você
pode alterar os tipos de armas que escolheu. Por exemplo, você pode mudar para usar as propriedades de
maestria de Cimitarras e Espadas Longas.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 2, 'Estilo de Luta', 'Você adquire um talento Estilo de Luta à sua escolha
(veja também o capítulo 5). Em vez de escolher um
desses talentos, você pode escolher a opção abaixo.
Combatente Druídico. Você aprende dois truques
de Druida à sua escolha. Fagulha Estelar e Orientação
são recomendados. Os truques escolhidos contam
como magias de Guardião para você, e Sabedoria é
seu atributo de conjuração para eles. Sempre que
você atingir um nível de Guardião, pode substituir um
desses truques por outro truque de Druida.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 2, 'Explorador Hábil', 'Graças às suas viagens, você adquire os seguintes
benefícios.
Especialista. Escolha uma perícia na qual você tenha
proficiência, mas não seja Especialista. Você obtém
Especialização nessa perícia.
Idiomas. Você conhece dois idiomas à sua escolha da
tabela de idiomas no capítulo 2.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 3, 'Subclasse de Guardião', 'Você adquire uma subclasse de Guardião à sua escolha.
As subclasses Andarilho Feérico, Caçador, Senhor das
Feras e Vigilante das Sombras estão detalhadas após a
descrição desta classe. Uma subclasse é uma especialidade que concede a você características em determinados níveis de Guardião. Durante toda sua jornada, você
adquire cada uma das características de sua subclasse
de seu nível de Guardião ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo (veja o capítulo 5) ou outro talento à sua escolha
para o qual atenda os pré-requisitos. Você adquire
essa característica novamente nos níveis 8, 12 e 16 de
Guardião.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 5, 'Ataque Extra', 'Você pode atacar duas vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 6, 'Errante', 'Seu Deslocamento aumenta em 3 metros enquanto
você não estiver usando Armadura Pesada. Você também tem um Deslocamento de Escalada e um Deslocamento de Natação igual ao seu Deslocamento.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 9, 'Especialista', 'Escolha duas perícias nas quais você tem proficiência,
mas não seja Especialista. Você obtém Especialização
nessas perícias.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 10, 'Incansável', 'As forças primordiais agora ajudam a impulsioná-lo em
suas jornadas, concedendo-lhe os seguintes benefícios.
Pontos de Vida Temporários. Como uma ação Usar
Magia, você pode conceder a si um número de Pontos
de Vida Temporários igual a 1d8 mais seu modificador
de Sabedoria (mínimo de 1). Você pode usar essa ação
um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez) e restaura todos os usos
gastos ao completar um Descanso Longo.
Redução de Exaustão. Sempre que completar um
Descanso Curto, seu nível de Exaustão, se houver,
reduz em 1.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 13, 'Predador Implacável', 'Sofrer dano não quebra sua Concentração da Marca do
Predador.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 14, 'Véu da Natureza', 'Você invoca espíritos da natureza para se esconder magicamente. Como uma Ação Bônus, você pode conceder a si a condição Invisível até o final do seu próximo
turno.
Você pode usar essa característica um número de vezes igual ao seu modificador de Sabedoria (mínimo de
uma vez) e restaura todos os usos gastos ao completar
um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 17, 'Caçador Preciso', 'Você tem Vantagem em jogadas de ataque contra a
criatura marcada pela sua Marca do Predador.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 18, 'Sentidos Selvagens', 'Sua conexão com as forças da natureza lhe concede
Visão às Cegas com um alcance de 9 metros.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
Dádiva da Viagem Dimensional é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 20, 'Matador de Inimigos Favoritos', 'O dado de dano da sua Marca do Predador é um d10 em
vez de um d6.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 1, 'Estilo de Luta', 'Você aprimorou suas proezas marciais e tem um
talento de Estilo de Luta à sua escolha (veja também o
capítulo 5).
Sempre que atinge um nível de Guerreiro, você pode
substituir o talento que escolheu por um talento diferente de Estilo de Luta.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 1, 'Maestria em Arma', 'Seu treinamento com armas permite que você utilize
as propriedades de maestria com três tipos de armas
Simples ou Marciais à sua escolha. Sempre que completar um Descanso Longo, você pode praticar movimentos
com armas e alterar uma dessas escolhas de armas.
Ao alcançar certos níveis de Guerreiro, você adquire a
habilidade de usar as propriedades de maestria de mais
tipos de armas, conforme mostrado na coluna Maestria
em Armas da tabela Características de Guerreiro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 1, 'Recuperar Fôlego', 'Você tem uma reserva limitada de resistência física e
mental que pode usar. Como uma Ação Bônus, você
pode usá-la para recuperar Pontos de Vida iguais a
1d10 mais seu nível de Guerreiro.
Você pode usar essa característica duas vezes. Você
recupera um uso gasto quando completa um Descanso
Curto e restaura todos os usos gastos quando completa
um Descanso Longo.
Ao atingir certos níveis de Guerreiro, você adquire
mais usos dessa característica, conforme mostrado na
coluna Recuperar Fôlego da tabela Características de
Guerreiro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 2, 'Mente Tática', 'Você tem uma mente para táticas dentro e fora do
campo de batalha. Ao falhar em um teste de atributo,
você pode gastar um uso de seu Recuperar Fôlego
para tentar alcançar a vitória. Em vez de recuperar
Pontos de Vida, você joga 1d10 e adiciona o resultado
ao teste de atributo, potencialmente transformando-o
em sucesso. Se o teste ainda assim falhar, esse uso do
Recuperar Fôlego não é gasto.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 2, 'Surto de Ação', 'Você pode se esforçar além de seus limites normais por
um momento. No seu turno, você pode executar uma
ação adicional, exceto a ação Usar Magia.
Após usar esta característica, você não pode usá-la
novamente até completar um Descanso Curto ou Longo. A partir do nível 17, você pode usá-lo duas vezes antes de um descanso, mas apenas uma vez em um turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 3, 'Subclasse de Guerreiro', 'Você adquire uma subclasse de Guerreiro à sua escolha. As subclasses Campeão, Cavaleiro Místico, Combatente Psíquico e Mestre da Batalha estão detalhadas
após a descrição desta classe. Uma subclasse é uma
especialidade que concede a você características em
determinados níveis de Guerreiro. Pelo resto de sua
jornada, você adquire cada uma das características de
sua subclasse de seu nível de Guerreiro ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para o
qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 6, 8, 12, 14 e 16 de Guerreiro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 5, 'Ajuste Tático', 'Sempre que executar uma Ação Bônus para seu Recuperar Fôlego, você pode mover-se até metade do seu
Deslocamento sem provocar Ataques de Oportunidade.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 5, 'Ataque Extra', 'Você pode atacar duas vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 9, 'Indomável', 'Ao falhar em uma salvaguarda, você pode jogá-la
novamente adicionando um bônus igual ao seu nível de
Guerreiro. Você deve usar o novo resultado e não pode
usar essa característica novamente até completar um
Descanso Longo.
A partir do nível 13, você pode usar essa característica
duas vezes antes de um Descanso Longo e três vezes
antes de um Descanso Longo ao atingir o nível 17.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 9, 'Mestre Tático', 'Ao atacar com uma arma cuja propriedade de maestria
você pode usar, você pode substituir essa propriedade
pela propriedade Empurrar, Drenar ou Lentidão para
esse ataque.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 11, 'Dois Ataques Extras', 'Você pode atacar três vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 13, 'Ataques Estudados', 'Você estuda seus oponentes e aprende com cada ataque que realiza. Se você realizar uma jogada de ataque
contra uma criatura e errar, você tem Vantagem em
sua próxima jogada de ataque contra essa criatura
antes do final do seu próximo turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
Dádiva da Proeza em Combate é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 20, 'Três Ataques Extras', 'Você pode atacar quatro vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 1, 'Ataque Furtivo', 'Você sabe atacar sutilmente, explorando a distração
do inimigo. Uma vez por turno, ao atingir uma criatura
com uma jogada de ataque em que tem Vantagem com
uma arma com Acuidade ou uma arma à Distância,
você pode causar 1d6 pontos de dano adicional do tipo
de dano da arma.
Você não precisa ter Vantagem na jogada de ataque
se pelo menos um de seus aliados estiver a até 1,5 metro do alvo, e o aliado não tem a condição Incapacitado
e você não tem Desvantagem na jogada de ataque.
O dano adicional aumenta à medida que você adquire níveis de Ladino, conforme mostrado na coluna
Ataque Furtivo da tabela Características de Ladino.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 1, 'Especialista', 'Você obtém Especialização (veja o glossário de regras)
em duas de suas perícias, à sua escolha, nas quais já
seja proficiente. Furtividade e Prestidigitação são recomendadas se você tiver proficiência nelas.
No nível 6 de Ladino, você obtém Especialização em
mais duas perícias nas quais já seja proficiente à sua
escolha.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 1, 'Gíria do Ladrão', 'Você aprendeu vários idiomas nas comunidades onde
usou seus talentos gatunos. Você conhece a Gíria dos
Ladrões e outro idioma à sua escolha, que você escolhe
nas tabelas de idiomas no capítulo 2.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 1, 'Maestria em Arma', 'Seu treinamento com armas permite que você use
as propriedades de maestria de dois tipos de armas à
sua escolha com as quais você tem proficiência, como
Adagas e Arcos Curtos.
Ao completar um Descanso Longo, você pode alterar
os tipos de armas que escolheu. Por exemplo, você
pode trocar para as propriedades de maestria de Cimitarras e Espadas Curtas.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 2, 'Ação Ardilosa', 'Seu pensamento rápido e agilidade permitem que você
se mova e aja rapidamente. No seu turno, você pode
executar uma das seguintes ações como uma Ação
Bônus: Correr, Desengajar ou Esconder.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 3, 'Mira Firme', 'Como uma Ação Bônus, você concede a si mesmo
Vantagem em sua próxima jogada de ataque no turno
atual. Você pode usar esta característica somente se
não tiver se movido durante este turno e, após usá-la,
seu Deslocamento é 0 até o final do turno atual.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 3, 'Subclasse de Ladino', 'Você adquire uma subclasse de Ladino à sua escolha.
As subclasses Adaga Espiritual, Assassino, Ladrão e
Trapaceiro Arcano estão detalhadas após a descrição
desta classe. Uma subclasse é uma especialidade que
concede a você características em determinados níveis
de Ladino. Durante toda sua jornada, você adquire
cada uma das características de sua subclasse de seu
nível de Ladino ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atende os pré-requisitos. Você adquire essa
característica novamente nos níveis 8, 10, 12 e 16 de
Ladino.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 5, 'Golpe Astuto', 'Você encontrou maneiras astutas de aplicar seu Ataque
Furtivo. Ao causar dano com ele, você pode adicionar
um dos seguintes efeitos de Golpe Astuto, cada um
com um custo em dados que deve ser subtraído do
dano total do Ataque Furtivo. Remova o dado antes de
jogar, e o efeito ocorre imediatamente após o dano. Por
exemplo, ao escolher o efeito Envenenar, retire 1d6 de
dano do Ataque Furtivo antes de jogá-lo.
Se um efeito de Golpe Astuto exigir uma salvaguarda, a CD é igual a 8 mais seu modificador de Destreza e
Bônus de Proficiência.
Envenenar (Custo: 1d6). Você adiciona uma toxina ao
seu ataque, forçando o alvo a realizar uma salvaguarda de Constituição. Se falhar, o alvo tem a condição
Envenenado por 1 minuto. No final de cada um dos
turnos do alvo Envenenado, ele repete a salvaguarda,
encerrando o efeito em si em caso de sucesso.
Para usar esse efeito, você deve ter um Kit de Veneno
com você.
Retirada (Custo: 1d6). Imediatamente após o ataque,
você se move até metade do seu Deslocamento sem
provocar Ataques de Oportunidade.
Tropeço (Custo: 1d6). Se o alvo for Grande ou menor,
ele deve ser bem-sucedido em uma salvaguarda de
Destreza ou tem a condição Caído.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 5, 'Esquiva Sobrenatural', 'Quando um atacante à sua vista o atinge com uma
jogada de ataque, você pode executar uma Reação para
reduzir o dano pela metade do ataque (arredondado
para baixo).') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 7, 'Evasão', 'Você pode se esquivar com agilidade do caminho de
certos perigos. Ao ser alvo de um efeito que permita
uma salvaguarda de Destreza para receber apenas metade do dano, você não sofre dano se for bem-sucedido na salvaguarda e sofre metade do dano se falhar.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 7, 'Talento Confiável', 'Ao realizar um teste de atributo que lhe permita
adicionar seu bônus de proficiência em uma perícia ou
ferramenta, você pode tratar uma jogada de d20 igual
a 9 ou menos como se fosse 10.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 11, 'Golpe Astuto Aprimorado', 'Você pode usar até dois efeitos de Golpe Astuto ao
causar dano de Ataque Furtivo, pagando o custo do
dado por cada efeito.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 14, 'Golpes Sujos', 'Você praticou novas maneiras de usar seu Ataque
Furtivo de forma engenhosa. Os seguintes efeitos agora
estão entre suas opções de Golpe Astuto.
Aturdir (Custo: 2d6). O alvo deve ser bem-sucedido
em uma salvaguarda de Constituição ou, no próximo
turno, pode apenas se mover, executar uma ação ou
uma Ação Bônus.
Nocaute (Custo: 6d6). O alvo deve ser bem-sucedido
em uma salvaguarda de Constituição ou tem a condição Inconsciente por 1 minuto ou até sofrer qualquer
dano. O alvo Inconsciente repete a salvaguarda no final
de cada um dos turnos dele, encerrando o efeito em
caso de sucesso.
Obscurecer (Custo: 3d6). O alvo deve ser bem-sucedido em uma salvaguarda de Destreza, ou tem a condição Cego até o final do próximo turno dele.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 15, 'Mente Escorregadia', 'Sua mente astuta é excepcionalmente difícil de controlar. Você adquire proficiência em salvaguardas de
Sabedoria e Carisma.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 18, 'Elusivo', 'Você é tão evasivo que os atacantes raramente conseguem vantagem. Nenhuma jogada de ataque pode
ter Vantagem contra você, a menos que você tenha a
condição Incapacitado.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
A Dádiva do Espírito da Noite é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 20, 'Golpe de Sorte', 'Você tem uma vocação maravilhosa para ter sucesso
quando necessário. Se você falhar em um Teste de
D20, pode transformar o resultado em um 20.
Após usar essa característica, você não pode usá-
-la novamente até completar um Descanso Curto ou
Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 1, 'Adepto de Ritual', 'Você pode conjurar qualquer magia como um Ritual se
essa magia tiver o marcador Ritual e a magia estiver em
seu livro de magias. Você não precisa ter a magia preparada, mas deve ler o livro para conjurar uma magia
deste modo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 1, 'Conjuração', 'Como estudante de magia arcana, você aprendeu a
conjurar magias. Veja o capítulo 7 para as regras sobre
conjuração de magias. As informações abaixo detalham
como você usa essas regras com magias de Mago, que
aparecem na lista de magias de Mago mais adiante na
descrição da classe.
Truques. Você conhece três truques de Mago à
sua escolha. Luz, Mãos Mágicas e Raio de Gelo são
recomendados. Ao completar um Descanso Longo,
você pode substituir um dos seus truques dessa
característica por outro truque de Mago à sua escolha.
Ao atingir os níveis 4 e 10 de Mago, você aprende
mais um truque de Mago à sua escolha, conforme
detalhado na coluna Truques da tabela Características
de Mago.
Livro de Magias. Seu aprendizado de mago culminou
na criação de um livro único: seu livro de magias. É
um objeto Minúsculo que pesa 1,5 quilo, contém 100
páginas e pode ser lido apenas por você ou por alguém
que conjure Identificar. Você determina a aparência
e os materiais do livro, como um tomo com bordas
douradas ou uma coleção de pergaminhos amarrados
com barbante.
O livro contém as magias de 1º círculo ou superior
que você conhece. Ele começa com seis magias de
mago 1º círculo à sua escolha. Armadura Arcana, Detectar Magia, Mísseis Mágicos, Onda Trovejante, Queda Suave
e Sono são recomendadas.
Ao atingir um nível de Mago após o primeiro, adicione duas magias de Mago à sua escolha ao seu livro de
magias. Cada uma dessas magias deve ser de um círculo
para o qual você tenha espaços de magia, conforme detalhado na tabela Características de Mago. As magias
são o ponto culminante da pesquisa arcana que você
faz regularmente.
Espaços de Magia. A tabela Características de Mago
mostra quantos espaços de magia você tem para conjurar
suas magias de 1º círculo ou superior. Você restaura todos
os espaços gastos ao completar um Descanso Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior que
estão disponíveis para você conjurar com essa característica. Para isso, escolha quatro magias do seu livro de
magias. As magias escolhidas devem ser de um círculo
para o qual você tenha espaços de magia.
O número de magias em sua lista aumenta à medida
que você alcança níveis de Mago, conforme detalhado
na coluna Magias Preparadas da tabela Características
de Mago. Sempre que esse número aumentar, escolha
magias adicionais de Mago até que o número de magias em sua lista corresponda ao número na tabela. As
magias escolhidas devem ser de um círculo para o qual
você possua espaços de magia. Por exemplo, se você
é um Mago de nível 3, sua lista de magias preparadas,
escolhidas do seu livro de magias, pode incluir seis magias de 1º ou 2º círculo, em qualquer combinação.
Se outra característica de Mago lhe conceder magias
que você sempre tem preparadas, essas magias não
contam para o número de magias que você pode preparar com esta característica, mas essas magias, de outra
forma, contam como magias de Mago para você.
Mudando Suas Magias Preparadas. Ao completar um
Descanso Longo, você pode alterar sua lista de magias
preparadas, substituindo qualquer uma das magias por
outras do seu livro de magias.
Atributo de Conjuração. Inteligência é seu atributo de
conjuração para suas magias de Mago.
Foco de Conjuração. Você pode usar um Foco Arcano
ou seu livro de magias como um Foco de Conjuração
para suas magias de Mago.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 1, 'Recuperação Arcana', 'Você pode recuperar um pouco de sua energia mágica estudando seu livro de magias. Ao completar um
Descanso Curto, você pode escolher recuperar espaços
de magia gastos. Os espaços de magia podem ter um
círculo combinado igual a não mais da metade do seu
nível de Mago (arredondado para cima), e nenhum
dos espaços pode ser de 6º círculo ou superior. Por
exemplo, se você é um Mago de nível 4, pode recuperar um valor de até dois círculos de espaços de magia,
recuperando um espaço de magia de 2º círculo ou dois
espaços de magia de 1º círculo.
Você pode usar esta característica novamente após
completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 2, 'Acadêmico', 'Enquanto estudava magia, você também se especializou em outro campo de estudo. Escolha uma das
seguintes perícias nas quais você tem proficiência: Arcanismo, História, Investigação, Medicina, Natureza ou
Religião. Você tem Especialização na perícia escolhida.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 3, 'Subclasse de Mago', 'Você adquire uma subclasse de Mago à sua escolha. As
subclasses Abjurador, Adivinhador, Evocador e Ilusionista estão detalhadas após a descrição desta classe.Uma
subclasse é uma especialidade que concede a você características em determinados níveis de Mago. Durante
toda sua jornada, você adquire cada uma das características de sua subclasse de seu nível de Mago ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Mago.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 5, 'Memorizar Magia', 'Ao completar um Descanso Curto, você pode estudar
seu livro de magias e substituir uma das magias de
Mago de 1º círculo ou superior que você preparou para
sua característica Conjuração por outra magia de 1º
círculo ou superior do livro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 18, 'Maestria de Magias', 'Você alcançou tal domínio sobre certas magias que
pode conjurá-las à vontade. Escolha uma magia de 1º e
uma de 2º círculo em seu livro de magias que tenham
um tempo de conjuração de uma ação. Você sempre
tem essas magias preparadas, e pode conjurá-las em
seu círculo mais baixo sem gastar um espaço de magia.
Para conjurar qualquer uma delas em um círculo superior, você deve gastar um espaço de magia.
Ao completar um Descanso Longo, você pode estudar seu livro de magias e substituir uma dessas magias
por uma magia elegível do mesmo círculo do livro.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
Dádiva da Recordação de Magia é recomendado.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 20, 'Assinatura Mágica', 'Escolha duas magias de 3º círculo em seu livro de magias como suas assinaturas mágicas. Você sempre tem
essas magias preparadas e pode conjurá-las, cada uma
delas, uma vez no 3º círculo sem gastar um espaço de
magia. Ao realizar isso, você não pode conjurá-las deste
modo novamente até completar um Descanso Curto ou
Longo. Para conjurar uma das magias em um círculo
superior, você deve gastar um espaço de magia.
Expandindo e Substituindo um Livro de Magias
As magias que você adiciona ao seu livro de magias à
medida que avança de nível refletem sua pesquisa mágica
em andamento. Durante suas aventuras, você pode
encontrar outras magias que podem ser incorporadas
ao livro, como uma magia de Mago em um Pergaminho
Mágico, que você pode copiar para o livro de magias.
Copiando uma Magia para o Livro. Ao encontrar uma
magia de Mago de 1º círculo ou superior, você pode
copiá-la para o seu livro de magias se for de um círculo
que você possa preparar e se tiver tempo para copiá-la.
Para cada círculo de magia, a transcrição leva 2 horas e
custa 50 PO. Depois disso, você pode preparar a magia
como as outras magias em seu livro de magias.
Copiando o Livro. Você pode copiar uma magia do
seu livro de magias para outro livro. Isso é como copiar
uma nova magia em seu livro de magias, mas mais
rápido, já que você já sabe como conjurá-la. Você precisa
gastar apenas 1 hora e 10 PO para cada círculo de magia
copiada.
Se você perder seu livro de magias, você pode usar
o mesmo procedimento para transcrever as magias
de Mago que preparou em um novo livro de magias.
Preencher o restante do novo livro exige que você
encontre novas magias para fazê-lo. Por esse motivo,
muitos magos mantêm um livro de magias reserva.
A rainha élfica Yolande
impressiona um dragão
vermelho com sua magia,
Presença Régia de Yolande.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 1, 'Artes Marciais', 'Sua prática de artes marciais lhe confere domínio de
estilos de combate que usam seu Ataque Desarmado e
armas de Monge, que incluem:
• Armas Simples Corpo a Corpo
• Armas Marciais Corpo a Corpo que tem a propriedade Leve
Você adquire os seguintes benefícios enquanto estiver
desarmado ou empunhando apenas armas de Monge
e não estiver vestindo armadura ou empunhando um
Escudo.
Ataque Desarmado Adicional. Você pode realizar um
Ataque Desarmado como uma Ação Bônus.
Dado de Artes Marciais. Você pode jogar 1d6 ao
invés do dano normal de seu Ataque Desarmado ou
armas de Monge. Este dado muda à medida que você
atinge níveis de Monge, conforme detalhado na coluna
Artes Marciais da tabela Características de Monge.
Ataques com Destreza. Você pode usar seu modificador de Destreza em vez de seu modificador de Força
para as jogadas de ataque e dano de seus Ataques
Desarmados e armas de Monge. Além disso, quando você usa a opção Empurrar ou Imobilizar do seu
Ataque Desarmado, você pode usar seu modificador
de Destreza em vez de seu modificador de Força para
determinar a CD da salvaguarda.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 1, 'Defesa sem Armadura', 'Enquanto você não estiver vestindo armadura ou
empunhando um Escudo, sua Classe de Armadura
base é igual a 10 mais seus modificadores de Destreza
e Sabedoria.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 2, 'Foco do Monge', 'Seu foco e treinamento marcial permitem que você
aproveite uma reserva de energia extraordinária
dentro de si. Essa energia é representada por Pontos
de Foco. Seu nível de Monge determina o número de
pontos que você tem, conforme detalhado na coluna
Pontos de Foco da tabela Características de Monge.
Você pode gastar esses pontos para melhorar ou
impulsionar certas características de Monge. Você
começa aprendendo três dessas características: Defesa
Paciente, Passo do Vento e Torrente de Golpes, cada
uma das quais é detalhada abaixo.
Ao gastar um Ponto de Foco, ele não está disponível.
Você restaura todos os usos gastos ao completar um
Descanso Curto ou Longo.
Algumas características que usam Pontos de Foco
exigem que seu alvo realize uma salvaguarda. A CD
da salvaguarda é igual a 8 mais seu modificador de
Sabedoria e seu Bônus de Proficiência.
Defesa Paciente. Você pode executar a ação Desengajar como uma Ação Bônus. Como alternativa, você
pode gastar 1 Ponto de Foco para executar as ações
Desengajar e Esquivar como uma Ação Bônus.
Passo do Vento. Você pode executar a ação Correr
como uma Ação Bônus. Como alternativa, você pode
gastar 1 Ponto de Foco para executar as ações Desengajar e Correr como uma Ação Bônus, e sua distância
de salto é dobrada durante o turno.
Torrente de Golpes. Você pode gastar 1 Ponto de
Foco para realizar dois Ataques Desarmados como
uma Ação Bônus.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 2, 'Metabolismo Incomum', 'Ao jogar Iniciativa, você pode restaurar todos os
Pontos de Foco gastos. Ao realizar isso, jogue seu dado
de Artes Marciais e recupere um número de Pontos de
Vida igual ao seu nível de Monge mais o valor jogado.
Após usar essa característica, você não pode usá-la
novamente até completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 2, 'Movimento sem Armadura', 'Seu Deslocamento aumenta em 3 metros enquanto
você não vestir armadura ou empunhar um Escudo.
Esse bônus aumenta quando você atinge certos níveis
de Monge, conforme detalhado na tabela Características de Monge.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 3, 'Defletir Ataques', 'Ao ser atingido devido uma jogada de ataque e o dano
dessa jogada incluir dano Contundente, Cortante ou
Perfurante, você pode executar uma Reação para reduzir o dano total do ataque. A redução é igual a 1d10
mais seu modificador de Destreza e nível de Monge.
Ao reduzir o dano a 0, você pode gastar 1 Ponto de
Foco para redirecionar parte da força do ataque. Para
isso, escolha uma criatura à vista a até 1,5 metro de
você se o ataque for corpo a corpo, ou a até 18 metros
se for à distância e sem Cobertura Total. Essa criatura
deve ser bem-sucedida em uma salvaguarda de Destreza ou sofre dano igual a duas jogadas de seu dado de Artes Marciais mais seu modificador de Destreza. O dano é do mesmo tipo causado pelo ataque.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 3, 'Subclasse de Monge', 'Você adquire uma subclasse de Monge à sua escolha.
As subclasses Combatente da Mão Espalmada, Combatente da Misericórdia, Combatente das Sombras e
Combatente dos Elementos estão detalhadas após a
descrição desta classe. Uma subclasse é uma especialidade que concede a você características em determinados níveis de Monge. Durante toda sua jornada,
você adquire cada uma das características de sua
subclasse de seu nível de Monge ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para
o qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Monge.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 4, 'Queda Lenta', 'Você pode executar uma Reação ao estar em queda
para reduzir qualquer dano recebido da queda em um
valor igual a cinco vezes seu nível de Monge.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 5, 'Ataque Extra', 'Você pode atacar duas vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 5, 'Golpe Atordoante', 'Uma vez por turno, ao acertar uma criatura com uma
arma de Monge ou um Ataque Desarmado, você pode
gastar 1 Ponto de Foco para tentar um golpe atordoante. O alvo deve realizar uma salvaguarda de Constituição. Se falhar, o alvo tem a condição Atordoado até
o início do seu próximo turno. Em caso de sucesso, o
Deslocamento do alvo é reduzido pela metade até o
início do seu próximo turno, e a próxima jogada de ataque realizada contra o alvo antes disso tem Vantagem.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 6, 'Golpes Potencializados', 'Ao causar dano com seu Ataque Desarmado, você
escolhe entre causar dano Energético ou seu tipo de
dano normal.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 7, 'Evasão', 'Ao ser alvo de um efeito que permita uma salvaguarda
de Destreza para receber apenas metade do dano, você
não recebe dano em caso de sucesso e sofre apenas
metade do dano se falhar.
Você não se beneficia dessa característica se tem a
condição Incapacitado.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 9, 'Movimento Acrobático', 'Enquanto não vestir armadura ou empunhar um
Escudo, você adquire a capacidade de se mover no seu
turno ao longo de superfícies verticais e por líquidos
sem entrar em queda durante o movimento.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 10, 'Foco Aprimorado', 'Sua Defesa Paciente, Passo do Vento e Torrente de
Golpes adquirem os seguintes benefícios.
Defesa Paciente. Ao gastar um Ponto de Foco para
usar Defesa Paciente, você adquire um número de
Pontos de Vida Temporários igual a duas jogadas de
seus dados de Artes Marciais.
Passo do Vento. Ao gastar um Ponto de Foco para
usar Passo do Vento, você pode escolher uma criatura voluntária a até 1,5 metro de si que seja Grande
ou menor. Você move a criatura com você até o final
do seu turno. O movimento da criatura não provoca
Ataques de Oportunidade.
Torrente de Golpes. Você pode gastar 1 Ponto de
Foco para usar Torrente de Golpes e realizar três Ataques Desarmados em vez de dois.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 10, 'Restauro Pessoal', 'Por pura força de vontade, você pode remover
uma das seguintes condições de si no final de cada
um dos seus turnos: Amedrontado, Enfeitiçado ou
Envenenado.
Além disso, você não sofre níveis de Exaustão por
não se alimentar e se hidratar.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 13, 'Defletir Energia', 'Agora você pode usar sua característica Defletir
Ataques contra ataques que causam qualquer tipo
de dano, não apenas Contundente, Cortante ou
Perfurante.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 14, 'Sobrevivente Disciplinado', 'Sua disciplina física e mental lhe concede proficiência
em todas as salvaguardas.
Além disso, ao realizar uma salvaguarda e falhar,
você pode gastar 1 Ponto de Foco para jogar novamente, e deve usar o novo resultado.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 15, 'Foco Perfeito', 'Ao jogar Iniciativa e não usar Metabolismo Incomum,
você recupera Pontos de Foco gastos até ter 4, se tiver
3 ou menos.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 18, 'Defesa Superior', 'No início do seu turno, você pode gastar 3 Pontos de
Foco para se fortalecer contra danos por 1 minuto ou
até ter a condição Incapacitado. Durante esse período,
você tem Resistência a todos os tipos de dano, exceto
Energético.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo
5) ou outro talento à sua escolha para o qual se qualifica. Dádiva do Ataque Irresistível é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 20, 'Corpo e Mente', 'Você auto aperfeiçoou seu corpo e mente a novos patamares. Seus valores de Destreza e Sabedoria aumentam em 4, até no máximo 25.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 1, 'Conjuração', 'Você aprendeu a conjurar magias por meio de oração
e meditação. Veja o capítulo 7 para as regras sobre
conjuração de magias. As informações abaixo detalham
como você usa essas regras com as magias de Paladino,
explicadas na lista de magias de Paladino mais adiante
na descrição da classe.
Espaços de Magia. A tabela Características de Paladino mostra quantos espaços de magia você tem para
conjurar suas magias de 1º círculo ou superior. Você
restaura todos os espaços gastos ao completar um
Descanso Longo.
Magias Preparadas de 1º Círculo ou Superior. Você
prepara a lista de magias de 1º círculo ou superior que
estão disponíveis para você conjurar com essa característica. Para começar, escolha duas magias de Paladino
de 1º círculo. Destruição Cauterizante e Heroísmo são
recomendadas.
O número de magias em sua lista aumenta à medida
que você atinge níveis de Paladino, conforme mostrado
na coluna Magias Preparadas da tabela Características
de Paladino. Sempre que esse número aumentar, escolha magias adicionais da lista de magias de Paladino até
que o número de magias em sua lista corresponda ao
número da tabela. As magias escolhidas devem ser de
um círculo para o qual você possui espaços de magia.
Por exemplo, se você é um Paladino de nível 5, sua lista
de magias preparadas pode incluir seis magias de Paladino de 1º ou 2º círculo em qualquer combinação.
Se outra característica de Paladino lhe der magias
que você sempre tem preparadas, essas magias não
contam para o número de magias que você pode preparar com esta característica, mas essas magias, de outra
forma, contam como magias de Paladino para você.
Mudando Suas Magias Preparadas. Sempre que completar um Descanso Longo, você pode substituir uma
magia em sua lista por outra magia de Paladino para a
qual você tem espaços de magia.
Atributo de Conjuração. Carisma é seu atributo de
conjuração para suas magias de Paladino.
Foco de Conjuração. Você pode usar um Símbolo Sagrado como um Foco de Conjuração para suas magias
de Paladino.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 1, 'Maestria em Arma', 'Seu treinamento com armas permite que você use as
propriedades de maestria de dois tipos de armas à sua
escolha com as quais você tem proficiência, como Azagaia e Espadas Longas.
Sempre que completar um Descanso Longo, você
pode alterar os tipos de armas que escolheu. Por exemplo, você pode mudar para usar as propriedades de
maestria de Alabardas e Manguais.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 1, 'Mãos Consagradas', 'Seu toque abençoado pode aliviar feridas. Você tem
uma reserva de poder de cura que reabastece ao
completar um Descanso Longo. Com essa reserva, você
pode recuperar um número total de Pontos de Vida
igual a cinco vezes seu nível de Paladino.
Como uma Ação Bônus, você toca uma criatura (que
pode ser você mesmo) e extrair poder dessa reserva de
cura para restaurar um número de Pontos de Vida para
essa criatura, até o valor máximo restante na reserva.
Você também pode gastar 5 Pontos de Vida dessa
reserva de poder de cura para remover a condição
Envenenado da criatura; esses pontos não restauram
Pontos de Vida da criatura.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 2, 'Destruição do Paladino', 'Você sempre tem a magia Destruição Divina preparada.
Além disso, você pode conjurá-la sem gastar um espaço
de magia, não podendo conjurá-la dessa forma novamente antes de completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 2, 'Estilo de Luta', 'Você adquire um talento Estilo de Luta à sua escolha
(veja também o capítulo 5). Em vez de escolher um
desses talentos, você pode escolher a opção abaixo.
Combatente Abençoado. Você aprende dois truques
de Clérigo à sua escolha. Chama Sagrada e Orientação
são recomendados. Os truques escolhidos contam
como magias de Paladino para você, e Carisma é o
atributo de conjuração para elas. Sempre que você
atinge um nível de Paladino, pode substituir um desses
truques por outro truque de Clérigo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 3, 'Canalizar Divindade', 'Você pode canalizar energia divina diretamente dos
Planos Externos, usando-a para causar efeitos mágicos.
Você começa com um desses efeitos: Sentido Divino,
descrito abaixo. Outras características de Paladino dão
opções adicionais de efeito de Canalizar Divindade.
Cada vez que você usa Canalizar Divindade desta classe, você escolhe qual efeito desta classe usar.
Você pode usar Canalizar Divindade desta classe
duas vezes e três vezes a partir do nível 11 de Paladino.
Você recupera um uso gasto ao completar um Descanso Curto, e restaura todos os usos gastos ao completar
um Descanso Longo.
Se um efeito de Canalizar Divindade exigir uma
salvaguarda, a CD é igual a CD para evitar magias da
característica Conjuração desta classe.
Sentido Divino. Como uma Ação Bônus, você pode
abrir sua consciência para detectar Celestiais, Ínferos e
Mortos-Vivos. Pelos próximos 10 minutos ou até você
ter a condição Incapacitado, você sabe a localização de
qualquer criatura desse tipo a até 18 metros de você
e conhece o tipo de criatura. Dentro do mesmo raio,
você também detecta a presença de qualquer lugar ou
objeto que tenha sido consagrado ou profanado, como
na magia Consagrar.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 3, 'Subclasse de Paladino', 'Você adquire uma subclasse de Paladino à sua escolha. As subclasses Juramento da Devoção, Juramento
da Glória, Juramento de Vingança e Juramento dos
Anciões estão detalhadas após a descrição desta classe.
Uma subclasse é uma especialidade que lhe concede
características em determinados níveis de Paladino.
Durante toda sua jornada, você recebe cada uma das
características de sua subclasse de seu nível de Paladino ou menor.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 4, 'Aumento no Valor de Atributo', 'Você adquire o talento Aumento no Valor de Atributo
(veja o capítulo 5) ou outro talento à sua escolha para o
qual atenda os pré-requisitos. Você adquire essa característica novamente nos níveis 8, 12 e 16 de Paladino.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 5, 'Ataque Extra', 'Você pode atacar duas vezes, em vez de uma, sempre
que executar a ação Atacar no seu turno.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 5, 'Montaria Fiel', 'Você pode pedir auxílio de uma montaria sobrenatural.
Você sempre tem a magia Convocar Montaria preparada.
Você também pode conjurar a magia uma vez sem
gastar um espaço de magia, e restaura a capacidade de
fazê-lo ao completar um Descanso Longo.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 6, 'Aura de Proteção', 'Você irradia uma aura protetora e invisível em uma
Emanação de 3 metros que se origina em você. A
aura fica inativa em você, caso tenha a condição
Incapacitado.
Você e seus aliados na aura adquirem um bônus
em salvaguardas igual ao seu modificador de Carisma
(bônus mínimo de +1).
Se outro Paladino estiver presente, uma criatura
pode se beneficiar de apenas uma Aura de Proteção de
cada vez; a criatura escolhe qual aura recebe enquanto
estiver nela.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 9, 'Repudiar Inimigos', 'Como uma ação Usar Magia, você pode fazer um uso
de Canalizar Divindade para subjugar inimigos com
temor. Ao apresentar seu Símbolo Sagrado ou arma,
você pode escolher um número de criaturas igual ao
seu modificador de Carisma (no mínimo uma criatura)
à sua vista e a até 18 metros de você. Cada alvo deve
ser bem-sucedido em uma salvaguarda de Sabedoria
ou tem a condição Amedrontado por 1 minuto ou até
sofrer qualquer dano. Enquanto Amedrontado deste
modo, um alvo pode realizar apenas uma das opções
seguintes nos turnos dele: mover-se, executar uma
ação ou executar uma Ação Bônus.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 10, 'Aura de Coragem', 'Você e seus aliados têm Imunidade à condição Amedrontado enquanto estiverem em sua Aura de Proteção. Se um aliado Amedrontado entrar na aura, essa
condição não tem efeito sobre esse aliado enquanto ele
estiver na aura.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 11, 'Golpes Radiantes', 'Seus golpes agora imbuem poder sobrenatural. Ao
atingir alvo com uma jogada de ataque usando uma
arma Corpo a Corpo ou um Ataque Desarmado, o alvo
sofre 1d8 pontos de dano Radiante adicionais.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 14, 'Toque Restaurador', 'Ao usar Mãos Consagradas em uma criatura, você
também pode remover uma ou mais das seguintes
condições da criatura: Amedrontado, Atordoado, Cego,
Enfeitiçado, Paralisado ou Surdo. Você deve gastar
5 Pontos de Vida da reserva de cura de Mãos Consagradas para cada uma dessas condições que deseja
remover; esses pontos não restauram Pontos de Vida
para a criatura.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 18, 'Aura Expandida', 'Sua Aura de Proteção agora é uma Emanação de 9
metros.') ON CONFLICT (class_id, level, name) DO NOTHING;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 19, 'Dádiva Épica', 'Você adquire o talento Dádiva Épica (veja o capítulo 5)
ou outro talento à sua escolha para o qual se qualifica.
Dádiva da Visão Verdadeira é recomendada.') ON CONFLICT (class_id, level, name) DO NOTHING;
