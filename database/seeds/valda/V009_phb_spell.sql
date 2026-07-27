-- Seed Valda spells
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'accelerate-decelerate',
  'Accelerate/Decelerate',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reaction, which you take when you see an attack roll hit a creature within 60 feet of yourself',
  '60 feet',
  true,
  true,
  true,
  'a drop of oil or molasses',
  'V, S, M (a drop of oil or molasses)',
  'Instantaneous',
  false,
  false,
  '[Chronomancy]

This spell accelerates or decelerates an attack (see the chosen effect below) the instant before it strikes, lessening or multiplying its force.

Accelerate. The target takes an extra 2d6 damage from the attack. This extra damage is the same type dealt by the triggering attack.

Decelerate. Reduce the damage the target takes by 2d6 (to a minimum of 0 damage).',
  'Using a Higher-Level Spell Slot. The extra damage or reduction in damage increases by 1d6 for each slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'clue',
  'Clue',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Action or Ritual',
  'Touch',
  true,
  true,
  true,
  'a magnifying glass and pipe',
  'V, S, M (a magnifying glass and pipe)',
  '10 minutes',
  false,
  true,
  'When you cast this spell, all footprints and fingerprints within a 30-foot Emanation originating from you become highlighted and glow faintly for the duration. When you cast the spell, choose any point in time up to 10 days ago. Only footprints and fingerprints left between that time and the present will be highlighted. Each creature that leaves footprints and fingerprints is assigned a unique color, but are not otherwise identified. Any creature that moves or touches objects within the Emanation will also leave colorful footprints and fingerprints, which might reveal invisible creatures in the area.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'delay',
  'Delay',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Action',
  '60 feet',
  true,
  true,
  true,
  'an octagonal sign',
  'V, S, M (an octagonal sign)',
  'Instantaneous',
  false,
  false,
  '[Chronomancy]

You briefly slow time for a creature of your choice that you can see within range. The target must succeed on a Wisdom saving throw or be moved to last place in the Initiative order from the start of the next round onwards.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'dire-warning',
  'Dire Warning',
  4,
  'Level 4',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Action',
  'Self',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantaneous',
  false,
  false,
  '[Chronomancy]

You receive a message of up to 6 words from yourself in the future, warning you of a critical threat or pointing you toward a fruitful avenue. The GM determines this message. At some point in the future, once you have learned why you sent the message, you must perform a ritual over the course of 10 minutes, which can be done during a Short or Long Rest, to deliver the message back in time to your past self. If you cast this spell and receive no message, it indicates that you will never complete the ritual in the future, possibly owing to your death or another hindrance.

Once you cast this spell, you can’t cast it again for 7 days or until you perform its ritual.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'defenestration',
  'Defenestration',
  2,
  'Level 2',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Action',
  '30 feet',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantaneous',
  false,
  false,
  'A wave of force erupts from your open hand, hurling a creature you can see within range through a window. The target makes a Strength saving throw. On a failure, the target is pushed up to 20 feet and thrown through a window of your choice. If there is no window within 20 feet of the target, it is instead pushed up to 20 feet in a direction of your choice and thrown through a window of arcane force, which materializes behind the creature and vanishes after it shatters. The target takes 4d6 Slashing damage and has the Prone condition when it is thrown through a window. On a successful save, the target is instead only pushed 10 feet and takes no damage.',
  'Using a Higher-Level Spell Slot. The damage increases by 1d6 and the distance the target is pushed on a success or failure increases by 5 feet for each spell slot level above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'mandy-s-feral-follower',
  'Mandy’s Feral Follower',
  4,
  'Level 4',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Action',
  '30 feet',
  true,
  true,
  true,
  'a small servant’s bell',
  'V, S, M (a small servant’s bell)',
  'Special',
  false,
  false,
  'You touch a Medium or smaller Beast, which shape-shifts into a Humanoid with an appearance of your choice. The Beast’s statistics are replaced by the stat block of a Commoner but retains its Hit Points and Hit Point Dice. You choose the Commoner’s skill proficiency. The commoner wears Fine Clothes but has no other equipment, and has a basic understanding of all unskilled tasks.

The target gains 10 Temporary Hit Points. The spell ends early on the target if it has no Temporary Hit Points left. When the spell ends, the Fine Clothes dissipate into smoke.

Combat. The commoner is an ally to you and your allies. It rolls its own Initiative and acts on its own turn. It behaves as though it is dutifully employed by you.

Duration. This spell’s duration varies depending upon when and where it was cast. If cast in a location where time passes normally, the spell lasts until the twelfth stroke of the next midnight, however long that may be. Elsewhere, the spell lasts for 24 hours.',
  'Using a Higher-Level Spell Slot. You can shape-shift one additional Beast for each spell slot level above 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'finger-guns',
  'Finger Guns',
  0,
  'Cantrip',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Bonus Action',
  'Self',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minute',
  false,
  false,
  'You extend your forefinger and thumb, a dangerous gesture mimicking a gun. For the duration, your hand counts as a Simple Ranged weapon with a range of 60/240 feet and the Slow mastery property. You can use your spellcasting ability instead of Dexterity for the attack rolls of this weapon. On a hit, the weapon deals 2d6 Force damage and doesn’t add your ability modifier to damage.',
  'Cantrip Upgrade. The weapon’s normal range increases by 30 feet and its long range increases by 120 feet when you reach levels 5 (90/360 feet), 11 (120/480 feet), and 17 (150/600 feet).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'game-of-fate',
  'Game of Fate',
  6,
  'Level 6',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Action or Ritual',
  '60 feet',
  true,
  true,
  true,
  'a Gaming Set',
  'V, S, M (a Gaming Set)',
  '1 hour',
  false,
  true,
  'You magically compel a creature within range that can hear and understand you to a nonmagical game with vital consequences. An unwilling creature must succeed on a Wisdom saving throw or be compelled to join you in the game.

The loser of the game takes 6d6 Psychic damage. If no player has won or lost by the end of the spell’s duration, both you and the target take this damage. If you or one of your allies harms the target, you forfeit the game, and vice versa if the target or one of its allies harms you.

Additionally, you and the target creature can negotiate for greater stakes. You can wager for higher Psychic damage (up to a maximum of 12d6), currency, property, or more esoteric rewards, such as bestowal of a noble title. The spell reveals if a creature attempts to place a bet it can’t fulfill. A bet is finalized when you and the target agree on the bet, solidifying the bet with a handshake or similar gesture. Property or currency bet on the game is teleported to the winner at the game’s conclusion. The loser is also magically compelled to take any action (such as bestowing a noble title) wagered as part of a bet.

Lastly, no spell, magical effect, or creature other than you and the target can influence the game’s outcome.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'hangover',
  'Hangover',
  2,
  'Level 2',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Action',
  '30 feet',
  true,
  true,
  true,
  'a vial of strong liquor',
  'V, S, M (a vial of strong liquor)',
  'Instantaneous',
  false,
  false,
  'You emit a drunken aura that quickly washes away, leaving an intense hangover. A creature you choose within range makes a Constitution saving throw. On a failed save, the creature takes 3d8 Psychic damage and has the Poisoned condition until the end of your next turn. On a successful save, the target takes half as much damage only. The target has Disadvantage on Constitution saving throws it makes to maintain Concentration as a result of this damage.',
  'Using a Higher-Level Spell Slot. The damage increases by 1d8 for each spell slot level above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'memorize',
  'Memorize',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Action or Ritual',
  'Touch',
  true,
  true,
  true,
  'silver string worth 10+ GP, tied in a knot, which the spell consumes',
  'V, S, M (silver string worth 10+ GP, tied in a knot, which the spell consumes)',
  'Instantaneous',
  false,
  true,
  'When you cast this spell, your eyes pass over a page of written text that is committed to your memory. For the next year, you remember the exact details of all information on the page. After that time, you have Advantage on all Intelligence checks you make to recall this information.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'moment-to-think',
  'Moment to Think',
  0,
  'Cantrip',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Bonus Action',
  'Self',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantaneous',
  false,
  false,
  '[Chronomancy]

When you cast this spell, you briefly stop time for everyone but yourself. You can take one additional action and move around in your space while no time passes for other creatures. That action can be used only to take the Search, Study, or Utilize action. Furthermore, you can’t affect or damage any creature or object, other than objects you are wearing or carrying. If an object leaves your hand, it also becomes frozen in time.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'paradox',
  'Paradox',
  9,
  'Level 9',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Action',
  '60 feet',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantaneous',
  false,
  false,
  '[Chronomancy]

By twisting the flow of time into knots, you cause one action of your choice taken within range within the last round to be undone. Reality then reasserts itself, recoiling from the damage caused by removing an event from time. The direct effects of that action, such as damage dealt by an attack or spell, are undone, but the indirect effects, such as creatures choosing to move to different locations, are not. The creature that took the action takes 10d8 Psychic damage, as it copes with its history being modified.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'polybrachia',
  'Polybrachia',
  3,
  'Level 3',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Action',
  'Touch',
  true,
  true,
  true,
  'a pair of armbands',
  'V, S, M (a pair of armbands)',
  'Concentration, up to 10 minutes',
  true,
  false,
  'Two muscular arms of brilliant arcane energy appear on a willing creature that you touch. These arms are fully functional and can be used to wield weapons and Shields (allowing the target to simultaneously hold 2 two-handed weapons, or 4 one-handed weapons), perform Somatic components of spells, and perform other actions. For the duration, the target has Advantage on Strength (Athletics) checks. The target can take a Bonus Action to make a melee attack using a weapon wielded by the arms.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'recall',
  'Recall',
  2,
  'Level 2',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Bonus Action',
  'Self',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 round',
  false,
  false,
  '[Chronomancy]

Record your location when you cast this spell. Until the end of your next turn, you can take a Reaction in response to an attack roll, a creature casting a spell, or a creature moving within 5 feet of you to teleport back to that location, or to the nearest unoccupied space if that space is occupied. This teleportation precedes the triggering attack or spell. The spell then ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'rumor',
  'Rumor',
  1,
  'Level 1',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Action',
  'Self',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minute',
  false,
  false,
  'You magically spread a rumor of 10 words or less in a 100-foot Emanation originating from you. Any creature within the Emanation that can hear and understand three or more other creatures believes that they hear the rumor being repeated by someone nearby. Different creatures hear the rumor from different people, so a concrete origin is impossible to discern. Generally, creatures won’t become Hostile upon hearing even the most vicious rumors, but hearing a rumor can affect their attitude positively or negatively.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
