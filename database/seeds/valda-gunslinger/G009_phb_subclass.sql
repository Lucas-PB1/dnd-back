-- Seed Pistoleiro subclasses
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'deadeye',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Olho Morto',
  'Atire com precisão no alvo',
  'Uma bala bem posicionada é mais poderosa que uma espada, flecha ou magia. Na verdade, você acredita que todo conflito violento deveria soar como um único estalo seguido de um longo silêncio. Esses tiros exigem perfeição, mesmo à distância, pois, quando bem executados, são tão mortais para',
  'Atire com precisão no alvo

Uma bala bem posicionada é mais poderosa que uma espada, flecha ou magia. Na verdade, você acredita que todo conflito violento deveria soar como um único estalo seguido de um longo silêncio. Esses tiros exigem perfeição, mesmo à distância, pois quando bem executados, são tão mortais para o alvo quanto estupendos para o público.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'high-roller',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Grande Apostador',
  'Jogue com a vida e a morte',
  'A fortuna é algo inconstante – a menos que você seja um High Roller. Esses Pistoleiros são mestres em cartas e lançadores de dados que misturam seu amor pelo risco com seu talento para o uso de armas. Os High Rollers abusam da sorte até que ela acabe e depois empurram com mais força. Por que se contentar com uma vitória quando você pode apostar que eu',
  'Jogue com a vida e a morte

A fortuna é algo inconstante – a menos que você seja um High Roller. Esses Pistoleiros são mestres em cartas e lançadores de dados que misturam seu amor pelo risco com seu talento para o uso de armas. Os High Rollers abusam da sorte até que ela acabe e depois empurram com mais força. Por que se contentar com uma vitória quando você pode apostar tudo e ganhar muito?',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'secret-agent',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Agente Secreto',
  'Envolva-se em espionagem e assassinato',
  'Conhecimento é poder. A melhor maneira de derrotar seus inimigos é roubar o que eles sabem e substituí-lo por desinformação. Para esse fim, você foi treinado nas formas de guerra secreta, o que lhe dá uma ampla gama de habilidades para complementar suas temíveis habilidades de artilharia.',
  'Envolva-se em espionagem e assassinato

Conhecimento é poder. A melhor maneira de derrotar seus inimigos é roubar o que eles sabem e substituí-lo por desinformação. Para esse fim, você foi treinado nas formas de guerra secreta, o que lhe dá uma ampla gama de habilidades para complementar suas temíveis habilidades de artilharia.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'spellslinger',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Pistoleiro Arcano',
  'Complemente seu Gunslinging com Arcana',
  'Magia e armas não são tão diferentes – o poder arcano é como a pólvora, uma magia é como uma bala e você é como uma arma, direcionando suas magias com precisão para alvos infelizes. Pistoleiros Arcanos misturam as disciplinas de uso de armas e lançamento de magias, às vezes carregando cargas arcanas com y',
  'Complemente seu Gunslinging com Arcana

Magia e armas não são tão diferentes – o poder arcano é como a pólvora, uma magia é como uma bala e você é como uma arma, direcionando suas magias com precisão para alvos infelizes. Pistoleiros Arcanos misturam as disciplinas de uso de armas e lançamento de magias, às vezes carregando cargas arcanas com seus tiros e disparando balas aprimoradas com iluminação, gelo ou chamas.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'trick-shot',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Tiro de Trucagem',
  'Ricochete de balas de todos os ângulos',
  'Noa Kriukova',
  'Ricochete de balas de todos os ângulos

Precisão significa coisas diferentes para pessoas diferentes. Para você, a verdadeira precisão não consiste necessariamente em acertar um alvo no primeiro tiro, mas pode incluir acertar o alvo depois que a bala quica uma dúzia de vezes. Seus ataques são tão perigosos se errarem, ou mesmo depois de atingirem o alvo, quanto os de outros enquanto ainda estão no ar.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'white-hat',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Chapéu Branco',
  'Proteja seus aliados e cumpra a lei',
  'Alguns Pistoleiros vivem de acordo com um código e esperam que outros façam o mesmo. Esses Pistoleiros, conhecidos como Chapéus Brancos, às vezes atuam como oficiais da lei, mas nunca hesitam em fazer o que é certo quando a lei diz o contrário. Apesar de sua afinidade com armas mortais, os Chapéus Brancos preferem manter',
  'Proteja seus aliados e cumpra a lei

Alguns Pistoleiros vivem de acordo com um código e esperam que outros façam o mesmo. Esses Pistoleiros, conhecidos como Chapéus Brancos, às vezes atuam como oficiais da lei, mas nunca hesitam em fazer o que é certo quando a lei diz o contrário. Apesar de sua afinidade com armas mortais, os Chapéus Brancos preferem manter seus amigos seguros e subjugar seus inimigos de forma não violenta – uma preferência que seus inimigos nem sempre atendem.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
