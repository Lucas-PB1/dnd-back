-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition
  WHERE slug = 'divineClarity'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Clareza Divina — usos'
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

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'feat-faithful-divine-clarity', 1, 2,
         'Clareza Divina'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Se falhar salvaguarda vs Enfeitiçado ou Amedrontado, gaste 1 Clareza Divina para escolher sucesso. 1× / DL.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_inspiration'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_d20_nat1'::rpg.effect_trigger, 1, 3, 'Provação da Fé'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Oferta (toggle): nat 1 em Teste d20 → recuperar Inspiração Heróica? Se já possui: informar + pode passar a outro (nota; sem transfer API).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Superar'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Superar: salvaguarda vs Amedrontado recebe +PB.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Sobreviver — comida'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sobreviver: metade da comida e água; vantagem em Sobrevivência para forragear (ver check_advantage).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'check_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 3, 'Sobreviver — forragear'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Circunstância: vantagem em Sabedoria (Sobrevivência) feitos para forragear comida e água.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
rd AS (
  SELECT id FROM rpg.phb_resource_definition WHERE slug = 'resistInspiration'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 4, 'Resistir — usos'
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

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'grant_inspiration'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_bloodied'::rpg.effect_trigger, 'resistInspiration', 1, 5, 'Resistir — oferta'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Oferta ao cruzar Ensanguentado: usar Resistir? Gasta 1 uso → Inspiração Heróica. Se já possui: informar + nota de repasse.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'grant_inspiration'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'feat-grizzled-resist',
         'resistInspiration', 1, 6, 'Resistir'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Inspiração Heróica concedida. Se já possui: pode passar a outro jogador (nota de mesa).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brutalizer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('wield_two_handed_one_hand'::rpg.effect_kind, 1, 'Armamento Brutal'),
      ('extra_melee_attack'::rpg.effect_kind, 2, 'Sequência Mortífera')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Empunhar arma Duas Mãos numa mão (outra mão sem 2H/escudo).'
    ELSE 'Após Atacar com 2H: BA ataque com arma Leve (sem mod dano salvo TWF / light_bonus_ability_mod).'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'cannoneer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      (1, 'Proficiência com Canhões'),
      (2, 'Cerco'),
      (3, 'Costas Fortes'),
      (4, 'Recarregar (BA)')
  ) AS v(sort_order, label)
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT ins.id,
  CASE ins.label
    WHEN 'Proficiência com Canhões' THEN 'Proficiência com canhões (catálogo luyarnha-cannon / cannon; grant_proficiency wire).'
    WHEN 'Cerco' THEN 'Cerco: regras de artilharia / cerco (declare na mesa).'
    WHEN 'Costas Fortes' THEN 'Peso de canhão tratado como metade para carga.'
    ELSE 'Economy BA genérica: Recarregar arma Loading/Artilharia (unlock L11/L20 no satélite).'
  END
FROM ins;
