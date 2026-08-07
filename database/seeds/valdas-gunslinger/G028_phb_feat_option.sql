-- Opção +1 DEX do talento Akimbo
-- Lote C: migrado para phb_option_def/value unificado
-- Só aplica se o talento existir no catálogo (seed de feat pode estar ausente).

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1
FROM rpg.phb_feat f
WHERE f.slug = 'akimbo'
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', 'destreza', 'Destreza', 1
FROM rpg.phb_feat f
WHERE f.slug = 'akimbo'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;
