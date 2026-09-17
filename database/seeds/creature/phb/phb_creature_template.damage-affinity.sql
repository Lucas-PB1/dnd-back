-- PVE-6c: afinidades piloto (Elemental do Fogo imune a fogo; Azer resistente).

INSERT INTO rpg.phb_creature_template_damage_affinity (
  template_slug, damage_type_slug, kind
) VALUES
  ('elemental-do-fogo', 'fire', 'immunity'),
  ('azer-sentinela', 'fire', 'resistance'),
  ('azer-piromante', 'fire', 'resistance')
ON CONFLICT DO NOTHING;
