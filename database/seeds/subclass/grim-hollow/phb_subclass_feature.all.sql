-- Grim Hollow Cap. 2 — subclass features
-- Fonte: docs/source/extracts/grim-hollow/cap2-subclasses-en.json
-- Overlay PT: docs/source/extracts/grim-hollow/cap2-features-pt.json

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  3,
  'Preparado para a Batalha',
  'Você ganha treinamento com armadura pesada.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  3,
  'Corpo a Corpo',
  'Sua habilidade em combate próximo permite golpes devastadores enquanto desequilibra o oponente. Quando você acerta uma criatura com uma jogada de ataque usando uma arma corpo a corpo, pode gastar uma Reação para causar 2d6 de dano extra do mesmo tipo causado pela arma. Essa criatura tem Desvantagem na próxima jogada de ataque dela antes do início do seu próximo turno. O dano se torna 4d6 quando você alcança o 11º nível de Caçador de Monstros.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  7,
  'Determinação Inabalável',
  'Você tem Vantagem em salvaguardas que fizer para evitar ou terminar a condição Amedrontado, e é imune à condição Amedrontado causada por tipos de criatura no seu Grimório de Monstros. Além disso, quando acerta uma criatura com um ataque como parte de uma Reação, pode escolher uma criatura Amedrontada a até 18 m que possa vê-lo (incluindo você). A condição termina nessa criatura.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  10,
  'Aterrorizar os Terrores',
  'Sua reputação é tal que monstros que se alimentam do medo passaram a temê-lo. Quando você acerta uma criatura com um ataque como parte de uma Reação, pode forçá-la a fazer uma salvaguarda de Sabedoria ou ficar com a condição Amedrontado até o fim do seu próximo turno. A CD da salvaguarda é 8 + seu modificador de Inteligência + seu Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  15,
  'Redirecionamento Mortal',
  'Seus golpes ficaram ainda mais letais. O dano extra de Corpo a Corpo aumenta para 6d6. Além disso, se você causar dano a uma criatura com Corpo a Corpo, o alvo tem Desvantagem em todas as jogadas de ataque até o fim do seu próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  18,
  'Passos Controlados',
  'Você é um combatente tão eficaz que permanece sempre no controle e nunca desequilibrado. Você pode realizar uma Reação duas vezes em uma rodada, em vez de uma.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  3,
  'Gastronomia Alquímica',
  'Você ganha proficiência com Suprimentos de Alquimista e Utensílios de Cozinheiro.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  3,
  'Metabolismo Transmutador',
  'Você ganha a capacidade de consumir restos de monstros, o que faz seu corpo adotar mutações poderosas e assustadoras. Elas aparecem na seção “Mutações” mais adiante na descrição da subclasse.

Salvando Porções. Como ação Utilizar, você pode colher uma única porção dos restos físicos de uma criatura. Só uma porção pode ser colhida de cada criatura. Anote o tipo de criatura do monstro. Uma porção colhida dura até você terminar um Descanso Longo, quando perde a potência.

Consumindo Porções. Como Ação Bônus, você pode consumir uma porção. Depois de consumi-la, escolhe uma mutação para ganhar, conforme o tipo da criatura. Você pode obter os benefícios de porções consumidas um número de vezes até 1 + seu modificador de Inteligência (mínimo 1). Quando termina um Descanso Longo, recupera a capacidade de consumir porções. Você pode se beneficiar de várias porções ao mesmo tempo, mas não pode ganhar a mesma mutação mais de uma vez simultaneamente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  7,
  'Resposta Sincronizada',
  'A ingestão de monstros aprofunda sua compreensão deles e do comportamento deles. Você ganha este efeito adicional quando consome uma porção de monstro: por 1 minuto, quando faz um ataque como parte de uma Reação, causa 1d6 de dano extra. Esse dano é do mesmo tipo da arma ou do Ataque Desarmado usado no ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  10,
  'Fome Roedora',
  'Sua fome pelo inimigo permite absorver a essência dele em combate. Quando você causa dano a uma criatura com um ataque corpo a corpo usando uma arma ou Ataque Desarmado, ganha Pontos de Vida Temporários iguais à metade do dano causado. Se o alvo for um tipo de criatura no seu Grimório de Monstros, em vez disso você ganha Pontos de Vida Temporários iguais ao dano causado. Você pode usar este recurso um número de vezes igual ao seu modificador de Inteligência (mínimo 1). Você recupera todos os usos gastos ao terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  15,
  'Decocções Alquímicas',
  'Você pode gastar 1 hora e 20 PO em ingredientes alquímicos (como ervas especiais ou salvamento de monstro) para usar seus Suprimentos de Alquimista e converter uma porção de monstro em uma decocção. Uma decocção é uma poção mágica que concede os benefícios de uma porção de monstro consumida. Você pode ter 4 decocções não consumidas ativas. Você pode destruir uma decocção como ação Utilizar. Uma criatura que não seja você pode consumir 1 decocção sem efeitos adversos. Uma criatura ganha 1 nível de Exaustão por cada decocção que consumir após a primeira. A criatura deve terminar um Descanso Longo antes de recuperar a capacidade de consumir uma decocção com segurança.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  18,
  'Paladar Adquirido',
  'Sua fome por porções de monstro tornou-se insaciável. Agora você pode consumir 1 porção adicional com segurança. Além disso, por 1 minuto ao consumir uma porção, você tem Vantagem nas jogadas de ataque feitas como parte de uma Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  3,
  'Acólito do Oculto',
  'Você ganha proficiência na perícia Arcanismo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  3,
  'Conjuração',
  'Seu estudo do oculto concede a capacidade de conjurar magias.

Truques. Você aprende dois truques de sua escolha da lista de magias de Mago. Sempre que ganha um nível de Caçador de Monstros, pode substituir um desses truques por outro de sua escolha da lista de magias de Mago. Quando alcança o 10º nível de Caçador de Monstros, aprende outro truque de Mago de sua escolha.

Espaços de Magia. A tabela Conjuração do Ocultista mostra quantos espaços de magia você tem para conjurar magias de 1º círculo ou superior. Você recupera todos os espaços gastos ao terminar um Descanso Longo.

Magias Preparadas de 1º+. Você prepara a lista de magias de 1º círculo ou superior disponíveis para conjurar com este recurso. Para começar, escolha três magias de Mago de 1º círculo. Mãos Flamejantes, Detectar Magia e Proteção contra o Bem e o Mal são recomendadas. O número de magias na lista aumenta conforme você sobe de nível de Caçador de Monstros, como na coluna Magias Preparadas da tabela. Sempre que esse número aumenta, escolha magias adicionais da lista de Mago até o número coincidir. As magias escolhidas devem ser de um círculo para o qual você tenha espaços. Por exemplo, se você for um Caçador de Monstros de 7º nível, sua lista pode incluir cinco magias de Mago de 1º e 2º círculos em qualquer combinação.

Mudando Magias Preparadas. Sempre que ganha um nível de Caçador de Monstros, pode substituir uma magia da lista por outra magia de Mago.

Habilidade de Conjuração. Inteligência é sua habilidade de conjuração para suas magias de Mago.

Foco de Conjuração. Você pode usar um Foco Arcano como Foco de Conjuração para suas magias de Mago.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  3,
  'Interferência Arcana',
  'Você tem Vantagem em salvaguardas contra magias conjuradas por tipos de criatura no seu Grimório de Monstros. Além disso, quando uma criatura que você possa ver a até 18 m conjura uma magia ou faz um ataque de magia, você pode usar Resposta Estudada contra essa criatura antes da magia ser conjurada.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  7,
  'Caçador de Magos',
  'Você considera Humanoides capazes de conjurar magias como um tipo de criatura no seu Grimório de Monstros. Além disso, quando causa dano a um tipo de criatura no seu Grimório de Monstros que esteja se concentrando, ela tem Desvantagem na salvaguarda para manter a Concentração.

“Digam o que quiserem sobre os métodos. Os resultados falam por si.” —Inquisidor Arcanista'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  10,
  'Conhecimento Oculto',
  'Seu conhecimento de magia aumenta a ponto de você aprender a conjurar Rituais. Você pode conjurar qualquer magia como Ritual se ela tiver a etiqueta Ritual e estiver preparada. Além disso, aprende duas magias de sua escolha. Elas podem vir das listas de Clérigo, Druida ou Mago, ou qualquer combinação (veja a seção da classe para a lista). Uma magia escolhida deve ter a etiqueta Ritual. Quando alcança o 14º nível de Caçador de Monstros, pode substituir uma das magias que conhece por este recurso por outra magia de qualquer lista. A nova magia deve ter a etiqueta Ritual.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  15,
  'Égide Mágica',
  'Você ganha a capacidade de estender um encanto protetor. Você irradia uma aura invisível em uma Emanação de 6 m originada de você. A aura fica inativa enquanto você tiver a condição Incapacitado. Você e aliados na aura têm Vantagem em salvaguardas contra magias conjuradas por tipos de criatura no seu Grimório de Monstros. Além disso, você sempre tem a magia Contramagía preparada. Você pode conjurar Contramagía uma vez sem gastar um espaço de magia. Depois de conjurá-la assim, não pode fazê-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  18,
  'Resposta Arcana',
  'Você aprendeu a antecipar inimigos o bastante para conjurar magias rapidamente em resposta aos ataques deles. Quando usa Resposta Estudada, pode conjurar uma magia. A magia deve ter tempo de conjuração de uma ação e deve ter como alvo apenas aquela criatura.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  3,
  'Furtivo e Astuto',
  'Você ganha proficiência na perícia Furtividade e com Ferramentas de Funileiro.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  3,
  'Engenhocas de Armadilheiro',
  'Você aprende a criar engenhocas e mecanismos que ajudam na caçada. Como parte de um Descanso Longo, pode fabricar duas Engenhocas de Armadilheiro se tiver materiais e Ferramentas de Funileiro à mão. Também, com 1 hora de trabalho com esse kit e gastando 20 PO em materiais (como equipamento ou salvamento de monstro), pode criar uma Engenhoca de Armadilheiro da lista abaixo.

Algumas Engenhocas permitem que o alvo faça um teste de atributo ou salvaguarda para resistir aos efeitos. A CD da salvaguarda é: CD das Engenhocas = 8 + seu modificador de Inteligência + seu Bônus de Proficiência.

As Engenhocas estão listadas em ordem alfabética.

Veneno do Pavor. Óleo de lâmina de cheiro nauseabundo que faz feridas hemorragiarem e recusarem cura. Pode revestir uma arma Cortante ou Perfurante ou até 10 peças de munição Cortante ou Perfurante. Aplicar o óleo leva 1 minuto e o óleo dura 8 horas após aplicado. Quando uma criatura sofre dano do item envenenado, não pode recuperar Pontos de Vida até terminar um Descanso Curto ou Longo.

Munição Elemental. A ponta de uma flecha ou virote é impregnada de veneno, carregada com um frasco de ácido, mergulhada em óleo inflamável ou revestida com outra substância. Como Ação Bônus, você imbuem poder elemental em uma única peça de munição que possa ser disparada de Arco Longo, Arco Curto ou Besta como parte de uma ação Atacar. Ao imbuir, escolha um tipo de dano: Ácido, Gélido, Ígneo, Elétrico, Veneno ou Trovejante. Quando uma criatura sofre dano da Munição Elemental, sofre 2d6 adicionais do tipo escolhido. A munição descarrega a energia se acertar e não pode ser recuperada. Se o ataque errar, pode ser recuperada e usada de novo. Retém o poder por 48 horas.

Bomba Rúnica. Usada para caçar criaturas resistentes a armas mundanas. Como Ação Bônus, você pode arremessar a bomba rúnica em um ponto a até 18 m que possa ver, criando uma Esfera de 6 m de raio centrada nesse ponto. A Esfera se espalha pelos cantos e sua área fica Levemente Obscurecida. Dura 1 minuto ou até um vento forte (como o de Rajada de Vento) dispersá-la. Sempre que dano Contundente, Perfurante ou Cortante for causado a uma criatura dentro da esfera, esse dano é de Força em vez do tipo normal. A Bomba Rúnica é destruída após um uso.

Âncora Escorpião. Destinada a prender inimigos voadores ao chão ou impedir a fuga de monstros. Pode ser disparada de Arco Longo, Arco Curto ou Besta como parte de uma ação Atacar. Quando você acerta uma criatura com uma jogada de ataque usando uma Âncora Escorpião, ela fica com a condição Contido. Uma criatura Contida pela Âncora pode gastar uma ação para fazer um teste de Força (Atletismo) contra a CD das Engenhocas. Em sucesso, deixa de estar Contida. A Âncora é destruída depois que a criatura Contida escapa ou morre.

Manto do Terreno. Feito de materiais locais, permite ocultar-se no ambiente. Pode ser vestido sobre armadura Leve ou Média e é vestido/removido com a velocidade de armadura Leve. Criaturas têm Desvantagem em testes de Sabedoria (Percepção) para vê-lo. O item dura até você terminar um Descanso Longo, quando se desfaz.

Armadilha Homem-Lobo. Detona quando o exterior frágil é quebrado. Você pode gastar uma ação Utilizar para armá-la em um espaço desocupado a até 1,5 m de você. Uma criatura a até 9 m deve ser bem-sucedida em um teste de Sabedoria (Percepção) contra a CD das Engenhocas para notar a armadilha. Criaturas têm Desvantagem nesse teste. Uma criatura que entre no espaço contendo a armadilha a aciona e faz uma salvaguarda de Destreza. Em falha, sofre 3d10 de dano Contundente e fica com a condição Caído. Em sucesso, sofre apenas metade do dano. A Armadilha Homem-Lobo também pode ser usada como arma Leve à Distância com as propriedades Acuidade e Arremesso. Alcance normal 6 m e longo 18 m. Em um acerto, causa 3d10 Contundente e o alvo fica Caído. É destruída após ser acionada ou arremessada, independentemente de acertar ou errar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  7,
  'Vantagem do Emboscador',
  'Você se tornou um emboscador feroz. Ao rolar Iniciativa, pode somar seu modificador de Inteligência à rolagem. Além disso, não pode ser Surpreso por inimigos que incluam tipos de criatura no seu Grimório de Monstros.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  10,
  'Resposta Ágil',
  'Você pode saltar para o lado e evitar inimigos que avancem. Quando uma criatura faz uma jogada de ataque corpo a corpo contra você, pode gastar uma Reação para impor Desvantagem nessa rolagem e usar Resposta Estudada como parte da mesma Reação. Quer o ataque acerte ou erre, você pode então se mover até metade do seu Deslocamento. Esse movimento não provoca Ataque de Oportunidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  15,
  'Armadura de Pele de Monstro',
  'Você aprendeu a fabricar um conjunto de armadura Leve ou Média usando escamas de dragão, pele de lobisomem, couro de troll ou componente semelhante de monstro. A armadura assume a aparência de sua escolha, refletindo o componente. Tem as mesmas propriedades de armadura Leve ou Média (sua escolha na fabricação) e ganha duas modificações da lista Modificações de Armadura. Sempre que ganha um nível de Caçador de Monstros, pode substituir uma dessas modificações por outra. As modificações exigem que a armadura esteja vestida para funcionar.

Modificações de Armadura (ordem alfabética):

Resistência a Dano. A pele usada concede resistências. Você ganha Resistência a dois dos seguintes tipos de dano de sua escolha: Ácido, Gélido, Ígneo, Elétrico, Veneno ou Trovejante.

Carga Elemental. Você embute uma gema de Constructo ou infunde poder de Elemental. Escolha um tipo: Ácido, Gélido, Ígneo, Elétrico, Veneno ou Trovejante. Quando acerta uma criatura com um ataque, pode fazer com que cause o tipo escolhido em vez do normal, e o ataque causa 1d6 extra desse tipo.

Defesa Endurecida. Escamas endurecidas ou peles mágicas dificultam a penetração. Enquanto vestir a armadura fabricada, você ganha +2 na Classe de Armadura.

Salto de Fase. Você polvilhou a armadura com pó feérico ou costurou pele de monstruosidade que muda de fase. Como Ação Bônus, teleporta-se até 18 m para um espaço desocupado que possa ver. Pode usar este recurso três vezes e recupera todos os usos ao terminar um Descanso Longo.

Regeneração. Você reforça a armadura com pele de troll ou a embebe em sangue de vampiro. Você tem um pool de seis d10. Como Ação Bônus, pode gastar um dado do pool, rolá-lo, somar seu modificador de Constituição e recuperar Pontos de Vida iguais ao total. Recupera todos os dados gastos ao terminar um Descanso Longo.

Furtiva. A armadura é coberta por manto sombrio ou feita de pele leve como pena. Não impõe Desvantagem em testes de Destreza (Furtividade), mesmo que normalmente o fizesse. Enquanto a vestir, criaturas têm Desvantagem em testes de Sabedoria (Percepção) para vê-lo, e você tem Vantagem em testes de Sabedoria (Percepção) para notar criaturas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  18,
  'Engenho Rápido',
  'Você passou a fabricar ferramentas de armadilheiro bem mais rápido. Pode gastar 1 minuto para criar uma Engenhoca de Armadilheiro sem gastar PO nem componentes. Pode usar este recurso duas vezes e recupera todos os usos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  3,
  'Rosto da Fúria',
  'Quando ativa a Fúria, seu semblante se distorce e o corpo incha. Criaturas que não testemunharam sua transformação — agora ou antes — não o reconhecem. Além disso, enquanto a Fúria estiver ativa, você ganha os seguintes benefícios: pode rolar 1d8 no lugar do dano normal do Ataque Desarmado e, sempre que causar dano com Ataque Desarmado, pode escolher dano de Força ou o tipo normal; quando acerta uma criatura com Ataque Desarmado, pode empurrá-la 3 m ou forçá-la a fazer salvaguarda de Constituição (CD 8 + modificador de Força + Bônus de Proficiência) — em falha, fica Caído; você conta como um tamanho maior ao determinar sucesso ou falha de Agarrar, e ao fazer Ataque Desarmado seu alcance é 1,5 m maior que o normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  3,
  'Máscara de Civilidade',
  'Você é proficiente em uma das seguintes perícias de sua escolha: Arcanismo, História, Investigação, Medicina, Natureza, Persuasão ou Religião. Além disso, ganha proficiência com um tipo de Ferramentas de Artesão de sua escolha ou conhece um idioma de sua escolha.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  6,
  'Cérebro e Músculo',
  'Enquanto a Fúria não estiver ativa, você tem Resistência a dano Psíquico. Enquanto a Fúria estiver ativa, tem Resistência a todos os tipos de dano exceto Força e Psíquico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  10,
  'Astúcia e Brutalidade',
  'Enquanto a Fúria não estiver ativa, você pode realizar a ação Desengajar ou Ajudar como Ação Bônus. Enquanto a Fúria estiver ativa, suas jogadas de ataque com Ataques Desarmados marcam Acerto Crítico em 19 ou 20 no d20.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  14,
  'Melhor Metade',
  'Quando você é reduzido a 0 Pontos de Vida e não é morto na hora, pode cair para 1 Ponto de Vida em vez disso e ganha Pontos de Vida Temporários iguais à metade do seu máximo de Pontos de Vida. Além disso, se a Fúria estiver ativa, ela termina. Se a Fúria não estiver ativa, você a ativa imediatamente (mesmo sem usos restantes). Se algum desses Pontos de Vida Temporários restar após 1 minuto, eles desaparecem. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  3,
  'Companheiro Primordial',
  'Você invoca magicamente um espírito primordial que assume a forma de uma fera e o acompanha. Escolha o bloco de estatísticas: Guardião Primordial ou Atacante Primordial. Além disso, escolha um ambiente que modifica o bloco: Terra, Mar ou Céu. Determine também o tipo de animal, adequado ao bloco. Qualquer que seja, ele exibe marcas eldritch indicando origem sobrenatural. O companheiro é Aliado a você e aos seus aliados e obedece a seus comandos. Desaparece se você morrer.

A Fera em Combate. Em combate, o companheiro age durante o seu turno. Pode se mover e usar a Reação por conta própria, mas a única ação que realiza é Esquivar, a menos que você gaste uma Ação Bônus para ordenar uma ação do bloco ou outra ação. Você também pode sacrificar um dos seus ataques ao realizar a ação Atacar para ordenar à fera a ação Golpe da Fera. Se você tiver a condição Incapacitado, o companheiro age sozinho e não fica limitado a Esquivar.

Restaurando ou Substituindo a Fera. Se o companheiro morreu na última hora, você pode gastar uma ação Mágica para tocá-lo e gastar um uso de Fúria. O companheiro volta à vida imediatamente com todos os Pontos de Vida restaurados. Sempre que terminar um Descanso Longo, pode invocar um companheiro primordial diferente, que aparece em um espaço desocupado a até 1,5 m de você. Você escolhe o bloco e a aparência. Se já tiver uma fera deste recurso, a antiga desaparece quando a nova aparece.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  3,
  'Fúria Compartilhada',
  'Enquanto a Fúria estiver ativa, seu companheiro primordial tem Resistência a dano Contundente, Perfurante e Cortante.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  6,
  'Parentesco com Feras',
  'Você sempre tem as magias Amizade Animal e Falar com Animais preparadas. Pode conjurar cada uma sem gastar espaço de magia. Depois de conjurar uma delas assim, não pode conjurá-la desse modo de novo até terminar um Descanso Curto ou Longo. Também pode conjurá-las usando espaços de magia do círculo apropriado. Constituição é sua habilidade de conjuração para elas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  10,
  'Transe do Cavaleiro da Pele',
  'Você gasta uma ação Mágica para entrar em transe e escolhe seu companheiro primordial ou uma Fera atualmente sob efeito de Amizade Animal a até 18 m de você. Pela duração do transe, você possui a criatura escolhida. Uma vez no corpo, você o controla. Seus Pontos de Vida, Dados de Vida, Força, Destreza, Constituição, Deslocamento e sentidos são substituídos pelos da criatura. Você mantém o restante das estatísticas. A posse termina se você optar por sair do transe (sem ação), se a Fera for reduzida a 0 Pontos de Vida, ou se você e a Fera estiverem em planos diferentes. Enquanto estiver em transe, seu corpo cai em estado catatônico: não pode se mover nem usar Reações e não percebe o entorno. Pode permanecer no transe por um número de horas até a metade do seu nível de Bárbaro + modificador de Constituição. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo. Também pode restaurar o uso gastando um uso de Fúria (sem ação).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  14,
  'Forma do Selvagem',
  'Como Ação Bônus, você pode escolher uma nova forma para o companheiro primordial, fazendo-o se transformar instantaneamente. Quando faz isso, os Pontos de Vida atuais dele passam a ser o novo máximo de Pontos de Vida. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Curto ou Longo. Também pode restaurar o uso gastando um uso de Fúria (sem ação).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  3,
  'Fúria dos Mortos',
  'Sua Fúria canaliza a fúria sem fim dos mortos inquietos. Enquanto a Fúria estiver ativa, você assume aspectos de espíritos inquietos e ganha os seguintes benefícios.

Forma Sombria. Você ignora Terreno Difícil. Além disso, pode se mover pelo espaço de qualquer criatura, mas não pode terminar o movimento em um espaço ocupado.

Esquiva Sombria. Seu Deslocamento aumenta em 3 m, e Ataques de Oportunidade contra você têm Desvantagem.

Visão Espectral. Você vê criaturas e objetos a até 36 m com a condição Invisível como se fossem visíveis, e pode ver no Plano Etéreo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  3,
  'Catarse da Noite Final',
  'Você é tomado por uma emoção que um espírito próximo experimentou na morte. Escolha uma das opções abaixo. Sempre que terminar um Descanso Longo, pode mudar a escolha.

Ódio. Quando erra uma jogada de ataque contra uma criatura, tem Vantagem na próxima jogada de ataque contra ela antes do fim do seu próximo turno.

Ciúme. Quando uma criatura que você tenha Agarrado estiver prestes a fazer um teste de atributo para terminar Agarrado em si, você pode gastar uma Reação para impor Desvantagem nessa rolagem.

Terror. Enquanto estiver Ferido, pode gastar uma Ação Bônus para realizar a ação Disparar ou Desengajar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  6,
  'Perdição Sombria Revisitada',
  'Uma vez por Fúria ativa, você pode gastar uma ação Mágica para canalizar uma morte traumática. Ao fazê-lo, escolha uma das opções.

Contaminação. No início do turno delas, cada criatura de sua escolha em uma Emanação de 3 m originada de você deve fazer salvaguarda de Constituição (CD 8 + modificador de Constituição + Bônus de Proficiência) ou sofrer dano de Veneno e a condição Envenenado por 1 minuto. O dano de Veneno é um número de d6 igual ao bônus de dano da Fúria, somados. A criatura afetada pode usar uma ação para terminar Envenenado em si.

Hipotermia. No início do turno delas, cada criatura de sua escolha em uma Emanação de 3 m originada de você deve fazer salvaguarda de Constituição (CD 8 + modificador de Força + Bônus de Proficiência) ou sofrer dano Gélido e ter o Deslocamento reduzido à metade por 1 minuto. O dano Gélido é um número de d6 igual ao bônus de dano da Fúria, somados. A criatura pode usar uma ação para terminar o efeito em si.

Imolação. No início do turno delas, cada criatura de sua escolha em uma Emanação de 4,5 m originada de você deve fazer salvaguarda de Destreza (CD 8 + modificador de Constituição + Bônus de Proficiência) ou sofrer dano Ígneo. O dano Ígneo é um número de d6 igual ao bônus de dano da Fúria, somados. Como ação, a criatura pode apagar o fogo em si ficando Caída e rolando no chão. O fogo também se apaga se for abafado, submerso ou sufocado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  10,
  'A Morte É Só uma Porta',
  'Sua familiaridade com a morte deixou-o resistente ao chamado dela. Você ganha os seguintes benefícios.

Difícil de Matar. Você tem Vantagem em Salvaguardas Contra a Morte. Além disso, precisa falhar em quatro Salvaguardas Contra a Morte para morrer, em vez de três.

Devolver o Espírito. Você pode chamar espíritos dos mortos para restaurar essência vital a uma criatura próxima. Pode conjurar Curar Ferimentos, Reviver os Mortos ou Revivificar sem fornecer componentes Materiais. Ao fazê-lo, ganha 1 nível de Exaustão por Curar Ferimentos, 2 por Revivificar e 3 por Reviver os Mortos. Constituição é sua habilidade de conjuração para este recurso. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo, a menos que gaste dois usos de Fúria (sem ação) para restaurá-lo.

“É um sujeito sinistro, sempre murmurando e vendo coisas que não estão lá. Mas não há ninguém com quem eu preferisse ter cobrindo minhas costas.”'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  14,
  'Alimentado pelo Pathos',
  'Sua Fúria é potencializada pelas emoções avassaladoras dos mortos inquietos. Catarse da Noite Final concede um efeito adicional conforme a emoção escolhida.

Ódio. Enquanto a Fúria estiver ativa, seus ataques com armas e Ataques Desarmados marcam Acerto Crítico em 19 ou 20 no d20.

Ciúme. Sempre que uma criatura que você possa ver começar o turno a até 9 m de você enquanto a Fúria estiver ativa, pode gastar uma Reação para convocar agressores espectrais que Agarram a criatura. Ela faz salvaguarda de Força ou Destreza (CD 8 + modificador de Constituição + Bônus de Proficiência). Em falha, fica Agarrada até o fim do turno dela. Em sucesso, não fica Agarrada; porém, cada 30 cm de movimento custa 30 cm extras até o fim do turno dela.

Terror. Sempre que uma criatura que você possa ver começar o turno a até 9 m de você enquanto a Fúria estiver ativa, pode gastar uma Reação para aterrorizá-la até o início do próximo turno dela. Uma criatura aterrorizada tem o Deslocamento reduzido à metade e Ataques de Oportunidade contra ela têm Vantagem.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  3,
  'Aventureiro Talentoso',
  'Você aprende um talento de aventureiro de sua escolha da seção “Opções de Talento de Aventureiro” mais adiante nesta subclasse. Aprende um talento adicional de sua escolha nos níveis 6 e 14 de Bardo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  3,
  'Organizador de Grupo',
  'Enquanto uma criatura tiver um dado de Inspiração Bárdica seu, ela pode gastar uma Ação Bônus para realizar a ação Ajudar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  6,
  'Bem Preparado',
  'Você ganha proficiência com um tipo de Ferramentas de Artesão de sua escolha, proficiência em uma perícia de sua escolha e conhece um idioma de sua escolha.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  14,
  'Talento Improvisado',
  'Quando termina um Descanso Longo, pode escolher um talento de aventureiro que conhece e substituí-lo por um que não conhece.

“Só me mostre o que você sabe. Prometo: aprendo rápido.”'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  3,
  'Travessuras Antagonistas',
  'Você conhece o truque Zombaria Perversa. Se já o conhece, aprende outro truque de Bardo de sua escolha. O truque não conta no número de truques conhecidos. Além disso, sempre tem a magia Sussurros Dissonantes preparada. Ademais, quando realiza a ação Disparar, Desengajar ou Influenciar no seu turno, pode gastar uma Ação Bônus no mesmo turno para conjurar Zombaria Perversa.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  3,
  'Gracejo Cruel',
  'Quando uma criatura que você possa ver ou ouvir a até 9 m falha em um Teste D20, pode gastar uma Reação para gastar um uso de Inspiração Bárdica; role o dado de Inspiração Bárdica e cause dano Psíquico igual ao número rolado + modificador de Carisma. Além disso, a criatura tem Desvantagem no próximo Teste D20 que fizer antes do fim do próximo turno dela.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  6,
  'Humor da Forca',
  'Quando uma criatura que você possa ver a até 18 m é reduzida a 0 Pontos de Vida ou morta na hora, pode gastar uma Reação para recuperar um uso gasto de Inspiração Bárdica. Ao fazê-lo, escolha uma criatura a até 9 m que possa ouvi-lo e compreendê-lo. Essa criatura deve ser bem-sucedida em salvaguarda de Sabedoria contra sua CD de magia ou ficar Caída e ter o Deslocamento reduzido a 0 até o fim do próximo turno dela. Se for bem-sucedida na salvaguarda, você recupera o uso desta habilidade. Caso contrário, depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  14,
  'Última Risada',
  'Quando você fica Ferido ou sofre dano enquanto Ferido, pode gastar uma Reação para recuperar todos os dados de Inspiração Bárdica gastos e explodir em uma gargalhada fatalista diante da própria perdição iminente. Por 1 minuto, você tem Resistência a todo dano. Além disso, quando uma criatura a até 18 m o acerta com uma jogada de ataque, pode gastar até três dados de Inspiração Bárdica para forçar o atacante a fazer salvaguarda de Carisma contra sua CD de magia. Em falha, a criatura sofre dano Psíquico igual ao total rolado nos dados + modificador de Carisma. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  3,
  'Melodia Gélida',
  'Você aprende dois truques de Necromancia de sua escolha. Contam como magias de Bardo para você, mas não contam no número de truques conhecidos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  3,
  'Arrancar as Cordas do Coração',
  'Sua Inspiração Bárdica pode puxar as amarras da vida. Cada criatura que tiver um dado de Inspiração Bárdica seu pode usá-lo em um dos efeitos seguintes.

Defesa. Quando a criatura é reduzida a 0 Pontos de Vida e não é morta na hora, pode rolar o dado de Inspiração Bárdica para ser reduzida a um número de Pontos de Vida igual ao resultado, em vez disso.

Ofensa. Imediatamente após acertar um alvo com uma jogada de ataque, pode rolar o dado de Inspiração Bárdica e somar o número rolado como dano Necrótico extra do ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  6,
  'Agitar os Ossos',
  'Você sempre tem a magia Animar Mortos preparada. Ela conta como magia de Bardo para você. Quando gasta um uso de Inspiração Bárdica, escolha criaturas Mortas-vivas sob seu controle a até 18 m, até um número igual ao modificador de Carisma (mínimo 1). Cada uma ganha um dado de Inspiração Bárdica. Esses dados extras não contam no seu limite. Quando uma criatura Morta-viva sob seu controle gasta um dado de Inspiração Bárdica em uma jogada de ataque, também pode somar o número rolado à jogada de dano do ataque se ele acertar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  14,
  'Dupla Morte',
  'Quando conjura uma magia de Necromancia que tem como alvo apenas uma criatura, pode fazê-la ter como alvo uma segunda criatura no alcance. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo. Também pode restaurar o uso gastando um uso de Inspiração Bárdica (sem ação).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  3,
  'Magias do Domínio Eldritch',
  'Sua conexão com este domínio divino garante que certas magias estejam sempre prontas. Quando alcança um nível de Clérigo especificado na tabela Magias do Domínio Eldritch, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  3,
  'Contágio Eldritch',
  'Você recebeu a capacidade de transmitir aos outros um breve gosto do incompreensível. Quando gasta uma ação Mágica para conjurar uma magia usando um espaço de magia que tenha como alvo uma ou mais criaturas, pode forçar um alvo da magia original a fazer salvaguarda de Sabedoria contra sua CD de magia. Em falha, role na tabela Efeitos Eldritch e a criatura sofre aquele efeito por 1 minuto. No fim de cada turno dela, repete a salvaguarda, terminando o efeito em si em um sucesso. O efeito termina antes se você usar este recurso de novo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  3,
  'Profecia de Perdição',
  'Como ação Mágica, você gasta um uso de Canalizar Divindade para escolher um ponto a até 36 m que possa ver e rolar na tabela Efeitos Eldritch. Cada criatura em uma Esfera de 4,5 m de raio centrada nesse ponto deve ser bem-sucedida em salvaguarda de Sabedoria contra sua CD de magia ou sofrer o efeito rolado por 1 minuto. No fim de cada turno dela, repete a salvaguarda, terminando o efeito em si em um sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  6,
  'Calmaria Sobrenatural',
  'Você tem Resistência a dano Psíquico e Vantagem em salvaguardas para evitar ou encerrar as condições Enfeitiçado e Amedrontado. Além disso, seus pensamentos não podem ser lidos por telepatia ou outros meios, a menos que você permita. A tentativa falha automaticamente, e a criatura deve passar numa salvaguarda de Sabedoria contra a sua CD de salvaguarda de magia ou sofrer dano Psíquico igual ao seu nível de Clérigo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  17,
  'Cantar a Canção que Termina o Mundo',
  'Quando uma criatura falha numa salvaguarda de Sabedoria contra o seu recurso Profecia de Perdição, você pode causar 10d10 de dano Psíquico a ela. Depois que uma criatura sofre dano dessa forma, ela fica imune a este efeito por 10 minutos, após o que pode ser afetada novamente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  3,
  'Magias — Inquisição',
  'Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas. Quando você alcança um nível de Clérigo especificado na tabela Magias — Inquisição, você passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  3,
  'Golpe do Caçador de Bruxas',
  'Quando você acerta uma criatura com um ataque com arma ou Ataque Desarmado, você pode causar 1d8 de dano de Força extra ao alvo. Se a criatura estiver se concentrando numa magia, você causa 2d8 de dano de Força extra em vez disso. No nível 14 de Clérigo, o dano de Força extra aumenta para 2d8, ou 3d8 se a criatura estiver se concentrando numa magia. Se uma criatura falhar na salvaguarda para manter Concentração em resultado do dano deste recurso, você ganha Pontos de Vida Temporários iguais ao dano de Força extra causado. Você pode usar este recurso um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez). Você recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  3,
  'Escudo Mágico',
  'Como Ação Bônus, você pode gastar um uso de Canalizar Divindade para conceder resiliência temporária contra dano arcano por 10 minutos. Escolha uma criatura que você possa ver (incluindo você) a até 9 m de você. A criatura escolhida ganha Pontos de Vida Temporários iguais a 1d10 mais o seu nível de Clérigo. Enquanto uma criatura tiver Pontos de Vida Temporários concedidos pelo seu Escudo Mágico, ela tem Vantagem em salvaguardas contra magias e Resistência ao dano de magias. Se restarem quaisquer desses Pontos de Vida Temporários quando o Escudo Mágico terminar, eles desaparecem.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  6,
  'Repreender Invocador',
  'Como Reação em resposta a uma criatura que você possa ver a até 18 m de você usando uma Ação Mágica para conjurar uma magia, você pode forçar a criatura a fazer uma salvaguarda de Constituição contra a sua CD de salvaguarda de magia. Em caso de falha, a criatura sofre 1d8 de dano de Força, mais outro 1d8 por nível do espaço de magia que a criatura gastou. Truques são considerados magias de 1º nível para esta habilidade. Em caso de sucesso, a criatura sofre metade do dano. Você pode usar este recurso um número de vezes igual ao seu modificador de Sabedoria (mínimo uma vez). Você recupera todos os usos gastos deste recurso ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  17,
  'Salvaguarda Suprema',
  'Escudo Mágico pode ter como alvo um número de criaturas até o seu modificador de Sabedoria (mínimo de uma criatura).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  3,
  'Purificar com Fogo',
  'Quando você causa dano com um truque ou com um ataque com arma ou Ataque Desarmado, você pode causar 1d8 de dano de Fogo adicional. Você pode usar este recurso um número de vezes igual ao seu modificador de Sabedoria mais o seu Bônus de Proficiência (mínimo de uma vez), e recupera todos os usos gastos ao terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  3,
  'Magias — Purificação',
  'Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas. Quando você alcança um nível de Clérigo especificado na tabela Magias — Purificação, você passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  3,
  'Marca Impura',
  'Quando você acerta uma criatura com um ataque corpo a corpo com arma ou Ataque Desarmado, em vez de causar o dano normal do golpe, você pode gastar um uso de Canalizar Divindade para gravar um símbolo na carne da criatura, marcando-a com uma marca brilhante por 1 minuto. Durante esse tempo, a criatura tem Desvantagem em salvaguardas contra as suas magias. Além disso, a criatura ganha Vulnerabilidade ao dano de Fogo que você causa, mesmo se normalmente tiver Resistência ou Imunidade a dano de Fogo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  6,
  'Proteção Contra Corrupção',
  'Você tem Vantagem em salvaguardas para evitar ou encerrar doenças e contra qualquer efeito que alteraria a sua forma, como a magia Polimorfia. Como Ação Mágica, você pode tocar uma criatura disposto a receber este benefício, mas a criatura sofre dano de Fogo igual ao seu modificador de Sabedoria (mínimo de 1). Este dano ignora Resistência e Imunidade. Depois que você concede este benefício, ele dura 1 hora ou até você concedê-lo novamente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  17,
  'Cauterizar Imperfeições',
  'Você pode conjurar Restauração Menor e Restauração Maior numa criatura disposta sem gastar espaços de magia e sem componentes Materiais, mas o alvo sofre 1d6 de dano de Fogo por cada nível do espaço de magia imediatamente após você conjurá-la. Este dano ignora Resistência e Imunidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  3,
  'Magias do Círculo de Sangue',
  'Quando você alcança um nível de Druida especificado na tabela Magias do Círculo de Sangue, você passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  3,
  'Rito da Lua de Sangue',
  'Como Ação Bônus, você pode gastar um uso de Forma Selvagem para adotar a selvageria violenta da Lua de Sangue por 10 minutos. Durante esse tempo, você ganha os seguintes benefícios: Resiliência Escarlate. Você ganha Pontos de Vida Temporários iguais a três vezes o seu nível de Druida. Deslocamento Aumentado. Seu Deslocamento aumenta em 3 m, e você pode realizar a ação Disparada como Ação Bônus. Golpes Violentos. Quando você acerta uma criatura com uma arma ou Ataque Desarmado, você pode causar 1d6 de dano Necrótico extra ao alvo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  6,
  'Dádiva de Sangue',
  'Sempre que uma criatura que você possa ver a até 18 m de você é reduzida a 0 Pontos de Vida, você pode usar uma Reação para reivindicar os últimos vestígios de sua vitalidade. Você recupera 1 Dado de Vida gasto e concede a uma criatura que você possa ver a até 18 m de você Pontos de Vida Temporários iguais ao seu nível de Druida. Você pode usar este recurso um número de vezes igual ao seu modificador de Sabedoria (mínimo uma vez). Você recupera um uso gasto ao terminar um Descanso Curto, e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  10,
  'Sede de Sangue',
  'Enquanto a sua Lua de Sangue estiver ativa, você ganha os seguintes benefícios: Golpes Violentos Aprimorados. O dano Necrótico extra dos seus Golpes Violentos aumenta para 2d6. Fúria Escarlate. Você tem Resistência a dano Contundente, Perfurante e Cortante.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  14,
  'Exsanguinar',
  'Quando você usa a sua Dádiva de Sangue, você recupera Dados de Vida gastos iguais à metade do seu nível de Druida e concede Pontos de Vida Temporários iguais ao dobro do seu nível de Druida a um número de criaturas até o seu modificador de Sabedoria (mínimo de uma criatura) que você possa ver a até 18 m de você. Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  3,
  'Poder Catastrófico',
  'Você dominou talentos, tanto mágicos quanto marciais, na busca pela destruição inevitável dos mortais e de suas obras. Quando você termina um Descanso Curto ou Longo, você ganha um dos seguintes benefícios até terminar o próximo Descanso Curto ou Longo. Cataclismo Elemental. Como Ação Mágica, você pode gastar um espaço de magia para fazer energia elemental explodir numa Esfera de 3 m de raio centrada num ponto a até 18 m de você. Escolha um tipo de dano: Ácido, Gélido, Fogo ou Relâmpago. Cada criatura na Esfera deve fazer uma salvaguarda de Destreza contra a sua CD de salvaguarda de magia. Em caso de falha, a criatura sofre 1d6 de dano do tipo escolhido por nível do espaço de magia gasto, e então tem Vulnerabilidade a esse tipo de dano por 1 minuto. Em caso de sucesso, a criatura sofre apenas metade do dano. O alvo repete a salvaguarda no fim de cada um dos seus turnos, encerrando a Vulnerabilidade em caso de sucesso. Golpe Ruinoso. Uma vez por turno, quando você causa dano com um ataque com arma ou Ataque Desarmado, você pode escolher gastar um espaço de magia para causar 1d8 de dano Necrótico extra, mais outro 1d8 por nível do espaço de magia. Maestria em Armas. Sua conexão sobrenatural com a destruição permite que você use a propriedade de maestria de um tipo de arma à sua escolha com a qual você tenha proficiência, como Arcos Curtos ou Bordões. Sempre que você termina um Descanso Longo, você pode mudar o tipo de arma escolhido. Por exemplo, você poderia passar a usar a propriedade de maestria de Fundas ou Clavas Grandes.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  3,
  'Ruína Encarnada',
  'Como Ação Bônus, você pode gastar um uso de Forma Selvagem para adotar um aspecto da entropia e do fim inevitável de todas as coisas por 10 minutos. Você ganha os seguintes benefícios. Tudo Passa. Você tem Vantagem em jogadas de ataque contra criaturas Feridas. Investida Inexorável. Você pode atacar duas vezes em vez de uma sempre que realizar a ação Atacar no seu turno. Armadura de Pele de Ferro. Sua CA base se torna 17 mais o seu modificador de Sabedoria (mínimo de +1) se a sua CA for menor que isso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  6,
  'Muitos Caminhos para a Ruína',
  'Sua conexão mística com a catástrofe e a destruição se fortalece. Você ganha os seguintes benefícios. Assalto Elemental. Enquanto o seu recurso Ruína Encarnada estiver ativo, sempre que você acertar com uma arma ou Ataque Desarmado, você pode fazer com que cause o tipo de dano à sua escolha entre Ácido, Gélido, Fogo, Relâmpago ou Necrótico em vez do tipo de dano normal. Poder Aumentado. Enquanto o seu recurso Ruína Encarnada estiver ativo, você pode somar o seu modificador de Sabedoria (bônus mínimo de +1) às suas salvaguardas de Força e Destreza.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  10,
  'Sacudir a Terra',
  'Como Ação Mágica, você pode golpear a terra com um tremor trovejante e crescer. Ao fazê-lo, o seu tamanho aumenta em uma categoria (de Médio para Grande, por exemplo) por 10 minutos. Além disso, cada criatura numa Emanação de 9 m originada da sua nova forma deve fazer uma salvaguarda de Destreza contra a sua CD de salvaguarda de magia ou ficar com a condição Caído. O tremor causa dano Contundente a cada estrutura em contato com o chão na área. Para determinar esse dano, role um número de d10s igual ao seu nível de Druida e some-os. Enquanto o seu tamanho estiver aumentado por este recurso, seus ataques com armas e Ataques Desarmados causam 1d4 de dano extra num acerto. Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  14,
  'Ápice da Entropia',
  'Você dominou a habilidade de acelerar o deslizamento inevitável em direção à entropia. Você ganha os seguintes benefícios. Golpe Ruinoso Aprimorado. Até o fim do seu próximo turno, qualquer criatura afetada pelo seu Golpe Ruinoso sofre um Acerto Crítico numa rolagem de 19–20 no d20. Investida Inexorável Aprimorada. Enquanto o seu recurso Ruína Encarnada estiver ativo, você pode atacar com uma arma ou Ataque Desarmado três vezes em vez de uma sempre que realizar a ação Atacar no seu turno. Quebrador de Mundos. Você recupera o uso do seu recurso Sacudir a Terra ao terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  3,
  'Formas do Círculo',
  'Você canaliza as possibilidades infinitas da natureza ao assumir uma forma de Forma Selvagem, concedendo os benefícios abaixo. Nível de Desafio. O Nível de Desafio máximo da forma é igual ao seu nível de Druida dividido por 3 (arredondado para baixo). Golpe do Predador. Quando você acerta uma criatura com uma jogada de ataque usando um ataque da forma de Besta na Forma Selvagem, você soma +2 ao dano causado. Imprevisível. Você pode realizar a ação Disparada, Desengajar ou Influenciar como Ação Bônus.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  3,
  'Mutar Forma',
  'Quando você assume uma forma de Forma Selvagem, ou como Ação Bônus enquanto a sua Forma Selvagem estiver ativa, você pode gastar um espaço de magia para ganhar Pontos de Mutação iguais ao nível do espaço. Esses Pontos de Mutação duram até serem gastos, você ganhar Pontos de Mutação adicionais, ou você deixar a forma. Enquanto tiver Pontos de Mutação, você pode gastá-los no seu turno (sem exigir ação) para obter uma Mutação da lista abaixo. Ao fazê-lo, o seu corpo se distende e se reconstitui numa exibição grotesca. As Mutações duram até você deixar a forma ou gastar um espaço de magia para ganhar Pontos de Mutação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  6,
  'Antinatural e Inquietante',
  'Quando você gasta um espaço de magia de 2º nível ou superior para ganhar Pontos de Mutação, você recupera um espaço de magia gasto. O espaço que você recupera deve ser de um nível inferior ao espaço gasto e não pode ser superior ao 5º nível. Além disso, enquanto estiver na forma de Forma Selvagem, você ganha os seguintes benefícios. Ataques Antinaturais. Cada um dos seus ataques na forma de Forma Selvagem pode causar o tipo de dano normal ou dano de Força. Você faz essa escolha cada vez que acerta com esses ataques. Aura Inquietante. Você tem Vantagem em testes de Carisma (Enganação ou Intimidação) e Sabedoria (Adestrar Animais).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  10,
  'Evolução Infinita',
  'Quando você ganha Pontos de Mutação, você ganha um número adicional de Pontos de Mutação igual ao seu modificador de Sabedoria (mínimo 1). Além disso, você agora pode gastar seus Pontos de Mutação nas seguintes Mutações. Criatura da Terra. Custo: 3 Pontos de Mutação. Você tem Sentido Sísmico com alcance de 9 m. Você pode gastar 2 Pontos de Mutação adicionais para ganhar um Deslocamento de Escavar igual ao seu Deslocamento. Endurecimento Elemental. Custo: 2 Pontos de Mutação. Você ganha Resistência a um dos seguintes tipos de dano à sua escolha: Ácido, Gélido, Fogo, Relâmpago, Veneno ou Trovejante. Repetível. Você pode obter esta Mutação mais de uma vez, mas deve escolher uma Resistência diferente a cada vez. Assalto Eldritch. Custo: 2 Pontos de Mutação. Você ganha um bônus de +1 em jogadas de ataque e jogadas de dano que fizer com os ataques da sua forma de Forma Selvagem. Repetível. Você pode obter esta Mutação mais de uma vez, mas no máximo três vezes. Monstro Místico. Custo: 3 Pontos de Mutação. Você pode conjurar magias enquanto estiver nesta forma de Forma Selvagem. Se você tiver 18 ou mais níveis de Druida, criaturas têm Desvantagem em salvaguardas contra magias que você conjurar enquanto esta Mutação estiver ativa. Regeneração Rápida. Custo: 5 Pontos de Mutação. No início de cada um dos seus turnos, você recupera Pontos de Vida iguais ao seu modificador de Sabedoria (mínimo de 1 Ponto de Vida recuperado). Pele Sobrenatural. Custo: 5 Pontos de Mutação. Você tem Resistência a dano Contundente, Perfurante e Cortante.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  14,
  'Predador Ápice',
  'Seu domínio da mutação tornou você um predador ápice, concedendo os seguintes benefícios. Ataques Evoluídos. Uma vez por turno, você pode causar 2d10 de dano de Força extra a um alvo que acertar com um ataque da forma de Forma Selvagem. Mutar Bestas. Como Ação Mágica, você pode tocar uma Besta e gastar um espaço de magia, fazendo o alvo mutar. Você ganha Pontos de Mutação iguais ao nível do espaço, que deve gastar imediatamente em Mutações para a Besta. Pontos de Mutação não gastos são perdidos. As Mutações permanecem até a Besta ser alvo deste recurso novamente. Remover Maldição, Restauração Maior ou magia semelhante encerra as Mutações.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  3,
  'Provocação Protetora',
  'Uma vez por turno, quando você acerta uma criatura com um ataque corpo a corpo usando uma arma ou Ataque Desarmado, você pode provocá-la. Até o início do seu próximo turno ou até você ter a condição Incapacitado, o alvo tem Desvantagem em jogadas de ataque contra alvos que não sejam você. Uma criatura só pode ser afetada por uma Provocação por vez.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  3,
  'Resistir à Tempestade',
  'Você se acostumou a ser espancado e machucado. Como Ação Bônus, você se endurece por 1 minuto. No fim de cada um dos seus turnos, você ganha Pontos de Vida Temporários iguais ao seu nível de Guerreiro mais o seu modificador de Constituição. Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  7,
  'Presença Ameaçadora',
  'Você pode provocar seus inimigos a um ódio obsessivo por você. Como Ação Mágica, cada criatura à sua escolha que possa ouvi-lo numa Emanação de 9 m originada de você deve fazer uma salvaguarda de Sabedoria (CD 8 mais o seu modificador de Constituição e Bônus de Proficiência). Em caso de falha, a criatura sofre 5d6 de dano Psíquico e tem Desvantagem em jogadas de ataque contra alvos que não sejam você. Quando você usa este recurso, você restaura o uso de Resistir à Tempestade. Você pode usar este recurso duas vezes. Você recupera todos os usos gastos ao terminar um Descanso Longo. Quando você alcança o nível 15 de Guerreiro, ganha outro uso deste recurso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  10,
  'Defesa Agressiva',
  'Você sabe quando passar da defesa para o ataque. Uma vez em cada um dos seus turnos, quando você acerta uma criatura com uma jogada de ataque usando uma arma corpo a corpo ou Ataque Desarmado, você pode perder Pontos de Vida Temporários iguais a no máximo a metade do seu nível de Guerreiro (arredondado para baixo) para causar dano extra ao alvo igual ao número de Pontos de Vida Temporários perdidos dessa forma.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  15,
  'Segundo Vento Aprimorado',
  'Sua resistência é inigualável. Quando você recupera Pontos de Vida com Segundo Vento, você ganha um número de Pontos de Vida Temporários igual ao total da rolagem.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  18,
  'Interromper o Assalto',
  'Quando outra criatura que você possa ver a até 1,5 m de você é acertada por uma jogada de ataque, você pode usar uma Reação para mudar o alvo para você. Você tem Resistência a todo o dano contra esse ataque. De vez em quando você encontra um: um soldado pronto e disposto a se colocar no caminho do perigo pelos camaradas. —'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  3,
  'Criador de Compostos',
  'Você aprende a criar compostos alquímicos tóxicos para os outros, mas fortalecedores para você. Compostos. Você aprende três compostos à sua escolha da seção “Opções de Compostos” abaixo. Você aprende dois compostos adicionais à sua escolha quando alcança os níveis 7, 10 e 15 de Guerreiro. Cada vez que aprende novos compostos, você também pode substituir um composto que conhece por um diferente. Criação. Sempre que você termina um Descanso Longo enquanto empunha Suprimentos de Alquimista, você pode usar essa ferramenta para produzir magicamente qualquer número de compostos. O composto aparece num frasco, e o frasco desaparece quando o composto é consumido ou derramado. Se restar algum composto quando você terminar um Descanso Longo, o composto e seu frasco desaparecem. Consumo. Como Ação Bônus, você pode consumir um composto. Você pode consumir um número de compostos até um mais o seu modificador de Constituição (mínimo de um). Ao atingir esse limite, você não pode se beneficiar de mais compostos até terminar um Descanso Longo. Você pode se beneficiar de múltiplos compostos ao mesmo tempo, mas consumir múltiplos frascos do mesmo composto não fornece efeitos adicionais. Somente você pode se beneficiar dos seus compostos. Qualquer outra criatura que consumir um composto deve passar numa salvaguarda de Constituição (CD 8 mais o seu modificador de Inteligência mais Bônus de Proficiência) ou ficar com a condição Envenenado por 1 minuto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  3,
  'Estudante de Alquimia',
  'Você recebe Suprimentos de Alquimista e tem proficiência com eles. Além disso, o seu Bônus de Proficiência é dobrado em testes de habilidade com Suprimentos de Alquimista.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  7,
  'Caldeirão Vivo',
  'O número de compostos que você pode consumir com segurança aumenta para três mais o seu modificador de Constituição (mínimo um). No nível 18 de Guerreiro, o número de compostos que você pode consumir com segurança aumenta para cinco mais o seu modificador de Constituição (mínimo um).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  10,
  'Consumo Rápido',
  'Quando você usa uma Ação Bônus para beber um composto, você pode beber um segundo composto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  15,
  'Transmutação de Toxina',
  'Você tem Resistência a dano de Veneno. Também, como Ação Bônus, você pode encerrar a condição Envenenado em si mesmo. Quando você encerra a condição Envenenado em si mesmo dessa forma, você pode escolher ganhar Pontos de Vida Temporários iguais ao seu nível de Guerreiro. Você recupera a capacidade de ganhar esses Pontos de Vida Temporários após completar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  18,
  'Catalisador Vivo',
  'Quando você termina um Descanso Longo, você pode substituir um composto que conhece por outro.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  3,
  'Guardião Hábil',
  'Desvendar mistérios sob o manto da noite aprimorou suas perícias. Você ganha os seguintes benefícios. Expertise. Escolha uma das suas proficiências em perícia nas quais você ainda não tenha Expertise. Você ganha Expertise nessa perícia. Hábil. Você ganha proficiência em duas perícias à sua escolha da seguinte lista: Enganação, História, Intuição, Intimidação, Investigação, Percepção ou Furtividade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  3,
  'Sempre Vigilante',
  'Suas longas noites de vigilância deixaram seus sentidos sintonizados a sinais de perigo, concedendo os seguintes benefícios. Visão no Escuro. Você ganha Visão no Escuro com alcance de 18 m. Se você já tiver Visão no Escuro ao ganhar este recurso, o alcance dela aumenta em 18 m. Sentidos Aguçados. Você tem Vantagem em rolagens de Iniciativa e testes de Sabedoria (Percepção). Grito de Alerta. Quando você faz uma rolagem de Iniciativa, você pode usar uma Reação para alertar criaturas à sua escolha a até 9 m de você que possam vê-lo ou ouvi-lo. Cada criatura pode então usar uma Reação para ter Vantagem na sua rolagem de Iniciativa e se mover até metade do seu Deslocamento sem provocar Ataque de Oportunidade. Depois de usar este recurso, você não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  7,
  'Avaliar',
  'Como Ação Bônus, você avalia uma criatura que possa ver a até 9 m de você. Até o início do seu próximo turno, quando essa criatura fizer uma jogada de ataque contra você ou outra criatura a até 1,5 m de você, você pode usar uma Reação para impor Desvantagem nessa rolagem e conceder Resistência a esse dano.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  10,
  'Espreitador Noturno',
  'Você é hábil em rastrear inimigos na escuridão da noite, recebendo estes benefícios. Visão Cega. Como Ação Bônus, você ganha Visão Cega com alcance de 9 m por 10 minutos. Depois de usar este benefício, você não pode usá-lo novamente até terminar um Descanso Curto ou Longo. Escorregadio. Ataques de Oportunidade têm Desvantagem contra você. Enquanto estiver totalmente sob Luz Fraca ou Escuridão, o seu movimento não provoca Ataque de Oportunidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  15,
  'Pronto para a Ação',
  'Quando você faz uma rolagem de Iniciativa, você pode tratar uma rolagem de d20 de 9 ou menos como 10. Quando você rola 18–20 numa rolagem de Iniciativa, você pode realizar uma ação adicional, exceto a Ação Mágica, no seu primeiro turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  18,
  'Espancar',
  'Imediatamente após errar uma criatura sob o efeito do seu recurso Avaliar com uma jogada de ataque, você pode usar uma Ação Bônus ou Reação para fazer um ataque corpo a corpo contra essa criatura se ela estiver no alcance. Você tem Vantagem na nova jogada de ataque contra essa criatura.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  3,
  'Mão Sutil',
  'Suas artes marciais são aprimoradas por uma capacidade de golpes telecinéticos. Durante o seu turno, o seu alcance é 1,5 m maior com Ataques Desarmados. Além disso, quando você acerta uma criatura com um Ataque Desarmado como parte da ação Atacar no seu turno, você pode escolher que ele cause dano Psíquico à sua escolha ou o tipo de dano normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  3,
  'Proeza Psiônica',
  'Seus poderes psíquicos se manifestaram na capacidade de conjurar certas magias. Você conhece o truque Mão Mágica. Você pode conjurá-lo sem componentes Verbais ou Somáticos, e pode tornar a mão espectral Invisível. Além disso, você pode conjurar certas magias gastando Pontos de Foco. Você pode realizar uma Ação Mágica e gastar 1 Ponto de Foco para conjurar Detectar o Bem e o Mal ou Proteção contra o Bem e o Mal. Você também pode realizar uma Ação Mágica e gastar 2 Pontos de Foco para conjurar Imobilizar Pessoa, Levitação ou Estilhaçar. Sabedoria é a sua habilidade de conjuração para essas magias, e você pode conjurá-las sem componentes Materiais.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  6,
  'Golpe Descarado',
  'Uma vez em cada um dos seus turnos, quando você acerta uma criatura com o seu Ataque Desarmado ou arma de Monge, você pode forçá-la a fazer uma salvaguarda de Força contra a sua CD de salvaguarda de Pontos de Foco. Em caso de falha, você pode mover o alvo até 3 m na sua direção ou para longe de você.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  11,
  'Esmagamento Psíquico',
  'Cada vez que você acerta uma criatura com um Ataque Desarmado, ela ganha um Ponto de Pressão. Uma criatura perde todos os Pontos de Pressão se você fizer outra criatura ganhar um Ponto de Pressão ou após 1 minuto, o que ocorrer primeiro. Como Ação Bônus, você pode gastar 1 Ponto de Foco para esmagar telecineticamente uma criatura com 1 ou mais dos seus Pontos de Pressão. A criatura perde todos os Pontos de Pressão e deve fazer uma salvaguarda de Força contra a sua CD de salvaguarda de Pontos de Foco. Em caso de falha, a criatura sofre 1d8 de dano de Força por Ponto de Pressão, e fica com a condição Contido até o fim do seu próximo turno. Em caso de sucesso, a criatura sofre apenas metade do dano.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  17,
  'Maestria Psiônica',
  'Após muito treinamento, você dominou as disciplinas psiônicas necessárias para defender mortais de ameaças planares. Como Ação Mágica, você pode gastar 5 Pontos de Foco para conjurar Dissipar o Bem e o Mal, Imobilizar Monstro, Telecinesia ou Muralha de Força. Sabedoria é a sua habilidade de conjuração para essas magias, e você pode conjurá-las sem componentes Materiais.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  3,
  'Contos Exagerados',
  'Você adquiriu jeito para contar histórias exageradas de suas façanhas passadas. Você ganha proficiência em uma das seguintes perícias à sua escolha: Enganação, Intimidação, Atuação ou Persuasão.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  3,
  'Ego Ferido',
  'Seu ego o fortalece enquanto você luta para provar o seu valor. Quando você gasta um Ponto de Foco, você também pode ganhar Pontos de Vida Temporários iguais ao seu modificador de Sabedoria (mínimo de 1 Ponto de Vida Temporário). Enquanto estiver Ferido, você ganha o dobro dessa quantidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  3,
  'Atacante Assertivo',
  'Enquanto estiver Ferido, você soma o seu modificador de Sabedoria ao dano que causa com Ataques Desarmados e armas de Monge.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  6,
  'Retaliação Irracional',
  'Dano causado a você é dano causado ao seu orgulho, e isso é algo que você simplesmente não pode permitir. Sempre que uma criatura causar dano a você, você pode usar uma Reação e gastar 1 Ponto de Foco. Você tem Vantagem em jogadas de ataque contra essa criatura até o fim do seu próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  6,
  'Esforços Redobrados',
  'Quando você obtém um Acerto Crítico enquanto estiver Ferido, você pode rolar um dado de dano adicional ao determinar o dano extra causado pelo ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  11,
  'Sempre Orgulhoso',
  'Quando você é reduzido a 0 Pontos de Vida e não é morto na hora, pode gastar 1 Ponto de Foco para entrar em um transe. Enquanto estiver nesse transe: é imune à condição Inconsciente; não pode falar; não pode conjurar nem se concentrar em magias; sofre 1 falha em Salvaguarda Contra a Morte por dano de Acerto Crítico em vez de 2. Sempre que começar o turno com 0 Pontos de Vida, deve gastar 1 Ponto de Foco para manter o transe e faz Salvaguardas Contra a Morte normalmente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  17,
  'Egotista',
  'Feridas no orgulho o enfurecem. Você é considerado Ferido se seus Pontos de Vida atuais estiverem abaixo do máximo de Pontos de Vida.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  3,
  'Sombra de Arrependimento',
  'Uma vez por turno, no seu turno, pode gastar 1 Ponto de Foco (sem ação) para criar uma sombra de si em um espaço desocupado que possa ver a até 3 m. A sombra é intangível e não ocupa o espaço. Dura até o fim do seu próximo turno, mas termina antes se você a dispensar (sem ação) ou tiver a condição Incapacitado. Enquanto persistir, você ganha os seguintes benefícios.

Golpe da Sombra. Quando usa Rajada de Golpes, pode fazer com que os ataques originem da sombra em vez de você. Ataques originados da sombra causam dano Necrótico ou de Força (sua escolha) em vez do tipo normal.

Mover. Como Ação Bônus, pode mover a sombra até 18 m para um espaço desocupado que possa ver a até 18 m de você.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  3,
  'A Estrada Não Percorrida',
  'Quando realiza a ação Disparar, em vez de se mover, pode teleportar a si ou a um aliado a até 18 m de você para o local da sua sombra.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  6,
  'Auxílio Não Negado',
  'Você pode gastar uma Ação Bônus para realizar a ação Ajudar, ou gastar 1 Ponto de Foco para tocar uma criatura e restaurar Pontos de Vida iguais a uma rolagem do seu dado de Artes Marciais + modificador de Sabedoria.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  11,
  'Culpa Esmagadora',
  'Você pode gastar 3 Pontos de Foco para liberar a culpa reprimida em uma onda esmagadora que derruba os inimigos. Criaturas de sua escolha em uma Emanação de 6 m originada de você ou da sua sombra devem fazer salvaguarda de Sabedoria contra a CD de salvaguarda do Ponto de Foco. Em falha, a criatura sofre dano Psíquico igual a três rolagens do dado de Artes Marciais e fica Caída. Em sucesso, sofre apenas metade do dano.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  17,
  'Reviver o Passado',
  'Sua Sombra de Arrependimento agora dura 10 minutos. Após usar Rajada de Golpes, a Sombra pode fazer um Ataque Desarmado adicional conforme Golpe da Sombra. Você também pode usar Golpe Atordoante através do Golpe da Sombra.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  3,
  'Febre Debilitante',
  'Você pode infligir doença a uma criatura. Quando acerta uma criatura com jogada de ataque usando arma ou Ataque Desarmado, pode gastar um uso de Canalizar Divindade para dar a essa criatura a condição Envenenado por 1 minuto. Enquanto Envenenada assim, o alvo também tem a condição Incapacitado. No fim de cada turno dela, o alvo Envenenado faz salvaguarda de Constituição, terminando o efeito em si em um sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  3,
  'Infecção Entrópica',
  'Como ação Mágica, você pode gastar um uso de Canalizar Divindade e selecionar uma criatura que possa ver a até 9 m. Por 1 minuto, se causar dano ao alvo, ele sofre 2d6 de dano Necrótico extra. Além disso, o alvo perde Resistência e Imunidade a dano Necrótico. O alvo pode fazer salvaguarda de Constituição contra a CD de magia do Paladino no fim de cada turno dele, terminando o efeito em si em um sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  3,
  'Magias do Juramento de Pestilência',
  'A magia do seu juramento garante que certas magias estejam sempre prontas; quando alcança um nível de Paladino especificado na tabela Magias do Juramento de Pestilência, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  7,
  'Aura de Doença Desenfreada',
  'Você emite uma aura de contágio e virulência. Quando uma criatura dentro da sua Aura de Proteção estiver prestes a fazer um Teste D20, pode gastar uma Reação para impor Desvantagem nesse Teste D20.

“Há dias em que mal se enxerga o brilho da armadura deles através da névoa, como se estivessem esperando por algo.”'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  15,
  'Resiliência Nojenta',
  'Quando você é reduzido a 0 Pontos de Vida e não é morto na hora, pode gastar qualquer número de Dados de Vida, rolá-los e reduzir o dano sofrido pelo total rolado. Além disso, se for morto, seu cadáver explode em pus e vísceras. Cada criatura em uma Emanação de 6 m originada de você faz salvaguarda de Constituição contra a CD de magia do Paladino, sofrendo 8d6 de dano Necrótico em falha ou metade em sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  20,
  'Portador da Peste',
  'Como Ação Bônus, você ganha os benefícios abaixo por 10 minutos, ou até encerrá-los (sem ação). Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo. Também pode restaurar o uso gastando um espaço de magia de 5º círculo (sem ação).

Um com a Peste. Você é imune a dano de Veneno e à condição Envenenado, e tem Resistência a dano Necrótico.

Fortalecido pela Podridão. Seu máximo de Pontos de Vida não pode ser reduzido.

Radiancia Entrópica. Sempre que um inimigo começar o turno dentro da sua Aura de Proteção, sofre dano Necrótico igual ao seu modificador de Carisma + Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  3,
  'Massacre Frenético',
  'Você pode canalizar a adrenalina da batalha para atos ainda maiores de violência. Como Ação Bônus, gasta um uso de Canalizar Divindade para entrar em frenesi de combate. Enquanto ativo, ganha os seguintes benefícios.

Ataque Reflexivo. Quando erra uma jogada de ataque com arma corpo a corpo ou Ataque Desarmado, pode gastar uma Reação para fazer outro ataque com a mesma arma.

Resistência a Condições. Você tem Vantagem em salvaguardas para evitar ou terminar as condições Enfeitiçado, Amedrontado e Atordoado.

Duração. O Massacre Frenético dura até o fim do seu próximo turno e termina antes se você tiver a condição Incapacitado. Se ainda estiver ativo no seu próximo turno, pode estendê-lo por mais uma rodada fazendo uma das seguintes: fazer uma jogada de ataque contra um inimigo; forçar um inimigo a fazer uma salvaguarda; ou estar Ferido no fim do turno. Cada extensão dura até o fim do próximo turno. Você pode mantê-lo por até 1 minuto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  3,
  'Magias do Juramento de Massacre',
  'A magia do seu juramento garante que certas magias estejam sempre prontas; quando alcança um nível de Paladino especificado na tabela Magias do Juramento de Massacre, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  7,
  'Aura da Sede de Sangue',
  'Sua sede de sangue contagia os que estão à sua volta. Quando um aliado Ferido dentro da sua Aura de Proteção faz um ataque com arma ou Ataque Desarmado, ganha bônus no dano igual ao seu modificador de Carisma. Além disso, quando uma criatura Ferida dentro da sua Aura de Proteção faz salvaguarda contra uma magia de Sangromancia, você pode gastar uma Reação para impor Desvantagem na salvaguarda.

“Somos mais parecidos do que diferentes daqueles paladinos que se deleitam no massacre, acho. Embora sejam um pouco mais… perdulários.”'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  15,
  'Seguir em Frente',
  'Quando uma criatura na sua Aura de Proteção fica Ferida, você pode gastar uma Reação para se mover até metade do Deslocamento e fazer um ataque com arma corpo a corpo ou Ataque Desarmado. Esse movimento não provoca Ataque de Oportunidade, e você tem Vantagem na jogada de ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  20,
  'Cavaleiro do Sangue',
  'Sua sede de sangue confere força e resiliência sobrenaturais, permitindo continuar a semear o massacre. Como Ação Bônus, você ganha os benefícios abaixo por 10 minutos ou até encerrá-los (sem ação). Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo. Também pode restaurar o uso gastando um espaço de magia de 5º círculo (sem ação).

Armadura Carmesim. Quando uma criatura dentro da sua Aura de Proteção fica Ferida por um inimigo, você ganha 30 Pontos de Vida Temporários.

Vendo Vermelho. Quando uma criatura o acerta com uma jogada de ataque, pode gastar uma Reação para fazer um ataque corpo a corpo contra ela, com arma ou Ataque Desarmado.

Massacre Desenfreado. Quando acerta uma criatura com jogada de ataque corpo a corpo usando arma ou Ataque Desarmado, pode escolher qualquer número de criaturas a até 1,5 m do alvo original e dentro do seu alcance. Cada uma sofre dano de Força igual ao modificador de Carisma (mínimo +1) + Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  3,
  'Marca do Herege',
  'Como Ação Bônus, você pode gastar um uso de Canalizar Divindade para marcar como herege uma criatura que possa ver a até 9 m. Por 1 minuto, seus ataques com arma e Ataques Desarmados contra a criatura escolhida marcam Acerto Crítico em 19 ou 20 no d20. Além disso, sempre que o alvo começar o turno, você pode gastar uma Reação para fazer um ataque corpo a corpo contra ele se estiver no alcance.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  3,
  'Magias do Juramento de Zelo',
  'A magia do seu juramento garante que certas magias estejam sempre prontas; quando alcança um nível de Paladino especificado na tabela Magias do Juramento de Zelo, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  7,
  'Aura de Clareza',
  'Você e seus aliados têm Imunidade à condição Cego enquanto estiverem na sua Aura de Proteção. Se um aliado Cego entrar na aura, essa condição não tem efeito nele enquanto estiver lá. Além disso, você pode ver criaturas Invisíveis dentro da sua Aura de Proteção.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  15,
  'Compelir Confissão',
  'Você pode conjurar Zona da Verdade sem gastar espaço de magia. Além disso, uma criatura que tenha sucesso na salvaguarda sofre 1d6 de dano Psíquico no início de cada turno dela enquanto estiver na sua Zona da Verdade, até optar por falhar na salvaguarda em vez disso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  20,
  'Revelação Apocalíptica',
  'Como Ação Bônus, você pode revelar a verdadeira natureza dos inimigos por 1 minuto. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo. Também pode restaurar o uso gastando um espaço de magia de 5º círculo (sem ação). Você ganha os seguintes benefícios.

Glória Cegante. Inimigos que começarem o turno a até 1,5 m de você devem fazer salvaguarda de Constituição contra a CD de magia do Paladino. Em falha, ficam Cegos até o início do próximo turno deles.

Ver a Verdade. Você tem Visão Verdadeira com alcance de 18 m.

Destruir o Herege. Como Ação Bônus, pode escolher uma criatura a até 18 m e revelar as fraquezas dela. Você e seus aliados têm Vantagem nas jogadas de ataque contra essa criatura.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  3,
  'Ataque Envenenado',
  'Como Ação Bônus, você pode aplicar uma dose de veneno a uma arma ou até 20 peças de munição. Uma vez aplicado, o veneno retém a potência por 1 minuto. Seus ataques com o item envenenado causam 1d4 de dano de Veneno extra em um acerto. Pode usar este recurso um número de vezes igual ao modificador de Sabedoria (mínimo 1). Recupera todos os usos ao terminar um Descanso Longo. No 11º nível de Guardião, o dano de Veneno extra aumenta para 2d4, e você recupera todos os usos ao terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  3,
  'Ofício Tóxico',
  'Você ganha um Kit de Envenenador e tem proficiência com ele. Além disso, seu Bônus de Proficiência é dobrado em testes de atributo com Kit de Envenenador. Se perder o kit, pode colher flora tóxica e fauna venenosa por 1 hora para criar magicamente um substituto. Essa colheita pode ser feita durante um Descanso Curto ou Longo e destrói o Kit de Envenenador anterior. Uma vez por turno, quando causa dano de Veneno a uma criatura com ataque de arma, pode gastar um espaço de magia (sem ação). O ataque causa 1d6 de dano de Veneno extra e o alvo fica Envenenado até o fim do seu próximo turno. Você também pode adicionar um Efeito de Toxina, escolhido da lista apropriada abaixo. Todos os Efeitos de Toxina duram até o fim do seu próximo turno, salvo indicação em contrário.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  3,
  'Magias do Ceifador Verde',
  'Quando alcança um nível de Guardião especificado na tabela Magias do Ceifador Verde, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  7,
  'Controle de Veneno',
  'Você ganha Resistência a dano de Veneno e tem Vantagem em salvaguardas para evitar ou terminar a condição Envenenado. Além disso, pode conjurar Proteção contra Veneno sem gastar espaço de magia. Pode fazê-lo um número de vezes igual ao modificador de Sabedoria (mínimo 1) e recupera todos os usos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  11,
  'Vexações Variadas',
  'Sempre que for causar dano de Veneno com um ataque de arma, pode mudar esse dano para Ácido ou Necrótico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  15,
  'Tolerância à Dor',
  'Você aprendeu a se proteger rapidamente contra o dano. Imediatamente antes de sofrer dano de uma criatura que possa ver a até 18 m, pode gastar uma Reação para ganhar Pontos de Vida Temporários iguais ao dano sofrido. Se algum desses Pontos de Vida Temporários restar no fim do seu próximo turno, eles desaparecem.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  3,
  'Flechas Elementais',
  'Como Ação Bônus, você pode imbuir um Arco Longo ou Arco Curto com energia elemental por 1 minuto. Escolha um dos tipos: Ácido, Gélido, Ígneo, Elétrico ou Trovejante. Pela duração, a arma imbuída causa dano do tipo escolhido em vez do normal e causa 1d6 extra desse tipo quando acerta. No início de cada um dos seus turnos, pode mudar essa escolha. Pode usar este recurso um número de vezes igual ao modificador de Sabedoria (mínimo 1) e recupera todos os usos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  3,
  'Sabedoria Herbal',
  'Você ganha um Kit de Herbalismo e é proficiente com ele. Pode usar o Kit de Herbalismo como Ação Bônus para estabilizar uma criatura Inconsciente a até 1,5 m com 0 Pontos de Vida como se usasse um Kit de Curandeiro, sem precisar de teste de Sabedoria (Medicina). Se gastar uma ação Utilizar, uma criatura Inconsciente a até 1,5 m com 0 Pontos de Vida ganha 1 Ponto de Vida em vez disso. Depois de usar este recurso, não pode fazê-lo de novo até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  3,
  'Magias do Arqueiro Primordial',
  'Quando alcança um nível de Guardião especificado na tabela Magias do Arqueiro Primordial, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  7,
  'Tece os Elementos',
  'Com 1 hora de trabalho ou ao terminar um Descanso Longo, pode usar um Kit de Herbalismo para marcar-se com padrões elementais. Você ganha Resistência a um dos seguintes tipos de dano de sua escolha até terminar um Descanso Longo: Ácido, Gélido, Ígneo, Elétrico ou Trovejante.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  11,
  'Flechas Feiticeiras',
  'Você ganha a capacidade de imbuir maldições nas flechas. Uma vez por turno, quando acerta uma criatura com ataque à distância usando Arco Longo ou Arco Curto, pode gastar um espaço de magia de 1º círculo ou superior para escolher um dos efeitos abaixo (sem ação). O dano listado aumenta em 2d6 para cada círculo acima do 1º.

Tiro em Arco. Eletricidade crepita em torno da flecha. Faça uma jogada de ataque à distância com a mesma arma contra uma segunda criatura a até 9 m da primeira que também esteja no seu alcance. Cada criatura acertada sofre 2d6 de dano Elétrico.

Tiro Enredante. O haste de madeira brota folhinhas verdes. O alvo deve ser bem-sucedido em salvaguarda de Força contra sua CD de magia. Em falha, sofre 2d6 de dano Perfurante e fica Contido por 1 minuto. Em sucesso, sofre apenas o dano. Uma criatura Contida repete a salvaguarda no fim de cada turno dela, terminando o efeito em si em um sucesso.

Tiro Amaldiçoante. A magia em torno da flecha obscurece a mente do alvo. O alvo faz salvaguarda de Sabedoria contra sua CD de magia. Em falha, sofre 2d6 de dano Psíquico e ganha a condição Enfeitiçado ou Amedrontado por 1 minuto (sua escolha). Pode repetir a salvaguarda no fim de cada turno, terminando o efeito em sucesso. Em sucesso na salvaguarda inicial, sofre apenas metade do dano.

Tiro Víbora. A flecha se transforma em serpente sibilante. O alvo faz salvaguarda de Constituição contra sua CD de magia. Em falha, sofre 2d6 de dano de Veneno e fica Envenenado por 1 minuto. Pode repetir a salvaguarda no fim de cada turno, terminando o efeito em sucesso. Em sucesso na salvaguarda inicial, sofre apenas metade do dano.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  15,
  'Magia Primordial',
  'Sofrer dano não pode quebrar sua Concentração em magias de Guardião que você conjurar. Além disso, pode gastar uma Ação Bônus para mudar o tipo de dano escolhido em Tece os Elementos para outro da lista. Ao fazê-lo, pode escolher uma criatura que possa ver a até 9 m. Essa criatura deve ser bem-sucedida em salvaguarda de Constituição ou sofrer 6d6 de dano de um dos dois tipos (sua escolha). Pode usar este recurso um número de vezes igual ao modificador de Sabedoria (mínimo 1) e recupera todos os usos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  3,
  'Afinidade Verminosa',
  'Você pode compreender e se comunicar verbalmente com Feras Minúsculas. Como ação Mágica, pode gastar um espaço de magia para convocar enxames de vermes. Convoca um número de enxames igual ao círculo do espaço por 1 hora. Cada enxame aparece em um espaço desocupado que possa ver a até 9 m. Um enxame usa o bloco Enxame de Vermes. Em combate, cada enxame age durante o seu turno. Pode se mover e usar a Reação por conta própria, mas a única ação que realiza é Esquivar, a menos que você gaste uma Ação Bônus para ordenar uma ação do bloco ou outra ação. Você pode comandar cada enxame com uma única Ação Bônus. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  3,
  'Golpes do Enxame',
  'Como Ação Bônus, você pode ordenar que todos os seus enxames realizem a ação Atacar em vez de apenas um. Alternativamente, um único enxame pode atacar duas vezes em vez de uma ao realizar a ação Atacar. Pode usar este recurso um número de vezes igual ao modificador de Sabedoria + Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  3,
  'Magias do Senhor dos Vermes',
  'Quando alcança um nível de Guardião especificado na tabela Magias do Senhor dos Vermes, passa a ter sempre as magias listadas preparadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  7,
  'Imundície e Fortitude',
  'O tempo passado com roedores portadores de peste tornou-o imune à condição Envenenado. Além disso, ganha proficiência em salvaguardas de Constituição.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  11,
  'Propagação Infecciosa',
  'Quando usa Golpes do Enxame, cada enxame que realiza a ação Atacar faz um ataque adicional. Cada criatura danificada pelo ataque de um enxame durante essa ação fica Envenenada até o início do seu próximo turno.

“Não dá tempo de contar todos! Só anote ‘centenas de mordidas de roedor’.”'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  15,
  'Força do Enxame',
  'Você pode chamar seus lacaios roedores para defesa. Quando sofrer dano de uma criatura que possa ver a até 3 m, pode gastar uma Reação para direcionar o dano a um enxame sob seu controle que possa ver a até 1,5 m de você.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  3,
  'Gatilho Instantâneo',
  'Você ganha proficiência com Pistolas de Pólvora Negra. Além disso, ao rolar Iniciativa sem Desvantagem nessa rolagem, pode imediatamente gastar uma Reação para uma das opções: fazer um ataque com arma ou Ataque Desarmado; mover-se até o Deslocamento sem provocar Ataque de Oportunidade; uma montaria controlada move-se até o Deslocamento sem provocar Ataque de Oportunidade; realizar a ação Esquivar ou Utilizar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  3,
  'Montaria Fiel',
  'Você sempre tem a magia Encontrar Corcel preparada. Com este recurso, pode conjurá-la sem espaço de magia nem componentes, e a habilidade de conjuração para ela é Inteligência. Depois de conjurá-la assim, não pode fazê-lo desse modo de novo até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  3,
  'Atropelar',
  'Você não precisa de Vantagem na jogada de ataque para Ataque Furtivo se você ou uma montaria controlada que monta se moverem pelo menos 6 m, e você não tiver Desvantagem na jogada de ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  9,
  'Senhor dos Cavalos',
  'Você pode gastar 1 minuto cuidando e tratando da montaria; ao final, ela ganha Pontos de Vida Temporários iguais ao dobro do seu nível de Ladino. Além disso, sua astúcia se estende ao corcel. Enquanto controlar uma montaria, ela pode realizar uma das seguintes ações como Ação Bônus: Disparar, Desengajar ou Esquivar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  13,
  'Determinação Inabalável',
  'Você ganha proficiência em salvaguardas de Constituição. Além disso, quando for sujeito a um efeito que permita salvaguarda de Constituição para sofrer apenas metade do dano, em vez disso não sofre dano se for bem-sucedido, e sofre apenas metade se falhar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  17,
  'Desesperado',
  'Quando você é reduzido a 0 Pontos de Vida e não é morto na hora, pode usar Gatilho Instantâneo imediatamente antes de ficar Inconsciente.

“As estradas secundárias estão perigosas demais. Nossa carruagem foi assaltada e saqueada três vezes… só hoje!”'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  3,
  'Olho Maligno',
  'Você pode lançar uma maldição menor com um olhar. Como Ação Bônus, escolha uma criatura que possa ver a até 18 m para ser amaldiçoada pelo seu Olho Maligno. Enquanto amaldiçoada assim, você pode causar dano de Ataque Furtivo a ela se não tiver Desvantagem na jogada de ataque. A criatura permanece amaldiçoada por 1 minuto ou até você amaldiçoar outra com o Olho Maligno, o que ocorrer primeiro.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  3,
  'Azarento',
  'Você aprende Azarões que pode infligir aos amaldiçoados pelo Olho Maligno.

Azarões. Você aprende dois Azarões de sua escolha, detalhados em “Azarões” abaixo. Aprende um Azarão adicional nos níveis 9, 13 e 17 de Ladino. Quando termina um Descanso Longo, pode substituir um Azarão conhecido por outro.

Pontos de Azar. Você tem 4 Pontos de Azar. Ganha 2 Pontos de Azar adicionais no 13º nível de Ladino. Para usar uma opção de Azarão, gasta o número de Pontos de Azar que ela custa. Recupera todos os Pontos de Azar gastos ao terminar um Descanso Curto ou Longo.

Salvaguardas. Se um Azarão exigir salvaguarda, a CD é 8 + modificador de Carisma ou Inteligência (sua escolha) + Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  9,
  'Roubar Sorte',
  'Quando uma criatura que você possa ver a até 9 m estiver prestes a fazer um Teste D20 com Vantagem, pode gastar uma Reação para impedir que a rolagem seja afetada por Vantagem. Ao fazê-lo, recupera 1 Ponto de Azar gasto. Depois de usar este recurso, não pode fazê-lo de novo até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  13,
  'Conjurador de Maldições',
  'Você pode gastar uma ação Mágica e 3 Pontos de Azar para conjurar Lançar Maldição.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  17,
  'Roubar Sorte Aprimorado',
  'Você pode usar Roubar Sorte três vezes e recupera todos os usos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  3,
  'Conjuração',
  'Você aprendeu a conjurar magias de Mago, bem como magias da escola de Sangromancia. Todas as magias e truques de Sangromancia são tratados como magias de Mago para esta subclasse.

Truques. Você conhece três truques da lista de Mago e da lista de Sangromancia. Sempre que ganha um nível de Ladino, pode substituir um truque por outro truque de Mago de sua escolha. Quando alcança o 10º nível de Ladino, aprende outro truque de Mago de sua escolha.

Espaços de Magia. A tabela Conjuração do Ladrão Sanguíneo mostra quantos espaços você tem para magias de 1º círculo ou superior. Recupera todos os espaços gastos ao terminar um Descanso Longo.

Magias Preparadas de 1º+. Você prepara a lista de magias de 1º+ disponíveis com este recurso. Para começar, escolha três magias de Mago de 1º círculo. O número aumenta conforme sobe de nível de Ladino, como na coluna Magias Preparadas. Sempre que o número aumenta, escolha magias adicionais de Mago até coincidir. As magias devem ser de um círculo para o qual você tenha espaços.

Mudando Magias Preparadas. Sempre que ganha um nível de Ladino, pode substituir uma magia da lista por outra magia de Mago para a qual tenha espaços.

Habilidade de Conjuração. Inteligência é sua habilidade de conjuração para magias de Mago.

Foco de Conjuração. Você pode usar um Foco Arcano como Foco de Conjuração para magias de Mago.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  3,
  'Poder Roubado',
  'Você extrai magia do sangue. Isso é representado pelos Dados de Sangromancia, que alimentam poderes desta subclasse. Você tem um pool de d8s que pode usar em recursos do Ladrão Sanguíneo. O número de dados no pool é igual ao número de dados de dano na coluna Ataque Furtivo da tabela de recursos de Ladino. Não pode ter mais Dados de Sangromancia do que esse número, a menos que tenha Dados de Sangromancia de outra fonte.

Magia de Sangue. Você pode gastar Dados de Sangromancia em vez de Dados de Vida ao conjurar magias de Sangromancia. O pool recupera todos os dados gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  3,
  'Roubar Sangue',
  'Quando causa dano de Ataque Furtivo, pode restaurar 1 Dado de Sangromancia. Se estiver Ferido, em vez de restaurar 1 Dado de Sangromancia ao causar dano de Ataque Furtivo, pode imediatamente rolar o dado e recuperar Pontos de Vida iguais ao total. Pode usar este recurso um número de vezes igual ao modificador de Inteligência (mínimo 1) e recupera todos os usos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  9,
  'Lâminas Sangrentas',
  'Quando você termina um Descanso Longo, pode gastar até 2 Dados de Vida ou Dados de Sangromancia para criar um número de Adagas igual ao número de dados gastos dessa forma. Cada Adaga conta como Foco Arcano para suas magias de Ladrão Sanguíneo, e você pode conjurar magias com componentes Somáticos mesmo empunhando essas armas em uma ou ambas as mãos. Além disso, quando obtém um Acerto Crítico com essa arma, pode fazer com que a arma cause dano extra ao alvo. O dano extra é um número de d8s igual ao número de Dados de Vida ou Dados de Sangromancia gastos neste recurso. O dano extra é Necrótico. As Adagas duram até você terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  13,
  'Costura Sangrenta',
  'Como ação Mágica, você pode gastar 3 Dados de Vida ou Dados de Sangromancia para lançar uma onda de estilhaços de sangue semelhantes a agulhas. Ao fazê-lo, cada criatura de sua escolha em uma Emanação de 9 m originada de você deve fazer uma salvaguarda de Destreza contra a CD de salvaguarda de magia, sofrendo 3d8 de dano Necrótico em caso de falha ou metade desse dano em caso de sucesso. Você recupera 1 Dado de Vida ou Dado de Sangromancia (sua escolha) por cada criatura reduzida a 0 Pontos de Vida por este recurso. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  17,
  'Saída Sangrenta',
  'Quando uma criatura o acerta com uma jogada de ataque, você pode gastar uma Reação e 5 Dados de Vida ou Dados de Sangromancia para transformar-se em névoa sanguínea. O ataque erra automaticamente, você pode se teletransportar até 9 m para um espaço desocupado que possa ver e retoma sua forma normal. Como parte dessa Reação, pode fazer um ataque com uma arma corpo a corpo imediatamente após o teletransporte. Em um acerto, esse ataque causa 5d8 de dano Necrótico extra ao alvo. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  3,
  'Magias — Apocalípticas',
  'Quando você alcança um nível de Feiticeiro indicado na tabela Magias — Apocalípticas, passa a ter sempre preparadas as magias listadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  3,
  'Anotações Desvairadas',
  'Você é obcecado por documentar suas visões. Ganha proficiência com Suprimentos de Calígrafo e pode criar Pergaminhos de Magia na metade do tempo e pela metade do custo em PO. Além disso, ao criar um Pergaminho de Magia, pode encantá-lo. Ao encantar um Pergaminho de Magia, deve gastar um espaço de magia igual ou superior ao nível da magia e pode gastar Pontos de Feitiçaria para aplicar uma de suas opções de Metamagia. Qualquer criatura que conheça ao menos um idioma pode usar seu Pergaminho de Magia encantado, que conjura a magia com o benefício da opção de Metamagia escolhida. O Pergaminho de Magia permanece encantado até ser usado ou até você terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  6,
  'Testemunhar',
  'Você passou a vida inteira se preparando para o fim do mundo. Enquanto seu recurso Feitiçaria Inata estiver ativo, ganha os seguintes benefícios. Endurecimento Apocalíptico. Você tem Resistência a dano de Força. Recitar Escrituras. Uma vez por Feitiçaria Inata ativa, como Ação Bônus você pode usar um Pergaminho de Magia cuja magia tenha tempo de conjuração de Ação. Impávido. Você é imune à condição Amedrontado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  6,
  'Apócrifa Arcana',
  'Suas reflexões obsessivas sobre o fim da existência inspiram sua escrita. Sempre que termina um Descanso Longo, você pode criar um Pergaminho de Magia sem custo. Deve ser uma magia de 5º círculo ou inferior que você possa conjurar. Esse Pergaminho de Magia se desintegra quando você termina um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  14,
  'Magia Proibida',
  'O fim de Etharis é um tempo em que a magia se liberta e poderes mágicos há muito ocultos são desenterrados. Ao conjurar uma magia de Feiticeiro usando um espaço de magia, você pode escolher uma opção abaixo. Excessivo. Se a magia exige um componente Material com custo, você pode conjurá-la sem o componente Material. Você sofre dano de Força igual a quatro vezes o nível do espaço de magia imediatamente após conjurá-la. Esse dano ignora Resistência e Imunidade. Inexorável. Sofrer dano não pode interromper sua Concentração na magia. Quando a magia termina, você ganha 1 nível de Exaustão. Pírrico. Se a magia exige uma jogada de ataque, ela acerta automaticamente e a jogada de ataque é um Acerto Crítico. Seu máximo de Pontos de Vida é reduzido em valor igual a quatro vezes o nível do espaço de magia imediatamente após conjurá-la. Quando você termina um Descanso Longo, seu máximo de Pontos de Vida volta ao normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  18,
  'O Fim Está Próximo',
  'Você proclama em voz alta o que acontecerá quando o mundo acabar. Como ação Mágica, descreve o fim dos dias. Ao fazê-lo, cada criatura de sua escolha em uma Emanação de 9 m originada de você deve fazer uma salvaguarda de Sabedoria contra a CD de salvaguarda de magia. Em caso de falha, a criatura sofre 6d6 de dano Psíquico e 6d6 de dano de Força e fica sob a condição Amedrontado por 1 minuto. Em caso de sucesso, a criatura sofre apenas metade do dano. Uma criatura Amedrontada pode repetir a salvaguarda no fim de cada um dos seus turnos, encerrando a condição Amedrontado em caso de sucesso. Se esse dano reduzir uma criatura a 0 Pontos de Vida, ela só pode ser revivida por uma magia Ressurreição Verdadeira ou Desejo. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo, a menos que gaste 6 Pontos de Feitiçaria (sem exigir ação) para restaurar seu uso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  3,
  'Magias — Assombradas',
  'Quando você alcança um nível de Feiticeiro indicado na tabela Magias — Assombradas, passa a ter sempre preparadas as magias listadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  3,
  'Sexto Sentido',
  'Quando você rola Iniciativa, pode adicionar seu modificador de Carisma à rolagem.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  3,
  'Companheiro Fantasma',
  'Você aprende a magia Encontrar Familiar e pode conjurá-la como ação Mágica sem gastar um espaço de magia. O familiar assume a forma de um Espectro, embora seja um Morto-vivo em vez de Celestial, Feérico ou Corruptor. Como ação Mágica, você pode ordenar que seu companheiro fantasma ganhe a condição Invisível até atacar ou até você conjurar uma magia através dele. Enquanto Invisível, não deixa evidência física de sua passagem e só pode ser rastreado por magia. Qualquer equipamento ou objeto que esteja segurando permanece visível. Além disso, ao realizar a ação Atacar, você pode abrir mão de um dos seus próprios ataques para permitir que seu familiar faça seu ataque Drenar Vida com sua Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  6,
  'Força do Espírito',
  'Seu vínculo com o companheiro fantasma o fortalece. Você ganha os seguintes benefícios: o máximo de Pontos de Vida do familiar aumenta em quatro vezes seu nível de Feiticeiro. Você pode conjurar magias como se estivesse no espaço do familiar. Quando usa sua ação para conjurar uma magia, pode usar uma Ação Bônus para ordenar que seu companheiro fantasma use seu ataque Drenar Vida com sua Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  6,
  'Palidez Mortífera',
  'Você tem Resistência a dano Necrótico e, ao conjurar uma magia de Feiticeiro que causa dano, pode causar dano Necrótico ou o tipo de dano normal da magia, à sua escolha.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  14,
  'Possessão Fantasma',
  'Como ação Mágica, você pode direcionar seu companheiro fantasma a possuir uma criatura de sua escolha a até 1,5 m do fantasma. O alvo faz uma salvaguarda de Carisma contra a CD de salvaguarda de magia. Em caso de falha, o companheiro fantasma entra no corpo do alvo por 1 minuto. Em caso de sucesso, o alvo resiste aos esforços de possessão e seu familiar não pode possuí-lo novamente por 24 horas. Uma vez que o companheiro fantasma possui o corpo de uma criatura, ele a controla. Os Pontos de Vida, Dados de Vida, Força, Destreza, Constituição, Deslocamento e sentidos do familiar são substituídos pelos da criatura. O companheiro fantasma mantém, no restante, suas estatísticas de jogo. Enquanto o alvo estiver possuído, você tem um elo telepático com o companheiro fantasma enquanto ambos estiverem a até 30 m. Você pode usar esse elo telepático para emitir ordens ao companheiro fantasma (sem exigir ação), a menos que esteja sob a condição Incapacitado. O companheiro fantasma faz o possível para obedecer em seu turno. Se concluir uma ordem e não receber nova direção sua, age e se move como quiser, focando em se proteger. Você pode ordenar que o alvo gaste uma Reação, mas deve gastar sua própria Reação para isso. Sempre que o alvo sofrer dano, ele repete a salvaguarda, encerrando a possessão sobre si em caso de sucesso, e o companheiro fantasma reaparece no espaço desocupado mais próximo. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  18,
  'Tornar-se Morte',
  'Você pode transmutar sua forma física em uma forma espectral quando está perto da morte. Quando for reduzido a 0 Pontos de Vida e não for morto imediatamente, pode cair para 1 Ponto de Vida em vez disso e ganhar Pontos de Vida Temporários iguais à metade do seu máximo de Pontos de Vida. No início de cada um dos seus turnos, você perde 10 Pontos de Vida Temporários e criaturas de sua escolha a até 9 m de você sofrem 10 de dano Necrótico. Enquanto tiver Pontos de Vida Temporários concedidos por este recurso, você tem Resistência a todo dano, Deslocamento de Voo de 9 m, pode Flutuar e pode atravessar espaços ocupados como se fossem Terreno Difícil. Se terminar seu turno em um espaço assim, é empurrado para o último espaço desocupado em que esteve. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo.

“Parece que, nas circunstâncias certas, um indivíduo sob assombração pode canalizar a energia do espírito em magia arcana. Profundamente inquietante.” — Relatório de campo do Inquisidor'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  3,
  'Amuleto da Má Sorte',
  'Você tem a capacidade de lançar um fragmento da sua maldição sobre outro ser temporariamente. Como Ação Bônus, escolha uma criatura que possa ver a até 9 m de si. A criatura escolhida tem Desvantagem no próximo Teste D20 que fizer antes do início do seu próximo turno. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Curto ou Longo, a menos que gaste 1 Ponto de Feitiçaria (sem exigir ação) para restaurar seu uso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  3,
  'Laços de Sangue',
  'Seus sentidos se afinam facilmente às forças sobrenaturais que causaram sua aflição herdada. Você sempre tem a magia Detectar o Bem e o Mal preparada e pode conjurá-la sem gastar um espaço de magia. Além disso, escolha um dos seguintes tipos de criatura como o ser que amaldiçoou seu ancestral: Feérico, Corruptor ou Morto-vivo. Em cada um dos seus turnos enquanto mantiver Concentração em Detectar o Bem e o Mal, inclusive no turno em que a conjurou, criaturas do tipo escolhido têm Desvantagem nas jogadas de ataque contra você, e você não pode ser possuído, Enfeitiçado ou Amedrontado por tais criaturas. Depois de conjurar a magia com este recurso, não pode fazê-lo dessa forma novamente até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  3,
  'Maldição Miserável',
  'Você sofre de uma maldição herdada de um ancestral que falhou em cumprir sua parte de um pacto com um poder de outro mundo. Escolha uma das seguintes maldições transmitidas a você. Descomunal. Seu ancestral foi amaldiçoado com um corpo descomunal. Você tem Desvantagem em testes de Destreza (Furtividade) para passar despercebido movendo-se em silêncio. Além disso, seu máximo de Pontos de Vida aumenta em 1 e aumenta em 1 sempre que você ganha outro nível de Feiticeiro. Por fim, você conta como uma categoria de tamanho maior ao determinar sua capacidade de carga. Noturno. Seu ancestral foi amaldiçoado a rejeitar a luz do dia. Você tem Desvantagem em testes de Sabedoria (Percepção) que dependam da visão enquanto estiver sob a luz do sol. Além disso, você enxerga normalmente em Luz Fraca e Escuridão — tanto mágica quanto não mágica — a até 36 m de si. Portador da Praga. Seu ancestral foi amaldiçoado com sintomas físicos de uma praga. Você tem Desvantagem em testes de Carisma (Persuasão) feitos para influenciar um Humanoide Indiferente a até 1,5 m de si. Além disso, você é Imune à condição Envenenado e tem Resistência a dano Necrótico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  6,
  'Compartilhar o Fardo',
  'Você sempre tem a magia Conceder Maldição preparada. Pode conjurá-la gastando 3 Pontos de Feitiçaria em vez de um espaço de magia. Ao conjurá-la dessa forma, a magia não exige Concentração e seu alcance muda para 18 m naquela conjuração.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  14,
  'Semblante Aterrorizante',
  'Como Ação Bônus, você pode adotar o semblante aterrorizante do ser que amaldiçoou seu ancestral por 10 minutos. Durante esse tempo, pode usar uma ação Mágica para fazer com que criaturas de sua escolha que você possa ver a até 9 m de si façam uma salvaguarda de Sabedoria. Em caso de falha, o alvo fica sob a condição Amedrontado até o fim do seu próximo turno. Além disso, enquanto Semblante Aterrorizante estiver ativo, você ganha o seguinte benefício com base no tipo de criatura escolhido com seu recurso Laços de Sangue. Feérico. Como Ação Bônus, você se teletransporta até 9 m para um espaço desocupado que possa ver. Corruptor. Você tem Resistência a dano de Frio e de Fogo. Morto-vivo. Quando sofrer dano de qualquer tipo que não seja Radiante, pode gastar uma Reação para reduzir o dano em metade do seu nível de Feiticeiro. Depois de usar Semblante Aterrorizante, não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  18,
  'Invocação Vingativa',
  'Sua magia tornou-se poderosa o bastante para chamar e comandar um servo daqueles que o amaldiçoaram. Escolha uma das seguintes criaturas com base na escolha feita com seu recurso Laços de Sangue: Lâmia ou Troll (somente Feérico), Diabo Espinhoso, Íncubo ou Súcubo (somente Corruptor), Fantasma ou Espectro (somente Morto-vivo). Você pode usar uma ação Mágica e gastar 5 Pontos de Feitiçaria para invocar a criatura escolhida. A criatura aparece em um espaço desocupado que você possa ver a até 18 m. Ela desaparece quando cai a 0 Pontos de Vida, quando você usa este recurso para invocar outra criatura ou após 10 minutos. A criatura é aliada sua e de seus aliados. Em combate, compartilha sua contagem de Iniciativa, mas age imediatamente após o seu turno. Obedece a seus comandos verbais (sem exigir ação sua). Se você não emitir nenhum, ela realiza a ação Esquivar e usa seu movimento para evitar perigo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  3,
  'Magias — Coven',
  'A magia do seu patrono garante que você sempre tenha certas magias prontas; quando alcança um nível de Bruxo indicado na tabela Magias — Coven, passa a ter sempre preparadas as magias listadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  3,
  'Olho da Bruxa',
  'Como agente de uma Bruxa, você recebeu um item mágico conhecido como Olho da Bruxa. Forjado a partir de um olho real e encaixado em um anel, pingente ou outro acessório, esse item pode ser usado como Foco Arcano para suas magias de Bruxo. A Bruxa pode ver através do olho, e a destruição do item pode causar-lhe dor real, de modo que qualquer peão que perca esse talismã frequentemente provoca a ira da Bruxa. Enquanto possuir o olho, você pode conjurar Azar um número de vezes igual ao seu modificador de Carisma (mínimo de uma vez) sem gastar um espaço de magia, e recupera todos os usos gastos dessa habilidade quando termina um Descanso Longo. Além disso, ao alcançar o 10º nível de Bruxo, pode usar o olho para conjurar Conceder Maldição uma vez sem gastar um espaço de magia, e recupera a capacidade de fazê-lo ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  6,
  'Astúcia da Bruxa',
  'Bruxas se deleitam em enganar e manipular os outros, e você ganha parte dessa habilidade. Você conhece o truque Ilusão Menor. Se já o conhecer, aprende um truque de Bruxo diferente de sua escolha. O truque não conta contra o número de truques conhecidos. Além disso, se uma criatura realizar a ação Estudar para examinar uma ilusão que você criou, você pode gastar uma Reação para impor Desvantagem no teste. Também, na primeira vez que uma criatura realizar a ação Estudar para examinar uma magia de ilusão que você conjurou e for bem-sucedida no teste de Inteligência (Investigação), você pode fazer a ilusão causar dano Psíquico. O dano é igual a 1d6 mais 1d6 por nível do espaço de magia usado para conjurar a magia. Você pode causar esse dano um número de vezes igual ao seu modificador de Carisma (mínimo de uma vez). Recupera todos os usos gastos quando termina um Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  10,
  'Semblante da Bruxa',
  'Como ação Mágica, você contorce o rosto em uma máscara horrenda que lembra sua patrona Bruxa. Dura 1 minuto, mas termina antecipadamente se você a dispensar (sem exigir ação) ou ficar sob a condição Incapacitado. Enquanto o efeito durar, você ganha os benefícios listados abaixo. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo. Olhar Horripilante. Como Ação Bônus, escolha um Humanoide que você possa ver e que possa vê-lo a até 9 m de você. A criatura deve fazer uma salvaguarda de Sabedoria contra a CD de salvaguarda de magia ou ficar sob a condição Amedrontado por 1 minuto. O alvo Amedrontado repete a salvaguarda no fim de cada um dos seus turnos, encerrando o efeito sobre si em caso de sucesso. Uma criatura que possa vê-lo tem Desvantagem nessa salvaguarda. Olhar Paralisante. Como ação Mágica, escolha um Humanoide que você possa ver e que possa vê-lo a até 9 m de você e que esteja sob a condição Amedrontado. A criatura deve fazer uma salvaguarda de Sabedoria contra a CD de salvaguarda de magia ou ficar sob a condição Paralisado. Em caso de sucesso, a criatura sofre dano Necrótico igual ao seu nível de Bruxo, deixa de estar Amedrontada e não pode ser alvo do seu Semblante da Bruxa novamente até você terminar um Descanso Longo. Olhar da Morte. Como ação Mágica, escolha um Humanoide que você possa ver e que possa vê-lo a até 9 m de você e que esteja sob a condição Paralisado. A criatura deve fazer uma salvaguarda de Sabedoria com Vantagem contra a CD de salvaguarda de magia ou ser reduzida a 0 Pontos de Vida. Em caso de sucesso, a criatura sofre dano Necrótico igual ao dobro do seu nível de Bruxo, deixa de estar Paralisada e não pode ser alvo do seu Semblante da Bruxa novamente até você terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  14,
  'Ofício da Bruxa',
  'A Bruxa transmite o conhecimento para criar dois itens mágicos. Você pode transformar temporariamente um recipiente comum em um Caldeirão da Bruxa gastando um espaço de magia. Esse caldeirão mágico dura 10 minutos. Durante esse tempo, você pode usar a ação Mágica para derramar três poções Comuns, duas Incomuns ou uma Rara. As poções perdem eficácia ao fim do seu próximo Descanso Curto ou Longo. Você recupera essa habilidade ao fim de um Descanso Longo. Além disso, ao terminar um Descanso Longo, pode gastar um espaço de magia e imbuir uma gema no valor de pelo menos 10 PO com magia, transformando-a em uma Pedra-Coração Menor. Esse item mágico concede ao portador Imunidade à condição Envenenado e a capacidade de conjurar Piscar uma vez sem gastar um espaço de magia. A magia na gema se desfaz após 24 horas e a gema se reduz a pó.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  3,
  'Drenar Vida',
  'Você ganha um poder inato de drenar a vida dos vivos. Depois de realizar a ação Atacar ou a ação Mágica, pode usar uma Ação Bônus para fazer um Ataque Desarmado. Em um acerto, o Ataque Desarmado causa dano Necrótico igual a 1d6 mais seu modificador de Carisma em vez do dano normal. Quando acerta uma criatura com Drenar Vida, pode gastar um espaço de magia de Magia do Pacto para causar 1d8 de dano Necrótico extra ao alvo, mais outro 1d8 por nível do espaço de magia. Ao gastar um espaço de magia dessa forma, você recupera Pontos de Vida iguais à quantidade de dano causado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  3,
  'Predador Noturno',
  'Como predador da noite, você foi abençoado com visão aprimorada na escuridão. Você tem Visão no Escuro com alcance de 18 m. Se já tiver Visão no Escuro, seu alcance aumenta em 18 m.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  3,
  'Magias — Primeiro Vampiro',
  'A magia do seu patrono garante que você sempre tenha certas magias prontas; quando alcança um nível de Bruxo indicado na tabela Magias — Primeiro Vampiro, passa a ter sempre preparadas as magias listadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  6,
  'Criatura da Noite',
  'Você sempre tem a magia Polimorfia preparada. Com este recurso, pode conjurá-la apenas sobre si mesmo sem gastar um espaço de magia e sem componentes Materiais para transformar-se em um Morcego, Rato ou Lobo. Suas estatísticas de jogo são substituídas pelo bloco de estatísticas da Besta, mas você mantém seu tipo de criatura; Pontos de Vida; Dados de Vida; valores de Inteligência, Sabedoria e Carisma; recursos de classe; idiomas; e talentos. Você também mantém suas proficiências em perícias e salvaguardas e usa seu Bônus de Proficiência nelas, além de ganhar as proficiências da criatura. Se um modificador de perícia ou salvaguarda no bloco de estatísticas da Besta for maior que o seu, use o do bloco. Você pode usar este recurso um número de vezes igual ao seu modificador de Carisma (mínimo de uma vez). Recupera todos os usos gastos quando termina um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  10,
  'Apetite Sobrenatural',
  'Quando você reduz um inimigo a 0 Pontos de Vida com seu recurso Drenar Vida, pode gastar uma Reação para consumir o último sopro de sua mortalidade fugaz. Ao fazê-lo, recupera um dos seus espaços de magia de Magia do Pacto gastos. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  14,
  'Noite Eterna',
  'Seu patrono vampiro concede-lhe um gosto da verdadeira imortalidade. Você deixa de envelhecer e ganha Resistência a dano Necrótico. Como Ação Bônus, ganha os seguintes benefícios por 1 minuto: no início de cada um dos seus turnos, recupera 1d6 Pontos de Vida se tiver pelo menos 1 Ponto de Vida e não estiver sob luz solar direta nem em água corrente. Se sofrer dano Radiante, não recupera Pontos de Vida deste recurso no início do seu próximo turno. Quando usar seu recurso Drenar Vida, pode causar 1d8 de dano Necrótico extra sem gastar um espaço de magia. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  3,
  'Sifão de Magia',
  'Seu patrono ensinou-o a sifonar magia dos inimigos e torná-la sua. Imediatamente após uma criatura que você possa ver a até 18 m conjurar uma magia, você pode gastar uma Reação para forçar a criatura a fazer uma salvaguarda de Carisma. A CD é igual à sua CD de salvaguarda de magia. Em caso de falha, essa criatura não pode conjurar novamente aquela magia até que 8 horas tenham passado. Enquanto o efeito durar, se a magia for de pelo menos 1º círculo e de um nível que você possa conjurar, você a tem preparada. O número máximo de círculos de magia que você pode ter sifonado de uma vez é igual a 1 mais seu modificador de Carisma (mínimo de 1). Se estiver sob a condição Incapacitado ou morrer, perde todas as magias sifonadas. Quando termina um Descanso Longo, perde todas as magias sifonadas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  3,
  'Espécime Físico',
  'Seu patrono aprimorou sua forma física para melhorar sua utilidade como hospedeiro e peão. Como Ação Bônus, uma vez por Descanso Longo, escolha um número de benefícios a seguir até o valor do seu modificador de Carisma (mínimo de um) que dure até você terminar um Descanso Longo. Sempre que terminar um Descanso Curto, pode escolher um dos benefícios selecionados e substituí-lo por outro desta lista. Seu máximo de Pontos de Vida aumenta em valor igual ao seu nível de Bruxo. Você ganha Visão no Escuro com alcance de 18 m. Se já tiver Visão no Escuro, seu alcance aumenta em 18 m. Seu Deslocamento aumenta em 1,5 m. Você tem Vantagem em salvaguardas para evitar ou encerrar a condição Envenenado. Sua distância de salto é triplicada e você ganha Deslocamento de Escalada igual ao seu Deslocamento. Adicione seu modificador de Carisma aos seus testes de Força (Atletismo) ou Destreza (Acrobacia).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  6,
  'Sentinela Simbiótica',
  'Seu patrono permanece alerta a ameaças ao hospedeiro o tempo todo. Você não pode ser surpreendido e tem Vantagem nas rolagens de Iniciativa. Também tem Vantagem em salvaguardas para evitar ou encerrar as condições Enfeitiçado e Amedrontado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  10,
  'Gerar Peão',
  'Você sempre tem a magia Dominar Pessoa preparada. Também pode conjurá-la uma vez sem um espaço de magia e recupera a capacidade de fazê-lo quando termina um Descanso Longo. Além disso, sofrer dano não pode interromper sua Concentração em Dominar Pessoa. Quando uma criatura for bem-sucedida na salvaguarda, sofre dano Psíquico igual ao seu nível de Bruxo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  14,
  'Regeneração Larval',
  'Quando você morre, um parasita larval explode do seu cadáver. Você controla o parasita. O parasita usa o bloco de estatísticas de Rato, exceto por ter seus Pontos de Vida; Dados de Vida; valores de Inteligência, Sabedoria e Carisma; recursos de classe; idiomas; e talentos. Não pode conjurar magias. Além disso, tem a seguinte habilidade: Possessão Escavadora. Como ação Mágica, o parasita pode fazer um Humanoide a até 1,5 m dele realizar uma salvaguarda de Força ou Destreza (sua escolha) contra a CD de salvaguarda de magia de Bruxo. Em caso de falha, o parasita escava para dentro da criatura, causando dano Perfurante igual ao seu nível de Bruxo. Enquanto escavado dentro de uma criatura, o parasita não pode realizar qualquer Ação, Ação Bônus ou Reação, tem Cobertura Total e tem Imunidade a todo dano exceto dano Psíquico. Em cada um dos turnos subsequentes da criatura, ela pode usar sua ação para fazer uma salvaguarda de Constituição contra a CD de salvaguarda de magia de Bruxo. Se a criatura for bem-sucedida, o parasita é expelido do corpo para um espaço desocupado de escolha da criatura a até 1,5 m dela. Se o parasita estiver escavado dentro da criatura quando o turno dela terminar, a criatura sofre dano Necrótico igual ao dobro do seu nível de Bruxo. Se esse dano reduzir a criatura a 0 Pontos de Vida, ela morre imediatamente, o parasita desaparece e você assume o corpo do Humanoide como se tivesse sido alvo da magia Reencarnar e tivesse rolado a espécie que o Humanoide tinha. Se você for devolvido à vida, como pela magia Revivificar, seu parasita desaparece imediatamente. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  3,
  'Justo e Torpe',
  'As magias listadas abaixo podem ser adicionadas ao seu grimório sem custo quando você alcança o nível associado. Cada vez que termina um Descanso Longo, escolha se está sifonando poder de Arquidemônios ou de Arquissarafins. Consulte a tabela abaixo correspondente à sua escolha; você pode preparar as magias listadas para o seu nível de Mago e inferiores, mas não pode preparar as da facção oposta. Por exemplo, se escolher Arquidemônio como poder sifonado, não pode preparar as magias listadas na seção Arquissarafim.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  3,
  'Segredos Roubados',
  'Você descobriu ou roubou poder secreto de agentes dos Arquidemônios e Arquissarafins. Ganha uma Invocação Mística de sua escolha. Pré-requisitos. Se uma invocação tiver um pré-requisito, você deve atendê-lo para aprendê-la. Se uma invocação tiver um pré-requisito de nível de Bruxo, use seu nível de Mago em vez disso. Por exemplo, se uma invocação exigir que você seja um Bruxo de 5º nível ou superior, pode selecioná-la ao alcançar o 5º nível de Mago. Substituir e Ganhar Invocações. Sempre que ganhar um nível de Mago, pode substituir uma das suas invocações por outra para a qual se qualifique. Não pode substituir uma invocação se ela for pré-requisito de outra invocação que você tenha. Você ganha uma invocação adicional ao alcançar os níveis de Mago 6 e 14. Não pode escolher a mesma invocação mais de uma vez, a menos que a descrição diga o contrário. Invocações Inteligentes. Você pode usar seu modificador de Inteligência em vez do modificador de Carisma nas suas invocações.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  6,
  'Línguas e Peles Emprestadas',
  'Sua capacidade de sifonar poder de Celestiais e Corruptores é aprimorada. Você ganha os seguintes benefícios. Dádiva do Arquidemônio. Enquanto estiver sifonando poder de Arquidemônios, você tem Resistência a dano Necrótico. Além disso, Corruptores que conheçam idiomas podem compreender sua fala e você pode compreender a deles, mesmo sem compartilhar um idioma. Dádiva do Arquissarafim. Enquanto estiver sifonando poder de Arquissarafins, você tem Resistência a dano Radiante. Além disso, Celestiais que conheçam idiomas podem compreender sua fala e você pode compreender a deles, mesmo sem compartilhar um idioma. Trocar de Lado. Como Ação Bônus, você pode mudar de qual poder está sifonando. Depois de trocar, não pode fazê-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  10,
  'Semblante Sobrenatural',
  'Como Ação Bônus, você adota um semblante infernal ou celestial por 10 minutos. Durante a duração, sua aparência ganha aspectos do poder que escolher. Você ganha os seguintes benefícios. Presença Imponente. Você tem Vantagem em testes de Carisma. Magias Aprimoradas. Ao gastar um espaço de magia para conjurar uma magia da tabela Arquidemônio ou Arquissarafim, a magia é conjurada como se você tivesse gasto um espaço de magia um nível acima. Asas Sobrenaturais. Você ganha Deslocamento de Voo de 18 m. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo. Também pode restaurar seu uso gastando um espaço de magia de 5º círculo ou superior (sem exigir ação).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  14,
  'Erupção da Guerra Eterna',
  'Você usa os poderes sob seu comando para evocar celestiais e infernais em guerra. Como ação Mágica, invoca uma manifestação da guerra entre Arquidemônios e Arquissarafins em uma Esfera de raio de 9 m centrada em um ponto a até 36 m de si. Cada criatura na Esfera deve fazer uma salvaguarda de Carisma contra a CD de salvaguarda de magia. Em caso de falha, a criatura sofre 4d10 de dano Necrótico, 4d10 de dano Radiante e fica sob a condição Cego até o fim do seu próximo turno. Em caso de sucesso, a criatura sofre apenas metade do dano. Como parte da mesma ação, você pode mudar o poder do qual está sifonando e também recupera 1 espaço de magia de Mago de sua escolha de 5º círculo ou inferior. Depois de usar este recurso, não pode usá-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  3,
  'Ofício de Poções',
  'Você ganha proficiência na perícia Medicina e proficiência com o Kit de Herbalismo e com Suprimentos de Alquimista. Além disso, aprendeu a criar poções mágicas. Criação. Com 10 minutos de trabalho ou ao terminar um Descanso Curto ou Longo, você pode preparar poções mágicas se tiver um Kit de Herbalismo ou Suprimentos de Alquimista. Ao fazê-lo, deve gastar um espaço de magia de 1º círculo ou superior para cada poção criada e escolher uma magia do seu grimório que tenha apenas uma criatura como alvo. A magia escolhida deve ser de nível igual ou inferior ao do espaço de magia gasto. Consumo. Como Ação Bônus, uma criatura pode beber a poção ou administrá-la a outra criatura a até 1,5 m dela. Quando uma criatura consome a poção, torna-se o alvo da magia como se você a tivesse conjurado. Se a magia exigir Concentração, a criatura que consome a poção Concentra-se nela. Poções não consumidas duram até você terminar um Descanso Longo ou até usar este recurso novamente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  3,
  'Boa Medicina',
  'Ao criar uma poção, você pode escolher gastar um espaço de magia sem escolher uma magia para criar uma dose de Boa Medicina. Como Ação Bônus, pode beber a dose ou administrá-la a outra criatura a até 1,5 m de si. Quando a Boa Medicina é consumida, role um número de d8s igual ao nível do espaço de magia gasto, e o alvo recupera Pontos de Vida iguais ao total da rolagem. Se você gastou um espaço de magia de 3º círculo ou superior neste recurso, a Boa Medicina também remove a condição Envenenado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  6,
  'Má Medicina',
  'Ao criar uma poção, você pode escolher gastar um espaço de magia sem escolher uma magia para criar uma dose de Má Medicina. Ao criar uma dose, escolha um efeito por nível do espaço de magia gasto. A criatura fica sob a condição Envenenado. O Deslocamento da criatura é reduzido à metade. A criatura sofre 1d4 de dano Necrótico extra na primeira vez que sofrer dano a cada turno. A criatura sofre 1d6 de dano de Veneno cada vez que realizar uma Ação, Ação Bônus ou Reação. A criatura sofre dano Ácido igual ao nível do espaço de magia gasto no início de cada um dos seus turnos. Como ação Mágica, você pode arremessar uma dose de Má Medicina em um ponto que possa ver a até 9 m. Criaturas a até 3 m desse ponto devem fazer uma salvaguarda de Constituição contra a CD de salvaguarda de magia. Em caso de falha, o alvo sofre um dos efeitos escolhidos por 1 minuto. Em cada um dos seus turnos, o alvo pode gastar uma ação e repetir a salvaguarda, encerrando o efeito sobre si em caso de sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  10,
  'Inalar',
  'A exposição persistente aos males mais mortais conhecidos concedeu-lhe alguma medida de resistência. Depois de sofrer dano Necrótico ou de Veneno, você ganha Pontos de Vida Temporários iguais ao dano sofrido. Além disso, é imune à condição Envenenado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  14,
  'Mestre Medicinal',
  'Quando a Boa Medicina restaura Pontos de Vida a uma criatura, essa criatura recupera 2d8 Pontos de Vida adicionais. Quando a Má Medicina causa dano Ácido a uma criatura, essa criatura sofre 2d8 de dano Ácido extra. Além disso, criaturas alvo têm Desvantagem na salvaguarda.

“É incrível o que se consegue com apenas algumas ervas e décadas de estudo intenso e obstinado.” — Tawnybruck Malore'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  3,
  'Especialista em Sangromancia',
  'Magias de Sangromancia contam como magias de Mago para você. Escolha duas magias de Sangromancia, cada uma de no máximo 2º círculo, e adicione-as ao seu grimório gratuitamente. Além disso, sempre que ganhar acesso a um novo nível de espaços de magia nesta classe, você pode adicionar uma magia de Sangromancia ao grimório gratuitamente. A magia escolhida deve ser de um nível para o qual você tenha espaços de magia.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  3,
  'Sangue Pleno',
  'Você extrai magia do sangue, representada pelos Dados de Sangromancia que alimentam os poderes desta subclasse. Você tem um conjunto de d12 que pode gastar no lugar de um Dado de Vida ao conjurar magias de Sangromancia. O número de dados no conjunto é igual a 1 mais o seu nível de Mago. Você recupera 1 Dado de Sangromancia ao terminar um Descanso Curto e todos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  6,
  'Vigor Sanguíneo',
  'Seu máximo de Pontos de Vida aumenta em 6 e aumenta em 1 sempre que você ganha um nível de Mago. Além disso, sempre que conjura uma magia de Sangromancia gastando um espaço de magia, recupera Pontos de Vida iguais ao nível do espaço gasto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  10,
  'Sangue por Sangue',
  'Uma vez em cada um dos seus turnos, quando você causar dano a uma ou mais criaturas com uma magia de Mago que conjurou, pode gastar um Dado de Vida ou um Dado de Sangromancia, rolar o dado e causar dano extra a uma dessas criaturas igual ao resultado. Se a criatura estiver Ferida, você rola duas vezes e usa o maior resultado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  14,
  'Renovação Rubra',
  'Ao terminar um Descanso Curto, recupera Dados de Vida e Dados de Sangromancia gastos em quantidade igual à metade do seu nível de Mago. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
