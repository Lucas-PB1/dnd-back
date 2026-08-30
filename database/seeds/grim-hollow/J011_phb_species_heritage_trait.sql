-- Grim Hollow Cap. 1 — traços de herança

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), 'Age', 'Age. Young Dragonborn grow quickly. They walk hours after hatching, attain the size and development of a 10-year-old human child by the age of 3, and reach adulthood by 15. Dragonborn live to be about 80.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), 'Size', 'Size. Dragonborn are typically tall and solidly built, with most standing well over 1.8 m tall and averaging almost 250 pounds. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Combate] Breath Weapon', 'Traço tradicional sugerido (Combate).

A connection to draconic or elemental fury lets you unleash a blast of destructive energy. When you select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 5 feet wide and 30 feet long, or a 15-foot Cone .

When you use a Magic action to expel your Breath Weapon, each creature in the area of effect must make a Dexterity saving throw (DC = 8 + your Constitution modifier + your Proficiency Bonus). A target creature takes 1d8 damage of the chosen type on a failed save, or half as much damage on a successful one. This damage increases by 1d8 when you reach character levels 5 (2d8), 11 (3d8), and 17 (4d8).

You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Potent Breath. If you take this trait multiple times, you gain an additional breath weapon each time, with its own number of uses, damage type, and area of effect.

Additionally, when you use any of your Breath Weapons, one target of your choice has Disadvantage on the saving throw. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Combate] Damage Resistance', 'Traço tradicional sugerido (Combate).

Exposure to the worst effects of a specific energy has given you a tolerance to its effects. You have Resistance to one of the following damage types of your choice: Acid, Cold, Fire, Lightning, Poison, or Thunder.

Damage Immunity. If you take this trait twice, as a Reaction to taking damage of the type you chose for Damage Resistance, you gain Immunity to that damage type until the end of your next turn. You regain the use this feature when you finish a Short Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Combate] Menacing Roar', 'Traço tradicional sugerido (Combate).

Your battle cry can cause even the most formidable foes to quail before you. As a Bonus Action, you emit a roar, shout, or other loud vocal outburst. Each creature of your choice within 10 feet of you that can hear you must succeed on a Wisdom saving throw (DC = 8 + your Proficiency Bonus + your Constitution modifier) or have the Frightened condtion until the end of your next turn. You regain the use of this feature when you finish a Long Rest.

Incomparable Roar. If you take this trait twice, when you use Menacing Roar, one target of your choice has Disadvantage on the saving throw.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Exploração] Darkvision', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Exploração] Natural Movement', 'Traço tradicional sugerido (Exploração).

The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, moving through nonmagical Difficult Terrain costs you no extra movement, and ability checks made to track you have Disadvantage.

Shared Movement. If you take this trait multiple times, you gain its benefits for a new environment each time. Additionally, while in any environment chosen for Natural Movement, as a Bonus Action, you can grant creatures of your choice the benefit of Natural Movement for 1 hour, as long as those creatures remain within 120 feet of you and can see you.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Exploração] Powerful Build', 'Traço tradicional sugerido (Exploração).

Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight you can push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)

Powerful Shove. If you take this trait twice, you can move or knock foes prone with ease. When you use Unarmed Attack to shove a creature 5 feet or give it the Prone condition, the target has Disadvantage on the saving throw. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Interpretação] Firm Influence', 'Traço tradicional sugerido (Interpretação).

Others have learned to fear you—and for good reason.

You have proficiency in the Intimidation skill.

Terrifying Influence. If you take this trait twice, you have Advantage on Intimidation checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'), '[Tradicional · Interpretação] Moved by Faith', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'), 'Typically short and stout, Dwarves are among the most recognizable folk of Etharis', 'Typically short and stout, Dwarves are among the most recognizable folk of Etharis.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'), 'Age', 'Age. Dwarves physically mature by their late teens, but are considered young until they reach the age of 50. On average, they live about 350 years.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'), 'Size', 'Size. Dwarves stand between 4 and 1.5 m tall and average about 150 pounds. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'), 'Speed', 'Speed. 9 m. Your Speed is not reduced by wearing heavy armor. You can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'), 'May your drink be strong and your hammer strike true', 'May your drink be strong and your hammer strike true.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'), 'Though elves might pass as humans at a distance, their fine features typically make them immediately recognizable to other folk', 'Though elves might pass as humans at a distance, their fine features typically make them immediately recognizable to other folk.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'), 'Age', 'Age. Although elves reach physical maturity at about the same age as humans, the elven understanding of adulthood goes beyond physical growth to encompass worldly experience. An Elf typically claims adulthood and an adult name around the age of 100, and can live to be 750 years old.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'), 'Size', 'Size. Elves range from under 5 to over 1.8 m tall and often have slender builds. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), 'Most Gnomes are marked by the slight features and long lives that are common among their kind', 'Most Gnomes are marked by the slight features and long lives that are common among their kind.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), 'Age', 'Age. Gnomes are physically mature by 18, and most are expected to settle down into an adult life by around age 40. They can live to almost 500 years.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), 'Size', 'Size. Gnomes are between 3 and 1.2 m tall and average about 40 pounds. Your size is Pequeno.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), 'Speed', 'Speed. 9 m. You can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), 'They’re grubby little folk, always smeared with ash and blackpowder', 'They’re grubby little folk, always smeared with ash and blackpowder. Couldn’t ask for better engineers though.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), 'Visão geral', '—Guard Captain, on her efforts to recruit gnomes', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Combate] Magical Fortification', 'Traço tradicional sugerido (Combate).

The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.

Extended Fortification. If you take this trait multiple times, you have Advantage on saving throws using a new ability score each time.

Additionally, if you fail a saving throw against a spell or other magical effect and you do not have proficiency with that saving throw, you can use your Reaction to reroll the save. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Combate] Quick Slip', 'Traço tradicional sugerido (Combate).

Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. You can take the Hide action as a Bonus Action on each of your turns. You must have appropriate cover to attempt to hide, as normal.

Astute Slip. If you take this trait twice, you have Advantage on Stealth checks you make with the Hide action when you use Quick Slip.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Exploração] Artifice Expertise', 'Traço tradicional sugerido (Exploração).

Working with detritus and shattered objects has granted you an affinity for repairing and remaking things. You have proficiency with Tinker’s Tools . (This is an Exploration trait.)

Additionally, you can use your Tinker’s Tools and 10 GP worth of appropriate materials to spend 10 minutes creating a small clockwork device. The device must fit in the palm of your hand, and can serve one of the following functions:

Smoker. The device exudes smoke in a 5-foot Cube for 1 minute. Any objects or creatures within this Cube are considered Lightly Obscured .

Lighter. The device emits a small flame the size of a candle’s that can light flammable objects.

Compass. The device always points north, or in a cardinal direction of the GM’s determination on another plane.

Expert Gadgeteer. If you take this trait twice, you can make a device in 1 minute instead of 10 minutes. In addition, you can choose to imbue a device with the following extra function: (This is a Combat trait.)

Distractor. This device is set with blinking lights that can captivate other creatures. As a Bonus Action, you place or toss the device into a space within 30 feet of you. A creature sharing a space with the device must succeed on a DC 10 Intelligence saving throw. On a failure, attacks against that creature have Advantage until the start of your next turn. A creature can use an action to destroy the device. You can give up to three of your devices the Distractor feature. You regain the ability to do so when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Exploração] Darkvision', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Exploração] Fade Away', 'Traço tradicional sugerido (Exploração).

You have learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. As a Bonus Action, you can take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.

You become visible at the start of your next turn unless you have moved into a position that allows you to use the Hide action normally. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Long Fade. If you take this trait twice, you have Advantage on your ability check when you take the Hide action from Fade Away, and you become visible at the end of your next turn instead of the start of your next turn.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Interpretação] Magical Savvy', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Interpretação] Masterful Aptitude', 'Traço tradicional sugerido (Interpretação).

Your discipline and focus give you an edge that others lack. Choose one of your skill or tool proficiencies. You have Expertise on ability checks made using the chosen proficiency.

Focused Mastery. If you take this trait multiple times, you gain its benefit for a new skill proficiency or tool proficiency each time.

Additionally, when you make a check using a skill or tool for which you’ve taken Masterful Aptitude, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'), '[Tradicional · Interpretação] Nature’s Voice', 'Traço tradicional sugerido (Interpretação).

Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, you can communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and you can’t understand or learn detailed information from them.

Primal Voice. If you take this trait twice, you have Advantage on ability checks made as part of an Influence action to interact with a Beast or Plant creature.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), 'Whatever their approach to life, most Halfling characters are defined by their diminutive stature', 'Whatever their approach to life, most Halfling characters are defined by their diminutive stature.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), 'Age', 'Age. A Halfling reaches adulthood at the age of 20 and generally lives into the middle of their second century.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), 'Size', 'Size. Halflings average about 0.9 m tall and weigh about 40 pounds. Your size is Pequeno.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), 'Speed', 'Speed. 9 m. You can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), 'The halflings prove trickier than I first suspected, though content enough with current arrangements', 'The halflings prove trickier than I first suspected, though content enough with current arrangements. I wouldn’t push things.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), 'Visão geral', '—Tax Collector’s Report', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Combate] Brave', 'Traço tradicional sugerido (Combate).

The horrors you’ve lived through have hardened you. You have Advantage on saving throws to avoid being Frightened .

Infectious Bravery. If you take this trait twice, you can use your Reaction to bolster the spirits of your allies, granting one ally who can see or hear you Advantage on a saving throw against being Frightened. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Combate] Creature Cover', 'Traço tradicional sugerido (Combate).

By slipping behind enemies or allies alike, you are able to fade from view with ease. You can take the Hide action even when you have Half Cover from a creature, as long as that creature is of a size larger than you.

Subtle Cover. If you take this trait twice, you can take the Hide action when you have Half Cover from a creature the same size as you.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Combate] Lucky', 'Traço tradicional sugerido (Combate).

The luck you carry will see you through the worst Etharis has to offer. When you roll a 1 on a D20 Test, you can reroll that die but must use the new roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Master of Fortune. If you take this trait twice, you have Advantage on the reroll made with Lucky.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Exploração] Helping Hand', 'Traço tradicional sugerido (Exploração).

You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)

Helpful Tactics. If you take this trait twice, when you use Helping Hand, you can also assist an ally making an attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Exploração] Pass Through', 'Traço tradicional sugerido (Exploração).

Making use of constant movement lets you minimize the threat of larger foes. You can move through the space of any creature at least one size larger than you.

Nimble Passage. If you take this trait twice, you do not treat another creature’s space as Difficult Terrain .', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Exploração] Power Nap', 'Traço tradicional sugerido (Exploração).

When you don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest you can get. When taking a Short Rest, you can choose to sleep for 1 hour. If you do so, you reduce your Exhaustion by one level and regain a Hit Point Die in addition to the other benefits of a Short Rest.

Extreme Resilience. If you take this trait twice, when using Power Nap, you can choose to regain a single resource that would normally refresh on a Long Rest. For example, a Sorcerer could choose to regain a Sorcery Point on a Short Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Interpretação] Artisanal Focus', 'Traço tradicional sugerido (Interpretação).

You revere the crafting skill of ancestors long dead. Choose an Artisan’s Tool. You have proficiency with that tool.

Artisanal Expertise. If you take this trait multiple times, you gain proficiency with a new tool each time.

Additionally, you have Advantage on ability checks made using any tool you selected with Artisanal Focus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'), '[Tradicional · Interpretação] Embrace the Past', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), 'Humans present a wide range of physical traits, but their brief lifespans have long defined their collective ambition', 'Humans present a wide range of physical traits, but their brief lifespans have long defined their collective ambition.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), 'Age', 'Age. Humans reach adulthood in their late teens and live less than a century.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), 'Size', 'Size. Humans vary widely in height and build, from barely 1.5 m to well over 1.8 m tall. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Combate] Awesome Critical', 'Traço tradicional sugerido (Combate).

When fortune favors your blade, you know how to make it count. When you score a Critical Hit with a melee attack with a weapon or an Unarmed Strike , you can roll one of the weapon’s damage dice one additional time and add it to the extra damage of the Critical Hit.

Maximum Critical. If you take this trait twice, when you use Awesome Critical, you can add the maximum of the weapon’s original damage dice and the extra Awesome Critical die to the extra damage of the Critical Hit, rather than rolling them. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Combate] First Strike', 'Traço tradicional sugerido (Combate).

Hesitation in others is a weakness you’ve learned to take deadly advantage of. When you hit a creature that hasn’t taken a turn in the combat yet, your attack deals an extra 2d6 damage. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Strong Strike. If you take this trait twice, you can use the maximum value of the extra damage dice from First Strike, rather than rolling. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Combate] Weapon Aptitude', 'Traço tradicional sugerido (Combate).

The weapons you wield might save your life one day, and you know their secrets. You have proficiency with three weapons of your choice.

Weapon Specialist. If you take this trait multiple times, you gain proficiency with three new weapons each time. Additionally, choose one weapon with which you have proficiency. You have a +1 bonus to damage rolls with that weapon.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Exploração] Helping Hand', 'Traço tradicional sugerido (Exploração).

You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)

Helpful Tactics. If you take this trait twice, when you use Helping Hand, you can also assist an ally making an attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Exploração] Intrinsic Orientation', 'Traço tradicional sugerido (Exploração).

A single misstep can lead to ruin, but your instincts for direction keep you from going astray. You always know which way is north, and you can reckon a cardinal direction of the GM’s determination while on other planes. Additionally, you have Advantage on ability checks made to avoid becoming lost, to navigate, or to track.

Expert Orientation. If you take this trait twice, when you fail an ability check made to avoid becoming lost, to navigate, or to track, you can choose to succeed instead. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Interpretação] Artisanal Focus', 'Traço tradicional sugerido (Interpretação).

You revere the crafting skill of ancestors long dead. Choose an Artisan’s Tool. You have proficiency with that tool.

Artisanal Expertise. If you take this trait multiple times, you gain proficiency with a new tool each time.

Additionally, you have Advantage on ability checks made using any tool you selected with Artisanal Focus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Interpretação] Keen Survivor', 'Traço tradicional sugerido (Interpretação).

The wilds of Etharis have claimed many who lack the skill to navigate them. You have proficiency in the Survival skill.

Determined Survivor. If you take this trait twice, you have Advantage on Survival checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'), '[Tradicional · Interpretação] Skill Prowess', 'Traço tradicional sugerido (Interpretação).

Your ingenuity and inventiveness help keep you alive in a dangerous world. Before you make an ability check using a skill you are proficient with, you can add your Proficiency Bonus again. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Skill Mastery. If you take this trait twice, when you fail an ability check made using the Skill Prowess trait, you can reroll the check and must use the new roll.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), 'Dreamers bear a general resemblance to other humanoids, but their distinct features make them stand out', 'Dreamers bear a general resemblance to other humanoids, but their distinct features make them stand out.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), 'Age', 'Age. The magic that kept the Dreamers in stasis during their long slumber has also served to preserve their bodies from natural aging. Dreamers mature at the age of 18 and can live to be 250 years old.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), 'Size', 'Size. Dreamers typically range from 5 to 1.8 m in height, and have solid builds. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Combate] Quick Initiative', 'Traço tradicional sugerido (Combate).

Danger is never far away from you, and you are always ready for it. You add your Proficiency Bonus to your Initiative rolls.

Focused Initiative. If you take this trait twice, when you roll Initiative, you can treat a roll of 9 or lower as if you rolled a 10.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Combate] Stalwart Reserves', 'Traço tradicional sugerido (Combate).

Each time you lay into a foe, their state of peril lends you vigor. When you hit a creature with a melee attack, you can use your Reaction to roll a number of d4s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total rolled. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Stalwart Edge. If you take this trait twice, you can take the maximum number of Temporary Hit Points rather than rolling.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Exploração] Darkvision', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Exploração] Helping Hand', 'Traço tradicional sugerido (Exploração).

You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)

Helpful Tactics. If you take this trait twice, when you use Helping Hand, you can also assist an ally making an attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Exploração] Power Nap', 'Traço tradicional sugerido (Exploração).

When you don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest you can get. When taking a Short Rest, you can choose to sleep for 1 hour. If you do so, you reduce your Exhaustion by one level and regain a Hit Point Die in addition to the other benefits of a Short Rest.

Extreme Resilience. If you take this trait twice, when using Power Nap, you can choose to regain a single resource that would normally refresh on a Long Rest. For example, a Sorcerer could choose to regain a Sorcery Point on a Short Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Interpretação] Dreamwalking', 'Traço tradicional sugerido (Interpretação).

Whenever you rest, you touch the dreams of those around you, seeding their thoughts and memories into your own mind. When you make an ability check to recall lore or knowledge, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Secret Dreams. If you take this trait twice, you gain an instinctive knowledge of the secrets of other creatures while you touch their dreams. Using a Search action, you focus on one creature you can see and make a DC 15 Wisdom Insight check. With a successful check, you learn one secret of the GM’s choice known to that creature. The secrets of creatures that don’t have a language come to you as vague images and impressions. You regain the use of this feature when you finish a Short or Long Rest.

Why bother with interrogation? Just let him rest a few hours. I’ll get you your answers.

—Varrigan the Dreamwalker', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Interpretação] Improviser', 'Traço tradicional sugerido (Interpretação).

When needs demand, you get the job done better than most. As a Bonus Action, choose one skill or tool that you don’t have proficiency with. You have proficiency in that skill or with that tool for 1 hour. You regain the use of this feature when you finish a Long Rest.

Expert Improviser. If you take this trait twice, you have Advantage on ability checks you make using the skill or tool you select with Improviser. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'), '[Tradicional · Interpretação] Inborn Perception', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), 'The Grudgels’ ancient heritage marks them as distinct figures among the folk of Etharis', 'The Grudgels’ ancient heritage marks them as distinct figures among the folk of Etharis.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), 'Age', 'Age. Grudgels reach adulthood at about the age of 16, and can live to their seventh decade or more.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), 'Size', 'Size. Grudgels are taller and stockier than many other humanoids, typically ranging from 6 to 2.1 m in height, and weighing 200 pounds or more. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Combate] Battlefield Control', 'Traço tradicional sugerido (Combate).

When foes attempt to press you in melee, they do so at their peril. Other creatures provoke Opportunity Attacks from you whenever they move into your reach, in addition to when they move out of your reach.

Battlefield Dominance. If you take this trait twice, you have Advantage on Opportunity Attacks. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Combate] Centered', 'Traço tradicional sugerido (Combate).

By focusing your inner strength, you gain a needed edge. As a Bonus Action, you grant yourself Advantage on an attack roll or ability check you make before the start of your next turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Centered Edge. If you take this trait twice, when you succeed on the attack roll or ability check made while using Centered, you can choose one creature within 30 feet of you. That creature has Advantage on the next attack roll or ability check they make before the start of your next turn.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Exploração] Darkvision', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Exploração] Powerful Build', 'Traço tradicional sugerido (Exploração).

Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight you can push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)

Powerful Shove. If you take this trait twice, you can move or knock foes prone with ease. When you use Unarmed Attack to shove a creature 5 feet or give it the Prone condition, the target has Disadvantage on the saving throw. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Exploração] Tireless', 'Traço tradicional sugerido (Exploração).

An innate resilience lets you shake off conditions that would take others down. You have Advantage on saving throws connected to gaining or removing Exhaustion levels.

Vigorous. If you take this trait twice, when you fail a saving throw against Exhaustion, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Interpretação] Artisanal Focus', 'Traço tradicional sugerido (Interpretação).

You revere the crafting skill of ancestors long dead. Choose an Artisan’s Tool. You have proficiency with that tool.

Artisanal Expertise. If you take this trait multiple times, you gain proficiency with a new tool each time.

Additionally, you have Advantage on ability checks made using any tool you selected with Artisanal Focus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Interpretação] Impromptu Artisan', 'Traço tradicional sugerido (Interpretação).

You’ve never known the luxury of always having the gear you need, but you have more than learned to make do. If you possess Artisan’s Tools with which you have proficiency, and if you have access to appropriate raw materials and any additional necessary equipment (as the GM determines), you can use a Short Rest to craft any one nonmagical item worth 10 GP or less, including:

The gear you create is workable but not high quality, and can’t be sold except as the GM determines.

Master Artisan. If you take this trait twice, you can use Impromptu Artisan during a Long Rest, during which you craft one nonmagical item worth 50 GP or less.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'), '[Tradicional · Interpretação] Magical Savvy (any cantrip)', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), 'Among the other folk of Etharis, Laneshi are unique in their appearance and their aquatic nature', 'Among the other folk of Etharis, Laneshi are unique in their appearance and their aquatic nature.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), 'Age', 'Age. Laneshi mature quickly, reaching adulthood at around 14, and can live up to 150 years.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), 'Size', 'Size. Laneshi are typically 5 to 1.8 m tall and have slender builds. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), 'Speed', 'Speed. 9 m. You have a Swim Speed of 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Combate] Awakened Mind', 'Traço tradicional sugerido (Combate).

The dangers of Etharis have given you a focus that allows you to shrug off debilitating magical effects. You automatically succeed on saving throws against magical effects that would give you the Incapacitated , Stunned , or Unconscious conditions. This does not include effects that leave you Unconscious because you are reduced to 0 Hit Points.

Reawakened. If you take this trait twice, you also have Advantage on Intelligence, Wisdom, and Charisma saving throws.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Combate] Psychic Spirit', 'Traço tradicional sugerido (Combate).

Your strength of mind shields you from unnatural forces. You have Resistance to Psychic damage.

Spirit’s Strength. If you take this trait twice, when you fail a saving throw against an effect that deals Psychic damage, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Exploração] Amphibious', 'Traço tradicional sugerido (Exploração).

Surviving underwater is second nature to you. You can breathe air and water.

Water Born. If you take this trait twice, you have Advantage on ability checks or saving throws made while submerged in water. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Exploração] Darkvision', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Exploração] Swimmer', 'Traço tradicional sugerido (Exploração).

You are in your element while in the water, moving with grace and ease. You have a Swim Speed equal to your Speed.

Quickened Swim. If you take this trait twice, you can use the Dash action as a Bonus Action while swimming.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Interpretação] Animal Friend', 'Traço tradicional sugerido (Interpretação).

Time spent among beasts has gifted you a way with those creatures. You have proficiency in the Animal Handling skill.

Animal Ally. If you take this trait twice, you have Advantage on Animal Handling checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Something must be done about that elf. Last time I confronted her, she sicced my own dog on me.

—Disgruntled Neighbor', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Interpretação] Magical Savvy (any Necromancy cantrip)', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'), '[Tradicional · Interpretação] Nature’s Voice', 'Traço tradicional sugerido (Interpretação).

Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, you can communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and you can’t understand or learn detailed information from them.

Primal Voice. If you take this trait twice, you have Advantage on ability checks made as part of an Influence action to interact with a Beast or Plant creature.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), 'An ogresh’s formidable size and slow aging makes them stand out in settled lands', 'An ogresh’s formidable size and slow aging makes them stand out in settled lands.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), 'Age', 'Age. Ogresh reach maturity around age 25 but are considered youthful by their kin for decades afterward. They can live as long as 300 years.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), 'Size', 'Size. Young Ogresh typically stand 6 to 2.1 m tall, and sport a distinctively wide and heavy build. A young Ogresh usually ranges between 200 and 300 pounds, while an older Ogresh can reach upward of 700 to 800 pounds. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Combate] Enemy in Motion', 'Traço tradicional sugerido (Combate).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Combate] Focused Mind', 'Traço tradicional sugerido (Combate).

Your strength of will protects you from magic that would corrupt your mind. You have Advantage on saving throws against being Charmed .

Immutable Mind. If you take this trait twice, when you fail a saving throw against being Charmed, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Exploração] Environmental Awareness', 'Traço tradicional sugerido (Exploração).

The natural world is a dangerous place, and your connection to specific parts of that world grants you an edge in survival. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, whenever you make an ability check to assess structures, monuments, or natural features; to find food or drinkable water; or to track creatures, you are considered to have proficiency in the appropriate skill for the check, and you add double your Proficiency Bonus to the check instead of your normal bonus.

Adaptive Awareness. If you take this trait multiple times, you gain its benefit for a new environment each time.

Additionally, when you make an ability check using Environmental Awareness, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Exploração] Natural Movement', 'Traço tradicional sugerido (Exploração).

The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, moving through nonmagical Difficult Terrain costs you no extra movement, and ability checks made to track you have Disadvantage.

Shared Movement. If you take this trait multiple times, you gain its benefits for a new environment each time. Additionally, while in any environment chosen for Natural Movement, as a Bonus Action, you can grant creatures of your choice the benefit of Natural Movement for 1 hour, as long as those creatures remain within 120 feet of you and can see you.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Exploração] Powerful Build', 'Traço tradicional sugerido (Exploração).

Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight you can push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)

Powerful Shove. If you take this trait twice, you can move or knock foes prone with ease. When you use Unarmed Attack to shove a creature 5 feet or give it the Prone condition, the target has Disadvantage on the saving throw. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Interpretação] Calculating Listener', 'Traço tradicional sugerido (Interpretação).

The weak-willed around you are easy targets for your manipulation. By conversing with a nonhostile creature for at least 1 minute, you can attempt to charm them. The creature must succeed on a Wisdom saving throw (DC = 8 + your Charisma modifier + your Proficiency Bonus) or have the Charmed condition for 1 hour. At the GM’s discretion, you also learn one piece of information that the target knows that relates to the topic of conversation while you speak to them. Regardless of whether or not the target succeeds on the saving throw, they remain unaware of your attempt. You regain use of this feature when you finish a Short or Long Rest.

Master Manipulator. If you take this trait twice, a creature has Disadvantage on the saving throw, and it has the Charmed condition for 8 hours on a failed save.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Interpretação] Commanding Insight', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'), '[Tradicional · Interpretação] Persuasive Knack', 'Traço tradicional sugerido (Interpretação).

You have learned that the best way to deal with certain threats is to keep those threats from escalating. You have proficiency in the Persuasion skill.

Tongue of Gold. If you take this trait twice, you have Advantage on Persuasion checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'), 'The unique nature of each Accursed is reflected in a breadth of form and longevity', 'The unique nature of each Accursed is reflected in a breadth of form and longevity.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'), 'Age', 'Age. Accursed that strongly resemble other humanoids might have a longevity only slightly different than those other folk. However, unusual Accursed might age quickly or live effectively ageless lives until cut down by tragedy.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'), 'Size', 'Size. Accursed can range in size from under 0.9 m to 1.8 m or more, with a wide range of body types to match. Your size is Pequeno or Médio, as you determine.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'), 'Speed', 'Speed. 9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), 'Each Arisen character is shaped by the unique nature of the magic or circumstances that created them', 'Each Arisen character is shaped by the unique nature of the magic or circumstances that created them.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), 'Age', 'Age. Some Arisen age slowly, the artificial nature of their bodies sloughing off the worst effects of age to leave them hale even into their second or third century. Others age more quickly, worn down by the unnatural magic that imbues them well before their sixtieth year.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), 'Size', 'Size. Arisen can be any size, from compact constructs 0.6 m tall, to towering figures topping 2.1 m. Your size is Pequeno or Médio, as you determine.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), 'Speed', 'Speed. 9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), 'If the whirring engine didn’t give it away, the rotting flesh would have', 'If the whirring engine didn’t give it away, the rotting flesh would have.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), 'Visão geral', '—High Consecrator Tevesh Day', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Combate] Magical Fortification', 'Traço tradicional sugerido (Combate).

The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.

Extended Fortification. If you take this trait multiple times, you have Advantage on saving throws using a new ability score each time.

Additionally, if you fail a saving throw against a spell or other magical effect and you do not have proficiency with that saving throw, you can use your Reaction to reroll the save. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Combate] Tenacious', 'Traço tradicional sugerido (Combate).

Your enemies might put you down, but you are never down for long. You have Advantage on Death Saving Throws.

Hard to Kill. If you take this trait twice, when you drop to 0 Hit Points but don’t die outright, you remain conscious. You must make Death Saving Throws as normal while at 0 Hit Points, and you suffer a Death Saving Throw failure each time you take any damage, but you can otherwise act freely. You can’t become Stable while you remain at 0 Hit Points in this way.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Combate] Toughness', 'Traço tradicional sugerido (Combate).

An intrinsic hardiness marks you as one born for battle. Your Hit Point maximum increases by 1, and it increases by 1 each time you gain a level.

Extra Tough. If you take this trait twice, your Hit Point maximum increases by 2 instead of 1, and it increases by 2 each time you gain a level.

Additionally, when you make a saving throw against an effect that would decrease your Hit Point maximum, you have Advantage on the save. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Exploração] Artificial Form', 'Traço tradicional sugerido (Exploração).

You were made, not born, and your unnatural origin forever marks you as different. You are a Construct, but your enchanted form still benefits from healing spells. You can also heal yourself by spending Hit Dice during Short Rests and Long Rests, as normal.

You don’t need to eat, drink, sleep, or breathe. You must still be inactive for 8 hours during a Long Rest to gain its benefits.

Self-Repair. If you take this trait twice, when the Mending cantrip is cast on you, you can spend a Hit Die to regain a number of Hit Points equal to the roll of the die plus your Constitution modifier (minimum 1 Hit Point). You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Exploração] Inured to the Elements', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Interpretação] Embrace the Past', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Interpretação] Magical Insight', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'), '[Tradicional · Interpretação] Unnatural Healer', 'Traço tradicional sugerido (Interpretação).

Your innate healing abilities let you recover from some of the grimmest wounds. During a Long Rest, you can automatically reverse Grievous Wounds. Additionally, you can reattach any severed body parts (fingers, legs, tails, and so on), which are automatically restored at the end of the Long Rest. If your severed body parts aren’t available, you can replace them with the same body parts of another creature of the same general anatomy as you. If you wish to intentionally swap out body parts with replacements, you can sever your own body parts with no pain or discomfort.

The ability to make use of unusual body parts (for example, giving yourself the taloned paw of a lion if you lose a hand) are left to the GM’s discretion. In any event, swapping a severed body part for an unusual body part grants you no mechanical Advantages not covered by other traits (see “ Features and Traits ”).

Regenerative Healer. If you take this trait twice, you automatically reverse Permanent Wounds during a Long Rest. Additionally, you can restore any severed body part during a Long Rest, as if subject to the Regenerate spell. You can use this trait to create unusual regenerated body parts at the GM’s determination.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), 'The physical nature of a Dhampir is shaped by the creature they once were, and by the nature of their curse', 'The physical nature of a Dhampir is shaped by the creature they once were, and by the nature of their curse.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), 'Age', 'Age. The curse that creates a Dhampir makes them ageless, letting them ignore the passage of time—though they can succumb to death in many other ways.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), 'Size', 'Size. A Dhampir is the same size as the humanoid they were spawned from. You are Pequeno or Médio, as you determine.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), 'Speed', 'Speed. 9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Combate] Draining Attack', 'Traço tradicional sugerido (Combate).

As your enemy’s life force ebbs, you grow ever stronger. If you have the Natural Attack trait, each time you hit with an Unarmed Strike , you gain Temporary Hit Points equal to the damage dealt by the attack.

To the Dregs. If you take this trait twice, when you use Draining Attack, the target also takes a penalty to their Hit Point maximum equal to the damage dealt by the attack. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Combate] Natural Attack', 'Traço tradicional sugerido (Combate).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Combate] Well Protected', 'Traço tradicional sugerido (Combate).

Your ability to roll with even the worst attacks means that armor would only slow you down. When you are not wearing armor, your AC is equal to 13 + your Dexterity modifier.

Protective Cover. If you take this trait twice, when you make a Dexterity saving throw or are targeted by a ranged attack, you can use a Reaction to have Advantage on the saving throw or impose Disadvantage on the ranged attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Alternate Rules: Wounds and Resting

The Grim Hollow Campaign Guide contains alternate rules for resting and receiving both Grievous Wounds and Permanent Wounds. These alternate rules are meant to enhance game play in a dark fantasy world where the heroes have to overcome every sort of obstacle to achieve their goals.

Grievous Wounds are applied to characters that would be dropped to 0 Hit Points, but instead choose to gain a lingering wound that stays with them. These wounds remain until a character takes a Long Rest (see Resting below) and undergoes treatment by a physician or someone trained in Medicine .

Permanent Wounds occur when a creature takes multiple Grievous Wounds, or when a character dies and is brought back to life. The challenges of Permanent Wounds can be offset with certain magic items or prosthetics.

The dark-fantasy vibe of Grim Hollow necessitates a change to the effects of Short and Long Rests. Grievous Wounds can be healed by taking a Long Rest, but those rests in Grim Hollow take 32 hours of resting in a completely safe environment.

//', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Exploração] Climber', 'Traço tradicional sugerido (Exploração).

Sometimes staying away from what threatens you means getting clear of those threats. You have a Climb Speed equal to your Speed.

Wall Walker. If you take this trait twice, you can use your Climb Speed to move up, down, and across vertical surfaces and upside down along ceilings, while leaving your hands free.

Additionally, while using climbing movement, you can use the Dash action as a Bonus Action. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Exploração] Darkvision', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Interpretação] Eager Deceiver', 'Traço tradicional sugerido (Interpretação).

You long ago learned that being open with others only gives them power over you. You have proficiency in the Deception skill.

Expert Deceiver. If you take this trait twice, you have Advantage on Deception checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Interpretação] Magical Savant', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'), '[Tradicional · Interpretação] Magical Savvy', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), 'Though their presence in the world is shaped by magic, the forms of the Disembodied appear much as they did before the disaster that spawned them', 'Though their presence in the world is shaped by magic, the forms of the Disembodied appear much as they did before the disaster that spawned them.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), 'Age', 'Age. The Disembodied mature at a much slower rate than the Humanoids they once were, with their life expectancy doubled or even tripled.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), 'Size', 'Size. Disembodied appear as translucent versions of their former selves, their nearly insubstantial nature reducing their weight to a quarter of what it was. Your size is Pequeno or Médio, as you determine.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), 'Speed', 'Speed. 9 m. If your size is Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), 'The day Ulmyr’s Gate fell, the area eerily was quiet…for a time', 'The day Ulmyr’s Gate fell, the area eerily was quiet…for a time.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Combate] Magical Fortification', 'Traço tradicional sugerido (Combate).

The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.

Extended Fortification. If you take this trait multiple times, you have Advantage on saving throws using a new ability score each time.

Additionally, if you fail a saving throw against a spell or other magical effect and you do not have proficiency with that saving throw, you can use your Reaction to reroll the save. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Combate] Master of Distraction', 'Traço tradicional sugerido (Combate).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Combate] Out of Phase', 'Traço tradicional sugerido (Combate).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Exploração] Ethereal Fade', 'Traço tradicional sugerido (Exploração).

Shifting away from the mortal world lets you move through and observe that world unseen. As a Magic action, you fade from the Material Plane into the Ethereal Plane for 1 minute. While you remain in this state, you can’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. You can move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappear in the Material Plane in the closest unoccupied space to where you faded from. You can end the effect early as a Bonus Action. You regain the use of this feature again when you finish a Long Rest.

Ethereal Focus. If you take this trait twice, you have Advantage when making Wisdom checks as part of a Search Action.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Exploração] Inured to the Elements', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Interpretação] Magical Insight', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Interpretação] Magical Savant', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'), '[Tradicional · Interpretação] Magical Savvy', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), 'Though mortal, Downcast are still touched by the celestial nature that has been taken from them', 'Though mortal, Downcast are still touched by the celestial nature that has been taken from them.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), 'Age', 'Age. Stripped of their immortality, the Downcast nevertheless possess long lifespans to rival even the elves. A Downcast reaches maturity in their late teens, but can live up to 800 years.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), 'Size', 'Size. Downcast generally range from 5 to 1.8 m tall and have a wide range of body types. Your size is Médio.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), 'Speed', 'Speed. 9 m.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), 'Brother Adovald is no longer welcome in the sanctuary', 'Brother Adovald is no longer welcome in the sanctuary. When last we spoke, he had some…unkind words for the Arch Seraphs.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Combate] Divine Sangromancy', 'Traço tradicional sugerido (Combate).

A connection to the life force of others lets you shape that force to their benefit. Whenever an allied creature within 30 feet of you regains Hit Points, you can spend a Hit Die and add the roll of the die to the number of Hit Points gained by the ally.

Sangromancy Savant. If you take this trait twice, when you use Divine Sangromancy, you also regain Hit Points equal to your Hit Die roll.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Combate] Touch of Life', 'Traço tradicional sugerido (Combate).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Exploração] Inured to the Elements', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Exploração] Meditative Rest', 'Traço tradicional sugerido (Exploração).

Sleep is a luxury you’ve never needed to afford. When you rest, you meditate deeply for 4 hours, dreaming but remaining conscious. After resting in this way, you gain the same benefit that other humanoids do from 8 hours of sleep.

Restorative Rest. If you take this trait twice, you need to spend only 2 hours in your meditation to gain the benefit of 8 hours of sleep, and you gain a d6 at the end of each Long Rest. Before the end of your next Long Rest, you can roll the d6 and add it to any d20 Test you make. You can decide to roll the d6 after the d20 Test is made, but you must do so before the outcome of the roll is known.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Exploração] Tireless', 'Traço tradicional sugerido (Exploração).

An innate resilience lets you shake off conditions that would take others down. You have Advantage on saving throws connected to gaining or removing Exhaustion levels.

Vigorous. If you take this trait twice, when you fail a saving throw against Exhaustion, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Interpretação] Magical Savant', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Interpretação] Magical Savvy', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'), '[Tradicional · Interpretação] Moved by Faith', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), 'Enchanted with powerful faerie magic, Wechselkind are unique among other Humanoids', 'Enchanted with powerful faerie magic, Wechselkind are unique among other Humanoids.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), 'Age', 'Age. Wechselkind do not age as normal creatures do, forever trapped in the doll-like visage of their creation. Their maximum age is a function of natural wear and damage, and they are immune to magical aging effects.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), 'Size', 'Size. Built to resemble a child, Wechselkind are between 2 and 0.9 m tall and weigh between 35 and 55 pounds. Your size is Pequeno.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), 'Speed', 'Speed. 9 m. You can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), 'They’re astoundingly quick studies and eager assistants', 'They’re astoundingly quick studies and eager assistants. Thankfully, our patients don’t seem to mind the splinters.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), 'Visão geral', '—Delia Phaxus, Master Physician', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Combate] Creature Cover', 'Traço tradicional sugerido (Combate).

By slipping behind enemies or allies alike, you are able to fade from view with ease. You can take the Hide action even when you have Half Cover from a creature, as long as that creature is of a size larger than you.

Subtle Cover. If you take this trait twice, you can take the Hide action when you have Half Cover from a creature the same size as you.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Combate] Magical Fortification', 'Traço tradicional sugerido (Combate).

The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.

Extended Fortification. If you take this trait multiple times, you have Advantage on saving throws using a new ability score each time.

Additionally, if you fail a saving throw against a spell or other magical effect and you do not have proficiency with that saving throw, you can use your Reaction to reroll the save. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Exploração] Artificial Form', 'Traço tradicional sugerido (Exploração).

You were made, not born, and your unnatural origin forever marks you as different. You are a Construct, but your enchanted form still benefits from healing spells. You can also heal yourself by spending Hit Dice during Short Rests and Long Rests, as normal.

You don’t need to eat, drink, sleep, or breathe. You must still be inactive for 8 hours during a Long Rest to gain its benefits.

Self-Repair. If you take this trait twice, when the Mending cantrip is cast on you, you can spend a Hit Die to regain a number of Hit Points equal to the roll of the die plus your Constitution modifier (minimum 1 Hit Point). You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Exploração] Helping Hand', 'Traço tradicional sugerido (Exploração).

You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)

Helpful Tactics. If you take this trait twice, when you use Helping Hand, you can also assist an ally making an attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest. (This is a Combat trait.)', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Exploração] Pass Through', 'Traço tradicional sugerido (Exploração).

Making use of constant movement lets you minimize the threat of larger foes. You can move through the space of any creature at least one size larger than you.

Nimble Passage. If you take this trait twice, you do not treat another creature’s space as Difficult Terrain .', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Interpretação] Magical Savant', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Interpretação] Magical Savvy', 'Traço tradicional sugerido (Interpretação).

Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'), '[Tradicional · Interpretação] Intuitive Acrobat', 'Traço tradicional sugerido (Interpretação).

Staying loose and limber means being able to get out of even the tightest spots when your life is on the line. You have proficiency in the Acrobatics skill.

Stunt Expert. If you take this trait twice, you have Advantage on Acrobatics checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), 'Wulven can arise among any other culture or folk, and draw on the physical features of those folk', 'Wulven can arise among any other culture or folk, and draw on the physical features of those folk.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), 'Age', 'Age. Wulven mature at the same rate as others of their original heritage, but the magic that spawns them lessens the debilitating effects of aging, and they remain fit even in their later years.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), 'Size', 'Size. Wulven are the same general height as others of their original heritage, but are often stockier, more muscular, or lither, depending on the nature of the curse that touches them. Your size is Pequeno or Médio, as you determine.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), 'Speed', 'Speed. 9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Combate] Hunter’s Instinct', 'Traço tradicional sugerido (Combate).

You summon a surge of ferocity when your prey least expects it. At the end of each Long Rest, you gain a number of d8s equal to your Proficiency Bonus. When you make an attack with a weapon or an Unarmed Strike , you can roll a d8 and add it to either the attack roll or the damage roll. If you add it to the d20 roll, you can decide to roll the d8 after the d20 roll is made, but you must do so before the outcome of the roll is known.

Relentless Instinct. If you take this trait twice, whenever you use Hunter’s Instinct for an attack roll, if the attack roll misses, you retain the d8 and can use it again.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Combate] Natural Attack (Claws)', 'Traço tradicional sugerido (Combate).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Combate] Pack Hunter', 'Traço tradicional sugerido (Combate).

Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 10 feet of you is about to make an attack roll or a saving throw, you can use a Reaction to grant that ally Advantage on the attack or save. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Pack Leader. If you take this trait twice, Pack Hunter can be triggered by any ally within 30 feet of you. Additionally, if the attack roll misses or the saving throw fails, you don’t lose that usage of Pack Hunter.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Exploração] Burst of Speed', 'Traço tradicional sugerido (Exploração).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Exploração] Climber', 'Traço tradicional sugerido (Exploração).

Sometimes staying away from what threatens you means getting clear of those threats. You have a Climb Speed equal to your Speed.

Wall Walker. If you take this trait twice, you can use your Climb Speed to move up, down, and across vertical surfaces and upside down along ceilings, while leaving your hands free.

Additionally, while using climbing movement, you can use the Dash action as a Bonus Action. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Interpretação] Athlete’s Spirit', 'Traço tradicional sugerido (Interpretação).

Your reserves of physical power have kept you alive on more than one occasion. You have proficiency in the Athletics skill.

Athlete’s Resolve. If you take this trait twice, you have Advantage on Athletics checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Interpretação] Inborn Perception', 'Traço tradicional sugerido (Interpretação).', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'), '[Tradicional · Interpretação] Nature’s Voice', 'Traço tradicional sugerido (Interpretação).

Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, you can communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and you can’t understand or learn detailed information from them.

Primal Voice. If you take this trait twice, you have Advantage on ability checks made as part of an Influence action to interact with a Beast or Plant creature.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] A Sight to Behold.', 'When you desire to stand out, you have a natural gift for impressing others. You have proficiency in the Performance skill.

A Sight to Behold. If you take this trait twice, you have Advantage on Performance checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: A Sight to Behold.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Adaptive Awareness.', 'The natural world is a dangerous place, and your connection to specific parts of that world grants you an edge in survival. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, whenever you make an ability check to assess structures, monuments, or natural features; to find food or drinkable water; or to track creatures, you are considered to have proficiency in the appropriate skill for the check, and you add double your Proficiency Bonus to the check instead of your normal bonus.

Adaptive Awareness. If you take this trait multiple times, you gain its benefit for a new environment each time.

Additionally, when you make an ability check using Environmental Awareness, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Adaptive Awareness.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Animal Ally.', 'Time spent among beasts has gifted you a way with those creatures. You have proficiency in the Animal Handling skill.

Animal Ally. If you take this trait twice, you have Advantage on Animal Handling checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Something must be done about that elf. Last time I confronted her, she sicced my own dog on me.

—Disgruntled Neighbor

Tomar novamente: Animal Ally.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Artisanal Expertise.', 'You revere the crafting skill of ancestors long dead. Choose an Artisan’s Tool. You have proficiency with that tool.

Artisanal Expertise. If you take this trait multiple times, you gain proficiency with a new tool each time.

Additionally, you have Advantage on ability checks made using any tool you selected with Artisanal Focus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Artisanal Expertise.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Astute Slip.', 'Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. You can take the Hide action as a Bonus Action on each of your turns. You must have appropriate cover to attempt to hide, as normal.

Astute Slip. If you take this trait twice, you have Advantage on Stealth checks you make with the Hide action when you use Quick Slip.

Tomar novamente: Astute Slip.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Athlete’s Resolve.', 'Your reserves of physical power have kept you alive on more than one occasion. You have proficiency in the Athletics skill.

Athlete’s Resolve. If you take this trait twice, you have Advantage on Athletics checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Athlete’s Resolve.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Battlefield Dominance.', 'When foes attempt to press you in melee, they do so at their peril. Other creatures provoke Opportunity Attacks from you whenever they move into your reach, in addition to when they move out of your reach.

Battlefield Dominance. If you take this trait twice, you have Advantage on Opportunity Attacks. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Battlefield Dominance.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Bond with Nature.', 'You’ve learned that paying attention to the environment around you is the best way to predict its threats. You have proficiency in the Nature skill.

Bond with Nature. If you take this trait twice, you have Advantage on Nature checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Born Lucky.', 'Fortune favors you at times when a threat might send you down. When you fail a saving throw, you can use your Reaction to roll a d4 and add it to the save, potentially turning it into a success. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Born Lucky. If you take this trait twice, you roll a d8 instead of a d4 when you use Timely Boon.

Tomar novamente: Born Lucky.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Calculated Disappearance.', 'When trouble comes for you, you excel at making sure it can’t find you. You have proficiency in the Stealth skill.

Calculated Disappearance. If you take this trait twice, you have Advantage on Stealth checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Centered Edge.', 'By focusing your inner strength, you gain a needed edge. As a Bonus Action, you grant yourself Advantage on an attack roll or ability check you make before the start of your next turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Centered Edge. If you take this trait twice, when you succeed on the attack roll or ability check made while using Centered, you can choose one creature within 30 feet of you. That creature has Advantage on the next attack roll or ability check they make before the start of your next turn.

Tomar novamente: Centered Edge.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Combat Doctor.', 'When others suffer, you are there to help. You have proficiency in the Medicine skill.

Combat Doctor. If you take this trait twice, you have Advantage on Medicine checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Combat Doctor.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Crafter’s Cunning.', 'The history of Etharis is written in relics, and you read that history better than most. When you make a History check related to any object (an item, device, building, or material) and you have proficiency in an Artisan’s Tool associated with creating that object, you are considered proficient in History and you add double your Proficiency Bonus to the check instead of your normal bonus.

Crafter’s Cunning. If you take this trait twice, you have Advantage on the History checks you make with Crafter’s Eye. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Crafter’s Cunning.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Damage Immunity.', 'Exposure to the worst effects of a specific energy has given you a tolerance to its effects. You have Resistance to one of the following damage types of your choice: Acid, Cold, Fire, Lightning, Poison, or Thunder.

Damage Immunity. If you take this trait twice, as a Reaction to taking damage of the type you chose for Damage Resistance, you gain Immunity to that damage type until the end of your next turn. You regain the use this feature when you finish a Short Rest.

Tomar novamente: Damage Immunity.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Deep Lore.', 'The lessons of the past are harsh, but learning those lessons might give you the best insight for navigating the future. You have proficiency in the History skill.

Deep Lore. If you take this trait twice, you have Advantage on History checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Determined Hearing.', 'Even as destruction rains down around you, your hearing stays sharp. You have Advantage on saving throws against having the Deafened condition.

Determined Hearing. If you take this trait twice, you have Advantage on Perception checks involving hearing. Additionally, when you fail a saving throw against being Deafened, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Determined Hearing.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Determined Survivor.', 'The wilds of Etharis have claimed many who lack the skill to navigate them. You have proficiency in the Survival skill.

Determined Survivor. If you take this trait twice, you have Advantage on Survival checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Determined Survivor.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Endless Breath.', 'Whether trapped under black water or resisting poisonous fumes, you refuse to give in. You can hold your breath for up to 1 hour.

Endless Breath. If you take this trait twice, you can hold your breath for up to 8 hours.

Tomar novamente: Endless Breath.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Ethereal Focus.', 'Shifting away from the mortal world lets you move through and observe that world unseen. As a Magic action, you fade from the Material Plane into the Ethereal Plane for 1 minute. While you remain in this state, you can’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. You can move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappear in the Material Plane in the closest unoccupied space to where you faded from. You can end the effect early as a Bonus Action. You regain the use of this feature again when you finish a Long Rest.

Ethereal Focus. If you take this trait twice, you have Advantage when making Wisdom checks as part of a Search Action.

Tomar novamente: Ethereal Focus.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Even Larger.', 'Foes that outsize you quickly learn to fear your wrath. If you hit a creature that is one size larger than you, you can choose to deal extra damage to the creature equal to your Proficiency Bonus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Even Larger. If you take this trait twice, Larger Target applies to creatures of any size larger than you.

Tomar novamente: Even Larger.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Exceptional Insight.', 'Those who attempt to deceive you do so in vain. You have proficiency in the Insight skill.

Exceptional Insight. If you take this trait twice, you have Advantage on Insight checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Expert Deceiver.', 'You long ago learned that being open with others only gives them power over you. You have proficiency in the Deception skill.

Expert Deceiver. If you take this trait twice, you have Advantage on Deception checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Expert Deceiver.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Expert Improviser.', 'When needs demand, you get the job done better than most. As a Bonus Action, choose one skill or tool that you don’t have proficiency with. You have proficiency in that skill or with that tool for 1 hour. You regain the use of this feature when you finish a Long Rest.

Expert Improviser. If you take this trait twice, you have Advantage on ability checks you make using the skill or tool you select with Improviser. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Expert Improviser.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Expert Orientation.', 'A single misstep can lead to ruin, but your instincts for direction keep you from going astray. You always know which way is north, and you can reckon a cardinal direction of the GM’s determination while on other planes. Additionally, you have Advantage on ability checks made to avoid becoming lost, to navigate, or to track.

Expert Orientation. If you take this trait twice, when you fail an ability check made to avoid becoming lost, to navigate, or to track, you can choose to succeed instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Expert Orientation.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Exquisite Legerdemain.', 'You have learned the value of being able to manipulate the world around you without attracting the notice of others. You have proficiency in the Sleight of Hand skill.

Exquisite Legerdemain. If you take this trait twice, you have Advantage on Sleight of Hand checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Exquisite Legerdemain.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Extended Fortification.', 'The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.

Extended Fortification. If you take this trait multiple times, you have Advantage on saving throws using a new ability score each time.

Additionally, if you fail a saving throw against a spell or other magical effect and you do not have proficiency with that saving throw, you can use your Reaction to reroll the save. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Extended Fortification.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Extra Tough.', 'An intrinsic hardiness marks you as one born for battle. Your Hit Point maximum increases by 1, and it increases by 1 each time you gain a level.

Extra Tough. If you take this trait twice, your Hit Point maximum increases by 2 instead of 1, and it increases by 2 each time you gain a level.

Additionally, when you make a saving throw against an effect that would decrease your Hit Point maximum, you have Advantage on the save. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Extra Tough.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Extreme Resilience.', 'When you don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest you can get. When taking a Short Rest, you can choose to sleep for 1 hour. If you do so, you reduce your Exhaustion by one level and regain a Hit Point Die in addition to the other benefits of a Short Rest.

Extreme Resilience. If you take this trait twice, when using Power Nap, you can choose to regain a single resource that would normally refresh on a Long Rest. For example, a Sorcerer could choose to regain a Sorcery Point on a Short Rest.

Tomar novamente: Extreme Resilience.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Faultless Shroud.', 'With any degree of obscuration, your instinctive ability to conceal yourself lets you avoid your enemies’ notice. You can take the Hide action even when you are only Lightly Obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.

Faultless Shroud. If you take this trait twice, you have Advantage on Stealth checks using the Hide action while using Shroud of the Wild.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Focused Edge.', 'No matter how badly beaten down you are, you find the will to keep fighting when you most need it. As a Reaction after you take damage, you can roll a number of d6s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Focused Edge. If you take this trait twice, you can reroll 1s and 2s when you use Focused Reserves, but you must use the new rolls.

Tomar novamente: Focused Edge.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Focused Initiative.', 'Danger is never far away from you, and you are always ready for it. You add your Proficiency Bonus to your Initiative rolls.

Focused Initiative. If you take this trait twice, when you roll Initiative, you can treat a roll of 9 or lower as if you rolled a 10.

Tomar novamente: Focused Initiative.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Focused Mastery.', 'Your discipline and focus give you an edge that others lack. Choose one of your skill or tool proficiencies. You have Expertise on ability checks made using the chosen proficiency.

Focused Mastery. If you take this trait multiple times, you gain its benefit for a new skill proficiency or tool proficiency each time.

Additionally, when you make a check using a skill or tool for which you’ve taken Masterful Aptitude, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Focused Mastery.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Focused Ruthlessness.', 'A creature that gets the drop on you is met with a swift and brutal reply. When you take damage from a creature within your reach, you can use your Reaction to make a melee attack with a weapon or an Unarmed Strike against that creature. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Focused Ruthlessness. If you take this trait twice, you have Advantage on attack rolls made using Ruthless Response.

Tomar novamente: Focused Ruthlessness.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Force of Faith.', 'The grimmest myths and legends of the past hold the keys to shaping the future. You have proficiency in the Religion skill.

Force of Faith. If you take this trait twice, you have Advantage on Religion checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Full-Speed Squeeze.', 'With an effort of will, you contort your body into the tightest spaces. You can squeeze through a space that is large enough for a creature two sizes smaller than you, rather than one size smaller.

Full-Speed Squeeze. If you take this trait twice, squeezing does not cost you additional movement, and you do not have Disadvantage on attack rolls and Dexterity saving throws while squeezing.

Tomar novamente: Full-Speed Squeeze.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Furious Charge.', 'The fury with which you throw yourself into battle forces your foes to feel your wrath. If you move at least 20 feet straight toward a target and then hit it with a melee attack with a weapon or an Unarmed Strike on the same turn, you can make another attack against the same target as a Bonus Action with the same weapon.

Furious Charge. If you take this trait twice, when you use Charging Attack, you have Advantage on all attacks after the triggering movement until the end of your turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Furious Charge.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Furious Speed.', 'The many things that want to kill you must catch you first. On your turn, you can increase your Speed by 30 feet until the end of your turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Furious Speed. If you take this trait twice, on a turn when you use Burst of Speed, you don’t provoke Opportunity Attacks.

On the battlefield, quick feet are the best suit of armor you could ask for. If an enemy can’t reach you, it can’t hurt you. Now pick up those knees!

—Militia Drillmaster', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Hard to Kill.', 'Your enemies might put you down, but you are never down for long. You have Advantage on Death Saving Throws.

Hard to Kill. If you take this trait twice, when you drop to 0 Hit Points but don’t die outright, you remain conscious. You must make Death Saving Throws as normal while at 0 Hit Points, and you suffer a Death Saving Throw failure each time you take any damage, but you can otherwise act freely. You can’t become Stable while you remain at 0 Hit Points in this way.

Tomar novamente: Hard to Kill.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Heavy Armor Training.', 'The pounding you routinely take in combat requires a formidable layer of defense. You have training with Medium armor and with Shields.

Heavy Armor Training. If you take this trait twice, you have training with Heavy armor.

Tomar novamente: Heavy Armor Training.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Helpful Tactics.', 'You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)

Helpful Tactics. If you take this trait twice, when you use Helping Hand, you can also assist an ally making an attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest. (This is a Combat trait.)

Tomar novamente: Helpful Tactics†.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Hindering Distraction.', 'You draw your foes’ attention to you, intending it to be the last diversion they ever see. As an Influence action, you put on a tactical display (bravado, cowardice, confusion, or some other tactic) that gets your enemies’ attention. Until the end of your next turn, any attack on an enemy within 10 feet of you that could see you when you took the Influence action is made with Advantage . You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Hindering Distraction. If you take this trait twice, when you use Master of Distraction, one affected enemy of your choice also has Disadvantage on attack rolls it makes against any of your allies until the end of your next turn.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Immune to the Elements.', 'Even beneath scorching sun and in freezing cold, you hold yourself strong. You have Advantage on Constitution saving throws made to resist the effects of extreme cold or extreme heat.

Immune to the Elements. If you take this trait twice, you automatically succeed on Constitution saving throws to resist the effects of extreme cold or extreme heat.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Immutable Mind.', 'Your strength of will protects you from magic that would corrupt your mind. You have Advantage on saving throws against being Charmed .

Immutable Mind. If you take this trait twice, when you fail a saving throw against being Charmed, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Immutable Mind.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Improved Darkvision.', 'A life spent in shadow has made you grow accustomed to the gloom. You can see in Dim Light within 60 feet of you as if it were Bright Light , and in Darkness within 60 feet of you as if it were Dim Light. You can’t discern color in Darkness, only shades of gray.

Improved Darkvision. If you take this trait twice, the range of your Darkvision increases to 120 feet.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Incomparable Roar.', 'Your battle cry can cause even the most formidable foes to quail before you. As a Bonus Action, you emit a roar, shout, or other loud vocal outburst. Each creature of your choice within 10 feet of you that can hear you must succeed on a Wisdom saving throw (DC = 8 + your Proficiency Bonus + your Constitution modifier) or have the Frightened condtion until the end of your next turn. You regain the use of this feature when you finish a Long Rest.

Incomparable Roar. If you take this trait twice, when you use Menacing Roar, one target of your choice has Disadvantage on the saving throw.

Tomar novamente: Incomparable Roar.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Incredible Leap.', 'Threats on the ground are of little concern as you leap over them with ease. You can make a Long Jump of up to 20 feet and a High Jump of up to 10 feet, with or without a running start. If your Speed is less than the distance you can Long Jump, you can leap only a distance equal to your Speed.

Incredible Leap. If you take this trait twice, you can make a Long Jump of up to 30 feet and a High Jump of up to 15 feet, as limited by your speed.

Additionally, when you jump out of another creature’s reach, the movement of the jump does not provoke Opportunity Attacks from that creature. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Incredible Leap.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Infectious Bravery.', 'The horrors you’ve lived through have hardened you. You have Advantage on saving throws to avoid being Frightened .

Infectious Bravery. If you take this trait twice, you can use your Reaction to bolster the spirits of your allies, granting one ally who can see or hear you Advantage on a saving throw against being Frightened. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Infectious Bravery.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Language Expert.', 'The advantages of mastering the languages of enemies and allies alike are clear to you. You learn two languages of your choice.

Language Expert. If you take this trait multiple times, you learn two new languages each time.

Additionally, you have Advantage on Influence action ability checks made to interact with another creature using any language you selected with Polyglot. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Language Expert.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Light Armor Expertise.', 'Dealing with the threats you face requires the right combination of protection and movement. You have training with Light armor.

Light Armor Expertise. If you take this trait twice, your AC increases by 1 while wearing Light armor.

Tomar novamente: Light Armor Expertise.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Long Fade.', 'You have learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. As a Bonus Action, you can take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.

You become visible at the start of your next turn unless you have moved into a position that allows you to use the Hide action normally. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Long Fade. If you take this trait twice, you have Advantage on your ability check when you take the Hide action from Fade Away, and you become visible at the end of your next turn instead of the start of your next turn.

Tomar novamente: Long Fade.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Magical Historian.', 'Magic is power in the right hands, and those hands are yours. You have proficiency in the Arcana skill.

Magical Historian. If you take this trait twice, you have Advantage on Arcana checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Magical Savant.', 'Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.

Magical Savant. If you take this trait multiple times, you select a different cantrip each time, or you can select a level 1 spell from the same list as a cantrip you have previously chosen. If you select a level 1 spell, you can cast it once without expending a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. If you have levels in the associated spellcasting class, you always have this spell prepared, and it doesn’t count against the number of spells you can prepare each day.

Tomar novamente: Magical Savant.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Master Artisan.', 'You’ve never known the luxury of always having the gear you need, but you have more than learned to make do. If you possess Artisan’s Tools with which you have proficiency, and if you have access to appropriate raw materials and any additional necessary equipment (as the GM determines), you can use a Short Rest to craft any one nonmagical item worth 10 GP or less, including:

The gear you create is workable but not high quality, and can’t be sold except as the GM determines.

Master Artisan. If you take this trait twice, you can use Impromptu Artisan during a Long Rest, during which you craft one nonmagical item worth 50 GP or less.

Tomar novamente: Master Artisan.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Master Manipulator.', 'The weak-willed around you are easy targets for your manipulation. By conversing with a nonhostile creature for at least 1 minute, you can attempt to charm them. The creature must succeed on a Wisdom saving throw (DC = 8 + your Charisma modifier + your Proficiency Bonus) or have the Charmed condition for 1 hour. At the GM’s discretion, you also learn one piece of information that the target knows that relates to the topic of conversation while you speak to them. Regardless of whether or not the target succeeds on the saving throw, they remain unaware of your attempt. You regain use of this feature when you finish a Short or Long Rest.

Master Manipulator. If you take this trait twice, a creature has Disadvantage on the saving throw, and it has the Charmed condition for 8 hours on a failed save.

Tomar novamente: Master Manipulator.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Master of Fortune.', 'The luck you carry will see you through the worst Etharis has to offer. When you roll a 1 on a D20 Test, you can reroll that die but must use the new roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Master of Fortune. If you take this trait twice, you have Advantage on the reroll made with Lucky.

Tomar novamente: Master of Fortune.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Maximum Critical.', 'When fortune favors your blade, you know how to make it count. When you score a Critical Hit with a melee attack with a weapon or an Unarmed Strike , you can roll one of the weapon’s damage dice one additional time and add it to the extra damage of the Critical Hit.

Maximum Critical. If you take this trait twice, when you use Awesome Critical, you can add the maximum of the weapon’s original damage dice and the extra Awesome Critical die to the extra damage of the Critical Hit, rather than rolling them. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Maximum Critical.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Mobile Bastion.', 'Focusing all your resolve, you stand fast and watch your enemies flail against your defenses. As a Magic action, you become motionless and gain the following effects:

You can’t take actions, and you can’t use your Bonus Action except to end the effect of this trait.

Mobile Bastion. If you take this trait twice, when you use Personal Bastion, your Speed is reduced to half your normal Speed (rounded down), you do not have Disadvantage on Dexterity saving throws, and you can use Bonus Actions.

Tomar novamente: Mobile Bastion.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Moving Insight.', 'A lifetime spent wandering lets you judge when others’ movement works to your benefit. When you make an attack roll against a creature or make a saving throw against a creature’s attack, spell, or ability, you can use a Reaction to have Advantage on the attack roll or saving throw if that creature moved since the end of your last turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Moving Insight. If you take this trait twice, Enemy in Motion also lets you use your Reaction to affect an ally''s attack roll or saving throw if your ally is within 30 feet.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Nimble Passage.', 'Making use of constant movement lets you minimize the threat of larger foes. You can move through the space of any creature at least one size larger than you.

Nimble Passage. If you take this trait twice, you do not treat another creature’s space as Difficult Terrain .

Tomar novamente: Nimble Passage.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Opportune Reach.', 'As you hurl yourself into battle, your foes discover that trying to keep away from you won’t save them. Your reach increases by 5 feet. This extra reach doesn’t apply to Opportunity Attacks.

Opportune Reach. If you take this trait twice, your extra reach from Reach Attack applies to Opportunity Attacks.

Tomar novamente: Opportune Reach.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Overwhelming Shove.', 'Your powerful blows send your targets reeling. When you hit a creature no more than one size larger than you with a melee attack, you can use a Bonus Action to attempt to shove that creature. The target must succeed on a Strength or Dexterity saving throw (DC = 8 + your Strength modifier + your Proficiency Bonus) or be pushed up to 10 feet away from you.

Overwhelming Shove. If you take this trait twice, when you use Mighty Shove, the target creature has Disadvantage on the saving throw.

Tomar novamente: Overwhelming Shove.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Pack Instinct.', 'Staying close to your allies in combat makes you even more dangerous. When you start your turn with at least one ally who isn’t Incapacitated within 5 feet of another creature you can see, you can use your Reaction to have Advantage on attack rolls against that creature until the end of your turn.

Pack Instinct. If you take this trait twice, gaining Advantage from Pack Tactics requires no action.

Tomar novamente: Pack Instinct.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Pack Leader.', 'Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 10 feet of you is about to make an attack roll or a saving throw, you can use a Reaction to grant that ally Advantage on the attack or save. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Pack Leader. If you take this trait twice, Pack Hunter can be triggered by any ally within 30 feet of you. Additionally, if the attack roll misses or the saving throw fails, you don’t lose that usage of Pack Hunter.

Tomar novamente: Pack Leader.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Phase Shift.', 'Your corporeal presence shifts and fades, softening your enemies’ ability to harm you. As a Bonus Action, for 1 minute, all creatures have Disadvantage on attack rolls against you, and you can move through other creature’s spaces without treating them as Difficult Terrain. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Phase Shift. If you take this trait twice, when you use Out of Phase, you can extend its benefit to any ally within 10 feet of you.

Clear a special cell for this one. She’s got tricks.

—Castinellan Jailor', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Piercing Perception.', 'The best way to avoid danger is to make sure you’re the first person to notice it. You have proficiency in the Perception skill.

Piercing Perception. If you take this trait twice, you have Advantage on Perception checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Poison Indemnity.', 'Your exceptional fortitude lets you shrug off the effects of even the worst toxins. You have Advantage on saving throws against being Poisoned .

Poison Indemnity. If you take this trait twice, when you fail a saving throw against being Poisoned, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Poison Indemnity.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Potent Breath.', 'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. When you select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 5 feet wide and 30 feet long, or a 15-foot Cone .

When you use a Magic action to expel your Breath Weapon, each creature in the area of effect must make a Dexterity saving throw (DC = 8 + your Constitution modifier + your Proficiency Bonus). A target creature takes 1d8 damage of the chosen type on a failed save, or half as much damage on a successful one. This damage increases by 1d8 when you reach character levels 5 (2d8), 11 (3d8), and 17 (4d8).

You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Potent Breath. If you take this trait multiple times, you gain an additional breath weapon each time, with its own number of uses, damage type, and area of effect.

Additionally, when you use any of your Breath Weapons, one target of your choice has Disadvantage on the saving throw. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Potent Breath.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Powerful Shove.', 'Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight you can push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)

Powerful Shove. If you take this trait twice, you can move or knock foes prone with ease. When you use Unarmed Attack to shove a creature 5 feet or give it the Prone condition, the target has Disadvantage on the saving throw. (This is a Combat trait.)

Tomar novamente: Powerful Shove†.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Primal Voice.', 'Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, you can communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and you can’t understand or learn detailed information from them.

Primal Voice. If you take this trait twice, you have Advantage on ability checks made as part of an Influence action to interact with a Beast or Plant creature.

Tomar novamente: Primal Voice.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Protective Cover.', 'Your ability to roll with even the worst attacks means that armor would only slow you down. When you are not wearing armor, your AC is equal to 13 + your Dexterity modifier.

Protective Cover. If you take this trait twice, when you make a Dexterity saving throw or are targeted by a ranged attack, you can use a Reaction to have Advantage on the saving throw or impose Disadvantage on the ranged attack roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Alternate Rules: Wounds and Resting

The Grim Hollow Campaign Guide contains alternate rules for resting and receiving both Grievous Wounds and Permanent Wounds. These alternate rules are meant to enhance game play in a dark fantasy world where the heroes have to overcome every sort of obstacle to achieve their goals.

Grievous Wounds are applied to characters that would be dropped to 0 Hit Points, but instead choose to gain a lingering wound that stays with them. These wounds remain until a character takes a Long Rest (see Resting below) and undergoes treatment by a physician or someone trained in Medicine .

Permanent Wounds occur when a creature takes multiple Grievous Wounds, or when a character dies and is brought back to life. The challenges of Permanent Wounds can be offset with certain magic items or prosthetics.

The dark-fantasy vibe of Grim Hollow necessitates a change to the effects of Short and Long Rests. Grievous Wounds can be healed by taking a Long Rest, but those rests in Grim Hollow take 32 hours of resting in a completely safe environment.

//

Tomar novamente: Protective Cover.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Quickened Swim.', 'You are in your element while in the water, moving with grace and ease. You have a Swim Speed equal to your Speed.

Quickened Swim. If you take this trait twice, you can use the Dash action as a Bonus Action while swimming.

Tomar novamente: Quickened Swim.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Reawakened.', 'The dangers of Etharis have given you a focus that allows you to shrug off debilitating magical effects. You automatically succeed on saving throws against magical effects that would give you the Incapacitated , Stunned , or Unconscious conditions. This does not include effects that leave you Unconscious because you are reduced to 0 Hit Points.

Reawakened. If you take this trait twice, you also have Advantage on Intelligence, Wisdom, and Charisma saving throws.

Tomar novamente: Reawakened.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Regenerative Healer.', 'Your innate healing abilities let you recover from some of the grimmest wounds. During a Long Rest, you can automatically reverse Grievous Wounds. Additionally, you can reattach any severed body parts (fingers, legs, tails, and so on), which are automatically restored at the end of the Long Rest. If your severed body parts aren’t available, you can replace them with the same body parts of another creature of the same general anatomy as you. If you wish to intentionally swap out body parts with replacements, you can sever your own body parts with no pain or discomfort.

The ability to make use of unusual body parts (for example, giving yourself the taloned paw of a lion if you lose a hand) are left to the GM’s discretion. In any event, swapping a severed body part for an unusual body part grants you no mechanical Advantages not covered by other traits (see “ Features and Traits ”).

Regenerative Healer. If you take this trait twice, you automatically reverse Permanent Wounds during a Long Rest. Additionally, you can restore any severed body part during a Long Rest, as if subject to the Regenerate spell. You can use this trait to create unusual regenerated body parts at the GM’s determination.

Tomar novamente: Regenerative Healer.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Relentless Instinct.', 'You summon a surge of ferocity when your prey least expects it. At the end of each Long Rest, you gain a number of d8s equal to your Proficiency Bonus. When you make an attack with a weapon or an Unarmed Strike , you can roll a d8 and add it to either the attack roll or the damage roll. If you add it to the d20 roll, you can decide to roll the d8 after the d20 roll is made, but you must do so before the outcome of the roll is known.

Relentless Instinct. If you take this trait twice, whenever you use Hunter’s Instinct for an attack roll, if the attack roll misses, you retain the d8 and can use it again.

Tomar novamente: Relentless Instinct.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Remarkable Driver.', 'The roads and waterways of Etharis are often no less dangerous than the open wilderness, and you dedicate yourself to moving others safely on those routes. You have proficiency with Navigator’s Tools , and you have Advantage on ability checks made to drive a vehicle.

Remarkable Driver. If you take this trait twice, you can make checks involving driving a vehicle that require an action without having to use your action. You can only get this free use once per round.

Tomar novamente: Remarkable Driver.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Resolute Sight.', 'Any foe you can see is a foe you can take down—so you make sure nothing prevents you from seeing. You have Advantage on saving throws against having the Blinded condition.

Resolute Sight. If you take this trait twice, when you fail a saving throw against having the Blinded condition, you can use your Reaction to succeed on the save instead. You regain the use of this feature after you finish a Long Rest.

Tomar novamente: Resolute Sight.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Restorative Rest.', 'Sleep is a luxury you’ve never needed to afford. When you rest, you meditate deeply for 4 hours, dreaming but remaining conscious. After resting in this way, you gain the same benefit that other humanoids do from 8 hours of sleep.

Restorative Rest. If you take this trait twice, you need to spend only 2 hours in your meditation to gain the benefit of 8 hours of sleep, and you gain a d6 at the end of each Long Rest. Before the end of your next Long Rest, you can roll the d6 and add it to any d20 Test you make. You can decide to roll the d6 after the d20 Test is made, but you must do so before the outcome of the roll is known.

Tomar novamente: Restorative Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Sangromancy Savant.', 'A connection to the life force of others lets you shape that force to their benefit. Whenever an allied creature within 30 feet of you regains Hit Points, you can spend a Hit Die and add the roll of the die to the number of Hit Points gained by the ally.

Sangromancy Savant. If you take this trait twice, when you use Divine Sangromancy, you also regain Hit Points equal to your Hit Die roll.

Tomar novamente: Sangromancy Savant.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Secret Dreams.', 'Whenever you rest, you touch the dreams of those around you, seeding their thoughts and memories into your own mind. When you make an ability check to recall lore or knowledge, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Secret Dreams. If you take this trait twice, you gain an instinctive knowledge of the secrets of other creatures while you touch their dreams. Using a Search action, you focus on one creature you can see and make a DC 15 Wisdom Insight check. With a successful check, you learn one secret of the GM’s choice known to that creature. The secrets of creatures that don’t have a language come to you as vague images and impressions. You regain the use of this feature when you finish a Short or Long Rest.

Why bother with interrogation? Just let him rest a few hours. I’ll get you your answers.

—Varrigan the Dreamwalker

Tomar novamente: Secret Dreams.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Self-Repair.', 'You were made, not born, and your unnatural origin forever marks you as different. You are a Construct, but your enchanted form still benefits from healing spells. You can also heal yourself by spending Hit Dice during Short Rests and Long Rests, as normal.

You don’t need to eat, drink, sleep, or breathe. You must still be inactive for 8 hours during a Long Rest to gain its benefits.

Self-Repair. If you take this trait twice, when the Mending cantrip is cast on you, you can spend a Hit Die to regain a number of Hit Points equal to the roll of the die plus your Constitution modifier (minimum 1 Hit Point). You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Self-Repair.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Shared Camouflage.', 'Your ability to fade into the background of familiar territory helps keep you safe from threats. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. You have Advantage on Stealth checks made with the Hide action while in that environment.

Shared Camouflage. If you take this trait multiple times, you gain its benefits for a new environment each time.

Additionally, when you take the Hide action, you can forgo making a Stealth check while in any environment chosen with Natural Camouflage, instead treating the check as if you had rolled a 15. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Shared Camouflage.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Shared Fleetness.', 'As you’ve learned more than once, moving fast is often the best way to avoid trouble. Your Speed increases by 5 feet.

Shared Fleetness. If you take this trait twice, your Speed increases by another 5 feet, for a total increase of 10 feet.

Additionally, as a Bonus Action, choose any number of creatures within 30 feet. Those creatures gain a 10 foot bonus to their Speed for 1 minute. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Shared Movement.', 'The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, moving through nonmagical Difficult Terrain costs you no extra movement, and ability checks made to track you have Disadvantage.

Shared Movement. If you take this trait multiple times, you gain its benefits for a new environment each time. Additionally, while in any environment chosen for Natural Movement, as a Bonus Action, you can grant creatures of your choice the benefit of Natural Movement for 1 hour, as long as those creatures remain within 120 feet of you and can see you.

Tomar novamente: Shared Movement.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Skill Mastery.', 'Your ingenuity and inventiveness help keep you alive in a dangerous world. Before you make an ability check using a skill you are proficient with, you can add your Proficiency Bonus again. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Skill Mastery. If you take this trait twice, when you fail an ability check made using the Skill Prowess trait, you can reroll the check and must use the new roll.

Tomar novamente: Skill Mastery.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Sleeping Ward.', 'An instinctive sense for danger protects you at all times. While you have the Unconscious condition while asleep, you are aware of your surroundings and can make Perception checks normally.

Sleeping Ward. If you take this trait twice, while you are asleep, you automatically detect the presence of any creature intending harm to you that moves within 30 feet of you. A creature that is simply capable of harming you does not trigger this trait until it has intent to do so. For example, a wild animal might approach you cautiously, then decide to attack only when it realizes you are sleeping.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Slip Free.', 'Your ability to stay in motion is second to none, and foes try in vain to pin you down. You have Advantage on saving throws against being Restrained .

Slip Free. If you take this trait twice, when you fail a saving throw against being Restrained, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Slip Free.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Smoker.', 'Working with detritus and shattered objects has granted you an affinity for repairing and remaking things. You have proficiency with Tinker’s Tools . (This is an Exploration trait.)

Additionally, you can use your Tinker’s Tools and 10 GP worth of appropriate materials to spend 10 minutes creating a small clockwork device. The device must fit in the palm of your hand, and can serve one of the following functions:

Smoker. The device exudes smoke in a 5-foot Cube for 1 minute. Any objects or creatures within this Cube are considered Lightly Obscured .

Lighter. The device emits a small flame the size of a candle’s that can light flammable objects.

Compass. The device always points north, or in a cardinal direction of the GM’s determination on another plane.

Expert Gadgeteer. If you take this trait twice, you can make a device in 1 minute instead of 10 minutes. In addition, you can choose to imbue a device with the following extra function: (This is a Combat trait.)

Distractor. This device is set with blinking lights that can captivate other creatures. As a Bonus Action, you place or toss the device into a space within 30 feet of you. A creature sharing a space with the device must succeed on a DC 10 Intelligence saving throw. On a failure, attacks against that creature have Advantage until the start of your next turn. A creature can use an action to destroy the device. You can give up to three of your devices the Distractor feature. You regain the ability to do so when you finish a Long Rest.

Tomar novamente: Expert Gadgeteer†.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Spirit’s Strength.', 'Your strength of mind shields you from unnatural forces. You have Resistance to Psychic damage.

Spirit’s Strength. If you take this trait twice, when you fail a saving throw against an effect that deals Psychic damage, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Spirit’s Strength.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Stalwart Edge.', 'Each time you lay into a foe, their state of peril lends you vigor. When you hit a creature with a melee attack, you can use your Reaction to roll a number of d4s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total rolled. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Stalwart Edge. If you take this trait twice, you can take the maximum number of Temporary Hit Points rather than rolling.

Tomar novamente: Stalwart Edge.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Stand Fast.', 'No matter what kind of upheaval surrounds you, you stand your ground. You have Advantage on saving throws against having the Prone condition.

Stand Fast. If you take this trait twice, standing from Prone takes only five feet of movement instead of half your movement.

Additionally, when you fail a saving throw against being knocked Prone, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Don’t stay down. Never stay down. If you stay down, you’re dead.

—Monster Hunter’s Guide to Survival

Tomar novamente: Stand Fast.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Strength of Life.', 'Effects that corrupt the essence of other living creatures are of little concern to you. You have Resistance to Necrotic damage.

Strength of Life. If you take this trait twice, when you fail a saving throw against an effect that deals Necrotic damage, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Strong Strike.', 'Hesitation in others is a weakness you’ve learned to take deadly advantage of. When you hit a creature that hasn’t taken a turn in the combat yet, your attack deals an extra 2d6 damage. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Strong Strike. If you take this trait twice, you can use the maximum value of the extra damage dice from First Strike, rather than rolling. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Strong Strike.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Stunt Expert.', 'Staying loose and limber means being able to get out of even the tightest spots when your life is on the line. You have proficiency in the Acrobatics skill.

Stunt Expert. If you take this trait twice, you have Advantage on Acrobatics checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Stunt Expert.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Subtle Cover.', 'By slipping behind enemies or allies alike, you are able to fade from view with ease. You can take the Hide action even when you have Half Cover from a creature, as long as that creature is of a size larger than you.

Subtle Cover. If you take this trait twice, you can take the Hide action when you have Half Cover from a creature the same size as you.

Tomar novamente: Subtle Cover.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Supreme Skirmisher.', 'Your brutal strike leaves your foe reeling as you slip away. When you hit a hostile creature with an attack with a weapon or an Unarmed Strike , Opportunity Attacks against you by that creature have Disadvantage until the end of your turn.

Supreme Skirmisher. If you take this trait twice, when you hit a hostile creature with an attack with a weapon attack or an Unarmed Strike, you can take the Disengage action as a Bonus Action until the end of your turn.

Tomar novamente: Supreme Skirmisher.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Supreme Slip.', 'Any enemy that tries to grab you is in for a surprise. You have Advantage on Athletics and Acrobatics checks to escape a grapple.

Supreme Slip. If you take this trait twice, when you fail an Athletics or Acrobatics check to escape a grapple, you can use your Reaction to succeed instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Supreme Slip.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Swift Strike.', 'The gift of natural weaponry means you are never unarmed, as your foes learn to their peril. Your Unarmed Strikes deal damage equal to 1d6 + your Strength or Dexterity modifier. The type of damage dealt by your Unarmed Strikes can be Bludgeoning, Piercing, or Slashing, based on the type of natural weaponry you possess (claws, horns, a tail, and so forth).

Swift Strike. If you take this trait twice, you can use Unarmed Strike as a Bonus Action. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Swift Strike.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Terrifying Influence.', 'Others have learned to fear you—and for good reason.

You have proficiency in the Intimidation skill.

Terrifying Influence. If you take this trait twice, you have Advantage on Intimidation checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Terrifying Influence.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Thorough Sleuth.', 'Putting together the pieces of even the darkest mysteries is second nature to you. You have proficiency in the Investigation skill.

Thorough Sleuth. If you take this trait twice, you have Advantage on Investigation checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Thorough Sleuth.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] To the Dregs.', 'As your enemy’s life force ebbs, you grow ever stronger. If you have the Natural Attack trait, each time you hit with an Unarmed Strike , you gain Temporary Hit Points equal to the damage dealt by the attack.

To the Dregs. If you take this trait twice, when you use Draining Attack, the target also takes a penalty to their Hit Point maximum equal to the damage dealt by the attack. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: To the Dregs.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Tongue of Gold.', 'You have learned that the best way to deal with certain threats is to keep those threats from escalating. You have proficiency in the Persuasion skill.

Tongue of Gold. If you take this trait twice, you have Advantage on Persuasion checks. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Tongue of Gold.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Unparalleled Endurance.', 'The battles you need yet to fight are many, and death is not an option. When you are reduced to 0 Hit Points but not killed outright, you can drop to 1 Hit Point instead. You regain the use of this feature when you finish a Long Rest.

Unparalleled Endurance. If you take this trait twice, when you use Relentless Endurance, you drop to 1d6 Hit Points + your Proficiency Bonus. Additionally, when you use Relentless Endurance, you can use a Reaction to spend up to five Hit Dice, rolling them and gaining that number of Hit Points.

Tomar novamente: Unparalleled Endurance.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Vigorous.', 'An innate resilience lets you shake off conditions that would take others down. You have Advantage on saving throws connected to gaining or removing Exhaustion levels.

Vigorous. If you take this trait twice, when you fail a saving throw against Exhaustion, you can use your Reaction to succeed on the save instead. You regain the use of this feature when you finish a Long Rest.

Tomar novamente: Vigorous.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Interpretação] Virtuoso.', 'In the quieter moments, music can help you forget the horrors you’ve seen. You have proficiency with two instruments of your choice.

Virtuoso. If you take this trait multiple times, you gain proficiency with two new instruments each time.

Additionally, you have Advantage on ability checks made using any instrument. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Virtuoso.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Wall Walker.', 'Sometimes staying away from what threatens you means getting clear of those threats. You have a Climb Speed equal to your Speed.

Wall Walker. If you take this trait twice, you can use your Climb Speed to move up, down, and across vertical surfaces and upside down along ceilings, while leaving your hands free.

Additionally, while using climbing movement, you can use the Dash action as a Bonus Action. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Wall Walker.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Exploração] Water Born.', 'Surviving underwater is second nature to you. You can breathe air and water.

Water Born. If you take this trait twice, you have Advantage on ability checks or saving throws made while submerged in water. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.

Tomar novamente: Water Born.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES ((SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), '[Combate] Weapon Specialist.', 'The weapons you wield might save your life one day, and you know their secrets. You have proficiency with three weapons of your choice.

Weapon Specialist. If you take this trait multiple times, you gain proficiency with three new weapons each time. Additionally, choose one weapon with which you have proficiency. You have a +1 bonus to damage rolls with that weapon.

Tomar novamente: Weapon Specialist.', NULL) ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description;
