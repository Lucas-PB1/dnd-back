-- Character Threads Northlands (catálogo PT)
-- Fonte: docs/plans/northlands-character-threads.md

DELETE FROM rpg.phb_character_thread_milestone_benefit b
USING rpg.phb_character_thread_milestone m
WHERE b.milestone_id = m.id
  AND m.thread_slug IN (
    'bloodsworn', 'cursemarked', 'explorer', 'fatebound',
    'herald', 'legend-hunter', 'sworn-huskarl'
  );

DELETE FROM rpg.phb_character_thread_milestone
WHERE thread_slug IN (
  'bloodsworn', 'cursemarked', 'explorer', 'fatebound',
  'herald', 'legend-hunter', 'sworn-huskarl'
);

DELETE FROM rpg.phb_character_thread_goal
WHERE thread_slug IN (
  'bloodsworn', 'cursemarked', 'explorer', 'fatebound',
  'herald', 'legend-hunter', 'sworn-huskarl'
);

DELETE FROM rpg.phb_character_thread
WHERE slug IN (
  'bloodsworn', 'cursemarked', 'explorer', 'fatebound',
  'herald', 'legend-hunter', 'sworn-huskarl'
);

INSERT INTO rpg.phb_character_thread (slug, edition_slug, name, summary, special_rules_text, source_citation_id, sort_order)
VALUES
(
  'bloodsworn',
  'northlands-heroes-2024-en',
  'Juramentado de Sangue',
  'Juramento de vingança quando a justiça “normal” não basta. O goal é punir quem fez o mal (às vezes sem morte).',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  1
),
(
  'cursemarked',
  'northlands-heroes-2024-en',
  'Marcado pela Maldição',
  'Azar pessoal que, ao disparar, pode ajudar aliados. Busca de expiação.',
  'Os benefícios disparam quando o d20 (salvaguarda / teste / ataque, conforme o intervalo) cai dentro do intervalo indicado. Os benefícios não se sobrepõem — após o gatilho, outro não dispara até o início do próximo turno depois que a duração acaba. Cada marco substitui os benefícios anteriores deste thread (exceto o Menor, que é o primeiro).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  2
),
(
  'explorer',
  'northlands-heroes-2024-en',
  'Explorador',
  'Andarilho e descobridor. Pode sobrepor-se a Rangers — alinhe com o grupo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  3
),
(
  'fatebound',
  'northlands-heroes-2024-en',
  'Atado ao Destino',
  'Sabe como (ou em que circunstância) vai morrer — não se vence nem se perde. Deve ser escolha consciente do jogador.',
  'Pode não poder morrer “antes da hora”, mas chega ao fim em qualquer estado. Se morrer cedo sem ressurreição: o GM pode aplicar ferimento permanente, perda de item poderoso, Exaustão até o próximo marco, etc. (acordo jogador/GM).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  4
),
(
  'herald',
  'northlands-heroes-2024-en',
  'Arauto',
  'Contador de histórias que molda política e guerra. Pode sobrepor-se a Bards — alinhe com o grupo.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  5
),
(
  'legend-hunter',
  'northlands-heroes-2024-en',
  'Caçador de Lendas',
  'Caça glória e lendas, não só sobrevivência.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  6
),
(
  'sworn-huskarl',
  'northlands-heroes-2024-en',
  'Huskarl Juramentado',
  'Servo jurado de jarl, rei ou rainha para uma missão específica (não necessariamente vitalícia).',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
  7
);

-- Goals
INSERT INTO rpg.phb_character_thread_goal (thread_slug, sort_order, text) VALUES
('bloodsworn', 1, 'Matar quem assassinou o amado'),
('bloodsworn', 2, 'Matar o usurpador do jarl'),
('bloodsworn', 3, 'Punir charlatães que arruinaram o negócio familiar'),
('bloodsworn', 4, 'Derrubar o jarl que destruiu a comunidade'),
('bloodsworn', 5, 'Vingar o shieldmate traidor'),
('bloodsworn', 6, 'Vingar a vergonha por acusação falsa'),
('cursemarked', 1, 'Devolver relíquia sagrada a um túmulo distante'),
('cursemarked', 2, 'Limpar o nome de um ancestral'),
('cursemarked', 3, 'Derrotar gigantes marauders'),
('cursemarked', 4, 'Forjar paz entre clãs (Freyr)'),
('cursemarked', 5, 'Passar provas de honra, valor e altruísmo'),
('cursemarked', 6, 'Convencer Wotan a interceder junto às Norns'),
('explorer', 1, 'Abrir rota inédita pelas Bloodfjord Mountains'),
('explorer', 2, 'Levar uma profecia para evitar o Ragnarok'),
('explorer', 3, 'Completar a busca da mãe (Tearstain River)'),
('explorer', 4, 'Obter um broto da Árvore do Mundo'),
('explorer', 5, 'Explorar Narvegr Maw'),
('explorer', 6, 'Palácio Congelado / coroa hiperbórea'),
('fatebound', 1, 'Morrer só após o dragão mais poderoso'),
('fatebound', 2, 'Ser morto por Utgard-Loki'),
('fatebound', 3, 'Pagar com a vida defendendo o povo'),
('fatebound', 4, 'Achar um tesouro e morrer nisso'),
('fatebound', 5, 'Ser o maior reaver e perecer contra a Serpente do Mundo'),
('fatebound', 6, 'Descobrir a verdade sobre Nordheim custando a vida'),
('herald', 1, 'Avisar uma invasão de Jotunheim'),
('herald', 2, 'Reunir apoio para o maior raid'),
('herald', 3, 'Lisonjear Thor/Wotan contra Chernobog/Angrboda'),
('herald', 4, 'Cruzada sob Tanserhall'),
('herald', 5, 'Achar o caminho a um vault hiperbóreo via contos'),
('herald', 6, 'Levantar o povo contra um rei corrupto'),
('legend-hunter', 1, 'Monstro lendário destruindo vilas'),
('legend-hunter', 2, 'Jotun de duas cabeças'),
('legend-hunter', 3, 'Dragão em seu covil'),
('legend-hunter', 4, 'Mãe de todos os krakens'),
('legend-hunter', 5, 'Cabeça de Fenris'),
('legend-hunter', 6, 'Nidhogg sob Yggdrasil'),
('sworn-huskarl', 1, 'Achar o herdeiro perdido'),
('sworn-huskarl', 2, 'Matar o pretendente'),
('sworn-huskarl', 3, 'Destruir a seita do Cult of Ragnarok'),
('sworn-huskarl', 4, 'Destruir raids de gigantes'),
('sworn-huskarl', 5, 'Achar a coroa roubada (liberdade)'),
('sworn-huskarl', 6, 'Servir até poder derrubar o rei feiticeiro');

-- Milestones (ranks)
INSERT INTO rpg.phb_character_thread_milestone (thread_slug, rank, sort_order) VALUES
('bloodsworn', 'least', 1), ('bloodsworn', 'lesser', 2), ('bloodsworn', 'greater', 3), ('bloodsworn', 'superior', 4),
('cursemarked', 'least', 1), ('cursemarked', 'lesser', 2), ('cursemarked', 'greater', 3), ('cursemarked', 'superior', 4),
('explorer', 'least', 1), ('explorer', 'lesser', 2), ('explorer', 'greater', 3), ('explorer', 'superior', 4),
('fatebound', 'least', 1), ('fatebound', 'lesser', 2), ('fatebound', 'greater', 3), ('fatebound', 'superior', 4),
('herald', 'least', 1), ('herald', 'lesser', 2), ('herald', 'greater', 3), ('herald', 'superior', 4),
('legend-hunter', 'least', 1), ('legend-hunter', 'lesser', 2), ('legend-hunter', 'greater', 3), ('legend-hunter', 'superior', 4),
('sworn-huskarl', 'least', 1), ('sworn-huskarl', 'lesser', 2), ('sworn-huskarl', 'greater', 3), ('sworn-huskarl', 'superior', 4);

-- Benefits helper: insert by thread+rank
INSERT INTO rpg.phb_character_thread_milestone_benefit (milestone_id, benefit_key, name, description, choice_group, sort_order)
SELECT m.id, v.benefit_key, v.name, v.description, v.choice_group, v.sort_order
FROM (VALUES
  -- Bloodsworn
  ('bloodsworn', 'least', 'cunning', 'Astúcia', 'Proficiência em Enganação, Intuição ou Intimidação.', 'a', 1),
  ('bloodsworn', 'least', 'tool-of-vengeance', 'Ferramenta da Vingança', 'Um item mágico Common escolhido com o GM.', 'a', 2),
  ('bloodsworn', 'lesser', 'enemy-of-my-enemy', 'Inimigo do Meu Inimigo', 'Um aliado e um esconderijo seguros.', 'a', 1),
  ('bloodsworn', 'lesser', 'wrath', 'Ira', 'Conjura Wrathful Smite 1/Descanso Longo (INT/SAB/CAR).', 'a', 2),
  ('bloodsworn', 'greater', 'tenacity', 'Tenacidade', 'No início do turno, encerra Assustado, Incapacitado, Paralisado ou Atordoado (1/Descanso Longo).', NULL, 1),
  ('bloodsworn', 'superior', 'dire-oath', 'Juramento Terrível', 'Após Descanso Longo, nomeia uma criatura: vantagem em ataques e testes para achá-la/aprender sobre ela por 24h (recarrega em 7 dias).', NULL, 1),
  -- Cursemarked
  ('cursemarked', 'least', 'tides-of-fate', 'Marés do Destino [1–3, Salvaguardas]', '−3 m de deslocamento; um aliado +3 m. Grande Sacrifício opcional (deslocamento 0 → aliado sem ataques de oportunidade e ignora terreno difícil; 1/DL).', NULL, 1),
  ('cursemarked', 'lesser', 'burdens-shield', 'Escudo do Fardo [1–5, Salvaguardas/Testes]', '−2 CA; aliado +2 CA. Substitui Menor. Grande Sacrifício opcional (−4/+4 ou benefício de Marés).', NULL, 1),
  ('cursemarked', 'greater', 'threads-entwined', 'Fios Entrelaçados [1–7, Salvaguardas/Testes/Ataques]', 'Sem Ações Bônus/Reações; aliado ganha Reação para Disparar/Ajudar/Esconder-se/ataque. Substitui anteriores. Grande Sacrifício opcional (só se move / abre mão da ação → ação extra do aliado, sem Magia).', NULL, 1),
  ('cursemarked', 'superior', 'two-edged-gift', 'Dádiva de Dois Gumes [1–9, Salvaguardas/Testes/Ataques]', 'Metade do dano; próximo acerto do aliado causa dano máximo. Substitui anteriores. Grande Sacrifício → sem dano próprio; próximo ataque do aliado é crítico automático.', NULL, 1),
  -- Explorer
  ('explorer', 'least', 'celebrity-explorer', 'Explorador Celebridade', '30% de desconto / frequentemente grátis em serviços comuns.', 'a', 1),
  ('explorer', 'least', 'explorers-aptitude', 'Aptidão de Explorador', 'Proficiência em Atletismo, História ou Percepção.', 'a', 2),
  ('explorer', 'lesser', 'traversal-expert', 'Especialista em Travessia', 'Ação Bônus Disparar + ignora Terreno Difícil + vantagem em Atletismo para escalar/saltar/nadar (1/DC ou DL).', 'a', 1),
  ('explorer', 'lesser', 'scouts-awareness', 'Alerta do Batedor', '1h: você e aliados a 9 m têm vantagem em saves vs armadilhas/perigos não mágicos (1/DL).', 'a', 2),
  ('explorer', 'greater', 'ennobled', 'Enobrecido', 'Título e propriedade; vantagem em Carisma com quem se impressiona.', 'a', 1),
  ('explorer', 'greater', 'wayfarers-steps', 'Passos do Viajante', 'Não se perde; Ação Bônus Disparar + até 4 aliados Disparar sem ataques de oportunidade (1/DL).', 'a', 2),
  ('explorer', 'superior', 'far-traveler', 'Viajante Distante', 'Ritmo Rápido sem penalidade; vantagem em acampamento/forrageio e Adestrar Animais.', NULL, 1),
  ('explorer', 'superior', 'one-with-the-land', 'Um com a Terra', 'Efeito semelhante a Commune with Nature em 1 minuto; 24h.', NULL, 2),
  -- Fatebound
  ('fatebound', 'least', 'dream-gift', 'Dádiva Onírica', 'Item Common concedido pelo GM.', 'a', 1),
  ('fatebound', 'least', 'fates-blessing', 'Bênção do Destino', '1/dia quando Bloodied: Reação para vantagem em um save.', 'a', 2),
  ('fatebound', 'lesser', 'strength-of-wyrd', 'Força do Wyrd', 'Bloodied: +PB de dano; PB usos/Descanso Longo.', 'a', 1),
  ('fatebound', 'lesser', 'enduring-wyrd', 'Wyrd Duradouro', 'Reação: PV temporários = PB (1/DC ou DL).', 'a', 2),
  ('fatebound', 'greater', 'doom-delayed', 'Ruína Adiada', 'Em vez de morrer → estável com 0 PV (1/DL).', NULL, 1),
  ('fatebound', 'greater', 'knight-of-fate', 'Cavaleiro do Destino', 'Título/propriedades até a morte; vantagem em Carisma na terra.', NULL, 2),
  ('fatebound', 'superior', 'last-act-of-fate', 'Último Ato do Destino', 'No momento predeterminado: 1 PV, limpa condições, 1 turno de imunidade + vantagem + dano +nível; depois morte permanente.', NULL, 1),
  ('fatebound', 'superior', 'glorious-end', 'Fim Glorioso', 'Aliados testemunhas: vantagem em testes d20 por 24h.', NULL, 2),
  -- Herald
  ('herald', 'least', 'storytellers-knack', 'Jeito de Contador', 'Três idiomas adicionais.', NULL, 1),
  ('herald', 'least', 'performers-reward', 'Recompensa do Performer', '≥3 dias de downtime → GP = 10× nível.', NULL, 2),
  ('herald', 'lesser', 'enthralling-speaker', 'Orador Cativante', 'Proficiência/expertise em Performance; Charm Person ou Suggestion 1/DL na performance (Carisma).', NULL, 1),
  ('herald', 'greater', 'persuasive-words', 'Palavras Persuasivas', 'Teste de Carisma: d20 ≤9 vira 10; usos = mod de Carisma / Descanso Longo.', NULL, 1),
  ('herald', 'superior', 'heroic-saga', 'Saga Heróica', 'Após 10+ min: Luck Boon ×3 ou Wyrd Boon ×1 (7 dias).', 'a', 1),
  ('herald', 'superior', 'song-of-matrimony', 'Canção do Matrimônio', 'Noivado real / aliança dinástica (acordo GM).', 'a', 2),
  -- Legend Hunter
  ('legend-hunter', 'least', 'predators-mark', 'Marca do Predador', 'Vantagem em Sobrevivência para rastrear; falha = metade do tempo para reencontrar a trilha.', NULL, 1),
  ('legend-hunter', 'lesser', 'unclouded-sight', 'Visão Clara', 'Ignora obscurecimento de clima (incl. Fog Cloud/Sleet Storm), não Darkness.', 'a', 1),
  ('legend-hunter', 'lesser', 'reliable-senses', 'Sentidos Confiáveis', 'Rerolar Investigação/Percepção/Sobrevivência (1/DL).', 'a', 2),
  ('legend-hunter', 'greater', 'finish-the-fight', 'Terminar a Luta', 'Após ficar Bloodied, o próximo acerto é crítico (1/DL).', NULL, 1),
  ('legend-hunter', 'superior', 'legend-breaker', 'Quebra-Lendas', 'Ao acertar criatura com Resistência/Ações Lendárias → abrir mão do dano; save de Con; sem Resistência/Ações Lendárias.', NULL, 1),
  ('legend-hunter', 'superior', 'ultimate-favor', 'Favor Supremo', 'Cura de 6º–9º de um NPC curandeiro, 1×.', NULL, 2),
  -- Sworn Huskarl
  ('sworn-huskarl', 'least', 'jarls-authority', 'Autoridade do Jarl', 'Intimidação/Persuasão vs quem respeita/teme o senhor: tratar d20 como 15 (1/DL).', NULL, 1),
  ('sworn-huskarl', 'lesser', 'extreme-loyalty', 'Lealdade Extrema', 'Encerrar Enfeitiçado pagando dano Psíquico = nível (1/DL).', 'a', 1),
  ('sworn-huskarl', 'lesser', 'jarls-gift', 'Dádiva do Jarl', 'Item Uncommon da lista / acordo GM.', 'a', 2),
  ('sworn-huskarl', 'greater', 'undying-loyalty', 'Lealdade Imortal', 'A 0 PV → PV = nível (não vs morte instantânea sem dano; 7 dias).', NULL, 1),
  ('sworn-huskarl', 'superior', 'grand-reward', 'Grande Recompensa', 'Item Very Rare (ex.: arma +3, Dancing Sword, Oathbow, Staff of Thunder and Lightning, Horn of the Hrimthursar).', NULL, 1)
) AS v(thread_slug, rank, benefit_key, name, description, choice_group, sort_order)
JOIN rpg.phb_character_thread_milestone m
  ON m.thread_slug = v.thread_slug AND m.rank = v.rank;
