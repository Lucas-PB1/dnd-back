-- Ex-templates dinâmicos → literais com schedule; números vivos ficam no motor.

-- ========== FIGHTER (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Ataques por ação: 1 → 2 (5º) → 3 (11º) → 4 (20º) — ver ataques por ação na ficha', 0
FROM rpg.phb_class c WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Ataques por ação: 1 → 2 (5º) → 3 (11º) → 4 (20º) — ver ataques por ação na ficha'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Indomável: rerrolar salvaguarda com +nível (1× → 2× no 13º → 3× no 17º por descanso longo)', 0
FROM rpg.phb_class c WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Indomável: rerrolar salvaguarda com +nível (1× → 2× no 13º → 3× no 17º por descanso longo)'
  );

-- ========== FIGHTER (subclasses) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Campeão: crítico 19–20 (18–20 no 15º+); Vantagem em Iniciativa e Atletismo', 0
FROM rpg.phb_subclass s WHERE s.slug = 'champion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Campeão: crítico 19–20 (18–20 no 15º+); Vantagem em Iniciativa e Atletismo'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Mestre da Batalha: Dados de Superioridade (4 → 5 no 7º → 6 no 15º; d8 → d10 no 10º → d12 no 18º)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'battle-master'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Mestre da Batalha: Dados de Superioridade (4 → 5 no 7º → 6 no 15º; d8 → d10 no 10º → d12 no 18º)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Combatente Psíquico: Dados de Energia (4d6 → 6d8 no 5º → 8d8 no 9º → 8d10 no 11º → 10d10 no 13º → 12d12 no 17º)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'psi-warrior'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Combatente Psíquico: Dados de Energia (4d6 → 6d8 no 5º → 8d8 no 9º → 8d10 no 11º → 10d10 no 13º → 12d12 no 17º)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Matar Monstro: +1d10 1×/turno vs tipos escolhidos', 0
FROM rpg.phb_subclass s WHERE s.slug = 'dungeoneer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Matar Monstro: +1d10 1×/turno vs tipos escolhidos'
  );

-- ========== ROGUE (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Ataque Furtivo: 1d6 no 1º, +1d6 a cada nível ímpar (1×/turno)', 0
FROM rpg.phb_class c WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Ataque Furtivo: 1d6 no 1º, +1d6 a cada nível ímpar (1×/turno)'
  );

-- ========== ROGUE (soulknife) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Adaga Espiritual: Dados de Energia (mesma escala do Combatente Psíquico; ver painel)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'soulknife'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Adaga Espiritual: Dados de Energia (mesma escala do Combatente Psíquico; ver painel)'
  );

-- ========== RANGER (subclasses) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Golpes Terríveis: +1d4 Psíquico 1×/turno ao acertar com arma (1d6 no 11º+)', 0
FROM rpg.phb_subclass s WHERE s.slug = 'fey-wanderer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Golpes Terríveis: +1d4 Psíquico 1×/turno ao acertar com arma (1d6 no 11º+)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Emboscador das Sombras: +SAB na Iniciativa; Golpe Terrível +2d6 Psíquico (2d8 no 11º+; usos = mod. SAB); +3 m no 1º turno', 0
FROM rpg.phb_subclass s WHERE s.slug = 'gloom-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Emboscador das Sombras: +SAB na Iniciativa; Golpe Terrível +2d6 Psíquico (2d8 no 11º+; usos = mod. SAB); +3 m no 1º turno'
  );

-- ========== CLERIC (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Canalizar Divindade: Centelha Divina (1d8 → 2d8 no 7º → 3d8 no 13º → 4d8 no 18º + SAB para cura/dano) ou Expulsar Mortos-Vivos', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Canalizar Divindade: Centelha Divina (1d8 → 2d8 no 7º → 3d8 no 13º → 4d8 no 18º + SAB para cura/dano) ou Expulsar Mortos-Vivos'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 7, 'Golpes Abençoados: escolha Conjuração Poderosa (+SAB no dano de truques) ou Golpe Divino (+1d8 Necrótico/Radiante com arma, 1×/turno; 2d8 no 14º+)', 0
FROM rpg.phb_class c WHERE c.slug = 'cleric'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 7 AND n.note = 'Golpes Abençoados: escolha Conjuração Poderosa (+SAB no dano de truques) ou Golpe Divino (+1d8 Necrótico/Radiante com arma, 1×/turno; 2d8 no 14º+)'
  );

-- ========== BARD (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Inspiração de Bardo (d6 → d8 no 5º → d10 no 10º → d12 no 15º): Ação Bônus para conceder a uma criatura a até 18 m; recarrega em Descanso Longo (Curto/Longo no 5º+).', 0
FROM rpg.phb_class c WHERE c.slug = 'bard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Inspiração de Bardo (d6 → d8 no 5º → d10 no 10º → d12 no 15º): Ação Bônus para conceder a uma criatura a até 18 m; recarrega em Descanso Longo (Curto/Longo no 5º+).'
  );

-- ========== WARLOCK (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Magia de Pacto: slots de Pacto recarregam em Descanso Curto ou Longo (quantidade/círculo na tabela do Bruxo; ver magias).', 0
FROM rpg.phb_class c WHERE c.slug = 'warlock'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Magia de Pacto: slots de Pacto recarregam em Descanso Curto ou Longo (quantidade/círculo na tabela do Bruxo; ver magias).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Invocações Místicas: quantidade conhecida escala com o nível (veja o painel/ficha).', 1
FROM rpg.phb_class c WHERE c.slug = 'warlock'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Invocações Místicas: quantidade conhecida escala com o nível (veja o painel/ficha).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Astúcia Mágica: rito de 1 min recupera metade dos slots de Pacto (todos no 20º; 1×/Descanso Longo).', 0
FROM rpg.phb_class c WHERE c.slug = 'warlock'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Astúcia Mágica: rito de 1 min recupera metade dos slots de Pacto (todos no 20º; 1×/Descanso Longo).'
  );

-- ========== WARLOCK (subclasses) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Patrono Celestial: Luz Medicinal (reserva de (1+nível)d6; Ação Bônus gasta 1–CAR d6s para curar).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'celestial'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Patrono Celestial: Luz Medicinal (reserva de (1+nível)d6; Ação Bônus gasta 1–CAR d6s para curar).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante ou Revigorante; no 6º+ também Desvanecedor ou Terrível).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'archfey'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante ou Revigorante; no 6º+ também Desvanecedor ou Terrível).'
  );

-- ========== DRUID (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Forma Selvagem (2 usos → 3 no 6º → 4 no 17º): pool na Economia (±). Assumir ficha de besta = polish futuro; Ação Bônus também ativa Companheiro Selvagem (mesa).', 0
FROM rpg.phb_class c WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Forma Selvagem (2 usos → 3 no 6º → 4 no 17º): pool na Economia (±). Assumir ficha de besta = polish futuro; Ação Bônus também ativa Companheiro Selvagem (mesa).'
  );

-- ========== DRUID (subclasses) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Círculo da Lua: Forma Selvagem de Combate (ND máx. ⌊nível/3⌋, CA 13+SAB, PV temp. = 3×nível).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'moon'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Círculo da Lua: Forma Selvagem de Combate (ND máx. ⌊nível/3⌋, CA 13+SAB, PV temp. = 3×nível).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Círculo da Terra: Auxílio da Terra (2d6 → 3d6 no 10º → 4d6 no 14º dano necrótico + cura à escolha, gasta Forma Selvagem).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'land'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Círculo da Terra: Auxílio da Terra (2d6 → 3d6 no 10º → 4d6 no 14º dano necrótico + cura à escolha, gasta Forma Selvagem).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Círculo das Estrelas: Forma Estelar (Arquiro: 1d8+SAB radiante → 2d8 no 10º; Cálice: +mesmo+SAB cura; Dragão: mínimo 10).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'stars'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Círculo das Estrelas: Forma Estelar (Arquiro: 1d8+SAB radiante → 2d8 no 10º; Cálice: +mesmo+SAB cura; Dragão: mínimo 10).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Círculo do Mar: Ira do Mar (Emanação 1,5 m → 3 m no 6º, d6s = SAB de dano Gélido + empurrão 4,5 m; gasta Forma Selvagem).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sea'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Círculo do Mar: Ira do Mar (Emanação 1,5 m → 3 m no 6º, d6s = SAB de dano Gélido + empurrão 4,5 m; gasta Forma Selvagem).'
  );

-- ========== WIZARD (class) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Recuperação Arcana: 1× por dia no Descanso Curto, recupe slots cuja soma dos níveis seja até ⌈nível/2⌉ (até 5º círculo).', 0
FROM rpg.phb_class c WHERE c.slug = 'wizard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Recuperação Arcana: 1× por dia no Descanso Curto, recupe slots cuja soma dos níveis seja até ⌈nível/2⌉ (até 5º círculo).'
  );

-- ========== WIZARD (diviner) ==========
INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Adivinhador: Presságio (guarde 2d20 no início do dia → 3d20 no 14º+ e substitua qualquer d20 seu ou de outra criatura).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'diviner'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Adivinhador: Presságio (guarde 2d20 no início do dia → 3d20 no 14º+ e substitua qualquer d20 seu ou de outra criatura).'
  );
