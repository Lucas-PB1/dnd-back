-- Flavor de espécies Valdas (tagline/summary para cards do compêndio)

UPDATE rpg.phb_species SET
  tagline = v.tagline,
  summary = v.summary
FROM (VALUES
  ('geppettin', 'Brinquedos vivos independentes', 'Construtos sencientes de madeira, tecido ou porcelana — sem fome nem cansaço.'),
  ('mandrake', 'Entre animal e planta', 'Ic or rubi, fotossíntese e emissários verdes entre os reinos naturais.')
) AS v(slug, tagline, summary)
WHERE rpg.phb_species.slug = v.slug;
