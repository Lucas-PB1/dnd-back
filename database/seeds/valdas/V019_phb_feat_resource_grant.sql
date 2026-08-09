-- Talento iron-hero (Valdas): recurso — após V006.
-- Outros talentos/itens com recurso → valdas-player-pack-2/P013.

INSERT INTO rpg.phb_resource_definition (slug, name, scope, feat_id, min_level)
VALUES (
  'ironHeroIntervention',
  'Intervenção Heroica',
  'feat'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  1
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  feat_id = EXCLUDED.feat_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'feat'::rpg.resource_owner_kind,
  f.id,
  rd.id,
  1,
  'proficiency_bonus'::rpg.resource_max_formula,
  NULL,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_feat f
JOIN rpg.phb_resource_definition rd
  ON rd.feat_id = f.id AND rd.slug = 'ironHeroIntervention'
WHERE f.slug = 'iron-hero'
ON CONFLICT DO NOTHING;
