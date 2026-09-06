-- Espécies Steinhardt Eldritch Hunt Player Pack

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'manikin',
  'Manikin',
  'Construto',
  'Pequeno (cerca de 0,60–1,20 m) ou Médio (cerca de 1,20–2,10 m)',
  '9 metros',
  'Com um toque de ouro, um sopro de relâmpago e horas de solda e articulação meticulosas, um manikin “nasce”. Frequentemente chamados de marionetes ou bonecos vivos, essas criaturas foram originalmente criações dos Scions, uma seita luyarnhiana que busca forjar uma força capaz de proteger a cidade. Embora cada manikin seja diferente — de fato, podem assemelhar-se a qualquer espécie — a fina costura dourada que une as placas da pele artificial denuncia que a criatura é obra humana.

Livre-arbítrio. Instruções inscritas em olhos humanos dentro do crânio regem todos os manikins. Quase sempre há um sistema de segurança que garante obediência à lei e impede que o manikin se volte contra o mestre. Em alguns casos, o criador até faz o manikin sentir amor pelo artífice. Concebidos como objetos animados capazes de cumprir ordens, manikins que expressam ideias de libertação costumam ser descartados antes que o pensamento vire ato. Embora as intenções iniciais dos Scions fossem nobres, brincar de deus deu-lhes gosto pelo poder — e não pretendem conceder livre-arbítrio aos servos animados.

Embora projetados para muitas funções, os manikins dividem-se em três categorias amplas:

Custódios. Tipicamente construídos como alternativa a golens, servem de mordomos, trabalhadores e carne de canhão. Como seres sencientes, juram defender a pessoa — ou cliente — para quem foram criados. A morte do dono muitas vezes os deixa sem rumo, vagando como cavaleiros errantes sem senhor.

Manipuladores. Projetados para espionagem. Pigmentos foscos e porte esguio ajudam a sumir nas sombras, enquanto armas ocultas podem ser empunhadas e guardadas rapidamente.

Teatrais. Feitos para entreter, trazem alegria a nobres, clero e povo. São o único tipo sem intenção letal; corpos sustentados por cordas invisíveis e intangíveis, movendo-se aparentemente em desafio à física. Com o agravamento da praga, os Scions voltaram-se à produção de manikins contra o Flagelo, e o número de teatrais tem diminuído.',
  '{"editionSlug":"steinhardt-eldritch-hunt-2024-en","book":"Steinhardt''s Guide to the Eldritch Hunt: Player Pack","language":"pt","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","source":"steinhardt-eldritch-hunt-player-pack"}'::jsonb
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
  'scourgeborne',
  'Nascido do Flagelo',
  'Monstruosidade',
  'Médio (cerca de 1,20–2,10 m)',
  '9 metros',
  'Nascidos do Flagelo não deveriam existir. São uma abominação do mundo, uma maldição vil sobre aqueles que espiaram além do véu e sucumbiram à loucura. A aparência distorcida espelha os recessos mais obscuros da personalidade. Toda criatura senciente abriga um monstro na alma — o lado que inveja o vizinho, que odeia amigos que o ignoram, que deseja ferir quem o ofende. A maioria esconde esse monstro atrás de uma máscara de virtudes falsas. Não o nascido do Flagelo: a maldição tomou os aspectos mais torcidos da personalidade e os expôs ao mundo. Quanto mais ressentimento, ódio e raiva, mais monstruosa a aparência.

Muitos veem essa revelação Eldritch como maldição que empurra à depravação até só restar o monstro. Outros recusam quebrar-se: com a escuridão interior agora visível, só resta aceitá-la. Diz-se que admitir a falha é o primeiro passo para corrigi-la. Aqueles que abraçam o monstro interior sem deixar que ele governe costumam tornar-se heróis messiânicos nos muros de Luyarnha — tentando redimir o mundo, e talvez um dia a si mesmos.

Aranea. Quem trama e tece mentiras em torno de si costuma tornar-se aranea (meio-aranha). Diferem dos demais: muitos se transformam, poucos mantêm a sanidade. São os menos confiáveis entre os nascidos do Flagelo.

Belua. Quem nutre raiva fervente muitas vezes vira a mais feral das bestas. Beluas (meio-lobos) são as mais ferozes nas ruas de Luyarnha; muitos escondem os olhos, pois a sede de sangue torna o olhar vermelho-carmesim.

Cervus. Os mais raros. Diziam que só quem comera a carne dos seus se tornava cervus (meio-cervo ou waldschrat) — lenda já desmentida. Curiosamente, costumam ser os mais aptos a combater criaturas da noite, ganhando respeito dos caçadores.

Vespertilio. Quem se escondeu do medo diante da adversidade é amaldiçoado a tornar-se essas bestas da noite. Vespertilios (meio-morcegos) tiveram grande parte da visão roubada e receberam asas semi-quebradas numa cruel farsa do destino. Quem domina esses poderes pode tornar-se dos caçadores mais ferozes.',
  '{"editionSlug":"steinhardt-eldritch-hunt-2024-en","book":"Steinhardt''s Guide to the Eldritch Hunt: Player Pack","language":"pt","citationSlug":"steinhardt-eldritch-hunt-2024-en:player-pack","source":"steinhardt-eldritch-hunt-player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
