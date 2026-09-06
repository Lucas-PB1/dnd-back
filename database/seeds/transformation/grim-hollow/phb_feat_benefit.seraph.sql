-- J056 — Serafim (gh-transformation-seraph)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 1, 'Como começar', 'To be chosen by an Arch Seraph is to become a vessel for the principles they uphold. This is a charge not to be taken lightly, and those who display righteousness with the intention of becoming a Seraph are usually overlooked for this reason. When becoming a Seraph, consider why your character was chosen. Do you display hidden merit? Are you devoted to a cause they will value?

Relinquishing Divinity

Characters who reach Stage 1 of the Seraph Transformação do not typically seek power without righteous cause. The Transformação’s Boons and Flaws can be removed at any time by relinquishing divinity, como warrior retires their sword when the war is over. Regaining such power may not be so easy.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 2, 'Estágio 1', 'Quando você passa pela the Seraph Transformação, you gain Celestial Form and mais uma Bênção do estágio 1 de sua escolha. You also gain the Stage 1 Flaw.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 3, 'Bênção do estágio 1: Celestial Form', 'You become a Celestial in addition to any other creature type(s) you are. Além disso, you have Resistência to Radiant Damage.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 4, 'Bênção do estágio 1: Angelic Wings', 'Como Ação Bônus, você pode manifest feathered wings por 1 hora. While they are manifested, you have a Fly Speed igual a your Speed when you are not wearing heavy armor.

Você pode manifest these wings um número de times igual a your Estágio de Transformação, and você recupera all uses after finishing a Short or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 5, 'Bênção do estágio 1: Holy Strikes', 'Quando você acerta with a weapon or an Ataque Desarmado or damage a creature with a cantrip, você pode add 1d6 dano Radiante to that attack. Você pode add esse dano um número de times igual a seu Bônus de Proficiência mais seu Estágio de Transformação. You regain all uses of este recurso when you finish a Short or Descanso Longo.

At higher Estágio de Transformaçãos, você causa an additional 1d6 dano Radiante per Estágio de Transformação, for a total of 2d6 at Stage 2, 3d6 at Stage 3, and 4d6 at Stage 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 6, 'Falha do estágio 1: Planar Binding', 'Your body and soul are bound to the higher planes of good. Você tem Desvantagem em Death Salvaguardas as the plane attempts to pull your soul into its place of final reward.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 7, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Seraph, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 8, 'Bênção do estágio 2: Divine Clemency', 'When an ally within 9 m of you que você possa ver takes damage, você pode use a Reação to cast Healing Word at first level on that ally without using a espaço de magia.

Você pode do this um número de times igual a your Estágio de Transformação. You regain all uses of este recurso after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 9, 'Bênção do estágio 2: Sacred Retribution', 'When an ally você pode see within 9 m takes the ação Atacar with a weapon or Ataque Desarmado , você pode use your Reação to imbue them with holy zeal, allowing them to make one additional attack. On a hit, the target takes an additional 1d8 dano Radiante. You may use este recurso um número de times igual a your Estágio de Transformação. You regain all uses of este recurso when you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 10, 'Falha do estágio 2: Blinding Radiance', 'Your Transformação into a Seraph brings with it changes to your physical features. Your body radiates a divine glow, your eyes may become hollow braziers of celestial light, or your many sets of wings may appear unsettling to mortal creatures.

Você pode suspend this form and manifest the appearance of the humanoid you once were, but this is taxing and requires effort. This form is not permanent, and moments of stress or wrath are likely to reveal your true nature. This might occur under o seguinte circumstances:

• Becoming Ferido

• Having the Unconscious condition

• Witnessing an act of evil

• Encountering Corruptorish creatures or powers

• Using your Seraph Transformação powers for the first time after a Descanso Curto or Descanso Longo

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constituição salvaguarda with a CD based on your current Estágio de Transformação. Se você fail this save, your Blinding Radiance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 11, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Seraph, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 12, 'Bênção do estágio 3: Cleanse Affliction', 'Quando você use Divine Clemency on a creature, they gain o seguinte additional benefits:

• They gain Pontos de Vida Temporários igual a the amount of damage healed by Healing Word .

• They have Vantagem on their next Teste D20 made within the next minute.

• You end one of o seguinte conditions on it: Blinded , Deafened , Paralyzed , or Envenenado .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 13, 'Bênção do estágio 3: Protective Wings', 'While you are manifesting your Angelic Wings , you gain o seguinte benefits:

• Como Reação , when you or an ally within 1,5 m of you is targeted by a weapon attack, você pode impose Desvantagem on that attack. If the attack hits the ally, you take half the attack’s damage (rounded up) and the original target takes the other half.

• Você tem Vantagem em salvaguardas or ability checks to avoid having the condição Agarrado or to escape a Grapple.

• Your Fly Speed is increased by 3 m.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 14, 'Bênção do estágio 3: Bow of Celestial Judgement', 'Você pode usar a Ação Bônus to manifest a powerful bow made of divine light. The Bow of Celestial Judgement lasts por 1 minuto and grants you o seguinte abilities while manifested:

• Você pode usar a ação Mágica to target a creature você pode see within 36 m with your bow. The creature must succeed on a Destreza salvaguarda against a CD igual a 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação. On a failed save, the creature takes 6d6 dano Radiante, or 10d6 if it is a Fey, Corruptor, or Undead. On a success, the creature takes half damage.

• Você tem Resistência to dano Necrótico.

• Você ganha 5 Pontos de Vida Temporários at the start of each of your turns.

Você pode usar este recurso um número de times igual a your Estágio de Transformação, and você recupera all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 15, 'Falha do estágio 3: Beacon to Darkness', 'Você é now a Seraph of noted virtue and divinity, becoming a target for the world''s evil. Sempre que você or an ally within 9 m commits an evil act, such as murdering innocents, you acquire a trace of darkness and you are Corrupted. GMs determine what constitutes an evil act.

While you are Corrupted, whenever you make uma jogada de ataque against an evil creature or a salvaguarda against a spell or effect from an evil creature, you have Desvantagem on the check. Also, if an ally is the one who caused your Corruption, they cannot be considered your ally or you theirs until the Corruption is removed.

Você pode remove the Corrupted condition by finishing a Descanso Curto or Descanso Longo, during which you must pray for at least 1 hour and burn holy incense or donate wealth to a local good cause worth at least 100 PO times your Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 16, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Seraph, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 17, 'Bênção do estágio 4: Aura of Holy Purge', 'You emit an aura of righteous fervor in a 6 m Emanação centered on you, except when you have the Unconscious condition. When an ally within your aura hits with a weapon attack, the ally can use their Reação to cause the hit to be a Acerto Crítico . If they do, you and the ally each gain a level of Exhaustion . After an ally uses this Reação, that ally can''t use it again until after they finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 18, 'Bênção do estágio 4: Aura of Righteous Mercy', 'You emit an aura of peaceful resolution in a 6 m Emanação centered on you, except when you have the Unconscious condition. When an ally within your aura would be reduced to 0 Pontos de Vida, they can use their Reação to drop to 1 Hit Point instead. If they do, you and the ally each gain a level of Exhaustion. After an ally uses this Reação, that ally can''t use it again until after they finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 19, 'Bênção do estágio 4: Bow of Celestial Domination', 'While your Bow of Celestial Judgement is manifested, you gain these additional benefits:

• Quando você use a ação Mágica to target a creature você pode see within 36 m, você pode also affect one other creature with 3 m of the original target.

• Você tem Imunidade to dano Necrótico instead of Resistência .

• Você ganha 15 Pontos de Vida Temporários at the start of each of your turns instead of 5.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 20, 'Falha do estágio 4: Seraph Corruption', 'The weight of evil in the world encumbers you more and more heavily as the days pass. Sometimes it becomes too much, e seu celestial form is wracked with pain and doubt.

Sempre que você roll a natural 1 on a salvaguarda, you suffer o seguinte effects por 1 minuto:

• No início de each of your turns, you take 1d10 dano Psíquico. This damage cannot be reduced in any way.

• Você podenot regain Pontos de Vida or have Pontos de Vida Temporários .

• Você tem Desvantagem em the first attack you make every round.

• Uma vez por rodada, the first creature you force to make a salvaguarda against your spell has Vantagem on the salvaguarda.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'), 21, 'Apêndice: Blinding Radiance Save CD', 'Stage | Constituição Save CD
2 | 13
3 | 16
4 | 20') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
