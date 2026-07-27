-- Seed Gunslinger class features + maneuvers
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  1,
  'Fighting Style',
  'You gain a Fighting Style feat of your choice. If you choose a feat, such as Great Weapon Fighting, that requires you to hold a Melee weapon in one or two hands, you can use that feat with Ranged weapons.

Whenever you gain a Gunslinger level, you can replace the feat you chose with a different Fighting Style feat.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  1,
  'Quick Draw',
  'You’re adept at drawing and firing before others have time to react, granting you the following benefits.

Initiative. You have Advantage on Initiative rolls.

Double Draw. You can draw or stow two weapons that lack the Two-Handed property when you would normally be able to draw or stow only one.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  1,
  'Weapon Mastery',
  'Your training with weapons allows you to use the mastery properties of two kinds of Simple or Martial Ranged weapons of your choice. Whenever you finish a Long Rest, you can practice weapon drills and change one of those weapon choices.

When you reach certain Gunslinger levels, you gain the ability to use the mastery properties of more kinds of weapons, as shown in the Weapon Mastery column of the Gunslinger Features table.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Critical Shot',
  'Your attack rolls with Ranged weapons can score a Critical Hit on a roll of 19 or 20 on the d20.

At Gunslinger level 9, your attack rolls with Ranged weapons score a Critical Hit on a roll of 18–20. At Gunslinger level 17, they score a Critical Hit on a roll of 17–20.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Risk',
  'You can perform incredible feats of daring fueled by special dice called Risk Dice.

Risk Dice. You have four Risk Dice, which are d8s. A Risk Die is expended when you use it. You regain all expended Risk Dice when you finish a Short or Long Rest. Your Risk Die changes and more Risk Dice become available as shown on the Risk Dice column of the Gunslinger Features table.

Maneuvers. You can expend Risk Dice to perform maneuvers. Your maneuver options are detailed later in the class description.

Saving Throws. If a maneuver requires a saving throw, the DC equals 8 plus your Dexterity modifier and Proficiency Bonus.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  3,
  'Gunslinger Subclass',
  'You gain a Gunslinger subclass of your choice. A subclass is a specialization that grants you features at certain Gunslinger levels. For the rest of your career, you gain each of your subclass’s features that are of your Gunslinger level or lower.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  4,
  'Ability Score Improvement',
  'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify. You gain this feature again at Gunslinger levels 8, 12, and 16.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  5,
  'Extra Attack',
  'You can attack twice instead of once whenever you take the Attack action on your turn.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  5,
  'Gut Shot',
  'Whenever you score a Critical Hit against a Large or smaller creature with a ranged attack using a weapon, the projectile lodges itself in the target. For 1 minute or until the target replaces one of its attacks with dislodging the projectile, its Speed is halved and it has Disadvantage on attack rolls.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  7,
  'Evasion',
  'When you’re subjected to an effect that allows you to make a Dexterity saving throw to take only half damage, you instead take no damage if you succeed on the saving throw and only half damage if you fail.

You don’t benefit from this feature if you have the Incapacitated condition.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  11,
  'Overkill',
  'When you deal damage with a Ranged weapon that doesn’t add your ability modifier to the roll, you add your ability modifier nonetheless. If you already add your modifier to the damage roll, the target takes an extra 1d8 damage of the weapon’s type.

Note that weapons that have the Firearm property don’t add your ability modifier to damage rolls.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  13,
  'Cheat Death',
  'When you are reduced to 0 Hit Points and not killed outright, you can drop to 1 Hit Point instead, and you regain a number of Hit Points equal to your Gunslinger level.

Once you use this feature, you can’t use it again until you finish a Short or Long Rest.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  15,
  'Dire Gambit',
  'Whenever you roll Initiative or score a Critical Hit, you regain one expended Risk Die.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  18,
  'Deft Maneuver',
  'You gain a special additional Bonus Action that you can take once on each of your turns. You can take this special Bonus Action only to use a maneuver.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  19,
  'Epic Boon',
  'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Irresistible Offense is recommended.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  20,
  'Headshot',
  'When you score a Critical Hit against a creature using a Ranged weapon, you can choose for it to be a Headshot. If the creature has less than 100 Hit Points, it dies. Otherwise, it takes an extra 10d10 damage of the weapon’s type.

Once you use this feature, you can’t use it again until you finish a Short or Long Rest. You can also restore your use of it by expending three Risk Dice (no action required).'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Maneuver: Bite the Bullet',
  'As a Bonus Action, you can expend one Risk Die to gain Temporary Hit Points equal to the number rolled on the die plus your Gunslinger level.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Maneuver: Blindfire',
  'You can take a Bonus Action and expend one Risk Die to gain Blindsight with a range of 30 feet until the end of the current turn.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Maneuver: Dodge Roll',
  'You can expend one Risk Die as a Bonus Action to move up to 15 feet and reload any Ranged weapon you are holding. This movement doesn’t provoke Opportunity Attacks and is unaffected by Difficult Terrain.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Maneuver: Grazing Shot',
  'When you miss with a ranged attack roll using a weapon, you can expend one Risk Die (no action required) to deal damage to that creature equal to a roll of the die plus your Dexterity modifier (minimum of 1). This damage is the same type dealt by the weapon, and the damage can be increased only by increasing the ability modifier. You can only use this maneuver once per turn.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Maneuver: Maverick Spirit',
  'When you fail an Intelligence, Wisdom, or Charisma ability check or saving throw, you can expend one Risk Die to add it to the roll, potentially turning it into a success. You can only use this maneuver once per turn.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  2,
  'Maneuver: Skin of Your Teeth',
  'When a creature you can see hits you with an attack roll, you can take a Reaction and expend one Risk Die to dodge out of harm’s way. Roll the die and add the number rolled to your AC against this attack, potentially causing it to miss.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET description = EXCLUDED.description;
