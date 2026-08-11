-- DMG §3.1: marca coberturas (kind + appliesTo + appliesFilter)
-- Gerado por scripts/generate-dmg-coverage-lote.mjs

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial","requiresTierBonus":true}'::jsonb
WHERE slug = 'arma-1-2-ou-3';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada","requiresTierBonus":true}'::jsonb
WHERE slug = 'armadura-1-2-ou-3';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"shield","appliesFilter":"Escudo","requiresTierBonus":true}'::jsonb
WHERE slug = 'escudo-1-2-ou-3';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"ammunition","appliesFilter":"Qualquer Munição","requiresTierBonus":true}'::jsonb
WHERE slug = 'municao-1-2-ou-3';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"wand","appliesFilter":"varinha","requiresTierBonus":true}'::jsonb
WHERE slug = 'varinha-do-mago-de-guerra-1-2-ou-3';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"unarmed","appliesFilter":"ataque-desarmado"}'::jsonb
WHERE slug = 'ataduras-do-poder-desarmado';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Munição ou Arma Corpo a Corpo"}'::jsonb
WHERE slug = 'arma-de-adamantina';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'arma-de-prata';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Média ou Pesada, Exceto Gibão de Peles"}'::jsonb
WHERE slug = 'armadura-adamantina';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Média ou Pesada, Exceto Gibão de Peles"}'::jsonb
WHERE slug = 'armadura-de-mitral';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada"}'::jsonb
WHERE slug = 'armadura-facil-de-tirar';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Pesada, Média ou Leve"}'::jsonb
WHERE slug = 'armadura-fumegante';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada"}'::jsonb
WHERE slug = 'armadura-reluzente';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada"}'::jsonb
WHERE slug = 'armadura-do-marinheiro';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'arma-implacavel';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial","enspelled":{"kind":"coverage","schoolSlugs":["adivinhacao","evocacao","invocacao","necromancia","transmutacao"],"maxLevel":8}}'::jsonb
WHERE slug = 'arma-magificada';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'arma-sempre-alerta';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada"}'::jsonb
WHERE slug = 'armadura-de-resistencia';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada"}'::jsonb
WHERE slug = 'armadura-de-vulnerabilidade';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Qualquer Leve, Média ou Pesada"}'::jsonb
WHERE slug = 'armadura-demoniaca';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"ammunition","appliesFilter":"Qualquer Munição"}'::jsonb
WHERE slug = 'municao-exterminadora';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"ammunition","appliesFilter":"Qualquer Munição"}'::jsonb
WHERE slug = 'municao-impactante';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'sorvedora-das-nove-almas';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Arma Corpo a Corpo"}'::jsonb
WHERE slug = 'defensora';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'matadora-de-dragoes';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'matadora-de-gigantes';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Simples ou Marcial"}'::jsonb
WHERE slug = 'sacro-vingadora';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira"}'::jsonb
WHERE slug = 'escara-gelida';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Grande, Espada Longa ou Glaive"}'::jsonb
WHERE slug = 'espada-da-precisao';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira"}'::jsonb
WHERE slug = 'espada-da-vinganca';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Rapieira"}'::jsonb
WHERE slug = 'espada-dancarina';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira"}'::jsonb
WHERE slug = 'espada-laceradora';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira"}'::jsonb
WHERE slug = 'espada-lunar';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive ou Rapieira"}'::jsonb
WHERE slug = 'espada-usurpadora-de-vida';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Grande, Espada Longa ou Glaive"}'::jsonb
WHERE slug = 'espada-vorpal';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Adaga, Cimitarra, Espada Curta, Foice, Lança ou Rapieira"}'::jsonb
WHERE slug = 'garra-silvestre';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Cimitarra, Espada Curta, Espada Grande, Espada Longa, Glaive, Rapieira"}'::jsonb
WHERE slug = 'lamina-da-sorte';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Alabarda, Machadinha, Machado de Batalha ou Machado Grande"}'::jsonb
WHERE slug = 'machado-do-carrasco';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Alabarda, Machado de Batalha ou Machado Grande"}'::jsonb
WHERE slug = 'machado-berserker';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Qualquer Arma Corpo a Corpo"}'::jsonb
WHERE slug = 'lingua-flamejante';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Arco Curto ou Arco Longo"}'::jsonb
WHERE slug = 'arco-de-energia';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Arco Curto ou Arco Longo"}'::jsonb
WHERE slug = 'arco-do-juramento';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"weapon","appliesFilter":"Malho ou Martelo de Guerra"}'::jsonb
WHERE slug = 'martelo-do-trovao';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Armadura de Placas Parcial ou Armadura de Placas"}'::jsonb
WHERE slug = 'armadura-de-placas-das-formas-etereas';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Armadura de Placas ou Placas Parcial"}'::jsonb
WHERE slug = 'armadura-de-placas-do-povo-anao';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Cota de Malha ou Cota de Malha Parcial"}'::jsonb
WHERE slug = 'cota-de-malha-elfica';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"kind":"coverage","appliesTo":"armor","appliesFilter":"Cota de Malha ou Cota de Malha Parcial"}'::jsonb
WHERE slug = 'cota-de-malha-ifriti';
