-- DMG §0 #9f: resources maravilhosos (cargas / 1×)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'escaravelhoProtecaoCharges',
    'Cargas — Escaravelho de Proteção',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'escaravelho-de-protecao'),
    1
  ),
  (
    'moedaRivalUse',
    'Lançar — Moeda Rival',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'moeda-rival'),
    1
  ),
  (
    'olhoMegeraCharges',
    'Cargas — Olho de Megera',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'olho-de-megera'),
    1
  ),
  (
    'faixasBilarroUse',
    'Faixas — Bilarro',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'faixas-de-ferro-de-bilarro'),
    1
  ),
  (
    'mantoAsasUse',
    'Asas — Manto das Asas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'manto-das-asas'),
    1
  ),
  (
    'botasVelocidadeUse',
    'Velocidade — Botas de Velocidade',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'botas-de-velocidade'),
    1
  ),
  (
    'caldeiraoPocaoUse',
    'Poção — Caldeirão do Renascimento',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'),
    1
  ),
  (
    'caldeiraoReviverUse',
    'Reviver — Caldeirão do Renascimento',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'),
    1
  ),
  (
    'tomoPalavrasUse',
    'Conjurar — Tomo das Palavras Tranquilizantes',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tomo-das-palavras-tranquilizantes'),
    1
  ),
  (
    'talismaMalCharges',
    'Cargas — Talismã do Mal Universal',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-do-mal-universal'),
    1
  ),
  (
    'talismaBemCharges',
    'Cargas — Talismã do Bem Sem Ver a Quem',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-do-bem-sem-ver-a-quem'),
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
  FALSE,
  TRUE
FROM (VALUES
  ('escaravelho-de-protecao', 'escaravelhoProtecaoCharges', 12),
  ('moeda-rival', 'moedaRivalUse', 1),
  ('olho-de-megera', 'olhoMegeraCharges', 3),
  ('faixas-de-ferro-de-bilarro', 'faixasBilarroUse', 1),
  ('manto-das-asas', 'mantoAsasUse', 1),
  ('botas-de-velocidade', 'botasVelocidadeUse', 1),
  ('caldeirao-do-renascimento', 'caldeiraoPocaoUse', 1),
  ('caldeirao-do-renascimento', 'caldeiraoReviverUse', 1),
  ('tomo-das-palavras-tranquilizantes', 'tomoPalavrasUse', 1),
  ('talisma-do-mal-universal', 'talismaMalCharges', 6),
  ('talisma-do-bem-sem-ver-a-quem', 'talismaBemCharges', 7)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "acBonus": 1
  }
}'::jsonb
WHERE slug = 'escaravelho-de-protecao';
