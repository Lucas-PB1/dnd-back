-- Opções de classe (scope = class): Clérigo (Ordem Divina, Golpes Abençoados)
-- e Druida (Ordem Primal, Fúria Elemental).
INSERT INTO rpg.phb_option_def (
  scope, owner_id, option_key, label, unlock_level, value_type, sort_order
)
VALUES
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    'divineOrder',
    'Ordem Divina',
    1,
    'catalog'::rpg.option_value_type,
    1
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    'blessedStrikes',
    'Golpes Abençoados',
    7,
    'catalog'::rpg.option_value_type,
    2
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    'primalOrder',
    'Ordem Primal',
    1,
    'catalog'::rpg.option_value_type,
    1
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    'elementalFury',
    'Fúria Elemental',
    7,
    'catalog'::rpg.option_value_type,
    2
  )
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order, benefit
)
VALUES
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    'divineOrder',
    'protector',
    'Protetor',
    1,
    'Proficiência com armas Marciais e treinamento com Armadura Pesada.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    'divineOrder',
    'thaumaturge',
    'Taumaturgo',
    2,
    'Um truque adicional de Clérigo e bônus de Sabedoria (mín. +1) em Arcanismo e Religião.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    'blessedStrikes',
    'potent-spellcasting',
    'Conjuração Poderosa',
    1,
    'Adicione o modificador de Sabedoria ao dano dos truques de Clérigo.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    'blessedStrikes',
    'divine-strike',
    'Golpe Divino',
    2,
    'Uma vez por turno, +1d8 Necrótico ou Radiante em um acerto com arma.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    'primalOrder',
    'warden',
    'Protetor',
    1,
    'Proficiência com armas Marciais e treinamento com Armadura Média.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    'primalOrder',
    'magician',
    'Xamã',
    2,
    'Um truque adicional de Druida e bônus de Sabedoria (mín. +1) em Arcanismo e Natureza.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    'elementalFury',
    'primal-strike',
    'Ataque Primal',
    1,
    'Uma vez por turno, +1d8 Elétrico, Gélido, Ígneo ou Trovejante em acerto com arma ou forma Animal.'
  ),
  (
    'class'::rpg.option_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    'elementalFury',
    'potent-spellcasting',
    'Conjuração Poderosa',
    2,
    'Adicione o modificador de Sabedoria ao dano dos truques de Druida.'
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  benefit = EXCLUDED.benefit,
  sort_order = EXCLUDED.sort_order;
