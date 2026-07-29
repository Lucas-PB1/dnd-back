-- Seed Valda feat benefits
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
  1,
  'Aumento de Atributo',
  'Aumento de Atributo. Aumente seu valor de Força em 1, até um máximo de 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
  2,
  'Duelista Pesado',
  'Duelista Pesado. Você pode empunhar uma arma corpo a corpo com a propriedade Duas mãos em uma mão.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
  3,
  'Portador Duplo Versátil',
  'Portador duplo versátil. Ao empunhar uma arma corpo a corpo com a propriedade Versátil em uma mão, a arma tem a propriedade Leve para você.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
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
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
  2,
  'Comando',
  'Comando. Como uma ação, você pode emitir um comando para um aliado a até 60 pés que possa ouvi-lo. Ele pode realizar imediatamente uma ação como uma reação. Essa ação pode ser usada para realizar apenas as ações de Ataque (apenas um ataque), Correr, Esquivar, Esconder-se, Influenciar, Procurar, Estudar ou Utilizar.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
  3,
  'Formação Apertada',
  'Formação apertada. Enquanto você estiver a 5 pés de dois ou mais aliados que não tenham a condição Incapacitado, os inimigos não poderão ter Vantagem nas jogadas de ataque contra você.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'),
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
  (SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'),
  2,
  'Crítico aprimorado',
  'Crítico aprimorado. Suas jogadas de ataque com armas e Ataque Desarmados podem obter um Acerto Crítico em uma jogada de 19 ou 20 no d20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
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
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  2,
  'A determinação do azarão',
  'A resolução do azarão. Quando você é atacado por uma criatura que possui um ND maior que o seu nível, você ganha +2 de bônus em seu Classe de Armadura por esse ataque.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  3,
  'Ataque Vingativo',
  'Golpe Vingativo. Você tem Vantagem nas jogadas de ataque contra qualquer criatura que tenha reduzido um de seus aliados a 0 Pontos de Vida desde o final do seu último turno.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  4,
  'Intervenção Heroica',
  'Intervenção Heroica. Quando um inimigo que você pode ver realiza uma Ação Lendária, você pode realizar uma Reação para interceder, evitando que a Ação Lendária aconteça. Você pode realizar esta Reação um número de vezes igual ao seu Bônus de Proficiência e recuperar todos os usos gastos ao terminar um Descanso Longo.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
