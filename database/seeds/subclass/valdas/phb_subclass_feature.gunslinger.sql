-- Seed Pistoleiro subclass features
-- Conteúdo canônico Valdas: Gunslinger

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  3,
  'Olho de Águia [Manobra]',
  'Uma vez por turno, quando você errar uma jogada de ataque à distância, você pode gastar um Dado de Risco e adicioná-lo à jogada de ataque, potencialmente fazendo com que o ataque acerte.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  3,
  'Postura do atirador',
  'Você treinou para atirar de uma posição Caído estável, atendendo às seguintes condições.

Atirar Enquanto Caído. Você não tem Desvantagem em jogadas de ataque à distância como resultado da condição Caído.

Suporte rápido. Quando você tem a condição Caído, você pode se endireitar e, assim, encerrar a condição com apenas 5 pés de movimento.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  6,
  'Posição oculta',
  'Você é excelente em atirar escondido, garantindo os seguintes benefícios.

Camuflar. Você pode realizar a ação Esconder-se mesmo se não estiver Fortemente Obscurecido ou atrás de Cobertura de Três Quartos ou Cobertura Total, desde que tenha a condição Caído. A condição Invisível desta ação Ocultar termina se você não tiver a condição Caído.

Ninho do Atirador. Se você fizer uma jogada de ataque enquanto estiver escondido e a jogada falhar, fazer a jogada de ataque não revelará sua localização.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  10,
  'Reposicionar',
  'Sempre que uma criatura erra você em uma jogada de ataque, você pode realizar uma Reação para encerrar a condição Caído em si mesmo e aumentar até metade de sua Velocidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  14,
  'Tiro Focado',
  'Ao usar a ação Atacar, você pode optar por fazer apenas uma jogada de ataque à distância usando uma arma para fazer um Tiro Focado. Você tem Vantagem nesta jogada de ataque e, ao acertar, obtém Acerto Crítico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  3,
  'Cara de Pôquer',
  'Você ganha proficiência com todos os Kit de Jogos e em uma das seguintes habilidades de sua escolha: Enganação, Intuição ou Percepção.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  3,
  'Dados do Mentiroso [Manobra]',
  'Quando você faz uma jogada de dano com uma arma de longo alcance, você pode gastar um Dado de Risco como Ação Bônus e declarar que é uma jogada oculta. Role o dano em segredo e declare o total que desejar. O Mestre tem a opção de denunciar seu blefe e, nesse caso, você revela os dados de dano que rolou. Isso tem consequências diferentes dependendo de você ter mentido ou não.

O Mestre chama seu blefe; Você mentiu. O dano que você causa é reduzido pela metade.

O Mestre chama seu blefe; Você disse a verdade. O dano que você causa é duplicado.

O Mestre não chama seu blefe. Use o dano total que você declarou, mesmo que tenha obtido um total diferente.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  6,
  'Negócio arriscado',
  'Uma vez por turno, quando você fizer uma jogada de ataque contra um inimigo e a jogada não tiver Desvantagem, você pode escolher fazer a jogada com Desvantagem. Ao fazer isso, você recupera um Dado de Risco gasto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  10,
  'Assumidor de risco',
  'Você pode usar suas manobras Espírito Independente e Por um Triz sem gastar um Dado de Risco. Ao fazer isso, role um d6 em vez de Dado de Risco.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  14,
  'Duplo ou nada',
  'Ao marcar um Acerto Crítico usando uma arma de longo alcance, você pode apostar para obter um resultado mais alto. Role um d20. Se o resultado for 10 ou superior, jogue todos os dados de dano do ataque quatro vezes e some-os, em vez de apenas duas vezes como normal para um Acerto Crítico. Se você tirar 9 ou menos no d20, o Acerto Crítico se torna um acerto normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  3,
  'Treinamento Operativo',
  'Seu treinamento secreto concede os seguintes benefícios:

Tiro oculto. Você aprende o truque Disparo Oculto. Inteligência, Sabedoria ou Carisma é sua habilidade de conjuração para este truque (escolha quando selecionar esta subclasse).

Ferramentas operativas. Você ganha um Kit de Disfarce e Ferramentas de Ladrão e tem proficiência com eles.

Proficiências em habilidades. Você ganha proficiência em duas dessas perícias à sua escolha: Enganação, Investigação, Persuasão, Prestidigitação ou Furtividade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  3,
  'Tiro de despedida [Manobra]',
  'Quando você realiza a ação Correr, Desengajar ou Esquivar em seu turno, você pode gastar um Dado de Risco para fazer um ataque à distância usando uma arma como Ação Bônus. Adicione o Dado de Risco à jogada de dano em um acerto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  6,
  'Artesanato de campo',
  'Sua experiência na área concede os seguintes benefícios.

Mudança rápida. Usando um Kit de Disfarce, você pode criar uma fantasia e vesti-la como Ação Bônus.

Falador habilidoso. Sempre que você fizer um teste de Carisma (Enganação) ou Carisma (Persuasão), você pode tratar um resultado de 20 ou menos no d20 como 10.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  10,
  'Estratégia de saída',
  'Ao sofrer dano, você pode realizar uma Reação para evitar mais danos. Você tem a condição Invisível até o início do seu próximo turno e pode mover-se imediatamente até 10 pés.

Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Curto ou Longo. Você também pode restaurar o uso dele gastando um Dado de Risco (nenhuma ação necessária).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  14,
  'Licença para matar',
  'Sempre que você causa dano com uma arma de longo alcance, você pode gastar um ou dois Dados de Risco e adicioná-los à jogada de dano. Se você lançar o número mais alto em Dado de Risco, poderá lançar o dado novamente e adicioná-lo ao dano sem gastá-lo, jogando novamente se for o número mais alto novamente e assim por diante. O número máximo de Dados de Risco que você pode adicionar ao dano é igual ao seu Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  3,
  'Magias',
  'Você complementa suas balas com a habilidade de lançar magias.

Truques. Você conhece dois truques à sua escolha da lista de magias do Mago (veja a seção dessa classe para consultar a lista). Raio de Fogo e Mensagem são recomendados. Sempre que você ganha um nível de Pistoleiro, você pode substituir um desses truques por outro truque de sua escolha da lista de magias do Mago.

Ao atingir o nível 10 de Pistoleiro, você aprende outro truque de Mago de sua escolha.

Espaços de Magia. A tabela Conjuração do Pistoleiro Arcano mostra quantos espaços de magia você tem para lançar suas magias de nível 1+. Você recupera todos os espaços gastos ao terminar um Descanso Longo.

Magias Preparadas de Nível 1+. Você prepara a lista de magias de nível 1+ que estão disponíveis para serem lançadas com esse recurso. Para começar, escolha três magias de nível 1 da lista de magias do Mago. Orbe cromático, salto e escudo são recomendados.

O número de magias em sua lista aumenta à medida que você ganha níveis de Pistoleiro, conforme mostrado na coluna Magias Preparadas da tabela Conjuração de Magias do Pistoleiro Arcano. Sempre que esse número aumentar, escolha magias adicionais da lista de magias do Mago até que o número de magias em sua lista corresponda ao número na tabela. As magias escolhidas devem ser de um nível para o qual você possui espaços de magia. Por exemplo, se você for um Pistoleiro de nível 7, sua lista de magias preparadas pode incluir cinco magias de Mago de níveis 1 e 2 em qualquer combinação.

Alterando suas magias preparadas. Sempre que você ganha um nível de Pistoleiro, você pode substituir uma magia de sua lista por outra magia de Mago para o qual você tenha espaços de magia.

Atributo de Conjuração. Inteligência é a sua habilidade de lançar magias para suas magias de Mago.

Foco de Conjuração. Você pode usar um Foco Arcano ou uma arma de longo alcance como Foco de Conjuração para suas magias de mago.

—Espaços de Magia por nível de magia—

1
2
3
4

3
3
2
-
-
-

4
4
3
-
-
-

5
4
3
-
-
-

6
4
3
-
-
-

7
5
4
2
-
-

8
6
4
2
-
-

9
6
4
2
-
-

10
7
4
3
-
-

11
8
4
3
-
-

12
8
4
3
-
-

13
9
4
3
2
-

14
10
4
3
2
-

15
10
4
3
2
-

16
11
4
3
3
-

17
11
4
3
3
-

18
11
4
3
3
-

19
12
4
3
3
1

20
13
4
3
3
1'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  3,
  'Bang, você está morto!',
  'Você pode usar magia no lugar de armas.

Pistolas de Dedo. Você aprende o truque Pistolas de Dedo. Veja a seção Novos Magias para detalhes.

Tiro Arcano. Ao atingir um alvo com um ataque de Pistolas de Dedo, você pode gastar um Dado de Risco como Ação Bônus e adicioná-lo à jogada de dano.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  6,
  'Magia',
  'Ao usar a ação Atacar no seu turno, você pode substituir um dos ataques por lançar um de seus truques de Mago que tenha um tempo de conjuração de uma ação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  10,
  'Contra-Mago',
  'Sua experiência no combate a conjuradores lhe concede os seguintes benefícios.

Quebrador de Abjuração. Sempre que você faz uma jogada de ataque à distância, você interrompe temporariamente a magia protetora que afeta o alvo. Durante o ataque, os efeitos das magias direcionados à criatura, como a Armadura do Mago, bem como as propriedades e poderes dos itens mágicos usados ​​ou carregados pela criatura, são suprimidos e não funcionam. O alvo do ataque não pode realizar uma Reação para lançar magias como Escudo em resposta ao ataque ou dano.

Tiro Antimágico. Quando você marca um Acerto Crítico e o alvo é afetado pelo seu recurso Tiro Intestinal, isso também impede a capacidade do alvo de lançar magias. Enquanto o projétil estiver alojado no alvo, ele não poderá lançar magias nem realizar a Ação Mágica. Além disso, o alvo tem Desvantagem nos salvaguardas de Constituição que faz para manter a Concentração.

Habituado à magia. Quando você falha em uma salvaguarda contra uma magia ou efeito mágico, você pode realizar uma Reação para rolar 1d6 e adicioná-lo à jogada, potencialmente transformando a falha em um sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  14,
  'Bala Mágica [Manobra]',
  'Quando você faz uma jogada de ataque mágico, você pode gastar um Dado de Risco como uma Ação Bônus para substituir o ataque mágico por um ataque à distância usando uma arma. Adicione o Dado de Risco à jogada de ataque. Se acertar, o ataque causa o dano normal da arma, além dos efeitos da jogada de ataque da magia.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  3,
  'Trajetória Criativa',
  'Você pode fazer seus projéteis viajarem de maneiras inesperadas. Seus ataques à distância com armas ignoram Meia Cobertura e Cobertura de Três Quartos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  3,
  'Ricochete [Manobra]',
  'Quando você erra um ataque à distância usando uma arma, você pode realizar uma Ação Bônus e gastar um Dado de Risco para rolar novamente o ataque e adicionar o Dado de Risco à jogada. Você deve usar o novo resultado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  6,
  'Tiroteio extravagante',
  'Seus truques chamativos com armas garantem os seguintes benefícios.

Girando Arma. Uma vez por turno, quando você faz um teste de Carisma (Desempenho) ou um teste de Destreza (Prestidigitação) usando uma de suas armas de longo alcance, você pode rolar um Dado de Risco e adicioná-lo ao teste de habilidade sem gastá-lo.

Carregador rápido. No seu turno, você pode recarregar uma arma com a propriedade Recarregar sem realizar uma ação ou Ação Bônus.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  10,
  'Deflexão Hábil [Manobra]',
  'Você pode atirar projéteis no ar. Quando um aliado a até 30 pés de você é atingido por um ataque, você pode realizar uma Reação e gastar um Dado de Risco para conceder a esse aliado o benefício da manobra Por um Triz contra esse ataque. Você deve possuir uma arma de longo alcance para usar esta manobra.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  14,
  'Tiro de pinball',
  'Uma vez em cada um de seus turnos, ao atingir uma criatura com um ataque à distância usando uma arma, você pode desviar o projétil em alvos adicionais. Escolha um alvo diferente a até 30 pés do primeiro e faça uma jogada de ataque contra ele. Se acertar, você pode repetir este ataque contra um novo alvo em um raio de 30 pés até errar ou realizar um total de cinco ataques. Você não pode atingir a mesma criatura com mais de um ataque cada vez que usar este recurso.

Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Curto ou Longo. Você também pode restaurar seu uso gastando dois Dados de Risco (nenhuma ação necessária).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  3,
  'Estabeleça a Lei [Manobra]',
  'Você pode realizar uma Ação Bônus e gastar um Dado de Risco para ficar atento aos perigos que ameaçam seus companheiros. Escolha um aliado que você possa ver a até 60 pés de você. Esse aliado ganha Pontos de Vida Temporários igual ao número obtido no Dado de Risco. Até o início do seu próximo turno, se o aliado for atingido por um ataque, você pode realizar uma Reação para realizar um ataque à distância usando uma arma contra o atacante.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  3,
  'Aura de Olhos de Aço',
  'Uma aura de confiança estóica irradia de você em uma Emanação de 10 pés. Você e aliados dentro da Emanação têm Vantagem nos salvaguardas feitos para evitar ou encerrar a condição Amedrontado. A aura fica inativa enquanto você estiver na condição Incapacitado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  6,
  'Alcance os céus',
  'Quando você marca um Acerto Crítico contra uma criatura, você pede que o alvo se renda em vez de alojar um projétil nele. O alvo deve ser bem sucedido em uma salvaguarda de Sabedoria contra sua CD de resistência de Manobra ou ter as condições Amedrontado e Incapacitado por 1 minuto. Essas condições terminam mais cedo se a criatura sofrer algum dano, se você tiver a condição Incapacitado ou se morrer. A criatura pode repetir a salvaguarda de Sabedoria no final de cada um de seus turnos, encerrando as condições em caso de sucesso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  10,
  'Longo braço da lei',
  'Uma vez por turno, quando você atingir uma criatura Grande ou menor com um ataque à distância usando uma arma, você pode mancar o alvo. A criatura não pode se mover no próximo turno, a menos que primeiro realize a ação de Desengajar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  14,
  'Herói Estrela Dourada',
  'Apesar do heroísmo armado, você ganha os seguintes benefícios.

Aura melhorada. O alcance do recurso Aura de Olhos de Aço aumenta para 30 pés.

Lei revestida de ferro. Quando você usa sua manobra Estabeleça a Lei, o aliado tem Resistência aos danos Contundente, Perfurante e Cortante até o início do seu próximo turno.

Rendição Atordoado. Quando uma criatura falha na salvaguarda contra seu recurso Alcançar os Céus, ela tem a condição Atordoado em vez da condição Incapacitado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
