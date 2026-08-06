CREATE OR REPLACE VIEW rpg.v_phb_subclass_table_action AS
SELECT
  sc.slug AS subclass_slug,
  a.slug,
  a.name,
  a.unlock_level,
  a.free_resource_slug,
  a.always_spends_pool,
  a.rolls_pool_die,
  a.spends_only_on_success,
  a.always_pool_cost,
  a.repeat_pool_cost
FROM rpg.phb_subclass_table_action a
JOIN rpg.phb_subclass sc ON sc.id = a.subclass_id;
