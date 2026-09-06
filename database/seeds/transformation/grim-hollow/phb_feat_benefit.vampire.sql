-- J059 — Vampiro (gh-transformation-vampire)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 1, 'Como começar', 'Vampires are spawned into the world when a mortal contracts the Sanguine Curse, dies, and is reborn undead. There are a variety of ways to contract the curse. A Vampire may have offered their blood to a loyal servant, powerful ally, or loved one they wished to elevate. More commonly, a Vampire may bite a victim, who survives the attack long enough to contract the Sanguine Curse before perishing and being reborn.

Other methods of becoming a Vampire include ancient and dark magic, as well as powerful but cursed magical artifacts. Vampirism may be passed along when an ancient Vampire allows a beloved plaything to drink blood from the Undead creature’s cursed veins. Regardless of how you have become a Vampire, you should discuss with seu Mestre what type of Vampire you might become and how it can be implemented in the campaign.

Curing Vampirism

Once the character reaches Stage 1 of the Vampire Transformação, no typical magic like Remove Curse can remove the affliction. Magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 2, 'Estágio 1', 'Quando você contrai vampirism, you gain the Fanged Bite Boon and one other Stage 1 Boon. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 3, 'Bênção do estágio 1: Fanged Bite', 'As an ação Atacar, você pode make a Bite attack. Você é considered proficient with this attack, and você pode use Força or Destreza as the ability. This attack deals Perfurante damage igual a 1d6 mais seu Força or modificador de Destreza. This Bite attack is not a weapon or an Ataque Desarmado .

If the attack hits a creature that has blood, the target must succeed on a Constituição salvaguarda or take an additional 1d6 dano Necrótico. You regain Pontos de Vida igual a the dano Necrótico dealt this way. The CD is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 4, 'Bênção do estágio 1: Soman Bloodline', 'Your vampirism follows the Soman bloodline, the most prevalent in Etharis. Você ganha o seguinte features:

• Your Força and Destreza scores increase by 1. Neither score can exceed 19 with este recurso.

• Você tem Vantagem em jogada de ataques with Fanged Bite .

• The dano Necrótico dealt by Fanged Bite increases to 1d8.

• Você ganha um Climb Speed igual a your Speed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 5, 'Bênção do estágio 1: Fzeg Bloodline', 'Your vampirism follows the Fzeg bloodline, a line of vampires that combines the affliction with lycanthropy. Você ganha o seguinte features:

• Your Força score increases by 2. Your Força score cannot exceed 20 with este recurso.

• Você ganha um Claw attack. This attack deals 1d8 mais seu modificador de Força Cortante damage, using seu modificador de Força and Bônus de Proficiência on jogada de ataques. This Claw attack is not a weapon or an Ataque Desarmado .

• Quando você realiza the ação Atacar to make the Claw attack, you may use a Ação Bônus to make a Bite attack from Fanged Bite .

• Your Speed increases by 3 m.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 6, 'Bênção do estágio 1: Strigoi Bloodline', 'Your vampirism follows the Strigoi bloodline. Your speed and guile almost match your ferocity. Você ganha o seguinte features:

• Your Destreza score increases by 2. Your Destreza score cannot exceed 20 with este recurso.

• Se você make your Fanged Bite attack with Vantagem , the Perfurante damage increases to 2d4 mais seu Força or modificador de Destreza.

• Você pode realizar the Hide action como Ação Bônus, and você pode use the Hide action anywhere that is not in sunlight.

• Você tem proficiency with the Furtividade skill. Se você are already proficient in Furtividade, you gain Especialização in Furtividade instead.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 7, 'Falha do estágio 1: The Sanguine Curse', 'The Sanguine Curse has taken hold of you. Como result, you gain o seguinte features:

• Você podenot enter a private residence that you do not own without one of the occupants inviting you. Once invited, você pode enter without penalty as long as the inviter resides there. Se você do enter uninvited, you have Desvantagem on all Teste D20s while in the residence. Além disso, you take 1d4 dano Psíquico at the start of each of your turns. Você podenot be Resistant or Imune to dano Psíquico while inside such a residence uninvited.

• Você deve feed at least once within seven days of your last feeding. See the Feeding sidebar for more information.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 8, 'Estágio 2', 'Quando você alcança o estágio 2 of vampirism, you select two Stage 2 Boons e ganha a Falha do estágio 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 9, 'Bênção do estágio 2: Eyes of the Night', 'Você ganha Darkvision out to 18 m. Se você already have Darkvision, the range increases by 18 m.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 10, 'Bênção do estágio 2: Grave-Touched Soul', 'Você ganha Resistência to dano Necrótico. Se você already have Resistência to dano Necrótico, you gain Imunidade instead.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 11, 'Bênção do estágio 2: Inhuman Reflexes', 'Você tem Vantagem em Destreza salvaguardas.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 12, 'Bênção do estágio 2: Undead Resilience', 'You become supernaturally tough to kill. Quando você are reduced to 0 Pontos de Vida by any type of damage except Radiant, você pode choose to be reduced to 1 Hit Point instead. Depois de usar este recurso, você podenot use it again until you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 13, 'Falha do estágio 2: Greater Sanguine Curse', 'Your curse has taken a stronger hold onto you. Você ganha o seguinte features:

• Você tem Desvantagem em all Teste D20s when you are in sunlight.

• Você deve feed every 4 days.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 14, 'Estágio 3', 'Quando você alcança o estágio 3 of vampirism, you select two Stage 3 Boons e ganha a Falha do estágio 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 15, 'Bênção do estágio 3: Beguiler’s Charm', 'Você ganha a capacidade de manipulate the mind of a creature with your unearthly charm. Como ação Mágica, você pode choose a Humanoidee or Beast within 9 m of you that can see you. The creature must succeed on a Carisma salvaguarda with a CD of 8 mais seu modificador de Carisma mais seu Bônus de Proficiência.

On a failed save, the creature has the Charmed condition por 24 horas. No fim de the 24 hours, você pode choose to automatically renew the Charmed condition on that creature with no salvaguarda. You may only have one creature Charmed in this manner at a time. Se você use este recurso on another creature, or you or an ally damages the creature, the Charmed condition ends on the previous creature immediately.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 16, 'Bênção do estágio 3: Improved Fanged Bite', 'As an ação Atacar, você pode make 2 Fanged Bite attacks. Além disso, você pode make a Fanged Bite attack como Ação Bônus se você don''t make a Fanged Bite attack como parte de uman ação Atacar on the same turn.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 17, 'Bênção do estágio 3: Mist Form', 'Você pode conjurar the Gaseous Form spell um número de times igual a your Vampire Estágio de Transformação without using a espaço de magia or needing to use Verbal, Somatic, or Material components. You regain all uses of este recurso when you finish a Descanso Longo.

Você pode conjurar this spell as an Ação no seu turno, or como Reação when you would take Contundente, Perfurante, or Cortante damage. You cast the spell before taking the damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 18, 'Bênção do estágio 3: Sangromancy Specialist', 'Your magic is tinged with the blood that you crave. Você ganha o seguinte features:

• Você ganha an extra 1d12 Sangromancy Dados de Vida per Vampire Transformação. Você pode usar those dice on Sangromancy spells. You regain all spent Dados de Sangromancia when you finish a Descanso Longo.

• Quando você successfully restore Pontos de Vida using Fanged Bite , você recupera one spent Dado de Sangromancia.

• Any cantrip you cast that does dano Necrótico can be enhanced by your Dados de Sangromancia. Você pode spend up to 2 Dados de Vida (including your Dados de Sangromancia) to deal extra dano Necrótico with those truques. Você pode decide to spend these Dados de Vida after você conhece if the cantrip affects the target(s).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 19, 'Falha do estágio 3: Supreme Sanguine Curse', 'Your curse continues to transform you, bringing about further debilitations. Você ganha o seguinte features:

• Se você start your turn in sunlight, you take 1d10 dano Radiante. Você podenot have Imunidade or Resistência to this Radiant Damage.

• Your appearance begins to resemble that of a true vampire. In stressful conditions, as determined by you or o Mestre, your appearance changes outside of your control. Quando você do, anyone observing você conheces your true nature.

• Você deve feed every 2 days.

Você pode hide your true appearance and disguise yourself as the humanoid you once were by concentrating on your composure. However, moments of bloodlust or stress are likely to reveal your true nature, including o seguinte situations:

• Becoming Ferido

• Concentrating on a spell

• Taking dano Radiante from sunlight

• Entering a feeding frenzy

• Having the Unconscious condition

• Entering hallowed ground

• Choosing to reveal yourself

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constituição salvaguarda with a CD based on your current Estágio de Transformação. Se você fail this save, your Sanguine Curse is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 20, 'Estágio 4', 'Quando você alcança o estágio 4 of vampirism, you gain the Regeneration Boon and one other Stage 4 Boon de sua escolha. You also gain the Stage 4 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 21, 'Bênção do estágio 4: Final Soman Bloodline', 'You reach the full manifestation of your Soman Bloodline. Você ganha o seguinte features:

• Your Força and Destreza scores increase by 1 to a maximum of 20.

• Fanged Bite’s dano Necrótico increases to 3d8.

• When a Humanoidee creature is reduced to 0 Pontos de Vida by your Fanged Bite attack or through your feeding, it rises como Vampire Spawn 24 hours later unless the body is destroyed or undergoes rituals to prevent its rising. Você pode have two Vampire Spawns created this way under your control, and they follow your verbal commands to the best of their abilities. Se você take control of a third Vampire Spawn, você escolhe one of the other Vampire Spawn you currently control to no longer follow your commands.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 22, 'Bênção do estágio 4: Final Fzeg Bloodline', 'You reach the full manifestation of your Fzeg Bloodline. Você tem o seguinte features:

• Your Força score increases by 2 points to a maximum of 20.

• The damage done by your Claw attack becomes 3d6 mais seu modificador de Força Cortante damage, using seu modificador de Força and Bônus de Proficiência on jogada de ataques. Você pode also make three Claw attacks with an ação Atacar.

• Você é Resistant to Contundente, Perfurante, and Cortante damage. Magic and silvered weapons ignore this Resistência .

• Your Speed increases by 3 m.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 23, 'Bênção do estágio 4: Final Strigoi Bloodline', 'You reach the full manifestation of your Strigoi Bloodline. Você tem o seguinte features:

• Your Destreza score increases by 2 points to a maximum of 20.

• Você pode summon 2d4 Swarms of Rats , Swarms of Bats , or Wolves como Ação Bônus. They appear at the start of your next turn within 18 m of you. They follow your verbal or mental commands. They disperse after 1 hour, when you are reduced to 0 Pontos de Vida, or when you dismiss them with a Ação Bônus. You regain this ability after finishing a Short or Descanso Longo.

• Você pode conjurar the Misty Step spell up to four times without using a espaço de magia. Você pode also cast a spell in this way como Reação when you are targeted with a weapon attack. You cast the spell before taking damage. You regain this ability after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 24, 'Bênção do estágio 4: Regeneration', 'The vampiric blood that flows in your veins gives you regenerative powers. You regain 15 Pontos de Vida at the start of your turn se você have at least 1 Hit Point but less than 60 Pontos de Vida. This feature has no effect se você are in sunlight or have taken dano Radiante since the end of your last turn.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 25, 'Falha do estágio 4: Ultimate Sanguine Curse', 'Your transformation into a creature of the night is complete. And with that transformation comes susceptibilities. Você ganha o seguinte features:

• One strike may end your existence forever. Quando você are Incapacitado , Stunned , or Unconscious , and you are struck by a Acerto Crítico with a Perfurante Weapon made of wood or silver, you must succeed on a CD 20 Constituição salvaguarda. On a failed save, you die and are reduced to ash. Only a True Resurrection or magia Desejo can resurrect you.

• Você deve feed every day.

//') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 26, 'Apêndice: Supreme Sanguine Curse Save CD', 'Stage | Constituição Save CD
3 | 16
4 | 20') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 27, 'Apêndice: Curing Vampirism', 'Curing Vampirism

Once the character reaches Stage 1 of the Vampire Transformação, no typical magic like Remove Curse can remove the affliction. Magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-vampire'), 28, 'Apêndice: Feeding', 'Feeding

Como Vampire transforms further and further from its mortal form, its metabolic requirements change. The first change is a need for mortal blood. This need is approximately 1 pint of blood from a Humanoidee, Beast, or other creature with mortal blood.

As an action, você pode bite a living creature within 1,5 m that is Charmed by you, or that has the Incapacitado, Paralyzed, Restrained, or Unconscious condition. You drain the target of one pint of blood (or similar life-giving substance), leaving a visible bite mark on that creature. The bitten creature gains one nível de Exaustão.

A Vampire that does not feed within the required time enters a rabid feeding frenzy under o Mestre’s control. They attack the nearest creature they could feed from. A Vampire remains in this state until they have drained a creature completely (killing them), at which point the Vampire falls unconscious for 4 hours.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
