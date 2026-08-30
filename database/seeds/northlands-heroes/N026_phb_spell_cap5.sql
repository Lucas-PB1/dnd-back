-- Magias Northlands Cap. 5 (Magic and Miscellany)
-- Gerado por scripts/gen-northlands-cap5-spell-seeds.mjs — textos PT (overlay docs/source/extracts/northlands/cap5-spells-pt.json, 78 slugs).
-- Fonte: northlands-heroes-2024-en:magic-and-miscellany

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'aegirs-breath',
  'Sopro de Aegir',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '54 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Você sopra uma nuvem de ar gélido em uma criatura ou objeto no alcance. Faça um ataque mágico à distância contra o alvo. Em um acerto, o alvo sofre 1d10 de dano Gélido, ou 1d12 se o alvo estiver pelo menos parcialmente submerso em água.',
  'A magia cria duas nuvens no 5º nível, três nuvens no 11º nível e quatro nuvens no 17º nível. Você pode direcionar as nuvens ao mesmo alvo ou a alvos diferentes. Faça uma jogada de ataque separada para cada nuvem.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'angrbodas-fury',
  'Fúria de Angrboda',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '13,5 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 1 minuto.',
  true,
  false,
  'Ao conjurar esta magia, você se abre para se tornar um conduto da raiva da deusa gigante Angrboda. Uma criatura no alcance realiza uma salvaguarda de Sabedoria. Em uma falha, o alvo fica Vulnerável a um tipo de dano à sua escolha. Se a criatura tiver Imunidade ao tipo de dano selecionado, ela perde essa Imunidade e sofre dano normalmente, mas não fica Vulnerável ao tipo de dano escolhido.

A criatura pode repetir a salvaguarda de Sabedoria no final de cada um dos seus turnos, encerrando esta magia em caso de sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'aspect-of-the-narwhal',
  'Aspecto do Narval',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Uma criatura voluntária que você toca assume os aspectos de um narval. Ela cresce nadadeiras e uma longa presa semelhante a um chifre. O alvo ganha Resistência a dano Gélido enquanto estiver submerso em água, seu Deslocamento se torna 1,5 metro, e ele ganha um Deslocamento de Natação de 15 metros. O alvo pode executar uma Ação Bônus em qualquer turno em que se mova pelo menos 4,5 metros diretamente em direção a um inimigo para fazer um ataque de investida com a presa que causa dano Perfurante igual a 2d6 mais o modificador de Força dele.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'awaken-ship-guardian',
  'Despertar Guardião do Navio',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '13,5 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  '24 horas',
  false,
  false,
  'Você invoca um espírito protetor para habitar o casco de um navio Grande ou maior. Enquanto a magia durar, o navio tem os seguintes benefícios:

Imunidade a dano Ígneo.

Cada vez que o navio sofrer dano de uma criatura Grande ou maior, a criatura atacante realiza uma salvaguarda de Sabedoria, sofrendo 5d6 de dano Psíquico em uma falha ou metade desse dano em um sucesso.

Como Ação Bônus enquanto você estiver no navio, você pode gastar um espaço de magia, e o navio recupera Pontos de Vida iguais a três vezes o círculo do espaço mais o seu modificador de conjuração.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'bearstormer',
  'Tempestade de Ursos',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  '54 metros',
  true,
  true,
  true,
  'a pinch of bear fur',
  'V, S, M (a pinch of bear fur)',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você cria três ursos-pardos fantasmais em um Cubo de 6 metros no alcance. Até a magia terminar, você pode usar uma Ação Bônus para mover o Cubo até 12 metros.

Quando o Cubo aparece, cada inimigo nele realiza uma salvaguarda de Inteligência. Em uma falha, a criatura sofre 18 (4d8) de dano Psíquico e tem a condição Amedrontado até o final do próximo turno dela. Em um sucesso, a criatura sofre apenas metade do dano. Uma criatura também realiza essa salvaguarda quando a área da magia se move para o espaço dela e quando uma criatura entra na área da magia ou termina o turno nela. Uma criatura realiza essa salvaguarda apenas uma vez por turno.',
  'Você aumenta o tamanho do Cubo em 6 metros, o número de ursos fantasmais em dois e o dano em 9 (2d8) para cada círculo de espaço de magia acima do 5º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'beast-of-ragnarok',
  'Fera do Ragnarok',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a bezoar formed in a wolf’s stomach',
  'V, S, M (a bezoar formed in a wolf’s stomach)',
  '1 minuto',
  false,
  false,
  'A aura espectral de Fenris o envolve enquanto você atrai o Ragnarok para o mundo por um instante. Até a magia terminar, o céu escurece, lançando o mundo em Meia-luz em uma Esfera de 1,5 quilômetro centrada em você. Neves densas caem dentro da Esfera, fazendo o solo se tornar Terreno Difícil e a visão ficar Totalmente Obscurecida.

Você ganha os seguintes benefícios pela Duração:

Você enxerga claramente dentro da Esfera e não é afetado pelo Terreno Difícil causado pela magia.

Você tem Vantagem em todos os Testes de D20.

Todas as criaturas têm Desvantagem nas jogadas de ataque contra você.

Você tem Imunidade a todos os tipos de dano, exceto um. Role 1d12 para determinar aleatoriamente um tipo de dano (1. Ácido, 2. Contundente, 3. Ígneo, 4. Energético, 5. Elétrico, 6. Necrótico, 7. Perfurante, 8. Venenoso, 9. Psíquico, 10. Radiante, 11. Cortante ou 12. Trovejante.) Você tem Vulnerabilidade ao tipo de dano rolado.

Você tem Vantagem em salvaguardas para resistir ou encerrar todas as condições.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'bergelmirs-provocation',
  'Provocação de Bergelmir',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Reação, que você executa quando você vê uma criatura fazer um ataque ou ataque mágico',
  '27 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Quando você vê uma criatura fazer um ataque ou ataque mágico, você pode usar sua Reação para provocar o atacante.

A criatura que faz o ataque deve realizar uma salvaguarda de Sabedoria. Em uma falha, a criatura faz o ataque contra outro alvo elegível à sua escolha, que não pode incluir a própria criatura. Se não houver outro alvo elegível, o ataque da criatura é desperdiçado.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'beseech-the-norns',
  'Suplicar às Nornas',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  true,
  true,
  'a silver spindle worth 100+ GP, which the spell consumes',
  'V, S, M (a silver spindle worth 100+ GP, which the spell consumes)',
  'Special (see text)',
  false,
  false,
  'Você contata uma das três Nornas, as tecelãs do destino, para interceder em seu favor alterando o passado, o presente ou o futuro. Escolha um dos seguintes efeitos:

Mudar o Passado (Uror). Escolha uma criatura que você possa ver e que tenha morrido desde o início do seu último turno. Essa criatura retorna à vida com 1 Ponto de Vida. Esta magia não pode reviver nenhuma criatura que tenha morrido de velhice, nem restaura partes do corpo ausentes.

Guiar o Presente (Verthandi). Trate a primeira jogada de ataque ou teste de atributo que você fizer antes do final do seu turno como um 20 natural.

Moldar o Futuro (Skuld). Começando no início do seu próximo turno e durando 1 minuto, você tem Vantagem em todos os testes de atributo e salvaguardas.

Se você conjurar a magia mais de uma vez antes de terminar um Descanso Longo, há 25 por cento cumulativos de chance, para cada conjuração após a primeira, de a magia não ter efeito (além de consumir o componente material).',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'billowing-sails',
  'Velas Enfunadas',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  '1 minute or Ritual',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 8 horas',
  true,
  true,
  'Você toca um navio ou outro veículo movido a vento e enche suas velas com uma brisa forte. Sempre que o navio viajar a vela, seu Deslocamento aumenta em 3 metros ou em 1,5 km/h.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'bone-chilling-smite',
  'Golpe Arrepiante',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  '1 minuto',
  false,
  false,
  'O alvo sofre 3d8 adicionais de dano Necrótico do ataque e deve ser bem-sucedido em uma salvaguarda de Constituição ou ganha um nível de Exaustão até a magia terminar.

No final de cada um dos seus turnos, o alvo Exausto repete a salvaguarda. Em um sucesso, ele remove toda a Exaustão causada por esta magia. Em uma falha, recebe um nível de Exaustão.',
  'O dano aumenta em 1d8 para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'bound-fortunes',
  'Fortunas Vinculadas',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'two small spindles bound together with thread',
  'V, S, M (two small spindles bound together with thread)',
  'Concentration , up to 1 hora',
  true,
  false,
  'Você toca outra criatura voluntária e une seus destinos até a magia terminar. Pela duração, se o alvo estiver a até 18 metros de você e fizer um teste de atributo, jogada de ataque ou salvaguarda, você pode usar sua Reação para permitir que o alvo role novamente e use o novo resultado. O alvo pode fazer o mesmo por você. Cada vez que fizer isso, o máximo de Pontos de Vida seu — e somente o seu — é reduzido em 1d4, e o mesmo vale para o alvo. Se isso reduzir o máximo de Pontos de Vida a 0, você morre. Essa redução é removida quando a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'bragis-theatrical-fall',
  'Queda Teatral de Bragi',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Reação, que você executa quando an attack would reduce you to 0 Hit Points but not kill you outright',
  'Pessoal',
  true,
  false,
  true,
  'a drop of your blood',
  'V, M (a drop of your blood)',
  'Concentration , up to 1 hora',
  true,
  false,
  'Com um suspiro e uma proclamação em voz alta, você parece cair morto no chão. Em vez de ser reduzido a 0 Pontos de Vida, você é reduzido a um número de Pontos de Vida igual ao seu modificador de atributo de conjuração. Ao mesmo tempo, você tem a condição Invisível, e uma ilusão do seu corpo morto aparece, deitada no espaço onde seu corpo teria caído.

Se uma criatura executar a ação Analisar para examinar seu corpo ilusório, ela pode determinar que é uma ilusão com um teste bem-sucedido de Inteligência (Investigação) contra a CD de magia. Se uma criatura discernir a ilusão pelo que ela é, a ilusão se torna tênue para essa criatura.

A condição Invisível termina se você executar a ação Atacar, usar a ação Usar Magia para conjurar uma magia que permita a uma criatura recuperar Pontos de Vida, ou usar qualquer ação para causar dano a uma criatura.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'branch-and-root-of-yggdrasil',
  'Ramo e Raiz de Yggdrasil',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Action or Ritual',
  'Toque',
  true,
  true,
  true,
  'branch, leaf, or bark from a World Tree',
  'V, S, M (branch, leaf, or bark from a World Tree)',
  'Instantânea',
  false,
  true,
  'Todas as árvores estão intrinsecamente ligadas a Yggdrasil. Ao conjurar esta magia e tocar uma árvore, você e até oito criaturas voluntárias em contato com essa árvore são transportados para um local aleatório em Yggdrasil. Se você estiver tocando uma Árvore do Mundo encontrada no plano mortal (como as encontradas nas Terras do Norte) ao conjurar a magia, pode especificar um destino-alvo em Yggdrasil em termos gerais, e você aparece nesse destino ou perto dele, conforme determinado pelo Mestre.

Usar esta magia exige um sacrifício do conjurador. Após conjurar esta magia, seu máximo de Pontos de Vida é reduzido em um valor igual a uma rolagem de um dos seus Dados de Vida até você completar um Descanso Longo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'call-to-action',
  'Chamado à Ação',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Reação, which you take in response to another creature’s turn starting',
  '27 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'A criatura que inicia o turno pode imediatamente usar sua Reação para executar a ação Correr, Desengajar, Esquivar ou Ajudar.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'claws-of-the-bear',
  'Garras do Urso',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a tuft of bear fur',
  'V, S, M (a tuft of bear fur)',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você imbui a si mesmo com as garras de um urso. Transforma os braços em um par de patas musculosas e peludas e faz um ataque mágico corpo a corpo contra um alvo. Em um acerto, o alvo sofre dano Cortante igual a 3d10 mais o seu modificador de atributo de conjuração e, se o alvo não for mais de uma categoria de tamanho maior que você, tem a condição Caído. Pela duração da magia, você pode atacar com as garras.',
  'Quando conjura esta magia usando um espaço de 5º ou 6º círculo, o dano aumenta para 4d10. Quando a conjura usando um espaço de 7º ou 8º círculo, o dano aumenta para 5d10. Quando a conjura usando um espaço de 9º círculo, o dano aumenta para 6d8.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'coldheart',
  'Coração Gelado',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '13,5 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Você faz um frio sobrenatural cair sobre uma Fera ou Humanoide que você possa ver no alcance. O alvo deve realizar uma salvaguarda de Constituição. Em uma falha, recebe 1 nível de Exaustão.

No final do próximo turno dele, o alvo deve realizar outra salvaguarda de Constituição. Em uma falha, a criatura recebe 1 nível de Exaustão. Em seguida a magia termina. A Exaustão aplicada por esta magia não é removida pelo fim da magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'compel-avarice',
  'Compelir Avareza',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '13,5 metros',
  true,
  true,
  true,
  'a gold coin',
  'V, S, M (a gold coin)',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Esta magia distorce as percepções da criatura-alvo, inflamando sua ganância. Você escolhe um objeto que possa ver ao conjurar esta magia. O alvo deve ser bem-sucedido em uma salvaguarda de Sabedoria ou é compelido a tentar tomar aquele item para si pela duração da magia. Ele tentará roubar o item se possível e, se não puder, lutará contra o atual portador do item. Se o alvo conseguir reivindicar o objeto, fugirá de todas as outras criaturas para guardá-lo com ciúmes até a magia terminar. Criaturas que tenham Imunidade à condição Enfeitiçado automaticamente têm sucesso nas salvaguardas contra esta magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'disrupt-the-wyrd',
  'Perturbar o Wyrd',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação, which you take in response to a saving throw being rolled by a creature that you can see within 30 feet of yourself',
  '13,5 metros',
  true,
  true,
  true,
  'a tangle of thread',
  'V, S, M (a tangle of thread)',
  'Instantânea',
  false,
  false,
  'A criatura rola novamente a salvaguarda, somando ou subtraindo o seu modificador de conjuração da nova rolagem. Ela deve usar o novo resultado.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'drummers-cadence',
  'Cadência do Tamborileiro',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 8 horas',
  true,
  false,
  'Pela duração, você emite uma aura em uma Emanação de 18 metros. Sempre que um navio aliado nesta área se mover a remo, seu Deslocamento aumenta em 3 metros. A embarcação deve ter tripulação suficiente para que esta magia tenha qualquer efeito.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'earthsail',
  'Vela da Terra',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '1 minute or Ritual',
  'Toque',
  true,
  true,
  true,
  'a handful of mud and a handful of sea water',
  'V, S, M (a handful of mud and a handful of sea water)',
  '8 horas',
  false,
  true,
  'Você toca uma embarcação à vela com uma tripulação de até 10 ao longo da conjuração da magia, imbuindo-a com a capacidade de tratar a terra como se fosse mar. Pela duração, a embarcação trata solo, lama e terra compactada como se fossem água, avançando por eles e deixando um rastilho ondulado de terreno ressolidificado. Neve, gelo, plantas (incluindo árvores) e pedras pequenas são temporariamente afastados na esteira do navio, mas pedregulhos e montanhas devem ser contornados à vela.',
  'Se conjurar esta magia com um espaço de 7º círculo, ela pode afetar uma embarcação com tripulação de até 30 e dura 24 horas. Se conjurar esta magia com um espaço de 9º círculo, ela pode afetar uma embarcação com tripulação de qualquer tamanho e dura 1 semana.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'encase-in-ice',
  'Encasular em Gelo',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '27 metros',
  true,
  true,
  true,
  'a handful of water',
  'V, S, M (a handful of water)',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Uma onda de água que se choca preenche um quadrado de 6 metros no solo que você possa ver no alcance. A água congela instantaneamente no lugar. Cada criatura na área realiza uma salvaguarda de Destreza. Em uma falha, as pernas da criatura ficam presas no gelo, e a criatura tem a condição Contido até a magia terminar. Uma criatura com a condição Contido pode usar uma ação para fazer um teste de Força (Atletismo) contra a CD de magia, encerrando a condição em si em caso de sucesso. Outra criatura pode executar a ação Ajudar para tentar libertar a criatura presa, fazendo o mesmo teste.

Criaturas que não estavam na área da magia quando você a conjurou tratam a área como Terreno Difícil. Se uma criatura que não esteja Contida pelo gelo entrar na área ou terminar o turno nela, deve ser bem-sucedida em uma salvaguarda de Destreza ou tem a condição Caído.',
  'Se conjurar esta magia com um espaço de 3º círculo, o gelo prende os braços do alvo além das pernas. O alvo não pode executar a ação Atacar nem conjurar magias com componentes somáticos até a condição Contido terminar.

Se conjurar esta magia usando um espaço de 5º círculo, o gelo sepulta completamente as criaturas na área quando você conjura a magia. Criaturas que falham na salvaguarda inicial ficam Contidas e têm Cobertura Total pela duração da magia. Uma criatura afetada pode fazer uma salvaguarda de Força no final de cada um dos seus turnos para se libertar, mas, tenha sucesso ou falhe, sofre 2d6 de dano Gélido à medida que a carne, que estava grudada no gelo, se rasga.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'ensnared-threads',
  'Fios Enredados',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  '27 metros',
  true,
  true,
  true,
  'a knotted string of wool',
  'V, S, M (a knotted string of wool)',
  '1 minuto',
  false,
  false,
  'As Nornas permitem que você force brevemente uma conexão entre os fios do seu destino e os de outra criatura. Uma criatura que você possa ver no alcance deve realizar uma salvaguarda de Sabedoria. Em uma falha, você forma uma conexão entre si e o alvo.

Uma vez por turno, até a magia terminar, o primeiro ataque que o acertar atinge a criatura-alvo em vez disso, se ela puder ser alvo do ataque. Se essa criatura não puder ser o alvo do ataque, o ataque o atinge normalmente.',
  'Se conjurar esta magia com um espaço de 8º ou 9º círculo, todos os ataques que o acertarem atingem o alvo em vez disso. Quaisquer ataques dos quais a criatura não possa ser alvo ainda o atingem normalmente.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'extinguish',
  'Extinguir',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Você extingue todas as chamas mágicas e não mágicas à sua escolha em um Cubo de 18 metros originado em você. Criaturas feitas parcial ou completamente de fogo sofrem 1d12 de dano Energético.',
  'Para cada círculo de espaço acima do 1º que você usar para conjurar esta magia, o cubo aumenta em 3 metros e as criaturas afetadas sofrem 1d12 adicional de dano Energético.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'eyes-of-the-raven',
  'Olhos do Corvo',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a raven feather',
  'V, S, M (a raven feather)',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você invoca o poder dos corvos oniscientes de Wotan, Huginn e Muninn. Enquanto a magia durar, você tem Vantagem em testes de Inteligência e salvaguardas de Inteligência.

Como ação Usar Magia, você pode ganhar Visão Verdadeira com alcance de 9 metros. Isso dura até o início do seu próximo turno. Em seguida a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'fenriss-howl',
  'Uivo de Fenris',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '54 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você canaliza o uivo penetrante e fúnebre do lobo Fenris em um ponto que possa ver no alcance e ganha força do medo alheio. Criaturas à sua escolha a até 18 metros daquele ponto que possam ouvi-lo devem ser bem-sucedidas em uma salvaguarda de Sabedoria ou têm a condição Amedrontado (com você como fonte) pela duração da magia. Enquanto pelo menos uma criatura afetada pela magia permanecer Amedrontada, seu Deslocamento é dobrado, e você causa 3d6 adicionais de dano Necrótico a um inimigo Amedrontado com cada um dos seus ataques.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'fiery-siege',
  'Cerco Flamejante',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  true,
  true,
  'a bit of pitch',
  'V, S, M (a bit of pitch)',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você toca uma arma de cerco, imbuindo-a com poder piroclástico. Pela duração, a arma de cerco causa 1d10 adicional de dano Ígneo quando acerta. Como Ação Bônus, você pode tocar uma máquina de cerco diferente, transferindo o efeito para ela.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'fire-rune',
  'Runa de Fogo',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você toca uma arma corpo a corpo e coloca nela um efeito mágico, criando uma runa visível gravada na arma. Ataques feitos com a arma invocada causam 1d8 adicional de dano Ígneo em um acerto.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'fist-of-the-frost-jarl',
  'Punho do Jarl do Gelo',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a drop of water melted from an icicle',
  'V, S, M (a drop of water melted from an icicle)',
  'Special',
  false,
  false,
  'Um punho de gelo sólido preenchendo um Cubo de 1,5 metro dispara de você na direção escolhida em uma Linha de 36 metros. Cada criatura na Linha realiza uma salvaguarda de Destreza. Em uma falha, a criatura sofre 18 (4d8) de dano Gélido. Em um sucesso, a criatura sofre metade do dano.

Você pode escolher que uma criatura de tamanho Enorme ou menor que falhe na salvaguarda tenha a condição Imobilizado, cuja CD de escape é igual à sua CD de magia. Uma criatura que termina o turno imobilizada pelo punho sofre 9 (2d8) de dano Gélido. Quando uma criatura escapa da imobilização, o punho se estilhaça.',
  'O dano aumenta em 1d8 para cada círculo de espaço de magia acima do 4º. Se conjurada usando um espaço de 7º círculo ou superior, a magia ignora Resistência a dano Gélido.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'freezing-fog',
  'Névoa Congelante',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '54 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 1 hora',
  true,
  false,
  'Você cria uma Esfera de 6 metros de raio de névoa gelada até os ossos centrada em um ponto no alcance. A Esfera está Totalmente Obscurecida e é considerada Terreno Difícil. A névoa permanece no ar pela duração ou até um vento forte (como o criado por Rajada de Vento) dispersá-la.

Cada criatura que inicia o turno na Esfera, ou se move para a área dela, deve ser bem-sucedida em uma salvaguarda de Constituição. Em uma falha, o Deslocamento do alvo é reduzido à metade até o final do próximo turno dele.

Quando uma criatura se move para dentro ou através da área, sofre 2d4 de dano Gélido a cada 1,5 metro que percorre.

Você tem Imunidade a todos os efeitos desta magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'freyjas-allure',
  'Fascínio de Freyja',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '13,5 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Uma criatura à sua escolha que você possa ver no alcance realiza uma salvaguarda de Carisma. Em uma falha, o alvo tem Desvantagem nas jogadas de ataque e não pode se afastar voluntariamente de você pela duração.

No final de cada um dos seus turnos, a criatura pode fazer outra salvaguarda de Carisma. O alvo tem Desvantagem na salvaguarda se puder vê-lo e você estiver a até 9 metros dele. Em um sucesso, a magia termina nele.',
  'Você pode escolher um alvo adicional para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'freyjas-grace',
  'Graça de Freyja',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação, which you take after failing a saving throw.',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Role novamente a salvaguarda como salvaguarda de Carisma, independentemente do tipo original da salvaguarda.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'ghostly-crew',
  'Tripulação Fantasma',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 8 horas',
  true,
  false,
  'Você invoca espíritos intangíveis para tripularem uma embarcação tocada. Pela duração da magia, enquanto você estiver a até 9 metros da embarcação, ela é considerada como tendo número suficiente de marinheiros para executar um complemento completo de ações normais de navio (incluindo movimento e uso de armas de cerco). Os espíritos não podem executar outras ações nem se engajar em quaisquer outras atividades, como lutar de forma independente ou reparar a embarcação.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'giantbane',
  'Flagelo dos Gigantes',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você tem Vantagem nas jogadas de ataque contra criaturas Grandes ou maiores, e seus ataques causam 2d6 adicionais de dano Energético contra tais criaturas.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'giantdodge',
  'Esquiva do Gigante',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  '1 minuto',
  false,
  false,
  'Aumente seu Deslocamento em 6 metros. Você ganha um bônus de +2 na CA contra ataques feitos por criaturas Grandes ou maiores, e não provoca Ataques de Oportunidade delas.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'giants-teeth',
  'Dentes do Gigante',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '40,5 metros',
  true,
  true,
  true,
  'a handful of molars',
  'V, S, M (a handful of molars)',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Dois semicírculos de dentes enormes irrompem do solo e se fecham para esmagar uma criatura à sua escolha a até 27 metros.

O alvo tem a condição Imobilizado. A CD de escape é igual à sua CD de magia. No início de cada um dos turnos dele enquanto tiver a condição Imobilizado, a criatura sofre 2d10 de dano Contundente. Se o alvo escapar, a magia termina.',
  'Quando conjura esta magia usando um espaço de 5º círculo, o dano aumenta para 3d10. Quando a conjura usando um espaço de 7º círculo, o dano aumenta para 5d8. Quando a conjura usando um espaço de 9º círculo, o dano aumenta para 6d8.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'glimpse-the-wyrd',
  'Vislumbre do Wyrd',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Reação, que você executa quando uma criatura tem sucesso ou falha em um Teste de D20',
  'Pessoal',
  true,
  true,
  true,
  'a small spindle',
  'V, S, M (a small spindle)',
  'Instantânea',
  false,
  false,
  'Você adiciona ou subtrai 1d6 do Teste de D20.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'hearthfire',
  'Fogo do Lar',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Action or Ritual',
  'Toque',
  true,
  false,
  true,
  'a bit of charcoal',
  'V, M (a bit of charcoal)',
  '8 horas',
  false,
  true,
  'Você toca um objeto Grande ou menor que não esteja sendo usado ou carregado por outra pessoa. Até a magia terminar, o objeto emite Luz Plena em um raio de 6 metros e Meia-luz por mais 6 metros. Dentro da área de Luz Plena da magia, você e cada criatura à sua escolha têm Imunidade aos efeitos nocivos do Frio Extremo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'hungry-jaws-of-fenris',
  'Mandíbulas Famintas de Fenris',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  NULL,
  'V, S, M',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Como ação Usar Magia, você canaliza o poder de Fenris, o Grande Lobo, transformando a boca em um focinho aberto. Isso não impede seu movimento nem suas ações, mas você não pode falar nem conjurar magias com componentes verbais pela duração.

Enquanto a magia estiver ativa, você pode usar as mandíbulas para fazer um ataque de mordida. Em um acerto, o alvo sofre dano Perfurante igual a 4d10 mais o seu modificador de atributo de conjuração, e tem a condição Imobilizado (CD de escape igual à sua CD de magia).

Se morder um alvo já Imobilizado por você, pode escolher engoli-lo, e a condição Imobilizado termina. Uma criatura engolida é empurrada para uma dimensão de bolso. Enquanto estiver lá, tem as condições Cego e Contido, tem Cobertura Total contra ataques e outros efeitos fora da dimensão, e sofre 19 (3d12) de dano Energético no início de cada um dos seus turnos. Você não pode engolir uma criatura se já tiver engolido uma criatura usando esta magia.

Uma criatura engolida pode fazer uma salvaguarda no final de cada um dos seus turnos. Em um sucesso, você regurgita a criatura para o espaço desocupado mais próximo à sua escolha. O mesmo ocorre se a duração da magia expirar.',
  'O dano causado pelo ataque de mordida aumenta em 1d12 para cada círculo de espaço de magia acima do 6º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'ice-shape',
  'Moldar Gelo',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a thread',
  'V, S, M (a thread)',
  'Instantânea',
  false,
  false,
  'Você toca uma seção de gelo de no máximo 1,5 metro em qualquer dimensão e a molda na forma que desejar. Por exemplo, poderia moldar o gelo em uma arma, estátua ou cofre, ou poderia fazer uma pequena passagem através do gelo com 1,5 metro de espessura. Também poderia moldar gelo para selar uma abertura estreita de caverna. Qualquer objeto que você criar é tosco, mas funcional; detalhes mecânicos mais finos não são possíveis.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'icewalker',
  'Caminhante do Gelo',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Action or Ritual',
  'Pessoal',
  true,
  true,
  true,
  'a shard of ice',
  'V, S, M (a shard of ice)',
  'Concentration , up to 4 hours',
  true,
  true,
  'Pela duração, você emite uma aura em uma Emanação de 9 metros. Enquanto estiverem na aura, você e criaturas à sua escolha ganham os seguintes benefícios:

Tratar gelo escorregadio como terreno normal

Tratar o peso como um décimo do normal para fins de romper gelo fino',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'inbars-giant-friend',
  'Amigo dos Gigantes de Inbar',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Reação, que você executa quando a Giant sees you',
  '27 metros',
  true,
  true,
  true,
  'a hair or nail clipping from a goblinoid',
  'V, S, M (a hair or nail clipping from a goblinoid)',
  'Instantânea',
  false,
  false,
  'Seus olhos brilham com luz dourada. O Gigante deve realizar uma salvaguarda de Sabedoria. Em uma falha, a atitude dele em relação a você melhora 1 passo, como de Hostil para Indiferente ou de Indiferente para Amigável. A atitude de uma criatura é dinâmica, então o modo como você se comporta com o gigante a partir desse ponto pode afetar ainda mais a atitude dele. Um Gigante com Imunidade à condição Enfeitiçado tem Imunidade a esta magia. Depois de conjurar esta magia em um determinado Gigante, você não pode conjurá-la novamente naquele Gigante.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'infectious-skal',
  'Skal Infeccioso',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '13,5 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você canta uma canção de beber ruidosa que compele outros a pararem o que estão fazendo e cantarem junto. Uma criatura que possa ouvi-lo no alcance da magia deve ser bem-sucedida em uma salvaguarda de Sabedoria ou tem a condição Enfeitiçado até a magia terminar. Enquanto a criatura estiver Enfeitiçada, é Amigável em relação a você e não executa ações além de cantar junto com a canção. Pela duração da canção, você pode usar uma Ação Bônus para escolher como alvo uma nova criatura que esteja a até 9 metros de você ou de outra criatura cantando a canção. Você pode afetar um número total de criaturas igual ao seu modificador de atributo de Conjuração a qualquer momento, adicionando-as progressivamente. Uma criatura-alvo deve ser bem-sucedida em uma salvaguarda de Sabedoria ou fica Enfeitiçada por você e começa a cantar junto. Se qualquer um dos cantores além de você for atacado durante a canção, a canção para com uma nota dissonante alta, e a magia termina para todos os afetados.',
  'Se conjurar esta magia com um espaço de 3º círculo ou superior, você pode afetar 2 criaturas cada vez que executar uma Ação Bônus para espalhar a canção.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'jotun-form',
  'Forma de Jotun',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a shard of a giant animal’s bone',
  'V, S, M (a shard of a giant animal’s bone)',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você se metamorfoseia em um Gigante pela duração ou até executar uma ação Usar Magia para se metamorfosear em uma forma elegível diferente. A nova forma deve ser de uma criatura do tipo Gigante com Nível de Desafio não superior ao seu nível ou Nível de Desafio. Você deve ter visto esse tipo de criatura antes.

Ao conjurar a magia, você ganha um número de Pontos de Vida Temporários igual aos Pontos de Vida da primeira forma na qual se metamorfoseia. Esses Pontos de Vida Temporários desaparecem se ainda restarem quando a magia terminar.

Suas estatísticas de jogo são substituídas pelo bloco de estatísticas da forma escolhida, mas você mantém seu tipo de criatura; alinhamento; personalidade; valores de Inteligência, Sabedoria e Carisma; Pontos de Vida; Dados de Pontos de Vida; proficiências; e capacidade de se comunicar. Se tiver o traço Conjuração, você o mantém também.

Ao se metamorfosear, você determina se seu equipamento cai no chão ou muda de tamanho e forma para se adequar à nova forma enquanto você estiver nela.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'lokis-escape',
  'Fuga de Loki',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Reação, which you take after taking damage',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  '1 round',
  false,
  false,
  'Você tem a condição Invisível até o final do seu próximo turno. Enquanto a magia durar, você pode usar sua Ação Bônus para se mover o seu Deslocamento sem provocar Ataques de Oportunidade. A magia termina antecipadamente imediatamente após você fazer uma jogada de ataque, causar dano ou conjurar uma magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'luckfingers',
  'Dedos da Sorte',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 1 hora',
  true,
  false,
  'Você toca uma criatura Média ou menor, imbuindo-a de confiança e habilidade. Até a magia terminar, a criatura tem Vantagem em todos os testes de atributo. Se tal teste resultar em falha, a criatura pode escolher encerrar a magia e ter sucesso automaticamente no teste de atributo.',
  'Você pode escolher um alvo adicional para cada círculo de espaço de magia acima do 3º. Se uma criatura escolher encerrar a magia para ter sucesso automaticamente em um teste de atributo, a magia termina apenas para ela.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'melody-of-sheltered-rest',
  'Melodia do Descanso Protegido',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a musical instrument',
  'V, S, M (a musical instrument)',
  'Concentration , up to 2 hours',
  true,
  false,
  'Você canta ou murmura uma melodia animada. Pela duração, uma aura irradia de você em uma Emanação de 9 metros. Uma criatura dentro da aura (incluindo você) pode estender a duração por mais 2 horas, desde que continue cantando. Isso pode se repetir enquanto uma criatura dentro da aura continuar cantando. Enquanto estiverem na aura, as criaturas têm Vantagem em testes de Percepção e não podem ser surpreendidas.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'murmurs-of-doom',
  'Murmúrios da Perdição',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você inicia um réquiem sussurrado que é magicamente acompanhado pelo uivo de espíritos e outros presságios sombrios. Pela duração, uma aura irradia de você em uma Emanação de 9 metros. Quando cria a aura e no início de cada um dos seus turnos enquanto ela persistir, você pode escolher uma criatura nela para realizar uma salvaguarda de Constituição. Em uma falha, a criatura sofre 3d8 de dano Necrótico.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'noble-sacrifice',
  'Sacrifício Nobre',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação, que você executa quando a creature you can see drops to 0 Hit Points or fails its third Death Saving Throw',
  '13,5 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'A criatura é restaurada a 1 Ponto de Vida, e você perde metade dos seus Pontos de Vida atuais.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'ode-to-wrath',
  'Ode à Ira',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você inicia um canto poético que é magicamente acompanhado por um trio de tambores batendo um ritmo furioso. Pela duração, uma aura irradia de você em uma Emanação de 9 metros. Enquanto estiverem na aura, você e seus aliados adicionam cada um o seu modificador de atributo de conjuração às jogadas de dano feitas com armas corpo a corpo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'pawn-of-the-wyrd',
  'Peão do Wyrd',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  '1 Reaction, que você executa quando another creature takes a Reaction',
  'Pessoal',
  true,
  true,
  true,
  'a bone die',
  'V, S, M (a bone die)',
  'Instantânea',
  false,
  false,
  'Você entrega seu destino aos ventos e aceita a orientação das Nornas. A criatura não executa aquela Reação e não pode executar uma Reação diferente. Se a Reação teria gasto um espaço de magia ou outra habilidade, nada é gasto. Você perde sua próxima Reação.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'protection-rune',
  'Runa de Proteção',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você toca uma criatura, criando uma runa visível gravada na pele dela. A criatura tem Resistência a um tipo de dano à sua escolha.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'reavers-rune',
  'Runa do Saqueador',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você toca uma arma corpo a corpo e coloca nela um efeito mágico, criando uma runa visível gravada na arma. No máximo uma vez por turno, uma criatura empunhando a arma pode fazer uma jogada de ataque com a arma com Vantagem quando de outra forma não teria Vantagem. Se a arma deixar a posse da criatura, a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'regenerative-hull',
  'Casco Regenerativo',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você toca um veículo. No início de cada um dos seus turnos, o veículo recupera um número de Pontos de Vida igual a duas vezes o seu modificador de conjuração. Um veículo deve ter 1 PV ou mais para ser afetado.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'reinforce-hull',
  'Reforçar Casco',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Action or Ritual',
  'Toque',
  true,
  true,
  true,
  'an iron nail',
  'V, S, M (an iron nail)',
  'Concentration , up to 1 hora',
  true,
  true,
  'Um veículo que você toca tem seu limiar de dano aumentado pelo seu modificador de atributo de conjuração pela duração. Um veículo sem limiar de dano não pode ser alvo desta magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'repair-hull',
  'Reparar Casco',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'iron nails',
  'V, S, M (iron nails)',
  'Instantânea',
  false,
  false,
  'Um veículo que você toca recupera um número de Pontos de Vida igual a 4d12 mais o seu modificador de atributo de conjuração. O veículo-alvo deve ter 1 PV ou mais para ser afetado.',
  'O dano aumenta em 1d12 para cada círculo de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'sailors-shanty',
  'Canção do Marinheiro',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Toque',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 4 hours',
  true,
  false,
  'Você toca um veículo. A tripulação do veículo tem Vantagem em Testes de D20 para controlar ou operar o veículo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'shared-expertise',
  'Especialização Compartilhada',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a piece of boot leather',
  'V, S, M (a piece of boot leather)',
  'Concentration , up to 1 hora',
  true,
  false,
  'Pela duração, você emite uma aura em uma Emanação de 9 metros. Escolha até 2 perícias nas quais você tenha Especialização. Se você não tiver Especialização em uma perícia, esta magia não tem efeito.

Enquanto estiverem na área, criaturas aliadas são tratadas como tendo Proficiência nas perícias escolhidas. Se um aliado já tiver Proficiência ou Especialização na perícia, não ganha benefício.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'shield-maidens-favor',
  'Favor da Donzela do Escudo',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação, que você executa quando you or an ally takes damage',
  '13,5 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Um eco espiritual de uma donzela do escudo de Valhalla aparece e se interpõe entre o ataque desencadeador e seu alvo; em seguida a donzela do escudo desaparece. O dano do ataque desencadeador é reduzido em 1d10 mais o seu modificador de conjuração.',
  'A redução de dano aumenta em 1d10 para cada círculo de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'sifs-grace',
  'Graça de Sif',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Toque',
  true,
  false,
  true,
  'two silver beads of equal weight',
  'V, M (two silver beads of equal weight)',
  'Concentration , up to 1 hora',
  true,
  false,
  'Você concede uma medida da velocidade e do passo firme de Sif a uma criatura ao alcance. Até a magia terminar, o Deslocamento do alvo dobra, e criaturas que fazem Ataques de Oportunidade contra o alvo têm Desvantagem nas jogadas de ataque. Se o alvo se mover no turno dele, tem Vantagem em testes de Destreza (Acrobacia).

Se o alvo estiver sujeito a um efeito que exija uma salvaguarda de Destreza, pode escolher ter sucesso automaticamente. Isso encerra esta magia para ele.',
  'Você pode escolher um alvo adicional para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'skaldic-scolding',
  'Repreensão Escáldica',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Reação, which you take in response to taking damage from a creature that you can see within 30 feet of yourself',
  '13,5 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'A criatura que o danificou é bombardeada com uma saraivada de insultos cáusticos e deve realizar uma salvaguarda de Carisma. Em uma falha, a criatura sofre 4d10 de dano Psíquico e tem a condição Incapacitado até o início do seu próximo turno. Se a criatura falhar na salvaguarda por 5 ou mais, tem a condição Atordoado em vez disso. Em um sucesso, a criatura sofre metade do dano e não tem a condição Incapacitado.',
  'O dano aumenta em 1d10 para cada círculo de magia acima do 4º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'song-of-the-shield-wall',
  'Canção da Muralha de Escudos',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  '13,5 metros',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você inicia um canto que é magicamente acompanhado pelo som de martelos batendo no ferro. Escudos circulares espectrais brilhantes aparecem diante de um número de criaturas igual ao seu modificador de atributo de conjuração que estejam a até 9 metros de você. Cada criatura ganha um bônus de +2 na CA.',
  'Se conjurar esta magia com um espaço de 6º círculo, o bônus na CA aumenta para +3, e se usar um espaço de 8º círculo, aumenta para +4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'speechmasters-rune',
  'Runa do Mestre da Fala',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  true,
  'a Tiny stone',
  'V, S, M (a Tiny stone)',
  '1 minuto',
  false,
  false,
  'Você coloca um efeito mágico na pedra usada como componente material da magia, criando uma runa visível gravada na pedra. Qualquer criatura segurando a pedra tem Vantagem em testes de Carisma.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'storm-maidens-edge',
  'Gume da Donzela da Tempestade',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você toca uma arma e a imbui com o poder da tempestade. Até a magia terminar, a arma escolhida causa 2d8 adicionais de dano Elétrico em um acerto.

Uma criatura atingida pela arma deve realizar uma salvaguarda de Força contra a CD de Magia. Em uma falha, o alvo é empurrado 3 metros para trás. Se o alvo falhar na salvaguarda de Força por 5 ou mais, tem a condição Caído.',
  'A quantidade de dano Elétrico adicional causado pela arma aumenta em 1d8 a cada dois círculos de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'summon-leviathan-avatar',
  'Invocar Avatar do Leviatã',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '54 metros',
  true,
  true,
  true,
  'a drop of seawater',
  'V, S, M (a drop of seawater)',
  'Concentration , up to 1 hora',
  true,
  false,
  'Você chama o espírito do lendário leviatã. Ele se manifesta em um espaço desocupado que você possa ver no alcance e usa o bloco de estatísticas Espírito do Leviatã. O espaço escolhido deve estar preenchido com água suficiente para conter o tamanho do leviatã; caso contrário, a magia termina imediatamente. A criatura desaparece quando chega a 0 Pontos de Vida ou quando a magia termina.

O leviatã é um aliado seu e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas age imediatamente após o seu turno. Ela obedece a seus comandos verbais (nenhuma ação necessária da sua parte). Se você não der nenhum comando, ela executa a ação Esquivar e usa seu movimento para evitar perigo.',
  'Use o círculo do espaço de magia como o círculo da magia no bloco de estatísticas.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'sun-rune',
  'Runa do Sol',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  '1 minute',
  'Toque',
  true,
  true,
  true,
  'a Tiny stone',
  'V, S, M (a Tiny stone)',
  '8 horas',
  false,
  false,
  'Você coloca um efeito mágico na pedra usada como componente material da magia, criando uma runa visível gravada na pedra. Você só pode ter uma magia Runa do Sol ativa por vez.

Uma vez enquanto a magia durar, qualquer criatura segurando a pedra pode usar uma Ação para invocar o poder da runa e arremessá-la a um alvo a até 18 metros de distância. Ela para antes se impactar contra uma superfície sólida. Quando a pedra aterra ou impacta, a runa é ativada.

Quando a runa é ativada, o calor abrasador do sol lampeja em uma Esfera de 9 metros de raio centrada na pedra. Cada criatura na Esfera realiza uma salvaguarda de Constituição. Em uma falha, a criatura sofre 4d6 de dano Ígneo e 4d6 de dano Radiante, ou metade em um sucesso.

Objetos inflamáveis na Esfera que não estejam sendo usados ou carregados começam a queimar. Gelo ou neve dentro da Esfera vaporizam em uma névoa que preenche a Esfera, tornando-a Totalmente Obscurecida por 1 minuto ou até um vento forte (como o criado pela magia Rajada de Vento) dispersá-la.

Após ativar o poder da runa, a criatura não pode ativar outra Runa do Sol novamente até depois de um Descanso Longo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'talons-of-the-eagle',
  'Garras da Águia',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'an eagle feather',
  'V, S, M (an eagle feather)',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você imbui a si mesmo com o poder da águia. Enquanto a magia durar, você tem Vantagem em testes de Destreza e salvaguardas de Destreza.

Como ação Usar Magia, você pode transformar brevemente as mãos em um conjunto de garras, então se mover até o seu Deslocamento e fazer um ataque corpo a corpo com as garras. Em um acerto, o alvo sofre dano Cortante igual a 1d8 mais o seu modificador de atributo de conjuração.',
  'O dano aumenta em 1d8 a cada dois círculos de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'thought-rune',
  'Runa do Pensamento',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  true,
  'a Tiny stone',
  'V, S, M (a Tiny stone)',
  '1 minuto',
  false,
  false,
  'Você coloca um efeito mágico na pedra usada como componente material da magia, criando uma runa visível gravada na pedra. Uma criatura segurando a pedra tem Vantagem em testes de Inteligência e Sabedoria e em salvaguardas de Inteligência e Sabedoria.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'tricksters-bluff',
  'Blefe do Trapaceiro',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  false,
  true,
  'the petrified tongue of a serpent',
  'V, M (the petrified tongue of a serpent)',
  'Concentration , up to 1 hora',
  true,
  false,
  'Você é agraciado com uma medida da língua de prata de Loki. Você tem Vantagem em testes de Carisma (Enganação). Se falhar em tal teste, pode escolher causar 1d4 de dano Psíquico à criatura que falhou em enganar, e essa criatura tem Desvantagem nas jogadas de ataque até o início do seu próximo turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'trollblood-infusion',
  'Infusão de Sangue de Troll',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a drop of troll blood',
  'V, S, M (a drop of troll blood)',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Uma criatura que você toca é magicamente infundida com as propriedades regenerativas do sangue de troll. Pela duração da magia, o alvo recupera 5 Pontos de Vida no início de cada um dos seus turnos, se tiver pelo menos 1 Ponto de Vida, e tem sucesso automaticamente em Salvaguardas Contra a Morte. Se a criatura sofrer dano Ácido ou Ígneo, este efeito não funciona no início do próximo turno dela.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'truths-blade',
  'Lâmina da Verdade',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  '13,5 metros',
  true,
  true,
  true,
  'A silver pin, which is not consumed',
  'V, S, M (A silver pin, which is not consumed)',
  '10 minuto',
  false,
  false,
  'Você pune quem falaria falsamente com você. A criatura deve realizar uma salvaguarda de Sabedoria. Se falhar, pela duração, sofre 4d8 de dano Psíquico sempre que mentir.',
  'A quantidade de dano Psíquico aumenta em 1d8 para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'valhallas-cohort',
  'Coorte de Valhalla',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '27 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você conjura espíritos guerreiros de Valhalla, o salão dos mortos honrados. Os espíritos aparecem como uma coorte Enorme de guerreiros espectrais intangíveis em um espaço desocupado que você possa ver no alcance. Os espíritos brandem lanças, machados e lâminas, atacando quem estiver por perto. A coorte dura pela duração, e você escolhe a aparência dos espíritos (como a espécie deles e quaisquer insígnias usadas).

Você também pode mover a coorte 9 metros como Ação Bônus nos seus turnos seguintes.

Se a coorte terminar o movimento a até 1,5 metro de uma criatura, ou se uma criatura se mover a até 1,5 metro da coorte, você pode fazer um ataque mágico corpo a corpo contra essa criatura. Em um acerto, o alvo sofre dano Energético igual a 2d10 mais o seu modificador de atributo de conjuração. Uma criatura só pode ser atacada dessa forma uma vez por turno.',
  'O dano aumenta em 1d10 para cada círculo de espaço de magia acima do 4º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'valkyries-guidance',
  'Orientação da Valquíria',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a polished blue stone',
  'V, S, M (a polished blue stone)',
  '1 minuto',
  false,
  false,
  'Você consulta as Valquírias e pede que guiem sua mão à glória em Valhalla. Escolha uma criatura que possa ver. Pela duração da magia, você ganha Vantagem em jogadas de ataque corpo a corpo contra aquela criatura e em testes de Inteligência para recordar lore sobre ela. A magia termina imediatamente se você não atacar a criatura no seu turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'valkyries-vision',
  'Visão da Valquíria',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a crystal bead',
  'V, S, M (a crystal bead)',
  'Concentration , up to 10 minuto',
  true,
  false,
  'Você vê quão perto da morte outras criaturas estão. Até a magia terminar, você conhece o total atual de Pontos de Vida de cada criatura que possa ver a até 9 metros de você, e pode ver quantos níveis de Exaustão ela tem.

Como Ação Bônus no seu turno, você pode fazer uma criatura a até 9 metros de você que esteja morrendo ficar Estável. Fazer isso encerra a magia imediatamente.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'wall-of-snow',
  'Muralha de Neve',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Action or Ritual',
  '13,5 metros',
  true,
  true,
  true,
  'a freshly packed snowball',
  'V, S, M (a freshly packed snowball)',
  'Concentration , up to 10 minuto',
  true,
  true,
  'Você cria uma muralha de neve compactada em uma superfície sólida no alcance. Você pode fazer a muralha com até 15 metros de comprimento, 4,5 metros de altura e 30 centímetros de espessura. Ou pode fazer uma cúpula hemisférica de 3 metros de raio. Você pode moldar a muralha da forma que escolher, desde que forme um caminho contínuo ao longo do solo. A muralha dura pela duração.

Se a muralha cortar o espaço de uma criatura quando aparecer, a criatura é empurrada para um lado da muralha (você escolhe qual lado).

A muralha é um objeto que pode ser danificado e assim rompido. Tem CA 10 e 10 Pontos de Vida por seção de 3 metros, e tem Imunidade a dano Gélido, Venenoso e Psíquico, e Vulnerabilidade a dano Ígneo e Radiante. Reduzir uma seção de 3 metros da muralha a 0 Pontos de Vida a destrói.

Criaturas dentro de uma cúpula intacta têm Imunidade aos efeitos do Frio Extremo enquanto a magia durar.

Se conjurar esta magia em uma área de terreno nevado, ela se mistura perfeitamente com a neve existente. Se uma criatura executar a ação Analisar para examinar a muralha, pode diferenciá-la do terreno ao redor com um teste bem-sucedido de Inteligência (Investigação) contra a CD de magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'weave-detonation',
  'Detonação da Trama',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  '27 metros',
  true,
  true,
  true,
  'a short piece of thread',
  'V, S, M (a short piece of thread)',
  'Instantânea',
  false,
  false,
  'Uma explosão invisível e silenciosa de destino irrompe em um ponto à sua escolha. Cada criatura em uma Esfera de 6 metros de raio centrada naquele ponto realiza uma salvaguarda de Sabedoria. Em uma falha, a criatura tem Desvantagem em todos os Testes de D20 por 1 minuto.

Uma criatura pode repetir a salvaguarda de Sabedoria no final de cada um dos seus turnos, encerrando a magia em caso de sucesso.',
  'Para cada círculo de espaço de magia acima do 3º, você pode excluir até cinco criaturas dentro do raio dos efeitos da magia.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'whiteout',
  'Nevasca Cegante',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '40,5 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration , up to 1 minuto',
  true,
  false,
  'Você deve estar ao ar livre para conjurar esta magia, e ela termina antecipadamente se você entrar em um ambiente fechado.

Ao conjurar esta magia, você cria uma Esfera de 6 metros de raio de névoa densa e neve rodopiante centrada em você. A Esfera está Totalmente Obscurecida e o terreno dentro dela é Terreno Difícil. Qualquer criatura que comece o turno na Esfera ou entre na Esfera no turno dela deve ser bem-sucedida em uma salvaguarda de Constituição ou recebe 1 nível de Exaustão. Criaturas que tenham Resistência ou Imunidade a dano Gélido têm sucesso automaticamente nessa salvaguarda.

Ao conjurar a magia, você pode designar um número de criaturas igual ao seu modificador de atributo de conjuração. Essas criaturas não recebem níveis de Exaustão da magia.

Quando a magia termina, toda a neve criada por ela desaparece instantaneamente e os níveis de Exaustão terminam.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'wotans-retribution',
  'Retribuição de Wotan',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Reação, que você executa quando a creature scores a Critical Hit against you',
  'Pessoal',
  true,
  false,
  true,
  'a splinter of iron',
  'V, M (a splinter of iron)',
  'Instantânea',
  false,
  false,
  'Você se teleporta diretamente atrás da criatura que desencadeou esta Reação e faz um ataque corpo a corpo contra ela com uma arma que estiver empunhando. Você tem Vantagem na jogada de ataque. Em um acerto, a criatura sofre o dano do seu ataque bem como uma quantidade de dano igual ao dano que ela causou a você quando desencadeou esta Reação.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
  'wyrd-sight',
  'Visão do Wyrd',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'A hag’s eye',
  'V, S, M (A hag’s eye)',
  'Concentration , up to 1 hora.',
  true,
  false,
  'Você manipula os fios da sorte e do destino para trabalhar a seu favor. No máximo uma vez por turno, você pode rolar 1d12 e somá-lo ou subtraí-lo de uma rolagem de d20 feita por uma criatura que você possa ver.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:magic-and-miscellany')
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
