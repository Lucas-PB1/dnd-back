-- Grim Hollow Cap. 1 — builds tradicionais sugeridos por herança

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'potent-breath'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'damage-immunity'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'incomparable-roar'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'shared-movement'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'powerful-shove'),
  6,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'terrifying-influence'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dragonborn'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'force-of-faith'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'damage-immunity'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extra-tough'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'weapon-specialist'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'poison-indemnity'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'stand-fast'),
  6,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'artisanal-expertise'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dwarf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'crafter-s-cunning'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'reawakened'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'immutable-mind'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'weapon-specialist'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'restorative-rest'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'faultless-shroud'),
  6,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'piercing-perception'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-elf'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extended-fortification'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'astute-slip'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'smoker'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'long-fade'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'focused-mastery'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-gnome'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'primal-voice'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'infectious-bravery'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'subtle-cover'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'master-of-fortune'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'helpful-tactics'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'nimble-passage'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extreme-resilience'),
  6,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'artisanal-expertise'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-halfling'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'deep-lore'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'maximum-critical'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'strong-strike'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'weapon-specialist'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'helpful-tactics'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'expert-orientation'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'artisanal-expertise'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'determined-survivor'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-human'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'skill-mastery'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'focused-initiative'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'stalwart-edge'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'helpful-tactics'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extreme-resilience'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'secret-dreams'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'expert-improviser'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dreamer'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'piercing-perception'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'battlefield-dominance'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'centered-edge'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'powerful-shove'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'vigorous'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'artisanal-expertise'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'master-artisan'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-grudgel'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'reawakened'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'spirit-s-strength'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'water-born'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'quickened-swim'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'animal-ally'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-laneshi'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'primal-voice'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'moving-insight'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'immutable-mind'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'adaptive-awareness'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'shared-movement'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'powerful-shove'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'master-manipulator'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'exceptional-insight'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-ogresh'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'tongue-of-gold'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;


INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extended-fortification'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'hard-to-kill'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extra-tough'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'self-repair'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'immune-to-the-elements'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'deep-lore'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-historian'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-arisen'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'regenerative-healer'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'to-the-dregs'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'swift-strike'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'protective-cover'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'wall-walker'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'improved-darkvision'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'expert-deceiver'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-dhampir'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extended-fortification'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'hindering-distraction'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'phase-shift'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'ethereal-focus'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'immune-to-the-elements'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-historian'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-disembodied'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'sangromancy-savant'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'strength-of-life'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'immune-to-the-elements'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'restorative-rest'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'vigorous'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-downcast'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'force-of-faith'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'subtle-cover'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extended-fortification'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'self-repair'),
  3,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'helpful-tactics'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'nimble-passage'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'magical-savant'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wechselkind'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'stunt-expert'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'relentless-instinct'),
  1,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'swift-strike'),
  2,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'pack-leader'),
  3,
  'combat'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'furious-speed'),
  4,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'wall-walker'),
  5,
  'exploration'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'athlete-s-resolve'),
  6,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'piercing-perception'),
  7,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;
INSERT INTO rpg.phb_heritage_traditional (heritage_id, trait_id, sort_order, category_hint)
VALUES (
  (SELECT id FROM rpg.phb_heritage WHERE slug = 'gh-wulven'),
  (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'primal-voice'),
  8,
  'roleplaying'::rpg.heritage_trait_category
)
ON CONFLICT (heritage_id, trait_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  category_hint = EXCLUDED.category_hint;

