-- Bruxo PHB: recursos + economia + painel de todos os patronos (idempotente).
-- Motivo: DB parcial sem S002/S003/C009/C010 completos para warlock.

-- ── Recursos (subclass) ──────────────────────────────────────────
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level) VALUES
  ('healing-light', 'Luz Medicinal', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 3),
  ('searing-vengeance', 'Vingança Calcinante', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'), 14),
  ('dark-ones-luck', 'A Sorte do Próprio Tenebroso', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 6),
  ('hurl-through-hell', 'Lançar no Inferno', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'), 14),
  ('fey-steps', 'Passos Feéricos', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 3),
  ('beguiling-defenses', 'Defesas Sedutoras', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'), 10),
  ('clairvoyant-competitor', 'Combatente Clarividente', 'subclass'::rpg.resource_scope,
   (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'), 6)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'subclass'::rpg.resource_owner_kind, s.id, rd.id, v.unlock_level,
       v.formula::rpg.resource_max_formula, v.fixed_max, sf.id,
       FALSE, FALSE, TRUE
FROM (VALUES
  ('celestial', 'healing-light', 3, 'level_plus_one', NULL, 'Luz Medicinal'),
  ('celestial', 'searing-vengeance', 14, 'fixed', 1, 'Vingança Calcinante'),
  ('fiend', 'dark-ones-luck', 6, 'charisma_mod', NULL, 'A Sorte do Próprio Tenebroso'),
  ('fiend', 'hurl-through-hell', 14, 'fixed', 1, 'Lançar no Inferno'),
  ('archfey', 'fey-steps', 3, 'charisma_mod', NULL, 'Passos Feéricos'),
  ('archfey', 'beguiling-defenses', 10, 'fixed', 1, 'Defesas Sedutoras'),
  ('great-old-one', 'clairvoyant-competitor', 6, 'fixed', 1, 'Combatente Clarividente')
) AS v(subclass_slug, resource_slug, unlock_level, formula, fixed_max, feature_name)
JOIN rpg.phb_subclass s ON s.slug = v.subclass_slug
JOIN rpg.phb_resource_definition rd ON rd.slug = v.resource_slug
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = v.feature_name
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- ── Economia ─────────────────────────────────────────────────────
INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
('warlock-magical-cunning', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), NULL,
 'Astúcia Mágica', 'free'::rpg.action_economy_bucket, 2, 'magical-cunning', NULL, true,
 'Recupera metade dos slots de Pacto (rito 1 min; 1×/DL)', NULL, 'magical-cunning', NULL, 63),
('warlock-healing-light', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
 'Luz Medicinal', 'bonus'::rpg.action_economy_bucket, 3, 'healing-light', NULL, false,
 'Cura com reserva de d6s (1–CAR)', NULL, 'healing-light', NULL, 64),
('warlock-dark-ones-luck', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
 'A Sorte do Próprio Tenebroso', 'free'::rpg.action_economy_bucket, 6, 'dark-ones-luck', NULL, false,
 '+1d10 em teste ou salvaguarda', NULL, 'dark-ones-luck', NULL, 65),
('warlock-fey-steps', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
 'Passos Feéricos', 'bonus'::rpg.action_economy_bucket, 3, 'fey-steps', NULL, true,
 'Passo Nebuloso sem espaço + efeito', NULL, 'fey-step-effect', NULL, 72),
('warlock-beguiling-defenses', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
 'Defesas Sedutoras', 'reaction'::rpg.action_economy_bucket, 10, 'beguiling-defenses', NULL, true,
 'Reação após ser acertado: metade do dano + psíquico', NULL, 'beguiling-defenses', NULL, 73),
('warlock-clairvoyant-combatant', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
 'Combatente Clarividente', 'free'::rpg.action_economy_bucket, 6, 'clairvoyant-competitor', NULL, true,
 'Ao usar Mente Desperta: link de combate (1× SR/LR)', NULL, 'clairvoyant-combatant', NULL, 74),
('warlock-searing-vengeance', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
 'Vingança Calcinante', 'reaction'::rpg.action_economy_bucket, 14, 'searing-vengeance', NULL, true,
 'Salvaguarda contra morte (você/aliado 18 m)', NULL, 'searing-vengeance', NULL, 75),
('warlock-hurl-through-hell', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
 'Lançar no Inferno', 'free'::rpg.action_economy_bucket, 14, 'hurl-through-hell', NULL, true,
 'Ao acertar: envie o alvo aos Infernos (1×/DL)', NULL, 'hurl-through-hell', NULL, 76)
ON CONFLICT (action_id) DO UPDATE SET
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  table_action = EXCLUDED.table_action,
  subclass_id = EXCLUDED.subclass_id,
  sort_order = EXCLUDED.sort_order;

-- ── Painel ───────────────────────────────────────────────────────
INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
('warlock|magical-cunning', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), NULL,
 'magical-cunning', 'Astúcia Mágica', NULL, 2, 'magical-cunning',
 'base'::rpg.panel_action_section, false, 1),
('warlock|invoke-pact-weapon', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), NULL,
 'invoke-pact-weapon', 'Invocar Arma de Pacto',
 'Ação Bônus: vincule e equipe uma arma corpo a corpo do inventário (Pacto da Lâmina)',
 1, NULL, 'base'::rpg.panel_action_section, false, 2),
('warlock|celestial|healing-light', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
 'healing-light', 'Luz Medicinal',
 'Ação Bônus: gaste 1–CAR d6s da reserva para curar a até 18 m',
 3, 'healing-light', 'subclass'::rpg.panel_action_section, false, 2),
('warlock|celestial|searing-vengeance', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
 'searing-vengeance', 'Vingança Calcinante',
 'Quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL)',
 14, 'searing-vengeance', 'subclass'::rpg.panel_action_section, false, 7),
('warlock|fiend|dark-ones-luck', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
 'dark-ones-luck', 'A Sorte do Próprio Tenebroso (+1d10)', NULL,
 6, 'dark-ones-luck', 'subclass'::rpg.panel_action_section, false, 3),
('warlock|fiend|fiendish-resilience', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
 'fiendish-resilience', 'Resistência Ínfera',
 'Após Descanso Curto ou Longo, escolha um tipo de dano (exceto Energético)',
 10, NULL, 'subclass'::rpg.panel_action_section, false, 6),
('warlock|fiend|hurl-through-hell', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
 'hurl-through-hell', 'Lançar no Inferno', NULL,
 14, 'hurl-through-hell', 'subclass'::rpg.panel_action_section, false, 8),
('warlock|archfey|fey-step-effect', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
 'fey-step-effect', 'Passos Feéricos',
 'Gasta 1 uso: Passo Nebuloso sem espaço + efeito',
 3, 'fey-steps', 'subclass'::rpg.panel_action_section, false, 4),
('warlock|archfey|beguiling-defenses', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
 'beguiling-defenses', 'Defesas Sedutoras',
 'Imune a Enfeitiçado; Reação após ser acertado: metade do dano + psíquico no atacante',
 10, 'beguiling-defenses', 'subclass'::rpg.panel_action_section, false, 9),
('warlock|great-old-one|awakened-mind', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
 'awakened-mind', 'Mente Desperta', 'Ação Bônus: ligação telepática a 9 m',
 3, NULL, 'subclass'::rpg.panel_action_section, false, 5),
('warlock|great-old-one|clairvoyant-combatant', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
 (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
 'clairvoyant-combatant', 'Combatente Clarividente',
 'Ao usar Mente Desperta: alvo salva Sabedoria; falha → desv. vs você / você vant. vs alvo',
 6, 'clairvoyant-competitor', 'subclass'::rpg.panel_action_section, false, 10)
ON CONFLICT (panel_key) DO UPDATE SET
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  subclass_id = EXCLUDED.subclass_id,
  sort_order = EXCLUDED.sort_order;
