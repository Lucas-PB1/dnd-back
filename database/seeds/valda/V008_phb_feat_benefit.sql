-- Seed Valda feat benefits
-- Gerado de docs/sources/valda-spire-of-secrets/extracted.json

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
  1,
  'Ability Score Increase',
  'Ability Score Increase. Increase your Strength score by 1, to a maximum of 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
  2,
  'Heavy Duelist',
  'Heavy Duelist. You can wield a Melee weapon with the Two-Handed property in one hand.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'),
  3,
  'Versatile Dual Wielder',
  'Versatile Dual Wielder. While wielding a Melee weapon with the Versatile property in one hand, the weapon has the Light property for you.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
  1,
  'Ability Score Increase',
  'Ability Score Increase. Increase your Charisma score by 1, to a maximum of 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
  2,
  'Command',
  'Command. As an action, you can issue a command to an ally within 60 feet that can hear you. It can immediately take an action as a Reaction. That action can be used to take only the Attack (one attack only), Dash, Dodge, Hide, Influence, Search, Study, or Utilize action.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'),
  3,
  'Tight Formation',
  'Tight Formation. While you are within 5 feet of two or more allies that don’t have the Incapacitated condition, enemies can’t have Advantage on attack rolls against you.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'),
  1,
  'Ability Score Increase',
  'Ability Score Increase. Increase your Strength or Dexterity score by 1, to a maximum of 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'),
  2,
  'Improved Critical',
  'Improved Critical. Your attack rolls with weapons and Unarmed Strikes can score a Critical Hit on a roll of 19 or 20 on the d20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  1,
  'Ability Score Increase',
  'Ability Score Increase. Increase your Strength or Dexterity score by 1, to a maximum of 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  2,
  'Underdog’s Resolve',
  'Underdog’s Resolve. When you are attacked by a creature that has a CR higher than your level, you gain a +2 bonus to your Armor Class for that attack.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  3,
  'Vengeful Strike',
  'Vengeful Strike. You have Advantage on attack rolls against any creature that has reduced one of your allies to 0 Hit Points since the end of your last turn.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (
  feat_id, sort_order, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'),
  4,
  'Heroic Intervention',
  'Heroic Intervention. When an enemy you can see takes a Legendary Action, you can take a Reaction to intercede, preventing the Legendary Action from happening. You can take this Reaction a number of times equal to your Proficiency Bonus and regain all expended uses when you finish a Long Rest.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
