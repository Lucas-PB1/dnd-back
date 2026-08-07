-- Seed rpg.phb_tool
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-carpinteiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Selar ou abrir uma porta ou recipiente (CD 20)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-cartografo'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Elaborar o mapa de uma pequena área (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-coureiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Moldar a estética de um item de couro (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-entalhador'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Entalhar um padrão em madeira (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-ferreiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Forçar a abertura de uma porta ou recipiente (CD 20)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-funileiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Monte um item Minúsculo composto de sucata,
que se desfaz em 1 minuto (CD 20)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-joalheiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Discernir o valor de uma gema (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-oleiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Discernir como um objeto de cerâmica foi
manuseado nas últimas 24 horas (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-pedreiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Cinzelar um símbolo ou buraco na pedra (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-sapateiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Modificar calçado para conceder Vantagem no
próximo teste de Destreza (Acrobacia) do usuário (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-tecelao'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Reparar um rasgo em uma roupa (CD 10) ou
costurar um ornamento Minúsculo (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-vidreiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Discernir como um objeto de vidro foi
manuseado nas últimas 24 horas (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-alquimista'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'supplies'), 'Identificar uma substância (CD 15) ou iniciar um
incêndio (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-caligrafo'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'supplies'), 'Escrever texto com uma caligrafia que protege
contra falsificação (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-cervejeiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'supplies'), 'Detectar bebida envenenada (CD 15) ou
identificar álcool (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-pintor'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'supplies'), 'Fazer uma pintura reconhecível de algo que você
viu (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'utensilios-de-cozinheiro'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'utensils'), 'Melhorar o sabor dos alimentos (CD 10) ou
detectar alimentos estragados ou envenenados (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-ladrao'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Abrir uma fechadura (CD 15) ou desarmar uma
armadilha (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'), 'Traçar uma rota (CD 10) ou determinar a posição
observando as estrelas (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'instrument'), 'Tocar uma música conhecida (CD 10) ou
improvisar uma música (CD 15)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-disfarce'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit'), 'Aplicar maquiagem (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-falsificacao'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit'), 'Imitar 10 ou menos palavras escritas de outra
pessoa (CD 15) ou duplicar um selo de cera (CD 20)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-herbalismo'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit'), 'Identificar uma planta (CD 10)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-jogos'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit'), 'Discernir se alguém está trapaceando (CD 10) ou
ganhar o jogo (CD 20)') ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-veneno'), (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit'), 'Detectar um objeto envenenado (CD 10)') ON CONFLICT (item_id) DO NOTHING;
