-- Seed Valdas species traits
-- Apenas traços mecânicos, sem descrições de subtipo

-- Geppettin

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Visão no Escuro',
  'Você tem Visão no Escuro com alcance de 18 metros.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Natureza de Construto',
  'Você não precisa de comida, bebida ou ar. Você não precisa dormir, e a magia não pode fazer você dormir. Você pode terminar um Descanso Longo em 4 horas se passar essas horas em um estado imóvel, durante o qual mantém a consciência.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Qualidade Artesanal',
  'Seu design pode ser enervante, articulado ou amigável. Você tem proficiência na perícia Intimidação, Atuação ou Persuasão.',
  'geppettin_skill'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Construção Geppettin',
  'Para simplificar, os geppettin são classificados por seus materiais: porcelana (bisque), madeira (marionete) e tecido (pelúcia). Escolha uma das seguintes construções.',
  'geppettin_construction'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Tamanho',
  'Escolha Pequeno (cerca de 0,60–0,90 m) ou Médio (cerca de 1,80 m; apenas construção Marionete) ao selecionar esta espécie.',
  'geppettin_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Mandrágora

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Natureza Vegetal',
  'Contanto que você esteja exposto à luz solar direta por pelo menos 4 horas por dia, você não precisa comer. Além disso, você pode respirar pelas folhas e absorver água e nutrientes pelos pés.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Conexão Natural',
  'Você tem proficiência na perícia Natureza ou Sobrevivência.',
  'mandrake_skill'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Magia das Raízes',
  'Você conhece o truque Bordão Místico e pode usar a magia como alvo, tratando um de seus membros como uma clava durante a duração da magia.

Quando você atinge o nível de personagem 3, você sempre tem Bom Fruto preparado, e quando você atinge o nível de personagem 5, você sempre tem Pele-Casca preparado. Você pode lançar cada uma dessas magias sem um espaço de magia. Depois de conjurar qualquer magia dessa forma, você não poderá lançá-la dessa forma novamente até terminar um Descanso Longo. Você também pode lançar essas magias usando espaços de magia do nível apropriado. Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para as magias que você conjurou com esta característica (escolha o atributo ao selecionar esta espécie).',
  'mandrake_casting_ability'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind,
  spell_id = NULL;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Vinhas Enredantes',
  'Você pode usar uma Ação Bônus para fazer com que ervas daninhas e trepadeiras brotem do solo ao redor de uma criatura Grande ou menor que você possa ver a até 9 metros de você. Até o final do próximo turno da criatura, sua Velocidade é 0 e não pode aumentar. Este efeito termina mais cedo se a criatura substituir um de seus ataques por se libertar. Você pode usar esta Ação Bônus um número de vezes igual ao seu Bônus de Proficiência e recuperar todos os usos gastos ao terminar um Descanso Longo.

Quando você atinge o nível 3 do personagem, suas Vinhas Enredantes ganham um efeito adicional com base na estação em que você foi colhido (escolha quando selecionar esta espécie).',
  'mandrake_season'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
