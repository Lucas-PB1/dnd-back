-- Seed Valda subclasses (Player Pack)
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'path-of-the-muscle-wizard',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Path of the Muscle Wizard',
  'Be a Buff, Angry “Wizard”',
  'You’re a wizard! Perhaps you went to wizarding school on a football scholarship or just picked up a book at the gym and started reading. No matter how you got here, you’re a wizard, one that just coincidentally has massive, rippling muscles. You have the big dumb hat and the book',
  'You’re a wizard! Perhaps you went to wizarding school on a football scholarship or just picked up a book at the gym and started reading. No matter how you got here, you’re a wizard, one that just coincidentally has massive, rippling muscles. You have the big dumb hat and the book filled with gibberish and everything!

Lucas Ferreira CM

You gently remind others, often by beating them to a pulp and cracking their bones, that your magical powers shouldn’t be questioned. You’re a good wizard—the best one, even! And only a fool would say otherwise.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'dungeoneer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Dungeoneer',
  'Survive the Dungeon',
  'Only fools would dive headfirst into an abandoned crypt filled with monsters and deathtraps, but it seems only fools emerge from such crypts laden with as much loot as they can carry. The archetypal dungeon delver is a veteran of such suicidal dungeon delves, and has become intim',
  'Only fools would dive headfirst into an abandoned crypt filled with monsters and deathtraps, but it seems only fools emerge from such crypts laden with as much loot as they can carry. The archetypal dungeon delver is a veteran of such suicidal dungeon delves, and has become intimately familiar with the hazards therein. In the course of their adventures, such a Dungeoneer will have adopted countless best practices, along with a litany of unproven superstitions which they believe keeps them alive. Principles from “always be the first one to hit the monster” to “never be the first one to touch a treasure chest” line a Dungeoneer’s journal. However, it’s probably better to be paranoid and superstitious than lying at the bottom of a pit trap, incinerated by a Fireball, or digested by a mimic.

Martin Kirby-Jackson',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'warrior-of-the-street',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
  'Warrior of the Street',
  'Strike with Combos and Special Moves',
  '“Street fighting” is an urban discipline founded on necessity, whose blindingly fast, unique brand of martial arts has been honed and perfected in back-alley brawls and tournaments alike. Monks who adopt this relatively new technique place comparatively little value on spiritual ',
  '“Street fighting” is an urban discipline founded on necessity, whose blindingly fast, unique brand of martial arts has been honed and perfected in back-alley brawls and tournaments alike. Monks who adopt this relatively new technique place comparatively little value on spiritual enlightenment and inner focus; the thrill of split-second timing, rapid combos, and decisive knock-outs drive them to become the best combatants in the world.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'oath-of-revelry',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Oath of Revelry',
  'Work Hard and Party Harder',
  'Paladins who swear the Oath of Revelry make a solemn vow to party day and night until their hearts give out. The antithesis of stuffy, lawful crusaders, these emissaries of carousal travel the land, crashing parties and raising hell wherever they raise a glass. Authorities bristl',
  'Paladins who swear the Oath of Revelry make a solemn vow to party day and night until their hearts give out. The antithesis of stuffy, lawful crusaders, these emissaries of carousal travel the land, crashing parties and raising hell wherever they raise a glass. Authorities bristle at their arrival, but the youth cheer, for a Party Paladin is always accompanied by a good time.

These paladins share the following tenets:

Abide by the doctrines of the Codicus Brodicus.

Celebrate every occasion, inviting friend and foe alike.

When necessary, fight for your right to party.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'arachnoid-stalker',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Arachnoid Stalker',
  'Sling Webs and Crawl Walls',
  'A life-changing event, such as being cursed by a drider or being bitten by a dangerously transmuted arachnid, has imbued you with the abilities of a spider. This transformation might have left you physically unchanged, or you may have developed a half-dozen eyes, lanky and hairy ',
  'A life-changing event, such as being cursed by a drider or being bitten by a dangerously transmuted arachnid, has imbued you with the abilities of a spider. This transformation might have left you physically unchanged, or you may have developed a half-dozen eyes, lanky and hairy limbs, or a set of inhuman mandibles. Whatever the side effects, you can now produce deadly poison and ropes of silken web from your palms, and even scale walls with your fingertips.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
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
  'future-you-patron',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'Future You Patron',
  'Manipulate Time with Help from the Future',
  'Your patron is you in a decades-distant future. Perhaps your future self found an artifact of great power connecting them to the past, which they must now lead you to discover, or perhaps they were taught the mystic arts by their future self long ago, a cycle you will have to con',
  'Your patron is you in a decades-distant future. Perhaps your future self found an artifact of great power connecting them to the past, which they must now lead you to discover, or perhaps they were taught the mystic arts by their future self long ago, a cycle you will have to continue someday. Your future self has forgotten the fine details of some things and outright refuses to tell you about things you “can’t know yet,” but nevertheless offers compelling insight and guidance. You’re not quite sure what your future self is planning for your future (and for their past), but one thing is certain—they need you alive.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:player-pack')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;
