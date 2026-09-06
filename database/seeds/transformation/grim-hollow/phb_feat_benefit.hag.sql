-- J051 — Bruxa (gh-transformation-hag)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 1, 'Como começar', 'Few creatures are born Hags. Humanoideees can become a Hag como result of a ritual or a curse. Sometimes the offspring of a cursed individual becomes a Hag after reaching the age of maturity. Hags have ways of spawning fully mature Hags, but only the most depraved individuals would consider that any sort of birth.

Other Fey creatures see Hags as pitiful, revolting creatures who can never enjoy the blessing of an existence in the Realm of Faerie, so cursing a mortal to become a Hag is a particularly harsh consequence for angering a Fey. Hags themselves are fond of creating other Hags to join them and form a coven.

Very few people are twisted enough to seek to transform themselves into a Hag. The power it provides is not worth the pain and anguish that comes with it. Yet that power is attractive to some, who seek out the rituals to make the change or entreat Hags to twist them como parte de uma bargain.

Reverter traços de Hag

The Hag Transformação is one of the few that can be reversed, especially when it is bestowed via a curse rather than sought, but only in its first two stages. Once the creature travels too far down the path of maddening power, the grip has become too strong.

Reversing the Transformação, even in its early stages, is an elaborate process that may take months or years, and often only with the assistance of a benevolent fey creature willing to donate some of their magic to the process.

The last step of the reversal process requires a powerful Fey creature to participate in a ritual to remove all remnants of the transformative magic. As with most Fey, this participation almost always comes at a steep cost.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Hag pela primeira vez, ganha a Bênção Hag Form e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 3, 'Bênção do estágio 1: Hag Form', 'Your Creature Type becomes Fey in addition to any other creature type(s) you have.

Além disso, your connection with the magic of the natural world provides you with increased defenses. Quando você are not wearing armor, your Armor Class is 13 mais seu modificador de Destreza. Além disso, choose Força, Inteligência, or Carisma: you are proficient with Salvaguardas using that ability score.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 4, 'Bênção do estágio 1: The Green Sisterhood', 'Green Hags are skilled deceivers who collect corrupting magic and secret curses. They use their magic to twist pure into foul, poking at the weaknesses of their foes. Green Hags embrace magical deceptions and are known for their vile recipes. There are no worse cooks in Etharis.

• Você tem Darkvision with a range of 18 m. Se você already have Darkvision, its range increases by 18 m.

• You become Amphibious and can breathe both air and water.

• Você pode mimic animal sounds and humanoid voices. A creature that hears the sounds can tell they are imitations with a Study action and a successful Sabedoria ( Intuição ) check with a CD igual a 8 mais seu modificador de Carisma mais seu Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 5, 'Bênção do estágio 1: The Red Sisterhood', 'Red Hags are sometimes called the “nice” hags due to their ability to pretend to be helpful, but their kindness is a mask. While they are more subtle than other Hags and may choose to do good deeds, their motives are selfish. They delight in using honeyed words and offering deals that are just too good to pass up.

• Você tem Darkvision with a range of 18 m.

• Você ganha proficiency in Enganação and Persuasão . Se você are already proficient, you gain Especialização instead.

• Você é immutable. No effect can change your form, and an illusion can disguise you only if the illusion gives you the Invisible condition.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 6, 'Bênção do estágio 1: The Sea Sisterhood', 'Sea Hags enjoy spreading chaos. They hate order and calm, creating elaborate deceptions that lead to despair when uncovered. Their appearances are especially hideous, and their gaze can cause fear, or even kill. Você ganha os seguintes benefícios.

• Você tem Darkvision with a range of 18 m.

• You become Amphibious and can breathe both air and water. Você ganha um Swim Speed igual a your Speed. Se você already have a Swim Speed, it increases by 3 m.

• Como ação Mágica, você pode gaze upon a creature você pode see within 9 m. If the creature fails a Sabedoria salvaguarda with a CD igual a 8 mais seu modificador de Carisma mais seu Estágio de Transformação, it takes 1d8 dano Psíquico for each Estágio de Transformação you have.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 7, 'Falha do estágio 1: Hideous Appearance', 'Your appearance is grotesquely transformed. Your body, hair, and eyes change in ways mortals find abhorrent. Most creatures witnessing your true form become Hostil and no one is likely to trust you, unless o Mestre decides otherwise. Você tem Desvantagem em Carisma ( Persuasão ) checks.

Você podenot stand to look upon your own reflection. The first time you see your reflection after a Descanso Curto or Descanso Longo, you must succeed on a CD 18 Sabedoria salvaguarda or gain 1 nível de Exaustão.

Your appearance changes based on your Stage 1 Sisterhood Boon:

Green Sisterhood. You wither or bloat as your body struggles to deal with the ravages of age. Your hair becomes white and several feet in length. Your skin becomes green and covered in warts and boils.

Red Sisterhood. Your eyes have turned entirely red, e seu pupils are narrow like a cat’s. Your skin becomes blood red.

Sea Sisterhood. Você tem slimy scales and the pallid skin of a dead fish that sags from your emaciated body. Your hair resembles seaweed, e seu eyes are glassy.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 8, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Hag, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 9, 'Bênção do estágio 2: Adept of the Green Sisterhood', 'As your connection to your Green Sisterhood grows, your body e seu magical skills strengthen.

• Você ganha um Claw attack that deals 1d6 mais seu Força or modificador de Destreza Cortante Damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• Você pode hide yourself from others. Como ação Mágica, você pode cast Invisibility without expending a espaço de magia. Você pode usar este recurso um número de times igual a your Estágio de Transformação. You regain all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 10, 'Bênção do estágio 2: Adept of the Red Sisterhood', 'As your connection to your Red Sisterhood grows, your body e seu magical skills strengthen.

• Você ganha um Claw attack that deals 1d6 mais seu Força or modificador de Destreza Cortante Damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• Você pode sway others to your will. Como ação Mágica, você pode cast Charm Person without expending a espaço de magia. The spell save CD when cast in this way is 12 mais seu Estágio de Transformação. Você pode usar este recurso um número de times igual a your Estágio de Transformação. You regain all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 11, 'Bênção do estágio 2: Adept of the Sea Sisterhood', 'As your connection to your Sea Sisterhood grows, your body e seu magical skills strengthen.

• Você ganha um Claw attack that deals 1d6 mais seu Força or modificador de Destreza Cortante Damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• Você pode appear as someone other than yourself. Como ação Mágica, você pode cast Disguise Self without expending a espaço de magia. The spell save CD when cast in this way is 12 mais seu Estágio de Transformação. Você pode usar este recurso um número de times igual a your Estágio de Transformação. You regain all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 12, 'Falha do estágio 2: Iron Sensitivity', 'Your body and soul connect back to the Realm of Faerie, and iron and steel weapons forged of the mortal realm cause you pain. After each Short or Descanso Longo, the first time you are damaged by an iron or steel weapon, you must succeed on a CD 15 Constituição salvaguarda or have the Stunned condition até o fim do seu próximo turno.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 13, 'Estágio 3', 'To move from one stage to the next higher one in this Transformação, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformação:

• Striking a bargain with a powerful Hag

• Cursing or killing an innocent being under the new moon

• Drinking a poisonous draught from a dead Hag’s cauldron

• Becoming the victim of multiple curses at the same time

• Consuming the flesh of the innocent

• Crafting a Hag’s Eye or creating a Gasdra

Small Monstrosity, Neutral Evil

AC 13 Initiative +4 (14)

HP 22 (4d6 + 8)

Speed 9 m, Fly 12 m

Ability | Score | Mod | Save
STR | 8 | -1 | -1
DEX | 15 | +2 | +2
CON | 15 | +2 | +2

Ability | Score | Mod | Save
INT | 6 | -2 | -2
WIS | 10 | +0 | +0
CHA | 7 | -2 | -2

Skills Percepção +2

Senses Darkvision 18 m; Passive Percepção 12

Languages Understands Sylvan but can’t speak

Challenge 1 (XP 200; PB +2)

Traits

Three Heads. The gasdra has Vantagem on Sabedoria ( Percepção ) checks and on salvaguardas to avoid or end the Blinded , Charmed , Deafened , Amedrontado , Stunned , or Unconscious conditions. The gasdra can take one Reação for each of its heads. The extra Reaçãos can be used only for Ataque de Oportunidades .

Wakeful. While the gasdra sleeps, at least one of its heads is awake.

Açãos

Multiattack. The gasdra makes three Beak attacks.

Beak. Melee Attack Roll: +4, reach 1,5 m Hit: 5 (1d6 + 2) Contundente damage.

Quando você alcança o estágio 3 da Transformação em Hag, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 14, 'Bênção do estágio 3: Master of the Green Sisterhood', 'You come into your power como Hag and enhance your abilities.

• Quando você realiza the ação Atacar no seu turno, you may make an additional Claw attack. Your Claw attacks deal an additional 1d6 dano de Veneno.

• Você aprende a corrupt ritual to create a Hag Eye or a Gasdra companion. The ritual takes four hours and 200 PO to complete. You choose which ritual você conhece when you select this boon. Você pode only have one Hag Eye or Gasdra companion at a time, and você podenot have both.

• Como ação Mágica, você pode recover an expended espaço de magia by spending Dados de Vida igual a the espaço de magia’s level. The espaço de magia can have a level igual a no more than one third your character level (round up). Depois de usar this boon, você pode’t do so again until you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 15, 'Bênção do estágio 3: Master of the Red Sisterhood', 'You come into your power como Hag and enhance your abilities.

• Quando você realiza the ação Atacar no seu turno, you may make an additional Claw attack. Your Claw attacks deal an additional 1d4 dano Psíquico. You regain Pontos de Vida igual a the dano Psíquico dealt.

• Your banter becomes supernaturally charming. A creature under your magical influence (such as being Charmed by you) who is able to hear you por 1 minuto must must make a Carisma salvaguarda with a CD igual a 14 mais seu Estágio de Transformação. On a failed save, when your mental influence ends, the target forgets magic was used to influence it. You regain use of este recurso after you finish a Short or Descanso Longo.

• Como Bonus action, você pode expend a Dado de Vida to cast the Charm Person spell.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 16, 'Bênção do estágio 3: Master of the Sea Sisterhood', 'You come into your power como Hag and enhance your abilities.

• Quando você realiza the ação Atacar no seu turno, you may make an additional Claw attack. Your Claw attacks deal an additional 1d6 Cortante damage.

• Your appearance becomes so vile that it terrifies mortal creatures. Como Ação Bônus, you gaze upon a Beast or Humanoidee within 9 m that can see your true form. The creature must succeed on a Sabedoria salvaguarda with a CD igual a 14 mais seu modificador de Carisma. On a failed save, the target has the condição Amedrontado until the start of its next turn. A target that succeeds is immune to este recurso por 24 horas. You regain use of este recurso after you finish a Short or Descanso Longo.

• Como ação Mágica, você pode expend and roll a Dado de Vida to touch a creature and allow the target to breathe water for um número de minutes igual a the amount rolled.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 17, 'Falha do estágio 3: Purity’s Pain', 'Unspoiled, pure things cause you physical pain to witness. A child hugging their parent, a loyal dog laying its head upon a sick man’s lap, a work of religious art devoted to an Arch Seraph, a baby’s laughter: these things make you physically ill.

Quando você are in the presence of a pure act or object (GM’s discretion) you are wracked with pain. No início de each of your turns while você pode see the cause of your pain, you suffer 3d6 mais seu modificador de Carisma dano Psíquico, and cannot use a Hag Transformação boons until the start of your next turn. The first time you take dano Psíquico from this flaw after finishing a Short or Descanso Longo, you must make a CD 18 Sabedoria salvaguarda. Se você fail, you have the condição Amedrontado as long as você pode see the source of your pain.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 18, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Hag, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 19, 'Bênção do estágio 4: Evil Eye', 'Your visage is so horrifying that você pode cause creatures to drop dead when your gaze falls upon them. Como ação Mágica, you gaze upon a Ferido Beast or Humanoidee within 9 m that can see your true form. The creature must succeed on a Sabedoria salvaguarda with a CD igual a 14 mais seu modificador de Carisma. If the target fails the save, it drops to 0 Pontos de Vida. On a successful save, the creature takes 6d8 dano Psíquico. You regain the use of este recurso when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 20, 'Bênção do estágio 4: Grandmother’s Curse', 'Você aprende um maldição de Shadowsteel de sua escolha. You always have it prepared, and it doesn’t count against the number of spells você pode prepare each day. Você pode conjurar it once per day without using a espaço de magia or needing spell components.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 21, 'Falha do estágio 4: Arch-Crone’s Hunger', 'You develop a taste for strange, cursed, or vile foods, and normal food no longer nourishes you. Você deve consume one of these unusual foods at least once every day or you gain 1 nível de Exaustão, which cannot be removed until you feed your vile hunger. Se você are forced to eat or drink normal food, you must succeed on a CD 18 Constituição salvaguarda or vomit it up and gain 1 nível de Exaustão.

Examples of vile foods include o seguinte:

• The flesh of sapient creatures (Humanoideees, Fey, or Celestiais)

• Magical ingredients (rare herbs, dragon’s blood, etc.)

• The pain and suffering of others

• Pages of a cursed tome') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 22, 'Apêndice: 3aaa476f-ab1d-4fa7-b7ce-c38731c0f866', 'Ability | Score | Mod | Save
STR | 8 | -1 | -1
DEX | 15 | +2 | +2
CON | 15 | +2 | +2') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 23, 'Apêndice: 68b9ceac-a2cb-40b7-baaf-d1c4ef9d562d', 'Ability | Score | Mod | Save
INT | 6 | -2 | -2
WIS | 10 | +0 | +0
CHA | 7 | -2 | -2') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-hag'), 24, 'Apêndice: Reverter traços de Hag', 'Reverter traços de Hag

The Hag Transformação is one of the few that can be reversed, especially when it is bestowed via a curse rather than sought, but only in its first two stages. Once the creature travels too far down the path of maddening power, the grip has become too strong.

Reversing the Transformação, even in its early stages, is an elaborate process that may take months or years, and often only with the assistance of a benevolent fey creature willing to donate some of their magic to the process.

The last step of the reversal process requires a powerful Fey creature to participate in a ritual to remove all remnants of the transformative magic. As with most Fey, this participation almost always comes at a steep cost.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
