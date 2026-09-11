-- Notas estáticas PHB/Valdas (gunslinger, sorcerer, barb/monk/paladin subclasses)

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Dado de Risco: gaste em manobras (painel). Recarrega no Descanso Curto/Longo.', 0
FROM rpg.phb_class c WHERE c.slug = 'gunslinger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Dado de Risco: gaste em manobras (painel). Recarrega no Descanso Curto/Longo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Pistolero — Tiro a Queima-Roupa: sem Desvantagem em ataques à distância a 1,5 m de inimigo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pistolero'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Pistolero — Tiro a Queima-Roupa: sem Desvantagem em ataques à distância a 1,5 m de inimigo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Abrir o Leque e Confronto: manobras no painel (gastam Dado de Risco).', 1
FROM rpg.phb_subclass s WHERE s.slug = 'pistolero'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Abrir o Leque e Confronto: manobras no painel (gastam Dado de Risco).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Desarmar: em crítico com Tiro no Estômago, solte um objeto a até 4,5 m (mesa).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pistolero'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Desarmar: em crítico com Tiro no Estômago, solte um objeto a até 4,5 m (mesa).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Tempo Bala: 1×/turno, Vantagem em um ataque à distância com arma.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pistolero'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Tempo Bala: 1×/turno, Vantagem em um ataque à distância com arma.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Olho Morto — Olho de Águia: manobra no painel (erra → +risk no ataque).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'deadeye'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Olho Morto — Olho de Águia: manobra no painel (erra → +risk no ataque).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Postura do atirador: sem Desvantagem à distância por Caído; levantar com 1,5 m.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'deadeye'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Postura do atirador: sem Desvantagem à distância por Caído; levantar com 1,5 m.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Posição oculta: Esconder Caído sem cobertura total; falha no ataque não revela se escondido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'deadeye'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Posição oculta: Esconder Caído sem cobertura total; falha no ataque não revela se escondido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Reposicionar (Reação): ao ser errado, encerre Caído e mova até metade da Velocidade.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'deadeye'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Reposicionar (Reação): ao ser errado, encerre Caído e mova até metade da Velocidade.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Tiro Focado: Atacar com 1 ataque à distância (Vantagem = crítico) — Economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'deadeye'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Tiro Focado: Atacar com 1 ataque à distância (Vantagem = crítico) — Economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Grande Apostador — Dados do Mentiroso: manobra no painel (blefe de dano).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'high-roller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Grande Apostador — Dados do Mentiroso: manobra no painel (blefe de dano).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Negócio Arriscado: 1×/turno Desvantagem no ataque → recupera 1 risk (± Economia).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'high-roller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Negócio Arriscado: 1×/turno Desvantagem no ataque → recupera 1 risk (± Economia).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Assumidor de risco: Espírito Independente / Por um Triz podem usar d6 sem gastar risk (mesa).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'high-roller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Assumidor de risco: Espírito Independente / Por um Triz podem usar d6 sem gastar risk (mesa).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Duplo ou Nada: no crítico, aposte d20 (10+ = ×4 dano; 9− = acerto normal) — Economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'high-roller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Duplo ou Nada: no crítico, aposte d20 (10+ = ×4 dano; 9− = acerto normal) — Economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Agente Secreto — Tiro de despedida: manobra no painel (Correr/Desengajar/Esquivar → BA ataque).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'secret-agent'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Agente Secreto — Tiro de despedida: manobra no painel (Correr/Desengajar/Esquivar → BA ataque).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Artesanato de campo: fantasia com Kit de Disfarce (BA); Enganação/Persuasão mínimo 10 no d20.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'secret-agent'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Artesanato de campo: fantasia com Kit de Disfarce (BA); Enganação/Persuasão mínimo 10 no d20.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Estratégia de Saída: Reação Invisível + 3 m (1×/descanso; restaure com 1 risk) — Economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'secret-agent'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Estratégia de Saída: Reação Invisível + 3 m (1×/descanso; restaure com 1 risk) — Economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Licença para Matar: 1–2 risk no dano (explode no máximo; teto = PB) — Economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'secret-agent'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Licença para Matar: 1–2 risk no dano (explode no máximo; teto = PB) — Economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Pistoleiro Arcano — Tiro Arcano: BA +1 risk no dano de Pistolas de Dedo — Economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'spellslinger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Pistoleiro Arcano — Tiro Arcano: BA +1 risk no dano de Pistolas de Dedo — Economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Bala Mágica: manobra no painel (substitui ataque mágico por arma + risk).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'spellslinger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Bala Mágica: manobra no painel (substitui ataque mágico por arma + risk).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Tiro de Trucagem — Ricochete: manobra no painel (erra → rerrole + risk).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trick-shot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Tiro de Trucagem — Ricochete: manobra no painel (erra → rerrole + risk).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Trajetória Criativa: ataques à distância ignoram Meia Cobertura e Cobertura ¾.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'trick-shot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Trajetória Criativa: ataques à distância ignoram Meia Cobertura e Cobertura ¾.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Tiroteio extravagante: +risk grátis em Desempenho/Prestidigitação com arma; reload free no turno.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trick-shot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Tiroteio extravagante: +risk grátis em Desempenho/Prestidigitação com arma; reload free no turno.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Deflexão Hábil: manobra no painel (Reação — Por um Triz em aliado).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trick-shot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Deflexão Hábil: manobra no painel (Reação — Por um Triz em aliado).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Tiro de Pinball: ricochetes (1×/descanso; restaure com 2 risk) — Economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trick-shot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Tiro de Pinball: ricochetes (1×/descanso; restaure com 2 risk) — Economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Chapéu Branco — Estabeleça a Lei: manobra no painel (PV Temp. + Reação de tiro).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'white-hat'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Chapéu Branco — Estabeleça a Lei: manobra no painel (PV Temp. + Reação de tiro).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Aura de Olhos de Aço (3 m): você e aliados com Vantagem vs Amedrontado.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'white-hat'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Aura de Olhos de Aço (3 m): você e aliados com Vantagem vs Amedrontado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Alcance os céus: no crítico, peça rendição (SAB vs CD de Manobra) — mesa.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'white-hat'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Alcance os céus: no crítico, peça rendição (SAB vs CD de Manobra) — mesa.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Longo braço da lei: 1×/turno, acerto em Grande ou menor → mancar (precisa Desengajar para se mover).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'white-hat'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Longo braço da lei: 1×/turno, acerto em Grande ou menor → mancar (precisa Desengajar para se mover).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Herói Estrela Dourada: aura 9 m; Estabeleça a Lei dá Resistência física; rendição Atordoado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'white-hat'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Herói Estrela Dourada: aura 9 m; Estabeleça a Lei dá Resistência física; rendição Atordoado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Feitiçaria Inata (2×/DL): Ação Bônus libera a magia por 1 minuto (+1 na CD das suas magias de Feiticeiro e Vantagem nas jogadas de ataque das magias de Feiticeiro).', 0
FROM rpg.phb_class c WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Feitiçaria Inata (2×/DL): Ação Bônus libera a magia por 1 minuto (+1 na CD das suas magias de Feiticeiro e Vantagem nas jogadas de ataque das magias de Feiticeiro).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Fonte de Magia: converta Slots de Magia em Pontos de Feitiçaria (1:1) ou Pontos de Feitiçaria em Slots de 1º a 5º círculo.', 0
FROM rpg.phb_class c WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Fonte de Magia: converta Slots de Magia em Pontos de Feitiçaria (1:1) ou Pontos de Feitiçaria em Slots de 1º a 5º círculo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Metamagia: aplique opções conhecidas gastando Pontos de Feitiçaria.', 1
FROM rpg.phb_class c WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Metamagia: aplique opções conhecidas gastando Pontos de Feitiçaria.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Restauração Feiticeira (1×/DL): no Descanso Curto, recupere Pontos de Feitiçaria até metade do nível do Feiticeiro.', 0
FROM rpg.phb_class c WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Restauração Feiticeira (1×/DL): no Descanso Curto, recupere Pontos de Feitiçaria até metade do nível do Feiticeiro.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Feitiçaria Encarnada: sem usos de Feitiçaria Inata, gaste 2 Pontos de Feitiçaria ao ativá-la; com Inata ativa, até 2 Metamagias por magia.', 0
FROM rpg.phb_class c WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Feitiçaria Encarnada: sem usos de Feitiçaria Inata, gaste 2 Pontos de Feitiçaria ao ativá-la; com Inata ativa, até 2 Metamagias por magia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 20, 'Apoteose Arcana: enquanto a Feitiçaria Inata estiver ativa, você pode usar uma opção de Metamagia por turno sem gastar Pontos de Feitiçaria.', 0
FROM rpg.phb_class c WHERE c.slug = 'sorcerer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 20 AND n.note = 'Apoteose Arcana: enquanto a Feitiçaria Inata estiver ativa, você pode usar uma opção de Metamagia por turno sem gastar Pontos de Feitiçaria.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Linhagem Dracônica: Resiliência Dracônica (CA sem armadura = 10 + DES + CAR; +1 PV por nível) e Afinidade Elemental (+CAR no dano de magias do elemento ancestral).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'draconic'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Linhagem Dracônica: Resiliência Dracônica (CA sem armadura = 10 + DES + CAR; +1 PV por nível) e Afinidade Elemental (+CAR no dano de magias do elemento ancestral).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Asas de Dragão (L14): Ação Bônus — voo 18 m por 1 h (1×/DL ou 3 Pontos de Feitiçaria para restaurar o uso).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'draconic'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Asas de Dragão (L14): Ação Bônus — voo 18 m por 1 h (1×/DL ou 3 Pontos de Feitiçaria para restaurar o uso).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Feitiçaria Aberrante: Mente Psiónica (telepatia a 9 m) e Feitiçaria Psiónica (gaste Pontos de Feitiçaria em vez de slots para magias aberrantes sem componentes V, S ou M).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'aberrant'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Feitiçaria Aberrante: Mente Psiónica (telepatia a 9 m) e Feitiçaria Psiónica (gaste Pontos de Feitiçaria em vez de slots para magias aberrantes sem componentes V, S ou M).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Implosão de Distorção (L18): ação Usar Magia — teleporte e dano espacial (1×/DL); gaste na economia/painel.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'aberrant'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Implosão de Distorção (L18): ação Usar Magia — teleporte e dano espacial (1×/DL); gaste na economia/painel.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Feitiçaria Mecânica: Restaurar Equilíbrio (Reação; usos = CAR) e Bastião da Lei (1–5 Pontos → N d8 de proteção).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'clockwork'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Feitiçaria Mecânica: Restaurar Equilíbrio (Reação; usos = CAR) e Bastião da Lei (1–5 Pontos → N d8 de proteção).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Feitiçaria Selvagem: Marés do Caos (Vantagem em 1 Teste de D20; 1 uso).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wild-magic'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Feitiçaria Selvagem: Marés do Caos (Vantagem em 1 Teste de D20; 1 uso).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Distorcer a Sorte (L6): Reação — 1 Ponto de Feitiçaria → ±1d4 no d20 de outra criatura.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wild-magic'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Distorcer a Sorte (L6): Reação — 1 Ponto de Feitiçaria → ±1d4 no d20 de outra criatura.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Feitiçaria Heróica: Alma Heróica (1 Ponto de Feitiçaria no início do turno → PV temp. 1d6 + nível); treino marcial e Lâmina Inata (CAR no ataque com Feitiçaria Inata).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'heroic-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Feitiçaria Heróica: Alma Heróica (1 Ponto de Feitiçaria no início do turno → PV temp. 1d6 + nível); treino marcial e Lâmina Inata (CAR no ataque com Feitiçaria Inata).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Ataque Extra: dois ataques; pode trocar um por um Truque de Feiticeiro.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'heroic-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Ataque Extra: dois ataques; pode trocar um por um Truque de Feiticeiro.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Manobras Místicas (2 SP): Cegar, Ruinoso (−3 CA) ou Ferimento (sangramento) +2d8 no dano — gaste na economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'heroic-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Manobras Místicas (2 SP): Cegar, Ruinoso (−3 CA) ou Ferimento (sangramento) +2d8 no dano — gaste na economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Aceleração Heróica: Acelerar em você sem Concentração (sem letargia ao terminar).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'heroic-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Aceleração Heróica: Acelerar em você sem Concentração (sem letargia ao terminar).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Berserker: Frenesi — com Fúria + Imprudente, +Nd6 (N = bônus de Fúria) no 1º acerto FOR do turno.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'berserker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Berserker: Frenesi — com Fúria + Imprudente, +Nd6 (N = bônus de Fúria) no 1º acerto FOR do turno.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Fúria Irracional: Imunidade a Amedrontado/Enfeitiçado enquanto enfurecido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'berserker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Fúria Irracional: Imunidade a Amedrontado/Enfeitiçado enquanto enfurecido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Retaliação: Reação ao sofrer dano a 1,5 m — ataque corpo a corpo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'berserker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Retaliação: Reação ao sofrer dano a 1,5 m — ataque corpo a corpo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Presença Intimidante: AB — CD FOR; Amedrontado 1 min (1×/DL; restaure gastando Fúria).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'berserker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Presença Intimidante: AB — CD FOR; Amedrontado 1 min (1×/DL; restaure gastando Fúria).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Coração Selvagem: ao entrar em Fúria escolha Águia/Lobo/Urso. Águia tem Usar (AB: Correr+Desengajar).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wild-heart'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Coração Selvagem: ao entrar em Fúria escolha Águia/Lobo/Urso. Águia tem Usar (AB: Correr+Desengajar).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Aspecto dos Selvagens: Coruja/Pantera/Salmão (escolha no DL — mesa).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wild-heart'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Aspecto dos Selvagens: Coruja/Pantera/Salmão (escolha no DL — mesa).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Poder dos Selvagens: ao entrar em Fúria escolha Carneiro/Falcão/Leão.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wild-heart'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Poder dos Selvagens: ao entrar em Fúria escolha Carneiro/Falcão/Leão.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Árvore do Mundo: ao entrar em Fúria, PV temp. = nível; no início do turno (Fúria), aliado a 3 m pode ganhar Nd6 PV temp. (N = bônus de Fúria).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'world-tree'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Árvore do Mundo: ao entrar em Fúria, PV temp. = nível; no início do turno (Fúria), aliado a 3 m pode ganhar Nd6 PV temp. (N = bônus de Fúria).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Ramos: Reação — teleporte inimigo a 9 m (salvaguarda FOR).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'world-tree'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Ramos: Reação — teleporte inimigo a 9 m (salvaguarda FOR).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Raízes Devastadoras: +3 m de alcance com armas Pesadas/Versáteis; no acerto pode Derrubar ou Empurrar além de outra maestria.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'world-tree'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Raízes Devastadoras: +3 m de alcance com armas Pesadas/Versáteis; no acerto pode Derrubar ou Empurrar além de outra maestria.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Percorrer a Árvore: teleporte 18 m (AB); 1×/Fúria até 45 m + aliados.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'world-tree'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Percorrer a Árvore: teleporte 18 m (AB); 1×/Fúria até 45 m + aliados.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Fanático: Campeão dos Deuses (reserva d12); Fúria Divina (+1d6 + metade do nível no 1º acerto/turno).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'zealot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Fanático: Campeão dos Deuses (reserva d12); Fúria Divina (+1d6 + metade do nível no 1º acerto/turno).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Concentração Fanática: 1×/Fúria, rerrolar salvaguarda com +bônus de Fúria.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'zealot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Concentração Fanática: 1×/Fúria, rerrolar salvaguarda com +bônus de Fúria.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Presença Zelosa: AB — Vantagem em ataque/salvaguarda a aliados até seu próximo turno (1×/DL).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'zealot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Presença Zelosa: AB — Vantagem em ataque/salvaguarda a aliados até seu próximo turno (1×/DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Fúria dos Deuses: forma divina 1 min ao entrar em Fúria (1×/DL).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'zealot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Fúria dos Deuses: forma divina 1 min ao entrar em Fúria (1×/DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mago Musculoso: “Truques” (Mãos Mágicas / Toque Chocante / Ataque Certeiro); “Magias” 1× cada / DL enquanto enfurecido; Reação pode entrar em Fúria sem gastar uso.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-muscle-wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mago Musculoso: “Truques” (Mãos Mágicas / Toque Chocante / Ataque Certeiro); “Magias” 1× cada / DL enquanto enfurecido; Reação pode entrar em Fúria sem gastar uso.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Resistência Mágica: Vantagem em salvaguardas vs magias enquanto enfurecido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-muscle-wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Resistência Mágica: Vantagem em salvaguardas vs magias enquanto enfurecido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Eu lancei o punho: 1×/Fúria — Ataque Desarmado com Vantagem, 6d6+FOR Contundente.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-muscle-wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Eu lancei o punho: 1×/Fúria — Ataque Desarmado com Vantagem, 6d6+FOR Contundente.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Técnica da Mão Espalmada: na Torrente, cada acerto impõe Caído, empurrão ou sem Reação', 0
FROM rpg.phb_subclass s WHERE s.slug = 'open-hand'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Técnica da Mão Espalmada: na Torrente, cada acerto impõe Caído, empurrão ou sem Reação'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Integridade Corporal: Ação Bônus — cura MA + Sabedoria (usos = Sabedoria/DL)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'open-hand'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Integridade Corporal: Ação Bônus — cura MA + Sabedoria (usos = Sabedoria/DL)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Passo Veloz: após Ação Bônus que não seja Passos do Vento, use Passos do Vento de imediato', 0
FROM rpg.phb_subclass s WHERE s.slug = 'open-hand'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Passo Veloz: após Ação Bônus que não seja Passos do Vento, use Passos do Vento de imediato'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Palma Vibrante: 4 Foco no acerto desarmado → vibrações; encerrar força CON vs 10d12 Energético', 0
FROM rpg.phb_subclass s WHERE s.slug = 'open-hand'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Palma Vibrante: 4 Foco no acerto desarmado → vibrações; encerrar força CON vs 10d12 Energético'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Sintonia Elemental: 1 Foco no início do turno (10 min) — tipo elemental, +3 m de alcance', 0
FROM rpg.phb_subclass s WHERE s.slug = 'elements'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Sintonia Elemental: 1 Foco no início do turno (10 min) — tipo elemental, +3 m de alcance'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Manipular Elementos: conhece Elementalismo (SAB)', 1
FROM rpg.phb_subclass s WHERE s.slug = 'elements'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Manipular Elementos: conhece Elementalismo (SAB)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Explosão Elemental: 2 Foco, esfera 6 m / 36 m, 3× MA (Destreza)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'elements'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Explosão Elemental: 2 Foco, esfera 6 m / 36 m, 3× MA (Destreza)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Passo dos Elementos: com Sintonia ativa — natação e voo = Deslocamento', 0
FROM rpg.phb_subclass s WHERE s.slug = 'elements'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Passo dos Elementos: com Sintonia ativa — natação e voo = Deslocamento'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Ápice Elemental: com Sintonia — dano extra MA 1×/turno; Passos do Vento aprimorados', 0
FROM rpg.phb_subclass s WHERE s.slug = 'elements'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Ápice Elemental: com Sintonia — dano extra MA 1×/turno; Passos do Vento aprimorados'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mão de Cura: 1 Foco para curar SAB + dado de Artes Marciais', 0
FROM rpg.phb_subclass s WHERE s.slug = 'mercy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mão de Cura: 1 Foco para curar SAB + dado de Artes Marciais'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mão de Dolo: 1 Foco para dano Necrótico extra (1×/turno)', 1
FROM rpg.phb_subclass s WHERE s.slug = 'mercy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mão de Dolo: 1 Foco para dano Necrótico extra (1×/turno)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Toque de Médico: cura remove condição; dolo pode impor Envenenado', 0
FROM rpg.phb_subclass s WHERE s.slug = 'mercy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Toque de Médico: cura remove condição; dolo pode impor Envenenado'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Torrente de Cura e Dolo: na Torrente, cura/dolo sem Foco extra (usos = Sabedoria/DL)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'mercy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Torrente de Cura e Dolo: na Torrente, cura/dolo sem Foco extra (usos = Sabedoria/DL)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Mão da Misericórdia Final: 5 Foco + 1 uso/DL para reviver (4d10 + SAB)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'mercy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Mão da Misericórdia Final: 5 Foco + 1 uso/DL para reviver (4d10 + SAB)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Artes das Sombras: Visão no Escuro; 1 Foco → Escuridão (vê na área); Ilusão Menor', 0
FROM rpg.phb_subclass s WHERE s.slug = 'shadow'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Artes das Sombras: Visão no Escuro; 1 Foco → Escuridão (vê na área); Ilusão Menor'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Passo da Sombra: teleporte 18 m entre Meia-luz/Escuridão + Vantagem', 0
FROM rpg.phb_subclass s WHERE s.slug = 'shadow'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Passo da Sombra: teleporte 18 m entre Meia-luz/Escuridão + Vantagem'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Passo Aprimorado: 1 Foco no Passo — sem requisito de sombra + Ataque Desarmado', 0
FROM rpg.phb_subclass s WHERE s.slug = 'shadow'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Passo Aprimorado: 1 Foco no Passo — sem requisito de sombra + Ataque Desarmado'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Manto da Sombra: 3 Foco — Invisível 1 min; Torrente sem Foco', 0
FROM rpg.phb_subclass s WHERE s.slug = 'shadow'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Manto da Sombra: 3 Foco — Invisível 1 min; Torrente sem Foco'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Combinação: 1 Foco no acerto → +2 a +6 nos ataques desarmados no turno', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warrior-of-the-street'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Combinação: 1 Foco no acerto → +2 a +6 nos ataques desarmados no turno'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Punho de Ferro: acerto desarmado em objeto = crítico', 1
FROM rpg.phb_subclass s WHERE s.slug = 'warrior-of-the-street'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Punho de Ferro: acerto desarmado em objeto = crítico'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Movimentos: Explosão de Energia, Quebrador de Guarda, Corte Superior (1 Foco cada)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warrior-of-the-street'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Movimentos: Explosão de Energia, Quebrador de Guarda, Corte Superior (1 Foco cada)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Traço Aéreo: 1 Foco — voo até o fim do próximo turno', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warrior-of-the-street'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Traço Aéreo: 1 Foco — voo até o fim do próximo turno'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'K.O.: +3× MA; ≤100 PV → Inconsciente (1×/descanso ou 5 Foco para recuperar)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warrior-of-the-street'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'K.O.: +3× MA; ≤100 PV → Inconsciente (1×/descanso ou 5 Foco para recuperar)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Arma Sagrada: na ação Atacar, Canalizar — +Carisma no ataque e luz por 10 min', 0
FROM rpg.phb_subclass s WHERE s.slug = 'devotion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Arma Sagrada: na ação Atacar, Canalizar — +Carisma no ataque e luz por 10 min'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura de Devoção: imunidade a Enfeitiçado na aura', 0
FROM rpg.phb_subclass s WHERE s.slug = 'devotion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura de Devoção: imunidade a Enfeitiçado na aura'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Destruição Protetora: ao usar Destruição Divina, Cobertura Parcial na aura até seu próximo turno', 0
FROM rpg.phb_subclass s WHERE s.slug = 'devotion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Destruição Protetora: ao usar Destruição Divina, Cobertura Parcial na aura até seu próximo turno'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Resplendor Sagrado: aura de dano Radiante por 10 minutos', 0
FROM rpg.phb_subclass s WHERE s.slug = 'devotion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Resplendor Sagrado: aura de dano Radiante por 10 minutos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Destruição Inspiradora: após Destruição Divina, Canalizar para distribuir PV temp. (2d8 + nível)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glory'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Destruição Inspiradora: após Destruição Divina, Canalizar para distribuir PV temp. (2d8 + nível)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Atleta Inigualável: Canalizar — Vantagem em Atletismo/Acrobacia e saltos +3 m por 1 h', 1
FROM rpg.phb_subclass s WHERE s.slug = 'glory'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Atleta Inigualável: Canalizar — Vantagem em Atletismo/Acrobacia e saltos +3 m por 1 h'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura de Vivacidade: +3 m de deslocamento (você e aliados na aura)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glory'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura de Vivacidade: +3 m de deslocamento (você e aliados na aura)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Defesa Gloriosa: Reação — +CA (Carisma) contra um ataque; se errar, possível contra-ataque', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glory'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Defesa Gloriosa: Reação — +CA (Carisma) contra um ataque; se errar, possível contra-ataque'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Lenda Viva: Vantagem em Carisma, golpe infalível e rerrolar salvaguarda', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glory'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Lenda Viva: Vantagem em Carisma, golpe infalível e rerrolar salvaguarda'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'A Ira da Natureza: Canalizar — Contém criaturas a 4,5 m (salvaguarda de Força)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'ancients'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'A Ira da Natureza: Canalizar — Contém criaturas a 4,5 m (salvaguarda de Força)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura de Resistência: Resistência a Necrótico, Psíquico e Radiante na aura', 0
FROM rpg.phb_subclass s WHERE s.slug = 'ancients'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura de Resistência: Resistência a Necrótico, Psíquico e Radiante na aura'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Sentinela Imortal: a 0 PV, fica com 1 + cura 3× nível (1×/DL)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'ancients'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Sentinela Imortal: a 0 PV, fica com 1 + cura 3× nível (1×/DL)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Campeão Ancestral: transformação por 1 minuto', 0
FROM rpg.phb_subclass s WHERE s.slug = 'ancients'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Campeão Ancestral: transformação por 1 minuto'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Voto de Inimizade: na ação Atacar, Canalizar — Vantagem vs um alvo por 1 min', 0
FROM rpg.phb_subclass s WHERE s.slug = 'vengeance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Voto de Inimizade: na ação Atacar, Canalizar — Vantagem vs um alvo por 1 min'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Vingador Implacável: ao acertar AO, Desloc. 0 no alvo e metade do seu movimento', 0
FROM rpg.phb_subclass s WHERE s.slug = 'vengeance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Vingador Implacável: ao acertar AO, Desloc. 0 no alvo e metade do seu movimento'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Alma Vingativa: Reação para atacar o alvo do Voto após ele atacar', 0
FROM rpg.phb_subclass s WHERE s.slug = 'vengeance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Alma Vingativa: Reação para atacar o alvo do Voto após ele atacar'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Anjo Vingador: voo e aura Amedrontar por 10 minutos', 0
FROM rpg.phb_subclass s WHERE s.slug = 'vengeance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Anjo Vingador: voo e aura Amedrontar por 10 minutos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Conjurar Bebida: Canalizar Divindade para efeitos de bebida em área', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-revelry'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Conjurar Bebida: Canalizar Divindade para efeitos de bebida em área'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura de Fraternidade: +1d4 dano corpo a corpo na aura', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-revelry'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura de Fraternidade: +1d4 dano corpo a corpo na aura'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Folião: usos = mod. de Carisma por descanso longo', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-revelry'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Folião: usos = mod. de Carisma por descanso longo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Animal de Festa: transformação festiva (1×/longo ou espaço de 5º)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-revelry'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Animal de Festa: transformação festiva (1×/longo ou espaço de 5º)'
  );
