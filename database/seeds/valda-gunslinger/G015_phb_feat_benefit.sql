-- Seed Pistoleiro pack feat benefits

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Destreza em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
  2,
  'Virar o Dado',
  'Virar o Dado. Uma vez por turno, ao rolar o dano com uma arma de longo alcance, você pode virar um dos dados de dano e usar o número na parte inferior. Você não pode usar esta habilidade em d4s. Observe que, para um dado equilibrado, os números superior e inferior somam um a mais do que o maior número do dado.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
  3,
  'Crítico aprimorado',
  'Crítico aprimorado. Quando você obtém um Acerto Crítico com uma arma de longo alcance, a velocidade do alvo é 0 até o final do próximo turno.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente sua Destreza em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  2,
  'Proficiência em Armas de Longo Alcance',
  'Proficiência em Armas de Longo Alcance. Você ganha proficiência com armas marciais de longo alcance.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  3,
  'Truque',
  'Truque. Você aprende o truque Pistolas de Dedo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  4,
  'Lista de magias expandida',
  'Lista de magias expandida. Os seguintes magias são adicionados à sua lista de magias: Campo Antibalístico, Golpe Balístico, Conjurar Bala de Canhão, Conjurar Cobertura, Emperrar Arma, Recarga Instantânea de Jethro e Tiro Perfurante.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  5,
  'Magias Preparadas',
  'Magias Preparadas. Escolha um número de magias igual ao seu Bônus de Proficiência dentre aqueles no benefício Lista Expandida de Magias. Você sempre tem esses magias preparadas. Sempre que você ganha um novo nível, você pode substituir um desses magias por uma magia diferente da Lista Expandida de Magias.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
