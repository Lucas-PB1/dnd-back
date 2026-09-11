-- Notas PHB restantes (estáticas) — literais sem template dinâmico.

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Mente Tática: ao falhar em teste de atributo, gaste Recuperar Fôlego para +1d10 (uso devolvido se ainda falhar)', 0
FROM rpg.phb_class c WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Mente Tática: ao falhar em teste de atributo, gaste Recuperar Fôlego para +1d10 (uso devolvido se ainda falhar)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Ajuste Tático: ao usar Recuperar Fôlego, mova-se até metade do Deslocamento sem provocar AO', 0
FROM rpg.phb_class c WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Ajuste Tático: ao usar Recuperar Fôlego, mova-se até metade do Deslocamento sem provocar AO'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Mestre Tático: pode substituir a maestria da arma por Empurrar, Drenar ou Lentidão neste ataque', 0
FROM rpg.phb_class c WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Mestre Tático: pode substituir a maestria da arma por Empurrar, Drenar ou Lentidão neste ataque'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 13, 'Ataques Estudados: se errar um ataque, vantagem no próximo ataque contra o mesmo alvo até o fim do próximo turno', 0
FROM rpg.phb_class c WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 13 AND n.note = 'Ataques Estudados: se errar um ataque, vantagem no próximo ataque contra o mesmo alvo até o fim do próximo turno'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Combatente Heroico: no início do turno sem Inspiração Heroica, conceda-a a si', 0
FROM rpg.phb_subclass s WHERE s.slug = 'champion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Combatente Heroico: no início do turno sem Inspiração Heroica, conceda-a a si'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Sobrevivente: Vantagem em salvaguardas contra morte; Regeneração Heroica se Sangrando', 0
FROM rpg.phb_subclass s WHERE s.slug = 'champion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Sobrevivente: Vantagem em salvaguardas contra morte; Regeneração Heroica se Sangrando'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Cavaleiro Místico: conjuração de 1/3 (lista de Mago, INT)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'eldritch-knight'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Cavaleiro Místico: conjuração de 1/3 (lista de Mago, INT)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Magia de Guerra: substitua 1 ataque por um truque (ação) na ação Atacar', 0
FROM rpg.phb_subclass s WHERE s.slug = 'eldritch-knight'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Magia de Guerra: substitua 1 ataque por um truque (ação) na ação Atacar'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Chute na Porta: Vantagem nos ataques na primeira rodada de combate', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dungeoneer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Chute na Porta: Vantagem nos ataques na primeira rodada de combate'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Evitar: em salvaguarda FOR/DES/CON por metade do dano, sucesso = 0 e falha = metade', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dungeoneer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Evitar: em salvaguarda FOR/DES/CON por metade do dano, sucesso = 0 e falha = metade'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Ação Ardilosa: Correr, Desengajar ou Esconder como Ação Bônus', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Ação Ardilosa: Correr, Desengajar ou Esconder como Ação Bônus'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 3, 'Mira Firme: vantagem no próximo ataque, sem movimento no turno', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 3 AND n.note = 'Mira Firme: vantagem no próximo ataque, sem movimento no turno'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Golpe Astuto: sacrifique dados de Ataque Furtivo para aplicar efeitos', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Golpe Astuto: sacrifique dados de Ataque Furtivo para aplicar efeitos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Esquiva Sobrenatural: use a Reação para reduzir pela metade o dano do ataque', 1
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Esquiva Sobrenatural: use a Reação para reduzir pela metade o dano do ataque'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha causa metade', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha causa metade'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Talento Confiável: resultados 9 ou menos viram 10 em testes com proficiência', 1
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Talento Confiável: resultados 9 ou menos viram 10 em testes com proficiência'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 11, 'Golpe Astuto Aprimorado: aplique até dois efeitos, pagando ambos os custos', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 11 AND n.note = 'Golpe Astuto Aprimorado: aplique até dois efeitos, pagando ambos os custos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Golpes Sujos: Aturdir, Nocaute e Obscurecer disponíveis', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Golpes Sujos: Aturdir, Nocaute e Obscurecer disponíveis'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 15, 'Mente Escorregadia: proficiência em salvaguardas de Sabedoria e Carisma', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 15 AND n.note = 'Mente Escorregadia: proficiência em salvaguardas de Sabedoria e Carisma'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Elusivo: ataques não têm Vantagem contra você enquanto não Incapacitado', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Elusivo: ataques não têm Vantagem contra você enquanto não Incapacitado'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 20, 'Golpe de Sorte: transforme um Teste de D20 que falhou em 20', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 20 AND n.note = 'Golpe de Sorte: transforme um Teste de D20 que falhou em 20'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Lâminas Psíquicas: 1d6 Psíquico; segunda lâmina 1d4 como Ação Bônus', 0
FROM rpg.phb_subclass s WHERE s.slug = 'soulknife'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Lâminas Psíquicas: 1d6 Psíquico; segunda lâmina 1d4 como Ação Bônus'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 9, 'Lâminas da Alma: Golpes Teleguiados e Teleporte Psíquico', 0
FROM rpg.phb_subclass s WHERE s.slug = 'soulknife'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 9 AND n.note = 'Lâminas da Alma: Golpes Teleguiados e Teleporte Psíquico'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 13, 'Véu Psíquico: Invisível por até 1 hora', 0
FROM rpg.phb_subclass s WHERE s.slug = 'soulknife'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 13 AND n.note = 'Véu Psíquico: Invisível por até 1 hora'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Rasgar Mente: salvaguarda de Sabedoria ou Atordoado', 0
FROM rpg.phb_subclass s WHERE s.slug = 'soulknife'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Rasgar Mente: salvaguarda de Sabedoria ou Atordoado'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Assassinar: Vantagem na Iniciativa e Golpe Surpreendente', 0
FROM rpg.phb_subclass s WHERE s.slug = 'assassin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Assassinar: Vantagem na Iniciativa e Golpe Surpreendente'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 9, 'Especialista em Infiltração: Mimetismo Magistral e Mira Móvel', 0
FROM rpg.phb_subclass s WHERE s.slug = 'assassin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 9 AND n.note = 'Especialista em Infiltração: Mimetismo Magistral e Mira Móvel'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 13, 'Armas Venenosas: Envenenar causa 2d6 Venenoso adicional em falha', 0
FROM rpg.phb_subclass s WHERE s.slug = 'assassin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 13 AND n.note = 'Armas Venenosas: Envenenar causa 2d6 Venenoso adicional em falha'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Golpe Mortal: salvaguarda de Constituição ou dobre o dano', 0
FROM rpg.phb_subclass s WHERE s.slug = 'assassin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Golpe Mortal: salvaguarda de Constituição ou dobre o dano'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Ladrão: Mão Leve e Andarilho de Telhados', 0
FROM rpg.phb_subclass s WHERE s.slug = 'thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Ladrão: Mão Leve e Andarilho de Telhados'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 9, 'Furtividade Suprema: Ataque Escondido custa 1 dado de Ataque Furtivo', 0
FROM rpg.phb_subclass s WHERE s.slug = 'thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 9 AND n.note = 'Furtividade Suprema: Ataque Escondido custa 1 dado de Ataque Furtivo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 13, 'Usar Dispositivo Mágico: quatro sintonizações e uso de pergaminhos', 0
FROM rpg.phb_subclass s WHERE s.slug = 'thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 13 AND n.note = 'Usar Dispositivo Mágico: quatro sintonizações e uso de pergaminhos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Reflexos de Ladrão: dois turnos na primeira rodada', 0
FROM rpg.phb_subclass s WHERE s.slug = 'thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Reflexos de Ladrão: dois turnos na primeira rodada'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Trapaceiro Arcano: conjuração de Mago (INT) e Mãos Mágicas Ligeiras', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arcane-trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Trapaceiro Arcano: conjuração de Mago (INT) e Mãos Mágicas Ligeiras'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 9, 'Emboscada Mágica: salvaguardas contra magia têm Desvantagem', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arcane-trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 9 AND n.note = 'Emboscada Mágica: salvaguardas contra magia têm Desvantagem'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 13, 'Trapaceiro Versátil: Golpe Astuto também afeta alvo junto à Mão Mágica', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arcane-trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 13 AND n.note = 'Trapaceiro Versátil: Golpe Astuto também afeta alvo junto à Mão Mágica'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Ladrão de Magias: negue e roube uma magia com sua Reação', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arcane-trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Ladrão de Magias: negue e roube uma magia com sua Reação'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Golpe Venenoso: Ataque Furtivo pode causar d8s de dano Venenoso', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arachnoid-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Golpe Venenoso: Ataque Furtivo pode causar d8s de dano Venenoso'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Correia: teias para movimento, objetos, corda ou a magia Teia', 1
FROM rpg.phb_subclass s WHERE s.slug = 'arachnoid-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Correia: teias para movimento, objetos, corda ou a magia Teia'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 9, 'Rastejando na Parede: escalada em paredes e tetos com mãos livres', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arachnoid-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 9 AND n.note = 'Rastejando na Parede: escalada em paredes e tetos com mãos livres'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 13, 'Sentido de Aranha: Esquiva Sobrenatural contra dano de salvaguarda', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arachnoid-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 13 AND n.note = 'Sentido de Aranha: Esquiva Sobrenatural contra dano de salvaguarda'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Veneno Paralítico: Paralisar custa 4 dados de Ataque Furtivo', 0
FROM rpg.phb_subclass s WHERE s.slug = 'arachnoid-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Veneno Paralítico: Paralisar custa 4 dados de Ataque Furtivo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Inimigo Favorito: Marca do Predador sempre preparada; usos gratuitos = PB (recuperam no Descanso Longo)', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Inimigo Favorito: Marca do Predador sempre preparada; usos gratuitos = PB (recuperam no Descanso Longo)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Explorador Hábil: Especialização em 1 perícia e 2 idiomas', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Explorador Hábil: Especialização em 1 perícia e 2 idiomas'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Ataque Extra: dois ataques na ação Atacar', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Ataque Extra: dois ataques na ação Atacar'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 6, 'Errante: +3 m de Deslocamento (sem Armadura Pesada); Escalada e Natação iguais ao Deslocamento', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 6 AND n.note = 'Errante: +3 m de Deslocamento (sem Armadura Pesada); Escalada e Natação iguais ao Deslocamento'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Especialista: Especialização em mais 2 perícias', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Especialista: Especialização em mais 2 perícias'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 10, 'Incansável: ação Usar Magia concede 1d8 + SAB PV temporários (usos = mod. SAB); Descanso Curto reduz Exaustão em 1', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 10 AND n.note = 'Incansável: ação Usar Magia concede 1d8 + SAB PV temporários (usos = mod. SAB); Descanso Curto reduz Exaustão em 1'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 13, 'Predador Implacável: dano não quebra Concentração da Marca do Predador', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 13 AND n.note = 'Predador Implacável: dano não quebra Concentração da Marca do Predador'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Véu da Natureza: Ação Bônus para Invisível até o fim do próximo turno (usos = mod. SAB)', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Véu da Natureza: Ação Bônus para Invisível até o fim do próximo turno (usos = mod. SAB)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 17, 'Caçador Preciso: Vantagem nos ataques contra a criatura marcada', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 17 AND n.note = 'Caçador Preciso: Vantagem nos ataques contra a criatura marcada'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Sentidos Selvagens: Visão às Cegas 9 m', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Sentidos Selvagens: Visão às Cegas 9 m'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 20, 'Matador de Inimigos Favoritos: dado da Marca do Predador vira d10', 0
FROM rpg.phb_class c WHERE c.slug = 'ranger'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 20 AND n.note = 'Matador de Inimigos Favoritos: dado da Marca do Predador vira d10'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Portador Bestial: garras (1d6 Cortante, DES/FOR), Escalada e Visão no Escuro +9 m.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beastborne'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Portador Bestial: garras (1d6 Cortante, DES/FOR), Escalada e Visão no Escuro +9 m.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Aspecto Bestial: na mesa, suba o nível (0–5) ao causar dano (Ação Bônus); zera se 1 min sem dano. Níveis: Carnificina +2, Velocidade +3 m, Frenesi de Sangue, Pele +2 CA, Retaliação.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'beastborne'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Aspecto Bestial: na mesa, suba o nível (0–5) ao causar dano (Ação Bônus); zera se 1 min sem dano. Níveis: Carnificina +2, Velocidade +3 m, Frenesi de Sangue, Pele +2 CA, Retaliação.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Uivo Feral: na Iniciativa, role 1d4 e defina o Aspecto Bestial nesse valor.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beastborne'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Uivo Feral: na Iniciativa, role 1d4 e defina o Aspecto Bestial nesse valor.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Fúria Sedenta: Marca do Predador na Ação Bônus que sobe o Aspecto; Carnificina +3.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beastborne'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Fúria Sedenta: Marca do Predador na Ação Bônus que sobe o Aspecto; Carnificina +3.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Resiliência Monstruosa: 1×/turno reduza dano em mod. CON + nível de Aspecto (mín. 0).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beastborne'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Resiliência Monstruosa: 1×/turno reduza dano em mod. CON + nível de Aspecto (mín. 0).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Presa do Caçador: Assassino de Colossos (+1d8 1×/turno vs alvo abaixo do máximo) ou Destruidor de Hordas (ataque extra a outro alvo a 1,5 m)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Presa do Caçador: Assassino de Colossos (+1d8 1×/turno vs alvo abaixo do máximo) ou Destruidor de Hordas (ataque extra a outro alvo a 1,5 m)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Conhecimento do Caçador: enquanto marcado, saiba Imunidades/Resistências/Vulnerabilidades', 1
FROM rpg.phb_subclass s WHERE s.slug = 'hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Conhecimento do Caçador: enquanto marcado, saiba Imunidades/Resistências/Vulnerabilidades'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Táticas Defensivas: Defesa Contra Ataques Múltiplos ou Escapar de Hordas', 0
FROM rpg.phb_subclass s WHERE s.slug = 'hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Táticas Defensivas: Defesa Contra Ataques Múltiplos ou Escapar de Hordas'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Presa do Caçador Superior: ao causar dano da Marca, cause o mesmo em outra criatura a até 9 m', 0
FROM rpg.phb_subclass s WHERE s.slug = 'hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Presa do Caçador Superior: ao causar dano da Marca, cause o mesmo em outra criatura a até 9 m'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Defesa do Caçador Superior: Reação para Resistência ao dano recebido neste turno', 0
FROM rpg.phb_subclass s WHERE s.slug = 'hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Defesa do Caçador Superior: Reação para Resistência ao dano recebido neste turno'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Companheiro Primal: Ação Bônus para comandar a fera; pode sacrificar um ataque para o Golpe da Fera', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beast-master'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Companheiro Primal: Ação Bônus para comandar a fera; pode sacrificar um ataque para o Golpe da Fera'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Treinamento Excepcional: comande Ajudar/Correr/Desengajar/Esquivar; dano Energético opcional', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beast-master'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Treinamento Excepcional: comande Ajudar/Correr/Desengajar/Esquivar; dano Energético opcional'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Fúria Bestial: Golpe da Fera duas vezes; a fera também causa o bônus da Marca do Predador', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beast-master'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Fúria Bestial: Golpe da Fera duas vezes; a fera também causa o bônus da Marca do Predador'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Compartilhar Magias: magias em si também afetam a fera a até 9 m', 0
FROM rpg.phb_subclass s WHERE s.slug = 'beast-master'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Compartilhar Magias: magias em si também afetam a fera a até 9 m'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Glamour Transcendental: +mod. SAB (mín. +1) em testes de Carisma', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fey-wanderer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Glamour Transcendental: +mod. SAB (mín. +1) em testes de Carisma'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Detalhe Sedutor: Vantagem vs Amedrontado/Enfeitiçado; Reação para redirecionar o efeito', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fey-wanderer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Detalhe Sedutor: Vantagem vs Amedrontado/Enfeitiçado; Reação para redirecionar o efeito'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Reforços Feéricos: Convocar Feérico 1× sem espaço / longo (sem Concentração, 1 min)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fey-wanderer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Reforços Feéricos: Convocar Feérico 1× sem espaço / longo (sem Concentração, 1 min)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Andarilho Nebuloso: Passo Nebuloso gratuito (usos = mod. SAB); pode levar um aliado', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fey-wanderer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Andarilho Nebuloso: Passo Nebuloso gratuito (usos = mod. SAB); pode levar um aliado'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Visão Umbrosa: Visão no Escuro 18 m (ou +18 m); Invisível na Escuridão contra Visão no Escuro', 0
FROM rpg.phb_subclass s WHERE s.slug = 'gloom-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Visão Umbrosa: Visão no Escuro 18 m (ou +18 m); Invisível na Escuridão contra Visão no Escuro'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Mente de Ferro: proficiência em salvaguarda de Sabedoria (ou INT/CAR se já tiver)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'gloom-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Mente de Ferro: proficiência em salvaguarda de Sabedoria (ou INT/CAR se já tiver)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 11, 'Torrente do Vigilante: Golpe Terrível 2d8 + ataque/Medo em Massa', 0
FROM rpg.phb_subclass s WHERE s.slug = 'gloom-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 11 AND n.note = 'Torrente do Vigilante: Golpe Terrível 2d8 + ataque/Medo em Massa'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Esquiva Sombria: Reação impõe Desvantagem e teleporte de 9 m', 0
FROM rpg.phb_subclass s WHERE s.slug = 'gloom-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Esquiva Sombria: Reação impõe Desvantagem e teleporte de 9 m'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 11, 'Arcanum Místico: conjura magias de 6º a 9º círculo sem gastar slots de pacto (1×/Descanso Longo cada).', 0
FROM rpg.phb_class c WHERE c.slug = 'warlock'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 11 AND n.note = 'Arcanum Místico: conjura magias de 6º a 9º círculo sem gastar slots de pacto (1×/Descanso Longo cada).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Alma Radiante: Resistência a Radiante; 1×/turno +CAR no dano de Fogo ou Radiante de uma magia sua.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'celestial'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Alma Radiante: Resistência a Radiante; 1×/turno +CAR no dano de Fogo ou Radiante de uma magia sua.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Resiliência Celestial: após Astúcia Mágica ou Descanso Curto/Longo, PV temp = nível + CAR (você e até 5 aliados a 9 m).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'celestial'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Resiliência Celestial: após Astúcia Mágica ou Descanso Curto/Longo, PV temp = nível + CAR (você e até 5 aliados a 9 m).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Vingança Calcinante: quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'celestial'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Vingança Calcinante: quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Patrono Ínfero: Bênção do Tenebroso (PV temp = CAR + nível ao reduzir inimigo a 0 PV).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fiend'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Patrono Ínfero: Bênção do Tenebroso (PV temp = CAR + nível ao reduzir inimigo a 0 PV).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'A Sorte do Próprio Tenebroso: +1d10 a um teste ou salvaguarda (usos = CAR).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fiend'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'A Sorte do Próprio Tenebroso: +1d10 a um teste ou salvaguarda (usos = CAR).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Resistência Ínfera: após Descanso Curto ou Longo, escolha Resistência a um tipo de dano (exceto Energético).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fiend'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Resistência Ínfera: após Descanso Curto ou Longo, escolha Resistência a um tipo de dano (exceto Energético).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Lançar no Inferno: ao acertar, envie o alvo aos Infernos (1×/DL; recarrega com Slot de Pacto).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fiend'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Lançar no Inferno: ao acertar, envie o alvo aos Infernos (1×/DL; recarrega com Slot de Pacto).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Fuga em Névoa: Reação ao sofrer dano — conjure Passo Nebuloso; efeitos Desvanecedor e Terrível entram nas opções de Passos Feéricos.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'archfey'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Fuga em Névoa: Reação ao sofrer dano — conjure Passo Nebuloso; efeitos Desvanecedor e Terrível entram nas opções de Passos Feéricos.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Defesas Sedutoras: imune a Enfeitiçado; Reação após ser acertado — metade do dano + psíquico no atacante (1×/DL ou Slot de Pacto).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'archfey'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Defesas Sedutoras: imune a Enfeitiçado; Reação após ser acertado — metade do dano + psíquico no atacante (1×/DL ou Slot de Pacto).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Magia Sedutora: após conjurar Encantamento ou Ilusão com ação e espaço, conjure Passo Nebuloso como parte da mesma ação sem gastar espaço.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'archfey'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Magia Sedutora: após conjurar Encantamento ou Ilusão com ação e espaço, conjure Passo Nebuloso como parte da mesma ação sem gastar espaço.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Patrono Grande Antigo: Mente Desperta (telepatia BA a 9 m) e Magias Psíquicas (dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'great-old-one'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Patrono Grande Antigo: Mente Desperta (telepatia BA a 9 m) e Magias Psíquicas (dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Combatente Clarividente: ao usar Mente Desperta, alvo salva Sabedoria; falha → desv. vs você / você vant. vs alvo (1× SR/LR ou Slot).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'great-old-one'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Combatente Clarividente: ao usar Mente Desperta, alvo salva Sabedoria; falha → desv. vs você / você vant. vs alvo (1× SR/LR ou Slot).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Danação Mística: sempre tem Danação preparada; alvo também tem Desvantagem nas salvaguardas do atributo escolhido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'great-old-one'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Danação Mística: sempre tem Danação preparada; alvo também tem Desvantagem nas salvaguardas do atributo escolhido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Escudo Mental: pensamentos ilegíveis; Resistência a Psíquico; quem causar Psíquico a você também sofre o dano.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'great-old-one'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Escudo Mental: pensamentos ilegíveis; Resistência a Psíquico; quem causar Psíquico a você também sofre o dano.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Criar Servo: Invocar Aberração sem Concentração (duração 1 min) + PV temp = nível; dano psíquico extra vs alvo da sua Danação.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'great-old-one'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Criar Servo: Invocar Aberração sem Concentração (duração 1 min) + PV temp = nível; dano psíquico extra vs alvo da sua Danação.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Ritualista Arcano: conjure magias de ritual diretamente do seu Grimório sem precisar tê-las preparadas.', 0
FROM rpg.phb_class c WHERE c.slug = 'wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Ritualista Arcano: conjure magias de ritual diretamente do seu Grimório sem precisar tê-las preparadas.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Dominância de Magias: escolha 1º e 2º círculo na aba Magias; conjure à vontade sem espaço.', 0
FROM rpg.phb_class c WHERE c.slug = 'wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Dominância de Magias: escolha 1º e 2º círculo na aba Magias; conjure à vontade sem espaço.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 20, 'Assinatura de Magia: 2 magias de 3º círculo preparadas sempre disponíveis; 1× por descanso longo conjure cada uma sem gastar slot.', 0
FROM rpg.phb_class c WHERE c.slug = 'wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 20 AND n.note = 'Assinatura de Magia: 2 magias de 3º círculo preparadas sempre disponíveis; 1× por descanso longo conjure cada uma sem gastar slot.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Abjurador: Proteção Arcana (barreira ao conjurar Abjuração 1º+; Ação Bônus gasta slot para recuperar 2× círculo).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'abjurer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Abjurador: Proteção Arcana (barreira ao conjurar Abjuração 1º+; Ação Bônus gasta slot para recuperar 2× círculo).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Resistência à Magia: vantagem em salvaguardas contra magias; Resistência a dano de magias.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'abjurer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Resistência à Magia: vantagem em salvaguardas contra magias; Resistência a dano de magias.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Perito em Adivinhação: ao conjurar Adivinhação com espaço de 2º+, recupere um espaço de nível inferior.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'diviner'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Perito em Adivinhação: ao conjurar Adivinhação com espaço de 2º+, recupere um espaço de nível inferior.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Evocador: Truque Potente (em salvaguarda bem-sucedida contra seu truque de dano, o alvo ainda sofre metade).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'evoker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Evocador: Truque Potente (em salvaguarda bem-sucedida contra seu truque de dano, o alvo ainda sofre metade).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Esculpir Magias: escolha aliados na área de Evocação; passam automaticamente e não sofrem dano.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'evoker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Esculpir Magias: escolha aliados na área de Evocação; passam automaticamente e não sofrem dano.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Evocação Potencializada: ao rolar dano de Evocação conjurada com espaço, trate 1s no dado como 2s.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'evoker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Evocação Potencializada: ao rolar dano de Evocação conjurada com espaço, trate 1s no dado como 2s.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Ilusionista: Ilusão Aprimorada (truques de Ilusão e Imagem Silenciosa como Ação Bônus, sem V, alcance dobrado).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'illusionist'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Ilusionista: Ilusão Aprimorada (truques de Ilusão e Imagem Silenciosa como Ação Bônus, sem V, alcance dobrado).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mago dos Mísseis: +1–4 dardos nos nv. 3/6/10/14; penetram Escudo. Economia na aba Ações (gratuitos, Versáteis, Escudo, Giga).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'magic-missile-mage'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mago dos Mísseis: +1–4 dardos nos nv. 3/6/10/14; penetram Escudo. Economia na aba Ações (gratuitos, Versáteis, Escudo, Giga).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Sangromante: Dados de Sangromancia (d12; máx. = 1 + nível de Mago). Gaste no lugar de Dados de Vida ao conjurar magias de Sangromancia. Recupera 1 no Descanso Curto, todos no Longo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sangromancer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Sangromante: Dados de Sangromancia (d12; máx. = 1 + nível de Mago). Gaste no lugar de Dados de Vida ao conjurar magias de Sangromancia. Recupera 1 no Descanso Curto, todos no Longo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Especialista em Sangromancia: magias de Sangromancia contam como de Mago; grimório ganha escolhas gratuitas na aba de opções de subclasse.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'sangromancer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Especialista em Sangromancia: magias de Sangromancia contam como de Mago; grimório ganha escolhas gratuitas na aba de opções de subclasse.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Sangue por Sangue: 1×/turno, ao causar dano com magia de Mago, gaste DV ou Dado de Sangromancia para dano extra (Ferido: role 2×, use o maior).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sangromancer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Sangue por Sangue: 1×/turno, ao causar dano com magia de Mago, gaste DV ou Dado de Sangromancia para dano extra (Ferido: role 2×, use o maior).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Renovação Rubra: após Descanso Curto, recupere metade do nível em DV e Dados de Sangromancia (1× até o próximo Descanso Longo).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sangromancer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Renovação Rubra: após Descanso Curto, recupere metade do nível em DV e Dados de Sangromancia (1× até o próximo Descanso Longo).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Ordem Divina: Protetor concede armas Marciais e Armadura Pesada; Taumaturgo concede um truque e +SAB (mín. +1) em Arcanismo/Religião', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Ordem Divina: Protetor concede armas Marciais e Armadura Pesada; Taumaturgo concede um truque e +SAB (mín. +1) em Arcanismo/Religião'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Fulminar Mortos-Vivos: mortos-vivos que falham contra Expulsar sofrem dados Radiantes iguais ao mod. SAB (mín. 1d8)', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Fulminar Mortos-Vivos: mortos-vivos que falham contra Expulsar sofrem dados Radiantes iguais ao mod. SAB (mín. 1d8)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 10, 'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo sem espaço ou componente Material (1×/Descanso Longo)', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 10 AND n.note = 'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo sem espaço ou componente Material (1×/Descanso Longo)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Golpes Abençoados Aprimorados: Conjuração Poderosa concede 2×SAB PV temporários ou Golpe Divino causa 2d8', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Golpes Abençoados Aprimorados: Conjuração Poderosa concede 2×SAB PV temporários ou Golpe Divino causa 2d8'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 20, 'Intervenção Divina Maior: pode escolher Desejo; nesse caso, recarga após 2d4 Descansos Longos', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 20 AND n.note = 'Intervenção Divina Maior: pode escolher Desejo; nesse caso, recarga após 2d4 Descansos Longos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Domínio da Vida: Discípulo da Vida soma 2 + círculo à cura; Preservar a Vida distribui 5 × nível em PV até metade do máximo', 0
FROM rpg.phb_subclass s WHERE s.slug = 'life'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Domínio da Vida: Discípulo da Vida soma 2 + círculo à cura; Preservar a Vida distribui 5 × nível em PV até metade do máximo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Curandeiro Abençoado: ao curar outra criatura com espaço, recupere 2 + círculo em PV', 0
FROM rpg.phb_subclass s WHERE s.slug = 'life'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Curandeiro Abençoado: ao curar outra criatura com espaço, recupere 2 + círculo em PV'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Cura Suprema: dados de cura usam o valor máximo', 0
FROM rpg.phb_subclass s WHERE s.slug = 'life'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Cura Suprema: dados de cura usam o valor máximo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Domínio da Luz: Brilho do Amanhecer causa 2d10 + nível Radiante; Labareda Protetora impõe Desvantagem como Reação', 0
FROM rpg.phb_subclass s WHERE s.slug = 'light'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Domínio da Luz: Brilho do Amanhecer causa 2d10 + nível Radiante; Labareda Protetora impõe Desvantagem como Reação'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Labareda Protetora Aprimorada: recupera em Descanso Curto e concede 2d6 + SAB PV temporários', 0
FROM rpg.phb_subclass s WHERE s.slug = 'light'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Labareda Protetora Aprimorada: recupera em Descanso Curto e concede 2d6 + SAB PV temporários'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Coroa de Luz: aura de luz solar; inimigos têm Desvantagem nas salvaguardas contra dano Ígneo/Radiante', 0
FROM rpg.phb_subclass s WHERE s.slug = 'light'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Coroa de Luz: aura de luz solar; inimigos têm Desvantagem nas salvaguardas contra dano Ígneo/Radiante'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Domínio da Trapaça: Bênção do Trapaceiro dá Vantagem em Furtividade; Invocar Duplicidade cria a ilusão com Canalizar Divindade', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Domínio da Trapaça: Bênção do Trapaceiro dá Vantagem em Furtividade; Invocar Duplicidade cria a ilusão com Canalizar Divindade'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Transposição do Trapaceiro: troque de lugar com a ilusão', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Transposição do Trapaceiro: troque de lugar com a ilusão'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Duplicidade Aprimorada: aliados também recebem a distração', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Duplicidade Aprimorada: aliados também recebem a distração'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Domínio da Guerra: Ataque Direcionado concede +10 após um erro; Sacerdote da Guerra faz ataque com Ação Bônus', 0
FROM rpg.phb_subclass s WHERE s.slug = 'war'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Domínio da Guerra: Ataque Direcionado concede +10 após um erro; Sacerdote da Guerra faz ataque com Ação Bônus'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Bênção do Deus da Guerra: Canalizar conjura Arma Espiritual ou Escudo da Fé sem espaço e sem Concentração', 0
FROM rpg.phb_subclass s WHERE s.slug = 'war'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Bênção do Deus da Guerra: Canalizar conjura Arma Espiritual ou Escudo da Fé sem espaço e sem Concentração'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Avatar da Guerra: Resistência a dano Contundente, Cortante e Perfurante', 0
FROM rpg.phb_subclass s WHERE s.slug = 'war'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Avatar da Guerra: Resistência a dano Contundente, Cortante e Perfurante'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Domínio do Dragão: após Descanso Longo escolha Ácido/Frio/Fogo/Relâmpago/Veneno; troque Necrótico/Radiante de Clérigo por esse tipo e cause dano extra = nível (usos = mod. SAB).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dragon-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Domínio do Dragão: após Descanso Longo escolha Ácido/Frio/Fogo/Relâmpago/Veneno; troque Necrótico/Radiante de Clérigo por esse tipo e cause dano extra = nível (usos = mod. SAB).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Majestade Dracônica: Canalizar Divindade — Emanação 9 m Enfeitiçado ou Amedrontado (salvaguarda SAB).', 1
FROM rpg.phb_subclass s WHERE s.slug = 'dragon-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Majestade Dracônica: Canalizar Divindade — Emanação 9 m Enfeitiçado ou Amedrontado (salvaguarda SAB).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Bênção da Serpe: Canalizar para Sopro do Dragão ou Proteção contra Energia em você sem Concentração.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dragon-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Bênção da Serpe: Canalizar para Sopro do Dragão ou Proteção contra Energia em você sem Concentração.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Aspecto Lendário: 3 ações lendárias/DL (Rasgar, Cauda, Asas) — Usar no painel/economia.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dragon-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Aspecto Lendário: 3 ações lendárias/DL (Rasgar, Cauda, Asas) — Usar no painel/economia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Pau para Toda Obra: adicione metade da PB (arredondada para baixo) em testes de habilidade sem proficiência.', 0
FROM rpg.phb_class c WHERE c.slug = 'bard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Pau para Toda Obra: adicione metade da PB (arredondada para baixo) em testes de habilidade sem proficiência.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Balada de Cura: criaturas que gastam Dados de Vida no Descanso Curto recuperam +1d6 PV extras.', 1
FROM rpg.phb_class c WHERE c.slug = 'bard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Balada de Cura: criaturas que gastam Dados de Vida no Descanso Curto recuperam +1d6 PV extras.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Fonte de Inspiração: Inspiração de Bardo recarrega em Descanso Curto ou Longo.', 0
FROM rpg.phb_class c WHERE c.slug = 'bard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Fonte de Inspiração: Inspiração de Bardo recarrega em Descanso Curto ou Longo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração de Bardo, recupere 1 uso.', 0
FROM rpg.phb_class c WHERE c.slug = 'bard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração de Bardo, recupere 1 uso.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Colégio do Conhecimento: Palavras de Interrupção (Reação: gasta Inspiração para subtrair do ataque/teste/dano inimigo).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'lore'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Colégio do Conhecimento: Palavras de Interrupção (Reação: gasta Inspiração para subtrair do ataque/teste/dano inimigo).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Descobertas Mágicas: aprenda 2 magias adicionais de qualquer lista.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'lore'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Descobertas Mágicas: aprenda 2 magias adicionais de qualquer lista.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Perícia Inigualável: após falhar teste/ataque, some o dado de Inspiração (só gasta se virar sucesso).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'lore'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Perícia Inigualável: após falhar teste/ataque, some o dado de Inspiração (só gasta se virar sucesso).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Colégio do Glamour: Manto de Inspiração (gasta Inspiração para PV temp. 2×dado e movimento por Reação).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glamour'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Colégio do Glamour: Manto de Inspiração (gasta Inspiração para PV temp. 2×dado e movimento por Reação).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Manto de Majestade: Comando sem espaço (1×/DL; restaurável com espaço 3+).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glamour'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Manto de Majestade: Comando sem espaço (1×/DL; restaurável com espaço 3+).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Majestade Inquebrável: presença 1 min — atacante falha salvo CAR ou o ataque falha.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'glamour'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Majestade Inquebrável: presença 1 min — atacante falha salvo CAR ou o ataque falha.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Colégio da Dança: Dança Virtuosa (Ataque Desarmado com DES + dado de Inspiração; Golpes Ágeis ao gastar Inspiração).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Colégio da Dança: Dança Virtuosa (Ataque Desarmado com DES + dado de Inspiração; Golpes Ágeis ao gastar Inspiração).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Movimento Coordenado (iniciativa) e Movimento Inspirador (Reação a 1,5 m).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Movimento Coordenado (iniciativa) e Movimento Inspirador (Reação a 1,5 m).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Evasão Liderada: Evasão e compartilhe com aliado a 1,5 m.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dance'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Evasão Liderada: Evasão e compartilhe com aliado a 1,5 m.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Colégio da Bravura: Inspiração em Combate (aliados usam Inspiração na CA ou no dano). Proficiência Marcial/Escudo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'valor'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Colégio da Bravura: Inspiração em Combate (aliados usam Inspiração na CA ou no dano). Proficiência Marcial/Escudo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Ataque Extra (Bravura): pode substituir um ataque por um Truque.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'valor'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Ataque Extra (Bravura): pode substituir um ataque por um Truque.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Magia de Batalha: após magia de ação, ataque com arma como Ação Bônus.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'valor'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Magia de Batalha: após magia de ação, ataque com arma como Ação Bônus.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Colégio das Máscaras: vista máscaras no painel; efeitos que gastam Inspiração têm Usar (Anjo/Diabo/Dragão/Gladiador/Bobão).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'college-of-masks'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Colégio das Máscaras: vista máscaras no painel; efeitos que gastam Inspiração têm Usar (Anjo/Diabo/Dragão/Gladiador/Bobão).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Artista Teatral: Kit de Disfarce; some o dado de Inspiração em Atuação sem gastar uso.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'college-of-masks'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Artista Teatral: Kit de Disfarce; some o dado de Inspiração em Atuação sem gastar uso.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Habilidade de Virtuoso: 1×/turno Teste d20 com Carisma (usos = mod. CAR).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'college-of-masks'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Habilidade de Virtuoso: 1×/turno Teste d20 com Carisma (usos = mod. CAR).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Mestre de Muitas Faces: use duas máscaras ao mesmo tempo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'college-of-masks'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Mestre de Muitas Faces: use duas máscaras ao mesmo tempo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Ordem Primal: escolha entre Protetor (Armaduras Médias e Armas Marciais) ou Magista (+1 truque de Druida).', 0
FROM rpg.phb_class c WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Ordem Primal: escolha entre Protetor (Armaduras Médias e Armas Marciais) ou Magista (+1 truque de Druida).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Ressurgimento Selvagem: gaste 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo (ou 1 slot de 1º círculo para recuperar 1 uso de Forma Selvagem).', 0
FROM rpg.phb_class c WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Ressurgimento Selvagem: gaste 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo (ou 1 slot de 1º círculo para recuperar 1 uso de Forma Selvagem).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Besta Feiticeira: conjure magias na Forma Selvagem sem componentes V ou S.', 0
FROM rpg.phb_class c WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Besta Feiticeira: conjure magias na Forma Selvagem sem componentes V ou S.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 20, 'Arquidruida: recupere 1 uso de Forma Selvagem ao rolar Iniciativa se não houver usos restantes.', 0
FROM rpg.phb_class c WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 20 AND n.note = 'Arquidruida: recupere 1 uso de Forma Selvagem ao rolar Iniciativa se não houver usos restantes.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Lua L6: ataques na forma podem ser Radiantes; +SAB em salvaguardas de Constituição.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'moon'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Lua L6: ataques na forma podem ser Radiantes; +SAB em salvaguardas de Constituição.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Passo Lunar: teleporte 9 m (usos = SAB); restaurar com espaço 2+.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'moon'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Passo Lunar: teleporte 9 m (usos = SAB); restaurar com espaço 2+.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Forma Lunar: +2d10 radiante 1×/turno na forma; Passo Lunar pode levar um aliado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'moon'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Forma Lunar: +2d10 radiante 1×/turno na forma; Passo Lunar pode levar um aliado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Recuperação Natural: 1 magia do Círculo sem espaço (1×/DL); no Descanso Curto recupere slots (soma ≤ ⌈nível/2⌉, sem 6+).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'land'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Recuperação Natural: 1 magia do Círculo sem espaço (1×/DL); no Descanso Curto recupere slots (soma ≤ ⌈nível/2⌉, sem 6+).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Proteção Natural: imune a Envenenado; resistência conforme terreno escolhido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'land'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Proteção Natural: imune a Envenenado; resistência conforme terreno escolhido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Santuário Natural: gaste Forma Selvagem — cubo 4,5 m com cobertura parcial (mover com Ação Bônus).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'land'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Santuário Natural: gaste Forma Selvagem — cubo 4,5 m com cobertura parcial (mover com Ação Bônus).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mapa Estelar: Raio Guia gratuito (usos = SAB) + Orientação preparada.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'stars'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mapa Estelar: Raio Guia gratuito (usos = SAB) + Orientação preparada.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Presságio Cósmico: após DL, Reação ±1d6 em Teste de D20 (usos = SAB).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'stars'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Presságio Cósmico: após DL, Reação ±1d6 em Teste de D20 (usos = SAB).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Constelações Cintilantes: 2d8; Dragão voo 6 m; trocar constelação no início do turno.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'stars'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Constelações Cintilantes: 2d8; Dragão voo 6 m; trocar constelação no início do turno.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Manifestação Oceânica: gaste 2 usos de Forma Selvagem para a variante aprimorada (mesa).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sea'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Manifestação Oceânica: gaste 2 usos de Forma Selvagem para a variante aprimorada (mesa).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Círculo da Cidade: gaste Forma Selvagem para Fundir-se na Pedra, Passagem ou Moldar Rocha sem espaço; magias urbanas usam estética de cidade.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-the-city'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Círculo da Cidade: gaste Forma Selvagem para Fundir-se na Pedra, Passagem ou Moldar Rocha sem espaço; magias urbanas usam estética de cidade.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Forma de Objeto: Forma Selvagem como Objeto Animado (até Grande; Enorme no nv. 10).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-the-city'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Forma de Objeto: Forma Selvagem como Objeto Animado (até Grande; Enorme no nv. 10).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Distorção de Muro: Reação cria painel de Muralha de Pedra (1×/LR ou espaço 3º+) — veja recurso.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-the-city'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Distorção de Muro: Reação cria painel de Muralha de Pedra (1×/LR ou espaço 3º+) — veja recurso.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Colosso Urbano: na forma de objeto, CA 18, limiar de dano, Multiataque e atravessar criaturas.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-the-city'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Colosso Urbano: na forma de objeto, CA 18, limiar de dano, Multiataque e atravessar criaturas.'
  );
