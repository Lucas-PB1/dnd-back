-- Magias always_prepared de classe (S023 — “você sempre tem a magia … preparada”)

INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'falar-com-animais'),
    1
  ),
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'marca-do-predador'),
    1
  ),
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'destruicao-divina'),
    2
  ),
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'convocar-montaria'),
    5
  ),
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'contato-extraplanar'),
    9
  ),
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'palavra-de-poder-matar'),
    20
  ),
  (
    'class'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'palavra-de-poder-salvar'),
    20
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
