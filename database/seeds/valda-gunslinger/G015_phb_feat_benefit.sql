-- Seed Gunslinger pack feat benefits

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
  1,
  'Ability Score Increase',
  'Ability Score Increase. Increase your Dexterity score by 1, to a maximum of 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
  2,
  'Flip Die',
  'Flip Die. Once per turn, when you roll for damage with a Ranged weapon, you can flip one of the damage dice over and use the number on the bottom. You can’t use this ability on d4s. Note that for a balanced die, the top and bottom numbers add up to one more than the die’s largest number.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'),
  3,
  'Enhanced Critical',
  'Enhanced Critical. When you score a Critical Hit with a Ranged weapon, the target’s Speed is 0 until the end of its next turn.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  1,
  'Ability Score Increase',
  'Ability Score Increase. Increase your Dexterity by 1, to a maximum of 20.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  2,
  'Ranged Weapon Proficiency',
  'Ranged Weapon Proficiency. You gain proficiency with Ranged Martial weapons.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  3,
  'Cantrip',
  'Cantrip. You learn the Finger Guns cantrip.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  4,
  'Expanded Spell List',
  'Expanded Spell List. The following spells are added to your spell list: Antiballistics Field, Ballistic Smite, Conjure Cannonball, Conjure Cover, Jam Weapon, Jethro’s Instant Reload, and Perforating Shot.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES (
  (SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'),
  5,
  'Spells Prepared',
  'Spells Prepared. Choose a number of spells equal to your Proficiency Bonus from among those in the Expanded Spell List benefit. You always have these spells prepared. Whenever you gain a new level, you can replace one of these spells with a different spell from the Expanded Spell List.'
)
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
