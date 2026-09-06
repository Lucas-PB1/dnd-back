-- Opções de +1 de atributo dos talentos Valdas.
-- Lote C: migrado para phb_option_def/value unificado
-- Sem isso o texto do benefício existe, mas applyFeatAbilityIncreases não aplica o ponto.

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1
FROM rpg.phb_feat f
WHERE f.slug IN ('brutal-grip', 'field-commander', 'focused-critical', 'iron-hero')
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, v.option_key, v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
JOIN (
  VALUES
    ('brutal-grip', 'abilityIncrease', 'forca', 'Força', 1),
    ('field-commander', 'abilityIncrease', 'carisma', 'Carisma', 1),
    ('focused-critical', 'abilityIncrease', 'forca', 'Força', 1),
    ('focused-critical', 'abilityIncrease', 'destreza', 'Destreza', 2),
    ('iron-hero', 'abilityIncrease', 'forca', 'Força', 1),
    ('iron-hero', 'abilityIncrease', 'destreza', 'Destreza', 2)
) AS v(feat_slug, option_key, value_id, label, sort_order)
  ON f.slug = v.feat_slug
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;
