-- Seed Griffon's Saddlebag Book One — subclasses (Part II)

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'path-of-the-glacier',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho da Glaciar',
  'Domine inimigos com a força de uma nevasca e armadura de gelo',
  'Nascidos na gélida e imponente Everglaciar, bárbaros do Caminho da Glaciar aprenderam a abrigar a quietude, a paciência e a determinação implacável da paisagem gelada — e sua destruição.',
  'Nascidos na gélida e imponente Everglaciar, bárbaros do Caminho da Glaciar aprenderam a abrigar a quietude, a paciência e a determinação implacável da paisagem gelada — e sua destruição. Esses guerreiros transformam o corpo em bunkers móveis poderosos, tão difíceis de derrubar quanto de escapar.

Quem segue este caminho costuma ser caçador treinado que aprecia a perseguição paciente. Prosperam no perigo que impõem às presas em fuga e se orgulham da abordagem lenta e constante.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'college-of-choreography',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  'Colégio da Coreografia',
  'Inspire aliados e confunda inimigos com movimento ágil',
  'Bardos do Colégio da Coreografia contam histórias e performam sem som, usando movimento feérico e mágico para inspirar e confundir.',
  'Bardos do Colégio da Coreografia contam histórias e performam sem som, escolhendo mover-se com graça feérica e magia para evitar danos e inspirar outros. Essas danças vêm da Festerwood, cujos esporos radiantes e luz geravam performances miraculosas e perigos mortais. Estão do taverna local aos palcos mais altos, comovendo multidões ou incitando rebelião. Em cada passo, inspiram coragem, movimento e participação.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'astral-domain',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  'Domínio Astral',
  'Controle o fluxo do espaço e da magia planar',
  'Deuses do Plano Astral estão perdidos no tempo e no espaço tanto quanto o reino que governam. Clérigos deste domínio veem o vazio como algo e conduzem outros ao destino final de todas as coisas.',
  'Deuses do Plano Astral estão perdidos no tempo e no espaço tanto quanto o reino que governam. O Plano Astral preenche as lacunas entre os planos e equilibra o multiverso. Praticantes deste domínio veem a ausência de tudo como algo e consideram o Astral o destino final de todas as coisas. Seguem o caminho até lá e ajudam outros nessa jornada de entropia. Clérigos do Domínio Astral são caóticos por natureza, mas costumam destruir o mal onde o encontram.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'the-unbroken-circle',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo Inquebrável',
  'Use a força da natureza para potencializar sua maestria marcial',
  'Ordem de druidas que abandonou ensinamentos pacientes para tomar armas em defesa da natureza, formando milícias contra ameaças ao sagrado.',
  'O Círculo Inquebrável é uma ordem de druidas que abandonou os ensinamentos pacientes dos antecessores para tomar armas em defesa da natureza. Formam milícias e canalizam a fúria da natureza para expulsar o mal que ameaça terras sagradas.

Há caos natural nesses druidas, mas corpo e impulsos são domados por treino e disciplina. Originários da implacável Festerwood, seus ensinamentos são tão rigorosos quanto a floresta.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'couatl-herald',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Arauto Couatl',
  'Mostre misericórdia e apoie aliados como paragono de civismo',
  'Guerreiros marciais que neutralizavam ameaças sem recorrer sempre à força letal — símbolos de paz na outrora grande cidade de Hearth.',
  'Os Arautos Couatl eram guerreiros marciais cujo intento era neutralizar ameaças sem sempre recorrer à força letal. Eram símbolos amados de paz na outrora grande cidade de Hearth, cuja destruição se perdeu quase por completo na história. Você pode vir de uma linhagem oculta que escapou do colapso, ou ter encontrado diários antigos de um instrutor da cidade. Um verdadeiro Arauto Couatl defende todas as vidas, independentemente das transgressões.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'warrior-of-the-celestial',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
  'Guerreiro Celestial',
  'Responda com divindade, apoie aliados e fulmine inimigos',
  'Monjes pacíficos e protetores que meditam para canalizar energia celestial em defesa dos seus.',
  'Monjes Guerreiros Celestiais são pacificadores e protetores de seu povo escolhido. Meditam para compreender um ser divino e canalizar energias celestiais. São pensativos, pacientes e compreensivos, mas oferecem pouca misericórdia quando intenções más ficam claras.

A tradição surgiu na perdida cidade de Hearth como tributo aos couatl guardiões. Embora rara, pequenos mosteiros protegidos podem ainda existir após a destruição da cidade.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'oath-of-the-hearth',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento da Lareira',
  'Proteja amigos com calor e incinere quem os ameaçar',
  'Juramento originado na cidade de Hearth, jurando proteger a metrópole tropical sob guardiões celestiais.',
  'O Juramento da Lareira vem da cidade homônima, cujo declínio trágico se perdeu ao longo de séculos. Paladinos juraram proteger aquela cidade ensolarada em nome de guardiões celestiais — e cumpriram o juramento até o fim. Você pode jurá-lo por laço de sangue ou por histórias e encontros com seres celestiais relacionados. Vestem armaduras com símbolos de comunidade, fogo e sol.

Esses paladinos compartilham os seguintes preceitos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'winter-trapper',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  'Caçador Invernal',
  'Use armadilhas geladas para imobilizar presas',
  'Mestres do controle originários da Everglaciar, experts em manter presas e adversários à distância.',
  'Caçadores Invernais dominam controle e mantêm adversários e presas indefesos e à distância. Originários da Everglaciar, são caçadores treinados que permanecem de pé quando outros cairiam, usando magia e acrobacia para proteger a si e aos aliados.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'runetagger',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Runetaggeiro',
  'Use runas poderosas para enfraquecer inimigos e escapar',
  'Rebeldes, artistas e espiões que marcam alvos com runas mágicas difíceis de rastrear.',
  'Runetaggeiros concentram esforços em aperfeiçoar a arte de marcas especiais para reivindicar e debilitar alvos. Líderes rebeldes, artistas, espiões e membros do submundo político podem pertencer a este arquétipo. Tática de subterfúgio da Festerwood; difíceis de prender. As marcas mágicas viram cartão de visita — e a fama cresce com os feitos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'frost-sorcery',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  'Feitiçaria Glacial',
  'Invoque tempestades e gelo escorregadio para controlar o campo',
  'Magia nascida do Everheart, núcleo da Everglaciar — você é encarnação do frio.',
  'Sua magia vem de fragmentos do Everheart, força por trás da Everglaciar. Pode ser herança de ancestrais que protegeram o núcleo mágico, ou encontro acidental com o gelo encantado. Seja qual for a fonte, você é criatura de frio encarnado.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'astral-griffon-patron',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'Patrono Grifo Astral',
  'Controle seu próprio espaço extradimensional',
  'Pacto com Criir, semideus grifo do Plano Astral que coleciona tesouros mundanos e mágicos pelo multiverso.',
  'Você firmou pacto com Criir, semideus grifo do Plano Astral cujo controle sobre espaço, criação e dimensões de bolso se estende pelo multiverso. Busca expandir coleção eclética de tesouros — valiosos ou não para lojas comuns, mas especiais para o Grifo Astral. A ligação pode levar longe em busca de artefatos ou a uma taverna por um medalhão manchado. Os objetivos raramente são claramente bons ou maus.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
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
  'materializer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  'Materializador',
  'Crie e destrua matéria como mestre artesão e arcanista',
  'Magos que focam a força que mantém tudo unido, tecendo matéria do nada.',
  'Alguns magos abandonam escolas arcanas e focam a força que une tudo. Tecem e recriam matéria para arte e utilidade, valorizando ofícios de artesãos como magia por si. Materializadores veem beleza no potencial da matéria bruta — em bibliotecas antigas ou no centro de uma forja movimentada. Muitos cuidam das bolsas de componentes e se identificam com bardos e artesãos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

