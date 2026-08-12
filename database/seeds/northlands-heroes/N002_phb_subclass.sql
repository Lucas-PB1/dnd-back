-- Subclasses — Northlands Heroes of the Sagas (Wave 1)

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES
(
  'path-of-the-titan',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho do Titã',
  'Maior é melhor',
  'Bárbaros que canalizam espíritos jotun na Fúria e crescem até o tamanho de gigantes.',
  'Não se nega o poder de Jotunheim. Até o menor dos gigantes exemplifica a força física herdada de Aurgelmir. Bárbaros do Caminho do Titã canalizam os espíritos dos jotun pela Fúria: a forma física cresce para igualar o poder da ira, erguendo-os acima dos inimigos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'skald',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  'Escaldo',
  'Provoque, manipule, inspire',
  'Bardos das terras nórdicas treinados para a guerra, a palavra e as sagas.',
  'Nos colégios bárbaros do Norte, a tradição escáldica diverte nos salões no inverno longo, ergue líderes e derruba déspotas. Escaldos viajam com bandos guerreiros: armas e palavras os protegem enquanto escrevem feitos, cantam no hidromel e recitam heróis nas longships.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'nornbound',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  'Atado às Nornas',
  'Tece os fios do Destino',
  'Clérigos que veem e manipulam os fios do destino mortal em serviço às Nornas.',
  'O Clérigo Atado às Nornas presta homenagem às Nornas e em troca vê e altera os fios do destino. Esse poder — tampando o destino, para alguns — ajuda ou atrapalha resultados. Embora orem a outros deuses, as Nornas são a luz-guia a quem juraram serviço.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'circle-of-fenris',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo de Fenris',
  'Devoto selvagem do Grande Lobo',
  'Druidas que veneram Fenris e vestem o manto do lobo na caça.',
  'O Norte amargo guarda círculos obscuros. O Círculo de Fenris venera o Grande Lobo: parentesco com o predador pelo laço natural. Nem todos são assassinos niilistas — alguns rejeitam o “progresso” e abraçam a caça. Todos são conhecidos pela natureza indomada e pelo entusiasmo pela perseguição.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'viking',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Viking',
  'Saqueador perigoso do mar',
  'Guerreiros-marinheiros do Norte, mestres de lança e machado no Caminho do Saqueador.',
  'Vikings são guerreiros endurecidos e marinheiros que cruzam os mares do Norte em busca de glória e saque. No Caminho do Saqueador têm honra própria, mas podem ser impiedosos na guerra. São conhecidos pela lança e pelo machado, e pela crença de conquistar lugar nos salões dos mortos pelos feitos em batalha.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'oath-of-valhalla',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento de Valhalla',
  'Demonstre bravura e honre os mortos',
  'Paladinos que preservam espíritos caídos com honra e buscam Valhalla pelos próprios feitos.',
  'Paladinos do Juramento de Valhalla preservam os espíritos dos que morreram com honra — até inimigos. Buscam merecer Valhalla. A festa trovejante dos mortos heróicos em Asgard os embriaga com o poder de campeões. Desconfiam de quem ressuscita heróis, mas assumem acordo com Valhalla; não dão trégua a quem anima cadáveres em zombaria da vida.

Tenetes: Proteja os mortos dignos. Inspire coragem em batalha. Faça justiça a quem zomba dos mortos.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'spirit-caller',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  'Chamador de Espíritos',
  'Empoderado por ancestrais',
  'Feiticeiros ligados aos espíritos ancestrais e aos mortos honrados.',
  'Você nasceu com laço sobrenatural aos ancestrais e aos mortos honrados. Pode chamá-los para ajudar aliados e atrapalhar inimigos. No Norte, os espíritos aparecem como animais fantasma que falam como em vida — raposa-ártica, corvo, lince e outros. Muitos acreditam que, ao conjurar, os ancestrais os assistem diretamente.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'trickster',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'Trapaceiro',
  'Imbuir a vida com um toque de caos',
  'Bruxos cujo patrono é o caos — fadas travessas ou facetas de Loki.',
  'Dos salões feéricos às travessuras de Loki, há entidades do caos primal. Seu pacto vem de um desses poderes: capricho ou deidade que deleita em trapaças. O patrono pede que você semeie caos e se delicie com o embuste. Se apertar os olhos, quase faz sentido o método por trás da aparente loucura.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id,
  class_id = EXCLUDED.class_id;
