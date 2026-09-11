-- Forward: tabelas de perfil/template de companheiro + seed mínimo

CREATE TABLE IF NOT EXISTS rpg.phb_companion_profile (
  profile_id TEXT PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  min_level INTEGER NOT NULL CHECK (min_level BETWEEN 1 AND 20)
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_phb_companion_profile_subclass
  ON rpg.phb_companion_profile(subclass_id);

CREATE TABLE IF NOT EXISTS rpg.phb_companion_template_map (
  id BIGSERIAL PRIMARY KEY,
  profile_id TEXT NOT NULL REFERENCES rpg.phb_companion_profile(profile_id) ON DELETE CASCADE,
  option_matches JSONB NOT NULL,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE RESTRICT,
  variant_label TEXT NOT NULL,
  CONSTRAINT phb_companion_template_map_matches_object CHECK (
    jsonb_typeof(option_matches) = 'object'
  )
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_phb_companion_template_map_profile_matches
  ON rpg.phb_companion_template_map(profile_id, option_matches);

INSERT INTO rpg.phb_companion_profile (profile_id, subclass_id, min_level)
SELECT v.profile_id, s.id, v.min_level
FROM (
  VALUES
    ('beast-master-primal', 'beast-master', 3),
    ('primal-spirit', 'pathofthe-primal-spirit', 3)
) AS v(profile_id, subclass_slug, min_level)
JOIN rpg.phb_subclass s ON s.slug = v.subclass_slug
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
