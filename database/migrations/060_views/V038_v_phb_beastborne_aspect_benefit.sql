CREATE OR REPLACE VIEW rpg.v_phb_beastborne_aspect_benefit AS
SELECT
  b.aspect_level,
  b.note
FROM rpg.phb_beastborne_aspect_benefit b;
