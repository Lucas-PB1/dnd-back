-- Grim Hollow Cap. 2 — subclass features
-- Fonte: D:/Projetos/dnd-work/dnd-api/docs/source/extracts/grim-hollow/cap2-subclasses-en.json

DELETE FROM rpg.phb_subclass_feature f
USING rpg.phb_subclass s, rpg.phb_source_citation sc
WHERE f.subclass_id = s.id
  AND s.source_citation_id = sc.id
  AND sc.slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes';

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  3,
  'Preparado para a Batalha',
  'Você ganha treinamento com armadura pesada.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  3,
  'Corpo a Corpo',
  'Your skill in close combat enables you to inflict crushing blows while keeping your opponent off balance. Quando você acerta uma creature with uma jogada de ataque using a arma corpo a corpo, você pode take a Reação to deal an extra 2d6 damage of the same type dealt by the weapon. That creature has Desvantagem on its next jogada de ataque before the start of your next turn. The damage becomes 4d6 when you reach Caçador de Monstros level 11.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  7,
  'Determinação Inabalável',
  'Você tem Vantagem on salvaguardas you make to avoid or end the condição Amedrontado, and you are immune to the condição Amedrontado caused by creature types in your Grimório de Monstros. Além disso, when you hit a creature with an attack como parte de uma Reação, você pode choose a Amedrontado creature within 18 m that can see you (including yourself). The condition ends on that creature.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  10,
  'Aterrorizar os Terrores',
  'Your reputation has become such that monsters preying on the fearful have come to fear you. Quando você acerta uma creature with an attack como parte de uma Reação, você pode force the creature to make a Sabedoria salvaguarda or have the condição Amedrontado até o fim do seu próximo turno. The CD for the salvaguarda equals 8 mais seu modificador de Inteligência e seu Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  15,
  'Redirecionamento Mortal',
  'Your strikes have become even deadlier. The extra damage of your Close Quarters increases to 6d6. Além disso, se você deal damage to a creature with Close Quarters, the target has Desvantagem on all jogada de ataques até o fim do seu próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'),
  18,
  'Passos Controlados',
  'Você é such an effective combatant that you are always in control and never off balance. Você pode realizar a Reação twice in a round instead of once.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  3,
  'Alquímica Gastronomia',
  'Você ganha proficiência com Alchemist’s Supplies and Cook’s Utensils .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  3,
  'Metabolismo Transmutador',
  'Você ganha a capacidade de consume monster remains, o que faz com que your body to adopt powerful and frightening mutations. These appear in the “ Mutations ” section later in the subclass’s description. Salvaging Portions. Como ação Utilizar, você pode harvest a single portion from the physical remains of a creature. Only one portion can be harvested from each creature. Record the monster’s creature type. A harvested portion lasts until you finish a Descanso Longo, at which point it loses its potency. Consuming Portions. Como Ação Bônus, você pode consume a portion. After you consume the portion, você escolhe a mutation to gain, dependendo de the creature’s type. Você pode gain the benefits of consumed portions um número de vezes até 1 mais seu modificador de Inteligência (mínimo de 1). Quando você termina um Descanso Longo, você recupera the ability to consume portions. Você pode benefit from multiple portions simultaneously, but você pode''t gain the same mutation more than once at the same time.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  7,
  'Sincronizada Resposta',
  'Your ingestion of monsters heightens your understanding of them and their behaviour. Você ganha this additional effect when you consume a monster portion: For 1 minute, when you make an attack como parte de uma Reação, você causa an extra 1d6 damage. This damage has do mesmo tipo que the weapon or Ataque Desarmado used for the attack.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  10,
  'Roedora Fome',
  'Your hunger for your enemy allows you to partake of its essence during battle. Quando você deal damage to a creature with a melee attack using a weapon or Ataque Desarmado , you gain Pontos de Vida Temporários igual a half the damage dealt. If the target is a creature type in your Grimório de Monstros, you instead gain Pontos de Vida Temporários igual a the damage dealt instead. Você pode usar este recurso um número de times igual a your modificador de Inteligência (mínimo de once). You regain all expended uses when you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  15,
  'Alquímica Decocções',
  'Você pode spend 1 hour and 20 PO worth of alchemical ingredients (such as special herbs or monster salvage) to use your Alchemist’s Supplies to convert a monster portion into a decoction. A decoction is a magic potion that grants the benefits of a consumed monster portion. Você pode have 4 unconsumed decoctions active. Você pode destroy a decoction como ação Utilizar. A creature other than você pode consume 1 decoction without adverse effects. A creature gains 1 nível de Exaustão for each decoction it consumes after the first. A creature must finish a Descanso Longo before it regains the ability to safely consume a decoction.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
  18,
  'Adquirido Paladar',
  'Your hunger for monster portions has increased to the point of being insatiable. Você pode now consume 1 additional portion safely. Além disso, por 1 minuto when you consume a portion, you have Vantagem , on jogada de ataques made como parte de uma Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  3,
  'Acólito de the Oculto',
  'Você ganha proficiency in the Arcana skill.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  3,
  'Conjuração',
  'Your study of the occult gives you the ability to cast spells. Truques. Você aprende dois truques de sua escolha from the magia de Mago list. Sempre que você gain a Caçador de Monstros level, você pode replace one of these truques with another de sua escolha from the magia de Mago list. Quando você alcança Caçador de Monstros level 10, you learn another Wizard cantrip de sua escolha. Espaços de Magia. The Occultist Spellcasting table shows how many espaços de magia you have to cast your level 1+ spells. You regain all expended espaços de magia when you finish a Descanso Longo. Prepared Spells of Level 1+. You prepare the list of level 1+ spells that are available for you to cast with este recurso. To start, choose three level 1 magia de Magos. Burning Hands , Detect Magic , and Protection from Evil and Good are recommended. The number of spells on your list increases as you gain Caçador de Monstros levels, as shown in the Prepared Spells column of the Occultist Spellcasting table. Whenever that number increases, choose additional spells from the magia de Mago list until the number of spells on your list matches the number on the table. The chosen spells must be of a level for which you have espaços de magia. For example, se você’re a level 7 Caçador de Monstros, your list of prepared spells can include five magia de Magos of levels 1 and 2 in any combination. Changing Your Prepared Spells. Sempre que você gain a Caçador de Monstros level, você pode replace one spell on your list with another magia de Mago. Spellcasting Ability. Inteligência is sua habilidade de conjuração for your magia de Magos. Foco de Conjuração. Você pode usar an Foco Arcano as Foco de Conjuração for your magia de Magos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  3,
  'Arcana Interferência',
  'Você tem Vantagem on salvaguardas against spells cast by creature types in your Grimório de Monstros. Além disso, when a creature você pode see within 18 m of you casts a spell or makes a spell attack, você pode use Resposta Estudada against that creature before the spell is cast.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  7,
  'Mago Caçador',
  'You consider Humanoideees that can cast spells as being a creature type in your Grimório de Monstros. Além disso, when you damage a creature type in your Grimório de Monstros that is concentrating, it has Desvantagem on the salvaguarda it makes to maintain its Concentração . Say what you will about their methods. The results speak for themselves. —Arcanist Inquisitor'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  10,
  'Oculto Knowledge',
  'Your knowledge of magic has increased so that you learn to cast Rituals. Você pode conjurar any spell como Ritual if that spell has the Ritual tag and it’s a spell you have prepared. Além disso, you learn two spells de sua escolha. These spells can come from the Cleric, Druid, or magia de Mago list or any combination thereof (see a class’s section for its spell list). A spell você escolhe must have the Ritual tag. Quando você alcança Caçador de Monstros level 14, você pode replace one of the spells você conhece from este recurso with another spell de sua escolha from any spell list. The new spell must have the Ritual tag.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  15,
  'Mágico Égide',
  'Você ganha a capacidade de extend a protective charm. You radiate an unseeable aura in a 6 m Emanação that originates from you. The aura is inactive while you have the Incapacitado condition. You and allies in your aura have Vantagem on salvaguardas against spells cast by creature types in your Grimório de Monstros. Além disso, you always have the Counterspell spell prepared. Você pode conjurar Counterspell once without expending a espaço de magia. Uma vez você cast the spell with este recurso, você pode’t do so in this way again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'),
  18,
  'Resposta Arcana',
  'Você tem learned to anticipate your enemies well enough to rapidly cast spells in response to their attacks. Quando você use Resposta Estudada, você pode cast a spell. The spell must have a casting time of an action and must target only that creature.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  3,
  'Furtiva e Astuta',
  'Você ganha proficiency in the Stealth skill and with Tinker’s Tools .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  3,
  'Gadgets de Armadilheiro',
  'Você aprende to create gadgets and mechanisms that help you during the hunt. As part of a Descanso Longo, você pode craft two Trapper Gadgets se você have materials and Tinker’s Tools on hand. Also, with 1 hour of work with such a kit and expending 20 PO worth of materials (such as equipment or monster salvage), você pode create one Trapper Gadget from the list below. Some Trapper Gadgets allow your target to make an ability check or salvaguarda to resist the gadget’s effects. The salvaguarda CD is calculated as follows: Trapper Gadgets Save CD = 8 + your modificador de Inteligência + your Bônus de Proficiência Trapper Gadgets Trapper Gadgets are listed in alphabetical order. Dread Venom. A foul-smelling blade oil that causes wounds to hemorrhage and refuse healing. Dread Venom can coat one Cortante or Perfurante weapon or up to 10 pieces of Cortante or Perfurante ammunition. Applying the oil takes 1 minute and the oil lasts 8 hours once applied. When a creature takes damage from the poisoned item, it can’t regain Pontos de Vida until it finishes a Short or Descanso Longo. Elemental Ammunition. The head of an arrow or bolt is tipped with poison, loaded with an acid vial, dipped in flammable oil, or coated with another substance. Como Ação Bônus, you imbue with elemental power a single piece of ammunition that can be fired from a Longbow , Shortbow , or Crossbow como parte de uman ação Atacar. When a Elemental Ammunition is imbued, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. When a creature takes damage from the Elemental Ammunition, it takes an additional 2d6 damage of the chosen type. Elemental Ammunition discharges its energy if it hits, and it can’t be recovered. If the attack misses, the Elemental Ammunition can be recovered and used again. Elemental Ammunition retains its power for 48 hours. Runic Bomb. Runic Bombs are used to hunt creatures resilient to mundane weapons. Como Ação Bônus, você pode throw the runic bomb at a point within 18 m que você possa ver, creating a 6 m-radius Sphere centered on that point. The Sphere spreads around corners, and its area is Lightly Obscured . It lasts por 1 minuto or until a strong wind (such as one created by Gust of Wind ) disperses it. Whenever Contundente, Perfurante, and Cortante damage is dealt to a creature inside the sphere, that damage is dano de Força instead of its normal damage type. A Runic Bomb is destroyed after a single use. Scorpion Anchor. This weapon is intended to keep flying foes anchored to the ground or stop monsters from fleeing. The Scorpion Anchor can be fired from a Longbow, Shortbow, or Crossbow como parte de uman ação Atacar. Quando você acerta uma creature with uma jogada de ataque using a Scorpion Anchor, it has the Restrained condition. A creature Restrained by the Scorpion Anchor can take an action to make a Força ( Athletics ) check against your Trapper Gadget save CD. If it succeeds, it is no longer Restrained. A Scorpion Anchor is destroyed after the Restrained creature escapes or dies. Terrain Cloak. Composed of local materials, a Terrain Cloak allows wearers to conceal themselves within the environment. Terrain Cloaks can be worn over Light or Medium armor and are donned and doffed with the speed of Light armor. Creatures have Desvantagem on Sabedoria ( Perception ) checks to see you. The item lasts until you finish a Descanso Longo, at which point the item falls apart. Weretrap. A Weretrap detonates when its fragile exterior is broken. Você pode realizar a ação Utilizar to set the Weretrap in an unoccupied space within 1,5 m of you. A creature within 9 m must succeed on a Sabedoria ( Perception ) check against your Trapper Gadget CD to spot the trap. Creatures have Desvantagem on this check. A creature that steps into a space containing a Weretrap triggers the trap and makes a Destreza salvaguarda. On a failed save, the creature takes 3d10 Contundente damage and has the condição Caído. On a successful save, the creature takes half as much damage only. The Weretrap can also be used como Light arma à distância with the Finesse and Thrown property. It hcomo normal range of 6 m and a long range of 18 m. On a hit, the Weretrap deals 3d10 Contundente damage and the target has the condição Caído. The Weretrap is destroyed after it is triggered or thrown, regardless of whether it hits or misses.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  7,
  'Ambusher’s Vantagem',
  'Você tem become a ferocious ambusher. Quando você rola Initiative, você pode add your modificador de Inteligência to the roll. Além disso, você pode’t be surprised by enemies that include creature types in your Grimório de Monstros.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  10,
  'Resposta Ágil',
  'Você pode leap aside to avoid enemies rushing toward you. When a creature makes a melee jogada de ataque against you, você pode take a Reação to impose Desvantagem on that roll and use your Resposta Estudada as part of the same Reação. Whether the attack hits or misses, você pode then move up to half your Speed . This movement doesn’t provoke Opportunity ação Atacar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  15,
  'Armadura de Pele de Monstro',
  'Você tem learned to craft a set of Light or Medium armor by using dragon scales, werewolf hide, troll leather, or a similar monster component. The armor takes on the appearance de sua escolha, reflecting the component it is made from. The armor has the same properties as Light or Medium armor (sua escolha when the armor is crafted) and gains two modifications from the Armor Modifications list. Sempre que você gain a Caçador de Monstros level, você pode replace one of these modifications with another modification. Modifications require the armor to be worn to function. Armor Modifications Armor modifications are listed in alphabetical order. Damage Resistência. The monster hide used to craft your armor grants some resistances. Você ganha Resistência to two of o seguinte damage types de sua escolha: Acid, Cold, Fire, Lightning, Poison, or Thunder. Elemental Charge. You embed your armor with a Construct’s gemstone or infuse it with the power of an Elemental. Choose one of o seguinte damage types: Acid, Cold, Fire, Lightning, Poison, or Thunder. Quando você acerta uma creature with an attack, você pode cause it to deal the chosen damage type rather than its normal damage type, and the attack deals an extra 1d6 of that type. Hardened Defense. Hardened scales or magical pelts make your armor difficult to pierce. While wearing your crafted armor, you gain a +2 bonus to Armor Class. Phase Leap. Você tem powdered your armor with fey dust or sewn a pelt of a phase-shifting monstrosity into it. Como Ação Bônus, you teleport up to 18 m to an unoccupied space você pode see. Você pode usar este recurso three times, and você recupera all expended uses when you finish a Descanso Longo. Regeneration. You reinforce the armor with troll hide or soak it in vampire blood. Você tem a pool of six d10s. Como Ação Bônus, você pode expend a die from the pool, roll that die and add your modificador de Constituição, and regain um número de Pontos de Vida igual a the roll’s total. You regain all the expended dice when you finish a Descanso Longo. Stealthy. Your armor is draped with a shadowy cloak or made from hide as light como feather. Your armor doesn’t impose Desvantagem on Destreza ( Stealth ) checks, even if it would normally. While wearing your armor, creatures have Desvantagem on Sabedoria ( Perception ) checks to see you, and you have Vantagem on Sabedoria ( Perception ) checks to notice creatures.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
  18,
  'Rápida Engenheiro',
  'Você tem become capable of crafting trapper tools at a much faster rate. Você pode spend 1 minute to make a Trapper Gadget without spending PO or components. Você pode usar este recurso twice, and você recupera all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  3,
  'Face de Fúria',
  'Quando você activate sua Fúria, your countenance distorts e seu body swells. Creatures that haven’t witnessed your transformation, now or previously, don’t recognize you. Além disso, while sua Fúria is active, you gain o seguinte benefits: Você pode roll 1d8 in place of the normal damage of your Ataque Desarmado , and whenever você causa damage with an Ataque Desarmado, it can deal sua escolha of dano de Força or its normal damage type. Quando você acerta uma creature with an Ataque Desarmado, você pode push it 3 m or force the creature to make a Constituição salvaguarda (CD 8 mais seu modificador de Força e seu Bônus de Proficiência). On a failed save, the creature has the condição Caído. You count as one size larger when determining the success or failure of a Grapple, and when you make an Ataque Desarmado, your reach is 1,5 m greater than normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  3,
  'Máscara de Civilidade',
  'Você é proficient in one of o seguinte skills de sua escolha: Arcana , History , Investigation , Medicine , Nature , Persuasion , or Religion . Além disso, you gain proficiency with one type of Artisan’s Tools de sua escolha or você conhece one language de sua escolha.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  6,
  'Cérebro e Músculo',
  'While sua Fúria is not active, you have Resistência to dano Psíquico. While sua Fúria is active, you have Resistência to every damage type except Force and Psychic.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  10,
  'Astúcia e Brutalidade',
  'While sua Fúria is not active, você pode take the Desengajar or ação Ajudar como Ação Bônus. While sua Fúria is active, your jogada de ataques with Ataque Desarmados score a Acerto Crítico on a roll of 19 or 20 on the d20.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-fractured'),
  14,
  'Melhor Half',
  'Quando você are reduced to 0 Pontos de Vida and not killed outright, você pode drop to 1 Hit Point instead, and you gain Pontos de Vida Temporários igual a half your máximo de Pontos de Vida. Além disso, se vocêr Rage is active, sua Fúria ends. Se vocêr Rage was not active, you immediately activate sua Fúria (even se você have no remaining uses of sua Fúria). If any of these Pontos de Vida Temporários remain after 1 minute, they vanish. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  3,
  'Primordial Companheiro',
  'You magically summon a primal spirit that adopts the form of a beast and accompanies you on your adventures. Choose its stat block: Primal Guardian or Primal Striker. Além disso, choose an environment that will modify the creature’s stat block: Land, Sea, or Sky . You also determine the kind of animal it is, choosing a kind appropriate for the stat block. Whatever companion você escolhe, it bears eldritch markings indicating its otherworldly origin. The companion is Aliado to you e seu allies and obeys your commands. It vanishes se você die. The Beast in Combat. In combat, the companion acts during your turn. It can move and use its Reação on its own, but the only action it takes is the Dodge action unless you take a Ação Bônus to command it to take an action in its stat block or some other action. Você pode also sacrifice one of your attacks when you take the ação Atacar to command the beast to take the Beast’s Strike action. Se você have the Incapacitado condition, the companion acts on its own and isn’t limited to the Dodge action. Restoring or Replacing the Beast. If the companion has died within the last hour, você pode take a ação Mágica to touch it and expend a use of sua Fúria. The companion returns to life immediately with all its Pontos de Vida restored. Sempre que você finish a Descanso Longo, você pode summon a different primal companion, which appears in an unoccupied space within 1,5 m of you. You choose its stat block and appearance. Se você already have a beast from este recurso, the old one vanishes when the new one appears.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  3,
  'Compartilhada Fúria',
  'While sua Fúria is active, your primal companion has Resistência to Contundente, Perfurante, and Cortante damage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  6,
  'Parentesco a Feras',
  'You always have the Animal Friendship and Speak with Animals spells prepared. Você pode conjurar each of these spells without expending a espaço de magia. Uma vez você cast either spell in this way, você pode’t cast that spell in this way again until you finish a Short or Descanso Longo. Você pode also cast these spells using espaços de magia you have of the appropriate level. Constituição is sua habilidade de conjuração for them.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  10,
  'Skinrider’s Trance',
  'You take a ação Mágica to enter a trance and choose your primal companion or one Beast currently under the effect of your Animal Friendship spell within 18 m of yourself. For the duration of this trance, you possess the chosen creature. Uma vez você possess a creature’s body, you control it. Your Pontos de Vida, Dados de Vida, Força, Destreza, Constituição, Speed , and senses are replaced by the creature’s. You otherwise keep your game statistics. This possession ends se você choose to exit the trance (no action required by you), if the Beast you’re possessing is reduced to 0 Pontos de Vida, or se você and the Beast are on different planes of existence. While in this trance, your body falls into a catatonic state. Você pode’t move or take Reaçãos, and you’re unaware of your surroundings. Você pode remain in the trance for um número de hours up to half your Barbarian level mais seu modificador de Constituição. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Você pode also restore your use of it by expending one use of sua Fúria (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  14,
  'Forma de the Selvagem',
  'Como Ação Bônus, você pode choose a new form for your primal companion, causing it to transform instantaneously. Quando você cause your primal companion to transform in this way, its current Pontos de Vida change to its new máximo de Pontos de Vida. Depois de usar este recurso, você pode’t use it again until you finish a Short or Descanso Longo. Você pode also restore your use of it by expending one use of sua Fúria (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  3,
  'Fúria de the Dead',
  'Your Rage taps into the endless fury of the unquiet dead. While sua Fúria is active, you take on aspects of restless spirits and you gain o seguinte benefits. Shadow Form. You ignore Difficult Terrain . Além disso, você pode move through the space of any creature, but você pode’t end your move in an occupied space. Lucas Torquato Shadowy Sidestep. Your Speed increases by 3 m, and Opportunity ação Atacar have Desvantagem against you. Spectral Sight. You see creatures and objects within 36 m that have the Invisible condition as if they were visible, and você pode see into the Ethereal Plane.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  3,
  'Final Noite Catarse',
  'Você é overcome by an emotion a nearby spirit experienced at its death. Você ganha um of as seguintes opções de sua escolha. Sempre que você finish a Descanso Longo, você pode change sua escolha. Hate. Quando você miss with uma jogada de ataque against a creature, you have Vantagem on the next jogada de ataque you make against it before the end of your next turn. Jealousy. When a creature you have Agarrado is about to make an ability check to end the condição Agarrado on itself, você pode take a Reação to impose Desvantagem on that roll. Terror. While you are Ferido , você pode take a Ação Bônus to take the Dash or Desengajar action.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  6,
  'Sombria Perdição Revisited',
  'Uma vez por Rage, você pode take a ação Mágica to channel a traumatic death. Quando você do, choose one of as seguintes opções. Contamination. No início de their turn, each creature de sua escolha in a 3 m Emanação originating from you must make a Constituição salvaguarda (CD 8 mais seu modificador de Constituição and Bônus de Proficiência) or take dano de Veneno and gain the condição Envenenado por 1 minuto. To determine the dano de Veneno, roll um número de d6s igual a sua Fúria Damage bonus, and add them together. An affected creature can use an action to end the condição Envenenado on itself. Hypothermia. No início de their turn, each creature de sua escolha in a 3 m Emanação originating from you must make a Constituição salvaguarda (CD 8 mais seu modificador de Força and Bônus de Proficiência) or take dano Gélido and have its Speed halved por 1 minuto. To determine the dano Gélido, roll um número de d6s igual a sua Fúria Damage bonus, and add them together. A creature can use an action to end this effect on itself. Immolation. No início de their turn, each creature de sua escolha in a 4,5 m Emanação originating from you must make a Destreza salvaguarda (CD 8 mais seu modificador de Constituição and Bônus de Proficiência) or take dano de Fogo. To determine the dano de Fogo, roll um número de d6s igual a sua Fúria Damage bonus, and add them together. As an action, a creature can extinguish the fire on itself by giving itself the condição Caído and rolling on the ground. The fire also goes out if it is doused, submerged, or suffocated.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  10,
  'Morte É Mas a Porta',
  'Your familiarity with death has left you resistant to its call. Você ganha os seguintes benefícios. Hard to Kill. Você tem Vantagem on Death Salvaguardas. Além disso, you must fail four Death Salvaguardas to die instead of three as normal. Return the Spirit. Você pode call the spirits of the deceased to restore life essence to a nearby creature. Você pode conjurar the Cure Wounds , Raise Dead , or Revivify spell without providing Material components. Quando você do, you gain 1 nível de Exaustão for Cure Wounds , 2 Exhuastion levels for Revivify , and 3 nível de Exaustãos for Raise Dead . Constituição is sua habilidade de conjuração for este recurso. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo unless you expend two uses of sua Fúria (no action required) to restore your use of it. He’s a creepy fella, always muttering to himself and seeing things that just aren’t there. But there’s no one I’d rather have watching my back.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-wrathful-dead'),
  14,
  'Alimentado by Pathos',
  'Your Rage is empowered by the overwhelming emotions of the unquiet dead. Your Final Night Catharsis feature grants an additional effect based on the chosen emotion. Hate. While sua Fúria is active, your attacks with weapons and Ataque Desarmados score a Acerto Crítico on a roll of 19 or 20 on the d20. Jealousy. Whenever a creature você pode see starts its turn within 9 m of you while sua Fúria is active, você pode take a Reação to summon spectral assailants to Grapple the creature. The creature makes a Força or Destreza salvaguarda (CD 8 mais seu modificador de Constituição and Bônus de Proficiência). On a failure, the creature has the condição Agarrado até o fim de its turn. On a successful save, the creature is not Agarrado; however, each foot of movement costs 1 extra foot for that creature até o fim de its turn. Terror. Whenever a creature você pode see starts its turn within 9 m of you while sua Fúria is active, você pode take a Reação to make that creature terrified until the start of its next turn. A terrified creature’s Speed is halved and Opportunity ação Atacar against it have Vantagem .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  3,
  'Talentoso Aventureiro',
  'Você aprende an adventurer’s talent de sua escolha from the “ Adventurer’s Talent Options ” section later in esta subclasse’s description. Você aprende um adicional adventurer’s talent de sua escolha when you reach Bard levels 6 and 14.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  3,
  'Festa Organizador',
  'While a creature hcomo Bardic Inspiration die from you, it can use a Ação Bônus to take the ação Ajudar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  6,
  'Bem Preparado',
  'Você ganha proficiência com one type of Artisan’s Tools de sua escolha, you gain proficiency in one skill de sua escolha, and você conhece one language de sua escolha.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-adventurers'),
  14,
  'Improvisacional Talento',
  'Quando você termina um Descanso Longo, você pode choose one adventurer’s talent você conhece and replace it with one you don’t. Just show me what você pode. I promise, I’m a quick study.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  3,
  'Antagônica Travessuras',
  'You know the Vicious Mockery cantrip. Se você already know it, you learn a different Bard cantrip de sua escolha. The cantrip doesn’t count against your number of truques known. Além disso, you always have the Dissonant Whispers spell prepared. Além disso, when you take the Dash , Desengajar , or Influence action no seu turno, você pode take a Ação Bônus on the same turn to cast Vicious Mockery .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  3,
  'Cruel Gracejo',
  'When a creature que você possa ver or hear within 9 m of yourself fails a Teste D20 , você pode take a Reação to expend one use of your Bardic Inspiration; roll your Bardic Inspiration die and deal dano Psíquico igual a the number rolled mais seu modificador de Carisma. Além disso, the creature has Desvantagem on the next Teste D20 it makes before the end of its next turn.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  6,
  'Forca Humor',
  'When a creature que você possa ver within 18 m of you is reduced to 0 Pontos de Vida or killed outright, você pode take a Reação to regain an expended use of your Bardic Inspiration. Quando você do so, choose a creature within 9 m of you that can hear and understand you. That creature must succeed on a Sabedoria salvaguarda against your spell save CD or gain the condição Caído and have its Speed reduced to 0 até o fim de its next turn. If the creature succeeds on the Sabedoria salvaguarda, você recupera the use of this ability. Otherwise, once you use este recurso, você pode’t use it again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
  14,
  'Última Risada',
  'Quando você become Ferido or take damage while you are Ferido, você pode take a Reação to regain all expended Bardic Inspiration dice and break out into a cackling fit of fatalistic glee at your own impending doom. For 1 minute, you have Resistência to all damage. Also, when a creature within 18 m of you hits you with uma jogada de ataque, você pode expend up to three Bardic Inspiration dice to force the attacker to make a Carisma salvaguarda against your spell save CD. On a failure, the creature takes dano Psíquico igual a the total rolled on the Bardic Inspiration dice mais seu modificador de Carisma. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  3,
  'Gélida Melodia',
  'Você aprende dois Necromancy truques de sua escolha. These count as Bard spells for you but don’t count against the number of truques você conhece.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  3,
  'Arrancar the Corações',
  'Your Bardic Inspiration can pluck at the tethers of life. Each creature that hcomo Bardic Inspiration die from você pode use it for one of o seguinte effects. Defense. When the creature is reduced to 0 Pontos de Vida and not killed outright, the creature can roll the Bardic Inspiration die to be reduced to um número de Pontos de Vida rolled on the Bardic Inspiration die instead. Offense. Immediately after the creature hits a target with uma jogada de ataque, the creature can roll the Bardic Inspiration die and add the number rolled as extra dano Necrótico dealt by the attack.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  6,
  'Agitar the Ossos',
  'You always have the Animate Dead spell prepared. It counts como Bard spell for you. Quando você expend a use of Bardic Inspiration, choose Undead creatures under your control within 18 m of yourself, up to a number igual a your modificador de Carisma (mínimo de one creature). The chosen creatures each gain a Bardic Inspiration die. These extra Bardic Inspiration dice do not count against your limit. When an Undead creature under your control expends a Bardic Inspiration die on uma jogada de ataque, it can also add the number rolled on the Bardic Inspiration die to the attack’s jogada de dano if that attack hits.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
  14,
  'Dupla Morte',
  'Quando você cast a Necromancy spell that targets only one creature, você pode have it target a second creature within range. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Você pode also restore your use of it by expending one use of your Bardic Inspiration dice (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  3,
  'Magias — Eldritch',
  'Your connection to this divine domain ensures you always have certain spells ready. Quando você alcança a Cleric level specified in the Eldritch Domain Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  3,
  'Eldritch Contagion',
  'You’ve been gifted with the ability to impart a fleeting taste of the unknowable on others. Quando você realiza a ação Mágica to cast a spell using a espaço de magia that targets one or more creatures, você pode force one target of the original spell to make a Sabedoria salvaguarda against your spell save CD. On a failed save, roll on the Eldritch Effects table, and the target creature suffers that effect por 1 minuto. No fim de each of its turns, the target repeats the save, ending the effect on itself on a success. This effect ends early se você use este recurso again.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  3,
  'Profecia de Perdição',
  'Como ação Mágica, you expend a use of your Channel Divinity to choose a point within 36 m of you que você possa ver and roll on the Eldritch Effects table. Each creature in a 4,5 m-radius Sphere centered on that point must succeed on a Sabedoria salvaguarda against your spell save CD or suffer the rolled effect por 1 minuto. No fim de each of its turns, the target repeats the save, ending the effect on itself on a success.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  6,
  'Sobrenatural Calm',
  'Você tem Resistência to dano Psíquico and Vantagem on salvaguardas to avoid or end the Charmed and condição Amedrontados. Além disso, your thoughts can’t be read by telepathy or other means unless you allow it. The attempt automatically fails, and the creature must succeed on a Sabedoria salvaguarda against your spell save CD or take dano Psíquico igual a your Cleric level.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-domain'),
  17,
  'Cantar the Song that Ends the Mundo',
  'When a creature fails a Sabedoria salvaguarda against your Prophecy of Doom feature, você pode deal 10d10 dano Psíquico to it. Once a creature takes damage in this way, it is immune to this effect for 10 minutes, after which it can be affected again.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  3,
  'Magias — Inquisition',
  'Your connection to this divine domain ensures you always have certain spells ready. Quando você alcança a Cleric level specified in the Inquisition Domain Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  3,
  'Bruxa Hunter’s Golpe',
  'Quando você acerta uma creature with a weapon attack or Ataque Desarmado , você pode deal an extra 1d8 dano de Força to the target. If the creature is concentrating on a spell, você causa an extra 2d8 dano de Força instead. At Cleric level 14, the extra dano de Força increases to 2d8, or 3d8 if the creature is concentrating on a spell. If a creature fails its salvaguarda to maintain Concentração como result of taking damage from este recurso, you gain Pontos de Vida Temporários igual a the extra dano de Força dealt. Você pode usar este recurso um número de times igual a your modificador de Sabedoria (mínimo de once). You regain all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  3,
  'Magia Shield',
  'Como Ação Bônus, você pode expend one use of your Channel Divinity to bestow a temporary resilience against arcane harm for 10 minutes. Choose a creature você pode see (including yourself) within 9 m of yourself. The chosen creature gains Pontos de Vida Temporários igual a 1d10 mais seu Cleric level. While a creature has Pontos de Vida Temporários granted by your Spell Escudo, the creature has Vantagem on salvaguardas against spells, and it has Resistência to the damage of spells. If any of these Pontos de Vida Temporários remain when Spell Escudo ends, they vanish.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  6,
  'Repreender Invoker',
  'Como Reação in response to a creature você pode see within 18 m of yourself using a ação Mágica to cast a spell, você pode force the creature to make a Constituição salvaguarda against your spell save CD. On a failed save, the creature takes 1d8 dano de Força, plus another 1d8 per level of the espaço de magia the creature expended. Truques are considered level 1 spells for this ability. On a successful save, the creature takes half as much damage instead. Você pode usar este recurso um número de times igual a your modificador de Sabedoria (minimum once). You regain all expended uses of este recurso when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
  17,
  'Supernal Salvaguarda',
  'Spell Escudo can target um número de creatures up to your modificador de Sabedoria (mínimo de one creature).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  3,
  'Purificar Com Fogo',
  'Quando você deal damage with a cantrip or an attack with a weapon or Ataque Desarmado , você pode deal an additional 1d8 dano de Fogo. Você pode usar este recurso um número de times igual a your modificador de Sabedoria mais seu Bônus de Proficiência (mínimo de once), and você recupera all expended uses when you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  3,
  'Magias — Purification',
  'Your connection to this divine domain ensures you always have certain spells ready. Quando você alcança a Cleric level specified in the Purification Domain Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  3,
  'Imunda Brand',
  'Quando você acerta uma creature with a melee attack with a weapon or Ataque Desarmado , instead of dealing the strike’s normal damage, você pode expend one use of your Channel Divinity to sear a symbol into the creature’s flesh, marking it with a glowing brand por 1 minuto. During that time, the creature has Desvantagem on salvaguardas against your spells. Além disso, the creature gains Vulnerability to dano de Fogo você causa, even if it normally has Resistência or Imunidade to dano de Fogo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  6,
  'Proteção Contra Corrupção',
  'Você tem Vantagem on salvaguardas to avoid or end diseases and against any effect that would change your form, such as the Polymorph spell. Como ação Mágica, você pode touch a willing creature to grant this benefit, but the creature takes dano de Fogo igual a your modificador de Sabedoria (mínimo de 1). This damage ignores Resistência and Imunidade . Uma vez você grant this benefit, it lasts por 1 hora or until you grant this benefit again.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
  17,
  'Cauterizar Imperfeições',
  'Você pode conjurar Lesser Restoration and Greater Restoration on a willing creature without expending espaços de magia and without Material components, but the target takes 1d6 dano de Fogo for each level of the espaço de magia immediately after you cast it. This damage ignores Resistência and Imunidade .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  3,
  'Magias do Círculo de Blood',
  'Quando você alcança a Druid level specified in the Circle of Blood Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  3,
  'Rito de the Sangue Moon',
  'Como Ação Bônus, você pode expend a use of your Wild Shape to adopt the violent savagery of the Blood Moon for 10 minutes. During this time, you gain o seguinte benefits: Red Resilience. Você ganha Pontos de Vida Temporários igual a three times your Druid level. Speed Increased. Your Speed increases by 3 m, and você pode take the Dash action como Ação Bônus. Violent Strikes. Quando você acerta uma creature with a weapon or Ataque Desarmado , você pode deal an extra 1d6 dano Necrótico to the target.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  6,
  'Sangue Dádiva',
  'Whenever a creature você pode see within 18 m of you is reduced to 0 Pontos de Vida, você pode take a Reação to claim the last vestiges of its vitality. You regain 1 spent Hit Die and grant a creature você pode see within 18 m of you Pontos de Vida Temporários igual a your Druid level. Você pode usar este recurso um número de times igual a your modificador de Sabedoria (minimum once). You regain one expended use when you finish a Descanso Curto, and você recupera all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  10,
  'Sangue Luxúria',
  'While your Blood Moon is active, you gain o seguinte benefits: Improved Violent Strikes. The extra dano Necrótico from your Violent Strikes increases to 2d6. Red Rage. Você tem Resistência to Contundente, Perfurante, and Cortante damage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
  14,
  'Exsanguinar',
  'Quando você use your Blood Boon, você recupera spent Dados de Vida igual a half your Druid level and give Pontos de Vida Temporários igual a twice your Druid level to um número de creatures up to your modificador de Sabedoria (mínimo de one creature) que você possa ver within 18 m of yourself. Depois de usar este recurso, você pode’t do so again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  3,
  'Catastrófico Poder',
  'Você tem mastered talents, both magical and martial, in your pursuit of the inevitable destruction of mortals and their works. Quando você termina um Short or Descanso Longo, you gain one of o seguinte benefits until you finish your next Short or Descanso Longo. Elemental Cataclysm. Como ação Mágica, você pode expend a espaço de magia to cause elemental energy to burst in a 3 m-radius Sphere centered on a point within 18 m of yourself. Choose a damage type: Acid, Cold, Fire, or Lightning. Lucas Torquato Each creature in the Sphere must make a Destreza salvaguarda against your spell save CD. On a failed save, a creature takes 1d6 damage of the chosen type per level of the espaço de magia expended, and then has Vulnerability to that damage type por 1 minuto. On a successful save, a creature takes half as much damage only. The target repeats the save at the end of each of its turns, ending the Vulnerability on a success. Ruinous Smite. Uma vez por turno when você causa damage with an attack with a weapon or an Ataque Desarmado , você pode choose to expend a espaço de magia to deal an extra 1d8 dano Necrótico, plus another 1d8 per level of the espaço de magia. Maestria em Armas. Your supernatural connection to destruction allows you to use the mastery property of one kind of weapon de sua escolha with which you have proficiency, such as Shortbows or Quarterstaffs. Sempre que você finish a Descanso Longo, você pode change the kind of weapon você escolhe. For example, you could switch to using the mastery property of Slings or Greatclubs.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  3,
  'Ruína Incarnate',
  'Como Ação Bônus, você pode expend a use of your Wild Shape to adopt an aspect of entropy and the inevitable end of all things for 10 minutes. Você ganha os seguintes benefícios. All Things Pass. Você tem Vantagem on jogada de ataques against Ferido creatures. Inexorable Onslaught. Você pode attack twice instead of once whenever you take the ação Atacar no seu turno. Ironskin Armor. Your base AC becomes 17 mais seu modificador de Sabedoria (mínimo de +1) se vocêr AC is lower than that.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  6,
  'Muitos Caminhos a Ruína',
  'Your mystic connection to catastrophe and destruction grows stronger. Você ganha os seguintes benefícios. Elemental Assault. While your Ruin Incarnate feature is active, whenever you hit with a weapon or an Ataque Desarmado , você pode cause it to deal sua escolha of Acid, Cold, Fire, Lightning, or dano Necrótico rather than its normal damage type. Increased Might. While your Ruin Incarnate feature is active, você pode add your modificador de Sabedoria (minimum bonus of +1) to your Força and Destreza salvaguardas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  10,
  'Sacudir the Terra',
  'Como ação Mágica, você pode strike the earth with a thunderous tremor and grow. Quando você do so, your size increases by one category (from Medium to Large, for example) for 10 minutes. Além disso, each creature in a 9 m Emanação originating from your new form must make a Destreza salvaguarda against your spell save CD or have the condição Caído. The tremor deals Contundente damage to each structure in contact with the ground in the area. To determine esse dano, roll um número de d10s igual a your Druid level, and add them together. While your size is increased by este recurso, your attacks with weapons and Ataque Desarmados deal an extra 1d4 damage on a hit. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
  14,
  'Entropy’s Ápice',
  'Você tem mastered the ability to hasten the inevitable slide toward entropy. Você ganha os seguintes benefícios. Enhanced Ruinous Smite. Until the end of your next turn, any creature affected by your Ruinous Smite suffers a Acerto Crítico on a roll of 19-20 on the d20. Improved Inexorable Onslaught. While your Ruin Incarnate feature is active, você pode attack with a weapon or an Ataque Desarmado three times instead of once whenever you take the ação Atacar no seu turno. World Breaker. You regain your use of your Shake the Earth feature when you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  3,
  'Círculo Formas',
  'You channel the endless possibilities of nature when you assume a Wild Shape form, granting you the benefits below. Challenge Rating. The maximum Challenge Rating for the form equals your Druid level divided by 3 (rounded down). Predator’s Strike. Quando você acerta uma creature with uma jogada de ataque using a Beast form’s attack in Wild Shape, you add +2 to the damage dealt. Unpredictable. Você pode realizar the Dash , Desengajar , or Influence action como Ação Bônus.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  3,
  'Mutar Forma',
  'Quando você assume a Wild Shape form, or como Ação Bônus while your Wild Shape is active, você pode expend a espaço de magia to gain Mutation Points igual a the slot’s level. These Mutation Points last until they are spent, you gain additional Mutation Points, or you leave the form. While you have Mutation Points, você pode spend them no seu turno (no action required by you) to gain a Mutation from the list below. Quando você do, your body distends and reconstitutes in a gruesome display. Mutations last until you leave the form or you expend a espaço de magia to gain Mutation Points.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  6,
  'Antinatural e Inquietante',
  'Quando você expend a level 2+ espaço de magia to gain Mutation Points, você recupera one expended espaço de magia. The slot você recupera must be of a level lower than the slot you expended and can’t be higher than level 5. Além disso, while in Wild Shape form, you gain o seguinte benefits. Unnatural Attacks. Each of your attacks in Wild Shape form can deal its normal damage type or dano de Força. You make this choice each time you hit with those attacks. Unnerving Aura. Você tem Vantagem on Carisma ( Deception or Intimidation ) and Sabedoria ( Animal Handling ) checks.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  10,
  'Infinita Evolução',
  'Quando você gain Mutation Points, you gain an additional number of Mutation Points igual a your modificador de Sabedoria (minimum 1). Além disso, você pode now spend your Mutation Points on o seguinte Mutations. Creature of Earth Cost: 3 Mutation Points Você tem Tremorsense with a range of 9 m. Você pode spend 2 additional Mutation Points to gain a Burrow Speed igual a your Speed . Elemental Inurement Cost: 2 Mutation Points Você ganha Resistência to one of o seguinte damage types de sua escolha: Acid, Cold, Fire, Lightning, Poison, or Thunder. Repeatable. Você pode gain this Mutation more than once, but you must choose a different Resistência each time. Eldritch Assault Cost: 2 Mutation Points Você ganha um +1 bonus to jogada de ataques and jogada de danos you make with your Wild Shape form’s attacks. Repeatable. Você pode gain this Mutation more than once, but no more than three times. Mystic Monster Cost: 3 Mutation Points Você pode conjurar spells while you’re in this Wild Shape form. Se você have 18 or more Druid levels, creatures have Desvantagem on salvaguardas against spells you cast while this Mutation is active. Rapid Regeneration Cost: 5 Mutation Points No início de each of your turns, você recupera Pontos de Vida igual a your modificador de Sabedoria (mínimo de 1 Hit Point regained). Supernatural Hide Cost: 5 Mutation Points Você tem Resistência to Contundente, Perfurante, and Cortante damage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-mutation'),
  14,
  'Ápice Predador',
  'Your mastery of mutation has made you an apex predator, granting you o seguinte benefits. Evolved Attacks. Uma vez por turno, você pode deal an extra 2d10 dano de Força to a target you hit with a Wild Shape form’s attack. Mutate Beasts. Como ação Mágica, você pode touch a Beast and expend a espaço de magia, causing the target to mutate. Você ganha Mutation Points igual a the slot’s level, which you must immediately spend on Mutations for the Beast. Unspent Mutation Points are lost. Mutations remain until the Beast is targeted by este recurso again. A Remove Curse , Greater Restoration or similar magic ends the Mutations.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  3,
  'Protetora Provocação',
  'Uma vez por turno when you hit a creature with a melee attack using a weapon or Ataque Desarmado , você pode taunt it. Until the start of your next turn or until you have the Incapacitado condition, the target has Desvantagem on jogada de ataques against targets other than you. A creature can only be affected by one Taunt at a time.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  3,
  'Resistir the Tempestade',
  'Você tem grown accustomed to being battered and bruised. Como Ação Bônus, you toughen up por 1 minuto. No fim de each of your turns, you gain Pontos de Vida Temporários igual a your Fighter level mais seu modificador de Constituição. Depois de usar este recurso, você pode’t use it again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  7,
  'Ameaçadora Presença',
  'Você pode provoke your enemies into single-minded hatred of you. Como ação Mágica, each creature de sua escolha that can hear you in a 9 m Emanação originating from you must make a Sabedoria salvaguarda (CD 8 mais seu modificador de Constituição and Bônus de Proficiência). On a failed save, the creature takes 5d6 dano Psíquico and has Desvantagem on jogada de ataques against targets other than you. Quando você use este recurso, you restore your use of Weather the Storm. Você pode usar este recurso twice. You regain all expended uses when you finish a Descanso Longo. Quando você alcança Fighter level 15, you gain another use of este recurso.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  10,
  'Agressiva Defesa',
  'You know when to switch from defense to offense. Once on each of your turns when you hit a creature with uma jogada de ataque using a arma corpo a corpo or Ataque Desarmado , você pode lose Pontos de Vida Temporários igual a no more than half your Fighter level (round down) to deal extra damage to the target igual a the number of Pontos de Vida Temporários lost in this way.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  15,
  'Aprimorado Second Vento',
  'Your endurance is unrivaled. Quando você regain Pontos de Vida from Second Wind, you gain um número de Pontos de Vida Temporários igual a the roll’s total.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'bulwark-warrior'),
  18,
  'Interromper the Ataque',
  'When another creature você pode see within 1,5 m of you is hit by uma jogada de ataque, você pode take a Reação to change the target to yourself. Você tem Resistência to all damage against that attack. Every so often you find one: a soldier ready and willing to put themselves in harm’s way for their comrades. —'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  3,
  'Composto Criador',
  'Você aprende to create alchemical compounds toxic to others but empowering to you. Compounds. Você aprende three compounds de sua escolha from the “ Compound Options ” section below. Você aprende dois additional compounds de sua escolha when you reach Fighter levels 7, 10, and 15. Each time you learn new compounds, você pode also replace one compound você conhece with a different one. Guilherme Castro Creating. Sempre que você finish a Descanso Longo while holding Alchemist’s Supplies , você pode use that tool to magically produce any number of compounds. The compound appears in a vial, and the vial vanishes when the compound is consumed or poured out. If any compound remains when you finish a Descanso Longo, the compound and its vial vanish. Consuming. Como Ação Bônus, você pode consume one compound. Você pode consume um número de compounds up to one mais seu modificador de Constituição (mínimo de one). Uma vez você reach this limit, você podenot benefit from more compounds until you finish a Descanso Longo. Você pode benefit from multiple compounds at the same time, but consuming multiple vials of the same compound provides no additional effects. Only você pode benefit from your compounds. Any other creature that consumes a compound must succeed on a Constituição salvaguarda (CD 8 mais seu modificador de Inteligência plus Bônus de Proficiência) or have the condição Envenenado por 1 minuto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  3,
  'Estudante de Alquimia',
  'Você ganha Alchemist’s Supplies , and you have proficiency with it. Além disso, your Bônus de Proficiência is doubled for ability checks with Alchemist’s Supplies.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  7,
  'Vivo Caldeirão',
  'The number of compounds você pode safely consume increases to three mais seu modificador de Constituição (minimum one). At Fighter level 18, the number of compounds você pode safely consume increases to five mais seu modificador de Constituição (minimum one).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  10,
  'Rápida Consumption',
  'Quando você use a Ação Bônus to drink a compound, você pode drink a second compound.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  15,
  'Toxina Transmutação',
  'Você tem Resistência to dano de Veneno. Also, como Ação Bônus, você pode end the condição Envenenado on yourself. Quando você end the condição Envenenado on yourself in this way, você pode choose to gain Pontos de Vida Temporários igual a your Fighter level. You regain the ability to gain these Pontos de Vida Temporários after completing a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'living-crucible'),
  18,
  'Vivo Catalisador',
  'Quando você termina um Descanso Longo, você pode replace one compound você conhece with another one.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  3,
  'Hábil Guardian',
  'Unraveling mysteries under the cover of night has honed your skills. Você ganha os seguintes benefícios. Expertise. Choose one of your skill proficiencies with which you lack Expertise. Você ganha Expertise in that skill. Skilled. Você ganha proficiency in two skills de sua escolha from o seguinte list: Deception , History , Insight , Intimidation , Investigation , Perception , or Stealth .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  3,
  'Sempre Vigilante',
  'Your long nights of vigilance have left your senses attuned to signs of danger, granting you o seguinte benefits. Darkvision. Você ganha Darkvision with a range of 18 m. Se você already have Darkvision when you gain este recurso, its range increases by 18 m. Keen Senses. Você tem Vantagem on Initiative rolls and Sabedoria ( Perception ) checks. Warning Shout. Quando você make an Initiative roll, você pode take a Reação to warn creatures de sua escolha within 9 m of yourself that can see or hear you. Each creature can then take a Reação to have Vantagem on its Initiative roll and move up to half its Speed without provoking Opportunity ação Atacar. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  7,
  'Avaliar Up',
  'Como Ação Bônus, you assess a creature você pode see within 9 m of you. Until the start of your next turn, when that creature makes uma jogada de ataque against you or another creature within 1,5 m of you, você pode take a Reação to impose Desvantagem on that roll and give Resistência to that damage.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  10,
  'Noite Stalker',
  'Você é adept at tracking down enemies in the dead of night, giving you these benefits. Blindsight. Como Ação Bônus, you gain Blindsight with a range of 9 m for 10 minutes. Depois de usar this benefit, você pode’t use it again until you finish a Short or Descanso Longo. Slippery. Opportunity ação Atacar have Desvantagem against you. While entirely within Dim Light or Darkness , your movement doesn’t provoke Opportunity ação Atacar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  15,
  'Ready para Action',
  'Quando você make an Initiative roll, você pode treat a d20 roll of 9 or lower como 10. Quando você rola 18-20 on an Initiative roll, você pode take one additional action, except the ação Mágica, on your first turn.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'nightwatcher'),
  18,
  'Espancar Derrubar',
  'Immediately after you miss a creature under the effect of your Size Up feature with uma jogada de ataque, você pode take a Ação Bônus or Reação to make a melee attack against that creature if it’s within range. Você tem Vantagem on the new jogada de ataque against that creature.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  3,
  'Sutil Mão',
  'Your martial arts are enhanced by a capacity for telekinetic strikes. During your turn, your reach is 1,5 m greater with Ataque Desarmados . Além disso, when you hit a creature with an Ataque Desarmado as part of the ação Atacar no seu turno, você pode choose to have it deal sua escolha of dano Psíquico or its normal damage type.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  3,
  'Psiônica Prowess',
  'Your psychic powers have manifested in the ability to cast certain spells. You know the Mage Hand cantrip. Você pode conjurar it without Verbal or Somatic components, and você pode make the spectral hand Invisible . Além disso, você pode cast certain spells by expending Focus Points. Você pode realizar a ação Mágica and expend 1 Focus Point to cast Detect Evil and Good or Protection from Evil and Good . Você pode also take a ação Mágica and expend 2 Focus Points to cast Hold Person , Levitate , or Shatter . Sabedoria is sua habilidade de conjuração for these spells, and você pode cast them without Material components.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  6,
  'Descarado Golpe',
  'Once on each of your turns when you hit a creature with your Ataque Desarmado or Monk weapon, você pode force it to make a Força salvaguarda against your Focus Point save CD. On a failed save, você pode move the target up to 3 m toward or away from you.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  11,
  'Psíquica Crush',
  'Each time you hit a creature with an Ataque Desarmado , it gains a Pressure Point. A creature loses all Pressure Points se você cause a different creature to gain a Pressure Point or after 1 minute, whichever comes first. Como Ação Bônus, você pode expend 1 Focus Point to telekinetically crush a creature with 1 or more of your Pressure Points. The creature loses all Pressure Points and must make a Força salvaguarda against your Focus Point save CD. On a failed save, the creature takes 1d8 dano de Força per Pressure Point, and it has the Restrained condition até o fim do seu próximo turno. On a successful save, the creature takes half as much damage only.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorofthe-leaden-crown'),
  17,
  'Psiônica Mastery',
  'After much training, you have mastered the psionic disciplines necessary to defend mortals from planar threats. Como ação Mágica, você pode spend 5 Focus Points to cast Dispel Evil and Good , Hold Monster , Telekinesis , or Wall of Force . Sabedoria is sua habilidade de conjuração for these spells, and você pode cast them without Material components.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  3,
  'Altas Histórias',
  'Você tem gained a knack for telling embellished tales of your past achievements. Você ganha proficiency in one of o seguinte skills de sua escolha: Deception , Intimidation , Performance , or Persuasion .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  3,
  'Machucado Ego',
  'Your ego strengthens you as you fight to prove your value. Quando você expend a Focus Point, você pode also gain Pontos de Vida Temporários igual a your modificador de Sabedoria (mínimo de 1 Temporary Hit Point). While you are Ferido , you gain twice that amount instead.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  3,
  'Assertivo Atacante',
  'While you are Ferido , you add your modificador de Sabedoria to the damage você causa with Ataque Desarmados and Monk weapons.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  6,
  'Irracional Retaliação',
  'Damage dealt to you is damage dealt to your pride, and that is something you simply can’t allow. Whenever a creature deals damage to you, você pode take a Reação and expend 1 Focus Point. Você tem Vantagem on jogada de ataques against that creature até o fim do seu próximo turno.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  6,
  'Redobrados Efforts',
  'Quando você score a Acerto Crítico while you are Ferido , você pode roll one additional damage die when determining the extra damage dealt by the attack.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  11,
  'Sempre Orgulhoso',
  'Quando você are reduced to 0 Pontos de Vida and not killed outright, você pode expend 1 Focus Point to enter a trance. While in this trance, you have o seguinte effects: Você é imune a the Unconscious condition. Você pode’t speak. Você pode’t cast or concentrate on spells. You suffer 1 Death Salvaguarda failure from damage from a Acerto Crítico instead of 2. Sempre que você start your turn with 0 Hit Point, you must expend 1 Focus Point to maintain a trance, and you make Death Salvaguardas as normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-pride'),
  17,
  'Egotista',
  'Injuries to your pride enrage you. Você é considered Ferido se vocêr current Pontos de Vida are below your máximo de Pontos de Vida.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  3,
  'Sombra de Arrependimento',
  'Uma vez por turno, no seu turno, você pode expend 1 Focus Point (no action required) to create a shade of yourself in an unoccupied space você pode see within 3 m of yourself. The shade is intangible and doesn’t occupy its space. It lasts até o fim do seu próximo turno, but it ends early se você dismiss it (no action required) or have the Incapacitado condition. While it persists, you gain o seguinte benefits. Daniel Alessi Shade Strike. Quando você use Flurry of Blows, você pode have the attacks originate from the shade instead of you. Attacks originating from the shade deal Necrotic or dano de Força (sua escolha) rather than their normal damage type. Move. Como Ação Bônus, você pode move the shade up to 18 m to an unoccupied space você pode see that is within 18 m of yourself.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  3,
  'The Estrada Não Percorrida',
  'Quando você realiza the Dash action, instead of moving, você pode teleport yourself or an ally within 18 m of you to the location of your shade.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  6,
  'Auxílio Não Negado',
  'Você pode realizar a Ação Bônus to take the ação Ajudar or expend 1 Focus Point to touch a creature and restore um número de Pontos de Vida igual a a roll of your Martial Arts die mais seu modificador de Sabedoria.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  11,
  'Esmagadora Culpa',
  'Você pode expend 3 Focus Points to release your pent-up guilt in a crushing wave that drops your foes to their knees. Creatures de sua escolha in a 6 m Emanação originating from you or your shade must make a Sabedoria salvaguarda against your Focus Point save CD. On a failed save, a creature takes dano Psíquico igual a three rolls of your Martial Arts die and has the condição Caído. On a successful save, a creature takes half as much damage only.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'warriorof-regret'),
  17,
  'Reviver the Past',
  'Your Shade of Regret now lasts for 10 minutes. After using Flurry of Blows, your Shade can make one additional Ataque Desarmado as per Shade Strike. Você pode also use the Stunning Strike feature through the Shade Strike.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  3,
  'Debilitante Febre',
  'Você pode inflict disease upon a creature. Quando você acerta uma creature with uma jogada de ataque using a weapon or Ataque Desarmado , você pode expend one use of your Channel Divinity to give that creature the condição Envenenado por 1 minuto. While Envenenado in this way, the target also has the Incapacitado condition. No fim de each of its turns, the Envenenado target makes a Constituição save, ending the effect on itself on a success.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  3,
  'Entrópica Infecção',
  'Como ação Mágica, você pode expend one use of your Channel Divinity and select a creature você pode see within 9 m of yourself. For 1 minute, se você deal damage to the target, the target takes an extra 2d6 dano Necrótico. Além disso, the target loses Resistência and Imunidade to dano Necrótico. The target can make a Constituição save against the Paladin''s spell save CD at the end of each of its turns, ending the effect on itself on a success.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  3,
  'Magias do Juramento de Pestilence',
  'The magic of your oath ensures you always have certain spells ready; when you reach a Paladin level specified in the Oath of Pestilence Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  7,
  'Aura de Desenfreada Doença',
  'You emit an aura of contagion and virulence. When a creature within your Aura of Protection is about to make a Teste D20 , você pode take a Reação to impose Desvantagem on that Teste D20. There are days when você pode just make out the glint of their armor through the haze, like they’re waiting for something. —'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  15,
  'Nojenta Resiliência',
  'Quando você are reduced to 0 Pontos de Vida and not killed outright, você pode spend any number of Dados de Vida, roll them, and reduce the damage taken by the total rolled on those dice. Além disso, se você are killed, your corpse explodes in a shower of pus and gore. Each creature in a 6 m Emanação originating from you makes Constituição salvaguarda against the Paladin''s spell save CD, taking 8d6 dano Necrótico on a failed save or half as much damage on a successful one.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
  20,
  'Portador da Peste',
  'Como Ação Bônus, you gain the benefits below for 10 minutes, or until you end them (no action required). Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Você pode also restore your use of it by expending a level 5 espaço de magia (no action required). One with Plague. Você é imune a dano de Veneno and the condição Envenenado, and you have Resistência to dano Necrótico. Bolstered by Rot. Your máximo de Pontos de Vida can’t be reduced. Entropic Radiance. Whenever an enemy starts its turn within your Aura of Protection, it takes dano Necrótico igual a your modificador de Carisma mais seu Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  3,
  'Frenético Massacre',
  'Você pode harness the rush of battle to drive you to even greater acts of violence. Como Ação Bônus, você pode expend one use of your Channel Divinity to enter a battle frenzy. Você ganha os seguintes benefícios while este recurso is active. Reflexive Attack. Quando você miss with uma jogada de ataque using a arma corpo a corpo or Ataque Desarmado , você pode take a Reação to make another attack with the same weapon. Condition Resistência. Você tem Vantagem on salvaguardas to avoid or end the Charmed , Amedrontado , and Stunned conditions. Duration. Frenzied Slaughter lasts até o fim do seu próximo turno, and it ends early se você have the Incapacitado condition. Se vocêr Frenzied Slaughter is still active no seu próximo turno, você pode extend it for another round by doing one of o seguinte: Make uma jogada de ataque against an enemy. Force an enemy to make a salvaguarda. Você é Ferido at the end of your turn. Each time Frenzied Slaughter is extended, it lasts até o fim do seu próximo turno. Você pode maintain it for up to 1 minute.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  3,
  'Magias do Juramento de Slaughter',
  'The magic of your oath ensures you always have certain spells ready; when you reach a Paladin level specified in the Oath of Slaughter Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  7,
  'Sede de Sangue Aura',
  'Your lust for blood infects those around you. When a Ferido ally within your Aura of Protection makes an attack with a weapon or an Ataque Desarmado , it gains a bonus to damage. The bonus equals your modificador de Carisma. Além disso, when a Ferido creature within your Aura of Protection makes a salvaguarda against a Sangromancia spell, você pode take a Reação to impose Desvantagem on the save. We’re more similar than different to those paladins who revel in slaughter, I think. Though, they are a tad more…wasteful. —'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  15,
  'Seguir Através',
  'When a creature in your Aura of Protection becomes Ferido , você pode take a Reação to move up to half your Speed and make an attack with a arma corpo a corpo or Ataque Desarmado . This movement doesn’t provoke Opportunity ação Atacar, and you have Vantagem on the jogada de ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
  20,
  'Sangue Cavaleiro',
  'Your bloodthirst imbues you with preternatural strength and resilience, allowing you to keep sowing slaughter. Como Ação Bônus, you gain the benefits below for 10 minutes or until you end them (no action required). Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Você pode also restore your use of it by expending a level 5 espaço de magia (no action required). Crimson Armor. When a creature within your Aura of Protection becomes Ferido by an enemy, you gain 30 Pontos de Vida Temporários . Seeing Red. When a creature hits you with uma jogada de ataque, você pode take a Reação to make one melee attack against that creature, using a weapon or an Ataque Desarmado . Wanton Slaughter. Quando você acerta uma creature with a melee jogada de ataque using a weapon or an Ataque Desarmado, você pode choose any number of creatures within 1,5 m of the original target and within your reach. Each chosen creature takes dano de Força igual a your modificador de Carisma (mínimo de +1) mais seu Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  3,
  'Marca de the Herege',
  'Como Ação Bônus, você pode expend one use of your Channel Divinity to mark a creature você pode see within 9 m of yourself como heretic. For 1 minute, your weapon attacks and Ataque Desarmados against the chosen creature can score a Acerto Crítico on a roll of 19 or 20 on the d20. Além disso, whenever the target starts its turn, você pode take a Reação to make a melee attack against that creature if it’s within reach.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  3,
  'Magias do Juramento de Zeal',
  'The magic of your oath ensures you always have certain spells ready; when you reach a Paladin level specified in the Oath of Zeal Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  7,
  'Aura de Clareza',
  'You e seu allies have Imunidade to the Blinded condition while in your Aura of Protection. If a Blinded ally enters the aura, that condition has no effect on that ally while there. Além disso, você pode see Invisible creatures within your Aura of Protection.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  15,
  'Compelir Confissão',
  'Você pode conjurar Zone of Truth without expending a espaço de magia. Além disso, a creature that succeeds on its salvaguarda takes 1d6 dano Psíquico at the start of each of its turns while in your Zone of Truth until it chooses to fail its salvaguarda instead.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
  20,
  'Apocalíptica Revelação',
  'Como Ação Bônus, você pode reveal the true nature of your enemies por 1 minuto. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Você pode also restore your use of it by expending a level 5 espaço de magia (no action required). Você ganha os seguintes benefícios. Blinding Glory. Enemies that start their turn within 1,5 m of you must make a Constituição salvaguarda against the Paladin''s spell save CD. On a failed save, the creature has the Blinded condition until the start of its next turn. See the Truth. Você tem Truesight with a range of 18 m. Smite the Heretic. Como Ação Bônus, você pode choose a creature within 18 m of yourself and reveal its weaknesses. You e seu allies have Vantagem on jogada de ataques against that creature. Daniel S. Alessi'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  3,
  'Envenenado Ataque',
  'Como Ação Bônus, você pode apply a poison dose to a weapon or up to 20 pieces of ammunition. Once applied, the poison retains its potency por 1 minuto. Your attacks with the poisoned item deal an extra 1d4 dano de Veneno on a hit. Você pode usar este recurso um número de times igual a your modificador de Sabedoria (mínimo de once). You regain all expended uses when you finish a Descanso Longo. At Ranger level 11, the extra dano de Veneno increases to 2d4, and você recupera all expended uses when you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  3,
  'Tóxica Ofício',
  'Você ganha um Poisoner’s Kit , and you have proficiency with it. Além disso, your Bônus de Proficiência is doubled for ability checks with a Poisoner’s Kit. Se você lose the kit, você pode harvest toxic flora and venomous fauna por 1 hora to magically create a replacement. This harvest can be performed during a Short or Descanso Longo, and it destroys the previous Poisoner’s Kit. Uma vez por turno when você causa dano de Veneno to a creature with a weapon attack, você pode expend a espaço de magia (no action required). The attack deals an extra 1d6 dano de Veneno and the target gains the condição Envenenado até o fim do seu próximo turno. You may also add a Toxin Effect, chosen from the appropriate list below. All Toxin Effects last até o fim do seu próximo turno, unless its description states otherwise.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  3,
  'Magias — Green Reaper',
  'Quando você alcança a Ranger level specified in the Green Reaper Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  7,
  'Veneno Controle',
  'Você ganha Resistência to dano de Veneno and have Vantagem on salvaguardas to avoid or end the condição Envenenado. Além disso, você pode cast the Protection from Poison spell without expending a espaço de magia. Você pode do so um número de times igual a your modificador de Sabedoria (mínimo de once), and você recupera all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  11,
  'Variadas Vexações',
  'Sempre que você would deal dano de Veneno with a weapon attack, você pode change that damage to be either Acid or Necrotic instead.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
  15,
  'Dor Tolerance',
  'Você tem learned to quickly inure yourself against harm. Immediately before you take damage from a creature você pode see within 18 m of yourself, você pode take a Reação to gain Pontos de Vida Temporários igual a the damage you take. If any of these Pontos de Vida Temporários remain at the end of your next turn, they vanish.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  3,
  'Flechas Elementais',
  'Como Ação Bônus, você pode imbue a Longbow or Shortbow with elemental energy por 1 minuto. Choose one of o seguinte damage types: Acid, Cold, Fire, Lightning, or Thunder. For the duration, the imbued weapon deals damage of the selected type instead of its normal type and deals an extra 1d6 damage of the chosen type when it hits. No início de each of your turns, você pode change this choice. Você pode usar este recurso um número de times igual a your modificador de Sabedoria (mínimo de once), and você recupera all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  3,
  'Herbal Conhecimento',
  'Você ganha an Herbalism Kit and are proficient with it. Você pode usar the Herbalism Kit como Ação Bônus to stabilize an Unconscious creature within 1,5 m of you that has 0 Pontos de Vida as if using a Healer’s Kit without needing to make a Sabedoria ( Medicine ) check. Se você take a ação Utilizar, an Unconscious creature within 1,5 m of you that has 0 Pontos de Vida gains 1 Hit Point instead. Guilherme Castro Depois de usar este recurso, você pode’t do so again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  3,
  'Magias — Primordial Archer',
  'Quando você alcança a Ranger level specified in the Primordial Archer Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  7,
  'Tece the Elementos',
  'With 1 hour of work or when you finish a Descanso Longo, você pode use an Herbalism Kit to mark yourself with elemental patterns. Você ganha Resistência to one of o seguinte damage types de sua escolha until you finish a Descanso Longo: Acid, Cold, Fire, Lightning, or Thunder.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  11,
  'Feiticeiras Flechas',
  'Você ganha a capacidade de imbue curses into your arrows. Uma vez por turno when you hit a creature with a ranged attack using a Longbow or Shortbow , você pode expend a level 1+ espaço de magia to choose one of o seguinte effects (no action required). The listed damage increases by 2d6 for each espaço de magia above 1. Arcing Shot. Electricity crackles around the arrow. Make a ranged jogada de ataque with the same weapon against a second creature within 9 m of the first that is also within your range. Each creature hit takes 2d6 dano de Relâmpago. Entangling Shot. The wooden shaft of the arrow sprouts tiny green leaves. The target must succeed on a Força salvaguarda against your spell save CD. On a failed save, the target takes 2d6 Perfurante damage and has the Restrained condition por 1 minuto. On a successful save, the creature takes the damage only. A Restrained creature repeats the save at the end of each of its turns, ending the effect on itself on a success. Hexing Shot. The magic surrounding your arrow clouds the mind of your target. The target must make a Sabedoria salvaguarda against your spell save CD. On a failed save, the target takes 2d6 dano Psíquico and gains the Charmed or condição Amedrontado por 1 minuto (sua escolha). The creature can repeat the save at the end of each of its turns, ending the effect on a success. On a successful save, the creature takes half as much damage only. Viper Shot. The arrow transforms into a hissing serpent. The target must make a Constituição salvaguarda against your spell save CD. On a failed save, the target takes 2d6 dano de Veneno and has the condição Envenenado por 1 minuto. The creature can repeat the save at the end of each of its turns, ending the effect on a success. On a successful save, the creature takes half as much damage only.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
  15,
  'Primordial Magic',
  'Taking damage can’t break your Concentração on any Ranger spells you cast. Além disso, você pode take a Ação Bônus to change the damage type you chose for the Weave the Elements feature to a different damage type in the list. Quando você do, você pode choose a creature que você possa ver within 9 m of yourself. That creature must succeed on a Constituição salvaguarda or take 6d6 damage of either damage type (sua escolha). Você pode usar este recurso um número de times igual a your modificador de Sabedoria (mínimo de once). You regain all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  3,
  'Verminata',
  'Você pode comprehend and verbally communicate with Tiny Beasts. Como ação Mágica, você pode expend a espaço de magia to summon vermin swarms. You summon um número de swarms igual a the slot’s level por 1 hora. Each swarm is summoned to an unoccupied space você pode see within 9 m of yourself. A swarm uses the Swarm of Vermin stat block. In combat, each swarm acts during your turn. It can move and use its Reação on its own, but the only action it takes is the Dodge action unless you take a Ação Bônus to command it to take an action in its stat block or some other action. Você pode command each swarm with a single Ação Bônus. Depois de usar este recurso, você pode’t use it again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  3,
  'Enxame Golpes',
  'Como Ação Bônus, você pode command all of your swarms to make an ação Atacar instead of just one. Alternatively, a single swarm can attack twice instead of once when it takes the ação Atacar. Suzanne Helmigh Você pode usar este recurso um número de times igual a your modificador de Sabedoria mais seu Bônus de Proficiência, and você recupera all expended uses when you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  3,
  'Magias — Vermin Lord',
  'Quando você alcança a Ranger level specified in the Vermin Lord Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  7,
  'Imundície e Fortitude',
  'The time you’ve spent with plague-bearing rodents has rendered you immune to the condição Envenenados. Além disso, you gain proficiency in Constituição salvaguardas.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  11,
  'Infecciosa Propagação',
  'Quando você use Swarming Strikes, each swarm that takes the ação Atacar makes one additional attack. Each creature damaged by a swarm''s attack during this action has the condição Envenenado until the start of your next turn. We don’t have time to count all of them! Just write ‘hundreds of rodent bites.’ —'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
  15,
  'Strength de the Swarm',
  'Você pode call on your rodent minions for defense. Quando você realiza damage from a creature você pode see within 3 m of yourself, você pode take a Reação to direct the damage toward a swarm you control você pode see within 1,5 m of yourself.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  3,
  'Gatilho Instantâneo',
  'Você ganha proficiência com Blackpowder Pistols. Além disso, when you roll Initiative and don’t have Desvantagem on that roll, você pode immediately take a Reação for one of as seguintes opções: Make one attack with a weapon or Ataque Desarmado . Move up to your Speed without provoking Opportunity ação Atacar. A controlled mount moves up to its Speed without provoking Opportunity ação Atacar. Take the Dodge or ação Utilizar.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  3,
  'Fiel Montaria',
  'You always have the Find Steed spell prepared. With este recurso, você pode cast it without a espaço de magia or components, e seu spellcasting ability for it is Inteligência. Uma vez você cast the spell with este recurso, você pode’t do so in this way again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  3,
  'Cavalgar Eles Derrubar',
  'You don’t need Vantagem on the jogada de ataque to Sneak Attack se você or a controlled mount you ride moves at least 6 m, and you don’t have Desvantagem on the jogada de ataque.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  9,
  'Cavalo Senhor',
  'Você pode spend 1 minute grooming and caring for your mount, at the end of which it gains um número de Pontos de Vida Temporários igual a twice your Rogue level. Além disso, your cunning extends to your steed. While you control a mount, it can take one of o seguinte actions como Ação Bônus: Dash , Desengajar , or Dodge .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  13,
  'Determinação Inabalável',
  'Você ganha proficiency in Constituição salvaguardas. Além disso, when you are subjected to an effect that allows you to make a Constituição salvaguarda to take only half damage, you instead take no damage se você succeed on the salvaguarda, and only half damage se você fail.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'highway-rider'),
  17,
  'Desesperado',
  'Quando você are reduced to 0 Pontos de Vida and not killed outright, você pode use your Hair Trigger feature immediately before you fall Unconscious . The back roads are getting too dangerous. Our carriage got held up and ransacked three times… today! —'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  3,
  'Maligno Olho',
  'Você pode place a minor curse with a glance. Como Ação Bônus, choose a creature você pode see within 18 m of yourself to be cursed by your Evil Eye. While a creature is cursed by your Evil Eye, você pode deal Sneak Attack damage to the creature se você don’t have Desvantagem on the jogada de ataque. The creature remains cursed by your Evil Eye por 1 minuto or until you curse a different creature with your Evil Eye, whichever comes first.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  3,
  'Azarento',
  'Você aprende Misfortunes that você pode inflict on those cursed by your Evil Eye. Misfortunes. Você aprende dois Misfortunes de sua escolha, which are detailed under “ Misfortunes ” below. Você aprende um adicional Misfortune de sua escolha when you reach Rogue levels 9, 13, and 17. Quando você termina um Descanso Longo, você pode replace one Misfortune você conhece with a different one. Jinx Points. Você tem 4 Jinx Points. Você ganha 2 additional Jinx Points at Rogue level 13. To use a Misfortune option, you must spend the number of Jinx Points that it costs. You regain all expended Jinx Points when you finish a Short or Descanso Longo. Salvaguardas. If a Misfortune requires a salvaguarda, the CD equals 8 + your Carisma or modificador de Inteligência (sua escolha) + your Bônus de Proficiência.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  9,
  'Roubar Sorte',
  'When a creature você pode see within 9 m of yourself is about to make a Teste D20 with Vantagem , você pode take a Reação to prevent the roll from being affected by Vantagem. Quando você do so, você recupera 1 expended Jinx Point. Depois de usar este recurso, você pode’t do so again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  13,
  'Maldição Caster',
  'Você pode realizar a ação Mágica and spend 3 Jinx Points to cast Bestow Curse .'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'misfortune-bringer'),
  17,
  'Aprimorado Roubar Sorte',
  'Você pode usar your Steal Luck feature three times, and você recupera all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  3,
  'Conjuração',
  'Você tem learned to cast magia de Magos, as well as spells from the Sangromancia school. All Sangromancia spells and truques are treated as magia de Magos for the purposes of esta subclasse. Truques. You know three truques from the magia de Mago list and from the list of Sangromancia spells. Sempre que você gain a Rogue level, você pode replace one of your truques with another Wizard cantrip de sua escolha. Guilherme Castro Quando você alcança Rogue level 10, you learn another Wizard cantrip de sua escolha. Espaços de Magia. The Sanguine Thief Spellcasting table shows how many espaços de magia you have to cast your level 1+ spells. You regain all expended espaços de magia when you finish a Descanso Longo. Prepared Spells of Level 1+. You prepare the list of level 1+ spells that are available for you to cast with este recurso. To start, choose three level 1 magia de Magos. The number of spells on your list increases as you gain Rogue levels, as shown in the Prepared Spells column of the Sanguine Thief Spellcasting table. Whenever that number increases, choose additional magia de Magos until the number of spells on your list matches the number in the Sanguine Thief Spellcasting table. The chosen spells must be of a level for which you have espaços de magia. Changing Your Prepared Spells. Sempre que você gain a Rogue level, você pode replace one spell on your list with another magia de Mago for which you have espaços de magia. Spellcasting Ability. Inteligência is sua habilidade de conjuração for your magia de Magos. Foco de Conjuração. Você pode usar an Foco Arcano como Foco de Conjuração for your magia de Magos.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  3,
  'Roubado Poder',
  'You draw magic from blood. It is represented by your Sangromancia Dice, which fuel powers you have from esta subclasse. Você tem a pool of d8s that você pode use on Sanguine Thief features. The number of damage dice in the pool equals the number of damage dice as shown in the Sneak Attack column of the Rogue Features table. Você pode’t have more Sangromancia Dice than the number of damage dice shown in the Sneak Attack column for your level, unless you have Sangromancia Dice from a different source. Blood Magic. Você pode spend Sangromancia Dice instead of Dados de Vida when you cast Sangromancia spells. Your pool regains all expended dice when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  3,
  'Roubar Sangue',
  'Quando você deal Sneak Attack damage, você pode restore 1 Sangromancia Die. Se você are Ferido , instead of restoring 1 Sangromancia Die when você causa Sneak Attack damage, você pode immediately roll the die and regain um número de Pontos de Vida igual a the roll’s total. Você pode usar este recurso um número de times igual a your modificador de Inteligência (mínimo de once). You regain all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  9,
  'Sanguinário Lâminas',
  'Quando você termina um Descanso Longo, você pode spend up to 2 Dados de Vida or Sangromancia Dice to create um número de Daggers igual a the number of dice spent in this way. Each Dagger counts as an Foco Arcano for your Sanguine Thief spells, and você pode cast spells with Somatic components even se você wield these weapons in one or both hands. Além disso, when you score a Acerto Crítico with this weapon, você pode cause the weapon to deal extra damage to the target. The extra damage is um número de d8s igual a the number of Dados de Vida or Sangromancia Dice spent on este recurso. The extra damage is Necrotic. The Daggers last until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  13,
  'Costura Sangrenta',
  'Como ação Mágica, você pode spend 3 Dados de Vida or Sangromancia Dice to fling a wave of needle-like blood shards. Quando você do so, each creature de sua escolha in a 9 m Emanação originating from you must make a Destreza salvaguarda against your spell save CD, taking 3d8 dano Necrótico on a failed save or half as much damage on a successful one. You regain 1 Hit Die or Sangromancia Die (sua escolha) for each creature reduced to 0 Pontos de Vida by este recurso. Depois de usar este recurso, você pode’t do so again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
  17,
  'Sanguinário Saída',
  'When a creature hits you with uma jogada de ataque, você pode take a Reação and spend 5 Dados de Vida or Sangromancia Dice to turn into bloody mist. The attack automatically misses you, você pode teleport up to 9 m to an unoccupied space você pode see, and você recupera your normal form. As part of this Reação, você pode make an attack with a arma corpo a corpo immediately after you teleport. On a hit, this attack deals an extra 5d8 dano Necrótico to the target. Depois de usar este recurso, você pode’t use it again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  3,
  'Magias — Apocalyptic',
  'Quando você alcança a Sorcerer level specified in the Apocalyptic Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  3,
  'Desequilibradas Asservations',
  'Você é obsessed with documenting your visions. Você ganha proficiência com Calligrapher’s Supplies and você pode create Spell Scrolls in half the time and at half the cost in PO. Além disso, when you create a Spell Scroll , você pode ensorcell it. Quando você ensorcell a Spell Scroll , you must expend a espaço de magia igual a or greater than the spell’s level and você pode spend Sorcery Points to apply one of your Metamagic options. Any creature that knows at least one language can use your ensorcelled Spell Scroll , which casts the spell with the benefit of the Metamagic option you chose. The Spell Scroll remains ensorcelled until it is used or you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  6,
  'Testemunhar Testemunhar',
  'Você tem prepared your entire life for the end of the world. While your Innate Sorcery feature is active, you gain o seguinte benefits. Apocalyptic Inurement. Você tem Resistência to dano de Força. Recite Scripture. Uma vez por Innate Sorcery, como Bonus action você pode use a Spell Scroll that hcomo spell with a casting time of Ação. Unflappable. Você é imune a the condição Amedrontado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  6,
  'Arcana Apócrifa',
  'Your obsessive reflections on the end of existence inspire your writing. Sempre que você finish a Descanso Longo, você pode create one Spell Scroll at no cost. It must be a spell of level 5 or lower that você pode cast. This Spell Scroll disintegrates when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  14,
  'Proibida Magic',
  'The end of Etharis is a time when magic is unbound and magical powers long hidden are unearthed. Quando você cast a Sorcerer spell using a espaço de magia, você pode choose one option below. Excessive. If the spell requires a Material component with a cost, você pode cast the spell without the Material component. You take dano de Força igual a four times the level of the espaço de magia immediately after you cast it. This damage ignores Resistência and Imunidade . Inexorable. Taking damage can’t break your Concentração on the spell. When the spell ends, you gain 1 nível de Exaustão. Pyrrhic. If the spell requires uma jogada de ataque, the spell automatically hits and the jogada de ataque is a Acerto Crítico . Your máximo de Pontos de Vida is reduced by an amount igual a four times the level of the espaço de magia immediately after you cast it. Quando você termina um Descanso Longo, your máximo de Pontos de Vida returns to normal.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'apocalypse-sorcery'),
  18,
  'The Fim É Próximo',
  'You loudly proclaim what will come to pass when the world ends. Como ação Mágica, you describe the end of days. Quando você do so, each creature de sua escolha in a 9 m Emanação originating from you must make a Sabedoria salvaguarda against your spell save CD. On a failed save, a creature takes 6d6 dano Psíquico and 6d6 dano de Força and has the condição Amedrontado por 1 minuto. On a successful save, the creature takes half as much damage only. A Amedrontado creature can repeat the salvaguarda at the end of each of its turns, ending the condição Amedrontado on a successful save. If esse dano reduces a creature to 0 Pontos de Vida, the creature can be revived only by a True Resurrection or a Wish spell. Depois de usar este recurso, você pode’t do so again until you finish a Descanso Longo unless you spend 6 Sorcery Points (no action required) to restore your use of it.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  3,
  'Magias — Haunted',
  'Quando você alcança a Sorcerer level specified in the Haunted Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  3,
  'Sexto Sentido',
  'Quando você rola Initiative, você pode add your modificador de Carisma to the roll.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  3,
  'Fantasma Companheiro',
  'Você aprende Find Familiar spell and can cast it como ação Mágica without expending a espaço de magia. The familiar takes the form of a Specter , though it is an Undead instead of a Celestial, Fey, or Fiend. Como ação Mágica, você pode comme seu phantom companion to gain the Invisible condition until it attacks or you cast a spell through it. While Invisible, it leaves no physical evidence of its passage and can be tracked only by magic. Any equipment or objects it is holding remains visible. Além disso, when you take the ação Atacar, você pode forgo one of your own attacks to allow your familiar to make its Life Drain attack with its Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  6,
  'Strength de Spirit',
  'Your bond with your phantom companion empowers it. Você ganha os seguintes benefícios: Your familiar’s máximo de Pontos de Vida increases by four times your Sorcerer level. Você pode conjurar spells as se você were in the familiar’s space. Quando você use your action to cast a spell, você pode use a Ação Bônus to comme seu phantom companion to use its Life Drain attack with its Reação.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  6,
  'Mortífero Palidez',
  'Você tem Resistência to dano Necrótico, and when you cast a Sorcerer spell that deals damage, it can deal sua escolha of dano Necrótico or its normal damage type.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  14,
  'Fantasma Possessão',
  'Como ação Mágica, você pode direct your phantom companion to possess a creature de sua escolha within 1,5 m of your phantom. The target makes a Carisma salvaguarda against your spell save CD. On a failed save, your phantom companion enters the target’s body por 1 minuto. On a successful save, the target resists the efforts to possess it, e seu familiar can’t possess it again por 24 horas. Once the phantom companion possesses a creature’s body, it controls that creature. The familiar’s Pontos de Vida, Dados de Vida, Força, Destreza, Constituição, Speed , and senses are replaced by the creature’s. The phantom companion otherwise keeps its game statistics. While the target is possessed, you have a telepathic link with your phantom companion as long as the two of you are within 30 m. Você pode usar this telepathic link to issue commands to your phantom companion (no action required) unless you have the Incapacitado condition. Your phantom companion does its best to obey on its turn. If it completes an order and doesn’t receive further direction from you, the phantom companion acts and moves as it likes, focusing on protecting itself. Você pode command the target to take a Reação but must take your own Reação to do so. Whenever the target takes damage, it repeats the save, ending the possession on itself on a success, e seu phantom companion reappears in the closest unoccupied space. Depois de usar este recurso, você pode’t do so again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'haunted-sorcery'),
  18,
  'Tornar-se Morte',
  'Você pode transmute your physical form into a spectral one when near death. Quando você are reduced to 0 Pontos de Vida and not killed outright, você pode drop to 1 Hit Point instead and gain Pontos de Vida Temporários igual a half your máximo de Pontos de Vida. No início de each of your turns, you lose 10 Pontos de Vida Temporários and creatures de sua escolha within 9 m of you take 10 dano Necrótico. While you have Pontos de Vida Temporários granted by este recurso, you have Resistência to all damage, a Fly Speed of 9 m, can Hover , and você pode move through occupied spaces as if they were Difficult Terrain . Se você end your turn in such a space, you are shunted to the last unoccupied space you were in. Depois de usar este recurso, você pode’t do so again until you finish a Descanso Longo. It seems that under the right circumstances, an individual experiencing a haunting can leverage the spirit’s energy into arcane magic. Deeply troubling. — Inquisitor’s field report'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  3,
  'Má Sorte Amuleto',
  'Você tem the ability to cast a sliver of your curse onto another temporarily. Como Ação Bônus, choose a creature você pode see within 9 m of yourself. The chosen creature has Desvantagem on the next Teste D20 it makes before the start of your next turn. Depois de usar este recurso, você pode’t do so again until you finish a Short or Descanso Longo unless you spend 1 Sorcery Point (no action required) to restore your use of it.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  3,
  'Sangue Laços',
  'Your senses easily attune to the supernatural forces that caused your inherited affliction. You always have the Detect Evil and Good spell prepared and can cast it without expending a espaço de magia. Além disso, choose one of o seguinte types of creatures as the being that cursed your ancestor: Fey, Fiend, or Undead. On each of your turns while you maintain Concentração on Detect Evil and Good , including the turn when you cast it, creatures of the chosen type have Desvantagem on jogada de ataques against you, and você pode’t be possessed, Charmed , or Amedrontado by such creatures. Uma vez você cast the spell with este recurso, você pode’t do so in this way again until you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  3,
  'Miserável Maldição',
  'You suffer from a curse inherited from an ancestor who failed to uphold their end of a bargain with an otherworldly power. Choose one of o seguinte curses that was passed down to you. Hulking. Your ancestor was cursed with a hulking frame. Você tem Desvantagem on Destreza ( Stealth ) checks to escape notice by moving quietly. Além disso, your máximo de Pontos de Vida increases by 1, and it increases by 1 whenever you gain another Sorcerer level. Finally, you count as one size larger when determining your carrying capacity. Nocturnal. Your ancestor was cursed to shun the light of day. Você tem Desvantagem on Sabedoria ( Perception ) checks that rely on sight while you are in sunlight. Além disso, você pode see normally in Dim Light and Darkness — both magical and nonmagical—within 36 m of yourself. Plaguebearer. Your ancestor was cursed with physical symptoms of a plague. Você tem Desvantagem on Carisma ( Persuasion ) checks made to influence an Indifferent Humanoidee within 1,5 m of yourself. Além disso, you are Imune to the condição Envenenado and have Resistência to dano Necrótico.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  6,
  'Compartilhar the Fardo',
  'You always have the Bestow Curse spell prepared. Você pode conjurar the spell by spending 3 Sorcery Points instead of a espaço de magia. Quando você cast the spell in this way, the spell doesn’t require Concentração , and its range changes to 18 m for that casting.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  14,
  'Aterrorizante Semblante',
  'Como Ação Bônus, você pode adopt the terrifying visage of the being that cursed your ancestor for 10 minutes. During this time, você pode take a ação Mágica to cause creatures de sua escolha você pode see you within 9 m of yourself to make a Sabedoria salvaguarda. On a failed save, the target has the condição Amedrontado até o fim do seu próximo turno. Além disso, while your Terrifying Visage feature is active, you gain o seguinte benefit based on the creature type chosen with your Blood Ties feature. Fey. Como Ação Bônus, you teleport up to 9 m to an unoccupied space você pode see. Fiend. Você tem Resistência to Cold and dano de Fogo. Undead. Quando você realiza damage of any type other than Radiant, você pode take a Reação to reduce the damage by half your Sorcerer level. Depois de usar Terrifying Visage, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'wretched-bloodline-sorcery'),
  18,
  'Vingativa Invocação',
  'Your magic has become powerful enough that você pode call and command a servant of those who cursed you. Choose one of o seguinte creatures based on the choice you made with your Blood Ties feature: Lamia or Troll (Fey only), Barbed Devil , Incubus , or Succubus (Fiend only), Ghost or Wraith (Undead only). Você pode realizar a ação Mágica and spend 5 Sorcery Points to summon your chosen creature. The creature appears in an unoccupied space você pode see within 18 m. It disappears when it drops to 0 Pontos de Vida, you use este recurso to summon another creature, or after 10 minutes have passed. The creature is an ally to you e seu allies. In combat, the creature shares your Initiative count, but it takes its turn immediately after yours. It obeys your verbal commands (no action required by you). Se você don’t issue any, it takes the Dodge action and uses its movement to avoid danger.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  3,
  'Magias — Coven',
  'The magic of your patron ensures you always have certain spells ready; when you reach a Warlock level specified in the Coven Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  3,
  'Hag’s Olho',
  'As an agent of a Hag, you have been gifted with a magical item known como Hag’s Eye . Crafted from a real eye and fitted into a ring, pendant, or other accessory, this item can be used as an Foco Arcano for your Warlock spells. The Hag can see through the eye, and the destruction of the item can cause the Hag actual pain, so any pawn who loses this talisman often invokes the Hag’s ire. While you possess the eye, você pode cast Hex um número de times igual a your modificador de Carisma (mínimo de once) without expending a espaço de magia, and você recupera all expended uses of this ability when you finish a Descanso Longo. Além disso, when you reach Warlock level 10, você pode use the eye to cast Bestow Curse once without expending a espaço de magia, and você recupera the ability to do so once you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  6,
  'Hag’s Astúcia',
  'Hags delight in deceiving and manipulating others, and you gain some of their skill in doing so. You know the Minor Illusion cantrip. Se você already know it, you learn a different Warlock cantrip de sua escolha. The cantrip doesn’t count against your number of truques known. Além disso, if a creature takes a Study action to examine an illusion you have created, você pode take a Reação to impose Desvantagem on the check. Also, the first time a creature takes a Study action to examine an illusion spell you have cast and succeeds on the Inteligência ( Investigation ) check, você pode cause the illusion to deal dano Psíquico. The damage equals 1d6 plus 1d6 per level of the espaço de magia used to cast the spell. Você pode do damage um número de times igual a your modificador de Carisma (mínimo de once). You regain all expended uses when you finish a Short or Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  10,
  'Hag’s Semblante',
  'Como ação Mágica, you twist your face into a horrifying mask resembling your Hag patron. It lasts por 1 minuto, but it ends early se você dismiss it (no action required) or have the Incapacitado condition. While this effect lasts, you gain the benefits listed below. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Horrifying Gaze. Como Ação Bônus, choose one Humanoidee que você possa ver and that can see you within 9 m of you. The creature must make a Sabedoria salvaguarda against your spell save CD or have the condição Amedrontado por 1 minuto. The Amedrontado target repeats the save at the end of each of its turns, ending the effect on itself on a success. A creature that can see you has Desvantagem on this save. Paralyzing Gaze. Como Magic Ação, choose one Humanoidee que você possa ver and that can see you within 9 m of you that has the condição Amedrontado. The creature must make a Sabedoria salvaguarda against your spell save CD or have the Paralyzed condition. On a successful save, the creature takes dano Necrótico igual a your Warlock level, it is no longer Amedrontado, and it can’t be targeted by your Hag’s Visage again until you finish a Descanso Longo. Death Gaze. Como Magic Ação, choose one Humanoidee que você possa ver and that can see you within 9 m of you that has the Paralyzed condition. The creature must make a Sabedoria salvaguarda with Vantagem against your spell save CD or be reduced to 0 Pontos de Vida. On a successful save, the creature takes dano Necrótico igual a twice your Warlock level, it is no longer Paralyzed, and it can’t be targeted by your Hag’s Visage again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
  14,
  'Hag’s Ofício',
  'The Hag imparts the knowledge to craft two magic items. Você pode temporarily turn a normal vessel into a Hag''s Cauldron by expending a espaço de magia. This magical cauldron lasts for 10 minutes. During that time, você pode take the Magic to pour out three Common, two Uncommon, or one Rare potion. The potions lose efficacy at the end of your next Short or Descanso Longo. You regain this ability at the end of a Descanso Longo. Além disso, when you finish a Descanso Longo, você pode expend a espaço de magia and imbue a gemstone worth at least 10 PO with magic, turning it into a Minor Heartstone . This magic item grants the bearer Imunidade to the condição Envenenado and the ability to cast Blink once without expending a espaço de magia. The magic within the gemstone fades after 24 hours and the gem crumbles into dust.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  3,
  'Drenar Vida',
  'Você ganha an innate power to drain life from the living. After you take the Attack or ação Mágica, você pode use a Ação Bônus to make an Ataque Desarmado . On a hit, the Ataque Desarmado deals dano Necrótico igual a 1d6 mais seu modificador de Carisma instead of its normal damage. Quando você acerta uma creature with Drain Life, você pode expend a Pact Magic espaço de magia to deal an extra 1d8 dano Necrótico to the target, plus another 1d8 per level of the espaço de magia. Quando você expend a espaço de magia in this way, você recupera Pontos de Vida igual a the amount of damage dealt.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  3,
  'Noturno Predador',
  'Como predator of the night, you have been blessed with enhanced vision in darkness. Você tem Darkvision with a range of 18 m. Se você already have Darkvision , its range increases by 18 m.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  3,
  'Magias — First Vampire',
  'The magic of your patron ensures you always have certain spells ready; when you reach a Warlock level specified in the First Vampire Spells table, you thereafter always have the listed spells prepared.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  6,
  'Criatura de the Noite',
  'You always have the Polymorph spell prepared. With este recurso, você pode cast it only on yourself without expending a espaço de magia and without Material components to transform into a Bat , Rat , or Wolf . Your game statistics are replaced by the Beast’s stat block, but you retain your creature type; Pontos de Vida; Dados de Vida; Inteligência, Sabedoria, and Carisma scores; class features; languages; and feats. You also retain your skill and salvaguarda proficiencies and use your Bônus de Proficiência for them, in addition to gaining the proficiencies of the creature. If a skill or salvaguarda modifier in the Beast’s stat block is higher than yours, use the one in the stat block. Você pode usar este recurso um número de times igual a your modificador de Carisma (mínimo de once). You regain all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  10,
  'Eldritch Appetite',
  'Quando você reduce an enemy to 0 Pontos de Vida with your Drain Life feature, você pode take a Reação to consume the last of its fleeting mortality. Quando você do so, você recupera one of your expended Pact Magic espaços de magia. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
  14,
  'Eterna Noite',
  'Your vampire patron grants you a taste of true immortality. You no longer age, and you gain Resistência to dano Necrótico. Como Ação Bônus, you gain o seguinte benefits por 1 minuto: No início de each of your turns, você recupera 1d6 Pontos de Vida se você have at least 1 Hit Point and you aren’t in direct sunlight or running water. Se você take dano Radiante, you don’t regain Pontos de Vida from este recurso at the start of your next turn. Quando você use your Drain Life feature, você pode deal an extra 1d8 dano Necrótico without expending a espaço de magia. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  3,
  'Magia Sifão',
  'Your patron has taught you to siphon magic from your enemies and make it your own. Immediately after a creature você pode see within 18 m of you casts a spell, você pode take a Reação to force the creature to make a Carisma salvaguarda. The CD equals your spell save CD. On a failed save, that creature can''t cast the spell again until 8 hours have passed. While this effect lasts, if the spell was at least level 1 and of a level você pode cast, you have that spell prepared. Tony Sart The maximum number of spell levels você pode have siphoned at once equals 1 mais seu modificador de Carisma (mínimo de 1). Se você have the Incapacitado condition or die, you lose all siphoned spells. Quando você termina um Descanso Longo, you lose all siphoned spells.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  3,
  'Físico Espécime',
  'Your patron has enhanced your physical form to improve your utility como host and pawn. Como Ação Bônus, once per Descanso Longo, choose um número de o seguinte benefits up to your modificador de Carisma (mínimo de one) that lasts until you finish a Descanso Longo. Sempre que você finish a Descanso Curto, você pode choose one of your selected benefits and replace it with another from this list. Your máximo de Pontos de Vida increases by an amount igual a your Warlock level. Você ganha Darkvision with a range of 18 m. Se você already have Darkvision , its range increases by 18 m. You Speed increases by 1,5 m. Você tem Vantagem on salvaguardas to avoid or end the condição Envenenado. Your jump distance is tripled, and you gain a Climb Speed igual a your Speed. Add your modificador de Carisma to your Força ( Athletics ) check or Destreza ( Acrobatics ) checks.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  6,
  'Simbiótico Sentinela',
  'Your patron remains alert to threats to its host at all times. Você pode’t be surprised and you have Vantagem on Initiative rolls. You also have Vantagem on salvaguardas to avoid or end the Charmed and condição Amedrontados.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  10,
  'Gerar Peão',
  'You always have the Dominate Person spell prepared. Você pode also cast it once without a espaço de magia, and você recupera the ability to do so when you finish a Descanso Longo. Além disso, taking damage can’t break your Concentração on Dominate Person . When a creature succeeds on its salvaguarda, it takes dano Psíquico igual a your Warlock level.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-parasite-patron'),
  14,
  'Larval Regeneração',
  'Quando você die, a larval parasite bursts from your corpse. You control the parasite. The parasite uses the Rat stat block except it has your Pontos de Vida; Dados de Vida; Inteligência, Sabedoria, and Carisma scores; class features; languages; and feats. It can’t cast spells. Além disso, it has o seguinte ability: Burrowing Possession. Como ação Mágica, the parasite can cause a Humanoidee within 1,5 m of it to make a Força or Destreza salvaguarda (sua escolha) against your Warlock spell save CD. On a failed save, the parasite burrows into the creature, dealing Perfurante damage igual a your Warlock level. While burrowed inside a creature, the parasite can’t take any action, Ação Bônus, or Reação, has Total Cover , and has Imunidade to all damage except dano Psíquico. On each of the creature’s subsequent turns, it can use its action to make a Constituição salvaguarda against your Warlock spell save CD. If the creature succeeds, the parasite is ejected from its body and into an unoccupied space of the creature’s choice within 1,5 m of it. If the parasite is burrowed inside the creature when the creature’s turn ends, the creature takes dano Necrótico igual a twice your Warlock level. If esse dano reduces the creature to 0 Pontos de Vida, it immediately dies, the parasite disappears, and you take over the body of the Humanoidee as se você had been targeted by the Reincarnate spell and rolled the species the Humanoidee had been. Se você are returned to life, such as by the Revivify spell, your parasite immediately disappears. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  3,
  'Justo e Torpe',
  'The spells listed below can be added to your grimório for no cost when you reach the associated level. Each time you finish a Descanso Longo, choose whether you are siphoning power from Arch Daemons or Arch Seraphs. Consult the table below that corresponds to sua escolha; você pode prepare the spells listed for your nível de Mago and lower, but você pode’t prepare the ones for the opposite faction. For example, se você choose Arch Daemon as your siphoned power, você pode’t prepare the spells listed in the Arch Seraph section.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  3,
  'Roubado Segredos',
  'Você tem uncovered or stolen secret power from agents of the Arch Daemons and Arch Seraphs. Você ganha um Eldritch Invocation de sua escolha. Prerequisites. If an invocation hcomo prerequisite, you must meet it to learn that invocation. If an invocation hcomo Warlock level prerequisite, you use your nível de Mago instead. For example, if an invocation requires you to be a level 5+ Warlock, você pode select the invocation once you reach nível de Mago 5. Replacing and Gaining Invocations. Sempre que você gain a nível de Mago, você pode replace one of your invocations with another one for which you qualify. Você pode’t replace an invocation if it’s a prerequisite for another invocation that you have. Você ganha um adicional invocation when you reach nível de Magos 6 and 14. Você pode’t pick the same invocation more than once unless its description says otherwise. Intelligent Invocations. Você pode usar your modificador de Inteligência instead of your modificador de Carisma for your invocations.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  6,
  'Emprestadas Línguas e Peles',
  'Your ability to siphon power from Celestials and Fiends is enhanced. Você ganha os seguintes benefícios. Arch Daemon Boon. While you are siphoning power from Arch Daemons, you have Resistência to dano Necrótico. Além disso, Fiends that know languages can underste seu speech and você pode understand theirs, even se você do not share a language. Arch Seraph Boon. While you are siphoning power from Arch Seraphs, you have Resistência to dano Radiante. Além disso, Celestials that know languages can underste seu speech and você pode understand theirs, even se você do not share a language. Switch Sides. Como Ação Bônus, você pode change which power you are siphoning from. Uma vez você switch, você pode’t do so again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  10,
  'Sobrenatural Countenance',
  'Como Ação Bônus, you adopt an infernal or celestial countenance for 10 minutes. For the duration, your appearance gains aspects of the power você escolhe. Você ganha os seguintes benefícios. Commanding Presence. Você tem Vantagem on Carisma checks. Improved Spells. Quando você expend a espaço de magia to cast a spell from the Arch Daemon or Arch Seraph table, the spell is cast as se você had spent a espaço de magia of one level higher. Unearthly Wings. Você ganha um Fly Speed of 18 m.Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo. Você pode also restore your use of it by expending a level 5+ espaço de magia (no action required).'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'daemonologist'),
  14,
  'Eterna Guerra Erupção',
  'You use the powers at your command to call forth warring celestials and infernals. Como ação Mágica, you summon a manifestation of the war between Arch Daemons and Arch Seraphs in a 9 m-radius Sphere centered on a point within 36 m of yourself. Each creature in the Sphere must make a Carisma salvaguarda against your spell save CD. On a failed save, a creature takes 4d10 dano Necrótico, 4d10 dano Radiante, and has the Blinded condition até o fim de its next turn. On a successful save, a creature takes half as much damage only. As part of the same action, você pode change the power you are siphoning from, and you also regain 1 Wizard espaço de magia de sua escolha of 5th level or lower. Depois de usar este recurso, você pode’t use it again until you finish a Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  3,
  'Poção Ofício',
  'Você ganha proficiency in the Medicine skill and proficiency with the Herbalism Kit and Alchemist’s Supplies . Além disso, you have learned to create magical potions. Crafting. With 10 minutes of work or when you finish a Short or Descanso Longo, você pode prepare magical potions se você have an Herbalism Kit or Alchemist’s Supplies . Quando você do so, you must expend a level 1+ espaço de magia for each potion you create and choose a spell from your grimório that targets only one creature. The chosen spell must be of an equal or lower level than the expended espaço de magia. Consuming. Como Ação Bônus, a creature can drink the potion or administer it to another creature within 1,5 m of it. When a creature consumes the potion, it becomes the target of the spell as se você had cast it. If the spell requires Concentração , the creature that consumes the potion Concentrates on it. Unconsumed potions last until you finish a Descanso Longo or until you use este recurso again.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  3,
  'Boa Medicina',
  'Quando você craft a potion, você pode choose to expend a espaço de magia without choosing a spell to craft a dose of Good Medicine. Como Ação Bônus, você pode drink the dose or administer it to another creature within 1,5 m of yourself. When Good Medicine is consumed, roll um número de d8s igual a the level of the espaço de magia expended, and the target regains Pontos de Vida igual a the roll’s total. Se você expended a level 3+ espaço de magia on este recurso, Good Medicine also removes the condição Envenenado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  6,
  'Má Medicina',
  'Quando você craft a potion, você pode choose to expend a espaço de magia without choosing a spell to craft a dose of Bad Medicine. Quando você create a dose, choose one effect per level of the espaço de magia expended. The creature has the condição Envenenado. The creature’s Speed is halved. The creature takes an extra 1d4 dano Necrótico the first time it takes damage each turn. The creature takes 1d6 dano de Veneno each time it takes an action, Ação Bônus, or Reação. The creature takes dano Ácido igual a the level of the espaço de magia expended at the start of each of its turns. Como ação Mágica, você pode hurl a dose of Bad Medicine at a point você pode see within 9 m. Creatures within 3 m of that point must make a Constituição salvaguarda against your spell save CD. On a failed save, the target suffers one of the chosen effects por 1 minuto. On each of its turns, the target can take an action and repeat the save, ending the effect on itself on a success.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  10,
  'Respirar Isso Em',
  'Being persistently exposed to the deadliest ailments known has given you some small measure of resistance. After you take Necrotic or dano de Veneno, you gain Pontos de Vida Temporários igual a the damage taken. Além disso, you are immune to the condição Envenenado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'plague-doctor'),
  14,
  'Medicinal Mestre',
  'When Good Medicine restores Pontos de Vida to a creature, that creature regains 2d8 additional Pontos de Vida. When Bad Medicine deals dano Ácido to a creature, that creature takes 2d8 extra dano Ácido. Além disso, target creatures have Desvantagem on their salvaguarda. It’s amazing what one can manage with just a few herbs and decades of intense singleminded study. — Tawnybruck Malore,'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  3,
  'Especialista em Sangromancia',
  'Magias de Sangromancia contam como magias de Mago para você. Escolha duas magias de Sangromancia, cada uma de no máximo 2º círculo, e adicione-as ao seu grimório gratuitamente. Além disso, sempre que ganhar acesso a um novo nível de espaços de magia nesta classe, você pode adicionar uma magia de Sangromancia ao grimório gratuitamente. A magia escolhida deve ser de um nível para o qual você tenha espaços de magia.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  3,
  'Sangue Pleno',
  'Você extrai magia do sangue, representada pelos Dados de Sangromancia que alimentam os poderes desta subclasse. Você tem um pool de d12 que pode gastar no lugar de um Dado de Vida ao conjurar magias de Sangromancia. O número de dados no pool é igual a 1 + seu nível de Mago. Recupera 1 Dado de Sangromancia ao terminar um Descanso Curto e todos ao terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  6,
  'Vigor Sanguíneo',
  'Seu máximo de Pontos de Vida aumenta em 6 e aumenta em 1 sempre que você ganha um nível de Mago. Além disso, sempre que conjura uma magia de Sangromancia gastando um espaço de magia, recupera Pontos de Vida iguais ao nível do espaço gasto.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  10,
  'Sangue por Sangue',
  'Uma vez em cada um dos seus turnos, quando você causar dano a uma ou mais criaturas com uma magia de Mago que conjurou, pode gastar um Dado de Vida ou um Dado de Sangromancia, rolar o dado e causar dano extra a uma dessas criaturas igual ao resultado. Se a criatura estiver Ferida, você rola duas vezes e usa o maior resultado.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  14,
  'Renovação Rubra',
  'Ao terminar um Descanso Curto, recupera Dados de Vida e Dados de Sangromancia gastos em quantidade igual à metade do seu nível de Mago. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo.'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

