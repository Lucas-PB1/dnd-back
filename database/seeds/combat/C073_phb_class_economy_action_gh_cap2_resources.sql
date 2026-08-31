-- C073: Wire resource_slug + always_spends nas economy Cap. 2 (Fase B)
-- Gerado por scripts/generate-gh-cap2-phase-b-resources.mjs
-- Não regenera C066; UPDATE + INSERT mínimos para cotas tipadas.


UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'beast-kinship',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'pathofthe-primal-spirit'
  AND a.table_action IN ('beast-kinship');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'skinrider-trance',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'pathofthe-primal-spirit'
  AND a.table_action IN ('skinrider-s-trance');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'shape-of-the-wild',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'pathofthe-primal-spirit'
  AND a.table_action IN ('shape-of-the-wild', 'shape-of-the-wild-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'gallows-humor',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'collegeof-fools'
  AND a.table_action IN ('gallows-humor');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'last-laugh',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'collegeof-fools'
  AND a.table_action IN ('last-laugh');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'dual-death',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'collegeof-requiems'
  AND a.table_action IN ('dual-death');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'witch-hunters-strike',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'inquisition-domain'
  AND a.table_action IN ('witch-hunters-strike');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'rebuke-invoker',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'inquisition-domain'
  AND a.table_action IN ('rebuke-invoker');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'purify-with-fire',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'purification-domain'
  AND a.table_action IN ('purify-with-fire');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'blood-boon',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'circleof-blood'
  AND a.table_action IN ('blood-boon');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'exsanguinate',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'circleof-blood'
  AND a.table_action IN ('exsanguinate');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'shake-the-earth',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'circleof-entropy'
  AND a.table_action IN ('shake-the-earth');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'plaguebringer',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'oathof-pestilence'
  AND a.table_action IN ('plaguebringer', 'plaguebringer-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'blood-knight',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'oathof-slaughter'
  AND a.table_action IN ('blood-knight', 'blood-knight-action', 'blood-knight-reaction');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'apocalyptic-revelation',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'oathof-zeal'
  AND a.table_action IN ('apocalyptic-revelation', 'apocalyptic-revelation-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'envenomed-attack',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'green-reaper'
  AND a.table_action IN ('envenomed-attack', 'envenomed-attack-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'poison-control',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'green-reaper'
  AND a.table_action IN ('poison-control');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'elemental-arrows',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'primordial-archer'
  AND a.table_action IN ('flechas-elementais', 'flechas-elementais-action', 'elemental-arrows', 'elemental-arrows-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'herbal-lore',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'primordial-archer'
  AND a.table_action IN ('herbal-lore', 'herbal-lore-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'primordial-magic',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'primordial-archer'
  AND a.table_action IN ('primordial-magic', 'primordial-magic-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'verminkin',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'vermin-lord'
  AND a.table_action IN ('verminkin', 'verminkin-action', 'verminkin-reaction');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'swarming-strikes',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'vermin-lord'
  AND a.table_action IN ('swarming-strikes', 'swarming-strikes-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'steal-blood',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'sanguine-thief'
  AND a.table_action IN ('steal-blood');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'bloodstitch',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'sanguine-thief'
  AND a.table_action IN ('bloodstitch');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'bloody-exit',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'sanguine-thief'
  AND a.table_action IN ('bloody-exit');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'hags-eye',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND a.table_action IN ('hag-s-eye');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'hags-guile',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND a.table_action IN ('hag-s-guile', 'hag-s-guile-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'hags-visage',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND a.table_action IN ('hag-s-visage', 'hag-s-visage-action');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'hags-craft',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND a.table_action IN ('hag-s-craft');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'creature-of-the-night',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-first-vampire-patron'
  AND a.table_action IN ('creature-of-the-night');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'eldritch-appetite',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-first-vampire-patron'
  AND a.table_action IN ('eldritch-appetite');

UPDATE rpg.phb_class_economy_action a
SET resource_slug = 'eternal-night',
    always_spends_resource = true
FROM rpg.phb_subclass s
WHERE a.subclass_id = s.id
  AND s.slug = 'the-first-vampire-patron'
  AND a.table_action IN ('eternal-night', 'eternal-night-action');

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-barbarian-pathofthe-primal-spirit-beast-kinship',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'Parentesco a Feras',
  'free'::rpg.action_economy_bucket,
  6,
  'beast-kinship',
  NULL,
  true,
  'Conjure Amizade com Animais / Falar com Animais sem espaço (2 usos)',
  'Conjure Amizade com Animais / Falar com Animais sem espaço (2 usos)',
  'beast-kinship',
  NULL,
  280
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-cleric-inquisition-domain-witch-hunters-strike',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  'Golpe do Caçador de Bruxas',
  'free'::rpg.action_economy_bucket,
  3,
  'witch-hunters-strike',
  NULL,
  true,
  '1×/acerto: dano de Força extra (mod. Sab/LR)',
  '1×/acerto: dano de Força extra (mod. Sab/LR)',
  'witch-hunters-strike',
  NULL,
  310
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-cleric-purification-domain-purify-with-fire',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  'Purificar com Fogo',
  'free'::rpg.action_economy_bucket,
  3,
  'purify-with-fire',
  NULL,
  true,
  'Dano de Fogo extra em truque/ataque (PB usos; S/L)',
  'Dano de Fogo extra em truque/ataque (PB usos; S/L)',
  'purify-with-fire',
  NULL,
  312
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-druid-circleof-blood-exsanguinate',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  'Exsanguinar',
  'free'::rpg.action_economy_bucket,
  14,
  'exsanguinate',
  NULL,
  true,
  'Ao usar Dádiva de Sangue: cura DV + PV temp. (1/LR)',
  'Ao usar Dádiva de Sangue: cura DV + PV temp. (1/LR)',
  'exsanguinate',
  NULL,
  360
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-ranger-green-reaper-poison-control',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  'Controle de Veneno',
  'free'::rpg.action_economy_bucket,
  7,
  'poison-control',
  NULL,
  true,
  'Conjure magia de veneno sem espaço (mod. Sab/LR)',
  'Conjure magia de veneno sem espaço (mod. Sab/LR)',
  'poison-control',
  NULL,
  390
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-rogue-sanguine-thief-steal-blood',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  'Roubar Sangue',
  'free'::rpg.action_economy_bucket,
  3,
  'steal-blood',
  NULL,
  true,
  'Ao Furtivo: recuperar dado de sangromancia / cura (mod. Int/LR)',
  'Ao Furtivo: recuperar dado de sangromancia / cura (mod. Int/LR)',
  'steal-blood',
  NULL,
  420
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-warlock-the-coven-hag-s-eye',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  'Olho da Bruxa (Hex)',
  'free'::rpg.action_economy_bucket,
  3,
  'hags-eye',
  NULL,
  true,
  'Conjure Hex sem espaço (mod. Car/LR)',
  'Conjure Hex sem espaço (mod. Car/LR)',
  'hag-s-eye',
  NULL,
  430
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-warlock-the-coven-hag-s-craft',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  'Ofício da Bruxa (Caldeirão)',
  'free'::rpg.action_economy_bucket,
  14,
  'hags-craft',
  NULL,
  true,
  'Caldeirão de poções (1/LR; gasta espaço)',
  'Caldeirão de poções (1/LR; gasta espaço)',
  'hag-s-craft',
  NULL,
  432
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES (
  'gh-warlock-the-first-vampire-patron-creature-of-the-night',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  'Criatura da Noite',
  'free'::rpg.action_economy_bucket,
  6,
  'creature-of-the-night',
  NULL,
  true,
  'Polimorfia em morcego/rato/lobo sem espaço (mod. Car/LR)',
  'Polimorfia em morcego/rato/lobo sem espaço (mod. Car/LR)',
  'creature-of-the-night',
  NULL,
  440
)
ON CONFLICT (action_id) DO UPDATE SET
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

-- Table actions: espelhar pool gastoido

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'beast-kinship',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'pathofthe-primal-spirit'
  AND t.slug IN ('beast-kinship');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'skinrider-trance',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'pathofthe-primal-spirit'
  AND t.slug IN ('skinrider-s-trance');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'shape-of-the-wild',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'pathofthe-primal-spirit'
  AND t.slug IN ('shape-of-the-wild', 'shape-of-the-wild-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'gallows-humor',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'collegeof-fools'
  AND t.slug IN ('gallows-humor');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'last-laugh',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'collegeof-fools'
  AND t.slug IN ('last-laugh');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'dual-death',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'collegeof-requiems'
  AND t.slug IN ('dual-death');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'witch-hunters-strike',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'inquisition-domain'
  AND t.slug IN ('witch-hunters-strike');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'rebuke-invoker',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'inquisition-domain'
  AND t.slug IN ('rebuke-invoker');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'purify-with-fire',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'purification-domain'
  AND t.slug IN ('purify-with-fire');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'blood-boon',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'circleof-blood'
  AND t.slug IN ('blood-boon');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'exsanguinate',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'circleof-blood'
  AND t.slug IN ('exsanguinate');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'shake-the-earth',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'circleof-entropy'
  AND t.slug IN ('shake-the-earth');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'plaguebringer',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'oathof-pestilence'
  AND t.slug IN ('plaguebringer', 'plaguebringer-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'blood-knight',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'oathof-slaughter'
  AND t.slug IN ('blood-knight', 'blood-knight-action', 'blood-knight-reaction');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'apocalyptic-revelation',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'oathof-zeal'
  AND t.slug IN ('apocalyptic-revelation', 'apocalyptic-revelation-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'envenomed-attack',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'green-reaper'
  AND t.slug IN ('envenomed-attack', 'envenomed-attack-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'poison-control',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'green-reaper'
  AND t.slug IN ('poison-control');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'elemental-arrows',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'primordial-archer'
  AND t.slug IN ('flechas-elementais', 'flechas-elementais-action', 'elemental-arrows', 'elemental-arrows-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'herbal-lore',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'primordial-archer'
  AND t.slug IN ('herbal-lore', 'herbal-lore-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'primordial-magic',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'primordial-archer'
  AND t.slug IN ('primordial-magic', 'primordial-magic-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'verminkin',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'vermin-lord'
  AND t.slug IN ('verminkin', 'verminkin-action', 'verminkin-reaction');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'swarming-strikes',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'vermin-lord'
  AND t.slug IN ('swarming-strikes', 'swarming-strikes-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'steal-blood',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'sanguine-thief'
  AND t.slug IN ('steal-blood');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'bloodstitch',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'sanguine-thief'
  AND t.slug IN ('bloodstitch');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'bloody-exit',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'sanguine-thief'
  AND t.slug IN ('bloody-exit');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'hags-eye',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND t.slug IN ('hag-s-eye');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'hags-guile',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND t.slug IN ('hag-s-guile', 'hag-s-guile-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'hags-visage',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND t.slug IN ('hag-s-visage', 'hag-s-visage-action');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'hags-craft',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-coven'
  AND t.slug IN ('hag-s-craft');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'creature-of-the-night',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-first-vampire-patron'
  AND t.slug IN ('creature-of-the-night');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'eldritch-appetite',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-first-vampire-patron'
  AND t.slug IN ('eldritch-appetite');

UPDATE rpg.phb_subclass_table_action t
SET free_resource_slug = 'eternal-night',
    always_spends_pool = true
FROM rpg.phb_subclass s
WHERE t.subclass_id = s.id
  AND s.slug = 'the-first-vampire-patron'
  AND t.slug IN ('eternal-night', 'eternal-night-action');

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'beast-kinship',
  'Parentesco a Feras',
  6,
  'beast-kinship',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  'witch-hunters-strike',
  'Golpe do Caçador de Bruxas',
  3,
  'witch-hunters-strike',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  'purify-with-fire',
  'Purificar com Fogo',
  3,
  'purify-with-fire',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  'exsanguinate',
  'Exsanguinar',
  14,
  'exsanguinate',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  'poison-control',
  'Controle de Veneno',
  7,
  'poison-control',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  'steal-blood',
  'Roubar Sangue',
  3,
  'steal-blood',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  'hag-s-eye',
  'Olho da Bruxa',
  3,
  'hags-eye',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  'hag-s-craft',
  'Ofício da Bruxa',
  14,
  'hags-craft',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  'creature-of-the-night',
  'Criatura da Noite',
  6,
  'creature-of-the-night',
  true, false, false, NULL, NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;
