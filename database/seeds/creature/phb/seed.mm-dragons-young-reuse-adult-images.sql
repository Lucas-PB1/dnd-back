-- Young dragons reuse Adult portrait (Beyond has no dedicated Young art).
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-azul-adulto.png' WHERE slug = 'dragao-azul-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-branco-adulto.png' WHERE slug = 'dragao-branco-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-de-bronze-adulto.png' WHERE slug = 'dragao-de-bronze-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-de-cobre-adulto.png' WHERE slug = 'dragao-de-cobre-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-de-latao-adulto.png' WHERE slug = 'dragao-de-latao-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-dourado-adulto.png' WHERE slug = 'dragao-dourado-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-negro-adulto.png' WHERE slug = 'dragao-negro-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-prateado-adulto.png' WHERE slug = 'dragao-prateado-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-verde-adulto.png' WHERE slug = 'dragao-verde-jovem' AND edition_slug = 'phb-2024-pt';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-vermelho-adulto.png' WHERE slug = 'dragao-vermelho-jovem' AND edition_slug = 'phb-2024-pt';
-- Shadow: Juvenile reuses adult/shadow art
UPDATE rpg.phb_creature_template SET image_url = '/catalog/monsters/dragao-sombra.png' WHERE slug = 'dragao-sombra-juvenil' AND edition_slug = 'phb-2024-pt';
