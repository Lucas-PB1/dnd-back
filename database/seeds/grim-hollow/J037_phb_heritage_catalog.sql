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
  'Quando você deseja se destacar, tem um dom natural para impressionar os outros. Você tem proficiência na perícia Atuação.

Um Espetáculo a Contemplar. Se você escolher este traço duas vezes, você tem Vantagem em testes de Atuação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando você deseja se destacar, tem um dom natural para impressionar os outros. Você tem proficiência na perícia Atuação.',
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
  'O mundo natural é um lugar perigoso, e sua conexão com partes específicas dele lhe dá vantagem na sobrevivência. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Enquanto estiver nesse ambiente, sempre que fizer um teste de atributo para avaliar estruturas, monumentos ou feições naturais; para encontrar comida ou água potável; ou para rastrear criaturas, você é considerado como tendo proficiência na perícia apropriada para o teste e adiciona o dobro do seu Bônus de Proficiência ao teste em vez do bônus normal.

Percepção Adaptativa. Se você escolher este traço várias vezes, você ganha o benefício para um novo ambiente a cada vez.

Além disso, quando você faz um teste de atributo usando Consciência Ambiental, você tem Vantagem no teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'O mundo natural é um lugar perigoso, e sua conexão com partes específicas dele lhe dá vantagem na sobrevivência. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Enquanto estiver nesse ambiente, sempre que fizer um teste de atributo para avaliar estruturas, monumentos ou feições naturais; para encontrar comida ou água potável; ou para rastrear criaturas, você é considerado como tendo proficiência na perícia apropriada para o teste e adiciona o dobro do seu Bônus de Proficiência ao teste em vez do bônus normal.',
  'Percepção Adaptativa. Se você escolher este traço várias vezes, você ganha o benefício para um novo ambiente a cada vez.

Além disso, quando você faz um teste de atributo usando Consciência Ambiental, você tem Vantagem no teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
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

Algo precisa ser feito com aquela elfa. Da última vez que a confrontei, ela soltou meu próprio cão contra mim.

— Vizinho ressentido',
  'Tempo entre feras lhe deu jeito com essas criaturas. Você tem proficiência na perícia Adestrar Animais.',
  'Aliado Animal. Se você escolher este traço duas vezes, você tem Vantagem em testes de Adestrar Animais. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Algo precisa ser feito com aquela elfa. Da última vez que a confrontei, ela soltou meu próprio cão contra mim.

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
  'Você reverencia a perícia artesanal de ancestrais há muito mortos. Escolha uma Ferramenta de Artesão. Você tem proficiência com essa ferramenta.

Perícia Artesanal. Se você escolher este traço várias vezes, você ganha proficiência com uma nova ferramenta a cada vez.

Além disso, você tem Vantagem em testes de atributo feitos com qualquer ferramenta que selecionou com Foco Artesanal. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você reverencia a perícia artesanal de ancestrais há muito mortos. Escolha uma Ferramenta de Artesão. Você tem proficiência com essa ferramenta.',
  'Perícia Artesanal. Se você escolher este traço várias vezes, você ganha proficiência com uma nova ferramenta a cada vez.

Além disso, você tem Vantagem em testes de atributo feitos com qualquer ferramenta que selecionou com Foco Artesanal. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Perícia Artesanal',
  NULL,
  'choice_each_take'::rpg.heritage_trait_take_mode
),
(
  'astute-slip',
  'QuickSlipCombat',
  'combat'::rpg.heritage_trait_category,
  'Escorregão Astuto',
  'Mesmo no auge da batalha, qualquer coisa que obscureça a visão que seus inimigos têm de você lhe dá chance de atacar sem ser visto. Você pode tomar a ação Esconder-se como Ação Bônus em cada um dos seus turnos. Você deve ter cobertura apropriada para tentar se esconder, como de costume.

Escorregão Astuto. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade que fizer com a ação Esconder-se ao usar Escorregão Rápido.',
  'Mesmo no auge da batalha, qualquer coisa que obscureça a visão que seus inimigos têm de você lhe dá chance de atacar sem ser visto. Você pode tomar a ação Esconder-se como Ação Bônus em cada um dos seus turnos. Você deve ter cobertura apropriada para tentar se esconder, como de costume.',
  'Escorregão Astuto. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade que fizer com a ação Esconder-se ao usar Escorregão Rápido.',
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
  'Quando inimigos tentam pressioná-lo em combate corpo a corpo, fazem-no por sua conta e risco. Outras criaturas provocam Ataques de Oportunidade de você sempre que entram no seu alcance, além de quando saem do seu alcance.

Domínio de Campo de Batalha. Se você escolher este traço duas vezes, você tem Vantagem em Ataques de Oportunidade. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando inimigos tentam pressioná-lo em combate corpo a corpo, fazem-no por sua conta e risco. Outras criaturas provocam Ataques de Oportunidade de você sempre que entram no seu alcance, além de quando saem do seu alcance.',
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
  'Você aprendeu que prestar atenção ao ambiente ao redor é a melhor forma de prever suas ameaças. Você tem proficiência na perícia Natureza.

Vínculo com a Natureza. Se você escolher este traço duas vezes, você tem Vantagem em testes de Natureza. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você aprendeu que prestar atenção ao ambiente ao redor é a melhor forma de prever suas ameaças. Você tem proficiência na perícia Natureza.',
  'Vínculo com a Natureza. Se você escolher este traço duas vezes, você tem Vantagem em testes de Natureza. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  NULL,
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'born-lucky',
  'TimelyBoonCombat',
  'combat'::rpg.heritage_trait_category,
  'Nascido Sob a Sorte',
  'A fortuna o favorece em momentos em que uma ameaça poderia derrubá-lo. Quando você falha em uma salvaguarda, pode usar sua Reação para rolar 1d4 e adicioná-lo à salvaguarda, potencialmente transformando-a em sucesso. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Nascido Sob a Sorte. Se você escolher este traço duas vezes, você rola 1d8 em vez de 1d4 quando usa Bênção Oportuna.',
  'A fortuna o favorece em momentos em que uma ameaça poderia derrubá-lo. Quando você falha em uma salvaguarda, pode usar sua Reação para rolar 1d4 e adicioná-lo à salvaguarda, potencialmente transformando-a em sucesso. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Nascido Sob a Sorte. Se você escolher este traço duas vezes, você rola 1d8 em vez de 1d4 quando usa Bênção Oportuna.',
  'Nascido Sob a Sorte',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'calculated-disappearance',
  'InstinctiveStealthRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Desaparecimento Calculado',
  'Quando o perigo vem atrás de você, você se destaca em garantir que ele não o encontre. Você tem proficiência na perícia Furtividade.

Desaparecimento Calculado. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando o perigo vem atrás de você, você se destaca em garantir que ele não o encontre. Você tem proficiência na perícia Furtividade.',
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
  'Ao concentrar sua força interior, você obtém a vantagem de que precisa. Como Ação Bônus, você concede a si mesmo Vantagem em uma jogada de ataque ou teste de atributo que fizer antes do início do seu próximo turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Fio Centrado. Se você escolher este traço duas vezes, quando você tem sucesso na jogada de ataque ou no teste de atributo feito ao usar Centrado, pode escolher uma criatura a até 9 m de você. Essa criatura tem Vantagem na próxima jogada de ataque ou teste de atributo que fizer antes do início do seu próximo turno.',
  'Ao concentrar sua força interior, você obtém a vantagem de que precisa. Como Ação Bônus, você concede a si mesmo Vantagem em uma jogada de ataque ou teste de atributo que fizer antes do início do seu próximo turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Fio Centrado. Se você escolher este traço duas vezes, quando você tem sucesso na jogada de ataque ou no teste de atributo feito ao usar Centrado, pode escolher uma criatura a até 9 m de você. Essa criatura tem Vantagem na próxima jogada de ataque ou teste de atributo que fizer antes do início do seu próximo turno.',
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
  'A história de Etharis está escrita em relíquias, e você lê essa história melhor do que a maioria. Quando faz um teste de História relacionado a qualquer objeto (um item, dispositivo, edifício ou material) e tem proficiência em uma Ferramenta de Artesão associada à criação desse objeto, você é considerado proficiente em História e adiciona o dobro do seu Bônus de Proficiência ao teste em vez do bônus normal.

Astúcia do Artífice. Se você escolher este traço duas vezes, você tem Vantagem nos testes de História que faz com Olho do Artífice. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'A história de Etharis está escrita em relíquias, e você lê essa história melhor do que a maioria. Quando faz um teste de História relacionado a qualquer objeto (um item, dispositivo, edifício ou material) e tem proficiência em uma Ferramenta de Artesão associada à criação desse objeto, você é considerado proficiente em História e adiciona o dobro do seu Bônus de Proficiência ao teste em vez do bônus normal.',
  'Astúcia do Artífice. Se você escolher este traço duas vezes, você tem Vantagem nos testes de História que faz com Olho do Artífice. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Astúcia do Artífice',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'damage-immunity',
  'DamageResistanceCombat',
  'combat'::rpg.heritage_trait_category,
  'Imunidade a Dano',
  'A exposição aos piores efeitos de uma energia específica lhe deu tolerância a ela. Você tem Resistência a um dos seguintes tipos de dano, à sua escolha: Ácido, Gélido, Fogo, Relâmpago, Veneno ou Trovejante.

Imunidade a Dano. Se você escolher este traço duas vezes, como Reação a receber dano do tipo que escolheu para Resistência a Dano, você ganha Imunidade a esse tipo de dano até o fim do seu próximo turno. Você recupera o uso deste recurso ao terminar um Descanso Curto.',
  'A exposição aos piores efeitos de uma energia específica lhe deu tolerância a ela. Você tem Resistência a um dos seguintes tipos de dano, à sua escolha: Ácido, Gélido, Fogo, Relâmpago, Veneno ou Trovejante.',
  'Imunidade a Dano. Se você escolher este traço duas vezes, como Reação a receber dano do tipo que escolheu para Resistência a Dano, você ganha Imunidade a esse tipo de dano até o fim do seu próximo turno. Você recupera o uso deste recurso ao terminar um Descanso Curto.',
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
  'Mesmo enquanto a destruição cai ao seu redor, sua audição permanece aguçada. Você tem Vantagem em salvaguardas contra a condição Surdo.

Audição Determinada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção que envolvem audição. Além disso, quando falha em uma salvaguarda contra ficar Surdo, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Mesmo enquanto a destruição cai ao seu redor, sua audição permanece aguçada. Você tem Vantagem em salvaguardas contra a condição Surdo.',
  'Audição Determinada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção que envolvem audição. Além disso, quando falha em uma salvaguarda contra ficar Surdo, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
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
  'Seja preso sob águas negras ou resistindo a fumos venenosos, você se recusa a ceder. Você pode prender a respiração por até 1 hora.

Fôlego Inesgotável. Se você escolher este traço duas vezes, você pode prender a respiração por até 8 horas.',
  'Seja preso sob águas negras ou resistindo a fumos venenosos, você se recusa a ceder. Você pode prender a respiração por até 1 hora.',
  'Fôlego Inesgotável. Se você escolher este traço duas vezes, você pode prender a respiração por até 8 horas.',
  'Fôlego Inesgotável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'ethereal-focus',
  'EtherealFadeExploration',
  'exploration'::rpg.heritage_trait_category,
  'Foco Etéreo',
  'Deslocar-se para longe do mundo mortal permite que você se mova e observe esse mundo sem ser visto. Como uma ação Mágica, você se desvanece do Plano Material para o Plano Etéreo por 1 minuto. Enquanto permanece nesse estado, não pode interagir com o Plano Material, e efeitos no Plano Material não podem afetá-lo, incluindo magias e criaturas. Você pode se mover e ouvir normalmente, e vê tudo em tons de cinza. Quando o efeito termina, você reaparece no Plano Material no espaço desocupado mais próximo de onde se desvaneceu. Você pode encerrar o efeito antecipadamente como Ação Bônus. Você recupera o uso deste recurso ao terminar um Descanso Longo.

Foco Etéreo. Se você escolher este traço duas vezes, você tem Vantagem ao fazer testes de Sabedoria como parte de uma ação Procurar.',
  'Deslocar-se para longe do mundo mortal permite que você se mova e observe esse mundo sem ser visto. Como uma ação Mágica, você se desvanece do Plano Material para o Plano Etéreo por 1 minuto. Enquanto permanece nesse estado, não pode interagir com o Plano Material, e efeitos no Plano Material não podem afetá-lo, incluindo magias e criaturas. Você pode se mover e ouvir normalmente, e vê tudo em tons de cinza. Quando o efeito termina, você reaparece no Plano Material no espaço desocupado mais próximo de onde se desvaneceu. Você pode encerrar o efeito antecipadamente como Ação Bônus. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Foco Etéreo. Se você escolher este traço duas vezes, você tem Vantagem ao fazer testes de Sabedoria como parte de uma ação Procurar.',
  'Foco Etéreo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'even-larger',
  'LargerTargetCombat',
  'combat'::rpg.heritage_trait_category,
  'Ainda Maior',
  'Inimigos maiores que você logo aprendem a temer sua fúria. Se acertar uma criatura que seja um tamanho maior que você, pode escolher causar dano extra à criatura igual ao seu Bônus de Proficiência. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Ainda Maior. Se você escolher este traço duas vezes, Alvo Maior se aplica a criaturas de qualquer tamanho maior que você.',
  'Inimigos maiores que você logo aprendem a temer sua fúria. Se acertar uma criatura que seja um tamanho maior que você, pode escolher causar dano extra à criatura igual ao seu Bônus de Proficiência. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Ainda Maior. Se você escolher este traço duas vezes, Alvo Maior se aplica a criaturas de qualquer tamanho maior que você.',
  'Ainda Maior',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'exceptional-insight',
  'CommandingInsightRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Intuição Excepcional',
  'Aqueles que tentam enganá-lo o fazem em vão. Você tem proficiência na perícia Intuição.

Intuição Excepcional. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intuição. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Aqueles que tentam enganá-lo o fazem em vão. Você tem proficiência na perícia Intuição.',
  'Intuição Excepcional. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intuição. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Intuição Excepcional',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'expert-deceiver',
  'EagerDeceiverRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Enganador Expert',
  'Há muito você aprendeu que ser aberto com os outros só lhes dá poder sobre você. Você tem proficiência na perícia Enganação.

Enganador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de Enganação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Há muito você aprendeu que ser aberto com os outros só lhes dá poder sobre você. Você tem proficiência na perícia Enganação.',
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
  'Quando a necessidade exige, você cumpre a tarefa melhor do que a maioria. Como Ação Bônus, escolha uma perícia ou ferramenta com a qual você não tem proficiência. Você tem proficiência nessa perícia ou com essa ferramenta por 1 hora. Você recupera o uso deste recurso ao terminar um Descanso Longo.

Improvisador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de atributo que fizer usando a perícia ou ferramenta selecionada com Improvisador. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando a necessidade exige, você cumpre a tarefa melhor do que a maioria. Como Ação Bônus, escolha uma perícia ou ferramenta com a qual você não tem proficiência. Você tem proficiência nessa perícia ou com essa ferramenta por 1 hora. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Improvisador Expert. Se você escolher este traço duas vezes, você tem Vantagem em testes de atributo que fizer usando a perícia ou ferramenta selecionada com Improvisador. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Improvisador Expert',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'expert-orientation',
  'IntrinsicOrientationExploration',
  'exploration'::rpg.heritage_trait_category,
  'Orientação Expert',
  'Um único passo em falso pode levar à ruína, mas seus instintos de direção o impedem de se perder. Você sempre sabe qual direção é o norte e pode determinar uma direção cardeal à escolha do Mestre enquanto estiver em outros planos. Além disso, você tem Vantagem em testes de atributo feitos para evitar se perder, navegar ou rastrear.

Orientação Expert. Se você escolher este traço duas vezes, quando falha em um teste de atributo feito para evitar se perder, navegar ou rastrear, pode escolher ter sucesso em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Um único passo em falso pode levar à ruína, mas seus instintos de direção o impedem de se perder. Você sempre sabe qual direção é o norte e pode determinar uma direção cardeal à escolha do Mestre enquanto estiver em outros planos. Além disso, você tem Vantagem em testes de atributo feitos para evitar se perder, navegar ou rastrear.',
  'Orientação Expert. Se você escolher este traço duas vezes, quando falha em um teste de atributo feito para evitar se perder, navegar ou rastrear, pode escolher ter sucesso em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Orientação Expert',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'exquisite-legerdemain',
  'NimbleMovesRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Prestidigitação Requintada',
  'Você aprendeu o valor de manipular o mundo ao redor sem atrair a atenção dos outros. Você tem proficiência na perícia Prestidigitação.

Prestidigitação Requintada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Prestidigitação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você aprendeu o valor de manipular o mundo ao redor sem atrair a atenção dos outros. Você tem proficiência na perícia Prestidigitação.',
  'Prestidigitação Requintada. Se você escolher este traço duas vezes, você tem Vantagem em testes de Prestidigitação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Prestidigitação Requintada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'extended-fortification',
  'MagicalFortificationCombat',
  'combat'::rpg.heritage_trait_category,
  'Fortificação Estendida',
  'Quanto mais a magia o ameaça, mais sua resiliência a ela aumenta. Escolha um atributo: Força, Destreza, Constituição, Inteligência, Sabedoria ou Carisma. Você tem Vantagem em salvaguardas usando esse atributo contra magias e outros efeitos mágicos.

Fortificação Estendida. Se você escolher este traço várias vezes, você tem Vantagem em salvaguardas usando um novo atributo a cada vez.

Além disso, se falhar em uma salvaguarda contra uma magia ou outro efeito mágico e não tiver proficiência nessa salvaguarda, pode usar sua Reação para rerrolar a salvaguarda. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Quanto mais a magia o ameaça, mais sua resiliência a ela aumenta. Escolha um atributo: Força, Destreza, Constituição, Inteligência, Sabedoria ou Carisma. Você tem Vantagem em salvaguardas usando esse atributo contra magias e outros efeitos mágicos.',
  'Fortificação Estendida. Se você escolher este traço várias vezes, você tem Vantagem em salvaguardas usando um novo atributo a cada vez.

Além disso, se falhar em uma salvaguarda contra uma magia ou outro efeito mágico e não tiver proficiência nessa salvaguarda, pode usar sua Reação para rerrolar a salvaguarda. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Fortificação Estendida',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'extra-tough',
  'ToughnessCombat',
  'combat'::rpg.heritage_trait_category,
  'Extra Resistente',
  'Uma robustez intrínseca marca você como alguém nascido para a batalha. Seu máximo de Pontos de Vida aumenta em 1, e aumenta em 1 cada vez que você sobe de nível.

Extra Resistente. Se você escolher este traço duas vezes, seu máximo de Pontos de Vida aumenta em 2 em vez de 1, e aumenta em 2 cada vez que você sobe de nível.

Além disso, quando faz uma salvaguarda contra um efeito que reduziria seu máximo de Pontos de Vida, você tem Vantagem na salvaguarda. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Uma robustez intrínseca marca você como alguém nascido para a batalha. Seu máximo de Pontos de Vida aumenta em 1, e aumenta em 1 cada vez que você sobe de nível.',
  'Extra Resistente. Se você escolher este traço duas vezes, seu máximo de Pontos de Vida aumenta em 2 em vez de 1, e aumenta em 2 cada vez que você sobe de nível.

Além disso, quando faz uma salvaguarda contra um efeito que reduziria seu máximo de Pontos de Vida, você tem Vantagem na salvaguarda. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Extra Resistente',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'extreme-resilience',
  'PowerNapExploration',
  'exploration'::rpg.heritage_trait_category,
  'Resiliência Extrema',
  'Quando você não sabe quanto tempo pode demorar até o próximo descanso completo, aprende a tirar o máximo proveito de qualquer descanso que conseguir. Ao fazer um Descanso Curto, pode escolher dormir por 1 hora. Se o fizer, reduz sua Exaustão em um nível e recupera um Dado de Vida além dos outros benefícios de um Descanso Curto.

Resiliência Extrema. Se você escolher este traço duas vezes, ao usar Cochilo Revigorante, pode escolher recuperar um único recurso que normalmente se renovaria em um Descanso Longo. Por exemplo, um Feiticeiro poderia escolher recuperar um Ponto de Feitiçaria em um Descanso Curto.',
  'Quando você não sabe quanto tempo pode demorar até o próximo descanso completo, aprende a tirar o máximo proveito de qualquer descanso que conseguir. Ao fazer um Descanso Curto, pode escolher dormir por 1 hora. Se o fizer, reduz sua Exaustão em um nível e recupera um Dado de Vida além dos outros benefícios de um Descanso Curto.',
  'Resiliência Extrema. Se você escolher este traço duas vezes, ao usar Cochilo Revigorante, pode escolher recuperar um único recurso que normalmente se renovaria em um Descanso Longo. Por exemplo, um Feiticeiro poderia escolher recuperar um Ponto de Feitiçaria em um Descanso Curto.',
  'Resiliência Extrema',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'faultless-shroud',
  'ShroudoftheWildExploration',
  'exploration'::rpg.heritage_trait_category,
  'Manto Impecável',
  'Com qualquer grau de obscurecimento, sua habilidade instintiva de se ocultar permite evitar a atenção dos inimigos. Você pode tomar a ação Esconder-se mesmo quando estiver apenas Levemente Obscurecido por folhagem, chuva forte, neve caindo, névoa e outros fenômenos naturais.

Manto Impecável. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade usando a ação Esconder-se enquanto usa Manto Selvagem.',
  'Com qualquer grau de obscurecimento, sua habilidade instintiva de se ocultar permite evitar a atenção dos inimigos. Você pode tomar a ação Esconder-se mesmo quando estiver apenas Levemente Obscurecido por folhagem, chuva forte, neve caindo, névoa e outros fenômenos naturais.',
  'Manto Impecável. Se você escolher este traço duas vezes, você tem Vantagem em testes de Furtividade usando a ação Esconder-se enquanto usa Manto Selvagem.',
  'Manto Impecável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-edge',
  'FocusedReservesCombat',
  'combat'::rpg.heritage_trait_category,
  'Fio Concentrado',
  'Por mais abatido que esteja, você encontra a vontade de continuar lutando quando mais precisa. Como Reação depois de receber dano, pode rolar um número de d6s igual ao seu Bônus de Proficiência e ganhar Pontos de Vida Temporários iguais ao total. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Fio Concentrado. Se você escolher este traço duas vezes, você pode rerrolar 1s e 2s quando usa Reservas Concentradas, mas deve usar as novas rolagens.',
  'Por mais abatido que esteja, você encontra a vontade de continuar lutando quando mais precisa. Como Reação depois de receber dano, pode rolar um número de d6s igual ao seu Bônus de Proficiência e ganhar Pontos de Vida Temporários iguais ao total. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Fio Concentrado. Se você escolher este traço duas vezes, você pode rerrolar 1s e 2s quando usa Reservas Concentradas, mas deve usar as novas rolagens.',
  'Fio Concentrado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-initiative',
  'QuickInitiativeCombat',
  'combat'::rpg.heritage_trait_category,
  'Iniciativa Concentrada',
  'O perigo nunca está longe de você, e você está sempre pronto para ele. Você adiciona seu Bônus de Proficiência às suas rolagens de Iniciativa.

Iniciativa Concentrada. Se você escolher este traço duas vezes, quando rola Iniciativa, pode tratar uma rolagem de 9 ou menos como se tivesse rolado 10.',
  'O perigo nunca está longe de você, e você está sempre pronto para ele. Você adiciona seu Bônus de Proficiência às suas rolagens de Iniciativa.',
  'Iniciativa Concentrada. Se você escolher este traço duas vezes, quando rola Iniciativa, pode tratar uma rolagem de 9 ou menos como se tivesse rolado 10.',
  'Iniciativa Concentrada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-mastery',
  'MasterfulAptitudeRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Maestria Concentrada',
  'Sua disciplina e foco lhe dão uma vantagem que outros não têm. Escolha uma de suas proficiências em perícia ou ferramenta. Você tem Expertise em testes de atributo feitos com a proficiência escolhida.

Maestria Concentrada. Se você escolher este traço várias vezes, você ganha o benefício para uma nova proficiência em perícia ou ferramenta a cada vez.

Além disso, quando faz um teste usando uma perícia ou ferramenta para a qual escolheu Aptidão Magistral, você tem Vantagem no teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sua disciplina e foco lhe dão uma vantagem que outros não têm. Escolha uma de suas proficiências em perícia ou ferramenta. Você tem Expertise em testes de atributo feitos com a proficiência escolhida.',
  'Maestria Concentrada. Se você escolher este traço várias vezes, você ganha o benefício para uma nova proficiência em perícia ou ferramenta a cada vez.

Além disso, quando faz um teste usando uma perícia ou ferramenta para a qual escolheu Aptidão Magistral, você tem Vantagem no teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Maestria Concentrada',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'focused-ruthlessness',
  'RuthlessResponseCombat',
  'combat'::rpg.heritage_trait_category,
  'Crueldade Concentrada',
  'Uma criatura que o pega de surpresa encontra uma resposta rápida e brutal. Quando você recebe dano de uma criatura dentro do seu alcance, pode usar sua Reação para fazer um ataque corpo a corpo com uma arma ou um Ataque Desarmado contra essa criatura. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Crueldade Concentrada. Se você escolher este traço duas vezes, você tem Vantagem em jogadas de ataque feitas usando Resposta Cruel.',
  'Uma criatura que o pega de surpresa encontra uma resposta rápida e brutal. Quando você recebe dano de uma criatura dentro do seu alcance, pode usar sua Reação para fazer um ataque corpo a corpo com uma arma ou um Ataque Desarmado contra essa criatura. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Crueldade Concentrada. Se você escolher este traço duas vezes, você tem Vantagem em jogadas de ataque feitas usando Resposta Cruel.',
  'Crueldade Concentrada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'force-of-faith',
  'MovedByFaithRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Força da Fé',
  'Os mitos e lendas mais sombrios do passado guardam as chaves para moldar o futuro. Você tem proficiência na perícia Religião.

Força da Fé. Se você escolher este traço duas vezes, você tem Vantagem em testes de Religião. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Os mitos e lendas mais sombrios do passado guardam as chaves para moldar o futuro. Você tem proficiência na perícia Religião.',
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
  'Com um esforço de vontade, você contorce o corpo pelos espaços mais apertados. Você pode se espremer por um espaço grande o bastante para uma criatura dois tamanhos menor que você, em vez de um tamanho menor.

Espremimento em Velocidade Plena. Se você escolher este traço duas vezes, espremer-se não lhe custa deslocamento adicional, e você não tem Desvantagem em jogadas de ataque e salvaguardas de Destreza enquanto se espreme.',
  'Com um esforço de vontade, você contorce o corpo pelos espaços mais apertados. Você pode se espremer por um espaço grande o bastante para uma criatura dois tamanhos menor que você, em vez de um tamanho menor.',
  'Espremimento em Velocidade Plena. Se você escolher este traço duas vezes, espremer-se não lhe custa deslocamento adicional, e você não tem Desvantagem em jogadas de ataque e salvaguardas de Destreza enquanto se espreme.',
  'Espremimento em Velocidade Plena',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'furious-charge',
  'ChargingAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Investida Furiosa',
  'A fúria com que você se lança à batalha força os inimigos a sentirem sua ira. Se você se mover pelo menos 6 m em linha reta em direção a um alvo e então o acertar com um ataque corpo a corpo com uma arma ou um Ataque Desarmado no mesmo turno, pode fazer outro ataque contra o mesmo alvo como Ação Bônus com a mesma arma.

Investida Furiosa. Se você escolher este traço duas vezes, quando usa Ataque de Investida, você tem Vantagem em todos os ataques após o movimento desencadeador até o fim do seu turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'A fúria com que você se lança à batalha força os inimigos a sentirem sua ira. Se você se mover pelo menos 6 m em linha reta em direção a um alvo e então o acertar com um ataque corpo a corpo com uma arma ou um Ataque Desarmado no mesmo turno, pode fazer outro ataque contra o mesmo alvo como Ação Bônus com a mesma arma.',
  'Investida Furiosa. Se você escolher este traço duas vezes, quando usa Ataque de Investida, você tem Vantagem em todos os ataques após o movimento desencadeador até o fim do seu turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Investida Furiosa',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'furious-speed',
  'BurstOfSpeedExploration',
  'exploration'::rpg.heritage_trait_category,
  'Velocidade Furiosa',
  'As muitas coisas que querem matá-lo precisam alcançá-lo primeiro. No seu turno, você pode aumentar seu Deslocamento em 9 m até o fim do turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Velocidade Furiosa. Se você escolher este traço duas vezes, em um turno em que usa Explosão de Velocidade, você não provoca Ataques de Oportunidade.

No campo de batalha, pés rápidos são a melhor armadura que se pode pedir. Se um inimigo não consegue alcançá-lo, não pode feri-lo. Agora erga esses joelhos!

— Instrutor de milícia',
  'As muitas coisas que querem matá-lo precisam alcançá-lo primeiro. No seu turno, você pode aumentar seu Deslocamento em 9 m até o fim do turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Velocidade Furiosa. Se você escolher este traço duas vezes, em um turno em que usa Explosão de Velocidade, você não provoca Ataques de Oportunidade.

No campo de batalha, pés rápidos são a melhor armadura que se pode pedir. Se um inimigo não consegue alcançá-lo, não pode feri-lo. Agora erga esses joelhos!

— Instrutor de milícia',
  'Velocidade Furiosa',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'hard-to-kill',
  'TenaciousCombat',
  'combat'::rpg.heritage_trait_category,
  'Difícil de Matar',
  'Seus inimigos podem derrubá-lo, mas você nunca fica no chão por muito tempo. Você tem Vantagem em Salvaguardas contra a Morte.

Difícil de Matar. Se você escolher este traço duas vezes, quando cai a 0 Pontos de Vida mas não morre imediatamente, permanece consciente. Você deve fazer Salvaguardas contra a Morte normalmente enquanto estiver a 0 Pontos de Vida, e sofre uma falha em Salvaguarda contra a Morte cada vez que recebe qualquer dano, mas pode agir livremente de outro modo. Você não pode ficar Estável enquanto permanecer a 0 Pontos de Vida dessa forma.',
  'Seus inimigos podem derrubá-lo, mas você nunca fica no chão por muito tempo. Você tem Vantagem em Salvaguardas contra a Morte.',
  'Difícil de Matar. Se você escolher este traço duas vezes, quando cai a 0 Pontos de Vida mas não morre imediatamente, permanece consciente. Você deve fazer Salvaguardas contra a Morte normalmente enquanto estiver a 0 Pontos de Vida, e sofre uma falha em Salvaguarda contra a Morte cada vez que recebe qualquer dano, mas pode agir livremente de outro modo. Você não pode ficar Estável enquanto permanecer a 0 Pontos de Vida dessa forma.',
  'Difícil de Matar',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'heavy-armor-training',
  'MediumArmorTrainingCombat',
  'combat'::rpg.heritage_trait_category,
  'Treinamento em Armadura Pesada',
  'A surra que você leva rotineiramente em combate exige uma camada formidável de defesa. Você tem treinamento com armadura média e com Escudos.

Treinamento em Armadura Pesada. Se você escolher este traço duas vezes, você tem treinamento com armadura pesada.',
  'A surra que você leva rotineiramente em combate exige uma camada formidável de defesa. Você tem treinamento com armadura média e com Escudos.',
  'Treinamento em Armadura Pesada. Se você escolher este traço duas vezes, você tem treinamento com armadura pesada.',
  'Treinamento em Armadura Pesada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'helpful-tactics',
  'HelpingHandExplorationCombat',
  'combat'::rpg.heritage_trait_category,
  'Táticas Úteis',
  'Você se destaca em auxiliar aliados, sabendo que virá o momento em que precisará que retribua o favor. Você pode usar a ação Ajudar como Ação Bônus para auxiliar qualquer aliado fazendo um teste de atributo. (Este é um traço de Exploração.)

Táticas Úteis. Se você escolher este traço duas vezes, quando usa Mão Amiga, também pode auxiliar um aliado fazendo uma jogada de ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo. (Este é um traço de Combate.)',
  'Você se destaca em auxiliar aliados, sabendo que virá o momento em que precisará que retribua o favor. Você pode usar a ação Ajudar como Ação Bônus para auxiliar qualquer aliado fazendo um teste de atributo. (Este é um traço de Exploração.)',
  'Táticas Úteis. Se você escolher este traço duas vezes, quando usa Mão Amiga, também pode auxiliar um aliado fazendo uma jogada de ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo. (Este é um traço de Combate.)',
  'Táticas Úteis',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'hindering-distraction',
  'MasterOfDistractionCombat',
  'combat'::rpg.heritage_trait_category,
  'Distração Obstructiva',
  'Você atrai a atenção dos inimigos para si, pretendendo que seja a última distração que eles vejam. Como uma ação Influenciar, você faz uma demonstração tática (bravata, covardia, confusão ou outra tática) que captura a atenção dos inimigos. Até o fim do seu próximo turno, qualquer ataque contra um inimigo a até 3 m de você que pudesse vê-lo quando você tomou a ação Influenciar é feito com Vantagem. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Distração Obstructiva. Se você escolher este traço duas vezes, quando usa Mestre da Distração, um inimigo afetado à sua escolha também tem Desvantagem em jogadas de ataque que fizer contra qualquer um dos seus aliados até o fim do seu próximo turno.',
  'Você atrai a atenção dos inimigos para si, pretendendo que seja a última distração que eles vejam. Como uma ação Influenciar, você faz uma demonstração tática (bravata, covardia, confusão ou outra tática) que captura a atenção dos inimigos. Até o fim do seu próximo turno, qualquer ataque contra um inimigo a até 3 m de você que pudesse vê-lo quando você tomou a ação Influenciar é feito com Vantagem. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Distração Obstructiva. Se você escolher este traço duas vezes, quando usa Mestre da Distração, um inimigo afetado à sua escolha também tem Desvantagem em jogadas de ataque que fizer contra qualquer um dos seus aliados até o fim do seu próximo turno.',
  'Distração Obstructiva',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'immune-to-the-elements',
  'InuredToTheElementsExploration',
  'exploration'::rpg.heritage_trait_category,
  'Imune aos Elementos',
  'Mesmo sob sol escaldante e no frio congelante, você se mantém firme. Você tem Vantagem em salvaguardas de Constituição feitas para resistir aos efeitos de frio extremo ou calor extremo.

Imune aos Elementos. Se você escolher este traço duas vezes, você tem sucesso automático em salvaguardas de Constituição para resistir aos efeitos de frio extremo ou calor extremo.',
  'Mesmo sob sol escaldante e no frio congelante, você se mantém firme. Você tem Vantagem em salvaguardas de Constituição feitas para resistir aos efeitos de frio extremo ou calor extremo.',
  'Imune aos Elementos. Se você escolher este traço duas vezes, você tem sucesso automático em salvaguardas de Constituição para resistir aos efeitos de frio extremo ou calor extremo.',
  'Imune aos Elementos',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'immutable-mind',
  'FocusedMindCombat',
  'combat'::rpg.heritage_trait_category,
  'Mente Inabalável',
  'Sua força de vontade o protege de magia que corromperia sua mente. Você tem Vantagem em salvaguardas contra ficar Enfeitiçado.

Mente Inabalável. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra ficar Enfeitiçado, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Sua força de vontade o protege de magia que corromperia sua mente. Você tem Vantagem em salvaguardas contra ficar Enfeitiçado.',
  'Mente Inabalável. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra ficar Enfeitiçado, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Mente Inabalável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'improved-darkvision',
  'DarkvisionExploration',
  'exploration'::rpg.heritage_trait_category,
  'Visão no Escuro Aprimorada',
  'Uma vida na sombra acostumou você à penumbra. Você enxerga em Luz Fraca a até 18 m de você como se fosse Luz Clara, e na Escuridão a até 18 m de você como se fosse Luz Fraca. Você não distingue cores na Escuridão, apenas tons de cinza.

Visão no Escuro Aprimorada. Se você escolher este traço duas vezes, o alcance da sua Visão no Escuro aumenta para 36 m.',
  'Uma vida na sombra acostumou você à penumbra. Você enxerga em Luz Fraca a até 18 m de você como se fosse Luz Clara, e na Escuridão a até 18 m de você como se fosse Luz Fraca. Você não distingue cores na Escuridão, apenas tons de cinza.',
  'Visão no Escuro Aprimorada. Se você escolher este traço duas vezes, o alcance da sua Visão no Escuro aumenta para 36 m.',
  'Visão no Escuro Aprimorada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'incomparable-roar',
  'MenacingRoarCombat',
  'combat'::rpg.heritage_trait_category,
  'Rugido Incomparável',
  'Seu grito de guerra pode fazer até os inimigos mais formidáveis tremerem diante de você. Como Ação Bônus, você emite um rugido, grito ou outro brado vocal alto. Cada criatura à sua escolha a até 3 m de você que possa ouvi-lo deve ter sucesso em uma salvaguarda de Sabedoria (CD = 8 + seu Bônus de Proficiência + seu modificador de Constituição) ou ficar com a condição Amedrontado até o fim do seu próximo turno. Você recupera o uso deste recurso ao terminar um Descanso Longo.

Rugido Incomparável. Se você escolher este traço duas vezes, quando usa Rugido Ameaçador, um alvo à sua escolha tem Desvantagem na salvaguarda.',
  'Seu grito de guerra pode fazer até os inimigos mais formidáveis tremerem diante de você. Como Ação Bônus, você emite um rugido, grito ou outro brado vocal alto. Cada criatura à sua escolha a até 3 m de você que possa ouvi-lo deve ter sucesso em uma salvaguarda de Sabedoria (CD = 8 + seu Bônus de Proficiência + seu modificador de Constituição) ou ficar com a condição Amedrontado até o fim do seu próximo turno. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Rugido Incomparável. Se você escolher este traço duas vezes, quando usa Rugido Ameaçador, um alvo à sua escolha tem Desvantagem na salvaguarda.',
  'Rugido Incomparável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'incredible-leap',
  'StandingLeapExploration',
  'exploration'::rpg.heritage_trait_category,
  'Salto Incrível',
  'Ameaças no chão pouco o preocupam, pois você salta sobre elas com facilidade. Você pode fazer um Salto em Distância de até 6 m e um Salto em Altura de até 3 m, com ou sem corrida. Se seu Deslocamento for menor que a distância do Salto em Distância, você só pode saltar uma distância igual ao seu Deslocamento.

Salto Incrível. Se você escolher este traço duas vezes, você pode fazer um Salto em Distância de até 9 m e um Salto em Altura de até 4,5 m, limitado pelo seu deslocamento.

Além disso, quando salta para fora do alcance de outra criatura, o movimento do salto não provoca Ataques de Oportunidade dessa criatura. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Ameaças no chão pouco o preocupam, pois você salta sobre elas com facilidade. Você pode fazer um Salto em Distância de até 6 m e um Salto em Altura de até 3 m, com ou sem corrida. Se seu Deslocamento for menor que a distância do Salto em Distância, você só pode saltar uma distância igual ao seu Deslocamento.',
  'Salto Incrível. Se você escolher este traço duas vezes, você pode fazer um Salto em Distância de até 9 m e um Salto em Altura de até 4,5 m, limitado pelo seu deslocamento.

Além disso, quando salta para fora do alcance de outra criatura, o movimento do salto não provoca Ataques de Oportunidade dessa criatura. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Salto Incrível',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'infectious-bravery',
  'BraveCombat',
  'combat'::rpg.heritage_trait_category,
  'Coragem Contagiante',
  'Os horrores que você viveu o endureceram. Você tem Vantagem em salvaguardas para evitar ficar Amedrontado.

Coragem Contagiante. Se você escolher este traço duas vezes, você pode usar sua Reação para fortalecer o ânimo dos aliados, concedendo a um aliado que possa vê-lo ou ouvi-lo Vantagem em uma salvaguarda contra ficar Amedrontado. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Os horrores que você viveu o endureceram. Você tem Vantagem em salvaguardas para evitar ficar Amedrontado.',
  'Coragem Contagiante. Se você escolher este traço duas vezes, você pode usar sua Reação para fortalecer o ânimo dos aliados, concedendo a um aliado que possa vê-lo ou ouvi-lo Vantagem em uma salvaguarda contra ficar Amedrontado. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Coragem Contagiante',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'language-expert',
  'PolyglotRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Expert em Idiomas',
  'As vantagens de dominar as línguas de inimigos e aliados são claras para você. Você aprende dois idiomas à sua escolha.

Expert em Idiomas. Se você escolher este traço várias vezes, você aprende dois novos idiomas a cada vez.

Além disso, você tem Vantagem em testes de atributo de ação Influenciar feitos para interagir com outra criatura usando qualquer idioma que selecionou com Poliglota. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'As vantagens de dominar as línguas de inimigos e aliados são claras para você. Você aprende dois idiomas à sua escolha.',
  'Expert em Idiomas. Se você escolher este traço várias vezes, você aprende dois novos idiomas a cada vez.

Além disso, você tem Vantagem em testes de atributo de ação Influenciar feitos para interagir com outra criatura usando qualquer idioma que selecionou com Poliglota. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Expert em Idiomas',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'light-armor-expertise',
  'LightArmorTrainingCombat',
  'combat'::rpg.heritage_trait_category,
  'Perícia em Armadura Leve',
  'Lidar com as ameaças que enfrenta exige a combinação certa de proteção e movimento. Você tem treinamento com armadura leve.

Perícia em Armadura Leve. Se você escolher este traço duas vezes, sua CA aumenta em 1 enquanto estiver vestindo armadura leve.',
  'Lidar com as ameaças que enfrenta exige a combinação certa de proteção e movimento. Você tem treinamento com armadura leve.',
  'Perícia em Armadura Leve. Se você escolher este traço duas vezes, sua CA aumenta em 1 enquanto estiver vestindo armadura leve.',
  'Perícia em Armadura Leve',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'long-fade',
  'FadeAwayExploration',
  'exploration'::rpg.heritage_trait_category,
  'Desvanecimento Longo',
  'Você aprendeu a evitar atenção a qualquer custo, permitindo obscurecer-se momentaneamente da observação. Como Ação Bônus, pode tomar a ação Esconder-se para se ocultar sem precisar estar Fortemente Obscurecido ou atrás de Cobertura de Três Quartos ou Cobertura Total. Você não precisa estar fora da linha de visão de uma criatura para usar esta habilidade.

Você se torna visível no início do seu próximo turno, a menos que tenha se movido para uma posição que permita usar a ação Esconder-se normalmente. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Desvanecimento Longo. Se você escolher este traço duas vezes, você tem Vantagem no teste de atributo quando toma a ação Esconder-se de Desvanecer, e se torna visível no fim do seu próximo turno em vez do início do seu próximo turno.',
  'Você aprendeu a evitar atenção a qualquer custo, permitindo obscurecer-se momentaneamente da observação. Como Ação Bônus, pode tomar a ação Esconder-se para se ocultar sem precisar estar Fortemente Obscurecido ou atrás de Cobertura de Três Quartos ou Cobertura Total. Você não precisa estar fora da linha de visão de uma criatura para usar esta habilidade.

Você se torna visível no início do seu próximo turno, a menos que tenha se movido para uma posição que permita usar a ação Esconder-se normalmente. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Desvanecimento Longo. Se você escolher este traço duas vezes, você tem Vantagem no teste de atributo quando toma a ação Esconder-se de Desvanecer, e se torna visível no fim do seu próximo turno em vez do início do seu próximo turno.',
  'Desvanecimento Longo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'magical-historian',
  'MagicalInsightRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Historiador Mágico',
  'Magia é poder nas mãos certas — e essas mãos são as suas. Você tem proficiência na perícia Arcanismo.

Historiador Mágico. Se você escolher este traço duas vezes, você tem Vantagem em testes de Arcanismo. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Magia é poder nas mãos certas — e essas mãos são as suas. Você tem proficiência na perícia Arcanismo.',
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
  'Seja por estudo intensivo ou pelo toque inato de magia em seu sangue, você tem a capacidade de invocar magias. Você aprende um truque à sua escolha de qualquer lista de magias, que conjura usando o atributo associado: Inteligência para magias de Mago, Sabedoria para magias de Clérigo e Druida, e Carisma para magias de Bardo, Feiticeiro e Bruxo. Se a magia aparecer em várias listas, escolha uma para determinar o atributo de conjuração dessa magia.

Erudito Mágico. Se você escolher este traço várias vezes, você seleciona um truque diferente a cada vez, ou pode selecionar uma magia de 1º nível da mesma lista de um truque que já tenha escolhido. Se selecionar uma magia de 1º nível, pode conjurá-la uma vez sem gastar um espaço de magia, e recupera a capacidade de conjurá-la dessa forma ao terminar um Descanso Longo. Se tiver níveis na classe de conjuração associada, você sempre tem essa magia preparada, e ela não conta contra o número de magias que pode preparar a cada dia.',
  'Seja por estudo intensivo ou pelo toque inato de magia em seu sangue, você tem a capacidade de invocar magias. Você aprende um truque à sua escolha de qualquer lista de magias, que conjura usando o atributo associado: Inteligência para magias de Mago, Sabedoria para magias de Clérigo e Druida, e Carisma para magias de Bardo, Feiticeiro e Bruxo. Se a magia aparecer em várias listas, escolha uma para determinar o atributo de conjuração dessa magia.',
  'Erudito Mágico. Se você escolher este traço várias vezes, você seleciona um truque diferente a cada vez, ou pode selecionar uma magia de 1º nível da mesma lista de um truque que já tenha escolhido. Se selecionar uma magia de 1º nível, pode conjurá-la uma vez sem gastar um espaço de magia, e recupera a capacidade de conjurá-la dessa forma ao terminar um Descanso Longo. Se tiver níveis na classe de conjuração associada, você sempre tem essa magia preparada, e ela não conta contra o número de magias que pode preparar a cada dia.',
  'Erudito Mágico',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'master-artisan',
  'ImpromptuArtisanRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Mestre Artesão',
  'Você nunca conheceu o luxo de sempre ter o equipamento de que precisa, mas aprendeu mais do que bem a se virar. Se possuir Ferramentas de Artesão com as quais tem proficiência, e se tiver acesso a matérias-primas apropriadas e a qualquer equipamento adicional necessário (conforme o Mestre determinar), pode usar um Descanso Curto para fabricar qualquer um item não mágico que valha 10 PO ou menos.

O equipamento que você cria é utilizável, mas não de alta qualidade, e não pode ser vendido exceto conforme o Mestre determinar.

Mestre Artesão. Se você escolher este traço duas vezes, você pode usar Artesão Improvisado durante um Descanso Longo, no qual fabrica um item não mágico que valha 50 PO ou menos.',
  'Você nunca conheceu o luxo de sempre ter o equipamento de que precisa, mas aprendeu mais do que bem a se virar. Se possuir Ferramentas de Artesão com as quais tem proficiência, e se tiver acesso a matérias-primas apropriadas e a qualquer equipamento adicional necessário (conforme o Mestre determinar), pode usar um Descanso Curto para fabricar qualquer um item não mágico que valha 10 PO ou menos.

O equipamento que você cria é utilizável, mas não de alta qualidade, e não pode ser vendido exceto conforme o Mestre determinar.',
  'Mestre Artesão. Se você escolher este traço duas vezes, você pode usar Artesão Improvisado durante um Descanso Longo, no qual fabrica um item não mágico que valha 50 PO ou menos.',
  'Mestre Artesão',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'master-manipulator',
  'CalculatingListenerRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Mestre Manipulador',
  'Os de vontade fraca ao seu redor são alvos fáceis para sua manipulação. Ao conversar com uma criatura não hostil por pelo menos 1 minuto, você pode tentar enfeitiçá-la. A criatura deve ter sucesso em uma salvaguarda de Sabedoria (CD = 8 + seu modificador de Carisma + seu Bônus de Proficiência) ou ficar com a condição Enfeitiçado por 1 hora. A critério do Mestre, você também aprende uma informação que o alvo conhece relacionada ao tema da conversa enquanto fala com ele. Independentemente de o alvo ter sucesso ou não na salvaguarda, ele permanece alheio à sua tentativa. Você recupera o uso deste recurso ao terminar um Descanso Curto ou Longo.

Mestre Manipulador. Se você escolher este traço duas vezes, uma criatura tem Desvantagem na salvaguarda, e fica com a condição Enfeitiçado por 8 horas em uma falha.',
  'Os de vontade fraca ao seu redor são alvos fáceis para sua manipulação. Ao conversar com uma criatura não hostil por pelo menos 1 minuto, você pode tentar enfeitiçá-la. A criatura deve ter sucesso em uma salvaguarda de Sabedoria (CD = 8 + seu modificador de Carisma + seu Bônus de Proficiência) ou ficar com a condição Enfeitiçado por 1 hora. A critério do Mestre, você também aprende uma informação que o alvo conhece relacionada ao tema da conversa enquanto fala com ele. Independentemente de o alvo ter sucesso ou não na salvaguarda, ele permanece alheio à sua tentativa. Você recupera o uso deste recurso ao terminar um Descanso Curto ou Longo.',
  'Mestre Manipulador. Se você escolher este traço duas vezes, uma criatura tem Desvantagem na salvaguarda, e fica com a condição Enfeitiçado por 8 horas em uma falha.',
  'Mestre Manipulador',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'master-of-fortune',
  'LuckyCombat',
  'combat'::rpg.heritage_trait_category,
  'Mestre da Fortuna',
  'A sorte que você carrega o levará através do pior que Etharis tem a oferecer. Quando rola 1 em um Teste de d20, pode rerrolar esse dado, mas deve usar a nova rolagem. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Mestre da Fortuna. Se você escolher este traço duas vezes, você tem Vantagem na rerrolagem feita com Sortudo.',
  'A sorte que você carrega o levará através do pior que Etharis tem a oferecer. Quando rola 1 em um Teste de d20, pode rerrolar esse dado, mas deve usar a nova rolagem. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Mestre da Fortuna. Se você escolher este traço duas vezes, você tem Vantagem na rerrolagem feita com Sortudo.',
  'Mestre da Fortuna',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'maximum-critical',
  'AwesomeCriticalCombat',
  'combat'::rpg.heritage_trait_category,
  'Crítico Máximo',
  'Quando a fortuna favorece sua lâmina, você sabe como fazer valer a pena. Quando marca um Acerto Crítico com um ataque corpo a corpo com uma arma ou um Ataque Desarmado, pode rolar um dos dados de dano da arma uma vez adicional e adicioná-lo ao dano extra do Acerto Crítico.

Crítico Máximo. Se você escolher este traço duas vezes, quando usa Crítico Formidável, pode adicionar o máximo dos dados de dano originais da arma e do dado extra de Crítico Formidável ao dano extra do Acerto Crítico, em vez de rolá-los. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Quando a fortuna favorece sua lâmina, você sabe como fazer valer a pena. Quando marca um Acerto Crítico com um ataque corpo a corpo com uma arma ou um Ataque Desarmado, pode rolar um dos dados de dano da arma uma vez adicional e adicioná-lo ao dano extra do Acerto Crítico.',
  'Crítico Máximo. Se você escolher este traço duas vezes, quando usa Crítico Formidável, pode adicionar o máximo dos dados de dano originais da arma e do dado extra de Crítico Formidável ao dano extra do Acerto Crítico, em vez de rolá-los. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Crítico Máximo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'mobile-bastion',
  'PersonalBastionCombat',
  'combat'::rpg.heritage_trait_category,
  'Bastião Móvel',
  'Concentrando toda a sua determinação, você permanece firme e vê os inimigos se esgotarem contra suas defesas. Como uma ação Mágica, você fica imóvel e ganha os seguintes efeitos: você não pode tomar ações e não pode usar sua Ação Bônus, exceto para encerrar o efeito deste traço.

Bastião Móvel. Se você escolher este traço duas vezes, quando usa Bastião Pessoal, seu Deslocamento é reduzido à metade do Deslocamento normal (arredondado para baixo), você não tem Desvantagem em salvaguardas de Destreza e pode usar Ações Bônus.',
  'Concentrando toda a sua determinação, você permanece firme e vê os inimigos se esgotarem contra suas defesas. Como uma ação Mágica, você fica imóvel e ganha os seguintes efeitos: você não pode tomar ações e não pode usar sua Ação Bônus, exceto para encerrar o efeito deste traço.',
  'Bastião Móvel. Se você escolher este traço duas vezes, quando usa Bastião Pessoal, seu Deslocamento é reduzido à metade do Deslocamento normal (arredondado para baixo), você não tem Desvantagem em salvaguardas de Destreza e pode usar Ações Bônus.',
  'Bastião Móvel',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'moving-insight',
  'EnemyInMotionCombat',
  'combat'::rpg.heritage_trait_category,
  'Intuição em Movimento',
  'Uma vida de andanças permite julgar quando o movimento dos outros trabalha a seu favor. Quando faz uma jogada de ataque contra uma criatura ou uma salvaguarda contra o ataque, magia ou habilidade de uma criatura, pode usar uma Reação para ter Vantagem na jogada de ataque ou salvaguarda se essa criatura se moveu desde o fim do seu último turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Intuição em Movimento. Se você escolher este traço duas vezes, Inimigo em Movimento também permite usar sua Reação para afetar a jogada de ataque ou salvaguarda de um aliado se esse aliado estiver a até 9 m.',
  'Uma vida de andanças permite julgar quando o movimento dos outros trabalha a seu favor. Quando faz uma jogada de ataque contra uma criatura ou uma salvaguarda contra o ataque, magia ou habilidade de uma criatura, pode usar uma Reação para ter Vantagem na jogada de ataque ou salvaguarda se essa criatura se moveu desde o fim do seu último turno. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Intuição em Movimento. Se você escolher este traço duas vezes, Inimigo em Movimento também permite usar sua Reação para afetar a jogada de ataque ou salvaguarda de um aliado se esse aliado estiver a até 9 m.',
  'Intuição em Movimento',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'nimble-passage',
  'PassThroughExploration',
  'exploration'::rpg.heritage_trait_category,
  'Passagem Ágil',
  'Usar movimento constante permite minimizar a ameaça de inimigos maiores. Você pode se mover através do espaço de qualquer criatura pelo menos um tamanho maior que você.

Passagem Ágil. Se você escolher este traço duas vezes, você não trata o espaço de outra criatura como Terreno Difícil.',
  'Usar movimento constante permite minimizar a ameaça de inimigos maiores. Você pode se mover através do espaço de qualquer criatura pelo menos um tamanho maior que você.',
  'Passagem Ágil. Se você escolher este traço duas vezes, você não trata o espaço de outra criatura como Terreno Difícil.',
  'Passagem Ágil',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'opportune-reach',
  'ReachAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Alcance Oportuno',
  'Ao se lançar à batalha, seus inimigos descobrem que tentar manter distância não os salvará. Seu alcance aumenta em 1,5 m. Esse alcance extra não se aplica a Ataques de Oportunidade.

Alcance Oportuno. Se você escolher este traço duas vezes, seu alcance extra de Ataque de Alcance se aplica a Ataques de Oportunidade.',
  'Ao se lançar à batalha, seus inimigos descobrem que tentar manter distância não os salvará. Seu alcance aumenta em 1,5 m. Esse alcance extra não se aplica a Ataques de Oportunidade.',
  'Alcance Oportuno. Se você escolher este traço duas vezes, seu alcance extra de Ataque de Alcance se aplica a Ataques de Oportunidade.',
  'Alcance Oportuno',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'overwhelming-shove',
  'MightyShoveCombat',
  'combat'::rpg.heritage_trait_category,
  'Empurrão Avassalador',
  'Seus golpes poderosos fazem os alvos cambalearem. Quando acerta uma criatura de no máximo um tamanho maior que você com um ataque corpo a corpo, pode usar uma Ação Bônus para tentar empurrar essa criatura. O alvo deve ter sucesso em uma salvaguarda de Força ou Destreza (CD = 8 + seu modificador de Força + seu Bônus de Proficiência) ou ser empurrado até 3 m para longe de você.

Empurrão Avassalador. Se você escolher este traço duas vezes, quando usa Empurrão Formidável, a criatura alvo tem Desvantagem na salvaguarda.',
  'Seus golpes poderosos fazem os alvos cambalearem. Quando acerta uma criatura de no máximo um tamanho maior que você com um ataque corpo a corpo, pode usar uma Ação Bônus para tentar empurrar essa criatura. O alvo deve ter sucesso em uma salvaguarda de Força ou Destreza (CD = 8 + seu modificador de Força + seu Bônus de Proficiência) ou ser empurrado até 3 m para longe de você.',
  'Empurrão Avassalador. Se você escolher este traço duas vezes, quando usa Empurrão Formidável, a criatura alvo tem Desvantagem na salvaguarda.',
  'Empurrão Avassalador',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'pack-instinct',
  'PackTacticsCombat',
  'combat'::rpg.heritage_trait_category,
  'Instinto de Matilha',
  'Manter-se perto dos aliados em combate o torna ainda mais perigoso. Quando inicia o turno com pelo menos um aliado que não esteja Incapacitado a até 1,5 m de outra criatura que você possa ver, pode usar sua Reação para ter Vantagem em jogadas de ataque contra essa criatura até o fim do seu turno.

Instinto de Matilha. Se você escolher este traço duas vezes, obter Vantagem de Táticas de Matilha não exige ação.',
  'Manter-se perto dos aliados em combate o torna ainda mais perigoso. Quando inicia o turno com pelo menos um aliado que não esteja Incapacitado a até 1,5 m de outra criatura que você possa ver, pode usar sua Reação para ter Vantagem em jogadas de ataque contra essa criatura até o fim do seu turno.',
  'Instinto de Matilha. Se você escolher este traço duas vezes, obter Vantagem de Táticas de Matilha não exige ação.',
  'Instinto de Matilha',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'pack-leader',
  'PackHunterCombat',
  'combat'::rpg.heritage_trait_category,
  'Líder de Matilha',
  'Lutar no meio da batalha permite auxiliar os aliados quando importa. Quando um aliado a até 3 m de você está prestes a fazer uma jogada de ataque ou uma salvaguarda, pode usar uma Reação para conceder a esse aliado Vantagem no ataque ou na salvaguarda. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Líder de Matilha. Se você escolher este traço duas vezes, Caçador de Matilha pode ser desencadeado por qualquer aliado a até 9 m de você. Além disso, se a jogada de ataque errar ou a salvaguarda falhar, você não perde esse uso de Caçador de Matilha.',
  'Lutar no meio da batalha permite auxiliar os aliados quando importa. Quando um aliado a até 3 m de você está prestes a fazer uma jogada de ataque ou uma salvaguarda, pode usar uma Reação para conceder a esse aliado Vantagem no ataque ou na salvaguarda. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Líder de Matilha. Se você escolher este traço duas vezes, Caçador de Matilha pode ser desencadeado por qualquer aliado a até 9 m de você. Além disso, se a jogada de ataque errar ou a salvaguarda falhar, você não perde esse uso de Caçador de Matilha.',
  'Líder de Matilha',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'phase-shift',
  'OutofPhaseCombat',
  'combat'::rpg.heritage_trait_category,
  'Mudança de Fase',
  'Sua presença corpórea oscila e se desvanece, enfraquecendo a capacidade dos inimigos de feri-lo. Como Ação Bônus, por 1 minuto, todas as criaturas têm Desvantagem em jogadas de ataque contra você, e você pode se mover através dos espaços de outras criaturas sem tratá-los como Terreno Difícil. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Mudança de Fase. Se você escolher este traço duas vezes, quando usa Fora de Fase, pode estender o benefício a qualquer aliado a até 3 m de você.

Prepare uma cela especial para essa. Ela tem truques.

— Carcereiro castinelano',
  'Sua presença corpórea oscila e se desvanece, enfraquecendo a capacidade dos inimigos de feri-lo. Como Ação Bônus, por 1 minuto, todas as criaturas têm Desvantagem em jogadas de ataque contra você, e você pode se mover através dos espaços de outras criaturas sem tratá-los como Terreno Difícil. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Mudança de Fase. Se você escolher este traço duas vezes, quando usa Fora de Fase, pode estender o benefício a qualquer aliado a até 3 m de você.

Prepare uma cela especial para essa. Ela tem truques.

— Carcereiro castinelano',
  'Mudança de Fase',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'piercing-perception',
  'InbornPerceptionRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Percepção Penetrante',
  'A melhor forma de evitar o perigo é garantir que você seja a primeira pessoa a notá-lo. Você tem proficiência na perícia Percepção.

Percepção Penetrante. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'A melhor forma de evitar o perigo é garantir que você seja a primeira pessoa a notá-lo. Você tem proficiência na perícia Percepção.',
  'Percepção Penetrante. Se você escolher este traço duas vezes, você tem Vantagem em testes de Percepção. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Percepção Penetrante',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'poison-indemnity',
  'PoisonResilienceExploration',
  'exploration'::rpg.heritage_trait_category,
  'Indenização ao Veneno',
  'Sua fortaleza excepcional permite ignorar os efeitos até das piores toxinas. Você tem Vantagem em salvaguardas contra ficar Envenenado.

Indenização ao Veneno. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra ficar Envenenado, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Sua fortaleza excepcional permite ignorar os efeitos até das piores toxinas. Você tem Vantagem em salvaguardas contra ficar Envenenado.',
  'Indenização ao Veneno. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra ficar Envenenado, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Indenização ao Veneno',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'potent-breath',
  'BreathWeaponCombat',
  'combat'::rpg.heritage_trait_category,
  'Sopro Potente',
  'Uma conexão com a fúria dracônica ou elemental permite liberar uma rajada de energia destrutiva. Ao selecionar este traço, escolha um tipo de dano: Ácido, Gélido, Fogo, Relâmpago, Veneno ou Trovejante. Em seguida, escolha uma área de efeito: uma Linha de 1,5 m de largura e 9 m de comprimento, ou um Cone de 4,5 m.

Quando usa uma ação Mágica para expelir seu Sopro Elemental, cada criatura na área de efeito deve fazer uma salvaguarda de Destreza (CD = 8 + seu modificador de Constituição + seu Bônus de Proficiência). Uma criatura alvo sofre 1d8 de dano do tipo escolhido em uma falha, ou metade desse dano em um sucesso. Esse dano aumenta em 1d8 quando você alcança os níveis de personagem 5 (2d8), 11 (3d8) e 17 (4d8).

Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Sopro Potente. Se você escolher este traço várias vezes, você ganha um sopro elemental adicional a cada vez, com seu próprio número de usos, tipo de dano e área de efeito.

Além disso, quando usa qualquer um dos seus Sopros Elementais, um alvo à sua escolha tem Desvantagem na salvaguarda. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Uma conexão com a fúria dracônica ou elemental permite liberar uma rajada de energia destrutiva. Ao selecionar este traço, escolha um tipo de dano: Ácido, Gélido, Fogo, Relâmpago, Veneno ou Trovejante. Em seguida, escolha uma área de efeito: uma Linha de 1,5 m de largura e 9 m de comprimento, ou um Cone de 4,5 m.

Quando usa uma ação Mágica para expelir seu Sopro Elemental, cada criatura na área de efeito deve fazer uma salvaguarda de Destreza (CD = 8 + seu modificador de Constituição + seu Bônus de Proficiência). Uma criatura alvo sofre 1d8 de dano do tipo escolhido em uma falha, ou metade desse dano em um sucesso. Esse dano aumenta em 1d8 quando você alcança os níveis de personagem 5 (2d8), 11 (3d8) e 17 (4d8).

Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sopro Potente. Se você escolher este traço várias vezes, você ganha um sopro elemental adicional a cada vez, com seu próprio número de usos, tipo de dano e área de efeito.

Além disso, quando usa qualquer um dos seus Sopros Elementais, um alvo à sua escolha tem Desvantagem na salvaguarda. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Sopro Potente',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'powerful-shove',
  'PowerfulBuildExplorationCombat',
  'combat'::rpg.heritage_trait_category,
  'Empurrão Poderoso',
  'Seja carregando espólio bem conquistado ou o corpo de um companheiro caído, você carrega esse peso com facilidade. Você conta como um tamanho maior ao determinar sua capacidade de carga e o peso que pode empurrar, arrastar ou erguer. Uma criatura Pequena com este traço pode usar qualquer arma com a propriedade Pesada, desde que tenha proficiência com essa arma. (Este é um traço de Exploração.)

Empurrão Poderoso. Se você escolher este traço duas vezes, você pode mover ou derrubar inimigos com facilidade. Quando usa Ataque Desarmado para empurrar uma criatura 1,5 m ou conceder-lhe a condição Caído, o alvo tem Desvantagem na salvaguarda. (Este é um traço de Combate.)',
  'Seja carregando espólio bem conquistado ou o corpo de um companheiro caído, você carrega esse peso com facilidade. Você conta como um tamanho maior ao determinar sua capacidade de carga e o peso que pode empurrar, arrastar ou erguer. Uma criatura Pequena com este traço pode usar qualquer arma com a propriedade Pesada, desde que tenha proficiência com essa arma. (Este é um traço de Exploração.)',
  'Empurrão Poderoso. Se você escolher este traço duas vezes, você pode mover ou derrubar inimigos com facilidade. Quando usa Ataque Desarmado para empurrar uma criatura 1,5 m ou conceder-lhe a condição Caído, o alvo tem Desvantagem na salvaguarda. (Este é um traço de Combate.)',
  'Empurrão Poderoso',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'primal-voice',
  'NaturesVoiceRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Voz Primal',
  'Dominar a expressão sutil da fauna e da flora lhe dá vantagem ao lidar com as ameaças da natureza. Por meio de sons e gestos, você pode comunicar ideias simples a Bestas e criaturas do tipo Planta, entendendo se uma criatura está com fome, por exemplo. Isso não lhe dá habilidade específica de controlar tais criaturas, e você não pode entender ou obter informações detalhadas delas.

Voz Primal. Se você escolher este traço duas vezes, você tem Vantagem em testes de atributo feitos como parte de uma ação Influenciar para interagir com uma Besta ou criatura do tipo Planta.',
  'Dominar a expressão sutil da fauna e da flora lhe dá vantagem ao lidar com as ameaças da natureza. Por meio de sons e gestos, você pode comunicar ideias simples a Bestas e criaturas do tipo Planta, entendendo se uma criatura está com fome, por exemplo. Isso não lhe dá habilidade específica de controlar tais criaturas, e você não pode entender ou obter informações detalhadas delas.',
  'Voz Primal. Se você escolher este traço duas vezes, você tem Vantagem em testes de atributo feitos como parte de uma ação Influenciar para interagir com uma Besta ou criatura do tipo Planta.',
  'Voz Primal',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'protective-cover',
  'WellProtectedCombat',
  'combat'::rpg.heritage_trait_category,
  'Cobertura Protetora',
  'Sua capacidade de absorver até os piores ataques significa que armadura só o atrasaria. Quando não estiver vestindo armadura, sua CA é igual a 13 + seu modificador de Destreza.

Cobertura Protetora. Se você escolher este traço duas vezes, quando faz uma salvaguarda de Destreza ou é alvo de um ataque à distância, pode usar uma Reação para ter Vantagem na salvaguarda ou impor Desvantagem na jogada de ataque à distância. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sua capacidade de absorver até os piores ataques significa que armadura só o atrasaria. Quando não estiver vestindo armadura, sua CA é igual a 13 + seu modificador de Destreza.',
  'Cobertura Protetora. Se você escolher este traço duas vezes, quando faz uma salvaguarda de Destreza ou é alvo de um ataque à distância, pode usar uma Reação para ter Vantagem na salvaguarda ou impor Desvantagem na jogada de ataque à distância. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Cobertura Protetora',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'quickened-swim',
  'SwimmerExploration',
  'exploration'::rpg.heritage_trait_category,
  'Natação Acelerada',
  'Você está em seu elemento na água, movendo-se com graça e facilidade. Você tem um Deslocamento de Natação igual ao seu Deslocamento.

Natação Acelerada. Se você escolher este traço duas vezes, você pode usar a ação Disparar como Ação Bônus enquanto nada.',
  'Você está em seu elemento na água, movendo-se com graça e facilidade. Você tem um Deslocamento de Natação igual ao seu Deslocamento.',
  'Natação Acelerada. Se você escolher este traço duas vezes, você pode usar a ação Disparar como Ação Bônus enquanto nada.',
  'Natação Acelerada',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'reawakened',
  'AwakenedMindCombat',
  'combat'::rpg.heritage_trait_category,
  'Reavivado',
  'Os perigos de Etharis lhe deram um foco que permite ignorar efeitos mágicos debilitantes. Você tem sucesso automático em salvaguardas contra efeitos mágicos que lhe concederiam as condições Incapacitado, Atordoado ou Inconsciente. Isso não inclui efeitos que o deixam Inconsciente por ser reduzido a 0 Pontos de Vida.

Reavivado. Se você escolher este traço duas vezes, você também tem Vantagem em salvaguardas de Inteligência, Sabedoria e Carisma.',
  'Os perigos de Etharis lhe deram um foco que permite ignorar efeitos mágicos debilitantes. Você tem sucesso automático em salvaguardas contra efeitos mágicos que lhe concederiam as condições Incapacitado, Atordoado ou Inconsciente. Isso não inclui efeitos que o deixam Inconsciente por ser reduzido a 0 Pontos de Vida.',
  'Reavivado. Se você escolher este traço duas vezes, você também tem Vantagem em salvaguardas de Inteligência, Sabedoria e Carisma.',
  'Reavivado',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'regenerative-healer',
  'UnnaturalHealerRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Curandeiro Regenerativo',
  'Suas habilidades de cura inatas permitem recuperar-se de algumas das feridas mais terríveis. Durante um Descanso Longo, você pode reverter automaticamente Feridas Graves. Além disso, pode reatar quaisquer partes do corpo decepadas (dedos, pernas, caudas e assim por diante), que são restauradas automaticamente ao fim do Descanso Longo. Se suas partes decepadas não estiverem disponíveis, pode substituí-las pelas mesmas partes do corpo de outra criatura da mesma anatomia geral que a sua. Se desejar trocar intencionalmente partes do corpo por substitutos, pode decepá-las sem dor ou desconforto.

A capacidade de usar partes do corpo incomuns (por exemplo, dar a si mesmo a pata com garras de um leão se perder uma mão) fica a critério do Mestre. Em qualquer caso, trocar uma parte decepada por uma parte incomum não concede Vantagens mecânicas não cobertas por outros traços (veja “Características e Traços”).

Curandeiro Regenerativo. Se você escolher este traço duas vezes, você reverte automaticamente Feridas Permanentes durante um Descanso Longo. Além disso, pode restaurar qualquer parte do corpo decepada durante um Descanso Longo, como se sujeito à magia Regeneração. Você pode usar este traço para criar partes regeneradas incomuns conforme determinação do Mestre.',
  'Suas habilidades de cura inatas permitem recuperar-se de algumas das feridas mais terríveis. Durante um Descanso Longo, você pode reverter automaticamente Feridas Graves. Além disso, pode reatar quaisquer partes do corpo decepadas (dedos, pernas, caudas e assim por diante), que são restauradas automaticamente ao fim do Descanso Longo. Se suas partes decepadas não estiverem disponíveis, pode substituí-las pelas mesmas partes do corpo de outra criatura da mesma anatomia geral que a sua. Se desejar trocar intencionalmente partes do corpo por substitutos, pode decepá-las sem dor ou desconforto.

A capacidade de usar partes do corpo incomuns (por exemplo, dar a si mesmo a pata com garras de um leão se perder uma mão) fica a critério do Mestre. Em qualquer caso, trocar uma parte decepada por uma parte incomum não concede Vantagens mecânicas não cobertas por outros traços (veja “Características e Traços”).',
  'Curandeiro Regenerativo. Se você escolher este traço duas vezes, você reverte automaticamente Feridas Permanentes durante um Descanso Longo. Além disso, pode restaurar qualquer parte do corpo decepada durante um Descanso Longo, como se sujeito à magia Regeneração. Você pode usar este traço para criar partes regeneradas incomuns conforme determinação do Mestre.',
  'Curandeiro Regenerativo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'relentless-instinct',
  'HuntersInstinctCombat',
  'combat'::rpg.heritage_trait_category,
  'Instinto Implacável',
  'Você convoca um surto de ferocidade quando sua presa menos espera. Ao fim de cada Descanso Longo, você ganha um número de d8s igual ao seu Bônus de Proficiência. Quando faz um ataque com uma arma ou um Ataque Desarmado, pode rolar 1d8 e adicioná-lo à jogada de ataque ou à jogada de dano. Se o adicionar à rolagem de d20, pode decidir rolar o d8 depois que a rolagem de d20 for feita, mas deve fazê-lo antes que o resultado da rolagem seja conhecido.

Instinto Implacável. Se você escolher este traço duas vezes, sempre que usa Instinto do Caçador para uma jogada de ataque, se a jogada de ataque errar, você retém o d8 e pode usá-lo novamente.',
  'Você convoca um surto de ferocidade quando sua presa menos espera. Ao fim de cada Descanso Longo, você ganha um número de d8s igual ao seu Bônus de Proficiência. Quando faz um ataque com uma arma ou um Ataque Desarmado, pode rolar 1d8 e adicioná-lo à jogada de ataque ou à jogada de dano. Se o adicionar à rolagem de d20, pode decidir rolar o d8 depois que a rolagem de d20 for feita, mas deve fazê-lo antes que o resultado da rolagem seja conhecido.',
  'Instinto Implacável. Se você escolher este traço duas vezes, sempre que usa Instinto do Caçador para uma jogada de ataque, se a jogada de ataque errar, você retém o d8 e pode usá-lo novamente.',
  'Instinto Implacável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'remarkable-driver',
  'DriverExploration',
  'exploration'::rpg.heritage_trait_category,
  'Condutor Notável',
  'As estradas e vias navegáveis de Etharis muitas vezes não são menos perigosas que a natureza selvagem, e você se dedica a transportar outros com segurança por essas rotas. Você tem proficiência com Ferramentas de Navegador e tem Vantagem em testes de atributo feitos para conduzir um veículo.

Condutor Notável. Se você escolher este traço duas vezes, você pode fazer testes envolvendo conduzir um veículo que exigiriam uma ação sem precisar usar sua ação. Você só obtém esse uso gratuito uma vez por rodada.',
  'As estradas e vias navegáveis de Etharis muitas vezes não são menos perigosas que a natureza selvagem, e você se dedica a transportar outros com segurança por essas rotas. Você tem proficiência com Ferramentas de Navegador e tem Vantagem em testes de atributo feitos para conduzir um veículo.',
  'Condutor Notável. Se você escolher este traço duas vezes, você pode fazer testes envolvendo conduzir um veículo que exigiriam uma ação sem precisar usar sua ação. Você só obtém esse uso gratuito uma vez por rodada.',
  'Condutor Notável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'resolute-sight',
  'IrrepressibleSightExploration',
  'exploration'::rpg.heritage_trait_category,
  'Visão Resoluta',
  'Qualquer inimigo que você possa ver é um inimigo que pode derrubar — então você garante que nada o impeça de ver. Você tem Vantagem em salvaguardas contra a condição Cego.

Visão Resoluta. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra a condição Cego, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Qualquer inimigo que você possa ver é um inimigo que pode derrubar — então você garante que nada o impeça de ver. Você tem Vantagem em salvaguardas contra a condição Cego.',
  'Visão Resoluta. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra a condição Cego, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Visão Resoluta',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'restorative-rest',
  'MeditativeRestExploration',
  'exploration'::rpg.heritage_trait_category,
  'Descanso Restaurador',
  'O sono é um luxo de que você nunca precisou. Quando descansa, medita profundamente por 4 horas, sonhando mas permanecendo consciente. Após descansar dessa forma, você ganha o mesmo benefício que outros humanoides obtêm de 8 horas de sono.

Descanso Restaurador. Se você escolher este traço duas vezes, você precisa passar apenas 2 horas na meditação para obter o benefício de 8 horas de sono, e ganha 1d6 ao fim de cada Descanso Longo. Antes do fim do seu próximo Descanso Longo, pode rolar o d6 e adicioná-lo a qualquer Teste de d20 que fizer. Você pode decidir rolar o d6 depois que o Teste de d20 for feito, mas deve fazê-lo antes que o resultado da rolagem seja conhecido.',
  'O sono é um luxo de que você nunca precisou. Quando descansa, medita profundamente por 4 horas, sonhando mas permanecendo consciente. Após descansar dessa forma, você ganha o mesmo benefício que outros humanoides obtêm de 8 horas de sono.',
  'Descanso Restaurador. Se você escolher este traço duas vezes, você precisa passar apenas 2 horas na meditação para obter o benefício de 8 horas de sono, e ganha 1d6 ao fim de cada Descanso Longo. Antes do fim do seu próximo Descanso Longo, pode rolar o d6 e adicioná-lo a qualquer Teste de d20 que fizer. Você pode decidir rolar o d6 depois que o Teste de d20 for feito, mas deve fazê-lo antes que o resultado da rolagem seja conhecido.',
  'Descanso Restaurador',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'sangromancy-savant',
  'DivineSangromancyCombat',
  'combat'::rpg.heritage_trait_category,
  'Erudito em Sangromancia',
  'Uma conexão com a força vital dos outros permite moldar essa força em benefício deles. Sempre que uma criatura aliada a até 9 m de você recupera Pontos de Vida, você pode gastar um Dado de Vida e adicionar a rolagem do dado ao número de Pontos de Vida ganhos pelo aliado.

Erudito em Sangromancia. Se você escolher este traço duas vezes, quando usa Sangromancia Divina, também recupera Pontos de Vida iguais à rolagem do seu Dado de Vida.',
  'Uma conexão com a força vital dos outros permite moldar essa força em benefício deles. Sempre que uma criatura aliada a até 9 m de você recupera Pontos de Vida, você pode gastar um Dado de Vida e adicionar a rolagem do dado ao número de Pontos de Vida ganhos pelo aliado.',
  'Erudito em Sangromancia. Se você escolher este traço duas vezes, quando usa Sangromancia Divina, também recupera Pontos de Vida iguais à rolagem do seu Dado de Vida.',
  'Erudito em Sangromancia',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'secret-dreams',
  'DreamwalkingRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Sonhos Secretos',
  'Sempre que descansa, você toca os sonhos daqueles ao redor, semeando seus pensamentos e memórias em sua própria mente. Quando faz um teste de atributo para recordar lore ou conhecimento, tem Vantagem no teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Sonhos Secretos. Se você escolher este traço duas vezes, você ganha um conhecimento instintivo dos segredos de outras criaturas enquanto toca seus sonhos. Usando uma ação Procurar, você se concentra em uma criatura que possa ver e faz um teste de Intuição de Sabedoria CD 15. Com um sucesso, aprende um segredo à escolha do Mestre conhecido por essa criatura. Os segredos de criaturas que não têm idioma chegam a você como imagens e impressões vagas. Você recupera o uso deste recurso ao terminar um Descanso Curto ou Longo.

Para que se preocupar com interrogatório? Deixe-o descansar algumas horas. Eu trago suas respostas.

— Varrigan, o Caminhante dos Sonhos',
  'Sempre que descansa, você toca os sonhos daqueles ao redor, semeando seus pensamentos e memórias em sua própria mente. Quando faz um teste de atributo para recordar lore ou conhecimento, tem Vantagem no teste. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sonhos Secretos. Se você escolher este traço duas vezes, você ganha um conhecimento instintivo dos segredos de outras criaturas enquanto toca seus sonhos. Usando uma ação Procurar, você se concentra em uma criatura que possa ver e faz um teste de Intuição de Sabedoria CD 15. Com um sucesso, aprende um segredo à escolha do Mestre conhecido por essa criatura. Os segredos de criaturas que não têm idioma chegam a você como imagens e impressões vagas. Você recupera o uso deste recurso ao terminar um Descanso Curto ou Longo.

Para que se preocupar com interrogatório? Deixe-o descansar algumas horas. Eu trago suas respostas.

— Varrigan, o Caminhante dos Sonhos',
  'Sonhos Secretos',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'self-repair',
  'ArtificialFormExploration',
  'exploration'::rpg.heritage_trait_category,
  'Autorreparo',
  'Você foi feito, não nascido, e sua origem antinatural o marca para sempre como diferente. Você é um Constructo, mas sua forma encantada ainda se beneficia de magias de cura. Você também pode se curar gastando Dados de Vida durante Descansos Curtos e Descansos Longos, como de costume.

Você não precisa comer, beber, dormir ou respirar. Ainda deve permanecer inativo por 8 horas durante um Descanso Longo para obter seus benefícios.

Autorreparo. Se você escolher este traço duas vezes, quando o truque Conserto é conjurado em você, pode gastar um Dado de Vida para recuperar um número de Pontos de Vida igual à rolagem do dado mais seu modificador de Constituição (mínimo 1 Ponto de Vida). Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você foi feito, não nascido, e sua origem antinatural o marca para sempre como diferente. Você é um Constructo, mas sua forma encantada ainda se beneficia de magias de cura. Você também pode se curar gastando Dados de Vida durante Descansos Curtos e Descansos Longos, como de costume.

Você não precisa comer, beber, dormir ou respirar. Ainda deve permanecer inativo por 8 horas durante um Descanso Longo para obter seus benefícios.',
  'Autorreparo. Se você escolher este traço duas vezes, quando o truque Conserto é conjurado em você, pode gastar um Dado de Vida para recuperar um número de Pontos de Vida igual à rolagem do dado mais seu modificador de Constituição (mínimo 1 Ponto de Vida). Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Autorreparo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'shared-camouflage',
  'NaturalCamouflageExploration',
  'exploration'::rpg.heritage_trait_category,
  'Camuflagem Compartilhada',
  'Sua capacidade de se fundir ao fundo de território familiar ajuda a mantê-lo a salvo de ameaças. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Você tem Vantagem em testes de Furtividade feitos com a ação Esconder-se enquanto estiver nesse ambiente.

Camuflagem Compartilhada. Se você escolher este traço várias vezes, você ganha os benefícios para um novo ambiente a cada vez.

Além disso, quando toma a ação Esconder-se, pode abrir mão de fazer um teste de Furtividade enquanto estiver em qualquer ambiente escolhido com Camuflagem Natural, tratando o teste como se tivesse rolado 15. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Sua capacidade de se fundir ao fundo de território familiar ajuda a mantê-lo a salvo de ameaças. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Você tem Vantagem em testes de Furtividade feitos com a ação Esconder-se enquanto estiver nesse ambiente.',
  'Camuflagem Compartilhada. Se você escolher este traço várias vezes, você ganha os benefícios para um novo ambiente a cada vez.

Além disso, quando toma a ação Esconder-se, pode abrir mão de fazer um teste de Furtividade enquanto estiver em qualquer ambiente escolhido com Camuflagem Natural, tratando o teste como se tivesse rolado 15. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Camuflagem Compartilhada',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'shared-fleetness',
  'FleetofFootExploration',
  'exploration'::rpg.heritage_trait_category,
  'Agilidade Compartilhada',
  'Como você já aprendeu mais de uma vez, mover-se rápido costuma ser a melhor forma de evitar problemas. Seu Deslocamento aumenta em 1,5 m.

Agilidade Compartilhada. Se você escolher este traço duas vezes, seu Deslocamento aumenta em mais 1,5 m, para um aumento total de 3 m.

Além disso, como Ação Bônus, escolha qualquer número de criaturas a até 9 m. Essas criaturas ganham um bônus de 3 m ao Deslocamento por 1 minuto. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Como você já aprendeu mais de uma vez, mover-se rápido costuma ser a melhor forma de evitar problemas. Seu Deslocamento aumenta em 1,5 m.',
  'Agilidade Compartilhada. Se você escolher este traço duas vezes, seu Deslocamento aumenta em mais 1,5 m, para um aumento total de 3 m.

Além disso, como Ação Bônus, escolha qualquer número de criaturas a até 9 m. Essas criaturas ganham um bônus de 3 m ao Deslocamento por 1 minuto. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  NULL,
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'shared-movement',
  'NaturalMovementExploration',
  'exploration'::rpg.heritage_trait_category,
  'Movimento Compartilhado',
  'O tempo que passou no mundo natural permite viajar com velocidade e dificulta aqueles que o caçariam. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Enquanto estiver nesse ambiente, mover-se através de Terreno Difícil não mágico não lhe custa deslocamento extra, e testes de atributo feitos para rastreá-lo têm Desvantagem.

Movimento Compartilhado. Se você escolher este traço várias vezes, você ganha os benefícios para um novo ambiente a cada vez. Além disso, enquanto estiver em qualquer ambiente escolhido para Movimento Natural, como Ação Bônus, pode conceder a criaturas à sua escolha o benefício de Movimento Natural por 1 hora, desde que essas criaturas permaneçam a até 36 m de você e possam vê-lo.',
  'O tempo que passou no mundo natural permite viajar com velocidade e dificulta aqueles que o caçariam. Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático. Enquanto estiver nesse ambiente, mover-se através de Terreno Difícil não mágico não lhe custa deslocamento extra, e testes de atributo feitos para rastreá-lo têm Desvantagem.',
  'Movimento Compartilhado. Se você escolher este traço várias vezes, você ganha os benefícios para um novo ambiente a cada vez. Além disso, enquanto estiver em qualquer ambiente escolhido para Movimento Natural, como Ação Bônus, pode conceder a criaturas à sua escolha o benefício de Movimento Natural por 1 hora, desde que essas criaturas permaneçam a até 36 m de você e possam vê-lo.',
  'Movimento Compartilhado',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'skill-mastery',
  'ProwessRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Maestria em Perícia',
  'Sua engenhosidade e inventividade ajudam a mantê-lo vivo em um mundo perigoso. Antes de fazer um teste de atributo usando uma perícia com a qual é proficiente, pode adicionar seu Bônus de Proficiência novamente. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Maestria em Perícia. Se você escolher este traço duas vezes, quando falha em um teste de atributo feito usando o traço Proeza em Perícia, pode rerrolar o teste e deve usar a nova rolagem.',
  'Sua engenhosidade e inventividade ajudam a mantê-lo vivo em um mundo perigoso. Antes de fazer um teste de atributo usando uma perícia com a qual é proficiente, pode adicionar seu Bônus de Proficiência novamente. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Maestria em Perícia. Se você escolher este traço duas vezes, quando falha em um teste de atributo feito usando o traço Proeza em Perícia, pode rerrolar o teste e deve usar a nova rolagem.',
  'Maestria em Perícia',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'sleeping-ward',
  'EveninSleepExploration',
  'exploration'::rpg.heritage_trait_category,
  'Proteção do Sono',
  'Um senso instintivo de perigo o protege o tempo todo. Enquanto tiver a condição Inconsciente por estar dormindo, você está ciente do entorno e pode fazer testes de Percepção normalmente.

Proteção do Sono. Se você escolher este traço duas vezes, enquanto estiver dormindo, detecta automaticamente a presença de qualquer criatura com intenção de feri-lo que se mova a até 9 m de você. Uma criatura que simplesmente seja capaz de feri-lo não desencadeia este traço até ter a intenção de fazê-lo. Por exemplo, um animal selvagem pode se aproximar com cautela e só decidir atacar quando perceber que você está dormindo.',
  'Um senso instintivo de perigo o protege o tempo todo. Enquanto tiver a condição Inconsciente por estar dormindo, você está ciente do entorno e pode fazer testes de Percepção normalmente.',
  'Proteção do Sono. Se você escolher este traço duas vezes, enquanto estiver dormindo, detecta automaticamente a presença de qualquer criatura com intenção de feri-lo que se mova a até 9 m de você. Uma criatura que simplesmente seja capaz de feri-lo não desencadeia este traço até ter a intenção de fazê-lo. Por exemplo, um animal selvagem pode se aproximar com cautela e só decidir atacar quando perceber que você está dormindo.',
  NULL,
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'slip-free',
  'UncheckedCombat',
  'combat'::rpg.heritage_trait_category,
  'Libertação Ágil',
  'Sua capacidade de permanecer em movimento não tem igual, e os inimigos tentam em vão imobilizá-lo. Você tem Vantagem em salvaguardas contra ficar Contido.

Libertação Ágil. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra ficar Contido, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Sua capacidade de permanecer em movimento não tem igual, e os inimigos tentam em vão imobilizá-lo. Você tem Vantagem em salvaguardas contra ficar Contido.',
  'Libertação Ágil. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra ficar Contido, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Libertação Ágil',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'smoker',
  'ArtificeExpertiseExplorationCombat',
  'combat'::rpg.heritage_trait_category,
  'Fumante',
  'Trabalhar com detritos e objetos quebrados lhe deu afinidade por reparar e refazer coisas. Você tem proficiência com Ferramentas de Funileiro. (Este é um traço de Exploração.)

Além disso, pode usar suas Ferramentas de Funileiro e 10 PO em materiais apropriados para gastar 10 minutos criando um pequeno dispositivo de mecanismo. O dispositivo deve caber na palma da mão e pode servir a uma das seguintes funções:

Fumante. O dispositivo exala fumaça em um Cubo de 1,5 m por 1 minuto. Quaisquer objetos ou criaturas dentro desse Cubo são considerados Levemente Obscurecidos.

Isqueiro. O dispositivo emite uma pequena chama do tamanho da de uma vela que pode acender objetos inflamáveis.

Bússola. O dispositivo sempre aponta para o norte, ou para uma direção cardeal à determinação do Mestre em outro plano.

Fumante. Se você escolher este traço duas vezes, você pode fazer um dispositivo em 1 minuto em vez de 10 minutos. Além disso, pode escolher imbuir um dispositivo com a seguinte função extra: (Este é um traço de Combate.)

Distrator. Este dispositivo é equipado com luzes piscantes que podem cativar outras criaturas. Como Ação Bônus, você coloca ou arremessa o dispositivo em um espaço a até 9 m de você. Uma criatura que compartilhe o espaço com o dispositivo deve ter sucesso em uma salvaguarda de Inteligência CD 10. Em uma falha, ataques contra essa criatura têm Vantagem até o início do seu próximo turno. Uma criatura pode usar uma ação para destruir o dispositivo. Você pode conceder a até três dos seus dispositivos a característica Distrator. Você recupera a capacidade de fazê-lo ao terminar um Descanso Longo.',
  'Trabalhar com detritos e objetos quebrados lhe deu afinidade por reparar e refazer coisas. Você tem proficiência com Ferramentas de Funileiro. (Este é um traço de Exploração.)

Além disso, pode usar suas Ferramentas de Funileiro e 10 PO em materiais apropriados para gastar 10 minutos criando um pequeno dispositivo de mecanismo. O dispositivo deve caber na palma da mão e pode servir a uma das seguintes funções:

Fumante. O dispositivo exala fumaça em um Cubo de 1,5 m por 1 minuto. Quaisquer objetos ou criaturas dentro desse Cubo são considerados Levemente Obscurecidos.

Isqueiro. O dispositivo emite uma pequena chama do tamanho da de uma vela que pode acender objetos inflamáveis.

Bússola. O dispositivo sempre aponta para o norte, ou para uma direção cardeal à determinação do Mestre em outro plano.',
  'Fumante. Se você escolher este traço duas vezes, você pode fazer um dispositivo em 1 minuto em vez de 10 minutos. Além disso, pode escolher imbuir um dispositivo com a seguinte função extra: (Este é um traço de Combate.)

Distrator. Este dispositivo é equipado com luzes piscantes que podem cativar outras criaturas. Como Ação Bônus, você coloca ou arremessa o dispositivo em um espaço a até 9 m de você. Uma criatura que compartilhe o espaço com o dispositivo deve ter sucesso em uma salvaguarda de Inteligência CD 10. Em uma falha, ataques contra essa criatura têm Vantagem até o início do seu próximo turno. Uma criatura pode usar uma ação para destruir o dispositivo. Você pode conceder a até três dos seus dispositivos a característica Distrator. Você recupera a capacidade de fazê-lo ao terminar um Descanso Longo.',
  'Fumante',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'spirit-s-strength',
  'PsychicSpiritCombat',
  'combat'::rpg.heritage_trait_category,
  'Força do Espírito',
  'A força de sua mente o protege de forças antinaturais. Você tem Resistência a dano Psíquico.

Força do Espírito. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra um efeito que causa dano Psíquico, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'A força de sua mente o protege de forças antinaturais. Você tem Resistência a dano Psíquico.',
  'Força do Espírito. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra um efeito que causa dano Psíquico, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Força do Espírito',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'stalwart-edge',
  'StalwartReservesCombat',
  'combat'::rpg.heritage_trait_category,
  'Fio Inabalável',
  'Cada vez que você ataca um inimigo, o estado de perigo dele lhe empresta vigor. Quando acerta uma criatura com um ataque corpo a corpo, pode usar sua Reação para rolar um número de d4s igual ao seu Bônus de Proficiência e ganhar Pontos de Vida Temporários iguais ao total rolado. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Fio Inabalável. Se você escolher este traço duas vezes, você pode obter o número máximo de Pontos de Vida Temporários em vez de rolar.',
  'Cada vez que você ataca um inimigo, o estado de perigo dele lhe empresta vigor. Quando acerta uma criatura com um ataque corpo a corpo, pode usar sua Reação para rolar um número de d4s igual ao seu Bônus de Proficiência e ganhar Pontos de Vida Temporários iguais ao total rolado. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Fio Inabalável. Se você escolher este traço duas vezes, você pode obter o número máximo de Pontos de Vida Temporários em vez de rolar.',
  'Fio Inabalável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'stand-fast',
  'SteadyExploration',
  'exploration'::rpg.heritage_trait_category,
  'Firmeza',
  'Não importa que tipo de convulsão o cerca, você mantém a posição. Você tem Vantagem em salvaguardas contra a condição Caído.

Firmeza. Se você escolher este traço duas vezes, levantar-se de Caído consome apenas 1,5 m de deslocamento em vez da metade do seu deslocamento.

Além disso, quando falha em uma salvaguarda contra ser derrubado (Caído), pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.

Não fique no chão. Nunca fique no chão. Se ficar no chão, você está morto.

— Guia de Sobrevivência do Caçador de Monstros',
  'Não importa que tipo de convulsão o cerca, você mantém a posição. Você tem Vantagem em salvaguardas contra a condição Caído.',
  'Firmeza. Se você escolher este traço duas vezes, levantar-se de Caído consome apenas 1,5 m de deslocamento em vez da metade do seu deslocamento.

Além disso, quando falha em uma salvaguarda contra ser derrubado (Caído), pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.

Não fique no chão. Nunca fique no chão. Se ficar no chão, você está morto.

— Guia de Sobrevivência do Caçador de Monstros',
  'Firmeza',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'strength-of-life',
  'TouchOfLifeCombat',
  'combat'::rpg.heritage_trait_category,
  'Força da Vida',
  'Efeitos que corrompem a essência de outras criaturas vivas pouco o preocupam. Você tem Resistência a dano Necrótico.

Força da Vida. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra um efeito que causa dano Necrótico, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Efeitos que corrompem a essência de outras criaturas vivas pouco o preocupam. Você tem Resistência a dano Necrótico.',
  'Força da Vida. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra um efeito que causa dano Necrótico, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Força da Vida',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'strong-strike',
  'FirstStrikeCombat',
  'combat'::rpg.heritage_trait_category,
  'Golpe Forte',
  'Hesitação nos outros é uma fraqueza de que você aprendeu a tirar vantagem mortal. Quando acerta uma criatura que ainda não agiu no combate, seu ataque causa 2d6 de dano extra. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.

Golpe Forte. Se você escolher este traço duas vezes, você pode usar o valor máximo dos dados de dano extra de Primeiro Golpe, em vez de rolar. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Hesitação nos outros é uma fraqueza de que você aprendeu a tirar vantagem mortal. Quando acerta uma criatura que ainda não agiu no combate, seu ataque causa 2d6 de dano extra. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Golpe Forte. Se você escolher este traço duas vezes, você pode usar o valor máximo dos dados de dano extra de Primeiro Golpe, em vez de rolar. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Golpe Forte',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'stunt-expert',
  'IntuitiveAcrobatRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Expert em Acrobacias',
  'Manter-se solto e ágil significa conseguir sair até dos apertos mais apertados quando a vida está em jogo. Você tem proficiência na perícia Acrobacia.

Expert em Acrobacias. Se você escolher este traço duas vezes, você tem Vantagem em testes de Acrobacia. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Manter-se solto e ágil significa conseguir sair até dos apertos mais apertados quando a vida está em jogo. Você tem proficiência na perícia Acrobacia.',
  'Expert em Acrobacias. Se você escolher este traço duas vezes, você tem Vantagem em testes de Acrobacia. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Expert em Acrobacias',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'subtle-cover',
  'CreatureCoverCombat',
  'combat'::rpg.heritage_trait_category,
  'Cobertura Sutil',
  'Ao esgueirar-se atrás de inimigos ou aliados, você consegue sumir de vista com facilidade. Você pode tomar a ação Esconder-se mesmo quando tiver Meia Cobertura de uma criatura, desde que essa criatura seja de um tamanho maior que você.

Cobertura Sutil. Se você escolher este traço duas vezes, você pode tomar a ação Esconder-se quando tiver Meia Cobertura de uma criatura do mesmo tamanho que você.',
  'Ao esgueirar-se atrás de inimigos ou aliados, você consegue sumir de vista com facilidade. Você pode tomar a ação Esconder-se mesmo quando tiver Meia Cobertura de uma criatura, desde que essa criatura seja de um tamanho maior que você.',
  'Cobertura Sutil. Se você escolher este traço duas vezes, você pode tomar a ação Esconder-se quando tiver Meia Cobertura de uma criatura do mesmo tamanho que você.',
  'Cobertura Sutil',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'supreme-skirmisher',
  'SkirmishTacticsCombat',
  'combat'::rpg.heritage_trait_category,
  'Escaramuçador Supremo',
  'Seu golpe brutal deixa o inimigo cambaleante enquanto você se esquiva. Quando acerta uma criatura hostil com um ataque com uma arma ou um Ataque Desarmado, Ataques de Oportunidade contra você por essa criatura têm Desvantagem até o fim do seu turno.

Escaramuçador Supremo. Se você escolher este traço duas vezes, quando acerta uma criatura hostil com um ataque com arma ou um Ataque Desarmado, pode tomar a ação Desengajar como Ação Bônus até o fim do seu turno.',
  'Seu golpe brutal deixa o inimigo cambaleante enquanto você se esquiva. Quando acerta uma criatura hostil com um ataque com uma arma ou um Ataque Desarmado, Ataques de Oportunidade contra você por essa criatura têm Desvantagem até o fim do seu turno.',
  'Escaramuçador Supremo. Se você escolher este traço duas vezes, quando acerta uma criatura hostil com um ataque com arma ou um Ataque Desarmado, pode tomar a ação Desengajar como Ação Bônus até o fim do seu turno.',
  'Escaramuçador Supremo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'supreme-slip',
  'SlipperyCombat',
  'combat'::rpg.heritage_trait_category,
  'Escorregão Supremo',
  'Qualquer inimigo que tentar agarrá-lo terá uma surpresa. Você tem Vantagem em testes de Atletismo e Acrobacia para escapar de um agarrão.

Escorregão Supremo. Se você escolher este traço duas vezes, quando falha em um teste de Atletismo ou Acrobacia para escapar de um agarrão, pode usar sua Reação para ter sucesso em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Qualquer inimigo que tentar agarrá-lo terá uma surpresa. Você tem Vantagem em testes de Atletismo e Acrobacia para escapar de um agarrão.',
  'Escorregão Supremo. Se você escolher este traço duas vezes, quando falha em um teste de Atletismo ou Acrobacia para escapar de um agarrão, pode usar sua Reação para ter sucesso em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Escorregão Supremo',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'swift-strike',
  'NaturalAttackCombat',
  'combat'::rpg.heritage_trait_category,
  'Golpe Rápido',
  'O dom de armamento natural significa que você nunca está desarmado, como seus inimigos aprendem por sua conta e risco. Seus Ataques Desarmados causam dano igual a 1d6 + seu modificador de Força ou Destreza. O tipo de dano causado pelos seus Ataques Desarmados pode ser Contundente, Perfurante ou Cortante, conforme o tipo de armamento natural que você possui (garras, chifres, cauda e assim por diante).

Golpe Rápido. Se você escolher este traço duas vezes, você pode usar Ataque Desarmado como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'O dom de armamento natural significa que você nunca está desarmado, como seus inimigos aprendem por sua conta e risco. Seus Ataques Desarmados causam dano igual a 1d6 + seu modificador de Força ou Destreza. O tipo de dano causado pelos seus Ataques Desarmados pode ser Contundente, Perfurante ou Cortante, conforme o tipo de armamento natural que você possui (garras, chifres, cauda e assim por diante).',
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
  'Os outros aprenderam a temê-lo — e por bom motivo. Você tem proficiência na perícia Intimidação.

Influência Aterradora. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intimidação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Os outros aprenderam a temê-lo — e por bom motivo. Você tem proficiência na perícia Intimidação.',
  'Influência Aterradora. Se você escolher este traço duas vezes, você tem Vantagem em testes de Intimidação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Influência Aterradora',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'thorough-sleuth',
  'MindfulInvestigatorRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Investigador Minucioso',
  'Juntar as peças até dos mistérios mais sombrios é segunda natureza para você. Você tem proficiência na perícia Investigação.

Investigador Minucioso. Se você escolher este traço duas vezes, você tem Vantagem em testes de Investigação. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Juntar as peças até dos mistérios mais sombrios é segunda natureza para você. Você tem proficiência na perícia Investigação.',
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
  'À medida que a força vital do inimigo se esvai, você fica cada vez mais forte. Se você tiver o traço Ataque Natural, cada vez que acertar com um Ataque Desarmado, ganha Pontos de Vida Temporários iguais ao dano causado pelo ataque.

Até a Última Gota. Se você escolher este traço duas vezes, quando usa Ataque Drenante, o alvo também sofre uma penalidade ao máximo de Pontos de Vida igual ao dano causado pelo ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'À medida que a força vital do inimigo se esvai, você fica cada vez mais forte. Se você tiver o traço Ataque Natural, cada vez que acertar com um Ataque Desarmado, ganha Pontos de Vida Temporários iguais ao dano causado pelo ataque.',
  'Até a Última Gota. Se você escolher este traço duas vezes, quando usa Ataque Drenante, o alvo também sofre uma penalidade ao máximo de Pontos de Vida igual ao dano causado pelo ataque. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Até a Última Gota',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'tongue-of-gold',
  'PersuasiveKnackRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Língua de Ouro',
  'Você aprendeu que a melhor forma de lidar com certas ameaças é impedir que elas escalem. Você tem proficiência na perícia Persuasão.

Língua de Ouro. Se você escolher este traço duas vezes, você tem Vantagem em testes de Persuasão. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Você aprendeu que a melhor forma de lidar com certas ameaças é impedir que elas escalem. Você tem proficiência na perícia Persuasão.',
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
  'As batalhas que ainda precisa travar são muitas, e a morte não é uma opção. Quando é reduzido a 0 Pontos de Vida mas não morto imediatamente, pode cair a 1 Ponto de Vida em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.

Resistência Incomparável. Se você escolher este traço duas vezes, quando usa Resistência Implacável, você cai a 1d6 Pontos de Vida + seu Bônus de Proficiência. Além disso, quando usa Resistência Implacável, pode usar uma Reação para gastar até cinco Dados de Vida, rolando-os e ganhando esse número de Pontos de Vida.',
  'As batalhas que ainda precisa travar são muitas, e a morte não é uma opção. Quando é reduzido a 0 Pontos de Vida mas não morto imediatamente, pode cair a 1 Ponto de Vida em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Resistência Incomparável. Se você escolher este traço duas vezes, quando usa Resistência Implacável, você cai a 1d6 Pontos de Vida + seu Bônus de Proficiência. Além disso, quando usa Resistência Implacável, pode usar uma Reação para gastar até cinco Dados de Vida, rolando-os e ganhando esse número de Pontos de Vida.',
  'Resistência Incomparável',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'vigorous',
  'TirelessExploration',
  'exploration'::rpg.heritage_trait_category,
  'Vigoroso',
  'Uma resiliência inata permite sacudir condições que derrubariam outros. Você tem Vantagem em salvaguardas ligadas a ganhar ou remover níveis de Exaustão.

Vigoroso. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra Exaustão, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Uma resiliência inata permite sacudir condições que derrubariam outros. Você tem Vantagem em salvaguardas ligadas a ganhar ou remover níveis de Exaustão.',
  'Vigoroso. Se você escolher este traço duas vezes, quando falha em uma salvaguarda contra Exaustão, pode usar sua Reação para ter sucesso na salvaguarda em vez disso. Você recupera o uso deste recurso ao terminar um Descanso Longo.',
  'Vigoroso',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'virtuoso',
  'InstrumentalistRoleplaying',
  'roleplaying'::rpg.heritage_trait_category,
  'Virtuoso',
  'Nos momentos mais quietos, a música ajuda a esquecer os horrores que você viu. Você tem proficiência com dois instrumentos à sua escolha.

Virtuoso. Se você escolher este traço várias vezes, você ganha proficiência com dois novos instrumentos a cada vez.

Além disso, você tem Vantagem em testes de atributo feitos com qualquer instrumento. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Nos momentos mais quietos, a música ajuda a esquecer os horrores que você viu. Você tem proficiência com dois instrumentos à sua escolha.',
  'Virtuoso. Se você escolher este traço várias vezes, você ganha proficiência com dois novos instrumentos a cada vez.

Além disso, você tem Vantagem em testes de atributo feitos com qualquer instrumento. Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Virtuoso',
  NULL,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'wall-walker',
  'ClimberExploration',
  'exploration'::rpg.heritage_trait_category,
  'Caminhante de Paredes',
  'Às vezes, manter distância do que o ameaça significa afastar-se dessas ameaças. Você tem um Deslocamento de Escalada igual ao seu Deslocamento.

Caminhante de Paredes. Se você escolher este traço duas vezes, você pode usar seu Deslocamento de Escalada para se mover para cima, para baixo e através de superfícies verticais e de cabeça para baixo ao longo de tetos, mantendo as mãos livres.

Além disso, enquanto usa movimento de escalada, pode usar a ação Disparar como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Às vezes, manter distância do que o ameaça significa afastar-se dessas ameaças. Você tem um Deslocamento de Escalada igual ao seu Deslocamento.',
  'Caminhante de Paredes. Se você escolher este traço duas vezes, você pode usar seu Deslocamento de Escalada para se mover para cima, para baixo e através de superfícies verticais e de cabeça para baixo ao longo de tetos, mantendo as mãos livres.

Além disso, enquanto usa movimento de escalada, pode usar a ação Disparar como Ação Bônus. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Caminhante de Paredes',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'water-born',
  'AmphibiousExploration',
  'exploration'::rpg.heritage_trait_category,
  'Nascido da Água',
  'Sobreviver debaixo d’água é segunda natureza para você. Você pode respirar ar e água.

Nascido da Água. Se você escolher este traço duas vezes, você tem Vantagem em testes de atributo ou salvaguardas feitos enquanto estiver submerso na água. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Sobreviver debaixo d’água é segunda natureza para você. Você pode respirar ar e água.',
  'Nascido da Água. Se você escolher este traço duas vezes, você tem Vantagem em testes de atributo ou salvaguardas feitos enquanto estiver submerso na água. Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  'Nascido da Água',
  2,
  'stack'::rpg.heritage_trait_take_mode
),
(
  'weapon-specialist',
  'WeaponAptitudeCombat',
  'combat'::rpg.heritage_trait_category,
  'Especialista em Armas',
  'As armas que empunha podem salvar sua vida um dia, e você conhece seus segredos. Você tem proficiência com três armas à sua escolha.

Especialista em Armas. Se você escolher este traço várias vezes, você ganha proficiência com três novas armas a cada vez. Além disso, escolha uma arma com a qual tenha proficiência. Você tem um bônus de +1 nas jogadas de dano com essa arma.',
  'As armas que empunha podem salvar sua vida um dia, e você conhece seus segredos. Você tem proficiência com três armas à sua escolha.',
  'Especialista em Armas. Se você escolher este traço várias vezes, você ganha proficiência com três novas armas a cada vez. Além disso, escolha uma arma com a qual tenha proficiência. Você tem um bônus de +1 nas jogadas de dano com essa arma.',
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

