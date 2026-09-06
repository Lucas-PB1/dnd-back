-- Benefícios dos talentos Eldritch Hunt

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
    1,
    'Clareza Divina',
    'Clareza Divina. Se você falhar numa salvaguarda contra a condição Enfeitiçado ou Amedrontado, pode escolher sucesso em vez disso. Depois de usar este benefício, não pode usá-lo novamente até terminar um Descanso Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
    2,
    'Provação da Fé',
    'Provação da Fé. Sempre que você rolar um 1 num Teste de d20, ganha Inspiração Heróica.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
    1,
    'Superar',
    'Superar. Sempre que fizer uma salvaguarda contra a condição Amedrontado, recebe um bônus igual ao seu Bônus de Proficiência nessa salvaguarda.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
    2,
    'Sobreviver',
    'Sobreviver. Você precisa da metade da comida e da água para sobreviver, e tem Vantagem em testes de Sabedoria (Sobrevivência) feitos para forragear comida e água.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
    3,
    'Resistir',
    'Resistir. Imediatamente após sofrer dano que o deixa Ensanguentado, você ganha Inspiração Heróica. Não pode obter este benefício novamente até terminar um Descanso Curto ou Longo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brutalizer'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força ou Destreza em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brutalizer'),
    2,
    'Armamento Brutal',
    'Armamento Brutal. Você pode empunhar uma arma com a propriedade Duas Mãos numa mão, desde que a outra mão não esteja também empunhando uma arma com a propriedade Duas Mãos nem segurando um Escudo.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'brutalizer'),
    3,
    'Sequência Mortífera',
    'Sequência Mortífera. Quando você executa a ação Atacar no seu turno e ataca com uma arma que tem a propriedade Duas Mãos, pode fazer um ataque extra como Ação Bônus mais tarde no mesmo turno. Esse ataque extra deve ser feito com uma arma Leve, e você não adiciona seu modificador de atributo ao dano do ataque extra, a menos que esse modificador seja negativo ou você tenha o talento Combate com Duas Armas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cannoneer'),
    1,
    'Aumento no Valor de Atributo',
    'Aumento no Valor de Atributo. Aumente seu valor de Força em 1, até no máximo 20.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cannoneer'),
    2,
    'Proficiência com Canhões',
    'Proficiência com Canhões. Você adquire proficiência com Canhões e pode recarregar um Canhão como Ação Bônus em vez de uma ação. Só pode executar essa Ação Bônus se não se tiver movido durante o seu turno; depois de executá-la, seu Deslocamento é 0 até o fim do turno. A partir do nível de personagem 11, isso não reduz o Deslocamento e, ao executar a ação Atacar, você pode substituir um dos ataques por recarregar o Canhão. Ao alcançar o nível 20, pode ignorar a propriedade Artilharia dos Canhões.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cannoneer'),
    3,
    'Cerco',
    'Cerco. Seus ataques com Canhões causam dano dobrado a objetos e estruturas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'cannoneer'),
    4,
    'Costas Fortes',
    'Costas Fortes. O peso de Canhões e Balas de Canhão conta como metade para você.'
  )
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
