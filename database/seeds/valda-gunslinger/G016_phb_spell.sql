-- Seed Pistoleiro pack spells

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'antiballistics-field',
  'Campo Antibalístico',
  6,
  '6º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'uma pitada de pólvora molhada',
  'V, S, M (uma pitada de pólvora úmida)',
  'Concentração, até 10 minutos',
  true,
  false,
  'Uma Emanação de 40 pés se estende de você, destruindo projéteis e causando mau funcionamento de armas de longo alcance. Dentro da Emanação, sempre que uma arma de longo alcance é usada para um ataque, a arma imediatamente funciona mal e o ataque é perdido. Uma arma com defeito não pode ser usada para realizar um ataque até que uma criatura execute a ação Utilizar para consertar o mau funcionamento da arma. Ataques à distância usando armas cujos projéteis passam pela Emanação têm Desvantagem e causam apenas metade do dano ao acertar.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'ballistic-smite',
  'Golpe Balístico',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus, que você pega imediatamente após acertar uma criatura com uma arma de longo alcance',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Escolha o dano Ácido, Gélido, Ígneo, Elétrico, Venenoso ou Trovejante. O alvo atingido pelo ataque sofre 2d6 de dano extra do tipo escolhido. O ataque desencadeador pode causar o tipo de dano escolhido ou o tipo de dano normal (sua escolha).',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'concealed-shot',
  'Tiro Oculto',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Toque',
  false,
  true,
  true,
  'uma arma de longo alcance',
  'S, M (uma arma de longo alcance)',
  '1 minuto',
  false,
  false,
  'Uma arma de longo alcance que você toca torna-se sobrenaturalmente sutil. Enquanto você faz um ataque à distância usando a arma, a arma ou munição que você está usando fica invisível durante o vôo e a arma fica silenciosa. Se a arma produzir fumaça ou luz, a magia suprime esses efeitos. A arma ou projétil que você está usando fica visível novamente após o ataque acertar ou errar. Se você estiver escondido e o alvo estiver a 80 pés ou mais de você, o ataque não revelará sua localização.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'conjure-cannonball',
  'Conjurar Bola de Canhão',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '600 pés',
  true,
  true,
  true,
  'uma pequena réplica de canhão',
  'V, S, M (uma pequena réplica de canhão)',
  'Instantânea',
  false,
  false,
  'Você invoca uma bala de canhão, no meio do vôo e a toda velocidade, que explode com o impacto. Faça uma jogada de ataque mágico à distância contra um alvo que você possa ver dentro do alcance. Se acertar, o alvo sofre 5d10 de dano Contundente e uma explosão se estende dele em uma Emanação de 5 pés. Cada criatura que não seja o alvo dentro da Emanação faz uma salvaguarda de Destreza, sofrendo metade do dano que o alvo em caso de falha na resistência.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d10 para cada nível de espaço acima de 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'conjure-cover',
  'Conjurar Cobertura',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  '10 pés',
  true,
  true,
  true,
  'uma estatueta de pato',
  'V, S, M (uma estatueta de pato)',
  'Concentração, até 1 hora',
  true,
  false,
  'Você conjura uma parede baixa de paralelepípedos ao longo do chão em um ponto que você possa ver dentro do alcance. A parede tem 18 polegadas de espessura e é composta por três segmentos de 5 pés de comprimento e 3 pés de altura. Cada segmento deve ser contíguo a pelo menos um outro segmento.

Uma criatura Média que se esconde atrás da parede tem Meia Cobertura, e uma criatura Pequena que se esconde atrás dela tem Três Quartos de Cobertura. A parede pode ser saltada sem gastar nenhum movimento adicional.

Cada segmento tem CA 10 e 30 pontos de vida. Reduzir um segmento da parede a 0 pontos de vida faz com que ela desmorone, destruindo-a. A parede desaparece quando todos os segmentos são destruídos ou a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'jam-weapon',
  'Emperrar Arma',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reação, que você executa quando uma criatura que você pode ver dentro do alcance faz um ataque usando uma arma de longo alcance',
  '60 pés',
  true,
  true,
  true,
  'uma pitada de pólvora molhada',
  'V, S, M (uma pitada de pólvora úmida)',
  'Instantânea',
  false,
  false,
  'A arma que você mira sofre um mau funcionamento e o ataque falha. Uma arma com defeito não pode ser usada para realizar um ataque até que uma criatura execute a ação Utilizar para consertar o mau funcionamento da arma.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'jethro-s-instant-reload',
  'Recarga Instantânea de Jethro',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'um invólucro de bala gasto',
  'V, S, M (um invólucro de bala gasto)',
  '8 horas',
  false,
  false,
  'Uma arma de longo alcance que você toca fica encantada para recarregar automaticamente. Se a arma tiver a propriedade Carregando ou Recarregar, você ignora a propriedade enquanto durar. Quando a munição da arma acaba, a munição que você carrega se teletransporta para dentro da arma.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
  'perforating-shot',
  'Tiro Perfurante',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus, que você pega imediatamente após acertar ou errar com um ataque à distância usando uma arma',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Conforme seu ataque atinge ou erra o alvo, a arma ou munição se transforma em uma linha de energia mágica de 5 pés de largura que se estende até o alcance normal da arma. A Linha inclui o alvo original do ataque. Cada criatura dentro da Linha faz uma salvaguarda de Destreza, sofrendo Energético de dano igual ao dano normal da arma em caso de falha na resistência ou metade do dano em caso de sucesso.',
  'Usando um Espaço de Magia de Círculo Superior. O dano da arma aumenta em 1d8 para cada nível de espaço acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
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
