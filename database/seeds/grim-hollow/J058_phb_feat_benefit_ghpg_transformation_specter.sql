-- J058 — Espectro (gh-transformation-specter)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 1, 'Como começar', 'Methods of becoming a Specter vary, and few find their way willingly. One that dies of an unjust or violent cause may find their spirit refusing to depart, despite their physical form fading. Contact with the forces of death can drain the soul of vitality—a would-be hero is corrupted by the force they wanted to fight. Sinister rituals can also infuse a body with the powers of unmaking from the realm of the Aether Kindred .

Alongside incorporeal beings and the magic of death stand entities that exist in a reality untethered from the material world as mortals understand it. These others and their minions, manifestations of otherworldly chaos, can infuse a person with that chaos, making the victim’s ultimate home a dream of cosmic horror.

Reverter traços de Specter

Once the character reaches Stage 1 of the Specter Transformação, typical magic like Remove Curse cannot remove the affliction. Você podenot be revived or restored by any magic lesser than the magia Desejo due to the ties that anchor your spirit to the corporeal world.

Uma vez você die completely e seu soul departs, you may be brought back to life by more conventional magic, free of the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Specter pela primeira vez, ganha a Bênção Spectral Form e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 3, 'Bênção do estágio 1: Spectral Form', 'Você é considered to be Undead in addition to your existing creature type(s). Você podenot be excluded from Turn Undead.

Além disso, you have Resistência to dano Necrótico. Se você have Resistência to dano Necrótico from another source, you have Imunidade instead.

Finally, you stop aging. Você é imune a any effect that would age you, and você podenot die from old age.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 4, 'Bênção do estágio 1: Ghastly Touch', 'Você pode deliver a soul-chilling jolt through your attacks. Uma vez por turno, when you hit a target with a melee attack when you are within 1,5 m of the target, você pode deal an additional 1d6 dano Necrótico.

Você pode usar este recurso um número de times igual a seu Bônus de Proficiência mais seu Estágio de Transformação. You regain all uses of este recurso when you finish a Descanso Curto or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 5, 'Bênção do estágio 1: Incorporeal Movement', 'Você é able to loosen the binds that tie you to the material world to move through solid objects and creatures. Como ação Mágica, você pode make yourself incorporeal until the start of your next turn. While in this form, you gain o seguinte benefits:

• Você pode move through solid objects at your full Speed. You take 1d10 dano de Força se você end your turn inside a solid object and are moved to the nearest open space.

• Você tem Resistência to all damage types except dano de Força.

• Você é Lightly Obscured .

Você pode usar este recurso um número de times igual a seu Bônus de Proficiência, and regain all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 6, 'Falha do estágio 1: Drawn to Darkness', 'Your body and soul are bound to the cold darkness of the realms of death. Você tem Desvantagem em Death Salvaguardas as your life force is drawn to oblivion.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 7, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Specter, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 8, 'Bênção do estágio 2: Ethereal Phasing', 'Você pode conjurar the Blink spell without expending a espaço de magia. Você pode conjurar the spell using this Boon um número de times igual a your Estágio de Transformação, and você recupera all uses after finishing a Descanso Longo.

While you are under the effects of Blink when cast in this way, you also gain Pontos de Vida Temporários igual a seu Bônus de Proficiência mais seu Estágio de Transformação at the start of each of your turns.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 9, 'Bênção do estágio 2: Haunting Flight', 'Você ganha um Fly Speed igual a your Speed.

Also, while you are flying, você pode use a Ação Bônus to focus your terrifying presence on one creature você pode see within 9 m. That creature must succeed on a Sabedoria salvaguarda or have the condição Amedrontado por 1 minuto. The CD for the Sabedoria salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação. Depois de usar este recurso, you must finish a Short or Descanso Longo before você pode use it again.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 10, 'Falha do estágio 2: Untethered from Life', 'Your life force is weaker than other creatures. Quando você would regain Pontos de Vida, você recupera half as many Pontos de Vida as normal (rounded down).') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 11, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Specter, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 12, 'Bênção do estágio 3: Draining Flight', 'Você pode now use your Incorporeal Movement feature como Ação Bônus. Além disso, your Fly Speed while using Haunting Flight becomes double your Speed.

Além disso, while you are using Incorporeal Movement, your movement does not provoke Ataque de Oportunidades and você pode damage creatures that you move through. Uma vez por turno, when you enter a space occupied by a creature, você pode choose to force that creature to succeed on a Constituição salvaguarda or take 6d6 dano Psíquico and have the condição Amedrontado até o fim do seu próximo turno. A creature takes half damage on a successful save and is not Amedrontado. The CD of the Constituição salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

Depois de usar este recurso, you must finish a Descanso Curto or Descanso Longo before você pode use it again.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 13, 'Bênção do estágio 3: Paralyzing Touch', 'Your Ghastly Touch feature takes on a spirit-freezing quality. The damage from your Ghastly Touch increases to 2d6 dano Necrótico. Além disso, você pode force any creature you damage with Ghastly Touch to make a Constituição salvaguarda. The CD for this salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação.

On a failed save, the creature has the Paralyzed condition until the start of your next turn. On a successful save, they have the condição Caído instead. Você pode usar este recurso um número de times igual a your Estágio de Transformação. You regain all uses of este recurso when you finish a Short or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 14, 'Falha do estágio 3: Fraying Reality', 'Your mind begins to slip into the dark places where the world of life and world of death intersect. Quando você become Ferido for the first time after finishing a Short or Descanso Longo, you must make a CD 15 Carisma salvaguarda. On a failed save, you act as though under the effects of a Confusion spell por 1 minuto.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 15, 'Estágio 4', 'Quando você alcança o estágio 4 da Transformação em Specter, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 16, 'Bênção do estágio 4: Call of Unmaking', 'Como Ação Bônus, você pode give a mournful wail or otherwise set up a wracking vibration. This sound has no effect on Constructs and Undead.

All other creatures de sua escolha within 9 m of you must make a Constituição salvaguarda. The CD of the Constituição salvaguarda is 8 mais seu Bônus de Proficiência mais seu Estágio de Transformação. Creatures that can’t hear you have Vantagem on the salvaguarda.

On a failed save, the creature bears the Mark of Unmaking por 1 minuto. While bearing this mark, a creature takes an additional 1d6 dano Necrótico each time it takes damage.

Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 17, 'Bênção do estágio 4: Possession', 'Como ação Mágica, you enter the space of a Humanoidee or Beast and force that creature to make a CD 15 Carisma salvaguarda. If the target fails, you disappear, and the target is Incapacitado and loses control of its body. You control the body without depriving the target of awareness.

While possessing a target, você pode’t be targeted by any attack, spell, or other effect. You retain your alignment, Inteligência, Sabedoria, Carisma, and any immunity to having the Charmed and condição Amedrontados. Otherwise, you use the possessed target’s statistics but don’t gain access to the target’s knowledge, spellcasting abilities or ação Mágicas, class features, or proficiencies.

The possession lasts por 1 hora, until the possessed target drops to 0 Pontos de Vida, you end it como Ação Bônus, or you are forced out by an effect that ends possession. When the possession ends, you reappear in an unoccupied space within 1,5 m of the possessed creature. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Curto or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 18, 'Falha do estágio 4: Puxão do Oblívio', 'Sua conexão com o plano material torna-se tênue como seda. Sempre que rolar 1 natural em um Teste D20, sofre 4d6 de dano de Força, e esse dano não pode ser mitigado. Se esse dano reduzir seus Pontos de Vida a 0, você morre.

Quando morrer dessa forma ou de qualquer outra, só pode ser trazido de volta à vida por magias de 7º nível ou superior.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-specter'), 19, 'Apêndice: Reverter traços de Specter', 'Reverter traços de Specter

Once the character reaches Stage 1 of the Specter Transformação, typical magic like Remove Curse cannot remove the affliction. Você podenot be revived or restored by any magic lesser than the magia Desejo due to the ties that anchor your spirit to the corporeal world.

Uma vez você die completely e seu soul departs, you may be brought back to life by more conventional magic, free of the Transformação and its Boons and Flaws.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
