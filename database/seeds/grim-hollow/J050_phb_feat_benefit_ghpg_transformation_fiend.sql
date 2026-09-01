-- J050 — Corruptor (gh-transformation-fiend)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 1, 'Como começar', 'Um mortal pode tornar-se Corruptor de várias maneiras. Alguns perdem a alma e tornam-se um ao morrer. Outros realizam rituais agonizantes para receber poder terrível de um Arquidaemônio. Alguns mortais podem tornar-se Corruptores sem intenção, como recompensa ou punição por uma vida de crueldade e maldades. Ainda assim, é raro que uma criatura seja escolhida para integrar as legiões do Submundo sem antes ter feito um pacto por tal dádiva.

Conversar com o Mestre sobre criar acordos com mortais na história é uma excelente forma de interpretar sua influência no mundo do jogo. Como Corruptor, considere as motivações do personagem e quais PNJs podem ajudá-lo a alcançar seus objetivos.

Você está a serviço de um Arquidaemônio ou divindade sombria específicos? Segue apenas suas próprias ambições, fazendo os pactos necessários para isso? Que maldades você infligirá ao mundo, e com que fins? Corruptores raramente agem sem ambição, mesmo que seja simplesmente corromper tantos mortais quanto conseguir convencer a assinar um contrato.

Reverter traços de Corruptor

Tornar-se Corruptor costuma exigir atos de grande maldade. Você pode ter realizado sacrifícios de sangue ou feito pactos que causaram sofrimento a outros. Nem mesmo magia do nível da magia Desejo poderia expiar suas ações ou redimir sua alma. Somente depois de realizar um ato de sacrifício ou expiação incríveis tal magia poderia remover as bênçãos e falhas da Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Corruptor pela primeira vez, ganha a Bênção Alma Corruptora e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 3, 'Bênção do estágio 1: Alma Corruptora', 'Você torna-se um Corruptor além de qualquer outro tipo de criatura que tenha. Você tem Vantagem em testes de Carisma (Enganação).

Além disso, escolha um dos seguintes tipos de dano e ganhe Resistência a ele: Ácido, Gélido ou Fogo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 4, 'Bênção do estágio 1: Contratante Diabólico', 'Você adquiriu a capacidade de vincular criaturas mortais à sua vontade. Pode criar um contrato para prender a alma de um Humanoide mortal a você, alimentando-se de seu poder. O mortal recebe um presente pedido no contrato, e você ganha uma Dádiva da Perdição de sua escolha. (Consulte Dádivas da Perdição ao final desta Transformação.)

Para prender a alma de um mortal, primeiro deve elaborar um contrato para o presente desejado. Um contrato exige tinta e papel mágicos no valor de 10 PO por Estágio de Transformação que você adquiriu.

Você e o mortal devem assinar o contrato de livre vontade, plenamente cientes dos custos. Uma vez assinado, entidades demoníacas concedem a você uma Dádiva da Perdição, e o mortal recebe seus desejos em até 7 dias. Você não precisa fornecer essa bênção pessoalmente.

Por exemplo, ao assinar um contrato por uma Dádiva da Glória Irrestrita, você recebe os benefícios listados para essa dádiva. O mortal que assina recebe seu desejo declarado, providenciado pelos poderes duvidosos do Submundo. Você não pode se beneficiar diretamente do presente desejado pelo mortal, nem um aliado. Nenhum aliado seu pode jamais assinar um contrato com você.

Você pode escolher uma Dádiva da Perdição do estágio que alcançou ou inferior. Por exemplo, se está no estágio 2 da Transformação, só pode escolher uma Dádiva da Perdição de estágio 1 ou 2.

Não há limite para o número de contratos que pode firmar, mas só pode ter uma Dádiva da Perdição ativa por vez. Quando ganharia uma segunda Dádiva da Perdição, pode substituir a ativa pela nova. Além disso, ao terminar um Descanso Longo, pode trocar sua Dádiva da Perdição ativa por qualquer outra dádiva associada a um contrato assinado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 5, 'Bênção do estágio 1: Punição Infernal', 'Uma vez em cada um dos seus turnos, pode escolher uma criatura que acabou de ferir com um ataque com arma, um Ataque Desarmado ou um truque. Cause 1d6 de dano extra de Ácido, Gélido ou Fogo a essa criatura, usando o mesmo tipo de dano escolhido para Alma Corruptora. Pode adicionar esse dano um número de vezes igual ao seu Bônus de Proficiência mais seu Estágio de Transformação, mas não mais de uma vez por jogada de dano. Recupera todos os usos ao terminar um Descanso Curto ou Descanso Longo.

Em Estágios de Transformação mais altos, causa 1d6 de dano adicional por Estágio de Transformação, totalizando 2d6 no estágio 2, 3d6 no estágio 3 e 4d6 no estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 6, 'Falha do estágio 1: Vinculado ao Submundo', 'Seu corpo e alma estão presos ao Submundo. Você tem Desvantagem em Salvaguardas contra a Morte enquanto o plano tenta puxá-lo para dentro dele.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 7, 'Estágio 2', 'Para avançar de um estágio para o próximo nesta Transformação, deve ocorrer um evento ou outra ocorrência notável ligada à história do personagem. Os eventos a seguir são sugestões que podem desencadear a passagem ao próximo estágio da Transformação:

Quando você alcança o estágio 2 da Transformação em Corruptor, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 8, 'Bênção do estágio 2: Marca Demoníaca', 'Como Ação Bônus no seu turno, pode marcar com um sinal ardente uma criatura a até 18 m de você que possa ver; a marca permanece por 1 minuto. Se o alvo passar em uma salvaguarda de Sabedoria, não é marcado. A CD da salvaguarda é 8 + seu Bônus de Proficiência + seu Estágio de Transformação.

Se a criatura falhar na salvaguarda, escolhe um dos efeitos a seguir, que dura pela duração:

• A criatura sofre –2 em todas as salvaguardas.
• O primeiro ataque contra a criatura em cada turno é feito com Vantagem.
• A criatura não pode recuperar Pontos de Vida.

Pode usar essa habilidade um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 9, 'Bênção do estágio 2: Contrato Aprimorado', 'Pode alternar entre sua Dádiva da Perdição ativa ao fim de um Descanso Curto ou Descanso Longo. Além disso, ao trocar de Dádivas da Perdição, ganha Pontos de Vida Temporários iguais a 5 vezes seu Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 10, 'Falha do estágio 2: Forma de Corruptor', 'Sua aparência transformou-se grotescamente. Sua pele fica vermelha e coriácea, e chifres, dentes e garras ferozes rompem a superfície da pele. Pode suprimir essa forma e apresentar a aparência do humanoide que um dia foi, mas isso é exaustivo e exige esforço. Momentos de estresse provavelmente revelarão sua verdadeira natureza. Nas situações a seguir, sua forma verdadeira pode ser revelada:

• Ficar Ferido.
• Concentração em uma magia.
• Receber a condição Inconsciente.
• Entrar em terreno sagrado.
• Entrar na presença de Celestiais ou outros Corruptores.
• Escolher revelar-se voluntariamente.

Nesses eventos, ou em momentos de estresse emocional ou físico extremo, o Mestre pode exigir uma salvaguarda de Constituição com CD baseada no seu Estágio de Transformação atual (estágio 2: CD 13; estágio 3: CD 16; estágio 4: CD 20). Se falhar, sua Aparência Horrível é revelada.

Criaturas não malignas que testemunharem sua forma verdadeira tornam-se instantaneamente Hostis a você, salvo decisão contrária do Mestre.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 11, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Corruptor, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 12, 'Bênção do estágio 3: Subcontratante Diabólico', 'Pode receber os benefícios de duas Dádivas da Perdição ao mesmo tempo. Ainda pode trocar apenas uma Dádiva da Perdição após um Descanso Curto ou Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 13, 'Bênção do estágio 3: Marca Avassaladora', 'Pode aplicar um dos efeitos adicionais a seguir a uma criatura sob o efeito da sua Marca Demoníaca:

• A Velocidade da criatura é reduzida à metade, e você pode mover a criatura até 3 m horizontalmente no seu turno (não exige ação).
• A criatura tem a condição Cego. No seu turno, pode escolher remover essa condição (não exige ação).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 14, 'Falha do estágio 3: Puxão do Submundo', 'Seu novo plano natal tenta puxá-lo para si, reivindicando sua forma. Sempre que rolar 1 natural em um Teste D20, sofre 6d6 de dano Psíquico enquanto os habitantes do plano infernal tentam desvincular sua alma do Plano Material. Esse dano só pode ser sofrido uma vez por Descanso Curto e ignora todas as Resistências e Imunidades. Se esse dano reduzir seus Pontos de Vida a 0, você morre e sua alma é levada imediatamente ao Submundo. Só pode ser trazido de volta à vida por magias de 7º nível ou superior.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 15, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Corruptor, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 16, 'Bênção do estágio 4: Resistência Abissal', 'Você ganha Imunidade ao tipo de dano escolhido para Alma Corruptora e Resistência aos outros dois tipos. Além disso, tem Resistência a dano de ataques com armas não mágicas ou Ataques Desarmados.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 17, 'Bênção do estágio 4: Convocação Infernal', 'Como ação Mágica, pode abrir um portal para o Submundo e convocar até quatro Corruptores de ND 4 ou menos a até 9 m de você. Os Corruptores permanecem por 1 minuto antes de desaparecer de volta ao Submundo. (O Mestre decide quais Corruptores respondem à convocação.)

Os Corruptores convocados são Aliados a você e seus companheiros. Agem imediatamente depois de você na ordem de iniciativa. Obedecem a quaisquer comandos verbais que você lhes der (não exige ação sua). Se não emitir comandos, usam a ação Esquivar no turno deles e não fazem outro movimento, Ações Bônus ou Reações, a não ser para se proteger.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 18, 'Bênção do estágio 4: Marca Suprema', 'Quando uma criatura afetada pela sua Marca Demoníaca inicia o turno, pode usar uma Reação para ditar seu movimento e a ação que realiza. Se o fizer, a criatura repete a salvaguarda de Sabedoria inicial ao fim do turno. Em caso de sucesso, você não pode usar essa Reação novamente enquanto a marca durar.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 19, 'Falha do estágio 4: Nome Verdadeiro', 'Sua transformação em Corruptor está completa e você renasce. Os habitantes do Submundo atribuem a você um novo nome, que se torna seu Nome Verdadeiro. Você recebe um talismã de enxofre e latão com seu nome verdadeiro inscrito em Infernal.

Uma criatura com ND 10 ou superior a até 3 m de você que conheça seu Nome Verdadeiro pode usar uma ação Mágica e pronunciar seu Nome Verdadeiro. Você deve passar em uma salvaguarda de Carisma CD 20 ou sofrer os efeitos a seguir por 1 minuto. Pode tentar uma salvaguarda de Carisma ao fim de cada um dos seus turnos para encerrar os efeitos:

• Você tem a condição Encantado, mesmo que seja Imune a ser Encantado.
• Como Ação Bônus, a entidade que pronunciou seu Nome Verdadeiro pode forçá-lo a se mover até sua Velocidade e usar sua ação para atacar com uma arma, usar Ataque Desarmado ou lançar um truque contra um alvo de sua escolha.
• Todos os ataques contra você têm Vantagem, e você tem Desvantagem em salvaguardas.
• Você não pode recuperar Pontos de Vida nem ter Pontos de Vida Temporários. Perde imediatamente quaisquer Pontos de Vida Temporários que tenha.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 20, 'Dádivas da Perdição', 'As Dádivas da Perdição são os benefícios que você ganha ao oferecer presentes a mortais em troca de suas almas, por meio da Bênção Contratante Diabólico.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 21, 'Dádivas do estágio 1', 'Você pode ganhar Dádivas do estágio 1 sempre que assinar um contrato infernal com uma vítima.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 22, 'Dádiva da Vida Jocosa', 'At the beginning of your turn, se você are Ferido , você pode choose to roll a Dado de Vida (no action required) and regain um número de Pontos de Vida igual a the roll. Se você roll a 1 on this die, você recupera no Hit points and take 1 point of dano de Força instead. You regain this ability when you finish a Short or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 23, 'Dádiva do Talento Prodigioso', 'Choose two Skills. Gain Especialização in the chosen skills.

Se você roll a 1 or 2 on an Ability Check using one of the chosen skills, you immediately lose half your maximum number of Dados de Vida , rounded down. You do not regain Dados de Vida lost this way until you finish two Descanso Longos.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 24, 'Dádiva da Fortuna Inigualável', 'When an enemy você pode see within 3 m succeeds on uma jogada de ataque or a salvaguarda, você pode use your Reação to roll d20. On a 6 or higher, the triggering attack or save misses or fails, and você recupera the use of your Reação. Otherwise, you take 1d6 dano Psíquico per Estágio de Transformação, which cannot be reduced. You regain your use of this ability when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 25, 'Dádivas do estágio 2', 'Você pode ganhar Dádivas do estágio 2 sempre que assinar um contrato infernal com uma vítima while at Stage 2 or higher of the Corruptor Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 26, 'Dádiva da Liberdade Libertadora', 'Como Ação Bônus while aren''t wearing armadura pesada, você pode manifest a pair of leathery wings. Você ganha um Fly Speed igual a half your Speed. These wings recede se você dismiss them como Ação Bônus no seu turno, se você have the Unconscious condition, or se você become Ferido while they are manifested.

Você pode have your wing manifested por 1 hora total, including several shorter stints adding up to 1 hour. You regain your ability to use your wings for an hour after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 27, 'Dádiva da Glória Irrestrita', 'Each time you damage a creature with a melee attack, an Ataque Desarmado , or a cantrip, você pode do an additional 2 points Force Damage per Estágio de Transformação.

Each time you roll a Dado de Vida to regain Pontos de Vida during a Descanso Curto, você recupera 2 Pontos de Vida fewer per Hit Die.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 28, 'Dádivas do estágio 3', 'Você pode gain these Gifts whenever you sign a victim to an infernal contract while at Stage 3 or higher of the Corruptor Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 29, 'Dádiva das Segundas Chances', 'Quando você are reduced to 0 Pontos de Vida, você pode use your Reação to roll a Dado de Vida. Se você roll a 2 or better, set your Hit Point total to the result of the roll. If not, you suffer a Death Salvaguarda failure. You regain the use of this gift when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 30, 'Dádiva do Amor Incondicional', 'When a creature você pode see within 9 m of you fails a salvaguarda, você pode use your Reação to gain Pontos de Vida Temporários igual a 1d10 mais seu Estágio de Transformação. You regain the use of this gift when you finish a Short or Descanso Longo.

Se você roll a 1 on the die, you gain no Pontos de Vida Temporários and instead have the condição Caído.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 31, 'Dádivas do estágio 4', 'Você pode gain these Gifts whenever you sign a victim to an infernal contract while at Stage 4 of the Corruptor Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 32, 'Dádiva da Prowess Marcial', 'Uma vez por turno, when you miss with a weapon attack or Ataque Desarmado , você pode reroll the jogada de ataque. If the reroll hits, you must spend 3 Dados de Vida and add the result to the attack’s normal damage as dano de Força. If the reroll misses, you must spend 3 Dados de Vida and take dano Psíquico igual a the result. Se você have fewer than 3 Dados de Vida available, você podenot use this gift.

Uma vez você hit a target with an attack using a rerolled attack, você podenot use it again until you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 33, 'Dádiva do Poder Desenfreado', 'Upon finishing a Descanso Curto, você pode spend 2 Dados de Vida and regain um número de espaço de magia levels igual a the highest number rolled. However, you take dano Psíquico igual a twice the total that you rolled. You regain the reuse of this gift when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 34, 'Apêndice: Corruptor Form Save CD', 'Stage | Constituição Save CD
2 | 13
3 | 16
4 | 20') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 35, 'Apêndice: Reverter traços de Corruptor', 'Reverter traços de Corruptor

Transforming into a Corruptor usually requires deeds of great evil. You may have performed blood sacrifices or made bargains that resulted in others suffering. Even magic on the level of the magia Desejo could not atone for your actions or redeem your soul. Only once you perform a deed of incredible sacrifice or atonement could such magic remove your Transformação boons and flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
