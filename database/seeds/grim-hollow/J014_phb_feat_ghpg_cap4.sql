-- Grim Hollow Cap. 4 — talentos referenciados por antecedentes e catálogo GH

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
(
  'blood-hound',
  'Blood Hound',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'convincing-inquisitor',
  'Convincing Inquisitor',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'deathbound',
  'Deathbound',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'fortuneofthe-thaumaturge',
  'Fortune of the Thaumaturge',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'free-sword-mercenarys-will',
  'Free Sword Mercenary’s Will',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'insightful-collector',
  'Insightful Collector',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'resolutionofthe-syndicate',
  'Resolution of the Syndicate',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'survivor',
  'Survivor',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'triage-expert',
  'Triage Expert',
  'origin',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'blackpowder-pistol-expert',
  'Blackpowder Pistol Expert',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'expanded-grip',
  'Expanded Grip',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'hulking-figure',
  'Hulking Figure',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'iron-gut',
  'Iron Gut',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'lightning-caster',
  'Lightning Caster',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'medicianofthe-morbus-doctore',
  'Medician of the Morbus Doctore',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'nimble-physique',
  'Nimble Physique',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'sangromantic-initiate',
  'Sangromantic Initiate',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'shadowsteel-adept',
  'Shadowsteel Adept',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'shadowsteel-master',
  'Shadowsteel Master',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'syndicate-spy',
  'Syndicate Spy',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'thrown-weapon-master',
  'Thrown Weapon Master',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'witch-hunter',
  'Witch Hunter',
  'general',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'close-combat-artillerist',
  'Close Combat Artillerist',
  'fighting-style',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'dual-shot',
  'Dual Shot',
  'fighting-style',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'flurry',
  'Flurry',
  'fighting-style',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'mobile-combatant',
  'Mobile Combatant',
  'fighting-style',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'opportunist',
  'Opportunist',
  'fighting-style',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'prone-defense',
  'Prone Defense',
  'fighting-style',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-archlich',
  'Boon of the Archlich',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-ascended-vampire',
  'Boon of the Ascended Vampire',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-earthly-tether',
  'Boon of the Earthly Tether',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elder-horror',
  'Boon of the Elder Horror',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elder-fey',
  'Boon of the Elder Fey',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elder-fiend',
  'Boon of the Elder Fiend',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-elemental-temperance',
  'Boon of the Elemental Temperance',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-high-seraph',
  'Boon of the High Seraph',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonof-magic-resistance',
  'Boon of Magic Resistance',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonof-perfect-flight',
  'Boon of Perfect Flight',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonof-shadowsteel-mastery',
  'Boon of Shadowsteel Mastery',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
),
(
  'boonofthe-wilds',
  'Boon of the Wilds',
  'epic-boon',
  FALSE,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  repeatable = EXCLUDED.repeatable,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'), 1, 'Visão geral', 'Your senses are heightened beyond those of most folk. Whether these senses were strengthened through training or the loss of other senses, or they simply matured as you did, you are a master of finding those whom you seek. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'), 2, 'Motion Sensor', 'Whenever a creature that is Small or larger moves within 10 feet of you while you do not have the Unconscious condition, you immediately become aware of its presence.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'), 3, 'No Hiding', 'You have Advantage on Wisdom ( Perception ) checks that rely on sound or smell.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 1, 'Visão geral', 'You know how to spot a liar, and you can get people to see your way, whether through charm, reasonable arguments, or force of will. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 2, 'Charming Presence', 'When you take the Influence action, you don’t have Disadvantage on checks to influence Hostile creatures, and you have Advantage on checks to influence Indifferent creatures.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 3, 'Multiple Paths', 'You can use any ability modifier when you take the Influence action to make an Intimidation or Persuasion check.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'), 4, 'Zealous Insight', 'When you succeed on a Search action’s Wisdom ( Insight ) check to detect lies or evasive answers, you have Advantage on Initiative rolls involving combat against that creature for 1 hour.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'), 1, 'Visão geral', 'You have seen death many times, up close and personal, and sometimes at your own hand. These experiences have affected you deeply, teaching you about life and death. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'), 2, 'One Last Breath', 'If you have two Death Saving Throw failures, you have Advantage on Death Saving Throws until you are no longer at 0 Hit Points.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'), 3, 'Recuperation', 'When you spend a Hit Point Die during a Short Rest to recover Hit Points, you can roll the Hit Point Die twice and use the higher roll.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), 1, 'Visão geral', 'Your connection to the Thaumaturge puts you in touch with forces outside mortal understanding, making others think you were born under a fortunate moon. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), 2, 'Fortune’s Fortitude', 'When you fail a D20 Test , you can expend and roll one Hit Point Die, adding that number to your result. You can do this only once per D20 Test. You can use this benefit a number of times equal to your Proficiency Bonus, and you regain all uses of this ability when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), 3, 'Fortune of the Unknown', 'When using the Fortune’s Fortitude benefit, if you roll the highest or lowest number on the Hit Point Die, you regain that Hit Point Die. It still counts as a use of Fortune’s Fortitude.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), 1, 'Visão geral', 'Your training with the Company of Free Swords has given you an increased stamina and an attitude that make you less likely to succumb to hardships. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), 2, 'Hold the Ground', 'When you are moved without using your movement by a creature, you can take a Reaction to reduce the distance you are moved by up to your Speed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), 3, 'Resolute', 'You have Advantage on saving throws that would apply a condition.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), 1, 'Visão geral', 'Your expeditions, transactions, and mercantile activities on behalf of the Augustine Trading Company have put you in contact with collectors of historical artifacts, relics, and tomes. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), 2, 'Object Intuition', 'You can take a Study action to examine one magical object and learn its properties and how to use it without attuning to it or taking a Short Rest in physical contact with it, but you don’t learn any curse the item might bear. There is a cumulative 5% chance for every rarity above Common that you misidentify the nature and the power of the object.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), 3, 'Rare Find', 'You begin play in possession of a Common magic item. Work with your GM to decide on which object fits your character and the campaign.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'), 1, 'Visão geral', 'Membership in the Ebon Syndicate provides perks—one of which is the motivation that comes with the understanding that the Syndicate kills those who fail too often. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'), 2, 'Quick Strike', 'On your first turn after an Initiative roll, add 1d4 to the first damage roll you make. This extra damage increases to 2d4 at character level 9, and to 4d4 at character level 16.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'), 3, 'Resilient', 'Your Hit Point maximum increases by an amount equal to your character level when you gain this feat. Whenever you gain a character level thereafter, your Hit Point maximum increases by an additional 1 Hit Point.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 1, 'Visão geral', 'Your ability to make the best out of a bad situation has served you well. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 2, 'Hardy', 'You need half the amount of food per day based on your size.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 3, 'Intuitive', 'When you take the Study action, you have Advantage on Intelligence checks made when taking the Study action.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'), 4, 'Shake It Off', 'Whenever you finish a Short Rest, your Exhaustion level, if any, decreases by 1. Additionally, when you finish a Long Rest, your Exhaustion level decreases by 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), 1, 'Visão geral', 'You are trained in dealing with injuries on the battlefield, and with the saving of lives afterward. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), 2, 'Bedside Manner', 'Whenever you cause a creature to regain Hit Points or the Blood and Bone benefit, you can roll one extra die and discard the lowest die.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), 3, 'Blood and Bone', 'Taking the Utilize action and expending the use of a Healer’s Kit lets you heal a creature within 5 feet of you. The creature can expend and roll a Hit Point Die and regain that number of Hit Points.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+)

You have become practiced with the use of Blackpowder Pistols. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 2, 'Ability Score Increase', 'Increase your Dexterity, Constitution, or Intelligence score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 3, 'Deadeye', 'Attacking at long range doesn’t impose Disadvantage on your attack rolls with a Blackpowder Pistol . Quick Load. You ignore the Loading property of the Blackpowder Pistol.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), 4, 'Trick Shot', 'Immediately after a creature within 5 feet of you moves, you can take a Reaction to make a ranged attack with a Blackpowder Pistol against that creature.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Strength 13+)

Your natural ability with larger weapons lets you use them in a way others can’t. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 2, 'Ability Score Increase', 'Increase your Strength, Dexterity, or Constitution score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 3, 'One-Handed Grip', 'When you use a Versatile weapon with one hand, the weapon deals the damage in parentheses when used to make a melee attack.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'), 4, 'Zealous Grasp', 'If an effect forces you to drop what you are holding, you can make a DC 15 Strength saving throw to maintain your grip. When you are subjected to an effect that allows you to make a saving throw to maintain your grip, you have Advantage on the saving throw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Strength 13+)

Either from extensive training or a natural build, you have a broad and formidable size for your species. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 2, 'Ability Score Increase', 'Increase your Strength or Constitution score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 3, 'Brutal', 'Once per turn, you can deal an extra 1d4 Bludgeoning damage to a target you hit with an Unarmed Strike .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 4, 'Intimidating', 'When you make a Charisma ( Intimidation , Performance , or Persuasion ) check, you can also add your Strength modifier to the roll.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'), 5, 'Powerful', 'You count as one size larger (to a maximum size of Large) when determining your carrying capacity.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Constitution 13+)

You can eat like a hill giant and drink like a fish. Years of punishing your stomach and liver have led to a powerful fortitude. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 2, 'Ability Score Increase', 'Increase your Strength, Constitution, or Charisma score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 3, 'Inured to Poison', 'You have Advantage on saving throws you make to avoid or end the Poisoned condition.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 4, 'Everything Looks Delicious', 'You have Advantage on Wisdom ( Survival ) checks to forage for food.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), 5, 'Quick to Recover', 'As a Bonus Action, you can expend one of your Hit Point Dice, roll the die and add your Constitution modifier, and regain a number of Hit Points equal to the roll’s total. Once you use this benefit, you can’t use it again until you finish a Short or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Spellcasting or Pact Magic Feature)

Your rapid-fire style of casting cantrips allows you to weave magic with uncanny speed. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 2, 'Ability Score Increase', 'Increase your Intelligence, Wisdom, or Charisma score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 3, 'Dual Target', 'When you cast a cantrip with a casting time of an action that targets a single creature, you can use a Bonus Action to target a second creature within the cantrip’s range.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), 4, 'Immediate Response', 'When you cast a spell as a Reaction , that spell doesn’t expend a spell slot. Once you use this benefit, you can’t use it again until you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'medicianofthe-morbus-doctore'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Triage Expert Feat)

You are a master of the medical sciences because of your association with a medical institute. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'medicianofthe-morbus-doctore'), 2, 'Adept Medic', 'When you use the Blood and Bone benefit of the Triage Expert feat, the creature can spend up to three Hit Point Dice instead of one.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'medicianofthe-morbus-doctore'), 3, 'Battle Surgeon', 'When you use the Blood and Bone benefit of the Triage Expert feat, the creature can spend three Hit Point Dice to end one of the following conditions on itself instead of regaining Hit Points: Blinded , Deafened , Paralyzed , Poisoned , or Stunned . Alternatively, you can cure one Grievous Wound affecting the creature (see Grim Hollow Campaign Guide ).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Dexterity 13+)

You are small and thin for your species. You have a mysterious and consistent ability to avoid danger. You gain the following benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 2, 'Ability Score Increase', 'Increase your Strength, Dexterity, or Constitution score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 3, 'Dodgy', 'While you aren’t wearing armor or wielding a Shield , you can take the Dodge action as a Bonus Action.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'nimble-physique'), 4, 'Slippery', 'While you are Grappled or Restrained , your attacks don’t have Disadvantage and attacks against you don’t have Advantage .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Spellcasting or Pact Magic Feature)

You have become adept enough with weaving blood magic to mitigate some of the harm of Sangromancy. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'), 2, 'Blood Magic', 'Choose a Sangromancy spell from any spell list of a level for which you have spell slots. You always have that spell prepared. You can cast it once without a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. You can also cast the spell using any spell slot you have.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'), 3, 'Sanguine Potency', 'You have a pool of two d12s that you can expend instead of Hit Point Dice when you cast Sangromancy spells. Your pool regains all expended dice when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Spellcasting or Pact Magic Feature)

You have learned to tap into the dangerous but powerful art of Shadowsteel casting. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 2, 'Ability Score Increase', 'Increase your Intelligence, Wisdom, or Charisma score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 3, 'Curse Caster', 'You always have Shadowsteel curses prepared, and you can cast them with any spell slots you have.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 4, 'Shadowsteel’s Bite', 'While holding your Shadowsteel Focus , you gain a +1 bonus to spell attack rolls and to the saving throw DCs of your spells.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'), 5, 'Shadowsteel Weapon', 'If your Shadowsteel Focus is also a weapon, that weapon has a +1 bonus to weapon attack rolls and damage rolls.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 8+, Shadowsteel Adept Feat)

Your mastery over Shadowsteel grows stronger. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 2, 'Ability Score Increase', 'Increase your Intelligence, Wisdom, or Charisma score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 3, 'Necrotic Harmony', 'While holding your Shadowsteel Focus , when you cast a spell that targets one or more creatures and requires an attack roll or saving throw, you can choose one target you hit or who failed the saving throw to also take 1d4 Necrotic damage for each spell slot level expended to cast the spell.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'), 4, 'Necrotic Weapon', 'If your Shadowsteel Focus is also a weapon, that weapon has a +2 bonus to weapon attack rolls and damage rolls. Additionally, once on each of your turns, when you hit a creature with a weapon attack roll using your Shadowsteel Focus, you can cause the target to take an extra 2d8 Necrotic damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Syndicate Smuggler background)

Rising in the ranks of the Ebon Syndicate has taught you the clandestine skills of spycraft, valuable in your trade as a racketeer. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 2, 'Locksmith', 'You have proficiency with Thieves’ Tools . While holding Thieves’ Tools, you can craft a key to a lock by spending 10 minutes with that lock.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 3, 'Master of Disguise', 'You have proficiency with a Disguise Kit . If you spend 10 minutes donning a Costume , you decide what you look like, including your height, weight, facial features, sound of your voice, hair length, coloration, and other distinguishing characteristics. You can make yourself appear as a member of another species, though none of your statistics change. You can’t appear as a creature of a different size, and your basic shape stays the same; if you’re bipedal, you can’t use this benefit to become quadrupedal, for instance.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 4, 'Master Calligrapher', 'You have proficiency with a Forgery Kit . You aren’t limited to 10 or fewer words when mimicking someone else’s handwriting.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'syndicate-spy'), 5, 'Blending In', 'When using the Hide action to conceal yourself from creatures that aren''t Hostile to you, you need only be Lightly Obscured and you may use Charisma instead of Dexterity for the check.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+, Strength or Dexterity 13+)

You excel at thrown weapons. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 2, 'Ability Score Increase', 'Increase your Strength or Dexterity score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 3, 'Multithrow', 'After you take the Attack action to make a ranged attack roll using a Simple weapon that has the Thrown property, you can make two additional ranged attacks using Simple weapons that have the Thrown property as a Bonus Action.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 4, 'Quick Hands', 'As a Bonus Action, you can retrieve and stow or wield all Simple weapons with the Thrown property that are within 5 feet of you. You need a free hand to perform this maneuver.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'), 5, 'Returning', 'Simple weapons with the Thrown property that you are proficient with also have the Returning property (see Chapter 8: Advanced Weapons & Equipment ). Heritage Traits as Feat Alternatives If feats, especially Origin feats, don’t fit the tenor or power level of your campaign, a viable alternative is to allow players to take one or two extra Heritage Traits (see Chapter 1 ) instead of a feat. This gives the player even more flexibility in imagining and building a character to the player’s exact mechanical or roleplaying specifications. Many of the Heritage Traits can be explained as part of a background.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 1, 'Visão geral', 'General Feat (Prerequisite: Level 4+)

You have honed and perfected your skills fighting against spellcasters, possibly from your background hunting mages as part of the Arcanist Inquisition . You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 2, 'Ability Score Increase', 'Increase your Strength, Constitution, or Wisdom score by 1, to a maximum of 20.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 3, 'Dodge Spells', 'You can take a Reaction to avoid a spell that is targeting only you and doesn’t create an area of effect. Make a Wisdom saving throw against the spellcaster’s spell save DC. On a successful save, the creature must choose a new target or the spell is canceled. A canceled spell dissipates with no effect, and any resources used to cast it are wasted.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 4, 'Keep Your Enemies Close', 'When you hit a target that can cast spells with an attack roll using a Melee weapon or an Unarmed Strike , you can reduce its Speed by 15 feet until the start of your next turn.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), 5, 'Resist Curses', 'You have Advantage on saving throws against all Shadowsteel curses, and also against spells with a duration of more than 10 minutes. Ah...you''re not from around here. Let me give you a friendly word of advice. Keep your opinions to yourself. We''re a quiet village, and we''d prefer to keep it that way. We don''t need a sanctimonious outsider telling us how much better life could be with a little magic. — Helpful Castinellan Villager') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'close-combat-artillerist'), 1, 'Visão geral', 'Fighting Style Feat (Prerequisite: Fighting Style Feature)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'close-combat-artillerist'), 2, 'Firing in Melee', 'Being within 5 feet of an enemy doesn’t impose Disadvantage on your attack rolls with Ranged weapons.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'close-combat-artillerist'), 3, 'Point Blank', 'When you hit a creature that is within 5 feet of you with a ranged attack, you gain a +2 bonus to the damage roll.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'dual-shot'), 1, 'Visão geral', 'Fighting Style Feat (Prerequisite: Fighting Style Feature)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'dual-shot'), 2, 'Dual Shot', 'When you take the Attack action on your turn and attack with a bow or crossbow, you can make one extra attack as part of the same action against a creature that is within 10 feet of the original target that is within the weapon’s range. If you do so, both attacks are made with Disadvantage .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'flurry'), 1, 'Visão geral', 'Fighting Style Feat (Prerequisite: Fighting Style Feature)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'flurry'), 2, 'Quick Strike', 'Once on each of your turns when you make an attack roll with a weapon or an Unarmed Strike and have Advantage on the roll, you can forgo Advantage on that attack roll. After resolving that attack, you can then make another attack with the same weapon or Unarmed Strike against a different creature. The new target must be within 5 feet of the first target and within the weapon''s reach. I’ve seen unorthodox fighting styles, but hers was as strange as it was deadly. — Valikan Raider') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'mobile-combatant'), 1, 'Visão geral', 'Fighting Style Feat (Prerequisite: Fighting Style Feature)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'mobile-combatant'), 2, 'Slippery', 'When you take the Attack action, your Speed increases by 10 feet and Opportunity Attack action have Disadvantage against you until the end of your turn.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'opportunist'), 1, 'Visão geral', 'Fighting Style Feat (Prerequisite: Fighting Style Feature)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'opportunist'), 2, 'Exploit Weakness', 'Whenever you make an attack as part of a Reaction , you gain a +2 bonus to the attack and damage rolls.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'prone-defense'), 1, 'Visão geral', 'Fighting Style Feat (Prerequisite: Fighting Style Feature)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'prone-defense'), 2, 'Defensive', 'When you have the Prone condition, you don’t have Disadvantage on attack rolls. Attack roll against you doesn’t have Advantage because of the Prone condition.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'prone-defense'), 3, 'Hop Up', 'When you have the Prone condition, you can right yourself with only 5 feet of movement.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-archlich'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Lich Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-archlich'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-archlich'), 3, 'Vessel of Vitality', 'Whenever you finish a Long Rest, if your Soul Vessel is not charged, it gains a soul and becomes charged.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-ascended-vampire'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Vampire Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-ascended-vampire'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-ascended-vampire'), 3, 'Inured to Sunlight', 'You are no longer affected by sunlight.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Specter Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 3, 'Persistent Haunter', 'You are no longer affected by the Fraying Reality Transformation Flaw .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-earthly-tether'), 4, 'Divergent Growth', 'Choose any Specter Transformation Boon that you don’t already have but meet the prerequisites for. You gain that Boon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Aberrant Horror Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 3, 'Stabilizing Form', 'When you roll a 25 or lower on the Unstable Form table, you can choose to roll again. You must use the new result. Once you use this benefit, you can’t use it again until you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-horror'), 4, 'Divergent Growth', 'Choose any Aberrant Horror Transformation Boon that you don’t already have but meet the prerequisites for. You gain that Boon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Fey Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 3, 'Fey Bulwark', 'You are no longer affected by the Weakened Constitution Transformation Flaw .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fey'), 4, 'Divergent Growth', 'Choose any Fey Transformation Boon that you don’t already have but meet the prerequisites for. You gain that Boon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Fiend Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 3, 'Free Agent', 'You are no longer affected by the Pull of The Netherworld Transformation Flaw .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elder-fiend'), 4, 'Divergent Growth', 'Choose any Fiend Transformation Boon that you don’t already have but meet the prerequisites for. You gain that Boon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elemental-temperance'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Primordial Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elemental-temperance'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-elemental-temperance'), 3, 'Controlled Chaos', 'You are no longer affected by the Primordial Chaos Transformation Flaw .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Seraph Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 3, 'Absolution', 'You are no longer affected by the Seraph Corruption Transformation Flaw .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-high-seraph'), 4, 'Divergent Growth', 'Choose any Seraph Transformation Boon that you don’t already have but meet the prerequisites for. You gain that Boon. The most powerful creatures are mostly unknown and unobserved. You are usually dead before you can observe them—and therefore you cannot know them. But I’ve heard tales that there are some who can capture the spark of immortality through careful training, meditation, or magic. But I fear that these are only tales—for even a spark of the immortal would sear through mortal flesh like a hot iron through parchment. — Charneaultian Philosopher') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-magic-resistance'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-magic-resistance'), 2, 'Ability Score Increase', 'Increase your Intelligence or Wisdom score by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-magic-resistance'), 3, 'Heroic Resistance', 'If you fail a saving throw, you can cause yourself to succeed instead. Once you use this benefit, you can’t use it again until you finish a Short or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+)

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 2, 'Ability Score Increase', 'Increase your Strength or Dexterity score by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 3, 'Flying', 'You have a Fly Speed of 40 feet and can hover.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'), 4, 'Graceful Fall', 'If you fall more than 5 feet, your rate of descent slows to 60 feet per round until you land. Kentigern endured the icy wyrm''s frigid breath as if it were nothing more than a cool summer breeze. - Valikan Storyteller') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-shadowsteel-mastery'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Shadowsteel Ghoul Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-shadowsteel-mastery'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-shadowsteel-mastery'), 3, 'Strange Bedfellows', 'You are no longer affected by the Friendless Transformation Flaw .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-wilds'), 1, 'Visão geral', 'Epic Boon Feat (Prerequisite: Level 19+, Lycanthrope Transformation )

You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-wilds'), 2, 'Ability Score Increase', 'Increase one ability score of your choice by 1, to a maximum of 30.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'boonofthe-wilds'), 3, 'Apex Predator', 'When you enter your Hybrid Form, you gain 25 Temporary Hit Points . At the end of each of your turns while in Hybrid Form, if you have no Temporary Hit Points, you gain 10 Temporary Hit Points. While you are in your Hybrid Form and have no Temporary Hit points, you have Advantage on attack rolls. //') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
