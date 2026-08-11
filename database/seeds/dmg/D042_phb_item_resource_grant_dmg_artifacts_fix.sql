-- Artefatos DMG: pools 1×/amanhecer (Kas, Contenção, Livro das Trevas) + PE Feitos
-- Ver docs/plans/audit-dmg-artifacts.md · economy em C045

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'espadaKasConvocarRelampagosUse',
    'Convocar Relâmpagos — Espada de Kas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'),
    1
  ),
  (
    'espadaKasDedoDaMorteUse',
    'Dedo da Morte — Espada de Kas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'),
    1
  ),
  (
    'espadaKasPalavraSagradaUse',
    'Palavra Sagrada — Espada de Kas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'),
    1
  ),
  (
    'demonomicoContencaoUse',
    'Contenção — Demonômico de lggwilv',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'),
    1
  ),
  (
    'livroTrevasAnimarMortosUse',
    'Animar Mortos — Livro das Trevas Profanas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
    1
  ),
  (
    'livroTrevasCirculoDaMorteUse',
    'Círculo da Morte — Livro das Trevas Profanas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
    1
  ),
  (
    'livroTrevasDedoDaMorteUse',
    'Dedo da Morte — Livro das Trevas Profanas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
    1
  ),
  (
    'livroTrevasDominarMonstroUse',
    'Dominar Monstro — Livro das Trevas Profanas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'item'::rpg.resource_owner_kind,
  i.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  v.fixed_max,
  FALSE,
  v.recover_short,
  v.recover_long
FROM (VALUES
  ('espada-de-kas', 'espadaKasConvocarRelampagosUse', 1, FALSE, TRUE),
  ('espada-de-kas', 'espadaKasDedoDaMorteUse', 1, FALSE, TRUE),
  ('espada-de-kas', 'espadaKasPalavraSagradaUse', 1, FALSE, TRUE),
  ('demonomico-de-lggwilv', 'demonomicoContencaoUse', 1, FALSE, TRUE),
  ('livro-das-trevas-profanas', 'livroTrevasAnimarMortosUse', 1, FALSE, TRUE),
  ('livro-das-trevas-profanas', 'livroTrevasCirculoDaMorteUse', 1, FALSE, TRUE),
  ('livro-das-trevas-profanas', 'livroTrevasDedoDaMorteUse', 1, FALSE, TRUE),
  ('livro-das-trevas-profanas', 'livroTrevasDominarMonstroUse', 1, FALSE, TRUE)
) AS v(item_slug, resource_slug, fixed_max, recover_short, recover_long)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "abilityBonuses": { "sabedoria": 2 },
    "abilityScoreMax": 24
  }
}'::jsonb
WHERE slug = 'livro-dos-feitos-sublimes';
