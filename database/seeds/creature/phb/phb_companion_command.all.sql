-- Comandos de mesa do companheiro.

INSERT INTO rpg.phb_companion_command (slug, label_pt, note_kind, sort_order)
VALUES
  ('strike', 'Golpe da Fera', 'strike', 1),
  ('help', 'Ajudar', 'bonus_action', 2),
  ('dash', 'Correr', 'bonus_action', 3),
  ('disengage', 'Desengajar', 'bonus_action', 4),
  ('dodge', 'Esquivar', 'bonus_action', 5)
ON CONFLICT (slug) DO UPDATE SET
  label_pt = EXCLUDED.label_pt,
  note_kind = EXCLUDED.note_kind,
  sort_order = EXCLUDED.sort_order;
