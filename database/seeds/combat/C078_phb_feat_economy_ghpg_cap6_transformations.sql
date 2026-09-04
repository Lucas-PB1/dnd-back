-- Economy — transformações Grim Hollow Cap. 6
-- Gerado por scripts/generate-ghpg-cap6-economy-seeds.mjs
-- table_action = `{transformationSlug}/{boonId}`; spend-resource quando alwaysSpendsResource.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'aberrant-mutation-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), NULL,
  'Aberrant Mutation', 'bonus'::rpg.action_economy_bucket, 1,
  'aberrant-mutation-uses', NULL, TRUE,
  'Aberrant Mutation', 'Your body can twist and reshape itself as you will it, changing body parts into dangerous or useful tools and regenerating after taking damage. These abilities are represented by Aberrant Mutations. You can manifest an Aberrant Mutation listed below a number of times equal to your Proficiency Bonus plus your current Transformation Stage.

Each of these Aberrant Mutations last for 1 minute, and you can end them early by spending a Bonus Action to remove them or take on a different mutation. If you choose another Aberrant Mutation, you must spend another use of this feature.

You regain all uses of this ability when you finish a Short or Long Rest.

Chitinous Shell. As a Bonus Action, you grow a hard, crustacean-like shell. While this mutation is active and are not wearing heavy armor, your Armor Class increases by 2. While you maintain this shell, your Speed is reduced by 10 feet.

Eldritch Limbs. As a Bonus Action, you transform one or both of your arms into thick muscle, scything claws, or sharpened bone. When you use the Attack action, you can replace one or more attacks with melee attacks made with your eldritch limb. You are considered proficient with this attack, and it uses either Strength or Dexterity (your choice). On a hit, the attack deals 1d8 damage (either Bludgeoning, Piercing, or Slashing, chosen each time you manifest the mutation).

As a Bonus Action, you can make a melee attack with your eldritch limb.

Your eldritch limbs cannot hold weapons, shields, or other items. They are not considered weapons or Unarmed Strikes.

Slimy Form. As a Bonus Action, you cover yourself in a slippery slime. You have Advantage on ability checks to escape a grapple, and you can use the Dash action as a Bonus Action. You also gain Resistance to Acid, Fire, and Cold damage while in this form.',
  'gh-transformation-aberrant-horror/aberrant-mutation', NULL, 601, NULL, NULL
),
(
  'writhing-tendrils-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), NULL,
  'Writhing Tendrils', 'bonus'::rpg.action_economy_bucket, 2,
  'writhing-tendrils-uses', NULL, TRUE,
  'Writhing Tendrils', 'You gain the ability to grow long, tendril-like appendages out of your body. As a Bonus Action, these tendrils sprout from you. While you maintain these tendrils, you gain the following benefits:

• When a creature moves to within 5 feet of you, you can try to push it back as a Reaction . Unless the creature succeeds on a Strength saving throw, it is pushed 5 feet away from you and its Speed is reduced to 0 until the start of your next turn. The DC of the saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.

• Your tendrils can protect you if you move. You can use a Bonus Action to Disengage .

• As a Reaction to being targeted with a melee attack, you can cause that creature to have Disadvantage on all melee attacks it makes that turn.

The tendrils last for 1 minute. You can use a Bonus Action to retract your tendrils.

You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Short Rest or Long Rest.',
  'gh-transformation-aberrant-horror/writhing-tendrils', NULL, 602, NULL, NULL
),
(
  'servant-of-the-spring-court-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Servant of the Spring Court', 'bonus'::rpg.action_economy_bucket, 1,
  'servant-of-the-spring-court-uses', NULL, TRUE,
  'Servant of the Spring Court', 'The Spring Court embodies carnal desires, rebirth, and the planting and sowing season. The Fey creatures of Spring tend to be capricious, unreliable, and quick to flare their emotions. This is the court most associated with satyrs and nymphs. Creatures of the Spring Court hide savage intentions and uncontrollable urges behind gentle words.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Thunder damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.',
  'gh-transformation-fey/servant-of-the-spring-court', NULL, 603, 'stage1Boon', 'servant-of-the-spring-court'
),
(
  'servant-of-the-summer-court-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Servant of the Summer Court', 'bonus'::rpg.action_economy_bucket, 1,
  'servant-of-the-summer-court-uses', NULL, TRUE,
  'Servant of the Summer Court', 'The Summer Court embodies the lush warmth and manic celebration of the growing season. The Fey creatures of Summer tend toward joviality, excess, and vanity. This is the court most associated with dryads and pixies. Creatures of the Summer Court often hide their narcissism and cruelty behind beautiful façades.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Fire damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.',
  'gh-transformation-fey/servant-of-the-summer-court', NULL, 604, 'stage1Boon', 'servant-of-the-summer-court'
),
(
  'servant-of-the-autumn-court-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Servant of the Autumn Court', 'bonus'::rpg.action_economy_bucket, 1,
  'servant-of-the-autumn-court-uses', NULL, TRUE,
  'Servant of the Autumn Court', 'The Autumn Court embodies the careful scheming and approaching rot of the harvesting season. The Fey creatures of Autumn tend to be devious, scheming, and full of secrets. This is the court most associated with treants and other plant fey. Creatures of the Autumn Court often appear beautiful and helpful, but in truth their forms are hideous and methods vile.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Poison damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.',
  'gh-transformation-fey/servant-of-the-autumn-court', NULL, 605, 'stage1Boon', 'servant-of-the-autumn-court'
),
(
  'servant-of-the-winter-court-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Servant of the Winter Court', 'bonus'::rpg.action_economy_bucket, 1,
  'servant-of-the-winter-court-uses', NULL, TRUE,
  'Servant of the Winter Court', 'The winter court embodies the stillness, darkness, and death of the coldest season. The Fey creatures of Winter tend to be serious, cruel, and reflective. Creatures of the Winter Court are often terrifying to behold and very direct about their intentions.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Cold damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.',
  'gh-transformation-fey/servant-of-the-winter-court', NULL, 606, 'stage1Boon', 'servant-of-the-winter-court'
),
(
  'two-faced-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Two-Faced', 'action'::rpg.action_economy_bucket, 2,
  'two-faced-uses', NULL, TRUE,
  'Two-Faced', 'You can transform your face into a vision of enchantment or horror that affects creatures around you, based on the Fey Court you serve. As a Magic action, you take on this visage. Creatures within 30 feet who can see you must succeed on a Charisma saving throw with a DC equal to 8 plus your Charisma modifier plus your Transformation Stage or be affected for 1 minute.

You can do this a number of times equal to your Proficiency Bonus, and you regain all uses after finishing a Long Rest.

Spring. Any creature that fails the saving throw has the Stunned condition. The creature can attempt a Constitution saving throw at the end of each of their turns to end the condition. This effect ends early on a creature if you or an ally deal damage to it or take other harmful actions.

Summer. Any creature that fails the saving throw gains the Charmed condition. This effect ends early on a creature if you or an ally deal damage to it or take other harmful actions.

Autumn. Any creature that fails the saving throw gains the Poisoned condition. The creature can attempt a Constitution saving throw at the end of each of their turns to end the condition.

Winter. Any creature that fails the saving throw becomes Frightened of you. This effect ends early if a creature affected by this ability ends its turn out of your line of sight.',
  'gh-transformation-fey/two-faced', NULL, 607, 'stage2Boon', 'two-faced'
),
(
  'magic-tricks-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Magic Tricks', 'free'::rpg.action_economy_bucket, 2,
  'magic-tricks-uses', NULL, TRUE,
  'Magic Tricks', 'Your Fey masters provide you with the ability to weave magic based on your Fey Court allegiance. You gain the ability to cast one cantrip, one level 1 spell, and one level 2 spell. You can cast each of these once without using a spell slot or needing spell components. You regain the ability to cast these spells when you finish a Long Rest. The DC for these spells is 8 plus your Proficiency Bonus plus your Transformation Stage.

Spring. Your cantrip is Poison Spray , and your spells are Fog Cloud and Misty Step .

Summer. Your cantrip is Fire Bolt , and your spells are Burning Hands and Flame Blade .

Autumn. Your cantrip is Shillelagh , and your spells are Thunderwave and Ray of Enfeeblement .

Winter. Your cantrip is Ray of Frost , and your spells are Ice Knife and Darkness .',
  'gh-transformation-fey/magic-tricks', NULL, 608, 'stage2Boon', 'magic-tricks'
),
(
  'tooth-and-claw-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Tooth and Claw', 'bonus'::rpg.action_economy_bucket, 3,
  'tooth-and-claw-uses', NULL, TRUE,
  'Tooth and Claw', 'You can manifest fangs, tusks, claws, or other means of harming your enemies. These manifestations also deliver a powerful magic jolt.

As a Bonus Action, you manifest some natural defense mechanism for 1 minute. This gives you the following benefits:

• You manifest a Claw, Bite, or Gore attack that you may use in place of any weapon attack. This manifested attack deals 1d6 plus your Strength or Dexterity modifier Slashing damage. You are proficient with this attack, and you add either your Strength or Dexterity modifier to attack and damage rolls. This attack is not an Unarmed Strike , nor can it be used in place of an Unarmed Strike.

• After taking an Attack action that did not use your manifested attack, you may take a Bonus Action later in that turn to use your manifested attack once.

• Once per round, when you hit a target with a manifested attack, you can choose to deal an additional 2d6 Psychic damage to the target. The creature must succeed on a Constitution saving throw or have the Stunned condition until the end of its next turn. The DC is 8 plus your Proficiency Bonus plus your Transformation Stage.

You can use this ability a number of times equal to your Proficiency Bonus plus your Transformation Stage. You regain all uses of this ability after completing a Long Rest.',
  'gh-transformation-fey/tooth-and-claw', NULL, 609, 'stage3Boon', 'tooth-and-claw'
),
(
  'dreams-and-nightmares-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Dreams and Nightmares', 'bonus'::rpg.action_economy_bucket, 3,
  'dreams-and-nightmares-uses', NULL, TRUE,
  'Dreams and Nightmares', 'You gain the ability to manipulate the mind of mortal beings. As a Bonus Action, choose a Humanoid you can see within 30 feet of you. That creature must succeed on a Wisdom saving throw. The DC is 8 plus your Proficiency Bonus plus your Transformation Stage.

On a failed saving throw, the creature has the Paralyzed condition, as it is stuck in a blissful dream or a terrifying nightmare. The condition lasts for 1 minute. The target can attempt the Constitution saving throw at the end of each of its turns and each time it takes damage.

You can choose to concentrate on the effect as you would a spell. If you are concentrating on the effect when the target attempts its saving throw, the target has Disadvantage on the saving throw.

You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses of this ability when you finish a Long Rest.',
  'gh-transformation-fey/dreams-and-nightmares', NULL, 610, 'stage3Boon', 'dreams-and-nightmares'
),
(
  'greater-magic-tricks-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Greater Magic Tricks', 'free'::rpg.action_economy_bucket, 4,
  'greater-magic-tricks-uses', NULL, TRUE,
  'Greater Magic Tricks', 'Your Fey masters provide even further magical abilities. You gain the ability to cast one level 3 spell, one level 4 spell, and one level 5 spell. You can cast each of these once without using a spell slot or needing spell components. You regain the ability to cast these spells when you finish a Long Rest. The DC for these spells is 8 plus your Proficiency Bonus plus your Transformation Stage.

Spring. Your spells are Stinking Cloud , Vitriolic Sphere , and Cloudkill .

Summer. Your spells are Fireball , Fire Shield , and Dream .

Autumn. Your spells are Lightning Bolt , Blight , and Hold Monster .

Winter. Your spells are Vampiric Touch , Ice Storm , and Cone of Cold .',
  'gh-transformation-fey/greater-magic-tricks', NULL, 611, 'stage4Boon', 'greater-magic-tricks'
),
(
  'twilight-glamour-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), NULL,
  'Twilight Glamour', 'bonus'::rpg.action_economy_bucket, 4,
  'twilight-glamour-uses', NULL, TRUE,
  'Twilight Glamour', 'As a Magic action, you gain the Invisible condition for 1 hour or until you end it as a Bonus Action. If you make an attack roll, deal damage, or cast a spell that causes the target to make a saving throw, the remaining duration changes to 1 minute.

You can use this ability twice, and you regain all uses after finishing a Long Rest.',
  'gh-transformation-fey/twilight-glamour', NULL, 612, 'stage4Boon', 'twilight-glamour'
),
(
  'infernal-smite-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), NULL,
  'Punição Infernal', 'free'::rpg.action_economy_bucket, 1,
  'infernal-smite-uses', NULL, TRUE,
  'Infernal Smite', 'Once on each of your turns, you can choose one creature you have just damaged with a weapon attack, an Unarmed Strike , or a cantrip. Deal an extra 1d6 Acid, Cold, or Fire damage to that creature, using the same damage type you chose for Fiendish Soul. You can add this damage a number of times equal to your Proficiency Bonus plus your Transformation Stage, but no more than once per damage roll. You regain all uses of this ability when you finish a Short Rest or Long Rest.

At higher Transformation Stages, you do an additional 1d6 of damage per Transformation Stage, for a total of 2d6 at Stage 2, 3d6 at Stage 3, and 4d6 at Stage 4.',
  'gh-transformation-fiend/infernal-smite', NULL, 613, 'stage1Boon', 'infernal-smite'
),
(
  'daemonic-brand-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), NULL,
  'Marca Demoníaca', 'bonus'::rpg.action_economy_bucket, 2,
  'daemonic-brand-uses', NULL, TRUE,
  'Daemonic Brand', 'As a Bonus Action on your turn, you can brand a creature within 60 feet of you that you can see with a fiery mark that remains on them for 1 minute. If the target succeeds on a Wisdom saving throw, they are not branded. The DC of the saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.

If the creature fails the saving throw, you choose one of the following effects that lasts for the duration:

• The creature takes a –2 penalty on all saving throws.

• The first attack against the creature on each turn is made with Advantage .

• The creature cannot regain Hit Points.

You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.',
  'gh-transformation-fiend/daemonic-brand', NULL, 614, 'stage2Boon', 'daemonic-brand'
),
(
  'adept-of-the-green-sisterhood-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Adept of the Green Sisterhood', 'action'::rpg.action_economy_bucket, 2,
  'adept-of-the-green-sisterhood-uses', NULL, TRUE,
  'Adept of the Green Sisterhood', 'As your connection to your Green Sisterhood grows, your body and your magical skills strengthen.

• You gain a Claw attack that deals 1d6 plus your Strength or Dexterity modifier Slashing Damage. You are proficient with this attack, and you add either your Strength or Dexterity modifier to attack and damage rolls. This attack is not an Unarmed Strike , nor can it be used in place of an Unarmed Strike.

• You can hide yourself from others. As a Magic action, you can cast Invisibility without expending a spell slot. You can use this feature a number of times equal to your Transformation Stage. You regain all uses after finishing a Long Rest.',
  'gh-transformation-hag/adept-of-the-green-sisterhood', NULL, 615, 'stage1Boon', 'the-green-sisterhood'
),
(
  'adept-of-the-red-sisterhood-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Adept of the Red Sisterhood', 'action'::rpg.action_economy_bucket, 2,
  'adept-of-the-red-sisterhood-uses', NULL, TRUE,
  'Adept of the Red Sisterhood', 'As your connection to your Red Sisterhood grows, your body and your magical skills strengthen.

• You gain a Claw attack that deals 1d6 plus your Strength or Dexterity modifier Slashing Damage. You are proficient with this attack, and you add either your Strength or Dexterity modifier to attack and damage rolls. This attack is not an Unarmed Strike , nor can it be used in place of an Unarmed Strike.

• You can sway others to your will. As a Magic action, you can cast Charm Person without expending a spell slot. The spell save DC when cast in this way is 12 plus your Transformation Stage. You can use this feature a number of times equal to your Transformation Stage. You regain all uses after finishing a Long Rest.',
  'gh-transformation-hag/adept-of-the-red-sisterhood', NULL, 616, 'stage1Boon', 'the-red-sisterhood'
),
(
  'adept-of-the-sea-sisterhood-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Adept of the Sea Sisterhood', 'action'::rpg.action_economy_bucket, 2,
  'adept-of-the-sea-sisterhood-uses', NULL, TRUE,
  'Adept of the Sea Sisterhood', 'As your connection to your Sea Sisterhood grows, your body and your magical skills strengthen.

• You gain a Claw attack that deals 1d6 plus your Strength or Dexterity modifier Slashing Damage. You are proficient with this attack, and you add either your Strength or Dexterity modifier to attack and damage rolls. This attack is not an Unarmed Strike , nor can it be used in place of an Unarmed Strike.

• You can appear as someone other than yourself. As a Magic action, you can cast Disguise Self without expending a spell slot. The spell save DC when cast in this way is 12 plus your Transformation Stage. You can use this feature a number of times equal to your Transformation Stage. You regain all uses after finishing a Long Rest.',
  'gh-transformation-hag/adept-of-the-sea-sisterhood', NULL, 617, 'stage1Boon', 'the-sea-sisterhood'
),
(
  'master-red-memory-wipe', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Master of the Red Sisterhood', 'free'::rpg.action_economy_bucket, 3,
  'master-of-the-red-sisterhood-memory-uses', NULL, TRUE,
  'Master of the Red Sisterhood — memory wipe', 'You come into your power as a Hag and enhance your abilities.

• When you take the Attack action on your turn, you may make an additional Claw attack. Your Claw attacks deal an additional 1d4 Psychic damage. You regain Hit Points equal to the Psychic damage dealt.

• Your banter becomes supernaturally charming. A creature under your magical influence (such as being Charmed by you) who is able to hear you for 1 minute must must make a Charisma saving throw with a DC equal to 14 plus your Transformation Stage. On a failed save, when your mental influence ends, the target forgets magic was used to influence it. You regain use of this feature after you finish a Short or Long Rest.

• As a Bonus action, you can expend a Hit Point Die to cast the Charm Person spell.',
  'gh-transformation-hag/master-red-memory-wipe', NULL, 618, 'stage1Boon', 'the-red-sisterhood'
),
(
  'master-sea-terrifying-gaze', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Master of the Sea Sisterhood', 'bonus'::rpg.action_economy_bucket, 3,
  'master-of-the-sea-sisterhood-gaze-uses', NULL, TRUE,
  'Master of the Sea Sisterhood — terrifying gaze', 'You come into your power as a Hag and enhance your abilities.

• When you take the Attack action on your turn, you may make an additional Claw attack. Your Claw attacks deal an additional 1d6 Slashing damage.

• Your appearance becomes so vile that it terrifies mortal creatures. As a Bonus Action, you gaze upon a Beast or Humanoid within 30 feet that can see your true form. The creature must succeed on a Wisdom saving throw with a DC equal to 14 plus your Charisma modifier. On a failed save, the target has the Frightened condition until the start of its next turn. A target that succeeds is immune to this feature for 24 hours. You regain use of this feature after you finish a Short or Long Rest.

• As a Magic action, you can expend and roll a Hit Point Die to touch a creature and allow the target to breathe water for a number of minutes equal to the amount rolled.',
  'gh-transformation-hag/master-sea-terrifying-gaze', NULL, 619, 'stage1Boon', 'the-sea-sisterhood'
),
(
  'master-green-recover-slot', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Master of the Green Sisterhood', 'action'::rpg.action_economy_bucket, 3,
  'master-of-the-green-sisterhood-slot-uses', NULL, TRUE,
  'Master of the Green Sisterhood — recover spell slot', 'You come into your power as a Hag and enhance your abilities.

• When you take the Attack action on your turn, you may make an additional Claw attack. Your Claw attacks deal an additional 1d6 Poison damage.

• You learn a corrupt ritual to create a Hag Eye or a Gasdra companion. The ritual takes four hours and 200 GP to complete. You choose which ritual you know when you select this boon. You can only have one Hag Eye or Gasdra companion at a time, and you cannot have both.

• As a Magic action, you can recover an expended spell slot by spending Hit Point Dice equal to the spell slot’s level. The spell slot can have a level equal to no more than one third your character level (round up). Once you use this boon, you can’t do so again until you finish a Long Rest.',
  'gh-transformation-hag/master-green-recover-slot', NULL, 620, 'stage1Boon', 'the-green-sisterhood'
),
(
  'evil-eye-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Evil Eye', 'action'::rpg.action_economy_bucket, 4,
  'evil-eye-uses', NULL, TRUE,
  'Evil Eye', 'Your visage is so horrifying that you can cause creatures to drop dead when your gaze falls upon them. As a Magic action, you gaze upon a Bloodied Beast or Humanoid within 30 feet that can see your true form. The creature must succeed on a Wisdom saving throw with a DC equal to 14 plus your Charisma modifier. If the target fails the save, it drops to 0 Hit Points. On a successful save, the creature takes 6d8 Psychic damage. You regain the use of this feature when you finish a Long Rest.',
  'gh-transformation-hag/evil-eye', NULL, 621, NULL, NULL
),
(
  'grandmothers-curse-cast', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), NULL,
  'Grandmother’s Curse', 'action'::rpg.action_economy_bucket, 4,
  'grandmothers-curse-uses', NULL, TRUE,
  'Grandmother’s Curse', 'You learn one Shadowsteel curse of your choice. You always have it prepared, and it doesn’t count against the number of spells you can prepare each day. You can cast it once per day without using a spell slot or needing spell components.',
  'gh-transformation-hag/grandmothers-curse', NULL, 622, 'stage4Boon', 'grandmothers-curse'
),
(
  'soul-vessel-capture', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), NULL,
  'Captura de alma (Recipiente)', 'action'::rpg.action_economy_bucket, 1,
  'soul-vessel-capture-uses', NULL, TRUE,
  'Soul Vessel — capture soul', 'You have successfully torn your soul from your body and trapped it in a suitable object. The object must be a trinket or item no larger than 1 cubic foot in size. This item becomes your soul vessel.

Soul Vessel. A soul vessel is an enchanted vessel containing a Lich’s soul. Additionally, a soul vessel is a conduit for the lich to feed on captured souls. A soul vessel has the following statistics:

Armor Class: 18

Hit Points: 10 × your Character Level

Speed: 0

Damage Immunities: Poison, Psychic; Bludgeoning, Piercing, and Slashing from non-magical sources

Damage Resistances: Cold, Fire, Lightning, Necrotic, Thunder; Bludgeoning, Piercing, and Slashing from magical sources

While a soul is stored in your soul vessel, the soul vessel is considered charged. The soul contained within the soul vessel must be from a creature whose Challenge Rating is equal to or higher than half your Character Level. The soul vessel can only contain one soul at a time.

You can add a soul to the soul vessel 2 times for each of your Transformation Stages. You regain this ability when you complete a Long Rest.

To store a soul within the soul vessel, the lich must use a Magic action within 1 minute of a creature’s death, or a Reaction triggered by the creature’s death, while holding the vessel to capture the soul, and the dead creature’s body must be within 60 feet of the vessel when the capture occurs. The creature cannot be returned to life until its soul is removed from your soul vessel.

If your soul vessel is reduced to 0 hit points, you must create a new one. Doing so takes a Long Rest. Until you do, you do not gain any of the benefits of having the soul vessel. Also, until you have a soul vessel, you have Disadvantage on the first D20 Test you make after finishing a Short or Long Rest.

If you are killed while you control a charged soul vessel on the same plane of existence, your soul vessel’s charge is consumed. You are brought back to life as per the Resurrection spell within 5 feet of your soul vessel 1 day later. If you are killed and your soul vessel is not charged, you are resurrected 7 days later instead.',
  'gh-transformation-lich/soul-vessel-capture', NULL, 623, NULL, NULL
),
(
  'binding-curse-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), NULL,
  'Binding Curse', 'bonus'::rpg.action_economy_bucket, 2,
  'binding-curse-uses', NULL, TRUE,
  'Binding Curse', 'You can compel a creature with a binding curse. As a Bonus Action, choose a creature within 30 feet who can see you. That creature makes a Charisma saving throw against a DC of 12 plus your Transformation Stage. On a failed save it cannot move more than 30 feet away from you for 1 minute. Also, during that time, your weapon attacks and Unarmed Strikes against the creature deal an additional 2d6 Necrotic damage.

You can use this feature three times, regaining all uses after finishing a Short Rest or Long Rest.',
  'gh-transformation-lich/binding-curse', NULL, 624, NULL, NULL
),
(
  'eldritch-concentration-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), NULL,
  'Eldritch Concentration', 'free'::rpg.action_economy_bucket, 3,
  'eldritch-concentration-uses', NULL, TRUE,
  'Eldritch Concentration', 'Your supernatural ability with magic manifests in new ways. When you cast a spell that requires Concentration , if you are already concentrating on one such spell, you can spend the charge of your soul vessel . If you do this, you do not lose Concentration on the original spell. Instead, you gain 1 Exhaustion level.

If you cast a third Concentration spell during this time, or lose Concentration for any other reason, you lose Concentration on both current spells you are concentrating on. Once you use this feature you cannot use it again until you finish a Short Rest or Long Rest.',
  'gh-transformation-lich/eldritch-concentration', NULL, 625, NULL, NULL
),
(
  'unholy-healing-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), NULL,
  'Unholy Healing', 'action'::rpg.action_economy_bucket, 3,
  'unholy-healing-uses', NULL, TRUE,
  'Unholy Healing', 'Your magical connection to your soul vessel restores your vitality quickly. While your soul vessel is charged, you can use a Magic action to draw healing power from it. At the start of each of your turns for 1 minute, you regain 10 Hit Points. The soul vessel does not lose its charge.

You can use this feature three times, and you regain all uses after finishing a Long Rest.',
  'gh-transformation-lich/unholy-healing', NULL, 626, NULL, NULL
),
(
  'soul-shattering-attack-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), NULL,
  'Soul-Shattering Attack', 'free'::rpg.action_economy_bucket, 4,
  'soul-shattering-attack-uses', NULL, TRUE,
  'Soul-Shattering Attack', 'After you make a weapon attack or Unarmed Strike , you can spend the charge in your soul vessel to add the Challenge Rating of the soul within it to the attack roll and damage dealt with that attack. If the creature dies from that attack, you can instantly recharge your soul vessel with the soul that you just expended.

You can use this feature a number of times equal to 4 plus your Proficiency Bonus. You regain all uses after finishing a Long Rest.',
  'gh-transformation-lich/soul-shattering-attack', NULL, 627, NULL, NULL
),
(
  'ooze-form-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), NULL,
  'Ooze Form', 'bonus'::rpg.action_economy_bucket, 1,
  'ooze-form-uses', NULL, TRUE,
  'Ooze Form', 'You become an Ooze in addition to any other creature type(s) you are. You gain Blindsight with a range of 30 feet. If you already have Blindsight, your range increases by 30 feet.

You can will your body to melt and flow, becoming more fluid than solid. As a Bonus Action, you manifest your Ooze Form. You become amorphous, able to move through a space as narrow as 1 inch without expending extra movement, and you are immune to the Grappled and Restrained conditions. You remain in Ooze Form for 1 minute or until you use your Bonus Action to return to normal.

You can manifest your Ooze Form a number of times equal to your Proficiency Bonus plus your Transformation stage. You regain all uses of this feature after finishing a Long Rest.',
  'gh-transformation-ooze/ooze-form', NULL, 628, NULL, NULL
),
(
  'elemental-surge-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), NULL,
  'Elemental Surge', 'bonus'::rpg.action_economy_bucket, 2,
  'elemental-surge-uses', NULL, TRUE,
  'Elemental Surge', 'You can channel pure elemental energy into a concentrated bolt of an element of your choice. As a Magic action, you can use any of the following options:

Lightning Strike. You can make a ranged attack targeting a creature within 60 feet. You are proficient with this attack, which uses your Constitution modifier. On a hit, this attack deals 3d8 plus your Constitution modifier Lightning damage. You can then use a Bonus Action to target another creature within 30 feet of the first target with the same attack.

Increase the damage of these attacks by 1d8 for each Transformation Stage above 2.

Earth Shard. You can force a creature within 30 feet to make a Constitution saving throw. On a failed save, the creature takes Bludgeoning damage equal to 3d6 plus your Constitution modifier, or half as much on a successful save. Increase the damage by 1d6 for each Transformation Stage above 2.

You also gain Temporary Hit Points equal to half the damage dealt.

Flame Wave. Each creature in a 15-foot Cone originating from you makes a Dexterity saving throw against a DC equal to 8 plus your Constitution modifier plus your Transformation Stage. On a failed save, creatures in the area take Fire damage equal to 2d8 plus your Constitution modifier. Increase the damage by 1d8 for each Transformation Stage above 2.

Aquatic Rejuvenation. Choose a creature you can see within 60 feet of you. The creature regains a number of Hit Points equal to 2d8 plus your Constitution modifier. Increase the number of Hit Points regained by 1d8 for each Transformation Stage above 2.

You can use Elemental Surge a number of times equal to your Constitution modifier, regaining all expended uses upon finishing a Long Rest.',
  'gh-transformation-primordial/elemental-surge', NULL, 629, NULL, NULL
),
(
  'angelic-wings-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), NULL,
  'Angelic Wings', 'bonus'::rpg.action_economy_bucket, 1,
  'angelic-wings-uses', NULL, TRUE,
  'Angelic Wings', 'As a Bonus Action, you can manifest feathered wings for 1 hour. While they are manifested, you have a Fly Speed equal to your Speed when you are not wearing heavy armor.

You can manifest these wings a number of times equal to your Transformation Stage, and you regain all uses after finishing a Short or Long Rest.',
  'gh-transformation-seraph/angelic-wings', NULL, 630, NULL, NULL
),
(
  'holy-strikes-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), NULL,
  'Holy Strikes', 'free'::rpg.action_economy_bucket, 1,
  'holy-strikes-uses', NULL, TRUE,
  'Holy Strikes', 'When you hit with a weapon or an Unarmed Strike or damage a creature with a cantrip, you can add 1d6 Radiant damage to that attack. You can add this damage a number of times equal to your Proficiency Bonus plus your Transformation Stage. You regain all uses of this feature when you finish a Short or Long Rest.

At higher Transformation Stages, you deal an additional 1d6 Radiant damage per Transformation Stage, for a total of 2d6 at Stage 2, 3d6 at Stage 3, and 4d6 at Stage 4.',
  'gh-transformation-seraph/holy-strikes', NULL, 631, NULL, NULL
),
(
  'divine-clemency-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), NULL,
  'Divine Clemency', 'reaction'::rpg.action_economy_bucket, 2,
  'divine-clemency-uses', NULL, TRUE,
  'Divine Clemency', 'When an ally within 30 feet of you that you can see takes damage, you can use a Reaction to cast Healing Word at first level on that ally without using a spell slot.

You can do this a number of times equal to your Transformation Stage. You regain all uses of this feature after finishing a Long Rest.',
  'gh-transformation-seraph/divine-clemency', NULL, 632, NULL, NULL
),
(
  'sacred-retribution-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), NULL,
  'Sacred Retribution', 'reaction'::rpg.action_economy_bucket, 2,
  'sacred-retribution-uses', NULL, TRUE,
  'Sacred Retribution', 'When an ally you can see within 30 feet takes the Attack action with a weapon or Unarmed Strike , you can use your Reaction to imbue them with holy zeal, allowing them to make one additional attack. On a hit, the target takes an additional 1d8 Radiant damage. You may use this feature a number of times equal to your Transformation Stage. You regain all uses of this feature when you finish a Long Rest.',
  'gh-transformation-seraph/sacred-retribution', NULL, 633, NULL, NULL
),
(
  'bow-of-celestial-judgement-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), NULL,
  'Bow of Celestial Judgement', 'bonus'::rpg.action_economy_bucket, 3,
  'bow-of-celestial-judgement-uses', NULL, TRUE,
  'Bow of Celestial Judgement', 'You can use a Bonus Action to manifest a powerful bow made of divine light. The Bow of Celestial Judgement lasts for 1 minute and grants you the following abilities while manifested:

• You can use a Magic action to target a creature you can see within 120 feet with your bow. The creature must succeed on a Dexterity saving throw against a DC equal to 8 plus your Proficiency Bonus plus your Transformation Stage. On a failed save, the creature takes 6d6 Radiant damage, or 10d6 if it is a Fey, Fiend, or Undead. On a success, the creature takes half damage.

• You have Resistance to Necrotic damage.

• You gain 5 Temporary Hit Points at the start of each of your turns.

You can use this feature a number of times equal to your Transformation Stage, and you regain all uses after finishing a Long Rest.',
  'gh-transformation-seraph/bow-of-celestial-judgement', NULL, 634, NULL, NULL
),
(
  'shadowsteel-arcane-vessel-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), NULL,
  'Shadowsteel Arcane Vessel', 'free'::rpg.action_economy_bucket, 4,
  'shadowsteel-arcane-vessel-uses', NULL, TRUE,
  'Shadowsteel Arcane Vessel', 'When you cast a spell using a spell slot, the power of your Shadowsteel infection emanates from you. One creature targeted by the spell within 60 feet of you has Disadvantage on the saving throw to resist the spell, or you have Advantage on the spell attack roll.

You can use this feature a number of times equal to your Proficiency Bonus, and you regain all uses after you finish a Long Rest.',
  'gh-transformation-shadowsteel-ghoul/shadowsteel-arcane-vessel', NULL, 635, NULL, NULL
),
(
  'ghastly-touch-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Ghastly Touch', 'free'::rpg.action_economy_bucket, 1,
  'ghastly-touch-uses', NULL, TRUE,
  'Ghastly Touch', 'You can deliver a soul-chilling jolt through your attacks. Once per turn, when you hit a target with a melee attack when you are within 5 feet of the target, you can deal an additional 1d6 Necrotic damage.

You can use this feature a number of times equal to your Proficiency Bonus plus your Transformation Stage. You regain all uses of this feature when you finish a Short Rest or Long Rest.',
  'gh-transformation-specter/ghastly-touch', NULL, 636, NULL, NULL
),
(
  'incorporeal-movement-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Incorporeal Movement', 'action'::rpg.action_economy_bucket, 1,
  'incorporeal-movement-uses', NULL, TRUE,
  'Incorporeal Movement', 'You are able to loosen the binds that tie you to the material world to move through solid objects and creatures. As a Magic action, you can make yourself incorporeal until the start of your next turn. While in this form, you gain the following benefits:

• You can move through solid objects at your full Speed. You take 1d10 Force damage if you end your turn inside a solid object and are moved to the nearest open space.

• You have Resistance to all damage types except Force damage.

• You are Lightly Obscured .

You can use this feature a number of times equal to your Proficiency Bonus, and regain all uses after finishing a Long Rest.',
  'gh-transformation-specter/incorporeal-movement', NULL, 637, NULL, NULL
),
(
  'ethereal-phasing-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Ethereal Phasing', 'free'::rpg.action_economy_bucket, 2,
  'ethereal-phasing-uses', NULL, TRUE,
  'Ethereal Phasing', 'You can cast the Blink spell without expending a spell slot. You can cast the spell using this Boon a number of times equal to your Transformation Stage, and you regain all uses after finishing a Long Rest.

While you are under the effects of Blink when cast in this way, you also gain Temporary Hit Points equal to your Proficiency Bonus plus your Transformation Stage at the start of each of your turns.',
  'gh-transformation-specter/ethereal-phasing', NULL, 638, NULL, NULL
),
(
  'haunting-flight-frighten', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Haunting Flight', 'bonus'::rpg.action_economy_bucket, 2,
  'haunting-flight-frighten-uses', NULL, TRUE,
  'Haunting Flight — frighten', 'You gain a Fly Speed equal to your Speed.

Also, while you are flying, you can use a Bonus Action to focus your terrifying presence on one creature you can see within 30 feet. That creature must succeed on a Wisdom saving throw or have the Frightened condition for 1 minute. The DC for the Wisdom saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage. Once you use this feature, you must finish a Short or Long Rest before you can use it again.',
  'gh-transformation-specter/haunting-flight-frighten', NULL, 639, NULL, NULL
),
(
  'paralyzing-touch-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Paralyzing Touch', 'free'::rpg.action_economy_bucket, 3,
  'paralyzing-touch-uses', NULL, TRUE,
  'Paralyzing Touch', 'Your Ghastly Touch feature takes on a spirit-freezing quality. The damage from your Ghastly Touch increases to 2d6 Necrotic damage. Additionally, you can force any creature you damage with Ghastly Touch to make a Constitution saving throw. The DC for this saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.

On a failed save, the creature has the Paralyzed condition until the start of your next turn. On a successful save, they have the Prone condition instead. You can use this feature a number of times equal to your Transformation Stage. You regain all uses of this feature when you finish a Short or Long Rest.',
  'gh-transformation-specter/paralyzing-touch', NULL, 640, NULL, NULL
),
(
  'possession-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Possession', 'action'::rpg.action_economy_bucket, 4,
  'possession-uses', NULL, TRUE,
  'Possession', 'As a Magic action, you enter the space of a Humanoid or Beast and force that creature to make a DC 15 Charisma saving throw. If the target fails, you disappear, and the target is Incapacitated and loses control of its body. You control the body without depriving the target of awareness.

While possessing a target, you can’t be targeted by any attack, spell, or other effect. You retain your alignment, Intelligence, Wisdom, Charisma, and any immunity to having the Charmed and Frightened conditions. Otherwise, you use the possessed target’s statistics but don’t gain access to the target’s knowledge, spellcasting abilities or Magic actions, class features, or proficiencies.

The possession lasts for 1 hour, until the possessed target drops to 0 Hit Points, you end it as a Bonus Action, or you are forced out by an effect that ends possession. When the possession ends, you reappear in an unoccupied space within 5 feet of the possessed creature. Once you use this feature, you can’t use it again until you finish a Short Rest or Long Rest.',
  'gh-transformation-specter/possession', NULL, 641, 'stage4Boon', 'possession'
),
(
  'call-of-unmaking-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), NULL,
  'Call of Unmaking', 'bonus'::rpg.action_economy_bucket, 4,
  'call-of-unmaking-uses', NULL, TRUE,
  'Call of Unmaking', 'As a Bonus Action, you can give a mournful wail or otherwise set up a wracking vibration. This sound has no effect on Constructs and Undead.

All other creatures of your choice within 30 feet of you must make a Constitution saving throw. The DC of the Constitution saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage. Creatures that can’t hear you have Advantage on the saving throw.

On a failed save, the creature bears the Mark of Unmaking for 1 minute. While bearing this mark, a creature takes an additional 1d6 Necrotic damage each time it takes damage.

Once you use this feature, you can’t use it again until you finish a Long Rest.',
  'gh-transformation-specter/call-of-unmaking', NULL, 642, 'stage4Boon', 'call-of-unmaking'
),
(
  'undead-resilience-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), NULL,
  'Undead Resilience', 'free'::rpg.action_economy_bucket, 2,
  'undead-resilience-uses', NULL, TRUE,
  'Undead Resilience', 'You become supernaturally tough to kill. When you are reduced to 0 Hit Points by any type of damage except Radiant, you can choose to be reduced to 1 Hit Point instead. Once you use this feature, you cannot use it again until you finish a Long Rest.',
  'gh-transformation-vampire/undead-resilience', NULL, 643, 'stage2Boon', 'undead-resilience'
),
(
  'mist-form-activate', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), NULL,
  'Mist Form', 'action'::rpg.action_economy_bucket, 3,
  'mist-form-uses', NULL, TRUE,
  'Mist Form', 'You can cast the Gaseous Form spell a number of times equal to your Vampire Transformation Stage without using a spell slot or needing to use Verbal, Somatic, or Material components. You regain all uses of this feature when you finish a Long Rest.

You can cast this spell as an Action on your turn, or as a Reaction when you would take Bludgeoning, Piercing, or Slashing damage. You cast the spell before taking the damage.',
  'gh-transformation-vampire/mist-form', NULL, 644, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  feat_id = EXCLUDED.feat_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
