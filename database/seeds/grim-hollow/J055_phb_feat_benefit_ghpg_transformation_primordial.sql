-- J055 — Primordial (gh-transformation-primordial)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 1, 'Como começar', 'There are several ways for a mortal to consume a primordial spark. They might be born with one due to some sorcery or gifted one by accident in the dreams of a slumbering Primordial. A mortal may consume the power of an Elemental through arcane rituals. Or a body could become infused with primal energy after surviving a calamity caused by an Elemental creature or rift to an Elemental Plane.

Once acquired, one must spend a great deal of time contemplating and understanding the spark to unlock its full potential. The process of attaining elemental mastery is dangerous. The slightest slip in control can cause devastation on a massive scale. Such facts are why isolated individuals like Druids, Monks, or Rangers are most likely to see the Transformação through to its end.

Reverter traços de Primordial

Once a primordial spark has taken hold, your mortal body will continue to deteriorate from the roiling elements it now tries to contain. You will inevitably become one with the elements, your soul pulled into the Elemental Plane. Only magic on the level of the magia Desejo can then revive you, with or without your Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Primordial pela primeira vez, ganha as duas Bênçãos do estágio 1 e a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 3, 'Bênção do estágio 1: Primordial Form', 'You become an Elemental in addition to any other creature type(s).

Your Constituição score increases by 1, but cannot increase above 20 in this way.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 4, 'Bênção do estágio 1: Elemental Affinity', 'Though you have sway over all the elements, your Primordial change was sparked by one particular element: your Elemental Affinity. This element infuses your form and dictates your powers. Você deve choose one element below and gain all the benefits of that element:

Air. Você tem Resistência to dano de Relâmpago. Além disso, você pode channel the air currents around you to guide a ranged attack. Once on each of your turns, when you make an attack with a arma à distância or ranged spell, você pode make that attack with Vantagem. Se você are in a location without air—such as underwater or in a vacuum—este recurso has no effect.

Earth. Você tem Resistência to Contundente damage. Além disso, whenever you gain Pontos de Vida Temporários , you gain additional Pontos de Vida Temporários igual a seu Bônus de Proficiência.

Fire. Você tem Resistência to dano de Fogo. Além disso, whenever você causa dano de Fogo, você pode add seu modificador de Constituição to the damage dealt.

Water. Você tem Resistência to dano Gélido. Além disso, whenever a creature within 9 m regains Pontos de Vida, você pode use a Reação to imbue them with healing elemental energy. The creature regains an additional 1d6 Pontos de Vida.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 5, 'Falha do estágio 1: Planar Binding', 'Your body and soul are connected to the Elemental Plane. Você tem Desvantagem em Death Salvaguardas as the plane attempts to pull you into it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 6, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Primordial, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 7, 'Bênção do estágio 2: Dual Nature', 'You add a second element to your Elemental Affinity Boon . Quando você do so, you gain the associated benefits of your new element.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 8, 'Bênção do estágio 2: Elemental Surge', 'Você pode channel pure elemental energy into a concentrated bolt of an element de sua escolha. Como ação Mágica, você pode use any of as seguintes opções:

Lightning Strike. Você pode make a ranged attack targeting a creature within 18 m. Você é proficient with this attack, which uses seu modificador de Constituição. On a hit, this attack deals 3d8 mais seu modificador de Constituição dano de Relâmpago. Você pode then use a Ação Bônus to target another creature within 9 m of the first target with the same attack.

Increase the damage of these attacks by 1d8 for each Estágio de Transformação above 2.

Earth Shard. Você pode force a creature within 9 m to make a Constituição salvaguarda. On a failed save, the creature takes Contundente damage igual a 3d6 mais seu modificador de Constituição, or half as much on a successful save. Increase the damage by 1d6 for each Estágio de Transformação above 2.

You also gain Pontos de Vida Temporários igual a half the damage dealt.

Flame Wave. Each creature in a 4,5 m Cone originating from you makes a Destreza salvaguarda against a CD igual a 8 mais seu modificador de Constituição mais seu Estágio de Transformação. On a failed save, creatures in the area take dano de Fogo igual a 2d8 mais seu modificador de Constituição. Increase the damage by 1d8 for each Estágio de Transformação above 2.

Aquatic Rejuvenation. Choose a creature você pode see within 18 m of you. The creature regains um número de Pontos de Vida igual a 2d8 mais seu modificador de Constituição. Increase the number of Pontos de Vida regained by 1d8 for each Estágio de Transformação above 2.

Você pode usar Elemental Surge um número de times igual a seu modificador de Constituição, regaining all expended uses upon finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 9, 'Falha do estágio 2: Roiling Elements', 'Your physical vessel strains to contain the roiling elements trapped inside of you. In a moment of distraction your body may erupt momentarily to reveal your Primordial nature. Tongues of flame may lash out or arcs of lightning might burst from beneath your skin.

Você pode contain the elements and maintain the appearance of the humanoid you once were, but this is taxing and requires effort. Moments of stress are likely to unleash your true nature, which might occur under o seguinte circumstances:

• Becoming Ferido

• Having the Unconscious condition

• Encountering Elemental creatures or powers

• Having the Charmed or condição Amedrontados

• Using your Primordial Transformação powers

In these events, or times of other extreme emotional or physical stress, o Mestre can call for a Constituição Salvaguarda with a CD based on your current Estágio de Transformação:') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 10, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Primordial, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 11, 'Bênção do estágio 3: Aura of Awakening', 'You emit an aura of power that awakens the elemental forces in your companions. Quando você first gain este recurso, choose one of the options below. You may change the aura you emit upon finishing a Descanso Longo.

Light as Air. Sempre que você or an ally você pode see within 9 m of you makes a Destreza salvaguarda, the creature gains a bonus igual a seu modificador de Constituição.

Forged in Fire. When an ally within 3 m of você causas damage with a melee attack, você pode use a Reação to make the attack deal dano de Fogo instead of the normal damage type, and add 2d6 dano de Fogo to the attack’s damage.

Heart of Stone. Você pode escolher to have Desvantagem on any Initiative check. Se você do, como Reação, you and each creature de sua escolha within 9 m of you gain Pontos de Vida Temporários igual a your 1d10 mais seu modificador de Constituição. While a creature has Pontos de Vida Temporários gained in this manner, they cannot have the condição Caído unless it is part of the Unconscious condition.

Fluid Movement. When an ally within 9 m moves or attempts to escape a Grapple, você pode use a Reação to give them o seguinte benefits:

• Their Speed increases by 3 m até o fim de their turn.

• Their movement doesn’t provoke Ataque de Oportunidades .

• They have Vantagem on checks to escape the Grapple.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 12, 'Bênção do estágio 3: Primeval Body', 'Your transformation to an Elemental creature has changed your body entirely. You no longer need to sleep, breathe, or eat. Also, you no longer age normally and suffer no effects of aging.

Além disso, choose one damage type from Contundente, Cold, Fire, and dano de Relâmpago. Você ganha Resistência to that damage type. Se você already have Resistência, you gain Imunidade to it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 13, 'Bênção do estágio 3: Master of Many', 'You add a third elemental to your Elemental Affinity Boon . Quando você do so, you gain the associated benefits of your new element.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 14, 'Falha do estágio 3: Elemental Imbalance', 'Your body reacts in strange ways to the application of severe elemental damage. Quando você realiza Acid, Cold, Fire, Lightning, or dano Trovejante, roll 1d6. On a 1, your Primordial form reacts in a volatile manner, and o seguinte effects occur:

• Você ganha Vulnerability to the instance of damage you just took, even se você had Resistência or Imunidade to that damage.

• Creatures within 1,5 m of you take the original amount of damage that you took. A CD 15 Constituição salvaguarda halves esse dano.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 15, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Primordial, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 16, 'Bênção do estágio 4: Primordial Aura', 'Creatures de sua escolha within 4,5 m of you gain Resistência to Contundente, Cold, Fire, or dano de Relâmpago. You choose the damage type after finishing a Descanso Curto or Descanso Longo, and você pode change the damage type como Ação Bônus. If they already have Resistência to any of these damage types, they gain Imunidade to that damage type.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 17, 'Bênção do estágio 4: Elemental Mastery', 'You add the final element to you Elemental Affinity Boon . Quando você do so, you gain the associated benefits of your new element.

Além disso, você pode summon the four elements to wreathe you in power. Whenever a creature hits you with a melee attack, você pode use your Reação to force it to make a Destreza salvaguarda, dealing 6d6 damage of a type de sua escolha from Contundente, Cold, Fire, or Lightning, or half as much on a successful save.

After you use this Reação, your Elemental Affinity features gain o seguinte benefits até o fim do seu próximo turno:

Air. Você tem Vantagem em all arma à distância and ranged spell attacks.

Earth. At the beginning of your turn, you gain 20 Pontos de Vida Temporários .

Fire. At the beginning of your turn, each creature de sua escolha within 1,5 m of you takes 2d6 dano de Fogo.

Water. Whenever a creature withing 18 m que você possa ver regains Pontos de Vida by spending Dados de Vida or through a spell or magical ability, that creature regains an additional 20 Pontos de Vida.

Você pode usar este recurso um número de times igual a seu modificador de Constituição, regaining all uses upon completing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 18, 'Falha do estágio 4: Primordial Chaos', 'The plane of Primordial energy that you’re tied to strengthens its pull on you. Sempre que você roll a natural 1 on a salvaguarda against a spell, you take 8d6 dano de Força, which ignores Resistências and Immunities. This damage is in addition to any normal damage from the effect.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 19, 'Apêndice: Roiling Elements Save CD', 'Stage | Constituição Save CD
2 | 13
3 | 16
4 | 20') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 20, 'Apêndice: Reverter traços de Primordial', 'Reverter traços de Primordial

Once a primordial spark has taken hold, your mortal body will continue to deteriorate from the roiling elements it now tries to contain. You will inevitably become one with the elements, your soul pulled into the Elemental Plane. Only magic on the level of the magia Desejo can then revive you, with or without your Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-primordial'), 21, 'Apêndice: The Primordial Existence', 'The Primordial Existence

The mythological, and perhaps even the empirical, representation of primordial power in Etharis is Gormadraug, the Prismatic Wyrm. Valikans grow up hearing tales of the power—and the world-ending danger of the Great Wyrm. The beast embodies all the apocalyptic potential of earth, air, fire, and water.

Within the land controlled by the Valikan Clans, creatures showing an ability to manifest the primordial elements would strike awe into witnesses of that power. And more importantly, they would also likely be feared and mistrusted. Indeed, with the awakening of Gormadraug such a feared event, such people would be seen como threat unless they could convince the common folk that they are not harbingers of doom.

While other lands would not be as fearful as the Valikans of the elemental magic (save for maybe the Inquisição Arcanista), wielders of primordial elemental power are likely looked at as dangerous and in league with powers beyond their control and understanding.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
