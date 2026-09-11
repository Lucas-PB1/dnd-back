-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa clérigo: core + domínios (Life/Light/Trickery/War/Dragon).

-- Centelha Divina — Cura
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'divine-spark-heal', 2, 1,
         'Centelha Divina — Cura'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_divine_spark_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'divine-spark-heal' AND e.kind = 'heal'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Centelha Divina: restaure {total} PV ({expression}; ajuste se for aliado).'
FROM fx;

-- Centelha Divina — Dano
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'divine-spark-damage', 2, 1,
         'Centelha Divina — CD'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'divine-spark-damage', 2, 2,
         'Centelha Divina — Dano'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_divine_spark_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'divine-spark-damage' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Centelha Divina: CD {saveDc} de CON; {total} Necrótico ou Radiante ({expression}), metade no sucesso.'
FROM fx;

-- Expulsar Mortos-Vivos
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'turn-undead', 2, 1,
         'Expulsar Mortos-Vivos — CD'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'turn-undead', 2, 2,
         'Expulsar Mortos-Vivos'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Expulsar Mortos-Vivos: CD de SAB; falha deixa Mortos-Vivos Amedrontados e Incapacitados por 1 minuto (encerra ao sofrer dano).'
FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'turn-undead', 5, 3,
         'Fulminar Mortos-Vivos'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'ability_mod_d8'::rpg.effect_amount_formula, NULL FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'turn-undead' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Expulsar Mortos-Vivos + Fulminar: CD {saveDc} de SAB; na falha, sofre {total} Radiante ({expression}) e fica Amedrontado/Incapacitado.'
FROM fx;

-- Intervenção Divina
WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'divine-intervention', 10, 1,
         'Intervenção Divina'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo, sem Reação, espaço ou componente Material. Nv. 20+: também Desejo (bloqueia a característica por 2d4 Descansos Longos).'
FROM ins;

-- Preservar a Vida
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'life'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'preserve-life', 3, 1,
         'Preservar a Vida'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level_times_5'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'life'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'preserve-life' AND e.kind = 'heal'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Preservar a Vida: distribua até o pool entre criaturas Sangrando a 9 m; nenhuma passa da metade dos PV máximos.'
FROM fx;

-- Brilho do Amanhecer
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'radiance-of-dawn', 3, 1,
         'Brilho do Amanhecer — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_roll'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'radiance-of-dawn', 3, 2,
         'Brilho do Amanhecer'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_2d10_plus_level'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'radiance-of-dawn' AND e.kind = 'table_roll'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Brilho do Amanhecer: dissipa Escuridão mágica; CD {saveDc} de CON, {total} Radiante ({expression}) ou metade.'
FROM fx;

-- Labareda Protetora
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'warding-flare', 3, 1,
         'Labareda Protetora'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Labareda Protetora: Reação para impor Desvantagem ao ataque de uma criatura visível a até 9 m.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'temp_hp'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'warding-flare', 6, 2,
         'Labareda Protetora Aprimorada'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_2d6_plus_flat'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'warding-flare' AND e.kind = 'temp_hp'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Labareda Protetora: imponha Desvantagem e conceda PV temporários ao alvo do ataque. Aplicado na ficha — ajuste o contador se o alvo for um aliado.'
FROM fx;

-- Coroa de Luz
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'crown-of-light', 17, 1,
         'Coroa de Luz'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Coroa de Luz: aura de luz solar por 1 minuto; inimigos na Luz Plena têm Desvantagem em salvaguardas contra seu dano Ígneo ou Radiante.'
FROM ins;

-- Bênção do Trapaceiro
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'tricksters-blessing', 3, 1,
         'Bênção do Trapaceiro'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Bênção do Trapaceiro: você ou uma criatura voluntária a 9 m recebe Vantagem em Furtividade até o Descanso Longo ou uma nova bênção.'
FROM ins;

-- Invocar Duplicidade
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'invoke-duplicity', 3, 1,
         'Invocar Duplicidade'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Invocar Duplicidade: Ação Bônus cria a ilusão por 1 minuto. Conjure a partir dela e obtenha Vantagem contra criaturas distraídas.'
FROM ins;

-- Ataque Direcionado
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'guided-strike', 3, 1,
         'Ataque Direcionado'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 10 FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'guided-strike' AND e.kind = 'table_note'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ataque Direcionado: some +10 à jogada de ataque que errou, potencialmente transformando-a em acerto.'
FROM fx;

-- Sacerdote da Guerra
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'war-priest', 3, 1,
         'Sacerdote da Guerra'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sacerdote da Guerra: use uma Ação Bônus para realizar um ataque com arma ou Ataque Desarmado.'
FROM ins;

-- Bênção do Deus da Guerra
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'war-gods-blessing', 6, 1,
         'Bênção do Deus da Guerra'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Bênção do Deus da Guerra: conjure Arma Espiritual ou Escudo da Fé sem espaço; não requer Concentração e dura até 1 minuto.'
FROM ins;

-- Majestade Dracônica
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'dragon-majesty', 3, 1,
         'Majestade Dracônica — CD'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'dragon-majesty', 3, 2,
         'Majestade Dracônica'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Majestade Dracônica: Emanação 9 m — escolha Enfeitiçado ou Amedrontado. CD de SAB; falha = condição por 1 minuto (repete no fim do turno).'
FROM ins;

-- Bênção da Serpe
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'serpent-blessing', 6, 1,
         'Bênção da Serpe'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Bênção da Serpe: conjure Sopro do Dragão ou Proteção contra Energia em si mesmo sem espaço; a magia não exige Concentração.'
FROM ins;

-- Afinidade Cromática
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'chromatic-affinity', 3, 1,
         'Afinidade Cromática'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'level'::rpg.effect_amount_formula, NULL FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN sc ON sc.id = e.owner_id
  WHERE e.action_slug = 'chromatic-affinity' AND e.kind = 'table_note'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Afinidade Cromática: ao causar dano do tipo escolhido no Descanso Longo, some o nível daquele tipo (1×/turno).'
FROM fx;

-- Aspecto Lendário
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'legendary-aspect-rend', 17, 1,
         'Aspecto — Rasgar'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Rasgar: mova-se até seu Deslocamento e conjure um Truque de Clérigo (ação) ou faça um ataque corpo a corpo (ataque/dano usam Sabedoria). Não repita esta opção até o início do seu próximo turno.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'legendary-aspect-tail', 17, 1,
         'Aspecto — Golpe de Cauda'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Golpe de Cauda: cada criatura Grande ou menor à sua escolha a até 3 m fica Caída. Não repita esta opção até o início do seu próximo turno.'
FROM ins;

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, 'legendary-aspect-wings', 17, 1,
         'Aspecto — Bater de Asas'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Bater de Asas: mova-se imediatamente até seu Deslocamento com Deslocamento de Voo igual ao seu Deslocamento; não provoca Ataques de Oportunidade. Não repita esta opção até o início do seu próximo turno.'
FROM ins;
