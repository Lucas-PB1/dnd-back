-- Seed Valdas Player Pack 2 subclasses

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'pistolero',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Pistolero',
  'Dispare revólveres com velocidade incrível',
  'Balas são poder, e você há muito acredita que mais balas equivalem a mais poder.',
  'Balas são poder, e você há muito acredita que mais balas equivalem a mais poder. Sua especialidade é desferir uma chuva de fogo mortal para pulverizar seus inimigos. Nem toda bala precisa ser precisa para fazer a diferença.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'college-of-masks',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  'Colégio das Máscaras',
  'Incorpore personagens arquetípicos por meio de máscaras teatrais',
  'Bardos do Colégio das Máscaras são intérpretes virtuosos que praticam tornar-se as figuras que interpretam, em vez de apenas imitá-las.',
  'Bardos do Colégio das Máscaras são intérpretes virtuosos que praticam tornar-se as figuras que interpretam, em vez de apenas imitá-las. Bardos que se juntam a este colégio acreditam que toda a vida é encenada numa “Grande Peça”, e que todas as pessoas usam máscaras metafóricas o tempo todo. Para participar deste grande drama cênico, um Bardo mascarado carrega várias Máscaras de Persona, cada uma conferindo os poderes de uma figura teatral específica.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'dragon-domain',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  'Domínio do Dragão',
  'Canalize o poder dos deuses-dragão',
  'Embora os dragões sejam os principais adoradores do Domínio do Dragão, as divindades dracônicas aceitam a adoração de qualquer um que cobice riqueza ou poder.',
  'Embora os dragões sejam os principais adoradores do Domínio do Dragão, as divindades dracônicas aceitam a adoração de qualquer um que cobice riqueza ou poder. Clérigos do Domínio do Dragão, muitas vezes considerados cultistas, podem canalizar o poder e o aspecto dos dragões, desencadeando temível magia elemental e manifestando a presença imponente de um wyrm ancestral.

Os principais deuses do Domínio do Dragão incluem Tiamat, a mãe de cinco cabeças dos dragões cromáticos, e Bahamut, o deus justo e sábio dos dragões metálicos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'circle-of-the-city',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo da Cidade',
  'Domine a selva urbana',
  'O Círculo da Cidade retira seu poder de edifícios, ruas e pessoas.',
  'O Círculo da Cidade retira seu poder de edifícios, ruas e pessoas. Esses “Druidas Urbanos” fazem suas casas em assentamentos vastos, longe dos domínios de seus irmãos selvagens.

A magia de um Druida Urbano pode retorcer as ruas da cidade em nós e erguer muros labirínticos em becos. Eles podem saltar de telhado em telhado, comungar com portas e paredes em busca de informações, ou se transformar em um rato para passar despercebidos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'beastborne',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  'Portador Bestial',
  'Canalize a fúria licantropa',
  'Seja por uma mordida infectada ou por uma maldição insidiosa, seu sangue foi contaminado pela magia da licantropia.',
  'Seja por uma mordida infectada ou por uma maldição insidiosa, seu sangue foi contaminado pela magia da licantropia. Uma forma feroz e bestial jaz logo sob sua pele, aguardando o fascínio do sangue e a emoção da caçada. Talvez, se você conseguir evitar a violência ou o chamado da luz da lua, possa resistir ao impulso licantropo. Ou talvez abrace a infecção como uma bênção ou a empunhe como uma arma temível.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'heroic-sorcery',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  'Feitiçaria Heróica',
  'Empunhe espadas e feitiçaria como um herói reencarnado',
  'Você é a reencarnação de um herói lendário conhecido por ter abatido muitos inimigos terríveis, e sua magia feiticeira brota do seu passado lendário.',
  'Você é a reencarnação de um herói lendário conhecido por ter abatido muitos inimigos terríveis, e sua magia feiticeira brota do seu passado lendário. Ser chamado de volta à vida — seja pelos deuses, por um mago muito poderoso ou por um ciclo de reencarnação — despertou um poço de magia e seus antigos instintos de batalha.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'magic-missile-mage',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  'Mago dos Mísseis Mágicos',
  'Conjure Mísseis Mágicos melhor do que qualquer um',
  'Mísseis Mágicos é uma magia essencial de mago, amada por sua versatilidade e precisão infalível.',
  'Mísseis Mágicos é uma magia essencial de mago, amada por sua versatilidade e precisão infalível. Como um Mago dos Mísseis, porém, seu apreço pela magia beira a obsessão. Seus estudos se concentram inteiramente nesta magia, explorando cada aspecto de sua conjuração, o que resulta em novas melhorias e maior poder.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
