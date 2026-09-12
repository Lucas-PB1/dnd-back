-- Forward: kinds tipados para outliers mesa (handlers thin).

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'missile_mage_arm';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'resource_fallback_spend';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'moon_combat_wild_shape';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'restore_resource_from_slot';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'bind_pact_weapon';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'psychic_blade_attack';

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT v.action_id, c.id, sc.id, v.name, v.economy::rpg.action_economy_bucket,
       v.unlock_level, v.resource_slug, v.free_resource_slug, v.always_spends,
       v.summary, v.description, v.table_action, v.spend_amount::integer, v.sort_order
FROM (VALUES
  ('wizard-arm-missile-shield', NULL::text, 'Armar Escudo de Mísseis', 'free', 10, NULL::text, NULL::text, false, 'Armar antes do cast', 'Marque Escudo de Mísseis armado na ficha.', 'arm-missile-shield', NULL::integer, 69),
  ('wizard-disarm-missile-shield', NULL, 'Desarmar Escudo de Mísseis', 'free', 10, NULL, NULL, false, 'Desarmar Escudo', 'Remove flag de Escudo de Mísseis armado.', 'disarm-missile-shield', NULL, 69),
  ('wizard-arm-giga-missile', NULL, 'Armar Giga-Míssil', 'free', 14, NULL, NULL, false, 'Armar antes do cast', 'Marque Giga-Míssil armado na ficha.', 'arm-giga-missile', NULL, 70),
  ('wizard-disarm-giga-missile', NULL, 'Desarmar Giga-Míssil', 'free', 14, NULL, NULL, false, 'Desarmar Giga-Míssil', 'Remove flag de Giga-Míssil armado.', 'disarm-giga-missile', NULL, 70),
  ('wizard-arcane-recovery-1', NULL, 'Recuperação Arcana (1º)', 'free', 1, 'arcaneRecovery', NULL, true, 'Slot 1º no DS', 'Descanso Curto: recupera 1 slot de 1º círculo.', 'arcane-recovery-1', NULL, 68),
  ('wizard-arcane-recovery-2', NULL, 'Recuperação Arcana (2º)', 'free', 1, 'arcaneRecovery', NULL, true, 'Slot 2º no DS', 'Descanso Curto: recupera 1 slot de 2º círculo.', 'arcane-recovery-2', NULL, 68),
  ('wizard-arcane-recovery-3', NULL, 'Recuperação Arcana (3º)', 'free', 1, 'arcaneRecovery', NULL, true, 'Slot 3º no DS', 'Descanso Curto: recupera 1 slot de 3º círculo.', 'arcane-recovery-3', NULL, 68),
  ('wizard-arcane-recovery-4', NULL, 'Recuperação Arcana (4º)', 'free', 1, 'arcaneRecovery', NULL, true, 'Slot 4º no DS', 'Descanso Curto: recupera 1 slot de 4º círculo.', 'arcane-recovery-4', NULL, 68),
  ('wizard-arcane-recovery-5', NULL, 'Recuperação Arcana (5º)', 'free', 1, 'arcaneRecovery', NULL, true, 'Slot 5º no DS', 'Descanso Curto: recupera 1 slot de 5º círculo.', 'arcane-recovery-5', NULL, 68),
  ('wizard-spell-mastery', NULL, 'Dominância de Magias', 'free', 18, NULL, NULL, false, 'Magias 1º/2º sem slot', 'Lembrete de mesa: 1 magia de 1º e 1 de 2º preparadas podem ser conjuradas sem espaço.', 'spell-mastery', NULL, 68),
  ('warlock-invoke-pact-weapon', NULL, 'Invocar Arma de Pacto', 'bonus', 1, NULL, NULL, false, 'Vincula arma corpo a corpo', 'Ação Bônus: vincule e equipe uma arma do inventário (Pacto da Lâmina).', 'invoke-pact-weapon', NULL, 62),
  ('warlock-fiendish-resilience', 'fiend', 'Resistência Ínfera', 'free', 10, NULL, NULL, false, 'Escolha tipo de dano', 'Após Descanso Curto ou Longo, escolha Resistência a um tipo (exceto Energético).', 'fiendish-resilience', NULL, 65),
  ('rogue-psychic-blade-main', 'soulknife', 'Lâmina Psíquica', 'action', 3, NULL, NULL, false, 'Ataque 1d6+DES Psíquico', 'Ataque com Lâmina Psíquica (alcance 18 m).', 'psychic-blade-main', NULL, 18),
  ('rogue-psychic-blade-bonus', 'soulknife', 'Lâmina Psíquica adicional', 'bonus', 3, NULL, NULL, false, 'AB: 1d4+DES Psíquico', 'Ataque adicional com Lâmina Psíquica.', 'psychic-blade-bonus', NULL, 18),
  ('druid-moon-combat-wild-shape', 'moon', 'Forma Selvagem de Combate', 'bonus', 3, 'wildShape', NULL, true, 'Lua: combate WS', 'Assuma forma de combate.', 'moon-combat-wild-shape', NULL, 54)
) AS v(action_id, subclass_slug, name, economy, unlock_level, resource_slug, free_resource_slug, always_spends, summary, description, table_action, spend_amount, sort_order)
CROSS JOIN rpg.phb_class c
LEFT JOIN rpg.phb_subclass sc ON sc.slug = v.subclass_slug
WHERE c.slug = CASE
  WHEN v.action_id LIKE 'wizard-%' THEN 'wizard'
  WHEN v.action_id LIKE 'warlock-%' THEN 'warlock'
  WHEN v.action_id LIKE 'rogue-%' THEN 'rogue'
  ELSE 'druid'
END
ON CONFLICT (action_id) DO NOTHING;
