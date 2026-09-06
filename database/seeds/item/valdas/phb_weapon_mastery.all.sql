-- Seed Valdas firearm mastery properties

INSERT INTO rpg.phb_weapon_mastery (slug, name, description)
VALUES
  ('automatic', 'Automática', 'Ao realizar um ataque com esta arma, você pode optar por realizar dois ataques. Esses ataques são sempre feitos com Desvantagem, independente das circunstâncias. Você não pode substituir esses ataques. Se esta arma tiver a propriedade Munição, esses ataques usam o dobro da quantidade normal de munição.'),
  ('explode', 'Explosiva', 'Ao usar a ação Atacar, você pode substituir um de seus ataques por uma explosão do projétil desta arma. Esta explosão é uma esfera de 5 pés de raio centrada em um ponto que você escolher dentro do alcance normal da arma. Cada criatura dentro da Esfera faz uma salvaguarda de Destreza (CD 8 mais seu modificador de Força ou Destreza e seu Bônus de Proficiência). Se falhar na resistência, uma criatura sofre o dano da arma, mas não adicione seu modificador de habilidade a esse dano, a menos que esse modificador seja negativo. Em um teste bem-sucedido, a criatura sofre metade do dano. Você pode criar uma explosão apenas uma vez por turno.'),
  ('scatter', 'Dispersão', 'Estar a 5 pés de um inimigo não impõe Desvantagem em suas jogadas de ataque à distância com esta arma.'),
  ('sighted', 'Mira', 'Atacar de longa distância com esta arma não impõe Desvantagem em suas jogadas de ataque. Quando você acerta uma criatura com um ataque usando esta arma a longa distância, você pode rolar novamente qualquer um dos dados de dano e deve usar a nova jogada.')
ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
