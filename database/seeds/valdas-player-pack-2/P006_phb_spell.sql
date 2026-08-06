-- Seed Valdas Player Pack 2 spells

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'arc-blade',
  'Lâmina Relâmpago',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '15 pés',
  false,
  true,
  true,
  'uma arma Corpo a Corpo com a qual você tenha proficiência e que valha 1+ PC',
  'S, M (uma arma Corpo a Corpo com a qual você tenha proficiência e que valha 1+ PC)',
  'Instantânea',
  false,
  false,
  'Conforme o relâmpago percorre a arma usada na conjuração da magia, você realiza um ataque. Este ataque pode ser um ataque corpo a corpo ou um ataque mágico à distância usando a arma com alcance de 15 pés, conforme uma onda de energia se estende a partir da arma. O ataque usa sua habilidade de conjuração para as jogadas de ataque e dano em vez de Força ou Destreza. Se for um ataque à distância, causa dano Elétrico. Caso contrário, pode causar dano Elétrico ou o tipo de dano normal da arma (sua escolha).',
  'Aprimoramento de Truque. Quer você cause dano Elétrico ou o tipo de dano normal da arma, o ataque causa dano Elétrico extra quando você atinge os níveis 5 (1d6), 11 (2d6) e 17 (3d6).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'blunder',
  'Trapalhada',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Reação, que você realiza quando uma criatura que você pode ver dentro do alcance acerta um alvo com uma jogada de ataque',
  '30 pés',
  false,
  true,
  true,
  'uma casca de banana',
  'S, M (uma casca de banana)',
  'Instantânea',
  false,
  false,
  'O atacante deve ser bem-sucedido em uma salvaguarda de Sabedoria ou sofre um dos seguintes efeitos à sua escolha.

Vacilo. O alvo solta um objeto à sua escolha que esteja segurando, com o objeto caindo em um espaço que você escolher a até 10 pés do alvo. Se o alvo soltar a arma que está usando para a jogada de ataque, ele pode realizar um Ataque Desarmado para o ataque desencadeador.

Queda Cômica. O alvo tem a condição Caído. A Desvantagem da condição Caído se aplica contra o ataque desencadeador, potencialmente fazendo com que ele erre.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'burning-blade',
  'Lâmina Ardente',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  false,
  true,
  true,
  'uma arma Corpo a Corpo com a qual você tenha proficiência e que valha 1+ PC',
  'S, M (uma arma Corpo a Corpo com a qual você tenha proficiência e que valha 1+ PC)',
  'Instantânea',
  false,
  false,
  'Envolvendo em chamas a arma usada na conjuração da magia, você realiza um ataque corpo a corpo. O ataque usa sua habilidade de conjuração para as jogadas de ataque e dano em vez de Força ou Destreza. Se o ataque causar dano, ele pode ser dano Ígneo ou o tipo de dano normal da arma (sua escolha). Se o dado de dano da arma ou qualquer dos dados de dano da magia resultar no número mais alto, você pode rolar aquele dado novamente e adicioná-lo ao dano, rolando novamente se for o número mais alto, e assim por diante. Você pode adicionar um número máximo de dados à jogada de dano igual ao seu modificador de habilidade de conjuração.',
  'Aprimoramento de Truque. Quer você cause dano Ígneo ou o tipo de dano normal da arma, o ataque causa dano Ígneo extra quando você atinge os níveis 5 (1d6), 11 (2d6) e 17 (3d6).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'candy-blast',
  'Rajada de Doces',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
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
  'Você invoca um punhado de doces duros — balas cozidas, mentas, jujubas etc. — e os arremessa em uma criatura que você possa ver dentro do alcance. Faça um ataque mágico à distância contra o alvo. Em um acerto, o alvo sofre 1d8 de dano Energético e os doces formam um monte no chão em seu espaço, fazendo com que uma área de 5 pés de lado à sua escolha no espaço do alvo se torne Terreno Difícil. Os doces produzidos por esta magia são comestíveis, mas não têm valor nutricional, e desaparecem após 1 minuto, encerrando qualquer Terreno Difícil.',
  'Aprimoramento de Truque. O dano aumenta em 1d8 quando você atinge os níveis 5 (2d8), 11 (3d8) e 17 (4d8).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'cheat',
  'Trapaça',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  true,
  'um dado viciado',
  'S, M (um dado viciado)',
  '1 rodada',
  false,
  false,
  'Você torce os dedos e o destino parece acompanhar. Até o final do seu próximo turno, você pode rerrolar qualquer teste de atributo que fizer para jogar jogos de habilidade não mágicos e deve usar a nova rolagem. Portanto, esta magia poderia influenciar uma partida de pôquer, mas não o resultado de um Baralho de Muitas Coisas.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'cosmic-horror',
  'Horror Cósmico',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '60 pés',
  true,
  true,
  true,
  'um diário de sonhos',
  'V, S, M (um diário de sonhos)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Pelo mais breve momento, você abre um portal para uma dimensão sobrenatural em uma Esfera de 10 pés de raio centrada em um ponto que você possa ver dentro do alcance. Cada criatura dentro da Esfera faz uma salvaguarda de Sabedoria ao contemplar a dimensão de pesadelo. Em uma falha na salvaguarda, uma criatura sofre 6d6 de dano Psíquico e tem a condição Amedrontado pela duração. Em um sucesso na salvaguarda, uma criatura sofre apenas metade do dano.

Uma criatura Amedrontada por esta magia faz outra salvaguarda de Sabedoria no final de cada um de seus turnos, encerrando o efeito sobre si mesma em um sucesso.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'flashback',
  'Rememoração',
  3,
  '3º Círculo',
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

Lançando sua mente através do tempo, você faz uma alteração sutil na história, permitindo que você faça preparativos para a situação atual dentro das últimas 24 horas. Descreva ao seu Mestre as precauções que você tomou com antecedência para afetar a situação atual. Por exemplo, você pode ter empacotado uma peça específica de equipamento ou combinado uma distração para ocorrer exatamente neste momento. O Mestre pode exigir um teste de atributo se os preparativos forem suficientemente desafiadores; em uma falha, a magia falha e não tem efeito.

Os efeitos de uma Rememoração são limitados, pois a realidade se reafirma com o menor número possível de mudanças para acomodar a alteração na história. A magia não pode remover criaturas ou objetos de um encontro, ferir uma criatura, ou fazer com que criaturas e objetos que não estejam sendo usados ou carregados por você se movam. Ela geralmente pode adicionar um elemento a um encontro, mas geralmente não pode subtraí-los. O Mestre decide a extensão do efeito da Rememoração.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'flawed-reconstruction',
  'Reconstrução Imperfeita',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'uma agulha e linha',
  'V, S, M (uma agulha e linha)',
  'Instantânea',
  false,
  false,
  'Você costura as feridas de uma criatura que toca, que recupera 3d6 Pontos de Vida. No entanto, o reparo é imperfeito, e o máximo de Pontos de Vida do alvo é reduzido em 1d6, até um mínimo de 1.',
  'Usando um Espaço de Magia de Círculo Superior. A cura aumenta em 2d6 e a redução aumenta em 1d6 para cada nível de espaço de magia acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'frenzy',
  'Frenesi',
  6,
  '6º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '120 pés',
  true,
  true,
  true,
  'uma gota de sangue fresco',
  'V, S, M (uma gota de sangue fresco)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Com um gesto, você reduz uma multidão ao instinto básico e à violência. Cada criatura em uma Esfera de 20 pés de raio centrada em um ponto que você escolher dentro do alcance faz uma salvaguarda de Sabedoria. Em uma falha na salvaguarda, uma criatura tem a condição Frenético pela duração.

Uma criatura com a condição Frenético perde a capacidade de distinguir entre amigo e inimigo, considerando todas as criaturas que pode ver como inimigas. Enquanto Frenético, a criatura escolhe os alvos de seus ataques, magias e habilidades aleatoriamente entre as criaturas que pode ver dentro do alcance, e deve realizar um Ataque de Oportunidade se qualquer criatura provocar um.

No final de seu turno, uma criatura afetada pode repetir sua salvaguarda, encerrando a condição sobre si mesma antecipadamente em um sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'frigid-blade',
  'Lâmina Gélida',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  false,
  true,
  true,
  'uma arma Corpo a Corpo com a qual você tenha proficiência e que valha 1+ PC',
  'S, M (uma arma Corpo a Corpo com a qual você tenha proficiência e que valha 1+ PC)',
  'Instantânea',
  false,
  false,
  'Envolvendo em gelo a arma usada na conjuração da magia, você realiza um ataque corpo a corpo. O ataque usa sua habilidade de conjuração para as jogadas de ataque e dano em vez de Força ou Destreza. O dado de dano da arma aumenta em 1 degrau (d4 → d6 → d8 → d10 → d12 ou 2d6, sua escolha). Os dados de dano da arma não aumentam se ela tiver mais de um dado de dano de arma. Se o ataque causar dano, ele pode ser dano Gélido ou o tipo de dano normal da arma (sua escolha).',
  'Aprimoramento de Truque. Quer você cause dano Gélido ou o tipo de dano normal da arma, o ataque causa dano Gélido extra quando você atinge os níveis 5 (1d6), 11 (2d6) e 17 (3d6).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'mandy-s-marvelous-dress',
  'Vestido Maravilhoso de Mandy',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'um sapatinho de cristal no valor de 100+ PO',
  'V, S, M (um sapatinho de cristal no valor de 100+ PO)',
  'Concentração, especial',
  true,
  false,
  'Uma criatura voluntária que você toca é instantaneamente vestida com um vestido de baile fabuloso, perfeitamente sob medida e completo com um conjunto de joias brilhantes. Você pode escolher que o vestido fique sobre as roupas ou armadura da criatura, ou que substitua magicamente seu traje. A criatura não pode remover o vestido até que a magia termine; da mesma forma, as joias desaparecem se forem removidas.

Estilo Elegante. Até que a magia termine, quando a portadora fizer um Teste de D20 usando Carisma, ela pode substituir o número que rolou por um 10.

Proteção Glamorosa. Se a portadora do vestido for atacada por uma criatura que possa vê-la, o atacante deve ser bem-sucedido em uma salvaguarda de Sabedoria ou erra o ataque. Em um sucesso, o atacante fica imune a este efeito até que a magia termine.

Duração. A duração desta magia varia dependendo de quando e onde foi conjurada. Se conjurada em um local onde o tempo passa normalmente, a magia dura até a décima segunda badalada da próxima meia-noite, por quanto tempo isso demorar. Em outros lugares, a magia dura 24 horas. Quando a magia termina, o vestido desaparece em uma nuvem de brilhos, e a criatura fica vestida com seu traje original.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'protect-threshold',
  'Proteger Limiar',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação ou Ritual',
  'Toque',
  true,
  true,
  true,
  'uma onça de sal para cada pé do perímetro do portal protegido',
  'V, S, M (uma onça de sal para cada pé do perímetro do portal protegido)',
  '10 minutos',
  false,
  true,
  'Traçando sigilos arcanos ao longo de sua borda, você pode proteger uma porta, janela ou outro portal contra entrada. Pela duração, uma criatura sobrenatural Invisível espreita o portal protegido. Qualquer criatura que tente passar pelo portal faz uma salvaguarda de Sabedoria, sofrendo 4d6 de dano Psíquico em uma falha na salvaguarda ou metade do dano em um sucesso.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'rocks-fall',
  'Pedras Caem',
  8,
  '8º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '120 pés',
  true,
  true,
  true,
  'dez dados',
  'V, S, M (dez dados)',
  'Instantânea',
  false,
  false,
  'Pedregulhos aparecem no ar e caem em um Cilindro de 60 pés de raio e 120 pés de altura centrado em um ponto dentro do alcance. Cada criatura no Cilindro faz uma salvaguarda de Destreza. Em uma falha na salvaguarda, um alvo sofre 10d8 de dano Contundente e fica soterrado sob os escombros. Em um sucesso na salvaguarda, um alvo sofre apenas metade do dano.

Uma criatura soterrada tem as condições Caído e Contido, e pode gastar uma ação para fazer um teste de Força (Atletismo) contra sua CD de magia, libertando-se dos pedregulhos e encerrando as condições Caído e Contido sobre si mesma em um sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'rusting-grasp',
  'Toque Corrosivo',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Você conjura um ácido potente na ponta dos dedos, que pode corroer metal e queimar carne. Faça um ataque mágico corpo a corpo contra uma criatura ou objeto dentro do seu alcance. Em um acerto, uma criatura sofre 6d4 de dano Ácido e tem uma penalidade de −3 em sua CA, até um mínimo de 10, por 1 hora.

Se você mirar um objeto metálico não mágico com esta magia que não esteja sendo usado ou carregado, você corrói e destrói partes do objeto à sua escolha que caibam em um Cubo de 1 pé.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 2d4 para cada nível de espaço de magia acima de 3. Se você mirar um objeto não mágico, você pode destruir um pé cúbico adicional para cada nível de espaço acima de 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'seance',
  'Sessão Espírita',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '10 minutos',
  'Pessoal',
  true,
  true,
  true,
  'uma bola de cristal, baralho de tarô ou tabuleiro ouija, e incenso no valor de 50+ PO',
  'V, S, M (uma bola de cristal, baralho de tarô ou tabuleiro ouija, e incenso no valor de 50+ PO)',
  '1 minuto',
  false,
  false,
  'Você e três ou mais criaturas voluntárias dão as mãos para conjurar um espírito do além para responder às suas perguntas. Descreva ou nomeie uma criatura que seja familiar a você. Se a alma da criatura estiver livre e disposta, ela se manifesta como um espectro fantasmagórico. Esta magia falha se o espírito foi o alvo desta magia nos últimos 10 dias.

Até que a magia termine, você pode fazer até três perguntas ao espectro. O espectro sabe apenas o que sabia em vida, incluindo os idiomas que conhecia. As respostas geralmente são breves, enigmáticas ou repetitivas, e o espectro não tem obrigação de oferecer uma resposta verdadeira se você for hostil a ele ou se ele o reconhecer como inimigo. Há 5 por cento de chance de que esta magia contate o espírito errado, um que responderá às perguntas de forma falsa ou ambígua.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'soul-effigy',
  'Efígie da Alma',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 minuto ou Ritual',
  'Toque',
  true,
  true,
  true,
  'uma boneca de palha no valor de 1+ PC',
  'V, S, M (uma boneca de palha no valor de 1+ PC)',
  '8 horas',
  false,
  true,
  'Um Humanoide que você toca faz uma salvaguarda de Constituição. Em uma falha na salvaguarda, um fragmento de sua alma é vinculado à boneca usada na conjuração desta magia, que se torna uma efígie daquela criatura. A magia termina se a efígie for destruída ou se o alvo estiver em outro plano de existência. Pela duração, você pode usar uma Ação Mágica para fazer uma das seguintes opções.

Controlar. Você controla diretamente as ações e o movimento do alvo em seu próximo turno manipulando os membros da efígie. Aquele alvo só pode realizar as ações Correr, Desengajar, Esconder-se ou Utilizar. Enquanto controlado, os movimentos do alvo são bruscos e antinaturais.

Prejudicar. Você cutuca a efígie e causa 2d8 de dano ao alvo. Este dano é Contundente, Perfurante, Cortante ou outro tipo de dano apropriado aos meios pelos quais você prejudica a efígie. Este dano ignora Resistência e Imunidade.

Restringir. Você submerge a efígie na água, fazendo com que o alvo acredite que está sufocando. O alvo tem a condição Contido até o final do seu próximo turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'stone-bones',
  'Ossos de Pedra',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  '30 pés',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 rodada',
  false,
  false,
  'Escolha uma criatura que você possa ver dentro do alcance. O alvo tem Resistência a dano Contundente, Perfurante e Cortante até que a magia termine no final do seu próximo turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'swift-flight',
  'Voo Célere',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  true,
  'uma pena da asa de um pássaro',
  'V, S, M (uma pena da asa de um pássaro)',
  '1 rodada',
  false,
  false,
  'Faixas de energia fluem das costas de uma criatura que você toca, traçando as formas de asas. O alvo tem um Deslocamento de Voo de 60 pés e pode pairar até o final de seu próximo turno. Quando a magia termina, o alvo cai se estiver no ar e nada o estiver sustentando.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'sword-of-judgment',
  'Espada do Julgamento',
  5,
  '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '60 pés',
  true,
  true,
  true,
  'um fio de crina de cavalo',
  'V, S, M (um fio de crina de cavalo)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Esta magia designa uma área de proteção em uma Esfera de 20 pés de raio centrada em um ponto que você escolher dentro do alcance. Dentro dessa Esfera, uma espada espectral aparece sobre cada criatura, seguindo a criatura enquanto ela permanecer dentro da Esfera.

Sempre que uma criatura dentro da Esfera fizer um ataque ou conjurar uma magia, você pode forçar essa criatura a fazer uma salvaguarda de Destreza, conforme a espada acima dela cai. Resolva a salvaguarda de Destreza antes do ataque ou magia desencadeador. Em uma falha na salvaguarda, o alvo sofre 4d8 de dano Energético, ou metade do dano em um sucesso. Uma criatura faz esta salvaguarda apenas uma vez por turno.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 5.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'transient-bulwark',
  'Baluarte Transitório',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação ou Ritual',
  'Pessoal',
  true,
  true,
  true,
  'uma pérola no valor de 10+ PO, que a magia consome',
  'V, S, M (uma pérola no valor de 10+ PO, que a magia consome)',
  '8 horas',
  false,
  true,
  'Um escudo frágil e invisível protege você pela duração. A próxima jogada de ataque contra você tem uma penalidade de −10 para acertar, e a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
  'zephyr-s-feather',
  'Pena de Zéfiro',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'uma pena de pomba',
  'V, S, M (uma pena de pomba)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você acena com a mão e quatro penas de alabastro, magicamente afiadas até a lâmina de uma navalha, aparecem e orbitam ao seu redor até que a magia termine. Quando você conjura esta magia e como Ação Bônus em seus turnos posteriores, você pode gastar uma das penas e fazer um ataque mágico à distância com ela contra uma criatura que você possa ver a até 120 pés de você. Em um acerto, o alvo sofre 1d8 de dano Energético.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valdas-spire-2024-en:player-pack-2')
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
