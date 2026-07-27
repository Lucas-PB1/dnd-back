-- Seed Valda firearm weapon properties

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
  ('firearm', 'Firearm', 'You don’t add your ability modifier to the weapon’s damage, unless otherwise stated. Firearm ammunition is destroyed upon use.'),
  ('recoil', 'Recoil', 'After you make an attack with this weapon, you can’t make ranged attacks beyond the weapon’s normal range until the end of the current turn.'),
  ('reload', 'Reload', 'This weapon can be used to make a number of attacks before it must be reloaded. If you are proficient with the weapon, reloading it takes an Action or a Bonus Action; otherwise, reloading it takes an Action.')
ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
