-- Seed Valda species
-- Conteúdo canônico Valda: Spire of Secrets

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'geppettin',
  'Geppettin',
  'Construto',
  'Pequeno (cerca de 0,60–0,90 m) ou Médio (cerca de 1,80 m; apenas construção Marionete)',
  '9 metros',
  'Sempre uma alegria para as crianças, os geppettin lembram brinquedos vivos feitos de madeira, tecido ou porcelana. Embora facilmente confundidos com fantoches, os geppettin não são manipulados por um marionetista que está fora de vista; eles são animados, sencientes e independentes.

Como espécie, os geppettin são uma raridade. Embora raros, eles são numerosos o suficiente e compartilham semelhanças suficientes para que possam ser considerados uma espécie real, e não apenas acidentes mágicos estranhos. Embora possa haver criadores dedicados de geppettin, como acontece com os golems, muitos geppettin ganham vida por conta própria.

Os Geppettin costumam ser mais baixos que os halflings. Suas características físicas variam muito de tipo para tipo, mas muitas vezes se assemelham a Humanoides. Apesar de serem feitos de materiais um tanto frágeis, a senciência lhes confere uma resistência estranha. Eles nunca têm fome e raramente se cansam. A maioria encontra alguma forma de trabalho ou profissão no entretenimento, mas alguns obtêm um sucesso fantástico como espiões e assassinos.

Como Construtos, os geppettin não envelhecem e amadurecem assim que se tornam sencientes.',
  '{"editionSlug":"valda-spire-2024-en","book":"Valda''s Spire of Secrets: Player Pack","language":"en","citationSlug":"valda-spire-2024-en:player-pack","source":"valda-spire-player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'mandrake',
  'Mandrágora',
  'Planta',
  'Médio (cerca de 1,50–2,10 metros)',
  '9 metros',
  'Com uma casca grossa e folhas crescendo nas extremidades, você poderia ser perdoado por acreditar que as mandrágoras são simplesmente plantas bizarras, entes ou árvores animadas. A verdade é muito mais estranha: as mandrágoras são um meio-termo bizarro entre o animal e a planta. Um icor rubi bombeia através de suas veias radiculares, e eles podem igualmente comer coisas vivas ou aproveitar a luz do sol para se alimentar. Dependendo da época em que são colhidas, uma mandrágora pode se assemelhar a uma muda vigorosa e frondosa ou a uma árvore espessa e lenhosa.

As pessoas comuns há muito tempo têm conceitos errados sobre as mandrágoras – acreditando categoricamente que elas sejam bebês chorões – mas os druidas as conhecem como os emissários verdes que ficam entre os reinos dos animais e das plantas, fazendo a paz para todas as partes. Na tradição druídica, as mandrágoras são criações personalizadas de uma deusa primordial da natureza, destinadas a atuar como delegadas de sua vontade.

Hoje, as mandrágoras são raras e vivem nas florestas perto de onde as aldeias e cidades encontram a verdadeira natureza selvagem. Eles vivem centenas de anos, tornando-se mais largos e nodosos com a idade.

Martin Kirby-Jackson',
  '{"editionSlug":"valda-spire-2024-en","book":"Valda''s Spire of Secrets: Player Pack","language":"en","citationSlug":"valda-spire-2024-en:player-pack","source":"valda-spire-player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
