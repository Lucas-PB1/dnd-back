-- Extrai Armadura Magificada colada em armadura-fumegante (como D014).
-- Fonte: docs/source/dmg-2024-itens-magicos-az.txt

UPDATE rpg.phb_item
SET description = 'Fumos tênues, inofensivos e sem odor se elevam desta armadura enquanto ela está sendo vestida.'
WHERE slug = 'armadura-fumegante';

INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  'armadura-magificada',
  'armor'::rpg.item_type,
  'Armadura Magificada',
  NULL,
  NULL,
  'Esta armadura contém uma magia de 8º círculo ou inferior vinculada a ela. A magia é determinada no momento em que a armadura é fabricada e deve pertencer às escolas de magia de Abjuração ou Ilusão. A armadura possui 6 cargas e recupera 1d6 cargas gastas diariamente ao amanhecer. Enquanto estiver vestindo a armadura, você pode gastar 1 carga para conjurar a magia vinculada a ela.
O círculo da magia vinculada à armadura determina a CD da salvaguarda da magia, o bônus de ataque e a raridade da armadura, conforme mostrado na tabela a seguir.
Círculo de Magia
	Raridade
	CD da Salvaguarda
	Bônus de Ataque
	Truque
	Incomum
	13
	+5
	1
	Incomum
	13
	+5
	2
	Raro
	13
	+5
	3
	Raro
	15
	+7
	4
	Muito Raro
	15
	+7
	5
	Muito Raro
	17
	+9
	6
	Lendário
	17
	+9
	7
	Lendário
	18
	+10
	8
	Lendário
	18
	+10',
  '{"magic":true,"source":"dmg-2024-pt","editionSlug":"dmg-2024-pt","citationSlug":"dmg-2024-pt:ch7:itens-magicos","category":"Armadura (Qualquer Leve, Média ou Pesada)","rarity":"varies","rarityLabel":"Raridade Variável","requiresAttunement":true,"header":"Armadura (Qualquer Leve, Média ou Pesada), Raridade Variável (Requer Sintonização)","attunement":"Requer Sintonização","armorSubtype":"Qualquer Leve, Média ou Pesada","kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada","enspelled":{"kind":"coverage","schoolSlugs":["abjuracao","ilusao"],"maxLevel":8}}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  properties = COALESCE(rpg.phb_item.properties, '{}'::jsonb) || EXCLUDED.properties;

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"enspelled":{"kind":"unique","schoolSlugs":null,"maxLevel":8}}'::jsonb
WHERE slug = 'cajado-magificado';
