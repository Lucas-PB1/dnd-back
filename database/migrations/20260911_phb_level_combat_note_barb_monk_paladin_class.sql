-- Notas de classe (estáticas) — bárbaro, monge, paladino.
-- Templates dinâmicos (Fúria ativa, dado de Artes Marciais, aura m, etc.) ficam no TS.

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Sentido de Perigo: Vantagem em salvaguardas de Destreza (se não Incapacitado)', 0
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Sentido de Perigo: Vantagem em salvaguardas de Destreza (se não Incapacitado)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Bote Instintivo: ao entrar em Fúria, mova-se até metade do Deslocamento', 0
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Bote Instintivo: ao entrar em Fúria, mova-se até metade do Deslocamento'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Instintos Primitivos: Vantagem na Iniciativa', 1
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Instintos Primitivos: Vantagem na Iniciativa'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 11, 'Fúria Implacável: se cair a 0 PV com Fúria ativa, teste CON (CD 10+) para ficar com 1 PV', 0
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 11 AND n.note = 'Fúria Implacável: se cair a 0 PV com Fúria ativa, teste CON (CD 10+) para ficar com 1 PV'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 15, 'Fúria Persistente: na Iniciativa pode recuperar todas as Fúrias (1× por descanso longo); Fúria dura 10 min sem extensão rodada a rodada', 0
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 15 AND n.note = 'Fúria Persistente: na Iniciativa pode recuperar todas as Fúrias (1× por descanso longo); Fúria dura 10 min sem extensão rodada a rodada'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Força Indomável: se o total de teste/salvaguarda de Força for menor que seu valor de Força, use o valor de Força', 0
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Força Indomável: se o total de teste/salvaguarda de Força for menor que seu valor de Força, use o valor de Força'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Foco do Monge: Torrente de Golpes, Defesa Paciente e Passos do Vento (Pontos de Foco)', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Foco do Monge: Torrente de Golpes, Defesa Paciente e Passos do Vento (Pontos de Foco)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 3, 'Defletir Ataques: Reação reduz dano corpo a corpo/à distância', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 3 AND n.note = 'Defletir Ataques: Reação reduz dano corpo a corpo/à distância'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 4, 'Queda Lenta: Reação reduz dano de queda', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 4 AND n.note = 'Queda Lenta: Reação reduz dano de queda'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Ataque Extra: dois ataques na ação Atacar', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Ataque Extra: dois ataques na ação Atacar'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Golpe Atordoante: gaste 1 Foco no acerto para forçar salvaguarda de Constituição', 1
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Golpe Atordoante: gaste 1 Foco no acerto para forçar salvaguarda de Constituição'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 6, 'Golpes Potencializados: dano pode ser Energético', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 6 AND n.note = 'Golpes Potencializados: dano pode ser Energético'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha, metade', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha, metade'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 10, 'Foco Aprimorado: aprimora Foco do Monge', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 10 AND n.note = 'Foco Aprimorado: aprimora Foco do Monge'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 13, 'Defletir Energia: Defletir contra qualquer dano', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 13 AND n.note = 'Defletir Energia: Defletir contra qualquer dano'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Sobrevivente Disciplinado: proficiência em todas as salvaguardas; 1 Foco para rerrolar', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Sobrevivente Disciplinado: proficiência em todas as salvaguardas; 1 Foco para rerrolar'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Defesa Superior: 3 Foco para Resistência a quase tudo (1 min)', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Defesa Superior: 3 Foco para Resistência a quase tudo (1 min)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Mãos Consagradas: reserva de cura = 5 × nível (Ação Bônus; 5 PV removem Envenenado)', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Mãos Consagradas: reserva de cura = 5 × nível (Ação Bônus; 5 PV removem Envenenado)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Destruição Divina: gaste um espaço de magia no acerto para +2d8 Radiante (+1d8 por círculo acima do 1º; +1d8 vs Corruptor/Morto-vivo)', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Destruição Divina: gaste um espaço de magia no acerto para +2d8 Radiante (+1d8 por círculo acima do 1º; +1d8 vs Corruptor/Morto-vivo)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 3, 'Canalizar Divindade: Sentido Divino e opções do juramento (usos por descanso)', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 3 AND n.note = 'Canalizar Divindade: Sentido Divino e opções do juramento (usos por descanso)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 5, 'Ataque Extra: dois ataques na ação Atacar', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 5 AND n.note = 'Ataque Extra: dois ataques na ação Atacar'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Repudiar Inimigos: Canalizar Divindade para Amedrontar inimigos', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Repudiar Inimigos: Canalizar Divindade para Amedrontar inimigos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 10, 'Aura de Coragem: imunidade a Amedrontado na aura', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 10 AND n.note = 'Aura de Coragem: imunidade a Amedrontado na aura'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 11, 'Golpes Radiantes: +1d8 Radiante em cada ataque corpo a corpo', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 11 AND n.note = 'Golpes Radiantes: +1d8 Radiante em cada ataque corpo a corpo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Toque Restaurador: gaste 5 PV das Mãos Consagradas para remover condições', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Toque Restaurador: gaste 5 PV das Mãos Consagradas para remover condições'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 18, 'Aura Expandida: alcance das auras vai a 9 m', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 18 AND n.note = 'Aura Expandida: alcance das auras vai a 9 m'
  );
