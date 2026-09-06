CREATE VIEW rpg.v_phb_feat_granted_spell AS
SELECT
  f.slug AS feat_slug,
  s.slug AS spell_slug
FROM rpg.phb_spell_grant g
JOIN rpg.phb_feat f ON f.id = g.origin_id
JOIN rpg.phb_spell s ON s.id = g.spell_id
WHERE g.origin_type = 'feat'::rpg.spell_grant_origin;

-- PV e defesa sem armadura (views de leitura)
