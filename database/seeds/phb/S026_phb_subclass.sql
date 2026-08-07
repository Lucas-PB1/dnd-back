-- Seed rpg.phb_subclass
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_subclass (slug, class_id, name, tagline, summary, description, source_citation_id)
VALUES
  ('world-tree', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'Trilha da Árvore do Mundo', 'Entrelace as Raízes e Ramos do Multiverso', 'Acessar a vitalidade cósmica.', 'Bárbaros que seguem a Trilha da Árvore do Mundo
conectam-se à árvore cósmica Yggdrasil por meio de
sua Fúria. Essa árvore cresce entre os Planos Externos,
ligando-os entre si e ao Plano Material. Esses Bárbaros extraem a magia da árvore para obter vitalidade e
viajar entre dimensões.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('berserker', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'Trilha do Berserker', 'Canalize sua Fúria em um Frenesi Violento', 'Liberar violência bruta.', 'Bárbaros que seguem a Trilha do Berserker direcionam
sua Fúria principalmente para a violência. Essa trilha
é de um frenesi desenfreado, e eles se deleitam no
caos da batalha ao permitir que sua Fúria os domine e
fortaleça.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('wild-heart', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'Trilha do Coração Selvagem', 'Ande em Comunhão com o Mundo Animal', 'Manifestar seu instinto animal.', 'Bárbaros que seguem a Trilha do Coração Selvagem
se consideram parentes dos animais. Esses Bárbaros
aprendem meios mágicos de se comunicar com os
animais, e sua Fúria intensifica essa conexão com eles,
preenchendo-os com poder sobrenatural.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('zealot', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'Trilha do Fanático', 'Fúria em Êxtase com um Deus', 'Enfurecer-se em união com um deus.', 'Bárbaros que seguem a Trilha do Fanático recebem
bênçãos de um deus ou panteão. Esses Bárbaros experimentam sua Fúria como um episódio extático de
união divina que os infunde com poder. Frequentemente, são aliados de sacerdotes e outros seguidores de sua
divindade ou panteão.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('valor', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'Colégio da Bravura', 'Cante os Feitos dos Heróis Antigos', 'Brandir armas com magias.', 'Os Bardos do Colégio da Bravura são narradores ousados cujas histórias preservam a memória dos grandes
heróis do passado. Eles cantam os feitos dos poderosos em salões suntuosos ou para multidões reunidas
em torno de grandes fogueiras. Esses Bardos viajam
para testemunhar grandes eventos em primeira mão e
garantir que a lembrança desses acontecimentos não
desapareça. Com suas canções, eles inspiram novas
gerações a alcançar os mesmos feitos grandiosos dos
heróis de outrora.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('dance', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'Colégio da Dança', 'Mova-se em Harmonia com o Cosmos', 'Aproveitar a agilidade no combate.', 'Bardos do Colégio da Dança entendem que as Palavras de Criação transcendem a fala e a canção; elas se
manifestam nos movimentos dos corpos celestes e nos
gestos das menores criaturas. Esses Bardos buscam
uma harmonia com o turbilhão do cosmos, enfatizando
agilidade, velocidade e graça.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('lore', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'Colégio do Conhecimento', 'Explore as Profundezas do Conhecimento Mágico', 'Colecionar saberes e segredos mágicos.', 'Bardos do Colégio do Conhecimento colecionam magias e segredos de fontes diversas, como tomos acadêmicos, ritos místicos e contos populares. Os membros
do colégio reúnem-se em bibliotecas e universidades
para compartilhar seu conhecimento uns com os
outros. Eles também participam de festivais ou eventos
de estado, onde podem expor corrupção, desvendar
mentiras e satirizar figuras de autoridade que se acham
importantes.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('glamour', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'Colégio do Glamour', 'Teça Magia Feérica Fascinante', 'Tecer a magia fascinante de Faéria.', 'O Colégio do Glamour remonta à magia encantadora
de Faéria. Bardos que estudam essa magia entrelaçam
fios de beleza e terror em suas canções e histórias, e os
mais poderosos entre eles podem se envolver em uma
majestade sobrenatural. Suas apresentações despertam
um anseio nostálgico por uma inocência esquecida,
evocam memórias inconscientes de medos antigos e
tocam as emoções até dos ouvintes mais insensíveis.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('archfey', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'Patrono Arquifada', 'Faça um pacto com um senhor das fadas', 'Teleportar-se e manipular magia feérica.', 'Seu pacto é fundamentado no poder de Faéria. Ao escolher essa subclasse, você pode realizar um pacto com
uma Arquifada, como o Príncipe do Gelo, a Rainha do
Ar e das Trevas, Titânia da Corte de Verão ou uma megera antiga. Outra opção é invocar um espectro Feérico, criando uma rede de favores e dívidas. Em qualquer
caso, seu patrono tende a ser enigmático e excêntrico.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('celestial', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'Patrono Celestial', 'Faça um pacto com um ser celestial', 'Curar com magia celestial.', 'Seu pacto é fundamentado nos Planos Superiores,
os reinos da felicidade eterna. Você pode firmar um
acordo com um empiriano, um couatl, uma esfinge, um
unicórnio ou outra entidade celestial, ou invocar vários
desses seres enquanto persegue objetivos que se alinham aos deles. O pacto permite que você experimente
uma fração da luz sagrada que ilumina o multiverso.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('great-old-one', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'Patrono O Grande Antigo', 'Faça um pacto com uma entidade do Reino Distante', 'Mergulhar em conhecimentos proibidos.', 'Ao escolher esta subclasse, você pode se conectar a
uma entidade indescritível do Reino Distante ou a um
deus ancestral, como Tharizdun, o Deus Acorrentado;
Zargon, o Retornador; Hadar, a Fome Sombria; ou
Grande Cthulhu. Ou você pode invocar várias entidades
sem se prender a uma. As motivações desses seres
são incompreensíveis, e o Grande Antigo pode ser indiferente à sua existência. No entanto, os segredos que
você aprendeu permitem que aproveite sua estranha
magia.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('fiend', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'Patrono Ínfero', 'Faça um pacto com um poder infernal', 'Invocar poderes sinistros.', 'Seu pacto se fundamenta nos Planos Inferiores, reinos
de perdição. Você pode negociar com um lorde demônio como Demogorgon ou Orcus; um arquidiabo como
Asmodeus; ou um Diabo do Fosso, balor, yugoloth ou
uma poderosa megera da noite. Os objetivos desse patrono são malignos — visam à corrupção ou destruição
de tudo, inclusive você — e seu caminho é determinado
pelo seu esforço em se opor a esses objetivos.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('life', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'Domínio da Vida', 'Preserve a força vital', 'Ser um mestre da cura.', 'O Domínio da Vida se concentra na energia positiva que ajuda a sustentar toda a vida no multiverso.
Os clérigos que acessam este domínio são mestres
da cura, usando essa força vital para curar muitas
feridas.
A existência deste domínio repousa na energia
positiva que o envolve, atraindo Clérigos de várias
tradições religiosas. Está especialmente conectado
a divindades agrícolas, deuses da cura e resistência,
além de entidades do lar e da comunidade. Ordens religiosas voltadas para a cura também buscam a magia
deste domínio.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('light', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'Domínio da Luz', 'Empunhe luz ardente', 'Empunhar luz ardente e protetora.', 'O Domínio da Luz destaca o poder divino de gerar
labaredas e revelação. Seus Clérigos, almas iluminadas, possuem a visão clara de suas divindades, encarregados de afastar mentiras e dissipar as trevas.
Este domínio está ligado a deuses da verdade, vigilância, beleza, percepção e renovação. Alguns desses
deuses são identificados com o sol ou como condutores de carruagens que guiam o sol pelo céu. Outros
atuam como sentinelas contra o engano, enquanto
algumas divindades da beleza e da arte ensinam que a
arte é um caminho para o aprimoramento da alma.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('trickery', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'Domínio da Trapaça', 'Engane e confunda', 'Atormentar inimigos com artimanhas.', 'O Domínio da Trapaça fornece magias de enganação,
ilusão e furtividade. Os Clérigos que usam essa magia
são uma força disruptiva no mundo, perfurando o
orgulho, zombando de tiranos, libertando cativos e
desprezando tradições vazias. Eles preferem estratagemas e brincadeiras ao confronto direto.
Os deuses da trapaça são instigadores e trapaceiros
que desafiam a ordem entre deuses e mortais. Eles
personificam a mudança e a agitação social, sendo
patronos de ladrões, vigaristas, apostadores, rebeldes
e libertadores. Ordens religiosas secretas, especialmente as que buscam minar governos ou hierarquias
opressivas, também se apoiam no poder do Domínio
da Trapaça.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('war', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'Domínio da Guerra', 'Inspire bravura marcial', 'Inspirar bravura e punir inimigos.', 'A guerra se manifesta de diversas formas, capaz de
transformar pessoas comuns em heróis. Pode ser
aterrorizante, com crueldades e covardias ofuscando
atos de bravura e coragem. Os Clérigos do Domínio
da Guerra se destacam em batalhas, inspirando outros
a lutar pelo bem ou convertendo atos de violência em
orações.
Os Deuses do Domínio da Guerra observam e
recompensam os guerreiros por suas conquistas. Eles
incluem deuses de honra e cavalheirismo, assim como
de destruição e pilhagem. Outros deuses da guerra
adotam uma postura neutra, apoiando a belicosidade
em todas as suas formas e incentivando os combatentes em todas as situações.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('land', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'Círculo da Terra', 'Canalize a magia do ambiente', 'Aproveitar a magia do ambiente.', 'O Círculo da Terra é composto por místicos e sábios
que preservam conhecimentos e rituais ancestrais.
Esses Druidas se reúnem em círculos sagrados de
árvores ou pedras para sussurrar segredos primordiais
em druídico. Os membros mais sábios do círculo atuam
como sumos sacerdotes de suas comunidades.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('moon', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'Círculo da Lua', 'Adote formas animais poderosas', 'Adotar formas de animais poderosos.', 'Druidas do Círculo da Lua canalizam a magia lunar
para se transformarem. A ordem se reúne sob a lua
para compartilhar informações e realizar rituais.
Assim como a lua é mutável, um Druida desse círculo
pode espreitar como um grande felino em uma noite,
sobrevoar as copas das árvores como uma águia no
dia seguinte e, depois, atravessar a vegetação como um
urso para afastar um monstro invasor. A vida selvagem
corre no sangue do Druida.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('stars', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'Círculo das Estrelas', 'Obtenha poderes em forma estelar', 'Obter poderes em uma forma estelar.', 'O Círculo das Estrelas segue os padrões celestiais desde tempos imemoriais, descobrindo segredos ocultos
entre as constelações. Ao compreender esses segredos,
os druidas deste círculo buscam dominar os poderes do
cosmos.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('sea', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'Círculo do Mar', 'Canalize marés e tempestades', 'Canalizar marés e tempestades.', 'Druidas do Círculo do Mar canalizam as forças
tempestuosas dos oceanos e das tormentas. Alguns se
veem como encarnações da ira da natureza, buscando
vingança contra aqueles que destroem o meio ambiente. Outros procuram uma unidade mística com a
natureza ao sintonizarem-se com o fluxo e refluxo das
marés, seguindo a correnteza e as ondas, ouvindo os
sussurros e rugidos indecifráveis dos ventos.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('aberrant', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'Feitiçaria Aberrante', 'Use estranha magia psiônica', 'Usar estranha magia psiônica.', 'Uma influência alienígena envolveu sua mente, concedendo-lhe poder psiônico. Agora, você pode tocar
outras mentes e moldar o mundo ao seu redor. Esse
poder brilhará em você como um farol de esperança
para os outros? Ou você será um terror para aqueles
que sentirem o impacto de sua mente?
Talvez um vento psíquico do Plano Astral tenha carregado energia psiônica para você, ou você tenha sido
exposto à influência deformadora do Reino Distante.
Também é possível que um devorador de mentes girino
tenha sido implantado em você, mas sua transformação
em um devorador de mentes nunca ocorreu; agora o
poder psiônico do girino é seu. Independente de como
você adquiriu esse poder, sua mente está em chamas
com ele.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('draconic', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'Feitiçaria Dracônica', 'Emane a magia dos dragões', 'Emanar a magia dos dragões.', 'Sua magia inata provém da dádiva de um dragão.
Talvez um dragão antigo, que estava à beira da morte,
tenha legado parte de seu poder mágico a você ou a um
de seus antepassados. Você pode ter absorvido a magia
de um local impregnado com o poder dos dragões. Ou
talvez tenha manuseado um tesouro retirado do covil
de um dragão, repleto de poder dracônico. Ou quem
sabe você tenha um dragão como ancestral.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('clockwork', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'Feitiçaria Mecânica', 'Aproveite forças cósmicas da ordem', 'Aproveitar forças cósmicas da ordem.', 'A força cósmica da ordem o envolveu em magia. Esse
poder provém de Mecanos ou de um reino semelhante
— um plano de existência moldado inteiramente pela eficiência de um relógio. Você ou alguém de sua linhagem
pode ter se envolvido nas maquinações dos modrons, os
seres ordenados que habitam Mecanos. Talvez seu antepassado tenha até participado da Grande Marcha dos
Modrons. Seja qual for sua origem, o poder da ordem
pode parecer estranho para os outros, mas, para você,
ele é parte de um sistema vasto e glorioso.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('wild-magic', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'Feitiçaria Selvagem', 'Libere magia caótica', 'Liberar magia caótica.', 'Sua magia inata provém das forças do caos que
sustentam a ordem da criação. Você ou um antepassado pode ter sido exposto à magia bruta, talvez
através de um portal planar que levava ao Limbo ou
aos Planos Elementais. Pode ser que você tenha sido
abençoado por um ser feérico ou marcado por um
demônio. Ou sua magia pode ser um acaso sem causa
aparente. Seja qual for a origem, essa magia se agita
dentro de você, aguardando uma oportunidade de se
manifestar.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('fey-wanderer', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'Andarilho Feérico', 'Manifeste a alegria e a fúria feérica', 'Manifestar a alegria e a fúria feérica.', 'Uma mística feérica o envolve, graças à bênção de uma
arquifada ou a um local em Faéria que o transformou.
Agora, como um Andarilho Feérico, você possui magia
feérica. Sua risada alegre ilumina os corações dos oprimidos, enquanto suas habilidades marciais infundem
terror em seus inimigos, pois a alegria dos feéricos é
imensa e sua fúria, temível.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('hunter', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'Caçador', 'Proteja a natureza com versatilidade marcial', 'Proteger a natureza com versatilidade marcial.', 'Você persegue presas nos ermos e em outros lugares,
usando suas habilidades como Caçador para proteger
a natureza e as pessoas em todos os lugares de forças
que as destruiriam.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('beast-master', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'Senhor das Feras', 'Forme um laço com uma fera primitiva', 'Formar um laço com uma fera primitiva.', 'Um Senhor das Feras forma um vínculo místico com
um animal especial, com base em magia primal e uma
profunda conexão com o mundo natural.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('gloom-stalker', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'Vigilante das Sombras', 'Persiga inimigos nas trevas', 'Perseguir inimigos que se escondem nas trevas.', 'Vigilantes das Sombras estão nos lugares mais sombrios, empunhando magia extraída do Sombral para
combater inimigos que se escondem na escuridão.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('champion', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'Campeão', 'Busque o auge da proeza no combate', 'Buscar o auge da proeza no combate.', 'Um Campeão foca no desenvolvimento de habilidades marciais em sua busca incessante pela vitória. Ele
combina treino rigoroso com excelência física para
suportar golpes devastadores, enfrentar perigos e
conquistar a glória. Seja em competições esportivas ou
batalhas sangrentas, os Campeões lutam pela coroa do
vencedor.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('eldritch-knight', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'Cavaleiro Místico', 'Aprenda magias que auxiliem no combate', 'Aprender magias que auxiliem no combate.', 'Cavaleiros Místicos unem habilidades marciais de
Guerreiros a um estudo aprofundado da magia, que
não só complementa suas técnicas de combate como
também oferece proteção adicional à armadura e
permite enfrentar múltiplos inimigos simultaneamente
com magia explosiva.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('psi-warrior', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'Combatente Psíquico', 'Aumente os ataques com poder psiônico', 'Aumentar os ataques com poder psiônico.', 'Combatentes Psíquicos despertam o poder de suas
mentes para aprimorar suas habilidades físicas, infundindo ataques com energia psiônica, usando telecinesia
e criando barreiras de força mental.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('battle-master', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'Mestre da Batalha', 'Use manobras de combate especiais', 'Usar manobras de combate especiais.', 'Os Mestres da Batalha são estudantes da arte do
combate, aprendendo técnicas marciais transmitidas
por gerações. Os mais bem-sucedidos equilibram suas
habilidades marciais cuidadosamente aprimoradas com
estudos acadêmicos em história, teoria e artes.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('soulknife', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'Adaga Espiritual', 'Golpeie inimigos com lâminas psíquicas', 'Golpear inimigos com lâminas psíquicas.', 'psiônicas podem ter se manifestado, revelando todo
o seu potencial sob estresse em aventuras. Ou então,
você pode ter buscado uma ordem de adeptos psíquicos, dedicando anos a aprender a manifestar seu poder.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('assassin', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'Assassino', 'Realize emboscadas e envenenamentos', 'Realizar emboscadas e envenenamentos.', 'O treinamento de um Assassino se concentra em usar
furtividade, veneno e disfarce para eliminar inimigos
com eficiência mortal. Enquanto alguns Ladinos que
seguem este caminho são assassinos contratados, espiões ou caçadores de recompensas, as capacidades desta
subclasse são igualmente úteis para aventureiros que
enfrentam uma variedade de inimigos monstruosos.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('thief', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'Ladrão', 'Domine infiltração e caça ao tesouro', 'Dominar infiltração e caça ao tesouro.', 'Uma mistura de ladrão, caçador de tesouros e explorador, você é o resumo de um aventureiro. Além de
melhorar sua agilidade e furtividade, você obtém habilidades úteis para adentrar em ruínas e obter o máximo
benefício dos itens mágicos que encontrar lá.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('arcane-trickster', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'Trapaceiro Arcano', 'Melhore a furtividade com magia', 'Melhorar a furtividade com magia.', 'Alguns Ladinos aprimoram suas habilidades de furtividade e agilidade com magia, aprendendo truques que
os auxiliam em seu ofício. Alguns Trapaceiros Arcanos
utilizam seus talentos para furtos ou assaltos, enquanto outros se dedicam a travessuras.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('abjurer', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'Abjurador', 'Proteja aliados e banir inimigos', 'Proteger aliados e banir inimigos.', 'Seu estudo da magia concentra-se em magias de
bloqueio, banimento e proteção, eliminando efeitos
nocivos, repelindo influências malignas e defendendo
os fracos. Abjuradores são chamados para exorcizar
espíritos malignos, proteger locais contra espionagem
mágica e fechar portais para outros planos de existência. Grupos de aventureiros valorizam os Abjuradores por sua proteção contra diversas magias hostis e
ataques.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('diviner', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'Adivinhador', 'Aprenda os segredos do multiverso', 'Aprender os segredos do multiverso.', 'A orientação de um Adivinhador é buscada por quem
deseja entender melhor o passado, presente e futuro.
Como Adivinhador, você se empenha em desvendar
os véus do espaço, tempo e consciência, dominando
magias de discernimento, visão remota, conhecimento
sobrenatural e previsão.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('evoker', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'Evocador', 'Crie efeitos explosivos', 'Criar efeitos explosivos.', 'Seus estudos se concentram em magia que cria poderosos efeitos elementais, como frio intenso, chamas
abrasadoras, trovões ensurdecedores, relâmpagos
crepitantes e ácido corrosivo. Alguns Evocadores
atuam em forças militares, servindo como artilharia
para atacar exércitos à distância. Outros utilizam seus
poderes para proteção, enquanto alguns buscam benefício pessoal.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('illusionist', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'Ilusionista', 'Teça magias de ilusão', 'Tecer magias de ilusão.', 'Você se especializa em magia que deslumbra os sentidos e engana a mente, e as ilusões que você cria fazem
o impossível parecer real.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('elements', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'Combatente dos Elementos', 'Maneje poder elemental', 'Manejar poder elemental.', 'Os Combatentes dos Elementos aproveitam o poder
dos Planos Elementais. Utilizando-se de seu foco
sobrenatural, eles dominam momentaneamente a
energia do Caos Elemental para se fortalecer dentro e
fora de batalha.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('open-hand', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'Combatente da Mão Espalmada', 'Domine o combate desarmado', 'Dominar o combate desarmado.', 'Os Combatentes da Mão Espalmada são mestres do
combate desarmado. Eles aprendem técnicas para
empurrar e derrubar seus oponentes e manipular sua
própria energia para se proteger de danos.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('mercy', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'Combatente da Misericórdia', 'Cure ou fira com um toque', 'Curar ou ferir com um toque.', 'Os Combatentes da Misericórdia controlam a força
vital dos outros. Esses monges errantes atuam como
curandeiros, mas eliminam rapidamente seus inimigos.
Geralmente, usam máscaras, surgindo como portadores sem rosto da vida e da morte.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('shadow', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'Combatente das Sombras', 'Utilize sombras em estratagemas', 'Utilizar sombras em estratagemas.', 'Combatentes das Sombras praticam furtividade e
subterfúgios, aproveitando o poder do Sombral. Eles
estão em casa na escuridão, capazes de atraí-la ao seu
redor para se esconder, pular de sombra em sombra e
assumir uma forma fantasmagórica.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('ancients', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'Juramento dos Anciões', 'Preserve a vida, a alegria e a natureza', 'Preservar a vida, a alegria e a natureza.', 'O Juramento dos Anciões remonta aos primeiros elfos.
Os Paladinos que o assumem, valorizam a luz e as
belezas vivificantes do mundo mais do que princípios
de honra, coragem e justiça. Para refletir seu compromisso com a preservação da vida e da luz, costumam
adornar suas armaduras e roupas com imagens de
elementos em crescimento, como folhas, chifres ou flores.
Esses Paladinos compartilham os seguintes
princípios:
• Acenda a luz da esperança.
• Proteja a vida.
• Encante-se com a arte e a alegria.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('devotion', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'Juramento da Devoção', 'Comporte-se como os anjos da justiça', 'Comportar-se como os anjos da justiça.', 'O Juramento da Devoção vincula um Paladino aos
ideais mais elevados de justiça, virtude e ordem. Paladinos que assumem este juramento comportam-se com
honra e integridade, protegendo os inocentes e punindo
os malfeitores com a força sagrada de suas armas.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('glory', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'Juramento da Glória', 'Alcance os picos do heroísmo', 'Alcançar os picos do heroísmo.', 'Os paladinos que fazem o Juramento de Glória acreditam que eles e seus companheiros estão destinados à
glória por meio de atos heroicos. Treinam com afinco
e encorajam seus companheiros, sempre prontos para
atender ao chamado do destino.
Esses Paladinos compartilham os seguintes
princípios:
• Esforce-se para ser conhecido por seus atos.
• Enfrente as dificuldades com coragem.
• Inspire os outros a buscar a glória.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182')),
  ('vengeance', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'Juramento da Vingança', 'Persiga os malfeitores', 'Perseguir os malfeitores.', 'O Juramento de Vingança é um compromisso solene de
punir quem comete graves atos imorais. Paladinos levantam-se para corrigir as injustiças em momentos de
massacres de aldeões indefesos por exércitos malignos,
tiranos que desafiam a vontade dos deuses, guildas de
ladrões que se tornam violentas demais ou a invasão de
dragões no campo.
Esses Paladinos compartilham os seguintes
princípios:
• Não mostre misericórdia aos ímpios.
• Combata a injustiça e suas causas.
• Ajude os vitimados pela injustiça.', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'));
