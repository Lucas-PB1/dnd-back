-- Seed Valda spells
-- Conteúdo canônico Valda: Spire of Secrets

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'accelerate-decelerate',
  'Acelerar/Desacelerar',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reação, que você realiza quando vê uma jogada de ataque atingir uma criatura a até 60 pés de você',
  '60 pés',
  true,
  true,
  true,
  'uma gota de óleo ou melaço',
  'V, S, M (uma gota de óleo ou melaço)',
  'Instantânea',
  false,
  false,
  '[Cronomancia]

Este magia acelera ou desacelera um ataque (veja o efeito escolhido abaixo) no instante anterior ao ataque, diminuindo ou multiplicando sua força.

Acelerar. O alvo sofre 2d6 de dano extra pelo ataque. Este dano extra é do mesmo tipo causado pelo ataque desencadeador.

Desacelerar. Reduza o dano que o alvo sofre em 2d6 (até um mínimo de 0 de dano).',
  'Usando um Espaço de Magia de Círculo Superior. O dano extra ou redução de dano aumenta em 1d6 para cada nível de espaço acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'clue',
  'Pista',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação ou Ritual',
  'Toque',
  true,
  true,
  true,
  'uma lupa e um cachimbo',
  'V, S, M (uma lupa e um cachimbo)',
  '10 minutos',
  false,
  true,
  'Quando você conjura esta magia, todas as pegadas e impressões digitais dentro de uma Emanação de 30 pés proveniente de você ficam destacadas e brilham fracamente enquanto durar. Ao lançar a magia, escolha qualquer momento até 10 dias atrás. Apenas pegadas e impressões digitais deixadas entre aquela época e o presente serão destacadas. Cada criatura que deixa pegadas e impressões digitais recebe uma cor única, mas não é identificada de outra forma. Qualquer criatura que se mova ou toque objetos dentro da Emanação também deixará pegadas e impressões digitais coloridas, que podem revelar criaturas invisíveis na área.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'delay',
  'Atrasar',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '60 pés',
  true,
  true,
  true,
  'um sinal octogonal',
  'V, S, M (um sinal octogonal)',
  'Instantânea',
  false,
  false,
  '[Cronomancia]

Você retarda brevemente o tempo de uma criatura de sua escolha que você possa ver dentro do alcance. O alvo deve ser bem sucedido em uma salvaguarda de Sabedoria ou será movido para o último lugar na ordem de Iniciativa a partir do início da próxima rodada.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'dire-warning',
  'Aviso Terrível',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  '[Cronomancia]

Você receberá uma mensagem sua de até 6 palavras no futuro, avisando-o sobre uma ameaça crítica ou apontando-o para um caminho frutífero. O Mestre determina esta mensagem. Em algum momento no futuro, depois de saber por que enviou a mensagem, você deverá realizar um ritual ao longo de 10 minutos, que pode ser feito durante um Descanso Curto ou Longo, para entregar a mensagem de volta no tempo ao seu eu passado. Se você lançar esta magia e não receber nenhuma mensagem, isso indica que você nunca completará o ritual no futuro, possivelmente devido à sua morte ou outro obstáculo.

Depois de lançar esta magia, você não poderá lançá-lo novamente por 7 dias ou até realizar seu ritual.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'defenestration',
  'Defenestração',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '30 pés',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Uma onda de força irrompe de sua mão aberta, arremessando uma criatura que você pode ver dentro do alcance através de uma janela. O alvo faz uma salvaguarda de Força. Se falhar, o alvo é empurrado até 20 pés e lançado através de uma janela à sua escolha. Se não houver nenhuma janela a até 20 pés do alvo, ela é empurrada até 20 pés em uma direção de sua escolha e lançada através de uma janela de força arcana, que se materializa atrás da criatura e desaparece após ser quebrada. O alvo sofre 4d6 de dano Cortante e tem a condição Caído quando é lançado através de uma janela. Em um teste bem-sucedido, o alvo é empurrado apenas 10 pés e não sofre dano.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d6 e a distância que o alvo é empurrado em caso de sucesso ou falha aumenta em 5 pés para cada nível de espaço de magia acima de 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'mandy-s-feral-follower',
  'Seguidor Feral de Mandy',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '30 pés',
  true,
  true,
  true,
  'um pequeno sino de servo',
  'V, S, M (um pequeno sino de servo)',
  'Especial',
  false,
  false,
  'Você toca uma Besta Média ou menor, que muda para um Humanoide com uma aparência de sua escolha. As estatísticas da Besta são substituídas pelo bloco de estatísticas de um Commoner, mas mantém seu Pontos de Vida e Dados de Vida. Você escolhe a proficiência na habilidade do Plebeu. O plebeu usa roupas finas, mas não possui outros equipamentos e possui um conhecimento básico de todas as tarefas não qualificadas.

O alvo ganha 10 Pontos de Vida Temporáriosssss. A magia termina mais cedo no alvo se ele não tiver mais nenhum Pontos de Vida Temporáriossss. Quando a magia termina, as Roupas Finas se dissipam em fumaça.

Combate. O plebeu é um aliado para você e seus aliados. Ele lança sua própria Iniciativa e age por seu próprio turno. Ele se comporta como se fosse devidamente empregado por você.

Duração. A duração desta magia varia dependendo de quando e onde foi lançado. Se lançado em um local onde o tempo passa normalmente, a magia dura até a décima segunda badalada da meia-noite seguinte, por mais longo que seja. Em outros lugares, a magia dura 24 horas.',
  'Usando um Espaço de Magia de Círculo Superior. Você pode mudar de forma uma Besta adicional para cada nível de espaço de magia acima de 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'finger-guns',
  'Pistolas de Dedo',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você estende o indicador e o polegar, um gesto perigoso mímico ao usar uma arma. Durante todo o tempo, sua mão conta como uma arma simples de longo alcance com alcance de 60/240 pés e propriedade de maestria lenta. Você pode usar sua habilidade de conjuração em vez de Destreza para as jogadas de ataque desta arma. Se acertar, a arma causa 2d6 Energético de dano e não adiciona seu modificador de habilidade ao dano.',
  'Aprimoramento de Truque. O alcance normal da arma aumenta em 30 pés e seu longo alcance aumenta em 120 pés quando você atinge os níveis 5 (90/360 pés), 11 (120/480 pés) e 17 (150/600 pés).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'game-of-fate',
  'Jogo do Destino',
  6,
  '6º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação ou Ritual',
  '60 pés',
  true,
  true,
  true,
  'um Kit de Jogo',
  'V, S, M (um Kit de Jogo)',
  '1 hora',
  false,
  true,
  'Você magicamente compele uma criatura dentro do alcance que pode ouvi-lo e entendê-lo a um jogo não-mágico com consequências vitais. Uma criatura relutante deve ter sucesso em uma salvaguarda de Sabedoria ou será compelida a se juntar a você no jogo.

O perdedor do jogo sofre 6d6 Psíquico de dano. Se nenhum jogador tiver vencido ou perdido até o final da duração da magia, você e o alvo sofrem este dano. Se você ou um de seus aliados ferir o alvo, você perde o jogo e vice-versa se o alvo ou um de seus aliados ferir você.

Além disso, você e a criatura alvo podem negociar apostas maiores. Você pode apostar em danos Psíquico maiores (até um máximo de 12d6), dinheiro, propriedade ou recompensas mais esotéricas, como a concessão de um título de nobreza. A magia revela se uma criatura tenta fazer uma aposta que não pode cumprir. Uma aposta é finalizada quando você e o alvo concordam com a aposta, solidificando a aposta com um aperto de mão ou gesto semelhante. A aposta de propriedade ou moeda no jogo é teletransportada para o vencedor no final do jogo. O perdedor também é magicamente compelido a realizar qualquer ação (como conceder um título de nobreza) apostada como parte de uma aposta.

Por último, nenhuma magia, efeito mágico ou criatura além de você e do alvo pode influenciar o resultado do jogo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'hangover',
  'Ressaca',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '30 pés',
  true,
  true,
  true,
  'um frasco de licor forte',
  'V, S, M (um frasco de bebida forte)',
  'Instantânea',
  false,
  false,
  'Você emite uma aura de embriaguez que desaparece rapidamente, deixando uma ressaca intensa. Uma criatura que você escolher dentro do alcance realiza uma salvaguarda de Constituição. Se falhar na resistência, a criatura sofre 3d8 de dano Psíquico e fica com a condição Envenenado até o final do seu próximo turno. Em um teste bem-sucedido, o alvo sofre apenas metade do dano. O alvo tem Desvantagem nos salvaguardas de Constituição que faz para manter a Concentração como resultado deste dano.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'memorize',
  'Memorizar',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação ou Ritual',
  'Toque',
  true,
  true,
  true,
  'cordão de prata no valor de 10+ PO, amarrado com um nó, que a magia consome',
  'V, S, M (cordão de prata no valor de 10+ PO, amarrado com um nó, que a magia consome)',
  'Instantânea',
  false,
  true,
  'Quando você lança esse magia, seus olhos passam por uma página de texto escrito que está guardada em sua memória. No próximo ano, você se lembrará dos detalhes exatos de todas as informações da página. Após esse tempo, você terá Vantagem em todos os testes de Inteligência que fizer para recuperar esta informação.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'moment-to-think',
  'Momento para Pensar',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  '[Cronomancia]

Ao lançar esta magia, você para brevemente o tempo para todos, menos para você. Você pode realizar uma ação adicional e se mover em seu espaço enquanto não passa tempo para outras criaturas. Essa ação só pode ser usada para realizar a ação Pesquisar, Estudar ou Utilizar. Além disso, você não pode afetar ou danificar qualquer criatura ou objeto, exceto objetos que você esteja vestindo ou carregando. Se um objeto sair da sua mão, ele também ficará congelado no tempo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'paradox',
  'Paradoxo',
  9,
  '9º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '60 pés',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  '[Cronomancia]

Ao distorcer o fluxo do tempo em nós, você faz com que uma ação de sua escolha, realizada dentro do alcance da última rodada, seja desfeita. A realidade então se reafirma, recuando diante do dano causado pela remoção de um evento do tempo. Os efeitos diretos dessa ação, como o dano causado por um ataque ou magia, são desfeitos, mas os efeitos indiretos, como criaturas escolhendo se mover para locais diferentes, não são. A criatura que realizou a ação sofre 10d8 de dano Psíquico, pois lida com a modificação de seu histórico.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'polybrachia',
  'Polibraquia',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'um par de braçadeiras',
  'V, S, M (um par de braçadeiras)',
  'Concentração, até 10 minutos',
  true,
  false,
  'Dois braços musculosos de energia arcana brilhante aparecem em uma criatura voluntária que você toca. Esses braços são totalmente funcionais e podem ser usados ​​para empunhar armas e escudos (permitindo ao alvo segurar simultaneamente 2 armas de duas mãos ou 4 armas de uma mão), executar componentes somáticos de magias e realizar outras ações. Durante a duração, o alvo tem Vantagem em testes de Força (Atletismo). O alvo pode realizar uma Ação Bônus para realizar um ataque corpo a corpo usando uma arma empunhada pelos braços.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'recall',
  'Retorno',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 rodada',
  false,
  false,
  '[Cronomancia]

Registre sua localização ao lançar esta magia. Até o final do seu próximo turno, você pode realizar uma Reação em resposta a uma jogada de ataque, a uma criatura lançando uma magia ou a uma criatura se movendo a até 5 pés de você para se teletransportar de volta para aquele local ou para o espaço desocupado mais próximo, se esse espaço estiver ocupado. Este teletransporte precede o ataque ou magia desencadeador. A magia então termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'rumor',
  'Rumor',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você espalha magicamente um boato de 10 palavras ou menos em uma Emanação de 100 pés originada de você. Qualquer criatura dentro da Emanação que possa ouvir e compreender três ou mais outras criaturas acredita ter ouvido o boato sendo repetido por alguém próximo. Criaturas diferentes ouvem rumores de pessoas diferentes, portanto é impossível discernir uma origem concreta. Geralmente, as criaturas não se tornarão hostis ao ouvirem até mesmo os rumores mais cruéis, mas ouvir um boato pode afetar sua atitude positiva ou negativamente.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;
