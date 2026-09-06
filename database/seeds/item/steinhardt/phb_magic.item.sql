-- Itens mágicos Eldritch Hunt Player Pack
-- Marca Sacrificial atualiza o placeholder de H011.


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'sacrificial-brand',
  'other'::rpg.item_type,
  'Marca Sacrificial',
  NULL,
  NULL,
  $d$Para aplicar um Entalhe Eldritch, segue-se um processo macabro. Diferente da maioria das artes, em que o artista determina a qualidade, nos Entalhes Eldritch a tela — a pessoa que recebe o entalhe — determina a qualidade. A tela deve visualizar a runa na mente o melhor possível, fazendo o corpo distorcer sob a pressão Eldritch. O entalhador aplica a ferramenta necessária à pele e deixa os poderes Eldritch moverem o pincel, a agulha ou a faca, conforme o Entalhe seja Desenhado, Tatuado ou Escarificado, respectivamente. O procedimento leva 1 hora e pode ser feito como parte de um Descanso Curto.

Após o Entalhe Eldritch estar completo, a criatura sintoniza-se a ele (se exigido) e obtém seus efeitos. Para remover um Entalhe Eldritch, a carne onde ele está precisa ser completamente queimada. Queimar o entalhe também remove a Sintonia. Entalhes Escarificados não podem ser removidos.

A marca — notória entre caçadores e chamada Marca da Morte — é um prenúncio de fim precoce. Ainda assim, Steinhardt e o Mártir Tulio entalharam o sigilo Eldritch na própria pele de livre vontade, para atrair as bestas durante a Caça e dar trégua aos companheiros.

Desenhada (Comum). Durante os três dias da Lua de Sangue, todas as criaturas de alinhamento Mau em Luyarnha têm Vantagem em testes de Sabedoria (Percepção) ou Sabedoria (Sobrevivência) para localizar criaturas com este Entalhe Eldritch.

Tatuada (Incomum). Como a variante Desenhada. Se estiverem a até 36 m de uma criatura com o entalhe, conhecem a localização exata e recebem +1 nas jogadas de ataque e dano contra ela.

Escarificada (Rara). Como a variante Desenhada. Se estiverem a até 36 m, conhecem a localização exata, recebem +3 nas jogadas de ataque e dano contra a criatura marcada e −3 nas jogadas de ataque e dano contra outras criaturas sem a marca. Além disso, portadores deste entalhe sangram dolorosamente dele quando monstros Hostis a até 90 m estão cientes de sua posição. Não podem ser surpreendidos pela duração da Lua de Sangue.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Entalhe Eldritch","rarity":"varies","rarityLabel":"Raridade varia","requiresAttunement":true,"header":"Entalhe Eldritch, Raridade varia"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'meat-hookshot',
  'weapon'::rpg.item_type,
  'Gancho de Carne',
  '{"text":"400 PO"}'::jsonb,
  NULL,
  $d$Quando os manikins do Abatedouro Sloered ganharam senciência, os Scions enviaram executores para sufocar a ameaça. Dos ganchos de carne do abatedouro e dos bacamartes dos executores mortos, Os Abatidos — como os manikins se nomearam — forjaram estas armas versáteis. Apelidado de “gancho de carne”, o hookshot é uma arma-truque usada por caçadores para fechar a distância até a presa num turbilhão de lâminas e pólvora.

Arma Truque. Como Ação Bônus, você pode alternar entre os estados Transformado e Não Transformado. Não Transformado: duas armas de uma mão ligadas por corrente curta — uma Foice de Mão e um Bacamarte. Transformado: uma única arma de duas mãos — um Bacamarte com lâmina que funciona como Machado de Batalha.

Não Transformado. A Foice de Mão tem Acuidade, e o Bacamarte não tem Duas Mãos. A foice numa mão e o bacamarte na outra. Ao executar a ação Atacar com a foice, pode atacar com o bacamarte como Ação Bônus, ignorando a propriedade Cano.

Transformado. Ao executar a ação Atacar, pode atacar com o bacamarte ou com a lâmina (estatísticas de Machado de Batalha com duas mãos). Além disso, o item ganha a propriedade Gancho.

Gancho. Como ação Utilizar, lança a foice do bacamarte, ainda ligada por corrente. Faça uma jogada de ataque à distância contra uma criatura que possa ver a até 9 m. No acerto, o alvo sofre dano Cortante igual a 1d4 + seu modificador de Destreza. Se a criatura for do seu tamanho ou menor, deve ser bem-sucedida numa salvaguarda de Força CD 13 ou ser puxada em linha reta até o espaço desocupado mais próximo de você. Se for maior que você, você é puxado até o espaço desocupado mais próximo dela. No fim do seu turno, o gancho se solta e se reata ao bacamarte.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Machado de Batalha, Bacamarte e Foice de Mão)","rarity":"uncommon","rarityLabel":"Incomum","requiresAttunement":false,"header":"Arma Truque (Machado de Batalha, Bacamarte e Foice de Mão), Incomum"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'dream-executioner',
  'weapon'::rpg.item_type,
  'Executor de Sonhos',
  '{"text":"4000 PO"}'::jsonb,
  NULL,
  $d$Arma Truque. Como Ação Bônus, alterne entre Transformado e Não Transformado. Não Transformado: uma Foice e uma lanterna. Transformado: um Malho enorme.

Você recebe +1 nas jogadas de ataque e dano com esta arma mágica.

Não Transformado. A Foice ganha a propriedade Colheita.

Colheita. Sempre que uma criatura de ND 1 ou superior (ou nível 1 ou superior) morrer a até 4,5 m de você, a lanterna colhe a alma. A alma fica presa na lanterna e a criatura não pode ser ressuscitada até a alma ser libertada. Como Ação Mágica, você pode libertar uma alma presa. A lanterna guarda no máximo uma alma.

Transformado. O Malho ganha a propriedade Explosão da Alma.

Explosão da Alma. Ao atingir uma criatura com esta arma enquanto houver uma alma na lanterna, você pode sacrificar a alma (destruindo-a permanentemente) para criar uma explosão de chama fantasma. Cada criatura à sua escolha numa Emanação de 4,5 m originada de você deve fazer uma salvaguarda de Destreza CD 14, sofrendo 2d8 de dano Radiante e 2d8 de dano Necrótico em falha, ou metade em sucesso. Mortos-vivos falham automaticamente.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Malho, Foice)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma Truque (Malho, Foice), Raro (Requer Sintonia)"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'ravenous-gazer',
  'weapon'::rpg.item_type,
  'Olhar Voraz',
  '{"text":"4000 PO"}'::jsonb,
  NULL,
  $d$Adquirir conhecimento proibido sempre tem um preço. Qualquer criatura sintonizada a esta glaive é considerada proficiente com ela. Você recebe +1 nas jogadas de ataque e dano com esta arma mágica.

Arma Truque. Como Ação Bônus, alterne entre Transformado e Não Transformado. Não Transformado: uma Glaive. Transformado: uma Glaive que pode ser usada como Foco de Conjuração.

Para transformar esta arma, você deve alimentá-la com seu sangue: cada vez que a muda para o estado Transformado, ou inicia o turno com ela Transformada, sofre 1d4 de dano Necrótico, que não pode ser reduzido ou prevenido de forma alguma. Este dano não pode quebrar sua Concentração.

Transformado. Enquanto Transformada, concede +2 nas jogadas de ataque com magia, aumenta em 1 a CD de salvaguarda de suas magias e dá Visão Verdadeira com alcance de 9 m.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Glaive)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma Truque (Glaive), Raro (Requer Sintonia)"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'unstable-crumbler',
  'weapon'::rpg.item_type,
  'Destruidor Instável',
  '{"text":"4000 PO"}'::jsonb,
  NULL,
  $d$Enquanto segura esta arma, seus ataques e magias causam dano dobrado a estruturas, e o dano Ígneo que você sofre é reduzido em valor igual ao seu modificador de Constituição (mínimo 1).

Arma Truque. Como Ação Bônus, alterne entre Transformado e Não Transformado. Não Transformado: um Canhão rugindo. Transformado: o cabo se estende, tornando a arma um Malho altamente instável. Como parte desta Ação Bônus, você pode:
• Ao transformar o Canhão em Malho, disparar aos próprios pés (mesmo sem carga), usando a deflagração para saltar até 9 m em qualquer direção sem gastar deslocamento.
• Ao transformar o Malho em Canhão, recarregar o Canhão e reter a força instável. Se recarregar assim, na próxima vez que acertar com um ataque à distância do Canhão no seu turno, você é empurrado 9 m em linha reta.

Não Transformado. O Destruidor Instável aquece Balas de Canhão, transformando-as em munição infernal. Sempre que rolar 15 ou mais no d20 numa jogada de ataque à distância com esta arma, a bala superaquece e explode no impacto, sendo tratada como Bala de Canhão Explosiva.

Transformado. Sempre que rolar 18 ou mais no d20 numa jogada de ataque com esta arma, a cabeça do Malho detona, causando um efeito como a magia Bola de Fogo (CD 15) centrado no alvo. Se você for bem-sucedido nessa salvaguarda, não sofre dano.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Canhão, Malho)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma Truque (Canhão, Malho), Raro (Requer Sintonia)"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'galvanized-claw',
  'weapon'::rpg.item_type,
  'Garra Galvanizada',
  '{"text":"40000 PO"}'::jsonb,
  NULL,
  $d$Rasgar a carne das bestas abatidas para forjar armas ferozes é algo em que caçadores se tornaram notavelmente hábeis.

Enquanto sintonizado a esta arma, você tem Resistência a dano Elétrico e Trovejante.

Arma Truque. Como Ação Bônus, alterne entre Transformado e Não Transformado. Não Transformado: uma luva de couro sinewosa feita de músculo e pele de um predador galvanizado. Transformado: a garra pulsa com energia elétrica, fundindo-se ao antebraço e tornando-se uma garra monstruosa.

Não Transformado. A pele bestial invigora você: tem Vantagem em jogadas de Iniciativa. Além disso, a luva alimenta-se do seu poder. Se tiver Pontos de Vida Temporários ao acertar com um ataque corpo a corpo, causa 1d6 de dano Elétrico extra.

A luva tem 3 cargas e recupera todas as cargas gastas diariamente ao amanhecer. Ao sofrer dano Elétrico ou Trovejante, pode gastar uma Reação e 1 carga para em vez disso não sofrer dano e ganhar Pontos de Vida Temporários iguais ao dano que teria sofrido.

Transformado. A luva funde-se à sua forma, tornando a mão uma garra aberrante da qual você não pode ser desarmado. A garra muda o dano dos seus Ataques Desarmados para 1d8 do tipo Cortante, e você pode usar Destreza ou Força nas jogadas de ataque e dano. Além disso, recebe +1 nas jogadas de ataque e dano com ela.

Ao executar a ação Atacar com esta garra, pode fazer um ataque com ela como Ação Bônus. Se tiver Pontos de Vida Temporários, ao acertar com um ataque corpo a corpo usando a garra causa 1d8 de dano Elétrico extra.

A garra é demasiado desajeitada para manuseio delicado, como ativar mecanismos intrincados (gatilho de arma de fogo) ou arrombar fechaduras com Ferramentas de Ladrão.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Especial)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma Truque (Especial), Muito Raro (Requer Sintonia)","charges":3,"recharge":"dawn"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'orphans-cradle',
  'weapon'::rpg.item_type,
  'Berço do Órfão',
  '{"text":"40000 PO"}'::jsonb,
  NULL,
  $d$“A Lágrima do Órfão é uma flor que reina no coração de Carmella…” — as flores exalam fragrância enjoativa que repele bestas e o toque da morte; acesas, servem de combustível durável e regeneram-se.

Você recebe +1 nas jogadas de ataque e dano com esta arma mágica.

Arma Truque. Como Ação Bônus, alterne entre Transformado e Não Transformado. Em ambos os estados, a arma é uma Maça-estrela com a propriedade Extensão.

Não Transformado. Humanoides a até 3 m do berço têm Vantagem em salvaguardas contra as condições Enfeitiçado e Amedrontado. Além disso, o berço tem as propriedades Miasma Purificador e Miasma Vil.

Miasma Purificador. Como Ação Mágica, pode purificar um Humanoide que possa ver a até 3 m. Ele ganha 1d12 Pontos de Vida Temporários e pode encerrar uma das condições: Enfeitiçado, Amedrontado ou Envenenado. Depois que uma criatura se beneficiar, não pode fazê-lo novamente por 1 hora.

Miasma Vil. Ao atingir uma Besta ou um Morto-vivo com esta arma, o alvo deve ser bem-sucedido numa salvaguarda de Constituição CD 16 ou ficar Envenenado por 1 minuto, mesmo se imune a Envenenado. Repete a salvaguarda no fim de cada turno. Em sucesso ou ao terminar o efeito, fica imune ao Miasma Vil pelas próximas 24 horas.

Transformado. As plantas inflamam e a arma causa 2d6 de dano Ígneo extra no acerto. Ganha também Chamas Avivadas e Chamas Definhantes.

Chamas Avivadas. Como ação, gira o berço violentamente, avivando as chamas. Cada criatura num Cone de 6 m deve fazer uma salvaguarda de Destreza CD 16, sofrendo 3d6 de dano Ígneo e 3d6 de dano Venenoso em falha, ou metade em sucesso. Bestas e Mortos-vivos têm Desvantagem. Depois de usar, o Berço do Órfão volta ao estado Não Transformado e não pode ser Transformado novamente por 1d4 rodadas.

Chamas Definhantes. Ao atingir uma Besta ou Morto-vivo, pode forçar salvaguarda de Constituição CD 16. Em falha, o alvo tem Vulnerabilidade a um tipo de dano à sua escolha até o início do seu próximo turno: Ácido, Gélido, Ígneo, Elétrico, Venenoso ou Radiante. Em sucesso ou ao terminar, fica imune às Chamas Definhantes por 24 horas.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Maça-estrela)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma Truque (Maça-estrela), Muito Raro (Requer Sintonia)"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'revelations',
  'weapon'::rpg.item_type,
  'Revelações',
  '{"text":"40000 PO"}'::jsonb,
  NULL,
  $d$Feita de metal desconhecido que mistura sangue e aço, esta espada horripilante é cravejada de dezenas de olhos de várias criaturas. Só um caçador competente empunha arma de tal peso — mas, armado com ela, nunca perde a presa de vista e nunca é pego de emboscada.

Você recebe +1 nas jogadas de ataque e dano com esta arma mágica. Enquanto sintonizado e segurando Revelações: não pode ser surpreendido; outras criaturas não ganham Vantagem em ataques contra você por estarem invisíveis a você; você é imune à condição Cego — a espada absorve o efeito e fecha dois olhos, depois os regenera.

Arma Truque. Como Ação Bônus, alterne estados. Não Transformado: um Cutelo cravejado de globos oculares. Transformado: um Chicote de estilhaços metálicos unidos por tendão de sangue e carne.

Não Transformado. Ao atingir uma criatura com o Cutelo, amaldiçoa-a por 1 hora: +1 no dano da arma contra o alvo; críticos com 19–20; Vantagem em testes de Sabedoria (Percepção ou Sobrevivência) para encontrar o alvo. A maldição termina cedo se você transformar a arma ou ficar Inconsciente.

Transformado. O Chicote causa 1d6 Cortante no acerto, tem Versátil (1d8), mas não tem Acuidade. Uma vez por turno, ao atingir, pode tentar esmagar o alvo sob o peso do chicote: salvaguarda de Força (CD 8 + modificador de Força + BP) ou sofre 1d6 Cortante e fica Caído.

Maldição: Devorar a Visão. Enquanto sintonizado, a visão deteriora-se. A cada cinco dias, −1 permanente em testes de Sabedoria (Percepção) baseados na visão. Ao chegar a −5, os olhos apodrecem e derretem; você fica Cego, e dois novos olhos surgem na lâmina. Enquanto permanece sintonizado, não sofre a penalidade nem percebe a piora — a lâmina faz o mundo parecer mais claro.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Cutelo, Chicote)","rarity":"very-rare","rarityLabel":"Muito Raro","requiresAttunement":true,"header":"Arma Truque (Cutelo, Chicote), Muito Raro (Requer Sintonia por criatura com Força 15+)","cursed":true,"attunementPrerequisite":"Força 15+"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;


INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'shard-of-moonlight',
  'weapon'::rpg.item_type,
  'Estilhaço do Luar',
  NULL,
  NULL,
  $d$Esta arma é a carne de um Grande Entidade, esculpida em dor e moldada em lâmina. O Estilhaço do Luar é a razão pela qual a Lua Estilhaçada existe e a Lua Devoradora não mais. Quem empunha a lâmina é tomado de esperança — por mais equivocada que seja.

Enquanto sintonizado: é proficiente com Montantes e Espadas Longas; +3 nas jogadas de ataque e dano, e a lâmina causa 1d6 de dano Radiante extra no acerto; Vantagem em salvaguardas de Sabedoria, exceto para resistir à Loucura; pode usar a arma como Foco de Conjuração.

Senciência. O Estilhaço do Luar é uma arma senciente, com a personalidade do Grande Entidade de cuja carne foi talhada. Comunica-se esporadicamente por telepatia com imagens e sons, mas não fala.

Arma Truque. Como Ação Bônus, alterne estados. Não Transformado: Espada Longa metálica que absorve luz. Transformado: Montante que pulsa com energia lunar. Em ambos os estados, tem a propriedade Leve.

Não Transformado. A lâmina guia seus golpes. Uma vez por turno, ao fazer um ataque com esta arma, pode imediatamente fazer um segundo ataque (sem ação). Tem a propriedade Absorção do Vazio.

Absorção do Vazio. Enquanto segura o estilhaço, pode gastar uma Reação para absorver uma magia que o tenha como alvo, incluindo áreas. O efeito é cancelado e a energia é armazenada como cargas (nível da magia; 1 para truques). Até 10 cargas. Sem espaço suficiente, falha em absorver. Recupera todas as cargas cada vez que a lua muda.

Transformado. Para transformar, gaste uma Ação Bônus sob luar direto. Dura 1 minuto ou até encerrar cedo com Ação Bônus. Enquanto Transformada, o dano Radiante extra sobe de 1d6 para 2d6, e você pode gastar cargas. Sem cargas, a transformação termina.

Efeitos com cargas (por ataque no estado Transformado):
Brilho Revelador (1 carga). No acerto, +1d12 Radiante; até o início do seu próximo turno, o alvo emite Luz Fraca num raio de 3 m, não pode ficar Invisível, e ataques contra ele têm Vantagem.
Luar Transitório (2 cargas). Linha de 1,5 m de largura e 18 m de comprimento: salvaguarda de Constituição CD 18, 2d12 Radiante em falha ou metade em sucesso.
Explosão Lunar (3 cargas, em vez de atacar). Emanação de 9 m: salvaguarda de Destreza CD 18; em falha, 3d12 Radiante e Caído; se cair Caído a até 1,5 m, você pode gastar Reação para atacar corpo a corpo com o estilhaço. Em sucesso, só metade do dano.$d$,
  '{"magic":true,"source":"steinhardt-eldritch-hunt","editionSlug":"steinhardt-eldritch-hunt-2024-en","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","category":"Arma Truque (Montante, Espada Longa)","rarity":"artifact","rarityLabel":"Artefato","requiresAttunement":true,"header":"Arma Truque (Montante, Espada Longa), Artefato (Requer Sintonia)","sentient":true,"charges":10}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
