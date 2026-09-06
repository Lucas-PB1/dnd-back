-- Seed: Cunning Strike effects

INSERT INTO rpg.phb_cunning_strike_effect (slug, name, cost, unlock_level, save_ability, subclass_id, note)
VALUES
  ('poison', 'Envenenar', 1, 5, 'constitution', NULL, 'Requer Kit de Veneno; em falha, Envenenado por 1 minuto.'),
  ('withdraw', 'Retirada', 1, 5, NULL, NULL, 'Mova-se até metade do Deslocamento sem provocar Ataques de Oportunidade.'),
  ('trip', 'Tropeço', 1, 5, 'dexterity', NULL, 'Alvo Grande ou menor fica Caído em uma falha.'),
  ('hidden-attack', 'Ataque Escondido', 1, 9, NULL, (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief'), 'O ataque não encerra Invisível de Esconder se terminar atrás de cobertura adequada.'),
  ('daze', 'Aturdir', 2, 14, 'constitution', NULL, 'Em falha, no próximo turno o alvo só pode mover, agir ou usar Ação Bônus.'),
  ('knock-out', 'Nocaute', 6, 14, 'constitution', NULL, 'Em falha, Inconsciente por 1 minuto ou até sofrer dano.'),
  ('obscure', 'Obscurecer', 3, 14, 'dexterity', NULL, 'Em falha, Cego até o fim do próximo turno do alvo.'),
  ('paralyze', 'Paralisar', 4, 17, 'constitution', (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'), 'Com Golpe Venenoso, o alvo fica Paralisado até o fim do seu próximo turno.')
ON CONFLICT (slug) DO UPDATE
  SET name = EXCLUDED.name,
      cost = EXCLUDED.cost,
      unlock_level = EXCLUDED.unlock_level,
      save_ability = EXCLUDED.save_ability,
      subclass_id = EXCLUDED.subclass_id,
      note = EXCLUDED.note;
