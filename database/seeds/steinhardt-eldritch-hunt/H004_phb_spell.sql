-- Magias Steinhardt Eldritch Hunt Player Pack
-- Fonte: docs/source/_scrapes/steinhardt (capítulo Spells)

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'brittle-bone-throw',
  'Arremesso de Osso Frágil',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 metros',
  true,
  true,
  true,
  'pó de osso',
  'V, S, M (pó de osso)',
  'Instantânea',
  false,
  false,
  '[Osteomancia]

Você arremessa um fragmento de osso estilhaçado contra uma criatura no alcance. Faça um ataque de magia à distância contra o alvo. Em um acerto, o alvo sofre 1d8 de dano Perfurante. Em um erro, você pode estilhaçar o osso no ar e redirecionar o remanescente para outra criatura a até 4,5 m do alvo original. Faça outro ataque de magia à distância. Em um acerto, o novo alvo sofre 1d4 de dano Perfurante.',
  'Aprimoramento de Truque. O dano aumenta em 1d8 e 1d4, respectivamente, quando você atinge os níveis 5 (2d8, 2d4), 11 (3d8, 3d4) e 17 (4d8, 4d4).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'gravity-spike',
  'Espinho Gravitacional',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Você cria um campo gravitacional localizado que altera temporariamente o terreno para empalá-lo. Escolha uma criatura no chão que você possa ver no alcance. Ela deve fazer uma salvaguarda de Destreza. Em falha, sofre 1d4 de dano Perfurante e fica Caída. Em sucesso, sofre apenas metade do dano.',
  'Aprimoramento de Truque. O dano aumenta em 1d4 quando você atinge os níveis 5 (2d4), 11 (3d4) e 17 (4d4).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'fractured-shell',
  'Casca Fraturada',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a carapaça de um porco-espinho',
  'V, S, M (a carapaça de um porco-espinho)',
  'Concentração, até 10 minutos',
  true,
  false,
  '[Osteomancia]

Você toca uma criatura voluntária, forçando placas ósseas com espinhos a crescerem e perfurarem a pele. Ela sofre 1 ponto de dano Perfurante. Pela duração da magia, na primeira vez em cada turno que o alvo for atingido por uma jogada de ataque corpo a corpo, a criatura atacante sofre 2d4 de dano Perfurante.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d4 para cada nível de espaço acima de 1. A magia não exige Concentração com um espaço de 5º círculo ou superior.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'phalangeal-shot',
  'Tiro Falângico',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
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
  '[Osteomancia]

Você aponta os dedos à frente e seus ossos falângicos disparam para fora, como balas de uma arma. Eles regeneram imediatamente, deixando a mão intacta. Todas as criaturas numa Linha de 9 m de comprimento e 30 cm de largura à sua frente devem passar numa salvaguarda de Destreza ou sofrer 2d8 de dano Perfurante.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8 para cada nível de espaço acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'spectral-slash',
  'Talho Espectral',
  1,
  '1º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  '6 metros',
  true,
  true,
  true,
  'uma arma corpo a corpo valendo 1+ PP',
  'V, S, M (uma arma corpo a corpo valendo 1+ PP)',
  'Instantânea',
  false,
  false,
  'Você envia uma cópia espectral de si para abater o inimigo. Faça um ataque de magia corpo a corpo contra uma criatura a até 6 m de você. Em um acerto, o alvo sofre 1d8 de dano do tipo de dano da sua arma.

Você pode então gastar sua ação para se mover até 6 m em linha reta em direção ao alvo, atravessando um rastro espectral, e realizar a ação Atacar contra ele. Para usar esta ação, você deve atacar com a arma corpo a corpo usada na conjuração desta magia.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8 e a distância percorrida em 3 m para cada nível de espaço acima de 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'arm-cannon',
  'Canhão de Braço',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '9 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 rodada',
  false,
  false,
  '[Osteomancia]

Você dispara os ossos do antebraço através da mão, deixando um ferimento grave que regenera e cicatriza imediatamente. Faça um ataque de magia à distância contra uma criatura no alcance. Em um acerto, o alvo sofre 4d8 de dano Perfurante e deve passar numa salvaguarda de Força ou ser empurrado 4,5 m para longe de você. Se for empurrado contra um obstáculo, fica empalado pelo osso e tem a condição Contido até o fim do próximo turno dele. Criaturas Grandes ou maiores têm Vantagem nessa salvaguarda.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8 e a distância de empurrão em 1,5 m para cada nível de espaço acima de 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'blind-ambush',
  'Emboscada Cega',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 metros',
  false,
  true,
  true,
  'um apito feito de ossos',
  'S, M (um apito feito de ossos)',
  '1 minuto',
  false,
  false,
  'Você sopra um apito, liberando um som inaudível. Escolha um ponto no chão no alcance. Na primeira vez que uma criatura se mover 1,5 m ou mais enquanto estiver dentro de um Quadrado de 3 m centrado nesse ponto antes da magia terminar, uma mandíbula eldritch erupciona do solo, causando 2d10 de dano Perfurante a cada criatura no Quadrado e derrubando uma delas (decida ao disparar). A magia então termina.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d10 para cada nível de espaço acima de 2. Se usar um espaço de 5º círculo ou superior, a magia pode disparar uma segunda vez antes de terminar.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'calcified-memories',
  'Memórias Calcificadas',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação ou Ritual',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  true,
  '[Osteomancia]

Você toca os ossos de uma criatura falecida. Ao fazê-lo, uma ilusão cinzenta fantasmagórica da criatura caída aparece acima do cadáver para reencenar os últimos 6 segundos de sua vida. A ilusão mostra apenas as ações da criatura — reagir a um monstro invisível ou engasgar com gás venenoso, por exemplo — mas não mostra o monstro ou efeito causador, apenas seus contornos. Esta magia não tem efeito em criaturas Mortas-vivas. Uma vez que a morte de um cadáver tenha sido revelada assim, não pode ser mostrada de novo por 24 horas.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'skeletal-tail',
  'Cauda Esquelética',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  true,
  true,
  'a cauda de um escorpião',
  'V, S, M (a cauda de um escorpião)',
  '1 minuto',
  false,
  false,
  '[Osteomancia]

Você cresce uma longa cauda semelhante à de escorpião feita de ossos afiados. Sempre que uma criatura se mover enquanto estiver numa Emanação de 4,5 m originada de você, você pode usar uma Reação para tentar perfurá-la com a cauda. Faça um ataque de magia corpo a corpo. Em um acerto, o alvo sofre dano Perfurante igual a 2d4 + seu modificador de conjuração e é puxado para um espaço vazio adjacente a você enquanto a cauda o arrasta.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 2d4 para cada nível de espaço acima de 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'displacing-maw',
  'Mandíbula Deslocadora',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '3 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  '[Osteomancia]

Sua caixa torácica se abre com violência, formando uma mandíbula que tenta devorar uma criatura no alcance. A criatura deve fazer uma salvaguarda de Força. Em falha, sofre 4d8 de dano Perfurante e é transportada magicamente para um ponto à sua escolha no chão a até 18 m de você, onde a mandíbula reaparece e a regurgita. Em sucesso, sofre apenas metade do dano.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d8, e a distância de teleporte aumenta em 3 m, para cada nível de espaço acima de 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'osseous-impalement',
  'Empalamento Ósseo',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 metros',
  true,
  true,
  true,
  'um bastão de bambu calcificado',
  'V, S, M (um bastão de bambu calcificado)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Osteomancia]

Espinhos ósseos massivos brotam sob até quatro criaturas no chão à sua escolha que você possa ver no alcance. Elas devem passar numa salvaguarda de Destreza ou sofrer 3d10 de dano Perfurante e ficar empaladas pelo espinho, com a condição Contido e erguidas a 1,5 m do chão pela duração. Uma criatura Contida assim sofre 1d10 de dano Perfurante no início de cada um dos seus turnos.

Uma criatura pode usar sua ação para fazer um teste de Força (Atletismo) contra sua CD de magia, quebrando o espinho e libertando-se em sucesso.',
  'Usando um Espaço de Magia de Círculo Superior. O dano (inicial e contínuo) aumenta em 1d10 para cada nível de espaço acima de 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'spectral-fury',
  'Fúria Espectral',
  3,
  '3º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '9 metros',
  true,
  true,
  true,
  'uma arma corpo a corpo valendo 1+ PP',
  'V, S, M (uma arma corpo a corpo valendo 1+ PP)',
  'Instantânea',
  false,
  false,
  'Você envia três duplicatas espectrais de si para abater inimigos a até 9 m de você. Pode ordená-las a atacar um alvo ou vários. Faça um ataque de magia corpo a corpo para cada duplicata. Em um acerto, um alvo sofre 4d8 de dano do tipo de dano da sua arma.

Você pode então usar uma Ação Bônus para se mover até 9 m em linha reta em direção a um dos alvos sem provocar Ataques de Oportunidade, atravessando um rastro espectral, e fazer um único ataque corpo a corpo com arma.',
  'Usando um Espaço de Magia de Círculo Superior. O dano da duplicata espectral aumenta em 2d8 para cada nível de espaço acima de 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'dread-scarecrow',
  'Espantalho do Pavor',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'uma flauta feita de um fêmur valendo 50+ PO',
  'V, S, M (uma flauta feita de um fêmur valendo 50+ PO)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Osteomancia]

Você cria magicamente a ilusão horrível de todos os seus ossos se quebrando e o corpo se dobrando de formas impossíveis, acompanhada pelo som de um crânio estilhaçado. Cada criatura à sua escolha numa Esfera de 9 m de raio centrada em você deve passar numa salvaguarda de Sabedoria ou ficar Amedrontada pela duração. Enquanto Amedrontada por esta magia, a Velocidade da criatura se torna 0 e ela fica Caída, as pernas falhando de medo. Se uma criatura afetada sofrer dano, pode repetir a salvaguarda no fim do próximo turno dela, encerrando o efeito em si em sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'maiden-of-bones',
  'Donzela dos Ossos',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 metros',
  true,
  true,
  true,
  'um osso carpiano de virgem',
  'V, S, M (um osso carpiano de virgem)',
  '1 minuto',
  false,
  false,
  '[Osteomancia]

Uma criatura no alcance deve passar numa salvaguarda de Força ou ficar presa dentro de uma donzela de ferro formada de osso que aparece no espaço dela. A criatura tem as condições Contido e Incapacitado, está atrás de Cobertura Total, não pode ser danificada por ataques ou efeitos originados do exterior, e sofre 3d6 de dano Perfurante no início de cada um dos seus turnos enquanto espinhos de osso perfuram o corpo.

No fim de cada um dos turnos dela, a criatura presa pode repetir a salvaguarda, escapando e encerrando a magia em sucesso.

A donzela óssea tem CA igual a 10 + seu modificador de conjuração, 80 Pontos de Vida, Imunidade a dano Psíquico e de Veneno, e Vulnerabilidade a dano Contundente. Se a donzela for destruída, a criatura presa é libertada e a magia termina.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d6 e os PV da donzela aumentam em 20 para cada nível de espaço acima de 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'marrow-transplant',
  'Transplante de Medula',
  4,
  '4º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '9 metros',
  true,
  true,
  true,
  'um pedaço de osso da coluna e um diamante valendo 300+ PO, que a magia consome',
  'V, S, M (um pedaço de osso da coluna e um diamante valendo 300+ PO, que a magia consome)',
  'Instantânea',
  false,
  false,
  '[Osteomancia]

Você drena a medula óssea de uma criatura, tentando roubar sua força vital e transferi-la a outra criatura à sua escolha. Faça um ataque de magia à distância contra uma criatura no alcance. Em um acerto, o alvo sofre 4d6 de dano Necrótico. Escolha outra criatura no alcance; ela recupera um número de Pontos de Vida igual ao dano causado ou, se estava morta há menos de 1 minuto, retorna à vida com PV iguais ao número recuperado. Se algum dos alvos não tiver ossos, a magia falha. Esta magia não pode trazer de volta uma criatura que morreu de velhice, nem restaurar partes do corpo faltantes.',
  'Usando um Espaço de Magia de Círculo Superior. O dano aumenta em 1d6 para cada nível de espaço acima de 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
  'forest-of-dread',
  'Floresta do Pavor',
  5,
  '5º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  '[Osteomancia]

Você toca o chão sob si e ossos semelhantes a árvores brotam do solo num Cilindro de 9 m de raio e 6 m de altura centrado em você. Cada criatura à sua escolha nessa área deve fazer uma salvaguarda de Destreza, sofrendo 4d8 de dano Perfurante em falha ou metade em sucesso.

Pela duração, a área se torna Terreno Difícil e, quando uma criatura se move para dentro ou dentro da área, sofre 2d8 de dano Perfurante a cada 1,5 m que percorre; você é Imune a esse efeito. A floresta do pavor concede Meia Cobertura a quaisquer criaturas dentro da área. Os ossos se desintegram quando a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack')
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
