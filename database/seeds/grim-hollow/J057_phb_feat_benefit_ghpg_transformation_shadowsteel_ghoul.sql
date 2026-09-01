-- J057 — Carniçal de Aço Sombrio (gh-transformation-shadowsteel-ghoul)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 1, 'Como começar', 'Curses are wrought from and woven with intense feelings of loathing, spite, and bitterness. Humanoideees who choose to wield such deeply evil magic leave an indelible mark upon their own soul. When enough of these marks pollute a person, their spirit begins to rot.

A creature who uses a Foco de Conjuração made of Shadowsteel, particularly to cast curses, risks acquiring the Shadowsteel Ghoul curse. Being attuned to a Shadowsteel magic item or wielding a Shadowsteel weapon for a prolonged period also carries a similar danger.

Curing Shadowsteel Ghoul Curses

Once the character reaches Stage 1 of the Shadowsteel Ghoul Transformação, no typical magic like Remove Curse can remove the affliction. Magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 2, 'Estágio 1', 'Quando você contrai the Shadowsteel Ghoul curse, você escolhe uma Bênção do estágio 1 Boon e ganha a Falha do estágio 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 3, 'Bênção do estágio 1: Shadowsteel Curser', 'Se você do not already have it, you gain the Shadowsteel Adept feat .

Além disso, when you cast a maldição de Shadowsteel, the casting time is reduced by half, and the salvaguarda CD increases by 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 4, 'Bênção do estágio 1: Shadowsteel Weapon', 'During a Descanso Longo, you focus upon a arma corpo a corpo within your reach, imbuing it with a fragment of your Shadowsteel corruption. This Shadowsteel weapon deals sua escolha of dano de Força or their normal damage type.

Quando você reduce a creature to 0 Pontos de Vida with a melee attack made with your Shadowsteel weapon, you gain 1d8 Pontos de Vida Temporários por 1 hora.

Você pode repeat the process described above to imbue a different weapon with Shadowsteel. This removes the effect from your existing Shadowsteel weapon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 5, 'Falha do estágio 1: Debilitating Magic', 'Choose one ability score. You lose 2 points in that ability as the power of the Shadowsteel slowly eats away at your body, soul, or both.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 6, 'Estágio 2', 'Quando você alcança o estágio 2 of the Shadowsteel Ghoul curse, you select two Stage 2 Boons e ganha a Falha do estágio 2 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 7, 'Bênção do estágio 2: Magic Resistance', 'Você tem Vantagem em salvaguardas against spells.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 8, 'Bênção do estágio 2: Shadowsteel Absorption', 'As the Shadowsteel courses through you, it begins to harden your flesh. Your Armor Class increases by 1 when you aren’t wearing armor.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 9, 'Bênção do estágio 2: Shadowsteel Caster', 'Se você do not already have it, you gain the Shadowsteel Master feat .

Além disso, when you use a Shadowsteel component to cast a spell using a espaço de magia, você pode spend a Hit Die to regain that espaço de magia. The espaço de magia level cannot be greater than twice your Shadowsteel Ghoul Estágio de Transformação.

Você pode usar este recurso um número de times igual a sua habilidade de conjuração modifier. You regain all uses of este recurso after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 10, 'Bênção do estágio 2: Shadowsteel Weapon Master', 'Você ganha um +4 bonus to jogada de danos made with your Shadowsteel weapon.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 11, 'Falha do estágio 2: Friendless', 'Você é no longer able to connect with other creatures on a social level. You prefer isolation and twisted contemplation to friendship and camaraderie.

Você podenot be considered an ally to any Humanoideees or Beasts, and no living creature can be Aliado toward you.

You also have Desvantagem on all Carisma ability checks.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 12, 'Estágio 3', 'Quando você alcança o estágio 3 of the Shadowsteel Ghoul Transformação, você ganha a Falha do estágio 3 Boon and the Stage 3 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 13, 'Bênção do estágio 3: Cursed Claw', 'Você ganha um Claw attack. This attack uses either your Força or Destreza for attack and jogada de danos.

Você pode usar this attack twice como parte de uman ação Atacar, or once como Ação Bônus. The Claw attack deals 2d6 mais seu Força or modificador de Destreza.

Além disso, when the Claw attack hits, the target must succeed on a Constituição salvaguarda or be afflicted with a random maldição de Shadowsteel at Stage 1. The salvaguarda CD is 8 mais seu modificador de Constituição mais seu Bônus de Proficiência. A creature already afflicted with a maldição de Shadowsteel cannot gain another maldição de Shadowsteel with this attack.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 14, 'Falha do estágio 3: Healing Resistance', 'You heal at a slower rate than normal, whether that healing is magical or natural. Sempre que você regain Pontos de Vida, você recupera half as many Pontos de Vida as you should. You still recover all Pontos de Vida at the end of a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 15, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Shadowsteel Ghoul, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 16, 'Bênção do estágio 4: Shadowsteel Arcane Vessel', 'Quando você cast a spell using a espaço de magia, the power of your Shadowsteel infection emanates from you. One creature targeted by the spell within 18 m of you has Desvantagem on the salvaguarda to resist the spell, or you have Vantagem on the spell jogada de ataque.

Você pode usar este recurso um número de times igual a seu Bônus de Proficiência, and você recupera all uses after you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 17, 'Bênção do estágio 4: Shadowsteel Fury', 'Quando você use the ação Atacar to attack with your Shadowsteel weapon or Cursed Claw , você pode use a Ação Bônus to make an additional attack with the same weapon or Claw. This extra attack carries with it the power of the Shadowsteel infection.

Quando você acerta with this attack, the target must succeed on a Constituição salvaguarda or gain a 1 nível de Exaustão. The salvaguarda CD is 8 plus the ability modifier used in the attack mais seu Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 18, 'Falha do estágio 4: Shadowsteel Explosion', 'The Shadowsteel that suffuses your flesh responds to stress, and você pode do nothing to control it. The first time you are Ferido or reduced to 0 Pontos de Vida after you finish a Short or Descanso Longo, you risk hurting everyone around you.

When these events occur, all living creatures within 18 m of you must succeed on a CD 20 Constituição salvaguarda. On a failed save, creatures in the area suffer 4d10 dano de Força and have the Stunned condition até o fim de their next turn. On a successful save, a target takes half damage and is not Stunned.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 19, 'Apêndice: Curing Shadowsteel Ghoul Curses', 'Curing Shadowsteel Ghoul Curses

Once the character reaches Stage 1 of the Shadowsteel Ghoul Transformação, no typical magic like Remove Curse can remove the affliction. Magic on the level of the magia Desejo is needed to completely remove the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-shadowsteel-ghoul'), 20, 'Apêndice: Shadowsteel''s Temptation', 'Shadowsteel''s Temptation

The Shadowsteel Ghoul Transformação might be the most likely change for characters to undertake. Each time a caster uses a Foco de Shadowsteel to cast a spell, or a warrior wields a Shadowsteel weapon, they risk losing a bit of their soul to gain a bit of power.

Players should know what is happening to their characters when they wield Shadowsteel''s power. It’s a boost to the power of a character, and the risk should be offsetting that power. The toll that is takes on the character should be explained by o Mestre, and hopefully the player—in the spirit of a dark fantasy campaign—should be able to express and illustrate that toll through roleplaying.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
