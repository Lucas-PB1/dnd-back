DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN ('magic-initiate', 'blessed-warrior', 'druidic-warrior')
  AND e.kind = 'grant_spell';

WITH feat AS (
  SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'on_build'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat
  CROSS JOIN (
    VALUES
      ('grant_spell'::rpg.effect_kind, 1, 'Iniciado em Magia — Truque 1'),
      ('grant_spell'::rpg.effect_kind, 2, 'Iniciado em Magia — Truque 2'),
      ('grant_spell'::rpg.effect_kind, 3, 'Iniciado em Magia — Magia de 1º')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'cantrip1'
    WHEN 2 THEN 'cantrip2'
    ELSE 'firstLevelSpell'
  END,
  CASE sort_order WHEN 3 THEN 1 ELSE 0 END
FROM ins;

WITH feat AS (
  SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'
),
effects AS (
  SELECT e.id, e.sort_order
  FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat'
    AND e.kind = 'grant_spell'
    AND e.label LIKE 'Iniciado em Magia%'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order = 3 THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order = 3 THEN 1 ELSE NULL END
FROM effects;

WITH feats AS (
  SELECT id, slug FROM rpg.phb_feat
  WHERE slug IN ('blessed-warrior', 'druidic-warrior')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'on_build'::rpg.effect_trigger, 1, v.sort_order,
         f.slug || ' — ' || v.label
  FROM feats f
  CROSS JOIN (
    VALUES (1, 'Truque 1'), (2, 'Truque 2')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, CASE sort_order WHEN 1 THEN 'cantrip1' ELSE 'cantrip2' END, 0
FROM ins;

WITH feats AS (
  SELECT id FROM rpg.phb_feat
  WHERE slug IN ('blessed-warrior', 'druidic-warrior')
),
effects AS (
  SELECT e.id
  FROM rpg.phb_effect e
  JOIN feats f ON f.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL
FROM effects
ON CONFLICT (effect_id) DO NOTHING;

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'lucky', 'tough', 'healer', 'musician', 'alert', 'skilled',
    'artisan', 'savage-attacker', 'tavern-brawler'
  );

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'lucky'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'luckPoints'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Sorte — Pontos de Sorte'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'tough'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Vigoroso'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 2, 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'healer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'healer-combat-medic', 1, 1,
         'Médico de Combate'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_hit_die_plus_pb'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'healer'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.action_slug = 'healer-combat-medic'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Usar Objeto + Kit de Curandeiro: aplica cura no PC (DV+PB). Aliado: ajuste PV na mesa. Cura Garantida: rerole 1s.'
FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'grant_inspiration'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'musician-song', 1, 1,
         'Músico — Canção'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Inspiração ligada neste PC. Conceda Inspiração a até PB aliados voluntários (declare na mesa).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat
  CROSS JOIN (
    VALUES
      (2, 'Músico — Instrumento 1'),
      (3, 'Músico — Instrumento 2'),
      (4, 'Músico — Instrumento 3')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id,
  CASE sort_order
    WHEN 2 THEN 'musicalInstrument1'
    WHEN 3 THEN 'musicalInstrument2'
    ELSE 'musicalInstrument3'
  END,
  'instrument'::rpg.effect_proficiency_kind
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'alert'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'initiative_pb'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Alerta — Iniciativa'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Proficiência em Iniciativa (+PB).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'alert'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Alerta — Troca'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Após Iniciativa: pode trocar com aliado voluntário.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat
  CROSS JOIN (
    VALUES
      (1, 'Hábil — Perícia 1'),
      (2, 'Hábil — Perícia 2'),
      (3, 'Hábil — Perícia 3')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'proficiency' || sort_order, 'skill'::rpg.effect_proficiency_kind
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'purchase_discount'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_purchase'::rpg.effect_trigger, 1, 1, 'Artesão — Desconto'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_purchase_discount (effect_id, percent_off, non_magic_only)
SELECT id, 20, TRUE FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat
  CROSS JOIN (
    VALUES
      (2, 'Artesão — Ferramenta 1'),
      (3, 'Artesão — Ferramenta 2'),
      (4, 'Artesão — Ferramenta 3')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id,
  CASE sort_order
    WHEN 2 THEN 'artisanTool1'
    WHEN 3 THEN 'artisanTool2'
    ELSE 'artisanTool3'
  END,
  'tool'::rpg.effect_proficiency_kind
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 5, 'Artesão — Fabricação'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Fabricação rápida no descanso: declare na mesa (craft on rest fora do motor neste lote).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'savage-attacker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_reroll_choice'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Atacante Selvagem'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  '1×/turno: marque no dano para rolar duas vezes e escolher o resultado.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'tavern-brawler'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_die_override'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Briguento — Desarmado'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d4' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'tavern-brawler'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat
  CROSS JOIN (
    VALUES
      (2, 'Briguento — Reroll 1s'),
      (3, 'Briguento — Improvisado'),
      (4, 'Briguento — Empurrão')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 2 THEN 'Desarmado: rerole 1s nos dados de dano.'
    WHEN 3 THEN 'Armas improvisadas: declare proficiência na mesa.'
    ELSE '1×/turno: empurrar alvo 1,5 m (declare na mesa).'
  END
FROM ins;

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'ability-score-improvement', 'actor', 'athlete', 'charger', 'chef',
    'crossbow-expert', 'crusher', 'defensive-duelist', 'dual-wielder', 'durable',
    'elemental-adept', 'fey-touched', 'grappler', 'great-weapon-master',
    'heavily-armored', 'heavy-armor-master', 'inspiring-leader', 'keen-mind',
    'lightly-armored', 'mage-slayer', 'martial-weapon-training',
    'medium-armor-master', 'moderately-armored', 'mounted-combatant',
    'observant', 'piercer', 'poisoner', 'polearm-master', 'resilient',
    'ritual-caster', 'sentinel', 'shadow-touched', 'sharpshooter',
    'shield-master', 'skill-expert', 'skulker', 'slasher', 'speedy',
    'spell-sniper', 'telekinetic', 'telepathic', 'war-caster', 'weapon-master'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('great-weapon-master', 10, 'Pesada +PB',
     'Arma Pesada na ação Atacar: +PB de dano ao acertar.'),
    ('sharpshooter', 10, 'Cobertura / alcance',
     'Ataques à distância ignoram Cobertura Parcial/¾; sem Desvantagem a 1,5 m nem no alcance longo.'),
    ('crossbow-expert', 10, 'Besta',
     'Ignora Recarga em bestas; sem Desvantagem a 1,5 m; Leve em besta Leve soma mod. no ataque extra.'),
    ('speedy', 10, 'Deslocamento / OA',
     '+3 m Deslocamento; Correr ignora Terreno Difícil no turno; Desvantagem em Ataques de Oportunidade contra você.'),
    ('crusher', 10, 'Contundente',
     '1×/turno (Contundente): mover alvo 1,5 m; crítico Contundente â Vantagem nos ataques contra o alvo até seu próximo turno.'),
    ('piercer', 10, 'Perfurante',
     '1×/turno (Perfurante): rerole 1 dado de dano; crítico Perfurante â +1 dado de dano.'),
    ('slasher', 10, 'Cortante',
     '1×/turno (Cortante): â3 m Deslocamento do alvo; crítico Cortante â Desvantagem nos ataques dele até seu próximo turno.'),
    ('heavy-armor-master', 10, 'Redução Pesada',
     'Com armadura Pesada: reduza Contundente/Cortante/Perfurante de ataques em PB.'),
    ('medium-armor-master', 10, 'CA Média',
     'Armadura Média: some até +3 de DES à CA (se DES â¥ 16).'),
    ('mounted-combatant', 10, 'Montado',
     'Montado: Vantagem vs desmontados menores; redirecionar ataque à montaria; montaria Evasão parcial.'),
    ('grappler', 10, 'Agarrar',
     'Desarmado: Dano+Imobilizar 1×/turno; Vantagem vs Imobilizado por você; sem custo extra de movimento.'),
    ('skulker', 10, 'Sorrateiro',
     'Visão às Cegas 3 m; Vantagem em Furtividade ao Esconder em combate; erro de ataque oculto não revela você.'),
    ('athlete', 10, 'Atleta',
     'Deslocamento de Escalada; levantar com 1,5 m; saltar após 1,5 m de corrida.'),
    ('charger', 10, 'Correr +3 m',
     'Correr: +3 m de Deslocamento nesta ação.'),
    ('elemental-adept', 10, 'Elemental',
     'Magias do tipo escolhido ignoram Resistência; 1s nos dados de dano viram 2.'),
    ('spell-sniper', 10, 'Atirador Arcano',
     'Ataques de magia ignoram Cobertura Parcial/¾; sem Desvantagem a 1,5 m; +18 m de alcance em magias de ataque (â¥ 3 m).'),
    ('poisoner', 10, 'Veneno',
     'Dano Venenoso ignora Resistência a Veneno.'),
    ('mage-slayer', 10, 'Concentração',
     'Dano a concentrador: Desvantagem na salvaguarda de Concentração.'),
    ('sentinel', 10, 'Deter',
     'Ao acertar Ataque de Oportunidade: Deslocamento do alvo = 0 no turno.'),
    ('dual-wielder', 10, 'Duas armas',
     'Ação Bônus: ataque com arma em outra mão (pode não ser Leve; não Duas Mãos). Saque/guarda duas armas ao sacar uma.'),
    ('war-caster', 10, 'Guerra',
     'OA pode conjurar magia em vez de ataque; componentes somáticos com armas/escudo.'),
    ('shield-master', 10, 'Escudo halfâ0',
     'Reação: sucesso em salvaguarda de Destreza que reduziria dano pela metade â 0 dano (com escudo).'),
    ('actor', 10, 'Mimetismo',
     'Mimetismo de fala/sons; CD Intuição vs seu teste de Enganação/Atuação.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT ins.id, r.note
FROM ins
JOIN rows r ON r.label = ins.label;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'durable'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'death_save_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_death_save'::rpg.effect_trigger, 1, 1, 'Salvaguarda contra a Morte'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Vantagem em Salvaguardas Contra a Morte.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Maestria Pesada'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'damage_bonus' AND e.label = 'Maestria Pesada'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escopo: arma Pesada na ação Atacar (auto).' FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'mageSlayerGuard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Resguardo Mental â pool'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'ritualQuick'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Ritual Rápido — pool'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'succeed_failed_save'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 'mageSlayerGuard', 1, 2, 'Resguardo Mental'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ao falhar salvaguarda Int/Sab/Cha: gastar 1 uso â tratar como sucesso. Recupera no DC ou DL.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'war-caster'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'check_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Concentração'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Vantagem em salvaguardas de Concentração (gate: concentrando). Offer+toggle na UI.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'skulker'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Visão às Cegas'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Visão às Cegas 3 m (grant_sense; wire read-model depois).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'speedy'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'speed_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Aumento de Deslocamento'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 10 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'speedy'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'speed_bonus'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, '+3 m ao Deslocamento (walk).' FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 20, 'Passo Nebuloso'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 2
FROM ins CROSS JOIN rpg.phb_spell s WHERE s.slug = 'passo-nebuloso';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.label = 'Passo Nebuloso'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 21, 'Magia Feérica â opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Magia Feérica â opção'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 22, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Atributo de conjuração = o aprimorado por este talento (option castingAbility / ASI). Free 1/DL cada; slots OK.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 20, 'Invisibilidade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 2
FROM ins CROSS JOIN rpg.phb_spell s WHERE s.slug = 'invisibilidade';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Invisibilidade'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 21, 'Magia Sombria â opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Magia Sombria â opção'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 22, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Atributo de conjuração = o aprimorado por este talento. Free 1/DL cada; slots OK.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 20, 'Mãos Mágicas'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0
FROM ins CROSS JOIN rpg.phb_spell s WHERE s.slug = 'maos-magicas';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Mãos Mágicas'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('spell_range_bonus'::rpg.effect_kind, 21, 'Alcance +9 m'),
      ('spellcasting_ability'::rpg.effect_kind, 22, 'Atributo de conjuração'),
      ('feature_dc'::rpg.effect_kind, 23, 'Empurrão telepático')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 21 THEN 'Mãos Mágicas: alcance (e distância da mão) +9 m na carta/notas.'
    WHEN 22 THEN 'Atributo de conjuração = o aprimorado por este talento.'
    ELSE 'Ação Bônus: CD 8+mod ASI+PB, save For; offer mover perto/longe 1,5 m.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'spell_range_bonus'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 30 FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 20, 'Enunciado Telepático'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Falar telepaticamente a 18 m (idioma conhecido; sem resposta telepática).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 21, 'Detectar Pensamentos'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 2
FROM ins CROSS JOIN rpg.phb_spell s WHERE s.slug = 'detectar-pensamentos';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Detectar Pensamentos'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 22, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Atributo de conjuração = o aprimorado por este talento. Free 1/DL; slots OK; sem componentes no free.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'athlete'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_climb_speed'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Deslocamento de Escalada'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Deslocamento de Escalada igual ao Deslocamento (walk).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'charger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'dash_speed_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Correr +3 m'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 10 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'charger'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'dash_speed_bonus'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Ao Correr (Dash): +3 m de Deslocamento nesta ação.' FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'extra_melee_attack'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Cortar'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'BA: ataque C/C extra após crítico ou reduzir alvo a 0 PV (triggers critical_hit | reduce_to_0).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'defensive-duelist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ac_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Aparar'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'defensive-duelist'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'ac_bonus' AND e.label = 'Aparar'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toggle sticky gate Finesse: +PB CA (Reação Aparar). Des 13 = build; Finesse = runtime.'
FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'charger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 2, 'Ataque em Investida'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toggle auto-off: +1d8 no proximo ataque C/C elegivel apos mover >= 3 m (DTO chargerStrike).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_die_floor'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Piso elemental'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Magias do tipo escolhido: faces 1 nos dados de dano viram 2 (damage_die_floor).'
FROM ins;

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'archery', 'defense', 'dueling', 'great-weapon-fighting',
    'two-weapon-fighting', 'thrown-weapon-fighting', 'unarmed-fighting',
    'interception', 'protection', 'blind-fighting'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('archery', 10, 'Arquearia',
     '+2 nas jogadas de ataque com armas à Distância.'),
    ('defense', 10, 'Defensivo',
     '+1 CA enquanto usa armadura Leve, Média ou Pesada.'),
    ('dueling', 10, 'Duelismo',
     '+2 dano com arma C/C em uma mão e nenhuma outra arma.'),
    ('great-weapon-fighting', 10, 'Armas Grandes',
     'Dano C/C com Duas Mãos ou Versátil (duas mãos): faces 1–2 viram 3 (damage_die_floor piso 3).'),
    ('two-weapon-fighting', 10, 'Duas Armas',
     'Ataque extra da propriedade Leve: some o modificador de atributo ao dano.'),
    ('thrown-weapon-fighting', 10, 'Arremesso',
     '+2 dano em ataque à distância com arma Arremesso.'),
    ('unarmed-fighting', 10, 'Desarmado',
     'Desarmado 1d6 Contundente (+For); d8 se sem arma/Escudo; início do turno 1d4 em Imobilizado por você.'),
    ('interception', 10, 'Interceptação',
     'Reação: −(1d10+PB) dano a aliado a 1,5 m (escudo ou arma Simples/Marcial).'),
    ('protection', 10, 'Protetivo',
     'Reação com Escudo: Desvantagem no ataque vs aliado a 1,5 m (e ataques contra ele até seu próximo turno).'),
    ('blind-fighting', 10, 'Luta às Cegas',
     'Visão às Cegas 3 m.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT i.id, r.note
FROM ins i
JOIN rows r ON r.label = i.label;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'archery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'attack_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Arquearia +2'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'defense'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ac_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Defensivo +1'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Gate: armadura Leve/Média/Pesada.'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.owner_kind = 'feat' AND e.kind = 'ac_bonus' AND e.label = 'Defensivo +1';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'dueling'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Duelismo +2'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-fighting'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Arremesso +2'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-fighting'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_die_floor'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Piso armas grandes'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 3 FROM ins;

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Piso face 3 (1–2→3) em dados de dano C/C 2H/Versátil duas mãos.'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.owner_kind = 'feat' AND e.kind = 'damage_die_floor' AND e.label = 'Piso armas grandes';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'two-weapon-fighting'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'light_bonus_ability_mod'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Leve +mod'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Ataque adicional Leve: inclui modificador de atributo no dano.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'unarmed-fighting'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_die_override'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Desarmado 1d6'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d6' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'interception'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_reduce_reaction'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Interceptação'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Reação: reduz dano em 1d10+PB (aliado a 1,5 m; escudo ou arma).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blind-fighting'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Visão às Cegas'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Visão às Cegas 3 m (grant_sense).' FROM ins;

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'boon-of-fortitude', 'boon-of-combat-prowess', 'boon-of-skill-proficiency',
    'boon-of-spell-recall', 'boon-of-recovery', 'boon-of-energy-resistance',
    'boon-of-speed', 'boon-of-dimensional-travel', 'boon-of-truesight',
    'boon-of-irresistible-offense', 'boon-of-fate', 'boon-of-the-night-spirit'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('boon-of-the-night-spirit', 10, 'Fundir-se com Sombras',
     'Meia-luz/Escuridão: BA Invisível (encerra após ação/AB/Reação).')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT i.id, r.note
FROM ins i
JOIN rows r ON r.label = i.label;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Fortitude +40'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 40, 0, 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'heal_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Bônus ao recuperar PV'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Ao recuperar PV: +mod Con (1× até início do próximo turno).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'miss_becomes_hit'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Erro → acerto'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Offer + toggle sticky: ao errar ataque, pergunta se usa; 1×/turno; toggle desliga o prompt.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_all_skill_proficiencies'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Todas as perícias'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Proficiência em todas as perícias (collector de skills).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_expertise'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Especialização'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'option_key expertiseSkill (já em S058).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-spell-recall'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'slot_refund_on_die_match'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_cast'::rpg.effect_trigger, 1, 1, 'Recordação 1d4'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Slots 1–4: rola 1d4; se = círculo do espaço, não gasta. Wire no cast.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'boonDeathWard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Até a Morte (resource)'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'survive_at_zero'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 'boonDeathWard', 1, 2, 'Até a Morte'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'A 0 PV: 1 PV + cura metade do máximo; gasta boonDeathWard.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'boonVitalityDice'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 3, 'Vitalidade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'heal_from_dice_pool'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'feat-boon-recovery-vitality',
         'boonVitalityDice', 1, 4, 'Recuperar Vitalidade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'BA: escolher N dados (d10) da reserva, gastar N, curar = soma. Mesmo verbo do Zelote Campeão dos Deuses (d12).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_resistance'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Resistência energia'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, '2 tipos escolhidos (option); troca no DL.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'redirect_damage_reaction'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Redirecionamento'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Reação: redireciona dano do tipo escolhido ≤18 m; save DES.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 3, 'CD Redirecionamento'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'CD = 8 + mod Con + PB.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'speed_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Agilidade +9 m'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 30 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'bonus_action_disengage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'disengage', 1, 2, 'Artista de Fuga'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'BA Desengajar; também encerra Imobilizado.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'teleport_after_action'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Passos Fugazes'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 30 FROM ins;

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Após Atacar ou Usar Magia: teleporte ≤9 m (30 ft).'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.owner_kind = 'feat' AND e.label = 'Passos Fugazes';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Visão Verdadeira'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Visão Verdadeira 18 m (grant_sense).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-irresistible-offense'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ignore_damage_resistance'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Ignora Res. Cont/Cort/Perf'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Dano Contundente, Cortante e Perfurante ignora Resistência.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-irresistible-offense'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'extra_damage_on_nat20'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_critical_hit'::rpg.effect_trigger, 1, 2, 'Golpe Devastador'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Nat 20: +valor do atributo aumentado por este talento (mesmo tipo de dano).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'boonFate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Destino (resource)'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'modify_d20_roll'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 'boonFate', 1, 2, 'Aprimorar Destino'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Offer: ±2d4 no Teste D20 (você ou criatura ≤18 m); gasta boonFate.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_resistance'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Forma Sombria'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Gate Meia-luz/Escuridão: Res. a tudo exceto Psíquico/Radiante.' FROM ins;
