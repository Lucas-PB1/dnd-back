-- Seed Gunslinger subclasses
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'deadeye',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Deadeye',
  'Shoot with Bullseye Precision',
  'A well-placed bullet is more powerful than a sword, arrow, or spell. Indeed, you believe that every violent conflict should sound like a single loud crack followed by a long silence. Such shots demand perfection, even at range, for when they are done right, they are as deadly for',
  'Shoot with Bullseye Precision

A well-placed bullet is more powerful than a sword, arrow, or spell. Indeed, you believe that every violent conflict should sound like a single loud crack followed by a long silence. Such shots demand perfection, even at range, for when they are done right, they are as deadly for the target as they are stupendous for the audience.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'high-roller',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'High Roller',
  'Gamble with Life and Death',
  'Fortune is a fickle thing—unless you’re a High Roller. These Gunslingers are master card sharps and dice throwers that mix their love of risk with their talent for gunplay. High Rollers push their luck until it runs out, then push harder. Why settle for a win when you could bet i',
  'Gamble with Life and Death

Fortune is a fickle thing—unless you’re a High Roller. These Gunslingers are master card sharps and dice throwers that mix their love of risk with their talent for gunplay. High Rollers push their luck until it runs out, then push harder. Why settle for a win when you could bet it all and win big?',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'secret-agent',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Secret Agent',
  'Engage in Espionage and Assassination',
  'Knowledge is power. The best way to defeat your enemies is by stealing what they know and replacing it with misinformation. To that end, you have been trained in the ways of covert warfare, giving you a broad range of abilities to complement your fearsome gunnery skills.',
  'Engage in Espionage and Assassination

Knowledge is power. The best way to defeat your enemies is by stealing what they know and replacing it with misinformation. To that end, you have been trained in the ways of covert warfare, giving you a broad range of abilities to complement your fearsome gunnery skills.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'spellslinger',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Spellslinger',
  'Complement Your Gunslinging with Arcana',
  'Magic and guns aren’t so different—arcane power is like gunpowder, a spell is like a bullet, and you are like a gun, directing your spells with precision at unfortunate targets. Spellslingers mix the disciplines of gunplay and spellcasting, sometimes loading arcane charges with y',
  'Complement Your Gunslinging with Arcana

Magic and guns aren’t so different—arcane power is like gunpowder, a spell is like a bullet, and you are like a gun, directing your spells with precision at unfortunate targets. Spellslingers mix the disciplines of gunplay and spellcasting, sometimes loading arcane charges with your shots and firing bullets enhanced with lighting, frost, or flame.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'trick-shot',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'Trick Shot',
  'Ricochet Bullets from Every Angle',
  'Noa Kriukova',
  'Ricochet Bullets from Every Angle

Accuracy means different things to different people. For you, true accuracy isn’t necessarily in hitting a target on the first shot, but might include hitting the mark after the bullet bounces around a dozen times. Your attacks are just as dangerous if they miss, or even after hitting their mark, as others’ are while they’re still in the air.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'white-hat',
  (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
  'White Hat',
  'Protect Your Allies and Uphold the Law',
  'Some Gunslingers live by a code and expect others to do the same. These Gunslingers, known as White Hats, sometimes serve as officers of the law but never hesitate to do what’s right when the law says otherwise. Despite their affinity for deadly weapons, White Hats prefer to keep',
  'Protect Your Allies and Uphold the Law

Some Gunslingers live by a code and expect others to do the same. These Gunslingers, known as White Hats, sometimes serve as officers of the law but never hesitate to do what’s right when the law says otherwise. Despite their affinity for deadly weapons, White Hats prefer to keep their friends safe and subdue their enemies nonviolently—a preference their enemies don’t often oblige.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
