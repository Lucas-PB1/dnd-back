-- Forward: kind recover_resource + apply mesa (spend na economy, recover no effect).
-- Se a migration anterior de colunas recover_* na economy já rodou, remove-as.

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'recover_resource';

ALTER TABLE rpg.phb_class_economy_action
  DROP COLUMN IF EXISTS recover_resource_slug,
  DROP COLUMN IF EXISTS recover_amount;

CREATE OR REPLACE VIEW rpg.v_phb_class_economy_action AS
SELECT
  a.action_id,
  c.slug AS class_slug,
  sc.slug AS subclass_slug,
  sp.slug AS species_slug,
  f.slug AS feat_slug,
  i.slug AS item_slug,
  ht.slug AS heritage_trait_slug,
  a.thread_slug AS thread_slug,
  a.name,
  a.economy::text AS economy,
  a.unlock_level,
  a.resource_slug,
  a.free_resource_slug,
  a.always_spends_resource,
  a.summary,
  a.description,
  a.table_action,
  a.spend_amount,
  a.spell_slug,
  a.sort_order,
  a.requires_option_key,
  a.requires_option_value,
  a.min_trait_takes
FROM rpg.phb_class_economy_action a
LEFT JOIN rpg.phb_class c ON c.id = a.class_id
LEFT JOIN rpg.phb_subclass sc ON sc.id = a.subclass_id
LEFT JOIN rpg.phb_species sp ON sp.id = a.species_id
LEFT JOIN rpg.phb_feat f ON f.id = a.feat_id
LEFT JOIN rpg.phb_item i ON i.id = a.item_id
LEFT JOIN rpg.phb_heritage_trait ht ON ht.id = a.heritage_trait_id;

CREATE OR REPLACE VIEW rpg.v_phb_heritage_economy_action AS
SELECT
  a.action_id,
  ht.slug AS trait_slug,
  a.name,
  a.economy::text AS economy,
  a.unlock_level,
  a.resource_slug,
  a.free_resource_slug,
  a.always_spends_resource,
  a.summary,
  a.description,
  a.table_action,
  a.spend_amount,
  a.spell_slug,
  a.sort_order,
  a.min_trait_takes
FROM rpg.phb_class_economy_action a
JOIN rpg.phb_heritage_trait ht ON ht.id = a.heritage_trait_id
WHERE a.heritage_trait_id IS NOT NULL;

DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_class_economy_action CASCADE;

CREATE MATERIALIZED VIEW rpg.mv_phb_class_economy_action AS
  SELECT * FROM rpg.v_phb_class_economy_action;

CREATE UNIQUE INDEX idx_mv_phb_class_economy_action
  ON rpg.mv_phb_class_economy_action (action_id);

-- Spend amount do K.O. fica na economy (padrão feat).
UPDATE rpg.phb_class_economy_action
SET spend_amount = 5
WHERE action_id = 'monk-recover-knockout'
  AND (spend_amount IS DISTINCT FROM 5);
