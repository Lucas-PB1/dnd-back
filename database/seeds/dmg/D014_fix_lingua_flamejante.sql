-- Corrige parse colado: remove slug monstro e cria lingua-flamejante limpa.
-- Fonte: docs/source/extracts/dmg/items-az.txt (linha de caption removida).

-- 1) Insere / atualiza a Língua Flamejante correta
INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'lingua-flamejante',
  'weapon'::rpg.item_type,
  'Língua Flamejante',
  NULL,
  NULL,
  'Enquanto estiver segurando esta arma mágica, você pode executar uma Ação Bônus e pronunciar uma palavra de comando para fazer com que chamas envolvam a lâmina. Essas chamas emitem Luz Plena em um raio de 12 metros e Meia-luz por mais 12 metros. Enquanto a arma estiver em chamas, ela causa 2d6 pontos de dano Ígneo adicionais ao acertar. As chamas permanecem até você executar uma Ação Bônus para repetir o comando ou até que você largue, guarde ou embainhe a arma.',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Arma (Qualquer Arma Corpo a Corpo)","rarity":"rare","rarityLabel":"Raro","requiresAttunement":true,"header":"Arma (Qualquer Arma Corpo a Corpo), Raro (Requer Sintonização)","attunement":"Requer Sintonização","weaponSubtype":"Qualquer Arma Corpo a Corpo","kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Arma Corpo a Corpo"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  properties = COALESCE(rpg.phb_item.properties, '{}'::jsonb) || EXCLUDED.properties;

-- 2) Remapeia refs do slug monstro → lingua-flamejante
UPDATE rpg.player_character_item
SET item_slug = 'lingua-flamejante'
WHERE item_slug = 'estatueta-de-poder-maravilhoso-cabras-de-marfim-coruja-de-serpentina-lingua-flamejante-espada-longa-escara-gelida-cimitarra';

UPDATE rpg.player_character_equipment
SET item_slug = 'lingua-flamejante'
WHERE item_slug = 'estatueta-de-poder-maravilhoso-cabras-de-marfim-coruja-de-serpentina-lingua-flamejante-espada-longa-escara-gelida-cimitarra';

UPDATE rpg.player_character
SET background_tool_item_slug = 'lingua-flamejante'
WHERE background_tool_item_slug = 'estatueta-de-poder-maravilhoso-cabras-de-marfim-coruja-de-serpentina-lingua-flamejante-espada-longa-escara-gelida-cimitarra';

-- 3) Remove o item colado
DELETE FROM rpg.phb_item
WHERE slug = 'estatueta-de-poder-maravilhoso-cabras-de-marfim-coruja-de-serpentina-lingua-flamejante-espada-longa-escara-gelida-cimitarra';

-- 4) Limpa descrição do Leque do Vento (tinha "Língua Flamejante" grudada)
UPDATE rpg.phb_item
SET description = 'Enquanto segurar este leque, você pode conjurar Lufada de Vento (CD 13 para evitar) a partir dele. Cada vez que o leque é usado antes do próximo amanhecer, ele tem uma chance cumulativa de 20% de não funcionar. Se o leque não funcionar, ele se rasga em farrapos inúteis e não mágicos.'
WHERE slug = 'leque-do-vento';
