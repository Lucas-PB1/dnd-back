-- Flavor de espécies Eldritch Hunt (tagline/summary para cards do compêndio)

UPDATE rpg.phb_species SET
  tagline = v.tagline,
  summary = v.summary
FROM (VALUES
  ('manikin', 'Marionetes com livre-arbítrio', 'Construtos dourados dos Scions — custódios, manipuladores ou teatrais.'),
  ('scourgeborne', 'Maldição do Flagelo', 'Aparência distorcida que expõe o monstro interior — e a chance de redimi-lo.')
) AS v(slug, tagline, summary)
WHERE rpg.phb_species.slug = v.slug;
