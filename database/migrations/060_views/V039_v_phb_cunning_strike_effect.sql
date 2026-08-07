CREATE OR REPLACE VIEW rpg.v_phb_cunning_strike_effect AS
SELECT
  e.slug,
  e.name,
  e.cost,
  e.unlock_level,
  e.save_ability::text AS save_ability,
  sc.slug AS subclass_slug,
  e.note
FROM rpg.phb_cunning_strike_effect e
LEFT JOIN rpg.phb_subclass sc ON sc.id = e.subclass_id;
