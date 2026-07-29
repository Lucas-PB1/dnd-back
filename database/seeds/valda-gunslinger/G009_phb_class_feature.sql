-- Seed Pistoleiro class features + maneuvers
-- Conteúdo canônico Valda: Gunslinger

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  1,
  'Estilo de Luta',
  'Você ganha um talento Estilo de Luta à sua escolha. Se você escolher um talento, como Lutar com Armas Grandes, que exige que você segure uma arma corpo a corpo com uma ou duas mãos, você pode usar esse talento com armas de longo alcance.

Sempre que você ganha um nível de Pistoleiro, você pode substituir o talento escolhido por um talento Estilo de Luta diferente.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  1,
  'Sorteio rápido',
  'Você é adepto de sacar e atirar antes que os outros tenham tempo de reagir, o que lhe garante os seguintes benefícios.

Iniciativa. Você tem Vantagem em testes de Iniciativa.

Sorteio Duplo. Você pode sacar ou guardar duas armas que não tenham a propriedade Duas Mãos, quando normalmente seria capaz de sacar ou guardar apenas uma.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  1,
  'Maestria em Armas',
  'Seu treinamento com armas permite que você use as propriedades de maestria de dois tipos de armas de longo alcance simples ou marciais de sua escolha. Sempre que você terminar um Descanso Longo, poderá praticar exercícios com armas e alterar uma dessas opções de armas.

Ao atingir determinados níveis de Pistoleiro, você ganha a capacidade de usar as propriedades de maestria de mais tipos de armas, conforme mostrado na coluna Maestria em Armas da tabela Características do Pistoleiro.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Tiro Crítico',
  'Suas jogadas de ataque com armas de longo alcance podem pontuar Acerto Crítico em uma jogada de 19 ou 20 no d20.

No nível 9 do Pistoleiro, suas jogadas de ataque com armas de longo alcance pontuam Acerto Crítico em uma jogada de 18–20. No nível 17 do Pistoleiro, eles marcam um Acerto Crítico em um resultado de 17–20.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Risco',
  'Você pode realizar feitos incríveis de ousadia alimentados por dados especiais chamados Dados de Risco.

Dados de Risco. Você tem quatro Dados de Risco, que são d8s. Um Dado de Risco é gasto quando você o usa. Você recupera todos os Dados de Risco gastos ao finalizar um Descanso Curto ou Longo. Suas alterações no Dado de Risco e mais Dados de Risco ficam disponíveis conforme mostrado na coluna Dados de Risco da tabela Recursos do Pistoleiro.

Manobras. Você pode gastar Dados de Risco para realizar manobras. Suas opções de manobra são detalhadas posteriormente na descrição da classe.

Salvando lances. Se uma manobra exigir uma salvaguarda, a CD é igual a 8 mais seu modificador de Destreza e Bônus de Proficiência.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  3,
  'Subclasse Pistoleiro',
  'Você ganha uma subclasse Pistoleiro de sua escolha. Uma subclasse é uma especialização que concede recursos em determinados níveis de Pistoleiro. Pelo resto de sua carreira, você ganha cada uma das características de sua subclasse que sejam do seu nível de Pistoleiro ou inferior.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  4,
  'Aprimoramento de Atributo',
  'Você ganha o talento Aprimoramento de Atributo ou outro talento de sua escolha para o qual você se qualifica. Você ganha esse recurso novamente nos níveis 8, 12 e 16 do Pistoleiro.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  5,
  'Ataque Extra',
  'Você pode atacar duas vezes em vez de uma sempre que usar a ação Atacar no seu turno.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  5,
  'Tiro intestinal',
  'Sempre que você obtiver um Acerto Crítico contra uma criatura Grande ou menor com um ataque à distância usando uma arma, o projétil se aloja no alvo. Por 1 minuto ou até que o alvo substitua um de seus ataques pelo desalojamento do projétil, sua Velocidade é reduzida pela metade e ele tem Desvantagem nas jogadas de ataque.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  7,
  'Evasão',
  'Quando você está sujeito a um efeito que lhe permite fazer uma salvaguarda de Destreza para sofrer apenas metade do dano, você não sofre nenhum dano se tiver sucesso na salvaguarda e apenas metade do dano se falhar.

Você não se beneficia desse recurso se tiver a condição Incapacitado.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  11,
  'Exagero',
  'Quando você causa dano com uma arma de longo alcance que não adiciona seu modificador de habilidade à rolagem, você adiciona seu modificador de habilidade mesmo assim. Se você já adicionou seu modificador à jogada de dano, o alvo sofre 1d8 de dano extra do tipo da arma.

Observe que as armas que possuem a propriedade arma de fogo não adicionam seu modificador de habilidade às jogadas de dano.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  13,
  'Trapacear a morte',
  'Quando você é reduzido a 0 Pontos de Vida e não é morto imediatamente, você pode cair para 1 Ponto de Vida e recuperar um número de Pontos de Vida igual ao seu nível de Pistoleiro.

Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Curto ou Longo.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  15,
  'Gambito Terrível',
  'Sempre que você rola Iniciativa ou obtém um Acerto Crítico, você recupera um Dado de Risco gasto.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  18,
  'Manobra hábil',
  'Você ganha uma Ação Bônus adicional especial que pode realizar uma vez em cada um dos seus turnos. Você pode realizar esta Ação Bônus especial apenas para usar uma manobra.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  19,
  'Dádiva Épica',
  'Você ganha um talento Dádiva Épica ou outro talento de sua escolha para o qual você se qualifica. Dádiva da Ofensa Irresistível é recomendada.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  20,
  'Tiro na cabeça',
  'Quando você marca um Acerto Crítico contra uma criatura usando uma arma de longo alcance, você pode escolher que seja um tiro na cabeça. Se a criatura tiver menos de 100 Pontos de Vida, ela morre. Caso contrário, sofre 10d10 de dano extra do tipo da arma.

Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Curto ou Longo. Você também pode restaurar o uso dele gastando três Dados de Risco (nenhuma ação necessária).'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Manobra: Morda a Bala',
  'Como Ação Bônus, você pode gastar um Dado de Risco para ganhar Pontos de Vida Temporáriossss igual ao número lançado no dado mais seu nível de Pistoleiro.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Manobra: Fogo cego',
  'Você pode realizar uma Ação Bônus e gastar um Dado de Risco para ganhar Visão Cega com um alcance de 30 pés até o final do turno atual.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Manobra: Rolamento Evasivo',
  'Você pode gastar um Dado de Risco como uma Ação Bônus para se mover até 15 pés e recarregar qualquer arma de longo alcance que estiver segurando. Este movimento não provoca Ataques de Oportunidade e não é afetado por Terreno Difícil.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Manobra: Tiro Rasante',
  'Quando você erra uma jogada de ataque à distância usando uma arma, você pode gastar um Dado de Risco (nenhuma ação necessária) para causar dano àquela criatura igual a uma jogada do dado mais seu modificador de Destreza (mínimo de 1). Este dano é do mesmo tipo causado pela arma, e o dano só pode ser aumentado aumentando o modificador de habilidade. Você só pode usar esta manobra uma vez por turno.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Manobra: Espírito Independente',
  'Quando você falha em um teste de habilidade ou salvaguarda de Inteligência, Sabedoria ou Carisma, você pode gastar um Dado de Risco para adicioná-lo ao teste, potencialmente transformando-o em um sucesso. Você só pode usar esta manobra uma vez por turno.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Manobra: Por um Triz',
  'Quando uma criatura que você pode ver atinge você com uma jogada de ataque, você pode realizar uma Reação e gastar um Dado de Risco para se esquivar e sair do caminho do perigo. Jogue o dado e some o número obtido à sua CA contra este ataque, potencialmente fazendo com que ele erre.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;
