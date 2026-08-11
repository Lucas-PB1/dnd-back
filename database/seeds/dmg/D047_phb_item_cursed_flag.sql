-- Treasure Cap. 7: itens amaldiçoados (não encerrar sintonia até Remover Maldição).
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"cursed":true}'::jsonb
WHERE slug IN (
  'armadura-de-vulnerabilidade',
  'armadura-demoniaca',
  'escudo-de-atracao-de-projeteis',
  'espada-da-vinganca',
  'machado-berserker'
);
