-- Seed rpg.phb_weapon_property
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
  ('finesse', 'Acuidade', 'Ao realizar um ataque com uma arma que possui Acuidade, utilize seu modificador de Força ou Destreza, à sua escolha, para as jogadas de ataque e dano. Você deve aplicar o mesmo modificador em ambas as jogadas.'),
  ('light', 'Leve', 'Quando você executa a ação Atacar em seu turno e usa uma arma Leve, pode realizar um ataque adicional com uma Ação Bônus mais tarde no mesmo turno. Esse ataque adicional deve ser realizado com uma arma Leve diferente, e você não adiciona seu modificador de atributo ao dano do ataque adicional, a menos que esse modificador seja negativo.'),
  ('thrown', 'Arremesso', 'Se uma arma possui a propriedade Arremesso, você pode arremessá-la para realizar um ataque à distância, e pode sacar essa arma como parte do ataque. Se a arma for corpo a corpo, utilize o mesmo modificador de atributo para as jogadas de ataque e dano que você emprega ao realizar um ataque corpo a corpo com essa arma.'),
  ('two-handed', 'Duas Mãos', 'Uma arma de Duas Mãos exige o uso de duas mãos quando você ataca com ela.'),
  ('reach', 'Extensão', 'Uma arma de Extensão adiciona 1,5 metro ao seu alcance quando você ataca com ela, bem como ao determinar seu alcance para realizar Ataques de Oportunidade com ela.'),
  ('heavy', 'Pesada', 'Você tem Desvantagem em jogadas de ataque com uma arma Pesada se for uma arma Corpo a Corpo e seu valor de Força for inferior a 13, ou se for uma arma à Distância e seu valor de Destreza for inferior a 13.'),
  ('ammunition', 'Munição', 'Você só pode usar uma arma com a propriedade Munição para realizar um ataque à distância se tiver munição disponível. Cada ataque gasta uma peça de munição. Sacar a munição é parte do ataque.'),
  ('loading', 'Recarga', 'Você pode disparar apenas uma única peça de munição de uma arma com Recarga ao executar uma ação, uma Ação Bônus ou uma Reação para dispará-la, independentemente do número de ataques que você normalmente pode realizar.'),
  ('range', 'Alcance', 'Indicado entre parênteses após Munição ou Arremesso. O primeiro número é o alcance normal em metros; o segundo, o alcance máximo. Ataques além do alcance normal têm Desvantagem; além do máximo são impossíveis.'),
  ('versatile', 'Versátil', 'Uma arma Versátil pode ser usada com uma ou duas mãos. Um valor de dano entre parênteses aparece com a propriedade. A arma causa esse dano quando usada com as duas mãos ao realizar um ataque corpo a corpo.');
