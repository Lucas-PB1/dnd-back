-- Seed Gunslinger subclass features
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  3,
  'Eagle Eye [Maneuver]',
  'Once per turn when you miss with a ranged attack roll, you can expend one Risk Die and add it to the attack roll, potentially causing the attack to hit.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  3,
  'Sharpshooter’s Stance',
  'You have trained to fire from a stable Prone position, granting the following conditions.

Fire While Prone. You don’t have Disadvantage on ranged attack rolls as a result of the Prone condition.

Quick Stand. When you have the Prone condition, you can right yourself and thereby end the condition with only 5 feet of movement.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  6,
  'Concealed Position',
  'You excel at firing from concealment, granting you the following benefits.

Camouflage. You can take the Hide action even if you aren’t Heavily Obscured or behind Three-Quarters Cover or Total Cover, as long as you have the Prone condition. The Invisible condition of this Hide action ends if you don’t have the Prone condition.

Sniper’s Nest. If you make an attack roll while hidden and the roll misses, making the attack roll doesn’t reveal your location.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  10,
  'Reposition',
  'Whenever a creature misses you with an attack roll, you can take a Reaction to end the Prone condition on yourself and move up to half your Speed.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'deadeye'),
  14,
  'Focused Shot',
  'When you take the Attack action, you can choose to make only one ranged attack roll using a weapon to make a Focused Shot. You have Advantage on this attack roll and, on a hit, score a Critical Hit.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  3,
  'Poker Face',
  'You gain proficiency with all Gaming Sets and in one of the following skills of your choice: Deception, Insight, or Perception.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  3,
  'Liar’s Dice [Maneuver]',
  'When you make a damage roll with a Ranged weapon, you can expend one Risk Die as a Bonus Action and declare it to be a hidden roll. Roll the damage in secret and declare any total you wish. The GM has the option to call your bluff, in which case you reveal the damage dice you rolled. This has different consequences based on whether or not you lied.

The GM Calls Your Bluff; You Lied. The damage you deal is halved.

The GM Calls Your Bluff; You Told the Truth. The damage you deal is doubled.

The GM Doesn’t Call Your Bluff. Use the total damage you declared, even if you rolled a different total.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  6,
  'Risky Business',
  'Once per turn when you make an attack roll against an enemy and the roll doesn’t have Disadvantage, you can choose to make the roll with Disadvantage. When you do, you regain one expended Risk Die.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  10,
  'Risk Taker',
  'You can use your Maverick Spirit and Skin of Your Teeth maneuvers without expending a Risk Die. When you do so, roll a d6 instead of a Risk Die.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'high-roller'),
  14,
  'Double or Nothing',
  'When you score a Critical Hit using a Ranged weapon, you can gamble for a higher result. Roll a d20. If the roll is a 10 or higher, roll all of the attack’s damage dice four times and add them together, instead of only two times as normal for a Critical Hit. If you roll a 9 or lower on the d20, the Critical Hit becomes a normal hit.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  3,
  'Operative Training',
  'Your covert training grants you the following benefits:

Concealed Shot. You learn the Concealed Shot cantrip. Intelligence, Wisdom, or Charisma is your spellcasting ability for this cantrip (choose when you select this subclass).

Operative Tools. You gain a Disguise Kit and Thieves’ Tools, and you have proficiency with them.

Skill Proficiencies. You gain proficiency in two of these skills of your choice: Deception, Investigation, Persuasion, Sleight of Hand, or Stealth.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  3,
  'Parting Shot [Maneuver]',
  'When you take the Dash, Disengage, or Dodge action on your turn, you can expend one Risk Die to make a ranged attack using a weapon as a Bonus Action. Add the Risk Die to the damage roll on a hit.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  6,
  'Fieldcraft',
  'Your experience in the field grants you the following benefits.

Quick Change. Using a Disguise Kit, you can create a Costume and don it as a Bonus Action.

Slick Talker. Whenever you make a Charisma (Deception) or Charisma (Persuasion) check, you can treat a d20 roll of 9 or lower as a 10.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  10,
  'Exit Strategy',
  'When you take damage, you can take a Reaction to evade further harm. You have the Invisible condition until the start of your next turn, and you can immediately move up to 10 feet.

Once you use this feature, you can’t use it again until you finish a Short or Long Rest. You can also restore your use of it by expending one Risk Die (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'secret-agent'),
  14,
  'License to Kill',
  'Whenever you deal damage with a Ranged weapon, you can expend either one or two Risk Dice and add them to the damage roll. If you roll the highest number on a Risk Die, you can roll the die again and add it to the damage without expending it, rolling again if it is the highest number again, and so on. The maximum number of Risk Dice you can add to the damage equals your Proficiency Bonus.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  3,
  'Spellcasting',
  'You complement your bullets with the ability to cast spells.

Cantrips. You know two cantrips of your choice from the Wizard spell list (see that class’s section for its list). Fire Bolt and Message are recommended. Whenever you gain a Gunslinger level, you can replace one of these cantrips with another cantrip of your choice from the Wizard spell list.

When you reach Gunslinger level 10, you learn another Wizard cantrip of your choice.

Spell Slots. The Spellslinger Spellcasting table shows how many spell slots you have to cast your level 1+ spells. You regain all expended slots when you finish a Long Rest.

Prepared Spells of Level 1+. You prepare the list of level 1+ spells that are available for you to cast with this feature. To start, choose three level 1 spells from the Wizard spell list. Chromatic Orb, Jump, and Shield are recommended.

The number of spells on your list increases as you gain Gunslinger levels, as shown in the Prepared Spells column of the Spellslinger Spellcasting table. Whenever that number increases, choose additional spells from the Wizard spell list until the number of spells on your list matches the number on the table. The chosen spells must be of a level for which you have spell slots. For example, if you’re a level 7 Gunslinger, your list of prepared spells can include five Wizard spells of levels 1 and 2 in any combination.

Changing your Prepared Spells. Whenever you gain a Gunslinger level, you can replace one spell on your list with another Wizard spell for which you have spell slots.

Spellcasting Ability. Intelligence is your spellcasting ability for your Wizard spells.

Spellcasting Focus. You can use an Arcane Focus or a Ranged weapon as a Spellcasting Focus for your Wizard spells.

        —Spell Slots per Spell Level—

1
2
3
4

3
3
2
—
—
—

4
4
3
—
—
—

5
4
3
—
—
—

6
4
3
—
—
—

7
5
4
2
—
—

8
6
4
2
—
—

9
6
4
2
—
—

10
7
4
3
—
—

11
8
4
3
—
—

12
8
4
3
—
—

13
9
4
3
2
—

14
10
4
3
2
—

15
10
4
3
2
—

16
11
4
3
3
—

17
11
4
3
3
—

18
11
4
3
3
—

19
12
4
3
3
1

20
13
4
3
3
1'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  3,
  'Bang, You’re Dead!',
  'You can use magic in place of guns.

Finger Guns. You learn the Finger Guns cantrip. See the New Spells section for details.

Arcane Shot. When you hit a target with a Finger Guns attack, you can expend one Risk Die as a Bonus Action and add it to the damage roll.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  6,
  'Spellshot',
  'When you take the Attack action on your turn, you can replace one of the attacks with a casting of one of your Wizard cantrips that has a casting time of an action.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  10,
  'Counter-Mage',
  'Your experience in combating spellcasters grants you the following benefits.

Abjuration-Breaker. Whenever you make a ranged attack roll, you temporarily disrupt protective magic affecting the target. For the duration of the attack, the effects of spells targeting the creature, such as Mage Armor, as well as the properties and powers of magic items worn or carried by the creature, are suppressed and don’t function. The target of the attack can’t take a Reaction to cast spells such as Shield in response to the attack or damage.

Antimagic Shot. When you score a Critical Hit and the target is affected by your Gut Shot feature, it also impedes the target’s ability to cast spells. While the projectile is lodged in the target, it can’t cast spells or take the Magic action. Additionally, the target has Disadvantage on Constitution saving throws it makes to maintain Concentration.

Inured to Magic. When you fail a saving throw against a spell or magical effect, you can take a Reaction to roll 1d6 and add it to the roll, potentially turning the failure into a success.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  14,
  'Magic Bullet [Maneuver]',
  'When you make a spell attack roll, you can expend one Risk Die as a Bonus Action to substitute the spell attack with a ranged attack using a weapon. Add the Risk Die to the attack roll. On a hit, the attack deals the weapon’s normal damage, in addition to the effects of the spell attack roll.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  3,
  'Creative Trajectory',
  'You can make your projectiles travel in unexpected ways. Your ranged attacks with weapons ignore Half Cover and Three-Quarters Cover.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  3,
  'Ricochet [Maneuver]',
  'When you miss with a ranged attack using a weapon, you can take a Bonus Action and expend one Risk Die to reroll the attack and add the Risk Die to the roll. You must use the new roll.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  6,
  'Fancy Gunplay',
  'Your flashy weapon tricks grant you the following benefits.

Gun Spinning. Once per turn when you make a Charisma (Performance) check or a Dexterity (Sleight of Hand) check using one of your Ranged weapons, you can roll a Risk Die and add it to the ability check without expending it.

Speed Loader. On your turn, you can reload a weapon with the Reload property without taking an action or Bonus Action.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  10,
  'Deft Deflection [Maneuver]',
  'You can shoot projectiles out of the air. When an ally within 30 feet of you is hit by an attack, you can take a Reaction and expend one Risk Die to grant that ally the benefit of the Skin of Your Teeth maneuver against that attack. You must be holding a Ranged weapon to use this maneuver.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trick-shot'),
  14,
  'Pinball Shot',
  'Once on each of your turns when you hit a creature with a ranged attack using a weapon, you can deflect the projectile at additional targets. Choose a different target within 30 feet of the first and make an attack roll against it. On a hit, you can repeat this attack against a new target within 30 feet until you miss or make a total of five attacks. You can’t target the same creature with more than one attack each time you use this feature.

Once you use this feature, you can’t use it again until you finish a Short or Long Rest. You can also restore your use of it by expending two Risk Dice (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  3,
  'Lay Down the Law [Maneuver]',
  'You can take a Bonus Action and expend one Risk Die to keep an eye out for dangers that threaten your companions. Choose an ally that you can see within 60 feet of you. That ally gains Temporary Hit Points equal to the number rolled on the Risk Die. Until the start of your next turn, if the ally is hit by an attack, you can take a Reaction to make a ranged attack using a weapon against the attacker.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  3,
  'Steely-Eyed Aura',
  'An aura of stoic confidence radiates from you in a 10-foot Emanantion. You and allies within the Emanantion have Advantage on saving throws made to avoid or end the Frightened condition. The aura is inactive while you have the Incapacitated condition.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  6,
  'Reach for the Skies',
  'When you score a Critical Hit against a creature, you call for the target to surrender instead of lodging a projectile in it. The target must succeed on a Wisdom saving throw against your Maneuver save DC or have the Frightened and Incapacitated conditions for 1 minute. These conditions end early if the creature takes any damage, if you have the Incapacitated condition, or if you die. The creature can repeat the Wisdom saving throw at the end of each of its turns, ending the conditions on itself on a success.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  10,
  'Long Arm of the Law',
  'Once per turn when you hit a Large or smaller creature with a ranged attack using a weapon, you can hobble the target. The creature can’t move on its next turn unless it first takes the Disengage action.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'white-hat'),
  14,
  'Gold Star Hero',
  'Though gunslinging heroism, you gain the following benefits.

Improved Aura. The range of your Steely-Eyed Aura feature increases to 30 feet.

Iron-Clad Law. When you use your Lay Down the Law maneuver, the ally has Resistance to Bludgeoning, Piercing, and Slashing damage until the start of your next turn.

Stunned Surrender. When a creature fails its saving throw against your Reach for the Skies feature, it has the Stunned condition instead of the Incapacitated condition.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;
