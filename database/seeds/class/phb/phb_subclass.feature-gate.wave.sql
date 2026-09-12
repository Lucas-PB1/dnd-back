-- Gates booleanos de subclasse (além do Sabujo).

INSERT INTO rpg.phb_subclass_feature_gate (subclass_id, gate_key, unlock_level)
SELECT s.id, v.gate_key, v.unlock_level
FROM rpg.phb_subclass s
JOIN (
  VALUES
    ('dungeoneer', 'door_kick', 3),
    ('assassin', 'assassin_mobile_aim', 9),
    ('zealot', 'divine_fury', 3),
    ('soulknife', 'psychic_blades', 3)
) AS v(subclass_slug, gate_key, unlock_level)
  ON s.slug = v.subclass_slug
ON CONFLICT (subclass_id, gate_key) DO UPDATE SET
  unlock_level = EXCLUDED.unlock_level;
