-- Seed rpg.phb_feat_granted_spell (magias fixas de talento)

INSERT INTO rpg.phb_feat_granted_spell (feat_id, spell_id)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'passo-nebuloso')
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'invisibilidade')
  )
ON CONFLICT DO NOTHING;
