-- Magias Grim Hollow Cap. 7 (Spells & Curses)
-- Overlay PT completo: docs/source/extracts/grim-hollow/cap7-spells-pt.json (101/101)
-- Aplicar: node scripts/generate/apply-cap7-spell-pt-overlay.mjs
-- Fonte: grim-hollow-players-guide-2024-en:chapter-7-spells-curses
-- Tag Sangromancy: prefixo [Sangromancia] na description quando aplicável.

-- Remove órfão de extract antigo (heading de regras confundido com magia)

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'arboreal-curse',
  'Maldição Arbórea',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a cup of sap',
  'V, S, M (a cup of sap)',
  'Até ser dissipada',
  false,
  false,
  'Você tenta transformar em madeira uma criatura que possa ver no alcance. A criatura faz uma salvaguarda de Constituição. Em uma falha, ela fica com a condição Contido enquanto sua carne começa a endurecer em casca. Em um sucesso, seu Deslocamento é 0 até o início do seu próximo turno.

Uma criatura Contida por esta magia faz uma salvaguarda de Constituição no final de cada um dos seus turnos. Se obtiver sucesso três vezes, a condição termina. Se falhar três vezes, é transformada em uma árvore e fica com a condição Petrificado. Os sucessos e as falhas não precisam ser consecutivos; acompanhe ambos até o alvo acumular três de um tipo.

Se a criatura for queimada, derrubada ou destruída de outro modo enquanto Petrificada, ela é morta.

A criatura permanece transformada a menos que o efeito seja revertido em até 1 ano com Restauração Maior, Desejo ou magia similar. Se a criatura passar 1 ano e 1 dia como árvore, a transformação se torna permanente e nada pode devolvê-la à forma original.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'arcane-aegis',
  'Égide Arcana',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Pessoal',
  false,
  true,
  true,
  'a statuette of a hedgehog',
  'S, M (a statuette of a hedgehog)',
  '1 minuto',
  false,
  false,
  'Ao conjurar esta magia, você é envolto por uma luz cintilante que se dissipa rapidamente. Você ganha 2d10 PV temporários. Se uma criatura o acertar com um ataque corpo a corpo antes de a magia terminar, a criatura sofre dano Energético igual ao número de PV temporários perdidos em consequência do ataque. A magia termina antecipadamente se você não tiver PV temporários.',
  'Você ganha 2d10 PV temporários adicionais para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'assisted-aim',
  'Mira Assistida',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '9 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'Você revitaliza até três criaturas no alcance com precisão aprimorada. Cada alvo ganha um bônus de +1 nas jogadas de ataque que fizer com armas à distância. Além disso, o alcance normal e o longo das armas à distância empunhadas por um alvo são dobrados pela duração da magia.',
  'Você pode escolher uma criatura adicional como alvo para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'binding-pledge',
  'Compromisso Vinculante',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  '1 minuto or Ritual',
  'Toque',
  true,
  true,
  true,
  'a book of religious or legal importance',
  'V, S, M (a book of religious or legal importance)',
  '10 days',
  false,
  false,
  'Ao conjurar a magia, uma criatura voluntária no alcance faz uma promessa, jura um juramento ou celebra um contrato. Pela duração da magia, você sabe imediatamente se a criatura quebrar essa promessa, juramento ou contrato. Se isso acontecer, pelo restante da duração da magia você conhece a distância e a direção até a criatura. Se esta magia for dissipada, você sabe imediatamente, mas não aprende a distância nem a direção até a criatura.',
  'A duração se torna 30 dias (espaço de 3º–4º círculo) ou 1 ano (espaço de 5º–6º círculo). Se você usar um espaço de 7º círculo ou superior, a magia dura até ser dissipada.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'bloat',
  'Inchação',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a bean',
  'V, S, M (a bean)',
  '1 round',
  false,
  false,
  'Você faz os gases no interior de uma criatura que possa ver no alcance se expandirem rapidamente. O alvo faz uma salvaguarda de Constituição, sofrendo 3d10 de dano Necrótico em uma falha ou metade desse dano em um sucesso. Se o dano que a criatura sofrer for igual ou superior ao valor de Constituição dela, a criatura flutua verticalmente 1,5 metro e permanece suspensa até o início do seu próximo turno. O alvo só pode se mover empurrando ou puxando um objeto ou superfície fixa ao alcance (como uma parede ou um teto), o que lhe permite se mover como se estivesse escalando. Quando a magia termina, o alvo flutua suavemente até o chão.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'bloodbane-rune',
  'Runa Flagelo-Sangue',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  false,
  true,
  false,
  NULL,
  'S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Você escolhe uma arma no alcance e nela traça uma runa escrita em sangue.

Pela duração, enquanto você empunhar essa arma, ela escorre um icor vermelho fantasmagórico quando estiver a até 9 metros de uma criatura Morta-viva. Além disso, uma vez por turno, quando você causar dano a uma criatura Morta-viva com a arma, causa dano Radiante extra. Para determinar esse dano, role o número de Dados de Vida que você gastou para conjurar a magia.',
  'Você gasta um Dado de Vida adicional para cada círculo de espaço de magia acima do 1º. Além disso, sua Concentração pode durar mais com um espaço de 2º círculo (até 10 minutos) ou 3º+ (até 1 hora).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'bloodletter',
  'Sangrador',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você toca uma arma não mágica. Até a magia terminar, a primeira criatura atingida pela arma deve obter sucesso em uma salvaguarda de Constituição ou recebe uma ferida putrefata. Uma criatura com uma ferida putrefata sofre 2d6 de dano Necrótico no início de cada um dos seus turnos pela duração da magia. Uma criatura só pode ter uma ferida putrefata por vez.

Se a criatura receber cura, a magia e o dano recorrente terminam.',
  'O dano aumenta em 1d6 para cada círculo de espaço de magia acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-bond',
  'Vínculo de Sangue',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a rag soaked in your own blood',
  'V, S, M (a rag soaked in your own blood)',
  '1 hora',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar três Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos; o alvo ganha PV temporários iguais ao total da rolagem.

Pela duração, você sabe a direção e a distância até o alvo, e você e o alvo podem falar telepaticamente. Além disso, você pode escolher essa criatura ao conjurar uma magia com alcance Pessoal ou Toque, independentemente da distância entre vocês. Esses benefícios são suprimidos enquanto você e a criatura não estiverem no mesmo plano.

A qualquer momento, a criatura alvo pode encerrar a magia antecipadamente. Se o fizer, perde todos os PV temporários restantes concedidos por esta magia e sofre dano Necrótico igual aos PV temporários perdidos.',
  'A duração aumenta com espaço de 5º ou 6º círculo (8 horas), 7º ou 8º (24 horas) e 9º (7 dias).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-rush',
  'Ímpeto Sanguíneo',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Role o Dado de Vida duas vezes e recupere PV iguais à soma das rolagens mais o seu modificador de atributo de conjuração.',
  'Você pode gastar um Dado de Vida adicional para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-tide',
  'Maré de Sangue',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a shell',
  'V, S, M (a shell)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar seis Dados de Vida ou a magia falha automaticamente.

Um jato de sangue formando uma Linha de 30 metros de comprimento e 3 metros de largura explode de você na direção escolhida. Cada criatura na Linha deve fazer uma salvaguarda de Destreza. Em uma falha, a criatura é empurrada 30 metros para longe de você na direção da Linha, fica com a condição Caído e sofre dano Contundente igual à rolagem dos Dados de Vida gastos na magia mais o seu modificador de atributo de conjuração. Em um sucesso, a criatura sofre apenas metade desse dano.',
  'Você pode gastar um Dado de Vida adicional para cada círculo de espaço de magia acima do 6º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-wisp',
  'Fogo-Fátuo de Sangue',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a ruby worth 10 GP',
  'V, S, M (a ruby worth 10 GP)',
  '1 hora',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar dois Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos e crie um fogo-fátuo vermelho com PV iguais à rolagem mais o seu modificador de atributo de conjuração. O fogo-fátuo circula sua cabeça. Sua CA é igual a 10 mais o seu modificador de atributo de conjuração, e ele usa as suas salvaguardas.

Sempre que você rolar dano de uma magia enquanto o fogo-fátuo circular você, pode rerrolar um dos dados de dano. Você deve usar a nova rolagem, e o fogo-fátuo sofre dano igual a essa nova rolagem. Se o fogo-fátuo for reduzido a 0 PV, a magia termina.',
  'Você pode gastar um Dado de Vida adicional para cada círculo de espaço de magia acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'boil-blood',
  'Ferver Sangue',
  1,
  '1º círculo',
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
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Um alvo voluntário sofre dano Ígneo igual à rolagem do Dado de Vida gasto. Se o alvo tiver a condição Envenenado, essa condição termina imediatamente.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'burst-forth',
  'Irromper',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '60 m',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar sete Dados de Vida ou a magia falha automaticamente. Você se teleporta para dentro de uma criatura que possa ver no alcance e irrompe dela em uma fonte de sangue, no espaço desocupado mais próximo. O alvo faz uma salvaguarda de Constituição, sofrendo dano Necrótico igual à rolagem dos Dados de Vida gastos para conjurar a magia mais o seu modificador de atributo de conjuração em uma falha, ou metade desse dano em um sucesso.',
  'Você pode gastar um Dado de Vida adicional para cada círculo de espaço de magia acima do 7º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'calling-card',
  'Cartão de Visitas',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Toque',
  false,
  true,
  true,
  'a stamp carved like the mark left by your calling card',
  'S, M (a stamp carved like the mark left by your calling card)',
  'Até ser dissipada',
  false,
  false,
  'Você toca um cadáver e deixa uma marca mágica. Você pode escolher torná-la uma marca visível que aparece como uma runa ou palavra escrita na carne, ou pode escolher tornar a marca Invisível. Uma criatura que use a ação Analisar para examinar especificamente um cadáver a detecta automaticamente, esteja visível ou Invisível.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'call-the-rabid-beast',
  'Chamar a Besta Raivosa',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a fang from a rabid animal',
  'V, S, M (a fang from a rabid animal)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Uma criatura que você toca se transforma em um monstro raivoso, tomado de fúria primordial. O alvo brota pelo espesso e sua boca se alonga em um focinho dentado. Ele ganha 20 PV temporários. Enquanto transformada, a criatura tem os seguintes efeitos:',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'chains-of-beleth',
  'Correntes de Beleth',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '30 m',
  true,
  true,
  true,
  'a chain link',
  'V, S, M (a chain link)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Correntes farpadas terminadas em ganchos de carne irrompem do solo a partir de um ponto que você possa ver no alcance, açoitadas em uma Esfera de 6 metros de raio centrada nesse ponto.

Cada criatura na área faz uma salvaguarda de Destreza. Em uma falha, sofre 8d6 de dano Perfurante e fica com a condição Contido até a magia terminar.

Na primeira vez que uma criatura entrar na área das correntes em um turno ou iniciar o turno nela, deve obter sucesso em uma salvaguarda de Destreza ou ficar com a condição Contido enquanto estiver na área ou até se libertar. Uma criatura Contida pelas correntes pode usar uma ação para fazer um teste de Força (Atletismo) contra a sua CD de magia. Em um sucesso, deixa de estar Contida.

Quando uma criatura Contida por esta magia termina o turno, sofre 3d6 de dano Contundente.',
  'O dano inicial e o subsequente aumentam em 1d6 para cada círculo de espaço de magia acima do 6º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'circle-of-scarlet',
  'Círculo Escarlate',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '36 m',
  true,
  true,
  true,
  'a piece of parchment with a circle drawn in humanoid blood',
  'V, S, M (a piece of parchment with a circle drawn in humanoid blood)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar quatro Dados de Vida ou a magia falha automaticamente. Um pilar carmesim ergue-se do chão em um Cilindro de 6 metros de raio e 30 metros de altura centrado em um ponto no alcance. Cada criatura no Cilindro faz uma salvaguarda de Constituição.

Em uma falha, a criatura sofre dano Necrótico igual à rolagem dos Dados de Vida gastos na magia mais o seu modificador de atributo de conjuração. Em um sucesso, sofre metade desse dano.

Para cada criatura que falhar na salvaguarda contra esta magia, você ganha 10 PV temporários.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'conjure-plants',
  'Conjurar Plantas',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  'Você conjura plantas animadas que aparecem como uma massa Grande de vinhas, caules, brotos, raízes e folhas em um espaço desocupado que você possa ver no alcance. A vegetação dura pela duração.

Enquanto você estiver a até 1,5 metro das plantas ou compartilhando um espaço com elas, você é considerado em uma área Levemente Obscurecida. Outras criaturas não podem entrar no mesmo espaço das plantas. Quando você se move no seu turno, também pode mover as plantas até 9 metros para um espaço desocupado que possa ver.

Sempre que as plantas se moverem a até 1,5 metro de uma criatura que você possa ver, e sempre que uma criatura que você possa ver entrar em um espaço a até 1,5 metro das plantas ou terminar seu turno ali, você pode forçar essa criatura a fazer uma salvaguarda de Destreza. Em uma falha, a criatura sofre 3d6 de dano Cortante. Uma criatura faz essa salvaguarda apenas uma vez por turno.',
  'O dano aumenta em 1d6 para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'consume-mind',
  'Consumir Mente',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a 1-ounce fresh or magically preserved portion of another creature’s brain',
  'V, S, M (a 1-ounce fresh or magically preserved portion of another creature’s brain)',
  '1 hora',
  false,
  false,
  'Você consome o cérebro de uma criatura morta, obtendo acesso às suas memórias. A criatura deve ter um cérebro e não pode ser Morta-viva. A magia falha se a criatura estiver morta (e não preservada) há mais de 3 dias.

Até a magia terminar, você pode tentar recordar uma memória, como história familiar, eventos recentes, layouts de construções, senhas, detalhes da morte da criatura e informações similares. Para recordar uma memória, você realiza uma ação Mágica e faz um teste de atributo usando o seu modificador de atributo de conjuração. A CD é igual ao valor de Inteligência do cadáver.

Depois de realizar uma ação Mágica para recordar uma informação, você não pode tentar recordar aquele pedaço específico de informação novamente.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'consumption',
  'Consumpção',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  '18 m',
  true,
  true,
  true,
  'a malnourished leech',
  'V, S, M (a malnourished leech)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Escolha uma criatura no alcance e role o Dado de Vida gasto. O alvo sofre dano Necrótico igual ao resultado. No final de cada um dos turnos dela enquanto a magia durar, o alvo faz uma salvaguarda de Constituição. Em uma falha, sofre esse dano novamente. Em um sucesso, a magia termina.',
  'Você pode escolher uma criatura adicional para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'creeping-death',
  'Morte Rastejante',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  false,
  true,
  false,
  NULL,
  'S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar oito Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos. O limiar de Morte Rastejante do alvo é igual ao total da rolagem. Pela duração da magia, se os PV da criatura forem reduzidos a esse limiar ou abaixo dele, a criatura morre imediatamente.

Como Ação Bônus, você pode forçar o alvo a fazer uma salvaguarda de Constituição. Em uma falha, role 2d6 e some o resultado ao limiar de Morte Rastejante da criatura. Em um sucesso, some metade do resultado. Se a criatura obtiver sucesso em três salvaguardas (não precisam ser consecutivas), esta magia termina antecipadamente.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'creeping-touch',
  'Toque Rastejante',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
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
  'Você destaca a própria mão no pulso, transformando-a em uma Aranha. Enquanto a aranha estiver a até 30 metros de você, pode se comunicar telepaticamente com ela. Além disso, como ação Mágica, você pode ver pelos olhos dela e ouvir o que ela ouve até o início do seu próximo turno. Durante esse tempo, você não tem consciência do próprio entorno.

Se a aranha for morta ou não retornar a você antes de a magia terminar, sua mão é restaurada, mas você sofre 1d6 de dano Psíquico. Como Ação Bônus, você pode comandar a aranha a retornar a você. Quando ela chega, se reanexa como sua mão e a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'crimson-lash',
  'Chicote Carmesim',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  '1 minuto',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Um chicote contorcido de sangue coagulado brota da sua mão com as propriedades listadas na fonte.',
  'Se você conjurar esta magia com um espaço de 3º–4º círculo, pode fazer dois ataques com essa arma ao realizar a ação Atacar. Com um espaço de 5º+ círculo, pode fazer três ataques com essa arma ao realizar a ação Atacar.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'crown-of-radiance',
  'Coroa de Radiância',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  '10 minutos',
  false,
  false,
  'Uma coroa flamejante de luz sagrada adorna sua cabeça até a magia terminar. Um Corruptor, Feérico ou Morto-vivo que se mover a até 9 metros de você ou iniciar o turno a até 9 metros de você sofre 2d8 de dano Radiante.

A coroa emite Luz Intensa em um raio de 9 metros e Luz Fraca por mais 9 metros adicionais.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'dark-sacrament',
  'Sacramento Sombrio',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a dagger encrusted in jewels worth 100+ GP',
  'V, S, M (a dagger encrusted in jewels worth 100+ GP)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar quatro Dados de Vida ou a magia falha automaticamente. Faça um ataque mágico corpo a corpo contra uma criatura a até 1,5 metro usando o componente material desta magia. Em um acerto, role os Dados de Vida gastos para conjurar a magia mais 4d8. Você causa dano Necrótico igual ao total da rolagem. Se esse dano reduzir a criatura a 0 PV, ela morre imediatamente e você ganha uma das seguintes bênçãos sombrias à sua escolha. Enquanto tiver uma bênção sombria, ao sofrer dano Radiante você sofre 1d4 de dano Radiante extra.

Inatacável. Você tem Vantagem em todas as salvaguardas.

Inquebrável. Seu tamanho aumenta em uma categoria (de Médio para Grande, por exemplo), você ganha PV temporários iguais ao seu modificador de Constituição (mínimo 1) no início de cada um dos seus turnos, e seus ataques com arma causam 1d4 de dano extra.

Infalível. Seu Bônus de Proficiência aumenta em 2.

Sua bênção sombria termina após 10 minutos ou quando você for reduzido a 0 PV, o que ocorrer primeiro.',
  'O dano inicial aumenta em 1d8 para cada círculo de espaço de magia acima do 4º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'dazing-blast',
  'Rajada Atordoante',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Uma onda de energia deixa suas palmas, visando uma criatura no alcance. O alvo faz uma salvaguarda de Constituição. Em uma falha, a criatura sofre 2d6 de dano Energético e fica com a condição Atordoado até o final do próximo turno dela. Em um sucesso, a criatura sofre apenas o dano.',
  'Uma criatura adicional pode ser escolhida como alvo para cada círculo de espaço de magia acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'earth-worm',
  'Verme Terrestre',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você transforma a terra em uma goela vermiforme em um ponto desocupado no solo no alcance. Como Ação Bônus, faça um ataque mágico corpo a corpo contra uma criatura a até 1,5 metro do verme. Em um acerto, o alvo sofre dano Perfurante igual a 3d8 mais o seu modificador de atributo de conjuração. Se o alvo for uma criatura Grande ou menor, deve obter sucesso em uma salvaguarda de Destreza ou ser engolido pelo verme. Uma criatura engolida fica com as condições Cego e Contido, tem Cobertura Total contra ataques e outros efeitos fora do verme, e sofre 6d6 de dano Contundente no início de cada um dos seus turnos.

Uma criatura presa dentro do verme pode usar uma ação para fazer um teste de Força (Atletismo) contra a sua CD de magia. Em um sucesso, é regurgitada e fica com a condição Caído em um espaço desocupado a até 3 metros do verme.

Como Ação Bônus, você pode mover o verme até 9 metros.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'elemental-exhalation',
  'Exalação Elemental',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  'Instantânea',
  false,
  false,
  'Ao conjurar esta magia, escolha um dos seguintes efeitos que determinam o tipo de dano da magia:

Ar. O tipo de dano é Trovejante. Cada criatura que falhar na salvaguarda é empurrada 3 metros para longe de você.

Coldfire. O tipo de dano é Gélido. Cada criatura que falhar na salvaguarda fica com a condição Amedrontado até o início do seu próximo turno.

Terra. O tipo de dano é Contundente. Cada criatura que falhar na salvaguarda tem seu Deslocamento reduzido a 0 até o fim do seu próximo turno.

Fogo. O tipo de dano é Ígneo. Cada criatura que falhar na salvaguarda fica envolta em chamas e sofre 2d6 de dano Ígneo no fim do seu próximo turno. Como ação, ela pode extinguir o fogo em si mesma ao se dar a condição Caído e rolar no chão. O fogo também se apaga se for abafado, submerso ou sufocado.

Água. O tipo de dano é Ácido. Cada criatura que falhar na salvaguarda fica com a condição Caído.

Cada criatura em um Cone de 9 metros de energia elemental destrutiva deve fazer uma salvaguarda de Destreza. Em uma falha, um alvo sofre 5d6 de dano do tipo escolhido. Em um sucesso, o alvo sofre apenas metade desse dano.',
  'O dano aumenta em 1d6 para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'emmelines-essence-infusion',
  'Infusão de Essência de Emmeline',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '8 horas',
  'Toque',
  true,
  true,
  true,
  'a diamond vial containing at least one ounce of blood worth at least 100 GP, which this spell consumes',
  'V, S, M (a diamond vial containing at least one ounce of blood worth at least 100 GP, which this spell consumes)',
  'Special',
  false,
  false,
  'Ao conjurar esta magia, você escolhe uma arma não mágica no alcance. Essa arma se torna mágica e ganha um benefício especial baseado no tipo de criatura do sangue usado como componente Material desta magia. O item exige Sintonia, e apenas a criatura sintonizada com esta arma obtém esses benefícios.

Aberração. Seus ataques com armas causam 1d6 de dano Psíquico extra em um acerto. Além disso, você pode falar telepaticamente com qualquer criatura que tenha sofrido pelo menos 1 ponto de dano desta arma nas últimas 24 horas, desde que ambos estejam no mesmo plano.

Celestial. Seus ataques com armas causam 1d6 de dano Radiante extra em um acerto. Além disso, você pode usar uma Ação Bônus para fazer a arma emanar Luz Brilhante em um raio de 9 metros e Luz Fraca por mais 9 metros. Você pode encerrar esse efeito usando outra Ação Bônus.

Dragão. Suas jogadas de ataque com esta arma podem marcar um Acerto Crítico com uma rolagem de 19 ou 20 no d20. Além disso, você tem Vantagem em salvaguardas que fizer para evitar ou encerrar a condição Amedrontado.

Feérico. Seus ataques com armas causam 1d4 de dano Energético extra em um acerto. Além disso, uma vez por turno, quando você acertar uma criatura a até 9 metros com esta arma, você pode se teleportar para um espaço desocupado que possa ver a até 1,5 metro dela.

Corruptor. Seus ataques com armas causam 1d6 de dano Necrótico extra em um acerto. Você pode usar uma Ação Bônus para mudar esse dano extra para Gélido ou Ígneo.

Ao conjurar esta magia, você se sintoniza com a arma mágica. A duração da magia dura enquanto você tiver Sintonia com a arma. Durante a duração da magia, o item mágico é suscetível à magia Dissipar Magia. Se você mantiver Sintonia com a arma mágica por 1 ano, o encantamento se torna permanente e esta magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'enspelled-armament',
  'Armamento Encantado',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  false,
  true,
  'a vial of oil and water',
  'M (a vial of oil and water)',
  '1 hora',
  false,
  false,
  'Ao conjurar esta magia, escolha uma arma Simples ou Marcial. Uma réplica da arma escolhida, feita de energia iridescente, aparece em suas mãos. Pela duração, você tem proficiência com essa arma e, sempre que atacar com ela, pode usar o seu modificador de atributo de conjuração nas jogadas de ataque e de dano em vez de Força ou Destreza. Ataques feitos com esta arma não exigem munição e, se você arremessar a arma como parte de um ataque à distância, ela retorna à sua mão imediatamente após a resolução do ataque. O dano causado por esta arma é Energético em vez do tipo de dano normal da arma.',
  'O dano da arma aumenta em 1d4 para cada círculo de espaço de magia acima do 2º. Se você conjurar a magia com um espaço de 5º círculo ou superior, a duração se torna 8 horas.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'extract-iron',
  'Extrair Ferro',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '1 minuto',
  'Pessoal',
  true,
  true,
  true,
  'a rusty knife',
  'V, S, M (a rusty knife)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar três Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos e extraia do seu sangue uma quantidade de quilos de ferro igual ao total da rolagem.

Você molda esse ferro em objetos metálicos não mágicos. O peso combinado desses objetos deve ser igual ou inferior ao número rolado nos Dados de Vida gastos. A qualidade desses objetos é pobre, mas funcional.',
  'Você pode gastar um Dado de Vida adicional e criar ferro extra para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'fiend-flesh',
  'Carne de Corruptor',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a handful of sulfur',
  'V, S, M (a handful of sulfur)',
  'Concentração, até 1 hora',
  true,
  false,
  'Você toca uma criatura voluntária, transformando a pele dela em escamas vermelhas. Até a magia terminar, o alvo tem Resistência a dano Gélido, Ígneo e Elétrico, e também tem Imunidade a dano Venenoso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'flash-fever',
  'Febre Relâmpago',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'flint and steel',
  'V, S, M (flint and steel)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Escolha uma criatura que você possa ver no alcance. A criatura entra em suor frio e faz uma salvaguarda de Constituição. Em uma falha, o suor frio se torna uma febre abrasadora e a criatura sofre 4d6 de dano Ígneo. Em um sucesso, a magia termina.

Pela duração, no início do turno do alvo, ele sofre 2d6 de dano Ígneo. O alvo deve repetir a salvaguarda no fim de cada um dos seus turnos até obter três sucessos ou falhas. Se o alvo obtiver sucesso em três dessas salvaguardas, a magia termina. Se o alvo falhar em três das salvaguardas, sofre 8d6 de dano Ígneo e a magia termina.',
  'O dano inicial aumenta em 1d6 para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'flense',
  'Esfolamento',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a scalpel',
  'V, S, M (a scalpel)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você mira uma criatura que possa ver no alcance, usando força necromântica para fatiar a pele de seu corpo. Faça um ataque mágico à distância contra essa criatura. Em um acerto, o alvo sofre 8d6 de dano Necrótico.

Em cada um dos seus turnos subsequentes até a magia terminar, você pode usar uma ação Mágica para forçar o mesmo alvo a fazer uma salvaguarda de Constituição, mesmo que o primeiro ataque tenha errado. Em uma falha, o alvo sofre 8d6 de dano Necrótico. Em um sucesso, sofre metade desse dano.

A magia termina se o alvo estiver fora do alcance da magia, se for reduzido a 0 PV ou se você não puder vê-lo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'fleshcrawl',
  'Carne Rastejante',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '30 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você arranca a carne de uma criatura, moldando-a em uma monstruosidade retorcida de sangue e pele que se ergue para atacar a criatura.

Uma criatura que você possa ver no alcance faz uma salvaguarda de Constituição. Em uma falha, a criatura sofre 8d10 de dano Necrótico. A pele esfolada da criatura é animada como uma paródia grotesca. Ela usa o bloco de estatísticas Construto Fleshling. Em um sucesso, sofre apenas metade desse dano.

A criatura é aliada sua e de seus aliados. Em combate, a criatura compartilha a sua contagem de Iniciativa, mas age imediatamente após o seu turno. Ela obedece a seus comandos verbais (nenhuma ação necessária da sua parte). Se você não der nenhum comando, ela executa a ação Esquivar e usa seu movimento para evitar perigo. O fleshling desaparece quando chega a 0 PV ou quando a magia termina.',
  'Use o círculo do espaço de magia como o nível da magia no bloco de estatísticas. Construto Médio, Sem Alinhamento CA 11 + o nível da magia PV 70 + 10 para cada círculo de magia acima do 7º Deslocamento 9 m Resistências Psíquico Imunidades Veneno; Enfeitiçado, Exaustão, Amedrontado, Paralisado, Envenenado Sentidos Visão no Escuro 18 m, Percepção Passiva 12 Idiomas Compreende os idiomas conhecidos pelo alvo Desafio Nenhum (XP 0; BP igual ao seu Bônus de Proficiência) Ações Estrangular. Jogada de Ataque Corpo a Corpo: bônus igual ao seu modificador de ataque mágico, alcance 1,5 m. Acerto: 2d8 + o nível da magia de dano Contundente, e o alvo fica com a condição Agarrado (CD de escape igual à sua CD de magia) e não pode falar. Até o agarrão terminar, o alvo fica com a condição Contido e está sufocando. Constranger. O construto fleshling constrange um alvo que esteja agarrando, causando 2d8 + o nível da magia de dano Contundente.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'frightful-start',
  'Susto Aterrador',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a dead spider',
  'V, S, M (a dead spider)',
  '1 round',
  false,
  false,
  'Você distorce o próprio rosto para assustar uma criatura que possa ver no alcance. A criatura deve obter sucesso em uma salvaguarda de Sabedoria ou fica com a condição Amedrontado até o início do seu próximo turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'ghost-light',
  'Luz Fantasma',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a clear marble',
  'V, S, M (a clear marble)',
  '1 hora',
  false,
  false,
  'Você toca um objeto que não seja maior que 3 metros em qualquer dimensão e especifica qualquer número de criaturas que possa ver a até 3 metros. Até a magia terminar, o objeto emite Luz Plena prateada em um raio de 6 metros e Meia-luz por mais 6 metros. Essa luz só é visível às criaturas que você especificou durante a conjuração da magia; todas as demais criaturas percebem a área afetada pela luz como fariam normalmente.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'greater-animate-dead',
  'Animar Mortos Superior',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 minuto',
  '3 m',
  true,
  true,
  true,
  'a drop of blood, a piece of flesh, a pinch of bone dust, and a black onyx stone worth 75+ GP for each level of CR you animate',
  'V, S, M (a drop of blood, a piece of flesh, a pinch of bone dust, and a black onyx stone worth 75+ GP for each level of CR you animate).',
  'Instantânea',
  false,
  false,
  'Escolha um número de cadáveres no alcance. Você pode reanimar até 5 criaturas Mortas-vivas de Nível de Desafio 2 ou inferior a partir desses cadáveres.

Em cada um dos seus turnos, você pode usar uma Ação Bônus para comandar mentalmente qualquer criatura que tenha criado com esta magia se ela estiver a até 36 metros de você (se controlar várias criaturas, pode comandar qualquer uma ou todas ao mesmo tempo, emitindo o mesmo comando a cada uma). Você decide qual ação a criatura realizará e para onde se moverá durante o próximo turno dela, ou pode emitir um comando geral, como guardar determinado aposento ou corredor. Se não emitir comandos, a criatura apenas se defende contra criaturas hostis. Uma vez dada uma ordem, a criatura continua a segui-la até a tarefa estar concluída. A criatura fica sob seu controle por 24 horas, após o que deixa de obedecer a qualquer comando que você tenha dado.

Para manter o controle da criatura por mais 24 horas, você deve conjurar esta magia novamente sobre a criatura antes que o período atual de 24 horas termine. Esse uso da magia reafirma seu controle sobre até quatro criaturas que você tenha animado com esta magia, em vez de animar uma nova criatura. Além disso, conjurar a magia dessa forma não exige componentes materiais com custo em PO.',
  'Você pode animar uma criatura Morta-viva adicional para cada círculo de espaço de magia acima do 5º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'heartseeker',
  'Caçador de Corações',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '90 m',
  true,
  true,
  true,
  'a ruby worth 100+ GP',
  'V, S, M (a ruby worth 100+ GP)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar seis Dados de Vida ou a magia falha automaticamente. Sangue flui do seu corpo e se cristaliza em uma flecha farpada, que é lançada contra uma criatura. Faça um ataque mágico à distância contra um alvo no alcance. Em um acerto, role os Dados de Vida gastos para conjurar a magia; a criatura sofre dano Perfurante igual ao total rolado.

Uma vez alojada na criatura, a flecha sangrenta começa a se enterrar em direção ao coração, tornando-a suscetível a ferimentos. Até a magia terminar, o primeiro ataque bem-sucedido contra a criatura após o fim do turno dela a cada rodada é automaticamente um Acerto Crítico.

O alvo faz uma salvaguarda de Constituição no final de cada um dos seus turnos. Em uma falha, o efeito continua. Em um sucesso, a criatura sofre 3d8 de dano Necrótico e a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'holy-word',
  'Palavra Sagrada',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Você sussurra uma palavra divina sob a respiração, com cuidado para não falar alto, pois tal poder celestial não é para os indignos. Faça um ataque mágico à distância contra um alvo no alcance. Em um acerto, o alvo sofre 1d8 de dano Radiante. Se o alvo for Feérico, Corruptor ou Morto-vivo, o Deslocamento dele é reduzido em 3 metros e ele não pode usar Reações até o final do próximo turno dele.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'hunter-sense',
  'Sentido do Caçador',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você toca uma criatura voluntária. Pela duração, os sentidos do alvo são aguçados. Sempre que o alvo fizer um teste de Sabedoria (Percepção), pode tratar uma rolagem de d20 de 9 ou menos como 10.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'illusory-instrument',
  'Instrumento Ilusório',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  '10 minutos',
  false,
  false,
  'Você cria uma cópia ilusória de um instrumento musical mundano. A cópia do instrumento assume a forma da sua memória mais querida daquele instrumento, como a primeira flauta que você possuiu ou a meia-harpa presenteada por um ente querido. Esta ilusão se move como faria a contraparte física, mas não tem peso e é tangível apenas para você. Este instrumento pode ser usado como Foco de Conjuração. Este instrumento ilusório se dissipa se você se afastar 3 metros dele ou escolher encerrar a magia (sem exigir ação).

Como Ação Bônus, você pode comandar seu instrumento a criar um dos seguintes efeitos:',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'incite-riot',
  'Incitar Motim',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a red handkerchief',
  'V, S, M (a red handkerchief)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Ao conjurar esta magia, você agita o lenço vermelho usado como componente Material e escolhe qualquer número de criaturas no alcance que possam vê-lo. Cada criatura escolhida faz uma salvaguarda de Sabedoria. Ela o faz com Vantagem se você ou seus aliados estiverem combatendo-a. Em uma falha, o alvo fica com a condição Enfeitiçado até a magia terminar ou até você ou seus aliados causarem dano a ele. A criatura Enfeitiçada é Amigável a você e a seus aliados. Enquanto Enfeitiçada, deve usar sua ação para fazer ataques corpo a corpo contra a criatura mais próxima (exceto você ou seus aliados) ou usar o turno para se mover em direção ao alvo mais próximo.

No final de cada um dos seus turnos, o alvo repete a salvaguarda, encerrando a magia em si mesmo em um sucesso.

As autoridades estavam prestes a capturá-la, então de repente todos no bar enlouqueceram e começaram a brigar.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'intaglio',
  'Intálio',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Action or Ritual',
  'Toque',
  true,
  true,
  true,
  'a quill or a vial of ink',
  'V, S, M (a quill or a vial of ink)',
  'Concentração, até 1 hora',
  true,
  false,
  'Você cria uma duplicata de um texto ou imagem. Durante a duração da magia, você pode usar uma ação Mágica para passar a mão sobre qualquer texto ou imagem não mágica em uma superfície no alcance. Você copia o texto ou a imagem para um novo suporte que fornecer, como outro livro ou pergaminho. Esta magia copia uma única página com cada ação Mágica. Ao copiar um grimório, você pode fazê-lo pelo mesmo método usado para substituir um grimório, exceto que os requisitos de tempo e de PO são ambos reduzidos pela metade.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'investiture-of-venom',
  'Investidura de Veneno',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
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
  'Até a magia terminar, suas veias incham e ficam visivelmente verdes sob a pele, seus olhos choram constantemente com veneno líquido, e você ganha os seguintes benefícios:',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'lifesink',
  'Sorvedouro de Vida',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'Uma aura se estende de você em uma Emanação de 4,5 metros pela duração. Qualquer outra criatura que entrar ou iniciar o turno na área sofre 4d6 de dano Necrótico. No início do seu turno, você recupera 4d6 PV mais 1 por cada criatura na área.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'life-tether',
  'Amarra Vital',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '36 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto.',
  true,
  false,
  'Escolha uma criatura que possa ver no alcance. O alvo deve fazer uma salvaguarda de Sabedoria. Em uma falha, uma amarra esverdeada doentia se forma entre você e o alvo. Sempre que você sofrer dano, o alvo amarrado sofre metade desse dano (arredondado para baixo) como dano Necrótico. Se o alvo cair a 0 PV antes de esta magia terminar, você pode usar uma Ação Bônus para mover a amarra para uma nova criatura que possa ver no alcance. O novo alvo deve obter sucesso em uma salvaguarda de Sabedoria ou fica amarrado.',
  'Você pode criar amarras adicionais com um espaço de 4º círculo (duas amarras), 6º (três amarras) ou 8º (quatro amarras).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'little-death',
  'Pequena Morte',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  false,
  true,
  true,
  'an item of personal sentimental value worth 1+ SP',
  'S, M (an item of personal sentimental value worth 1+ SP)',
  'Up to 8 horas',
  false,
  false,
  'Ao conjurar esta magia, você cai a 0 PV e morre. No início do seu próximo turno, você se torna um Fantasma ocupando o mesmo espaço do seu cadáver. Suas estatísticas de jogo são substituídas pelo bloco de estatísticas do Fantasma, mas você mantém seus PV; Dados de Vida; valores de Inteligência, Sabedoria e Carisma; e idiomas.

Enquanto for um Fantasma, você só pode usar as habilidades detalhadas no bloco de estatísticas do Fantasma. Além disso, soma o seu Bônus de Proficiência às suas jogadas de ataque e à CD das suas habilidades de Fantasma.

Seu Mestre rola secretamente 1d8 quando você conjura a magia. Após um número de horas igual ao número rolado, a magia termina. A magia termina antecipadamente se você for reduzido a 0 PV como Fantasma ou se usar a ação Mágica para encerrar a magia. Se o componente Material usado para conjurar esta magia permanecer no seu cadáver, você retorna à vida com um número de PV igual à metade do seu máximo de PV. Se o componente Material usado para conjurar esta magia não estiver mais no seu cadáver, você morre.

Se o seu corpo for destruído ou danificado além da capacidade de sobrevivência enquanto você estiver sob os efeitos desta magia, a duração se torna permanente. Você é agora um Fantasma até que seu corpo seja alvo de um efeito que devolva os vivos aos mortos, como Reviver os Mortos ou Ressurreição.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'maelfas-quickened-class',
  'Aula Acelerada de Maelfa',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '10 minutos',
  '9 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  '24 horas',
  false,
  false,
  'Ao conjurar esta magia, você dá uma aula abreviada sobre um tópico à sua escolha a 10 criaturas voluntárias à sua escolha no alcance. Ao fazê-lo, escolha uma magia que você conheça ou tenha preparada, uma perícia na qual seja proficiente, ou um idioma que você possa falar, ler e escrever. Cada criatura escolhida recebe temporariamente uma parcela do seu conhecimento.

Se você escolheu uma magia, cada criatura prepara a magia, a magia é considerada na lista de magias da criatura e não conta contra o número de magias preparadas da criatura. Se você escolheu uma perícia, cada criatura alvo ganha proficiência naquela perícia. Se você escolheu um idioma, cada criatura alvo pode falar, ler e escrever aquele idioma.

A criatura perde o conhecimento da magia, a proficiência ou o idioma quando esta magia termina. Se uma criatura for alvo desta magia enquanto estiver sob o efeito de uma conjuração anterior da magia, a conjuração anterior termina imediatamente.',
  'A duração da magia aumenta com um espaço de 3º ou 4º círculo (3 dias), 5º ou 6º (10 dias), 7º ou 8º (30 dias) ou 9º (1 ano).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'magic-mirror',
  'Espelho Mágico',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação , que você executa quando you are targeted by a spell',
  'Pessoal',
  true,
  true,
  true,
  'a polished silver marble',
  'V, S, M (a polished silver marble)',
  'Instantânea',
  false,
  false,
  'Uma bolha momentânea de energia iridescente cintila no ar entre você e um inimigo. A magia desencadeadora é redirecionada para uma criatura à sua escolha que você possa ver a até 18 metros. Se a magia for de 5º círculo ou inferior, você deixa de ser alvo da magia e a criatura escolhida passa a sê-lo. Se a magia for de 6º círculo ou superior, faça um teste de atributo usando o seu atributo de conjuração (CD 10 mais o círculo da magia). Em um sucesso, você deixa de ser alvo da magia e a criatura escolhida passa a sê-lo. Em uma falha, você permanece o alvo da magia desencadeadora.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'melting-curse',
  'Maldição Derretente',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '30 m',
  true,
  true,
  true,
  'a vial of quicksilver',
  'V, S, M (a vial of quicksilver)',
  '1 minuto',
  false,
  false,
  'Você mira uma criatura e um objeto de metal empunhado ou vestido por essa criatura que você possa ver no alcance. A criatura faz uma salvaguarda de Destreza. Em uma falha, a criatura sofre 5d8 de dano Ígneo e o objeto mirado derrete e escorre ao chão, onde retorna à forma e temperatura normais. Se o objeto for mágico, a criatura tem Vantagem na salvaguarda.

Se a criatura tentar recuperar ou de outro modo tocar o objeto pela duração, o objeto aquece e derrete, e a criatura sofre 5d8 de dano Ígneo. O objeto volta ao normal assim que a criatura deixar de tocá-lo ou a magia terminar.',
  'O dano aumenta em 1d8 para cada círculo de espaço de magia acima do 6º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'mirror-spell',
  'Espelhar Magia',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação , que você executa quando you see a creature within 60 feet of you casting a spell',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'Você tenta copiar e conjurar uma magia de 3º círculo ou inferior que possa ver sendo conjurada. Você só pode copiar magias conjuradas por criaturas, e não pode copiar a sua própria magia.

Se a magia desencadeadora for de 2º círculo ou inferior, você copia e conjura a magia automaticamente. Se a magia for de 3º círculo ou superior, você deve obter sucesso em um teste de atributo usando o seu atributo de conjuração (CD 10 mais o círculo da magia desencadeadora) para copiar e conjurar a magia.

Ao conjurar uma magia copiada, você não gasta um espaço de magia e não precisa de nenhum componente. Trate a magia como se você fosse o conjurador original, usando o seu próprio modificador de atributo de conjuração e CD de salvaguarda, e conjurando-a no círculo mais baixo em que possa ser conjurada.',
  'Trate o círculo do espaço de magia usado como o círculo máximo da magia que você pode copiar e conjurar.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'mortality',
  'Mortalidade',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '36 m',
  true,
  true,
  true,
  'the skull of a humanoid encrusted in gems worth 200+ GP',
  'V, S, M (the skull of a humanoid encrusted in gems worth 200+ GP)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar cinco Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos e escolha uma Aberração, Celestial, Elemental, Feérico ou Corruptor no alcance, condenando-a a um gosto de mortalidade. A criatura deve obter sucesso em uma salvaguarda de Carisma ou seu máximo de PV e PV atuais são reduzidos pelo valor rolado nos Dados de Vida gastos para conjurar a magia.

Pela duração, uma criatura que falhar na salvaguarda perde todas as Imunidades e Resistências a dano, seu tipo de criatura muda para Humanoides e ela sofre 1d4 de dano Necrótico adicional sempre que sofrer dano.

Se uma criatura afetada por esta magia for reduzida a 0 PV, essas mudanças se tornam permanentes e a criatura morre. Esse efeito final só pode ser revertido se a criatura for restaurada à vida e alvo de Remover Maldição ou magia similar.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'neutralize-aura',
  'Neutralizar Aura',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  '1 minuto',
  'Toque',
  true,
  true,
  true,
  'a sprig of sage',
  'V, S, M (a sprig of sage)',
  'Concentração, até 1 hora',
  true,
  false,
  'Você toca uma criatura voluntária e neutraliza a aura dela. Até a magia terminar, o alvo não pode ser percebido por Feéricos, Corruptores, Celestiais e Mortos-vivos.

A magia termina antecipadamente imediatamente após o alvo fazer uma jogada de ataque, causar dano, conjurar uma magia ou se mover a até 1,5 metro de uma das criaturas desses tipos.',
  'Você pode escolher uma criatura adicional como alvo para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'overgrow',
  'Sobrecrescimento',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a single seed',
  'V, S, M (a single seed)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Ao conjurar esta magia, escolha uma criatura ou um objeto no alcance que seja Enorme ou menor e que não esteja sendo usado ou carregado. Vinhas vibrantes crescem rapidamente em torno do alvo, prendendo-o no lugar e facilitando a travessia.

Se o alvo for uma criatura, ela deve obter sucesso em uma salvaguarda de Força ou fica com a condição Contido até a magia terminar. A criatura pode repetir a salvaguarda no final de cada um dos seus turnos, encerrando a condição Contido em um sucesso.

Se o alvo for um objeto, ele não pode ser movido da localização atual e criaturas que escalem o objeto não gastam movimento extra. Uma criatura pode fazer um teste de Força (Atletismo) contra a sua CD de magia para arrancar o objeto das vinhas a fim de movê-lo. Se o objeto for pesado demais para a criatura mover, esta ação falha.',
  'Você pode escolher um alvo adicional para cada círculo de espaço de magia acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'perfection',
  'Perfeição',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  '18 m',
  true,
  false,
  false,
  NULL,
  'V',
  '1 minuto',
  false,
  false,
  'Você pronuncia uma palavra sagrada e refaz uma criatura que possa ver à imagem dos Arqui-Serafins. A condição Envenenado na criatura termina, maldições no alvo são suprimidas pela duração da magia, e ela é restaurada ao seu máximo de PV. Os valores de atributo da criatura inferiores a 18 tornam-se 18. Conforme a palavra que usar, você também abençoa o alvo segundo o Arqui-Serafim que invocar:

Aphaelon: O alvo tem Imunidade à condição Enfeitiçado. Se o alvo falhar em uma salvaguarda, pode usar uma Reação para fazer com que a salvaguarda seja rerrolada. Deve usar a nova rolagem.

Empyreus: O alvo tem Imunidade à condição Amedrontado, e causa 4d6 de dano Energético extra ao primeiro alvo que acertar em cada um dos seus turnos.

Miklas: O alvo tem Imunidade a dano de Veneno e à condição Envenenado, e recupera 4d6 PV no início de cada um dos seus turnos.

Morael: O alvo ganha 30 PV temporários. Quando um aliado a até 18 metros do alvo sofrer dano, o alvo pode usar uma Reação para sofrer o dano no lugar.

Solyma: O alvo tem Imunidade a dano Trovejante. Quando o alvo sofrer dano de uma criatura que possa ver, pode usar uma Reação para causar dano Ígneo a essa criatura igual ao dano desencadeador.

Zabriel: O alvo ganha Visão Verdadeira com alcance de 18 metros. No final de cada um dos seus turnos, o alvo pode conceder Inspiração Heroica a um aliado que não a tenha.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'phoenix-flames',
  'Chamas da Fênix',
  9,
  '9º círculo',
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
  'Você se imola, consumindo o próprio corpo em uma nuvem abrasadora de chamas sagradas. Você é reduzido a 0 PV e morre, e radiância flamejante irrompe de você em uma Emanação de 9 metros. Cada criatura na área deve fazer uma salvaguarda de Constituição. Em uma falha, a criatura sofre 30d6 de dano Radiante e ganha 1 nível de Exaustão. Em um sucesso, sofre apenas metade desse dano. Se esse dano reduzir uma criatura a 0 PV, ela e tudo que estiver vestindo e carregando que não seja mágico são incinerados. O alvo só pode ser revivido por Ressurreição Verdadeira ou Desejo.

Após 10 minutos, você se ergue das cinzas onde originalmente conjurou a magia. Você retorna à vida como se fosse alvo de uma magia de Ressurreição Verdadeira.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'power-word-maim',
  'Palavra de Poder: Estropiar',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '18 m',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Você ordena que o corpo de uma criatura se contorça e se deforme. Se o alvo tiver 125 PV ou menos, sofre 8d10 de dano Necrótico e fica com a condição Caído. Caso contrário, seu Deslocamento é 0 até o início do seu próximo turno. O alvo faz uma salvaguarda de Constituição no final de cada um dos seus turnos, encerrando a condição em um sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'preserve',
  'Preservar',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a sack containing a pinch of salt',
  'V, S, M (a sack containing a pinch of salt)',
  '12 horas',
  false,
  false,
  'Alimentos e outros itens perecíveis com peso de 2,5 quilogramas ou menos que você colocar em um saco não envelhecem nem apodrecem pela duração.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'primordial-power',
  'Poder Primordial',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a handful of clay',
  'V, S, M (a handful of clay)',
  'Concentração, até 1 hora',
  true,
  false,
  'Ao conjurar esta magia, conceda a uma criatura no alcance uma parcela do poder dos elementais. Pela duração, a criatura pode falar e compreender Primordial e ganha benefícios adicionais baseados no elemento que você escolher ao conjurar a magia:

Ar. O alvo tem Resistência a dano Elétrico e Trovejante. Além disso, tem deslocamento de Voo de 9 metros.

Coldfire. O alvo tem Resistência a dano Gélido. Além disso, pode usar uma Ação Bônus para gastar um Dado de Vida, recuperando um número de PV igual ao número rolado mais o seu modificador de Constituição. Quando o alvo sofre dano Ígneo, não pode usar essa Ação Bônus no seu próximo turno.

Terra. O alvo tem Vantagem em salvaguardas contra ser movido ou derrubado Caído. Além disso, tem Sentido Sísmico com alcance de 9 metros.

Fogo. O alvo tem Resistência a dano Ígneo. Além disso, quando o alvo sofre dano de uma criatura a até 1,5 metro dele, pode realizar uma Reação para fazer um ataque corpo a corpo contra essa criatura, usando uma arma ou um Ataque Desarmado.

Água. O alvo tem Resistência a dano de Ácido. Além disso, pode respirar debaixo d’água e tem deslocamento de Natação de 18 metros.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'reanimate',
  'Reanimar',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a mélange of wilted daisies and other herbal powders worth 300+ GP, which this spell consumes',
  'V, S, M (a mélange of wilted daisies and other herbal powders worth 300+ GP, which this spell consumes)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar três Dados de Vida ou a magia falha automaticamente. Você toca uma criatura que tenha morrido nos últimos 10 minutos e a devolve à vida com 1 PV. Além disso, role os Dados de Vida gastos para conjurar a magia; a criatura ganha PV temporários iguais à rolagem.

No início de cada turno do alvo, ele perde 1 PV temporário concedido por esta magia. Enquanto a criatura tiver PV temporários concedidos por esta magia, move-se com vigor antinatural, ganhando +2 em Testes de D20. Ao perder os PV temporários concedidos por esta magia, a criatura ganha 1 nível de Exaustão.

Esta magia não pode reviver uma criatura que tenha morrido de velhice, nem restaura partes do corpo ausentes.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'red-rain',
  'Chuva Vermelha',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  '10 minutos',
  'Pessoal',
  true,
  true,
  true,
  'a sponge soaked in blood',
  'V, S, M (a sponge soaked in blood)',
  'Concentração, até 8 horas',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar oito Dados de Vida ou a magia falha automaticamente. Ao longo de 1d6 × 5 minutos, o céu escurece e gotas espessas de sangue chovem em toda parte a até 8 quilômetros de você.

Cada Fera e Planta na área deve obter sucesso em uma salvaguarda de Sabedoria ou fica com a condição Amedrontado até ter passado 1 minuto fora da área. Plantas mundanas expostas à chuva murcham e morrem após 10 minutos.

A cada 10 minutos em que uma criatura de qualquer tipo ficar diretamente exposta à chuva, ela ganha 1 nível de Exaustão e sofre 2d10 de dano Necrótico. O máximo de PV da criatura diminui em valor igual ao dano Necrótico causado. Essa redução dura até a criatura remover todos os níveis de Exaustão ganhos com esta magia. Enquanto a criatura tiver qualquer nível de Exaustão desta magia, ela falha automaticamente em salvaguardas para remover a condição Envenenado.

Quando a magia termina, role os Dados de Vida gastos para conjurá-la. Feras e Plantas não retornam e plantas não voltam a crescer na área por um número de dias igual ao total da rolagem.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'ride-the-lightning',
  'Cavalgar o Relâmpago',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a length of copper wire',
  'V, S, M (a length of copper wire)',
  'Instantânea',
  false,
  false,
  'Você se transforma em um raio, criando uma Linha de 1,5 metro de largura entre o seu espaço atual e um espaço desocupado a até 18 metros de você. Cada criatura na Linha faz uma salvaguarda de Destreza, sofrendo 4d6 de dano Elétrico em uma falha ou metade desse dano em um sucesso. Você então reaparece no espaço escolhido.',
  'O dano aumenta em 1d6 para cada círculo de espaço de magia acima do 4º. Além disso, o comprimento máximo da linha aumenta 3 metros para cada círculo de espaço de magia acima do 4º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sanguine-fusillade',
  'Fuzilaria Sanguínea',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a needle dipped in your blood',
  'V, S, M (a needle dipped in your blood)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Você cristaliza o sangue do inimigo em dardos afiados que explodem para atingir seus inimigos. Ao conjurar esta magia, você deve gastar sete Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos. Escolha uma criatura que possa ver no alcance. O alvo sofre dano Perfurante igual à rolagem. Quando uma criatura sofre esse dano, sete dardos carmesins saltam dela.

Você pode direcionar cada dardo para atingir uma criatura a até 18 metros do alvo original. Os dardos atingem simultaneamente, e você pode direcioná-los a uma ou várias criaturas, incluindo o alvo original. Para cada dardo, faça um ataque mágico à distância contra a criatura escolhida. Em um acerto, role um dos Dados de Vida gastos para conjurar a magia; a criatura sofre dano Perfurante igual ao número rolado.',
  'Você pode gastar um Dado de Vida adicional e criar outro dardo para cada círculo de espaço de magia acima do 7º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sanguine-poppet',
  'Boneco Sanguíneo',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '1 minuto',
  'Toque',
  true,
  true,
  true,
  'an object shaped like a creature worth 1+ CP',
  'V, S, M (an object shaped like a creature worth 1+ CP)',
  'Concentração, até 1 hora',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar três Dados de Vida ou a magia falha automaticamente. Você unta o componente material da magia com seu sangue. O objeto estremece e se torna um boneco sob seu controle.

A CA do boneco é igual a 10 mais o seu Bônus de Proficiência e o seu modificador de atributo de conjuração, e ele tem 30 PV. Se o boneco for reduzido a 0 PV ou estiver a mais de 1,5 quilômetro de você, a magia termina imediatamente. Como Ação Bônus, você pode comandar o boneco a se mover 9 metros, e pode ver e ouvir através dele até o início do seu próximo turno.

Como ação Mágica, você pode fazer o boneco detonar em uma explosão de sangue, encerrando esta magia. Role os Dados de Vida gastos para conjurá-la. Cada criatura em uma Esfera de 9 metros de raio centrada no boneco faz uma salvaguarda de Destreza, sofrendo dano Necrótico igual à rolagem em uma falha ou metade desse dano em um sucesso.',
  'Você pode gastar um Dado de Vida adicional para cada círculo de espaço de magia acima do 3º. Além disso, a duração desta magia aumenta em 1 hora para cada círculo de espaço acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sanguine-shield',
  'Escudo Sanguíneo',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar dois Dados de Vida ou a magia falha automaticamente. Você drena a força vital dos feridos ao redor para criar um escudo rodopiante de sangue. Você ganha 5 PV temporários para cada criatura a até 9 metros de você que esteja abaixo do seu máximo de PV (incluindo você), até um máximo de 15 PV temporários. Enquanto tiver PV temporários desta magia, você tem Cobertura Parcial. Quando a magia termina, todos os PV temporários dela são perdidos.',
  'O máximo de PV temporários que você ganha aumenta em 5 para cada dois círculos de espaço de magia acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'seal-spellcasting',
  'Selar Conjuração',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'wax mixed with lead and a stamp',
  'V, S, M (wax mixed with lead and a stamp)',
  'Concentração, até 10 minutos',
  true,
  false,
  'Ao conjurar esta magia, escolha uma criatura que possa ver no alcance. Quando o alvo conjurar uma magia, deve fazer uma salvaguarda de Carisma. Em uma falha, a criatura gasta um espaço de magia para conjurar a magia normalmente, mas a magia não tem efeito. Em um sucesso, a criatura conjura a magia, mas sofre 3d8 de dano Energético. Após a criatura fazer a salvaguarda, esta magia termina imediatamente.',
  'O dano aumenta em 1d8 para cada círculo de espaço de magia acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sense-lifeblood',
  'Sentir Sangue Vital',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar dois Dados de Vida ou a magia falha automaticamente. O sangue vital nas criaturas revela seus segredos. Criaturas com Imunidade à condição Exaustão são imunes a esta magia. Até a magia terminar, você pode determinar se criaturas que possa ver são biologicamente aparentadas. Além disso, você sabe se os PV de uma criatura estão no máximo, abaixo do máximo, na metade ou abaixo da metade.

Uma vez em cada um dos seus turnos, quando acertar uma criatura Sangrenta com uma jogada de ataque usando arma, Ataque Desarmado ou magia, pode fazer o alvo sofrer dano Necrótico extra. Para determinar esse dano, role os Dados de Vida gastos para conjurar a magia.',
  'Sua Concentração pode durar mais com um espaço de 3º–4º círculo (até 1 hora) ou 5º+ (até 8 horas).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'serpent-tongue',
  'Língua de Serpente',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
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
  'Você transforma sua língua em uma serpente venenosa pela duração. Como Ação Bônus, você pode fazer um ataque mágico corpo a corpo contra uma criatura a até 3 metros de você. Em um acerto, o alvo sofre 1d12 de dano Perfurante e fica com a condição Envenenado pela duração da magia.',
  'O dano aumenta em 1d12 para cada círculo de espaço de magia acima do 3º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'shared-judgement',
  'Julgamento Compartilhado',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentração, até 1 minuto',
  true,
  false,
  'Uma vez em cada um dos seus turnos, quando você reduzir um Morto-vivo a 0 PV, pode causar 5d6 de dano Radiante a uma criatura que possa ver a até 18 metros de você, sem necessidade de ação.',
  'O dano aumenta em 1d6 para cada círculo de espaço de magia acima do 4º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'shroud-blood',
  'Véu de Sangue',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  '9 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Você pode escolher a si mesmo ou uma criatura voluntária a até 9 metros para ter Vantagem em testes de Destreza (Furtividade). Quando o alvo perder a condição Invisível, pode usar uma Reação para ganhar a condição Invisível por um número de rodadas igual ao número de Dados de Vida gastos para conjurar a magia. O alvo perde a condição Invisível imediatamente após fazer uma jogada de ataque, causar dano ou conjurar uma magia.',
  'Você pode escolher uma criatura adicional para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'somnolence',
  'Somnolência',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'sand mixed with the spellcaster’s blood',
  'V, S, M (sand mixed with the spellcaster’s blood)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Role o Dado de Vida gasto mais 2d12 e escolha uma criatura no alcance. Se o total da rolagem for igual ou maior que os PV atuais da criatura escolhida, ela cai em sono mágico por 1 minuto. Se o total for igual ou maior que o máximo de PV da criatura, o sono mágico dura 24 horas. A magia termina em um alvo se ele sofrer dano ou se alguém a até 1,5 metro dele usar uma ação para sacudi-lo e tirá-lo do efeito. Uma criatura despertada antes do fim desta magia ganha 1 nível de Exaustão.

Criaturas que não dormem, como elfos, ou que têm Imunidade à condição Exaustão obtêm sucesso automaticamente em salvaguardas contra esta magia.',
  'Você rola 1d12 adicional e pode gastar dois Dados de Vida extras para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'spirit-swarm',
  'Enxame de Espíritos',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '36 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration, 1 minuto',
  true,
  false,
  'Você convida espíritos a se vingarem de um alvo. Uma criatura que você possa ver no alcance deve fazer uma salvaguarda de Carisma. O alvo deve ter Carisma 3 ou superior. Em uma falha, o alvo sofre 8d8 de dano Psíquico e fica com a condição Amedrontado até a magia terminar. Em um sucesso, a criatura sofre apenas metade desse dano.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'splattering-smite',
  'Destruição Espalhada',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação (which you take when you hit a creature with a Melee weapon)',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Seus golpes bebem o sangue respingado dos inimigos. Ao conjurar esta magia, você deve gastar cinco Dados de Vida ou a magia falha automaticamente. Uma vez em cada um dos seus turnos, ao acertar uma criatura com uma jogada de ataque usando arma corpo a corpo ou Ataque Desarmado, role os Dados de Vida gastos para conjurar a magia e recupere PV iguais ao total rolado.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'steal-immortality',
  'Roubar Imortalidade',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reação , que você executa quando a Celestial, Elemental, Fey, Fiend, or Undead within range that you can see is reduced to 0 Hit Points',
  '90 m',
  true,
  true,
  true,
  'the skull of a humanoid encrusted in gems worth 1,000+ GP, which the spell consumes',
  'V, S, M (the skull of a humanoid encrusted in gems worth 1,000+ GP, which the spell consumes)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar nove Dados de Vida ou a magia falha automaticamente. Role os Dados de Vida gastos e ganhe PV temporários iguais ao dobro do total da rolagem. Você ganha o tipo de criatura do alvo da magia, além do seu próprio tipo.

Enquanto a magia durar, você tem Imunidade à condição Envenenado; não precisa mais comer, beber ou respirar; tem Resistência a dano Contundente, Perfurante e Cortante; e ganha um benefício conforme o novo tipo de criatura:

Celestial. Você tem Resistência a dano Radiante e Necrótico e Deslocamento de Voo de 18 metros.

Elemental. Você tem Resistência a dano Ácido, Gélido, Ígneo, Elétrico e Trovejante.

Feérico. Você pode usar uma Ação Bônus para ficar com a condição Invisível até o início do seu próximo turno, ou se teleportar até 18 metros para um espaço desocupado que possa ver.

Corruptor. Você tem Resistência a dano Gélido e Ígneo e Deslocamento de Voo de 18 metros.

Morto-vivo. Você tem Imunidade a dano Necrótico e Imunidade às condições Enfeitiçado e Amedrontado.

Você mantém o tipo de criatura e os benefícios até conjurar a magia novamente ou ser reduzido a 0 PV.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'suffocate',
  'Sufocar',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a leather glove',
  'V, S, M (a leather glove)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você cria um par de mãos agarradoras feitas de força invisível. Faça um ataque mágico à distância contra uma criatura que possa ver no alcance. Em um acerto, a criatura fica com a condição Contido. Enquanto tiver essa condição, não pode respirar.

Uma criatura pode prender a respiração por um número de rodadas igual a 1 mais o seu modificador de Constituição (mínimo de 30 segundos) antes de começar a sufocar. Quando uma criatura fica sem fôlego, ganha 1 nível de Exaustão no fim de cada um dos seus turnos. Quando uma criatura puder respirar novamente, remove todos os níveis de Exaustão ganhos por sufocar.

Uma criatura Contida pelas mãos pode realizar uma ação para fazer um teste de Força (Atletismo) contra a sua CD de salvaguarda da magia. Se obtiver sucesso, deixa de estar Contida.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'summon-plant',
  'Invocar Planta',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '27 m',
  true,
  true,
  true,
  'a ceramic pot filled with herbs and fertilizer worth at least 200 GP',
  'V, S, M (a ceramic pot filled with herbs and fertilizer worth at least 200 GP)',
  'Concentração, até 1 hora',
  true,
  false,
  'Você evoca um espírito vegetal. Ele se manifesta em um espaço desocupado que você possa ver no alcance. Esta forma corpórea usa o bloco de estatísticas Espírito Vegetal. Ao conjurar a magia, escolha um traço floral: Florescente, Carvalho ou Espinhoso. A criatura se assemelha a uma planta animada marcada pelo traço floral escolhido, que determina um dos traços do bloco de estatísticas dela. A criatura desaparece quando cair a 0 PV ou quando a magia terminar.

A criatura é aliada sua e dos seus aliados. Em combate, a criatura compartilha a sua contagem de Iniciativa, mas age imediatamente após o seu turno. Ela obedece aos seus comandos verbais (sem exigir ação). Se você não der nenhum comando, ela usa a ação Esquivar e usa o movimento para evitar perigo.',
  'Use o círculo do espaço de magia como o nível da magia no bloco de estatísticas. Planta Média (Grande se Carvalho), Neutra. CA 11 + o nível da magia. PV 20 (somente Florescente e Espinhoso) ou 30 (somente Carvalho) + 10 para cada círculo da magia acima do 2º. Deslocamento 9 m; Escalada 9 m (somente Florescente e Espinhoso). Imunidades: Cego, Surdo, Exaustão, Atordoado. Sentidos: Sentido Sísmico 9 m (cego além desse raio), Percepção Passiva 11. Idiomas: compreende os idiomas que você conhece. ND nenhum (XP 0; BP igual ao seu Bônus de Proficiência). Traços: Regeneração Silvestre. O espírito recupera 1 PV no início do turno dele se tiver pelo menos 1 PV e estiver sob luz solar direta. Ações: Ataque Múltiplo. A planta faz um número de ataques igual à metade do nível desta magia (arredondado para baixo). Rajada de Pétalas (somente Florescente). A planta faz uma rajada de pétalas preencher o ar em uma Emanação de 3 metros. A área fica Totalmente Obscurecida por 1 minuto. Pancada. Jogadas de Ataque Corpo a Corpo: bônus igual ao seu modificador de ataque mágico, alcance 1,5 m. Acerto: 1d8 + 3 + o nível da magia de dano Contundente ou Perfurante (somente Espinhoso). Reações: Escudo de Carvalho (somente Carvalho). Quando uma criatura a até 1,5 metro da planta sofrer dano de um ataque, a planta sofre o dano no lugar. Proteção Espinhosa (somente Espinhoso). Quando uma criatura a até 1,5 metro da planta a atacar, a planta faz um ataque de Pancada com Vantagem contra a criatura.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'summon-sea-spirit',
  'Convocar Espírito do Mar',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '27 m',
  true,
  true,
  true,
  'a bejeweled statuette of a sea serpent worth at least 300 GP',
  'V, S, M (a bejeweled statuette of a sea serpent worth at least 300 GP)',
  'Concentração, até 1 hora',
  true,
  false,
  'Você chama um espírito abissal. Ele se manifesta em um espaço desocupado que você possa ver no alcance. Esta forma corpórea usa o bloco de estatísticas Sea Serpent. Ao conjurar a magia, escolha uma característica abominável: Enormous Mouth, Glowing Lantern ou Scaled Wings. A criatura se assemelha a uma criatura marinha monstruosa marcada pela característica abominável escolhida, que determina um dos traços em seu bloco de estatísticas. A criatura desaparece quando é reduzida a 0 PV ou quando a magia termina.

A criatura é uma aliada sua e dos seus aliados. Em combate, a criatura compartilha a sua contagem de Iniciativa, mas age imediatamente após o seu turno. Ela obedece aos seus comandos verbais (sem exigir ação sua). Se você não emitir nenhum, ela realiza a ação Esquiva e usa seu movimento para evitar perigo.',
  'Use o círculo do espaço de magia como o círculo da magia no bloco de estatísticas. Monstruosidade Grande, Neutro CA 11 + círculo da magia PV 30 + 10 para cada círculo da magia acima do 3º Deslocamento 9 m, Voo 12 m (apenas Scaled Wings), Natação 18 m Resistências Gélido Imunidades Caído Sentidos Visão no Escuro 18 m, Percepção Passiva 10 Idiomas Compreende os idiomas que você conhece Desafio Nenhum (XP 0; BP igual ao seu Bônus de Proficiência) Traços Sobrevoo (apenas Scaled Wings). A serpente marinha não provoca Ataques de Oportunidade quando voa para fora do alcance de um inimigo. Ações Ataque Múltiplo. A serpente marinha faz um número de ataques igual à metade do círculo desta magia (arredondado para baixo). Fascinar (apenas Glowing Lantern). A serpente marinha faz uma lanterna pendurada em uma de suas nadadeiras brilhar de forma sinistra. Salvaguarda de Sabedoria: CD igual à sua CD de salvaguarda da magia, cada criatura em uma Emanação de 9 metros originada da serpente marinha. Falha: O alvo fica Enfeitiçado pela serpente marinha até o início do próximo turno dela. Criaturas têm Vantagem na salvaguarda se a serpente marinha já tiver causado dano a elas neste turno, e a condição Enfeitiçado termina imediatamente se a serpente marinha causar dano a uma criatura Enfeitiçada por esta habilidade. Inalar (apenas Enormous Mouth). Salvaguarda de Força: CD igual à sua CD de salvaguarda da magia, cada criatura em um Cone de 4,5 metros. Falha: 1d6 + o círculo da magia de dano Psíquico e a criatura é puxada 1,5 metro em linha reta na direção dela ou, se a criatura já estiver a até 1,5 metro da serpente marinha, sofre 2d6 de dano Perfurante adicional. Sucesso: Metade do dano. Mordida. Jogadas de Ataque Corpo a Corpo: Bônus igual ao seu modificador de ataque mágico, alcance 1,5 m. Acerto: 1d6 + 3 + o círculo da magia de dano Perfurante e a criatura fica com a condição Agarrado (CD para escapar igual à sua CD de salvaguarda da magia). A condição Agarrado termina se a serpente marinha morder uma criatura diferente. Flagelar. Jogadas de Ataque Corpo a Corpo: Bônus igual ao seu modificador de ataque mágico, alcance 3 m. Acerto: 1d10 + 3 + o círculo da magia de dano Contundente e o alvo é empurrado 1,5 metro para longe da serpente marinha. O dano àquele navio não poderia ter sido causado por uma criatura deste mundo.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'supernal-smite',
  'Golpe Superno',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
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
  'Seu golpe faz a magia ambiente ao redor de uma criatura colapsar e detonar. O alvo atingido pelo golpe sofre 4d6 de dano Energético extra do ataque. Se a criatura estiver se concentrando em uma magia, essa Concentração é interrompida.

Além disso, cada magia contínua de 3º círculo ou inferior no alvo termina. Para cada magia contínua de 4º círculo ou superior no alvo, faça um teste de atributo usando o seu atributo de conjuração (CD 10 mais o círculo daquela magia). Em um sucesso, a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'theft-of-vitae',
  'Roubo de Vitalidade',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reação , que você executa quando a creature you can see within 30 feet of you takes damage',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar dois Dados de Vida ou a magia falha automaticamente.

Role os Dados de Vida gastos. A criatura desencadeadora sofre dano Necrótico igual ao resultado. Você ganha PV temporários iguais ao resultado mais o dano desencadeador, até um máximo de 15 PV temporários.',
  'O máximo de PV temporários que você pode ganhar com a conjuração aumenta em 10 para cada círculo de espaço acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'thorn-armor',
  'Armadura de Espinhos',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a rose',
  'V, S, M (a rose)',
  '10 minutos',
  false,
  false,
  'Ao conjurar esta magia, um exoesqueleto flexível coberto de espinhos aparece em torno de um alvo voluntário no alcance. O alvo ganha 3d6 PV temporários. Se uma criatura acertar o alvo com uma jogada de ataque corpo a corpo antes de a magia terminar, essa criatura sofre dano Perfurante igual ao número de PV temporários perdidos em consequência do ataque. Esta magia termina antecipadamente se o alvo não tiver PV temporários restantes concedidos por esta magia.',
  'O alvo ganha 2d6 PV temporários adicionais para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'tremor',
  'Tremor',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'small bell',
  'V, S, M (small bell)',
  'Concentração, até 1 minuto',
  true,
  false,
  'O solo ao seu redor em uma Emanação de 4,5 metros começa a tremer violentamente. Você não é afetado pelos tremores. O solo é considerado Terreno Difícil e, sempre que a Emanação entrar no espaço de uma criatura, uma criatura entrar na Emanação ou a criatura terminar o turno nela, a criatura faz uma salvaguarda de Destreza. Em uma falha, a criatura sofre 1d6 de dano Contundente e fica com a condição Caído. Uma criatura faz esta salvaguarda apenas uma vez por turno.',
  'O dano aumenta em 1d6 para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'undead-enthrallment',
  'Domínio de Mortos-vivos',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 hora',
  '3 m',
  true,
  true,
  true,
  'a clay pot filled with brackish water, another clay pot filled with grave dirt, and a black onyx stone worth 500 + GP for each corpse',
  'V, S, M (a clay pot filled with brackish water, another clay pot filled with grave dirt, and a black onyx stone worth 500 + GP for each corpse)',
  'Instantânea',
  false,
  false,
  'Escolha um cadáver, ou um número de cadáveres, no alcance equivalentes ao tamanho da criatura que você está animando (o Mestre determina quantos cadáveres são necessários). Sua magia imbui o alvo com uma imitação funesta de vida, erguendo-o como uma criatura Morta-viva. Você pode escolher que o alvo se torne uma criatura Morta-viva de Nível de Desafio 3 ou inferior (o Mestre tem as estatísticas de jogo da criatura).

Em cada um dos seus turnos, você pode usar uma Ação Bônus para comandar mentalmente qualquer criatura que tenha criado com esta magia se ela estiver a até 18 metros de você. (Se controlar várias criaturas, pode comandar qualquer uma ou todas ao mesmo tempo, emitindo o mesmo comando a cada uma.) Você decide qual ação a criatura realizará e para onde se moverá durante o próximo turno dela, ou pode emitir um comando geral, como guardar determinado aposento ou corredor. Se não emitir comandos, a criatura executa a ação Esquivar. Uma vez dada uma ordem, a criatura continua a segui-la até a tarefa estar concluída.

A criatura fica sob seu controle por 24 horas, após o que deixa de obedecer a qualquer comando que você tenha dado. Para manter o controle da criatura por mais 24 horas, você deve conjurar esta magia novamente sobre a criatura antes que o período atual de 24 horas termine. Esse uso da magia reafirma seu controle sobre 1 criatura que você tenha animado com esta magia, em vez de animar uma nova. Qualquer criatura que você tenha mantido com esta magia por 30 dias permanece permanentemente sob seu controle. Você só pode controlar no máximo quatro criaturas com esta magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'vampiric-claws',
  'Garras Vampíricas',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentração, até 1 minuto',
  true,
  false,
  'Você brota garras perversas. Quando usar o Ataque Desarmado para causar dano com o novo crescimento, ele causa 1d6 de dano Cortante em vez do dano normal do seu Ataque Desarmado, e você usa o seu modificador de atributo de conjuração nas jogadas de ataque e de dano em vez de Força.

Enquanto a magia durar, cada vez que você causar dano com um Ataque Desarmado, ganha um número de PV temporários igual ao seu modificador de atributo de conjuração. Os PV temporários desta magia são perdidos quando a magia termina.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'vibrating-humors',
  'Humores Vibrantes',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a tuning fork',
  'V, S, M (a tuning fork)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar um Dado de Vida ou a magia falha automaticamente. Uma criatura que você possa ver a até 9 metros deve fazer uma salvaguarda de Constituição. Em uma falha, o alvo sofre dano Trovejante e tem Desvantagem em testes de Destreza (Furtividade) porque o sangue vibra ruidosamente. Para determinar esse dano, role o Dado de Vida gasto para conjurar esta magia.

O alvo repete a salvaguarda no final de cada um dos seus turnos, encerrando a magia em um sucesso.',
  'Você aumenta o dano gastando um Dado de Vida adicional para cada círculo de espaço de magia acima do 1º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'viscous-sheath',
  'Bainha Viscosa',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  NULL,
  'V, S, M, (a bloody funerary shroud)',
  '10 minutos',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar sete Dados de Vida ou a magia falha automaticamente. Seu corpo é envolto em sangue coagulado. Sempre que uma criatura a até 1,5 metro de você o acertar com uma jogada de ataque corpo a corpo, o atacante sofre dano Necrótico. Para determinar esse dano, role os Dados de Vida gastos para conjurar a magia mais o seu modificador de atributo de conjuração.

Se uma criatura o acertar com uma arma corpo a corpo, você pode usar uma Reação para formar coágulos em torno da arma, aprisionando-a. O atacante deve obter sucesso em uma salvaguarda de Força ou a arma gruda em você. Se o atacante não soltar a arma, a criatura fica com a condição Agarrado enquanto a arma estiver presa. Enquanto presa, a arma não pode ser usada. O alvo pode usar uma ação para fazer um teste de Força (Atletismo) contra a CD de magia, libertando a arma em um sucesso. A criatura também pode soltar a arma para encerrar a condição Agarrado.

Você pode aprisionar um número de armas igual ao número de Dados de Vida gastos para conjurar a magia. Quando a magia termina, as armas são liberadas.',
  'Você pode aprisionar uma arma adicional para cada círculo de espaço de magia acima do 4º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wall-of-gloom',
  'Muralha de Melancolia',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '36 m',
  true,
  true,
  true,
  'a vial of tears',
  'V, S, M (a vial of tears)',
  '10 minutos',
  false,
  false,
  'Você cria uma muralha de energia cinzenta rodopiante, formada da dor psíquica da perda. A muralha aparece no alcance sobre uma superfície sólida e dura pela duração. Você escolhe fazer a muralha com até 18 metros de comprimento, 3 metros de altura e 1,5 metro de espessura, ou uma muralha em anel com 6 metros de diâmetro e até 6 metros de altura e 1,5 metro de espessura. A muralha bloqueia a linha de visão.

A muralha emite Luz Fraca até um alcance de 30 metros. Ao conjurar a magia, você e criaturas que designar podem atravessar e permanecer perto da muralha sem sofrer dano. Se uma criatura se mover a até 6 metros dela ou iniciar o turno ali, a criatura deve obter sucesso em uma salvaguarda de Carisma ou ficar com a condição Incapacitado até o início do seu próximo turno.

Uma criatura pode atravessar a muralha, embora a tentativa seja emocionalmente drenante. Na primeira vez que uma criatura entrar na muralha em um turno ou terminar o turno nela, deve obter sucesso em uma salvaguarda de Carisma ou ganhar 1 nível de Exaustão.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'weave-numen',
  'Tecer Numen',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a mithral sewing needle worth 300 GP+, which the spell consumes',
  'V, S, M (a mithral sewing needle worth 300 GP+, which the spell consumes)',
  'Concentração, até 10 minutos',
  true,
  false,
  'Você pode sentir a presença de magia a até 36 metros de si. Você vê uma aura fraca em torno de qualquer criatura ou objeto visível nesse alcance que porte magia, e aprende sua escola de magia, se houver.

Além disso, você ganha treze fios. Pode gastar esses fios para obter benefícios conforme descritos abaixo, sem ação necessária salvo indicação em contrário:

Você perde todos os fios restantes quando esta magia termina. Se gastar todos os fios concedidos pela magia, a magia termina.',
  'Você ganha dois fios adicionais por círculo de espaço de magia acima do 6º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wilting-smite',
  'Destruição Definhante',
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
  'Instantânea',
  false,
  false,
  '[Sangromancia] Ao conjurar esta magia, você deve gastar dois Dados de Vida ou a magia falha automaticamente. A criatura perde todas as Resistências a dano até o início do seu próximo turno. O alvo atingido pelo golpe sofre dano Necrótico extra do ataque. Para determinar esse dano, role os Dados de Vida gastos para conjurar a magia.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wipe-face',
  'Apagar Rosto',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  'Você amaldiçoa uma criatura que possa ver no alcance. O rosto do alvo é substituído por pele completamente lisa, selando os olhos, o nariz e a boca da criatura. A criatura fica com as condições Cego e Incapacitado e começa a sufocar.

No final de cada um dos seus turnos, o alvo pode tentar uma salvaguarda de Constituição para encerrar a magia. Causar pelo menos 15 de dano Cortante ao alvo abre uma via aérea permitindo que respire, mas a maldição sela a abertura no início do seu próximo turno.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wrack',
  'Suplício',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a frayed piece of cord',
  'V, S, M (a frayed piece of cord)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Escolha uma criatura que possa ver no alcance. O alvo deve obter sucesso em uma salvaguarda de Constituição ou é acometido por espasmos musculares lancinantes pela duração. Em uma falha, o Deslocamento do alvo é reduzido à metade e ele tem Desvantagem nas jogadas de ataque. O alvo repete a salvaguarda no final de cada um dos seus turnos, encerrando a magia em um sucesso.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-conceited-obsession',
  'Maldição da Obsessão Vaidosa',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a thread from the bed or clothes of your target, a handful of teeth, and a gilded mirror worth 1,000+ GP, all of which the spell consumes',
  'V, S, M (a thread from the bed or clothes of your target, a handful of teeth, and a gilded mirror worth 1,000+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com uma autoinfatuação obsessiva. O alvo deve fazer uma salvaguarda de Carisma.

Salvaguarda Bem-sucedida. Em um sucesso, o alvo sofre 4d6 de dano Psíquico e tem ciência de que foi alvo de uma maldição. Além disso, por 1 minuto, o alvo sofre 1d6 de dano Psíquico no início de cada um dos seus turnos.

Efeito Inicial. Em uma falha, o alvo sofre 8d10 de dano Psíquico e é amaldiçoado.

Evento Desencadeador. Na próxima vez que a criatura amaldiçoada olhar em um espelho ou superfície refletora, a superfície racha ou se distorce de algum modo, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada é compelida a parar e admirar-se sempre que vir seu reflexo. Fica constantemente preocupada com a própria aparência.

Estágio 2. A criatura amaldiçoada fica obcecada em procurar o próprio reflexo aonde for, inclusive nos olhos dos inimigos. Ataques contra a criatura amaldiçoada têm Vantagem.

Estágio 3. A criatura amaldiçoada é levada a encontrar ou construir um local onde possa ver o próprio reflexo de muitos ângulos. A criatura amaldiçoada é compelida a permanecer nesse local e admirar-se. Além disso, a criatura amaldiçoada tem Desvantagem em jogadas de ataque devido à obsessão com a própria aparência.

Culminação. A criatura amaldiçoada se contorce numa figura deformada e torna-se um Weeping Willow.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-crushing-sensation',
  'Maldição da Sensação Esmagadora',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a drop of the target’s blood, a shred of silk material, and a horn worth 1,000+ GP, all of which the spell consumes',
  'V, S, M (a drop of the target’s blood, a shred of silk material, and a horn worth 1,000+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com hipersensibilidade dolorosa a sensações físicas. O alvo deve fazer uma salvaguarda de Constituição.

Salvaguarda Bem-sucedida. Em um sucesso, o alvo sofre 4d6 de dano Trovejante e tem ciência de que foi alvo de uma maldição. Por 1 minuto, o alvo sofre 1d6 de dano Trovejante no início de cada um dos seus turnos.

Efeito Inicial. Em uma falha, o alvo sofre 8d10 de dano Trovejante e é amaldiçoado.

Evento Desencadeador. Na próxima vez que o alvo ouvir um barulho alto, sofre uma enxaqueca incapacitante, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada evita Luz Intensa, barulhos altos, temperaturas extremas e não gosta de ser tocada.

Estágio 2. A criatura amaldiçoada não suporta a sensação de roupas ásperas ou pesadas contra a pele. Não pode vestir armadura. Tem Vulnerabilidade a dano Trovejante devido à hipersensibilidade. Além disso, tem Desvantagem em jogadas de ataque se ela ou o alvo estiver em uma área de Luz Intensa.

Estágio 3. Até estímulos sensoriais leves se tornam intoleráveis à criatura amaldiçoada. Ela é levada a encontrar um covil escuro e silencioso, como uma caverna profunda ou masmorra. A criatura amaldiçoada não pode deixar esse covil voluntariamente e tem Vulnerabilidade a todo dano exceto Psíquico enquanto estiver fora do covil.

Culminação. A criatura amaldiçoada se contorce numa figura deformada e torna-se um Sightless Agony.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-damned-aging',
  'Maldição do Envelhecimento Maldito',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a childhood possession of the target, a pint of blood, and a watch worth 600+ GP, all of which the spell consumes',
  'V, S, M (a childhood possession of the target, a pint of blood, and a watch worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com envelhecimento horrível. O alvo deve fazer uma salvaguarda de Força.

Salvaguarda Bem-Sucedida. Em um sucesso, o alvo sofre 2d10 de dano Necrótico e percebe que foi alvo de uma maldição. Por 1 minuto, o alvo tem Vulnerabilidade a dano Contundente, Perfurante ou Cortante (você escolhe ao conjurar a magia).

Efeito Inicial. Em uma falha, o alvo sofre 6d10 de dano Necrótico e fica amaldiçoado.

Evento Desencadeador. Na próxima vez que o alvo terminar um Descanso Longo, ele encontra múltiplas rugas, cabelos grisalhos ou manchas que não tinha antes, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada é compelida a descansar sempre que a ocasião permitir, tornando-se letárgica e preguiçosa.

Estágio 2. A criatura amaldiçoada fica débil. Após terminar um Descanso Curto, a criatura só pode usar 25 por cento dos seus Dados de Vida, arredondado para cima, para recuperar PV.

Estágio 3. A criatura amaldiçoada começa a envelhecer rapidamente, tornando-se decrépita. A criatura amaldiçoada tem Desvantagem em salvaguardas de Força, Destreza e Constituição.

Culminação. A criatura amaldiçoada se contorce em uma figura deformada e se torna um Body Snatcher.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-fastidious-pride',
  'Maldição do Orgulho Meticuloso',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a shred of the target’s clothing, an uncrushed dead spider, and a sewing needle worth 600+ GP, all of which the spell consumes',
  'V, S, M (a shred of the target’s clothing, an uncrushed dead spider, and a sewing needle worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com soberba narcisista. O alvo deve fazer uma salvaguarda de Inteligência.

Salvaguarda Bem-Sucedida. Em um sucesso, o alvo sofre 2d10 de dano Psíquico e percebe que foi alvo de uma maldição.

Efeito Inicial. Em uma falha, o alvo sofre 4d10 de dano Psíquico, fica com a condição Cego por 1 minuto e fica amaldiçoado.

Evento Desencadeador. Na próxima vez que o alvo ouvir seu nome pronunciado, o falante soa depreciativo independentemente do tom real, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada ouve insultos velados em toda parte, acreditando que todos têm inveja do seu brilhantismo e talento.

Estágio 2. A criatura amaldiçoada sente inquietação a menos que esteja ativamente trabalhando para cumprir um objetivo. A criatura amaldiçoada não obtém nenhum benefício de seus Descansos Curtos.

Estágio 3. A criatura amaldiçoada acredita que todos estão envolvidos em uma conspiração para causar sua queda. Sempre que falhar em um Teste de D20, ela tem Desvantagem no próximo Teste de D20 que fizer.

Culminação. A criatura amaldiçoada se contorce em uma figura deformada e se torna um Mind Siphon.

Dicas do Mestre

Se o personagem de um jogador se transformar em um monstro após a Culminação de uma maldição, considere permitir que o jogador use o monstro contra os antigos companheiros do personagem. Isso garante que todos participem do que pode ser um evento memorável.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-foul-blight',
  'Maldição da Praga Repugnante',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a shred of the target’s hair or flesh, a chunk of rotten meat, and a jewelry box worth 600+ GP, all of which the spell consumes',
  'V, S, M (a shred of the target’s hair or flesh, a chunk of rotten meat, and a jewelry box worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com uma varíola putrefata e fétida. O alvo deve fazer uma salvaguarda de Carisma.

Salvaguarda Bem-Sucedida. Em um sucesso, o alvo sofre 3d10 de dano Necrótico e percebe que foi alvo de uma maldição. Além disso, não pode ganhar PV temporários nem recuperar PV por 1 minuto.

Efeito Inicial. Em uma falha, o alvo sofre 6d10 de dano Necrótico e fica amaldiçoado.

Evento Desencadeador. Na próxima vez que o alvo procurar suas vestes ou equipamento, encontra uma infestação de insetos, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada é acometida por uma tosse leve. Sempre que fala mais do que algumas palavras de uma vez, entra em acesso de tosse. Isso não afeta a conjuração de magias.

Estágio 2. O cheiro de putrefação paira no ar ao redor da criatura amaldiçoada. Comida e bebida estragam rapidamente, joias enferrujam e madeira apodrece a até 3 metros da criatura amaldiçoada. Além disso, a criatura amaldiçoada tem Desvantagem em testes de atributo e salvaguardas de Carisma, e não pode manter Concentração.

Estágio 3. A pele da criatura amaldiçoada fica repleta de marcas de varíola, pústulas e lesões. Insetos acorrem à criatura amaldiçoada, infestando suas roupas. A criatura amaldiçoada não pode recuperar PV exceto gastando Dados de Vida após terminar um Descanso Curto.

Culminação. A criatura amaldiçoada se contorce em uma figura deformada e se torna um Plague Carrion.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-ill-fated-fortune',
  'Maldição da Fortuna Infeliz',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a discarded piece of the target’s equipment, a splinter of bone, and a collection of dice worth 800+ GP, all of which the spell consumes',
  'V, S, M (a discarded piece of the target’s equipment, a splinter of bone, and a collection of dice worth 800+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com azar letal. O alvo deve fazer uma salvaguarda de Destreza.

Salvaguarda Bem-sucedida. Em um sucesso, o alvo sofre 3d10 de dano Trovejante e tem ciência de que foi alvo de uma maldição. Além disso, a criatura tem Desvantagem no primeiro Teste de D20 que fizer no próximo 1 minuto.

Efeito Inicial. Em uma falha, a criatura sofre 7d10 de dano Trovejante e é amaldiçoada.

Evento Desencadeador. Na próxima vez que o alvo atravessar uma porta, esbarra o pé ou bate a cabeça, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada sofre inconvenientes menores e azar. Lojas que deseja visitar fecham exatamente quando chega, e seu equipamento quebra em momentos inconvenientes.

Estágio 2. A criatura amaldiçoada torna-se um farol de azar, à medida que contratempos outrora inofensivos se tornam cada vez mais perigosos. Objetos parecem constantemente ser colocados no caminho da criatura. Além disso, a criatura amaldiçoada tem Desvantagem em testes de atributo e salvaguardas de Destreza.

Estágio 3. A criatura amaldiçoada torna-se perigosamente propensa a acidentes, pois até as tarefas mais simples têm consequências imprevistas e ameaçadoras à vida. A criatura amaldiçoada tem Desvantagem em testes de Iniciativa, seu Deslocamento é reduzido a 3 metros, e fica com a condição Caído se errar uma jogada de ataque.

Culminação. A criatura amaldiçoada se contorce numa figura deformada e torna-se um Herald of Calamity.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-insatiable-greed',
  'Maldição da Ganância Insaciável',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a coin that the target has previously possessed, the tail of a rat, and a golden crown of thorns worth 800+ GP, all of which the spell consumes',
  'V, S, M (a coin that the target has previously possessed, the tail of a rat, and a golden crown of thorns worth 800+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com uma ganância amarga e autodestrutiva. O alvo deve fazer uma salvaguarda de Sabedoria.

Salvaguarda Bem-sucedida. Em um sucesso, o alvo sofre 4d10 de dano Gélido e tem ciência de que foi alvo de uma maldição.

Efeito Inicial. Em uma falha, o alvo sofre 6d10 de dano Gélido, e seu Deslocamento é reduzido a 0 por 1 minuto. No final de cada turno, o Deslocamento do alvo aumenta em 1,5 metro, até atingir o Deslocamento máximo.

Evento Desencadeador. Na próxima vez que o alvo terminar um Descanso Curto ou Longo, percebe que perdeu um item valorizado, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada fica compelida a roubar quinquilharias.

Estágio 2. A criatura amaldiçoada encontra um lugar secreto para começar a esconder as quinquilharias roubadas, e fica ansiosa ao deixar o local por períodos prolongados. A criatura tem Desvantagem em testes de atributo e salvaguardas de Sabedoria.

Estágio 3. A criatura amaldiçoada é levada a transformar seu tesouro de quinquilharias num labirinto de posses e riquezas. A criatura amaldiçoada deseja permanecer nesse covil. A criatura não pode usar Reações.

Culminação. A criatura amaldiçoada se contorce numa figura deformada e torna-se um Verminous Abomination.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-lost-sentiment',
  'Maldição do Sentimento Perdido',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a lock of hair from someone the target loves, an animal’s heart, and an idol worth 600+ GP, all of which the spell consumes',
  'V, S, M (a lock of hair from someone the target loves, an animal’s heart, and an idol worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com a perda de memórias e loucura horrível. O alvo deve fazer uma salvaguarda de Inteligência.

Salvaguarda Bem-Sucedida. Em um sucesso, o alvo sofre 3d10 de dano Energético, fica com a condição Incapacitado até o fim do seu próximo turno e não percebe que foi alvo de uma maldição.

Efeito Inicial. Em uma falha, o alvo sofre 6d10 de dano Energético, fica com a condição Atordoado até o fim do seu próximo turno e fica amaldiçoado.

Evento Desencadeador. Na próxima vez que o alvo terminar um Descanso Longo, sofre visões de pesadelo de abandono ou solidão, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada começa a esquecer eventos ocorridos nos últimos dias e os nomes de conhecidos.

Estágio 2. A criatura amaldiçoada esquece todos exceto seus companheiros mais próximos, e tem delírios de ameaças ocultas e rivais conspirando. Além disso, a criatura amaldiçoada tem Desvantagem em testes de atributo e salvaguardas de Inteligência.

Estágio 3. A criatura amaldiçoada esquece seus companheiros mais próximos, sua própria identidade e seus objetivos. A maldição fabrica delírios de uma grande conspiração que só a criatura amaldiçoada pode impedir. A criatura amaldiçoada é compelida a tomar qualquer ação que acredite necessária para descobrir essa conspiração. A criatura não pode realizar Ações Bônus.

Culminação. A criatura amaldiçoada se contorce em uma figura deformada e se torna um Dream Whisperer.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-ravenous-hunger',
  'Maldição da Fome Voraz',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a morsel of food that belonged to the target, a sun-dried slug, and a dining plate worth 400+ GP, all of which the spell consumes',
  'V, S, M (a morsel of food that belonged to the target, a sun-dried slug, and a dining plate worth 400+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com fome dolorosa e interminável. O alvo deve fazer uma salvaguarda de Constituição.

Salvaguarda Bem-Sucedida. Em um sucesso, o alvo sofre 2d10 de dano de Veneno, fica com a condição Envenenado até o fim do seu próximo turno e percebe que foi alvo de uma maldição.

Efeito Inicial. Em uma falha, o alvo sofre 4d10 de dano de Veneno, fica com a condição Envenenado por 1 minuto e fica amaldiçoado.

Evento Desencadeador. Na próxima vez que comer uma refeição, a criatura amaldiçoada morde a própria língua e a boca se enche de sangue, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada é tomada por um apetite insaciável.

Estágio 2. A criatura amaldiçoada é compelida a comer itens inadequados, como moedas, flores, vidro e terra. Além disso, a criatura amaldiçoada tem Desvantagem em salvaguardas de Constituição, e seu máximo de PV diminui em valor igual ao seu nível de personagem (ou Dados de Vida se não tiver nível de personagem).

Estágio 3. A criatura amaldiçoada fica voraz e é compelida a consumir a carne de Humanoides. Nenhum outro alimento a sacia. A criatura não pode ter Vantagem em Testes de D20.

Culminação. A criatura amaldiçoada se contorce em uma figura deformada e se torna um Bloated Gastromorph.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-uncontrollable-wrath',
  'Maldição da Ira Incontrolável',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'blood or other fluid of the target, a severed hand, and a serrated knife worth 1,000+ GP, all of which the spell consumes',
  'V, S, M (blood or other fluid of the target, a severed hand, and a serrated knife worth 1,000+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'Esta magia amaldiçoa uma criatura com um temperamento incontrolável e sede de violência. O alvo deve fazer uma salvaguarda de Sabedoria.

Salvaguarda Bem-sucedida. Em um sucesso, o alvo sofre 4d10 de dano Psíquico e tem ciência de que foi alvo de uma maldição. Além disso, por 1 minuto, o alvo tem Desvantagem em ataques feitos usando Reações.

Efeito Inicial. Em uma falha, o alvo sofre 8d10 de dano Psíquico e é amaldiçoado.

Evento Desencadeador. Na próxima vez que a criatura amaldiçoada atacar com uma arma ou conjurar uma magia usando um Foco de Conjuração, uma ferida antiga se reabre, e a maldição avança para o Estágio 1.

Estágio 1. A criatura amaldiçoada fica facilmente agitada e agressiva.

Estágio 2. A criatura amaldiçoada fica obcecada com violência. A emoção do combate solo a intoxica, e sua postura com os aliados azeda conforme a maldição cresce. A criatura amaldiçoada não obtém benefício dos seus Descansos Curtos.

Estágio 3. A criatura amaldiçoada é levada a uma sede de sangue insaciável, incapaz de descansar enquanto houver inimigos a abater. A criatura amaldiçoada não obtém benefício dos seus Descansos Longos.

Culminação. A criatura amaldiçoada se contorce numa figura deformada e torna-se um Avatar of Slaughter.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
