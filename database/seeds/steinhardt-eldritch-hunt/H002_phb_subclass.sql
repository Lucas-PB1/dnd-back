-- Seed Steinhardt Eldritch Hunt — subclasses (Player Pack)

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'path-of-the-lightning-vessel',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho do Recipiente Relâmpago',
  'Corpo atravessado por relâmpago que esmaga o campo de batalha',
  'Um Recipiente Relâmpago é uma besta de combate cujo corpo transborda eletricidade, caindo no meio da luta e incinerando inimigos.',
  'Um Recipiente Relâmpago é uma besta de combate. Com o corpo transbordando de relâmpago, chega de surpresa — muitas vezes saltando de construções ou distâncias impossíveis — antes de cair no meio da luta. A presença de um único Recipiente costuma virar a maré do combate. Sua eletricidade feroz atravessa os inimigos, deixando um rastro de corpos carbonizados.

Os Scions criaram os Recipientes Relâmpago implantando hastes galvanizadas na coluna de recém-nascidos e submetendo-os a terapia de choque violenta. Poucos cresceram capazes de canalizar o relâmpago; muitos ficaram mutilados — um preço pequeno pela salvação, segundo seus criadores.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'circle-of-symbiosis',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo da Simbiose',
  'Enxerte a natureza em si com osteomancia',
  'Druidas que cortam os próprios membros e os substituem por fragmentos do mundo natural, tornando-se entidades simbióticas despertas.',
  'O Círculo da Simbiose permite que Druidas dedicados à Natureza se tornem um com ela — no sentido mais literal. Dominaram a osteomancia e a usam para seccionar membros e substituí-los por fragmentos do mundo natural: patas de cervo, galhos no lugar dos braços, até a cabeça de um animal nos mais zelosos.

Ao se regozijar nesses poderes, o círculo busca tornar todos os seres vivos um com a Natureza — ou então. Nenhum sacrifício é grande demais pela causa.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'blood-hound',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Sabujo de Sangue',
  'Teça o próprio sangue em golpes sobrenaturais',
  'Caçadores nascidos de experimentos com sangue-alcatrão que tecem o próprio sangue em ataques mágicos devastadores.',
  'Sabujo de Sangue são seres amaldiçoados que não deveriam existir. Nascidos de experimentos do Obitus Scholare, esses caçadores usam um método amaldiçoado de combate, tecendo o próprio sangue em ataques para produzir efeitos sobrenaturais. Seu poder vem do sangue-alcatrão, amalgama do sangue de centenas de espécies injetado à força nas veias dos caçadores.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'oath-of-the-eldritch-hunt',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento da Caça Eldritch',
  'Erradique o antinatural alimentando-se do poder da presa',
  'Paladinos jurados a destruir aberrações e alienígenas, caminhando na linha tênue entre poder roubado e sanidade.',
  'O Juramento da Caça Eldritch é prestado à erradicação do antinatural, do aberrante e do alienígena. Esses caçadores caminham numa linha tênue, aprimorando-se com os poderes da presa enquanto tentam manter a própria sanidade. Infelizmente, essa fome frenética leva muitos à loucura — e não é raro que esses Paladinos precisem caçar os seus.

Este juramento é mais comum entre Paladinos da Ordem Radiante — erroneamente apelidados de templários cinzentos, caçadores de bruxas e cavaleiros aberrantes.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'torturer-conclave',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  'Conclave do Torturador',
  'Extraia a verdade e quebre inimigos com técnicas inquisitoriais',
  'Patrulheiros inquisidores que usam ferramentas e técnicas de tortura para prevenir a Flagelo e destruir adversários em combate.',
  'Ocultos na radiância de Luyarnha, um conclave de Patrulheiros jurou preservar a paz dentro dos muros — a qualquer custo. Sempre vigilantes contra o avanço insidioso da Flagelo, aperfeiçoaram o ofício inquisitorial: encontrar e interrogar vítimas — e até potenciais vítimas — antes que os sinais da doença se manifestem.

Em combate, trazem essa expertise impiedosa, quebrando inimigos com precisão metódica. Não há misericórdia, pois sabem que nenhuma lhes seria estendida.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'blade-of-radiance',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Lâmina do Esplendor',
  'Santo de aço com lâmina santificada e pontos divinos',
  'Ordem letal da Igreja — Santos de Aço — que santificam armas e canalizam fervor divino em combate.',
  'As Lâminas do Esplendor, também chamadas Santos de Aço, são uma das ordens mais letais da Igreja. Para tornar-se uma lâmina, é preciso ser seguidor devoto da fé: só quem morreria pela causa é considerado digno. Treinam nos muros da Igreja, adotando o clero como nova família.

Seu fervor concede poderes inigualáveis no campo de batalha: empunham armas massivas como brinquedos, impregnam a lâmina com poder divino e destroem inimigos um a um. O objetivo comum: salvaguardar a Igreja e seus membros, custe o que custar.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'osteomancer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  'Osteomante',
  'Manipule ossos — os seus e os dos outros',
  'Magos amaldiçoados que colhem poder dos ossos, dobrando esqueletos inimigos e o próprio corpo como marionetes.',
  'Osteomantes são Magos poderosos que compreendem o poder colhido dos ossos. Dizem ser amaldiçoados; fala-se deles à sombra da noite. Quem tem a astúcia, a bravura ou a simples imprudência de pesquisar nesse campo é recompensado com conhecimento aflito.

Suas habilidades inquietam a maioria. Por focarem em manipular ossos — tabu e mistério — o povo os vê como seres maldosos. Quem vê sua magia compara a um mestre de marionetes. Muitos não percebem que a marionete favorita do Osteomante é ele mesmo.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
