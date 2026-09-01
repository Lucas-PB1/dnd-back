/**
 * Overrides editoriais PT-BR para talentos GH Cap. 4.
 * Chaves de benefício: `${slug}:${englishBenefitName}` (nome EN do extract).
 */
export const INTRO_OVERRIDES = {
  'blood-hound':
    'Seus sentidos estão aguçados além dos da maioria das pessoas. Quer tenham sido fortalecidos por treinamento ou pela perda de outros sentidos, quer simplesmente tenham amadurecido com você, você é um mestre em encontrar aqueles que procura.',
  'convincing-inquisitor':
    'Você sabe identificar um mentiroso e consegue levar as pessoas a verem as coisas do seu jeito, seja com charme, argumentos racionais ou força de vontade.',
  deathbound:
    'Você viu a morte muitas vezes, de perto e pessoalmente — às vezes por sua própria mão. Essas experiências o afetaram profundamente, ensinando-o sobre a vida e a morte.',
  'fortuneofthe-thaumaturge':
    'Sua conexão com o Taumaturgo coloca você em contato com forças além da compreensão mortal, fazendo outros pensarem que nasceu sob uma lua auspiciosa.',
  'free-sword-mercenarys-will':
    'Seu treinamento com a Companhia das Espadas Livres conferiu a você maior resistência e uma postura que o torna menos propenso a sucumbir às adversidades.',
  'insightful-collector':
    'Suas expedições, transações e atividades mercantis em nome da Companhia de Comércio Augustine colocaram você em contato com colecionadores de artefatos históricos, relíquias e tomos.',
  'resolutionofthe-syndicate':
    'A filiação ao Sindicato de Ébano traz vantagens — uma delas é a motivação que vem com a certeza de que o Sindicato elimina quem falha com frequência.',
  survivor:
    'Sua capacidade de tirar o melhor de uma situação ruim sempre lhe serviu bem.',
  'triage-expert':
    'Você é treinado para lidar com ferimentos no campo de batalha e para salvar vidas depois.',
  'blackpowder-pistol-expert':
    'Você se tornou proficiente no uso de Pistolas de Pólvora Negra.',
  'expanded-grip':
    'Sua aptidão natural com armas maiores permite usá-las de um jeito que outros não conseguem.',
  'hulking-figure':
    'Seja por treinamento extensivo ou por constituição natural, você tem um porte amplo e imponente para sua espécie.',
  'iron-gut':
    'Você come como um gigante das colinas e bebe como um peixe. Anos punindo estômago e fígado resultaram em uma fortitude poderosa.',
  'lightning-caster':
    'Seu estilo rápido de conjurar truques permite entrelaçar magia com velocidade incomum.',
  'medicianofthe-morbus-doctore':
    'Você é um mestre das ciências médicas graças à sua associação com um instituto médico.',
  'nimble-physique':
    'Você é pequeno e magro para sua espécie. Tem uma habilidade misteriosa e consistente de evitar perigo. Você ganha os seguintes benefícios:',
  'sangromantic-initiate':
    'Você se tornou habilidoso o suficiente em tecer magia de sangue para mitigar parte do dano da Sangromancia.',
  'shadowsteel-adept':
    'Você aprendeu a canalizar a arte perigosa, porém poderosa, da conjuração de Shadowsteel.',
  'shadowsteel-master':
    'Seu domínio sobre Shadowsteel se fortalece.',
  'syndicate-spy':
    'Subir na hierarquia do Sindicato de Ébano ensinou a você as habilidades clandestinas da espionagem, valiosas no seu ofício de criminoso organizado.',
  'thrown-weapon-master':
    'Você se destaca com armas de arremesso.',
  'witch-hunter':
    'Você aperfeiçoou suas habilidades lutando contra conjuradores, possivelmente por ter caçado magos como parte da Inquisição Arcanista.',
};

export const BENEFIT_DESCRIPTION_OVERRIDES = {
  // blood-hound
  'blood-hound:Motion Sensor':
    'Sempre que uma criatura Pequena ou maior se mover a até 3 m de você enquanto você não estiver com a condição Inconsciente, fica imediatamente ciente de sua presença.',
  'blood-hound:No Hiding':
    'Você tem Vantagem em testes de Sabedoria (Percepção) que dependam de som ou olfato.',

  // convincing-inquisitor
  'convincing-inquisitor:Charming Presence':
    'Quando realiza a ação Influenciar, não tem Desvantagem em testes para influenciar criaturas Hostis e tem Vantagem em testes para influenciar criaturas Indiferentes.',
  'convincing-inquisitor:Multiple Paths':
    'Pode usar qualquer modificador de atributo quando realiza a ação Influenciar para fazer um teste de Intimidação ou Persuasão.',
  'convincing-inquisitor:Zealous Insight':
    'Quando obtém sucesso em um teste de Sabedoria (Intuição) da ação Procurar para detectar mentiras ou respostas evasivas, tem Vantagem em rolagens de Iniciativa envolvendo combate contra essa criatura por 1 hora.',

  // deathbound
  'deathbound:One Last Breath':
    'Se tiver duas falhas em Salvaguardas contra Morte, tem Vantagem em Salvaguardas contra Morte até não estar mais com 0 Pontos de Vida.',
  'deathbound:Recuperation':
    'Quando gasta um Dado de Vida durante um Descanso Curto para recuperar Pontos de Vida, pode rolar o Dado de Vida duas vezes e usar o maior resultado.',

  // fortuneofthe-thaumaturge
  'fortuneofthe-thaumaturge:Fortune\u2019s Fortitude':
    'Quando falha em um Teste D20, pode gastar e rolar um Dado de Vida, somando esse número ao resultado. Só pode fazer isso uma vez por Teste D20. Pode usar este benefício um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.',
  'fortuneofthe-thaumaturge:Fortune of the Unknown':
    'Ao usar o benefício Fortitude da Fortuna, se rolar o valor mais alto ou mais baixo no Dado de Vida, recupera esse Dado de Vida. Ainda conta como um uso de Fortitude da Fortuna.',

  // free-sword-mercenarys-will
  'free-sword-mercenarys-will:Hold the Ground':
    'Quando for movido sem usar seu deslocamento por uma criatura, pode usar uma Reação para reduzir a distância em que foi movido em até seu Deslocamento.',
  'free-sword-mercenarys-will:Resolute':
    'Você tem Vantagem em salvaguardas que aplicariam uma condição.',

  // insightful-collector
  'insightful-collector:Object Intuition':
    'Pode realizar a ação Estudar para examinar um objeto mágico e aprender suas propriedades e como usá-lo sem sintonizar com ele ou passar um Descanso Curto em contato físico com ele, mas não aprende nenhuma maldição que o item possa carregar. Há 5% de chance cumulativa para cada raridade acima de Comum de identificar erroneamente a natureza e o poder do objeto.',
  'insightful-collector:Rare Find':
    'Você começa o jogo em posse de um item mágico Comum. Combine com o Mestre qual objeto se encaixa no seu personagem e na campanha.',

  // resolutionofthe-syndicate
  'resolutionofthe-syndicate:Quick Strike':
    'No seu primeiro turno após uma rolagem de Iniciativa, adicione 1d4 à primeira jogada de dano que fizer. Esse dano extra aumenta para 2d4 no nível de personagem 9 e para 4d4 no nível 16.',
  'resolutionofthe-syndicate:Resilient':
    'Seu máximo de Pontos de Vida aumenta em um valor igual ao seu nível de personagem quando ganha este talento. Sempre que ganha um nível de personagem depois disso, seu máximo de Pontos de Vida aumenta em 1.',

  // survivor
  'survivor:Hardy':
    'Você precisa de metade da quantidade de comida por dia com base no seu tamanho.',
  'survivor:Intuitive':
    'Quando realiza a ação Estudar, tem Vantagem em testes de Inteligência feitos ao realizar a ação Estudar.',
  'survivor:Shake It Off':
    'Sempre que termina um Descanso Curto, seu nível de Exaustão, se houver, diminui em 1. Além disso, quando termina um Descanso Longo, seu nível de Exaustão diminui em 2.',

  // triage-expert
  'triage-expert:Bedside Manner':
    'Sempre que faz uma criatura recuperar Pontos de Vida ou usa o benefício Sangue e Osso, pode rolar um dado extra e descartar o menor.',
  'triage-expert:Blood and Bone':
    'Realizar a ação Utilizar e gastar o uso de um Kit de Curandeiro permite curar uma criatura a até 1,5 m de você. A criatura pode gastar e rolar um Dado de Vida e recuperar Pontos de Vida iguais à rolagem.',

  // blackpowder-pistol-expert
  'blackpowder-pistol-expert:Ability Score Increase':
    'Aumente Destreza, Constituição ou Inteligência em 1, até o máximo de 20.',
  'blackpowder-pistol-expert:Deadeye':
    'Atacar em alcance longo não impõe Desvantagem em suas jogadas de ataque com uma Pistola de Pólvora Negra.',
  'blackpowder-pistol-expert:Quick Load':
    'Você ignora a propriedade Recarregar da Pistola de Pólvora Negra.',
  'blackpowder-pistol-expert:Trick Shot':
    'Imediatamente depois que uma criatura a até 1,5 m de você se mover, pode usar uma Reação para fazer um ataque à distância com uma Pistola de Pólvora Negra contra essa criatura.',

  // expanded-grip
  'expanded-grip:Ability Score Increase':
    'Aumente Força, Destreza ou Constituição em 1, até o máximo de 20.',
  'expanded-grip:One-Handed Grip':
    'Quando usa uma arma Versátil com uma mão, a arma causa o dano entre parênteses quando usada para fazer um ataque corpo a corpo.',
  'expanded-grip:Zealous Grasp':
    'Se um efeito o forçar a soltar o que está segurando, pode fazer uma salvaguarda de Força CD 15 para manter o agarre. Quando estiver sujeito a um efeito que permita fazer uma salvaguarda para manter o agarre, tem Vantagem na salvaguarda.',

  // hulking-figure
  'hulking-figure:Ability Score Increase':
    'Aumente Força ou Constituição em 1, até o máximo de 20.',
  'hulking-figure:Brutal':
    'Uma vez por turno, pode causar 1d4 de dano Contundente extra a um alvo que acertar com um Ataque Desarmado.',
  'hulking-figure:Intimidating':
    'Quando faz um teste de Carisma (Intimidação, Atuação ou Persuasão), também pode somar seu modificador de Força à rolagem.',
  'hulking-figure:Powerful':
    'Você conta como um tamanho maior (até no máximo Grande) ao determinar sua capacidade de carga.',

  // iron-gut
  'iron-gut:Ability Score Increase':
    'Aumente Força, Constituição ou Carisma em 1, até o máximo de 20.',
  'iron-gut:Inured to Poison':
    'Você tem Vantagem em salvaguardas que faz para evitar ou encerrar a condição Envenenado.',
  'iron-gut:Everything Looks Delicious':
    'Você tem Vantagem em testes de Sabedoria (Sobrevivência) para forragear comida.',
  'iron-gut:Quick to Recover':
    'Como Ação Bônus, pode gastar um de seus Dados de Vida, rolar o dado e somar seu modificador de Constituição, recuperando Pontos de Vida iguais ao total da rolagem. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Curto ou Longo.',

  // lightning-caster
  'lightning-caster:Ability Score Increase':
    'Aumente Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.',
  'lightning-caster:Dual Target':
    'Quando conjura um truque com tempo de conjuração de uma ação que tem como alvo uma única criatura, pode usar uma Ação Bônus para escolher uma segunda criatura dentro do alcance do truque.',
  'lightning-caster:Immediate Response':
    'Quando conjura uma magia como Reação, essa magia não gasta um espaço de magia. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Longo.',

  // medicianofthe-morbus-doctore
  'medicianofthe-morbus-doctore:Adept Medic':
    'Quando usa o benefício Sangue e Osso do talento Especialista em Triagem, a criatura pode gastar até três Dados de Vida em vez de um.',
  'medicianofthe-morbus-doctore:Battle Surgeon':
    'Quando usa o benefício Sangue e Osso do talento Especialista em Triagem, a criatura pode gastar três Dados de Vida para encerrar uma das seguintes condições em si mesma em vez de recuperar Pontos de Vida: Cego, Surdo, Paralisado, Envenenado ou Atordoado. Alternativamente, pode curar uma Ferida Grave que afete a criatura (consulte Grim Hollow: Guia de Campanha).',

  // nimble-physique
  'nimble-physique:Ability Score Increase':
    'Aumente Força, Destreza ou Constituição em 1, até o máximo de 20.',
  'nimble-physique:Dodgy':
    'Enquanto não estiver usando armadura nem empunhando um Escudo, pode realizar a ação Desviar como Ação Bônus.',
  'nimble-physique:Slippery':
    'Enquanto estiver Agarrado ou Impedido, seus ataques não têm Desvantagem e ataques contra você não têm Vantagem.',

  // sangromantic-initiate
  'sangromantic-initiate:Blood Magic':
    'Escolha uma magia de Sangromancia de qualquer lista de magias de um nível para o qual tenha espaços de magia. Você sempre tem essa magia preparada. Pode conjurá-la uma vez sem gastar um espaço de magia e recupera a capacidade de conjurá-la dessa forma ao terminar um Descanso Longo. Também pode conjurar a magia usando qualquer espaço de magia que tenha.',
  'sangromantic-initiate:Sanguine Potency':
    'Você tem um pool de dois d12 que pode gastar no lugar de Dados de Vida ao conjurar magias de Sangromancia. Seu pool recupera todos os dados gastos ao terminar um Descanso Longo.',

  // shadowsteel-adept
  'shadowsteel-adept:Ability Score Increase':
    'Aumente Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.',
  'shadowsteel-adept:Curse Caster':
    'Você sempre tem maldições de Shadowsteel preparadas e pode conjurá-las com quaisquer espaços de magia que tenha.',
  'shadowsteel-adept:Shadowsteel\u2019s Bite':
    'Enquanto segura seu Foco de Shadowsteel, você ganha +1 em jogadas de ataque com magia e nas CDs de salvaguarda das suas magias.',
  'shadowsteel-adept:Shadowsteel Weapon':
    'Se seu Foco de Shadowsteel também for uma arma, essa arma ganha +1 em jogadas de ataque e de dano.',

  // shadowsteel-master
  'shadowsteel-master:Ability Score Increase':
    'Aumente Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.',
  'shadowsteel-master:Necrotic Harmony':
    'Enquanto segura seu Foco de Shadowsteel, quando conjura uma magia que tem como alvo uma ou mais criaturas e exige uma jogada de ataque ou salvaguarda, pode escolher um alvo que acertou ou que falhou na salvaguarda para também sofrer 1d4 de dano Necrótico para cada nível de espaço de magia gasto para conjurar a magia.',
  'shadowsteel-master:Necrotic Weapon':
    'Se seu Foco de Shadowsteel também for uma arma, essa arma ganha +2 em jogadas de ataque e de dano. Além disso, uma vez em cada um dos seus turnos, quando acerta uma criatura com uma jogada de ataque com arma usando seu Foco de Shadowsteel, pode fazer o alvo sofrer 2d8 de dano Necrótico extra.',

  // syndicate-spy
  'syndicate-spy:Locksmith':
    'Você tem proficiência com Ferramentas de Ladrão. Enquanto segura Ferramentas de Ladrão, pode fabricar uma chave para uma fechadura passando 10 minutos com essa fechadura.',
  'syndicate-spy:Master of Disguise':
    'Você tem proficiência com um Kit de Disfarce. Se passar 10 minutos vestindo um Traje, decide como parece, incluindo altura, peso, traços faciais, som da voz, comprimento do cabelo, coloração e outras características distintivas. Pode parecer membro de outra espécie, embora nenhum de seus valores numéricos mude. Não pode parecer uma criatura de tamanho diferente, e sua forma básica permanece a mesma; se for bípede, por exemplo, não pode usar este benefício para se tornar quadrúpede.',
  'syndicate-spy:Master Calligrapher':
    'Você tem proficiência com um Kit de Falsificação. Não está limitado a 10 palavras ou menos ao imitar a caligrafia de outra pessoa.',
  'syndicate-spy:Blending In':
    'Ao usar a ação Esconder-se para ocultar-se de criaturas que não sejam Hostis a você, precisa estar apenas Levemente Obscurecido e pode usar Carisma em vez de Destreza no teste.',

  // thrown-weapon-master
  'thrown-weapon-master:Ability Score Increase':
    'Aumente Força ou Destreza em 1, até o máximo de 20.',
  'thrown-weapon-master:Multithrow':
    'Depois de realizar a ação Atacar para fazer uma jogada de ataque à distância com uma arma simples que tenha a propriedade Arremesso, pode fazer dois ataques à distância adicionais com armas simples que tenham a propriedade Arremesso como Ação Bônus.',
  'thrown-weapon-master:Quick Hands':
    'Como Ação Bônus, pode pegar, guardar ou empunhar todas as armas simples com a propriedade Arremesso que estejam a até 1,5 m de você. Precisa de uma mão livre para executar essa manobra.',
  'thrown-weapon-master:Returning':
    'Armas simples com a propriedade Arremesso com as quais você tenha proficiência também têm a propriedade Retorno (consulte Capítulo 8: Armas e Equipamento Avançados).',

  // witch-hunter
  'witch-hunter:Ability Score Increase':
    'Aumente Força, Constituição ou Sabedoria em 1, até o máximo de 20.',
  'witch-hunter:Dodge Spells':
    'Pode usar uma Reação para evitar uma magia que tenha apenas você como alvo e não crie uma área de efeito. Faça uma salvaguarda de Sabedoria contra a CD de salvaguarda da magia do conjurador. Em um sucesso, a criatura deve escolher um novo alvo ou a magia é cancelada. Uma magia cancelada se dissipa sem efeito, e quaisquer recursos usados para conjurá-la são desperdiçados.',
  'witch-hunter:Keep Your Enemies Close':
    'Quando acerta com uma jogada de ataque usando uma arma corpo a corpo ou um Ataque Desarmado um alvo que possa conjurar magias, pode reduzir o Deslocamento dele em 4,5 m até o início do seu próximo turno.',
  'witch-hunter:Resist Curses':
    'Você tem Vantagem em salvaguardas contra todas as maldições de Shadowsteel e também contra magias com duração superior a 10 minutos.',

  // advanced-weapon-proficiency
  'advanced-weapon-proficiency:Weapon Proficiency':
    'Você tem proficiência com armas Avançadas e seu treinamento permite usar as propriedades de maestria dessas armas.',
  'advanced-weapon-proficiency:Special':
    'Este talento pode ser escolhido como talento Geral por personagens de nível 8 ou superior.',

  // close-combat-artillerist
  'close-combat-artillerist:Firing in Melee':
    'Estar a até 1,5 m de um inimigo não impõe Desvantagem em suas jogadas de ataque com armas à distância.',
  'close-combat-artillerist:Point Blank':
    'Quando acerta uma criatura que está a até 1,5 m de você com um ataque à distância, ganha +2 na jogada de dano.',

  // dual-shot
  'dual-shot:Dual Shot':
    'Quando realiza a ação Atacar no seu turno e ataca com um arco ou besta, pode fazer um ataque extra como parte da mesma ação contra uma criatura que esteja a até 3 m do alvo original e dentro do alcance da arma. Se o fizer, ambos os ataques são feitos com Desvantagem.',

  // flurry
  'flurry:Quick Strike':
    'Uma vez em cada um dos seus turnos, quando faz uma jogada de ataque com uma arma ou um Ataque Desarmado e tem Vantagem na rolagem, pode renunciar à Vantagem nessa jogada de ataque. Depois de resolver esse ataque, pode fazer outro ataque com a mesma arma ou Ataque Desarmado contra uma criatura diferente. O novo alvo deve estar a até 1,5 m do primeiro alvo e dentro do alcance da arma.',

  // mobile-combatant
  'mobile-combatant:Slippery':
    'Quando realiza a ação Atacar, seu Deslocamento aumenta em 3 m e Ataques de Oportunidade têm Desvantagem contra você até o fim do seu turno.',

  // opportunist
  'opportunist:Exploit Weakness':
    'Sempre que faz um ataque como parte de uma Reação, ganha +2 nas jogadas de ataque e de dano.',

  // prone-defense
  'prone-defense:Defensive':
    'Quando tem a condição Caído, não tem Desvantagem em jogadas de ataque. Jogadas de ataque contra você não têm Vantagem por causa da condição Caído.',
  'prone-defense:Hop Up':
    'Quando tem a condição Caído, pode se levantar usando apenas 1,5 m de deslocamento.',

  // boonofthe-archlich
  'boonofthe-archlich:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-archlich:Vessel of Vitality':
    'Sempre que termina um Descanso Longo, se seu Vaso da Alma não estiver carregado, ele recebe uma alma e fica carregado.',

  // boonofthe-ascended-vampire
  'boonofthe-ascended-vampire:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-ascended-vampire:Inured to Sunlight':
    'Você não é mais afetado pela luz solar.',

  // boonofthe-earthly-tether
  'boonofthe-earthly-tether:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-earthly-tether:Persistent Haunter':
    'Você não é mais afetado pela Falha de Transformação Realidade Desfiada.',
  'boonofthe-earthly-tether:Divergent Growth':
    'Escolha uma Dádiva de Transformação Espectro que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.',

  // boonofthe-elder-horror
  'boonofthe-elder-horror:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-elder-horror:Stabilizing Form':
    'Quando rolar 25 ou menos na tabela Forma Instável, pode rolar novamente. Deve usar o novo resultado. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Longo.',
  'boonofthe-elder-horror:Divergent Growth':
    'Escolha uma Dádiva de Transformação Horror Aberrante que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.',

  // boonofthe-elder-fey
  'boonofthe-elder-fey:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-elder-fey:Fey Bulwark':
    'Você não é mais afetado pela Falha de Transformação Constituição Enfraquecida.',
  'boonofthe-elder-fey:Divergent Growth':
    'Escolha uma Dádiva de Transformação Fey que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.',

  // boonofthe-elder-fiend
  'boonofthe-elder-fiend:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-elder-fiend:Free Agent':
    'Você não é mais afetado pela Falha de Transformação Puxão do Submundo.',
  'boonofthe-elder-fiend:Divergent Growth':
    'Escolha uma Dádiva de Transformação Diabo que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.',

  // boonofthe-elemental-temperance
  'boonofthe-elemental-temperance:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-elemental-temperance:Controlled Chaos':
    'Você não é mais afetado pela Falha de Transformação Caos Primordial.',

  // boonofthe-high-seraph
  'boonofthe-high-seraph:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-high-seraph:Absolution':
    'Você não é mais afetado pela Falha de Transformação Corrupção Serafim.',
  'boonofthe-high-seraph:Divergent Growth':
    'Escolha uma Dádiva de Transformação Serafim que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.',

  // boonof-magic-resistance
  'boonof-magic-resistance:Ability Score Increase':
    'Aumente Inteligência ou Sabedoria em 1, até o máximo de 30.',
  'boonof-magic-resistance:Heroic Resistance':
    'Se falhar em uma salvaguarda, pode fazer com que tenha sucesso em vez disso. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Curto ou Longo.',

  // boonof-perfect-flight
  'boonof-perfect-flight:Ability Score Increase':
    'Aumente Força ou Destreza em 1, até o máximo de 30.',
  'boonof-perfect-flight:Flying':
    'Você tem Deslocamento de Voo de 12 m e pode pairar.',
  'boonof-perfect-flight:Graceful Fall':
    'Se cair mais de 1,5 m, sua taxa de queda desacelera para 18 m por rodada até pousar.',

  // boonof-shadowsteel-mastery
  'boonof-shadowsteel-mastery:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonof-shadowsteel-mastery:Strange Bedfellows':
    'Você não é mais afetado pela Falha de Transformação Solitária.',

  // boonofthe-wilds
  'boonofthe-wilds:Ability Score Increase':
    'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
  'boonofthe-wilds:Apex Predator':
    'Quando entra em sua Forma Híbrida, ganha 25 Pontos de Vida Temporários. No fim de cada um dos seus turnos enquanto estiver em Forma Híbrida, se não tiver Pontos de Vida Temporários, ganha 10 Pontos de Vida Temporários. Enquanto estiver em Forma Híbrida e não tiver Pontos de Vida Temporários, tem Vantagem em jogadas de ataque.',
};
