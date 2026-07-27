-- Seed Valda Gunslinger class
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_class (
  slug, name, tagline, summary, description,
  primary_ability_label, primary_ability_operator,
  hit_die_id, hp_level1_die_value, hp_fixed_per_level,
  hp_minimum_gain_per_level, hp_constitution_mod_applies,
  subclass_unlock_level, subclass_label,
  skill_choice_count, skill_choice_from,
  source_citation_id, spell_slot_pattern_id
)
VALUES (
  'gunslinger',
  'Gunslinger',
  '## Guts and Gunpowder',
  'Risk is in a Gunslinger’s blood. They are bold renegades, bucking tradition and forging a new path with dangerous and inelegant firearms. Gunslingers are infamous for surviving by their wits and relying on split-second timing and a considerable amount of luck to survive.',
  'Risk is in a Gunslinger’s blood. They are bold renegades, bucking tradition and forging a new path with dangerous and inelegant firearms. Gunslingers are infamous for surviving by their wits and relying on split-second timing and a considerable amount of luck to survive.

## Guts and Gunpowder

Black powder isn’t for the faint of heart. Its thunderous applause is volatile and imprecise—a barely controlled explosion directed at an enemy. Only the truly fearless seek to master it. But Gunslingers have nerves of steel, hurling death from their guns in a roaring cacophony. Adapted for shootouts, gunslingers are mobile and daring, knowing that life or death hangs on snap decision-making and one’s own mettle.

## Dangerous Outsiders

A Gunslinger’s explosive lifestyle lends well to wandering and adventuring. Gunslingers often shoot first and ask questions later, an attitude which earns them few friends and bountiful enemies. In their travels, most gunslingers are secretive and take great lengths to go unnoticed, lest they be spotted by old foes with scores to settle.

## Core Traits

Dexterity

Hit Point Die
D8 per Gunslinger level

Saving Throw Proficiencies
Dexterity and Charisma

Choose 2: Acrobatics, Animal Handling, Athletics, Deception, Insight, Intimidation, Perception, Persuasion, Sleight of Hand, and Stealth

Simple weapons and Martial Ranged weapons

Light armor

Choose A or B: (A) Leather Armor, 2 Daggers, Revolver, 50 Bullets, Explorer’s Pack, and 11 GP; or (B) 175 GP',
  'Dexterity',
  NULL,
  (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'),
  8,
  5,
  1,
  TRUE,
  3,
  'Creed',
  2,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger'),
  NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  primary_ability_label = EXCLUDED.primary_ability_label,
  hit_die_id = EXCLUDED.hit_die_id,
  hp_level1_die_value = EXCLUDED.hp_level1_die_value,
  hp_fixed_per_level = EXCLUDED.hp_fixed_per_level,
  subclass_unlock_level = EXCLUDED.subclass_unlock_level,
  subclass_label = EXCLUDED.subclass_label,
  skill_choice_count = EXCLUDED.skill_choice_count,
  source_citation_id = EXCLUDED.source_citation_id;
