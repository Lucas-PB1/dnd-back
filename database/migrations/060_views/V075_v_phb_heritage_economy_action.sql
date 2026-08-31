-- Ações de economia (Usar) ligadas a traços de herança

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
