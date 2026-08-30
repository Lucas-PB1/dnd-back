-- Grim Hollow — Caçador de Monstros features

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  1,
  'Grimório de Monstros',
  'You create or inherit a repository of knowledge known como Grimório de Monstros. Each Caçador de Monstros carries a grimoire, a manual on dangerous creatures. A Caçador de Monstros’s grimoire is an object entirely unique to each hunter. It may be a leather tome recovered from a dusty library with notes made in the margins, a set of blood-stained scrolls inherited from a previous hunter, or a precious stone with a communing spirit held within. If a Caçador de Monstros ever loses a grimoire, the hunter has retained enough knowledge to not suffer immediate drawbacks. However, the hunter can’t add to the grimoire until it is restored and therefore can’t take another Caçador de Monstros level until a lost grimoire has been replaced. A grimoire can be recreated by spending 8 hours and 50 PO worth of materials such as books, scrolls, and ink. Choose two types of creatures that you are specialized in hunting from o seguinte list: Aberrations, Beasts, Celestials, Constructs, Dragons, Elementals, Fey, Fiends, Giants, Monstrosities, Oozes, Plants, or Undead. You add your Bônus de Proficiência to Inteligência and Sabedoria checks you make that relate to the creature types in your grimoire. For example, if Undead are in your grimoire, you add your Bônus de Proficiência to an Inteligência ( History ) check to recall lore about an Undead creature you’re investigating or a Sabedoria ( Medicine ) check to identify claw marks left on a corpse by an Undead creature. Se você are already proficient in a skill when asked to make an Inteligência or Sabedoria ability check relating to the monster types in your grimoire, you add double your Bônus de Proficiência instead. Quando você gain este recurso, you also learn one language based on the chart below. (Você pode add languages to this chart based on your own campaign world.)'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  1,
  'Maestria em Armas',
  'Your training with weapons allows you to use the mastery properties of two kinds of weapons de sua escolha with which you have proficiency, such as Longbows and Longswords. Sempre que você finish a Descanso Longo, você pode practice weapon drills and change one of those weapon choices. Quando você alcança certain Caçador de Monstros levels, you gain the ability to use the mastery properties of more kinds of weapons, as shown in the Maestria em Armas column of the Caçador de Monstros Features table.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  2,
  'Estilo de Luta',
  'Você ganha um Estilo de Luta feat de sua escolha.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  2,
  'Studied Resposta',
  'Você tem learned the most effective way to slay a monster is to strike its most vulnerable area at the right moment. Too early, e seu attack glances away. Too late, and the monster may eviscerate you. When a creature você pode see within 18 m of you targets you or another creature with a melee or ranged attack, você pode take a Reação before the jogada de ataque to make one attack with a weapon or an Ataque Desarmado against that creature. If the attack misses, você recupera the use of your Reação.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  3,
  'Monster Caçador Subclass: Hunting Guild',
  'Você ganha um Caçador de Monstros subclass de sua escolha. The Carver Guild , Devourer Guild , Occultist Guild , and Trapper Guild subclasses are detailed below. A subclass is a specialization that grants you features at certain Caçador de Monstros levels. The guild você escolhe grants you features when you reach Caçador de Monstros levels 3, 7, 10, 15, and 18.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  4,
  'Aprimoramento de Atributo',
  'Você ganha the Aprimoramento de Atributo feat or another feat de sua escolha for which you qualify. Você ganha este recurso again at Caçador de Monstros levels 8, 12, 16, and 19.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  5,
  'Expert Golpe',
  'Você aprende weaknesses of monsters so that você conhece exactly onde atacar to inflict the most damage. Você pode add your modificador de Inteligência to the attack and jogada de danos of your weapons and Ataque Desarmados .'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  6,
  'Aprimorado Monster Grimoire',
  'Você tem expanded your Grimório de Monstros with your experience and knowledge. Você pode select a third creature type to add to your Grimório de Monstros from o seguinte list: Aberrations, Beasts, Celestials, Constructs, Dragons, Elementals, Fey, Fiends, Giants, Monstrosities, Oozes, Plants, or Undead. Você pode’t choose a creature type you have chosen before. All the benefits you gain from your Grimório de Monstros now also apply to this new type. Além disso, your jogada de ataques with weapons and Ataque Desarmados against creature types in your Grimório de Monstros can score a Acerto Crítico on a roll of 19 or 20 on the d20.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  9,
  'Knowledgeable Defesa',
  'Você pode rely on your knowledge to anticipate a monster’s actions and summon your best defense. Whenever a creature type in your Grimório de Monstros forces you to make a salvaguarda, você pode make an Inteligência salvaguarda in place of that salvaguarda instead.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  11,
  'Extra Ataque',
  'Você pode attack twice instead of once whenever you take the ação Atacar no seu turno.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  13,
  'Aprimorado Monster Grimoire',
  'Your Grimório de Monstros is further expanded by your encounters and studies. Você pode select a fourth creature type to add to your Grimório de Monstros from o seguinte list: Aberrations, Beasts, Constructs, Celestials, Dragons, Elementals, Fey, Fiends, Giants, Monstrosities, Oozes, Plants, or Undead. Você pode’t choose a monster type you have chosen before. All the benefits you gain from your Grimório de Monstros now also apply to this new monster type.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  14,
  'Lair Sentido',
  'Você é experienced at navigating the threats that arise near a monster’s lair. Você tem Vantagem on salvaguardas and Resistência to the damage of lair actions and regional effects caused by creatures. Além disso, you have Vantagem on salvaguardas and Resistência to damage against the Legendary Açãos of creature types in your Grimório de Monstros.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  17,
  'Slayer Auxílio',
  'You''re able to coordinate with your allies to quickly slay dangerous monsters. Quando você use Resposta Estudada, choose a Aliado creature that can see or hear you. That creature can use its Reação to make one attack with a weapon or Ataque Desarmado against the creature that triggered your Resposta Estudada. If the ally does not have their Reação, they regain it but then must use it to make the attack. Your ally''s attack occurs after yours but before the target creature rolls its own attack. This ability refreshes at the start of your turn.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  19,
  'Epic Dádiva',
  'Você ganha an Dádiva Épica feat or another feat de sua escolha for which you qualify.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_class_feature (class_id, level, name, description)
VALUES (
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  20,
  'Grave Golpe',
  'Você ganha a capacidade de strike mortal blows against the creatures you have studied. Your jogada de ataques with weapons and Ataque Desarmados against creature types in your Grimório de Monstros can now score a Acerto Crítico on a roll of 18 through 20 on the d20. Quando você score a Acerto Crítico against a creature type in your Grimório de Monstros, the creature must make a Constituição salvaguarda. The CD equals the damage taken, up to a maximum CD of 30. On a failed save, the creature drops to 0 Pontos de Vida. On a successful save, the creature takes the attack’s normal damage. Você pode usar este recurso um número de times igual a your modificador de Inteligência (mínimo de once), and você recupera all expended uses when you finish a Descanso Longo.'
)
ON CONFLICT (class_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

