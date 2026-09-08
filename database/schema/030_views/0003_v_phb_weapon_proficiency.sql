CREATE VIEW rpg.v_phb_weapon_proficiency AS
SELECT slug, label FROM (VALUES
  ('armas-simples', 'Armas Simples'),
  ('armas-marciais', 'Armas Marciais'),
  ('armas-avancadas', 'Armas Avançadas'),
  ('adagas', 'Adagas'),
  ('dardos', 'Dardos'),
  ('fundas', 'Fundas'),
  ('bordoes', 'Bordões'),
  ('bestas-leves', 'Bestas Leves'),
  ('bestas-de-mao', 'Bestas de Mão'),
  ('espada-longa', 'Espada Longa'),
  ('rapieira', 'Rapieira'),
  ('espada-curta', 'Espada Curta'),
  ('machadinhas', 'Machadinhas'),
  ('armas-marciais-leves', 'Armas Marciais (leves)'),
  ('armas-marciais-a-distancia', 'Armas Marciais (à Distância)'),
  ('armas-marciais-acuidade-ou-leves', 'Armas Marciais (Acuidade ou Leves)')
) AS t(slug, label);
