-- Seed Valda subclass features
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  3,
  'Unarguable Wizardry',
  'Your unquestionable legitimacy (and immense pectoral muscles) give you Advantage on Charisma (Intimidation) checks made to convince others that you are, in fact, a wizard.

Additionally, if someone questions your legitimate magical prowess, you can take a Reaction to enter your Rage until the end of your next turn. This Rage can’t be extended and doesn’t expend a use of your Rage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  3,
  '“Cantrips”',
  'You can call upon your “magic” to cast “Cantrips” in combat. Once on each of your turns when you hit a target with a Strength-based attack, you can use one of the following “Cantrips” of your choice.

Mage Hand. You can push the target up to 5 feet straight away from yourself if it is Large size or smaller. While your Rage is active, you can push the target up to 10 feet instead.

Shocking Grasp. The force of your strike is quite shocking. The target can’t make Opportunity Attacks until the end of the current turn. While your Rage is active, it can’t make Opportunity Attacks until the start of your next turn.

True Strike. You really, truly strike, dealing an extra 1d6 damage to the target. The damage has the same type as the weapon or Unarmed Strike used for the attack. While your Rage is active, you add half your Barbarian level (round down) to the extra damage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  6,
  '“Spells”',
  'Your “magic” is powerful enough to cast every “spell” that exists (and no one can prove otherwise without broken ribs). However, you only prepared the following “spells” today. While your Rage is active, you can use each of the following “Spells” once. When you do so, you can’t use that “Spell” again until you finish a Long Rest.

Burning Hands. Your backhand slap is legendary. As an action, you can make an Unarmed Strike against each creature within your reach. On a hit, this strike deals Bludgeoning damage equal to 1d8 plus your Strength modifier and the target has Disadvantage on the next attack it makes before the start of your next turn.

Magic Missile. As an action, you can make three ranged attacks using Darts, Daggers, or other weapons with the Thrown property that use Strength for the attack and damage rolls. Because Magic Missile never misses, you have Advantage on these attack rolls.

Shield. When you are hit by an attack roll, you can take a Reaction to quickly don a Shield to defend yourself. You gain the Shield’s AC bonus against the triggering attack, potentially causing it to miss. If the attack hits, the damage dealt to you is reduced by an amount equal to your Barbarian level.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  10,
  'Magic Resistance',
  'You’re such an amazing wizard that other wizards can’t even touch you. While your Rage is active, you have Advantage on saving throws against spells and other magical effects.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-muscle-wizard'),
  14,
  'I Cast Fist',
  'You can crush your enemies with your ultimate “spell”: Fist. When you take the Attack action while your Rage is active, you can replace one of your attacks with a really hard punch. Make an Unarmed Strike with Advantage. On a hit, the target takes Bludgeoning damage equal to 6d6 plus your Strength modifier and has the Prone condition if it is Huge or smaller. You can use this feature once per active Rage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  3,
  'Kick in the Door',
  'You have Advantage on attack rolls you make during the first round of combat.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  3,
  'Heroic Superstition',
  'You gain Heroic Inspiration when you do any of the following.

Damage Vulnerability. Deal a type of damage to which a creature has Vulnerability.

Find Weakness. Trigger a creature’s specific weakness, such as Shadow’s Sunlight Weakness or dealing damage that prevents a creature’s Regeneration.

Guess the Monster. Guess a creature’s specific kind (such as a mimic or lich) before seeing it. The GM confirms if you are correct when the creature is revealed. You can’t guess the identity of Humanoids.

Secret Doors. Discover a secret door.

Trapfinder. Detect or disarm a trap.

Treasure Hoard. Find an Uncommon, Rare, Very Rare, or Legendary magic item or treasure worth 100 GP+.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  7,
  'Dungeon Precautions',
  'You can cast any of the following spells without a spell slot: Alarm, Comprehend Languages, Detect Magic, Detect Poison and Disease, Find Traps, Identify, and Purify Food and Drink. Intelligence, Wisdom, or Charisma is your spellcasting ability for the spells you cast with this feature (choose the ability when you cast the spell).

You can use this feature five times and regain all expended uses when you finish a Long Rest.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  10,
  'Monster Kill',
  'Once per turn when you hit an Aberration, Dragon, Fey, Fiend, Monstrosity, Ooze, or Undead with an attack with a weapon, you can deal an extra 1d10 damage to the target. This damage is the same type dealt by the weapon.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  15,
  'Avoidance',
  'When you''re subjected to an effect that allows you to make a Strength, Dexterity, or Constitution saving throw to take only half damage, you instead take no damage if you succeed on the saving throw and only half damage if you fail. You can’t use this feature if you have the Incapacitated condition.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  18,
  'Veteran Hero',
  'Your dungeoneering expertise gives you the following benefits.

Peerless Heroism. Once per turn when you make a D20 Test, you can expend Heroic Inspiration to turn the roll into a 20, instead of rerolling the d20.

Double Inspiration. You can have two instances of Heroic Inspiration at one time. You can use only one Heroic Inspiration per roll.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  3,
  'Combo',
  'When you hit a creature with an Unarmed Strike and deal damage, you can expend 1 Focus Point to begin a combo. Until the end of the current turn, you gain a +2 bonus to attack rolls of your Unarmed Strikes. This bonus increases by 2, up to a maximum of +6, for each successive hit on the current turn. This bonus resets to +2 if you take damage or miss with an attack roll.

Lucas Ferreira CM'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  3,
  'Iron Fist',
  'Whenever you hit an object with an Unarmed Strike, the hit is a Critical Hit.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  6,
  'Special Moves',
  'You have memorized patterns of discrete movements that allow you to use the following special moves.

Energy Blast. When you take the Attack action on your turn, you can expend 1 Focus Point to replace one of your attacks with a blast of energy. One creature of your choice that you can see within 60 feet makes a Dexterity saving throw, taking Force damage equal to two rolls of your Martial Arts die, or half as much damage on a successful save.

Guard Breaker. If you make an attack roll with your Unarmed Strike and miss the target, you can expend 1 Focus Point to perform a Guard Breaker. This Unarmed Strike deals damage equal to your Dexterity modifier to the target. This miss doesn’t reset your Combo bonus to attack rolls.

Uppercut. When you hit a creature with an Unarmed Strike and deal damage, you can expend 1 Focus point to make an uppercut. You can push the target up to 5 feet away from you and give the target the Prone condition if it is Large or smaller.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  11,
  'Air Dash',
  'On your turn, you can expend 1 Focus Point to gain a Fly Speed equal to your Speed until the end of your next turn (no action required). You have Advantage on the next melee attack you make before the end of the current turn.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warrior-of-the-street'),
  17,
  'K.O.',
  'Once per turn when you hit a creature with an Unarmed Strike, you can attempt to knock the target out. The target takes extra Force damage equal to three rolls of your Martial Arts die. If the target has 100 Hit Points or fewer after you deal damage with the Unarmed Strike, it has the Unconscious condition for 10 minutes.

Once you use this feature, you can’t use it again until you finish a Short or Long Rest. You can also restore your use of it by expending 5 Focus Points (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  3,
  'Oath of Revelry Spells',
  'The magic of your oath ensures you always have certain spells ready; when you reach a Paladin level specified in the Oath of Revelry Spells table, you thereafter always have the listed spells prepared. New spells are marked with an asterisk (*).

      Oath of Revelry Spells

Paladin Level
Spells

3
Charm Person, Hideous Laughter

5
Enhance Ability, Hangover *

9
Create Food And Water, Hypnotic Pattern

13
Charm Monster, Freedom of Movement

17
Geas, Telepathic Bond'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  3,
  'Conjure Drink',
  'As a Magic action, you can expend one use of your Channel Divinity to conjure a number of mugs filled with frothy ale up to your Charisma modifier (minimum of one), which appear in spaces within 30 feet of yourself. A creature that drinks the ale as a Bonus Action gains Temporary Hit Points equal to your Charisma modifier and has Advantage on saving throws for 1 minute. When you finish a Long Rest, the mugs and remaining ale vanish.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  7,
  'Aura of Fraternity',
  'You and your allies deal an extra 1d4 damage on attacks using Melee weapons or Unarmed Strikes while in your Aura of Protection. This damage is the same type dealt by the weapon or Unarmed Strike.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  15,
  'Merrymaker',
  'When you or an ally within 30 feet of yourself that can see or hear you makes a D20 Test, you can take a Reaction to give that creature Advantage on the roll.

You can use this feature a number of times equal to your Charisma modifier (minimum of once), and regain all expended uses when you finish a Long Rest. If the creature still fails the D20 Test, this use of Merrymaker isn’t expended.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  20,
  'Party Animal',
  'As a Bonus Action, you can imbue your Aura of Protection with the many-hued magic of revelry, granting the benefits below for 10 minutes or until you end them (no action required). Once you use this feature, you can’t use it again until you finish a Long Rest. You can also restore your use of it by expending a level 5 spell slot (no action required).

Extra Damage. The extra damage from your Aura of Fraternity increases to 1d8.

Heroic Inspiration. At the start of each of your turns, you can give Heroic Inspiration to one ally within the aura.

Immunities. You and your allies have Immunity to the Blinded, Deafened, Exhaustion, and Poisoned conditions while in the aura.

Martin Kirby-Jackson'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  3,
  'Webbing',
  'You can magically produce sticky, silken spider webs from your hands as a Bonus Action. This web dissolves after 1 minute. When you create the webs, you can use them to do one of the following.

Pull Yourself. You project a line of web at a point you can see within 30 feet, pulling yourself to that point in a straight line without provoking Opportunity Attacks. You can use this benefit as a Reaction when you fall to pull yourself up to 10 feet in any direction.

Manipulate Objects. You can use a line of web to manipulate an object that isn’t being worn or carried within 30 feet. For example, you can pull an object to your hand, close a door, or snatch a Small or smaller object weighing less than 10 pounds.

Create Rope. You create a 60-foot-long Rope of web and anchor it to a point you choose.

Web Spell. You cast Web without a spell slot as a part of the Bonus Action used for this feature (DC equals 8 plus your Dexterity modifier and Proficiency Bonus). When you cast it using this feature, the webs fill a 5-foot Cube, and the spell’s duration becomes 1 minute. You can cast this spell using this feature twice. You regain one expended use when you finish a Short Rest, and you regain all expended uses when you finish a Long Rest.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  3,
  'Venomous Strike',
  'When you deal Sneak Attack damage to a creature, you can choose for the Sneak Attack to deal d8s of Poison damage instead of d6s of the same type dealt by the weapon.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  9,
  'Wall Crawling',
  'You’ve become accustomed to moving like a spider, granting you the following benefits.
Climber. You gain a Climb Speed equal to your Speed.

Hiding on Ceilings. If you are on a ceiling and Lightly Obscured, you can take the Hide action as long as any enemy that could see you is below you.

Spider Climb. You can move up, down, and across vertical surfaces and along ceilings, while leaving your hands free.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  13,
  'Spider Sense',
  'When you make a saving throw and take damage, you can take a Reaction to use your Uncanny Dodge, halving the damage you take (round down).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  17,
  'Paralytic Venom',
  'You gain the following Cunning Strike option.

Paralyze (Cost: 4d6). When you deal Poison damage with your Venomous Strike, the target must succeed on a Constitution saving throw or have the Paralyzed condition until the end of your next turn.

Lucas Ferreira CM'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  3,
  'Future You Spells',
  'The magic of your patron ensures you always have certain spells ready; when you reach a Warlock level specified in the Future You Spells table, you thereafter always have the listed spells prepared. New spells are marked with an asterisk (*).

Future You Spells

Warlock Level
Spells

3
Accelerate/Decelerate,* Delay,* Enhance Ability, Moment to Think,* Recall

5
Protection from Energy, Slow

7
Death Ward, Dire Warning *

9
Legend Lore, Telepathic Bond

In addition, strange effects linger after communicating with your future self. You gain one of the traits from the Future You Quirks table.

Future You Quirks

d6
Quirks

1
You often speak in the wrong tense or refer to yourself in a plural.

2
You sometimes refer to a person by name before they’ve introduced themselves.

3
You are unreasonably calm in dire circumstances.

4
In certain lighting, you look much older than you are.

5
Seeing certain people alive instantly reduces you to tears.

6
Your future fashion sense clashes completely with that of today.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  3,
  'It Happened Like This',
  'Your discussions of the future with yourself have given you peripheral knowledge about how events will play out. Whenever you finish a Short or Long Rest, the GM rolls a d20 and a d4 in secret and records the number rolled on the d20. The GM tells you the recorded d20 roll, unless they roll a 4 on the d4; in that case, they lie about the recorded d20 roll.

Lucas Ferreira CM

You can replace any D20 Test made by you or a creature you can see with the recorded d20 roll (no action required). You must choose to do so before the roll. If the GM lied about the roll, they inform you of the actual recorded d20 roll only after you replace the test with it.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  6,
  'I Could Do With Fewer Scars',
  'Your future self warns you of particular attacks to watch out for. When a creature you can see hits you with an attack roll, you can take a Reaction to gain a +10 bonus to your AC against that attack, potentially causing it to miss.

You can use this feature twice. You regain one expended use when you finish a Short Rest, and you regain all expended uses when you finish a Long Rest.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  10,
  'Expect an Ambush',
  'You have Advantage on Initiative rolls and Resistance to all damage on the first round of combat.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  14,
  'Grandfather Paradox',
  'As a Magic action, you can goad a creature within 60 feet of you that can see or hear you into causing a paradox. The creature must make an Intelligence saving throw against your spell save DC. On a failed save, the creature takes 10d6 Psychic damage and has the Stunned condition for 1 minute as it is locked between opposing timelines. On a successful save, the target takes half as much damage only. The Stunned creature repeats the save at the end of each of its turns, ending the condition on itself on a success.

Once you use this feature, you can’t use it again until you finish a Long Rest.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
