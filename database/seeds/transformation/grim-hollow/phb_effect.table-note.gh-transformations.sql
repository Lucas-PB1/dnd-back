-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Cap. 6 — table_action tipados (apply/nota) além dos grant_resource em E008.
-- Não regenerado pelo generate-ghpg-cap6-economy-seeds.mjs.

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-seraph'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger,
         'gh-transformation-seraph/divine-clemency', 2, 1,
         'Clemência Divina'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Reação: Palavra Curativa (nível 1) no aliado a até 9 m — 2d4 + atributo de conjuração. Ajuste os PV do alvo na mesa.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lich'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger,
         'gh-transformation-lich/unholy-healing', 3, 1,
         'Cura Profana'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Enquanto o vaso de alma estiver carregado: no início de cada turno por 1 minuto, recupera 10 PV. Declare na mesa (duração tipada ainda não modelada).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'table_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger,
         v.action_slug, v.unlock_level, v.sort_order, v.label
  FROM feat
  CROSS JOIN (VALUES
    ('gh-transformation-lycanthrope/hybrid-wolf-form', 1, 1, 'Forma Híbrida — Lobo'),
    ('gh-transformation-lycanthrope/hybrid-bear-form', 1, 2, 'Forma Híbrida — Urso'),
    ('gh-transformation-lycanthrope/hybrid-rat-form', 1, 3, 'Forma Híbrida — Rato'),
    ('gh-transformation-lycanthrope/hunters-focus', 2, 4, 'Foco do Caçador'),
    ('gh-transformation-lycanthrope/kindred-form', 2, 5, 'Forma Kindred')
  ) AS v(action_slug, unlock_level, sort_order, label)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT ins.id, n.note
FROM ins
JOIN (VALUES
  ('gh-transformation-lycanthrope/hybrid-wolf-form',
   'Declare forma híbrida de lobo na mesa (1 h × estágio). Reverter: ação Mágica.'),
  ('gh-transformation-lycanthrope/hybrid-bear-form',
   'Declare forma híbrida de urso na mesa (1 h × estágio). Reverter: ação Mágica.'),
  ('gh-transformation-lycanthrope/hybrid-rat-form',
   'Declare forma híbrida de rato na mesa (1 h × estágio). Reverter: ação Mágica.'),
  ('gh-transformation-lycanthrope/hunters-focus',
   'Marque 1 presa a até 18 m (1 h). +1d6 em acertos corpo a corpo; vantagem Percepção/Sobrevivência para localizá-la.'),
  ('gh-transformation-lycanthrope/kindred-form',
   'Declare Forma Kindred (regras de Polimorfia: urso/rato/lobo conforme a linhagem). Equipamento cai.')
) AS n(action_slug, note) ON n.action_slug = ins.action_slug;
