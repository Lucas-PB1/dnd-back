-- Seed rpg.phb_class
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class (slug, name, tagline, summary, description, primary_ability_label, primary_ability_operator, hit_die_id, hp_level1_die_value, hp_fixed_per_level, hp_minimum_gain_per_level, hp_constitution_mod_applies, subclass_unlock_level, subclass_label, skill_choice_count, skill_choice_from, source_citation_id, spell_slot_pattern_id)
VALUES
  ('barbarian', 'Bárbaro', 'Combatente feroz da Fúria primitiva', 'Avance com Fúria e entre em combate corpo a corpo.', 'Bárbaros são combatentes poderosos,
impulsionados por forças primitivas do multiverso que se manifestam com sua Fúria. Mais
do que uma simples emoção — e não limitada à raiva — essa Fúria é a encarnação da ferocidade de um
predador, da fúria de uma tempestade e da turbulência
do mar.
Alguns Bárbaros personificam sua Fúria como um
espírito feroz ou um antepassado reverenciado. Outros
a veem como uma conexão com a dor e o sofrimento
do mundo, um emaranhado impessoal de magia selvagem ou uma expressão de seu eu mais profundo. Para
cada Bárbaro, a Fúria é uma força que alimenta não
apenas sua habilidade de combate, mas também seus
reflexos aprimorados e sentidos ampliados.
Bárbaros frequentemente servem como protetores
e líderes em suas comunidades. Eles se entregam de
cabeça no perigo para que aqueles sob sua proteção
não precisem. Sua coragem diante do perigo torna os
Bárbaros perfeitamente adequados para aventuras.', 'Força', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd12'), 12, 7, 1, TRUE, 3, 'Trilha', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), NULL),
  ('bard', 'Bardo', 'Inspirador performista de música, dança e magia', 'Conjure magias que inspiram e curam aliados ou confundem inimigos.', 'Bardos são peritos em inspirar os outros,
aliviar ferimentos, desanimar inimigos e criar
ilusões. Eles acreditam que o multiverso foi trazido à
existência por meio de palavras pronunciadas e que
resquícios das Palavras de Criação ainda ressoam e
brilham em todos os planos de existência. A magia dos
Bardos tenta canalizar essas palavras, que transcendem
qualquer idioma.
Qualquer coisa pode inspirar uma nova canção ou
história, o que faz com que os Bardos sejam fascinados
por quase tudo. Eles se tornam mestres em muitas
coisas, incluindo tocar música, realizar magia e fazer
brincadeiras.
A vida de um Bardo é passada viajando, coletando conhecimento, contando histórias e vivendo da
gratidão dos ouvintes, como qualquer outro artista. No
entanto, a profundidade de conhecimento e o domínio
da magia distinguem os Bardos dos demais.', 'Carisma', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'), 8, 5, 1, TRUE, 3, 'Colégio', 3, 'any', (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'full')),
  ('warlock', 'Bruxo', 'Ocultista fortalecido com pactos sobrenaturais', 'Conjure magias derivadas de conhecimento oculto.', NULL, 'Carisma', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'), 8, 5, 1, TRUE, 3, 'Patrono', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'pact')),
  ('cleric', 'Clérigo', 'Campeão divino da magia sagrada', 'Invoque magia divina para curar, fortalecer e castigar.', NULL, 'Sabedoria', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'), 8, 5, 1, TRUE, 3, 'Domínio', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'full')),
  ('druid', 'Druida', 'Guardião da natureza e da magia primal', 'Canalize a magia da natureza para curar, moldar e controlar os elementos.', NULL, 'Sabedoria', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'), 8, 5, 1, TRUE, 3, 'Círculo', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'full')),
  ('sorcerer', 'Feiticeiro', 'Conjurador de magia inata e instável', 'Use magia inerente ao seu ser, moldando o poder à sua vontade.', 'Feiticeiros são raros. Algumas linhagens familiares
geram apenas um Feiticeiro por geração, enquanto,
geralmente, esse dom aparece de forma inesperada.
Aqueles que possuem esse poder logo percebem que
não conseguem ficar ociosos. A magia de um Feiticeiro
anseia por ser utilizada.', 'Carisma', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd6'), 6, 4, 1, TRUE, 3, 'Feitiçaria', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'full')),
  ('ranger', 'Guardião', 'Patrulheiro marcial das fronteiras selvagens', 'Una proezas marciais, magia da natureza e habilidades de sobrevivência.', NULL, 'Destreza e Sabedoria', 'and', (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd10'), 10, 6, 1, TRUE, 3, 'Arquétipo', 3, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'half')),
  ('fighter', 'Guerreiro', 'Mestre de armas e armaduras', 'Domine todas as armas e armaduras.', NULL, 'Força ou Destreza', 'or', (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd10'), 10, 6, 1, TRUE, 3, 'Arquétipo', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), NULL),
  ('rogue', 'Ladino', 'Especialista furtivo e mortal', 'Desfira Ataques Furtivos mortais enquanto evita danos através da furtividade.', NULL, 'Destreza', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'), 8, 5, 1, TRUE, 3, 'Arquétipo', 4, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), NULL),
  ('wizard', 'Mago', 'Estudioso da magia arcana', 'Estude magia arcana e domine magias para todos os propósitos.', 'Magos são reconhecidos por seu estudo
aprofundado da magia. Eles conjuram magias
explosivas, raios, ilusões e transformações
notáveis, além de invocar criaturas de outros planos,
prever o futuro e criar barreiras protetoras. Suas
magias mais poderosas podem transformar substâncias,
invocar meteoros ou abrir portais para outros mundos.
Geralmente, os Magos adotam uma abordagem acadêmica, explorando os fundamentos teóricos e categorizando magias em escolas. Figuras renomadas como
Bigby, Tasha, Mordenkainen e Yolande contribuíram
para a criação de magias icônicas reconhecidas por
todo o multiverso.
O máximo que um Mago pode vivenciar de maneira
comum é atuar como sábio ou mentor. Muitos oferecem serviços como conselheiros, servem em forças
militares ou se envolvem com o crime ou a dominação.
Entretanto, a busca pelo conhecimento leva até os
magos mais cautelosos a abandonar a segurança de
suas bibliotecas e laboratórios em busca de ruínas
decadentes e cidades perdidas. A maioria acredita que
civilizações antigas guardavam segredos de magia que
poderiam conceder um poder maior do que o disponível na atualidade.', 'Inteligência', NULL, (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd6'), 6, 4, 1, TRUE, 3, 'Tradição', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'full')),
  ('monk', 'Monge', 'Artista marcial de velocidade e precisão', 'Entre e saia do combate corpo a corpo com velocidade e precisão.', NULL, 'Destreza e Sabedoria', 'and', (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'), 8, 5, 1, TRUE, 3, 'Tradição', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), NULL),
  ('paladin', 'Paladino', 'Guerreiro sagrado vinculado a um juramento', 'Destrua inimigos e proteja aliados com poder divino e marcial.', 'Paladinos são unidos por seus juramentos de combater as forças da aniquilação e
da corrupção. Seja diante do altar de um deus,
em uma clareira sagrada diante de espíritos da natureza ou em momentos de desespero e tristeza com os
mortos como as únicas testemunhas, o juramento de
um Paladino é um vínculo poderoso. Ele transforma
um combatente devoto em um campeão abençoado.
Paladinos treinam para dominar armas e armaduras,
mas suas habilidades marciais são superadas pelo poder
mágico que possuem: curar feridos, punir inimigos e
proteger os indefesos e aqueles que lutam ao seu lado.
A vida de um Paladino é, quase por definição, uma
vida de aventura, pois eles estão na linha de frente da
luta cósmica contra a aniquilação. Guerreiros são raros
nos exércitos de um mundo, e ainda menos indivíduos
podem reivindicar a vocação de um Paladino. Ao receber esse chamado, essas pessoas abençoadas abandonam suas ocupações anteriores para empunhar armas
e magia.', 'Força e Carisma', 'and', (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd10'), 10, 6, 1, TRUE, 3, 'Juramento', 2, NULL, (SELECT id FROM rpg.phb_source_citation WHERE slug = 'phb-2024-pt:ch3:55-182'), (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'half'));
