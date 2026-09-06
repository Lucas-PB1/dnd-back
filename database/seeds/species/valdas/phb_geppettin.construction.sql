-- Seed geppettin construction → phb_species_option_*
-- Lote B: consolida em options

-- option_def
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'constructionId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- option_value (benefit)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, benefit)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'constructionId', 'bisque', 'Porcelana',
    'Você é indistinguível de uma boneca de porcelana até o momento em que ataca. Sempre que você causa dano a uma criatura com uma jogada de ataque com arma em seu primeiro turno de combate, a criatura sofre dano extra igual ao seu Bônus de Proficiência. O dano é do mesmo tipo causado pela arma.'
  ),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'constructionId', 'marionette', 'Marionete',
    'Cordas soltas pendem de seus membros articulados. Durante o seu turno, seu alcance é 1,5 metro maior com qualquer arma corpo a corpo que não tenha as propriedades Alcance, Duas Mãos e Versátil.'
  ),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'constructionId', 'plushie', 'Pelúcia',
    'Você está cheio de penugem. Ao sofrer dano Contundente, você pode realizar uma Reação para ganhar Resistência ao dano desencadeado. Você também é empurrado 1,5 metro da fonte do dano. Você não pode realizar esta Reação se não puder ser afastado da fonte do dano.'
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  benefit = EXCLUDED.benefit;
