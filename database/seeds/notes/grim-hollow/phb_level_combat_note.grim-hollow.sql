-- Notas de combate GH Cap.2 (classe/subclasse) — gerado a partir dos batches TS.

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Couro de Monstro: armadura leve/média com 2 modificações; resistência a 2 tipos (ácido, frio, fogo, relâmpago, veneno ou trovão).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'carver-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Couro de Monstro: armadura leve/média com 2 modificações; resistência a 2 tipos (ácido, frio, fogo, relâmpago, veneno ou trovão).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Fome Roedora: ao causar dano corpo a corpo, PV temporários = metade do dano (total vs tipos do Grimório).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'devourer-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Fome Roedora: ao causar dano corpo a corpo, PV temporários = metade do dano (total vs tipos do Grimório).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Interferência Arcana: vantagem em salvaguardas contra magias de tipos no Grimório de Monstros.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'occultist-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Interferência Arcana: vantagem em salvaguardas contra magias de tipos no Grimório de Monstros.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Vantagem do Emboscador: +INT na Iniciativa; não pode ser surpreendido por tipos no Grimório.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trapper-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Vantagem do Emboscador: +INT na Iniciativa; não pode ser surpreendido por tipos no Grimório.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Cérebro e Músculo: sem Fúria — resistência psíquica; com Fúria — resistência a todos os tipos exceto força e psíquico.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-fractured'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Cérebro e Músculo: sem Fúria — resistência psíquica; com Fúria — resistência a todos os tipos exceto força e psíquico.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Fúria Compartilhada: com Fúria ativa, companheiro primal tem resistência a concussão, perfuração e corte.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-primal-spirit'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Fúria Compartilhada: com Fúria ativa, companheiro primal tem resistência a concussão, perfuração e corte.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Fúria dos Mortos: com Fúria — +3 m deslocamento, visão espectral 36 m, atravessa terreno difícil e espaços ocupados.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-wrathful-dead'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Fúria dos Mortos: com Fúria — +3 m deslocamento, visão espectral 36 m, atravessa terreno difícil e espaços ocupados.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Morte é mas uma Porta: vantagem em salvaguardas contra morte; falha em 4 salvaguardas para morrer.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-wrathful-dead'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Morte é mas uma Porta: vantagem em salvaguardas contra morte; falha em 4 salvaguardas para morrer.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Talento de Aventureiro: escolha talentos de aventureiro (L3/6/14) — ver descrição da subclasse.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'collegeof-adventurers'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Talento de Aventureiro: escolha talentos de aventureiro (L3/6/14) — ver descrição da subclasse.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Última Risada: Reação quando Ferido — resistência a todo dano por 1 min (1×/DL).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'collegeof-fools'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Última Risada: Reação quando Ferido — resistência a todo dano por 1 min (1×/DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Puxar Cordas da Vida: Inspiração Bárdica pode evitar 0 PV ou adicionar dano necrótico no ataque.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'collegeof-requiems'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Puxar Cordas da Vida: Inspiração Bárdica pode evitar 0 PV ou adicionar dano necrótico no ataque.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Calma Sobrenatural: resistência a dano psíquico; vantagem para evitar/encerrar Enfeitiçado e Amedrontado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'eldritch-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Calma Sobrenatural: resistência a dano psíquico; vantagem para evitar/encerrar Enfeitiçado e Amedrontado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Golpe do Caçador de Bruxas: +1d8 de força vs Aberrações, Celestiais, Demônios, Dragões ou Mortos-vivos.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'inquisition-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Golpe do Caçador de Bruxas: +1d8 de força vs Aberrações, Celestiais, Demônios, Dragões ou Mortos-vivos.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Marca Impura: vantagem em salvaguardas contra doenças e efeitos que alteram forma (ex.: Polimorfia).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'purification-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Marca Impura: vantagem em salvaguardas contra doenças e efeitos que alteram forma (ex.: Polimorfia).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Com Lua de Sangue ativa: resistência a dano de concussão, perfuração e corte.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-blood'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Com Lua de Sangue ativa: resistência a dano de concussão, perfuração e corte.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Ruína Incarnate: CA base 17 + Sab (mín. +1) se sua CA for menor; 2 ataques na ação Atacar.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-entropy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Ruína Incarnate: CA base 17 + Sab (mín. +1) se sua CA for menor; 2 ataques na ação Atacar.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Com Ruína Incarnate ativa: dano elemental/necrótico nos acertos; +Sab em salv. FOR/DES.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-entropy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Com Ruína Incarnate ativa: dano elemental/necrótico nos acertos; +Sab em salv. FOR/DES.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Mutações: tremorsense 9 m; resistência elemental (ácido/frio/fogo/relâmpago/veneno/trovão) via pontos de mutação.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-mutation'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Mutações: tremorsense 9 m; resistência elemental (ácido/frio/fogo/relâmpago/veneno/trovão) via pontos de mutação.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Interromper o Ataque: Reação — sofre o ataque no lugar de aliado a 1,5 m; resistência a todo o dano desse ataque.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'bulwark-warrior'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Interromper o Ataque: Reação — sofre o ataque no lugar de aliado a 1,5 m; resistência a todo o dano desse ataque.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Transmutação Tóxica: resistência a dano de veneno; Ação Bônus para encerrar Envenenado e ganhar PV temporários.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'living-crucible'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Transmutação Tóxica: resistência a dano de veneno; Ação Bônus para encerrar Envenenado e ganhar PV temporários.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Sempre Vigilante: visão no escuro 18 m; vantagem em Iniciativa e testes de Percepção.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'nightwatcher'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Sempre Vigilante: visão no escuro 18 m; vantagem em Iniciativa e testes de Percepção.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mão Sutil: alcance desarmado +1,5 m; pode causar dano psíquico no lugar do tipo normal.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warriorofthe-leaden-crown'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mão Sutil: alcance desarmado +1,5 m; pode causar dano psíquico no lugar do tipo normal.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Ferido de Orgulho: considerado Ferido enquanto PV atual < PV máximo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warriorof-pride'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Ferido de Orgulho: considerado Ferido enquanto PV atual < PV máximo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Transe da Morte: a 0 PV, pode gastar 1 Ponto de Foco — imune a Inconsciente; falha crítica de morte conta como 1.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warriorof-regret'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Transe da Morte: a 0 PV, pode gastar 1 Ponto de Foco — imune a Inconsciente; falha crítica de morte conta como 1.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Portador da Peste (forma): imune a veneno/Envenenado; resistência necrótica; PV máx. não pode ser reduzido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oathof-pestilence'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Portador da Peste (forma): imune a veneno/Envenenado; resistência necrótica; PV máx. não pode ser reduzido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Massacre Frenético: com frenesi ativo — vantagem em salv. contra Enfeitiçado, Amedrontado e Atordoado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oathof-slaughter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Massacre Frenético: com frenesi ativo — vantagem em salv. contra Enfeitiçado, Amedrontado e Atordoado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura de Clareza: você e aliados imunes a Cegueira na Aura de Proteção.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oathof-zeal'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura de Clareza: você e aliados imunes a Cegueira na Aura de Proteção.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Controle de Veneno: resistência a veneno; vantagem em salvaguardas contra Envenenado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'green-reaper'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Controle de Veneno: resistência a veneno; vantagem em salvaguardas contra Envenenado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Tece os Elementos: resistência a ácido, frio, fogo, relâmpago ou trovão (escolha até descanso longo).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'primordial-archer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Tece os Elementos: resistência a ácido, frio, fogo, relâmpago ou trovão (escolha até descanso longo).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Sujeira e Fortitude: imune a Envenenado; resistência a dano de veneno.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'vermin-lord'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Sujeira e Fortitude: imune a Envenenado; resistência a dano de veneno.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Gatilho Rápido: vantagem em Iniciativa; Reação para atirar antes de agir no combate.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'highway-rider'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Gatilho Rápido: vantagem em Iniciativa; Reação para atirar antes de agir no combate.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Olho Maligno: com alvo amaldiçoado, Ataque Furtivo mesmo sem vantagem (se não tiver desvantagem).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'misfortune-bringer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Olho Maligno: com alvo amaldiçoado, Ataque Furtivo mesmo sem vantagem (se não tiver desvantagem).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Conjuração: magias de mago + Sangromancia (lista preparada; INT). Dados de Sangromancia (Poder Roubado) no lugar de DV em magias de sangue.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sanguine-thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Conjuração: magias de mago + Sangromancia (lista preparada; INT). Dados de Sangromancia (Poder Roubado) no lugar de DV em magias de sangue.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Roubar Sangue: Ataque Furtivo pode restaurar 1 Dado de Sangromancia; se Ferido, recupera 1 Dado de Vida.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'sanguine-thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Roubar Sangue: Ataque Furtivo pode restaurar 1 Dado de Sangromancia; se Ferido, recupera 1 Dado de Vida.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Testemunhar o Fim: com Feitiçaria Inata ativa — resistência a força; imune a Amedrontado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'apocalypse-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Testemunhar o Fim: com Feitiçaria Inata ativa — resistência a força; imune a Amedrontado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Palidez Mortífera: resistência a dano necrótico; magias de feiticeiro podem causar necrótico.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'haunted-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Palidez Mortífera: resistência a dano necrótico; magias de feiticeiro podem causar necrótico.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Maldição Herdada (escolha): Colossal +1 PV/nível; Noturno visão 36 m no escuro; Flagelo — penalidades sociais variadas.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wretched-bloodline-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Maldição Herdada (escolha): Colossal +1 PV/nível; Noturno visão 36 m no escuro; Flagelo — penalidades sociais variadas.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Visagem Horripilante: máscara de medo — criaturas com desvantagem na salv. se puderem ver você.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'the-coven'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Visagem Horripilante: máscara de medo — criaturas com desvantagem na salv. se puderem ver você.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Predador Noturno: visão no escuro 18 m (+18 m se já tiver).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'the-first-vampire-patron'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Predador Noturno: visão no escuro 18 m (+18 m se já tiver).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Noite Eterna: resistência a dano necrótico; não envelhece.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'the-first-vampire-patron'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Noite Eterna: resistência a dano necrótico; não envelhece.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Forma Aprimorada (1×/DL): pode escolher +PV máx. = nível de Bruxo, visão no escuro, velocidade, etc.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'the-parasite-patron'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Forma Aprimorada (1×/DL): pode escolher +PV máx. = nível de Bruxo, visão no escuro, velocidade, etc.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Sifão Aprimorado: com sifão de Arquidaemons — resistência necrótica; com Arqueanjo — resistência radiante.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'daemonologist'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Sifão Aprimorado: com sifão de Arquidaemons — resistência necrótica; com Arqueanjo — resistência radiante.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Inale Isso: imune a Envenenado; após dano necrótico ou de veneno, ganha PV temporários = dano recebido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'plague-doctor'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Inale Isso: imune a Envenenado; após dano necrótico ou de veneno, ganha PV temporários = dano recebido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Vigor Sanguíneo: +PV máx. por nível (ver PV na ficha); ao conjurar sangromancia com espaço, recupera PV = nível do espaço.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sangromancer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Vigor Sanguíneo: +PV máx. por nível (ver PV na ficha); ao conjurar sangromancia com espaço, recupera PV = nível do espaço.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Defesa Erudita: em salvaguardas forçadas por tipos do Grimório, pode usar salvaguarda de Inteligência.', 0
FROM rpg.phb_class c WHERE c.slug = 'monster-hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Defesa Erudita: em salvaguardas forçadas por tipos do Grimório, pode usar salvaguarda de Inteligência.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Senso do Covil: vantagem e resistência a ações de covil/região e Ações Lendárias de tipos no Grimório.', 1
FROM rpg.phb_class c WHERE c.slug = 'monster-hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Senso do Covil: vantagem e resistência a ações de covil/região e Ações Lendárias de tipos no Grimório.'
  );
