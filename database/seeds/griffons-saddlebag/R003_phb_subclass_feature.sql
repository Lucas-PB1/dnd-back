-- Seed Griffon's Saddlebag Book One — subclass features (Part II)
-- 63 features; fonte: docs/source/gsb1-part-ii-character-options-extract.json

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  3,
  'Permafrost',
  'Sua pele fica gelada ao toque, manifestando o poço frio e paciente dentro de você.

Carne Gelada. Sem armadura, você recebe +1 na CA.

Extensão de Fúria. Quando sua Fúria terminaria e você não estiver Inconsciente, pode estendê-la (sem ação). Usos = mod. Constituição (mín. 1); recupera todos no Descanso Longo.

Resistência. Você tem Resistência a dano Gélido.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  3,
  'Geladura',
  'Enquanto a Fúria estiver ativa, uma vez por turno você pode liberar frio implacável ao acertar com ataque baseado em Força. O alvo sofre 1d6 de dano Gélido extra (2d6 no nível 9 de Bárbaro; 3d6 no 16).

Quando uma criatura sofre dano Gélido assim, a Velocidade dela cai 3 m até o início do seu próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  6,
  'Fortaleza Gelada',
  'Ao entrar em Fúria sem armadura, sua pele ganha camada protetora de gelo: PV temporários = 1d12 + mod. Constituição.

Como Ação Bônus nos turnos seguintes enquanto a Fúria durar, pode gastar um Dado de Vida para ganhar esses PV temporários de novo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  10,
  'Sono Profundo',
  'Pode entrar em hibernação profunda num Descanso Longo. Fica gelado ao toque e parece morto a inspeção e magias que determinem seu estado. Ruído não o acorda.

Desperta após 6 horas, ao sofrer dano ou quando alguém usa ação para esbofeteá-lo. Se completar 6 horas contínuas, recebe benefícios de Descanso Longo e um pool especial de Dados de Vida ( = mod. Constituição, mín. 1) de Bárbaro até o próximo Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  14,
  'Pisoteio Avalanche',
  'Como ação Mágica, pode pisotear o chão e enviar tremor. Cada criatura escolhida numa Emanação de 4,5 m centrada em você faz salvaguarda de Destreza (CD 8 + mod. Força + PB). Em falha: dano Contundente = 3d6 + mod. Força e condição Caído.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'),
  3,
  'Movimento Rápido',
  'Sua Velocidade aumenta 3 m. Aumenta mais 1,5 m no nível 6 de Bardo (total +4,5 m) e no 14 (+6 m).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'),
  3,
  'Dança Inspiradora',
  'Como Ação Bônus, gaste uma Inspiração de Bardo para dançar e reanimar criatura à vista. Role o dado de Inspiração; ela ganha PV temporários = resultado + mod. Carisma (mín. 2). Ao ganhar PV temporários assim, pode usar Reação para se mover até a Velocidade sem provocar Ataques de Oportunidade ou fazer a ação Esquivar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'),
  6,
  'Movimento Encantador',
  'Movimentos tão graciosos que inimigos frios sentem remorso por interromper sua dança. Quando uma criatura acerta você com Ataque de Oportunidade ou ataque enquanto você se beneficia de Esquivar, sofre dano Psíquico = mod. Carisma + metade do nível de Bardo (arred. p/ baixo).

Você sempre tem Enfeitiçar Pessoa preparada e pode conjurá-la sem componente Verbal. Com este recurso, conjura sem gastar espaço como magia de 3º círculo; alvos não têm Vantagem na salvaguarda por combate. 1× / Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-choreography'),
  14,
  'Dança Infinita',
  'Quando uma criatura ganharia PV temporários de Dança Inspiradora, pode usar Reação para fazer um ataque com arma ou Ataque Desarmado.

Além disso, pode Esquivar como Ação Bônus; sempre que usar Ação Bônus para gastar dado de Inspiração, pode Esquivar como parte dessa Ação Bônus.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'),
  3,
  'Magias do Domínio Astral',
  'Sua conexão divina garante magias sempre preparadas conforme a tabela do Domínio Astral (níveis de Clérigo 3, 5, 7 e 9).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'),
  3,
  'Criar Vazio',
  'Como Ação Bônus, gaste Canalizar Divindade para abrir rasgo planar em ponto à vista a até 18 m, criando vácuo numa Esfera de 4,5 m de raio. Cada criatura na área faz salvaguarda de Destreza. Em falha: dano de Força = 1d8 + nível de Clérigo e é puxada até 4,5 m em direção ao ponto. Em sucesso: metade do dano. O rasgo some em seguida.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'),
  3,
  'Alcance Planar',
  'Pode criar e alcançar breves buracos na realidade. Ao conjurar magia de alcance Toque, pode torná-la alcance 9 m. Usos = mod. Sabedoria (mín. 1) / Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'),
  6,
  'Troca Espacial',
  'Sempre tem Passo Nebuloso preparado. Pode conjurá-lo gastando Canalizar Divindade em vez de espaço. Ao conjurar assim, pode escolher espaço a até 9 m ocupado por criatura voluntária e trocar de lugar; falha se não houver espaço para ambos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'),
  17,
  'Troca Suprema',
  'Troca Espacial melhora:

• Sempre que conjurar Passo Nebuloso, pode trocar com criatura voluntária, mesmo usando espaço.

• Ao conjurar Passo Nebuloso com Canalizar Divindade, pode escolher criatura involuntária a até 9 m; ela faz salvaguarda de Carisma contra sua CD de magia ou a troca falha e o uso de Canalizar Divindade é perdido.

• Ao trocar de lugar com sucesso via Canalizar Divindade, pode conjurar magia de círculo 0–5 de alcance Toque como parte da mesma Ação Bônus, mirando a criatura com quem trocou.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
  3,
  'Bordão Místico Aprimorado',
  'Ao conjurar Bordão Místico, pode imbuir qualquer arma corpo a corpo que segure; pode manter o dado de dano normal em vez de d8. Pode usar qualquer arma com proficiência como foco de conjuração.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
  3,
  'Magias do Círculo Inquebrável',
  'Magias sempre preparadas conforme tabela (níveis de Druida 3, 5, 7 e 9).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
  3,
  'Recuperação Selvagem',
  'Como Ação Bônus, gaste uma Forma Selvagem para recuperar PV = 2d6 + nível de Druida (+1d6 no nível 10; +2d6 no 14).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
  6,
  'Maestria do Bordão',
  'Com arma sob efeito de Bordão Místico, pode atacar duas vezes com ela ao usar a ação Atacar. +1 em ataques e dano com essa arma (+2 no nível 10; +3 no 14). Se a arma já tiver bônus, escolha qual usar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
  10,
  'Druida de Guerra',
  'Ao usar a ação Atacar, pode substituir um ataque por conjuração de um truque de Druida com tempo de conjuração de ação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-unbroken-circle'),
  14,
  'Armadura da Natureza',
  'Sempre sob efeito de Pele-Casca.

No início de cada turno, ganha PV temporários = metade do nível de Druida (arred. p/ baixo). Ao assumir Forma Selvagem, ganha PV temporários = nível de Druida + metade do nível (arred. p/ baixo).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
  3,
  'Agente de Misericórdia',
  'Reservatório de magia positiva representado por Dados de Misericórdia (veja tabela por nível de Guerreiro). Recupera todos no Descanso Curto ou Longo.

Presença Benevolente. Em testes de Intuição ou Carisma (Atuação/Persuasão), pode gastar Dados de Misericórdia e somá-los.

Golpe Implacável. Uma vez por turno ao acertar com arma ou Ataque Desarmado, gaste um dado para dano Radiante extra = valor do dado.

Proteção Pacífica. Como Ação Bônus, gaste um dado: PV temporários = dado + mod. Carisma (mín. 1).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
  3,
  'Um do Povo',
  'Proficiência em Intuição e Persuasão. Ao reduzir criatura a 0 PV com ataque corpo a corpo ou à distância, pode nocauteá-la (1 PV, Inconsciente, inicia Descanso Curto) até recuperar PV ou alguém prestar primeiros socorros (Medicina CD 10).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
  7,
  'Portador de Paz',
  'Dano com arma ou Ataque Desarmado pode ser Radiante ou tipo normal.

Sempre tem Acalmar Emoções e Santuário preparadas (Carisma, sem componentes Somático/Material). Cada uma 1× sem espaço / Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
  10,
  'Mente Calma',
  'Ao persuadir criatura a desescalar violência, recupera um Dado de Misericórdia (um por criatura afetada). Imunidade a Enfeitiçado e Amedrontado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
  15,
  'Paragono',
  'Como Ação Bônus, ordene criatura à vista a até 9 m e gaste um Dado de Misericórdia. Se ouvir você: PV temporários = dado + mod. Carisma (mín. 1) e Reação para mover metade da Velocidade sem provocar oportunidade e atacar. Dano nocauteante em vez de matar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'),
  18,
  'Executor Heráldico',
  'Pode usar Golpe Implacável uma vez por turno sem gastar dado; se o fizer, pode usar de novo no turno gastando dado normalmente.

Ao nocautear em vez de matar, o alvo permanece Inconsciente por 8 h ou até você/aliado sacudi-lo, mesmo se recuperar PV ou receber primeiros socorros.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'),
  3,
  'Conexão Celestial',
  'Telepatia com qualquer criatura à vista a até 9 m. Não precisa compartilhar idioma, mas ela deve entender ao menos um. Não concede resposta telepática.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'),
  3,
  'Golpe de Busca da Alma',
  'Ao tocar ou acertar com Ataque Desarmado, gaste 1 Ponto de Foco (sem ação) para sondar a alma até o fim do seu próximo turno (ou 1 min fora de combate): emoções e desejo mais óbvio; à critério do Mestre, PV ou fragmento de história. Vantagem no próximo ataque e em Intuição contra o alvo.

Ao acertar com ataque de Rajada de Golpes, pode usar sem gastar Ponto de Foco.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'),
  6,
  'Foco Estabilizador',
  'Como ação Mágica, toque criatura Ferida e gaste 1+ Pontos de Foco: cada ponto restaura 5 PV (máx. metade do máximo de PV). Pode gastar 2 pontos para conjurar Aprimorar Atributo, Restauração Menor ou Proteção Contra o Bem e o Mal sem espaço ou material (Sabedoria).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'),
  11,
  'Emissário Celestial',
  'Sempre tem Sonho e Vidência preparadas (Sabedoria). 1× cada sem espaço/material / Descanso Longo. Sonho: só você pode ser mensageiro.

Em acerto com Vantagem, dano Radiante extra = um dado de Artes Marciais. Usos = mod. Sabedoria (mín. 1) / Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-celestial'),
  17,
  'Celestial Ascendente',
  'Energia entrelaçada com magia celestial ofensiva e curativa.

Foco Estabilizador Aprimorado. Pode usar como Ação Bônus; alvo Ferido a até 9 m em vez de toque.

Voo Limitado. Deslocamento de Voo = Velocidade; cai se terminar o turno no ar sem suporte.

Golpe da Alma. Ataques Desarmados causam +1d4 Radiante.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'),
  3,
  'Magias do Juramento da Lareira',
  'Magias sempre preparadas conforme tabela (níveis de Paladino 3, 5, 9, 13 e 17).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'),
  3,
  'Arma Flamejante',
  'Na ação Atacar, gaste Canalizar Divindade para incendiar uma arma corpo a corpo: por 10 min ou até usar de novo, dano Ígneo extra = mod. Carisma (mín. 1) por acerto; pode escolher tipo normal ou Ígneo. Emite Luz Plena num raio de 6 m e Meia-luz por mais 6 m.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'),
  7,
  'Aura de Calor',
  'Você e aliados na Aura de Proteção têm Resistência a dano Gélido e Ígneo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'),
  15,
  'Proteção Isolante',
  'Ao conjurar magia de Paladino de círculo 1+ com espaço ou sem espaço via recurso de Paladino, você e aliados na Aura de Proteção ganham PV temporários = círculo da magia + mod. Carisma (mín. 2).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'),
  20,
  'Espírito Flamejante',
  'Como Ação Bônus, por 10 min (ou até encerrar): 1× / Descanso Longo (ou restaurar gastando espaço de 5º círculo).

Luz Ígnea. Luz Plena preenche a Aura de Proteção e Meia-luz por mais 9 m.

Passos Ligeiros. Velocidade +3 m; pode atravessar e terminar em espaço ocupado sem Caído.

Chama Vingativa. No fim de cada turno, criaturas escolhidas numa Emanação de 3 m sofrem dano Ígneo = 2× mod. Carisma (mín. 2).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'),
  3,
  'Fixar',
  'Uma vez por turno ao acertar, dano extra = 1d6 do tipo do ataque e Velocidade do alvo cai 3 m até o início do seu próximo turno. No nível 11: 1d8 e alvo não pode fazer Ataques de Oportunidade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'),
  3,
  'Magia do Caçador Invernal',
  'Magias sempre preparadas conforme tabela (níveis de Patrulheiro 3, 5, 9, 13 e 17).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'),
  7,
  'Predador Ártico',
  'Presa Indefesa. Sem Desvantagem por Caído em alvos Caídos a mais de 1,5 m.

Caminhante do Gelo. Terreno difícil de gelo/neve não custa movimento extra; Vantagem em Furtividade em gelo/neve.

Pé Firme. Não pode estar Caído salvo se também Incapacitado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'),
  11,
  'Armadilha Mágica',
  'Como Ação Bônus, cria armadilha imperceptível no chão. Primeira criatura Grande ou menor (exceto você/designados) que entrar no espaço no próximo minuto: salvaguarda de Destreza vs. CD de magia. Falha: 2d8 Perfurante e Velocidade 0 até fim do seu próximo turno. Metade do dano em sucesso. Usos = mod. Sabedoria (mín. 1) / Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'),
  15,
  'Defesas Tropeçadas',
  'Quando criatura a até 1,5 m erra ataque contra você, Reação para desequilibrá-la: Grande ou menor fica Caída; senão Velocidade reduzida pela metade até fim do turno (salvo Imunidade a Caído). Depois, ataque ou move metade da Velocidade sem provocar oportunidade dela.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'),
  3,
  'Impressionista',
  'Perícia em Suprimentos de Calígrafo e Pintor; nunca fica sem pincéis. Como ação Mágica, cria suprimentos numa mão livre e tinta ou tinta de qualquer cor. Objetos somem se saírem de você ou se recriar.

Ao terminar marca com tinta, pode imbuir efeito de Mensagem: marca brilha (Meia-luz 1,5 m); quem tocar ouve a mensagem telepática e a marca perde o efeito.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'),
  3,
  'Runas',
  '4 Pontos de Runa; recupera no Descanso Curto ou Longo. Ao acertar corpo a corpo, gaste 1 ponto para marcar criatura por até 1 min (some se apagada com ação).

Cryos: alvo não pode fazer Reações até início do seu próximo turno.

Hexxus: Reação quando alvo passa em teste/ataque a até 18 m: −1d6 no resultado.

Locus: próximo ataque contra o alvo tem Vantagem; se acertar, +1d6 Ácido.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'),
  9,
  'Artista da Fuga',
  'Vantagem em testes/salvaguardas para evitar ou encerrar Agarrado/Restringido. Pode escapar como Ação Bônus se normalmente exigiria ação.

A até 1,5 m de superfície sólida, Ação Bônus + 1 Ponto de Runa: Invisível por 10 min (termina ao atacar, causar dano, conjurar ou sair do espaço).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'),
  13,
  'Engenhoso',
  'Na Iniciativa, recupera Pontos de Runa até ter 2 se tiver menos. Ao usar Ataque Furtivo com efeito de Golpe Astuto, pode gastar Pontos de Runa para reduzir dados de dano trocados por efeito (1 ponto = −1 dado).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'),
  17,
  'Tinta de Chumbo',
  'Contra alvo marcado ou ao marcar com runa no ataque, não precisa de Vantagem nem aliado a 1,5 m para Ataque Furtivo (salvo se tiver Desvantagem). Ataque Furtivo +2d6.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'),
  3,
  'Criar Gelo',
  'Tocando superfície sólida, Ação Bônus: gelo em até cinco quadrados de 1,5 m contíguos a partir do ponto tocado. Terreno difícil até fim do seu próximo turno. Gaste Pontos de Feitiçaria para +5 quadrados contíguos por ponto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'),
  3,
  'Magias Glaciais',
  'Magias sempre preparadas conforme tabela (níveis de Feiticeiro 3, 5, 7 e 9).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'),
  3,
  'Corpo Congelado',
  'Pele com brilho cristalino. PV máximo +3 (+1 por nível de Feiticeiro). Terreno difícil de gelo/neve não custa extra; em gelo, 1 m de movimento por cada 2 m.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'),
  6,
  'Coração Gelado',
  'Criomancia. Ao causar dano Gélido com magia em criatura Grande ou menor, gaste Pontos de Feitiçaria: −4,5 m de Velocidade por ponto até fim do turno dela; se Velocidade 0, +2d6 Gélido.

Congelar Água. Criar Gelo também funciona em água (5 m de profundidade, Cubo de 1,5 m).

Resistência a dano Gélido.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'),
  14,
  'Congelamento Súbito',
  'Movimento no gelo não provoca oportunidade. Reação quando criatura a 1,5 m acerta você: dano Gélido = mod. Carisma + metade do nível de Feiticeiro; pode usar Criar Gelo como parte da Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'frost-sorcery'),
  18,
  'Alma Congelada',
  'Imunidade a dano Gélido; Resistência a Ígneo. Sempre tem Muralha de Gelo preparada, sem componente material; 1× sem espaço / Descanso Longo (painéis planos não precisam ser contíguos).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
  3,
  'Magias do Grifo Astral',
  'Magias sempre preparadas conforme tabela (níveis de Bruxo 3, 5, 7 e 9).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
  3,
  'Míssil Astral',
  'Conjura Mísseis Mágicos sem espaço usos = mod. Carisma (mín. 1) / Descanso Longo. Dardos podem mirar alvo invisível; se fora de alcance, voam erraticamente e somem por rasgo planar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
  3,
  'Acuidade Extradimensional',
  'Bolso dimensional permanente: até 22 kg de material inanimado, volume máx. ~28 L, acessível pelas mãos. Colocar Bolsa de Holding, Haversack ou Buraco Portable destrói o item e espalha conteúdos no Astral; bolso inacessível por 7 dias.

Sente espaços extradimensionais (exceto o seu) a até 18 m (não revela quantidade/local).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
  6,
  'Escape Planar',
  'Reação ao sofrer dano: metade do dano, desaparece em semiplano inofensivo sobreposto ao plano atual. Percebe o plano de origem e move-se normalmente, imperceptível lá. Permanece até fim do seu próximo turno ou retorno voluntário. 1× / Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
  10,
  'Maestria Extradimensional',
  'Clareza Astral. Ação Mágica: por 10 min, Vantagem em Percepção visual e Visão Verdadeira 9 m. Usos = mod. Carisma (mín. 1) / Descanso Longo.

Espião Mágico. A 3 m de item com espaço extradimensional, sente conteúdo.

Resistência a dano de Força.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'),
  14,
  'Bolseiro',
  'Bolso dimensional: até 113 kg, ~280 L. Ação Mágica: envia objeto à vista a até 9 m (não vestido) ao bolso; se não couber, falha. Se carregado por criatura, salvaguarda de Sabedoria vs. CD de magia. Objeto retorna no fim do seu próximo turno se não recuperado. 1× em objeto carregado / Descanso Curto ou Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
  3,
  'Artesão Arcano',
  'Truque Bônus. Conhece Reparar; se já conhece, aprende outro truque de Mago (não conta no limite).

Perito em Criação. Proficiência em três Ferramentas de Artesão; troca uma por outra ao fim de cada Descanso Longo.

Ofício Arcano. Ao craftar com ferramenta proficiente, subtrai mod. Inteligência (mín. 1) das horas diárias (mín. 2 h/dia).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
  3,
  'Criação Menor',
  'Ao conjurar magia de círculo 1+, cria Cubo de material inanimado até 1,5 m de lado a até 9 m (18 m no nível 10). Peso ≈ 5× comprimento do lado em kg; suporta 10× peso. Máximo de Cubos = nível de Mago. Dispersa com Ação Bônus ou após 1 h/dano. CA = 10 + mod. Int; 1 PV; Imunidade a Força.

Detonação. Ao dispersar, pode detonar: salvaguarda de Destreza vs. CD de magia em raio de 3 m, dano Força = 1d6 + metade do nível de Mago. Usos de detonação = mod. Int (mín. 1) / Descanso Longo; restaura com espaço de círculo 1+.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
  6,
  'Aprimoramento Material',
  'Ação Mágica: toque arma, armadura ou objeto. Até fim do próximo Descanso Curto/Longo, torna mágico com até 2 benefícios entre: +1 ataque/dano em arma (+2 no 10; +3 no 14); +1 CA em armadura (+2/+3); armadura sem Desvantagem em Furtividade; luz 6 m/6 m; peso reduzido pela metade; cores/texturas; objeto arremessado volta à mão.

2 usos por benefício; recupera no Descanso Curto/Longo. Mesmo benefício não repete até recuperar usos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
  10,
  'Desmaterializar',
  'Magias causam dano dobrado a objetos e estruturas; construtos sofrem +1d8 Força.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'),
  14,
  'Rematerializar',
  'Reação ao ver objeto ou estrutura Grande ou menor não mágico destruído a até 18 m: destroços somem. Até 8 h depois, ação Mágica recria intacto a até 18 m. Se no ar, cai; criatura abaixo: salvaguarda de Destreza vs. CD de magia, dano Contundente por queda (P/M/G: 1d6/2d6/3d6). 1× / Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

