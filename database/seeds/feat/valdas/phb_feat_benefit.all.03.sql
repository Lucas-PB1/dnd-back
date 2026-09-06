-- Seed Valdas Player Pack 2 feat benefits

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'familiar-keeper'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'familiar-keeper'),
  2,
  'Convocar Familiar',
  'Convocar Familiar. Você sempre tem a magia Convocar Familiar preparada. Além disso, você pode conjurá-la como uma Ação Mágica sem gastar um espaço de magia ou componentes Materiais. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para esta magia (escolha ao selecionar este talento). Depois de conjurar a magia usando este benefício, você não poderá fazê-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'familiar-keeper'),
  3,
  'Opções Expandidas',
  'Opções Expandidas. Ao conjurar Convocar Familiar, você pode escolher uma das formas normais para o seu familiar ou uma das seguintes formas especiais: Diabrete, Pseudodragão, Quasit, Esfinge Maravilhosa ou Sprite.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'familiar-keeper'),
  4,
  'Distração do Familiar',
  'Distração do Familiar. Quando uma criatura a até 1,5 m do seu familiar faz uma jogada de ataque, você pode realizar uma Reação para ordenar que seu familiar imponha Desvantagem ao ataque. Você impõe Desvantagem dessa forma um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'flex-caster'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'flex-caster'),
  2,
  'Elevação',
  'Elevação. Ao conjurar uma magia, como Mísseis Mágicos, que pode ser conjurada com um espaço de magia de círculo superior para efeitos mais poderosos, você pode gastar qualquer espaço de magia adicional para aumentar o nível efetivo da magia em 1, até um máximo de nível 9.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'flex-caster'),
  3,
  'Redução',
  'Redução. Ao conjurar uma magia usando um espaço de magia de círculo superior, você pode optar por reciclar o excesso de energia mágica em vez de aprimorar a magia. A magia é conjurada em seu círculo base e você recupera um espaço de magia de 1º círculo gasto.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magitechnician'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magitechnician'),
  2,
  'Especialista em Item Mágico',
  'Especialista em Item Mágico. Se um de seus itens mágicos exigir uma salvaguarda, ele usa a seguinte CD se for maior: 8 mais o modificador do atributo aumentado por este talento e seu Bônus de Proficiência.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magitechnician'),
  3,
  'Recarga de Item Mágico',
  'Recarga de Item Mágico. Ao terminar um Descanso Curto, você pode fazer com que um item mágico que recupera cargas ou propriedades recarregue como se fosse o próximo amanhecer. Depois de usar este traço, você não poderá fazê-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'metabolistic-magic'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'metabolistic-magic'),
  2,
  'Perícia Arcana',
  'Perícia Arcana. Quando você falha em um Teste de D20, pode gastar um espaço de magia para ganhar um bônus na jogada, potencialmente fazendo-a ter sucesso. O bônus é igual a 2 mais o nível do espaço de magia gasto.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'metabolistic-magic'),
  3,
  'Combustível Vital',
  'Combustível Vital. Ao terminar um Descanso Curto, você pode gastar um número de Dados de Pontos de Vida até o seu Bônus de Proficiência para recuperar espaços de magia gastos. Escolha espaços de magia para recuperar cujo nível combinado seja no máximo igual ao número de Dados de Pontos de Vida gastos. Depois de usar esta característica, você não poderá fazê-lo novamente até terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'pyromaniac'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'pyromaniac'),
  2,
  'Magia Incendiária',
  'Magia Incendiária. Você conhece o truque Raio de Fogo e sempre tem as magias Mãos Flamejantes e Raio Ardente preparadas. Você pode conjurar Mãos Flamejantes e Raio Ardente sem gastar um espaço de magia. Depois de conjurar qualquer uma dessas magias dessa forma, você não poderá conjurá-la dessa forma novamente até terminar um Descanso Longo. Você também pode conjurar essas magias usando espaços de magia que tiver do círculo apropriado. O atributo de conjuração das magias deste talento é o atributo aumentado por este talento.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'pyromaniac'),
  3,
  'Dano de Labareda',
  'Dano de Labareda. Sempre que você causa dano Ígneo e obtém o número mais alto em qualquer dado de dano, pode jogar esse dado de dano novamente e adicioná-lo ao dano, jogando novamente se for o número mais alto, e assim por diante. Você pode adicionar um número máximo de dados à jogada de dano igual ao seu Bônus de Proficiência (mínimo de 1).'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'shock-trooper'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Força ou Destreza em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'shock-trooper'),
  2,
  'Primeiro Golpe',
  'Primeiro Golpe. Ao rolar Iniciativa e não ter Desvantagem na jogada, você pode sacar uma arma e realizar um ataque com ela.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'shock-trooper'),
  3,
  'Avanço Rápido',
  'Avanço Rápido. Durante a primeira rodada de cada combate, sua Velocidade é dobrada.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'showman'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'showman'),
  2,
  'Atuante Especialista',
  'Atuante Especialista. Você ganha proficiência na perícia Atuação. Se já tiver proficiência nela, você ganha Especialização nela.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'showman'),
  3,
  'Provocação',
  'Provocação. Você pode realizar uma Ação Bônus para zombar de uma criatura a até 4,5 m de você. Se o alvo puder ouvi-lo (embora não precise entendê-lo), ele tem Desvantagem na próxima jogada de ataque que fizer contra uma criatura que não seja você antes do final do próximo turno dele. Você pode usar esta Ação Bônus um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
  2,
  'Truques de Lâmina',
  'Truques de Lâmina. Você aprende dois dos seguintes truques à sua escolha: Lâmina de Arco, Lâmina Ardente, Lâmina Frígida ou Golpe Certeiro. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para essas magias (escolha ao selecionar este talento). Sempre que você ganhar um novo nível, pode mudar sua seleção de truques.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
  3,
  'Golpe Arcano',
  'Golpe Arcano. Ao realizar a ação Atacar no seu turno, você pode substituir um dos ataques por conjurar Lâmina de Arco, Lâmina Ardente, Lâmina Frígida ou Golpe Certeiro.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
  4,
  'Ataque Canalizado',
  'Ataque Canalizado. Ao fazer um ataque usando Força ou Destreza com uma arma com a qual você tem proficiência, você pode ganhar um bônus na jogada de ataque igual ao seu modificador de Inteligência, Sabedoria ou Carisma (mínimo de +1). Escolha o atributo cada vez que usar este benefício. Você pode ganhar este bônus um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
