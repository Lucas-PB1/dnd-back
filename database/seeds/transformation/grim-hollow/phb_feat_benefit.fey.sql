-- J049 — Fada (gh-transformation-fey)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 1, 'Como começar', 'Becoming a Fey requires a direct connection to the Realm of Faerie. Many mortals who become Fey are stolen from the mortal realm as children. These children, known as changelings, transform rapidly after a few days trapped in the Realm of Faerie. A changeling’s transition is often painful or strange, for a child altered in this way does not have a say in what type of Fey creature they ultimately become.

Others might be born mortal but have the taint of Fey blood coursing through their veins. As they mature, their Fey features slowly manifest. More than a few innocent folks quickly learn of their Fey destinies immediately after a joyous birthday celebration.

A creature who voluntarily seeks to become a Fey can strike a deal with a Fey or beseech the court of a Faerie Queen. These pathways to transformation are as dangerous as the Realm of Faerie itself, and it requires a quick wit and sharp awareness to get the best of Feykind.

Reverter traços de Fey

The hold of the Fey over a mortal being is strong, but it’s even stronger when the mortal begins to show signs of Fey heritage. The rituals to reverse the Fey Transformação are dangerous and rarely successful.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 2, 'Estágio 1', 'To move from one stage to the next higher one in this Transformação, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformação:

• Striking a bargain with a greater Fey creature

• Performing a great deed in the name of a Fey Queen

• Establishing a new faerie ring or bridge to the Realm of Faerie

• Defeating a powerful agent from your rival Fey Court

• Earning a domain or title in the Realm of Faerie

• Being born with Fey blood that starts manifesting Fey traits on the day of maturation

Quando você passa pela Transformação em Fey pela primeira vez, ganha a Bênção Fey Form e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 3, 'Bênção do estágio 1: Fey Form', 'Your creature type becomes Fey in addition to any other creature type(s) you have.

Also, after you finish a Descanso Longo, pick a damage type from o seguinte list: Acid, Cold, Fire, Lightning, Psychic, or Thunder. Você ganha Resistência to that damage type until you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 4, 'Bênção do estágio 1: Servant of the Spring Court', 'The Spring Court embodies carnal desires, rebirth, and the planting and sowing season. The Fey creatures of Spring tend to be capricious, unreliable, and quick to flare their emotions. This is the court most associated with satyrs and nymphs. Creatures of the Spring Court hide savage intentions and uncontrollable urges behind gentle words.

Como Ação Bônus, você pode magically teleport up to 9 m to an unoccupied space você pode see. One creature de sua escolha que você possa ver within 1,5 m of your starting or ending space takes 1d6 dano Trovejante. Você pode usar this ability um número de times igual a seu Bônus de Proficiência, and você recupera all uses when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 5, 'Bênção do estágio 1: Servant of the Summer Court', 'The Summer Court embodies the lush warmth and manic celebration of the growing season. The Fey creatures of Summer tend toward joviality, excess, and vanity. This is the court most associated with dryads and pixies. Creatures of the Summer Court often hide their narcissism and cruelty behind beautiful façades.

Como Ação Bônus, você pode magically teleport up to 9 m to an unoccupied space você pode see. One creature de sua escolha que você possa ver within 1,5 m of your starting or ending space takes 1d6 dano de Fogo. Você pode usar this ability um número de times igual a seu Bônus de Proficiência, and você recupera all uses when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 6, 'Bênção do estágio 1: Servant of the Autumn Court', 'The Autumn Court embodies the careful scheming and approaching rot of the harvesting season. The Fey creatures of Autumn tend to be devious, scheming, and full of secrets. This is the court most associated with treants and other plant fey. Creatures of the Autumn Court often appear beautiful and helpful, but in truth their forms are hideous and methods vile.

Como Ação Bônus, você pode magically teleport up to 9 m to an unoccupied space você pode see. One creature de sua escolha que você possa ver within 1,5 m of your starting or ending space takes 1d6 dano de Veneno. Você pode usar this ability um número de times igual a seu Bônus de Proficiência, and você recupera all uses when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 7, 'Bênção do estágio 1: Servant of the Winter Court', 'The winter court embodies the stillness, darkness, and death of the coldest season. The Fey creatures of Winter tend to be serious, cruel, and reflective. Creatures of the Winter Court are often terrifying to behold and very direct about their intentions.

Como Ação Bônus, você pode magically teleport up to 9 m to an unoccupied space você pode see. One creature de sua escolha que você possa ver within 1,5 m of your starting or ending space takes 1d6 dano Gélido. Você pode usar this ability um número de times igual a seu Bônus de Proficiência, and você recupera all uses when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 8, 'Falha do estágio 1: Planar Binding', 'Your body and soul have been saturated with the magical energy of the Realm of Faerie. Rather than inuring you to the essence of magic, it has made you more susceptible. After finishing a Short or Descanso Longo, you have Desvantagem on the first salvaguarda you make against a spell originating from an enemy.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 9, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Fey, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 10, 'Bênção do estágio 2: Two-Faced', 'Você pode transform your face into a vision of enchantment or horror that affects creatures around you, based on the Fey Court you serve. Como ação Mágica, you take on this visage. Creatures within 9 m who can see you must succeed on a Carisma salvaguarda with a CD igual a 8 mais seu modificador de Carisma mais seu Estágio de Transformação or be affected por 1 minuto.

Você pode do this um número de times igual a seu Bônus de Proficiência, and você recupera all uses after finishing a Descanso Longo.

Spring. Any creature that fails the salvaguarda has the Stunned condition. The creature can attempt a Constituição salvaguarda at the end of each of their turns to end the condition. This effect ends early on a creature se você or an ally deal damage to it or take other harmful actions.

Summer. Any creature that fails the salvaguarda gains the Charmed condition. This effect ends early on a creature se você or an ally deal damage to it or take other harmful actions.

Autumn. Any creature that fails the salvaguarda gains the condição Envenenado. The creature can attempt a Constituição salvaguarda at the end of each of their turns to end the condition.

Winter. Any creature that fails the salvaguarda becomes Amedrontado of you. This effect ends early if a creature affected by this ability ends its turn out of your line of sight.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 11, 'Bênção do estágio 2: Magic Tricks', 'Your Fey masters provide you with the ability to weave magic based on your Fey Court allegiance. Você ganha a capacidade de cast one cantrip, one level 1 spell, and one level 2 spell. Você pode conjurar each of these once without using a espaço de magia or needing spell components. You regain the ability to cast these spells when you finish a Descanso Longo. The CD for these spells is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

Spring. Your cantrip is Poison Spray , e seu spells are Fog Cloud and Misty Step .

Summer. Your cantrip is Fire Bolt , e seu spells are Burning Hands and Flame Blade .

Autumn. Your cantrip is Shillelagh , e seu spells are Thunderwave and Ray of Enfeeblement .

Winter. Your cantrip is Ray of Frost , e seu spells are Ice Knife and Darkness .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 12, 'Falha do estágio 2: Queen’s Command', 'The Fey court lends you its power, and in exchange you must pay regular tribute to maintain your freedom. Twice a year, at times relevant to the Fey Court that you serve—such as the solstices or the equinoxes—you must deliver a treasure or other significant tribute to your ruling Fey Queen.

Se vocêr queen considers the tribute lacking, you are immediately notified of your failure and are given detailed instructions on how to atone. Você tem Desvantagem em all Teste D20s until you rectify the situation. Se você do not satisfy your queen’s demand in one week’s time, your queen transports you immediately to her Fey Court, where you must answer for your insolence. Once transported in this way, you must remain in the Realm of Faerie for 100 years, or until you strike a bargain with your queen to let you return to the Material Plane.

Seu Mestre will tell you what constitutes an appropriate tribute to the court. Some Fey Queens prefer magic items while others wish for long-kept secrets, the capture of Fey criminals, or Humanoidee servants.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 13, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Fey, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 14, 'Bênção do estágio 3: Illusionary Cloak', 'Você pode usar a ação Mágica to wrap yourself in an illusionary cloak for up to 1 hour. During this time, você pode make yourself look like another creature of your general size and humanoid shape. This illusion ends when you use a Ação Bônus to end it, or se você die or gain the Unconscious condition.

A creature can pierce the illusion by taking the Study action and succeeding on a CD 20 Inteligência ( Investigação ) check, thus seeing your true form.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 15, 'Bênção do estágio 3: Tooth and Claw', 'Você pode manifest fangs, tusks, claws, or other means of harming your enemies. These manifestations also deliver a powerful magic jolt.

Como Ação Bônus, you manifest some natural defense mechanism por 1 minuto. This gives you o seguinte benefits:

• You manifest a Claw, Bite, or Gore attack that you may use in place of any weapon attack. This manifested attack deals 1d6 mais seu Força or modificador de Destreza Cortante damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• After taking an ação Atacar that did not use your manifested attack, you may take a Ação Bônus later in that turn to use your manifested attack once.

• Uma vez por rodada, when you hit a target with a manifested attack, você pode choose to deal an additional 2d6 dano Psíquico to the target. The creature must succeed on a Constituição salvaguarda or have the Stunned condition até o fim de its next turn. The CD is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

Você pode usar this ability um número de times igual a seu Bônus de Proficiência mais seu Estágio de Transformação. You regain all uses of this ability after completing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 16, 'Bênção do estágio 3: Dreams and Nightmares', 'Você ganha a capacidade de manipulate the mind of mortal beings. Como Ação Bônus, choose a Humanoidee você pode see within 9 m of you. That creature must succeed on a Sabedoria salvaguarda. The CD is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

On a failed salvaguarda, the creature has the Paralyzed condition, as it is stuck in a blissful dream or a terrifying nightmare. The condition lasts por 1 minuto. The target can attempt the Constituição salvaguarda at the end of each of its turns and each time it takes damage.

Você pode escolher to concentrate on the effect as you would a spell. Se você are concentrating on the effect when the target attempts its salvaguarda, the target has Desvantagem on the salvaguarda.

Você pode usar this ability um número de times igual a seu Bônus de Proficiência, and você recupera all uses of this ability when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 17, 'Falha do estágio 3: Weakened Constitution', 'Your connection to the Fey Courts has granted you tremendous power but also an inherent fragility. Quando você become Ferido for the first time after you roll Initiative, you must succeed on a CD 20 Constituição salvaguarda. On a failed save, you gain a level of Exhaustion .

Como ação Mágica, você pode expend um número de Dados de Vida igual a your Estágio de Transformação to remove one level of Exhaustion gained in this manner. Você ganha no other benefit from those expended Dados de Vida.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 18, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Fey, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 19, 'Bênção do estágio 4: Greater Magic Tricks', 'Your Fey masters provide even further magical abilities. Você ganha a capacidade de cast one level 3 spell, one level 4 spell, and one level 5 spell. Você pode conjurar each of these once without using a espaço de magia or needing spell components. You regain the ability to cast these spells when you finish a Descanso Longo. The CD for these spells is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

Spring. Your spells are Stinking Cloud , Vitriolic Sphere , and Cloudkill .

Summer. Your spells are Fireball , Fire Escudo , and Dream .

Autumn. Your spells are Lightning Bolt , Blight , and Hold Monster .

Winter. Your spells are Vampiric Touch , Ice Storm , and Cone of Cold .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 20, 'Bênção do estágio 4: Twilight Glamour', 'Como ação Mágica, you gain the Invisible condition por 1 hora or until you end it como Ação Bônus. Se você make uma jogada de ataque, deal damage, or cast a spell that causes the target to make a salvaguarda, the remaining duration changes to 1 minute.

Você pode usar this ability twice, and você recupera all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 21, 'Falha do estágio 4: Seasonally Affected', 'Your connection to the Realm of Fey hcomo stronger pull on you. Você tem Desvantagem em Death Salvaguardas as the Fey Court attempts to claim your soul as their own.

Além disso, you gain Vulnerability to a certain damage type based on the Fey Court that you are pledged to. Você podenot benefit from Resistência or Imunidade to that damage.

Spring. Você é Vulnerable to dano Necrótico.

Summer. Você é Vulnerable to dano Gélido.

Autumn. Você é Vulnerable to dano Radiante.

Winter. Você é Vulnerable to dano de Fogo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-fey'), 22, 'Apêndice: Reverter traços de Fey', 'Reverter traços de Fey

The hold of the Fey over a mortal being is strong, but it’s even stronger when the mortal begins to show signs of Fey heritage. The rituals to reverse the Fey Transformação are dangerous and rarely successful.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
