-- Seed Valda species traits
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Darkvision',
  'Darkvision. You have Darkvision with a range of 60 feet.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Construct Nature',
  'Construct Nature. You don’t need food, drink, or air. You don’t need to sleep, and magic can’t put you to sleep. You can finish a Long Rest in 4 hours if you spend those hours in a motionless state, during which you retain consciousness.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Handcrafted Quality',
  'Handcrafted Quality. Your design might be unnerving, articulated, or friendly. You have proficiency in the Intimidation, Performance, or Persuasion skill.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Gepettin Construction',
  'Gepettin Construction. For simplicity, geppettin are classified by their materials: bisque are porcelain, marionettes are wood, and plushies are made of fabric. Choose one of the following constructions.

Bisque. You are indistinguishable from a porcelain doll until the moment you strike. Whenever you deal damage to a creature with a weapon attack roll on your first turn in combat, the creature takes extra damage equal to your Proficiency Bonus. The damage is the same type dealt by the weapon.

Marionette. Loose strings hang from your jointed limbs. During your turn, your reach is 5 feet greater with any Melee weapon that lacks the Reach, Two-Handed, and Versatile properties.

Plushie. You are stuffed with fluff. When you take Bludgeoning damage, you can take a Reaction to gain Resistance to the triggering damage. You are also knocked 5 feet away from the source of the damage. You can’t take this Reaction if you can’t be knocked away from the source of the damage.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Bisques',
  'Bisque geppettin are a form of porcelain doll, crafted with exacting specification and luxurious clothing materials. Though they are designed to look as realistic as possible, they are often the most terrifying geppettin due to their lifeless visages.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Marionettes',
  'Marionette geppettin are made mostly out of wood, with painted faces and carved clothing. Due to their construction, their jointed limbs are quite flexible, and they are known to be fantastic dancers. The very largest marionettes, called mannequins, stand as tall as a human and bear completely blank, expressionless faces.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
  'Plushies',
  'Plushies, also called raggedies, are any form of stuffed or soft geppettin. Though they often look Humanoid, they may also look like animals, monsters, or any other anthropomorphic creature.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Plant Nature',
  'Plant Nature. As long as you are in direct sunlight for at least 4 hours a day, you don’t need to eat. Additionally, you can breathe through your leaves and you can absorb water and nutrients through your feet.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Natural Connection',
  'Natural Connection. You have proficiency in the Nature or Survival skill.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Root Magic',
  'Root Magic. You know the Shillelagh cantrip and can target yourself with the spell, treating one of your limbs as a Club for the duration of the spell.

When you reach character level 3, you always have Goodberry prepared, and when you reach character level 5, you always have Barkskin prepared. You can cast each of these spells without a spell slot. Once you cast either spell in this way, you can’t cast that spell in this way again until you finish a Long Rest. You can also cast these spells using spell slots you have of the appropriate level. Intelligence, Wisdom, or Charisma is your spellcasting ability for the spells you cast with this trait (choose the ability when you select this species).',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;

INSERT INTO rpg.phb_species_trait (
  species_id, name, description, choice_kind
)
VALUES (
  (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
  'Entangling Vines',
  'Entangling Vines. You can take a Bonus Action to cause grasping weeds and vines to sprout up from the ground around a Large or smaller creature you can see within 30 feet of yourself. Until the end of the creature’s next turn, its Speed is 0 and can’t increase. This effect ends early if the creature replaces one of its attacks with with freeing itself. You can use this Bonus Action a number of times equal to your Proficiency Bonus and you regain all expended uses when you finish a Long Rest.

When you reach character level 3, your Entangling Vines gain an additional effect based on the season in which you were harvested (choose when you select this species):

Spring. Your Entangling Vines can target an airborne creature within 30 feet of the ground, which is pulled safely to the ground when you use this trait.

Summer. Your Entangling Vines can move the target up to 10 feet to an unoccupied space on the ground or floor.

Autumn. Your Entangling Vines can affect a second creature within 5 feet of the first target.

Winter. The target takes Cold damage equal to your Proficiency Bonus.',
  NULL
)
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description;
