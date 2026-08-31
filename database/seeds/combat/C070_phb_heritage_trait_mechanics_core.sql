-- GH heritage traits — core 10 + classificador automático (Cap. 1)

INSERT INTO rpg.phb_combat_modifier (
  kind, owner_kind, owner_id, heritage_trait_id, label, per_level_bonus, min_trait_takes
)
SELECT
  'hp_bonus'::rpg.combat_modifier_kind,
  'heritage'::rpg.combat_modifier_owner,
  ht.id,
  ht.id,
  'Robustez extra',
  1,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'extra-tough'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_combat_modifier cm
    WHERE cm.heritage_trait_id = ht.id AND cm.kind = 'hp_bonus'::rpg.combat_modifier_kind
  );

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-potent-breath',
  ht.id,
  'Sopro Potente',
  'action'::rpg.action_economy_bucket,
  1,
  'potentBreath',
  TRUE,
  'Sopro elemental (PB usos/LR)',
  'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. Quando você select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 1,5 m wide and 9 m long, or a 4,5 m Cone .',
  'spend-resource',
  700,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'potent-breath'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  min_trait_takes = EXCLUDED.min_trait_takes;

