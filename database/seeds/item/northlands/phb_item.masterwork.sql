-- Obra-Prima (Masterwork) — cobertura anexável (+1 ataque/dano)
-- Anexe com attach-coverage e bonus=1 (masterwork exige +1).

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES
(
  'obra-prima',
  'other'::rpg.item_type,
  'Obra-Prima',
  '{"text":"300 PO","gp":300}'::jsonb,
  NULL,
  'Aprimoramento de arma: +1 nas jogadas de ataque e de dano se você for proficiente. Armas mágicas já são consideradas obra-prima — pode anexar; o +1 não se soma aos bônus mágicos. Custo típico = base + 300 PO.',
  '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial","requiresTierBonus":true,"masterwork":true,"source":"northlands-heroes","editionSlug":"northlands-heroes-2024-en","citationSlug":"northlands-heroes-2024-en:magic-and-miscellany","category":"Cobertura","rarity":"common","rarityLabel":"Comum","requiresAttunement":false}'::jsonb
),
(
  'obra-prima-municao',
  'other'::rpg.item_type,
  'Obra-Prima (Munição)',
  '{"text":"5 PO","gp":5}'::jsonb,
  NULL,
  'Aprimoramento de munição: +1 nas jogadas de ataque e de dano se você for proficiente. Munição mágica já é obra-prima — pode anexar; o +1 não se soma. Custo típico 5 PO.',
  '{"kind":"coverage","appliesTo":"ammunition","appliesFilter":"Qualquer Munição","requiresTierBonus":true,"masterwork":true,"source":"northlands-heroes","editionSlug":"northlands-heroes-2024-en","citationSlug":"northlands-heroes-2024-en:magic-and-miscellany","category":"Cobertura","rarity":"common","rarityLabel":"Comum","requiresAttunement":false}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
