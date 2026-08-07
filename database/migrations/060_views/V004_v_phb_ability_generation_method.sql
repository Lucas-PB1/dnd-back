-- VALUES view for ability generation methods
-- Lote A: replaces dropped phb_ability_generation_method table

CREATE VIEW rpg.v_phb_ability_generation_method AS
SELECT slug, name, description FROM (VALUES
  ('standard-array'::rpg.ability_generation_method, 'Conjunto Padrão', 'Use os seis valores fixos abaixo e atribua a Força, Destreza, Constituição, Inteligência, Sabedoria e Carisma.'),
  ('roll'::rpg.ability_generation_method, 'Geração Aleatória', 'Jogue 4d6, descarte o menor dado e some os três restantes. Repita seis vezes. A soma dos seis atributos costuma ficar entre 72 e 80 (média ~73).'),
  ('point-buy'::rpg.ability_generation_method, 'Custo de Pontos', '27 pontos para distribuir entre os seis atributos, conforme a tabela de custos.')
) AS t(slug, name, description);
