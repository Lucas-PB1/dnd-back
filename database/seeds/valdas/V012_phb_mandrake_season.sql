-- Seed mandrake season → phb_species_option_*
-- Lote B: consolida em options

-- option_def
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'seasonId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- option_value (benefit)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, benefit)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'seasonId', 'spring', 'Primavera',
    'Suas Vinhas Enredantes podem atingir uma criatura aérea a até 9 metros do solo, que é puxada com segurança para o solo quando você usa esta característica.'
  ),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'seasonId', 'summer', 'Verão',
    'Suas Vinhas Enredantes podem mover o alvo até 3 metros para um espaço desocupado no chão.'
  ),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'seasonId', 'autumn', 'Outono',
    'Suas Vinhas Enredantes podem afetar uma segunda criatura a até 1,5 metro do primeiro alvo.'
  ),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'seasonId', 'winter', 'Inverno',
    'O alvo sofre dano Gélido igual ao seu Bônus de Proficiência.'
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  benefit = EXCLUDED.benefit;
