-- Transe do Cavaleiro da Pele (Primal Spirit): enter/end tipados

WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'skinrider_trance'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, 10, 1, v.label
  FROM sc
  CROSS JOIN (VALUES
    ('skinrider-s-trance', 'Transe do Cavaleiro da Pele'),
    ('skinrider-s-trance-end', 'Encerrar Transe do Cavaleiro da Pele')
  ) AS v(action_slug, label)
  RETURNING id
)
SELECT 1 FROM ins;
