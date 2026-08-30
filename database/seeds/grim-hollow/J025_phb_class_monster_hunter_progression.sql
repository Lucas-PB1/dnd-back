-- Grim Hollow — Caçador de Monstros progressão

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  1,
  2,
  NULL,
  NULL,
  NULL,
  2
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  2,
  2,
  NULL,
  NULL,
  NULL,
  2
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  3,
  2,
  NULL,
  NULL,
  NULL,
  2
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  4,
  2,
  NULL,
  NULL,
  NULL,
  2
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  5,
  3,
  NULL,
  NULL,
  NULL,
  3
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  6,
  3,
  NULL,
  NULL,
  NULL,
  3
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  7,
  3,
  NULL,
  NULL,
  NULL,
  3
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  8,
  3,
  NULL,
  NULL,
  NULL,
  3
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  9,
  4,
  NULL,
  NULL,
  NULL,
  3
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  10,
  4,
  NULL,
  NULL,
  NULL,
  3
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  11,
  4,
  NULL,
  NULL,
  NULL,
  4
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  12,
  4,
  NULL,
  NULL,
  NULL,
  4
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  13,
  5,
  NULL,
  NULL,
  NULL,
  4
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  14,
  5,
  NULL,
  NULL,
  NULL,
  4
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  15,
  5,
  NULL,
  NULL,
  NULL,
  4
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  16,
  5,
  NULL,
  NULL,
  NULL,
  4
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  17,
  6,
  NULL,
  NULL,
  NULL,
  5
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  18,
  6,
  NULL,
  NULL,
  NULL,
  5
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  19,
  6,
  NULL,
  NULL,
  NULL,
  5
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

INSERT INTO rpg.phb_class_progression (class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  20,
  6,
  NULL,
  NULL,
  NULL,
  5
)
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

