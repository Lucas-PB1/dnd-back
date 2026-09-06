-- Opções de espécie + stubs de magia (Blur / Gust of Wind) — Northlands

-- Stubs para lineages élficas (ausentes no PHB 2024 deste catálogo)
INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES
(
  'embacar',
  'Embaçar',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Pessoal',
  TRUE,
  TRUE,
  FALSE,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  TRUE,
  FALSE,
  'Sua forma fica embaraçada e deslocada. Enquanto a magia durar, criaturas têm Desvantagem nas jogadas de ataque contra você. Um atacante é imune a esse efeito se não depender de visão (como Visão Cega) ou puder ver através de ilusões (como Visão Verdadeira).

Stub PHB 2024 para lineage Ice Elf / Alfar (Northlands); texto resumido.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
),
(
  'sopro-de-vento',
  'Sopro de Vento',
  2,
  '2º Círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  TRUE,
  TRUE,
  TRUE,
  'uma semente de legume',
  'V, S, M (uma semente de legume)',
  'Concentração, até 1 minuto',
  TRUE,
  FALSE,
  'Uma linha de vento forte de 18 m de comprimento e 3 m de largura sopra de você na direção escolhida pela duração. Cada criatura que iniciar o turno na linha deve ser bem-sucedida numa salvaguarda de Força ou é empurrada 4,5 m na direção do vento. A linha dispersa gases e vapores e extingue chamas desprotegidas.

Stub PHB 2024 para lineage Ice Elf (Northlands); texto resumido.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
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

-- Option defs
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'), 'bearfolkLineageId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'), 'naturalAdaptationId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'), 'trollkinAncestryId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Bearfolk lineages
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'), 'bearfolkLineageId', 'andari', 'Andari', 1,
  'Dádiva da Natureza. Você conhece um truque à escolha da lista de Druida. Sabedoria é o atributo de conjuração.',
  'Dádiva da Natureza. Você conhece um truque à escolha da lista de Druida. Sabedoria é o atributo de conjuração.'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'), 'bearfolkLineageId', 'garhamr', 'Garhamr', 2,
  'Abraço do Urso. Ao acertar um alvo com um ataque e causar dano, pode fazer um Ataque Desarmado como Ação Bônus. Usos = mod. Constituição (mín. 1) / Descanso Longo.',
  'Abraço do Urso. Ao acertar um alvo com um ataque e causar dano, pode fazer um Ataque Desarmado como Ação Bônus. Usos = mod. Constituição (mín. 1) / Descanso Longo.'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit;

-- Beastkin adaptations
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'), 'naturalAdaptationId', 'avian', 'Aviário', 1,
  'Asas (couro, penas ou gaze) nascem das costas ou unem-se aos braços. Você tem Deslocamento de Voo igual ao Deslocamento. Não pode voar com armadura Média ou Pesada.',
  'Asas (couro, penas ou gaze) nascem das costas ou unem-se aos braços. Você tem Deslocamento de Voo igual ao Deslocamento. Não pode voar com armadura Média ou Pesada.'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'), 'naturalAdaptationId', 'agile', 'Ágil', 2,
  'Garras, cascos, membros robustos, articulações invertidas ou ventosas permitem escalar. Você tem Deslocamento de Escalada igual ao Deslocamento e Vantagem em salvaguardas para evitar a condição Caído.',
  'Garras, cascos, membros robustos, articulações invertidas ou ventosas permitem escalar. Você tem Deslocamento de Escalada igual ao Deslocamento e Vantagem em salvaguardas para evitar a condição Caído.'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'), 'naturalAdaptationId', 'aquatic', 'Aquático', 3,
  'Pelo oleoso, escamas, nadadeiras ou membranas. Você tem Deslocamento de Natação igual ao Deslocamento e pode prender a respiração por até 20 minutos.',
  'Pelo oleoso, escamas, nadadeiras ou membranas. Você tem Deslocamento de Natação igual ao Deslocamento e pode prender a respiração por até 20 minutos.'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'), 'naturalAdaptationId', 'sturdy', 'Robusto', 4,
  'Membros poderosos, reservas de gordura ou pele grossa. Sem armadura, CA = 13 + mod. Destreza. Conta como um tamanho maior para carga e peso que pode arrastar, erguer ou empurrar.',
  'Membros poderosos, reservas de gordura ou pele grossa. Sem armadura, CA = 13 + mod. Destreza. Conta como um tamanho maior para carga e peso que pode arrastar, erguer ou empurrar.'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit;

-- Giantkin ancestries
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'cloud', 'Nuvem', 1,
  $b$Resistência natural: Imunidade aos efeitos de frio extremo e alta altitude.

Passo Aéreo. Você pode conjurar Queda Suave à vontade (somente em si).

Chamado do Vento. Como Ação Bônus, o ar a 9 m move-se na direção escolhida: empurra uma criatura Média ou menor até 1,5 m, move objeto desatendido até 3 m, ou efeito sensorial inofensivo com ar.$b$,
  $b$Resistência natural: Imunidade aos efeitos de frio extremo e alta altitude.

Passo Aéreo. Você pode conjurar Queda Suave à vontade (somente em si).

Chamado do Vento. Como Ação Bônus, o ar a 9 m move-se na direção escolhida: empurra uma criatura Média ou menor até 1,5 m, move objeto desatendido até 3 m, ou efeito sensorial inofensivo com ar.$b$
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'fire', 'Fogo', 2,
  $b$Resistência natural: Imunidade aos efeitos de calor extremo.

Sangue Ardente. Como Reação ao sofrer dano Perfurante ou Cortante, uma criatura à escolha a 1,5 m faz salvaguarda de Destreza ou sofre 1d6 Ígneo. Usos = PB / Descanso Longo. O dano sobe +1d6 nos níveis 5, 11 e 17.$b$,
  $b$Resistência natural: Imunidade aos efeitos de calor extremo.

Sangue Ardente. Como Reação ao sofrer dano Perfurante ou Cortante, uma criatura à escolha a 1,5 m faz salvaguarda de Destreza ou sofre 1d6 Ígneo. Usos = PB / Descanso Longo. O dano sobe +1d6 nos níveis 5, 11 e 17.$b$
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'frost', 'Geada', 3,
  $b$Resistência natural: Imunidade aos efeitos de frio extremo; Vantagem em salvaguardas contra Atordoado.

Moldador de Gelo. Como ação, escolha gelo, neve ou água a 9 m que caiba num Cubo de 30 cm: mova até 1,5 m, forme formas simples, ou congele/descongele (sem criaturas dentro). Após 1 h ou ao usar de novo, reverte.

Visão na Neve. Enxerga através de neve, granizo e precipitação invernal sem penalidade; Imunidade à cegueira pela neve.$b$,
  $b$Resistência natural: Imunidade aos efeitos de frio extremo; Vantagem em salvaguardas contra Atordoado.

Moldador de Gelo. Como ação, escolha gelo, neve ou água a 9 m que caiba num Cubo de 30 cm: mova até 1,5 m, forme formas simples, ou congele/descongele (sem criaturas dentro). Após 1 h ou ao usar de novo, reverte.

Visão na Neve. Enxerga através de neve, granizo e precipitação invernal sem penalidade; Imunidade à cegueira pela neve.$b$
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'hill', 'Colina', 4,
  $b$Resistência natural: Vantagem em salvaguardas contra Envenenado e Atordoado.

Robusto. Vantagem em salvaguardas contra Agarrado; em sucesso, pode empurrar o iniciador 3 m.

Estômago de Ferro. Pode ingerir quase qualquer matéria orgânica; 1 kg conta como ração de um dia.$b$,
  $b$Resistência natural: Vantagem em salvaguardas contra Envenenado e Atordoado.

Robusto. Vantagem em salvaguardas contra Agarrado; em sucesso, pode empurrar o iniciador 3 m.

Estômago de Ferro. Pode ingerir quase qualquer matéria orgânica; 1 kg conta como ração de um dia.$b$
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'stone', 'Pedra', 5,
  $b$Resistência natural: Vantagem em salvaguardas contra Caído e Petrificado.

Pulso de Pedra. Vantagem em iniciativa se você e todos os inimigos estiverem tocando solo sólido.

Visão no Escuro. Alcance de 18 metros.$b$,
  $b$Resistência natural: Vantagem em salvaguardas contra Caído e Petrificado.

Pulso de Pedra. Vantagem em iniciativa se você e todos os inimigos estiverem tocando solo sólido.

Visão no Escuro. Alcance de 18 metros.$b$
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), 'giantkinAncestryId', 'storm', 'Tempestade', 6,
  $b$Resistência natural: Vantagem em salvaguardas contra dano Elétrico; Imunidade aos efeitos de alta altitude.

Personalidade Crepitante. Em área aberta ao céu, pode conjurar Levitação à vontade (somente em si).

Visão da Tempestade. Enxerga através de nuvens, névoa, chuva e tempestades sem penalidade; Imunidade à cegueira pela neve.$b$,
  $b$Resistência natural: Vantagem em salvaguardas contra dano Elétrico; Imunidade aos efeitos de alta altitude.

Personalidade Crepitante. Em área aberta ao céu, pode conjurar Levitação à vontade (somente em si).

Visão da Tempestade. Enxerga através de nuvens, névoa, chuva e tempestades sem penalidade; Imunidade à cegueira pela neve.$b$
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit;

-- Trollkin ancestries
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'), 'trollkinAncestryId', 'fey', 'Fey', 1,
  'Ao fazer um teste que use Carisma, pode rolar 1d6 e somar ao total. Usos por dia = mod. Carisma; recupera todos no Descanso Longo.',
  'Ao fazer um teste que use Carisma, pode rolar 1d6 e somar ao total. Usos por dia = mod. Carisma; recupera todos no Descanso Longo.'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'), 'trollkinAncestryId', 'ogre', 'Ogro', 2,
  'Vantagem em testes e salvaguardas para evitar ou escapar de agarres. Conta como um tamanho maior para capacidade de carga.',
  'Vantagem em testes e salvaguardas para evitar ou escapar de agarres. Conta como um tamanho maior para capacidade de carga.'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'), 'trollkinAncestryId', 'troll', 'Troll', 3,
  'Vantagem em salvaguardas contra Atordoado. Conta como um tamanho maior para capacidade de carga.',
  'Vantagem em salvaguardas contra Atordoado. Conta como um tamanho maior para capacidade de carga.'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit;

-- Elf lineages — Alfar / Ice Elf (PHB elf; edição Northlands)
INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order,
  level1_benefit, spell_level1_id, spell_level3_id, spell_level5_id,
  edition_slug
)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'alfar', 'Alfar (Elfo Oculto)', 10,
  'Você conhece o truque Ilusão Menor. Além disso, tem Vantagem em testes de Destreza (Furtividade) em florestas.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'),
  (SELECT id FROM rpg.phb_spell WHERE slug = 'imagem-silenciosa'),
  (SELECT id FROM rpg.phb_spell WHERE slug = 'embacar'),
  'northlands-heroes-2024-en'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'ice-elf', 'Elfo do Gelo', 11,
  'Você conhece o truque Raio de Gelo. Além disso, tem Vantagem em testes de Destreza (Furtividade) em condições de gelo ou neve.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-de-gelo'),
  (SELECT id FROM rpg.phb_spell WHERE slug = 'faca-de-gelo'),
  (SELECT id FROM rpg.phb_spell WHERE slug = 'sopro-de-vento'),
  'northlands-heroes-2024-en'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level1_id = EXCLUDED.spell_level1_id,
  spell_level3_id = EXCLUDED.spell_level3_id,
  spell_level5_id = EXCLUDED.spell_level5_id,
  edition_slug = EXCLUDED.edition_slug;
