-- Mago dos Mísseis: Mísseis Mágicos no grimório/preparadas (sempre disponíveis).
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'magic-missile-mage' AND sp.slug = 'misseis-magicos'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
