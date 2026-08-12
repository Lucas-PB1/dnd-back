-- Opções de espécie Eldritch Hunt (Manikin / Scourgeborne)

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'armorPresetId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'serviceModelId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'madnessId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'monstrousLineageId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit)
VALUES
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'armorPresetId', 'infiltrator', 'Infiltrador', 1,
    'Sua Classe de Armadura base é igual a 11 + seu modificador de Destreza. Você é considerado sem armadura para efeitos que exigem que você não esteja vestindo armadura. Você tem Vantagem em testes de Destreza (Furtividade).',
    'Sua Classe de Armadura base é igual a 11 + seu modificador de Destreza. Você é considerado sem armadura para efeitos que exigem que você não esteja vestindo armadura. Você tem Vantagem em testes de Destreza (Furtividade).'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'armorPresetId', 'sentinel', 'Sentinela', 2,
    'Sua Classe de Armadura base é igual a 13 + seu modificador de Destreza (máximo 2) ou de Força (máximo 3). Você é considerado vestindo armadura Média. Sem treinamento em armadura Média, sofre as penalidades associadas.',
    'Sua Classe de Armadura base é igual a 13 + seu modificador de Destreza (máximo 2) ou de Força (máximo 3). Você é considerado vestindo armadura Média. Sem treinamento em armadura Média, sofre as penalidades associadas.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'armorPresetId', 'tormentor', 'Tormentador', 3,
    'Sua Classe de Armadura base é igual a 16 + seu modificador de Força (máximo 2). Você é considerado vestindo armadura Pesada. Sem treinamento em armadura Pesada, sofre as penalidades associadas. Você tem Desvantagem em testes de Destreza (Furtividade).',
    'Sua Classe de Armadura base é igual a 16 + seu modificador de Força (máximo 2). Você é considerado vestindo armadura Pesada. Sem treinamento em armadura Pesada, sofre as penalidades associadas. Você tem Desvantagem em testes de Destreza (Furtividade).'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'serviceModelId', 'custodian', 'Custódio', 1,
    'Você tem Vantagem em qualquer teste de atributo para encerrar a condição Agarrado. Também conta como um tamanho maior ao determinar capacidade de carga. Além disso, quando uma criatura a até 1,5 m de você for alvo de um ataque, você pode gastar uma Reação para saltar à frente: se a criatura for voluntária, trocam de lugar e você se torna o alvo. Você pode usar esta Reação um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.',
    'Você tem Vantagem em qualquer teste de atributo para encerrar a condição Agarrado. Também conta como um tamanho maior ao determinar capacidade de carga. Além disso, quando uma criatura a até 1,5 m de você for alvo de um ataque, você pode gastar uma Reação para saltar à frente: se a criatura for voluntária, trocam de lugar e você se torna o alvo. Você pode usar esta Reação um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'serviceModelId', 'handler', 'Manipulador', 2,
    'Você adquire proficiência na perícia Furtividade e com o Kit de Disfarce. Além disso, pode ter até duas armas Corpo a Corpo embutidas no corpo; cada uma deve ter a propriedade Acuidade ou Leve. Ao longo de 1 hora (pode ser durante um Descanso Curto), você pode remover uma ou ambas e trocá-las por outras armas adequadas que estiver segurando. Empunhar ou guardar armas embutidas funciona como armas normais. Você não pode ser desarmado delas, salvo se tiver os braços cortados.',
    'Você adquire proficiência na perícia Furtividade e com o Kit de Disfarce. Além disso, pode ter até duas armas Corpo a Corpo embutidas no corpo; cada uma deve ter a propriedade Acuidade ou Leve. Ao longo de 1 hora (pode ser durante um Descanso Curto), você pode remover uma ou ambas e trocá-las por outras armas adequadas que estiver segurando. Empunhar ou guardar armas embutidas funciona como armas normais. Você não pode ser desarmado delas, salvo se tiver os braços cortados.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), 'serviceModelId', 'thespian', 'Teatral', 3,
    'Você adquire proficiência na perícia Atuação. Como Ação Bônus, pode formar conexão consigo e uma criatura voluntária que possa ver a até 9 m via cordas imateriais por 1 hora. Se a criatura conectada não usar todo o deslocamento no turno (se tiver vários, use o maior), você pode gastar uma Reação no fim do turno dela para se mover um número de metros igual ao deslocamento restante dela. Depois de formar uma conexão assim, não pode fazê-lo novamente até terminar um Descanso Curto ou Longo.',
    'Você adquire proficiência na perícia Atuação. Como Ação Bônus, pode formar conexão consigo e uma criatura voluntária que possa ver a até 9 m via cordas imateriais por 1 hora. Se a criatura conectada não usar todo o deslocamento no turno (se tiver vários, use o maior), você pode gastar uma Reação no fim do turno dela para se mover um número de metros igual ao deslocamento restante dela. Depois de formar uma conexão assim, não pode fazê-lo novamente até terminar um Descanso Curto ou Longo.'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'madnessId', 'good', 'Alinhamento Bom', 1,
    'Sua convicção concede controle sobre os impulsos mais obscuros. Você tem Vantagem em salvaguardas para evitar ou encerrar a condição Enfeitiçado, mas tem Desvantagem em testes de Carisma (Intimidação).',
    'Sua convicção concede controle sobre os impulsos mais obscuros. Você tem Vantagem em salvaguardas para evitar ou encerrar a condição Enfeitiçado, mas tem Desvantagem em testes de Carisma (Intimidação).'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'madnessId', 'evil', 'Alinhamento Mau', 2,
    'Você deixa o monstro depravado interior influenciá-lo. Ganha um bônus em salvaguardas de Destreza igual ao seu Bônus de Proficiência, mas tem Desvantagem em salvaguardas para evitar ou encerrar a condição Enfeitiçado. (Também aumenta o dado de Membros Ferais para d8.)',
    'Você deixa o monstro depravado interior influenciá-lo. Ganha um bônus em salvaguardas de Destreza igual ao seu Bônus de Proficiência, mas tem Desvantagem em salvaguardas para evitar ou encerrar a condição Enfeitiçado. (Também aumenta o dado de Membros Ferais para d8.)'
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'monstrousLineageId', 'aranea', 'Aranea', 1,
    $b$Nível 1: Você tem Deslocamento de Escalada de 9 m. Enquanto estiver na água, tem Desvantagem em todos os testes de atributo e jogadas de ataque.
Nível 3: Você pode escalar superfícies difíceis, inclusive tetos, sem fazer teste de atributo. Depois de usar este traço por 1 minuto, não pode fazê-lo novamente até terminar um Descanso Longo.
Nível 5: Você pode usar o traço de nível 3 por um número de minutos igual ao seu Bônus de Proficiência e recupera todos os minutos gastos ao terminar um Descanso Longo.$b$,
    $b$Nível 1: Você tem Deslocamento de Escalada de 9 m. Enquanto estiver na água, tem Desvantagem em todos os testes de atributo e jogadas de ataque.
Nível 3: Você pode escalar superfícies difíceis, inclusive tetos, sem fazer teste de atributo. Depois de usar este traço por 1 minuto, não pode fazê-lo novamente até terminar um Descanso Longo.
Nível 5: Você pode usar o traço de nível 3 por um número de minutos igual ao seu Bônus de Proficiência e recupera todos os minutos gastos ao terminar um Descanso Longo.$b$
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'monstrousLineageId', 'belua', 'Belua', 2,
    $b$Nível 1: Você tem Vantagem em testes de Sabedoria (Percepção) que dependam de audição ou olfato. Sempre que causar a uma criatura a condição Ensanguentado, você sofre 1d4 de dano Psíquico ao tentar reter a sanidade.
Nível 3: Como Ação Bônus, pode fazer um Ataque Desarmado para alimentar-se de uma criatura ao alcance. No acerto, recupera Pontos de Vida iguais ao dano causado. Depois de usar este traço, não pode fazê-lo novamente até terminar um Descanso Longo.
Nível 5: Você pode usar o traço de nível 3 um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.$b$,
    $b$Nível 1: Você tem Vantagem em testes de Sabedoria (Percepção) que dependam de audição ou olfato. Sempre que causar a uma criatura a condição Ensanguentado, você sofre 1d4 de dano Psíquico ao tentar reter a sanidade.
Nível 3: Como Ação Bônus, pode fazer um Ataque Desarmado para alimentar-se de uma criatura ao alcance. No acerto, recupera Pontos de Vida iguais ao dano causado. Depois de usar este traço, não pode fazê-lo novamente até terminar um Descanso Longo.
Nível 5: Você pode usar o traço de nível 3 um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.$b$
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'monstrousLineageId', 'cervus', 'Cervus', 3,
    $b$Nível 1: Seu Deslocamento aumenta para 12 m. Levantar-se da condição Caído custa 1,5 m adicional.
Nível 3: Se você se mover pelo menos 6 m em linha reta em direção a uma criatura e então a atingir com um ataque corpo a corpo no mesmo turno, o alvo deve fazer uma salvaguarda de Força (CD 8 + seu modificador de Força + seu Bônus de Proficiência). Em falha, fica Caído e você pode imediatamente gastar uma Ação Bônus para fazer um ataque corpo a corpo contra ele. Depois de forçar essa salvaguarda, não pode fazê-lo novamente até terminar um Descanso Longo.
Nível 5: Você pode usar o traço de nível 3 um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.$b$,
    $b$Nível 1: Seu Deslocamento aumenta para 12 m. Levantar-se da condição Caído custa 1,5 m adicional.
Nível 3: Se você se mover pelo menos 6 m em linha reta em direção a uma criatura e então a atingir com um ataque corpo a corpo no mesmo turno, o alvo deve fazer uma salvaguarda de Força (CD 8 + seu modificador de Força + seu Bônus de Proficiência). Em falha, fica Caído e você pode imediatamente gastar uma Ação Bônus para fazer um ataque corpo a corpo contra ele. Depois de forçar essa salvaguarda, não pode fazê-lo novamente até terminar um Descanso Longo.
Nível 5: Você pode usar o traço de nível 3 um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.$b$
  ),
  (
    'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), 'monstrousLineageId', 'vespertilio', 'Vespertilio', 4,
    $b$Nível 1: Você tem Visão Cega com alcance de 9 m. Tem Desvantagem em qualquer teste de atributo ou jogada de ataque que exija visão além desse alcance.
Nível 3: Como Ação Bônus, pode obter Deslocamento de Voo de 9 m até o fim do seu turno. Se nada o mantiver no ar no fim do turno, você cai. Depois de usar este traço, não pode fazê-lo novamente até terminar um Descanso Curto ou Longo.
Nível 5: Você pode usar o traço de nível 3 um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Curto ou Longo.$b$,
    $b$Nível 1: Você tem Visão Cega com alcance de 9 m. Tem Desvantagem em qualquer teste de atributo ou jogada de ataque que exija visão além desse alcance.
Nível 3: Como Ação Bônus, pode obter Deslocamento de Voo de 9 m até o fim do seu turno. Se nada o mantiver no ar no fim do turno, você cai. Depois de usar este traço, não pode fazê-lo novamente até terminar um Descanso Curto ou Longo.
Nível 5: Você pode usar o traço de nível 3 um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Curto ou Longo.$b$
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit;
