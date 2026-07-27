-- Seed Gunslinger pack spells

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'antiballistics-field',
  'Antiballistics Field',
  6,
  'Level 6',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Action',
  'Self',
  true,
  true,
  true,
  'a pinch of wet gunpowder',
  'V, S, M (a pinch of wet gunpowder)',
  'Concentration, up to 10 minutes',
  true,
  false,
  'A 40-foot Emanation extends from you, disrupting projectiles and causing Ranged weapons to malfunction. Within the Emanation, whenever a Ranged weapon is used for an attack, the weapon immediately malfunctions and the attack is lost. A malfunctioning weapon can’t be used to make an attack until a creature takes the Utilize action to fix the weapon malfunction. Ranged attacks using weapons whose projectiles pass through the Emanation have Disadvantage and deal only half damage on a hit.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'ballistic-smite',
  'Ballistic Smite',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Bonus Action, which you take immediately after hitting a creature with a Ranged weapon',
  'Self',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantaneous',
  false,
  false,
  'Choose Acid, Cold, Fire, Lightning, Poison, or Thunder damage. The target hit by the attack takes an extra 2d6 damage of the chosen type. The triggering attack can deal the chosen damage type or its normal damage type (your choice).',
  'Using a Higher-Level Spell Slot. The damage increases by 1d6 for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'concealed-shot',
  'Concealed Shot',
  0,
  'Cantrip',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Action',
  'Touch',
  false,
  true,
  true,
  'a Ranged weapon',
  'S, M (a Ranged weapon)',
  '1 minute',
  false,
  false,
  'A Ranged weapon you touch is made supernaturally subtle. For the duration, when you make a ranged attack using the weapon, the weapon or ammunition you’re using becomes invisible while in flight and the weapon becomes silent. If the weapon produces smoke or light, the spell suppresses these effects. The weapon or projectile you’re using becomes visible again after the attack hits or misses. If you are hidden and the target is 80 feet or further from you, the attack doesn’t reveal your location.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'conjure-cannonball',
  'Conjure Cannonball',
  3,
  'Level 3',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Action',
  '600 feet',
  true,
  true,
  true,
  'a small replica cannon',
  'V, S, M (a small replica cannon)',
  'Instantaneous',
  false,
  false,
  'You summon a cannonball, mid-flight and at full velocity, which explodes on impact. Make a ranged spell attack roll against a target you can see within range. On a hit, the target takes 5d10 Bludgeoning damage and an explosion extends from it in a 5-foot Emanation. Each creature other than the target within the Emanation makes a Dexterity saving throw, taking half as much damage as the target on a failed save.',
  'Using a Higher-Level Spell Slot. The damage increases by 1d10 for each slot level above 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'conjure-cover',
  'Conjure Cover',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Bonus Action',
  '10 feet',
  true,
  true,
  true,
  'a duck figurine',
  'V, S, M (a duck figurine)',
  'Concentration, up to 1 hour',
  true,
  false,
  'You conjure a low cobblestone wall along the ground at a point you can see within range. The wall is 18 inches thick and is composed of three 5-foot-long, 3-foot-high segments. Each segment must be contiguous with at least one other segment.

A Medium creature that hunkers behind the wall has Half Cover, and a Small creature that hunkers behind it has Three-Quarters Cover. The wall can be leapt over without spending any additional movement.

Each segment has AC 10 and 30 hit points. Reducing a segment of the wall to 0 hit points causes it to crumble, destroying it. The wall disappears when all the segments are destroyed or the spell ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'jam-weapon',
  'Jam Weapon',
  2,
  'Level 2',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reaction, which you take when a creature you can see within range makes an attack using a Ranged weapon',
  '60 feet',
  true,
  true,
  true,
  'a pinch of wet gunpowder',
  'V, S, M (a pinch of wet gunpowder)',
  'Instantaneous',
  false,
  false,
  'The weapon you target suffers a malfunction and the attack fails. A malfunctioning weapon can’t be used to make an attack until a creature takes the Utilize action to fix the weapon malfunction.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'jethro-s-instant-reload',
  'Jethro’s Instant Reload',
  2,
  'Level 2',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Action',
  'Touch',
  true,
  true,
  true,
  'a spent bullet casing',
  'V, S, M (a spent bullet casing)',
  '8 hours',
  false,
  false,
  'One Ranged weapon you touch becomes enchanted to reload itself automatically. If the weapon has the Loading or Reload property, you ignore the property for the duration. When the weapon’s ammunition is depleted, ammunition you are carrying teleports into the weapon.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'perforating-shot',
  'Perforating Shot',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Bonus Action, which you take immediately after hitting or missing with a ranged attack using a weapon',
  'Self',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantaneous',
  false,
  false,
  'As your attack hits or misses the target, the weapon or ammunition transforms into a 5-foot-wide Line of magical energy that extends out to the weapon’s normal range. The Line includes the attack’s original target. Each creature within the Line makes a Dexterity saving throw, taking Force damage equal to the weapon’s normal damage on a failed save or half as much damage on a successful one.',
  'Using a Higher-Level Spell Slot. The weapon’s damage increases by 1d8 for each slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;
