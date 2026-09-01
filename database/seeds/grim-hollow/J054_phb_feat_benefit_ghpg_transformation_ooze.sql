-- J054 — Gosma (gh-transformation-ooze)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 1, 'Como começar', 'It may seem like Oozes are monsters that only appear in the deepest, dankest recesses of dungeons and cave complexes that never see the light. While they certainly do haunt those places, Oozes in Etharis are never far away. Urban areas with poor sanitation are breeding ground for Oozes, as are pastoral locations with proximity to the Fey Realms.

And while some Ooze creatures may only devour and destroy, there are just as many — especially those who have been created or experimented on by the curious and the morbid — who seek to spread their oozy nature to others.

It is rumored by sage and peasant alike that the Filth Grazer, the force allegedly behind the creation and spread of the Weeping Pox, devours organic life by reducing it first into a putrescent sludge. Mortals are but food for aetheric horrors, and the Filth Grazer prefers theirs gurgling, gooey, and foul.

The truly mad might seek to gain the benefits of becoming an Ooze, thinking that being formless would provide power. Regardless of how it happens, people who become an Ooze find themselves in a terrible race: which will they lose first, their body or their mind?

Reverter traços de Ooze

Ooze features are terrible and difficult to undo once they have taken hold. Excruciating experimental trials might be able to alleviate some of the symptoms for a while, but a complete cure would take decades of knowledge and wealth that few in Etharis possess. Even then, it would still require a great deal of luck.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Ooze pela primeira vez, ganha a Bênção Ooze Form e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 3, 'Bênção do estágio 1: Ooze Form', 'You become an Ooze in addition to any other creature type(s) you are. Você ganha Blindsight with a range of 9 m. Se você already have Blindsight, your range increases by 9 m.

Você pode will your body to melt and flow, becoming more fluid than solid. Como Ação Bônus, you manifest your Ooze Form. You become amorphous, able to move through a space as narrow as 1 inch without expending extra movement, and you are immune to the Agarrado and Restrained conditions. You remain in Ooze Form por 1 minuto or until you use your Ação Bônus to return to normal.

Você pode manifest your Ooze Form um número de times igual a seu Bônus de Proficiência mais seu Transformação stage. You regain all uses of este recurso after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 4, 'Bênção do estágio 1: Mutable Corpus', 'Você tem abundant control over your Ooze Form. Each time you manifest your Ooze Form, você pode choose to augment it with one of as seguintes opções:

• Breathless. You do not need to breathe.

• Disguise. You remold your features and body to look different. Você pode change your apparent species, seem 1 foot shorter or taller, and appear heavier or lighter. Você deve adopt a form that has the same basic arrangement of limbs as you have. To discern that you are disguised, a creature must take the Study action to inspect your appearance and succeed on an Inteligência ( Investigação ) check with a CD igual a 10 mais seu modificador de Constituição mais seu Estágio de Transformação.

• Transparent. You body becomes transparent. Você tem Vantagem em Destreza ( Furtividade ) checks.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 5, 'Bênção do estágio 1: Slimy Mien', 'While manifesting your Ooze Form, you gain o seguinte additional benefits:

• Você é imune a the Charmed condition.

• The range of your Blindsight increases by 9 m.

• Você pode communicate with Oozes within 9 m as se você shared a common language. While Oozes are not automatically Aliado to you, they do not see you as food. Você pode ask them simple questions, and they may choose to respond if they are not Hostil .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 6, 'Falha do estágio 1: Sluggish', 'Your body frequently shifts and melts without control, making you sluggish. Your speed decreases by 1,5 m for every Estágio de Transformação you achieve.

Além disso, your skin glistens with oozy droplets leaving a trail anywhere you go. Ability checks made to follow your tracks are made with Vantagem .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 7, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Ooze, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 8, 'Bênção do estágio 2: Elastic Limbs', 'Your limbs have become elastic and tacky, allowing you to reach distant enemies and climb walls.

Your reach increases by 1,5 m and you gain a Climb Speed igual a your Speed. Você pode move up, down, and across vertical surfaces and along ceilings, while leaving your hands free. Creatures you are grappling have Desvantagem on Força ( Atletismo ) and Destreza ( Acrobatics ) checks to escape.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 9, 'Bênção do estágio 2: Viscous Durability', 'Your mind and body become even more Ooze-like. Você tem Imunidade to the condição Amedrontado and dano Ácido.

Quando você gain this Boon, choose Cold, Fire, or Lightning. Gain resistance to the chosen damage type.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 10, 'Falha do estágio 2: Melted Appearance', 'Your body is now a hideous lump of dripping flesh excreting foul smelling slime. While your form remains roughly humanoid, the horror of what you are is clear to anyone that looks upon your molten face. Você tem Desvantagem when you use the Influence action to make Carisma-based ability checks made against creatures that are not Aberrations or Oozes.

Além disso, your Transformação to an Ooze has liquefied many of your organs and dimmed your senses. Your eyes melt and run down your face and there is nothing but flesh where your ears once were. You permanently have the Blinded condition beyond the range of your Blindsight .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 11, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Ooze, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 12, 'Bênção do estágio 3: Corrosive Membrane', 'Quando você manifest your Ooze Form , it lasts for 10 minutes.

While manifesting your Ooze Form, you are covered with a sheen of acidic slime. When a creature hits you with a melee attack, it takes dano Ácido igual a 1d6 mais seu Estágio de Transformação. Nonmagical ammunition is destroyed immediately after hitting you and dealing damage. Any nonmagical weapon takes a cumulative −1 penalty to jogada de ataques immediately after dealing damage or coming into contact with you. The weapon is destroyed if the penalty reaches −5. The penalty can be removed by casting the Mending spell on the weapon.

Além disso, você pode eat through 0,6 m of nonmagical wood or metal in 1 minute simply by touching it.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 13, 'Bênção do estágio 3: Engulf', 'Quando você manifest your Ooze Form, it lasts for 10 minutes.

While manifesting your Ooze Form, você pode envelop your foes in your gooey body. Como ação Mágica, você pode try to engulf a creature of your size category or smaller that is within 1,5 m of you. The target makes a Força salvaguarda, with a CD igual a 10 mais seu modificador de Força mais seu Estágio de Transformação. On a failure, the creature is engulfed.

While engulfed, a target has Total Cover against attacks and other effects outside of you, and when you move, the engulfed target moves with you. While engulfed, a creature takes 4d6 dano Ácido at the start of each of its turns, is suffocating, has the Restrained condition, and repeats the save at the end of each of its turns, ending the effect on a success. An engulfed creature that is reduced to 0 Pontos de Vida is fully digested, leaving no body or nonmagical equipment behind.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 14, 'Falha do estágio 3: Physical Deterioration', 'Your skin sloughs away in thick, syrupy sheets e seu bones become like melted wax. The sun itself burns you, and holy light becomes lethal. Now your reactions slow as much as your pace.

Você é Vulnerable to dano Radiante, and you have Desvantagem on Destreza ability checks and salvaguardas.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 15, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Ooze, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 16, 'Bênção do estágio 4: Legion of Slime', 'Quando você manifest your Ooze Form , it lasts until you finish a Short or Descanso Longo.

While you are manifesting your Ooze Form and you are hit by an attack that causes you to become Ferido , você pode use a Reação to split into two identical Oozes. Each Ooze uses your game statistics, except that they are one size category smaller than your normal size, e seu remaining Pontos de Vida and Hit Point Maximum are divided evenly between the two Oozes (round down). Your equipment is not duplicated; all of it remains on one of the Oozes.

Each Ooze acts on your Initiative. They can each move independently, but they can only collectively take one action and Ação Bônus no seu turno and one Reação per round.

After you use este recurso, você podenot use it again until after you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 17, 'Bênção do estágio 4: Mimic Object', 'Quando você manifest your Ooze Form, it lasts until you finish a Short or Descanso Longo.

While manifesting your Ooze Form, você pode use a ação Mágica to transform into an object of your size or up to two sizes smaller. Any equipment worn or carried is dropped in your space. While mimicking an object, you retain your statistics.

While mimicking an object, you are indistinguishable from the object and você pode take a Reação when you are touched to adhere to the creature that touches you. The creature has the condição Agarrado. The CD to escape is igual a CD igual a 8 mais seu modificador de Constituição mais seu Estágio de Transformação. Ability checks made to escape this grapple have Desvantagem .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 18, 'Falha do estágio 4: Slippery Ego', 'As your brain becomes just one more part of the gooey mass that is you, e seu sense of self becomes ever more tentative, the slightest distraction can cause you to forget who you were.

The first time you become Ferido after a Descanso Longo, or whenever you roll a 1 on a salvaguarda, the pain or surprise causes you lose your grip on your mind. Você pode’t cast spells, activate magic items, understand language, or communicate in any intelligible way. Você é overwhelmed with hunger and take the ação Atacar no seu próximo turno to make melee attacks against a random creature within reach. If there are no creatures within reach, you move until you are adjacent to the nearest creature, using the Dash action if necessary.

You may attempt a CD 18 Sabedoria salvaguarda at the end of each of your turns to regain your sense of self. This effect ends automatically when you finish a Descanso Curto or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-ooze'), 19, 'Apêndice: Reverter traços de Ooze', 'Reverter traços de Ooze

Ooze features are terrible and difficult to undo once they have taken hold. Excruciating experimental trials might be able to alleviate some of the symptoms for a while, but a complete cure would take decades of knowledge and wealth that few in Etharis possess. Even then, it would still require a great deal of luck.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
