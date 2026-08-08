-- Atualiza a view de economia após T066 (species_id + requires_option_*).
-- DROP necessário: CREATE OR REPLACE não permite inserir colunas no meio.

DROP VIEW IF EXISTS rpg.v_phb_class_economy_action;

CREATE VIEW rpg.v_phb_class_economy_action AS
SELECT
  a.action_id,
  c.slug AS class_slug,
  sc.slug AS subclass_slug,
  sp.slug AS species_slug,
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
  a.sort_order,
  a.requires_option_key,
  a.requires_option_value
FROM rpg.phb_class_economy_action a
LEFT JOIN rpg.phb_class c ON c.id = a.class_id
LEFT JOIN rpg.phb_subclass sc ON sc.id = a.subclass_id
LEFT JOIN rpg.phb_species sp ON sp.id = a.species_id;
