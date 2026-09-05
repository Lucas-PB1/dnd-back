DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'brutal-grip', 'field-commander', 'focused-critical', 'iron-hero',
    'marksman-s-luck', 'gun-mage-adept', 'familiar-keeper', 'flex-caster',
    'magitechnician', 'metabolistic-magic', 'pyromaniac', 'shock-trooper',
    'showman', 'spellblade'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('brutal-grip', 10, 'Empunhadura brutal',
     'Empunhar Duas Mãos em uma mão; Versátil em uma mão conta como Leve.'),
    ('focused-critical', 10, 'Crítico ampliado',
     'Crítico com armas/Desarmado em 19–20.'),
    ('iron-hero', 10, 'Herói de ferro',
     '+2 CA vs atacante de ND > seu nível; Vantagem vs quem zerou aliado desde seu último turno.'),
    ('field-commander', 10, 'Formação Apertada',
     'A ≤ 1,5 m de ≥ 2 aliados: inimigos sem Vantagem contra você.'),
    ('marksman-s-luck', 10, 'Crítico à distância',
     '1×/turno: virar um dado de dano à distância (não d4); crítico à distância → Deslocamento 0.'),
    ('flex-caster', 10, 'Elevação / Redução',
     'Elevação: gastar espaços extras para subir círculo; Redução: conjurar no base e recuperar espaço de 1º.'),
    ('shock-trooper', 10, 'Investida inicial',
     '1ª rodada de combate: Deslocamento dobrado.'),
    ('spellblade', 10, 'Golpe Arcano',
     'Na ação Atacar: pode substituir um ataque por truque de lâmina conhecido.'),
    ('magitechnician', 10, 'CD de item mágico',
     'CD de item mágico: máx(CD do item, 8 + mod do atributo + PB).'),
    ('pyromaniac', 10, 'Truques ígneos',
     'Dano Ígneo: rerole e some dados no máximo (até PB dados extras).'),
    ('gun-mage-adept', 10, 'Pistola Arcana',
     'Prof. armas marciais à distância; Finger Guns + lista expandida (7 magias); escolha ×PB sempre prep.'),
    ('familiar-keeper', 10, 'Familiar e distração',
     'Find Familiar prep + free 1/DL; Distração: pool ×PB + reação (wire depois).'),
    ('metabolistic-magic', 10, 'Combustível arcano',
     'Offer Perícia Arcana no D20 (+2+nível slot; toggle); Combustível: ≤PB DV → recuperar slot (1/DL).'),
    ('showman', 10, 'Provocação',
     'Prof./Expertise Atuação; Provocação ×PB + BA para provocar inimigo (wire depois).')
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

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('wield_two_handed_one_hand'::rpg.effect_kind, 1, 'Duas Mãos — uma mão'),
      ('grant_weapon_property'::rpg.effect_kind, 2, 'Versátil Leve')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Empunhar arma Duas Mãos numa mão (outra mão sem 2H/escudo).'
    ELSE 'Versátil empunhada a uma mão conta como Leve.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'grant_weapon_property'
)
INSERT INTO rpg.phb_effect_weapon (effect_id, property_slug)
SELECT id, 'light' FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'improve_critical'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Crítico 19–20'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Crítico com armas corpo a corpo e Desarmado em 19–20 (threshold 19).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ac_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'CA vs ND superior'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'ac_bonus'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toggle sticky: +2 CA vs atacante de ND > seu nível. Vant. ataque vs quem zerou aliado (offer).'
FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_die_flip'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Sorte do Atirador'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  '1×/turno: virar um dado de dano à distância (não d4). Crítico à distância → Desloc. alvo 0 (nota).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shock-trooper'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('speed_bonus'::rpg.effect_kind, 1, 'Deslocamento dobrado'),
      ('combat_note'::rpg.effect_kind, 2, 'Sacar e atacar')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN '1ª rodada: Deslocamento ×2 (gate rodada 1; wire speed_bonus depois).'
    ELSE 'Início combate: sacar arma + 1 ataque (economy/init; mesa).'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'pyromaniac'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, v.trigger::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('damage_die_explode'::rpg.effect_kind, 'on_damage_roll', 1, 'Explosão Ígnea'),
      ('spellcasting_ability'::rpg.effect_kind, 'on_build', 2, 'Atributo de conjuração')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Dano Ígneo: rerole máximos e some (cap PB dados extras/turno).'
    ELSE 'Fire Bolt + mãos/raio prep; atributo = ASI do talento; free 1/DL.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'feat-field-commander-order', 1, 1,
         'Comando de Campo'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ação Comando: aliado a 9 m executa Ataque ou Correr (wire table-action depois).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'flex-caster'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'on_cast'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('slot_elevate'::rpg.effect_kind, 1, 'Elevação'),
      ('slot_reduce'::rpg.effect_kind, 2, 'Redução')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Offer no cast: gastar espaços extras para subir círculo da magia.'
    ELSE 'Offer no cast: conjurar no círculo base e recuperar um espaço de 1º.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 1, 'Truques de lâmina'),
      ('spellcasting_ability'::rpg.effect_kind, 2, 'Atributo de conjuração'),
      ('combat_note'::rpg.effect_kind, 3, 'Canalizado')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN '×2 truques de lâmina escolhidos (grant_spell+option wire depois).'
    WHEN 2 THEN 'Atributo de conjuração = escolha do talento (Int/Sab/Cha).'
    ELSE 'Offer toggle sticky: +mod Int|Sab|Cha no ataque; pool ×PB/DL (Canalizado).'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'magitechnician'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'magic_item_save_dc'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'CD de item mágico'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'CD item = máx(CD do item, 8 + mod atributo + PB). Recarga 1/DL = só usos (sem aplicar no item).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'ironHeroIntervention'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Intervenção Heroica — pool'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH rows(slug, resource_slug, label) AS (
  VALUES
    ('spellblade', 'spellbladeChannel', 'Ataque Canalizado — pool'),
    ('showman', 'showmanTaunt', 'Provocação — pool'),
    ('familiar-keeper', 'familiarDistraction', 'Distração do Familiar — pool')
)
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
       'on_build'::rpg.effect_trigger, 1, 20, r.label
FROM rows r
JOIN rpg.phb_feat f ON f.slug = r.slug;

INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT e.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id AND e.owner_kind = 'feat'
JOIN rpg.phb_resource_definition rd ON rd.feat_id = f.id
WHERE e.kind = 'grant_resource'
  AND e.sort_order = 20
  AND (f.slug, rd.slug) IN (
    ('spellblade', 'spellbladeChannel'),
    ('showman', 'showmanTaunt'),
    ('familiar-keeper', 'familiarDistraction')
  );

WITH rows(slug, resource_slug, label) AS (
  VALUES
    ('magitechnician', 'magitechRecharge', 'Recarga de Item — pool'),
    ('metabolistic-magic', 'metabolisticFuel', 'Combustível Vital — pool')
)
INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
)
SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
       'on_build'::rpg.effect_trigger, 1, 20, r.label
FROM rows r
JOIN rpg.phb_feat f ON f.slug = r.slug;

INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT e.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id AND e.owner_kind = 'feat'
JOIN rpg.phb_resource_definition rd ON rd.feat_id = f.id
WHERE e.kind = 'grant_resource'
  AND e.sort_order = 20
  AND (f.slug, rd.slug) IN (
    ('magitechnician', 'magitechRecharge'),
    ('metabolistic-magic', 'metabolisticFuel')
  );
