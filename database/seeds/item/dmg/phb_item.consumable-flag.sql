-- DMG lote §0 #1: marca consumíveis (poção / óleo / pergaminho)
-- Gerado por scripts/generate-dmg-consumable-lote.mjs

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"consumable":true}'::jsonb
WHERE slug IN (
  'oleo-de-forma-eterea',
  'oleo-de-precisao',
  'oleo-escorregadio',
  'pergaminho-da-invocacao-de-tita',
  'pergaminho-de-circulo-da-protecao',
  'pocao-bafo-de-fogo',
  'pocao-da-saude',
  'pocao-das-formas-gasosas',
  'pocao-de-amizade-animal',
  'pocao-de-clarividencia',
  'pocao-de-compreensao',
  'pocao-de-cura',
  'pocao-de-escalada',
  'pocao-de-forca-de-gigante',
  'pocao-de-heroismo',
  'pocao-de-invisibilidade',
  'pocao-de-invisibilidade-maior',
  'pocao-de-invulnerabilidade',
  'pocao-de-ler-mentes',
  'pocao-de-longevidade',
  'pocao-de-pugilismo',
  'pocao-de-resistencia',
  'pocao-de-respirar-na-agua',
  'pocao-de-velocidade',
  'pocao-de-vitalidade',
  'pocao-de-voo',
  'pocao-do-amor',
  'pocao-do-crescimento',
  'pocao-do-encolhimento',
  'pocao-falsa'
);
