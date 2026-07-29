-- Seed Valda subclasses (Player Pack)
-- Conteúdo canônico Valda: Spire of Secrets

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'path-of-the-muscle-wizard',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho do Mago Musculoso',
  'Seja um “mago” musculoso e furioso',
  'Você é um “mago” de músculos enormes: chapéu pontudo, livro de bobagens e a convicção inabalável de que ninguém deve questionar sua magia.',
  'Você é um mago! Talvez você tenha ido para uma escola de magia com uma bolsa de futebol ou simplesmente tenha pegado um livro na academia e começado a ler. Não importa como você chegou aqui, você é um mago, que por coincidência tem músculos enormes e ondulantes. Você tem o grande chapéu idiota e o livro cheio de bobagens e tudo mais!

Você gentilmente lembra aos outros, muitas vezes batendo neles até virar polpa e quebrando seus ossos, que seus poderes mágicos não devem ser questionados. Você é um bom mago – o melhor até! E só um tolo diria o contrário.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'dungeoneer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Explorador de Masmorras',
  'Sobreviva à masmorra',
  'Veterano de incursões suicidas: superstições, precauções e o hábito de acertar o monstro antes que o monstro acerte você.',
  'Apenas os tolos mergulhariam de cabeça em uma cripta abandonada cheia de monstros e armadilhas mortais, mas parece que apenas os tolos emergem de tais criptas carregados com tanto saque quanto podem carregar. O explorador de masmorras arquetípico é um veterano nessas incursões suicidas em masmorras e tornou-se intimamente familiarizado com os perigos que elas representam. No decorrer de suas aventuras, tal Explorador de Masmorras terá adotado inúmeras práticas recomendadas, juntamente com uma litania de superstições não comprovadas que eles acreditam que os mantêm vivos. Princípios que vão de “seja sempre o primeiro a acertar o monstro” a “nunca seja o primeiro a tocar em um baú de tesouro” estão no diário do Explorador de Masmorras. No entanto, provavelmente é melhor ser paranóico e supersticioso do que ficar deitado no fundo de uma armadilha de fosso, incinerado por uma Bola de Fogo ou digerido por um mímico.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'warrior-of-the-street',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
  'Guerreiro das Ruas',
  'Ataque com combos e movimentos especiais',
  '“Luta de rua” é uma disciplina urbana fundada na necessidade, cujo tipo único e incrivelmente rápido de artes marciais foi aprimorado e aperfeiçoado tanto em brigas de beco quanto em torneios. Os monges que adotam esta técnica relativamente nova dão comparativamente pouco valor à espiritualidade.',
  '“Luta de rua” é uma disciplina urbana fundada na necessidade, cujo tipo único e incrivelmente rápido de artes marciais foi aprimorado e aperfeiçoado tanto em brigas de beco quanto em torneios. Os monges que adotam esta técnica relativamente nova dão comparativamente pouco valor à iluminação espiritual e ao foco interior; a emoção do timing em frações de segundo, combos rápidos e nocautes decisivos os levam a se tornarem os melhores combatentes do mundo.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'oath-of-revelry',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento da Folia',
  'Trabalhe Duro e Festeje Mais Ainda',
  'Paladinos que fazem o Juramento da Folia fazem um voto solene de festejar dia e noite até que seus corações desistam. Antítese dos cruzados formais e ordeiros, esses emissários da farra viajam pela terra, invadindo festas e causando confusão onde quer que levantem um copo. Como um',
  'Paladinos que fazem o Juramento da Folia fazem um voto solene de festejar dia e noite até que seus corações desistam. Antítese dos cruzados formais e ordeiros, esses emissários da farra viajam pela terra, invadindo festas e causando confusão onde quer que levantem um copo. As autoridades se irritam com sua chegada, mas os jovens comemoram, pois um Paladino da Festa sempre vem acompanhado de diversão.

Esses paladinos compartilham os seguintes preceitos:

Respeite as doutrinas do Codicus Brodicus.

Celebre toda ocasião, convidando amigos e inimigos igualmente.

Quando necessário, lute pelo seu direito de festejar.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'arachnoid-stalker',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Perseguidor Aracnídeo',
  'Dispare Teias e Escale Paredes',
  'Um evento que mudará sua vida, como ser amaldiçoado por um drider ou ser mordido por um aracnídeo perigosamente transmutado, imbuiu você das habilidades de uma aranha. Essa transformação pode ter deixado você fisicamente inalterado, ou você pode ter desenvolvido meia dúzia de olhos, esguios e peludos.',
  'Um evento que mudará sua vida, como ser amaldiçoado por um drider ou ser mordido por um aracnídeo perigosamente transmutado, imbuiu você das habilidades de uma aranha. Essa transformação pode ter deixado você fisicamente inalterado, ou você pode ter desenvolvido meia dúzia de olhos, membros esguios e peludos ou um conjunto de mandíbulas desumanas. Quaisquer que sejam os efeitos colaterais, agora você pode produzir veneno mortal e cordas de teia de seda com as palmas das mãos e até escalar paredes com as pontas dos dedos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'future-you-patron',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'Patrono Eu do Futuro',
  'Manipule o tempo com a ajuda do futuro',
  'Seu patrono é você em um futuro distante. Talvez o seu eu futuro tenha encontrado um artefato de grande poder conectando-os ao passado, que agora eles devem levá-lo a descobrir, ou talvez eles tenham aprendido as artes místicas com o seu eu futuro há muito tempo, um ciclo que você terá que enfrentar.',
  'Seu patrono é você em um futuro distante. Talvez o seu eu futuro tenha encontrado um artefato de grande poder conectando-os ao passado, que agora eles devem levá-lo a descobrir, ou talvez eles tenham aprendido as artes místicas com o seu eu futuro há muito tempo, um ciclo que você terá que continuar algum dia. Seu eu futuro esqueceu os detalhes de algumas coisas e se recusa abertamente a lhe contar sobre coisas que você “ainda não pode saber”, mas mesmo assim oferece uma visão e orientação convincentes. Você não tem certeza do que o seu eu futuro está planejando para o seu futuro (e para o passado dele), mas uma coisa é certa: eles precisam de você vivo.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
