-- Artefatos DMG: pools 1×/amanhecer (Kas, Contenção, Livro das Trevas) + PE Feitos
-- Ver docs/plans/audit-dmg-artifacts.md · economy em C045
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "abilityBonuses": { "sabedoria": 2 },
    "abilityScoreMax": 24
  }
}'::jsonb
WHERE slug = 'livro-dos-feitos-sublimes';
