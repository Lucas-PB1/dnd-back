-- Forward: schedules onda 2 (sneak/BI/rage/superiority/psi/...).

-- Onda 2: sneak, BI, rage, indomitable, superiority/psi, champion crit, zealot heal.

-- Rogue: Ataque Furtivo (ceil(level/2) em faixas ímpares).
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('sneak_attack_dice_count', 1, 1::float8),
    ('sneak_attack_dice_count', 3, 2::float8),
    ('sneak_attack_dice_count', 5, 3::float8),
    ('sneak_attack_dice_count', 7, 4::float8),
    ('sneak_attack_dice_count', 9, 5::float8),
    ('sneak_attack_dice_count', 11, 6::float8),
    ('sneak_attack_dice_count', 13, 7::float8),
    ('sneak_attack_dice_count', 15, 8::float8),
    ('sneak_attack_dice_count', 17, 9::float8),
    ('sneak_attack_dice_count', 19, 10::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'rogue'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Bard: faces do dado de Inspiração Bárdica.
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('bardic_inspiration_die_faces', 1, 6::float8),
    ('bardic_inspiration_die_faces', 5, 8::float8),
    ('bardic_inspiration_die_faces', 10, 10::float8),
    ('bardic_inspiration_die_faces', 15, 12::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'bard'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Barbarian: bônus de dano da Fúria.
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('rage_damage_bonus', 1, 2::float8),
    ('rage_damage_bonus', 9, 3::float8),
    ('rage_damage_bonus', 16, 4::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Fighter: usos de Indomável.
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'class', c.id, NULL, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('indomitable_max_uses', 9, 1::float8),
    ('indomitable_max_uses', 13, 2::float8),
    ('indomitable_max_uses', 17, 3::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE c.slug = 'fighter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.class_id = c.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Battle Master: dados de Superioridade.
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'subclass', NULL, sc.id, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_subclass sc
CROSS JOIN (
  VALUES
    ('superiority_dice_count', 3, 4::float8),
    ('superiority_dice_count', 7, 5::float8),
    ('superiority_dice_count', 15, 6::float8),
    ('superiority_die_faces', 3, 8::float8),
    ('superiority_die_faces', 10, 10::float8),
    ('superiority_die_faces', 18, 12::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE sc.slug = 'battle-master'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.subclass_id = sc.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Psi Warrior + Soulknife: dados de Energia Psiônica (mesma progressão).
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'subclass', NULL, sc.id, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_subclass sc
CROSS JOIN (
  VALUES
    ('psi_energy_dice_count', 3, 4::float8),
    ('psi_energy_dice_count', 5, 6::float8),
    ('psi_energy_dice_count', 9, 8::float8),
    ('psi_energy_dice_count', 11, 8::float8),
    ('psi_energy_dice_count', 13, 10::float8),
    ('psi_energy_dice_count', 17, 12::float8),
    ('psi_energy_die_faces', 3, 6::float8),
    ('psi_energy_die_faces', 5, 8::float8),
    ('psi_energy_die_faces', 9, 8::float8),
    ('psi_energy_die_faces', 11, 10::float8),
    ('psi_energy_die_faces', 13, 10::float8),
    ('psi_energy_die_faces', 17, 12::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE sc.slug IN ('psi-warrior', 'soulknife')
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.subclass_id = sc.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Champion: limiar de crítico (menor = melhor).
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'subclass', NULL, sc.id, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_subclass sc
CROSS JOIN (
  VALUES
    ('champion_crit_threshold', 3, 19::float8),
    ('champion_crit_threshold', 15, 18::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE sc.slug = 'champion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.subclass_id = sc.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );

-- Zealot: dados de cura (Campeão dos Deuses).
INSERT INTO rpg.phb_class_feature_schedule (owner_kind, class_id, subclass_id, feature_key, unlock_level, value_num)
SELECT 'subclass', NULL, sc.id, v.feature_key, v.unlock_level, v.value_num
FROM rpg.phb_subclass sc
CROSS JOIN (
  VALUES
    ('zealot_healing_dice_count', 3, 4::float8),
    ('zealot_healing_dice_count', 6, 5::float8),
    ('zealot_healing_dice_count', 12, 6::float8),
    ('zealot_healing_dice_count', 17, 7::float8)
) AS v(feature_key, unlock_level, value_num)
WHERE sc.slug = 'zealot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_feature_schedule s
    WHERE s.subclass_id = sc.id AND s.feature_key = v.feature_key AND s.unlock_level = v.unlock_level
  );
