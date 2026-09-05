-- PHB Cap. 6 — corrige descrição dos itens barding (custo ×4, peso ×2).

UPDATE rpg.phb_item
SET description = 'Armadura feita para montaria. Qualquer armadura da tabela do PHB pode ser comprada como barding; custo ×4 e peso ×2 da armadura equivalente.'
WHERE slug LIKE 'barding-%'
  AND properties->>'kind' = 'barding';
