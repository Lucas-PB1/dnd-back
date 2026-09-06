-- Seed rpg.phb_spell_grant (magias fixas de talento)

INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'passo-nebuloso'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'invisibilidade'),
    1
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
