-- Seed rpg.phb_skill
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_skill (slug, name, ability_id, description)
VALUES
  ('acrobatics', 'Acrobacia', (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 'Manter-se em pé em uma situação complicada ou realizar uma acrobacia.'),
  ('animal-handling', 'Lidar com Animais', (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Acalmar ou treinar um animal, ou fazer com que ele se comporte de uma determinada maneira.'),
  ('arcana', 'Arcanismo', (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 'Recordar conhecimentos sobre magias, itens mágicos e planos de existência.'),
  ('athletics', 'Atletismo', (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 'Pular mais longe do que o normal, manter-se à tona em águas agitadas ou quebrar algo.'),
  ('deception', 'Enganação', (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Contar uma mentira convincente ou usar um disfarce de forma convincente.'),
  ('history', 'História', (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 'Relembrar fatos sobre eventos históricos, pessoas, nações e culturas.'),
  ('insight', 'Intuição', (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Perceber o humor e as intenções de uma pessoa.'),
  ('intimidation', 'Intimidação', (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Atemorizar ou ameaçar alguém para que faça o que você quer.'),
  ('investigation', 'Investigação', (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 'Encontrar informações obscuras em livros ou deduzir como algo funciona.'),
  ('medicine', 'Medicina', (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Diagnosticar uma doença ou determinar o que matou uma pessoa que morreu recentemente.'),
  ('nature', 'Natureza', (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 'Relembrar fatos sobre o terreno, as plantas, os animais e o clima.'),
  ('perception', 'Percepção', (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Usando uma combinação de sentidos, notar algo que é fácil de passar despercebido.'),
  ('performance', 'Atuação', (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Atuar, contar uma história, tocar música ou dançar.'),
  ('persuasion', 'Persuasão', (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Convencer alguém de algo de forma honesta e graciosa.'),
  ('religion', 'Religião', (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 'Relembrar fatos sobre deuses, rituais religiosos e símbolos sagrados.'),
  ('sleight-of-hand', 'Prestidigitação', (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 'Furtar um bolso, ocultar um objeto portátil ou fazer truque com as mãos.'),
  ('stealth', 'Furtividade', (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 'Evitar ser notado movendo-se silenciosamente e se escondendo atrás de objetos.'),
  ('survival', 'Sobrevivência', (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Seguir rastros, procurar alimentos, encontrar uma trilha ou evitar perigos naturais.');
