-- Hotfix Bruxo: Astúcia Mágica, dark-ones-luck, limpeza painel legado
-- Uso: node scripts/reseed-c009.mjs && node scripts/reseed-c010.mjs
--      ou aplicar este arquivo + S068/S073 após migrate T071

DELETE FROM rpg.phb_class_panel_action
WHERE panel_key = 'warlock|fiend|dark-ones-own-luck';
