-- J052 — Lich (gh-transformation-lich)
-- Benefícios da transformação; requer J019 (shell phb_feat).

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 1, 'Como começar', 'There are many ways to become a Lich, each determining the type of Lich the mortal becomes. The Ritual of Dread is one of the main methods for arcanists of Etharis. The process of this ritual is a well-guarded secret, entrusted to only a handful of mortals at any one time. The process of the ritual involves several despicable acts including murder, the brewing of a vile concoction, and even one’s own death.

For Memori Liches, warriors of great renown who hope to break the cycle of death, the process is less involved but no less gruesome. The skull of a powerful vanquished foe serves at the focus of power, tipping off new opponents they are in for a hellish battle.

For Hierophants, the call of the divine is equally strong to the call of mortality. Those who want to spend an eternity with power over both life and death in the name of a powerful divine source.

Regardless of the form of lichdom, the process of tearing one’s soul from the body is most despised, for this process involves the sacrifice of something truly dear to a mortal, and no substitute will be accepted. For some, it is the death of a cherished loved one. For others it is a family legacy. Regardless of the sacrifice, unless the dread spirits deem it worthy, lichdom will not be granted.

Reverter traços de Lich

The amount of raw magical energy that goes into becoming a Lich means that undoing it is impossible. The only stage beyond lichdom is annihilation, and even that can only occur if both the physical form of the lich and its soul vessel are both destroyed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 2, 'Estágio 1', 'Quando você passa pela Transformação em Lich pela primeira vez, ganha a Bênção Undead Form e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 3, 'Bênção do estágio 1: Undead Form', 'You become an Undead in addition to any other creature type(s). Você podenot be excluded from Turn Undead.

You also stop aging. Você é imune a any effect that would age you, and você podenot die from old age. You do not require air, food, drink, or sleep.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 4, 'Bênção do estágio 1: Lich Magica', 'Você pode trade the soul in your soul vessel for increased magical power.

On your turn, como Ação Bônus, você pode spend the charge in your soul vessel (see the Stage 1 Flaw below) for one of o seguinte effects.

• Regain a espaço de magia igual a or lower than your current Lich Estágio de Transformação.

• The next salvaguarda made before the end of your next turn against one of your spells has Desvantagem .

• The next time you cast a spell before the end of your next turn, deal an extra 1d6 dano Necrótico per Lich Estágio de Transformação to a single creature damaged by that spell.

• The next time you cast a spell before the end of your next turn that restores Pontos de Vida, that spell restores an additional 1d6 Pontos de Vida per Lich Estágio de Transformação.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 5, 'Bênção do estágio 1: Memori Lichdom', 'While your soul vessel is charged, you gain o seguinte benefits to your weapon attacks or Ataque Desarmados:

• They deal sua escolha of dano de Força or their normal damage type.

• They have Vantagem if taken como Reação .

• After você causa damage with a weapon attack or an Ataque Desarmado , você pode spend a Ação Bônus later on that turn and spend a Dado de Vida. Roll the Dado de Vida and deal dano Necrótico igual a the result to one target damaged by the triggering attack or Ataque Desarmado.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 6, 'Falha do estágio 1: Soul Vessel', 'Você tem successfully torn your soul from your body and trapped it in a suitable object. The object must be a trinket or item no larger than 1 cubic foot in size. This item becomes your soul vessel.

Soul Vessel. A soul vessel is an enchanted vessel containing a Lich’s soul. Além disso, a soul vessel is a conduit for the lich to feed on captured souls. A soul vessel has o seguinte statistics:

Armor Class: 18

Pontos de Vida: 10 × your Character Level

Speed: 0

Damage Immunities: Poison, Psychic; Contundente, Perfurante, and Cortante from non-magical sources

Damage Resistências: Cold, Fire, Lightning, Necrotic, Thunder; Contundente, Perfurante, and Cortante from magical sources

While a soul is stored in your soul vessel, the soul vessel is considered charged. The soul contained within the soul vessel must be from a creature whose ND is igual a or higher than half your Character Level. The soul vessel can only contain one soul at a time.

Você pode add a soul to the soul vessel 2 times for each of your Estágio de Transformaçãos. You regain this ability when you complete a Descanso Longo.

To store a soul within the soul vessel, the lich must use a ação Mágica within 1 minute of a creature’s death, or a Reação triggered by the creature’s death, while holding the vessel to capture the soul, and the dead creature’s body must be within 18 m of the vessel when the capture occurs. The creature cannot be returned to life until its soul is removed from your soul vessel.

Se vocêr soul vessel is reduced to 0 hit points, you must create a new one. Doing so takes a Descanso Longo. Until you do, you do not gain any of the benefits of having the soul vessel. Also, until you have a soul vessel, you have Desvantagem on the first Teste D20 you make after finishing a Short or Descanso Longo.

Se você are killed while you control a charged soul vessel on the same plane of existence, your soul vessel’s charge is consumed. Você é brought back to life as per the Resurrection spell within 1,5 m of your soul vessel 1 day later. Se você are killed e seu soul vessel is not charged, you are resurrected 7 days later instead.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 7, 'Estágio 2', 'Quando você alcança o estágio 2 da Transformação em Lich, escolhe uma Bênção do estágio 2 e ganha a Falha do estágio 2.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 8, 'Bênção do estágio 2: Acolyte of Undeath', 'Quando você reduce a Humanoidee to 0 Pontos de Vida and it dies, você pode use a Reação to immediately transform it into a Zombie under your control. Você pode have three such creatures under your control at once. These Zombies act on their own initiative count, following your verbal commands to the best of their ability.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 9, 'Bênção do estágio 2: Binding Curse', 'Você pode compel a creature with a binding curse. Como Ação Bônus, choose a creature within 9 m who can see you. That creature makes a Carisma salvaguarda against a CD of 12 mais seu Estágio de Transformação. On a failed save it cannot move more than 9 m away from you por 1 minuto. Also, during that time, your weapon attacks and Ataque Desarmados against the creature deal an additional 2d6 dano Necrótico.

Você pode usar este recurso three times, regaining all uses after finishing a Descanso Curto or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 10, 'Bênção do estágio 2: Corrupting Magic', 'Sempre que você matar uma criatura com uma magia, pode aplicar um efeito adicional conforme o dano causado. Esta habilidade não pode ser usada ao matar um Constructo, Morto-vivo ou qualquer criatura sem alma.

Escolha um dos efeitos a seguir ao usar esta habilidade:

Life Force. As the soul of your enemy leaves their body, you siphon off part of their life force. You regain 1d6 Pontos de Vida per Estágio de Transformação.

Poison. Choose a creature within 3 m of the killed creature. That creature takes 1d6 dano de Veneno per Estágio de Transformação.

Exhaustion. Choose a creature within 3 m of the killed creature. That creature gains one nível de Exaustão. A creature may only have one nível de Exaustão from este recurso at a time.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 11, 'Falha do estágio 2: Hideous Appearance', 'Your appearance has grotesquely transformed. Your flesh withers and contracts around your bones, your eyes become sunken, and you reek of death. Regardless of your true form, you’re horrific to behold.

Você pode suspend this form and manifest the appearance of the humanoid you once were, but this is taxing and requires effort. This form is not permanent, and moments of stress are likely to reveal your true nature. Your true form may be revealed in o seguinte situations:

• Becoming Ferido

• Concentrating on a spell

• Having the Unconscious condition

• Entering hallowed ground

• Choosing to reveal yourself

In these events, or times of other extreme emotional or physical stress, a GM can call or a Constituição salvaguarda with a CD based on your current Estágio de Transformação. Se você fail this save, your Horrific Appearance is revealed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 12, 'Estágio 3', 'Quando você alcança o estágio 3 da Transformação em Lich, escolhe uma Bênção do estágio 3 e ganha a Falha do estágio 3.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 13, 'Bênção do estágio 3: Eldritch Concentration', 'Your supernatural ability with magic manifests in new ways. Quando você cast a spell that requires Concentração , se você are already concentrating on one such spell, você pode spend the charge of your soul vessel . Se você do this, you do not lose Concentração on the original spell. Instead, you gain 1 nível de Exaustão.

Se você cast a third Concentração spell during this time, or lose Concentração for any other reason, you lose Concentração on both current spells you are concentrating on. Depois de usar este recurso você podenot use it again until you finish a Descanso Curto or Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 14, 'Bênção do estágio 3: Master of Undeath', 'Undead creatures under your control from a Lich Transformação Boon have Vantagem on jogada de ataques when they are within 1,5 m of you.

Além disso, whenever an Undead creature you control due to a Lich Transformação Boon is reduced to 0 Pontos de Vida, você pode spend the charge of your soul vessel como Reação . Se você do, that Undead creature is at 1 hit point instead and may immediately move up to its full speed and make an ação Atacar with Vantagem. This feature has no effect if the creature has been reduced to 0 Pontos de Vida by dano Radiante.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 15, 'Bênção do estágio 3: Unholy Healing', 'Your magical connection to your soul vessel restores your vitality quickly. While your soul vessel is charged, você pode use a ação Mágica to draw healing power from it. No início de each of your turns por 1 minuto, você recupera 10 Pontos de Vida. The soul vessel does not lose its charge.

Você pode usar este recurso three times, and você recupera all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 16, 'Falha do estágio 3: Necromantic Dystrophia', 'Quando vocêr soul vessel is not charged, you suffer o seguinte effects:

• Você podenot use the Dash , Dodge , or Desengajar actions.

• Você podenot use Reaçãos.

• Você tem Desvantagem em Constituição salvaguardas.

• Você podenot disguise your Aparência Horrível .

Upon charging your soul vessel with an appropriate soul, you are no longer subject to these effects.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 17, 'Estágio 4', 'To move from one stage to the next higher one in this Transformação, an event or some other notable occurrence tied to the story of the character should take place. The following events are suggestions for ones that might trigger a move to the next stage of the Transformação:

• Discover ancient and dark arcane knowledge

• Consume the soul of an exceptionally powerful spellcaster

• Build a monument to your power to serve como giant arcane focus

• Create or lead an army of undead

• Meditate in the glow of a powerful arcane item or location

• Kill an Arquidaemônio or Arch Seraph and absorb their power

Quando você alcança o estágio 4 da Transformação em Lich, escolhe uma Bênção do estágio 4 e ganha a Falha do estágio 4.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 18, 'Bênção do estágio 4: Eldritch Omniscience', 'Você tem better mastered the magical arts. The number of spells você pode learn and can have prepared increases by 4. Além disso, whenever you finish a Descanso Curto or Descanso Longo you gain 1 additional espaço de magia of whichever level você escolhe.

If a creature dies como result of one of your spells, você pode instantly draw that soul into your soul vessel without using a ação Mágica or Reação .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 19, 'Bênção do estágio 4: Lord of Undeath', 'Quando você use Acolyte of Undeath você pode choose to transform the target into a Ghoul instead of a Zombie .') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 20, 'Bênção do estágio 4: Soul-Shattering Attack', 'After you make a weapon attack or Ataque Desarmado , você pode spend the charge in your soul vessel to add the ND of the soul within it to the jogada de ataque and damage dealt with that attack. If the creature dies from that attack, você pode instantly recharge your soul vessel with the soul that you just expended.

Você pode usar este recurso um número de times igual a 4 mais seu Bônus de Proficiência. You regain all uses after finishing a Descanso Longo.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 21, 'Falha do estágio 4: Weight of the Ages', 'The weight of time is degrading for your form, and only the magic of your soul vessel holds it together. Se vocêr soul vessel is reduced to 0 hit points, your soul is lost; you are killed instantly e seu body crumbles to dust.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 22, 'Apêndice: Aparência Horrível Save CD', 'Stage | Constituição Save CD
2 | 13
3 | 16
4 | 20') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 23, 'Apêndice: Reverter traços de Lich', 'Reverter traços de Lich

The amount of raw magical energy that goes into becoming a Lich means that undoing it is impossible. The only stage beyond lichdom is annihilation, and even that can only occur if both the physical form of the lich and its soul vessel are both destroyed.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description) VALUES ((SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'), 24, 'Apêndice: The Making of a Lich', 'The Making of a Lich

In most fantasy stories, lichdom isn’t just something that happens to an innocent person. Becoming a Lich takes years of research, countless sacrifices for yourself and others, and the incredibly low moral and ethical standards necessary to follow through. The years or even decades of meticulous planning and study are infused into the mythology of what lichdom means.

For the Lich Transformação, that mythology may need to be rewritten slightly. The power of Liches comes much more quickly, or perhaps even accidentally, or through a curse. Liches may not be the all-powerful geniuses they are thought to be. They might be tricked or forced to undergo a transition to lichdom. They may even think they are free agents, but the forces that turn them into Liches are using them for other purposes.') ON CONFLICT (feat_id, sort_order) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
