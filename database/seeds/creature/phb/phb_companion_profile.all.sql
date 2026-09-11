-- Mapas opção → template de companheiro (Beast Master + Path of the Primal Spirit).

INSERT INTO rpg.phb_companion_profile (profile_id, subclass_id, min_level)
VALUES
  (
    'beast-master-primal',
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
    3
  ),
  (
    'primal-spirit',
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    3
  )
ON CONFLICT (profile_id) DO UPDATE SET
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_companion_template_map (
  profile_id, option_matches, template_slug, variant_label
)
VALUES
  ('beast-master-primal', '{"primalCompanion":"earth"}'::jsonb, 'primal-companion-earth', 'Terra'),
  ('beast-master-primal', '{"primalCompanion":"sky"}'::jsonb, 'primal-companion-sky', 'Céu'),
  ('beast-master-primal', '{"primalCompanion":"sea"}'::jsonb, 'primal-companion-sea', 'Mar'),

  ('primal-spirit', '{"primalCompanionStatBlock":"primal-guardian","primalCompanionEnvironment":"land"}'::jsonb, 'primal-companion-guardian-land', 'Guardião Primal · Terra'),
  ('primal-spirit', '{"primalCompanionStatBlock":"primal-guardian","primalCompanionEnvironment":"sea"}'::jsonb, 'primal-companion-guardian-sea', 'Guardião Primal · Mar'),
  ('primal-spirit', '{"primalCompanionStatBlock":"primal-guardian","primalCompanionEnvironment":"sky"}'::jsonb, 'primal-companion-guardian-sky', 'Guardião Primal · Céu'),
  ('primal-spirit', '{"primalCompanionStatBlock":"primal-striker","primalCompanionEnvironment":"land"}'::jsonb, 'primal-companion-striker-land', 'Atacante Primal · Terra'),
  ('primal-spirit', '{"primalCompanionStatBlock":"primal-striker","primalCompanionEnvironment":"sea"}'::jsonb, 'primal-companion-striker-sea', 'Atacante Primal · Mar'),
  ('primal-spirit', '{"primalCompanionStatBlock":"primal-striker","primalCompanionEnvironment":"sky"}'::jsonb, 'primal-companion-striker-sky', 'Atacante Primal · Céu')
ON CONFLICT (profile_id, option_matches) DO UPDATE SET
  template_slug = EXCLUDED.template_slug,
  variant_label = EXCLUDED.variant_label;
