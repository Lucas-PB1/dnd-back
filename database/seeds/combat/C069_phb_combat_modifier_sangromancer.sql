-- C069: Sangromante — Vigor Sanguíneo (nv. 6+): +1 PV máx. por nível de personagem.
-- Fonte: GHPG Cap. 2 — ao ganhar o recurso no 6º, +6; depois +1 por nível (= per_level × nível).

DELETE FROM rpg.phb_combat_modifier cm
USING rpg.phb_subclass sc
WHERE cm.owner_kind = 'subclass'::rpg.combat_modifier_owner
  AND cm.owner_id = sc.id
  AND sc.slug = 'sangromancer'
  AND cm.kind = 'hp_bonus'::rpg.combat_modifier_kind
  AND cm.label = 'Vigor Sanguíneo';

INSERT INTO rpg.phb_combat_modifier (
  kind, owner_kind, owner_id, label, per_level_bonus, from_level
)
SELECT
  'hp_bonus'::rpg.combat_modifier_kind,
  'subclass'::rpg.combat_modifier_owner,
  sc.id,
  'Vigor Sanguíneo',
  1,
  6
FROM rpg.phb_subclass sc
WHERE sc.slug = 'sangromancer';
