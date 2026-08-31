-- Grim Hollow Cap. 1 — catálogo de heranças e pool global de traços

INSERT INTO rpg.phb_heritage (
  slug, name, category, creature_type, size_rule, speed_rule,
  allows_speed_trade, allows_size_choice, description, tagline, summary, image_url, source_meta
)
VALUES
(
  'gh-dragonborn',
  'Draconato',
  'common'::rpg.heritage_category,
  'Humanoide',
  'Draconatos são tipicamente altos e robustos; a maioria passa de 1,8 m e pesa cerca de 125 kg em média. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'Draconatos caminham com orgulho por um mundo que os recebe com medo e admiração em igual medida. A poderosa semelhança com dragões os torna notáveis entre os demais povos comuns. Escamas espessas cobrem seus corpos, garras afiadas pontiagem seus dedos, presas alinham suas mandíbulas. Não possuem o tamanho lendário nem as asas impressionantes de seus presumíveis ancestrais, mas ser draconato é ser abençoado com o sopro e a beleza de um dragão.

Alguns afirmam que os draconatos devem ser a herança mais antiga de todas. Durante a Era da Expansão, a humanidade descobriu um reino já em ruínas nas regiões mais meridionais de Etharis. Nem os próprios draconatos conseguiam recontar a história que levara à destruição de sua outrora grandiosa capital — a cidade de granito de Ember Cairn. Quando os draconatos oravam, eram recebidos pelo silêncio de seus deuses. Habitavam as ruínas de sua própria herança.

Não foi difícil para os humanos colonizar as terras meridionais que viriam a se tornar Castinella. Desilusão e desespero levaram os draconatos a abandonar suas terras ancestrais e dispersar-se por Etharis, em busca de respostas sobre o silêncio de seus deuses. Foi nesse mesmo período que missionários humanos passaram a ensinar suas próprias religiões aos draconatos que permaneceram — sobre a Guerra Aetherica e os Serafins Divinos. Os draconatos passaram a crer que seus deuses não os haviam abandonado, mas haviam sido destruídos pelos Parentes Aethericos. Com uma nova fé para preencher o vazio de suas crenças perdidas, os draconatos de Castinella tornaram-se uns dos mais zelosos adeptos do Dogma Eterno.

Castinella concedeu aos draconatos uma pequena região de suas terras ancestrais para chamar de sua. Desse começo humilde, reconstruíram a antiga cidade de Ember Cairn. Os dispersos pelo continente passaram a empreender peregrinações à cidade, onde eram encorajados a abraçar o culto aos Serafins Divinos. Com suas antigas preces enfim aparentemente respondidas, muitos draconatos foram atraídos a tornar-se clérigos, missionários e inquisidores, espalhando suas novas crenças com paixão ardente — e, com frequência, com fogo ardente.

Sua herança dracônica marca você como um povo singular entre as demais heranças de Etharis.',
  'Variante comum',
  'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-dwarf',
  'Anão',
  'common'::rpg.heritage_category,
  'Humanoide',
  'Anões medem entre 1,2 m e 1,5 m e pesam cerca de 75 kg em média. Seu tamanho é Médio.',
  '9 m. Seu deslocamento não é reduzido por usar armadura pesada. Você pode reduzir seu deslocamento em 1,5 m para ganhar um traço tradicional extra.',
  FALSE,
  FALSE,
  'Antigos e destemidos como as montanhas que chamam de lar, os anões surgiram em Etharis muito antes da história registrada. Como artesãos talentosos e diligentes, forjaram seus reinos nos vales e contrafortes das duas montanhas mais antigas do continente: Rock-Teeth e Grey Spine. Sob essas vastas cordilheiras corriam ricas veias de mithral e ouro. Os anões que extraíam e trabalhavam esses metais tornaram-se rapidamente famosos por toda Etharis.

Durante as guerras da Era da Expansão, os anões barricaram-se em suas maiores capitais: a cidade em níveis de Stehlenwald e a fortaleza montanhosa de Grabenstein. Ambas as cidades-fortaleza foram outrora consideradas inexpugnáveis. Os anões de Grabenstein lutaram valentemente por suas terras natais, resistindo a múltiplos cercos até que, por fim, seus muros foram arruinados, seus thanedoms arrancados e suas ricas minas tomadas por senhores da guerra humanos. Os descendentes desses conquistadores mais tarde lançariam as bases do Império Bürach.

O reino anão de Stehlenwald perdurou. Em vez de compartilhar o destino de seus primos do norte, os anões de Stehlenwald cavaram mais fundo no coração da montanha. Lá, os mineiros puseram os olhos em um metal novo, impenetrável às armas de seus inimigos: adamantina. Com armaduras e armas forjadas de adamantina, batalhões anões conseguiram repelir os invasores até suas terras, mas a um grande custo. A população de Stehlenwald foi dizimada por guerra e fome. O isolamento dentro das montanhas era a única opção de sobrevivência para os que restaram.

Na época da ascensão dos reinos humanos, os orgulhosos anões de Stehlenwald haviam se recuperado da guerra. Emergiram das montanhas por fim e descobriram que o panorama político havia mudado drasticamente, deixando-os cercados e em vasta inferioridade numérica perante os exércitos do Império Bürach. Percebendo que havia apenas um caminho para seu povo sobreviver e prosperar, o rei anão fechou um acordo com o Império Bürach. Os anões entregariam suas terras e se tornariam membros do império, desde que pudessem governar-se de forma independente.

Grandes números de anões ainda não conseguem perdoar a grande perda de vidas e soberania que seus ancestrais uma vez suportaram. É frase comum em Etharis que é mais fácil mover uma montanha do que um anão. Mas, embora feridas profundas ainda existam no Império Bürach, os anões tornaram-se uns dos povos mais prósperos e aceitos em todas as nações de Etharis.

Tipicamente baixos e robustos, os anões estão entre os povos mais reconhecíveis de Etharis.',
  'Variante comum',
  'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-elf',
  'Elfo',
  'common'::rpg.heritage_category,
  'Humanoide',
  'Elfos variam de menos de 1,5 m a mais de 1,8 m de altura, com porte frequentemente esguio. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'Os orgulhosos e elegantes elfos estiveram entre os primeiros povos a habitar as florestas de Etharis. Sua longa história entrelaça-se com fábulas de tempos distantes. Altos, graciosos e extraordinariamente belos, esses povos antigos creem descender dos espíritos da natureza que cultivaram o reino mortal. Os elfos reivindicam as florestas e terras fluviais de Caer Neiada como lar ancestral, no que hoje é o Reino Charneault. Dentro daquelas florestas profundas criaram domínios magníficos, sempre recebendo orientação e bênção dos espíritos imemoriais da mata.

Muitos elfos são abençoados com vista aguçada e talento para arco e flecha. Seu profundo conhecimento das matas e sua afinidade com o feérico permitem ocultar-se sem esforço em seus próprios domínios. Seus exércitos mortíferos e ágeis fizeram deles uma força a ser respeitada nos primeiros dias de Etharis. Contudo, seu domínio incontestado sobre as florestas, combinado com vidas longas, tornou os elfos arrogantes, colocando-se acima e à parte dos demais povos — especialmente os humanos, que consideravam primitivos e bárbaros. Assim, os elfos falharam em reconhecer os humanos como ameaça plausível.

A Era da Expansão cobrou caro dos elfos. Seus reinos foram despedaçados, com muitas de suas florestas reduzidas a cinzas e tocos carbonizados. Embora sua proeza em combate jamais tenha minguado, os elfos viram-se em inferioridade numérica e incapazes de repelir exércitos famintos por guerra que queimavam e derrubavam suas florestas protetoras. Em vez disso, recuaram para as profundezas de suas matas, nas margens da civilização humana, onde acreditavam que os Espíritos da Natureza ainda os protegeriam. Quando os elfos eventualmente ressurgiram, formaram um pacto com a humanidade que deu origem ao Reino Charneault.

No fim, a tristeza dos elfos por seu paraíso perdido os fortaleceu a recriar essa beleza em música e artes. Compuseram canções desoladoras de um passado perdido que ecoam entre as árvores à noite. Nesses balados chamam a si mesmos de ulufey, significando feéricos mortais e descendentes dos fey sidhe. As cortes feéricas que outrora guiaram os elfos não foram vencidas na Era da Expansão, e muitos esperam que tais Espíritos da Natureza ajudem a restaurar as terras élficas à antiga graça.

Embora elfos possam passar por humanos à distância, seus traços finos tipicamente os tornam imediatamente reconhecíveis para os demais povos.',
  'Variante comum',
  'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-gnome',
  'Gnomo',
  'common'::rpg.heritage_category,
  'Humanoide',
  'Gnomos medem entre 0,9 m e 1,2 m e pesam cerca de 20 kg em média. Seu tamanho é Pequeno.',
  '9 m.',
  FALSE,
  FALSE,
  'Engenhosos e cheios de energia, os gnomos são considerados primos distantes dos anões. Mais baixos que seus parentes anões e menos corpulentos, esses povos de porte pequeno são conhecidos por cérebros sempre ativos e grande aptidão para a invenção. Gnomos são astutos, curiosos, por vezes travessos, mas culturalmente muito diligentes.

Gnomos criaram algumas das maravilhas mecânicas mais impressionantes de Etharis. Canhões, autômatos, arcabuzes e explosivos são reputados frutos do artesanato gnômico. O processo de inventar é tão importante quanto o resultado. Gnomos criam novas invenções simplesmente para provar que é possível. Diz-se entre os demais povos que, se você procura um gnomo numa cidade populosa, basta esperar a explosão guiar seus passos.

Durante a Era da Expansão, gnomos fugiram de seus assentamentos fora das montanhas protetoras para buscar a proteção de cidades anãs como Stehlenwald. Lá, compartilharam o destino de seus primos anões enquanto exércitos humanos cercavam os altos muros de pedra da cidade. Enquanto os anões eventualmente contemplavam a adamantina, as mentes engenhosas dos gnomos tramavam outros planos com os dons das montanhas.

Alquimistas gnomos trabalhavam dia e noite, misturando químicos e pós, até inventarem uma nova arma: explosivos. Enquanto anões revestidos de adamantina avançavam contra os exércitos humanos sitiantes, eram apoiados pelo som de explosões enquanto a artilharia gnômica arremessava balas de canhão e dinamite contra o inimigo. Sob o bombardeio, as forças humanas foram rapidamente quebradas. Os efeitos dos explosivos nunca vistos antes semearam medo em suas mentes, como se testemunhassem uma nova e terrível feitiçaria. Uma primeira grande batalha havia sido vencida, mas as perdas para gnomos e anões foram grandes. Assim, os gnomos seguiram os anões de Stehlenwald em seu isolamento de séculos — e quando o rei anão voluntariamente conduziu seu povo ao Império Bürach, os gnomos o acompanharam.

Curiosamente, gnomos têm afinidade com o mundo natural. Aqueles que não fugiram para a segurança das montanhas foram chamados de volta a seus lares ancestrais nas profundezas das florestas de Etharis. Talvez isso sugira um ancestral comum com os elfos, também.

A maioria dos gnomos é marcada pelos traços delicados e vidas longas comuns entre sua espécie.',
  'Variante comum',
  'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-halfling',
  'Halfling',
  'common'::rpg.heritage_category,
  'Humanoide',
  'Halflings têm cerca de 0,9 m de altura e pesam cerca de 20 kg. Seu tamanho é Pequeno.',
  '9 m.',
  FALSE,
  FALSE,
  'Ao longo dos séculos em que a humanidade provou ser uma força imparável na conquista de Etharis, os humanos conquistaram a inimizade da maioria dos demais povos. Todos que tentaram opor-se a eles foram recebidos com violência. Um grupo, porém, escolheu não contestar a ascensão humana e, em vez disso, sobreviveu adaptando-se à hegemonia humana.

A Era da Expansão não afetou os halflings de Etharis como afetou os povos de outras heranças. Halflings atribuem menos valor a riquezas mundanas como ouro ou joias e, por isso, pagavam de bom grado dízimos a humanos mais fortes e melhor armados que lhes ofereciam proteção. Embora corajosos e espirituosos, halflings carecem de ambição para construir nações. Suas humildes comarcas adaptaram-se facilmente a tornar-se celeiros de impérios e reinos criados por humanos. Halflings também se encaixam perfeitamente na cultura humana ao ocupar posições úteis como mercadores, conselheiros, professores ou eruditos. Mesmo discordando dos modos violentos dos humanos, mantiveram silêncio e garantiram sua sobrevivência.

Halflings são um povo resiliente, porém pacífico. O que a maioria desses povos diminutos busca na vida é um lugar tranquilo para assentar-se, longe de conflitos e guerras. Apreciam boa música, comida fina e uma boa gargalhada quando podem, e têm paixão por saber, aprendizado e histórias fantásticas. Isso não significa, porém, que halflings sejam incapazes de se defender num mundo perigoso. São povos corajosos quando enfrentam inimigos que não podem evitar ou fugir, e relatos de aventureiros halfling em busca de conhecimento antigo e oculto estão entre as histórias mais famosas entre sua espécie.

Halflings há muito usam o saber que reúnem para construir bibliotecas impressionantes sobre assuntos específicos. Dentro dos incontáveis volumes dessas bibliotecas repousam gerações de conhecimento sobre os interesses e paixões desses povos, incluindo artes domésticas, natureza e história.

Seja qual for sua abordagem à vida, a maioria dos personagens halfling é definida por sua estatura diminuta.',
  'Variante comum',
  'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-human',
  'Humano',
  'common'::rpg.heritage_category,
  'Humanoide',
  'Humanos variam muito em altura e porte, de pouco mais de 1,5 m a bem acima de 1,8 m. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'Embora heranças antigas como elfos e anões afirmem ter erguido os primeiros reinos em Etharis, os humanos dominam essas terras na era atual. Humanos podem ser encontrados em toda parte, desde a tundra gelada e inóspita do Norte até as planícies escaldadas do Sul. Registrados pela primeira vez emergindo de florestas temperadas nas terras que hoje formam o Império Bürach, os humanos não eram considerados ameaça pelos povos dominantes do continente. Sem freios, seus números cresceram rapidamente. E, no fim, a natureza adaptável dos humanos e sua mentalidade aventureira levaram-nos a expandir-se além de suas terras natais.

O período registrado na história como Era da Expansão é frequentemente retratado como uma erupção interminável de violência que durou séculos enquanto os humanos se espalhavam por cada canto de Etharis. Na verdade, a Era da Expansão descreve muitos conflitos separados que ocorreram na esteira da migração humana. Humanos não enviaram exércitos inicialmente, mas colonos. Cortaram árvores do Labirinto de Bosques para construir casas. Viajaram até os confins de Valika para escapar de seus próprios reinos no sul. Quando reivindicaram terras já povoadas por outros povos, a guerra tornou-se inevitável. Quando os grandes reinos dos elfos e anões reconheceram o perigo da migração humana, já era tarde demais. O derramamento de sangue que se seguiu mudou Etharis para sempre.

O sucesso dos humanos deve-se à sua adaptabilidade. Vivem vidas mais curtas que muitos outros povos, o que faz suas tradições culturais se desvanecerem mais depressa e os impede de sufocar em suas próprias tradições. Toda cultura humana foi tocada por outra herança nas terras que passaram a colonizar. Nos ducados do Reino Charneault, humanos prestam homenagem aos Espíritos da Natureza conforme lhes ensinaram os elfos. As fortalezas e cidades modernas do Império Bürach incorporam alvenaria e arquitetura anãs. Até hoje, humanos são considerados o povo dominante em toda Etharis, controlando a maior parte da terra e do mar. Mas seus domínios estão longe de ser homogêneos, cada um com história própria e mistura de povos de outras heranças.

De todos os vícios humanos, a ambição é considerada a mais insidiosa. Humanos ainda dominam posições de poder em suas sociedades. Muitos reivindicaram o Trono Alto de Altenheim, desejando controlar o império mais poderoso do mundo. Conhecida como Era da Queda, os anos que se seguiram à Era da Expansão testemunharam o declínio de cada domínio humano. Enquanto muitos plebeus creem que foi a morte dos deuses que iniciou essa queda, povos de outras heranças sussurram que foi a hubris humana. Quando não havia mais reinos a conquistar, a humanidade voltou sua ganância, ambição e violência contra si mesma.

Humanos apresentam ampla variedade de traços físicos, mas suas vidas breves há muito definem sua ambição coletiva.',
  'Variante comum',
  'Variante comum em Etharis (Grim Hollow) — equivalente às espécies tradicionais, com traços modulares escolhidos na criação.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-dreamer',
  'Sonhador',
  'rare'::rpg.heritage_category,
  'Humanoide',
  'Sonhadores medem tipicamente entre 1,5 m e 1,8 m e têm porte sólido. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'A história se repete. Muito antes de os humanos terem suas Eras da Expansão e da Queda, e mesmo antes do tempo dos elfos e anões, outra civilização havia ascendido e caído. Onde hoje vivem os anões de Stehlenwald, outrora erguia-se o assento de um império sem nome que se acredita ter superado qualquer um surgido desde então. Por séculos, viveu apenas nas mitologias de elfos e anões. Em algumas histórias, a queda ocorreu quando mortais tentaram desafiar os deuses. Em outros contos, o império foi devorado por inteiro na primeira catástrofe que foi a Guerra Aetherica.

Ainda assim, algo sobreviveu.

Enquanto os humanos reivindicavam Etharis, os anões de Stehlenwald foram forçados a cavar mais fundo em suas fortalezas montanhosas para resistir ao cerco. Nas profundezas, ainda abaixo da adamantina que provou ser sua salvação, os anões encontraram câmaras seladas de origem misteriosa. Com os selos quebrados, um feitiço antigo foi dissolvido, e os habitantes das câmaras começaram a despertar de seu sono milenar.

Nos dias anteriores à calamidade que exterminou sua civilização, um grupo de místicos conhecidos como sonhadores previu o perigo e elaborou um plano para sobreviver. O tempo passa de modo diferente nos sonhos, e aqueles antigos puderam usar a magia da oneiromancia para libertar-se do fluxo do tempo. Suspensos entre realidade e sonhos enquanto selados nas profundezas subterrâneas, puderam viver em estado de sono perpétuo pelo tempo necessário, sobrevivendo às consequências do desastre que exterminaria o restante de sua espécie.

O plano funcionou. Mas viver tanto tempo dentro do mundo dos sonhos teve consequências imprevistas. Ao despertar, os sonhadores descobriram que já não conseguiam diferenciar sonhos de memórias, com ambos desvanecendo-se rapidamente de suas mentes. O resultado foi o surgimento de um novo povo sem conhecimento de sua própria história — apenas imagens incompletas e impressões oníricas de um lugar e tempo que podem ou não ter existido.

Agora os sonhadores lutam para se adaptar a um mundo que não foi feito para eles. Seja qual for sua história, provaram ser perspicazes e fortes, capazes de se adaptar facilmente a um mundo novo e desconhecido. Seu longo sono aparentemente os deixou energizados, capazes de trabalhar além da lendária resistência dos anões. Ainda assim, o sono é onde os sonhadores ainda se sentem em casa, e têm o hábito de cochilar rapidamente sempre que nenhuma tarefa imediata se apresenta.

Sonhadores guardam semelhança geral com outros humanoides, mas seus traços distintos os fazem destacar-se.',
  'Variante rara',
  'Variante rara — povo pouco comum em Etharis, com traços modulares.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-grudgel',
  'Rancoroso',
  'rare'::rpg.heritage_category,
  'Humanoide',
  'Rancorosos são mais altos e robustos que muitos humanoides, tipicamente entre 1,8 m e 2,1 m, pesando 100 kg ou mais. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'Lendas em Etharis falam de uma era dos orcs. Essa herança antiga tem raízes no Norte de Etharis, de onde a história afirma que se espalharam para aterrorizar outras culturas. Orcs, como o termo passou a ser entendido, eram guerreiros formidáveis com sede interminável de batalha. Contudo, contos de seus exércitos quase conquistando toda Etharis são quase certamente propaganda de culturas externas temerosas.

Essas mesmas lendas falam de como os orcs abandonaram suas terras em massa — não por incursões inimigas ou desastre natural, mas por algum chamado misterioso de seus ancestrais para navegar a oeste através do mar. Embora se concorde que orcs fugiram de Etharis em uma grande frota, com seu legado ressoando em Thorgard av Holgar um século depois, parece apócrifo que uma herança inteira pudesse simplesmente desaparecer além-mar. De fato, a verdade é mais complexa do que qualquer daquelas velhas histórias pode contar.

Os descendentes dos orcs chamam a si mesmos de rancorosos. Sua falta de semelhança com as terríveis lendas sobre seus ancestrais leva os incultos a assumir que orcs e rancorosos são povos diferentes. Mas o que verdadeiramente os separa é apenas o tempo e a cultura em evolução.

Rancorosos são um povo imponente cuja presença física não diminuiu desde as lendas dos guerreiros orcs. Contudo, mesmo onde são mais numerosos entre os Clãs Valikan, rancorosos não são mais nem menos predispostos à batalha ou ao caminho do guerreiro que qualquer outro povo. Rancorosos também são artesãos talentosos, viajantes, tecelões de magia e observadores das estrelas. Só eles guardam os segredos de forjar stryllum, estranha substância que ocorre quando a luz estelar é solidificada em vidro. Rancorosos são trabalhadores, pacíficos entre amigos e têm talento para manter a calma sob pressão. Mas são mais do que capazes de se defender contra as ameaças da natureza selvagem e de povos em busca de briga.

Fora do Norte, rancorosos permanecem raros o bastante em Etharis para que seja mais provável ouvir rumores temerosos sobre sua espécie do que encontrar um. Embora um rancoroso trabalhando como guarda-costas ou mercenário possa tirar proveito de tais rumores, a única coisa que aparentemente conecta todos os rancorosos é um desinteresse compartilhado em discutir ou ouvir as antigas lendas dos orcs. Mas se isso decorre do desejo de se distanciar do passado violento de seus parentes, ou de algum conhecimento secreto sobre por que os orcs desapareceram de Etharis, só eles sabem.

A herança antiga dos rancorosos marca-os como figuras distintas entre os povos de Etharis.',
  'Variante rara',
  'Variante rara — povo pouco comum em Etharis, com traços modulares.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-laneshi',
  'Laneshi',
  'rare'::rpg.heritage_category,
  'Humanoide',
  'Laneshi medem tipicamente entre 1,5 m e 1,8 m e têm porte esguio. Seu tamanho é Médio.',
  '9 m. Você tem deslocamento de natação de 9 m.',
  FALSE,
  FALSE,
  'Nas profundezas das ondas ao largo das costas orientais de Etharis jaz o Império Llana''Shi, lar do misterioso povo chamado laneshi pelos habitantes da superfície. Aparentando-se incrivelmente alienígenas aos demais povos comuns, esses humanoides pálidos com jubas de cabelo semelhante a algas são criaturas do mar, capazes de conversar com a flora e a fauna das profundezas. Laneshi vivem numa cultura que enxerga o mundo em termos de absolutos e um senso subjacente de dualidade. Dia ou noite. Aceitação ou rejeição. Amigo ou inimigo. Sua cultura também se entrelaça ao longo da linha entre vida e morte. Comungam com espíritos em busca de orientação e não temem encontrar sua morte mortal. Todas as coisas devem ter seu lugar na sociedade laneshi, construída sobre um rígido sistema de castas que reflete essa visão.

A casta mística compreende todos os laneshi nascidos gêmeos, ocorrência comum entre seu povo. O gêmeo primogênito é sempre iniciado na casta mística, enquanto o outro é consagrado como guia espiritual do irmão. Mediante um poderoso ritual necromântico, o segundo gêmeo é sacrificado, com sua alma ligada ao corpo do outro. Cada membro da casta mística possui, portanto, duas almas — uma viva e uma morta — o que lhes concede visão no mundo espiritual e intensifica suas habilidades necromânticas. Místicos supervisionam ritos funerários, artesanato, construção, registro e preparo de alimentos. Os deveres mais pesados dos membros dessa casta são até realizados com auxílio de mão de obra morta-viva — visão aterradora para os povos da superfície.

A casta guerreira dos laneshi supervisiona não apenas a guerra, mas também diplomacia, agricultura e a criação e educação de crianças. A casta guerreira tem aproximadamente o dobro do tamanho da casta mística, estruturada como meritocracia, com grandes feitos levando a maior status.

Guerreiros laneshi escaramuçam constantemente com vizinhos das profundezas. Mas, ao mesmo tempo, os governantes do Império Llana''Shi começaram a voltar-se para o mundo da superfície por razões desconhecidas. Talvez alguma ameaça nova e maior se agite nas profundezas escuras do mar, e os laneshi busquem auxílio de seus primos respiradores de ar. Ou talvez haja verdade nos sussurros temerosos de que esses visitantes aquáticos firmaram pactos blasfemos com males antigos, e os laneshi busquem novas terras a conquistar para aplacar a fome de um mestre inominável.

Entre os demais povos de Etharis, os laneshi são únicos em aparência e natureza aquática.',
  'Variante rara',
  'Variante rara — povo pouco comum em Etharis, com traços modulares.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-ogresh',
  'Ogrês',
  'rare'::rpg.heritage_category,
  'Humanoide',
  'Ogrês jovens medem entre 1,8 m e 2,1 m, com corpo largo e pesado — entre 90 kg e 135 kg; exemplares mais velhos podem ultrapassar 350 kg. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'As culturas mais populosas de Etharis têm histórias sobre os ogrês, embora poucos tenham visto esses gigantes gentis pessoalmente. Contos os descrevem como figuras solitárias e sábias que frequentemente servem como fontes de informação e conselho para comunidades próximas. Histórias de aventura abundam em que um protagonista recebe orientação de um ogrês antes de partir em sua jornada, enquanto outras descrevem conselheiros reais com um conjunto distintivo de traços largos. Esses contos não carecem de mérito, pois ogrês podem ser experientes em suas viagens nos anos jovens. Contudo, mesmo fora do escopo dessas histórias, quem conhece os ogrês frequentemente os vê como uma exótica curiosidade.

Na verdade, a escassez dos ogrês é resultado de sua biologia particular. Ogrês jovens amadurecem lentamente e, durante uma juventude prolongada que pode durar décadas, são impulsionados por um profundo desejo de vagar. Esse sentimento os leva a viajar em busca de uma área adequada para assentar-se — com recursos naturais abundantes, população local de criaturas sencientes e ausência de outros ogrês por perto. Uma vez que decidem por uma área, um ogrês entra na segunda fase de sua vida, marcada por apetite drasticamente aumentado e estilo de vida em grande parte sedentário. Mais de um único ogrês poderia facilmente esgotar o excedente de uma pequena aldeia, de modo que a razão desse desejo de vagar é simples necessidade biológica.

Dada sua dependência de outros povos para sobreviver, não surpreende que muitos ogrês sejam mestres da interação social. Mas alguns povos sustentam que a habilidade ogrês de extrair percepções dos outros tem qualidade sobrenatural, revelando ao ogrês mais do que a maioria das criaturas compartilharia de bom grado.

Ele é um investigador fantástico. A maioria dos suspeitos confessa assim que o vê, e o restante desabafa após alguns momentos de conversa.

O tamanho formidável e o envelhecimento lento dos ogrês os fazem destacar-se em terras assentadas.',
  'Variante rara',
  'Variante rara — povo pouco comum em Etharis, com traços modulares.',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-accursed',
  'Amaldiçoado',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Amaldiçoados podem medir de menos de 0,9 m a 1,8 m ou mais, com tipos corporais variados. Seu tamanho é Pequeno ou Médio, conforme você definir.',
  '9 m. Se você for Pequeno, pode reduzir seu deslocamento em 1,5 m para ganhar um traço extra.',
  FALSE,
  TRUE,
  'Os amaldiçoados são a herança mais rara e menos compreendida de todas em Etharis — porque cada amaldiçoado é, na prática, uma herança por si só. Seja criado por magia única, trazido ao mundo por portais planares ou extradimensionais, ou representando um dos últimos membros de uma herança que se acreditava perdida para a história, um amaldiçoado é uma criatura cujos traços são todos livremente escolhidos com um conceito de personagem específico em mente.

Amaldiçoados recebem esse nome não porque seu nascimento ou criação tenha sido resultado de má-fé mágica, barganha de bruxa, pergaminho corrompido ou qualquer dos outros sentidos típicos de "maldição" no jogo. Antes, amaldiçoado reflete o senso sombrio de como a maioria dos demais povos da campanha verá tal personagem, especialmente aqueles que não se dão ao trabalho de saber mais sobre a vida e a perspectiva do personagem. Essa herança visa encorajar jogadores a decidir quem é seu personagem com o máximo de criatividade. É uma categoria aberta para personagens únicos que não se encaixam em outra herança, mas ainda podem pertencer a Grim Hollow.

Amaldiçoados tipicamente não representam um povo ou uma cultura e são frequentemente inteiramente únicos. Um jogador pode criar um personagem amaldiçoado na forma de um corvo falante do tamanho de um halfling, que chocou de um ovo de basilisco petrificado durante lua cheia. Em todo o mundo, não há ninguém igual a ele, e a combinação de traços de herança escolhida pelo jogador desse amaldiçoado reflete isso. Outro jogador pode escolher a herança amaldiçoada para refletir a forma e as capacidades de um homem-lagarto — herança que não existe canonicamente em Grim Hollow. Seja esse amaldiçoado um viajante que partiu de um enclave perdido de homens-lagarto nas profundezas de Black Mire, ou um personagem nascido de pais elfos amaldiçoados por um mago maligno, sua seleção de traços de herança define seu lugar único no mundo.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-arisen',
  'Reerguido',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Reerguidos podem ser compactos (cerca de 0,6 m) ou imponentes (acima de 2,1 m). Seu tamanho é Pequeno ou Médio, conforme você definir.',
  '9 m. Se você for Pequeno, pode reduzir seu deslocamento em 1,5 m para ganhar um traço tradicional extra.',
  FALSE,
  TRUE,
  'Os reerguidos são tema de sussurros temerosos por toda Etharis, com frequência proclamados entidades antinaturais que não podem ser confiados nem redimidos. Pois, embora sejam humanoides, cada reerguido é um construto único criado por magia, ciência misteriosa ou ambos.

Reerguidos nunca nascem em sua forma atual. Não são mortos-vivos, nem foram trazidos da morte por magia divina. Antes, cada reerguido é construído e recebe o dom da vida, geralmente por um criador. Reerguidos são pessoas, com certeza. Têm personalidades, intelectos e experiências únicas, como todos os humanoides. Mas possuem alma? Essa é uma questão existencial com a qual todos os reerguidos devem lutar.

Reerguidos são feitos em sua maior parte de matéria orgânica. Não são máquinas, embora muitos possuam partes mecânicas em pequena ou grande medida. Um reerguido pode ter um único membro mecanizado, enquanto outro tem órgãos mantidos num aglomerado de frascos. Um reerguido pode ter fios protruindo de seu corpo que se conectam a uma fonte de energia arcana enxertada em suas costas, enquanto outro parece inteiramente mundano, salvo algumas cicatrizes e as gemas arcanas guardadas em suas cavidades oculares.

Alguns reerguidos são inteiramente construídos, erguidos conforme alguma especificação ou plano. Outros começam inocentemente por experimentos para substituir membros ou órgãos vivos, com experimentos repetidos empurrando inexoravelmente uma criatura a perder toda conexão consigo mesma. Outros ainda podem ser resultado de uma criatura viva que morreu ou foi gravemente ferida antes de ser "remontada". Mas não importa o processo que os gerou, a criação de um reerguido é frequentemente traumática, tipicamente guardada como memórias fragmentadas de laboratórios arcanos e o primeiro lampejo de consciência, ou como os pesadelos vagos que restam de uma vida anterior.

Sua raridade entre os povos de Etharis e os rumores sombrios que os cercam deixam reerguidos na maior parte socialmente isolados. Mas nem todos os reerguidos são levados ao niilismo pela desolação de sua criação e de suas vidas. Pois desse trauma, muitos desenvolvem senso de introspecção que impulsiona curiosidade intensa e uma perspectiva filosófica sobre assuntos de vida, mortalidade e seu próprio lugar no mundo.

Cada personagem reerguido é moldado pela natureza única da magia ou das circunstâncias que o criaram.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-dhampir',
  'Dhampir',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Um dhampir tem o mesmo tamanho do humanoide do qual surgiu. Você é Pequeno ou Médio, conforme você definir.',
  '9 m.',
  FALSE,
  TRUE,
  'Um dhampir é marcado por um direito de nascimento inquietante — um humanoide meio amaldiçoado com vampirismo, vivendo como mortal, mas tocado por um temido poder imortal. Um dhampir possui muitos dos traços sombrios de seus progenitores mortos-vivos, mas sua natureza mortal lhe permite evitar vulnerabilidades vampíricas. Como seus criadores, dhampirs anseiam pelo sangue dos vivos, mas não são controlados por tais anseios se sua vontade for forte o bastante para resistir.

Sempre gerados a partir de criaturas de outras heranças, dhampirs são incrivelmente raros e variam amplamente em forma e temperamento. A única coisa que todos os dhampirs verdadeiramente compartilham é o legado de sua criação antinatural. Vampiros verdadeiros são a personificação da morte, imitando a vida ao retorcer cadáveres em mortos-vivos ou espalhar sua maldição para gerar mais de sua espécie. Mas vampiros não podem reproduzir naturalmente nem criar algo verdadeiramente vivo. Dhampirs são, portanto, na maior parte das vezes resultado de alguma forma de acidente necromântico — uma criança moribunda revivida por magia funesta, um boticário misturando ervas com sangue vampírico, ou uma tentativa fracassada de encontrar cura para o vampirismo.

Seja qual for sua origem, a maioria dos dhampirs experimenta uma existência enraizada em trauma e, frequentemente, permeada de solidão. Plebeus que temem dhampirs os veem como monstros sedentos de sangue, apesar de a maioria sustentar a vida com comida e bebida normais. Ao mesmo tempo, vampiros os execram como fracos de sangue ralo. A vida de um dhampir é, assim, em geral passada em busca de um lugar onde pertencer, seja integrando-se à sociedade mortal ou tentando aplacar seus antepassados bebedores de sangue.

Um dhampir que escolhe a vida entre mortais é frequentemente atormentado por culpa. Seu anseio por sangue pode tornar-se avassalador enquanto se agarra à humanidade e à empatia. Dhampirs são tratados como monstros por quem é supersticioso em relação a eles. Contudo, plebeus que cuidam de um dhampir como família jamais podem compreender verdadeiramente sua luta contra o monstro interior.

Outros dhampirs decidem ceder à sede de sangue. Podem até disputar posição entre a nobreza de Ostoya. Apesar de carecer de parentesco convencional, um dhampir pode formar vínculo familiar com o vampiro que considera seu sire. Vampiros que exploram essa relação podem ganhar um guardião valioso capaz de caminhar à luz do sol e misturar-se mais facilmente com a sociedade mortal. Um dhampir nessa posição pode tornar-se espião, mordomo ou arauto de seu mestre. Mas compreendem que jamais alcançarão posições de poder real na sociedade vampírica.

A natureza física de um dhampir é moldada pela criatura que outrora foi e pela natureza de sua maldição.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-disembodied',
  'Desencarnado',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Desencarnados aparecem como versões translúcidas de si mesmos; sua natureza quase insubstancial reduz o peso a um quarto do original. Seu tamanho é Pequeno ou Médio, conforme você definir.',
  '9 m.',
  FALSE,
  TRUE,
  'Permitir que a mente toque os planos é o sonho supremo de muitos conjuradores arcanos, e em nenhum lugar esse sonho chegou mais perto da realidade do que na cidade perdida de Ulmyr''s Gate. Fundada no Império Bürach por um grupo de magos ambiciosos que se irritavam com as limitações impostas pela burocracia governamental, Ulmyr''s Gate ostentava estudo livre para todos os magos que buscassem refúgio dentro de seus muros. O Grande Colégio dedicado ao estudo mágico na cidade tornou-se rapidamente santuário para magos de todas as disciplinas de toda Etharis, criando uma era de ouro da magia dentro de seus muros.

Essa era de ouro desmoronou numa única noite, quando os magos fundadores de Ulmyr''s Gate tentaram um ritual ambicioso destinado a rasgar o véu e criar um portal permanente para o Plano Etéreo. Em vez disso, sua magia rasgou uma fenda imensa no tecido da realidade, e num instante a cidade inteira foi inclinada para o vazio entre os mundos. Ulmyr''s Gate e todos os seus cidadãos foram dados como destruídos. O incidente desencadeou outra inquisição contra arcanistas hubristas que mexiam em coisas que mortais não deveriam conhecer. Depois, a vida no império seguiu.

Anos depois, histórias começaram a surgir de aparições aterradoras avistadas na região onde Ulmyr''s Gate outrora se erguia. Esses povos assombrosos pareciam estranhamente borrados ou indistintos. Testemunhas relataram que desapareciam tão subitamente quanto surgiam. Gradualmente, tornou-se claro que essas pobres almas eram sobreviventes da Fenda Etérea, agora presas entre os mundos e tentando manter seu tênue domínio sobre o Plano Material.

Os residentes da perdida Ulmyr''s Gate que reuniram força para retornar ao mundo foram nomeados desencarnados pelos sábios que os estudaram. Esses raros indivíduos deixaram ou fugiram de seu antigo lar, atravessando a Fenda Etérea para vagar pelo mundo mortal. Embora se assemelhem às pessoas que outrora foram, são ao mesmo tempo mais e menos — criaturas de dois reinos, frequentemente assombradas por memórias da destruição da cidade, das quais raramente ou jamais falam.

Embora sua presença no mundo seja moldada pela magia, as formas dos desencarnados aparecem muito como antes do desastre que os gerou.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-downcast',
  'Relegado',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Relegados medem geralmente entre 1,5 m e 1,8 m, com tipos corporais variados. Seu tamanho é Médio.',
  '9 m.',
  FALSE,
  FALSE,
  'Ao fim do Fim dos Deuses, mil almas caíram sobre Etharis como estrelas ardentes do céu. Os relegados outrora faziam parte das legiões celestiais, mas a morte dos deuses enviou ondas de choque pelos céus. Lançados ao reino mortal, esses anjos outrora celestiais viram-se despojados de poder e deixados a viver sua existência agora mortal entre o povo do mundo.

Na ausência dos deuses, os Arquisserafins de cada divindade desceram ao reino mortal, assumindo sobre si o fardo de impor ordem a um mundo lançado na desordem. Os Arquisserafins eram os tenentes mais poderosos entre as hostes angélicas, fortes o bastante para reter semelhança de seu poder divino após a tragédia. Mas um anjo não é um deus. Um Arquisserafim não pode encarnar todos os aspectos de um domínio divino. Alguns tornaram-se consumidos em impor virtudes estreitas. Outros desviaram-se inteiramente da graça, escolhendo encarnar vício em vez de virtude, e tornaram-se temidos como Arquidaemônios.

Os relegados são em número muito menor do que quando chegaram pela primeira vez. Muitos sucumbiram ao desespero e à doença após sua queda da graça. Dos que restam, alguns ainda servem os Arquisserafins em suas cruzadas distorcidas, esperando reclamar o que perderam. Outros viraram as costas a antigos companheiros para buscar seus próprios objetivos, abraçando plenamente a vida mortal. E mais do que alguns sentem-se amargurados o bastante por sua queda para serem alegremente aceitos pelos Arquidaemônios como agentes para espalhar medo e destruição no mundo.

Fisicamente, os relegados ainda possuem a beleza de suas formas angélicas, embora já não brilhem tão intensamente quanto antes. Para a maioria, a marca do divino ainda persiste como brilho visível nos olhos, ou runas Celestiais fracamente luminosas em pele por outro lado impecável. Outros foram marcados por sua mudança de moralidade, manifestando pele rachada ou chifres diabólicos.

Embora mortais, relegados ainda são tocados pela natureza celestial de que foram despojados.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-wechselkind',
  'Wechselkind',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Wechselkind medem entre 0,6 m e 0,9 m e pesam entre 12,5 kg e 17,5 kg. Seu tamanho é Pequeno.',
  '9 m.',
  FALSE,
  FALSE,
  'Uma mãe ouve um som na noite e, preocupada, verifica seu filho pequeno adormecido. Nada parece fora do lugar. Mas semanas depois, um glamour invisível se desvanece e um horror é revelado: a criança foi roubada pelo feérico, e um wechselkind ficou em seu lugar. Pois os feéricos são seres insensíveis e imutáveis, e nada inspira sua fascinação — e sua inveja — mais do que a centelha maleável e brilhante de uma criança humanoide jovem.

Um wechselkind é um construto feito de madeira, barro e cerâmica na forma de uma criança pequena, animado por magia feérica e oculto em ilusão que o faz parecer idêntico a um bebê mortal roubado. Uma vez que o glamour se desvanece e a mentira é revelada, um wechselkind é na maior parte das vezes expulso pela família da criança roubada, se não destruído. Ocasionalmente, porém, uma família tem pena da pobre criatura e tenta criá-la, apenas para descobrir que, embora sua mente se desenvolva normalmente, um wechselkind está para sempre preso na forma imutável de uma boneca infantil.

Seja nutrido ou rejeitado, a maioria dos wechselkind eventualmente vive como párias, aprendendo a se virar da melhor forma possível. A magia residual de seu glamour feérico permite que um wechselkind se oculte por breves períodos, seja na aparência da criança que substituiu ou de um halfling, gnomo ou outra pessoa de estatura semelhante adulta. Com poucas necessidades físicas, um wechselkind pode vagar facilmente de assentamento em assentamento, observando as pessoas que encontra com olhos invejosos e esperando um lugar onde finalmente se encaixe.

Com a propagação da Praga Lacrimosa, muitos wechselkind emergiram do esconderijo. Com sua imunidade a doenças, podem auxiliar curandeiros em regiões assoladas pela peste, ganhando alguma medida de respeito — ou até admiração — daqueles capazes de ver além de suas trágicas origens. Contudo, mesmo wechselkind aceitos entre outros povos frequentemente permanecem cautelosos, temendo que, uma vez encerrada sua utilidade, possam ser expulsos novamente.

Encantados com poderosa magia feérica, wechselkind são únicos entre os demais humanoides.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-wulven',
  'Wulven',
  'eldritch'::rpg.heritage_category,
  'Humanoide',
  'Wulven têm altura semelhante à herança original, porém costumam ser mais robustos, musculosos ou ágeis conforme a natureza da maldição. Seu tamanho é Pequeno ou Médio, conforme você definir.',
  '9 m.',
  FALSE,
  TRUE,
  'Por ermos e terras assentadas, em aldeias florestais e fazendas, o medo da licantropia corre fundo. Mas poucos povos chegam a perceber que o estranho imponente que passaram na estrada comercial ao entardecer, o eremita da floresta que surgiu do nada para avisar de perigo oculto adiante, ou o acólito druídico protegendo uma nascente sagrada não compartilham seus temores. Pois esses povos já foram tocados pela maldição licantropica e aceitaram os dons bestiais que ela confere.

Wulven são filhos naturais ou descendentes de um indivíduo amaldiçoado com licantropia, não herdando a maldição por inteiro, mas tocados por sua natureza feral. Aqueles afligidos dessa forma são comumente associados a lobisomens na mente dos plebeus, inspirando o nome que lhes foi dado. Mas wulven são igualmente propensos a descender de ursos-lobisomens, ratos-lobisomens, corvos-lobisomens ou licantropos ainda mais raros.

O traço mais fraco de licantropia transmitido a um wulven significa que não assumem forma animal ou híbrida. São tão calmos e afáveis quanto qualquer povo, sem perda de controle ou sede de sangue irrefletida sob a lua cheia. Contudo, a natureza feral da fera que carregam dentro impulsiona a maioria dos wulven a vidas de solitude e ao silêncio da natureza selvagem.

Wulven encarnam o misticismo do mundo primal, em vez de sua selvageria. Onde vagam por florestas e matagais, sua aparência selvagem e natureza solitária faz com que sejam frequentemente confundidos com espíritos feéricos, druidas ou licantropos de fato. Muitos fazem vida como membros de enclaves druídicos ou como protetores de pequenas comunidades isoladas. Alguns tornam-se emissários ou campeões das cortes feéricas, embora o toque de magia amaldiçoada nos wulven faça alguns feéricos desconfiarem deles. Mas, no fim, a maioria dos wulven vive como forasteiros, cautelosos com povos que não conhecem, temendo que sua natureza solitária e traços sutilmente bestiais sejam mal compreendidos.

Wulven podem surgir entre qualquer outra cultura ou povo e recorrem aos traços físicos desses povos.',
  'Variante eldritch',
  'Variante eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  NULL,
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  creature_type = EXCLUDED.creature_type,
  size_rule = EXCLUDED.size_rule,
  speed_rule = EXCLUDED.speed_rule,
  allows_speed_trade = EXCLUDED.allows_speed_trade,
  allows_size_choice = EXCLUDED.allows_size_choice,
  description = EXCLUDED.description,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  source_meta = EXCLUDED.source_meta;

INSERT INTO rpg.phb_heritage_trait (
  slug, anchor_id, category, name, description,
  benefit_base, benefit_improved, improved_name, max_takes, take_mode
)
VALUES
(
  'a-sight-to-behold',
  'GiftedPerformerRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Um Espetáculo a Contemplar',
  'Quando você quer se destacar, tem um dom natural para impressionar os outros. Você tem proficiência na perícia Atuação.

Um Espetáculo a Contemplar. Se você escolher este traço duas vezes, você tem Vantagem em testes de Atuação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando você quer se destacar, tem um dom natural para impressionar os outros. Você tem proficiência na perícia Atuação.',
  'Um Espetáculo a Contemplar. Se você escolher este traço duas vezes, você tem Vantagem em testes de Atuação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Um Espetáculo a Contemplar',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'adaptive-awareness',
  'EnvironmentalAwarenessExploration',
  'exploration'::rpg.heritage_trait_category,
  'Percepção Adaptativa',
  'O mundo natural é um lugar perigoso, e sua conexão to specific parts of that world grants you an edge in survival. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. While in esse ambiente, whenever você faz an ability check to assess structures, monuments, or natural features; to find food or drinkable water; or to track creatures, você é considerado como tendo proficiency in the a perícia apropriada para o teste, e você soma o dobro your Bônus de Proficiência to o teste em vez do seu bônus normal.

Percepção Adaptativa. Se você escolher este traço várias vezes, você ganha o benefício para um novo ambiente a cada vez.

Além disso, when você faz an ability check using Percepção Ambiental, você tem Vantagem em o teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'O mundo natural é um lugar perigoso, e sua conexão to specific parts of that world grants you an edge in survival. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. While in esse ambiente, whenever você faz an ability check to assess structures, monuments, or natural features; to find food or drinkable water; or to track creatures, você é considerado como tendo proficiency in the a perícia apropriada para o teste, e você soma o dobro your Bônus de Proficiência to o teste em vez do seu bônus normal.',
  'Percepção Adaptativa. Se você escolher este traço várias vezes, você ganha o benefício para um novo ambiente a cada vez.

Além disso, when você faz an ability check using Percepção Ambiental, você tem Vantagem em o teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Percepção Adaptativa',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'animal-ally',
  'AnimalFriendRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Aliado Animal',
  'Tempo entre feras lhe deu jeito com essas criaturas. Você tem proficiência na perícia Adestrar Animais.

Aliado Animal. Se você escolher este traço duas vezes, você tem Vantagem em testes de Adestrar Animais. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Algo precisa ser feito com aquela elfa. Da última vez que a confrontei, ela sicou meu próprio cão contra mim.

— Vizinho ressentido',
  'Tempo entre feras lhe deu jeito com essas criaturas. Você tem proficiência na perícia Adestrar Animais.',
  'Aliado Animal. Se você escolher este traço duas vezes, você tem Vantagem em testes de Adestrar Animais. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Algo precisa ser feito com aquela elfa. Da última vez que a confrontei, ela sicou meu próprio cão contra mim.

— Vizinho ressentido',
  'Aliado Animal',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'artisanal-expertise',
  'ArtisanalFocusRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Perícia Artesanal',
  'Você reverencia a perícia artesanal de ancestrais há muito mortos. Choose an Artisan’s Tool. Você tem proficiência com essa ferramenta.

Perícia Artesanal. Se você escolher este traço várias vezes, você ganha proficiência com uma nova ferramenta a cada vez.

Além disso, você tem Vantagem em testes de ability made using qualquer ferramenta que você escolheu com Foco Artesanal. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você reverencia a perícia artesanal de ancestrais há muito mortos. Choose an Artisan’s Tool. Você tem proficiência com essa ferramenta.',
  'Perícia Artesanal. Se você escolher este traço várias vezes, você ganha proficiência com uma nova ferramenta a cada vez.

Além disso, você tem Vantagem em testes de ability made using qualquer ferramenta que você escolheu com Foco Artesanal. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Perícia Artesanal',
  NULL,
  'choice_each_take'::rpg.heritage_trait_take_mode
),
(
  'astute-slip',
  'QuickSlipCombat',
  'combat'::rpg.heritage_trait_category,
  'Escorregão Astuto',
  'Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. Você pode realizar the Hide action como Ação Bônus on each of your turns. Você deve have appropriate cover to attempt to hide, as normal.

Escorregão Astuto. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. você faz with the Hide action quando você use Quick Slip.',
  'Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. Você pode realizar the Hide action como Ação Bônus on each of your turns. Você deve have appropriate cover to attempt to hide, as normal.',
  'Escorregão Astuto. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. você faz with the Hide action quando você use Quick Slip.',
  'Escorregão Astuto',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'athlete-s-resolve',
  'AthletesSpiritRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Determinação Atlética',
  'Suas reservas de força física já o mantiveram vivo em mais de uma ocasião. Você tem proficiência na perícia Atletismo.

Determinação Atlética. Se você escolher este traço duas vezes, você tem Vantagem em testes de Atletismo. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Suas reservas de força física já o mantiveram vivo em mais de uma ocasião. Você tem proficiência na perícia Atletismo.',
  'Determinação Atlética. Se você escolher este traço duas vezes, você tem Vantagem em testes de Atletismo. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Determinação Atlética',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'battlefield-dominance',
  'BattlefieldControlCombat',
  'combat'::rpg.heritage_trait_category,
  'Domínio de Campo de Batalha',
  'When foes attempt to press you in melee, they do so at their peril. Other creatures provoke Ataque de Oportunidades from you whenever they move into your reach, in addition to when they move out of your reach.

Domínio de Campo de Batalha. Se você escolher este traço duas vezes, você tem Vantagem em Ataques de Oportunidade. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'When foes attempt to press you in melee, they do so at their peril. Other creatures provoke Ataque de Oportunidades from you whenever they move into your reach, in addition to when they move out of your reach.',
  'Domínio de Campo de Batalha. Se você escolher este traço duas vezes, você tem Vantagem em Ataques de Oportunidade. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Domínio de Campo de Batalha',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'bond-with-nature',
  'ConnectiontoNatureRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Vínculo com a Natureza',
  'Você aprendeu que prestar atenção ao ambiente ao redor é a melhor forma de prever suas ameaças. Você tem proficiência na perícia Naturezazaza.

Bond with Naturezazaza. Se você escolher este traço duas vezes, você tem Vantagem em testes de Naturezazaza. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você aprendeu que prestar atenção ao ambiente ao redor é a melhor forma de prever suas ameaças. Você tem proficiência na perícia Naturezazaza.',
  'Vínculo com a Natureza. zazaza. Se você escolher este traço duas vezes, você tem Vantagem em testes de Naturezazaza. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  NULL,
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'born-lucky',
  'TimelyBoonCombat',
  'combat'::rpg.heritage_trait_category,
  'Nascido Sob a Sorte',
  'Fortune favors you at times when a threat might send you down. Quando você falha a salvaguarda, você pode usar your Reação to roll a d4 and add it to the save, potentially turning it into a success. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Nascido Sob a Sorte. Se você escolher este traço duas vezes, você rola a d8 instead of a d4 quando você use Timely Boon.',
  'Fortune favors you at times when a threat might send you down. Quando você falha a salvaguarda, você pode usar your Reação to roll a d4 and add it to the save, potentially turning it into a success. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Nascido Sob a Sorte. Se você escolher este traço duas vezes, você rola a d8 instead of a d4 quando você use Timely Boon.',
  'Nascido Sob a Sorte',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'calculated-disappearance',
  'InstinctiveStealthRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Desaparecimento Calculado',
  'When trouble comes for you, you excel at making sure it can’t find you. Você tem proficiência na perícia Furtividade.

Desaparecimento Calculado. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'When trouble comes for you, you excel at making sure it can’t find you. Você tem proficiência na perícia Furtividade.',
  'Desaparecimento Calculado. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Desaparecimento Calculado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'centered-edge',
  'CenteredCombat',
  'combat'::rpg.heritage_trait_category,
  'Fio Centrado',
  'By focusing your inner strength, você ganha a needed edge. Como Ação Bônus, you grant yourself Vantagem em uma jogada de ataque or ability check você faz before the start of your next turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Fio Centrado. Se você escolher este traço duas vezes, quando você succeed on the jogada de ataque or ability check made while using Centered, você pode escolher one creature within 9 m of you. That creature has Vantagem em the next jogada de ataque or ability check they make before the start of your next turn.',
  'By focusing your inner strength, você ganha a needed edge. Como Ação Bônus, you grant yourself Vantagem em uma jogada de ataque or ability check você faz before the start of your next turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Fio Centrado. Se você escolher este traço duas vezes, quando você succeed on the jogada de ataque or ability check made while using Centered, você pode escolher one creature within 9 m of you. That creature has Vantagem em the next jogada de ataque or ability check they make before the start of your next turn.',
  'Fio Centrado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'combat-doctor',
  'BornHealerRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Médico de Combate',
  'Quando outros sofrem, você está lá para ajudar. Você tem proficiência na perícia Medicina.

Médico de Combate. Se você escolher este traço duas vezes, você tem Vantagem em testes de Medicina. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando outros sofrem, você está lá para ajudar. Você tem proficiência na perícia Medicina.',
  'Médico de Combate. Se você escolher este traço duas vezes, você tem Vantagem em testes de Medicina. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Médico de Combate',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'crafter-s-cunning',
  'CraftersEyeRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Astúcia do Artífice',
  'The history of Etharis is written in relics, and you read that history better than most. Quando você faz a História check related to any object (an item, device, building, or material) and você tem proficiency in an Artisan’s Tool associated with creating that object, você é considerado proficiente em História e você soma o dobro your Bônus de Proficiência to o teste em vez do seu bônus normal.

Astúcia do Artífice. Se você escolher este traço duas vezes, você tem Vantagem em testes de the História. você faz with Crafter’s Eye. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The history of Etharis is written in relics, and you read that history better than most. Quando você faz a História check related to any object (an item, device, building, or material) and você tem proficiency in an Artisan’s Tool associated with creating that object, você é considerado proficiente em História e você soma o dobro your Bônus de Proficiência to o teste em vez do seu bônus normal.',
  'Astúcia do Artífice. Se você escolher este traço duas vezes, você tem Vantagem em testes de the História. você faz with Crafter’s Eye. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Astúcia do Artífice',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'damage-immunity',
  'DamageResistanceCombat',
  'combat'::rpg.heritage_trait_category,
  'Imunidade a Dano',
  'Exposure to the worst effects of a specific energy has given you a tolerance to its effects. Você tem Resistência to one of o seguinte damage types de sua escolha: Acid, Cold, Fire, Lightning, Poison, or Thunder.

Damage Imunidade. Se você escolher este traço duas vezes, como Reação to taking damage of the type you chose for Damage Resistência, você ganha Imunidade to that damage type até o fim do seu próximo turno. You regain the use este recurso quando você finish a Descanso Curto.',
  'Exposure to the worst effects of a specific energy has given you a tolerance to its effects. Você tem Resistência to one of o seguinte damage types de sua escolha: Acid, Cold, Fire, Lightning, Poison, or Thunder.',
  'Damage Imunidade. Se você escolher este traço duas vezes, como Reação to taking damage of the type you chose for Damage Resistência, você ganha Imunidade to that damage type até o fim do seu próximo turno. You regain the use este recurso quando você finish a Descanso Curto.',
  'Imunidade a Dano',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'deep-lore',
  'EmbraceThePastRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Lore Profundo',
  'As lições do passado são duras, mas aprendê-las pode dar a melhor perspectiva para navegar o futuro. Você tem proficiência na perícia História.

Lore Profundo. Se você escolher este traço duas vezes, você tem Vantagem em testes de História. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'As lições do passado são duras, mas aprendê-las pode dar a melhor perspectiva para navegar o futuro. Você tem proficiência na perícia História.',
  'Lore Profundo. Se você escolher este traço duas vezes, você tem Vantagem em testes de História. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Lore Profundo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'determined-hearing',
  'ResilientEarsExploration',
  'exploration'::rpg.heritage_trait_category,
  'Audição Determinada',
  'Even as destruction rains down around you, your hearing stays sharp. Você tem Vantagem em salvaguardas against having the Deafened condition.

Audição Determinada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção. que envolvem audição. Além disso, Quando você falha a salvaguarda against being Deafened, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Even as destruction rains down around you, your hearing stays sharp. Você tem Vantagem em salvaguardas against having the Deafened condition.',
  'Audição Determinada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção. que envolvem audição. Além disso, Quando você falha a salvaguarda against being Deafened, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Audição Determinada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'determined-survivor',
  'KeenSurvivorRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Sobrevivente Determinado',
  'As terras selvagens de Etharis reclamaram muitos que não tinham perícia para navegá-las. Você tem proficiência na perícia Sobrevivência.

Sobrevivente Determinado. Se você escolher este traço duas vezes, você tem Vantagem em testes de Sobrevivência. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'As terras selvagens de Etharis reclamaram muitos que não tinham perícia para navegá-las. Você tem proficiência na perícia Sobrevivência.',
  'Sobrevivente Determinado. Se você escolher este traço duas vezes, você tem Vantagem em testes de Sobrevivência. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sobrevivente Determinado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'endless-breath',
  'HoldBreathExploration',
  'exploration'::rpg.heritage_trait_category,
  'Fôlego Inesgotável',
  'Whether trapped under black water or resisting poisonous fumes, you refuse to give in. Você pode hold your breath for up to 1 hour.

Fôlego Inesgotável. Se você escolher este traço duas vezes, você pode hold your breath for up to 8 hours.',
  'Whether trapped under black water or resisting poisonous fumes, you refuse to give in. Você pode hold your breath for up to 1 hour.',
  'Fôlego Inesgotável. Se você escolher este traço duas vezes, você pode hold your breath for up to 8 hours.',
  'Fôlego Inesgotável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'ethereal-focus',
  'EtherealFadeExploration',
  'exploration'::rpg.heritage_trait_category,
  'Foco Etéreo',
  'Shifting away from the mortal world lets you move through and observe that world unseen. Como ação Mágica, you fade from the Material Plane into the Ethereal Plane por 1 minuto. While you remain in this state, você pode’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. Você pode move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappear in the Material Plane in the closest unoccupied space to where you faded from. Você pode end the effect early como Ação Bônus. You regain the use of este recurso again quando você finish a Descanso Longo.

Foco Etéreo. Se você escolher este traço duas vezes, você tem Vantagem when making Sabedoria testes como parte de uma Search Ação.',
  'Shifting away from the mortal world lets you move through and observe that world unseen. Como ação Mágica, you fade from the Material Plane into the Ethereal Plane por 1 minuto. While you remain in this state, você pode’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. Você pode move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappear in the Material Plane in the closest unoccupied space to where you faded from. Você pode end the effect early como Ação Bônus. You regain the use of este recurso again quando você finish a Descanso Longo.',
  'Foco Etéreo. Se você escolher este traço duas vezes, você tem Vantagem when making Sabedoria testes como parte de uma Search Ação.',
  'Foco Etéreo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'even-larger',
  'LargerTargetCombat',
  'combat'::rpg.heritage_trait_category,
  'Ainda Maior',
  'Foes that outsize you quickly learn to fear your wrath. Se você hit a creature that is one size larger than you, você pode escolher to deal extra damage to the creature igual a your Bônus de Proficiência. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Ainda Maior. Se você escolher este traço duas vezes, Larger Target applies to creatures of any size larger than you.',
  'Foes that outsize you quickly learn to fear your wrath. Se você hit a creature that is one size larger than you, você pode escolher to deal extra damage to the creature igual a your Bônus de Proficiência. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Ainda Maior. Se você escolher este traço duas vezes, Larger Target applies to creatures of any size larger than you.',
  'Ainda Maior',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'exceptional-insight',
  'CommandingInsightRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Intuição Excepcional',
  'Those who attempt to deceive you do so in vain. Você tem proficiência na perícia Intuição.

Exceptional Intuição. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intuição. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Those who attempt to deceive you do so in vain. Você tem proficiência na perícia Intuição.',
  'Exceptional Intuição. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intuição. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Intuição Excepcional',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'expert-deceiver',
  'EagerDeceiverRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Enganador Expert',
  'You long ago learned that being open with others only gives them power over you. Você tem proficiência na perícia Enganação.

Enganador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de Enganação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'You long ago learned that being open with others only gives them power over you. Você tem proficiência na perícia Enganação.',
  'Enganador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de Enganação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Enganador Expert',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'expert-improviser',
  'ImproviserRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Improvisador Expert',
  'When needs demand, you get the job done better than most. Como Ação Bônus, choose one skill or tool that you don’t have proficiency with. Você tem proficiência na perícia that. or with essa ferramenta por 1 hora. You regain the use of este recurso quando você finish a Descanso Longo.

Improvisador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de ability. você faz using the skill or tool you select with Improviser. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'When needs demand, you get the job done better than most. Como Ação Bônus, choose one skill or tool that you don’t have proficiency with. Você tem proficiência na perícia that. or with essa ferramenta por 1 hora. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Improvisador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de ability. você faz using the skill or tool you select with Improviser. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Improvisador Expert',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'expert-orientation',
  'IntrinsicOrientationExploration',
  'exploration'::rpg.heritage_trait_category,
  'Orientação Expert',
  'A single misstep can lead to ruin, but your instincts for direction keep you from going astray. You always know which way is north, and você pode reckon a cardinal direction of the GM’s determination while on other planes. Além disso, você tem Vantagem em testes de ability made to avoid becoming lost, to navigate, or to track.

Orientação Expert. Se você escolher este traço duas vezes, Quando você falha an ability check made to avoid becoming lost, to navigate, or to track, você pode escolher to succeed instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'A single misstep can lead to ruin, but your instincts for direction keep you from going astray. You always know which way is north, and você pode reckon a cardinal direction of the GM’s determination while on other planes. Além disso, você tem Vantagem em testes de ability made to avoid becoming lost, to navigate, or to track.',
  'Orientação Expert. Se você escolher este traço duas vezes, Quando você falha an ability check made to avoid becoming lost, to navigate, or to track, você pode escolher to succeed instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Orientação Expert',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'exquisite-legerdemain',
  'NimbleMovesRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Prestidigitação Requintada',
  'Você tem learned the value of being able to manipulate the world around you without attracting the notice of others. Você tem proficiência na perícia Sleight of Hand.

Prestidigitação Requintada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Sleight of Hand. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você tem learned the value of being able to manipulate the world around you without attracting the notice of others. Você tem proficiência na perícia Sleight of Hand.',
  'Prestidigitação Requintada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Sleight of Hand. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Prestidigitação Requintada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'extended-fortification',
  'MagicalFortificationCombat',
  'combat'::rpg.heritage_trait_category,
  'Fortificação Estendida',
  'The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Força, Destreza, Constituição, Inteligência, Sabedoria, or Carisma. Você tem Vantagem em salvaguardas using that ability score against spells and other magical effects.

Fortificação Estendida. Se você escolher this trait multiple times, você tem Vantagem em salvaguardas using a new ability score each time.

Além disso, se você fail a salvaguarda against a spell or other magical effect and you do not have proficiency with that salvaguarda, você pode usar your Reação to reroll the save. You regain the use of este recurso quando você finish a Descanso Longo.',
  'The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Força, Destreza, Constituição, Inteligência, Sabedoria, or Carisma. Você tem Vantagem em salvaguardas using that ability score against spells and other magical effects.',
  'Fortificação Estendida. Se você escolher this trait multiple times, você tem Vantagem em salvaguardas using a new ability score each time.

Além disso, se você fail a salvaguarda against a spell or other magical effect and you do not have proficiency with that salvaguarda, você pode usar your Reação to reroll the save. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Fortificação Estendida',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'extra-tough',
  'ToughnessCombat',
  'combat'::rpg.heritage_trait_category,
  'Extra Resistente',
  'An intrinsic hardiness marks you as one born for battle. Your máximo de Pontos de Vida increases by 1, and it increases by 1 each time você ganha a level.

Extra Resistente. Se você escolher este traço duas vezes, your máximo de Pontos de Vida increases by 2 instead of 1, and it increases by 2 each time você ganha a level.

Além disso, when você faz a salvaguarda against an effect that would decrease your máximo de Pontos de Vida, você tem Vantagem em the save. You regain the use of este recurso quando você finish a Descanso Longo.',
  'An intrinsic hardiness marks you as one born for battle. Your máximo de Pontos de Vida increases by 1, and it increases by 1 each time você ganha a level.',
  'Extra Resistente. Se você escolher este traço duas vezes, your máximo de Pontos de Vida increases by 2 instead of 1, and it increases by 2 each time você ganha a level.

Além disso, when você faz a salvaguarda against an effect that would decrease your máximo de Pontos de Vida, você tem Vantagem em the save. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Extra Resistente',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'extreme-resilience',
  'PowerNapExploration',
  'exploration'::rpg.heritage_trait_category,
  'Resiliência Extrema',
  'Quando você don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest você pode get. When taking a Descanso Curto, você pode escolher to sleep por 1 hora. Se você do so, you reduce your Exhaustion by one level and regain a Dado de Vida in addition to the other benefits of a Descanso Curto.

Resiliência Extrema. Se você escolher este traço duas vezes, when using Power Nap, você pode escolher to regain a single resource that would normally refresh on a Descanso Longo. For example, a Sorcerer could choose to regain a Sorcery Point on a Descanso Curto.',
  'Quando você don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest você pode get. When taking a Descanso Curto, você pode escolher to sleep por 1 hora. Se você do so, you reduce your Exhaustion by one level and regain a Dado de Vida in addition to the other benefits of a Descanso Curto.',
  'Resiliência Extrema. Se você escolher este traço duas vezes, when using Power Nap, você pode escolher to regain a single resource that would normally refresh on a Descanso Longo. For example, a Sorcerer could choose to regain a Sorcery Point on a Descanso Curto.',
  'Resiliência Extrema',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'faultless-shroud',
  'ShroudoftheWildExploration',
  'exploration'::rpg.heritage_trait_category,
  'Manto Impecável',
  'With any degree of obscuration, your instinctive ability to conceal yourself lets you avoid your enemies’ notice. Você pode realizar the Hide action even quando você are only Lightly Obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.

Manto Impecável. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. using the Hide action while using Shroud of the Wild.',
  'With any degree of obscuration, your instinctive ability to conceal yourself lets you avoid your enemies’ notice. Você pode realizar the Hide action even quando você are only Lightly Obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.',
  'Manto Impecável. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. using the Hide action while using Shroud of the Wild.',
  'Manto Impecável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-edge',
  'FocusedReservesCombat',
  'combat'::rpg.heritage_trait_category,
  'Fio Concentrado',
  'No matter how badly beaten down you are, you find the will to keep fighting quando você most need it. Como Reação after you take damage, você pode roll um número de d6s igual a your Bônus de Proficiência and gain Pontos de Vida Temporários igual a the total. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Fio Concentrado. Se você escolher este traço duas vezes, você pode reroll 1s and 2s quando você use Focused Reserves, but you must use the new rolls.',
  'No matter how badly beaten down you are, you find the will to keep fighting quando você most need it. Como Reação after you take damage, você pode roll um número de d6s igual a your Bônus de Proficiência and gain Pontos de Vida Temporários igual a the total. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Fio Concentrado. Se você escolher este traço duas vezes, você pode reroll 1s and 2s quando você use Focused Reserves, but you must use the new rolls.',
  'Fio Concentrado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-initiative',
  'QuickInitiativeCombat',
  'combat'::rpg.heritage_trait_category,
  'Iniciativa Concentrada',
  'Danger is never far away from you, and you are always ready for it. You add your Bônus de Proficiência to your Initiative rolls.

Iniciativa Concentrada. Se você escolher este traço duas vezes, when você rola Initiative, você pode treat a roll of 9 or lower as se você rolled a 10.',
  'Danger is never far away from you, and you are always ready for it. You add your Bônus de Proficiência to your Initiative rolls.',
  'Iniciativa Concentrada. Se você escolher este traço duas vezes, when você rola Initiative, você pode treat a roll of 9 or lower as se você rolled a 10.',
  'Iniciativa Concentrada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-mastery',
  'MasterfulAptitudeRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Maestria Concentrada',
  'Your discipline and focus give you an edge that others lack. Choose one of your skill or tool proficiencies. Você tem Expertise on ability testes made using the chosen proficiency.

Maestria Concentrada. Se você escolher this trait multiple times, você ganha its benefit for a new skill proficiency or tool proficiency each time.

Além disso, when você faz a check using a skill or tool for which you’ve taken Masterful Aptitude, você tem Vantagem em o teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Your discipline and focus give you an edge that others lack. Choose one of your skill or tool proficiencies. Você tem Expertise on ability testes made using the chosen proficiency.',
  'Maestria Concentrada. Se você escolher this trait multiple times, você ganha its benefit for a new skill proficiency or tool proficiency each time.

Além disso, when você faz a check using a skill or tool for which you’ve taken Masterful Aptitude, você tem Vantagem em o teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Maestria Concentrada',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-ruthlessness',
  'RuthlessResponseCombat',
  'combat'::rpg.heritage_trait_category,
  'Crueldade Concentrada',
  'A creature that gets the drop on you is met with a swift and brutal reply. Quando você realiza damage from a creature within your reach, você pode usar your Reação to make a melee attack with a weapon or an Ataque Desarmado against that creature. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Crueldade Concentrada. Se você escolher este traço duas vezes, você tem Vantagem em jogada de ataques made using Ruthless Response.',
  'A creature that gets the drop on you is met with a swift and brutal reply. Quando você realiza damage from a creature within your reach, você pode usar your Reação to make a melee attack with a weapon or an Ataque Desarmado against that creature. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Crueldade Concentrada. Se você escolher este traço duas vezes, você tem Vantagem em jogada de ataques made using Ruthless Response.',
  'Crueldade Concentrada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'force-of-faith',
  'MovedByFaithRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Força da Fé',
  'The grimmest myths and legends of the past hold the keys to shaping the future. Você tem proficiência na perícia Religião.

Força da Fé. Se você escolher este traço duas vezes, você tem Vantagem em testes de Religião. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The grimmest myths and legends of the past hold the keys to shaping the future. Você tem proficiência na perícia Religião.',
  'Força da Fé. Se você escolher este traço duas vezes, você tem Vantagem em testes de Religião. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Força da Fé',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'full-speed-squeeze',
  'SuppleSqueezeExploration',
  'exploration'::rpg.heritage_trait_category,
  'Espremimento em Velocidade Plena',
  'With an effort of will, you contort your body into the tightest spaces. Você pode squeeze through a space that is large enough for a creature two sizes smaller than you, rather than one size smaller.

Espremimento em Velocidade Plena. Se você escolher este traço duas vezes, squeezing does not cost you additional movement, and you do not have DesVantagem em jogada de ataques and Destreza salvaguardas while squeezing.',
  'With an effort of will, you contort your body into the tightest spaces. Você pode squeeze through a space that is large enough for a creature two sizes smaller than you, rather than one size smaller.',
  'Espremimento em Velocidade Plena. Se você escolher este traço duas vezes, squeezing does not cost you additional movement, and you do not have DesVantagem em jogada de ataques and Destreza salvaguardas while squeezing.',
  'Espremimento em Velocidade Plena',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'furious-charge',
  'ChargingAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Investida Furiosa',
  'The fury with which you throw yourself into battle forces your foes to feel your wrath. Se você move at least 6 m straight toward a target and then hit it with a melee attack with a weapon or an Ataque Desarmado on the same turn, você pode make another attack against the same target como Ação Bônus with the same weapon.

Investida Furiosa. Se você escolher este traço duas vezes, quando você use Charging Attack, você tem Vantagem em all attacks after the triggering movement até o fim de your turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The fury with which you throw yourself into battle forces your foes to feel your wrath. Se você move at least 6 m straight toward a target and then hit it with a melee attack with a weapon or an Ataque Desarmado on the same turn, você pode make another attack against the same target como Ação Bônus with the same weapon.',
  'Investida Furiosa. Se você escolher este traço duas vezes, quando você use Charging Attack, você tem Vantagem em all attacks after the triggering movement até o fim de your turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Investida Furiosa',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'furious-speed',
  'BurstOfSpeedExploration',
  'exploration'::rpg.heritage_trait_category,
  'Velocidade Furiosa',
  'The many things that want to kill you must catch you first. On your turn, você pode increase your Speed by 9 m até o fim de your turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Velocidade Furiosa. Se você escolher este traço duas vezes, on a turn quando você use Burst of Speed, you don’t provoke Ataque de Oportunidades.

On the battlefield, quick feet are the best suit of armor you could ask for. If an enemy can’t reach you, it can’t hurt you. Now pick up those knees!

—Militia Drillmaster',
  'The many things that want to kill you must catch you first. On your turn, você pode increase your Speed by 9 m até o fim de your turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Velocidade Furiosa. Se você escolher este traço duas vezes, on a turn quando você use Burst of Speed, you don’t provoke Ataque de Oportunidades.

On the battlefield, quick feet are the best suit of armor you could ask for. If an enemy can’t reach you, it can’t hurt you. Now pick up those knees!

—Militia Drillmaster',
  'Velocidade Furiosa',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'hard-to-kill',
  'TenaciousCombat',
  'combat'::rpg.heritage_trait_category,
  'Difícil de Matar',
  'Your enemies might put you down, but you are never down for long. Você tem Vantagem em Death Salvaguardas.

Difícil de Matar. Se você escolher este traço duas vezes, quando você drop to 0 Pontos de Vida but don’t die outright, you remain conscious. Você deve make Death Salvaguardas as normal while at 0 Pontos de Vida, and you suffer a Death Salvaguarda failure each time you take any damage, but você pode otherwise act freely. Você pode’t become Stable while you remain at 0 Pontos de Vida in this way.',
  'Your enemies might put you down, but you are never down for long. Você tem Vantagem em Death Salvaguardas.',
  'Difícil de Matar. Se você escolher este traço duas vezes, quando você drop to 0 Pontos de Vida but don’t die outright, you remain conscious. Você deve make Death Salvaguardas as normal while at 0 Pontos de Vida, and you suffer a Death Salvaguarda failure each time you take any damage, but você pode otherwise act freely. Você pode’t become Stable while you remain at 0 Pontos de Vida in this way.',
  'Difícil de Matar',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'heavy-armor-training',
  'MediumArmorTrainingCombat',
  'combat'::rpg.heritage_trait_category,
  'Treinamento em Armadura Pesada',
  'The pounding you routinely take in combat requires a formidable layer of defense. Você tem training with Medium armor and with Escudos.

Treinamento em Armadura Pesada. Se você escolher este traço duas vezes, você tem training with armadura pesada.',
  'The pounding you routinely take in combat requires a formidable layer of defense. Você tem training with Medium armor and with Escudos.',
  'Treinamento em Armadura Pesada. Se você escolher este traço duas vezes, você tem training with armadura pesada.',
  'Treinamento em Armadura Pesada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'helpful-tactics',
  'HelpingHandExplorationCombat',
  'combat'::rpg.heritage_trait_category,
  'Táticas Úteis',
  'You excel at aiding your allies, knowing that the time will come quando você need them to return the favor. Você pode usar the ação Ajudar como Ação Bônus to assist any ally making an ability check. (This is an Exploration trait.)

Táticas Úteis. Se você escolher este traço duas vezes, quando você use Helping Hand, você pode also assist an ally making uma jogada de ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo. (This is a Combat trait.)',
  'You excel at aiding your allies, knowing that the time will come quando você need them to return the favor. Você pode usar the ação Ajudar como Ação Bônus to assist any ally making an ability check. (This is an Exploration trait.)',
  'Táticas Úteis. Se você escolher este traço duas vezes, quando você use Helping Hand, você pode also assist an ally making uma jogada de ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo. (This is a Combat trait.)',
  'Táticas Úteis',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'hindering-distraction',
  'MasterOfDistractionCombat',
  'combat'::rpg.heritage_trait_category,
  'Distração Obstructiva',
  'You draw your foes’ attention to you, intending it to be the last diversion they ever see. As an Influence action, you put on a tactical display (bravado, cowardice, confusion, or some other tactic) that gets your enemies’ attention. Until the end of your next turn, any attack on an enemy within 3 m of you that could see you quando você took the Influence action is made with Vantagem . Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Distração Obstructiva. Se você escolher este traço duas vezes, quando você use Master of Distraction, one affected enemy de sua escolha also has DesVantagem em jogada de ataques it makes against any of your allies até o fim do seu próximo turno.',
  'You draw your foes’ attention to you, intending it to be the last diversion they ever see. As an Influence action, you put on a tactical display (bravado, cowardice, confusion, or some other tactic) that gets your enemies’ attention. Until the end of your next turn, any attack on an enemy within 3 m of you that could see you quando você took the Influence action is made with Vantagem . Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Distração Obstructiva. Se você escolher este traço duas vezes, quando você use Master of Distraction, one affected enemy de sua escolha also has DesVantagem em jogada de ataques it makes against any of your allies até o fim do seu próximo turno.',
  'Distração Obstructiva',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'immune-to-the-elements',
  'InuredToTheElementsExploration',
  'exploration'::rpg.heritage_trait_category,
  'Imune aos Elementos',
  'Even beneath scorching sun and in freezing cold, you hold yourself strong. Você tem Vantagem em Constituição salvaguardas made to resist the effects of extreme cold or extreme heat.

Imune to the Elements. Se você escolher este traço duas vezes, you automatically succeed on Constituição salvaguardas to resist the effects of extreme cold or extreme heat.',
  'Even beneath scorching sun and in freezing cold, you hold yourself strong. Você tem Vantagem em Constituição salvaguardas made to resist the effects of extreme cold or extreme heat.',
  'Imune to the Elements. Se você escolher este traço duas vezes, you automatically succeed on Constituição salvaguardas to resist the effects of extreme cold or extreme heat.',
  'Imune aos Elementos',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'immutable-mind',
  'FocusedMindCombat',
  'combat'::rpg.heritage_trait_category,
  'Mente Inabalável',
  'Your strength of will protects you from magic that would corrupt your mind. Você tem Vantagem em salvaguardas against being Charmed .

Mente Inabalável. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against being Charmed, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Your strength of will protects you from magic that would corrupt your mind. Você tem Vantagem em salvaguardas against being Charmed .',
  'Mente Inabalável. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against being Charmed, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Mente Inabalável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'improved-darkvision',
  'DarkvisionExploration',
  'exploration'::rpg.heritage_trait_category,
  'Visão no Escuro Aprimorada',
  'A life spent in shadow has made you grow accustomed to the gloom. Você pode see in Dim Light within 18 m of you as if it were Bright Light , and in Darkness within 18 m of you as if it were Dim Light. Você pode’t discern color in Darkness, only shades of gray.

Visão no Escuro Aprimorada. Se você escolher este traço duas vezes, the range of your Darkvision increases to 36 m.',
  'A life spent in shadow has made you grow accustomed to the gloom. Você pode see in Dim Light within 18 m of you as if it were Bright Light , and in Darkness within 18 m of you as if it were Dim Light. Você pode’t discern color in Darkness, only shades of gray.',
  'Visão no Escuro Aprimorada. Se você escolher este traço duas vezes, the range of your Darkvision increases to 36 m.',
  'Visão no Escuro Aprimorada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'incomparable-roar',
  'MenacingRoarCombat',
  'combat'::rpg.heritage_trait_category,
  'Rugido Incomparável',
  'Your battle cry can cause even the most formidable foes to quail before you. Como Ação Bônus, you emit a roar, shout, or other loud vocal outburst. Each creature de sua escolha within 3 m of you that can hear you must succeed on a Sabedoria salvaguarda (CD = 8 + your Bônus de Proficiência + your modificador de Constituição) or have the Amedrontado condtion até o fim do seu próximo turno. You regain the use of este recurso quando você finish a Descanso Longo.

Rugido Incomparável. Se você escolher este traço duas vezes, quando você use Menacing Roar, one target de sua escolha has DesVantagem em the salvaguarda.',
  'Your battle cry can cause even the most formidable foes to quail before you. Como Ação Bônus, you emit a roar, shout, or other loud vocal outburst. Each creature de sua escolha within 3 m of you that can hear you must succeed on a Sabedoria salvaguarda (CD = 8 + your Bônus de Proficiência + your modificador de Constituição) or have the Amedrontado condtion até o fim do seu próximo turno. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Rugido Incomparável. Se você escolher este traço duas vezes, quando você use Menacing Roar, one target de sua escolha has DesVantagem em the salvaguarda.',
  'Rugido Incomparável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'incredible-leap',
  'StandingLeapExploration',
  'exploration'::rpg.heritage_trait_category,
  'Salto Incrível',
  'Threats on the ground are of little concern as you leap over them with ease. Você pode make a Long Jump of up to 6 m and a High Jump of up to 3 m, with or without a running start. Se vocêr Speed is less than the distance você pode Long Jump, você pode leap only a distance igual a your Speed.

Salto Incrível. Se você escolher este traço duas vezes, você pode make a Long Jump of up to 9 m and a High Jump of up to 4,5 m, as limited by your speed.

Além disso, quando você jump out of another creature’s reach, the movement of the jump does not provoke Ataque de Oportunidades from that creature. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Threats on the ground are of little concern as you leap over them with ease. Você pode make a Long Jump of up to 6 m and a High Jump of up to 3 m, with or without a running start. Se vocêr Speed is less than the distance você pode Long Jump, você pode leap only a distance igual a your Speed.',
  'Salto Incrível. Se você escolher este traço duas vezes, você pode make a Long Jump of up to 9 m and a High Jump of up to 4,5 m, as limited by your speed.

Além disso, quando você jump out of another creature’s reach, the movement of the jump does not provoke Ataque de Oportunidades from that creature. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Salto Incrível',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'infectious-bravery',
  'BraveCombat',
  'combat'::rpg.heritage_trait_category,
  'Coragem Contagiante',
  'The horrors you’ve lived through have hardened you. Você tem Vantagem em salvaguardas to avoid being Amedrontado .

Coragem Contagiante. Se você escolher este traço duas vezes, você pode usar your Reação to bolster the spirits of your allies, granting one ally who can see or hear you Vantagem em a salvaguarda against being Amedrontado. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The horrors you’ve lived through have hardened you. Você tem Vantagem em salvaguardas to avoid being Amedrontado .',
  'Coragem Contagiante. Se você escolher este traço duas vezes, você pode usar your Reação to bolster the spirits of your allies, granting one ally who can see or hear you Vantagem em a salvaguarda against being Amedrontado. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Coragem Contagiante',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'language-expert',
  'PolyglotRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Expert em Idiomas',
  'The advantages of mastering the languages of enemies and allies alike are clear to you. Você aprende dois languages de sua escolha.

Expert em Idiomas. Se você escolher this trait multiple times, you learn two new languages each time.

Além disso, você tem Vantagem em testes de Influence action ability made to interact with another creature using any language you selected with Polyglot. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The advantages of mastering the languages of enemies and allies alike are clear to you. Você aprende dois languages de sua escolha.',
  'Expert em Idiomas. Se você escolher this trait multiple times, you learn two new languages each time.

Além disso, você tem Vantagem em testes de Influence action ability made to interact with another creature using any language you selected with Polyglot. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Expert em Idiomas',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'light-armor-expertise',
  'LightArmorTrainingCombat',
  'combat'::rpg.heritage_trait_category,
  'Perícia em Armadura Leve',
  'Dealing with the threats you face requires the right combination of protection and movement. Você tem training with Light armor.

Perícia em Armadura Leve. Se você escolher este traço duas vezes, your AC increases by 1 while wearing Light armor.',
  'Dealing with the threats you face requires the right combination of protection and movement. Você tem training with Light armor.',
  'Perícia em Armadura Leve. Se você escolher este traço duas vezes, your AC increases by 1 while wearing Light armor.',
  'Perícia em Armadura Leve',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'long-fade',
  'FadeAwayExploration',
  'exploration'::rpg.heritage_trait_category,
  'Desvanecimento Longo',
  'Você tem learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. Como Ação Bônus, você pode take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.

You become visible at the start of your next turn unless você tem moved into a position that allows you to use the Hide action normally. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Desvanecimento Longo. Se você escolher este traço duas vezes, você tem Vantagem em your ability check quando você take the Hide action from Fade Away, and you become visible at the end of your next turn instead of the start of your next turn.',
  'Você tem learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. Como Ação Bônus, você pode take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.',
  'You become visible at the start of your next turn unless você tem moved into a position that allows you to use the Hide action normally. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Desvanecimento Longo. Se você escolher este traço duas vezes, você tem Vantagem em your ability check quando você take the Hide action from Fade Away, and you become visible at the end of your next turn instead of the start of your next turn.',
  'Desvanecimento Longo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'magical-historian',
  'MagicalInsightRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Historiador Mágico',
  'Magic is power in the right hands, and those hands are yours. Você tem proficiência na perícia Arcanismo.

Historiador Mágico. Se você escolher este traço duas vezes, você tem Vantagem em testes de Arcanismo. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Magic is power in the right hands, and those hands are yours. Você tem proficiência na perícia Arcanismo.',
  'Historiador Mágico. Se você escolher este traço duas vezes, você tem Vantagem em testes de Arcanismo. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Historiador Mágico',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'magical-savant',
  'MagicalSavvyRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Erudito Mágico',
  'Whether through intensive study or the innate touch of magic in your blood, você tem the ability to invoke magical spells. Você aprende um cantrip de sua escolha from any spell list, which you cast using the associated ability score: Inteligência for magia de Magos, Sabedoria for Cleric and Druid spells, and Carisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Erudito Mágico. Se você escolher this trait multiple times, you select a different cantrip each time, or você pode select a level 1 spell from the same list como cantrip você tem previously chosen. Se você select a level 1 spell, você pode cast it once without expending a espaço de magia, and você recupera the ability to cast it in that way quando você finish a Descanso Longo. Se você have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells você pode prepare each day.',
  'Whether through intensive study or the innate touch of magic in your blood, você tem the ability to invoke magical spells. Você aprende um cantrip de sua escolha from any spell list, which you cast using the associated ability score: Inteligência for magia de Magos, Sabedoria for Cleric and Druid spells, and Carisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.',
  'Erudito Mágico. Se você escolher this trait multiple times, you select a different cantrip each time, or você pode select a level 1 spell from the same list como cantrip você tem previously chosen. Se você select a level 1 spell, você pode cast it once without expending a espaço de magia, and você recupera the ability to cast it in that way quando você finish a Descanso Longo. Se você have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells você pode prepare each day.',
  'Erudito Mágico',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'master-artisan',
  'ImpromptuArtisanRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Mestre Artesão',
  'You’ve never known the luxury of always having the gear you need, but você tem more than learned to make do. Se você possess Artisan’s Tools with which você tem proficiency, and se você have access to appropriate raw materials and any additional necessary equipment (as the GM determines), você pode usar a Descanso Curto to craft any one nonmagical item worth 10 PO or less, including:

The gear you create is workable but not high quality, and can’t be sold except as the GM determines.

Mestre Artesão. Se você escolher este traço duas vezes, você pode usar Impromptu Artisan during a Descanso Longo, during which you craft one nonmagical item worth 50 PO or less.',
  'You’ve never known the luxury of always having the gear you need, but você tem more than learned to make do. Se você possess Artisan’s Tools with which você tem proficiency, and se você have access to appropriate raw materials and any additional necessary equipment (as the GM determines), você pode usar a Descanso Curto to craft any one nonmagical item worth 10 PO or less, including:',
  'The gear you create is workable but not high quality, and can’t be sold except as the GM determines.

Mestre Artesão. Se você escolher este traço duas vezes, você pode usar Impromptu Artisan during a Descanso Longo, during which you craft one nonmagical item worth 50 PO or less.',
  'Mestre Artesão',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'master-manipulator',
  'CalculatingListenerRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Mestre Manipulador',
  'The weak-willed around you are easy targets for your manipulation. By conversing with a nonhostile creature for at least 1 minute, você pode attempt to charm them. The creature must succeed on a Sabedoria salvaguarda (CD = 8 + your modificador de Carisma + your Bônus de Proficiência) or have the Charmed condition por 1 hora. At the GM’s discretion, you also learn one piece of information that the target knows that relates to the topic of conversation while you speak to them. Regardless of whether or not the target succeeds on the salvaguarda, they remain unaware of your attempt. You regain use of este recurso quando você finish a Short or Descanso Longo.

Mestre Manipulador. Se você escolher este traço duas vezes, a creature has DesVantagem em the salvaguarda, and it has the Charmed condition por 8 horas on a failed save.',
  'The weak-willed around you are easy targets for your manipulation. By conversing with a nonhostile creature for at least 1 minute, você pode attempt to charm them. The creature must succeed on a Sabedoria salvaguarda (CD = 8 + your modificador de Carisma + your Bônus de Proficiência) or have the Charmed condition por 1 hora. At the GM’s discretion, you also learn one piece of information that the target knows that relates to the topic of conversation while you speak to them. Regardless of whether or not the target succeeds on the salvaguarda, they remain unaware of your attempt. You regain use of este recurso quando você finish a Short or Descanso Longo.',
  'Mestre Manipulador. Se você escolher este traço duas vezes, a creature has DesVantagem em the salvaguarda, and it has the Charmed condition por 8 horas on a failed save.',
  'Mestre Manipulador',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'master-of-fortune',
  'LuckyCombat',
  'combat'::rpg.heritage_trait_category,
  'Mestre da Fortuna',
  'The luck you carry will see you through the worst Etharis has to offer. Quando você rola a 1 on a Teste D20, você pode reroll that die but must use the new roll. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Mestre da Fortuna. Se você escolher este traço duas vezes, você tem Vantagem em the reroll made with Lucky.',
  'The luck you carry will see you through the worst Etharis has to offer. Quando você rola a 1 on a Teste D20, você pode reroll that die but must use the new roll. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Mestre da Fortuna. Se você escolher este traço duas vezes, você tem Vantagem em the reroll made with Lucky.',
  'Mestre da Fortuna',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'maximum-critical',
  'AwesomeCriticalCombat',
  'combat'::rpg.heritage_trait_category,
  'Crítico Máximo',
  'When fortune favors your blade, você conhece how to make it count. Quando você score a Acerto Crítico with a melee attack with a weapon or an Ataque Desarmado , você pode roll one of the weapon’s damage dice one additional time and add it to the extra damage of the Acerto Crítico.

Crítico Máximo. Se você escolher este traço duas vezes, quando você use Awesome Critical, você pode add the maximum of the weapon’s original damage dice and the extra Awesome Critical die to the extra damage of the Acerto Crítico, rather than rolling them. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'When fortune favors your blade, você conhece how to make it count. Quando você score a Acerto Crítico with a melee attack with a weapon or an Ataque Desarmado , você pode roll one of the weapon’s damage dice one additional time and add it to the extra damage of the Acerto Crítico.',
  'Crítico Máximo. Se você escolher este traço duas vezes, quando você use Awesome Critical, você pode add the maximum of the weapon’s original damage dice and the extra Awesome Critical die to the extra damage of the Acerto Crítico, rather than rolling them. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Crítico Máximo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'mobile-bastion',
  'PersonalBastionCombat',
  'combat'::rpg.heritage_trait_category,
  'Bastião Móvel',
  'Focusing all your resolve, you stand fast and watch your enemies flail against your defenses. Como ação Mágica, you become motionless and gain o seguinte effects:

Você pode’t take actions, and você pode’t use your Ação Bônus except to end the effect of this trait.

Bastião Móvel. Se você escolher este traço duas vezes, quando você use Personal Bastion, your Speed is reduced to half your normal Speed (rounded down), you do not have DesVantagem em Destreza salvaguardas, and você pode usar Ação Bônuss.',
  'Focusing all your resolve, you stand fast and watch your enemies flail against your defenses. Como ação Mágica, you become motionless and gain o seguinte effects:',
  'Você pode’t take actions, and você pode’t use your Ação Bônus except to end the effect of this trait.

Bastião Móvel. Se você escolher este traço duas vezes, quando você use Personal Bastion, your Speed is reduced to half your normal Speed (rounded down), you do not have DesVantagem em Destreza salvaguardas, and você pode usar Ação Bônuss.',
  'Bastião Móvel',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'moving-insight',
  'EnemyInMotionCombat',
  'combat'::rpg.heritage_trait_category,
  'Intuição em Movimento',
  'A lifetime spent wandering lets you judge when others’ movement works to your benefit. Quando você faz uma jogada de ataque against a creature or make a salvaguarda against a creature’s attack, spell, or ability, você pode usar a Reação to have Vantagem em the jogada de ataque or salvaguarda if that creature moved since the end of your last turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Moving Intuição. Se você escolher este traço duas vezes, Enemy in Motion also lets you use your Reação to affect an ally''s jogada de ataque or salvaguarda se vocêr ally is within 9 m.',
  'A lifetime spent wandering lets you judge when others’ movement works to your benefit. Quando você faz uma jogada de ataque against a creature or make a salvaguarda against a creature’s attack, spell, or ability, você pode usar a Reação to have Vantagem em the jogada de ataque or salvaguarda if that creature moved since the end of your last turn. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Moving Intuição. Se você escolher este traço duas vezes, Enemy in Motion also lets you use your Reação to affect an ally''s jogada de ataque or salvaguarda se vocêr ally is within 9 m.',
  'Intuição em Movimento',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'nimble-passage',
  'PassThroughExploration',
  'exploration'::rpg.heritage_trait_category,
  'Passagem Ágil',
  'Making use of constant movement lets you minimize the threat of larger foes. Você pode move through the space of any creature at least one size larger than you.

Passagem Ágil. Se você escolher este traço duas vezes, you do not treat another creature’s space as Difficult Terrain .',
  'Making use of constant movement lets you minimize the threat of larger foes. Você pode move through the space of any creature at least one size larger than you.',
  'Passagem Ágil. Se você escolher este traço duas vezes, you do not treat another creature’s space as Difficult Terrain .',
  'Passagem Ágil',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'opportune-reach',
  'ReachAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Alcance Oportuno',
  'As you hurl yourself into battle, your foes discover that trying to keep away from you won’t save them. Your reach increases by 1,5 m. This extra reach doesn’t apply to Ataque de Oportunidades.

Alcance Oportuno. Se você escolher este traço duas vezes, your extra reach from Reach Attack applies to Ataque de Oportunidades.',
  'As you hurl yourself into battle, your foes discover that trying to keep away from you won’t save them. Your reach increases by 1,5 m. This extra reach doesn’t apply to Ataque de Oportunidades.',
  'Alcance Oportuno. Se você escolher este traço duas vezes, your extra reach from Reach Attack applies to Ataque de Oportunidades.',
  'Alcance Oportuno',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'overwhelming-shove',
  'MightyShoveCombat',
  'combat'::rpg.heritage_trait_category,
  'Empurrão Avassalador',
  'Your powerful blows send your targets reeling. Quando você acerta uma creature no more than one size larger than you with a melee attack, você pode usar a Ação Bônus to attempt to shove that creature. The target must succeed on a Força or Destreza salvaguarda (CD = 8 + your modificador de Força + your Bônus de Proficiência) or be pushed up to 3 m away from you.

Empurrão Avassalador. Se você escolher este traço duas vezes, quando você use Mighty Shove, the target creature has DesVantagem em the salvaguarda.',
  'Your powerful blows send your targets reeling. Quando você acerta uma creature no more than one size larger than you with a melee attack, você pode usar a Ação Bônus to attempt to shove that creature. The target must succeed on a Força or Destreza salvaguarda (CD = 8 + your modificador de Força + your Bônus de Proficiência) or be pushed up to 3 m away from you.',
  'Empurrão Avassalador. Se você escolher este traço duas vezes, quando você use Mighty Shove, the target creature has DesVantagem em the salvaguarda.',
  'Empurrão Avassalador',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'pack-instinct',
  'PackTacticsCombat',
  'combat'::rpg.heritage_trait_category,
  'Instinto de Matilha',
  'Staying close to your allies in combat makes you even more dangerous. Quando você start your turn with at least one ally who isn’t Incapacitado within 1,5 m of another creature você pode see, você pode usar your Reação to have Vantagem em jogada de ataques against that creature até o fim de your turn.

Instinto de Matilha. Se você escolher este traço duas vezes, gaining Vantagem from Pack Tactics requires no action.',
  'Staying close to your allies in combat makes you even more dangerous. Quando você start your turn with at least one ally who isn’t Incapacitado within 1,5 m of another creature você pode see, você pode usar your Reação to have Vantagem em jogada de ataques against that creature até o fim de your turn.',
  'Instinto de Matilha. Se você escolher este traço duas vezes, gaining Vantagem from Pack Tactics requires no action.',
  'Instinto de Matilha',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'pack-leader',
  'PackHunterCombat',
  'combat'::rpg.heritage_trait_category,
  'Líder de Matilha',
  'Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 3 m of you is about to make uma jogada de ataque or a salvaguarda, você pode usar a Reação to grant that ally Vantagem em the attack or save. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Líder de Matilha. Se você escolher este traço duas vezes, Pack Hunter can be triggered by any ally within 9 m of you. Além disso, if the jogada de ataque misses or the salvaguarda fails, you don’t lose that usage of Pack Hunter.',
  'Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 3 m of you is about to make uma jogada de ataque or a salvaguarda, você pode usar a Reação to grant that ally Vantagem em the attack or save. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Líder de Matilha. Se você escolher este traço duas vezes, Pack Hunter can be triggered by any ally within 9 m of you. Além disso, if the jogada de ataque misses or the salvaguarda fails, you don’t lose that usage of Pack Hunter.',
  'Líder de Matilha',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'phase-shift',
  'OutofPhaseCombat',
  'combat'::rpg.heritage_trait_category,
  'Mudança de Fase',
  'Your corporeal presence shifts and fades, softening your enemies’ ability to harm you. Como Ação Bônus, por 1 minuto, all creatures have DesVantagem em jogada de ataques against you, and você pode move through other creature’s spaces without treating them as Difficult Terrain. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Mudança de Fase. Se você escolher este traço duas vezes, quando você use Out of Phase, você pode extend its benefit to any ally within 3 m of you.

Clear a special cell for this one. She’s got tricks.

—Castinellan Jailor',
  'Your corporeal presence shifts and fades, softening your enemies’ ability to harm you. Como Ação Bônus, por 1 minuto, all creatures have DesVantagem em jogada de ataques against you, and você pode move through other creature’s spaces without treating them as Difficult Terrain. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Mudança de Fase. Se você escolher este traço duas vezes, quando você use Out of Phase, você pode extend its benefit to any ally within 3 m of you.

Clear a special cell for this one. She’s got tricks.

—Castinellan Jailor',
  'Mudança de Fase',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'piercing-perception',
  'InbornPerceptionRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Percepção Penetrante',
  'The best way to avoid danger is to make sure you’re the first person to notice it. Você tem proficiência na perícia Percepção.

Perfurante Percepção. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The best way to avoid danger is to make sure you’re the first person to notice it. Você tem proficiência na perícia Percepção.',
  'Perfurante Percepção. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Percepção Penetrante',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'poison-indemnity',
  'PoisonResilienceExploration',
  'exploration'::rpg.heritage_trait_category,
  'Indenização ao Veneno',
  'Your exceptional fortitude lets you shrug off the effects of even the worst toxins. Você tem Vantagem em salvaguardas against being Envenenado .

Indenização ao Veneno. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against being Envenenado, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Your exceptional fortitude lets you shrug off the effects of even the worst toxins. Você tem Vantagem em salvaguardas against being Envenenado .',
  'Indenização ao Veneno. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against being Envenenado, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Indenização ao Veneno',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'potent-breath',
  'BreathWeaponCombat',
  'combat'::rpg.heritage_trait_category,
  'Sopro Potente',
  'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. Quando você select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 1,5 m wide and 9 m long, or a 4,5 m Cone .

Quando você use a ação Mágica to expel your Breath Weapon, each creature in the area of effect must make a Destreza salvaguarda (CD = 8 + your modificador de Constituição + your Bônus de Proficiência). A target creature takes 1d8 damage of the chosen type on a failed save, or half as much damage on a successful one. This damage increases by 1d8 Quando você alcança character levels 5 (2d8), 11 (3d8), and 17 (4d8).

Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Sopro Potente. Se você escolher this trait multiple times, você ganha an additional breath weapon each time, with its own number of uses, damage type, and area of effect.

Além disso, quando você use any of your Breath Weapons, one target de sua escolha has DesVantagem em the salvaguarda. You regain the use of este recurso quando você finish a Descanso Longo.',
  'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. Quando você select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 1,5 m wide and 9 m long, or a 4,5 m Cone .',
  'Quando você use a ação Mágica to expel your Breath Weapon, each creature in the area of effect must make a Destreza salvaguarda (CD = 8 + your modificador de Constituição + your Bônus de Proficiência). A target creature takes 1d8 damage of the chosen type on a failed save, or half as much damage on a successful one. This damage increases by 1d8 Quando você alcança character levels 5 (2d8), 11 (3d8), and 17 (4d8).

Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Sopro Potente. Se você escolher this trait multiple times, você ganha an additional breath weapon each time, with its own number of uses, damage type, and area of effect.

Além disso, quando você use any of your Breath Weapons, one target de sua escolha has DesVantagem em the salvaguarda. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Sopro Potente',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'powerful-shove',
  'PowerfulBuildExplorationCombat',
  'combat'::rpg.heritage_trait_category,
  'Empurrão Poderoso',
  'Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight você pode push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)

Empurrão Poderoso. Se você escolher este traço duas vezes, você pode move or knock foes prone with ease. Quando você use Unarmed Attack to shove a creature 1,5 m or give it the condição Caído, the target has DesVantagem em the salvaguarda. (This is a Combat trait.)',
  'Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight você pode push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)',
  'Empurrão Poderoso. Se você escolher este traço duas vezes, você pode move or knock foes prone with ease. Quando você use Unarmed Attack to shove a creature 1,5 m or give it the condição Caído, the target has DesVantagem em the salvaguarda. (This is a Combat trait.)',
  'Empurrão Poderoso',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'primal-voice',
  'NaturesVoiceRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Voz Primal',
  'Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, você pode communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and você pode’t understand or learn detailed information from them.

Voz Primal. Se você escolher este traço duas vezes, você tem Vantagem em testes de ability. made como parte de uman Influence action to interact with a Beast or Plant creature.',
  'Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, você pode communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and você pode’t understand or learn detailed information from them.',
  'Voz Primal. Se você escolher este traço duas vezes, você tem Vantagem em testes de ability. made como parte de uman Influence action to interact with a Beast or Plant creature.',
  'Voz Primal',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'protective-cover',
  'WellProtectedCombat',
  'combat'::rpg.heritage_trait_category,
  'Cobertura Protetora',
  'Your ability to roll with even the worst attacks means that armor would only slow you down. Quando você are not wearing armor, your AC is igual a 13 + your modificador de Destreza.

Cobertura Protetora. Se você escolher este traço duas vezes, when você faz a Destreza salvaguarda or are targeted by a ranged attack, você pode usar a Reação to have Vantagem em the salvaguarda or impose DesVantagem em the ranged jogada de ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Alternate Rules: Wounds and Resting

The Grim Hollow Campaign Guide contains alternate rules for resting and receiving both Grievous Wounds and Permanent Wounds. These alternate rules are meant to enhance game play in a dark fantasy world where the heroes have to overcome every sort of obstacle to achieve their goals.

Grievous Wounds are applied to characters that would be dropped to 0 Pontos de Vida, but instead choose to gain a lingering wound that stays with them. These wounds remain until a character takes a Descanso Longo (see Resting below) and undergoes treatment by a physician or someone trained in Medicina .

Permanent Wounds occur when a creature takes multiple Grievous Wounds, or when a character dies and is brought back to life. The challenges of Permanent Wounds can be offset with certain magic items or prosthetics.

The dark-fantasy vibe of Grim Hollow necessitates a change to the effects of Short and Descanso Longos. Grievous Wounds can be healed by taking a Descanso Longo, but those rests in Grim Hollow take 32 hours of resting in a completely safe environment.

//',
  'Your ability to roll with even the worst attacks means that armor would only slow you down. Quando você are not wearing armor, your AC is igual a 13 + your modificador de Destreza.',
  'Cobertura Protetora. Se você escolher este traço duas vezes, when você faz a Destreza salvaguarda or are targeted by a ranged attack, você pode usar a Reação to have Vantagem em the salvaguarda or impose DesVantagem em the ranged jogada de ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Alternate Rules: Wounds and Resting

The Grim Hollow Campaign Guide contains alternate rules for resting and receiving both Grievous Wounds and Permanent Wounds. These alternate rules are meant to enhance game play in a dark fantasy world where the heroes have to overcome every sort of obstacle to achieve their goals.

Grievous Wounds are applied to characters that would be dropped to 0 Pontos de Vida, but instead choose to gain a lingering wound that stays with them. These wounds remain until a character takes a Descanso Longo (see Resting below) and undergoes treatment by a physician or someone trained in Medicina .

Permanent Wounds occur when a creature takes multiple Grievous Wounds, or when a character dies and is brought back to life. The challenges of Permanent Wounds can be offset with certain magic items or prosthetics.

The dark-fantasy vibe of Grim Hollow necessitates a change to the effects of Short and Descanso Longos. Grievous Wounds can be healed by taking a Descanso Longo, but those rests in Grim Hollow take 32 hours of resting in a completely safe environment.

//',
  'Cobertura Protetora',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'quickened-swim',
  'SwimmerExploration',
  'exploration'::rpg.heritage_trait_category,
  'Natação Acelerada',
  'Você é in your element while in the water, moving with grace and ease. Você tem a Swim Speed igual a your Speed.

Natação Acelerada. Se você escolher este traço duas vezes, você pode usar the Dash action como Ação Bônus while swimming.',
  'Você é in your element while in the water, moving with grace and ease. Você tem a Swim Speed igual a your Speed.',
  'Natação Acelerada. Se você escolher este traço duas vezes, você pode usar the Dash action como Ação Bônus while swimming.',
  'Natação Acelerada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'reawakened',
  'AwakenedMindCombat',
  'combat'::rpg.heritage_trait_category,
  'Reavivado',
  'The dangers of Etharis have given you a focus that allows you to shrug off debilitating magical effects. You automatically succeed on salvaguardas against magical effects that would give you the Incapacitado , Stunned , or Unconscious conditions. This does not include effects that leave you Unconscious because you are reduced to 0 Pontos de Vida.

Reavivado. Se você escolher este traço duas vezes, you also have Vantagem em Inteligência, Sabedoria, and Carisma salvaguardas.',
  'The dangers of Etharis have given you a focus that allows you to shrug off debilitating magical effects. You automatically succeed on salvaguardas against magical effects that would give you the Incapacitado , Stunned , or Unconscious conditions. This does not include effects that leave you Unconscious because you are reduced to 0 Pontos de Vida.',
  'Reavivado. Se você escolher este traço duas vezes, you also have Vantagem em Inteligência, Sabedoria, and Carisma salvaguardas.',
  'Reavivado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'regenerative-healer',
  'UnnaturalHealerRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Curandeiro Regenerativo',
  'Your innate healing abilities let you recover from some of the grimmest wounds. During a Descanso Longo, você pode automatically reverse Grievous Wounds. Além disso, você pode reattach any severed body parts (fingers, legs, tails, and so on), which are automatically restored at the end of the Descanso Longo. Se vocêr severed body parts aren’t available, você pode replace them with the same body parts of another creature of the same general anatomy as you. Se você wish to intentionally swap out body parts with replacements, você pode sever your own body parts with no pain or discomfort.

The ability to make use of unusual body parts (for example, giving yourself the taloned paw of a lion se você lose a hand) are left to the GM’s discretion. In any event, swapping a severed body part for an unusual body part grants you no mechanical Vantagems not covered by other traits (see “ Features and Traits ”).

Curandeiro Regenerativo. Se você escolher este traço duas vezes, you automatically reverse Permanent Wounds during a Descanso Longo. Além disso, você pode restore any severed body part during a Descanso Longo, as if subject to the Regenerate spell. Você pode usar this trait to create unusual regenerated body parts at the GM’s determination.',
  'Your innate healing abilities let you recover from some of the grimmest wounds. During a Descanso Longo, você pode automatically reverse Grievous Wounds. Além disso, você pode reattach any severed body parts (fingers, legs, tails, and so on), which are automatically restored at the end of the Descanso Longo. Se vocêr severed body parts aren’t available, você pode replace them with the same body parts of another creature of the same general anatomy as you. Se você wish to intentionally swap out body parts with replacements, você pode sever your own body parts with no pain or discomfort.',
  'The ability to make use of unusual body parts (for example, giving yourself the taloned paw of a lion se você lose a hand) are left to the GM’s discretion. In any event, swapping a severed body part for an unusual body part grants you no mechanical Vantagems not covered by other traits (see “ Features and Traits ”).

Curandeiro Regenerativo. Se você escolher este traço duas vezes, you automatically reverse Permanent Wounds during a Descanso Longo. Além disso, você pode restore any severed body part during a Descanso Longo, as if subject to the Regenerate spell. Você pode usar this trait to create unusual regenerated body parts at the GM’s determination.',
  'Curandeiro Regenerativo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'relentless-instinct',
  'HuntersInstinctCombat',
  'combat'::rpg.heritage_trait_category,
  'Instinto Implacável',
  'You summon a surge of ferocity quando vocêr prey least expects it. No fim de each Descanso Longo, você ganha um número de d8s igual a your Bônus de Proficiência. Quando você faz an attack with a weapon or an Ataque Desarmado , você pode roll a d8 and add it to either the jogada de ataque or the jogada de dano. Se você add it to the d20 roll, você pode decide to roll the d8 after the d20 roll is made, but you must do so before the outcome of the roll is known.

Instinto Implacável. Se você escolher este traço duas vezes, whenever you use Hunter’s Instinct for uma jogada de ataque, if the jogada de ataque misses, you retain the d8 and can use it again.',
  'You summon a surge of ferocity quando vocêr prey least expects it. No fim de each Descanso Longo, você ganha um número de d8s igual a your Bônus de Proficiência. Quando você faz an attack with a weapon or an Ataque Desarmado , você pode roll a d8 and add it to either the jogada de ataque or the jogada de dano. Se você add it to the d20 roll, você pode decide to roll the d8 after the d20 roll is made, but you must do so before the outcome of the roll is known.',
  'Instinto Implacável. Se você escolher este traço duas vezes, whenever you use Hunter’s Instinct for uma jogada de ataque, if the jogada de ataque misses, you retain the d8 and can use it again.',
  'Instinto Implacável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'remarkable-driver',
  'DriverExploration',
  'exploration'::rpg.heritage_trait_category,
  'Condutor Notável',
  'The roads and waterways of Etharis are often no less dangerous than the open wilderness, and you dedicate yourself to moving others safely on those routes. Você tem proficiência com Navigator’s Tools , and você tem Vantagem em testes de ability made to drive a vehicle.

Condutor Notável. Se você escolher este traço duas vezes, você pode make testes involving driving a vehicle that require an action without having to use your action. Você pode only get this free use once per round.',
  'The roads and waterways of Etharis are often no less dangerous than the open wilderness, and you dedicate yourself to moving others safely on those routes. Você tem proficiência com Navigator’s Tools , and você tem Vantagem em testes de ability made to drive a vehicle.',
  'Condutor Notável. Se você escolher este traço duas vezes, você pode make testes involving driving a vehicle that require an action without having to use your action. Você pode only get this free use once per round.',
  'Condutor Notável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'resolute-sight',
  'IrrepressibleSightExploration',
  'exploration'::rpg.heritage_trait_category,
  'Visão Resoluta',
  'Any foe você pode see is a foe você pode take down—so você faz sure nothing prevents you from seeing. Você tem Vantagem em salvaguardas against having the Blinded condition.

Visão Resoluta. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against having the Blinded condition, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso after you finish a Descanso Longo.',
  'Any foe você pode see is a foe você pode take down—so você faz sure nothing prevents you from seeing. Você tem Vantagem em salvaguardas against having the Blinded condition.',
  'Visão Resoluta. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against having the Blinded condition, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso after you finish a Descanso Longo.',
  'Visão Resoluta',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'restorative-rest',
  'MeditativeRestExploration',
  'exploration'::rpg.heritage_trait_category,
  'Descanso Restaurador',
  'Sleep is a luxury you’ve never needed to afford. Quando você rest, you meditate deeply for 4 hours, dreaming but remaining conscious. After resting in this way, você ganha the same benefit that other humanoids do from 8 hours of sleep.

Descanso Restaurador. Se você escolher este traço duas vezes, you need to spend only 2 hours in your meditation to gain the benefit of 8 hours of sleep, and você ganha a d6 at the end of each Descanso Longo. Before the end of your next Descanso Longo, você pode roll the d6 and add it to any d20 Test você faz. Você pode decide to roll the d6 after the d20 Test is made, but you must do so before the outcome of the roll is known.',
  'Sleep is a luxury you’ve never needed to afford. Quando você rest, you meditate deeply for 4 hours, dreaming but remaining conscious. After resting in this way, você ganha the same benefit that other humanoids do from 8 hours of sleep.',
  'Descanso Restaurador. Se você escolher este traço duas vezes, you need to spend only 2 hours in your meditation to gain the benefit of 8 hours of sleep, and você ganha a d6 at the end of each Descanso Longo. Before the end of your next Descanso Longo, você pode roll the d6 and add it to any d20 Test você faz. Você pode decide to roll the d6 after the d20 Test is made, but you must do so before the outcome of the roll is known.',
  'Descanso Restaurador',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'sangromancy-savant',
  'DivineSangromancyCombat',
  'combat'::rpg.heritage_trait_category,
  'Erudito em Sangromancia',
  'A connection to the life force of others lets you shape that force to their benefit. Whenever an allied creature within 9 m of você recuperas Pontos de Vida, você pode spend a Hit Die and add the roll of the die to the number of Pontos de Vida gained by the ally.

Sangromancia Savant. Se você escolher este traço duas vezes, quando você use Divine Sangromancia, you also regain Pontos de Vida igual a your Hit Die roll.',
  'A connection to the life force of others lets you shape that force to their benefit. Whenever an allied creature within 9 m of você recuperas Pontos de Vida, você pode spend a Hit Die and add the roll of the die to the number of Pontos de Vida gained by the ally.',
  'Sangromancia Savant. Se você escolher este traço duas vezes, quando você use Divine Sangromancia, you also regain Pontos de Vida igual a your Hit Die roll.',
  'Erudito em Sangromancia',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'secret-dreams',
  'DreamwalkingRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Sonhos Secretos',
  'Sempre que você rest, you touch the dreams of those around you, seeding their thoughts and memories into your own mind. Quando você faz an ability check to recall lore or knowledge, você tem Vantagem em o teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Sonhos Secretos. Se você escolher este traço duas vezes, você ganha an instinctive knowledge of the secrets of other creatures while you touch their dreams. Using a Search action, you focus on one creature você pode see and make a CD 15 Sabedoria Intuição check. With a successful check, you learn one secret of the GM’s choice known to that creature. The secrets of creatures that don’t have a language come to you as vague images and impressions. You regain the use of este recurso quando você finish a Short or Descanso Longo.

Why bother with interrogation? Just let him rest a few hours. I’ll get you your answers.

—Varrigan the Dreamwalker',
  'Sempre que você rest, you touch the dreams of those around you, seeding their thoughts and memories into your own mind. Quando você faz an ability check to recall lore or knowledge, você tem Vantagem em o teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sonhos Secretos. Se você escolher este traço duas vezes, você ganha an instinctive knowledge of the secrets of other creatures while you touch their dreams. Using a Search action, you focus on one creature você pode see and make a CD 15 Sabedoria Intuição check. With a successful check, you learn one secret of the GM’s choice known to that creature. The secrets of creatures that don’t have a language come to you as vague images and impressions. You regain the use of este recurso quando você finish a Short or Descanso Longo.

Why bother with interrogation? Just let him rest a few hours. I’ll get you your answers.

—Varrigan the Dreamwalker',
  'Sonhos Secretos',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'self-repair',
  'ArtificialFormExploration',
  'exploration'::rpg.heritage_trait_category,
  'Autorreparo',
  'You were made, not born, e seu unnatural origin forever marks you as different. Você é a Construct, but your enchanted form still benefits from healing spells. Você pode also heal yourself by spending Dados de Vida during Descanso Curtos and Descanso Longos, as normal.

You don’t need to eat, drink, sleep, or breathe. Você deve still be inactive por 8 horas during a Descanso Longo to gain its benefits.

Autorreparo. Se você escolher este traço duas vezes, when the Mending cantrip is cast on you, você pode spend a Hit Die to regain um número de Pontos de Vida igual a the roll of the die mais seu modificador de Constituição (minimum 1 Hit Point). Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'You were made, not born, e seu unnatural origin forever marks you as different. Você é a Construct, but your enchanted form still benefits from healing spells. Você pode also heal yourself by spending Dados de Vida during Descanso Curtos and Descanso Longos, as normal.',
  'You don’t need to eat, drink, sleep, or breathe. Você deve still be inactive por 8 horas during a Descanso Longo to gain its benefits.

Autorreparo. Se você escolher este traço duas vezes, when the Mending cantrip is cast on you, você pode spend a Hit Die to regain um número de Pontos de Vida igual a the roll of the die mais seu modificador de Constituição (minimum 1 Hit Point). Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Autorreparo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'shared-camouflage',
  'NaturalCamouflageExploration',
  'exploration'::rpg.heritage_trait_category,
  'Camuflagem Compartilhada',
  'Your ability to fade into the background of familiar territory helps keep you safe from threats. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Você tem Vantagem em testes de Furtividade made with the Hide action while in esse ambiente.

Camuflagem Compartilhada. Se você escolher this trait multiple times, você ganha its benefits for a new environment each time.

Além disso, quando você take the Hide action, você pode forgo making a Furtividade check while in any environment chosen with Natural Camouflage, instead treating o teste as se você had rolled a 15. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Your ability to fade into the background of familiar territory helps keep you safe from threats. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Você tem Vantagem em testes de Furtividade made with the Hide action while in esse ambiente.',
  'Camuflagem Compartilhada. Se você escolher this trait multiple times, você ganha its benefits for a new environment each time.

Além disso, quando você take the Hide action, você pode forgo making a Furtividade check while in any environment chosen with Natural Camouflage, instead treating o teste as se você had rolled a 15. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Camuflagem Compartilhada',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'shared-fleetness',
  'FleetofFootExploration',
  'exploration'::rpg.heritage_trait_category,
  'Agilidade Compartilhada',
  'As you’ve learned more than once, moving fast is often the best way to avoid trouble. Your Speed increases by 1,5 m.

Agilidade Compartilhada. Se você escolher este traço duas vezes, your Speed increases by another 1,5 m, for a total increase of 3 m.

Além disso, como Ação Bônus, choose any number of creatures within 9 m. Those creatures gain a 10 foot bonus to their Speed por 1 minuto. You regain the use of este recurso quando você finish a Descanso Longo.',
  'As you’ve learned more than once, moving fast is often the best way to avoid trouble. Your Speed increases by 1,5 m.',
  'Agilidade Compartilhada. Se você escolher este traço duas vezes, your Speed increases by another 1,5 m, for a total increase of 3 m.

Além disso, como Ação Bônus, choose any number of creatures within 9 m. Those creatures gain a 10 foot bonus to their Speed por 1 minuto. You regain the use of este recurso quando você finish a Descanso Longo.',
  NULL,
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'shared-movement',
  'NaturalMovementExploration',
  'exploration'::rpg.heritage_trait_category,
  'Movimento Compartilhado',
  'The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. While in esse ambiente, moving through nonmagical Difficult Terrain costs you no extra movement, and ability testes made to track você tem Desvantagem.

Movimento Compartilhado. Se você escolher this trait multiple times, você ganha its benefits for a new environment each time. Além disso, while in any environment chosen for Natural Movement, como Ação Bônus, você pode grant creatures de sua escolha the benefit of Natural Movement por 1 hora, as long as those creatures remain within 36 m of you and can see you.',
  'The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. While in esse ambiente, moving through nonmagical Difficult Terrain costs you no extra movement, and ability testes made to track você tem Desvantagem.',
  'Movimento Compartilhado. Se você escolher this trait multiple times, você ganha its benefits for a new environment each time. Além disso, while in any environment chosen for Natural Movement, como Ação Bônus, você pode grant creatures de sua escolha the benefit of Natural Movement por 1 hora, as long as those creatures remain within 36 m of you and can see you.',
  'Movimento Compartilhado',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'skill-mastery',
  'ProwessRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Maestria em Perícia',
  'Your ingenuity and inventiveness help keep you alive in a dangerous world. Before você faz an ability check using a skill you are proficient with, você pode add your Bônus de Proficiência again. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Maestria em Perícia. Se você escolher este traço duas vezes, Quando você falha an ability check made using the Skill Prowess trait, você pode reroll o teste and must use the new roll.',
  'Your ingenuity and inventiveness help keep you alive in a dangerous world. Before você faz an ability check using a skill you are proficient with, você pode add your Bônus de Proficiência again. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Maestria em Perícia. Se você escolher este traço duas vezes, Quando você falha an ability check made using the Skill Prowess trait, você pode reroll o teste and must use the new roll.',
  'Maestria em Perícia',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'sleeping-ward',
  'EveninSleepExploration',
  'exploration'::rpg.heritage_trait_category,
  'Proteção do Sono',
  'An instinctive sense for danger protects you at all times. While você tem the Unconscious condition while asleep, you are aware of your surroundings and can make Percepção testes normally.

Proteção do Sono. Se você escolher este traço duas vezes, while you are asleep, you automatically detect the presence of any creature intending harm to you that moves within 9 m of you. A creature that is simply capable of harming you does not trigger this trait until it has intent to do so. For example, a wild animal might approach you cautiously, then decide to attack only when it realizes you are sleeping.',
  'An instinctive sense for danger protects you at all times. While você tem the Unconscious condition while asleep, you are aware of your surroundings and can make Percepção testes normally.',
  'Proteção do Sono. Se você escolher este traço duas vezes, while you are asleep, you automatically detect the presence of any creature intending harm to you that moves within 9 m of you. A creature that is simply capable of harming you does not trigger this trait until it has intent to do so. For example, a wild animal might approach you cautiously, then decide to attack only when it realizes you are sleeping.',
  NULL,
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'slip-free',
  'UncheckedCombat',
  'combat'::rpg.heritage_trait_category,
  'Libertação Ágil',
  'Your ability to stay in motion is second to none, and foes try in vain to pin you down. Você tem Vantagem em salvaguardas against being Restrained .

Libertação Ágil. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against being Restrained, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Your ability to stay in motion is second to none, and foes try in vain to pin you down. Você tem Vantagem em salvaguardas against being Restrained .',
  'Libertação Ágil. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against being Restrained, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Libertação Ágil',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'smoker',
  'ArtificeExpertiseExplorationCombat',
  'combat'::rpg.heritage_trait_category,
  'Fumante',
  'Working with detritus and shattered objects has granted you an affinity for repairing and remaking things. Você tem proficiência com Tinker’s Tools . (This is an Exploration trait.)

Além disso, você pode usar your Tinker’s Tools and 10 PO worth of appropriate materials to spend 10 minutes creating a small clockwork device. The device must fit in the palm of your hand, and can serve one of o seguinte functions:

Fumante. The device exudes smoke in a 1,5 m Cube por 1 minuto. Any objects or creatures within this Cube are considered Lightly Obscured .

Lighter. The device emits a small flame the size of a candle’s that can light flammable objects.

Compass. The device always points north, or in a cardinal direction of the GM’s determination on another plane.

Expert Gadgeteer. Se você escolher este traço duas vezes, você pode make a device in 1 minute instead of 10 minutes. Além disso, você pode escolher to imbue a device with o seguinte extra function: (This is a Combat trait.)

Distractor. This device is set with blinking lights that can captivate other creatures. Como Ação Bônus, you place or toss the device into a space within 9 m of you. A creature sharing a space with the device must succeed on a CD 10 Inteligência salvaguarda. On a failure, attacks against that creature have Vantagem until the start of your next turn. A creature can use an action to destroy the device. Você pode give up to three of your devices the Distractor feature. You regain the ability to do so quando você finish a Descanso Longo.',
  'Working with detritus and shattered objects has granted you an affinity for repairing and remaking things. Você tem proficiência com Tinker’s Tools . (This is an Exploration trait.)',
  'Além disso, você pode usar your Tinker’s Tools and 10 PO worth of appropriate materials to spend 10 minutes creating a small clockwork device. The device must fit in the palm of your hand, and can serve one of o seguinte functions:

Fumante. The device exudes smoke in a 1,5 m Cube por 1 minuto. Any objects or creatures within this Cube are considered Lightly Obscured .

Lighter. The device emits a small flame the size of a candle’s that can light flammable objects.

Compass. The device always points north, or in a cardinal direction of the GM’s determination on another plane.

Expert Gadgeteer. Se você escolher este traço duas vezes, você pode make a device in 1 minute instead of 10 minutes. Além disso, você pode escolher to imbue a device with o seguinte extra function: (This is a Combat trait.)

Distractor. This device is set with blinking lights that can captivate other creatures. Como Ação Bônus, you place or toss the device into a space within 9 m of you. A creature sharing a space with the device must succeed on a CD 10 Inteligência salvaguarda. On a failure, attacks against that creature have Vantagem until the start of your next turn. A creature can use an action to destroy the device. Você pode give up to three of your devices the Distractor feature. You regain the ability to do so quando você finish a Descanso Longo.',
  'Fumante',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'spirit-s-strength',
  'PsychicSpiritCombat',
  'combat'::rpg.heritage_trait_category,
  'Força do Espírito',
  'Your strength of mind shields you from unnatural forces. Você tem Resistência to dano Psíquico.

Spirit’s Força. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against an effect that deals dano Psíquico, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Your strength of mind shields you from unnatural forces. Você tem Resistência to dano Psíquico.',
  'Spirit’s Força. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against an effect that deals dano Psíquico, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Força do Espírito',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'stalwart-edge',
  'StalwartReservesCombat',
  'combat'::rpg.heritage_trait_category,
  'Fio Inabalável',
  'Each time you lay into a foe, their state of peril lends you vigor. Quando você acerta uma creature with a melee attack, você pode usar your Reação to roll um número de d4s igual a your Bônus de Proficiência and gain Pontos de Vida Temporários igual a the total rolled. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Fio Inabalável. Se você escolher este traço duas vezes, você pode take the maximum number of Pontos de Vida Temporários rather than rolling.',
  'Each time you lay into a foe, their state of peril lends you vigor. Quando você acerta uma creature with a melee attack, você pode usar your Reação to roll um número de d4s igual a your Bônus de Proficiência and gain Pontos de Vida Temporários igual a the total rolled. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Fio Inabalável. Se você escolher este traço duas vezes, você pode take the maximum number of Pontos de Vida Temporários rather than rolling.',
  'Fio Inabalável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'stand-fast',
  'SteadyExploration',
  'exploration'::rpg.heritage_trait_category,
  'Firmeza',
  'No matter what kind of upheaval surrounds you, you ste seu ground. Você tem Vantagem em salvaguardas against having the condição Caído.

Firmeza. Se você escolher este traço duas vezes, standing from Caído takes only five feet of movement instead of half your movement.

Além disso, Quando você falha a salvaguarda against being knocked Caído, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.

Don’t stay down. Never stay down. Se você stay down, you’re dead.

—Caçador de Monstros’s Guide to Sobrevivência',
  'No matter what kind of upheaval surrounds you, you ste seu ground. Você tem Vantagem em salvaguardas against having the condição Caído.',
  'Firmeza. Se você escolher este traço duas vezes, standing from Caído takes only five feet of movement instead of half your movement.

Além disso, Quando você falha a salvaguarda against being knocked Caído, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.

Don’t stay down. Never stay down. Se você stay down, you’re dead.

—Caçador de Monstros’s Guide to Sobrevivência',
  'Firmeza',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'strength-of-life',
  'TouchOfLifeCombat',
  'combat'::rpg.heritage_trait_category,
  'Força da Vida',
  'Effects that corrupt the essence of other living creatures are of little concern to you. Você tem Resistência to dano Necrótico.

Força of Life. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against an effect that deals dano Necrótico, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Effects that corrupt the essence of other living creatures are of little concern to you. Você tem Resistência to dano Necrótico.',
  'Força of Life. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against an effect that deals dano Necrótico, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Força da Vida',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'strong-strike',
  'FirstStrikeCombat',
  'combat'::rpg.heritage_trait_category,
  'Golpe Forte',
  'Hesitation in others is a weakness you’ve learned to take deadly advantage of. Quando você acerta uma creature that hasn’t taken a turn in the combat yet, your attack deals an extra 2d6 damage. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Golpe Forte. Se você escolher este traço duas vezes, você pode usar the maximum value of the extra damage dice from First Strike, rather than rolling. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Hesitation in others is a weakness you’ve learned to take deadly advantage of. Quando você acerta uma creature that hasn’t taken a turn in the combat yet, your attack deals an extra 2d6 damage. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Golpe Forte. Se você escolher este traço duas vezes, você pode usar the maximum value of the extra damage dice from First Strike, rather than rolling. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Golpe Forte',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'stunt-expert',
  'IntuitiveAcrobatRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Expert em Acrobacias',
  'Staying loose and limber means being able to get out of even the tightest spots quando vocêr life is on the line. Você tem proficiência na perícia Acrobatics.

Expert em Acrobacias. Se você escolher este traço duas vezes, você tem Vantagem em testes de Acrobatics. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Staying loose and limber means being able to get out of even the tightest spots quando vocêr life is on the line. Você tem proficiência na perícia Acrobatics.',
  'Expert em Acrobacias. Se você escolher este traço duas vezes, você tem Vantagem em testes de Acrobatics. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Expert em Acrobacias',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'subtle-cover',
  'CreatureCoverCombat',
  'combat'::rpg.heritage_trait_category,
  'Cobertura Sutil',
  'By slipping behind enemies or allies alike, you are able to fade from view with ease. Você pode realizar the Hide action even when você tem Half Cover from a creature, as long as that creature is of a size larger than you.

Cobertura Sutil. Se você escolher este traço duas vezes, você pode take the Hide action when você tem Half Cover from a creature the same size as you.',
  'By slipping behind enemies or allies alike, you are able to fade from view with ease. Você pode realizar the Hide action even when você tem Half Cover from a creature, as long as that creature is of a size larger than you.',
  'Cobertura Sutil. Se você escolher este traço duas vezes, você pode take the Hide action when você tem Half Cover from a creature the same size as you.',
  'Cobertura Sutil',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'supreme-skirmisher',
  'SkirmishTacticsCombat',
  'combat'::rpg.heritage_trait_category,
  'Escaramuçador Supremo',
  'Your brutal strike leaves your foe reeling as you slip away. Quando você acerta uma hostile creature with an attack with a weapon or an Ataque Desarmado , Ataque de Oportunidades against you by that creature have Desvantagem até o fim de your turn.

Escaramuçador Supremo. Se você escolher este traço duas vezes, quando você hit a hostile creature with an attack with a weapon attack or an Ataque Desarmado, você pode take the Desengajar action como Ação Bônus até o fim de your turn.',
  'Your brutal strike leaves your foe reeling as you slip away. Quando você acerta uma hostile creature with an attack with a weapon or an Ataque Desarmado , Ataque de Oportunidades against you by that creature have Desvantagem até o fim de your turn.',
  'Escaramuçador Supremo. Se você escolher este traço duas vezes, quando você hit a hostile creature with an attack with a weapon attack or an Ataque Desarmado, você pode take the Desengajar action como Ação Bônus até o fim de your turn.',
  'Escaramuçador Supremo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'supreme-slip',
  'SlipperyCombat',
  'combat'::rpg.heritage_trait_category,
  'Escorregão Supremo',
  'Any enemy that tries to grab you is in for a surprise. Você tem Vantagem em testes de Atletismo and Acrobatics to escape a grapple.

Escorregão Supremo. Se você escolher este traço duas vezes, Quando você falha an Atletismo or Acrobatics check to escape a grapple, você pode usar your Reação to succeed instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Any enemy that tries to grab you is in for a surprise. Você tem Vantagem em testes de Atletismo and Acrobatics to escape a grapple.',
  'Escorregão Supremo. Se você escolher este traço duas vezes, Quando você falha an Atletismo or Acrobatics check to escape a grapple, você pode usar your Reação to succeed instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Escorregão Supremo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'swift-strike',
  'NaturalAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Golpe Rápido',
  'The gift of natural weaponry means you are never unarmed, as your foes learn to their peril. Your Ataque Desarmados deal damage igual a 1d6 + your Força or modificador de Destreza. The type of damage dealt by your Ataque Desarmados can be Contundente, Perfurante, or Cortante, based on the type of natural weaponry you possess (claws, horns, a tail, and so forth).

Golpe Rápido. Se você escolher este traço duas vezes, você pode usar Ataque Desarmado como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'The gift of natural weaponry means you are never unarmed, as your foes learn to their peril. Your Ataque Desarmados deal damage igual a 1d6 + your Força or modificador de Destreza. The type of damage dealt by your Ataque Desarmados can be Contundente, Perfurante, or Cortante, based on the type of natural weaponry you possess (claws, horns, a tail, and so forth).',
  'Golpe Rápido. Se você escolher este traço duas vezes, você pode usar Ataque Desarmado como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Golpe Rápido',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'terrifying-influence',
  'FirmInfluenceRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Influência Aterradora',
  'Others have learned to fear you—and for good reason.

Você tem proficiência na perícia Intimidação.

Influência Aterradora. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intimidação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Others have learned to fear you—and for good reason.',
  'Você tem proficiência na perícia Intimidação.

Influência Aterradora. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intimidação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Influência Aterradora',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'thorough-sleuth',
  'MindfulInvestigatorRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Investigador Minucioso',
  'Putting together the pieces of even the darkest mysteries is second nature to you. Você tem proficiência na perícia Investigação.

Investigador Minucioso. Se você escolher este traço duas vezes, você tem Vantagem em testes de Investigação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Putting together the pieces of even the darkest mysteries is second nature to you. Você tem proficiência na perícia Investigação.',
  'Investigador Minucioso. Se você escolher este traço duas vezes, você tem Vantagem em testes de Investigação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Investigador Minucioso',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'to-the-dregs',
  'DrainingAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Até a Última Gota',
  'As your enemy’s life force ebbs, you grow ever stronger. Se você have the Natural Attack trait, each time you hit with an Ataque Desarmado , você ganha Pontos de Vida Temporários igual a the damage dealt by the attack.

Até a Última Gota. Se você escolher este traço duas vezes, quando você use Draining Attack, the target also takes a penalty to their máximo de Pontos de Vida igual a the damage dealt by the attack. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'As your enemy’s life force ebbs, you grow ever stronger. Se você have the Natural Attack trait, each time you hit with an Ataque Desarmado , você ganha Pontos de Vida Temporários igual a the damage dealt by the attack.',
  'Até a Última Gota. Se você escolher este traço duas vezes, quando você use Draining Attack, the target also takes a penalty to their máximo de Pontos de Vida igual a the damage dealt by the attack. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Até a Última Gota',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'tongue-of-gold',
  'PersuasiveKnackRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Língua de Ouro',
  'Você tem learned that the best way to deal with certain threats is to keep those threats from escalating. Você tem proficiência na perícia Persuasão.

Língua de Ouro. Se você escolher este traço duas vezes, você tem Vantagem em testes de Persuasão. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você tem learned that the best way to deal with certain threats is to keep those threats from escalating. Você tem proficiência na perícia Persuasão.',
  'Língua de Ouro. Se você escolher este traço duas vezes, você tem Vantagem em testes de Persuasão. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Língua de Ouro',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'unparalleled-endurance',
  'RelentlessEnduranceCombat',
  'combat'::rpg.heritage_trait_category,
  'Resistência Incomparável',
  'The battles you need yet to fight are many, and death is not an option. Quando você are reduced to 0 Pontos de Vida but not killed outright, você pode drop to 1 Hit Point instead. You regain the use of este recurso quando você finish a Descanso Longo.

Resistência Incomparável. Se você escolher este traço duas vezes, quando você use Relentless Endurance, you drop to 1d6 Pontos de Vida + your Bônus de Proficiência. Além disso, quando você use Relentless Endurance, você pode usar a Reação to spend up to five Dados de Vida, rolling them and gaining that number of Pontos de Vida.',
  'The battles you need yet to fight are many, and death is not an option. Quando você are reduced to 0 Pontos de Vida but not killed outright, você pode drop to 1 Hit Point instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Resistência Incomparável. Se você escolher este traço duas vezes, quando você use Relentless Endurance, you drop to 1d6 Pontos de Vida + your Bônus de Proficiência. Além disso, quando você use Relentless Endurance, você pode usar a Reação to spend up to five Dados de Vida, rolling them and gaining that number of Pontos de Vida.',
  'Resistência Incomparável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'vigorous',
  'TirelessExploration',
  'exploration'::rpg.heritage_trait_category,
  'Vigoroso',
  'An innate resilience lets you shake off conditions that would take others down. Você tem Vantagem em salvaguardas connected to gaining or removing nível de Exaustãos.

Vigoroso. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against Exhaustion, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'An innate resilience lets you shake off conditions that would take others down. Você tem Vantagem em salvaguardas connected to gaining or removing nível de Exaustãos.',
  'Vigoroso. Se você escolher este traço duas vezes, Quando você falha a salvaguarda against Exhaustion, você pode usar your Reação to succeed on the save instead. You regain the use of este recurso quando você finish a Descanso Longo.',
  'Vigoroso',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'virtuoso',
  'InstrumentalistRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Virtuoso',
  'In the quieter moments, music can help you forget the horrors you’ve seen. Você tem proficiência com two instruments de sua escolha.

Virtuoso. Se você escolher this trait multiple times, você ganha proficiency with two new instruments each time.

Além disso, você tem Vantagem em testes de ability made using any instrument. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'In the quieter moments, music can help you forget the horrors you’ve seen. Você tem proficiência com two instruments de sua escolha.',
  'Virtuoso. Se você escolher this trait multiple times, você ganha proficiency with two new instruments each time.

Além disso, você tem Vantagem em testes de ability made using any instrument. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Virtuoso',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'wall-walker',
  'ClimberExploration',
  'exploration'::rpg.heritage_trait_category,
  'Caminhante de Paredes',
  'Sometimes staying away from what threatens you means getting clear of those threats. Você tem a Climb Speed igual a your Speed.

Caminhante de Paredes. Se você escolher este traço duas vezes, você pode usar your Climb Speed to move up, down, and across vertical surfaces and upside down along ceilings, while leaving your hands free.

Além disso, while using climbing movement, você pode usar the Dash action como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sometimes staying away from what threatens you means getting clear of those threats. Você tem a Climb Speed igual a your Speed.',
  'Caminhante de Paredes. Se você escolher este traço duas vezes, você pode usar your Climb Speed to move up, down, and across vertical surfaces and upside down along ceilings, while leaving your hands free.

Além disso, while using climbing movement, você pode usar the Dash action como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Caminhante de Paredes',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'water-born',
  'AmphibiousExploration',
  'exploration'::rpg.heritage_trait_category,
  'Nascido da Água',
  'Surviving underwater is second nature to you. Você pode breathe air and water.

Nascido da Água. Se você escolher este traço duas vezes, você tem Vantagem em testes de ability. or salvaguardas made while submerged in water. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Surviving underwater is second nature to you. Você pode breathe air and water.',
  'Nascido da Água. Se você escolher este traço duas vezes, você tem Vantagem em testes de ability. or salvaguardas made while submerged in water. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Nascido da Água',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'weapon-specialist',
  'WeaponAptitudeCombat',
  'combat'::rpg.heritage_trait_category,
  'Especialista em Armas',
  'The weapons you wield might save your life one day, and você conhece their secrets. Você tem proficiência com three weapons de sua escolha.

Especialista em Armas. Se você escolher this trait multiple times, você ganha proficiency with three new weapons each time. Além disso, choose one weapon with which você tem proficiency. Você tem a +1 bonus to jogada de danos with that weapon.',
  'The weapons you wield might save your life one day, and você conhece their secrets. Você tem proficiência com three weapons de sua escolha.',
  'Especialista em Armas. Se você escolher this trait multiple times, você ganha proficiency with three new weapons each time. Além disso, choose one weapon with which você tem proficiency. Você tem a +1 bonus to jogada de danos with that weapon.',
  'Especialista em Armas',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
)
ON CONFLICT (slug) DO UPDATE SET
  anchor_id = EXCLUDED.anchor_id,
  category = EXCLUDED.category,
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  benefit_base = EXCLUDED.benefit_base,
  benefit_improved = EXCLUDED.benefit_improved,
  improved_name = EXCLUDED.improved_name,
  max_takes = EXCLUDED.max_takes,
  take_mode = EXCLUDED.take_mode;

