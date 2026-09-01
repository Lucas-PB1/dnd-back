-- Grim Hollow Cap. 4 — talentos referenciados por antecedentes e catálogo GH

DELETE FROM rpg.phb_feat_benefit
WHERE feat_id IN (
  SELECT f.id
  FROM rpg.phb_feat f
  INNER JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
  WHERE sc.slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats'
    AND f.slug <> 'advanced-weapon-proficiency'
);

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
(
  'blood-hound',
  'Farejador',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'convincing-inquisitor',
  'Inquisidor Convincente',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'deathbound',
  'Vinculado à Morte',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'fortuneofthe-thaumaturge',
  'Fortuna do Taumaturgo',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'free-sword-mercenarys-will',
  'Vontade do Mercenário Espada Livre',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'insightful-collector',
  'Colecionador Perspicaz',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'resolutionofthe-syndicate',
  'Determinação do Sindicato',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'survivor',
  'Sobrevivente',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'triage-expert',
  'Especialista em Triagem',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'blackpowder-pistol-expert',
  'Especialista em Pistola de Pólvora Negra',
  'general',
  FALSE,
  'Nível 4 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'expanded-grip',
  'Empunhadura Expandida',
  'general',
  FALSE,
  'Nível 4 ou superior, Força 13 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'hulking-figure',
  'Figura Imponente',
  'general',
  FALSE,
  'Nível 4 ou superior, Força 13 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'iron-gut',
  'Estômago de Ferro',
  'general',
  FALSE,
  'Nível 4 ou superior, Constituição 13 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'lightning-caster',
  'Conjurador Relâmpago',
  'general',
  FALSE,
  'Nível 4 ou superior, Característica de Conjuração ou Magia de Pacto',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'medicianofthe-morbus-doctore',
  'Médico do Morbus Doctore',
  'general',
  FALSE,
  'Nível 4 ou superior, talento Especialista em Triagem',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'nimble-physique',
  'Físico Ágil',
  'general',
  FALSE,
  'Nível 4 ou superior, Destreza 13 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'sangromantic-initiate',
  'Iniciado Sangromântico',
  'general',
  FALSE,
  'Nível 4 ou superior, Característica de Conjuração ou Magia de Pacto',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'shadowsteel-adept',
  'Adepto de Shadowsteel',
  'general',
  FALSE,
  'Nível 4 ou superior, Característica de Conjuração ou Magia de Pacto',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'shadowsteel-master',
  'Mestre de Shadowsteel',
  'general',
  FALSE,
  'Nível 8 ou superior, talento Adepto de Shadowsteel',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'syndicate-spy',
  'Espião do Sindicato',
  'general',
  FALSE,
  'Nível 4 ou superior, antecedente Contrabandista do Sindicato',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'thrown-weapon-master',
  'Mestre em Armas de Arremesso',
  'general',
  FALSE,
  'Nível 4 ou superior, Força ou Destreza 13 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'witch-hunter',
  'Caçador de Bruxas',
  'general',
  FALSE,
  'Nível 4 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'close-combat-artillerist',
  'Artilheiro de Combate Próximo',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'dual-shot',
  'Tiro Duplo',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'flurry',
  'Rajada',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'mobile-combatant',
  'Combatente Móvel',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'opportunist',
  'Oportunista',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'prone-defense',
  'Defesa Caído',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-archlich',
  'Dádiva do Arquilich',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Lich',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-ascended-vampire',
  'Dádiva do Vampiro Ascendido',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Vampiro',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-earthly-tether',
  'Dádiva da Âncora Terrena',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Espectro',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elder-horror',
  'Dádiva do Horror Ancestral',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Horror Aberrante',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elder-fey',
  'Dádiva do Fey Ancestral',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Fey',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elder-fiend',
  'Dádiva do Diabo Ancestral',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Diabo',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elemental-temperance',
  'Dádiva da Temperança Elemental',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Primordial',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-high-seraph',
  'Dádiva do Serafim Elevado',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Serafim',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonof-magic-resistance',
  'Dádiva da Resistência à Magia',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonof-perfect-flight',
  'Dádiva do Voo Perfeito',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonof-shadowsteel-mastery',
  'Dádiva do Domínio de Shadowsteel',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Carniçal de Shadowsteel',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-wilds',
  'Dádiva das Terras Selvagens',
  'epic-boon',
  FALSE,
  'Nível 19 ou superior, Transformação Licantropo',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  repeatable = EXCLUDED.repeatable,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'), 1, 'Visão geral', 'Seus sentidos estão aguçados além dos da maioria das pessoas. Quer tenham sido fortalecidos por treinamento ou pela perda de outros sentidos, quer simplesmente tenham amadurecido com você, você é um mestre em encontrar aqueles que procura.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'), 2, 'Sensor de Movimento', 'Sempre que uma criatura Pequena ou maior se mover a até 3 m de você enquanto você não estiver com a condição Inconsciente, fica imediatamente ciente de sua presença.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'), 3, 'Sem Esconderijo', 'Você tem Vantagem em testes de Sabedoria (Percepção) que dependam de som ou olfato.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 1, 'Visão geral', 'Você sabe identificar um mentiroso e consegue levar as pessoas a verem as coisas do seu jeito, seja com charme, argumentos racionais ou força de vontade.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 2, 'Presença Cativante', 'Quando realiza a ação Influenciar, não tem Desvantagem em testes para influenciar criaturas Hostis e tem Vantagem em testes para influenciar criaturas Indiferentes.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 3, 'Múltiplos Caminhos', 'Pode usar qualquer modificador de atributo quando realiza a ação Influenciar para fazer um teste de Intimidação ou Persuasão.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 4, 'Intuição Zelosa', 'Quando obtém sucesso em um teste de Sabedoria (Intuição) da ação Procurar para detectar mentiras ou respostas evasivas, tem Vantagem em rolagens de Iniciativa envolvendo combate contra essa criatura por 1 hora.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'), 1, 'Visão geral', 'Você viu a morte muitas vezes, de perto e pessoalmente — às vezes por sua própria mão. Essas experiências o afetaram profundamente, ensinando-o sobre a vida e a morte.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'), 2, 'Um Último Suspiro', 'Se tiver duas falhas em Salvaguardas contra Morte, tem Vantagem em Salvaguardas contra Morte até não estar mais com 0 Pontos de Vida.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'), 3, 'Recuperação', 'Quando gasta um Dado de Vida durante um Descanso Curto para recuperar Pontos de Vida, pode rolar o Dado de Vida duas vezes e usar o maior resultado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), 1, 'Visão geral', 'Sua conexão com o Taumaturgo coloca você em contato com forças além da compreensão mortal, fazendo outros pensarem que nasceu sob uma lua auspiciosa.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), 2, 'Fortune’s Fortitude', 'Quando falha em um Teste D20, pode gastar e rolar um Dado de Vida, somando esse número ao resultado. Só pode fazer isso uma vez por Teste D20. Pode usar este benefício um número de vezes igual ao seu Bônus de Proficiência e recupera todos os usos ao terminar um Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), 3, 'Fortuna do Desconhecido', 'Ao usar o benefício Fortitude da Fortuna, se rolar o valor mais alto ou mais baixo no Dado de Vida, recupera esse Dado de Vida. Ainda conta como um uso de Fortitude da Fortuna.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), 1, 'Visão geral', 'Seu treinamento com a Companhia das Espadas Livres conferiu a você maior resistência e uma postura que o torna menos propenso a sucumbir às adversidades.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), 2, 'Manter o Terreno', 'Quando for movido sem usar seu deslocamento por uma criatura, pode usar uma Reação para reduzir a distância em que foi movido em até seu Deslocamento.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), 3, 'Resoluto', 'Você tem Vantagem em salvaguardas que aplicariam uma condição.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), 1, 'Visão geral', 'Suas expedições, transações e atividades mercantis em nome da Companhia de Comércio Augustine colocaram você em contato com colecionadores de artefatos históricos, relíquias e tomos.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), 2, 'Intuição de Objetos', 'Pode realizar a ação Estudar para examinar um objeto mágico e aprender suas propriedades e como usá-lo sem sintonizar com ele ou passar um Descanso Curto em contato físico com ele, mas não aprende nenhuma maldição que o item possa carregar. Há 5% de chance cumulativa para cada raridade acima de Comum de identificar erroneamente a natureza e o poder do objeto.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), 3, 'Descoberta Rara', 'Você começa o jogo em posse de um item mágico Comum. Combine com o Mestre qual objeto se encaixa no seu personagem e na campanha.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'), 1, 'Visão geral', 'A filiação ao Sindicato de Ébano traz vantagens — uma delas é a motivação que vem com a certeza de que o Sindicato elimina quem falha com frequência.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'), 2, 'Golpe Rápido', 'No seu primeiro turno após uma rolagem de Iniciativa, adicione 1d4 à primeira jogada de dano que fizer. Esse dano extra aumenta para 2d4 no nível de personagem 9 e para 4d4 no nível 16.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'), 3, 'Resiliente', 'Seu máximo de Pontos de Vida aumenta em um valor igual ao seu nível de personagem quando ganha este talento. Sempre que ganha um nível de personagem depois disso, seu máximo de Pontos de Vida aumenta em 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 1, 'Visão geral', 'Sua capacidade de tirar o melhor de uma situação ruim sempre lhe serviu bem.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 2, 'Resistente', 'Você precisa de metade da quantidade de comida por dia com base no seu tamanho.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 3, 'Intuitivo', 'Quando realiza a ação Estudar, tem Vantagem em testes de Inteligência feitos ao realizar a ação Estudar.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 4, 'Sacudir', 'Sempre que termina um Descanso Curto, seu nível de Exaustão, se houver, diminui em 1. Além disso, quando termina um Descanso Longo, seu nível de Exaustão diminui em 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), 1, 'Visão geral', 'Você é treinado para lidar com ferimentos no campo de batalha e para salvar vidas depois.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), 2, 'Trato ao Paciente', 'Sempre que faz uma criatura recuperar Pontos de Vida ou usa o benefício Sangue e Osso, pode rolar um dado extra e descartar o menor.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), 3, 'Sangue e Osso', 'Realizar a ação Utilizar e gastar o uso de um Kit de Curandeiro permite curar uma criatura a até 1,5 m de você. A criatura pode gastar e rolar um Dado de Vida e recuperar Pontos de Vida iguais à rolagem.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 1, 'Visão geral', 'Você se tornou proficiente no uso de Pistolas de Pólvora Negra.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 2, 'Aumento de Atributo', 'Aumente Destreza, Constituição ou Inteligência em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 3, 'Olho de Águia', 'Atacar em alcance longo não impõe Desvantagem em suas jogadas de ataque com uma Pistola de Pólvora Negra.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 4, 'Recarga Rápida', 'Você ignora a propriedade Recarregar da Pistola de Pólvora Negra.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 5, 'Tiro Engenhoso', 'Imediatamente depois que uma criatura a até 1,5 m de você se mover, pode usar uma Reação para fazer um ataque à distância com uma Pistola de Pólvora Negra contra essa criatura.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 1, 'Visão geral', 'Sua aptidão natural com armas maiores permite usá-las de um jeito que outros não conseguem.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 2, 'Aumento de Atributo', 'Aumente Força, Destreza ou Constituição em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 3, 'Empunhadura com Uma Mão', 'Quando usa uma arma Versátil com uma mão, a arma causa o dano entre parênteses quando usada para fazer um ataque corpo a corpo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 4, 'Agarre Zeloso', 'Se um efeito o forçar a soltar o que está segurando, pode fazer uma salvaguarda de Força CD 15 para manter o agarre. Quando estiver sujeito a um efeito que permita fazer uma salvaguarda para manter o agarre, tem Vantagem na salvaguarda.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 1, 'Visão geral', 'Seja por treinamento extensivo ou por constituição natural, você tem um porte amplo e imponente para sua espécie.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 2, 'Aumento de Atributo', 'Aumente Força ou Constituição em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 3, 'Brutal', 'Uma vez por turno, pode causar 1d4 de dano Contundente extra a um alvo que acertar com um Ataque Desarmado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 4, 'Intimidador', 'Quando faz um teste de Carisma (Intimidação, Atuação ou Persuasão), também pode somar seu modificador de Força à rolagem.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 5, 'Poderoso', 'Você conta como um tamanho maior (até no máximo Grande) ao determinar sua capacidade de carga.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 1, 'Visão geral', 'Você come como um gigante das colinas e bebe como um peixe. Anos punindo estômago e fígado resultaram em uma fortitude poderosa.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 2, 'Aumento de Atributo', 'Aumente Força, Constituição ou Carisma em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 3, 'Imune ao Veneno', 'Você tem Vantagem em salvaguardas que faz para evitar ou encerrar a condição Envenenado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 4, 'Tudo Parece Delicioso', 'Você tem Vantagem em testes de Sabedoria (Sobrevivência) para forragear comida.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 5, 'Recuperação Rápida', 'Como Ação Bônus, pode gastar um de seus Dados de Vida, rolar o dado e somar seu modificador de Constituição, recuperando Pontos de Vida iguais ao total da rolagem. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Curto ou Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 1, 'Visão geral', 'Seu estilo rápido de conjurar truques permite entrelaçar magia com velocidade incomum.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 2, 'Aumento de Atributo', 'Aumente Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 3, 'Alvo Duplo', 'Quando conjura um truque com tempo de conjuração de uma ação que tem como alvo uma única criatura, pode usar uma Ação Bônus para escolher uma segunda criatura dentro do alcance do truque.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 4, 'Resposta Imediata', 'Quando conjura uma magia como Reação, essa magia não gasta um espaço de magia. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'medicianofthe-morbus-doctore'), 1, 'Visão geral', 'Você é um mestre das ciências médicas graças à sua associação com um instituto médico.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'medicianofthe-morbus-doctore'), 2, 'Médico Habilidoso', 'Quando usa o benefício Sangue e Osso do talento Especialista em Triagem, a criatura pode gastar até três Dados de Vida em vez de um.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'medicianofthe-morbus-doctore'), 3, 'Cirurgião de Campo', 'Quando usa o benefício Sangue e Osso do talento Especialista em Triagem, a criatura pode gastar três Dados de Vida para encerrar uma das seguintes condições em si mesma em vez de recuperar Pontos de Vida: Cego, Surdo, Paralisado, Envenenado ou Atordoado. Alternativamente, pode curar uma Ferida Grave que afete a criatura (consulte Grim Hollow: Guia de Campanha).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 1, 'Visão geral', 'Você é pequeno e magro para sua espécie. Tem uma habilidade misteriosa e consistente de evitar perigo. Você ganha os seguintes benefícios:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 2, 'Aumento de Atributo', 'Aumente Força, Destreza ou Constituição em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 3, 'Escorregadio', 'Enquanto não estiver usando armadura nem empunhando um Escudo, pode realizar a ação Desviar como Ação Bônus.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 4, 'Escorregadio', 'Enquanto estiver Agarrado ou Impedido, seus ataques não têm Desvantagem e ataques contra você não têm Vantagem.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'), 1, 'Visão geral', 'Você se tornou habilidoso o suficiente em tecer magia de sangue para mitigar parte do dano da Sangromancia.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'), 2, 'Magia de Sangue', 'Escolha uma magia de Sangromancia de qualquer lista de magias de um nível para o qual tenha espaços de magia. Você sempre tem essa magia preparada. Pode conjurá-la uma vez sem gastar um espaço de magia e recupera a capacidade de conjurá-la dessa forma ao terminar um Descanso Longo. Também pode conjurar a magia usando qualquer espaço de magia que tenha.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'), 3, 'Potência Sanguínea', 'Você tem um pool de dois d12 que pode gastar no lugar de Dados de Vida ao conjurar magias de Sangromancia. Seu pool recupera todos os dados gastos ao terminar um Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 1, 'Visão geral', 'Você aprendeu a canalizar a arte perigosa, porém poderosa, da conjuração de Shadowsteel.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 2, 'Aumento de Atributo', 'Aumente Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 3, 'Conjurador de Maldições', 'Você sempre tem maldições de Shadowsteel preparadas e pode conjurá-las com quaisquer espaços de magia que tenha.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 4, 'Shadowsteel’s Bite', 'Enquanto segura seu Foco de Shadowsteel, você ganha +1 em jogadas de ataque com magia e nas CDs de salvaguarda das suas magias.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 5, 'Arma de Shadowsteel', 'Se seu Foco de Shadowsteel também for uma arma, essa arma ganha +1 em jogadas de ataque e de dano.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 1, 'Visão geral', 'Seu domínio sobre Shadowsteel se fortalece.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 2, 'Aumento de Atributo', 'Aumente Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 3, 'Harmonia Necrótica', 'Enquanto segura seu Foco de Shadowsteel, quando conjura uma magia que tem como alvo uma ou mais criaturas e exige uma jogada de ataque ou salvaguarda, pode escolher um alvo que acertou ou que falhou na salvaguarda para também sofrer 1d4 de dano Necrótico para cada nível de espaço de magia gasto para conjurar a magia.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 4, 'Arma Necrótica', 'Se seu Foco de Shadowsteel também for uma arma, essa arma ganha +2 em jogadas de ataque e de dano. Além disso, uma vez em cada um dos seus turnos, quando acerta uma criatura com uma jogada de ataque com arma usando seu Foco de Shadowsteel, pode fazer o alvo sofrer 2d8 de dano Necrótico extra.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 1, 'Visão geral', 'Subir na hierarquia do Sindicato de Ébano ensinou a você as habilidades clandestinas da espionagem, valiosas no seu ofício de criminoso organizado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 2, 'Chaveiro', 'Você tem proficiência com Ferramentas de Ladrão. Enquanto segura Ferramentas de Ladrão, pode fabricar uma chave para uma fechadura passando 10 minutos com essa fechadura.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 3, 'Mestre do Disfarce', 'Você tem proficiência com um Kit de Disfarce. Se passar 10 minutos vestindo um Traje, decide como parece, incluindo altura, peso, traços faciais, som da voz, comprimento do cabelo, coloração e outras características distintivas. Pode parecer membro de outra espécie, embora nenhum de seus valores numéricos mude. Não pode parecer uma criatura de tamanho diferente, e sua forma básica permanece a mesma; se for bípede, por exemplo, não pode usar este benefício para se tornar quadrúpede.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 4, 'Mestre Calígrafo', 'Você tem proficiência com um Kit de Falsificação. Não está limitado a 10 palavras ou menos ao imitar a caligrafia de outra pessoa.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 5, 'Passar Despercebido', 'Ao usar a ação Esconder-se para ocultar-se de criaturas que não sejam Hostis a você, precisa estar apenas Levemente Obscurecido e pode usar Carisma em vez de Destreza no teste.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 1, 'Visão geral', 'Você se destaca com armas de arremesso.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 2, 'Aumento de Atributo', 'Aumente Força ou Destreza em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 3, 'Arremesso Múltiplo', 'Depois de realizar a ação Atacar para fazer uma jogada de ataque à distância com uma arma simples que tenha a propriedade Arremesso, pode fazer dois ataques à distância adicionais com armas simples que tenham a propriedade Arremesso como Ação Bônus.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 4, 'Mãos Rápidas', 'Como Ação Bônus, pode pegar, guardar ou empunhar todas as armas simples com a propriedade Arremesso que estejam a até 1,5 m de você. Precisa de uma mão livre para executar essa manobra.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 5, 'Retorno', 'Armas simples com a propriedade Arremesso com as quais você tenha proficiência também têm a propriedade Retorno (consulte Capítulo 8: Armas e Equipamento Avançados).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 1, 'Visão geral', 'Você aperfeiçoou suas habilidades lutando contra conjuradores, possivelmente por ter caçado magos como parte da Inquisição Arcanista.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 2, 'Aumento de Atributo', 'Aumente Força, Constituição ou Sabedoria em 1, até o máximo de 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 3, 'Esquivar Magias', 'Pode usar uma Reação para evitar uma magia que tenha apenas você como alvo e não crie uma área de efeito. Faça uma salvaguarda de Sabedoria contra a CD de salvaguarda da magia do conjurador. Em um sucesso, a criatura deve escolher um novo alvo ou a magia é cancelada. Uma magia cancelada se dissipa sem efeito, e quaisquer recursos usados para conjurá-la são desperdiçados.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 4, 'Mantenha os Inimigos Por Perto', 'Quando acerta com uma jogada de ataque usando uma arma corpo a corpo ou um Ataque Desarmado um alvo que possa conjurar magias, pode reduzir o Deslocamento dele em 4,5 m até o início do seu próximo turno.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 5, 'Resistir a Maldições', 'Você tem Vantagem em salvaguardas contra todas as maldições de Shadowsteel e também contra magias com duração superior a 10 minutos.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'close-combat-artillerist'), 1, 'Disparo em Corpo a Corpo', 'Estar a até 1,5 m de um inimigo não impõe Desvantagem em suas jogadas de ataque com armas à distância.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'close-combat-artillerist'), 2, 'Queima-roupa', 'Quando acerta uma criatura que está a até 1,5 m de você com um ataque à distância, ganha +2 na jogada de dano.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'dual-shot'), 1, 'Tiro Duplo', 'Quando realiza a ação Atacar no seu turno e ataca com um arco ou besta, pode fazer um ataque extra como parte da mesma ação contra uma criatura que esteja a até 3 m do alvo original e dentro do alcance da arma. Se o fizer, ambos os ataques são feitos com Desvantagem.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'flurry'), 1, 'Golpe Rápido', 'Uma vez em cada um dos seus turnos, quando faz uma jogada de ataque com uma arma ou um Ataque Desarmado e tem Vantagem na rolagem, pode renunciar à Vantagem nessa jogada de ataque. Depois de resolver esse ataque, pode fazer outro ataque com a mesma arma ou Ataque Desarmado contra uma criatura diferente. O novo alvo deve estar a até 1,5 m do primeiro alvo e dentro do alcance da arma.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'mobile-combatant'), 1, 'Escorregadio', 'Quando realiza a ação Atacar, seu Deslocamento aumenta em 3 m e Ataques de Oportunidade têm Desvantagem contra você até o fim do seu turno.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'opportunist'), 1, 'Explorar Fraqueza', 'Sempre que faz um ataque como parte de uma Reação, ganha +2 nas jogadas de ataque e de dano.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'prone-defense'), 1, 'Defensivo', 'Quando tem a condição Caído, não tem Desvantagem em jogadas de ataque. Jogadas de ataque contra você não têm Vantagem por causa da condição Caído.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'prone-defense'), 2, 'Levantar-se', 'Quando tem a condição Caído, pode se levantar usando apenas 1,5 m de deslocamento.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-archlich'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-archlich'), 2, 'Vaso de Vitalidade', 'Sempre que termina um Descanso Longo, se seu Vaso da Alma não estiver carregado, ele recebe uma alma e fica carregado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-ascended-vampire'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-ascended-vampire'), 2, 'Imune à Luz Solar', 'Você não é mais afetado pela luz solar.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 2, 'Assombração Persistente', 'Você não é mais afetado pela Falha de Transformação Realidade Desfiada.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 3, 'Crescimento Divergente', 'Escolha uma Dádiva de Transformação Espectro que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 2, 'Forma Estabilizada', 'Quando rolar 25 ou menos na tabela Forma Instável, pode rolar novamente. Deve usar o novo resultado. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 3, 'Crescimento Divergente', 'Escolha uma Dádiva de Transformação Horror Aberrante que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 2, 'Baluarte Fey', 'Você não é mais afetado pela Falha de Transformação Constituição Enfraquecida.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 3, 'Crescimento Divergente', 'Escolha uma Dádiva de Transformação Fey que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 2, 'Agente Livre', 'Você não é mais afetado pela Falha de Transformação Puxão do Submundo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 3, 'Crescimento Divergente', 'Escolha uma Dádiva de Transformação Diabo que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elemental-temperance'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elemental-temperance'), 2, 'Caos Controlado', 'Você não é mais afetado pela Falha de Transformação Caos Primordial.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 2, 'Absolvição', 'Você não é mais afetado pela Falha de Transformação Corrupção Serafim.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 3, 'Crescimento Divergente', 'Escolha uma Dádiva de Transformação Serafim que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-magic-resistance'), 1, 'Aumento de Atributo', 'Aumente Inteligência ou Sabedoria em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-magic-resistance'), 2, 'Resistência Heroica', 'Se falhar em uma salvaguarda, pode fazer com que tenha sucesso em vez disso. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Curto ou Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 1, 'Aumento de Atributo', 'Aumente Força ou Destreza em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 2, 'Voo', 'Você tem Deslocamento de Voo de 12 m e pode pairar.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 3, 'Queda Graciosa', 'Se cair mais de 1,5 m, sua taxa de queda desacelera para 18 m por rodada até pousar.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-shadowsteel-mastery'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-shadowsteel-mastery'), 2, 'Estranhos Companheiros', 'Você não é mais afetado pela Falha de Transformação Solitária.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-wilds'), 1, 'Aumento de Atributo', 'Aumente um atributo à sua escolha em 1, até o máximo de 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-wilds'), 2, 'Predador Supremo', 'Quando entra em sua Forma Híbrida, ganha 25 Pontos de Vida Temporários. No fim de cada um dos seus turnos enquanto estiver em Forma Híbrida, se não tiver Pontos de Vida Temporários, ganha 10 Pontos de Vida Temporários. Enquanto estiver em Forma Híbrida e não tiver Pontos de Vida Temporários, tem Vantagem em jogadas de ataque.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
