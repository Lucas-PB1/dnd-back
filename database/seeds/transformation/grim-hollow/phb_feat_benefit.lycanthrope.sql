-- J053 — Licantropo (gh-transformation-lycanthrope)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 1, 'Como começar', 'In Etharis, there are two well-known methods of contracting the lycanthropic curse. The first is being bitten by a lycanthrope and not curing the curse before it takes hold.

The second is to complete a Druidic ritual known as the Lunar Sacrament. This violent and bloody rite, involving the sacrifice of an innocent person, underscores the ruthless and uncompromising nature of someone willing to do evil in exchange for power.

Other means of gaining lycanthropy are possible. The curse of a powerful being, a side effect of a powerful artifact, or eating the raw flesh of a lycanthropic creature: all of these are potential triggers for the Lycanthrope Transformação.

Uma vez vocêr character has become a Lycanthrope, consider how they feel about the curse. Do they wish to cure it before it progresses too far? Do they wish to understand it and make peace with the beast that resides within?

Curing Lycanthropy

Once the character reaches Stage 1 of the Lycanthrope Transformação, no typical magic like Remove Curse can cure the character’s lycanthropy. Magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 2, 'Estágio 1', 'Quando você contrai lycanthropy, você escolhe uma Bênção do estágio 1 Boon e ganha a Falha do estágio 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 3, 'Bênção do estágio 1: Hybrid Wolf Form', 'You become a Monstrosity in addition to any other creature type(s).

Como ação Mágica, you may voluntarily transform into a hybrid half-wolf creature. While in your hybrid wolf form, o seguinte rules apply:

• Your Força score becomes 18 unless it is higher.

• Your Speed increases by 3 m, and você pode use the Dash action como Ação Bônus.

• Você pode’t cast spells or concentrate on spells. Your ability to speak is reduced to short, basic, guttural responses.

• While transformed, você pode use weapons and equipment as normal, unless specified elsewhere.

• Você ganha um Claw or Bite attack that you may use in place of any weapon attack. These attacks deal 1d8 mais seu Força or modificador de Destreza Cortante damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• After taking an ação Atacar, you may take a Ação Bônus later in that turn to attack once with either your Claw or Bite.

Your hybrid wolf form lasts 1 hour per Estágio de Transformação. Se você entered your hybrid form voluntarily, você pode revert to your normal form by using a ação Mágica no seu turno. (Flaws listed below may override this rule.)') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 4, 'Bênção do estágio 1: Hybrid Bear Form', 'You become a Monstrosity in addition to any other creature type(s).

Como ação Mágica, you may voluntarily transform into a hybrid half-bear creature. While in your hybrid bear form, o seguinte rules apply:

• Your Força score becomes 20 unless it was higher.

• Você ganha um Climb Speed igual a your Speed.

• Você pode’t cast spells or concentrate on spells. Your ability to speak is reduced to short, basic, guttural responses.

• While transformed, você pode use weapons and equipment as normal, unless specified elsewhere.

• Você ganha um Claw attack that you may use in place of any weapon attack. This attack deals 1d8 mais seu Força or modificador de Destreza Cortante damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• Immediately after hitting a target with a Claw attack, você pode take a Ação Bônus to grab the creature with that hand, as long as it is no more than one size category larger than you. The grabbed target has the condição Agarrado. The escape CD is 8 mais seu modificador de Força mais seu Bônus de Proficiência.

Your hybrid bear form lasts 1 hour per Estágio de Transformação. Se você entered your hybrid form voluntarily, você pode revert to your normal form by using a ação Mágica no seu turno. (Flaws listed below may override this rule.)') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 5, 'Bênção do estágio 1: Hybrid Rat Form', 'You become a Monstrosity in addition to any other creature type(s).

Como ação Mágica, you may voluntarily transform into a hybrid half-rat creature. While in your hybrid rat form, o seguinte rules apply:

• Your Destreza score becomes 18 unless it was higher.

• Você pode Hide or Desengajar como Ação Bônus.

• Você ganha proficiência com Furtividade , and você pode double seu Bônus de Proficiência when making a Destreza (Furtividade) check.

• Você pode’t cast spells or concentrate on spells. Your ability to speak is reduced to short, basic, guttural responses.

• While transformed, você pode use weapons and equipment as normal, unless specified elsewhere.

• Você ganha um Claw or Bite attack that you may use in place of any weapon attack. This attack deals 1d6 mais seu Força or modificador de Destreza Cortante damage. Você é proficient with this attack, and you add either your Força or modificador de Destreza to attack and jogada de danos. This attack is not an Ataque Desarmado , nor can it be used in place of an Ataque Desarmado.

• After taking an ação Atacar, you may take a Ação Bônus later in that turn to attack once with either your Claw or Bite.

• Se você target a creature that is within 1,5 m of one of its enemies, you have Vantagem on Claw or Bite attacks made against the target.

Your hybrid rat form lasts 1 hour per Estágio de Transformação. Se você entered your hybrid form voluntarily, você pode revert to your normal form by using a ação Mágica no seu turno. (Flaws listed below may override this rule.)') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 6, 'Falha do estágio 1: Lust for the Hunt', 'The savage nature of your curse sometimes causes you to lose control. These ferocious tendencies are a constant struggle between you and the beast within.

The first time you become Ferido after finishing a Descanso Curto or Descanso Longo, you must succeed on a CD 10 Sabedoria salvaguarda. Se você are in the light of a full moon, you automatically fail this salvaguarda.

Se você fail this salvaguarda, you are subjected to o seguinte rules until você pode end the hybrid form:

• You immediately enter your hybrid form. You go completely feral, and você podenot use any of your equipment or class features.

• On your turn while in hybrid form, you must move toward the closest creature você pode see, smell, or hear, prioritizing Ferido creatures. Se você end your movement and no creature is within 1,5 m of you, you must use the Dash action to move toward the closest one.

• If there is a creature within 1,5 m of you and you have not used your action, you must make an ação Atacar using your Claw attack.

• Quando você damage a creature no seu turno and it is not reduced to 0 Pontos de Vida, you must use further attacks that turn against that creature.

Se você are at full Pontos de Vida at the start of your turn, você pode make a CD 10 Sabedoria salvaguarda. On a success, you return to your normal form. You also return to your normal form if Remove Curse is cast on you, or after 1 hour passes.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 7, 'Estágio 2', 'Quando você alcança o estágio 2 of lycanthropy, você escolhe uma Bênção do estágio 2 Boon e ganha a Falha do estágio 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 8, 'Bênção do estágio 2: Hunter’s Focus', 'While in hybrid form, você pode use a Ação Bônus to mark one creature within 18 m as your prey. A creature remains marked this way por 1 hora, or until it dies. You may only have 1 creature marked at a time.

While a creature is marked as your prey, you gain o seguinte benefits:

• Sempre que você hit the marked creature with a melee attack, você causa an additional 1d6 damage of that attack''s type.

• Você tem Vantagem em any Sabedoria ( Percepção or Sobrevivência ) check you make to find it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 9, 'Bênção do estágio 2: Iron Pelt', 'While in hybrid form, you have Resistência to Contundente, Perfurante, and Cortante damage. Magical and silvered weapons ignore this resistance.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 10, 'Bênção do estágio 2: Kindred Form', 'Você ganha a capacidade de transform into the animal form representative of your Lycanthropy type, known as your Kindred Form. Use the stat block of the creature your lycanthropy corresponds with and follow the rules of the Polymorph spell:

• Werebear: Black Bear

• Wererat: Giant Rat

• Werewolf: Wolf

Você é indistinguishable from other creatures of that type, and você pode communicate with those creatures. Você podenot speak, but você pode understand languages você conhece. All equipment you wear and carry falls off you when transforming.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 11, 'Falha do estágio 2: Silver Sensitivity', 'Você tem developed a debilitating sensitivity to silver. In all forms, you have Vulnerability to Contundente, Perfurante, or Cortante damage from silvered weapons. Além disso, você podenot have Resistência to damage inflicted by silvered weapons.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 12, 'Estágio 3', 'Quando você alcança o estágio 3 of lycanthropy, você escolhe uma Bênção do estágio 3 Boon e ganha a Falha do estágio 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 13, 'Bênção do estágio 3: Bestial Vigor', 'Your Hit Point Maximum increases by an amount igual a your character level, and it increases by 1 every time you gain a character level.

Além disso, when in your hybrid form, you gain 5 Pontos de Vida Temporários at the start of each of your turns.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 14, 'Bênção do estágio 3: Shapeshifter’s Savagery', 'Você tem embraced the animalistic side of your transformation. While in your hybrid form, you gain o seguinte benefits:

• Your Claw and Bite attacks deal an additional 1d8 Cortante damage.

• Você tem Imunidade to the Charmed and condição Amedrontados.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 15, 'Falha do estágio 3: Frayed Thoughts', 'You suffer the effects of sharing a mind with two personalities. Memories of less practical significance are lost to new ones of midnight hunts. Você tem Desvantagem em Inteligência ability checks and salvaguardas.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 16, 'Estágio 4', 'Quando você alcança o estágio 4 of lycanthropy, you select a Stage 4 Boon e ganha a Falha do estágio 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 17, 'Bênção do estágio 4: Hybrid Form Affinity', 'Você tem achieved a state of equilibrium that most Lycanthropes never find. Você ganha os seguintes benefícios while you are voluntarily in your hybrid form:

• Você pode speak normally.

• Você pode conjurar spells without needing to provide their Verbal or Somatic components. Além disso, você pode cast spells without needing to provide material components, provided they do not have a PO value listed.

• Allies within 6 m of you have Vantagem on Sabedoria ability checks and salvaguardas.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 18, 'Bênção do estágio 4: Savage Instincts', 'Você tem developed an unrelenting thirst for bloodshed and carnage. While in your hybrid form, se você hit a Ferido creature with a Claw or Bite attack, the attack deals an additional 1d8 Cortante damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 19, 'Falha do estágio 4: Ultimate Predator', 'You realize the true cost of your transformation. The beast within has gained more control of your body than you have. While você pode control it at times, você conhece it cannot be contained forever—and when it breaks free, it delights in any slaughter it can find.

Você ganha o seguinte features:

• Se você can see, hear or smell a Ferido creature, you have Desvantagem on Sabedoria salvaguardas.

• No início do seu turno, se você can see, hear or smell a creature with the Unconscious condition, you must make a CD 15 Sabedoria salvaguarda. On a failure, you transform into your hybrid form, or, if already in hybrid form you go feral as described under Lust for Hunt, above. On a success, you are immune to this effect until you finish a Descanso Longo.

• Sempre que você kill a creature while in your hybrid form, você podenot transform back into your normal form until dawn the next day.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'), 20, 'Apêndice: Curing Lycanthropy', 'Curing Lycanthropy

Once the character reaches Stage 1 of the Lycanthrope Transformação, no typical magic like Remove Curse can cure the character’s lycanthropy. Magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
