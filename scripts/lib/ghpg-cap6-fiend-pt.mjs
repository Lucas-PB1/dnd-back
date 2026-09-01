/** PT curado — Transformação Corruptor (gh-transformation-fiend). Chave: anchorId do extract. */
export const FIEND_BENEFIT_PT = {
  FiendStage1: {
    description:
      'Quando você passa pela Transformação em Corruptor pela primeira vez, ganha a Bênção Alma Corruptora e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.',
  },
  Stage1BoonFiendishSoul: {
    name: 'Bênção do estágio 1: Alma Corruptora',
    description:
      'Você torna-se um Corruptor além de qualquer outro tipo de criatura que tenha. Você tem Vantagem em testes de Carisma (Enganação).\n\nAlém disso, escolha um dos seguintes tipos de dano e ganhe Resistência a ele: Ácido, Gélido ou Fogo.',
  },
  Stage1BoonDevilishContractor: {
    name: 'Bênção do estágio 1: Contratante Diabólico',
    description:
      'Você adquiriu a capacidade de vincular criaturas mortais à sua vontade. Pode criar um contrato para prender a alma de um Humanoide mortal a você, alimentando-se de seu poder. O mortal recebe um presente pedido no contrato, e você ganha uma Dádiva da Perdição de sua escolha. (Consulte Dádivas da Perdição ao final desta Transformação.)\n\nPara prender a alma de um mortal, primeiro deve elaborar um contrato para o presente desejado. Um contrato exige tinta e papel mágicos no valor de 10 PO por Estágio de Transformação que você adquiriu.\n\nVocê e o mortal devem assinar o contrato de livre vontade, plenamente cientes dos custos. Uma vez assinado, entidades demoníacas concedem a você uma Dádiva da Perdição, e o mortal recebe seus desejos em até 7 dias. Você não precisa fornecer essa bênção pessoalmente.\n\nPor exemplo, ao assinar um contrato por uma Dádiva da Glória Irrestrita, você recebe os benefícios listados para essa dádiva. O mortal que assina recebe seu desejo declarado, providenciado pelos poderes duvidosos do Submundo. Você não pode se beneficiar diretamente do presente desejado pelo mortal, nem um aliado. Nenhum aliado seu pode jamais assinar um contrato com você.\n\nVocê pode escolher uma Dádiva da Perdição do estágio que alcançou ou inferior. Por exemplo, se está no estágio 2 da Transformação, só pode escolher uma Dádiva da Perdição de estágio 1 ou 2.\n\nNão há limite para o número de contratos que pode firmar, mas só pode ter uma Dádiva da Perdição ativa por vez. Quando ganharia uma segunda Dádiva da Perdição, pode substituir a ativa pela nova. Além disso, ao terminar um Descanso Longo, pode trocar sua Dádiva da Perdição ativa por qualquer outra dádiva associada a um contrato assinado.',
  },
  Stage1BoonInfernalSmite: {
    name: 'Bênção do estágio 1: Punição Infernal',
    description:
      'Uma vez em cada um dos seus turnos, pode escolher uma criatura que acabou de ferir com um ataque com arma, um Ataque Desarmado ou um truque. Cause 1d6 de dano extra de Ácido, Gélido ou Fogo a essa criatura, usando o mesmo tipo de dano escolhido para Alma Corruptora. Pode adicionar esse dano um número de vezes igual ao seu Bônus de Proficiência mais seu Estágio de Transformação, mas não mais de uma vez por jogada de dano. Recupera todos os usos ao terminar um Descanso Curto ou Descanso Longo.\n\nEm Estágios de Transformação mais altos, causa 1d6 de dano adicional por Estágio de Transformação, totalizando 2d6 no estágio 2, 3d6 no estágio 3 e 4d6 no estágio 4.',
  },
  Stage1FlawFiendBound: {
    name: 'Falha do estágio 1: Vinculado ao Submundo',
    description:
      'Seu corpo e alma estão presos ao Submundo. Você tem Desvantagem em Salvaguardas contra a Morte enquanto o plano tenta puxá-lo para dentro dele.',
  },
  FiendStage2: {
    description:
      'Quando você alcança o estágio 2 da Transformação em Corruptor, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.',
  },
  AchievingANewStage2: {
    description:
      'Para avançar de um estágio para o próximo nesta Transformação, deve ocorrer um evento ou outra ocorrência notável ligada à história do personagem. Os eventos a seguir são sugestões que podem desencadear a passagem ao próximo estágio da Transformação:',
  },
  Stage2BoonDaemonicBrand: {
    name: 'Bênção do estágio 2: Marca Demoníaca',
    description:
      'Como Ação Bônus no seu turno, pode marcar com um sinal ardente uma criatura a até 18 m de você que possa ver; a marca permanece por 1 minuto. Se o alvo passar em uma salvaguarda de Sabedoria, não é marcado. A CD da salvaguarda é 8 + seu Bônus de Proficiência + seu Estágio de Transformação.\n\nSe a criatura falhar na salvaguarda, escolhe um dos efeitos a seguir, que dura pela duração:\n\n• A criatura sofre –2 em todas as salvaguardas.\n• O primeiro ataque contra a criatura em cada turno é feito com Vantagem.\n• A criatura não pode recuperar Pontos de Vida.\n\nPode usar essa habilidade um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  },
  Stage2BoonEnhancedContract: {
    name: 'Bênção do estágio 2: Contrato Aprimorado',
    description:
      'Pode alternar entre sua Dádiva da Perdição ativa ao fim de um Descanso Curto ou Descanso Longo. Além disso, ao trocar de Dádivas da Perdição, ganha Pontos de Vida Temporários iguais a 5 vezes seu Estágio de Transformação.',
  },
  Stage2FlawFiendForm: {
    name: 'Falha do estágio 2: Forma de Corruptor',
    description:
      'Sua aparência transformou-se grotescamente. Sua pele fica vermelha e coriácea, e chifres, dentes e garras ferozes rompem a superfície da pele. Pode suprimir essa forma e apresentar a aparência do humanoide que um dia foi, mas isso é exaustivo e exige esforço. Momentos de estresse provavelmente revelarão sua verdadeira natureza. Nas situações a seguir, sua forma verdadeira pode ser revelada:\n\n• Ficar Ferido.\n• Concentração em uma magia.\n• Receber a condição Inconsciente.\n• Entrar em terreno sagrado.\n• Entrar na presença de Celestiais ou outros Corruptores.\n• Escolher revelar-se voluntariamente.\n\nNesses eventos, ou em momentos de estresse emocional ou físico extremo, o Mestre pode exigir uma salvaguarda de Constituição com CD baseada no seu Estágio de Transformação atual (estágio 2: CD 13; estágio 3: CD 16; estágio 4: CD 20). Se falhar, sua Aparência Horrível é revelada.\n\nCriaturas não malignas que testemunharem sua forma verdadeira tornam-se instantaneamente Hostis a você, salvo decisão contrária do Mestre.',
  },
  FiendStage3: {
    description:
      'Quando você alcança o estágio 3 da Transformação em Corruptor, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.',
  },
  Stage3BoonDevilishSubcontractor: {
    name: 'Bênção do estágio 3: Subcontratante Diabólico',
    description:
      'Pode receber os benefícios de duas Dádivas da Perdição ao mesmo tempo. Ainda pode trocar apenas uma Dádiva da Perdição após um Descanso Curto ou Descanso Longo.',
  },
  Stage3BoonOverwhelmingBrand: {
    name: 'Bênção do estágio 3: Marca Avassaladora',
    description:
      'Pode aplicar um dos efeitos adicionais a seguir a uma criatura sob o efeito da sua Marca Demoníaca:\n\n• A Velocidade da criatura é reduzida à metade, e você pode mover a criatura até 3 m horizontalmente no seu turno (não exige ação).\n• A criatura tem a condição Cego. No seu turno, pode escolher remover essa condição (não exige ação).',
  },
  Stage3FlawPullOfTheNetherworld: {
    name: 'Falha do estágio 3: Puxão do Submundo',
    description:
      'Seu novo plano natal tenta puxá-lo para si, reivindicando sua forma. Sempre que rolar 1 natural em um Teste D20, sofre 6d6 de dano Psíquico enquanto os habitantes do plano infernal tentam desvincular sua alma do Plano Material. Esse dano só pode ser sofrido uma vez por Descanso Curto e ignora todas as Resistências e Imunidades. Se esse dano reduzir seus Pontos de Vida a 0, você morre e sua alma é levada imediatamente ao Submundo. Só pode ser trazido de volta à vida por magias de 7º nível ou superior.',
  },
  FiendStage4: {
    description:
      'Quando você alcança o estágio 4 da Transformação em Corruptor, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.',
  },
  Stage4BoonAbyssalResistance: {
    name: 'Bênção do estágio 4: Resistência Abissal',
    description:
      'Você ganha Imunidade ao tipo de dano escolhido para Alma Corruptora e Resistência aos outros dois tipos. Além disso, tem Resistência a dano de ataques com armas não mágicas ou Ataques Desarmados.',
  },
  Stage4BoonInfernalSummons: {
    name: 'Bênção do estágio 4: Convocação Infernal',
    description:
      'Como ação Mágica, pode abrir um portal para o Submundo e convocar até quatro Corruptores de ND 4 ou menos a até 9 m de você. Os Corruptores permanecem por 1 minuto antes de desaparecer de volta ao Submundo. (O Mestre decide quais Corruptores respondem à convocação.)\n\nOs Corruptores convocados são Aliados a você e seus companheiros. Agem imediatamente depois de você na ordem de iniciativa. Obedecem a quaisquer comandos verbais que você lhes der (não exige ação sua). Se não emitir comandos, usam a ação Esquivar no turno deles e não fazem outro movimento, Ações Bônus ou Reações, a não ser para se proteger.',
  },
  Stage4BoonUltimateBrand: {
    name: 'Bênção do estágio 4: Marca Suprema',
    description:
      'Quando uma criatura afetada pela sua Marca Demoníaca inicia o turno, pode usar uma Reação para ditar seu movimento e a ação que realiza. Se o fizer, a criatura repete a salvaguarda de Sabedoria inicial ao fim do turno. Em caso de sucesso, você não pode usar essa Reação novamente enquanto a marca durar.',
  },
  Stage4FlawTrueName: {
    name: 'Falha do estágio 4: Nome Verdadeiro',
    description:
      'Sua transformação em Corruptor está completa e você renasce. Os habitantes do Submundo atribuem a você um novo nome, que se torna seu Nome Verdadeiro. Você recebe um talismã de enxofre e latão com seu nome verdadeiro inscrito em Infernal.\n\nUma criatura com ND 10 ou superior a até 3 m de você que conheça seu Nome Verdadeiro pode usar uma ação Mágica e pronunciar seu Nome Verdadeiro. Você deve passar em uma salvaguarda de Carisma CD 20 ou sofrer os efeitos a seguir por 1 minuto. Pode tentar uma salvaguarda de Carisma ao fim de cada um dos seus turnos para encerrar os efeitos:\n\n• Você tem a condição Encantado, mesmo que seja Imune a ser Encantado.\n• Como Ação Bônus, a entidade que pronunciou seu Nome Verdadeiro pode forçá-lo a se mover até sua Velocidade e usar sua ação para atacar com uma arma, usar Ataque Desarmado ou lançar um truque contra um alvo de sua escolha.\n• Todos os ataques contra você têm Vantagem, e você tem Desvantagem em salvaguardas.\n• Você não pode recuperar Pontos de Vida nem ter Pontos de Vida Temporários. Perde imediatamente quaisquer Pontos de Vida Temporários que tenha.',
  },
};
