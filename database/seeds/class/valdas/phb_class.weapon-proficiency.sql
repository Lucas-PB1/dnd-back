-- Seed Gunslinger weapon proficiencies
-- RAW: Simple weapons and Martial Ranged weapons

-- Corrige seed antigo que usava armas-marciais (corpo a corpo inclusive)

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_slug)
VALUES
  (
    (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
    'weapon'::rpg.class_proficiency_kind,
    'armas-simples'
  ),
  (
    (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
    'weapon'::rpg.class_proficiency_kind,
    'armas-marciais-a-distancia'
  )
ON CONFLICT (class_id, kind, ref_slug) WHERE ref_slug IS NOT NULL DO NOTHING;
