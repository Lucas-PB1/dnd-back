-- DMG Treasure: tabelas de geração de item senciente
DELETE FROM rpg.dmg_sentient_trait_table;

INSERT INTO rpg.dmg_sentient_trait_table
  (kind, roll_min, roll_max, slug, summary_pt, payload)
VALUES
  ('alignment', 1, 15, 'lg', 'Ordeiro e Bom', '{"alignment":"OB"}'::jsonb),
  ('alignment', 16, 35, 'ng', 'Neutro e Bom', '{"alignment":"NB"}'::jsonb),
  ('alignment', 36, 50, 'cg', 'Caótico e Bom', '{"alignment":"CB"}'::jsonb),
  ('alignment', 51, 63, 'ln', 'Ordeiro e Neutro', '{"alignment":"ON"}'::jsonb),
  ('alignment', 64, 73, 'n', 'Neutro', '{"alignment":"N"}'::jsonb),
  ('alignment', 74, 85, 'cn', 'Caótico e Neutro', '{"alignment":"CN"}'::jsonb),
  ('alignment', 86, 89, 'le', 'Ordeiro e Mau', '{"alignment":"OM"}'::jsonb),
  ('alignment', 90, 96, 'ne', 'Neutro e Mau', '{"alignment":"NM"}'::jsonb),
  ('alignment', 97, 100, 'ce', 'Caótico e Mau', '{"alignment":"CM"}'::jsonb),
  ('communication', 1, 6, 'empathy', 'Transmite emoções à criatura que o carrega ou empunha.', '{"communication":"empatia"}'::jsonb),
  ('communication', 7, 9, 'speech', 'Fala um ou mais idiomas.', '{"communication":"fala"}'::jsonb),
  ('communication', 10, 10, 'speech-telepathy', 'Fala um ou mais idiomas e se comunica telepaticamente com quem o carrega ou empunha.', '{"communication":"fala+telepatia"}'::jsonb),
  ('senses', 1, 1, 'hear-see-30', 'Audição e visão padrão até 9 metros.', '{"senses":"audição e visão 9 m"}'::jsonb),
  ('senses', 2, 2, 'hear-see-60', 'Audição e visão padrão até 18 metros.', '{"senses":"audição e visão 18 m"}'::jsonb),
  ('senses', 3, 3, 'hear-see-120', 'Audição e visão padrão até 36 metros.', '{"senses":"audição e visão 36 m"}'::jsonb),
  ('senses', 4, 4, 'hear-darkvision-120', 'Audição e Visão no Escuro até 36 metros.', '{"senses":"audição e Visão no Escuro 36 m"}'::jsonb),
  ('special_purpose', 1, 1, 'aligned', 'Alinhado. Busca derrotar ou destruir aqueles de alinhamento diametralmente oposto. Nunca é Neutro.', '{"purpose":"aligned","purposeSummary":"Derrotar alinhamento oposto."}'::jsonb),
  ('special_purpose', 2, 2, 'bane', 'Flagelo. Busca frustrar ou destruir criaturas de um tipo particular (ex.: Construtos, Demônios, Mortos-Vivos).', '{"purpose":"bane","purposeSummary":"Destruir um tipo de criatura."}'::jsonb),
  ('special_purpose', 3, 3, 'creator-seeker', 'Buscador do Criador. Procura seu criador e quer entender por que foi criado.', '{"purpose":"creator_seeker","purposeSummary":"Encontrar o criador."}'::jsonb),
  ('special_purpose', 4, 4, 'destiny-seeker', 'Buscador do Destino. Acredita que ele e o portador têm papéis-chave em eventos futuros.', '{"purpose":"destiny_seeker","purposeSummary":"Cumprir um destino."}'::jsonb),
  ('special_purpose', 5, 5, 'destroyer', 'Destruidor. Anseia por destruição e incentiva o usuário a lutar arbitrariamente.', '{"purpose":"destroyer","purposeSummary":"Destruir sem propósito."}'::jsonb),
  ('special_purpose', 6, 6, 'glory-seeker', 'Buscador de Glória. Busca renome como o maior item mágico do mundo.', '{"purpose":"glory_seeker","purposeSummary":"Fama e notoriedade."}'::jsonb),
  ('special_purpose', 7, 7, 'lore-seeker', 'Buscador de Sabedoria. Anseia por conhecimento, mistérios ou profecias.', '{"purpose":"lore_seeker","purposeSummary":"Buscar conhecimento."}'::jsonb),
  ('special_purpose', 8, 8, 'protector', 'Protetor. Busca defender um tipo particular de criatura.', '{"purpose":"protector","purposeSummary":"Proteger um povo/tipo."}'::jsonb),
  ('special_purpose', 9, 9, 'soulmate-seeker', 'Buscador de Alma Gêmea. Procura outro item mágico senciente.', '{"purpose":"soulmate_seeker","purposeSummary":"Encontrar outro item senciente."}'::jsonb),
  ('special_purpose', 10, 10, 'templar', 'Templário. Busca defender os servos e interesses de uma divindade particular.', '{"purpose":"templar","purposeSummary":"Servir uma divindade."}'::jsonb),
  ('ability_scores', 1, 1, '4d6-drop-lowest', 'Role 4d6 descartando o menor para INT, SAB e CAR.', '{"method":"4d6dl1","abilities":["inteligencia","sabedoria","carisma"]}'::jsonb);
