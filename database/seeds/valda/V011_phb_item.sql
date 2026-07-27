-- Seed Valda magic items
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'frog-prince-statuette',
  'other'::rpg.item_type,
  'Frog Prince Statuette',
  NULL,
  NULL,
  'While holding this clay statuette of a frog, you can speak its command word and kiss it to cast the spell Mandy’s Feral Follower, transforming the statuette into a Commoner. The commoner created by the statuette retains the memories of each time it is transformed, no matter what appearance you ascribe to it.

Once it has been used, the statuette can’t transform again until the next dawn.',
  '{"magic":true,"category":"Wondrous Item","rarity":"rare","rarityLabel":"Rare","requiresAttunement":false,"source":"valda-spire-player-pack","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'leonora-s-throne-of-indolence',
  'other'::rpg.item_type,
  'Leonora’s Throne of Indolence',
  NULL,
  '100 pounds',
  'This high-backed armchair made of oak and gold weighs 100 pounds. When you sit in it and speak its command word as a Magic action, it hovers beneath you and can fly through the air. The throne has a Fly Speed of 50 feet, can hover, and can carry up to 400 pounds. The throne stops hovering when you speak its command word again.

By speaking a second command word, you can cast Unseen Servant using the throne. The servant can conjure a spectral trumpet to announce your arrival, in addition to its usual tasks.

Lastly, you can speak a third command word as a Magic action to magically create up to 10 pounds of delicious food of your choice and up to four bottles of wine. Only you can partake of this meal and drink; it instantly becomes stale and sickening in another creature’s mouth. Once you have spoken this third command word, you can’t do so again until the next dawn.',
  '{"magic":true,"category":"Wondrous item","rarity":"very-rare","rarityLabel":"Very Rare","requiresAttunement":true,"attunement":"Requires Attunement","source":"valda-spire-player-pack","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'memento-mori',
  'other'::rpg.item_type,
  'Memento Mori',
  NULL,
  NULL,
  'This sealed letter, infused with Chronomancy magic, contains a written description of how the creature that reads it shall die. The letter always contains specific descriptions, such as “The red-eyed orc drove its blade through Faizon the Blue’s heart,” but may also use cryptic or vague language. It never specifies an exact time. Once a creature has read the letter, it has Advantage on Death Saving Throws, and dies only after gaining five Death Saving Throw failures, instead of three. However, when the creature arrives at the moment of its death described in the letter, it dies without making Death Saving Throws if it is reduced to 0 Hit Points.

Once a Memento Mori is opened and read, it becomes an ordinary letter. Its effects end only if the creature that read it dies and is later restored to life.',
  '{"magic":true,"category":"Wondrous Item","rarity":"rare","rarityLabel":"Rare","requiresAttunement":false,"source":"valda-spire-player-pack","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'portable-cannonballs',
  'weapon'::rpg.item_type,
  'Portable Cannonballs',
  NULL,
  NULL,
  'This bag contains twenty iron balls, each measuring one inch in diameter and weighing 1/4 of a pound. When poured out of their bag as a Utilize action, the balls function as Ball Bearings.

As a Bonus Action, you can speak the command word, which causes a number of the balls that you choose to expand into full-size cannonballs weighing 10 pounds each, suitable for firing from a cannon. A creature in the path of one or more cannonballs rolling downhill must succeed on a DC 13 Dexterity saving throw or take 2d10 Bludgeoning damage and have the Prone condition if it is Large or smaller.

Each iron ball can also be used as a Sling Bullet or a Firearm Bullet. As a Bonus Action when you make an attack with an iron ball as ammunition, you can expand it in midair. On a hit, this attack deals Bludgeoning damage equal to 2d12 plus the ability modifier used for the attack roll instead of the weapon’s normal damage.',
  '{"magic":true,"category":"Weapon (Bullet)","rarity":"uncommon","rarityLabel":"Uncommon","requiresAttunement":false,"weaponSubtype":"Bullet","source":"valda-spire-player-pack","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'ring-of-barrels',
  'other'::rpg.item_type,
  'Ring of Barrels',
  NULL,
  NULL,
  'This ring has 6 charges and regains 1d6 expended charges daily at dawn. While wearing the ring, you can take a Magic action and expend 1–3 charges to summon a number of empty Barrels in spaces within 5 feet of you equal to the number of charges expended. A Barrel provides Half Cover to a Medium or smaller target behind it and can be moved or set to rolling with a Utilize action. A Barrel has AC 15 and 20 HP.

If you summon a Barrel into a space occupied by a Medium or smaller creature, the creature must succeed on a DC 13 Dexterity saving throw to be trapped within the Barrel. It has Advantage on its saving throw unless its Speed is 0. A Medium creature trapped within a Barrel has the Restrained condition, whereas a Small or smaller creature has Total Cover from effects outside the Barrel. Bursting free of the Barrel requires a successful DC 20 Strength (Athletics) check as an action.',
  '{"magic":true,"category":"Ring","rarity":"uncommon","rarityLabel":"Uncommon","requiresAttunement":true,"attunement":"Requires Attunement","source":"valda-spire-player-pack","editionSlug":"valda-spire-2024-en","citationSlug":"valda-spire-2024-en:player-pack"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
