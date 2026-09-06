CREATE VIEW rpg.v_phb_ability_generation_method AS
SELECT slug, name, description FROM (VALUES
  ('standard-array'::rpg.ability_generation_method, 'Conjunto PadrÃ£o', 'Use os seis valores fixos abaixo e atribua a ForÃ§a, Destreza, ConstituiÃ§Ã£o, InteligÃªncia, Sabedoria e Carisma.'),
  ('roll'::rpg.ability_generation_method, 'GeraÃ§Ã£o AleatÃ³ria', 'Jogue 4d6, descarte o menor dado e some os trÃªs restantes. Repita seis vezes. A soma dos seis atributos costuma ficar entre 72 e 80 (mÃ©dia ~73).'),
  ('point-buy'::rpg.ability_generation_method, 'Custo de Pontos', '27 pontos para distribuir entre os seis atributos, conforme a tabela de custos.')
) AS t(slug, name, description);
