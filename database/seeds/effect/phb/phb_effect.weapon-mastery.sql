-- Effects tipados por maestria de arma (PHB) — owner_kind = weapon_mastery.
-- Pipeline de combate: on_hit / on_miss.

-- Graze: dano = mod do atributo do ataque no erro
WITH m AS (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'graze'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ability_mod_damage'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
         'on_miss'::rpg.effect_trigger, 1, 1, 'Resvalar'
  FROM m
  WHERE NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Resvalar'
  )
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'attack_ability_mod'::rpg.effect_amount_formula, NULL FROM ins
ON CONFLICT (effect_id) DO NOTHING;

-- Vex: vantagem até consumir vs o alvo
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'advantage_until_consumed'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
       'on_hit'::rpg.effect_trigger, 1, 1, 'Afligir'
FROM rpg.phb_weapon_mastery m
WHERE m.slug = 'vex'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Afligir'
  );

-- Sap: desvantagem no próximo ataque do alvo
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'attack_disadvantage'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
       'on_hit'::rpg.effect_trigger, 1, 1, 'Drenar'
FROM rpg.phb_weapon_mastery m
WHERE m.slug = 'sap'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Drenar'
  );

-- Topple: save CON → Caído
WITH m AS (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'feature_save'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
         'on_hit'::rpg.effect_trigger, 1, 1, 'Derrubar'
  FROM m
  WHERE NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Derrubar'
  )
  RETURNING id
)
INSERT INTO rpg.phb_effect_save (effect_id, save_ability, dc_ability, dc_formula)
SELECT id, 'constitution'::rpg.save_ability, NULL, 'eight_plus_mod_plus_pb'::rpg.effect_amount_formula
FROM ins
ON CONFLICT (effect_id) DO NOTHING;

INSERT INTO rpg.phb_effect_condition (effect_id, condition_slug, pending_kind)
SELECT e.id, 'prone'::rpg.condition_slug, NULL
FROM rpg.phb_effect e
JOIN rpg.phb_weapon_mastery m ON m.id = e.owner_id AND e.owner_kind = 'weapon_mastery'
WHERE m.slug = 'topple' AND e.label = 'Derrubar'
ON CONFLICT (effect_id) DO NOTHING;

-- Push: 3 m (sem grid: log + marca)
WITH m AS (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'push'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'forced_movement'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
         'on_hit'::rpg.effect_trigger, 1, 1, 'Empurrar'
  FROM m
  WHERE NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Empurrar'
  )
  RETURNING id
)
INSERT INTO rpg.phb_effect_forced_movement (effect_id, distance_m, max_target_size)
SELECT id, 3, 'large' FROM ins
ON CONFLICT (effect_id) DO NOTHING;

-- Slow: −3 m deslocamento
WITH m AS (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'reduce_target_speed_on_hit'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
         'on_hit'::rpg.effect_trigger, 1, 1, 'Lentidão'
  FROM m
  WHERE NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Lentidão'
  )
  RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 3 FROM ins
ON CONFLICT (effect_id) DO NOTHING;

-- Nick: ataque leve extra na ação Atacar
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'extra_melee_attack'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
       'passive'::rpg.effect_trigger, 1, 1, 'Ágil'
FROM rpg.phb_weapon_mastery m
WHERE m.slug = 'nick'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Ágil'
  );

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Ataque adicional da propriedade Leve como parte da ação Atacar (1×/turno).'
FROM rpg.phb_effect e
JOIN rpg.phb_weapon_mastery m ON m.id = e.owner_id AND e.owner_kind = 'weapon_mastery'
WHERE m.slug = 'nick' AND e.label = 'Ágil'
ON CONFLICT (effect_id) DO NOTHING;

-- Cleave: N/A 1v1 — tipado como nota para encontros multi-alvo
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'combat_note'::rpg.effect_kind, 'weapon_mastery'::rpg.effect_owner_kind, m.id,
       'on_hit'::rpg.effect_trigger, 1, 1, 'Trespassar'
FROM rpg.phb_weapon_mastery m
WHERE m.slug = 'cleave'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'weapon_mastery' AND e.owner_id = m.id AND e.label = 'Trespassar'
  );

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, '1v1: indisponível (exige segundo alvo a 1,5 m). Em encontro: ataque C/C extra sem mod de atributo (1×/turno).'
FROM rpg.phb_effect e
JOIN rpg.phb_weapon_mastery m ON m.id = e.owner_id AND e.owner_kind = 'weapon_mastery'
WHERE m.slug = 'cleave' AND e.label = 'Trespassar'
ON CONFLICT (effect_id) DO NOTHING;

-- Protetivo (feat): tipar attack_disadvantage (reação; N/A 1v1)
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'attack_disadvantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
       'passive'::rpg.effect_trigger, 1, 2, 'Protetivo (reação)'
FROM rpg.phb_feat f
WHERE f.slug = 'protection'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'feat' AND e.owner_id = f.id AND e.label = 'Protetivo (reação)'
  );

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Reação com Escudo: desvantagem no ataque vs aliado a 1,5 m. Duelo 1v1: indisponível.'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id AND e.owner_kind = 'feat'
WHERE f.slug = 'protection' AND e.label = 'Protetivo (reação)'
ON CONFLICT (effect_id) DO NOTHING;
