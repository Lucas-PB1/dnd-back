-- Seed Valda species traits
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Visão no escuro',
  'Visão no escuro. Você tem Visão no Escuro com alcance de 60 pés.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Construir a Natureza',
  'Construa a Natureza. Você não precisa de comida, bebida ou ar. Você não precisa dormir, e a magia não pode fazer você dormir. Você pode terminar um Descanso Longo em 4 horas se passar essas horas em um estado imóvel, durante o qual mantém a consciência.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Qualidade artesanal',
  'Qualidade artesanal. Seu design pode ser enervante, articulado ou amigável. Você tem proficiência nas perícias Intimidação, Atuação ou Persuasão.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Gepettin Construções',
  'Construção Gepettin. Para simplificar, os geppettin são classificados por seus materiais: bisque são de porcelana, marionetes são de madeira e peluches são feitos de tecido. Escolha uma das seguintes construções.

Bisque. Você é indistinguível de uma boneca de porcelana até o momento em que ataca. Sempre que você causa dano a uma criatura com uma jogada de ataque com arma em seu primeiro turno de combate, a criatura sofre dano extra igual ao seu Bônus de Proficiência. O dano é do mesmo tipo causado pela arma.

Marionete. Cordas soltas pendem de seus membros articulados. Durante o seu turno, seu alcance é 5 pés maior com qualquer arma corpo a corpo que não tenha as propriedades Alcance, Duas Mãos e Versátil.

Pelúcia. Você está cheio de penugem. Ao sofrer dano Contundente, você pode realizar uma Reação para ganhar Resistência ao dano desencadeado. Você também é derrubado a 5 pés da fonte do dano. Você não pode realizar esta Reação se não puder ser afastado da fonte do dano.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Bisques',
  'Bisque geppettin é uma forma de boneca de porcelana, feita com especificações exatas e materiais de roupas luxuosos. Embora sejam projetados para parecerem o mais realistas possível, eles costumam ser os geppettin mais aterrorizantes devido ao seu rosto sem vida.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Marionetas',
  'Os marionetes geppettin são feitos principalmente de madeira, com rostos pintados e roupas esculpidas. Devido à sua construção, seus membros articulados são bastante flexíveis e são conhecidos por serem dançarinos fantásticos. As maiores marionetes, chamadas manequins, são tão altas quanto um ser humano e apresentam rostos completamente vazios e inexpressivos.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Peluches',
  'Peluches, também chamados de trapos, são qualquer forma de geppettin recheado ou macio. Embora muitas vezes pareçam Humanoide, eles também podem se parecer com animais, monstros ou qualquer outra criatura antropomórfica.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Natureza vegetal',
  'Natureza Vegetal. Contanto que você esteja exposto à luz solar direta por pelo menos 4 horas por dia, você não precisa comer. Além disso, você pode respirar pelas folhas e absorver água e nutrientes pelos pés.',
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
  'Conexão Natural. Você tem proficiência na perícia Natureza ou Sobrevivência.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Magia Raiz',
  'Magia Raiz. Você conhece o truque Shillelagh e pode usar a magia como alvo, tratando um de seus membros como uma clava durante a duração da magia.

Quando você atinge o nível de personagem 3, você sempre tem Goodberry preparado, e quando você atinge o nível de personagem 5, você sempre tem Barkskin preparado. Você pode lançar cada uma dessas magias sem um espaço de magia. Depois de conjurar qualquer magia dessa forma, você não poderá lançá-la dessa forma novamente até terminar um Descanso Longo. Você também pode lançar esses magias usando espaços de magia do nível apropriado. Inteligência, Sabedoria ou Carisma é sua habilidade de conjuração para as magias que você conjurou com esta característica (escolha a habilidade ao selecionar esta espécie).',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Vinhas Enredadas',
  'Enredando Vinhas. Você pode usar uma Ação Bônus para fazer com que ervas daninhas e trepadeiras brotem do solo ao redor de uma criatura grande ou menor que você possa ver a até 30 pés de você. Até o final do próximo turno da criatura, sua Velocidade é 0 e não pode aumentar. Este efeito termina mais cedo se a criatura substituir um de seus ataques por se libertar. Você pode usar este Ação Bônus um número de vezes igual ao seu Bônus de Proficiência e recuperar todos os usos gastos ao terminar um Descanso Longo.

Quando você atinge o nível 3 do personagem, suas Vinhas Enredantes ganham um efeito adicional com base na estação em que você foi colhida (escolha quando selecionar esta espécie):

Primavera. Suas Vinhas Enredantes podem atingir uma criatura aérea a até 30 pés do solo, que é puxada com segurança para o solo quando você usa esta característica.

Verão. Suas vinhas enredadas podem mover o alvo até 10 pés para um espaço desocupado no chão ou no chão.

Outono. Suas Vinhas Enredantes podem afetar uma segunda criatura a até 5 pés do primeiro alvo.

Inverno. O alvo sofre dano Gélido igual ao seu Bônus de Proficiência.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;
