-- Gates de nível — Sabujo de Sangue (Blood Hound).

INSERT INTO rpg.phb_subclass_feature_gate (subclass_id, gate_key, unlock_level)
SELECT s.id, v.gate_key, v.unlock_level
FROM rpg.phb_subclass s
CROSS JOIN (
  VALUES
    ('blood-armament', 7),
    ('blood-explosion', 7),
    ('blood-lower-cost', 10),
    ('blood-symphony', 15)
) AS v(gate_key, unlock_level)
WHERE s.slug = 'blood-hound'
ON CONFLICT (subclass_id, gate_key) DO UPDATE SET
  unlock_level = EXCLUDED.unlock_level;
