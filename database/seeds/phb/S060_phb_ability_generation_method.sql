-- Seed rpg.phb_ability_generation_method
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_ability_generation_method (slug, name, description)
VALUES
  ('standard-array', 'Conjunto Padrão', 'Use os seis valores fixos abaixo e atribua a Força, Destreza, Constituição, Inteligência, Sabedoria e Carisma.'),
  ('roll', 'Geração Aleatória', 'Jogue 4d6, descarte o menor dado e some os três restantes. Repita seis vezes. A soma dos seis atributos costuma ficar entre 72 e 80 (média ~73).'),
  ('point-buy', 'Custo de Pontos', '27 pontos para distribuir entre os seis atributos, conforme a tabela de custos.');
