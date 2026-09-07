-- phb_effect — Northlands (origem bênçãos/mundanos, general, FS)
-- ADR: docs/architecture/adr-effect-engine.md · residual: docs/plans/effect-mesa-checklist.md

-- >>> from northlands-heroes/N040_phb_effect_feat_origin_nl_blessings.sql
-- Fase 5: efeitos origin Northlands — bênçãos (10)
-- Docs: docs/plans/effect-engine-origin-northlands.md

-- Eir
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'eir-vitality-points'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Pontos de Vitalidade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'feat-eir-vitality-surge',
         'eir-vitality-points', 1, 2, 'Surto de Vitalidade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_1d4'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, resource_slug,
    unlock_level, sort_order, label
  )
  SELECT 'heal'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_table_action'::rpg.effect_trigger, 'feat-eir-channel-vitality',
         'eir-vitality-points', 1, 3, 'Canalizar Vitalidade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'dice_1d4'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'stabilize_on_death_save'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_death_save'::rpg.effect_trigger, 'eir-vitality-points', 1, 4,
         'Estabilizar (Morrendo)'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Em cada death save: oferta estabilizar gastando 1 Ponto de Vitalidade (sem ação).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Helper pattern: fixed cantrip grant_spell from N031 spell slugs
-- Baldur
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Lança Solar'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0
FROM ins CROSS JOIN rpg.phb_spell s WHERE s.slug = 'chama-sagrada';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.label = 'Lança Solar'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL
FROM fx ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('spellcasting_ability'::rpg.effect_kind, 2, 'Atributo — Carisma'),
      ('damage_reduce_reaction'::rpg.effect_kind, 3, 'Égide Protetora'),
      ('combat_note'::rpg.effect_kind, 4, 'Aura Radiante')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 2 THEN 'Atributo de conjuração fixo: Carisma (magias deste talento).'
    WHEN 3 THEN '1×/DL: reação — reduzir dano em PB+Carisma (mín. 1) em você ou aliado a 3 m.'
    ELSE 'Ação bônus: luz plena 3 m + fraca +3 m; outra AB apaga (nota / ação indicativa).'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Boreas (truque + kinds)
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Raio de Gelo'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0 FROM ins
CROSS JOIN rpg.phb_spell s WHERE s.slug = 'raio-de-gelo';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Raio de Gelo'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Magia de Inverno — opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.label = 'Magia de Inverno — opção'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('damage_resistance_reaction'::rpg.effect_kind, 3, 'Égide do Frio'),
      ('spellcasting_ability'::rpg.effect_kind, 4, 'Atributo de conjuração')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 3 THEN 'Usos = PB / DL. Reação ao dano de Frio → Resistência a Frio até fim do próximo turno.'
    ELSE 'Escolher INT, SAB ou CAR na criação (magias deste talento).'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Freyr
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Conhecimento Selvagem'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'wildKnowledge', 'skill'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
spells AS (
  SELECT * FROM (VALUES
    (2, 'arte-druidica', 0, 'Druidismo'),
    (3, 'chicote-de-espinhos', 0, 'Chicote de Espinhos')
  ) AS t(sort_order, spell_slug, spell_level, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, spells.sort_order, spells.label
  FROM feat CROSS JOIN spells
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0
FROM ins
JOIN spells ON spells.sort_order = ins.sort_order
JOIN rpg.phb_spell s ON s.slug = spells.spell_slug;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 4, 'Magia Verde — opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order = 4 THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order = 4 THEN 1 ELSE NULL END
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 5, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Remaining blessings: compact notes + key grant_spells from N031
-- Jormungandr
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
spells AS (
  SELECT * FROM (VALUES
    (1, 'amizade-animal', 'Amizade com Animal'),
    (2, 'falar-com-animais', 'Falar com Animais')
  ) AS t(sort_order, spell_slug, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, spells.sort_order, spells.label
  FROM feat CROSS JOIN spells RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 1
FROM ins JOIN spells ON spells.sort_order = ins.sort_order
JOIN rpg.phb_spell s ON s.slug = spells.spell_slug;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, 1
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('damage_resistance_reaction'::rpg.effect_kind, 3, 'Resiliência ao Veneno'),
      ('combat_note'::rpg.effect_kind, 4, 'Só cobras (free cast)'),
      ('grant_language'::rpg.effect_kind, 5, 'Idioma'),
      ('spellcasting_ability'::rpg.effect_kind, 6, 'Atributo de conjuração')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 3 THEN 'Usos = PB / DL. Reação ao dano de Veneno → Resistência a Veneno até fim do próximo turno.'
    WHEN 4 THEN 'Free cast de Amizade/Falar: só cobras/serpentes (nota).'
    WHEN 5 THEN 'Concede idioma (param: Dracônico).'
    ELSE 'Escolher INT, SAB ou CAR na criação.'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Loki
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Enganação'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'deception', 'skill'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_expertise'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Expertise se já proficiente'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Se já tiver Enganação: concede expertise nela.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
spells AS (
  SELECT * FROM (VALUES
    (3, 'ilusao-menor', 0, 'Ilusão Menor'),
    (4, 'zombaria-perversa', 0, 'Zombaria Perversa')
  ) AS t(sort_order, spell_slug, lvl, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, spells.sort_order, spells.label
  FROM feat CROSS JOIN spells RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0
FROM ins JOIN spells ON spells.sort_order = ins.sort_order
JOIN rpg.phb_spell s ON s.slug = spells.spell_slug;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 5, 'Magia do Trapaceiro — opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id WHERE e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order >= 5 THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order >= 5 THEN 1 ELSE NULL END
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 6, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Sif / Thor dádiva + spells
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'add_proficiency_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Dádiva da Destreza'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Usos = PB / DL. Oferta (toggle) em teste/save de DES: +PB (de novo se já tinha).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Golpe Certo'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0 FROM ins
CROSS JOIN rpg.phb_spell s WHERE s.slug = 'golpe-certeiro';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 3, 'Proeza de Sif — opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id WHERE e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order = 3 THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order = 3 THEN 1 ELSE NULL END
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 4, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'add_proficiency_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Dádiva da Força'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Usos = PB / DL. Oferta (toggle) em teste/save de FOR: +PB (de novo se já tinha).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Truque — opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'cantripChoice', 0 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 3, 'Golpe Trovejante'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 1 FROM ins
CROSS JOIN rpg.phb_spell s WHERE s.slug = 'destruicao-estrondosa';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id WHERE e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order = 3 THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order = 3 THEN 1 ELSE NULL END
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 4, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Volund
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Ferramenta de Artesão'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'artisanTool', 'tool'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'check_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Já proficiente → vantagem'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Se já tinha a ferramenta escolhida: vantagem nos testes com ela.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
spells AS (
  SELECT * FROM (VALUES
    (3, 'elementalismo', 'Elementalismo'),
    (4, 'reparar', 'Conserto')
  ) AS t(sort_order, spell_slug, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, spells.sort_order, spells.label
  FROM feat CROSS JOIN spells RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0
FROM ins JOIN spells ON spells.sort_order = ins.sort_order
JOIN rpg.phb_spell s ON s.slug = spells.spell_slug;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 5, 'Magia da Forja — opção'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'bonusSpell', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id WHERE e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order = 5 THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order = 5 THEN 1 ELSE NULL END
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 6, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Wotan
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Amarrado ao Saber'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'loreSkill', 'skill'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_expertise'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 2, 'Expertise se já proficiente'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Se já tiver a perícia escolhida: expertise nela.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 3, 'Orientação'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, spell_level)
SELECT ins.id, s.id, 0 FROM ins
CROSS JOIN rpg.phb_spell s WHERE s.slug = 'orientacao';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell_by_level'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 4, 'Qualquer magia de 1º'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id, 'anyFirstLevel', 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
fx AS (
  SELECT e.id, e.kind FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.kind IN ('grant_spell', 'grant_spell_by_level')
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN kind = 'grant_spell_by_level' THEN 'once_per_long_rest'::rpg.effect_cast_economy
       ELSE 'at_will'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN kind = 'grant_spell_by_level' THEN 1 ELSE NULL END
FROM fx ON CONFLICT DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 5, 'Atributo de conjuração'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- >>> from northlands-heroes/N041_phb_effect_feat_origin_nl_mundane.sql
-- Fase 5: efeitos origin Northlands — mundanos (8)
-- Docs: docs/plans/effect-engine-origin-northlands.md

-- brewer
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Suprimentos de Cervejeiro'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'brewersSupplies', 'tool'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'purchase_discount'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_purchase'::rpg.effect_trigger, 1, 2, 'Desconto comida/bebida'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_purchase_discount (effect_id, percent_off, non_magic_only, food_drink_only)
SELECT id, 50, FALSE, TRUE FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 3, 'Desconto — filtro'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Desconto 50% só em comida/bebida (tag food_drink; poções = bebida). Wire de filtro no checkout.'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'brewer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'craft_item_on_long_rest'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_rest_long'::rpg.effect_trigger, 1, 4, 'Fermentação Rápida'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Fim do DL: se tem Suprimentos de Cervejeiro → oferta criar hidromel (item temp_hp = PB). Início do DL: hidromel some.'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- fisher
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fisher'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Sobrevivência'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'survival', 'skill'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fisher'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('vehicle_check_advantage'::rpg.effect_kind, 2, 'Veículos aquáticos'),
      ('combat_note'::rpg.effect_kind, 3, 'Proeza de Pesca')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 2 THEN 'Vantagem em Testes d20 para operar veículos aquáticos (PC no veículo).'
    ELSE 'Proeza de Pesca: 1 h → comida para até 6 pessoas / 1 dia (nota).'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- northern-raider
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'northern-raider'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_proficiency'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Ferramentas de Navegador'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'navigatorsTools', 'tool'::rpg.effect_proficiency_kind FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'northern-raider'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'advantage_until_consumed'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Sangue na Água'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ao sair do navio (ou água): vantagem pendente em ataques e testes de atributo; some ao usar.'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- norn-touched
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'norn-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'add_proficiency_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Favor das Parcas'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  '1×/dia. Oferta (toggle) em Teste d20: +PB (pode ver resultado antes).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'norn-touched'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Desdém das Parcas'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  '1×/dia: −PB no d20 de outra criatura (ataque/teste). Nota + uso manual (sem auto em roll alheio).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- well-versed
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'well-versed'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'on_build'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('grant_proficiency'::rpg.effect_kind, 1, 'Instrumento musical'),
      ('grant_proficiency'::rpg.effect_kind, 2, 'Perícia de saber')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id,
  CASE sort_order WHEN 1 THEN 'musicalInstrument' ELSE 'loreSkill' END,
  CASE sort_order
    WHEN 1 THEN 'instrument'::rpg.effect_proficiency_kind
    ELSE 'skill'::rpg.effect_proficiency_kind
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'well-versed'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'check_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 3, 'Conhecimento Útil'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Usos = PB / DL. Oferta (toggle) antes de INT (Arcanismo/História/Natureza/Religião): vantagem?'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- cold-plunge
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-plunge-training'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('check_advantage'::rpg.effect_kind, 1, 'Treino em Água Fria'),
      ('combat_note'::rpg.effect_kind, 2, 'Mergulho Ártico')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Enquanto mesaCircumstances inclui in_water: vantagem vs frio extremo e Atletismo (natação). Toggle: cold-plunge-toggle-in-water / extreme-cold.'
    ELSE 'Mergulho Ártico: da terra para a água no turno — deslocamento normal na água (ative in_water na ficha).'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'cold-plunge-training')
INSERT INTO rpg.phb_effect_check_advantage (effect_id, skill_slug, circumstance_tag, ability_slug)
SELECT e.id, 'athletics', 'in_water', NULL
FROM rpg.phb_effect e
JOIN feat ON feat.id = e.owner_id
WHERE e.owner_kind = 'feat'
  AND e.kind = 'check_advantage'
  AND e.label = 'Treino em Água Fria'
ON CONFLICT (effect_id) DO UPDATE SET
  skill_slug = EXCLUDED.skill_slug,
  circumstance_tag = EXCLUDED.circumstance_tag;

-- sea-wolf
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'sea-wolf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id,
         CASE WHEN v.sort_order = 2 THEN 'on_critical_hit'::rpg.effect_trigger
              ELSE 'passive'::rpg.effect_trigger END,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 1, 'Abordagem Tática'),
      ('extra_melee_attack_on_crit'::rpg.effect_kind, 2, 'Ferocidade do Saqueador')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Vantagem em Atletismo/Acrobacia para embarcar em veículos (nota).'
    ELSE 'Crítico corpo a corpo: oferta de outro ataque CA (AB) vs mesma ou adjacente.'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- snowrunner
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'snowrunner'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES (1, 'Caminhada no Gelo'), (2, 'Fio do Inverno')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Com mesaCircumstances snow_ice: vantagem em equilíbrio em superfícies escorregadias/neve. Toggle: snowrunner-toggle-snow-ice.'
    ELSE 'Com mesaCircumstances snow_ice: vantagem em Sobrevivência em terreno nevado/gelado.'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- >>> from northlands-heroes/N042_phb_effect_feat_general_nl.sql
-- Fase 6: phb_effect general Northlands (51 feats — sem fighting-styles)
-- Inventário: docs/plans/effect-engine-general-nl.md
-- Idempotente. combat_note = nomes de benefício N018 (exc. ASI) · join max ~200 chars.

-- —— combat_note (bulk — 1 por feat) ——
WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('axe-fighter', 10, 'Rajada de Machado · Derrubada Precisa…', 'Rajada de Machado · Derrubada Precisa · Trespassar Interminável'),
    ('axe-thrower', 10, 'Arremesso de Retorno', 'Arremesso de Retorno'),
    ('battle-cry', 10, 'Grito Trovejante', 'Grito Trovejante'),
    ('blessing-of-angrboda-and-bergelmir', 10, 'Golpe Trovejante · Visão Profética', 'Golpe Trovejante · Visão Profética'),
    ('blessing-of-bragi', 10, 'Amor dos Vanir', 'Amor dos Vanir'),
    ('blessing-of-heimdall', 10, 'Consciência do Guardião · Trompa do A…', 'Consciência do Guardião · Trompa do Arauto · Vigilância'),
    ('blessing-of-hel', 10, 'Adiar o Fim · Ressurgimento · O Sino …', 'Adiar o Fim · Ressurgimento · O Sino Toca'),
    ('blessing-of-njord', 10, 'Convocar Serpente Marinha · Proteção …', 'Convocar Serpente Marinha · Proteção de Njord'),
    ('blessing-of-skadi', 10, 'Olho do Caçador · Passo na Neve', 'Olho do Caçador · Passo na Neve'),
    ('blessing-of-the-snow-queen', 10, 'Gume Congelado · Escudo do Vento do N…', 'Gume Congelado · Escudo do Vento do Norte'),
    ('blessing-of-tyr', 10, 'Bravura · Justicar', 'Bravura · Justicar'),
    ('blood-of-the-berserker', 10, 'Fúria do Berserker', 'Fúria do Berserker'),
    ('bloodied-resilience', 10, 'Reação Ensanguentada · Salvaguardas E…', 'Reação Ensanguentada · Salvaguardas Ensanguentadas'),
    ('bloody-resolve', 10, 'Fogo Interior', 'Fogo Interior'),
    ('boisterous-roar', 10, 'Grito Poderoso', 'Grito Poderoso'),
    ('brazen-courage', 10, 'Vontade Firme', 'Vontade Firme'),
    ('chosen-by-fate', 10, 'Ressurgimento Heroico · Bonança Heroica', 'Ressurgimento Heroico · Bonança Heroica'),
    ('clout', 10, 'Influência Forte', 'Influência Forte'),
    ('cold-water-warrior', 10, 'Contra a Corrente · Resistência à Águ…', 'Contra a Corrente · Resistência à Água Fria · Salto Nadando · Combatente Aquático'),
    ('combat-flyting', 10, 'Provocação', 'Provocação'),
    ('cut-down-the-nithingr', 10, 'Flagelo dos Covardes · Visagem Aterra…', 'Flagelo dos Covardes · Visagem Aterradora'),
    ('endurance-conditioning', 10, 'Recuperação Rápida', 'Recuperação Rápida'),
    ('faster-crafting', 10, 'Proficiência Artesanal Aumentada · Cr…', 'Proficiência Artesanal Aumentada · Criação Rápida em Combate · Criação em Descanso Curto'),
    ('fjord-jumper', 10, 'Salto de Penhasco · Mergulho Seguro', 'Salto de Penhasco · Mergulho Seguro'),
    ('frost-eyed', 10, 'Olhos Brilhantes · Rastreador do Gelo', 'Olhos Brilhantes · Rastreador do Gelo'),
    ('frost-touched', 10, 'Magia de Geada', 'Magia de Geada'),
    ('giant-slayer', 10, 'Esquivar e Tecer · Quanto Maior, Mais…', 'Esquivar e Tecer · Quanto Maior, Mais Forte Cai'),
    ('greater-blessing-of-baldur', 10, 'Resiliência Divina', 'Resiliência Divina'),
    ('greater-blessing-of-boreas', 10, 'Forjado no Frio', 'Forjado no Frio'),
    ('greater-blessing-of-freyr-and-freyja', 10, 'Magia Curativa', 'Magia Curativa'),
    ('greater-blessing-of-jormungandr', 10, 'Aspecto da Serpente', 'Aspecto da Serpente'),
    ('greater-blessing-of-loki', 10, 'Senhor das Mentiras · Magia da Máscara', 'Senhor das Mentiras · Magia da Máscara'),
    ('greater-blessing-of-sif', 10, 'Flecha de Sif', 'Flecha de Sif'),
    ('greater-blessing-of-thor', 10, 'Golpe da Tempestade', 'Golpe da Tempestade'),
    ('greater-blessing-of-wotan', 10, 'Mestre do Saber · Presságio Mágico', 'Mestre do Saber · Presságio Mágico'),
    ('heroic-rush', 10, 'Impulso Triunfante · Inspiração Vitor…', 'Impulso Triunfante · Inspiração Vitoriosa'),
    ('holmganga-master', 10, 'Pronto para a Batalha · Intimidação d…', 'Pronto para a Batalha · Intimidação de Duelo'),
    ('hunter', 10, 'Rastreamento Aprimorado · Furtividade…', 'Rastreamento Aprimorado · Furtividade Superior'),
    ('ice-mastery', 10, 'Garras do Fimbulvetr', 'Garras do Fimbulvetr'),
    ('lightning-mastery', 10, 'Fúria de Thor', 'Fúria de Thor'),
    ('living-off-the-land', 10, 'Herbalista · Abrigo de Sobrevivência', 'Herbalista · Abrigo de Sobrevivência'),
    ('long-haft-strike', 10, 'Contornar Escudo · Defesa de Alcance', 'Contornar Escudo · Defesa de Alcance'),
    ('moon-touched', 10, 'Magia Lunar', 'Magia Lunar'),
    ('mounted-leap', 10, 'Proeza Equestre · Ataque de Investida…', 'Proeza Equestre · Ataque de Investida em Salto'),
    ('northlands-hardiness', 10, 'Resiliência ao Clima Frio · Inesgotável', 'Resiliência ao Clima Frio · Inesgotável'),
    ('primal', 10, 'Magia Primordial', 'Magia Primordial'),
    ('ravens-friend', 10, 'Estudo Rápido · Sussurros do Corvo', 'Estudo Rápido · Sussurros do Corvo'),
    ('spear-expert', 10, 'Haste Defletora · Arremessador Experi…', 'Haste Defletora · Arremessador Experiente · Lança Pronta'),
    ('surtrs-touch', 10, 'Toque da Chama', 'Toque da Chama'),
    ('tricksters-toolbox', 10, 'Magia Trapaceira', 'Magia Trapaceira'),
    ('wild-lore', 10, 'Conhecimento da Terra · Provedor', 'Conhecimento da Terra · Provedor')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, owner_id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT DISTINCT ON (ins.id) ins.id, r.note
FROM ins
JOIN rpg.phb_feat f ON f.id = ins.owner_id
JOIN rows r ON r.slug = f.slug AND r.label = ins.label
ORDER BY ins.id
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- Greater Freyr: Curar Ferimentos PB×/DL (optionKey sintético bonusSpell = magia fixa)
WITH feat AS (
  SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-freyr-and-freyja'
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 20, 'Magia Curativa'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, s.id, 'bonusSpell', 1
FROM ins
CROSS JOIN rpg.phb_spell s
WHERE s.slug = 'curar-ferimentos';

WITH feat AS (
  SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-freyr-and-freyja'
),
fx AS (
  SELECT e.id
  FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat'
    AND e.kind = 'grant_spell'
    AND e.label = 'Magia Curativa'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'once_per_long_rest'::rpg.effect_cast_economy,
       'proficiency_bonus'::rpg.effect_uses_formula, NULL
FROM fx
ON CONFLICT DO NOTHING;

-- —— blessing-of-hel: death_save_advantage ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-hel'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'death_save_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_death_save'::rpg.effect_trigger, 1, 1, 'Adiar o Fim'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Vantagem em Salvaguardas Contra a Morte.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- —— blessing-of-njord: grant_swim_speed ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-njord'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_swim_speed'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Proteção de Njord — natação'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Deslocamento de Natação = Deslocamento a pé; respira água e ar.' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- —— blessing-of-skadi: speed_bonus +3 m (gelo/neve) ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-skadi'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'speed_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Passo na Neve'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 10 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-skadi'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'speed_bonus'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, '+3 m Deslocamento sobre gelo/neve; terreno gelo/neve nunca é Difícil.' FROM fx
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- —— endurance-conditioning: reduce_exhaustion_on_rest ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'endurance-conditioning'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, v.trigger::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('reduce_exhaustion_on_rest'::rpg.effect_kind, 'on_rest_short', 1, 'Recuperação — DC'),
      ('reduce_exhaustion_on_rest'::rpg.effect_kind, 'on_rest_long', 2, 'Recuperação — DL')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Fim do Descanso Curto: −1 Exaustão (1×/dia).'
    ELSE 'Fim do Descanso Longo: −2 níveis de Exaustão.'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'endurance-conditioning'),
fx AS (
  SELECT e.id, e.trigger FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'reduce_exhaustion_on_rest'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula,
  CASE WHEN trigger = 'on_rest_short' THEN 1 ELSE 2 END
FROM fx;

-- —— northlands-hardiness ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'northlands-hardiness'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ignore_exhaustion_penalties'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Inesgotável'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ignora penalidade de Exaustão no Deslocamento (1º nível); offer D20 1/DL (resource depois).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- —— chosen-by-fate: inspiration_refund_on_fail ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'chosen-by-fate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'inspiration_refund_on_fail'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Ressurgimento Heroico'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'IH em Teste d20 que falha → uso não gasto. Bonança Heroica: heal/temp HP no spend (wire IH).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- —— long-haft-strike: ac_bonus ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'long-haft-strike'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ac_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Defesa de Alcance'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toggle sticky gate Extensão: +1 CA com haste/lança. Contornar Escudo = nota (ignora CA escudo).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'long-haft-strike'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'ac_bonus'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM fx;

-- —— spear-expert ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('ac_bonus'::rpg.effect_kind, 1, 'Haste Defletora'),
      ('override_weapon_range'::rpg.effect_kind, 2, 'Arremessador Experiente')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Toggle sticky gate Lança: +1 CA empunhando lança.'
    ELSE 'Alcance lança/arremesso: 9 m / 27 m.'
  END
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'ac_bonus'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'spear-expert'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'override_weapon_range'
)
INSERT INTO rpg.phb_effect_weapon (effect_id, range_normal_ft, range_long_ft)
SELECT id, 30, 90 FROM fx;

-- —— sticky canal damage_bonus (Surtr / Sif / Thor) ——
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'surtrs-touch'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Toque da Chama'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Canal sticky ×PB: +PB dano Ígneo corpo a corpo. Ligado → aplica e gasta; off manual ou pool zero.'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-sif'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Flecha de Sif'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Canal sticky ×PB: +PB dano à distância. Off manual ou pool zero (não auto-off no 1º hit).'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'greater-blessing-of-thor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Golpe da Tempestade'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Canal sticky ×PB: +PB dano corpo a corpo. Off manual ou pool zero.'
FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- —— magia touch: spellcasting_ability ——
WITH rows(slug, label, note) AS (
  VALUES
    ('frost-touched', 'Magia de Geada',
     'Cantrip + 1º Gélido + Lufada; free 1/DL; atributo = ASI (Int/Sab/Cha).'),
    ('moon-touched', 'Magia Lunar',
     'Cantrip + 1º luz + Raio Lunar; free 1/DL; atributo = ASI.'),
    ('primal', 'Magia Primordial',
     '2 magias de pool + Pele-Casca; free 1/DL; atributo = ASI.'),
    ('tricksters-toolbox', 'Magia Trapaceira',
     '2× Enc/Ilu 1º + Gargalhada Tasha; free 1/DL; atributo = ASI.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'spellcasting_ability'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'on_build'::rpg.effect_trigger, 1, 1, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT DISTINCT ON (ins.id) ins.id, r.note
FROM ins
JOIN rows r ON r.label = ins.label
ORDER BY ins.id
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- >>> from northlands-heroes/N043_phb_effect_feat_fighting_style_nl.sql
-- Fase 6b: phb_effect fighting-style Northlands
-- Inventário: docs/plans/effect-engine-fighting-style.md
-- Idempotente.

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('glima', 10, 'Glima',
     'Desarmado a 1,5 m vs tamanho ≥ seu ou menor: save FOR (CD 8+PB+For) ou Caído.'),
    ('raiders-rush', 10, 'Investida do Saqueador',
     'Vantagem em ataques vs criatura a 1,5 m de aliado se você moveu ≥4,5 m e parou a 1,5 m do aliado.'),
    ('savagery', 10, 'Selvageria',
     '1ª ataque C/C com arma no turno: +PB dano C/C com arma; −2 CA até início do próximo turno (toggle).'),
    ('shield-wall', 10, 'Proteger Aliado',
     'Reação: concede CA do seu Escudo a aliado adjacente vs o ataque.'),
    ('shield-wall', 11, 'Ombro a Ombro',
     'Você e aliado com escudo adjacentes: +1 CA cada.'),
    ('skirmisher', 10, 'Mobilidade',
     '+3 m Deslocamento.'),
    ('skirmisher', 11, 'Golpear e Desaparecer',
     '1×/turno: +PB dano Cont/Perf/Cort se moveu ≥4,5 m antes do ataque.'),
    ('underfoot', 10, 'Pelos Pés',
     'Terminar movimento em espaço de criatura 2+ tamanhos maior; Vantagem ao atacá-la; ela tem Desvantagem contra você.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT DISTINCT ON (i.id) i.id, r.note
FROM ins i
JOIN rows r ON r.label = i.label
ORDER BY i.id
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- glima feature_dc
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'glima'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'feature_dc'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'CD Glima'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'CD = 8 + PB + mod Força (derrubar com desarmado).' FROM ins
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- savagery damage_bonus PB
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'savagery'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 1, 'Selvageria +PB'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'savagery'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'damage_bonus' AND e.label = 'Selvageria +PB'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Toggle: +PB dano C/C arma; −2 CA até próximo turno.'
FROM fx
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- shield-wall ac_bonus +1
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-wall'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'ac_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Ombro a Ombro +1'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-wall'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'ac_bonus' AND e.label = 'Ombro a Ombro +1'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Gate: você e aliado com escudo adjacentes (UI/mesa).'
FROM fx
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;

-- skirmisher speed + damage PB
WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'skirmisher'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'speed_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Escaramuçador +3 m'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 10 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'skirmisher'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 2, 'Golpear e Desaparecer'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'skirmisher'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.kind = 'damage_bonus' AND e.label = 'Golpear e Desaparecer'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, '1×/turno após mover ≥4,5 m; Cont/Perf/Cort.'
FROM fx
ON CONFLICT (effect_id) DO UPDATE SET note = EXCLUDED.note;
