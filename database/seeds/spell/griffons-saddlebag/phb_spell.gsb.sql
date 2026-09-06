INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES
(
  'pressa', 'Pressa', 3, '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação', '9 metros', TRUE, TRUE, TRUE, 'um floco de raiz de alcaçuz', 'V, S, M',
  'Concentração, até 1 minuto', TRUE, FALSE,
  'Escolha uma criatura voluntária no alcance. Até a magia terminar, o alvo tem +2 de CA, Vantagem em salvaguardas de Destreza e uma ação adicional em cada turno (Ação de Ataque, Correr, Desengajar, Esconder-se ou Usar Objeto).',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'punicao-radiante', 'Punição Radiante', 2, '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus', 'Pessoal', TRUE, TRUE, FALSE, NULL, 'V, S',
  'Concentração, até 1 minuto', TRUE, FALSE,
  'Na próxima vez que você acertar um alvo com um ataque corpo a corpo com arma antes da magia terminar, o alvo sofre 2d6 de dano Radiante extra e emite Luz Plena em 1,5 m até o início do seu próximo turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'golpe-flamejante', 'Golpe Flamejante', 5, '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação', '18 metros', TRUE, TRUE, FALSE, NULL, 'V, S',
  'Instantânea', FALSE, FALSE,
  'Coluna de fogo divino atinge o alvo. O alvo faz salvaguarda de Destreza, sofrendo 4d6 de dano Radiante e 4d6 de dano Ígneo em falha, ou metade em sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'detectar-bem-e-mal', 'Detectar Bem e Mal', 1, '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação', 'Pessoal', TRUE, TRUE, FALSE, NULL, 'V, S',
  'Concentração, até 10 minutos', TRUE, FALSE,
  'Pela duração, você sente a presença de Aberrações, Celestiais, Elementais, Fadas, Mortos-vivos ou Fiéis a até 9 metros.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'aperfeicoar-atributo', 'Aperfeiçoar Atributo', 2, '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação', 'Toque', TRUE, TRUE, TRUE, 'pelo ou pena de animal', 'V, S, M',
  'Concentração, até 1 hora', TRUE, FALSE,
  'Você toca uma criatura e escolhe Força ou Destreza. O alvo tem Vantagem em testes do atributo escolhido pela duração.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'encontrar-familiar', 'Encontrar Familiar', 1, '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  '1 hora ou Ritual', '3 metros', TRUE, TRUE, TRUE, 'carvão, incenso e ervas no valor de 200 PO', 'V, S, M',
  'Instantânea', FALSE, TRUE,
  'Você ganha o serviço de um espírito familiar que assume a forma de um animal à sua escolha.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'farol-de-esperanca', 'Farol de Esperança', 3, '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação', '9 metros', TRUE, TRUE, FALSE, NULL, 'V, S',
  'Concentração, até 1 minuto', TRUE, FALSE,
  'Criaturas à sua escolha em uma Esfera de 9 m têm Vantagem em salvaguardas de Sabedoria e curam o máximo possível de PV Temporários.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'guardiao-da-fe', 'Guardião da Fé', 4, '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação', '9 metros', TRUE, TRUE, FALSE, NULL, 'V',
  '8 horas', FALSE, FALSE,
  'Um guardião espectral grande aparece e protege o espaço que você escolher.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'vinculo-telepatico-de-rary', 'Vínculo Telepático de Rary', 5, '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação', '9 metros', TRUE, TRUE, TRUE, 'pedaços de casca de ovo', 'V, S, M',
  '1 hora', FALSE, FALSE,
  'Você forja um vínculo telepático entre até oito criaturas voluntárias no alcance.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'imagem-espelhada', 'Imagem Espelhada', 2, '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação', 'Pessoal', TRUE, TRUE, FALSE, NULL, 'V, S',
  '1 minuto', FALSE, FALSE,
  'Três duplicatas ilusórias suas aparecem; ataques contra você podem acertar uma duplicata.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'prender-monstro', 'Prender Monstro', 5, '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação', '27 metros', TRUE, TRUE, TRUE, 'um pedaço de ferro', 'V, S, M',
  'Concentração, até 1 minuto', TRUE, FALSE,
  'Uma criatura no alcance faz salvaguarda de Sabedoria ou fica Paralisada pela duração.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'passar-parede', 'Passar Parede', 5, '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação', '9 metros', TRUE, TRUE, TRUE, 'pó de sésamo', 'V, S, M',
  '1 hora', FALSE, FALSE,
  'Uma passagem aparece em uma superfície de madeira, gesso ou pedra que você toca.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'bau-secreto-de-leomund', 'Baú Secreto de Leomund', 4, '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação', 'Toque', TRUE, TRUE, TRUE, 'um baú em miniatura de ouro', 'V, S, M',
  'Até ser dissipada', FALSE, FALSE,
  'Você esconde um baú e seu conteúdo no Plano Etéreo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'corda-encantada', 'Corda Encantada', 2, '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação', 'Toque', TRUE, TRUE, TRUE, 'pó de milho e um pedaço de pergaminho enrolado', 'V, S, M',
  '1 hora', FALSE, FALSE,
  'Você toca uma corda e ela sobe verticalmente até 18 m; no topo, abre um espaço extradimensional.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
),
(
  'conjurar-elemental', 'Conjurar Elemental', 5, '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação', '18 metros', TRUE, TRUE, TRUE, 'incenso queimado no valor de 400 PO', 'V, S, M',
  'Concentração, até 1 hora', TRUE, FALSE,
  'Você invoca um elemental de Ar, Terra, Fogo ou Água que obedece seus comandos.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
