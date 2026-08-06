-- Seed: Gunslinger maneuvers

INSERT INTO rpg.phb_gunslinger_maneuver (slug, name, description, effect_kind, risk_cost, from_level, subclass_id)
VALUES
  ('bite-the-bullet', 'Morda a Bala', 'Como Ação Bônus, gaste um Dado de Risco para ganhar PV Temporários iguais ao resultado do dado mais seu nível de Pistoleiro.', 'temp_hp', 1, 2, NULL),
  ('blindfire', 'Fogo cego', 'Ação Bônus: gaste um Dado de Risco para ganhar Visão Cega de 9 m até o fim do turno.', 'descriptive', 1, 2, NULL),
  ('evasive-roll', 'Rolamento Evasivo', 'Ação Bônus: gaste um Dado de Risco para se mover até 4,5 m (sem OA / terreno difícil) e recarregar qualquer arma à distância que estiver segurando.', 'reload_move', 1, 2, NULL),
  ('grazing-shot', 'Tiro Rasante', 'Quando erra um ataque à distância com arma, gaste um Dado de Risco (sem ação) para causar dano igual ao dado + modificador de Destreza (mín. 1). 1×/turno.', 'miss_damage', 1, 2, NULL),
  ('independent-spirit', 'Espírito Independente', 'Quando falha em teste ou salvaguarda de INT/SAB/CAR, gaste um Dado de Risco para somá-lo ao teste. 1×/turno.', 'ability_check_bonus', 1, 2, NULL),
  ('close-shave', 'Por um Triz', 'Reação: quando um ataque o acerta, gaste um Dado de Risco e some o resultado à CA contra aquele ataque.', 'ac_bonus', 1, 2, NULL),
  ('fan-the-hammer', 'Abrir o Leque', 'Ação Bônus (Pistolero): ao Atacar com arma à distância sem Duas mãos, gaste 1 Dado de Risco para dois ataques extras com Desvantagem (mão livre; sem Automática).', 'descriptive', 1, 3, (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero')),
  ('showdown', 'Confronto', 'Na Iniciativa (Pistolero): gaste 1 Dado de Risco, saque uma arma à distância e ataque; some o dado ao dano. No 1º turno, o alvo tem Desvantagem em ataques contra outros.', 'descriptive', 1, 10, (SELECT id FROM rpg.phb_subclass WHERE slug = 'pistolero'))
ON CONFLICT (slug) DO UPDATE
  SET name = EXCLUDED.name,
      description = EXCLUDED.description,
      effect_kind = EXCLUDED.effect_kind,
      risk_cost = EXCLUDED.risk_cost,
      from_level = EXCLUDED.from_level,
      subclass_id = EXCLUDED.subclass_id;
