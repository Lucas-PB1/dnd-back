-- Gates de nível — Sabujo de Sangue (Blood Hound).

INSERT INTO rpg.phb_feature_gate (owner_kind, class_id, subclass_id, gate_key, unlock_level)
SELECT 'subclass'::rpg.class_subclass_owner, NULL, s.id, v.gate_key, v.unlock_level
FROM rpg.phb_subclass s
CROSS JOIN (
  VALUES
    ('blood-armament', 7),
    ('blood-explosion', 7),
    ('blood-lower-cost', 10),
    ('blood-symphony', 15)
) AS v(gate_key, unlock_level)
WHERE s.slug = 'blood-hound'
ON CONFLICT (subclass_id, gate_key)
WHERE (subclass_id IS NOT NULL)
DO UPDATE SET
  unlock_level = EXCLUDED.unlock_level;
