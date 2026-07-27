-- Seed Gunslinger weapon proficiencies
-- RAW: Simple weapons and Martial Ranged weapons

INSERT INTO rpg.phb_weapon_proficiency (slug, label)
VALUES ('armas-marciais-a-distancia', 'Armas Marciais (à Distância)')
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;

-- Corrige seed antigo que usava armas-marciais (corpo a corpo inclusive)
DELETE FROM rpg.phb_class_weapon_proficiency
WHERE class_id = (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger')
  AND proficiency_id = (
    SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais'
  );

INSERT INTO rpg.phb_class_weapon_proficiency (class_id, proficiency_id)
VALUES
  (
    (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
    (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')
  ),
  (
    (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
    (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais-a-distancia')
  )
ON CONFLICT DO NOTHING;
