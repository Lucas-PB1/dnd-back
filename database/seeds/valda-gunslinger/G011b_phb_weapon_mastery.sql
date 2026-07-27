-- Seed Valda firearm mastery properties

INSERT INTO rpg.phb_weapon_mastery (slug, name, description)
VALUES
  ('automatic', 'Automatic', 'When you make an attack with this weapon, you can choose to make two attacks instead. These attacks are always made with Disadvantage, regardless of circumstance. You can’t replace these attacks. If this weapon has the Ammunition property, these attacks use twice the normal amount of ammunition.'),
  ('explode', 'Explode', 'When you take the Attack action, you can replace one of your attacks with an explosion from this weapon’s projectile. This explosion is a 5-foot-radius Sphere centered on a point you choose within the weapon’s normal range. Each creature within the Sphere makes a Dexterity saving throw (DC 8 plus your Strength or Dexterity modifier and your Proficiency Bonus). On a failed save, a creature takes the weapon’s damage, but don’t add your ability modifier to that damage unless that modifier is negative. On a successful save, a creature takes half as much damage. You can create an explosion only once per turn.'),
  ('scatter', 'Scatter', 'Being within 5 feet of an enemy doesn’t impose Disadvantage on your ranged attack rolls with this weapon.'),
  ('sighted', 'Sighted', 'Attacking at long range with this weapon doesn’t impose Disadvantage on your attack rolls. When you hit a creature with an attack using this weapon at long range, you can reroll any of the damage dice and must use the new roll.')
ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
