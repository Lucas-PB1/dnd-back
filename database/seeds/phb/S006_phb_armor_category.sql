-- Seed rpg.phb_armor_category
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_armor_category (slug, name, don_doff, sort_order)
VALUES
  ('light', 'Armadura Leve', '1 Minuto para Vestir ou Despir', 1),
  ('medium', 'Armadura Média', '5 Minutos para Vestir e 1 Minuto para Despir', 2),
  ('heavy', 'Armadura Pesada', '10 Minutos para Vestir e 5 Minutos para Despir', 3),
  ('shield', 'Escudo', 'Ação Usar Objeto para Equipar ou Desequipar', 4);
