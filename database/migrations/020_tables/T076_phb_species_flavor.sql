-- tagline + summary em phb_species (paridade com phb_class)

ALTER TABLE rpg.phb_species
  ADD COLUMN IF NOT EXISTS tagline TEXT,
  ADD COLUMN IF NOT EXISTS summary TEXT;

UPDATE rpg.phb_species SET
  tagline = v.tagline,
  summary = v.summary
FROM (VALUES
  ('aasimar', 'Mortais com centelha dos Planos Superiores', 'Impulsione luz, cura e fúria celestial.'),
  ('dwarf', 'Filhos da forja e da pedra', 'Afinidade por metal, vida subterrânea e resiliência de montanha.'),
  ('dragonborn', 'Herdeiros dos dragões', 'Escamas, sopro e o legado dos ovos dracônicos.'),
  ('elf', 'Filhos de Corellon e de Faéria', 'Longevidade, transe e magia moldada pelo ambiente.'),
  ('gnome', 'Pequenos mestres da invenção e da ilusão', 'Inteligência, tocas e magia que confunde predadores.'),
  ('goliath', 'Descendentes distantes de gigantes', 'Estatura imponente e bênçãos sobrenaturais dos antigos.'),
  ('human', 'Ambição em todo o multiverso', 'Variedade, determinação e o impulso de alcançar o máximo.'),
  ('orc', 'Filhos de Gruumsh', 'Resistência, determinação e olhos na escuridão.'),
  ('halfling', 'Lar, lareira e um toque de sorte', 'Comunidade bucólica — e um espírito aventureiro surpreendente.'),
  ('tiefling', 'Legado dos Planos Inferiores', 'Poder ínfero no sangue, sem ditar o caráter moral.')
) AS v(slug, tagline, summary)
WHERE rpg.phb_species.slug = v.slug;
