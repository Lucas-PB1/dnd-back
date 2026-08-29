-- Flavor de espécies Northlands (tagline/summary para cards do compêndio)

UPDATE rpg.phb_species SET
  tagline = v.tagline,
  summary = v.summary
FROM (VALUES
  ('bearfolk', 'Predadores das terras nórdicas', 'Força ursina, espírito indomável e linhagens Andari ou Garhamr.'),
  ('beastkin', 'Wildkin do Norte', 'Características animais, instintos de caça e adaptações naturais.'),
  ('giantkin', 'Sangue de jotuns', 'Resistência a ambientes extremos e dons conforme a ancestria.'),
  ('trollkin', 'Herança fey, ogro ou troll', 'Visão profunda, armas naturais e regeneração.'),
  ('werekin', 'Licantropia ancestral', 'Garras, faro e aspecto primal por um minuto.'),
  ('baugsmidr-dwarf', 'Anões dos anéis', 'Afinidade arcana no lugar do pacote anão clássico.'),
  ('fjord-dwarf', 'Anões das costas geladas', 'Tenacidade costeira, natação e combate em terreno difícil.')
) AS v(slug, tagline, summary)
WHERE rpg.phb_species.slug = v.slug;
