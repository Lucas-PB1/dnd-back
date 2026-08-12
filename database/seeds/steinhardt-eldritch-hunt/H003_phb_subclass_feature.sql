-- Seed Steinhardt Eldritch Hunt — subclass features (Player Pack)
-- Fonte: docs/source/new (capítulo Subclasses)

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'),
  3,
  'Coração Galvânico',
  'O relâmpago faz parte de você. Você ganha Resistência a dano Elétrico. Se já tiver essa Resistência, pode reduzir ainda mais o dano Elétrico: role um número de d6 igual ao seu bônus de dano de Fúria e some-os (após aplicar a Resistência).

CD de Salvaguarda do Recipiente. Se um recurso desta subclasse exigir salvaguarda, a CD é 8 + seu modificador de Constituição + Bônus de Proficiência.

Dano do Recipiente. Alguns recursos usam Dano do Recipiente: role um número de d4 igual ao seu bônus de dano de Fúria e some-os. Esse dano extra é sempre Elétrico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'),
  3,
  'Tempestade Desamarrada',
  'Enquanto sua Fúria estiver ativa, você pode liberar relâmpago com as opções a seguir.

Correntes Eletrificadas. Ação Bônus: correntes de relâmpago envolvem sua arma. Na próxima vez que você acertar uma criatura neste turno, ela sofre seu Dano do Recipiente e fica enredada até o início do seu próximo turno. Cada vez que tentar se mover mais de 3 m enquanto enredada, deve fazer um teste de Força (Atletismo) contra sua CD do Recipiente; em sucesso, liberta-se. Em falha, sofre seu Dano do Recipiente e sua Velocidade cai a 0 até o início do seu próximo turno.

Golpe Fulgurante. Quando acerta com ataque corpo a corpo com arma, pode deixar a arma embutida por um instante e imediatamente usar Ação Bônus para invocar relâmpago dos céus contra o alvo (usando a arma como condutor) antes de recuperá-la. O alvo sofre seu Dano do Recipiente, e cada outra criatura numa Emanação de 3 m a partir do alvo deve passar numa salvaguarda de Destreza ou sofrer o mesmo dano. Você tem Vantagem nessa salvaguarda.

Passo Relâmpago. Ação Bônus: mova-se até metade da sua Velocidade. Se terminar esse movimento a até 1,5 m de uma criatura, ela sofre seu Dano do Recipiente. Se houver várias, escolha uma.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'),
  6,
  'Queda Estrondosa',
  'Como parte de entrar em Fúria, você pode saltar e cair num espaço no chão que possa ver a até 9 m que não esteja ocupado por criatura Enorme ou maior. Cada criatura numa Emanação de 3 m a partir do destino faz salvaguarda de Destreza, sofrendo o dobro do seu Dano do Recipiente em falha ou metade em sucesso.

Se uma criatura estiver no espaço de destino, ela tem Desvantagem na salvaguarda e é empurrada 1,5 m para um espaço desocupado à escolha dela. Se não houver espaço, fica Caída.

No nível 10 de Bárbaro, o salto aumenta para 18 m e você pode pousar em espaços ocupados por criaturas Enormes. No nível 14, aumenta para 27 m e pode pousar em espaços ocupados por qualquer criatura.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'),
  10,
  'Reflexos Relâmpago',
  'Sempre que fizer um teste de Destreza, ganha bônus igual ao seu modificador de Constituição (mínimo +1).

Além disso, enquanto a Fúria estiver ativa, você pode usar Passo Relâmpago uma vez em cada um dos seus turnos sem gastar Ação Bônus.

Lembrete: Iniciativa é um teste de Destreza.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-lightning-vessel'),
  14,
  'Fera Elétrica',
  'Você pode adicionar seu modificador de Constituição ao Dano do Recipiente, e as opções de Tempestade Desamarrada melhoram:

Correntes Eletrificadas. A criatura enredada deve fazer o teste de Força (Atletismo) se tentar se mover 1,5 m; em falha, não pode fazer Reações até o início do seu próximo turno.

Golpe Fulgurante. A Emanação aumenta para 6 m, e você pode escolher um número de criaturas igual ao seu modificador de Constituição (mínimo uma) que passam automaticamente na salvaguarda.

Passo Relâmpago. Ao avançar, pode mover-se até sua Velocidade completa e optar por fundir-se ao relâmpago, teleportando a distância percorrida em vez de caminhar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  3,
  'Magias do Círculo da Simbiose',
  'Quando você atinge um nível de Druida indicado na tabela, passa a ter sempre preparadas as magias listadas.

Nível 3: Canhão de Braço, Memórias Calcificadas, Casca Fraturada, Tiro Falângico, Bordão Místico.
Nível 5: Mandíbula Deslocadora, Empalamento Ósseo.
Nível 7: Espantalho do Pavor, Donzela dos Ossos.
Nível 9: Floresta do Pavor, Passo Arbóreo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  3,
  'Poderes Enxertados',
  'Você ganha uma das opções a seguir (à sua escolha). Os elementos podem ser visíveis ou não, ou representados por outros aspectos naturais.

Costas de Urso. Você conta como um tamanho maior para capacidade de carga e para agarrar. Além disso, pode adicionar seu modificador de Sabedoria a qualquer teste de Força.

Cabeça de Cervo. Você tem Vantagem em testes de Sabedoria (Percepção).

Cascos de Bode. Você tem Vantagem em salvaguardas para evitar a condição Caído. Ganha Deslocamento de Escalada igual à sua Velocidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  3,
  'Beemote de Osso-Vime',
  'Como Ação Bônus enquanto não estiver vestindo armadura nem empunhando Escudo, você pode gastar um uso de Forma Selvagem para despertar a fúria da Natureza e tornar-se um beemote por 10 minutos (ou até usar Forma Selvagem de novo):

• Cada braço conta como um Porrete sob efeito de Bordão Místico, e você pode usar a propriedade de maestria da arma. Pode usar as mãos normalmente, mas tem Desvantagem em testes de Destreza (Prestidigitação) com elas.
• Você está sob efeito de Pele-Casca (sem Concentração).
• Sempre que uma criatura o danifica com um ataque, sua pele estilhaça e cada criatura à sua escolha a até 1,5 m sofre 1d4 de dano Perfurante (2d4 a partir do nível 10 de Druida).
• No início de cada um dos seus turnos, você recupera PV iguais à metade do dano sofrido desde o início do turno anterior, até no máximo cinco vezes seu Bônus de Proficiência. Esta regeneração não funciona se você estiver Inconsciente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  6,
  'Ataque Extra',
  'Você pode atacar duas vezes, em vez de uma, sempre que realizar a ação Atacar no seu turno. Além disso, pode conjurar um dos seus truques no lugar de um desses ataques.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  10,
  'Ira da Natureza',
  'Você está permanentemente sob efeito de Pele-Casca.

Além disso, enquanto Beemote de Osso-Vime estiver ativo, seu tamanho é Grande e, sempre que realizar a ação Atacar, ganha Resistência a dano Contundente, Perfurante e Cortante até o fim do seu próximo turno. Você perde essas Resistências cedo se sofrer dano de Fogo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-symbiosis'),
  14,
  'Coração de Espinho',
  'Enquanto for beemote de Beemote de Osso-Vime, você pode usar a propriedade de maestria Nick além de Slow com seus braços.

Além disso, se realizar a ação Atacar no seu turno, pode usar Ação Bônus para conjurar qualquer magia de Osteomancia* com tempo de conjuração de uma ação.

*Magias de Osteomancia: Canhão de Braço, Arremesso de Osso Frágil, Memórias Calcificadas, Mandíbula Deslocadora, Espantalho do Pavor, Floresta do Pavor, Casca Fraturada, Donzela dos Ossos, Transplante de Medula, Empalamento Ósseo, Tiro Falângico, Cauda Esquelética.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  3,
  'Golpe de Sangue',
  'Você aprende a liberar as propriedades destrutivas do seu sangue. Ao ganhar este recurso, aprende três opções de Golpe de Sangue à sua escolha.

Uma vez por turno, quando fizer um ataque com arma como parte da ação Atacar, pode aplicar uma opção a esse ataque (antes ou depois do acerto, salvo se a opção não envolver jogada de ataque). Ao usar um Golpe de Sangue, você sofre dano Necrótico igual a uma rolagem do Custo de Sangue; esse dano não pode ser reduzido ou impedido. Um Golpe de Sangue é um efeito mágico.

Você pode usar este recurso um número de vezes igual a 1 + seu modificador de Constituição (mínimo 1), recuperando todos os usos ao terminar um Descanso Curto ou Longo.

Aprende uma opção adicional nos níveis 5, 9, 13 e 17 de Guerreiro. Sempre que aprender uma nova, pode substituir uma que conhece.

CD do Golpe de Sangue. 8 + modificador de Constituição + Bônus de Proficiência.

Opções (ordem alfabética):

Golpe Enfeitiçante — Custo 1d8. Extra 2d6 Psíquico; salvaguarda de Sabedoria ou o alvo trata um aliado a até 9 m como inimigo até o início do seu próximo turno. (4d6 no nível 18.)

Golpe Ferver-Sangue — Custo 1d6. Ao acertar, o alvo e cada outra criatura numa Emanação de 3 m sofrem 2d6 Fogo e começam a queimar; ignora Resistência a Fogo. (4d6 no nível 18.)

Golpe Estilhaço-Sangue — Custo 1d8. Em vez de jogada de ataque: Linha de 2,5 cm × 18 m; cada criatura faz salvaguarda de Destreza, sofrendo dano como se acertada pela arma + 1d6 Perfurante em falha ou metade em sucesso. (3d6 no nível 18.)

Golpe Constritor — Custo 1d8. Extra 2d6 Ácido, Desvantagem no próximo ataque; salvaguarda de Destreza ou sofre 2d6 Ácido na primeira vez em cada turno que se mover 1,5 m+ sem teleportar. Ação + Força (Atletismo) para remover (1 minuto ou até reusar). (4d6 no nível 18.)

Golpe do Exílio — Custo 1d10. Salvaguarda de Carisma ou banido (Velocidade 0, Incapacitado) até o fim do próximo turno do alvo. (No nível 18, também 2d6 Radiante no acerto.)

Golpe da Caça — Custo 1d4. Próximo ataque ignora bônus de CA de escudos, armadura ou efeitos mágicos (Escudo, Armadura Arcana etc.). Extra 1d6 Cortante; por 1 minuto você conhece a localização exata do alvo e ele não ganha Vantagem contra você por Invisível. (3d6 no nível 18.)

Golpe Sangue-Sombra — Custo 1d6. Extra 2d6 Necrótico; névoa de Escuridão mágica numa Emanação de 3 m até o início do seu próximo turno (Visão no Escuro e luz não mágica não atravessam). (4d6 no nível 18.)

Golpe Sangue-Trovão — Custo 1d4. Extra 2d6 Trovão e empurrado 4,5 m; salvaguarda de Força ou Caído. (4d6 no nível 18.)

Golpe Definhante — Custo 1d6. Extra 2d6 Necrótico; salvaguarda de Constituição ou o dano dos ataques do alvo é reduzido à metade até o início do seu próximo turno. (4d6 no nível 18.)'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  3,
  'Anatomia do Sabujo de Sangue',
  'Você é imune a contágios mágicos, tem Resistência a dano de Veneno e Vantagem em salvaguardas para evitar ou encerrar a condição Envenenado.

Além disso, após ter combatido uma criatura, tem Vantagem em qualquer teste de Inteligência (Investigação) ou Sabedoria (Percepção ou Sobrevivência) para encontrar uma criatura à qual você tenha causado dano e que tenha sangue.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  7,
  'Armamento de Sangue',
  'Enquanto empunhar uma arma e não estiver Inconsciente, essa arma é considerada revestida de sangue. Pode causar dano Ácido, Necrótico ou de Veneno (à sua escolha) em vez do tipo normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  7,
  'Explosão de Sangue',
  'Quando errar uma jogada de ataque com arma revestida de sangue, pode imediatamente usar Ação Bônus para detonar o sangue. O alvo e cada outra criatura numa Emanação de 1,5 m fazem salvaguarda de Constituição: em falha, sofrem dano como se acertados pela arma; em sucesso, metade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  10,
  'Sangue da Criação',
  '• Ao rolar o Custo de Sangue de um Golpe de Sangue, pode rerrolar e escolher o menor resultado.
• Sempre que terminar um Descanso Longo, pode substituir uma opção de Golpe de Sangue que conhece por outra.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  15,
  'Sinfonia de Sangue',
  'Sempre que usar um Golpe de Sangue, recupera PV iguais ao seu modificador de Constituição (mínimo 1). Além disso, se o alvo morrer em até 1 minuto após ser danificado por um Golpe de Sangue, você recupera um uso expendido deste recurso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
  18,
  'Golpe de Sangue Aprimorado',
  'Suas opções de Golpe de Sangue melhoram conforme anotado na descrição de cada opção.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  3,
  'Preceitos da Caça Eldritch',
  'Resolução. Pela força de vontade e tenacidade, o peso da caça é suportado; membros doloridos e mentes doentes não são motivo para falhar.

Respeito. Tire a vida só quando isso proteger outros. Mate apenas quando necessário, para que o derramamento de sangue não enamore sua alma e o caçador se torne a besta.

Responsabilidade. Muitos dependem do seu talento para sobreviver às noites de luar. Não os decepcione. Sacrifique o próprio corpo para que outros mantenham a santidade de suas formas intactas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  3,
  'Caçar a Presa',
  'Como Ação Bônus, gaste um uso de Canalizar Divindade para designar uma criatura a até 18 m como sua presa por 1 minuto. Ao usar este recurso, e como Ação Bônus em turnos seguintes, você pode teleportar-se magicamente até 18 m para um espaço desocupado que possa ver a até 1,5 m do alvo marcado (precisa vê-lo).

Se a criatura cair a 0 PV antes do fim do efeito, pode transferir a marca para outra criatura a até 18 m (sem ação).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  3,
  'Magias do Juramento da Caça Eldritch',
  'Você sempre tem preparadas as magias do juramento ao atingir os níveis:

Nível 3: Fogo das Fadas, Talho Espectral.
Nível 5: Paralisar Pessoa, Raio Lunar.
Nível 9: Mandíbula Deslocadora, Fúria Espectral.
Nível 13: Tentáculos Negros de Evard, Donzela dos Ossos.
Nível 17: Contato Extraplanar, Paralisar Monstro.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  3,
  'Dádiva Eldritch Roubada',
  'Você pode adicionar seu modificador de Carisma a quaisquer testes de Atletismo, Percepção e Sobrevivência que fizer.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  7,
  'Sentidos Aguçados',
  'Quando uma criatura estiver na sua Aura de Proteção, você aprende quaisquer Imunidades, Resistências ou Vulnerabilidades que ela tenha.

Além disso, você tem Visão Cega no alcance da sua Aura de Proteção.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  15,
  'Perseguição Implacável',
  'Quando acertar o alvo marcado com arma Corpo a Corpo ou Ataque Desarmado imediatamente após teleportar com Caçar a Presa, pode conjurar Destruição Divina sem usar Ação Bônus. Gasta espaço de magia normalmente; só uma vez por turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
  20,
  'Caçador Perfeito',
  'Como Ação Bônus, ativa o poder do verdadeiro caçador por 10 minutos:

Devorar. Seus ataques com arma causam 1d8 Necrótico extra (ignora Resistência e Imunidade a Necrótico).
Partir. Você é Imune a Agarrado, Paralisado e Contido.
Sumir. Você tem a condição Invisível.

Uma vez usado, não pode usar de novo até Descanso Longo, ou pode restaurar o uso gastando um espaço de magia de 5º círculo (sem ação).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
  3,
  'Ferramentas do Ofício',
  'Você ganha proficiência com Ferramentas de Tortura e a perícia Intuição, e tem Expertise com ambas.

Ferramentas de Tortura (20 PO / 5 kg): satchel com instrumentos para maximizar dor.

Exaustão. Usar as ferramentas por 1 hora numa criatura Contida causa 1 nível de Exaustão; depois faça teste de Destreza (Ferramentas de Tortura) CD 20 − modificador de Constituição da criatura. Em falha, a criatura sofre 10 de dano Contundente, Perfurante ou Cortante (sua escolha).

Intimidação. Em testes de Carisma (Intimidação) contra criatura em que já usou as ferramentas, ganha bônus igual ao dobro do Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
  3,
  'Técnicas do Torturador',
  'Você pode usar cada técnica duas vezes, recuperando todos os usos ao terminar um Descanso Longo. Pode gastar um uso de Inimigo Favorito (sem ação) para recuperar um uso de uma técnica.

Ao acertar com ataque corpo a corpo com arma ou Ataque Desarmado enquanto tiver Ferramentas de Tortura em uma mão (ou mão livre e ferramentas disponíveis), pode aplicar uma técnica. Só uma técnica por turno e por ataque.

Técnicas Empoderadas. Pode empoderar gastando espaço de magia (sem ação): dano extra e o alvo subtrai Nd4 das salvaguardas da técnica, conforme o nível do espaço (máx. pelo nível de Patrulheiro). Gastar Inimigo Favorito conta como espaço de 1º.

CD das Técnicas. 8 + modificador de Sabedoria + Bônus de Proficiência.

Penteado. Extra 1d10 Cortante. Nível 7+: se danificar o mesmo alvo dois turnos seguidos, salvaguarda de Constituição ou decomposição (Necrótico = mod. Sabedoria no início dos turnos, 1 minuto; não reduzível).

Enucleação. Extra 1d6 do tipo da arma; salvaguarda de Constituição (Vantagem se tiver mais de dois olhos) ou Desvantagem em Percepção e Cego além de 18 m por 1 minuto. Nível 11+: falha em dois turnos seguidos → Cego pela duração.

Cortar Tendão. Extra 1d6 Cortante; salvaguarda de Constituição ou Velocidade 0 até o início do seu próximo turno. Nível 7+: falha em dois turnos → Velocidade 0 por 1 minuto.

Raspar Nervos. Extra 1d4 Psíquico; salvaguarda de Constituição ou até o início do seu próximo turno deve usar a ação antes de se mover para atacar aleatoriamente outra criatura no alcance. Nível 11+: falha em dois turnos → −1d4 em ataques e salvaguardas por 1 minuto.

Golpe na Garganta. Extra 1d8 Contundente; não pode falar nem usar componentes Verbais até o início do seu próximo turno. Nível 11+: acertar dois turnos seguidos → salvaguarda de Constituição ou Atordoado até o fim do seu próximo turno.

Ruptura Timpânica. Extra 1d8 Contundente; salvaguarda de Constituição ou Surdo por 1 minuto. Nível 7+: falha em dois turnos → desorientado (sem Reações) pela duração.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
  7,
  'Mente Depravada',
  'Você é imune à condição Amedrontado e ganha Resistência a dano Psíquico.

Se uma criatura tentar ler sua mente ou falar telepaticamente contra sua vontade, deve primeiro passar numa salvaguarda de Sabedoria contra sua CD de Técnicas. Em falha, presencia os horrores da sua mente, sofre dano Psíquico igual ao seu nível e falha em comunicar-se. Em sucesso, pode interagir assim por 1 minuto sem nova salvaguarda.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
  11,
  'Véu de Dor',
  'Quando danificar uma criatura com suas técnicas, pode tentar abalar a mente dela (sem ação). Salvaguarda de Sabedoria contra sua CD de Técnicas ou você fica Invisível para o alvo por 1 minuto (o alvo repete no fim de cada turno).

Usos iguais ao modificador de Sabedoria (mínimo 1); recupera todos ao Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
  15,
  'Agonia Mental',
  'Quando uma criatura que você possa ver a até 18 m e que falhou numa salvaguarda contra uma de suas técnicas desde o início do seu último turno fizer salvaguarda de Inteligência, Sabedoria ou Carisma, você pode usar Reação para fazê-la subtrair 1d10. Criaturas imunes a Amedrontado são imunes a este efeito.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
  3,
  'Campeão Santificado',
  'Você ganha proficiência com armas Marciais e treinamento com armadura Média.

Sempre que terminar um Descanso Curto, pode realizar um ritual numa arma corpo a corpo com a qual seja proficiente e que cause dano Perfurante ou Cortante, santificando-a. Torna-se sua lâmina santificada (só uma por vez). Para você, a lâmina tem a propriedade Acuidade, e ataques com ela contra Aberrações, Demônios e Mortos-vivos ignoram Resistência a dano.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
  3,
  'Bênçãos Divinas',
  'Você tem uma reserva de Pontos Divinos igual a 1 + seu modificador de Sabedoria (mínimo 1). Recupera todos ao terminar Descanso Curto ou Longo. Sempre que matar uma Aberração, Besta, Demônio ou Morto-vivo de ND ½ ou maior com sua lâmina santificada, recupera 1 Ponto Divino.

CD da Radiância. 8 + modificador de Sabedoria + Bônus de Proficiência.

Armadura dos Fiéis. Reação quando uma criatura o mira com um ataque: gaste 1 Ponto Divino; salvaguarda de Sabedoria ou o atacante deve escolher novo alvo / ataque sem efeito, e não pode atacá-lo até o início do seu próximo turno (não protege contra áreas).

Inspiração Divina. Ao fazer teste de Inteligência (História ou Religião) ou Sabedoria (Intuição), gaste 1 Ponto Divino para rerrolar o d20 (obrigatório usar o novo) e ganhar bônus igual ao modificador de Sabedoria (mínimo 1).

Rasgar o Blasfemo. Após a ação Atacar com a lâmina santificada, Ação Bônus + 1 Ponto Divino: faça um ataque com ela; bônus na jogada de ataque igual ao modificador de Sabedoria (mínimo 1).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
  9,
  'Armamento Íntegro',
  'Correntes do Julgamento. Ao acertar com a lâmina santificada, gaste 1 Ponto Divino: salvaguarda de Força ou o alvo sofre dano Radiante igual ao seu modificador de Sabedoria e fica Contido até o fim do seu próximo turno.

Retaliação Divina. Reação ao sofrer dano de ataque corpo a corpo enquanto empunha a lâmina: gaste 1 Ponto Divino e ataque com ela; bônus no dano igual ao modificador de Sabedoria.

Lâminas Eruptivas. Ao acertar com ataque que poderia aplicar Ataque Furtivo, pode abrir mão do Furtivo e gastar 2 Pontos Divinos: o alvo e cada criatura numa Linha de 13,5 m × 1,5 m a partir do alvo fazem salvaguarda de Destreza; em falha, dano Radiante igual ao seu Ataque Furtivo; em sucesso, metade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
  13,
  'Revelações Santas',
  'Você aprende dois truques à sua escolha da lista de Clérigo.

Além disso, sempre tem preparadas Heroísmo, Proteção Contra o Bem e o Mal e Escudo da Fé. Com este recurso, pode conjurá-las à vontade apenas em si mesmo, sem espaço nem componentes. Sabedoria é sua habilidade de conjuração.

A partir do nível 17 de Ladino, essas magias não exigem Concentração quando conjuradas assim; só uma delas pode estar ativa por vez.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
  17,
  'Julgamento Final',
  'Espíritos Divinos. Como ação Usar Magia enquanto empunha a lâmina, conjure Guardiões Espirituais sem espaço nem componentes. Criaturas na área contam, para Ataque Furtivo, como estando a 1,5 m de um aliado. Uma vez por Descanso Longo, ou restaure gastando 3 Pontos Divinos (sem ação).

Lâmina Radiante. Palavra de comando (sem ação): a lâmina emite Luz Brilhante num raio de 9 m e Luz Fraca por mais 9 m. Enquanto brilhar, é arma mágica e causa 2d4 Radiante extra no acerto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
  3,
  'Armadura de Osso Frágil',
  'Como ação, se não estiver vestindo armadura nem empunhando Escudo, pode forçar uma armação de ossos para fora do corpo, concedendo PV temporários iguais ao dobro do seu nível de Mago por 1 hora.

Enquanto tiver esses PV temporários, tem Resistência a dano Perfurante e Cortante e +2 na CA.

Uma vez usado, não pode usar de novo até Descanso Longo, a menos que gaste um espaço de magia de 2º círculo ou superior (sem ação) para restaurar o uso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
  3,
  'Especialista Anatômico',
  'Você ganha proficiência em Medicina. Em testes de Sabedoria (Medicina ou Sobrevivência), ganha bônus igual ao modificador de Inteligência (mínimo 1). Quando esses testes concernirem criatura com esqueleto, você tem Expertise na perícia (mesmo sem proficiência em Sobrevivência).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
  6,
  'Marionetismo Ósseo',
  'Como ação Usar Magia, escolha uma criatura com esqueleto que possa ver a até 18 m. Salvaguarda de Força contra sua CD de magia ou você assume controle total e preciso do esqueleto até o fim do próximo turno dela: só age como você permitir. Ataques dela contra aliados têm Desvantagem; aliados têm Vantagem em salvaguardas contra efeitos causados por ela.

Só uma criatura sob controle por vez. Usos iguais ao modificador de Inteligência (mínimo 1); recupera todos ao Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
  10,
  'Maestria Esquelética',
  'Muitas Formas. Pode remodelar ossos (incluindo o rosto) para parecer outra pessoa. Conjure Alterar-se sem gastar espaço; sem Concentração; só opções Mudar Aparência ou Armas Naturais.

Controle Esquelético. Como ação Usar Magia, dissolve ou restaura o próprio esqueleto. Sem ossos: Velocidade 3 m, passa por espaços de 2,5 cm sem apertar-se, considera-se Caído, não usa mãos, não ataca nem conjura. Ação Bônus: regenera ossos das mãos para controle fino até o fim do próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
  14,
  'Marionetismo Ósseo Aprimorado',
  'Quando uma criatura falha na salvaguarda contra Marionetismo Ósseo, o controle dura 1 minuto. O alvo não resiste ao comando (sem Desvantagem/Vantagem especiais). Repete a salvaguarda no fim de cada turno. Você deve Concentrar-se neste recurso como numa magia; dano não quebra essa Concentração.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
