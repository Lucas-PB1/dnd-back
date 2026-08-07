-- Seed Gunslinger weapon proficiencies
-- RAW: Simple weapons and Martial Ranged weapons

-- Corrige seed antigo que usava armas-marciais (corpo a corpo inclusive)
DELETE FROM rpg.phb_class_proficiency
WHERE class_id = (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger')
  AND kind = 'weapon'::rpg.class_proficiency_kind
  AND ref_slug = 'armas-marciais';

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
