-- DMG §0 #9f: resources maravilhosos (cargas / 1×)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "acBonus": 1
  }
}'::jsonb
WHERE slug = 'escaravelho-de-protecao';
