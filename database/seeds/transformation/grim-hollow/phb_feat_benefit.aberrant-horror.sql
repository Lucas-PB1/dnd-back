-- J048 — Horror Aberrante (gh-transformation-aberrant-horror)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 1, 'Como começar', 'Every Aberrant Horror begins with a defining question: what happened to them? Some individuals make pacts with ancient entities for powers that have unforeseen effects. Others awaken after defeating an unnatural monster, surprised that they survived, only to feel something writhing in their stomach. Many tropes of body horror can be used as inspiration for an Aberrant Horror’s creation.

Uma vez você''ve established your origin, consider your character’s motivations regarding their Transformação. As their power grows and manifests, they may feel they have lost what makes them fundamentally themselves. Perhaps they decide to take revenge on the entity responsible for their Transformação, or perhaps they perceive their mutation como gift.

Reverter traços de Aberrant Horror

Once the character reaches Stage 1 of the Aberrant Horror Transformação, the Boons and Flaws they’ve received cannot be removed by normal or even typical magical means. Some magic might slow or halt the mutations that the character endures, but magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Aberrant Horror pela primeira vez, ganha as duas Bênçãos do estágio 1 e a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 3, 'Bênção do estágio 1: Aberrant Form', 'Your creature type becomes Aberration in addition to any other creature types you have.

Also, the first time you become Ferido after a Short or Descanso Longo, you gain um número de Pontos de Vida Temporários igual a seu Bônus de Proficiência mais seu current Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 4, 'Bênção do estágio 1: Aberrant Mutation', 'Your body can twist and reshape itself as you will it, changing body parts into dangerous or useful tools and regenerating after taking damage. These abilities are represented by Aberrant Mutations. Você pode manifest an Aberrant Mutation listed below um número de times igual a seu Bônus de Proficiência mais seu current Estágio de Transformação.

Each of these Aberrant Mutations last por 1 minuto, and você pode end them early by spending a Ação Bônus to remove them or take on a different mutation. Se você choose another Aberrant Mutation, you must spend another use of este recurso.

You regain all uses of this ability when you finish a Short or Descanso Longo.

Chitinous Shell. Como Ação Bônus, you grow a hard, crustacean-like shell. While this mutation is active and are not wearing heavy armor, your Armor Class increases by 2. While you maintain this shell, your Speed is reduced by 3 m.

Eldritch Limbs. Como Ação Bônus, you transform one or both of your arms into thick muscle, scything claws, or sharpened bone. Quando você use the ação Atacar, você pode replace one or more attacks with melee attacks made with your eldritch limb. Você é considered proficient with this attack, and it uses either Força or Destreza (sua escolha). On a hit, the attack deals 1d8 damage (either Contundente, Perfurante, or Cortante, chosen each time you manifest the mutation).

Como Ação Bônus, você pode make a melee attack with your eldritch limb.

Your eldritch limbs cannot hold weapons, shields, or other items. They are not considered weapons or Ataque Desarmados.

Slimy Form. Como Ação Bônus, you cover yourself in a slippery slime. Você tem Vantagem em ability checks to escape a grapple, and você pode use the Dash action como Ação Bônus. You also gain Resistência to Acid, Fire, and dano Gélido while in this form.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 5, 'Falha do estágio 1: Unstable Form', 'Your body becomes malleable and struggles to maintain any one physical shape. Upon completing a Descanso Longo after an adventuring day in which you took damage, you must roll 1d100 on the Forma Instável table and apply the corresponding mutation based on current your Estágio de Transformação. This mutation lasts until you finish another Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 6, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Aberrant Horror, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 7, 'Bênção do estágio 2: Efficient Killer', 'Quando você make an attack with your eldritch limbs, você pode gain an added ability based on the damage type you have chosen.

Perfurante. You may replace any attack made with your eldritch limb with a razor-sharp barb hurled at the target. Você é considered proficient with this barb, which hcomo Range of 20/60, has the Finesse and Thrown properties, and deals 2d6 Perfurante damage on a hit.

Contundente. You manifest a long tentacle, tipped with a hardened bone club. Your eldritch limb attack deals an additional 1d8 Contundente damage. Also, the attack uses the Slow Weapon Property, which you have Mastery with.

Cortante. Your arm forms a row of viciously hooked claws and talons. Your eldritch limb attack deals an additional 1d8 Cortante damage. Also, the attack uses the Graze Weapon Property, which you have Mastery with.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 8, 'Bênção do estágio 2: Writhing Tendrils', 'Você ganha a capacidade de grow long, tendril-like appendages out of your body. Como Ação Bônus, these tendrils sprout from you. While you maintain these tendrils, you gain o seguinte benefits:

• When a creature moves to within 1,5 m of you, você pode try to push it back como Reação . Unless the creature succeeds on a Força salvaguarda, it is pushed 1,5 m away from you and its Speed is reduced to 0 until the start of your next turn. The CD of the salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

• Your tendrils can protect you se você move. Você pode usar a Ação Bônus to Desengajar .

• Como Reação to being targeted with a melee attack, você pode cause that creature to have Desvantagem on all melee attacks it makes that turn.

The tendrils last por 1 minuto. Você pode usar a Ação Bônus to retract your tendrils.

Você pode usar this ability um número de times igual a seu Bônus de Proficiência, and você recupera all uses when you finish a Descanso Curto or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 9, 'Falha do estágio 2: Hideous Appearance', 'Your appearance has grotesquely transformed. You may have turned into a hulking mass of flesh adorned with countless eyes, or a bone-and-tusk-covered behemoth. Regardless of your true form, you’re horrific to behold.

Você pode suspend this form and take on the appearance of the humanoid you once were, but this is taxing and requires effort. This form is not permanent, and moments of stress are likely to reveal your true nature. Your true form may be revealed in o seguinte situations:

• Becoming Ferido

• Concentrating on a spell

• Gaining the Unconscious condition

• Entering hallowed ground

• Choosing to reveal yourself

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constituição salvaguarda with a CD based on your current Estágio de Transformação. Se você fail this save, your Horrific Appearance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 10, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Aberrant Horror, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 11, 'Bênção do estágio 3: Terrifying Visage', 'Your mutations and unearthly appearance can unsettle even the bravest creatures. Quando você invoke your Aberrant Mutations or Writhing Tendrils , você escolhe one creature within 9 m that can see you. That creature must succeed on a Sabedoria salvaguarda or gain the condição Amedrontado por 1 minuto. The CD for the salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação. A creature that makes its salvaguarda is immune to this effect por 24 horas.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 12, 'Bênção do estágio 3: Constricting Tendrils', 'Você ganha um adicional option for your Writing Tendrils mutation.

Como Ação Bônus while Writhing Tentacles is active, você pode attempt to restrain a creature within 1,5 m of you with your tendrils. The creature must succeed on a Força or Destreza salvaguarda or gain the Restrained condition. The CD is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação. A Restrained creature can take an action to make a Força ( Atletismo ) check against this CD, ending the condition on itself on a success. The Restrained condition ends se você are Incapacitado , you move from your current position, se você retract your tendrils, or se você use your tendrils to perform another ability.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 13, 'Falha do estágio 3: Unstable Existence', 'Magic causes your physical form to unravel. Sempre que você roll a natural 1 or 2 on a salvaguarda against a spell, you reveal your Aparência Horrível and must roll again on the Forma Instável table. If the result is less than your current Forma Instável effect, replace it with the new result.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 14, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Aberrant Horror, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 15, 'Bênção do estágio 4: Eldritch Aberration', 'Você ganha a capacidade de deliver jolts of magical energy with your eldritch limbs. Uma vez por turno, when you hit a creature with an attack using your eldritch limbs, você pode expend a espaço de magia to deal additional damage igual a 1d6 per spell level expended. Você pode escolher for this additional damage to be of any of o seguinte types: Acid, Cold, Fire, Force, Lightning, or Thunder. If any of these extra dice show a 6 when rolled, the target has the condição Caído.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 16, 'Bênção do estágio 4: Poisonous Mutations', 'Você tem Resistência to dano de Veneno and are Imune to the condição Envenenado.

While you have an Aberrant Mutation active, any creature você escolhe that starts its turn within 1,5 m of you takes 3d6 dano de Veneno unless they succeed on a Constituição salvaguarda. The CD for this salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 17, 'Falha do estágio 4: Entropic Abomination', 'This Flaw replaces the Stage 3 Flaw: Unstable Existence . The very essence of magic and the effect of stress aggravates the unstable nature of your aberrant body. Each time you fail a salvaguarda, or the first time you become Ferido after finishing a Descanso Longo, you must roll on the Forma Instável table. If the result is less than your current Forma Instável effect, replace it with the new result.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 18, 'Apêndice: Aparência Horrível DCs', 'Stage | Constituição Save CD
2 | 13
3 | 16
4 | 20') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 19, 'Apêndice: Forma Instável', 'Stage 1 | Stage 2 | Stage 3 | Stage 4 | Effect
 |  |  | 01–02 | The stress of your Transformação becomes too much. You die. Você podenot restored to life by any spell below level 5.
 |  | 01 | 03–04 | Your form becomes fragile. Your Hit Point Maximum is half your normal maximum.
 | 01 | 02–03 | 05–06 | Your body starts to lose cohesion. Você tem Desvantagem em all Teste D20s .
01–05 | 02–03 | 04–06 | 07–24 | Your body’s metabolism quickly drains your energy. Você ganha 2 nível de Exaustãos.
06–10 | 04–06 | 07–24 | 25–32 | Você tem trouble processing what is happening. After rolling Initiative, you have the Stunned condition até o fim de your first turn.
11–15 | 07–24 | 25–32 | 33–40 | Your limbs weaken. Your Speed (in all modes of movement) decreases by 4,5 m and cannot be increased.
16–24 | 25–32 | 33–40 | 41–48 | Your body does not react quickly to mental commands. Você podenot take Reaçãos .
25–32 | 33–40 | 41–48 | 49–56 | Você é distracted by your changing form. Você tem Desvantagem em Sabedoria ( Percepção ) checks.
33–40 | 41–48 | 49–56 | 57–64 | Your body becomes unable to fight off attacks. Você tem Desvantagem em Constituição salvaguardas.
41–48 | 49–56 | 57–64 | 65–79 | You become clumsy. Você tem Desvantagem em Destreza salvaguardas and Destreza ability checks.
49–56 | 57–64 | 65–79 | 80–87 | You lose blood or other vital fluids during your mutations. Você podenot add seu modificador de Constituição to any Dados de Vida spent to regain Pontos de Vida.
57–64 | 65–79 | 80–87 | 88–93 | Speaking is difficult. Você pode only utter one word during each turn. This does not hamper spellcasting.
65–79 | 80–87 | 88–93 | 94–100 | No effect.
80–87 | 88–93 | 94–100 |  | Your lower limbs become more powerful. Your Speed increases by 1,5 m.
88–93 | 94–100 |  |  | Your flesh becomes more hardy. You start the day with 4 Pontos de Vida Temporários per Estágio de Transformação.
94–100 |  |  |  | Your body’s systems are enhanced. Você tem Vantagem em Death Salvaguardas.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 20, 'Apêndice: Reverter traços de Aberrant Horror', 'Reverter traços de Aberrant Horror

Once the character reaches Stage 1 of the Aberrant Horror Transformação, the Boons and Flaws they’ve received cannot be removed by normal or even typical magical means. Some magic might slow or halt the mutations that the character endures, but magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-aberrant-horror'), 21, 'Apêndice: Player Agency', 'Player Agency

Some abilities or flaws dictate the way creatures respond to a character, such as the Aparência Horrível flaw that makes creatures Hostil. Other player characters always have the choice how they react to these revelations.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
