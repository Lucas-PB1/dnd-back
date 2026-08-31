-- Magias Grim Hollow Cap. 7 (Spells & Curses)
-- Gerado por scripts/generate-ghpg-cap7-spell-seeds.mjs — textos EN; ranges SI.
-- Fonte: grim-hollow-players-guide-2024-en:chapter-7-spells-curses
-- Tag Sangromancy: prefixo na description quando aplicável.

-- Remove órfão de extract antigo (heading de regras confundido com magia)
DELETE FROM rpg.phb_spell_class
WHERE spell_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'shadowsteel-focus');
DELETE FROM rpg.phb_spell WHERE slug = 'shadowsteel-focus';

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'arboreal-curse',
  'Arboreal Curse',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a cup of sap',
  'V, S, M (a cup of sap)',
  'Até ser dissipada',
  false,
  false,
  'You attempt to turn one creature that you can see within range into wood. The creature makes a Constitution saving throw. On a failed save, it has the Restrained condition as its flesh begins to harden into bark. On a successful save, its Speed is 0 until the start of your next turn.

A creature Restrained by this spell makes a Constitution saving throw at the end of each of its turns. If it successfully saves three times, the condition ends. If it fails three times, it is turned into a tree and has the Petrified condition. The successes and failures needn’t be consecutive; keep track of both until the target collects three of a kind.

If the creature is burned, chopped down, or otherwise destroyed while Petrified, it is killed.

A creature remains transformed unless the effect is reversed within 1 year with Greater Restoration , Wish , or similar magic. If the creature spends 1 year and 1 day as a tree, the transformation becomes permanent, and nothing can return the creature to its original form.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'arcane-aegis',
  'Arcane Aegis',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Pessoal',
  false,
  true,
  true,
  'a statuette of a hedgehog',
  'S, M (a statuette of a hedgehog)',
  '1 minuto',
  false,
  false,
  'When you cast this spell, you are surrounded by a shimmering light that quickly dissipates. You gain 2d10 Temporary Hit Points . If a creature hits you with a melee attack before the spell ends, the creature takes Force damage equal to the number of Temporary Hit Points lost as a result of the attack. The spell ends early if you have no Temporary Hit Points.',
  'You gain an additional 2d10 Temporary Hit Points for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'assisted-aim',
  'Assisted Aim',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '9 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'You invigorate up to three creatures within range with improved accuracy. Each target gains a +1 bonus to attack rolls it makes with Ranged weapons. Additionally, the normal and long range of Ranged weapons wielded by a target are doubled for the spell’s duration.',
  'You can target one additional creature for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'binding-pledge',
  'Binding Pledge',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  '1 minuto or Ritual',
  'Toque',
  true,
  true,
  true,
  'a book of religious or legal importance',
  'V, S, M (a book of religious or legal importance)',
  '10 days',
  false,
  false,
  'When you cast the spell, a willing creature within range makes a promise, swears an oath, or enters into a contract. For the duration of the spell, you immediately know if the creature breaks that promise, oath, or contract. If this happens, for the remainder of the duration of the spell, you know the distance and direction to the creature. If this spell is dispelled, you immediately know it but don’t learn the distance and direction to the creature.',
  'The duration becomes 30 days (level 3-4 slot) or 1 year (level 5-6 slot). If you use a level 7+ spell slot, the spell lasts until dispelled.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'bloat',
  'Bloat',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a bean',
  'V, S, M (a bean)',
  '1 round',
  false,
  false,
  'You cause the gases within a creature you can see within range to expand rapidly. The target makes a Constitution saving throw, taking 3d10 Necrotic damage on a failed save or half as much damage on a successful one. If the damage that the creature takes equals or exceeds its Constitution ability score, the creature floats vertically 1,5 m and remains suspended until the start of your next turn. The target can move only by pushing or pulling against a fixed object or surface within reach (such as a wall or a ceiling), which allows it to move as if it were climbing. When the spell ends, the target floats gently to the ground.

I saw the witch make the Inquisitor puff up like a sack of wind. Everyone was terrified. I laughed.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'bloodbane-rune',
  'Bloodbane Rune',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  false,
  true,
  false,
  NULL,
  'S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. You target a weapon of your choice within range and scrawl onto it a rune written in blood.

For the duration, while you wield this weapon, it weeps a phantasmal red ichor when within 9 m of an Undead creature. Additionally, once per turn, when you damage an Undead creature with the weapon, you deal extra Radiant damage. To determine this damage, roll the number of Hit Point Dice you expended to cast the spell.',
  'You expend an additional Hit Point Die for each spell slot level above 1. In addition, your Concentration can last longer with a spell slot of level 2 (up to 10 minutes) or 3+ (up to 1 hour).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'bloodletter',
  'Bloodletter',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação Bônus',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'You touch a nonmagical weapon. Until the spell ends, the first creature hit by the weapon must succeed on a Constitution saving throw or receive a festering wound. A creature with a festering wound takes 2d6 Necrotic damage at the start of each of its turns for the spell’s duration. A creature can only have one festering wound at a time.

If the creature receives healing, the spell and recurring damage end.',
  'The damage increases by 1d6 for each spell slot above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-bond',
  'Blood Bond',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a rag soaked in your own blood',
  'V, S, M (a rag soaked in your own blood)',
  '1 hora',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend three Hit Point Dice or the spell automatically fails. Roll the expended Hit Point Dice, and the target gains a number of Temporary Hit Points equal to the roll’s total.

For the duration, you know the direction and distance to the target, and you and the target can speak telepathically. Additionally, you can target that creature when you cast a spell with a range of Self or Touch, regardless of the distance between you. These benefits are suppressed while you and the creature are not on the same plane.

At any point, the targeted creature can choose to end the spell early. If it does, the creature loses all remaining Temporary Hit Points granted by this spell and takes Necrotic damage equal to the Temporary Hit Points lost.',
  'The duration increases with a spell slot level 5 or 6 (8 hours), 7 or 8 (24 hours), and 9 (7 days).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-rush',
  'Blood Rush',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. Roll the Hit Point Die twice, and regain a number of Hit Points equal to the added roll plus your spellcasting ability modifier.',
  'You can expend one additional Hit Point Die for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-tide',
  'Blood Tide',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a shell',
  'V, S, M (a shell)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend six Hit Point Dice or the spell automatically fails.

A gout of blood forming a 30 m-long, 3 m-wide Line blasts out from you in a direction you choose. Each creature in the Line must make a Dexterity saving throw. On a failed save, the creature is pushed 30 m away from you in a direction following the Line, has the Prone condition, and takes Bludgeoning damage equal to a roll of the Hit Point Dice expended on the spell plus your spellcasting ability modifier. On a successful save, the creature takes half as much damage only.',
  'You can expend one additional Hit Point Die for each spell slot level above 6. The arcanists who use blood magic are the most terrible of all. It’s cruel, and messy.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'blood-wisp',
  'Blood Wisp',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a ruby worth 10 GP',
  'V, S, M (a ruby worth 10 GP)',
  '1 hora',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend two Hit Point Dice or the spell automatically fails. Roll the Hit Point Dice expended to cast the spell and create a red wisp with a number of Hit Points equal to the roll plus your spellcasting ability modifier. The wisp circles your head. It has an AC equal to 10 plus your spellcasting ability modifier, and uses your saving throws.

Each time you roll damage for a spell while the wisp circles you, you can reroll one of the damage dice. You must use the new roll, and the wisp takes damage equal to the new roll. If the wisp is reduced to 0 Hit Points, the spell ends.',
  'You can expend one additional Hit Point Die for each spell slot level above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'boil-blood',
  'Boil Blood',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. A willing target takes Fire damage equal to a roll of the expended Hit Point Die. If the target has the Poisoned condition, that condition immediately ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'burst-forth',
  'Burst Forth',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '60 m',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend seven Hit Point Dice or the spell automatically fails. You teleport inside a creature that you can see within range and burst forth from it in a fountain of gore in the nearest unoccupied space. The target makes a Constitution saving throw, taking Necrotic damage equal to a roll of the Hit Point Dice expended to cast the spell plus your spellcasting ability modifier on a failed save or half as much damage on a successful one.',
  'You can expend one additional Hit Point Die for each spell slot level above 7.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'calling-card',
  'Calling Card',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Toque',
  false,
  true,
  true,
  'a stamp carved like the mark left by your calling card',
  'S, M (a stamp carved like the mark left by your calling card)',
  'Até ser dissipada',
  false,
  false,
  'You touch a corpse and leave a magical mark. You can choose to make it a visible mark that appears as a rune or word written on the flesh, or you can choose to make the mark Invisible . A creature that takes the Study action to specifically examine a corpse automatically detects it, whether visible or Invisible.

The murders happening in Liesech have the authorities stumped. I found one of the bodies by the docks. They said there was a magical mark on it, but I didn’t notice it.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'call-the-rabid-beast',
  'Call the Rabid Beast',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a fang from a rabid animal',
  'V, S, M (a fang from a rabid animal)',
  'Concentração, até 1 minuto',
  true,
  false,
  'A creature you touch transforms into a rabid monster, filled with primal fury. The target sprouts thick fur and its mouth elongates into a fanged maw. It gains 20 Temporary Hit Points . While transformed, the creature has the following effects:',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'chains-of-beleth',
  'Chains of Beleth',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '30 m',
  true,
  true,
  true,
  'a chain link',
  'V, S, M (a chain link)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Barbed chains ending in meat hooks burst from the ground from a point you can see within range, flailing in a 6 m-radius Sphere centered on that point.

Each creature in the area makes a Dexterity saving throw. On a failed save, it takes 8d6 Piercing damage and has the Restrained condition until the spell ends.

The first time a creature enters the chain’s area on a turn or starts its turn there, it must succeed on a Dexterity saving throw or have the Restrained condition while in the area or until it breaks free. A creature Restrained by the chains can take an action to make a Strength ( Athletics ) check against your spell save DC. If it succeeds, it is no longer Restrained.

When a creature Restrained by this spell ends its turn, the creature takes 3d6 Bludgeoning damage.',
  'The initial and subsequent damage increase by 1d6 for each spell slot level above 6.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'circle-of-scarlet',
  'Circle of Scarlet',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '36 m',
  true,
  true,
  true,
  'a piece of parchment with a circle drawn in humanoid blood',
  'V, S, M (a piece of parchment with a circle drawn in humanoid blood)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend four Hit Point Dice or the spell automatically fails. A crimson pillar erupts from the ground in a 6 m-radius, 30 m-high Cylinder centered on a point within range. Each creature within the Cylinder makes a Constitution saving throw.

On a failed save, the creature takes Necrotic damage equal to a roll of the Hit Point Dice expended on the spell plus your spellcasting ability modifier. On a successful save, the creature takes half as much damage.

For each creature that fails the saving throw against this spell, you gain 10 Temporary Hit Points .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'conjure-plants',
  'Conjure Plants',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  'You conjure animated plants that appear as a Large mass of vines, stems, shoots, roots, and leaves in an unoccupied space you can see within range. The vegetation lasts for the duration.

While you’re within 1,5 m of the plants or sharing a space with them, you are considered to be in a Lightly Obscured area. Other creatures cannot enter the same space as the plants. When you move on your turn, you can also move the plants up to 9 m to an unoccupied space you can see.

Whenever the plants move within 1,5 m of a creature you can see, and whenever a creature you can see enters a space within 1,5 m of the plants or ends its turn there, you can force that creature to make a Dexterity saving throw. On a failed save, the creature takes 3d6 Slashing damage. A creature makes this save only once per turn.',
  'The damage increases by 1d6 for each spell slot level above 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'consume-mind',
  'Consume Mind',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a 1-ounce fresh or magically preserved portion of another creature’s brain',
  'V, S, M (a 1-ounce fresh or magically preserved portion of another creature’s brain)',
  '1 hora',
  false,
  false,
  'You consume the brain of a dead creature, gaining access to its memories. The creature must have a brain and can’t be Undead. The spell fails if the creature has been dead (and not preserved) for more than 3 days.

Until the spell ends, you can attempt to recall a memory, such as family history, recent events, building layouts, passwords, details of the creature’s death, and similar information. To recall a memory, you take a Magic action and make an ability check using your spellcasting ability modifier. The DC equals the corpse’s Intelligence ability score.

Once you take a Magic action to recall information, you can’t attempt to recall that specific piece of information again.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'consumption',
  'Consumption',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  '18 m',
  true,
  true,
  true,
  'a malnourished leech',
  'V, S, M (a malnourished leech)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. Choose a creature within range and roll the expended Hit Point Die. The target takes Necrotic damage equal to the result. At the end of each of its turns while the spell lasts, the target makes a Constitution saving throw. On a failed save, it takes this damage again. On a successful save, the spell ends.',
  'You can target one additional creature for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'creeping-death',
  'Creeping Death',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  false,
  true,
  false,
  NULL,
  'S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend eight Hit Point Dice or the spell automatically fails. Roll the expended Hit Point Dice. The target’s Creeping Death threshold is equal to the roll’s total. For the spell’s duration, if the creature’s Hit Points are reduced to or lower than its Creeping Death threshold, the creature immediately dies.

As a Bonus Action, you can force the target to make a Constitution saving throw. On a failed save, roll 2d6 and add the result to the creature’s Creeping Death threshold. On a successful save, add half the result instead. If the creature succeeds on three saving throws, which don’t have to be consecutive, this spell ends early.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'creeping-touch',
  'Creeping Touch',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  'You detach your hand at the wrist, transforming it into a Spider . While the spider is within 30 m of you, you can communicate with it telepathically. Additionally, as a Magic action, you can see through its eyes and hear what it hears until the start of your next turn. During this time, you have no awareness of your own surroundings.

If the spider is killed or doesn’t return to you before the spell ends, your hand is restored, but you take 1d6 Psychic damage. As a Bonus Action, you can command the spider to return to you. Once it arrives, it reattaches as your hand and the spell ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'crimson-lash',
  'Crimson Lash',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  '1 minuto',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. A writhing lash of coagulated blood springs from your hand with the following properties:',
  'If you cast this spell using a level 3-4 spell slot, you can make two weapon attacks with this weapon when you take the Attack action. If you use a level 5+ spell slot, you can make three weapon attacks with this weapon when you take the Attack action.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'crown-of-radiance',
  'Crown of Radiance',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  '10 minutos',
  false,
  false,
  'A flaming crown of holy light adorns your head until the spell ends. A Fiend, Fey, or Undead that moves within 9 m of you or begins its turn within 9 m of you takes 2d8 Radiant damage.

The crown sheds Bright Light in a 9 m radius and Dim Light for an additional 9 m.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'dark-sacrament',
  'Dark Sacrament',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a dagger encrusted in jewels worth 100+ GP',
  'V, S, M (a dagger encrusted in jewels worth 100+ GP)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend four Hit Point Dice or the spell automatically fails. Make a melee spell attack against a creature within 1,5 m using the Material component of this spell. On a hit, roll the Hit Point Dice expended to cast the spell plus 4d8. You deal Necrotic damage equal to the roll’s total. If this damage causes the creature to be reduced to 0 Hit Points, it immediately dies and you gain one of the following dark blessings of your choice. When you take Radiant damage while you have a dark blessing, you take an extra 1d4 Radiant damage.

Unassailable. You have Advantage on all saving throws.

Unbreakable. Your size increases by one category (from Medium to Large, for example), you gain a number of Temporary Hit Points equal to your Constitution modifier (minimum 1) at the start of each of your turns, and your weapon attacks deal an extra 1d4 damage.

Unerring. Your Proficiency Bonus increases by 2.

Your dark blessing ends after 10 minutes or when you are reduced to 0 Hit Points, whichever happens first.',
  'The initial damage increases by 1d8 for each spell slot level above 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'dazing-blast',
  'Dazing Blast',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'A wave of force leaves your palms, targeting a creature within range. The target makes a Constitution saving throw. On a failed save, the creature takes 2d6 Force damage and has the Stunned condition until the end of its next turn. On a successful save, the creature takes the damage only.',
  'One additional creature can be targeted for each spell slot above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'earth-worm',
  'Earth Worm',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'You transform the earth into a wormlike maw at an unoccupied point on the ground within range. As a Bonus Action, make a melee spell attack against a creature within 1,5 m of the worm. On a hit, the target takes Piercing damage equal to 3d8 plus your spellcasting ability modifier. If the target is a Large or smaller creature, it must succeed on a Dexterity saving throw or be swallowed by the worm. A swallowed creature has the Blinded and Restrained conditions, it has Total Cover against attacks and other effects outside the worm, and it takes 6d6 Bludgeoning damage at the start of each of your turns.

A creature trapped within the worm can take an action to make a Strength ( Athletics ) check against your spell save DC. If it succeeds, it is regurgitated and has the Prone condition in an unoccupied space within 3 m of the worm.

As a Bonus Action, you can move the worm up to 9 m.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'elemental-exhalation',
  'Elemental Exhalation',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  'Instantânea',
  false,
  false,
  'When you cast this spell, choose one of the following effects that determine the spell’s damage type:

Air. The damage type is Thunder. Each creature that fails the saving throw is pushed 3 m away from you.

Coldfire. The damage type is Cold. Each creature that fails the saving throw has the Frightened condition until the start of your next turn.

Earth. The damage type is Bludgeoning. Each creature that fails the saving throw has its Speed reduced to 0 until the end of its next turn.

Fire. The damage type is Fire. Each creature that fails the saving throw is engulfed in flames and takes 2d6 Fire damage at the end of its next turn. As an action, it can extinguish fire on itself by giving itself the Prone condition and rolling on the ground. The fire also goes out if it is doused, submerged, or suffocated.

Water. The damage type is Acid. Each creature that fails the saving throw has the Prone condition.

Each creature within a 9 m Cone of destructive elemental energy must make a Dexterity saving throw. On a failed save, a target takes 5d6 damage of the chosen type. On a successful save, the target takes half as much damage only.',
  'The damage increases by 1d6 for each spell slot level above 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'emmelines-essence-infusion',
  'Emmeline’s Essence Infusion',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '8 horas',
  'Toque',
  true,
  true,
  true,
  'a diamond vial containing at least one ounce of blood worth at least 100 GP, which this spell consumes',
  'V, S, M (a diamond vial containing at least one ounce of blood worth at least 100 GP, which this spell consumes)',
  'Special',
  false,
  false,
  'When you cast this spell, you target one nonmagical weapon within range. That weapon becomes magical and gains a special benefit based on the creature type of the blood used as the Material component for this spell. The item requires Attunement , and only the creature attuned to this weapon gains these benefits.

Aberration. Your attacks with weapons deal an extra 1d6 Psychic damage on a hit. In addition, you can telepathically speak with any creature that has taken at least 1 point of damage from this weapon in the last 24 hours, provided you are both on the same plane.

Celestial. Your attacks with weapons deal an extra 1d6 Radiant damage on a hit. In addition, you can use a Bonus Action to cause the weapon to shed Bright Light in a 9 m radius and Dim Light for an additional 9 m. You can end this effect by using another Bonus Action.

Dragon. Your attack rolls with this weapon can score a Critical Hit on a roll of 19 or 20 on the d20. In addition, you have Advantage on saving throws you make to avoid or end the Frightened condition.

Fey. Your attacks with weapons deal an extra 1d4 Force damage on a hit. In addition, once per turn when you hit a creature within 9 m with this weapon, you can teleport to an unoccupied space you can see within 1,5 m of it.

Fiend. Your attacks with weapons deal an extra 1d6 Necrotic damage on a hit. You can use a Bonus Action to change this extra damage to Cold or Fire.

When you cast this spell, you attune to the magic weapon. The spell’s duration lasts as long as you have Attunement to the weapon. During the spell’s duration, the magic item is susceptible to the Dispel Magic spell. If you maintain Attunement to the magic weapon for 1 year, the enchantment becomes permanent and this spell ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'enspelled-armament',
  'Enspelled Armament',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  false,
  true,
  'a vial of oil and water',
  'M (a vial of oil and water)',
  '1 hora',
  false,
  false,
  'When you cast this spell, choose one Simple or Martial weapon. A replica of the chosen weapon, made of iridescent energy, appears in your hands. For the duration, you are proficient with that weapon and whenever you attack with the weapon, you can use your spellcasting ability modifier for the attack and damage rolls instead of using Strength or Dexterity. Attacks made with this weapon don’t require ammunition, and if you throw the weapon as part of a ranged attack, it returns to your hand immediately after resolving the attack. The damage dealt by this weapon is Force instead of the weapon’s normal damage type.',
  'The damage of the weapon increases by 1d4 for each spell slot level above 2. If you cast the spell using a level 5+ spell slot, the duration becomes 8 hours.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'extract-iron',
  'Extract Iron',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '1 minuto',
  'Pessoal',
  true,
  true,
  true,
  'a rusty knife',
  'V, S, M (a rusty knife)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend three Hit Dice or the spell automatically fails. Roll the expended Hit Dice and extract a number of pounds of iron from your blood equal to the roll’s total.

You fashion this iron into nonmagical metal objects. The combined weight of these objects must be equal to or less than the number rolled on the expended Hit Point Dice. The quality of these created objects is poor but functional.',
  'You can expend an additional Hit Point Die and create additional iron for each spell slot level above 3. We needed an axle when the cart broke, and I’ll be damned if the hooded stranger didn’t make one out of blood!”',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'fiend-flesh',
  'Fiend Flesh',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a handful of sulfur',
  'V, S, M (a handful of sulfur)',
  'Concentração, até 1 hora',
  true,
  false,
  'You touch a willing creature, transforming its skin into red scales. Until the spell ends, the target has Resistance to Cold, Fire, and Lightning damage, and the target also has Immunity to Poison damage.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'flash-fever',
  'Flash Fever',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'flint and steel',
  'V, S, M (flint and steel)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Choose a creature that you can see within range. The creature breaks into a cold sweat and makes a Constitution saving throw. On a failed save, the cold sweat becomes a burning fever and the creature takes 4d6 Fire damage. On a successful save, the spell ends.

For the duration, at the start of the target’s turn, it takes 2d6 Fire damage. The target must repeat the saving throw at the end of each of its turns until it gets three successes or failures. If the target succeeds on three of these saves, the spell ends. If the target fails three of the saves, it takes 8d6 Fire damage and the spell ends.',
  'The initial damage increases by 1d6 for each spell slot level above 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'flense',
  'Flense',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a scalpel',
  'V, S, M (a scalpel)',
  'Concentração, até 1 minuto',
  true,
  false,
  'You target a creature you can see within range, using necromantic force to slice the skin from its body. Make a ranged spell attack against that creature. On a hit, the target takes 8d6 Necrotic damage.

On each of your subsequent turns until the spell ends, you can take a Magic action to force the same target to make a Constitution saving throw, even if the first attack missed. On a failed save, the target takes 8d6 Necrotic damage. On a successful save, the target takes half as much damage.

The spell ends if the target is ever outside the spell’s range, if the target is reduced to 0 Hit Points, or if you can’t see it.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'fleshcrawl',
  'Fleshcrawl',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '30 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'You rip the flesh from a creature, fashioning it into a twisted monstrosity of blood and skin that rises up to attack the creature.

A creature that you can see within range makes a Constitution saving throw. On a failed save, the creature takes 8d10 Necrotic damage. The creature’s flayed skin is animated as a grotesque mockery. It uses the Fleshling Construct stat block. On a successful save, it takes half as much damage only.

The creature is an ally to you and your allies. In combat, the creature shares your Initiative count, but it takes its turn immediately after yours. It obeys your verbal commands (no action required by you). If you don’t issue any, it takes the Dodge action and uses its movement to avoid danger. The fleshling disappears when it drops to 0 Hit Points or when the spell ends.',
  'Use the spell slot’s level for the spell’s level in the stat block. Medium Construct, Unaligned AC 11 + the spell’s level HP 70 + 10 for each spell level above 7 Speed 9 m. Resistances Psychic Immunities Poison; Charmed , Exhaustion, Frightened , Paralyzed , Poisoned Senses Darkvision 18 m., Passive Perception 12 Languages Understands the languages known by the target Challenge None (XP 0; PB equals your Proficiency Bonus) Actions Strangle. Melee Attack Roll: Bonus equals your spell attack modifier, reach 1,5 m. Hit: 2d8 + the spell’s level Bludgeoning damage, and the target has the Grappled condition (escape DC equals your spell save DC) and can’t speak. Until the grapple ends, the target has the Restrained condition and is suffocating. Constrict. The fleshling construct constricts a target that it is grappling, doing 2d8 + the spell’s level Bludgeoning damage.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'frightful-start',
  'Frightful Start',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a dead spider',
  'V, S, M (a dead spider)',
  '1 round',
  false,
  false,
  'You twist your visage to scare a creature that you can see within range. The creature must succeed on a Wisdom saving throw or have the Frightened condition until the start of your next turn.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'ghost-light',
  'Ghost Light',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a clear marble',
  'V, S, M (a clear marble)',
  '1 hora',
  false,
  false,
  'You touch one object that is no larger than 3 m in any dimension and specify any number of creatures you can see within 3 m. Until the spell ends, the object sheds silvery Bright Light in a 6 m radius and Dim Light for an additional 6 m. This light is only visible to the creatures you specified during the casting of the spell; all other creatures perceive the area affected by the light as they regularly would.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'greater-animate-dead',
  'Greater Animate Dead',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 minuto',
  '3 m',
  true,
  true,
  true,
  'a drop of blood, a piece of flesh, a pinch of bone dust, and a black onyx stone worth 75+ GP for each level of CR you animate',
  'V, S, M (a drop of blood, a piece of flesh, a pinch of bone dust, and a black onyx stone worth 75+ GP for each level of CR you animate).',
  'Instantânea',
  false,
  false,
  'Choose a number of corpses, within range. You can reanimate up to 5 Challenge Rating 2 or lower Undead creatures from these corpses.

On each of your turns, you can take a Bonus Action to mentally command any creature you made with this spell if the creature is within 36 m of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until its task is complete. The creature is under your control for 24 hours, after which time it stops obeying any command you’ve given it.

To maintain control of the creature for another 24 hours, you must cast this spell on the creature again before the current 24-hour period ends. This use of the spell reasserts your control over up to four creatures you have animated with this spell rather than animating a new creature. Additionally, casting this spell in this manner doesn’t require spell components with a GP cost.',
  'You can animate one additional Undead creature for each spell slot level above 5.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'heartseeker',
  'Heartseeker',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '90 m',
  true,
  true,
  true,
  'a ruby worth 100+ GP',
  'V, S, M (a ruby worth 100+ GP)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend six Hit Point Dice or the spell automatically fails. Blood flows from your body then crystallizes into a barbed arrow, which launches at a creature. Make a ranged spell attack against a target within range. On a hit, roll the Hit Point Dice expended to cast the spell, and the creature takes Piercing damage equal to the numbered rolled.

Once lodged in the creature, the bloody arrow begins to burrow toward its heart, rendering it susceptible to injury. Until the spell ends, the first successful attack against a creature after its turn ends each round is automatically a Critical Hit .

The target makes a Constitution saving throw at the end of each of its turns. On a failed save, the effect continues. On a success save, the creature takes 3d8 Necrotic damage and the spell ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'holy-word',
  'Holy Word',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'You whisper a divine word under your breath, careful not to speak loudly, for such celestial power isn’t for the unworthy. Make a ranged spell attack against a target within range. On a hit, the target takes 1d8 Radiant damage. If the target is Fey, Fiend, or Undead, its Speed is reduced by 3 m and it can’t take Reactions until the end of its next turn.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'hunter-sense',
  'Hunter Sense',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'You touch a willing creature. For the duration, the target’s senses are heightened. Whenever the target makes a Wisdom ( Perception ) check, it can treat a d20 roll of 9 or lower as a 10.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'illusory-instrument',
  'Illusory Instrument',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  'Toque',
  true,
  true,
  false,
  NULL,
  'V, S',
  '10 minutos',
  false,
  false,
  'You create an illusionary copy of a mundane musical instrument. The copy of the instrument takes on the shape of your fondest memory of the instrument, such as the first flute you owned or the half harp gifted to you by a loved one. This illusion moves as its physical counterpart would, but it is weightless and is tangible only to you. This instrument can be used as a Spellcasting Focus. This illusory instrument dissipates if you move 3 m away from it or choose to end the spell (no action required by you).

As a Bonus Action, you can command your instrument to create one of the following effects:',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'incite-riot',
  'Incite Riot',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a red handkerchief',
  'V, S, M (a red handkerchief)',
  'Concentração, até 1 minuto',
  true,
  false,
  'When you cast this spell, you wave the red handkerchief used as the Material component and choose any number of creatures within range that can see you. Each chosen creature makes a Wisdom saving throw. It does so with Advantage if you or your allies are fighting it. On a failed save, the target has the Charmed condition until the spell ends or until you or your allies damage it. The Charmed creature is Friendly to you and your allies. While Charmed, it must use its action to make melee attacks against the nearest creature (other than you or your allies) or use its turn to move toward the nearest target.

At the end of each of its turns, the target repeats the save, ending the spell on itself on a success.

The authorities were about to capture her, then suddenly everyone in the bar went mad and started brawling.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'intaglio',
  'Intaglio',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Action or Ritual',
  'Toque',
  true,
  true,
  true,
  'a quill or a vial of ink',
  'V, S, M (a quill or a vial of ink)',
  'Concentração, até 1 hora',
  true,
  false,
  'You create a duplicate of a text or image. During the spell’s duration, you can take a Magic action to trace your hand over any non-magical text or image on a surface within range. You copy the text or image onto a new medium that you provide, such as another book or parchement. This spell copies a single page with each Magic action. When copying a spellbook, you can do so using the same method as you would replace a spellbook, except the time and GP requirements are both halved.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'investiture-of-venom',
  'Investiture of Venom',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  'Until the spell ends, your veins bulge and become visibly green beneath your skin, your eyes weep constantly with liquid poison, and you gain the following benefits:',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'lifesink',
  'Lifesink',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  'An aura extends from you in a 4,5 m Emanation for the duration. Any other creature that enters or begins its turn in the area takes 4d6 Necrotic damage. At the start of your turn, you regain 4d6 Hit Points plus 1 for each creature in the area.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'life-tether',
  'Life Tether',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '36 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto.',
  true,
  false,
  'Choose a creature you can see within range. The target must make a Wisdom saving throw. On a failed save, a sickly green tether forms between you and your target. Whenever you take damage, the tethered target takes half as much damage (round down) as Necrotic damage. If the target drops to 0 Hit Points before this spell ends, you can take a Bonus Action to move the tether to a new creature you can see within range. The new target must succeed on a Wisdom saving throw or be tethered.',
  'You can create additional tethers with a spell slot of level 4 (two tethers), 6 (three tethers), or 8 (four tethers).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'little-death',
  'Little Death',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  false,
  true,
  true,
  'an item of personal sentimental value worth 1+ SP',
  'S, M (an item of personal sentimental value worth 1+ SP)',
  'Up to 8 horas',
  false,
  false,
  'When you cast this spell, you drop to 0 Hit Points and die. At the start of your next turn, you become a Ghost occupying the same space as your corpse. Your game statistics are replaced by the Ghost’s stat block, but you retain your Hit Points; Hit Point Dice; Intelligence, Wisdom, and Charisma scores; and languages.

While you are a Ghost, you can only use abilities detailed in the Ghost’s stat block. In addition, you add your Proficiency Bonus to your attack rolls and the DC of your Ghost abilities.

Your GM secretly rolls 1d8 when you cast the spell. After a number of hours equal to the number rolled, the spell ends. The spell ends early if you are reduced to 0 Hit Points as a Ghost or you take the Magic action to end the spell. If the Material component used to cast this spell remains on your corpse, you return to life with a number of Hit Points equal to half your Hit Point maximum. If the Material component used to cast this spell is no longer on your corpse, you die.

If your body is destroyed or damaged beyond the capacity to survive while you are under the effects of this spell, its duration becomes permanent. You are now a Ghost until your body is targeted by an effect that returns the living to the dead such as Raise Dead or Resurrection .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'maelfas-quickened-class',
  'Maelfa’s Quickened Class',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '10 minutos',
  '9 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  '24 horas',
  false,
  false,
  'When you cast this spell, you give an abbreviated lecture on a topic of your choosing to 10 willing creatures of your choice within range. When you do so, choose one spell you know or have prepared, one skill you are proficient in, or one language you can speak, read, and write. Each chosen creature is temporarily imparted with a portion of your knowledge.

If you chose a spell, each creature prepares the spell, the spell is considered on the creature’s spell list, and it doesn’t count against the creature’s number of prepared spells. If you chose a skill, each targeted creature gains proficiency in that skill. If you chose a language, each targeted creature can speak, read, and write that language.

The creature loses the knowledge of the spell, proficiency, or language when this spell ends. If a creature is targeted by this spell while under the effect of a previous casting of the spell, the previous casting immediately ends.',
  'The duration of the spell increases with a spell slot level of 3 or 4 (3 days), 5 or 6 (10 days), 7 or 8 (30 days), or 9 (1 year).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'magic-mirror',
  'Magic Mirror',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação , que você executa quando you are targeted by a spell',
  'Pessoal',
  true,
  true,
  true,
  'a polished silver marble',
  'V, S, M (a polished silver marble)',
  'Instantânea',
  false,
  false,
  'A momentary bubble of iridescent energy shimmers in the air between you and a foe. The triggering spell is redirected to a creature of your choice you can see within 18 m. If the spell is level 5 or lower, you are no longer a target of the spell and the chosen creature is instead. If the spell is level 6 or higher, make an ability check using your spellcasting ability (DC 10 plus the spell’s level). On a successful check, you are no longer a target of the spell and the chosen creature is instead. On a failed check, you remain the target of the triggering spell.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'melting-curse',
  'Melting Curse',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '30 m',
  true,
  true,
  true,
  'a vial of quicksilver',
  'V, S, M (a vial of quicksilver)',
  '1 minuto',
  false,
  false,
  'You target a creature and a metal object held or worn by that creature you can see within range. The creature makes a Dexterity saving throw. On a failed save, the creature takes 5d8 Fire damage and the targeted object melts and oozes to the ground, where it returns to its normal shape and temperature. If the object is magical, the creature has Advantage on the saving throw.

If the creature tries to retrieve or otherwise touch the object for the duration, the object heats and melts, and the creature takes 5d8 Fire damage. The object returns to normal once the creature is no longer touching it or the spell ends.',
  'The damage increases by 1d8 for each spell slot level above 6.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'mirror-spell',
  'Mirror Spell',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação , que você executa quando you see a creature within 60 feet of you casting a spell',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'You attempt to copy and cast a spell of level 3 or lower that you can see being cast. You can only copy spells cast by creatures, and you can''t copy your own spell.

If the triggering spell is level 2 or lower, you automatically copy and cast the spell. If the spell is level 3 or higher, you must succeed on an ability check using your spellcasting ability (DC 10 plus the triggering spell''s level) to copy and cast the spell.

When casting a copied spell, you don''t expend a spell slot and you don''t need any components. Treat the spell as if you were its original caster, using your own spellcasting ability modifier and save DC, and casting it at the lowest level it can be cast.',
  'Treat the level of the spell slot used as the maximum level of spell you can copy and cast.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'mortality',
  'Mortality',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '36 m',
  true,
  true,
  true,
  'the skull of a humanoid encrusted in gems worth 200+ GP',
  'V, S, M (the skull of a humanoid encrusted in gems worth 200+ GP)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend five Hit Point Dice or the spell automatically fails. Roll the Hit Point Dice expended, then choose an Aberration, Celestial, Elemental, Fey, or Fiend within range and condemn it to a taste of mortality. The creature must succeed on a Charisma saving throw or its Hit Point maximum and current Hit Points are reduced by the amount rolled on the Hit Point Dice expended to cast the spell.

For the duration of the spell, a creature that fails the saving throw loses all damage Immunities and Resistances , its creature type changes to Humanoid, and it takes an additional 1d4 Necrotic damage each time it takes damage.

If a creature affected by this spell is reduced to 0 Hit Points, these changes become permanent and the creature dies. This final effect of the spell can only be reversed if the creature is restored to life and targeted by a Remove Curse spell or similar magic.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'neutralize-aura',
  'Neutralize Aura',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  '1 minuto',
  'Toque',
  true,
  true,
  true,
  'a sprig of sage',
  'V, S, M (a sprig of sage)',
  'Concentração, até 1 hora',
  true,
  false,
  'You touch a willing creature and neutralize its aura. Until the spell ends, the target can’t be perceived by Fey, Fiends, Celestials, and Undead.

The spell ends early immediately after the target makes an attack roll, deals damage, casts a spell, or moves within 1,5 m of one of the creature types.',
  'You can target one additional creature for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'overgrow',
  'Overgrow',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a single seed',
  'V, S, M (a single seed)',
  'Concentração, até 1 minuto',
  true,
  false,
  'When you cast this spell, choose a creature or an object within range that is Huge or smaller and not being worn or carried within range. Vibrant vines quickly grow around the target, pinning it into place and making it easier to traverse.

If the target is a creature, it must succeed on a Strength saving throw or have the Restrained condition until the spell ends. The creature can repeat the saving throw at the end of each of its turns, ending the Restrained condition on a success.

If the target is an object, it can’t be moved from its current location and creatures that climb the object don’t spend extra movement. A creature can make a Strength ( Athletics ) check against your spell save DC to wrest the object out of the vines so it can be moved. If the object is too heavy for the creature to move, this action fails.',
  'You can choose an additional target for each spell slot level above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'perfection',
  'Perfection',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  '18 m',
  true,
  false,
  false,
  NULL,
  'V',
  '1 minuto',
  false,
  false,
  'You speak a holy word and remake a creature you can see in the image of the Arch Seraphs. The Poisoned condition on the creature ends, curses on the target are suppressed for the spell’s duration, and it is restored to its Hit Point maximum. The creature’s ability scores less than 18 become 18. Depending on the word you use, you also bless the target based upon the Arch Seraph that you call upon:

Aphaelon: The target has Immunity to the Charmed condition. If the target fails a saving throw, it can take a Reaction to cause the save to be rerolled. It must use the new roll.

Empyreus: The target has Immunity to the Frightened condition, and the target deals an extra 4d6 Force damage to the first target it hits on each of its turns.

Miklas: The target has Immunity to Poison damage and the Poisoned condition, and it regains 4d6 Hit Points at the start of each of its turns.

Morael: The target gains 30 Temporary Hit Points . When an ally within 18 m of the target takes damage, the target can take a Reaction to take the damage instead.

Solyma: The target has Immunity to Thunder damage. When the target takes damage from a creature it can see, it can take a Reaction to deal Fire damage to that creature equal to the triggering damage.

Zabriel: The target gains Truesight with a range of 18 m. At the end of each of its turn, the target can award Heroic Inspiration to an ally that doesn’t have it.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'phoenix-flames',
  'Phoenix Flames',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  'You immolate yourself, consuming your body in a searing cloud of holy flames. You are reduced to 0 Hit Points and die, and burning radiance erupts from you in a 9 m Emanation . Each creature in the area must make a Constitution saving throw. On a failed save, the creature takes 30d6 Radiant damage and gains 1 Exhaustion level. On a successful save, a creature takes half as much damage only. If this damage reduces a creature to 0 Hit Points, it and everything nonmagical it is wearing and carrying are incinerated. The target can be revived only by a True Resurrection or a Wish spell.

After 10 minutes, you rise from the ashes where you originally cast the spell. You return to life as if you were targeted by a True Resurrection spell.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'power-word-maim',
  'Power Word Maim',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '18 m',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'You command the body of a creature to twist and warp. If the target has 125 Hit Points or fewer, it takes 8d10 Necrotic damage, and it has the Prone condition. Otherwise, its Speed is 0 until the start of your next turn. The target makes a Constitution saving throw at the end of each of its turns, ending the condition on a success.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'preserve',
  'Preserve',
  0,
  'Truque',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a sack containing a pinch of salt',
  'V, S, M (a sack containing a pinch of salt)',
  '12 horas',
  false,
  false,
  'Food and other perishable items weighing 5 pounds or less that you place in a sack don’t age or decay for the duration.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'primordial-power',
  'Primordial Power',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a handful of clay',
  'V, S, M (a handful of clay)',
  'Concentração, até 1 hora',
  true,
  false,
  'When you cast this spell, grant a creature in range a portion of the power of the elementals. For the duration, the creature can speak and understand Primordial and gains additional benefits based on the element you choose when you cast the spell:

Air. The target has Resistance to Lightning and Thunder damage. In addition, it has a Fly speed of 9 m.

Coldfire. The target has Resistance to Cold damage. In addition, it can use a Bonus Action to expend a Hit Point Die, regaining a number of Hit Points equal to the numbered rolled plus its Constitution modifier. When the target takes Fire damage, it can’t use this Bonus Action on its next turn.

Earth. The target has Advantage on saving throws against being moved or knocked Prone . In addition, it has Tremorsense with a range of 9 m.

Fire. The target has Resistance to Fire damage. In addition, when the target takes damage from a creature that is within 1,5 m of it, it can take a Reaction to make one melee attack against that creature, using a weapon or an Unarmed Strike .

Water. The target has Resistance to Acid damage. In addition, it can breathe underwater and has a Swim speed of 18 m.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'reanimate',
  'Reanimate',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a mélange of wilted daisies and other herbal powders worth 300+ GP, which this spell consumes',
  'V, S, M (a mélange of wilted daisies and other herbal powders worth 300+ GP, which this spell consumes)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend three Hit Point Dice or the spell automatically fails. You touch a creature that has died within the last 10 minutes and return it to life with 1 Hit Point. In addition, roll the Hit Point Dice expended to cast the spell, and the creature gains Temporary Hit Points equal to the roll.

At the start of each of the target’s turns, it loses 1 Temporary Hit Point granted by this spell. While the creature has Temporary Hit Points granted by this spell, it moves with unnatural vigor, gaining a +2 bonus to D20 Tests . Once it loses the Temporary Hit Points granted by this spell, the creature gains 1 Exhaustion level.

This spell can’t revive a creature that has died of old age, nor does it restore any missing body parts.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'red-rain',
  'Red Rain',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  '10 minutos',
  'Pessoal',
  true,
  true,
  true,
  'a sponge soaked in blood',
  'V, S, M (a sponge soaked in blood)',
  'Concentração, até 8 horas',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend eight Hit Point Dice or the spell automatically fails. Over the course of 1d6 times 5 minutes, the sky darkens and thick droplets of blood rain everywhere within 5 miles of you.

Each Beast and Plant creature in the area must succeed on a Wisdom saving throw or have the Frightened condition until it has spent 1 minute outside the area. Mundane plants exposed to the rain wither and die after 10 minutes.

For every 10 minutes that a creature of any type is directly exposed to the rain, that creature gains 1 Exhaustion level and takes 2d10 Necrotic damage. The creature''s Hit Point maximum decreases by an amount equal to the Necrotic damage dealt. This reduction lasts until the creature removes all levels of Exhaustion gained from this spell. While a creature has any Exhaustion levels from this spell, it automatically fails saving throws against removing the Poisoned condition.

When the spell ends, roll the Hit Point Dice expended to cast the spell. Beast and Plant creatures won’t return and plants won’t regrow in the area for a number of days equal to the roll’s total.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'ride-the-lightning',
  'Ride the Lightning',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a length of copper wire',
  'V, S, M (a length of copper wire)',
  'Instantânea',
  false,
  false,
  'You transform yourself into a bolt of lightning, creating a 1,5 m-wide Line between your current space and an unoccupied space within 18 m of you. Each creature in the Line makes a Dexterity saving throw, taking 4d6 Lightning damage on a failed save or half as much damage on a successful one. You then reappear in the chosen space.',
  'The damage increases by 1d6 for each spell slot level above 4. In addition, the maximum length of the line increases 3 m for each spell slot level above 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sanguine-fusillade',
  'Sanguine Fusillade',
  7,
  '7º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a needle dipped in your blood',
  'V, S, M (a needle dipped in your blood)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] You crystalize your foe’s blood into razor darts that burst forth to strike your enemies. As part of casting this spell, you must expend seven Hit Point Dice or the spell automatically fails. Roll the Hit Point Dice expended to cast the spell. Choose a creature that you can see within range. The target takes Piercing damage equal to the roll. When a creature takes this damage, seven crimson darts burst from it.

You can direct each dart to hit a creature within 18 m of the original target. The darts all strike simultaneously, and you can direct them to hit one creature or several, including the original target. For each dart, make a ranged spell attack against the chosen creature. On a hit, roll one Hit Point Die expended to cast the spell, and the creature takes Piercing damage equal to the number rolled.',
  'You can expend an additional Hit Point Die and create another dart for each spell slot level above 7.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sanguine-poppet',
  'Sanguine Poppet',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  '1 minuto',
  'Toque',
  true,
  true,
  true,
  'an object shaped like a creature worth 1+ CP',
  'V, S, M (an object shaped like a creature worth 1+ CP)',
  'Concentração, até 1 hora',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend three Hit Point Dice or the spell automatically fails. You smear the spell’s Material component with your blood. The object shudders and becomes a poppet under your control.

The poppet’s AC equals 10 plus your Proficiency Bonus and your spellcasting ability modifier, and it has 30 Hit Points. If your poppet is ever reduced to 0 Hit Points or it is more than 1 mile away, the spell ends immediately. As a Bonus Action, you can command your poppet to move 9 m, and you can see and hear through it until the start of your next turn.

As a Magic action, you can cause the poppet to detonate in an explosion of blood, ending this spell. Roll the Hit Point Dice expended to cast this spell. Each creature in a 9 m-radius Sphere centered on the poppet makes a Dexterity saving throw, taking Necrotic damage equal to the roll on a failed save or half as much damage on a successful one.',
  'You can expend an additional Hit Point Die for each spell slot level above 3. Additionally, the duration of this spell increases by 1 hour for each spell slot level above 3. That was the best puppet show ever! Until all the blood. Then it was better.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sanguine-shield',
  'Sanguine Shield',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend two Hit Point Dice or the spell automatically fails. You draw lifeforce from those injured around you to create a swirling shield of blood. You gain 5 Temporary Hit Points for each creature within 9 m of you that is below its Hit Point maximum (including you) to a maximum of 15 Temporary Hit Points. While you have Temporary Hit Points from this spell, you have Half Cover . When the spell ends, all Temporary Hit Points from it are lost.',
  'The maximum number of Temporary Hit Points you gain increases by 5 for each two spell slot levels above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'seal-spellcasting',
  'Seal Spellcasting',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'wax mixed with lead and a stamp',
  'V, S, M (wax mixed with lead and a stamp)',
  'Concentração, até 10 minutos',
  true,
  false,
  'When you cast this spell, choose a creature you can see within range. When the target casts a spell, it must make a Charisma saving throw. On a failed save, the creature expends a spell slot to cast the spell as normal but the spell has no effect. On a successful save, the creature casts the spell but takes 3d8 Force damage. After the creature makes a saving throw, the spell immediately ends.',
  'The damage increases by 1d8 for each spell slot above level 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'sense-lifeblood',
  'Sense Lifeblood',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação Bônus',
  'Pessoal',
  false,
  true,
  false,
  NULL,
  'S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend two Hit Point Dice or the spell automatically fails. The lifeblood flowing within creatures tells you its secrets. Creatures that have Immunity to the Exhaustion condition are immune to this spell. Until the spell ends, you can determine if creatures you can see are related biologically. In addition, you know if a creature’s Hit Points are at maximum, below maximum, at half, or below half.

Once on each of your turns when you hit a Bloodied creature with an attack roll using a weapon, Unarmed Strike , or spell, you can cause the target to take extra Necrotic. To determine this damage, roll the Hit Point Dice expended to cast the spell.',
  'Your Concentration can last longer with a spell slot of level 3-4 (up to 1 hour) or 5+ (up to 8 hours).',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'serpent-tongue',
  'Serpent Tongue',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  '1 minuto',
  false,
  false,
  'You transform your tongue into a poisonous serpent for the duration. As a Bonus Action, you can make a melee spell attack against a creature within 3 m of you. On a hit, the target takes 1d12 Piercing damage and has the Poisoned condition for the duration of the spell.',
  'The damage increases by 1d12 for every spell slot level above 3.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'shared-judgement',
  'Shared Judgement',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentração, até 1 minuto',
  true,
  false,
  'Once on each of your turns when you reduce an Undead to 0 Hit Points, you can deal 5d6 Radiant damage to a creature you can see within 18 m of you no action required.',
  'The damage increases by 1d6 for each spell slot level above 4.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'shroud-blood',
  'Shroud Blood',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'ilusao'),
  'Ação',
  '9 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. You can choose yourself or a willing creature within 9 m of yourself to have Advantage on Dexterity ( Stealth ) checks. When the target loses the Invisible condition, it can take a Reaction to gain the Invisible condition for a number of rounds equal to the number of Hit Point Dice expended to cast the spell. The target loses the Invisible condition immediately after it makes an attack roll, deals damage, or casts a spell.',
  'You can target an additional creature for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'somnolence',
  'Somnolence',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'sand mixed with the spellcaster’s blood',
  'V, S, M (sand mixed with the spellcaster’s blood)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Point Die or the spell automatically fails. Roll the Hit Point Die expended to cast the spell plus 2d12 and choose a creature within range. If the roll’s total is equal to or greater than the chosen creature’s current Hit Points, the creature falls into a magical slumber for 1 minute. If the roll’s total is equal to or greater than the chosen creature’s Hit Point maximum, the magical slumber lasts for 24 hours instead. The spell ends on a target if it takes damage or someone within 1,5 m of it takes an action to shake it out of the spell’s effect. A creature woken early from this spell gains 1 Exhaustion level.

Creatures that don’t sleep, such as elves, or that have Immunity to the Exhaustion condition automatically succeed on saves against this spell.',
  'You roll an additional 1d12 and can expend an additional two Hit Point Dice for every spell slot level above 1. The Long Sleep Adherents of the Prismatic Circle perform a variation of the Somnolence spell that takes 10 minutes and requires the sacrifice of a Humanoid. These adherents believe when the ritual is completed, it staves off the waking of Gormadraug for a day and night. Through the repetitive performance of this ritual, the Druids of the Prismatic Circle hope to ensure Gormadraug slumbers forever.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'spirit-swarm',
  'Spirit Swarm',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '36 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentration, 1 minuto',
  true,
  false,
  'You invite spirits to take their revenge upon a target. A creature you can see within range must make a Charisma saving throw. The target must have a Charisma of 3 or higher. On a failed save, the target takes 8d8 Psychic damage and has the Frightened condition until the spell ends. On a successful save, the creature takes half as much damage only.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'splattering-smite',
  'Splattering Smite',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Reação (which you take when you hit a creature with a Melee weapon)',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] Your strikes drink the splattered blood of your foes. As part of casting this spell, you must expend five Hit Dice or the spell automatically fails. Once on each of your turns when you hit a creature with an attack roll using a Melee weapon or Unarmed Strike , roll the Hit Point Dice expended to cast the spell and regain a number of Hit Points equal to the numbered rolled.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'steal-immortality',
  'Steal Immortality',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reação , que você executa quando a Celestial, Elemental, Fey, Fiend, or Undead within range that you can see is reduced to 0 Hit Points',
  '90 m',
  true,
  true,
  true,
  'the skull of a humanoid encrusted in gems worth 1,000+ GP, which the spell consumes',
  'V, S, M (the skull of a humanoid encrusted in gems worth 1,000+ GP, which the spell consumes)',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend nine Hit Point Dice or the spell automatically fails. Roll the Hit Point Dice expended to cast the spell and gain a number of Temporary Hit Points equal to twice the roll’s total. You gain the creature type of the spell’s target, in addition to your own type.

While the spell lasts, you have Immunity to the Poisoned condition; you no longer need to eat, drink, or breathe; you have Resistance to Bludgeoning, Piercing, and Slashing damage; and you gain a benefit based on your new creature type:

Celestial. You have Resistance to Radiant and Necrotic damage and have a Fly Speed of 18 m.

Elemental. You have Resistance to Acid, Cold, Fire, Lightning, and Thunder damage.

Fey. You can use a Bonus Action to have the Invisible condition until the start of your next turn, or teleport up to 18 m to an unoccupied space you can see.

Fiend. You have Resistance to Cold and Fire damage and have a Fly Speed of 18 m.

Undead. You have Immunity to Necrotic damage, and you have Immunity to the Charmed and Frightened conditions.

You have the creature type and benefits until you cast the spell again, or you are reduced to 0 Hit Points.

The creatures from other worlds present the greatest danger—and offer the most rewards.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'suffocate',
  'Suffocate',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '18 m',
  true,
  true,
  true,
  'a leather glove',
  'V, S, M (a leather glove)',
  'Concentração, até 1 minuto',
  true,
  false,
  'You create a pair of grasping hands made from invisible force. Make a ranged spell attack against a creature you can see within range. On a hit, the creature has the Restrained condition. While it has this condition, it can’t breathe.

A creature can hold its breath for a number of rounds equal to 1 plus its Constitution modifier (minimum of 30 seconds) before suffocation begins. When a creature runs out of breath, it gains 1 Exhaustion level at the end of each of its turns. When a creature can breathe again, it removes all levels of Exhaustion it gained from suffocating.

A creature Restrained by the hands can take an action to make a Strength ( Athletics ) check against your spell save DC. If it succeeds, it is no longer Restrained.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'summon-plant',
  'Summon Plant',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '27 m',
  true,
  true,
  true,
  'a ceramic pot filled with herbs and fertilizer worth at least 200 GP',
  'V, S, M (a ceramic pot filled with herbs and fertilizer worth at least 200 GP)',
  'Concentração, até 1 hora',
  true,
  false,
  'You call forth a plant spirit. It manifests in an unoccupied space you can see within range. This corporeal form uses the Plant Spirit stat block. When you cast the spell, choose a floral feature: Blooming, Oaken, or Thorny. The creature resembles an animated plant marked by the chosen floral feature, which determines one of the traits in its stat block. The creature disappears when it drops to 0 Hit Points or when the spell ends.

The creature is an ally to you and your allies. In combat, the creature shares your Initiative count, but it takes its turn immediately after yours. It obeys your verbal commands (no action required by you). If you don’t issue any, it takes the Dodge action and uses its move to avoid danger.',
  'Use the spell slot’s level for the spell’s level in the stat block. Medium (Large if Oaken) Plant, Neutral AC 11 + the spell’s level HP 20 (Blooming and Thorny Only) or 30 (Oaken Only) + 10 for each spell level above 2 Speed 9 m.; Climb 9 m. (Blooming and Thorny Only) Immunities Blinded , Deafened , Exhaustion, Stunned Senses Tremorsense 9 m. (Blind beyond this radius), Passive Perception 11 Languages Understands the languages you know Challenge None (XP 0; PB equals your Proficiency Bonus) Traits Sylvan Regeneration. The spirit regains 1 Hit Point at the start of its turn if it has at least 1 Hit Point and is in direct sunlight. Actions Multiattack. The plant makes a number of attacks equal to half this spell’s level (rounded down). Petal Burst (Blooming Only). The plant causes a burst of petals to fill the air within a 3 m Emanation . The area is Heavily Obscured for 1 minute. Slam. Melee Attack Roll: Bonus equals your spell attack modifier, reach 1,5 m. Hit: 1d8 + 3 + the spell’s level Bludgeoning or Piercing damage (Thorny Only). Reactions Oaken Shield (Oaken Only). When a creature within 1,5 m of the plant takes damage from an attack, the plant takes the damage instead. Prickly Protection (Thorny Only). When a creature within 1,5 m of the plant attacks it, the plant makes a Slam attack with Advantage against the creature.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'summon-sea-spirit',
  'Summon Sea Spirit',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '27 m',
  true,
  true,
  true,
  'a bejeweled statuette of a sea serpent worth at least 300 GP',
  'V, S, M (a bejeweled statuette of a sea serpent worth at least 300 GP)',
  'Concentração, até 1 hora',
  true,
  false,
  'You call forth an abyssal spirit. It manifests in an unoccupied space that you can see within range. This corporeal form uses the Sea Serpent stat block. When you cast the spell, choose an abhorrent feature: Enormous Mouth, Glowing Lantern, or Scaled Wings. The creature resembles a monstrous sea creature marked by the chosen abhorrent feature, which determines one of the traits in its stat block. The creature disappears when it drops to 0 Hit Points or when the spell ends.

The creature is an ally to you and your allies. In combat, the creature shares your Initiative count, but it takes its turn immediately after yours. It obeys your verbal commands (no action required by you). If you don’t issue any, it takes the Dodge action and uses its move to avoid danger.',
  'Use the spell slot’s level for the spell’s level in the stat block. Large Monstrosity, Neutral AC 11 + spell’s level HP 30 + 10 for each spell level above 3 Speed 9 m., Fly 12 m. (Scaled Wings only), Swim 18 m. Resistances Cold Immunities Prone Senses Darkvision 18 m., Passive Perception 10 Languages Understands the languages you know Challenge None (XP 0; PB equals your bonus) Traits Flyby (Scaled Wings only). The sea serpent doesn’t provoke Opportunity Attacks when it flies out of an enemy’s reach. Actions Multiattack. The sea serpent makes a number of attacks equal to half this spell’s level (rounded down). Allure (Glowing Lantern only). The sea serpent causes a lantern hanging from one of its fins to glow eerily. Wisdom Saving Throw: DC equals your spell save DC, each creature in a 9 m Emanation originating from the sea serpent. Failure: The target is Charmed by the sea serpent until the start of its next turn. Creatures have Advantage on the saving throw if the sea serpent has dealt damage to them already this turn, and the Charmed condition ends immediately if the sea serpent deals damage to a creature Charmed by this ability. Inhale (Enormous Mouth only). Strength Saving Throw: DC equals your spell save DC, each creature in a 4,5 m Cone . Failure: 1d6 + the spell’s level Psychic damage and the creature is pulled 1,5 m straight toward it or, if the creature is already within 1,5 m of the sea serpent, it takes an additional 2d6 Piercing damage. Success: Half damage. Bite. Melee Attack Roll: Bonus equals your spell attack modifier, reach 1,5 m. Hit: 1d6 + 3 + the spell’s level Piercing damage and the creature has the Grappled condition (escape DC equals your spell save DC). The Grappled condition ends if the sea serpent bites a different creature. Thrash. Melee Attack Roll: Bonus equals your spell attack modifier, reach 3 m. Hit: 1d10 + 3 + the spell’s level Bludgeoning damage and the target is pushed 1,5 m away from the sea serpent. The damage to that vessel could not have been done by a creature of this world.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'supernal-smite',
  'Supernal Smite',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  'Your strike cause ambient magic surrounded a creature to collapse and detonate. The target hit by the strike takes an extra 4d6 Force damage from the attack. If the creature is concentrating on a spell, that Concentration is broken.

In addition, each ongoing spell of level 3 or lower on the target ends. For each ongoing spell of level 4 or higher on the target, make an ability check using your spellcasting ability (DC 10 plus that spell’s level). On a successful check, the spell ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'theft-of-vitae',
  'Theft of Vitae',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Reação , que você executa quando a creature you can see within 30 feet of you takes damage',
  'Pessoal',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend two Hit Dice or the spell automatically fails.

Roll the Hit Point Dice expended to cast the spell. The triggering creature takes Necrotic damage equal to the result. You gain Temporary Hit Points equal to the result plus the triggering damage, to a maximum of 15 Temporary Hit Points.',
  'The maximum number of Temporary Hit Points you can gain from casting increases by 10 for each slot level above 2.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'thorn-armor',
  'Thorn Armor',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'abjuracao'),
  'Ação',
  'Toque',
  true,
  true,
  true,
  'a rose',
  'V, S, M (a rose)',
  '10 minutos',
  false,
  false,
  'When you cast this spell, a flexible exoskeleton covered in thorns appears around a willing target within range. The target gains 3d6 Temporary Hit Points . If a creature hits the target with a melee attack roll before the spell ends, that creature takes Piercing damage equal to the number of Temporary Hit Points lost as a result of the attack. This spell ends early if the target has no remaining Temporary Hit Points granted by this spell.',
  'The target gains an additional 2d6 Temporary Hit Points for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'tremor',
  'Tremor',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'small bell',
  'V, S, M (small bell)',
  'Concentração, até 1 minuto',
  true,
  false,
  'The ground around you in a 4,5 m Emanation begins to shake violently. You are unaffected by the tremors. The ground is considered Difficult Terrain and whenever the Emanation enters a creature’s space, a creature enters the Emanation, or the creature ends its turn there, the creature makes a Dexterity saving throw. On a failed save, the creature takes 1d6 Bludgeoning damage and has the Prone condition. A creature makes this save only once per turn.',
  'The damage increases by 1d6 for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'undead-enthrallment',
  'Undead Enthrallment',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 hora',
  '3 m',
  true,
  true,
  true,
  'a clay pot filled with brackish water, another clay pot filled with grave dirt, and a black onyx stone worth 500 + GP for each corpse',
  'V, S, M (a clay pot filled with brackish water, another clay pot filled with grave dirt, and a black onyx stone worth 500 + GP for each corpse)',
  'Instantânea',
  false,
  false,
  'Choose a corpse, or a number or corpses, within range that are equivalent to the size of the creature you are animating (the GM determines how many corpses are required). Your spell imbues the target with a foul mimicry of life, raising it as an Undead creature. You can choose for the target to become an Undead creature of CR 3 or lower (the GM has the creature’s game statistics).

On each of your turns, you can use a Bonus Action to mentally command any creature you made with this spell if the creature is within 18 m of you. (If you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one.) You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature takes the Dodge action. Once given an order, the creature continues to follow it until its task is complete.

The creature is under your control for 24 hours, after which it stops obeying any command you’ve given it. To maintain control of the creature for another 24 hours, you must cast this spell on the creature again before the current 24-hour period ends. This use of the spell reasserts your control over 1 creature you have animated with this spell, rather than animating a new one. Any creature you have maintained with this spell for 30 days remains permanently under your control. You may only control a maximum of four creatures with this spell.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'vampiric-claws',
  'Vampiric Claws',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Concentração, até 1 minuto',
  true,
  false,
  'You sprout wicked claws. When you use your Unarmed Strike to deal damage with the new growth, it deals 1d6 Slashing damage instead of dealing the normal damage for your Unarmed Strike, and you use your spellcasting ability modifier for the attack and damage rolls rather than using Strength.

While the spell lasts, each time you deal damage with an Unarmed Strike, you gain a number of Temporary Hit Points equal to your spellcasting ability modifier. Temporary Hit Points from the spell are lost when the spell ends.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'vibrating-humors',
  'Vibrating Humors',
  1,
  '1º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocacao'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a tuning fork',
  'V, S, M (a tuning fork)',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Sangromancia] As part of casting this spell, you must expend one Hit Die or the spell automatically fails. A creature you can see within 9 m of you must make a Constitution saving throw. On a failed save, the target takes Thunder damage and has Disadvantage on Dexterity ( Stealth ) checks from its blood vibrating loudly. To determine this damage, roll the Hit Point Die expended to cast this spell.

The target repeats the save at the end of each of turns, ending the spell on a success.',
  'You increase the damage by expending an additional Hit Die for each spell slot level above 1.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'viscous-sheath',
  'Viscous Sheath',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  NULL,
  'V, S, M, (a bloody funerary shroud)',
  '10 minutos',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend seven Hit Dice or the spell automatically fails. Your body is wrapped in clotted blood. Whenever a creature within 1,5 m of you hits you with a melee attack roll, the attacker takes Necrotic damage. To determine this damage, roll the Hit Point Dice expended to cast the spell plus your spellcasting ability modifier.

If a creature hits you with a Melee weapon, you can take a Reaction to have clots form around the weapon, entrapping it. The attacker must succeed on a Strength saving throw or the weapon sticks to you. If the attacker doesn’t release the weapon, the creature has the Grappled condition while the weapon is stuck. While stuck, the weapon can’t be used. The target can take an action to make a Strength ( Athletics ) check against your spell save DC, freeing the weapon on a success. The creature can also release the weapon to end the Grappled condition.

You can trap a number of weapons equal to the number of Hit Dice expended to cast the spell. When the spell ends, the weapons are released.',
  'You can trap an additional weapon for each spell slot level above 4. He looked like a creature of the night. But he wasn’t, I reckon.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wall-of-gloom',
  'Wall of Gloom',
  8,
  '8º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação',
  '36 m',
  true,
  true,
  true,
  'a vial of tears',
  'V, S, M (a vial of tears)',
  '10 minutos',
  false,
  false,
  'You create a wall of swirling gray energy, formed of the psychic pain of loss. The wall appears within range on a solid surface and lasts for the duration. You choose to make the wall up to 18 m long, 3 m high, and 1,5 m thick or a ringed wall that has a 6 m diameter and is up to 6 m high and 1,5 m thick. The wall blocks line of sight.

The wall sheds Dim Light out to a range of 30 m. When you cast the spell, you and creatures you designate can pass through and remain near the wall without harm. If a creature moves within 6 m of it or starts its turn there, the creature must succeed on a Charisma saving throw or have the Incapacitated condition until the start of its next turn.

A creature can move through the wall, though the attempt is emotionally draining. The first time a creature enters the wall on a turn or ends its turn there, it must succeed on a Charisma saving throw or gain 1 Exhaustion level.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'weave-numen',
  'Weave Numen',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  'Ação',
  'Pessoal',
  true,
  true,
  true,
  'a mithral sewing needle worth 300 GP+, which the spell consumes',
  'V, S, M (a mithral sewing needle worth 300 GP+, which the spell consumes)',
  'Concentração, até 10 minutos',
  true,
  false,
  'You can sense the presence of magic within 36 m of yourself. You see a faint aura around any visible creature or object within that range that bears magic, and you learn its school of magic, if any.

In addition, you gain thirteen threads. You can spend these threads to gain benefits as described below, with no action required unless stated:

You lose all remaining threads when this spell ends. If you spend all threads granted by the spell, the spell ends.',
  'You gain an additional two threads per spell slot level above 6.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wilting-smite',
  'Wilting Smite',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'transmutacao'),
  'Ação Bônus',
  'Pessoal',
  true,
  false,
  false,
  NULL,
  'V',
  'Instantânea',
  false,
  false,
  '[Sangromancia] As part of casting this spell, you must expend two Hit Point Dice or the spell automatically fails. The creature loses all Resistances to damage until the start of your next turn. The target hit by the strike takes extra Necrotic damage from the attack. To determine this damage, roll the Hit Point Dice expended to cast the spell.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wipe-face',
  'Wipe Face',
  9,
  '9º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '18 m',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 10 minutos',
  true,
  false,
  'You curse a creature that you can see within range. The target’s face is replaced with completely smooth skin, sealing the creature’s eyes, nose, and mouth. The creature has the Blinded and Incapacitated conditions and begins suffocating.

At the end of each of its turns, the target can attempt a Constitution saving throw to end the spell. Dealing at least 15 Slashing damage to the target opens an airway allowing it to breathe, but the curse seals the opening at the start of your next turn.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'wrack',
  'Wrack',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  'Ação',
  '9 m',
  true,
  true,
  true,
  'a frayed piece of cord',
  'V, S, M (a frayed piece of cord)',
  'Concentração, até 1 minuto',
  true,
  false,
  'Choose a creature that you can see within range. The target must succeed on a Constitution saving throw or be afflicted with excruciating muscle spasms for the duration. On a failed save, the target’s Speed is halved and it has Disadvantage on attack rolls. The target repeats the save at the end of each of its turns, ending the spell on a success.

The screams were like those of a banshee, but it was a human making them. Now a dead human.

Within Etharis, there are long-lasting spells empowered by a rare substance called Shadowsteel. Shadowsteel channels dark emotions, and spells cast with the substance grow in power as the targets languish under their spiteful effects.

While Shadowsteel curses aren’t restricted by alignment, casting a Shadowsteel curse is considered evil. A Shadowsteel curse is felt by any Celestial or Fiend within 1 mile of its casting. This taint remains with the caster for as long as the target remains cursed.

To cast a Shadowsteel curse requires three facets:

The caster can increase proficiency with these curses by taking the Shadowsteel Master feat.

When casting a Shadowsteel curse, the spellcaster can use special components to enhance the curse. These components are listed in the curse’s description. See “ Saving Throw Modifications ,” for more information.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-conceited-obsession',
  'Curse of Conceited Obsession',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a thread from the bed or clothes of your target, a handful of teeth, and a gilded mirror worth 1,000+ GP, all of which the spell consumes',
  'V, S, M (a thread from the bed or clothes of your target, a handful of teeth, and a gilded mirror worth 1,000+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with an obsessive self-infatuation. The target must make a Charisma saving throw.

Successful Saving Throw. On a successful save, the target takes 4d6 Psychic damage and is aware it was targeted by a curse. Additionally, for 1 minute, the target takes 1d6 Psychic damage at the start of each of its turns.

Initial Effect. On a failed save, the target takes 8d10 Psychic damage and is cursed.

Triggering Event. The next time the cursed creature looks into a mirror or reflective surface, the surface cracks or become distorted in some way, and the curse advances to Stage 1.

Stage 1. The cursed creature is compelled to stop and admire itself whenever it sees its reflection. It constantly fusses over its appearance.

Stage 2. The cursed creature becomes obsessed with looking for its reflection wherever it goes, including in the eyes of its foes. Attacks against the cursed creature have Advantage .

Stage 3. The cursed creature is driven to find or build a location where it can see its own reflection from many angles. The cursed creature is compelled to remain in this location and admire itself. Additionally, the cursed creature has Disadvantage on attack rolls from its obsession with its own appearance.

Culmination. The cursed creature twists into a deformed figure and becomes a Weeping Willow .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-crushing-sensation',
  'Curse of Crushing Sensation',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a drop of the target’s blood, a shred of silk material, and a horn worth 1,000+ GP, all of which the spell consumes',
  'V, S, M (a drop of the target’s blood, a shred of silk material, and a horn worth 1,000+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with painful hypersensitivity to physical sensations. The target must make a Constitution saving throw.

Successful Saving Throw. On a successful save, the target takes 4d6 Thunder damage and is aware it was targeted by a curse. For 1 minute, the target takes 1d6 Thunder damage at the start of each of its turns.

Initial Effect. On a failed save, the target takes 8d10 Thunder damage and is cursed.

Triggering Event. The next time the target hears a loud noise, it gets a crippling headache, and the curse advances to Stage 1.

Stage 1. The cursed creature avoids Bright Light , loud noises, extreme temperatures, and doesn’t like to be touched.

Stage 2. The cursed creature can’t stand the feeling of rough or heavy clothing against its skin. It can’t wear armor. It has Vulnerability to Thunder damage from its hypersensitivity. Additionally, it has Disadvantage on attack rolls if it or its target is in an area of Bright Light.

Stage 3. Even mild sensory input becomes intolerable to the cursed creature. It is driven to find a dark and quiet lair, such as a deep cave or dungeon. The cursed creature can’t willingly leave this lair and has Vulnerability to all damage except for Psychic damage while outside its lair.

Culmination. The cursed creature twists into a deformed figure and becomes a Sightless Agony .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-damned-aging',
  'Curse of Damned Aging',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a childhood possession of the target, a pint of blood, and a watch worth 600+ GP, all of which the spell consumes',
  'V, S, M (a childhood possession of the target, a pint of blood, and a watch worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with horrific aging. The target must make a Strength saving throw.

Successful Saving Throw. On a successful save, the target takes 2d10 Necrotic damage and is aware it was targeted by a curse. For 1 minute, the target has Vulnerability to Bludgeoning, Piercing, or Slashing damage (you choose when you cast the spell).

Initial Effect. On a failed save, the target takes 6d10 Necrotic damage and is cursed.

Triggering Event. The next time the target finishes a Long Rest, it finds multiple wrinkles, grey hairs, or spots it didn’t previously have, and the curse advances to Stage 1.

Stage 1. The cursed creature is compelled to rest when the occasion permits it, becoming lethargic and lazy.

Stage 2. The cursed creature becomes feeble. After finishing a Short Rest, the creature can only use 25 percent of its Hit Point Dice, rounded up, to regain Hit Points.

Stage 3. The cursed creature starts to age rapidly, becoming decrepit. The cursed creature has Disadvantage on Strength, Dexterity, and Constitution saving throws.

Culmination. The cursed creature twists into a deformed figure and becomes a Body Snatcher .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-fastidious-pride',
  'Curse of Fastidious Pride',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a shred of the target’s clothing, an uncrushed dead spider, and a sewing needle worth 600+ GP, all of which the spell consumes',
  'V, S, M (a shred of the target’s clothing, an uncrushed dead spider, and a sewing needle worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with narcissistic hubris. The target must make an Intelligence saving throw.

Successful Saving Throw. On a successful save, the target takes 2d10 Psychic damage and is aware it was targeted by a curse.

Initial Effect. On a failed save, the target takes 4d10 Psychic damage, has the Blinded condition for 1 minute, and is cursed.

Triggering Event. The next time the target hears its name spoken, the speaker sounds derisive regardless of its actual tone, and the curse advances to Stage 1.

Stage 1. The cursed creature hears veiled insults everywhere, believing everyone is jealous of its brilliance and talent.

Stage 2. The cursed creature feels restless unless it is actively working to accomplish a goal. The cursed creature gains no benefit from its Short Rests .

Stage 3. The cursed creature believes everyone is involved in a conspiracy to bring about its downfall. Whenever it fails a D20 Test , it has Disadvantage on the next D20 Test it makes.

Culmination. The cursed creature twists into a deformed figure and becomes a Mind Siphon .

GM Tips

If a player’s character turns into a monster after the Culmination of a curse, consider letting the player use the monster against the character’s former companions. This ensures everyone gets to participate in what can be a memorable event.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-foul-blight',
  'Curse of Foul Blight',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'necromancia'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a shred of the target’s hair or flesh, a chunk of rotten meat, and a jewelry box worth 600+ GP, all of which the spell consumes',
  'V, S, M (a shred of the target’s hair or flesh, a chunk of rotten meat, and a jewelry box worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with a putrefying and stinking pox. The target must make a Charisma saving throw.

Successful Saving Throw. On a successful save, the target takes 3d10 Necrotic damage and is aware it was targeted by a curse. Additionally, it can’t gain Temporary Hit Points or regain Hit Points for 1 minute.

Initial Effect. On a failed save, the target takes 6d10 Necrotic damage and is cursed.

Triggering Event. The next time the target searches for its garments or equipment, it finds an infestation of insects, and the curse advances to Stage 1.

Stage 1. The cursed creature is afflicted with a minor cough. Whenever it speaks more than a few words at a time, it breaks into a fit of coughing. This does not affect spellcasting.

Stage 2. The smell of putrescence lingers in the air around the cursed creature. Food and drink quickly spoil, jewelry tarnishes, and wood rots within 3 m of the cursed creature. Additionally, the cursed creature has Disadvantage on Charisma ability checks and saving throws, and it can’t maintain Concentration .

Stage 3. The cursed creature’s skin becomes riddled with pockmarks, pustules, and lesions. Insects flock to the cursed creature, infesting its clothes. The cursed creature can’t regain Hit Points except by spending Hit Point Dice after finishing a Short Rest.

Culmination. The cursed creature twists into a deformed figure and becomes a Plague Carrion .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-ill-fated-fortune',
  'Curse of Ill-Fated Fortune',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'adivinhacao'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a discarded piece of the target’s equipment, a splinter of bone, and a collection of dice worth 800+ GP, all of which the spell consumes',
  'V, S, M (a discarded piece of the target’s equipment, a splinter of bone, and a collection of dice worth 800+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with lethal bad luck. The target must make a Dexterity saving throw.

Successful Saving Throw. On a successful save, the target takes 3d10 Thunder damage and is aware it was targeted by a curse. Additionally, the creature has Disadvantage on the first D20 Test it makes in the next 1 minute.

Initial Effect. On a failed save, the creature takes 7d10 Thunder damage and is cursed.

Triggering Event. The next time the target walks through a doorway, the target stubs its toe or bashes its head, and the curse advances to Stage 1.

Stage 1. The cursed creature falls victim to minor inconveniences and bad luck. Shops it wishes to visit close just as it arrives, and its equipment breaks at inconvenient moments.

Stage 2. The cursed creature becomes a beacon of bad luck as otherwise harmless setbacks become increasingly dangerous. Objects constantly seem to be placed in the creature’s way. Additionally, the cursed creature has Disadvantage on Dexterity ability checks and saving throws.

Stage 3. The cursed creature becomes dangerously prone to accidents, as even the simplest tasks have unforeseen life-threatening consequences. The cursed creature has Disadvantage on Initiative checks, its Speed is reduced to 3 m, and it has the Prone condition if it misses an attack roll.

Culmination. The cursed creature twists into a deformed figure and becomes a Herald of Calamity .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-insatiable-greed',
  'Curse of Insatiable Greed',
  5,
  '5º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a coin that the target has previously possessed, the tail of a rat, and a golden crown of thorns worth 800+ GP, all of which the spell consumes',
  'V, S, M (a coin that the target has previously possessed, the tail of a rat, and a golden crown of thorns worth 800+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with a bitter and self-destructive greed. The target must make a Wisdom saving throw.

Successful Saving Throw. On a successful save, the target takes 4d10 Cold damage and is aware it was targeted by a curse.

Initial Effect. On a failed save, the target takes 6d10 Cold damage, and its Speed is reduced to 0 for 1 minute. At the end of each turns, the target''s Speed increases by 1,5 m, until it reaches its maximum Speed.

Triggering Event. The next time the target finishes a Short or Long Rest, it notices it has lost a valued item, and the curse advances to Stage 1.

Stage 1. The cursed creature becomes compelled to steal trinkets.

Stage 2. The cursed creature finds a secret place to start stashing its stolen trinkets, and it becomes anxious about leaving the location for extended periods of time. The creature has Disadvantage on Wisdom ability checks and saving throws.

Stage 3. The cursed creature is driven to transform its hoard of trinkets into a labyrinth of possessions and treasure. The cursed creature desires to remain in this lair. The creature can’t take Reactions .

Culmination. The cursed creature twists into a deformed figure and becomes a Verminous Abomination .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-lost-sentiment',
  'Curse of Lost Sentiment',
  4,
  '4º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a lock of hair from someone the target loves, an animal’s heart, and an idol worth 600+ GP, all of which the spell consumes',
  'V, S, M (a lock of hair from someone the target loves, an animal’s heart, and an idol worth 600+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with the loss of memories and horrific madness. The target must make an Intelligence saving throw.

Successful Saving Throw. On a successful save, the target takes 3d10 Force damage, has the Incapacitated condition until the end of its next turn, and is unaware it was targeted by a curse.

Initial Effect. On a failed save, the target takes 6d10 Force damage, has the Stunned condition until the end of its next turn, and is cursed.

Triggering Event. The next time the target finishes a Long Rest, it suffers nightmarish visions of being abandoned or left alone, and the curse advances to Stage 1.

Stage 1. The cursed creature begins forgetting events that have occurred within the past few days and the names of acquaintances.

Stage 2. The cursed creature forgets all but its closest companions, and it has delusions of hidden threats and scheming rivals. Additionally, the cursed creature has Disadvantage on Intelligence ability checks and saving throws.

Stage 3. The cursed creature forgets its closest companions, its own identity, and its goals. The curse fabricates delusions of a great conspiracy that only the cursed creature can prevent. The cursed creature is compelled to take any action it believes necessary to uncover this conspiracy. The creature can’t take Bonus Actions.

Culmination. The cursed creature twists into a deformed figure and becomes a Dream Whisperer .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-ravenous-hunger',
  'Curse of Ravenous Hunger',
  3,
  '3º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'a morsel of food that belonged to the target, a sun-dried slug, and a dining plate worth 400+ GP, all of which the spell consumes',
  'V, S, M (a morsel of food that belonged to the target, a sun-dried slug, and a dining plate worth 400+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with painful and unending starvation. The target must make a Constitution saving throw.

Successful Saving Throw. On a successful save, the target takes 2d10 Poison damage, has the Poisoned condition until the end of its next turn, and is aware it was targeted by a curse.

Initial Effect. On a failed save, the target takes 4d10 Poison damage, has the Poisoned condition for 1 minute, and is cursed.

Triggering Event. The next time it eats a meal, the cursed creature bites its tongue and its mouth fills with blood, and the curse advances to Stage 1.

Stage 1. The cursed creature is gripped with an insatiable appetite.

Stage 2. The cursed creature becomes compelled to eat inappropriate items such as coins, flowers, glass, and dirt. Additionally, the cursed creature has Disadvantage on Constitution saving throws, and its Hit Point maximum decreases by an amount equal to its character level (or Hit Dice if it has no character level).

Stage 3. The cursed creature becomes ravenous and is compelled to consume the flesh of Humanoids. No other food satiates it. The creature can’t have Advantage on D20 Tests .

Culmination. The cursed creature twists into a deformed figure and becomes a Bloated Gastromorph .',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
  'curse-of-uncontrollable-wrath',
  'Curse of Uncontrollable Wrath',
  6,
  '6º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'encantamento'),
  '1 hora',
  'Especial',
  true,
  true,
  true,
  'blood or other fluid of the target, a severed hand, and a serrated knife worth 1,000+ GP, all of which the spell consumes',
  'V, S, M (blood or other fluid of the target, a severed hand, and a serrated knife worth 1,000+ GP, all of which the spell consumes)',
  'Until cured',
  false,
  false,
  'This spell curses a creature with an uncontrollable temper and a lust for violence. The target must make a Wisdom saving throw.

Successful Saving Throw. On a successful save, the target takes 4d10 Psychic damage and is aware it was targeted by a curse. Additionally, for 1 minute, the target has Disadvantage on attacks made using Reactions .

Initial Effect. On a failed save, the target takes 8d10 Psychic damage and is cursed.

Triggering Event. The next time the cursed creature attacks with a weapon or casts a spell using a Spellcasting Focus, an old wound reopens, and the curse advances to Stage 1.

Stage 1. The cursed creature becomes easily agitated and aggressive.

Stage 2. The cursed creature becomes obsessed with violence. The thrill of solo battle intoxicates it, and its demeanor toward its allies sours as the curse grows. The cursed creature gains no benefit from its Short Rests .

Stage 3. The cursed creature is driven to insatiable bloodlust, unable to rest while there are enemies to slaughter. The cursed creature gains no benefit from its Long Rests .

Culmination. The cursed creature twists into a deformed figure and becomes an Avatar of Slaughter .

//',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-7-spells-curses')
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
