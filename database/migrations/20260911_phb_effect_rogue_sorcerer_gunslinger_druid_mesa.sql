-- Forward: mesa ladino/feiticeiro/pistoleiro/druida — economy rows + Soulknife free/paid pools.

UPDATE rpg.phb_class_economy_action
SET resource_slug = 'soulknife-psi-dice',
    free_resource_slug = 'psychic-whispers'
WHERE action_id = 'rogue-psychic-whispers';

UPDATE rpg.phb_class_economy_action
SET resource_slug = 'soulknife-psi-dice',
    free_resource_slug = 'psychic-veil'
WHERE action_id = 'rogue-psychic-veil';

UPDATE rpg.phb_class_economy_action
SET resource_slug = 'soulknife-psi-dice',
    free_resource_slug = 'rend-mind',
    spend_amount = 3
WHERE action_id = 'rogue-rend-mind';

UPDATE rpg.phb_class_economy_action
SET always_spends_resource = true
WHERE action_id = 'druid-wild-shape';

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT v.action_id, c.id, sc.id, v.name, v.economy::rpg.action_economy_bucket,
       v.unlock_level, v.resource_slug, v.free_resource_slug, v.always_spends,
       v.summary, v.description, v.table_action, v.spend_amount, v.sort_order
FROM (VALUES
  ('rogue-psi-bolstered-knack', 'soulknife', 'Aptidão Reforçada Psiquicamente', 'free', 3, 'soulknife-psi-dice', NULL, false, 'Some dado psi ao teste', 'Gasta o dado somente se o teste passar.', 'psi-bolstered-knack', NULL, 20),
  ('rogue-guided-strike', 'soulknife', 'Golpes Teleguiados', 'free', 9, 'soulknife-psi-dice', NULL, false, 'Some dado psi ao ataque', 'Gasta o dado somente se acertar.', 'guided-strike', NULL, 21),
  ('sorcerer-convert-slot-1', NULL, 'Converter Slot 1º → PF', 'free', 2, NULL, NULL, false, 'Fonte de Magia', 'Consuma 1 slot de 1º círculo → 1 PF.', 'convert-slot-1-to-points', NULL, 58),
  ('sorcerer-convert-slot-2', NULL, 'Converter Slot 2º → PF', 'free', 2, NULL, NULL, false, 'Fonte de Magia', 'Consuma 1 slot de 2º círculo → 2 PF.', 'convert-slot-2-to-points', NULL, 58),
  ('sorcerer-convert-slot-3', NULL, 'Converter Slot 3º → PF', 'free', 2, NULL, NULL, false, 'Fonte de Magia', 'Consuma 1 slot de 3º círculo → 3 PF.', 'convert-slot-3-to-points', NULL, 58),
  ('sorcerer-convert-slot-4', NULL, 'Converter Slot 4º → PF', 'free', 2, NULL, NULL, false, 'Fonte de Magia', 'Consuma 1 slot de 4º círculo → 4 PF.', 'convert-slot-4-to-points', NULL, 58),
  ('sorcerer-convert-slot-5', NULL, 'Converter Slot 5º → PF', 'free', 2, NULL, NULL, false, 'Fonte de Magia', 'Consuma 1 slot de 5º círculo → 5 PF.', 'convert-slot-5-to-points', NULL, 58),
  ('sorcerer-convert-points-1', NULL, 'Criar Slot 1º (2 PF)', 'free', 2, 'sorceryPoints', NULL, true, 'Fonte de Magia', 'Gaste 2 PF → 1 slot de 1º.', 'convert-points-to-slot-1', 2, 58),
  ('sorcerer-convert-points-2', NULL, 'Criar Slot 2º (3 PF)', 'free', 2, 'sorceryPoints', NULL, true, 'Fonte de Magia', 'Gaste 3 PF → 1 slot de 2º.', 'convert-points-to-slot-2', 3, 58),
  ('sorcerer-convert-points-3', NULL, 'Criar Slot 3º (5 PF)', 'free', 2, 'sorceryPoints', NULL, true, 'Fonte de Magia', 'Gaste 5 PF → 1 slot de 3º.', 'convert-points-to-slot-3', 5, 58),
  ('sorcerer-convert-points-4', NULL, 'Criar Slot 4º (6 PF)', 'free', 2, 'sorceryPoints', NULL, true, 'Fonte de Magia', 'Gaste 6 PF → 1 slot de 4º.', 'convert-points-to-slot-4', 6, 58),
  ('sorcerer-convert-points-5', NULL, 'Criar Slot 5º (7 PF)', 'free', 2, 'sorceryPoints', NULL, true, 'Fonte de Magia', 'Gaste 7 PF → 1 slot de 5º.', 'convert-points-to-slot-5', 7, 58),
  ('sorcerer-use-metamagic', NULL, 'Metamagia (mesa)', 'free', 2, 'sorceryPoints', NULL, false, 'Gastar PF em opção conhecida', 'Escolha metamagicSlug no POST.', 'use-metamagic', NULL, 59),
  ('gunslinger-use-maneuver', NULL, 'Usar Manobra', 'free', 2, 'risk', NULL, false, 'Gasta risk na manobra', 'Escolha maneuverSlug no POST.', 'use-maneuver', NULL, 70),
  ('gunslinger-recover-risk', NULL, 'Gambito Terrível', 'free', 15, NULL, NULL, false, 'Recupera 1 risk (nv.15+)', 'Marque recuperação ao rolar iniciativa/crítico.', 'recover-risk', NULL, 71),
  ('gunslinger-reload-firearm', NULL, 'Recarregar', 'action', 2, NULL, NULL, false, 'Recarrega arma de fogo', 'Informe itemSlug.', 'reload-firearm', NULL, 72),
  ('gunslinger-fire-chamber', NULL, 'Disparar', 'action', 2, NULL, NULL, false, 'Gasta tiros do tambor', 'Informe itemSlug e shots.', 'fire-chamber', NULL, 73),
  ('druid-wild-resurgence-slot', NULL, 'Ressurgimento (Forma → Slot)', 'free', 5, 'wildShape', NULL, true, '1 Forma → slot 1º', 'Gaste 1 Forma Selvagem.', 'wild-resurgence-slot', NULL, 53),
  ('druid-wild-resurgence-shape', NULL, 'Ressurgimento (Slot → Forma)', 'free', 5, NULL, NULL, true, 'Slot 1º → 1 Forma', 'Consuma 1 slot de 1º.', 'wild-resurgence-shape', NULL, 53),
  ('druid-moon-combat-wild-shape', 'moon', 'Forma Selvagem de Combate', 'bonus', 3, 'wildShape', NULL, true, 'Lua: combate WS', 'Assuma forma de combate.', 'moon-combat-wild-shape', NULL, 54),
  ('druid-natural-recovery-1', 'land', 'Recuperação Natural (1º)', 'free', 6, 'natural-recovery', NULL, false, 'Slot 1º no DS', 'Descanso Curto.', 'natural-recovery-1', NULL, 54),
  ('druid-natural-recovery-2', 'land', 'Recuperação Natural (2º)', 'free', 6, 'natural-recovery', NULL, false, 'Slot 2º no DS', 'Descanso Curto.', 'natural-recovery-2', NULL, 54),
  ('druid-natural-recovery-3', 'land', 'Recuperação Natural (3º)', 'free', 6, 'natural-recovery', NULL, false, 'Slot 3º no DS', 'Descanso Curto.', 'natural-recovery-3', NULL, 54),
  ('druid-natural-recovery-4', 'land', 'Recuperação Natural (4º)', 'free', 8, 'natural-recovery', NULL, false, 'Slot 4º no DS', 'Descanso Curto.', 'natural-recovery-4', NULL, 54),
  ('druid-natural-recovery-5', 'land', 'Recuperação Natural (5º)', 'free', 10, 'natural-recovery', NULL, false, 'Slot 5º no DS', 'Descanso Curto.', 'natural-recovery-5', NULL, 54)
) AS v(action_id, subclass_slug, name, economy, unlock_level, resource_slug, free_resource_slug, always_spends, summary, description, table_action, spend_amount, sort_order)
CROSS JOIN rpg.phb_class c
LEFT JOIN rpg.phb_subclass sc ON sc.slug = v.subclass_slug
WHERE c.slug = CASE
  WHEN v.action_id LIKE 'rogue-%' THEN 'rogue'
  WHEN v.action_id LIKE 'sorcerer-%' THEN 'sorcerer'
  WHEN v.action_id LIKE 'gunslinger-%' THEN 'gunslinger'
  ELSE 'druid'
END
ON CONFLICT (action_id) DO NOTHING;
