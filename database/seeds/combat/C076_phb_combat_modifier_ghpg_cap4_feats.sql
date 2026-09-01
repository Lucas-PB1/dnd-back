-- Combat modifiers — talentos Grim Hollow Cap. 4
-- Resolução do Sindicato: +1 PV máx. por nível (= nível atual ao longo da carreira).

DELETE FROM rpg.phb_combat_modifier cm
USING rpg.phb_feat f
WHERE cm.owner_kind = 'feat'::rpg.combat_modifier_owner
  AND cm.owner_id = f.id
  AND f.slug = 'resolutionofthe-syndicate'
  AND cm.kind = 'hp_bonus'::rpg.combat_modifier_kind
  AND cm.label = 'Resiliente';

INSERT INTO rpg.phb_combat_modifier (kind, owner_kind, owner_id, label, per_level_bonus)
SELECT
  'hp_bonus'::rpg.combat_modifier_kind,
  'feat'::rpg.combat_modifier_owner,
  f.id,
  'Resiliente',
  1
FROM rpg.phb_feat f
WHERE f.slug = 'resolutionofthe-syndicate';
