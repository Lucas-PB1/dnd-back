-- Grim Hollow Cap. 1 — heranças jogáveis: pool de traços + 8 slots por herança

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'), 'ghHeritageTraitId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order, benefit, level1_benefit, edition_slug)
VALUES
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'a-sight-to-behold',
  '[Interpretação] A Sight to Behold',
  1,
  'When you desire to stand out, you have a natural gift for impressing others. You have proficiency in the Performance skill.',
  'When you desire to stand out, you have a natural gift for impressing others. You have proficiency in the Performance skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'adaptive-awareness',
  '[Exploração] Adaptive Awareness',
  2,
  'The natural world is a dangerous place, and your connection to specific parts of that world grants you an edge in survival. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, whenever you make an ability check to assess structures, monuments, or natural features; to find food or drinkable water; or to track creatures, you are considered to have proficiency in the appropriate skill for the check, and you add double your Proficiency Bonus to the check instead of your normal bonus.',
  'The natural world is a dangerous place, and your connection to specific parts of that world grants you an edge in survival. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, whenever you make an ability check to assess structures, monuments, or natural features; to find food or drinkable water; or to track creatures, you are considered to have proficiency in the appropriate skill for the check, and you add double your Proficiency Bonus to the check instead of your normal bonus.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'animal-ally',
  '[Interpretação] Animal Ally',
  3,
  'Time spent among beasts has gifted you a way with those creatures. You have proficiency in the Animal Handling skill.',
  'Time spent among beasts has gifted you a way with those creatures. You have proficiency in the Animal Handling skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'artisanal-expertise',
  '[Interpretação] Artisanal Expertise',
  4,
  'You revere the crafting skill of ancestors long dead. Choose an Artisan’s Tool. You have proficiency with that tool.',
  'You revere the crafting skill of ancestors long dead. Choose an Artisan’s Tool. You have proficiency with that tool.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'astute-slip',
  '[Combate] Astute Slip',
  5,
  'Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. You can take the Hide action as a Bonus Action on each of your turns. You must have appropriate cover to attempt to hide, as normal.',
  'Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. You can take the Hide action as a Bonus Action on each of your turns. You must have appropriate cover to attempt to hide, as normal.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'athlete-s-resolve',
  '[Interpretação] Athlete’s Resolve',
  6,
  'Your reserves of physical power have kept you alive on more than one occasion. You have proficiency in the Athletics skill.',
  'Your reserves of physical power have kept you alive on more than one occasion. You have proficiency in the Athletics skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'battlefield-dominance',
  '[Combate] Battlefield Dominance',
  7,
  'When foes attempt to press you in melee, they do so at their peril. Other creatures provoke Opportunity Attacks from you whenever they move into your reach, in addition to when they move out of your reach.',
  'When foes attempt to press you in melee, they do so at their peril. Other creatures provoke Opportunity Attacks from you whenever they move into your reach, in addition to when they move out of your reach.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'bond-with-nature',
  '[Interpretação] Bond with Nature',
  8,
  'You’ve learned that paying attention to the environment around you is the best way to predict its threats. You have proficiency in the Nature skill.',
  'You’ve learned that paying attention to the environment around you is the best way to predict its threats. You have proficiency in the Nature skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'born-lucky',
  '[Combate] Born Lucky',
  9,
  'Fortune favors you at times when a threat might send you down. When you fail a saving throw, you can use your Reaction to roll a d4 and add it to the save, potentially turning it into a success. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Fortune favors you at times when a threat might send you down. When you fail a saving throw, you can use your Reaction to roll a d4 and add it to the save, potentially turning it into a success. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'calculated-disappearance',
  '[Interpretação] Calculated Disappearance',
  10,
  'When trouble comes for you, you excel at making sure it can’t find you. You have proficiency in the Stealth skill.',
  'When trouble comes for you, you excel at making sure it can’t find you. You have proficiency in the Stealth skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'centered-edge',
  '[Combate] Centered Edge',
  11,
  'By focusing your inner strength, you gain a needed edge. As a Bonus Action, you grant yourself Advantage on an attack roll or ability check you make before the start of your next turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'By focusing your inner strength, you gain a needed edge. As a Bonus Action, you grant yourself Advantage on an attack roll or ability check you make before the start of your next turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'combat-doctor',
  '[Interpretação] Combat Doctor',
  12,
  'When others suffer, you are there to help. You have proficiency in the Medicine skill.',
  'When others suffer, you are there to help. You have proficiency in the Medicine skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'crafter-s-cunning',
  '[Interpretação] Crafter’s Cunning',
  13,
  'The history of Etharis is written in relics, and you read that history better than most. When you make a History check related to any object (an item, device, building, or material) and you have proficiency in an Artisan’s Tool associated with creating that object, you are considered proficient in History and you add double your Proficiency Bonus to the check instead of your normal bonus.',
  'The history of Etharis is written in relics, and you read that history better than most. When you make a History check related to any object (an item, device, building, or material) and you have proficiency in an Artisan’s Tool associated with creating that object, you are considered proficient in History and you add double your Proficiency Bonus to the check instead of your normal bonus.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'damage-immunity',
  '[Combate] Damage Immunity',
  14,
  'Exposure to the worst effects of a specific energy has given you a tolerance to its effects. You have Resistance to one of the following damage types of your choice: Acid, Cold, Fire, Lightning, Poison, or Thunder.',
  'Exposure to the worst effects of a specific energy has given you a tolerance to its effects. You have Resistance to one of the following damage types of your choice: Acid, Cold, Fire, Lightning, Poison, or Thunder.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'deep-lore',
  '[Interpretação] Deep Lore',
  15,
  'The lessons of the past are harsh, but learning those lessons might give you the best insight for navigating the future. You have proficiency in the History skill.',
  'The lessons of the past are harsh, but learning those lessons might give you the best insight for navigating the future. You have proficiency in the History skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'determined-hearing',
  '[Exploração] Determined Hearing',
  16,
  'Even as destruction rains down around you, your hearing stays sharp. You have Advantage on saving throws against having the Deafened condition.',
  'Even as destruction rains down around you, your hearing stays sharp. You have Advantage on saving throws against having the Deafened condition.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'determined-survivor',
  '[Interpretação] Determined Survivor',
  17,
  'The wilds of Etharis have claimed many who lack the skill to navigate them. You have proficiency in the Survival skill.',
  'The wilds of Etharis have claimed many who lack the skill to navigate them. You have proficiency in the Survival skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'endless-breath',
  '[Exploração] Endless Breath',
  18,
  'Whether trapped under black water or resisting poisonous fumes, you refuse to give in. You can hold your breath for up to 1 hour.',
  'Whether trapped under black water or resisting poisonous fumes, you refuse to give in. You can hold your breath for up to 1 hour.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'ethereal-focus',
  '[Exploração] Ethereal Focus',
  19,
  'Shifting away from the mortal world lets you move through and observe that world unseen. As a Magic action, you fade from the Material Plane into the Ethereal Plane for 1 minute. While you remain in this state, you can’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. You can move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappear in the Material Plane in the closest unoccupied space to where you faded from. You can end the effect early as a Bonus Action. You regain the use of this feature again when you finish a Long Rest.',
  'Shifting away from the mortal world lets you move through and observe that world unseen. As a Magic action, you fade from the Material Plane into the Ethereal Plane for 1 minute. While you remain in this state, you can’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. You can move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappear in the Material Plane in the closest unoccupied space to where you faded from. You can end the effect early as a Bonus Action. You regain the use of this feature again when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'even-larger',
  '[Combate] Even Larger',
  20,
  'Foes that outsize you quickly learn to fear your wrath. If you hit a creature that is one size larger than you, you can choose to deal extra damage to the creature equal to your Proficiency Bonus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Foes that outsize you quickly learn to fear your wrath. If you hit a creature that is one size larger than you, you can choose to deal extra damage to the creature equal to your Proficiency Bonus. You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'exceptional-insight',
  '[Interpretação] Exceptional Insight',
  21,
  'Those who attempt to deceive you do so in vain. You have proficiency in the Insight skill.',
  'Those who attempt to deceive you do so in vain. You have proficiency in the Insight skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'expert-deceiver',
  '[Interpretação] Expert Deceiver',
  22,
  'You long ago learned that being open with others only gives them power over you. You have proficiency in the Deception skill.',
  'You long ago learned that being open with others only gives them power over you. You have proficiency in the Deception skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'expert-improviser',
  '[Interpretação] Expert Improviser',
  23,
  'When needs demand, you get the job done better than most. As a Bonus Action, choose one skill or tool that you don’t have proficiency with. You have proficiency in that skill or with that tool for 1 hour. You regain the use of this feature when you finish a Long Rest.',
  'When needs demand, you get the job done better than most. As a Bonus Action, choose one skill or tool that you don’t have proficiency with. You have proficiency in that skill or with that tool for 1 hour. You regain the use of this feature when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'expert-orientation',
  '[Exploração] Expert Orientation',
  24,
  'A single misstep can lead to ruin, but your instincts for direction keep you from going astray. You always know which way is north, and you can reckon a cardinal direction of the GM’s determination while on other planes. Additionally, you have Advantage on ability checks made to avoid becoming lost, to navigate, or to track.',
  'A single misstep can lead to ruin, but your instincts for direction keep you from going astray. You always know which way is north, and you can reckon a cardinal direction of the GM’s determination while on other planes. Additionally, you have Advantage on ability checks made to avoid becoming lost, to navigate, or to track.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'exquisite-legerdemain',
  '[Interpretação] Exquisite Legerdemain',
  25,
  'You have learned the value of being able to manipulate the world around you without attracting the notice of others. You have proficiency in the Sleight of Hand skill.',
  'You have learned the value of being able to manipulate the world around you without attracting the notice of others. You have proficiency in the Sleight of Hand skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'extended-fortification',
  '[Combate] Extended Fortification',
  26,
  'The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.',
  'The more that magic threatens you, the more your resilience to it increases. Choose an ability score: Strength, Dexterity, Constitution, Intelligence, Wisdom, or Charisma. You have Advantage on saving throws using that ability score against spells and other magical effects.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'extra-tough',
  '[Combate] Extra Tough',
  27,
  'An intrinsic hardiness marks you as one born for battle. Your Hit Point maximum increases by 1, and it increases by 1 each time you gain a level.',
  'An intrinsic hardiness marks you as one born for battle. Your Hit Point maximum increases by 1, and it increases by 1 each time you gain a level.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'extreme-resilience',
  '[Exploração] Extreme Resilience',
  28,
  'When you don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest you can get. When taking a Short Rest, you can choose to sleep for 1 hour. If you do so, you reduce your Exhaustion by one level and regain a Hit Point Die in addition to the other benefits of a Short Rest.',
  'When you don’t know how long it might be before your next full respite, you learn to take maximum advantage of any rest you can get. When taking a Short Rest, you can choose to sleep for 1 hour. If you do so, you reduce your Exhaustion by one level and regain a Hit Point Die in addition to the other benefits of a Short Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'faultless-shroud',
  '[Exploração] Faultless Shroud',
  29,
  'With any degree of obscuration, your instinctive ability to conceal yourself lets you avoid your enemies’ notice. You can take the Hide action even when you are only Lightly Obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.',
  'With any degree of obscuration, your instinctive ability to conceal yourself lets you avoid your enemies’ notice. You can take the Hide action even when you are only Lightly Obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'focused-edge',
  '[Combate] Focused Edge',
  30,
  'No matter how badly beaten down you are, you find the will to keep fighting when you most need it. As a Reaction after you take damage, you can roll a number of d6s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'No matter how badly beaten down you are, you find the will to keep fighting when you most need it. As a Reaction after you take damage, you can roll a number of d6s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'focused-initiative',
  '[Combate] Focused Initiative',
  31,
  'Danger is never far away from you, and you are always ready for it. You add your Proficiency Bonus to your Initiative rolls.',
  'Danger is never far away from you, and you are always ready for it. You add your Proficiency Bonus to your Initiative rolls.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'focused-mastery',
  '[Interpretação] Focused Mastery',
  32,
  'Your discipline and focus give you an edge that others lack. Choose one of your skill or tool proficiencies. You have Expertise on ability checks made using the chosen proficiency.',
  'Your discipline and focus give you an edge that others lack. Choose one of your skill or tool proficiencies. You have Expertise on ability checks made using the chosen proficiency.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'focused-ruthlessness',
  '[Combate] Focused Ruthlessness',
  33,
  'A creature that gets the drop on you is met with a swift and brutal reply. When you take damage from a creature within your reach, you can use your Reaction to make a melee attack with a weapon or an Unarmed Strike against that creature. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'A creature that gets the drop on you is met with a swift and brutal reply. When you take damage from a creature within your reach, you can use your Reaction to make a melee attack with a weapon or an Unarmed Strike against that creature. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'force-of-faith',
  '[Interpretação] Force of Faith',
  34,
  'The grimmest myths and legends of the past hold the keys to shaping the future. You have proficiency in the Religion skill.',
  'The grimmest myths and legends of the past hold the keys to shaping the future. You have proficiency in the Religion skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'full-speed-squeeze',
  '[Exploração] Full-Speed Squeeze',
  35,
  'With an effort of will, you contort your body into the tightest spaces. You can squeeze through a space that is large enough for a creature two sizes smaller than you, rather than one size smaller.',
  'With an effort of will, you contort your body into the tightest spaces. You can squeeze through a space that is large enough for a creature two sizes smaller than you, rather than one size smaller.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'furious-charge',
  '[Combate] Furious Charge',
  36,
  'The fury with which you throw yourself into battle forces your foes to feel your wrath. If you move at least 20 feet straight toward a target and then hit it with a melee attack with a weapon or an Unarmed Strike on the same turn, you can make another attack against the same target as a Bonus Action with the same weapon.',
  'The fury with which you throw yourself into battle forces your foes to feel your wrath. If you move at least 20 feet straight toward a target and then hit it with a melee attack with a weapon or an Unarmed Strike on the same turn, you can make another attack against the same target as a Bonus Action with the same weapon.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'furious-speed',
  '[Exploração] Furious Speed',
  37,
  'The many things that want to kill you must catch you first. On your turn, you can increase your Speed by 30 feet until the end of your turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'The many things that want to kill you must catch you first. On your turn, you can increase your Speed by 30 feet until the end of your turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'hard-to-kill',
  '[Combate] Hard to Kill',
  38,
  'Your enemies might put you down, but you are never down for long. You have Advantage on Death Saving Throws.',
  'Your enemies might put you down, but you are never down for long. You have Advantage on Death Saving Throws.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'heavy-armor-training',
  '[Combate] Heavy Armor Training',
  39,
  'The pounding you routinely take in combat requires a formidable layer of defense. You have training with Medium armor and with Shields.',
  'The pounding you routinely take in combat requires a formidable layer of defense. You have training with Medium armor and with Shields.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'helpful-tactics',
  '[Combate] Helpful Tactics',
  40,
  'You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)',
  'You excel at aiding your allies, knowing that the time will come when you need them to return the favor. You can use the Help action as a Bonus Action to assist any ally making an ability check. (This is an Exploration trait.)',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'hindering-distraction',
  '[Combate] Hindering Distraction',
  41,
  'You draw your foes’ attention to you, intending it to be the last diversion they ever see. As an Influence action, you put on a tactical display (bravado, cowardice, confusion, or some other tactic) that gets your enemies’ attention. Until the end of your next turn, any attack on an enemy within 10 feet of you that could see you when you took the Influence action is made with Advantage . You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'You draw your foes’ attention to you, intending it to be the last diversion they ever see. As an Influence action, you put on a tactical display (bravado, cowardice, confusion, or some other tactic) that gets your enemies’ attention. Until the end of your next turn, any attack on an enemy within 10 feet of you that could see you when you took the Influence action is made with Advantage . You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'immune-to-the-elements',
  '[Exploração] Immune to the Elements',
  42,
  'Even beneath scorching sun and in freezing cold, you hold yourself strong. You have Advantage on Constitution saving throws made to resist the effects of extreme cold or extreme heat.',
  'Even beneath scorching sun and in freezing cold, you hold yourself strong. You have Advantage on Constitution saving throws made to resist the effects of extreme cold or extreme heat.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'immutable-mind',
  '[Combate] Immutable Mind',
  43,
  'Your strength of will protects you from magic that would corrupt your mind. You have Advantage on saving throws against being Charmed .',
  'Your strength of will protects you from magic that would corrupt your mind. You have Advantage on saving throws against being Charmed .',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'improved-darkvision',
  '[Exploração] Improved Darkvision',
  44,
  'A life spent in shadow has made you grow accustomed to the gloom. You can see in Dim Light within 60 feet of you as if it were Bright Light , and in Darkness within 60 feet of you as if it were Dim Light. You can’t discern color in Darkness, only shades of gray.',
  'A life spent in shadow has made you grow accustomed to the gloom. You can see in Dim Light within 60 feet of you as if it were Bright Light , and in Darkness within 60 feet of you as if it were Dim Light. You can’t discern color in Darkness, only shades of gray.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'incomparable-roar',
  '[Combate] Incomparable Roar',
  45,
  'Your battle cry can cause even the most formidable foes to quail before you. As a Bonus Action, you emit a roar, shout, or other loud vocal outburst. Each creature of your choice within 10 feet of you that can hear you must succeed on a Wisdom saving throw (DC = 8 + your Proficiency Bonus + your Constitution modifier) or have the Frightened condtion until the end of your next turn. You regain the use of this feature when you finish a Long Rest.',
  'Your battle cry can cause even the most formidable foes to quail before you. As a Bonus Action, you emit a roar, shout, or other loud vocal outburst. Each creature of your choice within 10 feet of you that can hear you must succeed on a Wisdom saving throw (DC = 8 + your Proficiency Bonus + your Constitution modifier) or have the Frightened condtion until the end of your next turn. You regain the use of this feature when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'incredible-leap',
  '[Exploração] Incredible Leap',
  46,
  'Threats on the ground are of little concern as you leap over them with ease. You can make a Long Jump of up to 20 feet and a High Jump of up to 10 feet, with or without a running start. If your Speed is less than the distance you can Long Jump, you can leap only a distance equal to your Speed.',
  'Threats on the ground are of little concern as you leap over them with ease. You can make a Long Jump of up to 20 feet and a High Jump of up to 10 feet, with or without a running start. If your Speed is less than the distance you can Long Jump, you can leap only a distance equal to your Speed.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'infectious-bravery',
  '[Combate] Infectious Bravery',
  47,
  'The horrors you’ve lived through have hardened you. You have Advantage on saving throws to avoid being Frightened .',
  'The horrors you’ve lived through have hardened you. You have Advantage on saving throws to avoid being Frightened .',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'language-expert',
  '[Interpretação] Language Expert',
  48,
  'The advantages of mastering the languages of enemies and allies alike are clear to you. You learn two languages of your choice.',
  'The advantages of mastering the languages of enemies and allies alike are clear to you. You learn two languages of your choice.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'light-armor-expertise',
  '[Combate] Light Armor Expertise',
  49,
  'Dealing with the threats you face requires the right combination of protection and movement. You have training with Light armor.',
  'Dealing with the threats you face requires the right combination of protection and movement. You have training with Light armor.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'long-fade',
  '[Exploração] Long Fade',
  50,
  'You have learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. As a Bonus Action, you can take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.',
  'You have learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. As a Bonus Action, you can take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'magical-historian',
  '[Interpretação] Magical Historian',
  51,
  'Magic is power in the right hands, and those hands are yours. You have proficiency in the Arcana skill.',
  'Magic is power in the right hands, and those hands are yours. You have proficiency in the Arcana skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'magical-savant',
  '[Interpretação] Magical Savant',
  52,
  'Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.',
  'Whether through intensive study or the innate touch of magic in your blood, you have the ability to invoke magical spells. You learn one cantrip of your choice from any spell list, which you cast using the associated ability score: Intelligence for Wizard spells, Wisdom for Cleric and Druid spells, and Charisma for Bard, Sorcerer, and Warlock spells. If the spell appears on multiple spell lists, choose one to determine the spellcasting attribute for that spell.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'master-artisan',
  '[Interpretação] Master Artisan',
  53,
  'You’ve never known the luxury of always having the gear you need, but you have more than learned to make do. If you possess Artisan’s Tools with which you have proficiency, and if you have access to appropriate raw materials and any additional necessary equipment (as the GM determines), you can use a Short Rest to craft any one nonmagical item worth 10 GP or less, including:',
  'You’ve never known the luxury of always having the gear you need, but you have more than learned to make do. If you possess Artisan’s Tools with which you have proficiency, and if you have access to appropriate raw materials and any additional necessary equipment (as the GM determines), you can use a Short Rest to craft any one nonmagical item worth 10 GP or less, including:',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'master-manipulator',
  '[Interpretação] Master Manipulator',
  54,
  'The weak-willed around you are easy targets for your manipulation. By conversing with a nonhostile creature for at least 1 minute, you can attempt to charm them. The creature must succeed on a Wisdom saving throw (DC = 8 + your Charisma modifier + your Proficiency Bonus) or have the Charmed condition for 1 hour. At the GM’s discretion, you also learn one piece of information that the target knows that relates to the topic of conversation while you speak to them. Regardless of whether or not the target succeeds on the saving throw, they remain unaware of your attempt. You regain use of this feature when you finish a Short or Long Rest.',
  'The weak-willed around you are easy targets for your manipulation. By conversing with a nonhostile creature for at least 1 minute, you can attempt to charm them. The creature must succeed on a Wisdom saving throw (DC = 8 + your Charisma modifier + your Proficiency Bonus) or have the Charmed condition for 1 hour. At the GM’s discretion, you also learn one piece of information that the target knows that relates to the topic of conversation while you speak to them. Regardless of whether or not the target succeeds on the saving throw, they remain unaware of your attempt. You regain use of this feature when you finish a Short or Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'master-of-fortune',
  '[Combate] Master of Fortune',
  55,
  'The luck you carry will see you through the worst Etharis has to offer. When you roll a 1 on a D20 Test, you can reroll that die but must use the new roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'The luck you carry will see you through the worst Etharis has to offer. When you roll a 1 on a D20 Test, you can reroll that die but must use the new roll. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'maximum-critical',
  '[Combate] Maximum Critical',
  56,
  'When fortune favors your blade, you know how to make it count. When you score a Critical Hit with a melee attack with a weapon or an Unarmed Strike , you can roll one of the weapon’s damage dice one additional time and add it to the extra damage of the Critical Hit.',
  'When fortune favors your blade, you know how to make it count. When you score a Critical Hit with a melee attack with a weapon or an Unarmed Strike , you can roll one of the weapon’s damage dice one additional time and add it to the extra damage of the Critical Hit.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'mobile-bastion',
  '[Combate] Mobile Bastion',
  57,
  'Focusing all your resolve, you stand fast and watch your enemies flail against your defenses. As a Magic action, you become motionless and gain the following effects:',
  'Focusing all your resolve, you stand fast and watch your enemies flail against your defenses. As a Magic action, you become motionless and gain the following effects:',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'moving-insight',
  '[Combate] Moving Insight',
  58,
  'A lifetime spent wandering lets you judge when others’ movement works to your benefit. When you make an attack roll against a creature or make a saving throw against a creature’s attack, spell, or ability, you can use a Reaction to have Advantage on the attack roll or saving throw if that creature moved since the end of your last turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'A lifetime spent wandering lets you judge when others’ movement works to your benefit. When you make an attack roll against a creature or make a saving throw against a creature’s attack, spell, or ability, you can use a Reaction to have Advantage on the attack roll or saving throw if that creature moved since the end of your last turn. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'nimble-passage',
  '[Exploração] Nimble Passage',
  59,
  'Making use of constant movement lets you minimize the threat of larger foes. You can move through the space of any creature at least one size larger than you.',
  'Making use of constant movement lets you minimize the threat of larger foes. You can move through the space of any creature at least one size larger than you.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'opportune-reach',
  '[Combate] Opportune Reach',
  60,
  'As you hurl yourself into battle, your foes discover that trying to keep away from you won’t save them. Your reach increases by 5 feet. This extra reach doesn’t apply to Opportunity Attacks.',
  'As you hurl yourself into battle, your foes discover that trying to keep away from you won’t save them. Your reach increases by 5 feet. This extra reach doesn’t apply to Opportunity Attacks.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'overwhelming-shove',
  '[Combate] Overwhelming Shove',
  61,
  'Your powerful blows send your targets reeling. When you hit a creature no more than one size larger than you with a melee attack, you can use a Bonus Action to attempt to shove that creature. The target must succeed on a Strength or Dexterity saving throw (DC = 8 + your Strength modifier + your Proficiency Bonus) or be pushed up to 10 feet away from you.',
  'Your powerful blows send your targets reeling. When you hit a creature no more than one size larger than you with a melee attack, you can use a Bonus Action to attempt to shove that creature. The target must succeed on a Strength or Dexterity saving throw (DC = 8 + your Strength modifier + your Proficiency Bonus) or be pushed up to 10 feet away from you.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'pack-instinct',
  '[Combate] Pack Instinct',
  62,
  'Staying close to your allies in combat makes you even more dangerous. When you start your turn with at least one ally who isn’t Incapacitated within 5 feet of another creature you can see, you can use your Reaction to have Advantage on attack rolls against that creature until the end of your turn.',
  'Staying close to your allies in combat makes you even more dangerous. When you start your turn with at least one ally who isn’t Incapacitated within 5 feet of another creature you can see, you can use your Reaction to have Advantage on attack rolls against that creature until the end of your turn.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'pack-leader',
  '[Combate] Pack Leader',
  63,
  'Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 10 feet of you is about to make an attack roll or a saving throw, you can use a Reaction to grant that ally Advantage on the attack or save. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 10 feet of you is about to make an attack roll or a saving throw, you can use a Reaction to grant that ally Advantage on the attack or save. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'phase-shift',
  '[Combate] Phase Shift',
  64,
  'Your corporeal presence shifts and fades, softening your enemies’ ability to harm you. As a Bonus Action, for 1 minute, all creatures have Disadvantage on attack rolls against you, and you can move through other creature’s spaces without treating them as Difficult Terrain. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Your corporeal presence shifts and fades, softening your enemies’ ability to harm you. As a Bonus Action, for 1 minute, all creatures have Disadvantage on attack rolls against you, and you can move through other creature’s spaces without treating them as Difficult Terrain. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'piercing-perception',
  '[Interpretação] Piercing Perception',
  65,
  'The best way to avoid danger is to make sure you’re the first person to notice it. You have proficiency in the Perception skill.',
  'The best way to avoid danger is to make sure you’re the first person to notice it. You have proficiency in the Perception skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'poison-indemnity',
  '[Exploração] Poison Indemnity',
  66,
  'Your exceptional fortitude lets you shrug off the effects of even the worst toxins. You have Advantage on saving throws against being Poisoned .',
  'Your exceptional fortitude lets you shrug off the effects of even the worst toxins. You have Advantage on saving throws against being Poisoned .',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'potent-breath',
  '[Combate] Potent Breath',
  67,
  'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. When you select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 5 feet wide and 30 feet long, or a 15-foot Cone .',
  'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. When you select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 5 feet wide and 30 feet long, or a 15-foot Cone .',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'powerful-shove',
  '[Combate] Powerful Shove',
  68,
  'Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight you can push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)',
  'Whether carrying well-earned loot or the body of a fallen companion, you shoulder that load with ease. You count as one size larger when determining your carrying capacity and the weight you can push, drag, or lift. A Small creature with this trait can use any weapon with the Heavy property as long as they have proficiency with that weapon. (This is an Exploration trait.)',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'primal-voice',
  '[Interpretação] Primal Voice',
  69,
  'Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, you can communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and you can’t understand or learn detailed information from them.',
  'Mastering the subtle expression of fauna and flora grants you an edge in dealing with the threats of the wilderness. Through sounds and gestures, you can communicate simple ideas with Beasts and Plant creatures, understanding if a creature is hungry, for example. This gives you no specific ability to control such creatures, and you can’t understand or learn detailed information from them.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'protective-cover',
  '[Combate] Protective Cover',
  70,
  'Your ability to roll with even the worst attacks means that armor would only slow you down. When you are not wearing armor, your AC is equal to 13 + your Dexterity modifier.',
  'Your ability to roll with even the worst attacks means that armor would only slow you down. When you are not wearing armor, your AC is equal to 13 + your Dexterity modifier.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'quickened-swim',
  '[Exploração] Quickened Swim',
  71,
  'You are in your element while in the water, moving with grace and ease. You have a Swim Speed equal to your Speed.',
  'You are in your element while in the water, moving with grace and ease. You have a Swim Speed equal to your Speed.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'reawakened',
  '[Combate] Reawakened',
  72,
  'The dangers of Etharis have given you a focus that allows you to shrug off debilitating magical effects. You automatically succeed on saving throws against magical effects that would give you the Incapacitated , Stunned , or Unconscious conditions. This does not include effects that leave you Unconscious because you are reduced to 0 Hit Points.',
  'The dangers of Etharis have given you a focus that allows you to shrug off debilitating magical effects. You automatically succeed on saving throws against magical effects that would give you the Incapacitated , Stunned , or Unconscious conditions. This does not include effects that leave you Unconscious because you are reduced to 0 Hit Points.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'regenerative-healer',
  '[Interpretação] Regenerative Healer',
  73,
  'Your innate healing abilities let you recover from some of the grimmest wounds. During a Long Rest, you can automatically reverse Grievous Wounds. Additionally, you can reattach any severed body parts (fingers, legs, tails, and so on), which are automatically restored at the end of the Long Rest. If your severed body parts aren’t available, you can replace them with the same body parts of another creature of the same general anatomy as you. If you wish to intentionally swap out body parts with replacements, you can sever your own body parts with no pain or discomfort.',
  'Your innate healing abilities let you recover from some of the grimmest wounds. During a Long Rest, you can automatically reverse Grievous Wounds. Additionally, you can reattach any severed body parts (fingers, legs, tails, and so on), which are automatically restored at the end of the Long Rest. If your severed body parts aren’t available, you can replace them with the same body parts of another creature of the same general anatomy as you. If you wish to intentionally swap out body parts with replacements, you can sever your own body parts with no pain or discomfort.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'relentless-instinct',
  '[Combate] Relentless Instinct',
  74,
  'You summon a surge of ferocity when your prey least expects it. At the end of each Long Rest, you gain a number of d8s equal to your Proficiency Bonus. When you make an attack with a weapon or an Unarmed Strike , you can roll a d8 and add it to either the attack roll or the damage roll. If you add it to the d20 roll, you can decide to roll the d8 after the d20 roll is made, but you must do so before the outcome of the roll is known.',
  'You summon a surge of ferocity when your prey least expects it. At the end of each Long Rest, you gain a number of d8s equal to your Proficiency Bonus. When you make an attack with a weapon or an Unarmed Strike , you can roll a d8 and add it to either the attack roll or the damage roll. If you add it to the d20 roll, you can decide to roll the d8 after the d20 roll is made, but you must do so before the outcome of the roll is known.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'remarkable-driver',
  '[Exploração] Remarkable Driver',
  75,
  'The roads and waterways of Etharis are often no less dangerous than the open wilderness, and you dedicate yourself to moving others safely on those routes. You have proficiency with Navigator’s Tools , and you have Advantage on ability checks made to drive a vehicle.',
  'The roads and waterways of Etharis are often no less dangerous than the open wilderness, and you dedicate yourself to moving others safely on those routes. You have proficiency with Navigator’s Tools , and you have Advantage on ability checks made to drive a vehicle.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'resolute-sight',
  '[Exploração] Resolute Sight',
  76,
  'Any foe you can see is a foe you can take down—so you make sure nothing prevents you from seeing. You have Advantage on saving throws against having the Blinded condition.',
  'Any foe you can see is a foe you can take down—so you make sure nothing prevents you from seeing. You have Advantage on saving throws against having the Blinded condition.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'restorative-rest',
  '[Exploração] Restorative Rest',
  77,
  'Sleep is a luxury you’ve never needed to afford. When you rest, you meditate deeply for 4 hours, dreaming but remaining conscious. After resting in this way, you gain the same benefit that other humanoids do from 8 hours of sleep.',
  'Sleep is a luxury you’ve never needed to afford. When you rest, you meditate deeply for 4 hours, dreaming but remaining conscious. After resting in this way, you gain the same benefit that other humanoids do from 8 hours of sleep.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'sangromancy-savant',
  '[Combate] Sangromancy Savant',
  78,
  'A connection to the life force of others lets you shape that force to their benefit. Whenever an allied creature within 30 feet of you regains Hit Points, you can spend a Hit Die and add the roll of the die to the number of Hit Points gained by the ally.',
  'A connection to the life force of others lets you shape that force to their benefit. Whenever an allied creature within 30 feet of you regains Hit Points, you can spend a Hit Die and add the roll of the die to the number of Hit Points gained by the ally.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'secret-dreams',
  '[Interpretação] Secret Dreams',
  79,
  'Whenever you rest, you touch the dreams of those around you, seeding their thoughts and memories into your own mind. When you make an ability check to recall lore or knowledge, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Whenever you rest, you touch the dreams of those around you, seeding their thoughts and memories into your own mind. When you make an ability check to recall lore or knowledge, you have Advantage on the check. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'self-repair',
  '[Exploração] Self-Repair',
  80,
  'You were made, not born, and your unnatural origin forever marks you as different. You are a Construct, but your enchanted form still benefits from healing spells. You can also heal yourself by spending Hit Dice during Short Rests and Long Rests, as normal.',
  'You were made, not born, and your unnatural origin forever marks you as different. You are a Construct, but your enchanted form still benefits from healing spells. You can also heal yourself by spending Hit Dice during Short Rests and Long Rests, as normal.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'shared-camouflage',
  '[Exploração] Shared Camouflage',
  81,
  'Your ability to fade into the background of familiar territory helps keep you safe from threats. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. You have Advantage on Stealth checks made with the Hide action while in that environment.',
  'Your ability to fade into the background of familiar territory helps keep you safe from threats. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. You have Advantage on Stealth checks made with the Hide action while in that environment.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'shared-fleetness',
  '[Exploração] Shared Fleetness',
  82,
  'As you’ve learned more than once, moving fast is often the best way to avoid trouble. Your Speed increases by 5 feet.',
  'As you’ve learned more than once, moving fast is often the best way to avoid trouble. Your Speed increases by 5 feet.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'shared-movement',
  '[Exploração] Shared Movement',
  83,
  'The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, moving through nonmagical Difficult Terrain costs you no extra movement, and ability checks made to track you have Disadvantage.',
  'The time you’ve spent in the natural world lets you travel at speed, and hinders the abilities of those who would hunt you. Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater. While in that environment, moving through nonmagical Difficult Terrain costs you no extra movement, and ability checks made to track you have Disadvantage.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'skill-mastery',
  '[Interpretação] Skill Mastery',
  84,
  'Your ingenuity and inventiveness help keep you alive in a dangerous world. Before you make an ability check using a skill you are proficient with, you can add your Proficiency Bonus again. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Your ingenuity and inventiveness help keep you alive in a dangerous world. Before you make an ability check using a skill you are proficient with, you can add your Proficiency Bonus again. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'sleeping-ward',
  '[Exploração] Sleeping Ward',
  85,
  'An instinctive sense for danger protects you at all times. While you have the Unconscious condition while asleep, you are aware of your surroundings and can make Perception checks normally.',
  'An instinctive sense for danger protects you at all times. While you have the Unconscious condition while asleep, you are aware of your surroundings and can make Perception checks normally.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'slip-free',
  '[Combate] Slip Free',
  86,
  'Your ability to stay in motion is second to none, and foes try in vain to pin you down. You have Advantage on saving throws against being Restrained .',
  'Your ability to stay in motion is second to none, and foes try in vain to pin you down. You have Advantage on saving throws against being Restrained .',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'smoker',
  '[Combate] Smoker',
  87,
  'Working with detritus and shattered objects has granted you an affinity for repairing and remaking things. You have proficiency with Tinker’s Tools . (This is an Exploration trait.)',
  'Working with detritus and shattered objects has granted you an affinity for repairing and remaking things. You have proficiency with Tinker’s Tools . (This is an Exploration trait.)',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'spirit-s-strength',
  '[Combate] Spirit’s Strength',
  88,
  'Your strength of mind shields you from unnatural forces. You have Resistance to Psychic damage.',
  'Your strength of mind shields you from unnatural forces. You have Resistance to Psychic damage.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'stalwart-edge',
  '[Combate] Stalwart Edge',
  89,
  'Each time you lay into a foe, their state of peril lends you vigor. When you hit a creature with a melee attack, you can use your Reaction to roll a number of d4s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total rolled. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Each time you lay into a foe, their state of peril lends you vigor. When you hit a creature with a melee attack, you can use your Reaction to roll a number of d4s equal to your Proficiency Bonus and gain Temporary Hit Points equal to the total rolled. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'stand-fast',
  '[Exploração] Stand Fast',
  90,
  'No matter what kind of upheaval surrounds you, you stand your ground. You have Advantage on saving throws against having the Prone condition.',
  'No matter what kind of upheaval surrounds you, you stand your ground. You have Advantage on saving throws against having the Prone condition.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'strength-of-life',
  '[Combate] Strength of Life',
  91,
  'Effects that corrupt the essence of other living creatures are of little concern to you. You have Resistance to Necrotic damage.',
  'Effects that corrupt the essence of other living creatures are of little concern to you. You have Resistance to Necrotic damage.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'strong-strike',
  '[Combate] Strong Strike',
  92,
  'Hesitation in others is a weakness you’ve learned to take deadly advantage of. When you hit a creature that hasn’t taken a turn in the combat yet, your attack deals an extra 2d6 damage. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'Hesitation in others is a weakness you’ve learned to take deadly advantage of. When you hit a creature that hasn’t taken a turn in the combat yet, your attack deals an extra 2d6 damage. You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'stunt-expert',
  '[Interpretação] Stunt Expert',
  93,
  'Staying loose and limber means being able to get out of even the tightest spots when your life is on the line. You have proficiency in the Acrobatics skill.',
  'Staying loose and limber means being able to get out of even the tightest spots when your life is on the line. You have proficiency in the Acrobatics skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'subtle-cover',
  '[Combate] Subtle Cover',
  94,
  'By slipping behind enemies or allies alike, you are able to fade from view with ease. You can take the Hide action even when you have Half Cover from a creature, as long as that creature is of a size larger than you.',
  'By slipping behind enemies or allies alike, you are able to fade from view with ease. You can take the Hide action even when you have Half Cover from a creature, as long as that creature is of a size larger than you.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'supreme-skirmisher',
  '[Combate] Supreme Skirmisher',
  95,
  'Your brutal strike leaves your foe reeling as you slip away. When you hit a hostile creature with an attack with a weapon or an Unarmed Strike , Opportunity Attacks against you by that creature have Disadvantage until the end of your turn.',
  'Your brutal strike leaves your foe reeling as you slip away. When you hit a hostile creature with an attack with a weapon or an Unarmed Strike , Opportunity Attacks against you by that creature have Disadvantage until the end of your turn.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'supreme-slip',
  '[Combate] Supreme Slip',
  96,
  'Any enemy that tries to grab you is in for a surprise. You have Advantage on Athletics and Acrobatics checks to escape a grapple.',
  'Any enemy that tries to grab you is in for a surprise. You have Advantage on Athletics and Acrobatics checks to escape a grapple.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'swift-strike',
  '[Combate] Swift Strike',
  97,
  'The gift of natural weaponry means you are never unarmed, as your foes learn to their peril. Your Unarmed Strikes deal damage equal to 1d6 + your Strength or Dexterity modifier. The type of damage dealt by your Unarmed Strikes can be Bludgeoning, Piercing, or Slashing, based on the type of natural weaponry you possess (claws, horns, a tail, and so forth).',
  'The gift of natural weaponry means you are never unarmed, as your foes learn to their peril. Your Unarmed Strikes deal damage equal to 1d6 + your Strength or Dexterity modifier. The type of damage dealt by your Unarmed Strikes can be Bludgeoning, Piercing, or Slashing, based on the type of natural weaponry you possess (claws, horns, a tail, and so forth).',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'terrifying-influence',
  '[Interpretação] Terrifying Influence',
  98,
  'Others have learned to fear you—and for good reason.',
  'Others have learned to fear you—and for good reason.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'thorough-sleuth',
  '[Interpretação] Thorough Sleuth',
  99,
  'Putting together the pieces of even the darkest mysteries is second nature to you. You have proficiency in the Investigation skill.',
  'Putting together the pieces of even the darkest mysteries is second nature to you. You have proficiency in the Investigation skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'to-the-dregs',
  '[Combate] To the Dregs',
  100,
  'As your enemy’s life force ebbs, you grow ever stronger. If you have the Natural Attack trait, each time you hit with an Unarmed Strike , you gain Temporary Hit Points equal to the damage dealt by the attack.',
  'As your enemy’s life force ebbs, you grow ever stronger. If you have the Natural Attack trait, each time you hit with an Unarmed Strike , you gain Temporary Hit Points equal to the damage dealt by the attack.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'tongue-of-gold',
  '[Interpretação] Tongue of Gold',
  101,
  'You have learned that the best way to deal with certain threats is to keep those threats from escalating. You have proficiency in the Persuasion skill.',
  'You have learned that the best way to deal with certain threats is to keep those threats from escalating. You have proficiency in the Persuasion skill.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'unparalleled-endurance',
  '[Combate] Unparalleled Endurance',
  102,
  'The battles you need yet to fight are many, and death is not an option. When you are reduced to 0 Hit Points but not killed outright, you can drop to 1 Hit Point instead. You regain the use of this feature when you finish a Long Rest.',
  'The battles you need yet to fight are many, and death is not an option. When you are reduced to 0 Hit Points but not killed outright, you can drop to 1 Hit Point instead. You regain the use of this feature when you finish a Long Rest.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'vigorous',
  '[Exploração] Vigorous',
  103,
  'An innate resilience lets you shake off conditions that would take others down. You have Advantage on saving throws connected to gaining or removing Exhaustion levels.',
  'An innate resilience lets you shake off conditions that would take others down. You have Advantage on saving throws connected to gaining or removing Exhaustion levels.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'virtuoso',
  '[Interpretação] Virtuoso',
  104,
  'In the quieter moments, music can help you forget the horrors you’ve seen. You have proficiency with two instruments of your choice.',
  'In the quieter moments, music can help you forget the horrors you’ve seen. You have proficiency with two instruments of your choice.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'wall-walker',
  '[Exploração] Wall Walker',
  105,
  'Sometimes staying away from what threatens you means getting clear of those threats. You have a Climb Speed equal to your Speed.',
  'Sometimes staying away from what threatens you means getting clear of those threats. You have a Climb Speed equal to your Speed.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'water-born',
  '[Exploração] Water Born',
  106,
  'Surviving underwater is second nature to you. You can breathe air and water.',
  'Surviving underwater is second nature to you. You can breathe air and water.',
  'grim-hollow-players-guide-2024-en'
),
(
  'species'::rpg.option_scope,
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits'),
  'ghHeritageTraitId',
  'weapon-specialist',
  '[Combate] Weapon Specialist',
  107,
  'The weapons you wield might save your life one day, and you know their secrets. You have proficiency with three weapons of your choice.',
  'The weapons you wield might save your life one day, and you know their secrets. You have proficiency with three weapons of your choice.',
  'grim-hollow-players-guide-2024-en'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  benefit = EXCLUDED.benefit,
  level1_benefit = EXCLUDED.level1_benefit,
  edition_slug = EXCLUDED.edition_slug;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dragonborn'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dwarf'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-elf'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-gnome'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-halfling'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-human'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dreamer'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-grudgel'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-laneshi'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-ogresh'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-accursed'),
  'Tamanho',
  'Pequeno ou Médio, conforme você determinar.',
  'gh_heritage_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-arisen'),
  'Tamanho',
  'Pequeno ou Médio, conforme você determinar.',
  'gh_heritage_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-dhampir'),
  'Tamanho',
  'Pequeno ou Médio, conforme você determinar.',
  'gh_heritage_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-disembodied'),
  'Tamanho',
  'Pequeno ou Médio, conforme você determinar.',
  'gh_heritage_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-downcast'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wechselkind'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 1',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_1'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 2',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_2'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 3',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_3'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 4',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_4'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 5',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_5'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 6',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_6'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 7',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_7'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 8',
  'Escolha um traço tradicional do pool de herança Grim Hollow.',
  'gh_heritage_trait_8'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Trocar deslocamento por traço extra',
  'Reduza seu deslocamento em 1,5 m para ganhar um 9º traço modular (escolha em Traço modular 9).',
  'gh_heritage_speed_trade'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Traço modular 9',
  'Disponível se você trocar 1,5 m de deslocamento por um traço extra.',
  'gh_heritage_trait_9'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'gh-wulven'),
  'Tamanho',
  'Pequeno ou Médio, conforme você determinar.',
  'gh_heritage_size'::rpg.species_choice_kind
)
ON CONFLICT (species_id, name) DO UPDATE SET description = EXCLUDED.description, choice_kind = EXCLUDED.choice_kind;

