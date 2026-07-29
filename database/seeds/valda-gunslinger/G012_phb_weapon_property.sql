-- Seed Valda firearm weapon properties

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
  ('firearm', 'Arma de Fogo', 'Você não adiciona seu modificador de habilidade ao dano da arma, salvo indicação em contrário. A munição arma de fogo é destruída após o uso.'),
  ('recoil', 'Recuo', 'Depois de realizar um ataque com esta arma, você não poderá realizar ataques à distância além do alcance normal da arma até o final do turno atual.'),
  ('reload', 'Recarga', 'Esta arma pode ser usada para realizar vários ataques antes de ser recarregada. Se você for proficiente com a arma, recarregá-la exige uma Ação ou Ação Bônus; caso contrário, recarregá-lo requer uma Ação.')
ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
