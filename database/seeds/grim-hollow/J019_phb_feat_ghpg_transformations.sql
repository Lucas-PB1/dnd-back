-- Grim Hollow Cap. 6 — transformações (catálogo; categoria gh-transformation)

INSERT INTO rpg.phb_feat (slug, name, category, repeatable, prerequisite, source_citation_id)
VALUES
(
  'gh-transformation-aberrant-horror',
  'Horror Aberrante',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-fey',
  'Fada',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-fiend',
  'Corruptor',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-hag',
  'Bruxa',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-lich',
  'Lich',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-lycanthrope',
  'Licantropo',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-ooze',
  'Gosma',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-primordial',
  'Primordial',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-seraph',
  'Serafim',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-shadowsteel-ghoul',
  'Carniçal de Aço Sombrio',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-specter',
  'Espectro',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
),
(
  'gh-transformation-vampire',
  'Vampiro',
  'gh-transformation',
  FALSE,
  'Transformação opcional — ver Grim Hollow PG Cap. 6',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-6-transformations')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 1, 'Como começar', 'Every Aberrant Horror begins with a defining question: what happened to them? Some individuals make pacts with ancient entities for powers that have unforeseen effects. Others awaken after defeating an unnatural monster, surprised that they survived, only to feel something writhing in their stomach. Many tropes of body horror can be used as inspiration for an Aberrant Horror’s creation.

Once you''ve established your origin, consider your character’s motivations regarding their Transformation. As their power grows and manifests, they may feel they have lost what makes them fundamentally themselves. Perhaps they decide to take revenge on the entity responsible for their Transformation, or perhaps they perceive their mutation as a gift.

Reversing Aberrant Horror Traits

Once the character reaches Stage 1 of the Aberrant Horror Transformation, the Boons and Flaws they’ve received cannot be removed by normal or even typical magical means. Some magic might slow or halt the mutations that the character endures, but magic on the level of the Wish spell is needed to completely remove the Transformation and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 2, 'Estágio 1', 'When you initially undergo the Aberrant Horror Transformation, you gain both Stage 1 Boons and the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 3, 'Stage 1 Boon: Aberrant Form', 'Aberrant Horror Stage 1 Boon

Your creature type becomes Aberration in addition to any other creature types you have.

Also, the first time you become Bloodied after a Short or Long Rest, you gain a number of Temporary Hit Points equal to your Proficiency Bonus plus your current Transformation Stage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 4, 'Stage 1 Boon: Aberrant Mutation', 'Your body can twist and reshape itself as you will it, changing body parts into dangerous or useful tools and regenerating after taking damage. These abilities are represented by Aberrant Mutations. You can manifest an Aberrant Mutation listed below a number of times equal to your Proficiency Bonus plus your current Transformation Stage.

Each of these Aberrant Mutations last for 1 minute, and you can end them early by spending a Bonus Action to remove them or take on a different mutation. If you choose another Aberrant Mutation, you must spend another use of this feature.

You regain all uses of this ability when you finish a Short or Long Rest.

Chitinous Shell. As a Bonus Action, you grow a hard, crustacean-like shell. While this mutation is active and are not wearing heavy armor, your Armor Class increases by 2. While you maintain this shell, your Speed is reduced by 10 feet.

Eldritch Limbs. As a Bonus Action, you transform one or both of your arms into thick muscle, scything claws, or sharpened bone. When you use the Attack action, you can replace one or more attacks with melee attacks made with your eldritch limb. You are considered proficient with this attack, and it uses either Strength or Dexterity (your choice). On a hit, the attack deals 1d8 damage (either Bludgeoning, Piercing, or Slashing, chosen each time you manifest the mutation).

As a Bonus Action, you can make a melee attack with your eldritch limb.

Your eldritch limbs cannot hold weapons, shields, or other items. They are not considered weapons or Unarmed Strikes.

Slimy Form. As a Bonus Action, you cover yourself in a slippery slime. You have Advantage on ability checks to escape a grapple, and you can use the Dash action as a Bonus Action. You also gain Resistance to Acid, Fire, and Cold damage while in this form.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 5, 'Stage 1 Flaw: Unstable Form', 'Your body becomes malleable and struggles to maintain any one physical shape. Upon completing a Long Rest after an adventuring day in which you took damage, you must roll 1d100 on the Unstable Form table and apply the corresponding mutation based on current your Transformation Stage. This mutation lasts until you finish another Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 6, 'Estágio 2', 'When you reach Stage 2 of the Aberrant Horror Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 7, 'Stage 2 Boon: Efficient Killer', 'When you make an attack with your eldritch limbs, you can gain an added ability based on the damage type you have chosen.

Piercing. You may replace any attack made with your eldritch limb with a razor-sharp barb hurled at the target. You are considered proficient with this barb, which has a Range of 20/60, has the Finesse and Thrown properties, and deals 2d6 Piercing damage on a hit.

Bludgeoning. You manifest a long tentacle, tipped with a hardened bone club. Your eldritch limb attack deals an additional 1d8 Bludgeoning damage. Also, the attack uses the Slow Weapon Property, which you have Mastery with.

Slashing. Your arm forms a row of viciously hooked claws and talons. Your eldritch limb attack deals an additional 1d8 Slashing damage. Also, the attack uses the Graze Weapon Property, which you have Mastery with.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 8, 'Stage 2 Boon: Writhing Tendrils', 'You gain the ability to grow long, tendril-like appendages out of your body. As a Bonus Action, these tendrils sprout from you. While you maintain these tendrils, you gain the following benefits:

The tendrils last for 1 minute. You can use a Bonus Action to retract your tendrils.

You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Short Rest or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 9, 'Stage 2 Flaw: Hideous Appearance', 'Your appearance has grotesquely transformed. You may have turned into a hulking mass of flesh adorned with countless eyes, or a bone-and-tusk-covered behemoth. Regardless of your true form, you’re horrific to behold.

You can suspend this form and take on the appearance of the humanoid you once were, but this is taxing and requires effort. This form is not permanent, and moments of stress are likely to reveal your true nature. Your true form may be revealed in the following situations:

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constitution saving throw with a DC based on your current Transformation Stage. If you fail this save, your Horrific Appearance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 10, 'Estágio 3', 'When you reach Stage 3 of the Aberrant Horror Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 11, 'Stage 3 Boon: Terrifying Visage', 'Your mutations and unearthly appearance can unsettle even the bravest creatures. When you invoke your Aberrant Mutations or Writhing Tendrils , you choose one creature within 30 feet that can see you. That creature must succeed on a Wisdom saving throw or gain the Frightened condition for 1 minute. The DC for the saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage. A creature that makes its saving throw is immune to this effect for 24 hours.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 12, 'Stage 3 Boon: Constricting Tendrils', 'You gain an additional option for your Writing Tendrils mutation.

As a Bonus Action while Writhing Tentacles is active, you can attempt to restrain a creature within 5 feet of you with your tendrils. The creature must succeed on a Strength or Dexterity saving throw or gain the Restrained condition. The DC is 8 plus your Proficiency Bonus plus your Transformation Stage. A Restrained creature can take an action to make a Strength ( Athletics ) check against this DC, ending the condition on itself on a success. The Restrained condition ends if you are Incapacitated , you move from your current position, if you retract your tendrils, or if you use your tendrils to perform another ability.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 13, 'Stage 3 Flaw: Unstable Existence', 'Magic causes your physical form to unravel. Whenever you roll a natural 1 or 2 on a saving throw against a spell, you reveal your Hideous Appearance and must roll again on the Unstable Form table. If the result is less than your current Unstable Form effect, replace it with the new result.

The madness that comes with connecting with the Kindred is inevitable.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 14, 'Estágio 4', 'When you reach Stage 4 of the Aberrant Horror Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 15, 'Stage 4 Boon: Eldritch Aberration', 'You gain the ability to deliver jolts of magical energy with your eldritch limbs. Once per turn, when you hit a creature with an attack using your eldritch limbs, you can expend a spell slot to deal additional damage equal to 1d6 per spell level expended. You can choose for this additional damage to be of any of the following types: Acid, Cold, Fire, Force, Lightning, or Thunder. If any of these extra dice show a 6 when rolled, the target has the Prone condition.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 16, 'Stage 4 Boon: Poisonous Mutations', 'You have Resistance to Poison damage and are Immune to the Poisoned condition.

While you have an Aberrant Mutation active, any creature you choose that starts its turn within 5 feet of you takes 3d6 Poison damage unless they succeed on a Constitution saving throw. The DC for this saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 17, 'Stage 4 Flaw: Entropic Abomination', 'This Flaw replaces the Stage 3 Flaw: Unstable Existence . The very essence of magic and the effect of stress aggravates the unstable nature of your aberrant body. Each time you fail a saving throw, or the first time you become Bloodied after finishing a Long Rest, you must roll on the Unstable Form table. If the result is less than your current Unstable Form effect, replace it with the new result.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 1, 'Como começar', 'Becoming a Fey requires a direct connection to the Realm of Faerie. Many mortals who become Fey are stolen from the mortal realm as children. These children, known as changelings, transform rapidly after a few days trapped in the Realm of Faerie. A changeling’s transition is often painful or strange, for a child altered in this way does not have a say in what type of Fey creature they ultimately become.

Others might be born mortal but have the taint of Fey blood coursing through their veins. As they mature, their Fey features slowly manifest. More than a few innocent folks quickly learn of their Fey destinies immediately after a joyous birthday celebration.

A creature who voluntarily seeks to become a Fey can strike a deal with a Fey or beseech the court of a Faerie Queen. These pathways to transformation are as dangerous as the Realm of Faerie itself, and it requires a quick wit and sharp awareness to get the best of Feykind.

Reversing Fey Traits

The hold of the Fey over a mortal being is strong, but it’s even stronger when the mortal begins to show signs of Fey heritage. The rituals to reverse the Fey Transformation are dangerous and rarely successful.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 2, 'Estágio 1', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 3, 'Estágio 1', 'When you initially undergo the Fey Transformation, you gain the Fey Form Boon and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 4, 'Stage 1 Boon: Fey Form', 'Your creature type becomes Fey in addition to any other creature type(s) you have.

Also, after you finish a Long Rest, pick a damage type from the following list: Acid, Cold, Fire, Lightning, Psychic, or Thunder. You gain Resistance to that damage type until you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 5, 'Stage 1 Boon: Servant of the Spring Court', 'The Spring Court embodies carnal desires, rebirth, and the planting and sowing season. The Fey creatures of Spring tend to be capricious, unreliable, and quick to flare their emotions. This is the court most associated with satyrs and nymphs. Creatures of the Spring Court hide savage intentions and uncontrollable urges behind gentle words.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Thunder damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 6, 'Stage 1 Boon: Servant of the Summer Court', 'The Summer Court embodies the lush warmth and manic celebration of the growing season. The Fey creatures of Summer tend toward joviality, excess, and vanity. This is the court most associated with dryads and pixies. Creatures of the Summer Court often hide their narcissism and cruelty behind beautiful façades.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Fire damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 7, 'Stage 1 Boon: Servant of the Autumn Court', 'The Autumn Court embodies the careful scheming and approaching rot of the harvesting season. The Fey creatures of Autumn tend to be devious, scheming, and full of secrets. This is the court most associated with treants and other plant fey. Creatures of the Autumn Court often appear beautiful and helpful, but in truth their forms are hideous and methods vile.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Poison damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 8, 'Stage 1 Boon: Servant of the Winter Court', 'The winter court embodies the stillness, darkness, and death of the coldest season. The Fey creatures of Winter tend to be serious, cruel, and reflective. Creatures of the Winter Court are often terrifying to behold and very direct about their intentions.

As a Bonus Action, you can magically teleport up to 30 feet to an unoccupied space you can see. One creature of your choice that you can see within 5 feet of your starting or ending space takes 1d6 Cold damage. You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 9, 'Stage 1 Flaw: Planar Binding', 'Your body and soul have been saturated with the magical energy of the Realm of Faerie. Rather than inuring you to the essence of magic, it has made you more susceptible. After finishing a Short or Long Rest, you have Disadvantage on the first saving throw you make against a spell originating from an enemy.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 10, 'Estágio 2', 'When you reach Stage 2 of the Fey Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 11, 'Stage 2 Boon: Two-Faced', 'You can transform your face into a vision of enchantment or horror that affects creatures around you, based on the Fey Court you serve. As a Magic action, you take on this visage. Creatures within 30 feet who can see you must succeed on a Charisma saving throw with a DC equal to 8 plus your Charisma modifier plus your Transformation Stage or be affected for 1 minute.

You can do this a number of times equal to your Proficiency Bonus, and you regain all uses after finishing a Long Rest.

Spring. Any creature that fails the saving throw has the Stunned condition. The creature can attempt a Constitution saving throw at the end of each of their turns to end the condition. This effect ends early on a creature if you or an ally deal damage to it or take other harmful actions.

Summer. Any creature that fails the saving throw gains the Charmed condition. This effect ends early on a creature if you or an ally deal damage to it or take other harmful actions.

Autumn. Any creature that fails the saving throw gains the Poisoned condition. The creature can attempt a Constitution saving throw at the end of each of their turns to end the condition.

Winter. Any creature that fails the saving throw becomes Frightened of you. This effect ends early if a creature affected by this ability ends its turn out of your line of sight.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 12, 'Stage 2 Boon: Magic Tricks', 'Your Fey masters provide you with the ability to weave magic based on your Fey Court allegiance. You gain the ability to cast one cantrip, one level 1 spell, and one level 2 spell. You can cast each of these once without using a spell slot or needing spell components. You regain the ability to cast these spells when you finish a Long Rest. The DC for these spells is 8 plus your Proficiency Bonus plus your Transformation Stage.

Spring. Your cantrip is Poison Spray , and your spells are Fog Cloud and Misty Step .

Summer. Your cantrip is Fire Bolt , and your spells are Burning Hands and Flame Blade .

Autumn. Your cantrip is Shillelagh , and your spells are Thunderwave and Ray of Enfeeblement .

Winter. Your cantrip is Ray of Frost , and your spells are Ice Knife and Darkness .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 13, 'Stage 2 Flaw: Queen’s Command', 'The Fey court lends you its power, and in exchange you must pay regular tribute to maintain your freedom. Twice a year, at times relevant to the Fey Court that you serve—such as the solstices or the equinoxes—you must deliver a treasure or other significant tribute to your ruling Fey Queen.

If your queen considers the tribute lacking, you are immediately notified of your failure and are given detailed instructions on how to atone. You have Disadvantage on all D20 Tests until you rectify the situation. If you do not satisfy your queen’s demand in one week’s time, your queen transports you immediately to her Fey Court, where you must answer for your insolence. Once transported in this way, you must remain in the Realm of Faerie for 100 years, or until you strike a bargain with your queen to let you return to the Material Plane.

Your GM will tell you what constitutes an appropriate tribute to the court. Some Fey Queens prefer magic items while others wish for long-kept secrets, the capture of Fey criminals, or Humanoid servants.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 14, 'Estágio 3', 'When you reach Stage 3 of the Fey Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 15, 'Stage 3 Boon: Illusionary Cloak', 'You can use a Magic action to wrap yourself in an illusionary cloak for up to 1 hour. During this time, you can make yourself look like another creature of your general size and humanoid shape. This illusion ends when you use a Bonus Action to end it, or if you die or gain the Unconscious condition.

A creature can pierce the illusion by taking the Study action and succeeding on a DC 20 Intelligence ( Investigation ) check, thus seeing your true form.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 16, 'Stage 3 Boon: Tooth and Claw', 'You can manifest fangs, tusks, claws, or other means of harming your enemies. These manifestations also deliver a powerful magic jolt.

As a Bonus Action, you manifest some natural defense mechanism for 1 minute. This gives you the following benefits:

You can use this ability a number of times equal to your Proficiency Bonus plus your Transformation Stage. You regain all uses of this ability after completing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 17, 'Stage 3 Boon: Dreams and Nightmares', 'You gain the ability to manipulate the mind of mortal beings. As a Bonus Action, choose a Humanoid you can see within 30 feet of you. That creature must succeed on a Wisdom saving throw. The DC is 8 plus your Proficiency Bonus plus your Transformation Stage.

On a failed saving throw, the creature has the Paralyzed condition, as it is stuck in a blissful dream or a terrifying nightmare. The condition lasts for 1 minute. The target can attempt the Constitution saving throw at the end of each of its turns and each time it takes damage.

You can choose to concentrate on the effect as you would a spell. If you are concentrating on the effect when the target attempts its saving throw, the target has Disadvantage on the saving throw.

You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses of this ability when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 18, 'Stage 3 Flaw: Weakened Constitution', 'Your connection to the Fey Courts has granted you tremendous power but also an inherent fragility. When you become Bloodied for the first time after you roll Initiative, you must succeed on a DC 20 Constitution saving throw. On a failed save, you gain a level of Exhaustion .

As a Magic action, you can expend a number of Hit Point Dice equal to your Transformation Stage to remove one level of Exhaustion gained in this manner. You gain no other benefit from those expended Hit Point Dice.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 19, 'Estágio 4', 'When you reach Stage 4 of the Fey Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 20, 'Stage 4 Boon: Greater Magic Tricks', 'Your Fey masters provide even further magical abilities. You gain the ability to cast one level 3 spell, one level 4 spell, and one level 5 spell. You can cast each of these once without using a spell slot or needing spell components. You regain the ability to cast these spells when you finish a Long Rest. The DC for these spells is 8 plus your Proficiency Bonus plus your Transformation Stage.

Spring. Your spells are Stinking Cloud , Vitriolic Sphere , and Cloudkill .

Summer. Your spells are Fireball , Fire Shield , and Dream .

Autumn. Your spells are Lightning Bolt , Blight , and Hold Monster .

Winter. Your spells are Vampiric Touch , Ice Storm , and Cone of Cold .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 21, 'Stage 4 Boon: Twilight Glamour', 'As a Magic action, you gain the Invisible condition for 1 hour or until you end it as a Bonus Action. If you make an attack roll, deal damage, or cast a spell that causes the target to make a saving throw, the remaining duration changes to 1 minute.

You can use this ability twice, and you regain all uses after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 22, 'Stage 4 Flaw: Seasonally Affected', 'Your connection to the Realm of Fey has a stronger pull on you. You have Disadvantage on Death Saving Throws as the Fey Court attempts to claim your soul as their own.

Additionally, you gain Vulnerability to a certain damage type based on the Fey Court that you are pledged to. You cannot benefit from Resistance or Immunity to that damage.

Spring. You are Vulnerable to Necrotic damage.

Summer. You are Vulnerable to Cold damage.

Autumn. You are Vulnerable to Radiant damage.

Winter. You are Vulnerable to Fire damage.

When the veil between the land of Faerie and our world is thin and parted, people can easily cross over to the other realm. Sometimes it’s planned, often it’s accidental, but the effects of the journey stay with a mortal creature forever.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 1, 'Como começar', 'A mortal can become a Fiend in a variety of ways. Some forfeit their souls and become one upon death. Others undertake excruciating rituals to be granted forbidding power by an Arch Daemon. Some mortals may become Fiends unintentionally, as a reward or punishment for their life of cruelty and misdeeds. Yet it is rare for a creature to be chosen to join the legions of the Netherworld without first having made a bargain for such a gift.

Communicating with your GM about creating deals with mortals in their story is a great way to roleplay your influence within the game world. As a Fiend, you should consider your character’s motivations and which NPCs might serve to achieve their goals.

Are you in service of a particular Arch Daemon or dark deity? Do you follow only your own ambitions, making the necessary bargains to do so? What evils will you exact upon the world, and to what ends? Fiends rarely behave without ambition, even if that is simply corrupting as many mortals as you can convince to sign a contract.

Reversing Fiend Traits

Transforming into a Fiend usually requires deeds of great evil. You may have performed blood sacrifices or made bargains that resulted in others suffering. Even magic on the level of the Wish spell could not atone for your actions or redeem your soul. Only once you perform a deed of incredible sacrifice or atonement could such magic remove your Transformation boons and flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 2, 'Estágio 1', 'When you initially undergo the Fiend Transformation, you gain the Fiendish Soul Boon and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 3, 'Stage 1 Boon: Fiendish Soul', 'You become a Fiend in addition to any other creature type(s) you have. You have Advantage on Charisma ( Deception ) checks.

Additionally, choose one of the following damage types and gain Resistance to it: Acid, Cold, or Fire.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 4, 'Stage 1 Boon: Devilish Contractor', 'You have acquired the ability to bind mortal creatures to your will. You can create a contract to bind a mortal Humanoid’s soul to you, feeding on its power. The mortal gains a gift asked for in the contract, and you gain a Gift of Damnation of your choice. (See Gifts of Damnation at the end of this Transformation.)

To bind a mortal’s soul to you, you must first create a contract for their desired gift. A contract requires magical ink and paper worth 10 GP for each Transformation Stage you have acquired.

You and the mortal must both sign the contract willingly, fully aware of the costs involved. Once signed, daemonic entities give you a Gift of Damnation, and the mortal receives their desired wishes within 7 days. You do not have to provide this boon yourself.

For example, upon signing a contract for a Gift of Unfettered Glory , you receive the benefits listed for that gift. The mortal who signs receives their stated desire, provided by the dubious powers of the Netherworld. You cannot benefit directly from the mortal’s desired gift, nor can an ally. No ally of yours can ever sign a contract with you.

You may take a Gift of Damnation of the Stage that you have attained or lower. For example, if you are at Stage 2 of the Transformation, you may only take a Stage 1 or Stage 2 Gift of Damnation.

There is no limit to the number of contracts you can execute, but you can only have one active Gift of Damnation at a time. When you would gain a second Gift of Damnation, you may replace your active gift with the new one. Also, when you finish a Long Rest you may swap your active Gift of Damnation for any other gift associated with a signed contract.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 5, 'Stage 1 Boon: Infernal Smite', 'Once on each of your turns, you can choose one creature you have just damaged with a weapon attack, an Unarmed Strike , or a cantrip. Deal an extra 1d6 Acid, Cold, or Fire damage to that creature, using the same damage type you chose for Fiendish Soul. You can add this damage a number of times equal to your Proficiency Bonus plus your Transformation Stage, but no more than once per damage roll. You regain all uses of this ability when you finish a Short Rest or Long Rest.

At higher Transformation Stages, you do an additional 1d6 of damage per Transformation Stage, for a total of 2d6 at Stage 2, 3d6 at Stage 3, and 4d6 at Stage 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 6, 'Stage 1 Flaw: Fiend Bound', 'Your body and soul are bound to the Netherworld. You have Disadvantage on Death Saving Throws as the plane attempts to pull you into it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 7, 'Estágio 2', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 8, 'Estágio 2', 'When you reach Stage 2 of the Fiend Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 9, 'Stage 2 Boon: Daemonic Brand', 'As a Bonus Action on your turn, you can brand a creature within 60 feet of you that you can see with a fiery mark that remains on them for 1 minute. If the target succeeds on a Wisdom saving throw, they are not branded. The DC of the saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.

If the creature fails the saving throw, you choose one of the following effects that lasts for the duration:

You can use this ability a number of times equal to your Proficiency Bonus, and you regain all uses when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 10, 'Stage 2 Boon: Enhanced Contract', 'You may switch between your active Gift of Damnation at the end of a Short or Long Rest. In addition, when you switch Gifts of Damnation, you gain Temporary Hit Points equal to 5 times your Transformation Stage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 11, 'Stage 2 Flaw: Fiend Form', 'Your appearance has grotesquely transformed. Your skin becomes red and leathery, and vicious horns, teeth and nails erupt through the surface of your skin. You can suppress this form and present the appearance of the humanoid you once were, but this is taxing and requires effort. Moments of stress are likely to reveal your true nature. In the following situations your true form may be revealed:

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constitution saving throw with a DC based on your current Transformation Stage. If you fail this save, your Horrific Appearance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 12, 'Estágio 3', 'When you reach Stage 3 of the Fiend Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 13, 'Stage 3 Boon: Devilish Subcontractor', 'You may gain the benefits of two Gifts of Damnation at the same time. You may still only switch one Gift of Damnation after a Short or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 14, 'Stage 3 Boon: Overwhelming Brand', 'You can apply one of the following additional effects to a creature under the effect of your Daemonic Brand .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 15, 'Stage 3 Flaw: Pull of the Netherworld', 'Your new native plane attempts to pull you to it, laying claim to your form. Whenever you roll a natural 1 on a D20 Test , you take 6d6 Psychic damage as the denizens of the fiendish plane attempt to unbind your soul from the Material Plane. This damage can only be taken once per Short Rest, and it ignores all Resistances and Immunities. If this damage reduces your Hit Points to 0, you die and your soul is immediately taken to the Netherworld. You can only be returned to life by spells of 7th level or higher.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 16, 'Estágio 4', 'When you reach Stage 4 of the Fiend Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 17, 'Stage 4 Boon: Abyssal Resistance', 'You gain Immunity to the damage type chosen for Fiendish Soul, and you gain Resistance to the other two damage types. Additionally, you have Resistance to damage from nonmagical weapon attacks or Unarmed Strikes.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 18, 'Stage 4 Boon: Infernal Summons', 'As a Magic action, you can tear open a portal to the Netherworld and summon up to four Fiends of CR 4 or less within 30 feet of you. The Fiends remain for 1 minute before disappearing back to the Netherworld. (The GM can decide what Fiends answer the summons.)

The summoned Fiends are Friendly to you and your companions. They act directly after you in the initiative order. They obey any verbal commands that you issue to them (no action required by you). If you don’t issue any commands to them, they use the Dodge action on their turn and take no other movement, Bonus Actions, or Reactions unless it is to protect themselves.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 19, 'Stage 4 Boon: Ultimate Brand', 'When a creature affected by your Daemonic Brand starts its turn, you can use a Reaction to dictate its move and the action it takes. If you do, the creature repeats the initial Wisdom saving throw at the end of its turn. On a success, you can''t use this Reaction again while your brand lasts.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fiend'), 20, 'Stage 4 Flaw: True Name', 'Your Fiend transformation is complete, and you are reborn. You are assigned a new name by the denizens of the Netherworld, which becomes your True Name. You receive a talisman of brimstone and brass with your true name inscribed in Infernal on it.

A creature with a Challenge Rating of 10 or higher within 10 feet of you that knows your True Name can use a Magic action and speak your True Name. You must succeed on a DC 20 Charisma saving throw or suffer the following effects for 1 minute. You may attempt a Charisma saving throw at the end of each of your turns to end the effects.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 1, 'Como começar', 'Few creatures are born Hags. Humanoids can become a Hag as a result of a ritual or a curse. Sometimes the offspring of a cursed individual becomes a Hag after reaching the age of maturity. Hags have ways of spawning fully mature Hags, but only the most depraved individuals would consider that any sort of birth.

Other Fey creatures see Hags as pitiful, revolting creatures who can never enjoy the blessing of an existence in the Realm of Faerie, so cursing a mortal to become a Hag is a particularly harsh consequence for angering a Fey. Hags themselves are fond of creating other Hags to join them and form a coven.

Very few people are twisted enough to seek to transform themselves into a Hag. The power it provides is not worth the pain and anguish that comes with it. Yet that power is attractive to some, who seek out the rituals to make the change or entreat Hags to twist them as part of a bargain.

Reversing Hag Traits

The Hag Transformation is one of the few that can be reversed, especially when it is bestowed via a curse rather than sought, but only in its first two stages. Once the creature travels too far down the path of maddening power, the grip has become too strong.

Reversing the Transformation, even in its early stages, is an elaborate process that may take months or years, and often only with the assistance of a benevolent fey creature willing to donate some of their magic to the process.

The last step of the reversal process requires a powerful Fey creature to participate in a ritual to remove all remnants of the transformative magic. As with most Fey, this participation almost always comes at a steep cost.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 2, 'Estágio 1', 'When you initially undergo the Hag Transformation, you gain the Hag Form Boon and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 3, 'Stage 1 Boon: Hag Form', 'Your Creature Type becomes Fey in addition to any other creature type(s) you have.

Additionally, your connection with the magic of the natural world provides you with increased defenses. When you are not wearing armor, your Armor Class is 13 plus your Dexterity modifier. Additionally, choose Strength, Intelligence, or Charisma: you are proficient with Saving Throws using that ability score.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 4, 'Stage 1 Boon: The Green Sisterhood', 'Green Hags are skilled deceivers who collect corrupting magic and secret curses. They use their magic to twist pure into foul, poking at the weaknesses of their foes. Green Hags embrace magical deceptions and are known for their vile recipes. There are no worse cooks in Etharis.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 5, 'Stage 1 Boon: The Red Sisterhood', 'Red Hags are sometimes called the “nice” hags due to their ability to pretend to be helpful, but their kindness is a mask. While they are more subtle than other Hags and may choose to do good deeds, their motives are selfish. They delight in using honeyed words and offering deals that are just too good to pass up.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 6, 'Stage 1 Boon: The Sea Sisterhood', 'Sea Hags enjoy spreading chaos. They hate order and calm, creating elaborate deceptions that lead to despair when uncovered. Their appearances are especially hideous, and their gaze can cause fear, or even kill. You gain the following benefits.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 7, 'Stage 1 Flaw: Hideous Appearance', 'Your appearance is grotesquely transformed. Your body, hair, and eyes change in ways mortals find abhorrent. Most creatures witnessing your true form become Hostile and no one is likely to trust you, unless the GM decides otherwise. You have Disadvantage on Charisma ( Persuasion ) checks.

You cannot stand to look upon your own reflection. The first time you see your reflection after a Short Rest or Long Rest, you must succeed on a DC 18 Wisdom saving throw or gain 1 Exhaustion level.

Your appearance changes based on your Stage 1 Sisterhood Boon:

Green Sisterhood. You wither or bloat as your body struggles to deal with the ravages of age. Your hair becomes white and several feet in length. Your skin becomes green and covered in warts and boils.

Red Sisterhood. Your eyes have turned entirely red, and your pupils are narrow like a cat’s. Your skin becomes blood red.

Sea Sisterhood. You have slimy scales and the pallid skin of a dead fish that sags from your emaciated body. Your hair resembles seaweed, and your eyes are glassy.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 8, 'Estágio 2', 'When you reach Stage 2 of the Hag Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 9, 'Stage 2 Boon: Adept of the Green Sisterhood', 'As your connection to your Green Sisterhood grows, your body and your magical skills strengthen.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 10, 'Stage 2 Boon: Adept of the Red Sisterhood', 'As your connection to your Red Sisterhood grows, your body and your magical skills strengthen.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 11, 'Stage 2 Boon: Adept of the Sea Sisterhood', 'As your connection to your Sea Sisterhood grows, your body and your magical skills strengthen.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 12, 'Stage 2 Flaw: Iron Sensitivity', 'Your body and soul connect back to the Realm of Faerie, and iron and steel weapons forged of the mortal realm cause you pain. After each Short or Long Rest, the first time you are damaged by an iron or steel weapon, you must succeed on a DC 15 Constitution saving throw or have the Stunned condition until the end of your next turn.

Eye of Newt… Powdered Owlbear Beak… Hag’s Blood… hmm… maybe we can skip that last one for now.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 13, 'Estágio 3', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 14, 'Gasdra', 'Small Monstrosity, Neutral Evil

AC 13 Initiative +4 (14)

HP 22 (4d6 + 8)

Speed 30 ft., Fly 40 ft.

Mod

Save

Skills Perception +2

Senses Darkvision 60 ft.; Passive Perception 12

Languages Understands Sylvan but can’t speak

Challenge 1 (XP 200; PB +2)

Traits

Three Heads. The gasdra has Advantage on Wisdom ( Perception ) checks and on saving throws to avoid or end the Blinded , Charmed , Deafened , Frightened , Stunned , or Unconscious conditions. The gasdra can take one Reaction for each of its heads. The extra Reactions can be used only for Opportunity Attacks .

Wakeful. While the gasdra sleeps, at least one of its heads is awake.

Actions

Multiattack. The gasdra makes three Beak attacks.

Beak. Melee Attack Roll: +4, reach 5 ft. Hit: 5 (1d6 + 2) Bludgeoning damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 15, 'Estágio 3', 'When you reach Stage 3 of the Hag Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 16, 'Stage 3 Boon: Master of the Green Sisterhood', 'You come into your power as a Hag and enhance your abilities.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 17, 'Stage 3 Boon: Master of the Red Sisterhood', 'You come into your power as a Hag and enhance your abilities.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 18, 'Stage 3 Boon: Master of the Sea Sisterhood', 'You come into your power as a Hag and enhance your abilities.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 19, 'Stage 3 Flaw: Purity’s Pain', 'Unspoiled, pure things cause you physical pain to witness. A child hugging their parent, a loyal dog laying its head upon a sick man’s lap, a work of religious art devoted to an Arch Seraph, a baby’s laughter: these things make you physically ill.

When you are in the presence of a pure act or object (GM’s discretion) you are wracked with pain. At the start of each of your turns while you can see the cause of your pain, you suffer 3d6 plus your Charisma modifier Psychic damage, and cannot use a Hag Transformation boons until the start of your next turn. The first time you take Psychic damage from this flaw after finishing a Short or Long Rest, you must make a DC 18 Wisdom saving throw. If you fail, you have the Frightened condition as long as you can see the source of your pain.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 20, 'Estágio 4', 'When you reach Stage 4 of the Hag Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 21, 'Stage 4 Boon: Evil Eye', 'Your visage is so horrifying that you can cause creatures to drop dead when your gaze falls upon them. As a Magic action, you gaze upon a Bloodied Beast or Humanoid within 30 feet that can see your true form. The creature must succeed on a Wisdom saving throw with a DC equal to 14 plus your Charisma modifier. If the target fails the save, it drops to 0 Hit Points. On a successful save, the creature takes 6d8 Psychic damage. You regain the use of this feature when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 22, 'Stage 4 Boon: Grandmother’s Curse', 'You learn one Shadowsteel curse of your choice. You always have it prepared, and it doesn’t count against the number of spells you can prepare each day. You can cast it once per day without using a spell slot or needing spell components.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 23, 'Stage 4 Flaw: Arch-Crone’s Hunger', 'You develop a taste for strange, cursed, or vile foods, and normal food no longer nourishes you. You must consume one of these unusual foods at least once every day or you gain 1 Exhaustion level, which cannot be removed until you feed your vile hunger. If you are forced to eat or drink normal food, you must succeed on a DC 18 Constitution saving throw or vomit it up and gain 1 Exhaustion level.

Examples of vile foods include the following:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 1, 'Como começar', 'There are many ways to become a Lich, each determining the type of Lich the mortal becomes. The Ritual of Dread is one of the main methods for arcanists of Etharis. The process of this ritual is a well-guarded secret, entrusted to only a handful of mortals at any one time. The process of the ritual involves several despicable acts including murder, the brewing of a vile concoction, and even one’s own death.

For Memori Liches, warriors of great renown who hope to break the cycle of death, the process is less involved but no less gruesome. The skull of a powerful vanquished foe serves at the focus of power, tipping off new opponents they are in for a hellish battle.

For Hierophants, the call of the divine is equally strong to the call of mortality. Those who want to spend an eternity with power over both life and death in the name of a powerful divine source.

Regardless of the form of lichdom, the process of tearing one’s soul from the body is most despised, for this process involves the sacrifice of something truly dear to a mortal, and no substitute will be accepted. For some, it is the death of a cherished loved one. For others it is a family legacy. Regardless of the sacrifice, unless the dread spirits deem it worthy, lichdom will not be granted.

Reversing Lich Traits

The amount of raw magical energy that goes into becoming a Lich means that undoing it is impossible. The only stage beyond lichdom is annihilation, and even that can only occur if both the physical form of the lich and its soul vessel are both destroyed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 2, 'Estágio 1', 'When you initially undergo the Lich Transformation, you gain the Undead Form Boon and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 3, 'Stage 1 Boon: Undead Form', 'You become an Undead in addition to any other creature type(s). You cannot be excluded from Turn Undead.

You also stop aging. You are immune to any effect that would age you, and you cannot die from old age. You do not require air, food, drink, or sleep.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 4, 'Stage 1 Boon: Lich Magica', 'You can trade the soul in your soul vessel for increased magical power.

On your turn, as a Bonus Action, you can spend the charge in your soul vessel (see the Stage 1 Flaw below) for one of the following effects.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 5, 'Stage 1 Boon: Memori Lichdom', 'While your soul vessel is charged, you gain the following benefits to your weapon attacks or Unarmed Strikes:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 6, 'Stage 1 Flaw: Soul Vessel', 'You have successfully torn your soul from your body and trapped it in a suitable object. The object must be a trinket or item no larger than 1 cubic foot in size. This item becomes your soul vessel.

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

If you are killed while you control a charged soul vessel on the same plane of existence, your soul vessel’s charge is consumed. You are brought back to life as per the Resurrection spell within 5 feet of your soul vessel 1 day later. If you are killed and your soul vessel is not charged, you are resurrected 7 days later instead.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 7, 'Estágio 2', 'When you reach Stage 2 of the Lich Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 8, 'Stage 2 Boon: Acolyte of Undeath', 'When you reduce a Humanoid to 0 Hit Points and it dies, you can use a Reaction to immediately transform it into a Zombie under your control. You can have three such creatures under your control at once. These Zombies act on their own initiative count, following your verbal commands to the best of their ability.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 9, 'Stage 2 Boon: Binding Curse', 'You can compel a creature with a binding curse. As a Bonus Action, choose a creature within 30 feet who can see you. That creature makes a Charisma saving throw against a DC of 12 plus your Transformation Stage. On a failed save it cannot move more than 30 feet away from you for 1 minute. Also, during that time, your weapon attacks and Unarmed Strikes against the creature deal an additional 2d6 Necrotic damage.

You can use this feature three times, regaining all uses after finishing a Short Rest or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 10, 'Stage 2 Boon: Corrupting Magic', 'Whenever you kill any creature with a spell, you may apply an additional effect depending on the damage dealt. This ability cannot be used when you kill a Construct, Undead, or any creature without a soul.

Choose one of the following effects when you use this ability:

Life Force. As the soul of your enemy leaves their body, you siphon off part of their life force. You regain 1d6 Hit Points per Transformation Stage.

Poison. Choose a creature within 10 feet of the killed creature. That creature takes 1d6 Poison damage per Transformation Stage.

Exhaustion. Choose a creature within 10 feet of the killed creature. That creature gains one Exhaustion level. A creature may only have one Exhaustion level from this feature at a time.

The Making of a Lich

In most fantasy stories, lichdom isn’t just something that happens to an innocent person. Becoming a Lich takes years of research, countless sacrifices for yourself and others, and the incredibly low moral and ethical standards necessary to follow through. The years or even decades of meticulous planning and study are infused into the mythology of what lichdom means.

For the Lich Transformation, that mythology may need to be rewritten slightly. The power of Liches comes much more quickly, or perhaps even accidentally, or through a curse. Liches may not be the all-powerful geniuses they are thought to be. They might be tricked or forced to undergo a transition to lichdom. They may even think they are free agents, but the forces that turn them into Liches are using them for other purposes.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 11, 'Stage 2 Flaw: Hideous Appearance', 'Your appearance has grotesquely transformed. Your flesh withers and contracts around your bones, your eyes become sunken, and you reek of death. Regardless of your true form, you’re horrific to behold.

You can suspend this form and manifest the appearance of the humanoid you once were, but this is taxing and requires effort. This form is not permanent, and moments of stress are likely to reveal your true nature. Your true form may be revealed in the following situations:

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constitution saving throw with a DC based on your current Transformation Stage. If you fail this save, your Horrific Appearance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 12, 'Estágio 3', 'When you reach Stage 3 of the Lich Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 13, 'Stage 3 Boon: Eldritch Concentration', 'Your supernatural ability with magic manifests in new ways. When you cast a spell that requires Concentration , if you are already concentrating on one such spell, you can spend the charge of your soul vessel . If you do this, you do not lose Concentration on the original spell. Instead, you gain 1 Exhaustion level.

If you cast a third Concentration spell during this time, or lose Concentration for any other reason, you lose Concentration on both current spells you are concentrating on. Once you use this feature you cannot use it again until you finish a Short Rest or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 14, 'Stage 3 Boon: Master of Undeath', 'Undead creatures under your control from a Lich Transformation Boon have Advantage on attack rolls when they are within 5 feet of you.

Additionally, whenever an Undead creature you control due to a Lich Transformation Boon is reduced to 0 Hit Points, you can spend the charge of your soul vessel as a Reaction . If you do, that Undead creature is at 1 hit point instead and may immediately move up to its full speed and make an Attack action with Advantage. This feature has no effect if the creature has been reduced to 0 Hit Points by Radiant damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 15, 'Stage 3 Boon: Unholy Healing', 'Your magical connection to your soul vessel restores your vitality quickly. While your soul vessel is charged, you can use a Magic action to draw healing power from it. At the start of each of your turns for 1 minute, you regain 10 Hit Points. The soul vessel does not lose its charge.

You can use this feature three times, and you regain all uses after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 16, 'Stage 3 Flaw: Necromantic Dystrophia', 'When your soul vessel is not charged, you suffer the following effects:

Upon charging your soul vessel with an appropriate soul, you are no longer subject to these effects.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 17, 'Estágio 4', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 18, 'Estágio 4', 'When you reach Stage 4 of the Lich Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 19, 'Stage 4 Boon: Eldritch Omniscience', 'You have better mastered the magical arts. The number of spells you can learn and can have prepared increases by 4. Additionally, whenever you finish a Short Rest or Long Rest you gain 1 additional spell slot of whichever level you choose.

If a creature dies as a result of one of your spells, you can instantly draw that soul into your soul vessel without using a Magic action or Reaction .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 20, 'Stage 4 Boon: Lord of Undeath', 'When you use Acolyte of Undeath you can choose to transform the target into a Ghoul instead of a Zombie .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 21, 'Stage 4 Boon: Soul-Shattering Attack', 'After you make a weapon attack or Unarmed Strike , you can spend the charge in your soul vessel to add the Challenge Rating of the soul within it to the attack roll and damage dealt with that attack. If the creature dies from that attack, you can instantly recharge your soul vessel with the soul that you just expended.

You can use this feature a number of times equal to 4 plus your Proficiency Bonus. You regain all uses after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 22, 'Stage 4 Flaw: Weight of the Ages', 'The weight of time is degrading for your form, and only the magic of your soul vessel holds it together. If your soul vessel is reduced to 0 hit points, your soul is lost; you are killed instantly and your body crumbles to dust.

There is always a price for power. And the powerful aren’t always the ones who pay.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 1, 'Como começar', 'In Etharis, there are two well-known methods of contracting the lycanthropic curse. The first is being bitten by a lycanthrope and not curing the curse before it takes hold.

The second is to complete a Druidic ritual known as the Lunar Sacrament. This violent and bloody rite, involving the sacrifice of an innocent person, underscores the ruthless and uncompromising nature of someone willing to do evil in exchange for power.

Other means of gaining lycanthropy are possible. The curse of a powerful being, a side effect of a powerful artifact, or eating the raw flesh of a lycanthropic creature: all of these are potential triggers for the Lycanthrope Transformation.

Once your character has become a Lycanthrope, consider how they feel about the curse. Do they wish to cure it before it progresses too far? Do they wish to understand it and make peace with the beast that resides within?

Curing Lycanthropy

Once the character reaches Stage 1 of the Lycanthrope Transformation, no typical magic like Remove Curse can cure the character’s lycanthropy. Magic on the level of the Wish spell is needed to completely remove the Transformation and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 2, 'Estágio 1', 'When you initially contract lycanthropy, you select one Stage 1 Boon and gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 3, 'Stage 1 Boon: Hybrid Wolf Form', 'You become a Monstrosity in addition to any other creature type(s).

As a Magic action, you may voluntarily transform into a hybrid half-wolf creature. While in your hybrid wolf form, the following rules apply:

Your hybrid wolf form lasts 1 hour per Transformation Stage. If you entered your hybrid form voluntarily, you can revert to your normal form by using a Magic action on your turn. (Flaws listed below may override this rule.)') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 4, 'Stage 1 Boon: Hybrid Bear Form', 'You become a Monstrosity in addition to any other creature type(s).

As a Magic action, you may voluntarily transform into a hybrid half-bear creature. While in your hybrid bear form, the following rules apply:

Your hybrid bear form lasts 1 hour per Transformation Stage. If you entered your hybrid form voluntarily, you can revert to your normal form by using a Magic action on your turn. (Flaws listed below may override this rule.)') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 5, 'Stage 1 Boon: Hybrid Rat Form', 'You become a Monstrosity in addition to any other creature type(s).

As a Magic action, you may voluntarily transform into a hybrid half-rat creature. While in your hybrid rat form, the following rules apply:

Your hybrid rat form lasts 1 hour per Transformation Stage. If you entered your hybrid form voluntarily, you can revert to your normal form by using a Magic action on your turn. (Flaws listed below may override this rule.)') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 6, 'Stage 1 Flaw: Lust for the Hunt', 'The savage nature of your curse sometimes causes you to lose control. These ferocious tendencies are a constant struggle between you and the beast within.

The first time you become Bloodied after finishing a Short Rest or Long Rest, you must succeed on a DC 10 Wisdom saving throw. If you are in the light of a full moon, you automatically fail this saving throw.

If you fail this saving throw, you are subjected to the following rules until you can end the hybrid form:

If you are at full Hit Points at the start of your turn, you can make a DC 10 Wisdom saving throw. On a success, you return to your normal form. You also return to your normal form if Remove Curse is cast on you, or after 1 hour passes.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 7, 'Estágio 2', 'When you reach Stage 2 of lycanthropy, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 8, 'Stage 2 Boon: Hunter’s Focus', 'While in hybrid form, you can use a Bonus Action to mark one creature within 60 feet as your prey. A creature remains marked this way for 1 hour, or until it dies. You may only have 1 creature marked at a time.

While a creature is marked as your prey, you gain the following benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 9, 'Stage 2 Boon: Iron Pelt', 'While in hybrid form, you have Resistance to Bludgeoning, Piercing, and Slashing damage. Magical and silvered weapons ignore this resistance.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 10, 'Stage 2 Boon: Kindred Form', 'You gain the ability to transform into the animal form representative of your Lycanthropy type, known as your Kindred Form. Use the stat block of the creature your lycanthropy corresponds with and follow the rules of the Polymorph spell:

You are indistinguishable from other creatures of that type, and you can communicate with those creatures. You cannot speak, but you can understand languages you know. All equipment you wear and carry falls off you when transforming.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 11, 'Stage 2 Flaw: Silver Sensitivity', 'You have developed a debilitating sensitivity to silver. In all forms, you have Vulnerability to Bludgeoning, Piercing, or Slashing damage from silvered weapons. In addition, you cannot have Resistance to damage inflicted by silvered weapons.

I can still see her silver blade cutting through the beast’s flesh, where arrows had just bounced off.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 12, 'Estágio 3', 'When you reach Stage 3 of lycanthropy, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 13, 'Stage 3 Boon: Bestial Vigor', 'Your Hit Point Maximum increases by an amount equal to your character level, and it increases by 1 every time you gain a character level.

Additionally, when in your hybrid form, you gain 5 Temporary Hit Points at the start of each of your turns.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 14, 'Stage 3 Boon: Shapeshifter’s Savagery', 'You have embraced the animalistic side of your transformation. While in your hybrid form, you gain the following benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 15, 'Stage 3 Flaw: Frayed Thoughts', 'You suffer the effects of sharing a mind with two personalities. Memories of less practical significance are lost to new ones of midnight hunts. You have Disadvantage on Intelligence ability checks and saving throws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 16, 'Estágio 4', 'When you reach Stage 4 of lycanthropy, you select a Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 17, 'Stage 4 Boon: Hybrid Form Affinity', 'You have achieved a state of equilibrium that most Lycanthropes never find. You gain the following benefits while you are voluntarily in your hybrid form:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 18, 'Stage 4 Boon: Savage Instincts', 'You have developed an unrelenting thirst for bloodshed and carnage. While in your hybrid form, if you hit a Bloodied creature with a Claw or Bite attack, the attack deals an additional 1d8 Slashing damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 19, 'Stage 4 Flaw: Ultimate Predator', 'You realize the true cost of your transformation. The beast within has gained more control of your body than you have. While you can control it at times, you know it cannot be contained forever—and when it breaks free, it delights in any slaughter it can find.

You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 20, 'Estágio 5', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 1, 'Como começar', 'It may seem like Oozes are monsters that only appear in the deepest, dankest recesses of dungeons and cave complexes that never see the light. While they certainly do haunt those places, Oozes in Etharis are never far away. Urban areas with poor sanitation are breeding ground for Oozes, as are pastoral locations with proximity to the Fey Realms.

And while some Ooze creatures may only devour and destroy, there are just as many — especially those who have been created or experimented on by the curious and the morbid — who seek to spread their oozy nature to others.

It is rumored by sage and peasant alike that the Filth Grazer, the force allegedly behind the creation and spread of the Weeping Pox, devours organic life by reducing it first into a putrescent sludge. Mortals are but food for aetheric horrors, and the Filth Grazer prefers theirs gurgling, gooey, and foul.

The truly mad might seek to gain the benefits of becoming an Ooze, thinking that being formless would provide power. Regardless of how it happens, people who become an Ooze find themselves in a terrible race: which will they lose first, their body or their mind?

Reversing Ooze Traits

Ooze features are terrible and difficult to undo once they have taken hold. Excruciating experimental trials might be able to alleviate some of the symptoms for a while, but a complete cure would take decades of knowledge and wealth that few in Etharis possess. Even then, it would still require a great deal of luck.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 2, 'Estágio 1', 'When you initially undergo the Ooze Transformation, you gain the Ooze Form Boon and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 3, 'Stage 1 Boon: Ooze Form', 'You become an Ooze in addition to any other creature type(s) you are. You gain Blindsight with a range of 30 feet. If you already have Blindsight, your range increases by 30 feet.

You can will your body to melt and flow, becoming more fluid than solid. As a Bonus Action, you manifest your Ooze Form. You become amorphous, able to move through a space as narrow as 1 inch without expending extra movement, and you are immune to the Grappled and Restrained conditions. You remain in Ooze Form for 1 minute or until you use your Bonus Action to return to normal.

You can manifest your Ooze Form a number of times equal to your Proficiency Bonus plus your Transformation stage. You regain all uses of this feature after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 4, 'Stage 1 Boon: Mutable Corpus', 'You have abundant control over your Ooze Form. Each time you manifest your Ooze Form, you can choose to augment it with one of the following options:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 5, 'Stage 1 Boon: Slimy Mien', 'While manifesting your Ooze Form, you gain the following additional benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 6, 'Stage 1 Flaw: Sluggish', 'Your body frequently shifts and melts without control, making you sluggish. Your speed decreases by 5 feet for every Transformation Stage you achieve.

In addition, your skin glistens with oozy droplets leaving a trail anywhere you go. Ability checks made to follow your tracks are made with Advantage .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 7, 'Estágio 2', 'When you reach Stage 2 of the Ooze Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 8, 'Stage 2 Boon: Elastic Limbs', 'Your limbs have become elastic and tacky, allowing you to reach distant enemies and climb walls.

Your reach increases by 5 feet and you gain a Climb Speed equal to your Speed. You can move up, down, and across vertical surfaces and along ceilings, while leaving your hands free. Creatures you are grappling have Disadvantage on Strength ( Athletics ) and Dexterity ( Acrobatics ) checks to escape.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 9, 'Stage 2 Boon: Viscous Durability', 'Your mind and body become even more Ooze-like. You have Immunity to the Frightened condition and Acid damage.

When you gain this Boon, choose Cold, Fire, or Lightning. Gain resistance to the chosen damage type.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 10, 'Stage 2 Flaw: Melted Appearance', 'Your body is now a hideous lump of dripping flesh excreting foul smelling slime. While your form remains roughly humanoid, the horror of what you are is clear to anyone that looks upon your molten face. You have Disadvantage when you use the Influence action to make Charisma-based ability checks made against creatures that are not Aberrations or Oozes.

In addition, your Transformation to an Ooze has liquefied many of your organs and dimmed your senses. Your eyes melt and run down your face and there is nothing but flesh where your ears once were. You permanently have the Blinded condition beyond the range of your Blindsight .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 11, 'Estágio 3', 'When you reach Stage 3 of the Ooze Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 12, 'Stage 3 Boon: Corrosive Membrane', 'When you manifest your Ooze Form , it lasts for 10 minutes.

While manifesting your Ooze Form, you are covered with a sheen of acidic slime. When a creature hits you with a melee attack, it takes Acid damage equal to 1d6 plus your Transformation Stage. Nonmagical ammunition is destroyed immediately after hitting you and dealing damage. Any nonmagical weapon takes a cumulative −1 penalty to attack rolls immediately after dealing damage or coming into contact with you. The weapon is destroyed if the penalty reaches −5. The penalty can be removed by casting the Mending spell on the weapon.

Additionally, you can eat through 2 feet of nonmagical wood or metal in 1 minute simply by touching it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 13, 'Stage 3 Boon: Engulf', 'When you manifest your Ooze Form, it lasts for 10 minutes.

While manifesting your Ooze Form, you can envelop your foes in your gooey body. As a Magic action, you can try to engulf a creature of your size category or smaller that is within 5 feet of you. The target makes a Strength saving throw, with a DC equal to 10 plus your Strength modifier plus your Transformation Stage. On a failure, the creature is engulfed.

While engulfed, a target has Total Cover against attacks and other effects outside of you, and when you move, the engulfed target moves with you. While engulfed, a creature takes 4d6 Acid damage at the start of each of its turns, is suffocating, has the Restrained condition, and repeats the save at the end of each of its turns, ending the effect on a success. An engulfed creature that is reduced to 0 Hit Points is fully digested, leaving no body or nonmagical equipment behind.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 14, 'Stage 3 Flaw: Physical Deterioration', 'Your skin sloughs away in thick, syrupy sheets and your bones become like melted wax. The sun itself burns you, and holy light becomes lethal. Now your reactions slow as much as your pace.

You are Vulnerable to Radiant damage, and you have Disadvantage on Dexterity ability checks and saving throws.

I’ll never use the term “I’m melting from this heat“ again after seeing that.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 15, 'Estágio 4', 'When you reach Stage 4 of the Ooze Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 16, 'Stage 4 Boon: Legion of Slime', 'When you manifest your Ooze Form , it lasts until you finish a Short or Long Rest.

While you are manifesting your Ooze Form and you are hit by an attack that causes you to become Bloodied , you can use a Reaction to split into two identical Oozes. Each Ooze uses your game statistics, except that they are one size category smaller than your normal size, and your remaining Hit Points and Hit Point Maximum are divided evenly between the two Oozes (round down). Your equipment is not duplicated; all of it remains on one of the Oozes.

Each Ooze acts on your Initiative. They can each move independently, but they can only collectively take one action and Bonus Action on your turn and one Reaction per round.

After you use this feature, you cannot use it again until after you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 17, 'Stage 4 Boon: Mimic Object', 'When you manifest your Ooze Form, it lasts until you finish a Short or Long Rest.

While manifesting your Ooze Form, you can use a Magic action to transform into an object of your size or up to two sizes smaller. Any equipment worn or carried is dropped in your space. While mimicking an object, you retain your statistics.

While mimicking an object, you are indistinguishable from the object and you can take a Reaction when you are touched to adhere to the creature that touches you. The creature has the Grappled condition. The DC to escape is equal to DC equal to 8 plus your Constitution modifier plus your Transformation Stage. Ability checks made to escape this grapple have Disadvantage .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 18, 'Stage 4 Flaw: Slippery Ego', 'As your brain becomes just one more part of the gooey mass that is you, and your sense of self becomes ever more tentative, the slightest distraction can cause you to forget who you were.

The first time you become Bloodied after a Long Rest, or whenever you roll a 1 on a saving throw, the pain or surprise causes you lose your grip on your mind. You can’t cast spells, activate magic items, understand language, or communicate in any intelligible way. You are overwhelmed with hunger and take the Attack action on your next turn to make melee attacks against a random creature within reach. If there are no creatures within reach, you move until you are adjacent to the nearest creature, using the Dash action if necessary.

You may attempt a DC 18 Wisdom saving throw at the end of each of your turns to regain your sense of self. This effect ends automatically when you finish a Short Rest or Long Rest.

You don’t know real power until you can become anything!') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 19, 'Estágio 6', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 1, 'Como começar', 'There are several ways for a mortal to consume a primordial spark. They might be born with one due to some sorcery or gifted one by accident in the dreams of a slumbering Primordial. A mortal may consume the power of an Elemental through arcane rituals. Or a body could become infused with primal energy after surviving a calamity caused by an Elemental creature or rift to an Elemental Plane.

Once acquired, one must spend a great deal of time contemplating and understanding the spark to unlock its full potential. The process of attaining elemental mastery is dangerous. The slightest slip in control can cause devastation on a massive scale. Such facts are why isolated individuals like Druids, Monks, or Rangers are most likely to see the Transformation through to its end.

Reversing Primordial Traits

Once a primordial spark has taken hold, your mortal body will continue to deteriorate from the roiling elements it now tries to contain. You will inevitably become one with the elements, your soul pulled into the Elemental Plane. Only magic on the level of the Wish spell can then revive you, with or without your Transformation and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 2, 'Estágio 1', 'When you initially undergo the Primordial Transformation, you gain both Stage 1 Boons and the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 3, 'Stage 1 Boon: Primordial Form', 'You become an Elemental in addition to any other creature type(s).

Your Constitution score increases by 1, but cannot increase above 20 in this way.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 4, 'Stage 1 Boon: Elemental Affinity', 'Though you have sway over all the elements, your Primordial change was sparked by one particular element: your Elemental Affinity. This element infuses your form and dictates your powers. You must choose one element below and gain all the benefits of that element:

Air. You have Resistance to Lightning damage. In addition, you can channel the air currents around you to guide a ranged attack. Once on each of your turns, when you make an attack with a Ranged weapon or ranged spell, you can make that attack with Advantage. If you are in a location without air—such as underwater or in a vacuum—this feature has no effect.

Earth. You have Resistance to Bludgeoning damage. In addition, whenever you gain Temporary Hit Points , you gain additional Temporary Hit Points equal to your Proficiency Bonus.

Fire. You have Resistance to Fire damage. In addition, whenever you deal Fire damage, you can add your Constitution modifier to the damage dealt.

Water. You have Resistance to Cold damage. In addition, whenever a creature within 30 feet regains Hit Points, you can use a Reaction to imbue them with healing elemental energy. The creature regains an additional 1d6 Hit Points.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 5, 'Stage 1 Flaw: Planar Binding', 'Your body and soul are connected to the Elemental Plane. You have Disadvantage on Death Saving Throws as the plane attempts to pull you into it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 6, 'Estágio 2', 'When you reach Stage 2 of the Primordial Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 7, 'Stage 2 Boon: Dual Nature', 'You add a second element to your Elemental Affinity Boon . When you do so, you gain the associated benefits of your new element.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 8, 'Stage 2 Boon: Elemental Surge', 'You can channel pure elemental energy into a concentrated bolt of an element of your choice. As a Magic action, you can use any of the following options:

Lightning Strike. You can make a ranged attack targeting a creature within 60 feet. You are proficient with this attack, which uses your Constitution modifier. On a hit, this attack deals 3d8 plus your Constitution modifier Lightning damage. You can then use a Bonus Action to target another creature within 30 feet of the first target with the same attack.

Increase the damage of these attacks by 1d8 for each Transformation Stage above 2.

Earth Shard. You can force a creature within 30 feet to make a Constitution saving throw. On a failed save, the creature takes Bludgeoning damage equal to 3d6 plus your Constitution modifier, or half as much on a successful save. Increase the damage by 1d6 for each Transformation Stage above 2.

You also gain Temporary Hit Points equal to half the damage dealt.

Flame Wave. Each creature in a 15-foot Cone originating from you makes a Dexterity saving throw against a DC equal to 8 plus your Constitution modifier plus your Transformation Stage. On a failed save, creatures in the area take Fire damage equal to 2d8 plus your Constitution modifier. Increase the damage by 1d8 for each Transformation Stage above 2.

Aquatic Rejuvenation. Choose a creature you can see within 60 feet of you. The creature regains a number of Hit Points equal to 2d8 plus your Constitution modifier. Increase the number of Hit Points regained by 1d8 for each Transformation Stage above 2.

You can use Elemental Surge a number of times equal to your Constitution modifier, regaining all expended uses upon finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 9, 'Stage 2 Flaw: Roiling Elements', 'Your physical vessel strains to contain the roiling elements trapped inside of you. In a moment of distraction your body may erupt momentarily to reveal your Primordial nature. Tongues of flame may lash out or arcs of lightning might burst from beneath your skin.

You can contain the elements and maintain the appearance of the humanoid you once were, but this is taxing and requires effort. Moments of stress are likely to unleash your true nature, which might occur under the following circumstances:

In these events, or times of other extreme emotional or physical stress, the GM can call for a Constitution Saving Throw with a DC based on your current Transformation Stage:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 10, 'Estágio 3', 'When you reach Stage 3 of the Primordial Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 11, 'Stage 3 Boon: Aura of Awakening', 'You emit an aura of power that awakens the elemental forces in your companions. When you first gain this feature, choose one of the options below. You may change the aura you emit upon finishing a Long Rest.

Light as Air. Whenever you or an ally you can see within 30 feet of you makes a Dexterity saving throw, the creature gains a bonus equal to your Constitution modifier.

Forged in Fire. When an ally within 10 feet of you deals damage with a melee attack, you can use a Reaction to make the attack deal Fire damage instead of the normal damage type, and add 2d6 Fire damage to the attack’s damage.

Heart of Stone. You can choose to have Disadvantage on any Initiative check. If you do, as a Reaction, you and each creature of your choice within 30 feet of you gain Temporary Hit Points equal to your 1d10 plus your Constitution modifier. While a creature has Temporary Hit Points gained in this manner, they cannot have the Prone condition unless it is part of the Unconscious condition.

Fluid Movement. When an ally within 30 feet moves or attempts to escape a Grapple, you can use a Reaction to give them the following benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 12, 'Stage 3 Boon: Primeval Body', 'Your transformation to an Elemental creature has changed your body entirely. You no longer need to sleep, breathe, or eat. Also, you no longer age normally and suffer no effects of aging.

Additionally, choose one damage type from Bludgeoning, Cold, Fire, and Lightning damage. You gain Resistance to that damage type. If you already have Resistance, you gain Immunity to it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 13, 'Stage 3 Boon: Master of Many', 'You add a third elemental to your Elemental Affinity Boon . When you do so, you gain the associated benefits of your new element.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 14, 'Stage 3 Flaw: Elemental Imbalance', 'Your body reacts in strange ways to the application of severe elemental damage. When you take Acid, Cold, Fire, Lightning, or Thunder damage, roll 1d6. On a 1, your Primordial form reacts in a volatile manner, and the following effects occur:

The Primordial Existence

The mythological, and perhaps even the empirical, representation of primordial power in Etharis is Gormadraug, the Prismatic Wyrm. Valikans grow up hearing tales of the power—and the world-ending danger of the Great Wyrm. The beast embodies all the apocalyptic potential of earth, air, fire, and water.

Within the land controlled by the Valikan Clans, creatures showing an ability to manifest the primordial elements would strike awe into witnesses of that power. And more importantly, they would also likely be feared and mistrusted. Indeed, with the awakening of Gormadraug such a feared event, such people would be seen as a threat unless they could convince the common folk that they are not harbingers of doom.

While other lands would not be as fearful as the Valikans of the elemental magic (save for maybe the Arcanist Inquisition), wielders of primordial elemental power are likely looked at as dangerous and in league with powers beyond their control and understanding.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 15, 'Estágio 4', 'When you reach Stage 4 of the Primordial Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 16, 'Stage 4 Boon: Primordial Aura', 'Creatures of your choice within 15 feet of you gain Resistance to Bludgeoning, Cold, Fire, or Lightning damage. You choose the damage type after finishing a Short Rest or Long Rest, and you can change the damage type as a Bonus Action. If they already have Resistance to any of these damage types, they gain Immunity to that damage type.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 17, 'Stage 4 Boon: Elemental Mastery', 'You add the final element to you Elemental Affinity Boon . When you do so, you gain the associated benefits of your new element.

Additionally, you can summon the four elements to wreathe you in power. Whenever a creature hits you with a melee attack, you can use your Reaction to force it to make a Dexterity saving throw, dealing 6d6 damage of a type of your choice from Bludgeoning, Cold, Fire, or Lightning, or half as much on a successful save.

After you use this Reaction, your Elemental Affinity features gain the following benefits until the end of your next turn:

Air. You have Advantage on all Ranged weapon and ranged spell attacks.

Earth. At the beginning of your turn, you gain 20 Temporary Hit Points .

Fire. At the beginning of your turn, each creature of your choice within 5 feet of you takes 2d6 Fire damage.

Water. Whenever a creature withing 60 feet that you can see regains Hit Points by spending Hit Point Dice or through a spell or magical ability, that creature regains an additional 20 Hit Points.

You can use this feature a number of times equal to your Constitution modifier, regaining all uses upon completing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 18, 'Stage 4 Flaw: Primordial Chaos', 'The plane of Primordial energy that you’re tied to strengthens its pull on you. Whenever you roll a natural 1 on a saving throw against a spell, you take 8d6 Force damage, which ignores Resistances and Immunities. This damage is in addition to any normal damage from the effect.

The presence of these people gives credence to mortals being comprised of four essential elements.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 19, 'Estágio 7', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 1, 'Como começar', 'To be chosen by an Arch Seraph is to become a vessel for the principles they uphold. This is a charge not to be taken lightly, and those who display righteousness with the intention of becoming a Seraph are usually overlooked for this reason. When becoming a Seraph, consider why your character was chosen. Do you display hidden merit? Are you devoted to a cause they will value?

Relinquishing Divinity

Characters who reach Stage 1 of the Seraph Transformation do not typically seek power without righteous cause. The Transformation’s Boons and Flaws can be removed at any time by relinquishing divinity, as a warrior retires their sword when the war is over. Regaining such power may not be so easy.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 2, 'Estágio 1', 'When you initially undergo the Seraph Transformation, you gain Celestial Form and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 3, 'Stage 1 Boon: Celestial Form', 'You become a Celestial in addition to any other creature type(s) you are. Additionally, you have Resistance to Radiant Damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 4, 'Stage 1 Boon: Angelic Wings', 'As a Bonus Action, you can manifest feathered wings for 1 hour. While they are manifested, you have a Fly Speed equal to your Speed when you are not wearing heavy armor.

You can manifest these wings a number of times equal to your Transformation Stage, and you regain all uses after finishing a Short or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 5, 'Stage 1 Boon: Holy Strikes', 'When you hit with a weapon or an Unarmed Strike or damage a creature with a cantrip, you can add 1d6 Radiant damage to that attack. You can add this damage a number of times equal to your Proficiency Bonus plus your Transformation Stage. You regain all uses of this feature when you finish a Short or Long Rest.

At higher Transformation Stages, you deal an additional 1d6 Radiant damage per Transformation Stage, for a total of 2d6 at Stage 2, 3d6 at Stage 3, and 4d6 at Stage 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 6, 'Stage 1 Flaw: Planar Binding', 'Your body and soul are bound to the higher planes of good. You have Disadvantage on Death Saving Throws as the plane attempts to pull your soul into its place of final reward.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 7, 'Estágio 2', 'When you reach Stage 2 of the Seraph Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 8, 'Stage 2 Boon: Divine Clemency', 'When an ally within 30 feet of you that you can see takes damage, you can use a Reaction to cast Healing Word at first level on that ally without using a spell slot.

You can do this a number of times equal to your Transformation Stage. You regain all uses of this feature after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 9, 'Stage 2 Boon: Sacred Retribution', 'When an ally you can see within 30 feet takes the Attack action with a weapon or Unarmed Strike , you can use your Reaction to imbue them with holy zeal, allowing them to make one additional attack. On a hit, the target takes an additional 1d8 Radiant damage. You may use this feature a number of times equal to your Transformation Stage. You regain all uses of this feature when you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 10, 'Stage 2 Flaw: Blinding Radiance', 'Your Transformation into a Seraph brings with it changes to your physical features. Your body radiates a divine glow, your eyes may become hollow braziers of celestial light, or your many sets of wings may appear unsettling to mortal creatures.

You can suspend this form and manifest the appearance of the humanoid you once were, but this is taxing and requires effort. This form is not permanent, and moments of stress or wrath are likely to reveal your true nature. This might occur under the following circumstances:

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constitution saving throw with a DC based on your current Transformation Stage. If you fail this save, your Blinding Radiance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 11, 'Estágio 3', 'When you reach Stage 3 of the Seraph Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 12, 'Stage 3 Boon: Cleanse Affliction', 'When you use Divine Clemency on a creature, they gain the following additional benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 13, 'Stage 3 Boon: Protective Wings', 'While you are manifesting your Angelic Wings , you gain the following benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 14, 'Stage 3 Boon: Bow of Celestial Judgement', 'You can use a Bonus Action to manifest a powerful bow made of divine light. The Bow of Celestial Judgement lasts for 1 minute and grants you the following abilities while manifested:

You can use this feature a number of times equal to your Transformation Stage, and you regain all uses after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 15, 'Stage 3 Flaw: Beacon to Darkness', 'You are now a Seraph of noted virtue and divinity, becoming a target for the world''s evil. Whenever you or an ally within 30 feet commits an evil act, such as murdering innocents, you acquire a trace of darkness and you are Corrupted. GMs determine what constitutes an evil act.

While you are Corrupted, whenever you make an attack roll against an evil creature or a saving throw against a spell or effect from an evil creature, you have Disadvantage on the check. Also, if an ally is the one who caused your Corruption, they cannot be considered your ally or you theirs until the Corruption is removed.

You can remove the Corrupted condition by finishing a Short Rest or Long Rest, during which you must pray for at least 1 hour and burn holy incense or donate wealth to a local good cause worth at least 100 GP times your Transformation Stage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 16, 'Estágio 4', 'When you reach Stage 4 of the Seraph Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 17, 'Stage 4 Boon: Aura of Holy Purge', 'You emit an aura of righteous fervor in a 20-foot Emanation centered on you, except when you have the Unconscious condition. When an ally within your aura hits with a weapon attack, the ally can use their Reaction to cause the hit to be a Critical Hit . If they do, you and the ally each gain a level of Exhaustion . After an ally uses this Reaction, that ally can''t use it again until after they finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 18, 'Stage 4 Boon: Aura of Righteous Mercy', 'You emit an aura of peaceful resolution in a 20-foot Emanation centered on you, except when you have the Unconscious condition. When an ally within your aura would be reduced to 0 Hit Points, they can use their Reaction to drop to 1 Hit Point instead. If they do, you and the ally each gain a level of Exhaustion. After an ally uses this Reaction, that ally can''t use it again until after they finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 19, 'Stage 4 Boon: Bow of Celestial Domination', 'While your Bow of Celestial Judgement is manifested, you gain these additional benefits:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 20, 'Stage 4 Flaw: Seraph Corruption', 'The weight of evil in the world encumbers you more and more heavily as the days pass. Sometimes it becomes too much, and your celestial form is wracked with pain and doubt.

Whenever you roll a natural 1 on a saving throw, you suffer the following effects for 1 minute:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 21, 'Estágio 8', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 1, 'Como começar', 'Curses are wrought from and woven with intense feelings of loathing, spite, and bitterness. Humanoids who choose to wield such deeply evil magic leave an indelible mark upon their own soul. When enough of these marks pollute a person, their spirit begins to rot.

A creature who uses a Spellcasting Focus made of Shadowsteel, particularly to cast curses, risks acquiring the Shadowsteel Ghoul curse. Being attuned to a Shadowsteel magic item or wielding a Shadowsteel weapon for a prolonged period also carries a similar danger.

Curing Shadowsteel Ghoul Curses

Once the character reaches Stage 1 of the Shadowsteel Ghoul Transformation, no typical magic like Remove Curse can remove the affliction. Magic on the level of the Wish spell is needed to completely remove the Transformation and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 2, 'Estágio 1', 'When you initially contract the Shadowsteel Ghoul curse, you select one Stage 1 Boon and gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 3, 'Stage 1 Boon: Shadowsteel Curser', 'If you do not already have it, you gain the Shadowsteel Adept feat .

Additionally, when you cast a Shadowsteel curse, the casting time is reduced by half, and the saving throw DC increases by 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 4, 'Stage 1 Boon: Shadowsteel Weapon', 'During a Long Rest, you focus upon a Melee weapon within your reach, imbuing it with a fragment of your Shadowsteel corruption. This Shadowsteel weapon deals your choice of Force damage or their normal damage type.

When you reduce a creature to 0 Hit Points with a melee attack made with your Shadowsteel weapon, you gain 1d8 Temporary Hit Points for 1 hour.

You can repeat the process described above to imbue a different weapon with Shadowsteel. This removes the effect from your existing Shadowsteel weapon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 5, 'Stage 1 Flaw: Debilitating Magic', 'Choose one ability score. You lose 2 points in that ability as the power of the Shadowsteel slowly eats away at your body, soul, or both.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 6, 'Estágio 2', 'When you reach Stage 2 of the Shadowsteel Ghoul curse, you select two Stage 2 Boons and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 7, 'Stage 2 Boon: Magic Resistance', 'You have Advantage on saving throws against spells.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 8, 'Stage 2 Boon: Shadowsteel Absorption', 'As the Shadowsteel courses through you, it begins to harden your flesh. Your Armor Class increases by 1 when you aren’t wearing armor.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 9, 'Stage 2 Boon: Shadowsteel Caster', 'If you do not already have it, you gain the Shadowsteel Master feat .

Additionally, when you use a Shadowsteel component to cast a spell using a spell slot, you can spend a Hit Die to regain that spell slot. The spell slot level cannot be greater than twice your Shadowsteel Ghoul Transformation Stage.

You can use this feature a number of times equal to your spellcasting ability modifier. You regain all uses of this feature after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 10, 'Stage 2 Boon: Shadowsteel Weapon Master', 'You gain a +4 bonus to damage rolls made with your Shadowsteel weapon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 11, 'Stage 2 Flaw: Friendless', 'You are no longer able to connect with other creatures on a social level. You prefer isolation and twisted contemplation to friendship and camaraderie.

You cannot be considered an ally to any Humanoids or Beasts, and no living creature can be Friendly toward you.

You also have Disadvantage on all Charisma ability checks.

Shadowsteel''s Temptation

The Shadowsteel Ghoul Transformation might be the most likely change for characters to undertake. Each time a caster uses a Shadowsteel Focus to cast a spell, or a warrior wields a Shadowsteel weapon, they risk losing a bit of their soul to gain a bit of power.

Players should know what is happening to their characters when they wield Shadowsteel''s power. It’s a boost to the power of a character, and the risk should be offsetting that power. The toll that is takes on the character should be explained by the GM, and hopefully the player—in the spirit of a dark fantasy campaign—should be able to express and illustrate that toll through roleplaying.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 12, 'Estágio 3', 'When you reach Stage 3 of the Shadowsteel Ghoul Transformation, you gain the Stage 3 Boon and the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 13, 'Stage 3 Boon: Cursed Claw', 'You gain a Claw attack. This attack uses either your Strength or Dexterity for attack and damage rolls.

You can use this attack twice as part of an Attack action, or once as a Bonus Action. The Claw attack deals 2d6 plus your Strength or Dexterity modifier.

Additionally, when the Claw attack hits, the target must succeed on a Constitution saving throw or be afflicted with a random Shadowsteel curse at Stage 1. The saving throw DC is 8 plus your Constitution modifier plus your Proficiency Bonus. A creature already afflicted with a Shadowsteel curse cannot gain another Shadowsteel curse with this attack.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 14, 'Stage 3 Flaw: Healing Resistance', 'You heal at a slower rate than normal, whether that healing is magical or natural. Whenever you regain Hit Points, you regain half as many Hit Points as you should. You still recover all Hit Points at the end of a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 15, 'Estágio 4', 'When you reach Stage 4 of the Shadowsteel Ghoul Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 16, 'Stage 4 Boon: Shadowsteel Arcane Vessel', 'When you cast a spell using a spell slot, the power of your Shadowsteel infection emanates from you. One creature targeted by the spell within 60 feet of you has Disadvantage on the saving throw to resist the spell, or you have Advantage on the spell attack roll.

You can use this feature a number of times equal to your Proficiency Bonus, and you regain all uses after you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 17, 'Stage 4 Boon: Shadowsteel Fury', 'When you use the Attack action to attack with your Shadowsteel weapon or Cursed Claw , you can use a Bonus Action to make an additional attack with the same weapon or Claw. This extra attack carries with it the power of the Shadowsteel infection.

When you hit with this attack, the target must succeed on a Constitution saving throw or gain a 1 Exhaustion level. The saving throw DC is 8 plus the ability modifier used in the attack plus your Transformation Stage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 18, 'Stage 4 Flaw: Shadowsteel Explosion', 'The Shadowsteel that suffuses your flesh responds to stress, and you can do nothing to control it. The first time you are Bloodied or reduced to 0 Hit Points after you finish a Short or Long Rest, you risk hurting everyone around you.

When these events occur, all living creatures within 60 feet of you must succeed on a DC 20 Constitution saving throw. On a failed save, creatures in the area suffer 4d10 Force damage and have the Stunned condition until the end of their next turn. On a successful save, a target takes half damage and is not Stunned.

The power of the Shadowsteel became a part of me the first time I picked it up. It practically sang to me of magical ability beyond my understanding. If I had any idea of how true that was….') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 19, 'Estágio 9', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 1, 'Como começar', 'Methods of becoming a Specter vary, and few find their way willingly. One that dies of an unjust or violent cause may find their spirit refusing to depart, despite their physical form fading. Contact with the forces of death can drain the soul of vitality—a would-be hero is corrupted by the force they wanted to fight. Sinister rituals can also infuse a body with the powers of unmaking from the realm of the Aether Kindred .

Alongside incorporeal beings and the magic of death stand entities that exist in a reality untethered from the material world as mortals understand it. These others and their minions, manifestations of otherworldly chaos, can infuse a person with that chaos, making the victim’s ultimate home a dream of cosmic horror.

Reversing Specter Traits

Once the character reaches Stage 1 of the Specter Transformation, typical magic like Remove Curse cannot remove the affliction. You cannot be revived or restored by any magic lesser than the Wish spell due to the ties that anchor your spirit to the corporeal world.

Once you die completely and your soul departs, you may be brought back to life by more conventional magic, free of the Transformation and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 2, 'Estágio 1', 'When you initially undergo the Specter Transformation, you gain the Spectral Form Boon and one other Stage 1 Boon of your choice. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 3, 'Stage 1 Boon: Spectral Form', 'You are considered to be Undead in addition to your existing creature type(s). You cannot be excluded from Turn Undead.

Additionally, you have Resistance to Necrotic damage. If you have Resistance to Necrotic damage from another source, you have Immunity instead.

Finally, you stop aging. You are immune to any effect that would age you, and you cannot die from old age.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 4, 'Stage 1 Boon: Ghastly Touch', 'You can deliver a soul-chilling jolt through your attacks. Once per turn, when you hit a target with a melee attack when you are within 5 feet of the target, you can deal an additional 1d6 Necrotic damage.

You can use this feature a number of times equal to your Proficiency Bonus plus your Transformation Stage. You regain all uses of this feature when you finish a Short Rest or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 5, 'Stage 1 Boon: Incorporeal Movement', 'You are able to loosen the binds that tie you to the material world to move through solid objects and creatures. As a Magic action, you can make yourself incorporeal until the start of your next turn. While in this form, you gain the following benefits:

You can use this feature a number of times equal to your Proficiency Bonus, and regain all uses after finishing a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 6, 'Stage 1 Flaw: Drawn to Darkness', 'Your body and soul are bound to the cold darkness of the realms of death. You have Disadvantage on Death Saving Throws as your life force is drawn to oblivion.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 7, 'Estágio 2', 'When you reach Stage 2 of the Specter Transformation, you select one Stage 2 Boon and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 8, 'Stage 2 Boon: Ethereal Phasing', 'You can cast the Blink spell without expending a spell slot. You can cast the spell using this Boon a number of times equal to your Transformation Stage, and you regain all uses after finishing a Long Rest.

While you are under the effects of Blink when cast in this way, you also gain Temporary Hit Points equal to your Proficiency Bonus plus your Transformation Stage at the start of each of your turns.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 9, 'Stage 2 Boon: Haunting Flight', 'You gain a Fly Speed equal to your Speed.

Also, while you are flying, you can use a Bonus Action to focus your terrifying presence on one creature you can see within 30 feet. That creature must succeed on a Wisdom saving throw or have the Frightened condition for 1 minute. The DC for the Wisdom saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage. Once you use this feature, you must finish a Short or Long Rest before you can use it again.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 10, 'Stage 2 Flaw: Untethered from Life', 'Your life force is weaker than other creatures. When you would regain Hit Points, you regain half as many Hit Points as normal (rounded down).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 11, 'Estágio 3', 'When you reach Stage 3 of the Specter Transformation, you select one Stage 3 Boon and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 12, 'Stage 3 Boon: Draining Flight', 'You can now use your Incorporeal Movement feature as a Bonus Action. Additionally, your Fly Speed while using Haunting Flight becomes double your Speed.

Additionally, while you are using Incorporeal Movement, your movement does not provoke Opportunity Attacks and you can damage creatures that you move through. Once per turn, when you enter a space occupied by a creature, you can choose to force that creature to succeed on a Constitution saving throw or take 6d6 Psychic damage and have the Frightened condition until the end of your next turn. A creature takes half damage on a successful save and is not Frightened. The DC of the Constitution saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.

Once you use this feature, you must finish a Short Rest or Long Rest before you can use it again.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 13, 'Stage 3 Boon: Paralyzing Touch', 'Your Ghastly Touch feature takes on a spirit-freezing quality. The damage from your Ghastly Touch increases to 2d6 Necrotic damage. Additionally, you can force any creature you damage with Ghastly Touch to make a Constitution saving throw. The DC for this saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage.

On a failed save, the creature has the Paralyzed condition until the start of your next turn. On a successful save, they have the Prone condition instead. You can use this feature a number of times equal to your Transformation Stage. You regain all uses of this feature when you finish a Short or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 14, 'Stage 3 Flaw: Fraying Reality', 'Your mind begins to slip into the dark places where the world of life and world of death intersect. When you become Bloodied for the first time after finishing a Short or Long Rest, you must make a DC 15 Charisma saving throw. On a failed save, you act as though under the effects of a Confusion spell for 1 minute.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 15, 'Estágio 4', 'When you reach Stage 4 of the Specter Transformation, you select one Stage 4 Boon and gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 16, 'Stage 4 Boon: Call of Unmaking', 'As a Bonus Action, you can give a mournful wail or otherwise set up a wracking vibration. This sound has no effect on Constructs and Undead.

All other creatures of your choice within 30 feet of you must make a Constitution saving throw. The DC of the Constitution saving throw is 8 plus your Proficiency Bonus plus your Transformation Stage. Creatures that can’t hear you have Advantage on the saving throw.

On a failed save, the creature bears the Mark of Unmaking for 1 minute. While bearing this mark, a creature takes an additional 1d6 Necrotic damage each time it takes damage.

Once you use this feature, you can’t use it again until you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 17, 'Stage 4 Boon: Possession', 'As a Magic action, you enter the space of a Humanoid or Beast and force that creature to make a DC 15 Charisma saving throw. If the target fails, you disappear, and the target is Incapacitated and loses control of its body. You control the body without depriving the target of awareness.

While possessing a target, you can’t be targeted by any attack, spell, or other effect. You retain your alignment, Intelligence, Wisdom, Charisma, and any immunity to having the Charmed and Frightened conditions. Otherwise, you use the possessed target’s statistics but don’t gain access to the target’s knowledge, spellcasting abilities or Magic actions, class features, or proficiencies.

The possession lasts for 1 hour, until the possessed target drops to 0 Hit Points, you end it as a Bonus Action, or you are forced out by an effect that ends possession. When the possession ends, you reappear in an unoccupied space within 5 feet of the possessed creature. Once you use this feature, you can’t use it again until you finish a Short Rest or Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 18, 'Stage 4 Flaw: Pull of Oblivion', 'Your connection to the material realm becomes gossamer thin. When you roll a natural 1 on a D20 Test , you take 4d6 Force damage, and this damage cannot be mitigated. If this damage reduces you to 0 Hit Points, you die.

When you die in this way or any other, you can only be brought back to life through magic equivalent to level 7 or higher spells.

He faded away as quickly as he appeared. From his expression, it looked like he was being dragged away.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 19, 'Estágio 10', 'To move from one stage to the next higher one in this Transformation, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformation:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 1, 'Como começar', 'Vampires are spawned into the world when a mortal contracts the Sanguine Curse, dies, and is reborn undead. There are a variety of ways to contract the curse. A Vampire may have offered their blood to a loyal servant, powerful ally, or loved one they wished to elevate. More commonly, a Vampire may bite a victim, who survives the attack long enough to contract the Sanguine Curse before perishing and being reborn.

Other methods of becoming a Vampire include ancient and dark magic, as well as powerful but cursed magical artifacts. Vampirism may be passed along when an ancient Vampire allows a beloved plaything to drink blood from the Undead creature’s cursed veins. Regardless of how you have become a Vampire, you should discuss with your GM what type of Vampire you might become and how it can be implemented in the campaign.

Curing Vampirism

Once the character reaches Stage 1 of the Vampire Transformation, no typical magic like Remove Curse can remove the affliction. Magic on the level of the Wish spell is needed to completely remove the Transformation and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 2, 'Estágio 1', 'When you initially contract vampirism, you gain the Fanged Bite Boon and one other Stage 1 Boon. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 3, 'Stage 1 Boon: Fanged Bite', 'As an Attack action, you can make a Bite attack. You are considered proficient with this attack, and you can use Strength or Dexterity as the ability. This attack deals Piercing damage equal to 1d6 plus your Strength or Dexterity modifier. This Bite attack is not a weapon or an Unarmed Strike .

If the attack hits a creature that has blood, the target must succeed on a Constitution saving throw or take an additional 1d6 Necrotic damage. You regain Hit Points equal to the Necrotic damage dealt this way. The DC is 8 plus your Proficiency Bonus plus your Transformation Stage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 4, 'Stage 1 Boon: Soman Bloodline', 'Your vampirism follows the Soman bloodline, the most prevalent in Etharis. You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 5, 'Stage 1 Boon: Fzeg Bloodline', 'Your vampirism follows the Fzeg bloodline, a line of vampires that combines the affliction with lycanthropy. You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 6, 'Stage 1 Boon: Strigoi Bloodline', 'Your vampirism follows the Strigoi bloodline. Your speed and guile almost match your ferocity. You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 7, 'Stage 1 Flaw: The Sanguine Curse', 'The Sanguine Curse has taken hold of you. As a result, you gain the following features:

Feeding

As a Vampire transforms further and further from its mortal form, its metabolic requirements change. The first change is a need for mortal blood. This need is approximately 1 pint of blood from a Humanoid, Beast, or other creature with mortal blood.

As an action, you can bite a living creature within 5 feet that is Charmed by you, or that has the Incapacitated, Paralyzed, Restrained, or Unconscious condition. You drain the target of one pint of blood (or similar life-giving substance), leaving a visible bite mark on that creature. The bitten creature gains one Exhaustion level.

A Vampire that does not feed within the required time enters a rabid feeding frenzy under the GM’s control. They attack the nearest creature they could feed from. A Vampire remains in this state until they have drained a creature completely (killing them), at which point the Vampire falls unconscious for 4 hours.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 8, 'Estágio 2', 'When you reach Stage 2 of vampirism, you select two Stage 2 Boons and gain the Stage 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 9, 'Stage 2 Boon: Eyes of the Night', 'You gain Darkvision out to 60 feet. If you already have Darkvision, the range increases by 60 feet.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 10, 'Stage 2 Boon: Grave-Touched Soul', 'You gain Resistance to Necrotic damage. If you already have Resistance to Necrotic damage, you gain Immunity instead.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 11, 'Stage 2 Boon: Inhuman Reflexes', 'You have Advantage on Dexterity saving throws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 12, 'Stage 2 Boon: Undead Resilience', 'You become supernaturally tough to kill. When you are reduced to 0 Hit Points by any type of damage except Radiant, you can choose to be reduced to 1 Hit Point instead. Once you use this feature, you cannot use it again until you finish a Long Rest.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 13, 'Stage 2 Flaw: Greater Sanguine Curse', 'Your curse has taken a stronger hold onto you. You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 14, 'Estágio 3', 'When you reach Stage 3 of vampirism, you select two Stage 3 Boons and gain the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 15, 'Stage 3 Boon: Beguiler’s Charm', 'You gain the ability to manipulate the mind of a creature with your unearthly charm. As a Magic action, you can choose a Humanoid or Beast within 30 feet of you that can see you. The creature must succeed on a Charisma saving throw with a DC of 8 plus your Charisma modifier plus your Proficiency Bonus.

On a failed save, the creature has the Charmed condition for 24 hours. At the end of the 24 hours, you can choose to automatically renew the Charmed condition on that creature with no saving throw. You may only have one creature Charmed in this manner at a time. If you use this feature on another creature, or you or an ally damages the creature, the Charmed condition ends on the previous creature immediately.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 16, 'Stage 3 Boon: Improved Fanged Bite', 'As an Attack action, you can make 2 Fanged Bite attacks. Additionally, you can make a Fanged Bite attack as a Bonus Action if you don''t make a Fanged Bite attack as part of an Attack action on the same turn.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 17, 'Stage 3 Boon: Mist Form', 'You can cast the Gaseous Form spell a number of times equal to your Vampire Transformation Stage without using a spell slot or needing to use Verbal, Somatic, or Material components. You regain all uses of this feature when you finish a Long Rest.

You can cast this spell as an Action on your turn, or as a Reaction when you would take Bludgeoning, Piercing, or Slashing damage. You cast the spell before taking the damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 18, 'Stage 3 Boon: Sangromancy Specialist', 'Your magic is tinged with the blood that you crave. You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 19, 'Stage 3 Flaw: Supreme Sanguine Curse', 'Your curse continues to transform you, bringing about further debilitations. You gain the following features:

You can hide your true appearance and disguise yourself as the humanoid you once were by concentrating on your composure. However, moments of bloodlust or stress are likely to reveal your true nature, including the following situations:

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constitution saving throw with a DC based on your current Transformation Stage. If you fail this save, your Sanguine Curse is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 20, 'Estágio 4', 'When you reach Stage 4 of vampirism, you gain the Regeneration Boon and one other Stage 4 Boon of your choice. You also gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 21, 'Stage 4 Boon: Final Soman Bloodline', 'You reach the full manifestation of your Soman Bloodline. You gain the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 22, 'Stage 4 Boon: Final Fzeg Bloodline', 'You reach the full manifestation of your Fzeg Bloodline. You have the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 23, 'Stage 4 Boon: Final Strigoi Bloodline', 'You reach the full manifestation of your Strigoi Bloodline. You have the following features:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 24, 'Stage 4 Boon: Regeneration', 'The vampiric blood that flows in your veins gives you regenerative powers. You regain 15 Hit Points at the start of your turn if you have at least 1 Hit Point but less than 60 Hit Points. This feature has no effect if you are in sunlight or have taken Radiant damage since the end of your last turn.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 25, 'Stage 4 Flaw: Ultimate Sanguine Curse', 'Your transformation into a creature of the night is complete. And with that transformation comes susceptibilities. You gain the following features:

//') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
