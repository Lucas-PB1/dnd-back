-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Espécie → phb_effect (todas as fontes). Idempotente; preserva spends E006.
-- Docs: docs/architecture/effect-dictionary.md · plano migração espécie

-- ═══════════════════════════════════════════════════════════════════════════
-- Idiomas ×2 (todas as espécies jogáveis)
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (
  SELECT id, slug FROM rpg.phb_species
  WHERE slug IN (
    'aasimar', 'dwarf', 'dragonborn', 'elf', 'gnome', 'goliath', 'human', 'orc',
    'halfling', 'tiefling', 'geppettin', 'mandrake', 'bearfolk', 'beastkin',
    'giantkin', 'trollkin', 'werekin', 'manikin', 'scourgeborne', 'feathren'
  )
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_language'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, s.id,
         'on_build'::rpg.effect_trigger, 1, 0, 'Idiomas da espécie'
  FROM species s
  RETURNING id
)
INSERT INTO rpg.phb_effect_language (effect_id, option_key, language_slug, choice_count)
SELECT id, 'speciesLanguage', NULL, 2 FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Anão (gates dwarfCultureId: phb | baugsmidr | fjord)
-- ═══════════════════════════════════════════════════════════════════════════

-- Visão 120 ft — phb + baugsmidr
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 10, 'Visão no Escuro 36 m',
         'dwarfCultureId', v.culture
  FROM species CROSS JOIN (VALUES ('phb'), ('baugsmidr')) AS v(culture)
  RETURNING id
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 120, NULL FROM ins;

-- Visão 90 ft — fjord
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 10, 'Visão no Escuro 27 m',
         'dwarfCultureId', 'fjord'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 90, NULL FROM ins;

-- Resist. + save veneno — phb + baugsmidr
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label,
         'dwarfCultureId', v.culture
  FROM species
  CROSS JOIN (
    VALUES
      ('damage_resistance'::rpg.effect_kind, 11, 'Resistência a Veneno', 'phb'),
      ('damage_resistance'::rpg.effect_kind, 11, 'Resistência a Veneno', 'baugsmidr'),
      ('save_advantage'::rpg.effect_kind, 12, 'Vantagem vs Envenenado', 'phb'),
      ('save_advantage'::rpg.effect_kind, 12, 'Vantagem vs Envenenado', 'baugsmidr')
  ) AS v(kind, sort_order, label, culture)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_damage_type (effect_id, damage_type_slug, option_key)
SELECT id, 'poison', NULL FROM ins WHERE kind = 'damage_resistance';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'save_advantage'
    AND e.requires_option_key = 'dwarfCultureId'
    AND e.requires_option_value IN ('phb', 'baugsmidr')
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'poisoned' FROM fx;

-- Tenacidade — phb + fjord
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 13, 'Tenacidade Anã',
         'dwarfCultureId', v.culture
  FROM species CROSS JOIN (VALUES ('phb'), ('fjord')) AS v(culture)
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 1, 1 FROM ins;

-- Pedras (phb)
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'stonecunning'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 14, 'Conhecimento de Pedras',
         'dwarfCultureId', 'phb'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_resource_spend'::rpg.effect_trigger, 'stonecunning', 1, 15,
         'Sismiconsciência', 'dwarfCultureId', 'phb'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'tremorsense'::rpg.effect_sense_slug, 60, 10 FROM ins;

-- Baugsmidr: check_advantage + Sentir Magia
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'check_advantage'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label,
         'dwarfCultureId', 'baugsmidr'
  FROM species CROSS JOIN (
    VALUES
      (20, 'Lore Arcano'),
      (21, 'Artesão Mágico')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_check_advantage (effect_id, skill_slug, circumstance_tag, ability_slug)
SELECT id,
  CASE WHEN sort_order = 20 THEN 'arcana' ELSE NULL END,
  CASE WHEN sort_order = 21 THEN 'craft_magic_item' ELSE NULL END,
  NULL
FROM ins;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'baugsmidr-sense-magic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 22, 'Sentir Magia',
         'dwarfCultureId', 'baugsmidr'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- Fjord: Guerreiro + natação
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label,
         'dwarfCultureId', 'fjord'
  FROM species CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 30, 'Guerreiro dos Fiordes'),
      ('grant_swim_speed'::rpg.effect_kind, 31, 'Maestria das Ondas'),
      ('combat_note'::rpg.effect_kind, 32, 'Fôlego ×2')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 30 THEN 'Sem penalidade em jogadas de ataque ao equilibrar ou escalar.'
    WHEN 32 THEN 'Pode prender a respiração pelo dobro do tempo normal.'
    ELSE 'Deslocamento de Natação = Deslocamento a pé.'
  END
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Humano
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'human'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_inspiration'::rpg.effect_kind, 'on_rest_long', 10, 'Eficiente'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 11, 'Hábil'),
      ('grant_feat'::rpg.effect_kind, 'on_build', 12, 'Versátil')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'human_skill', 'skill'::rpg.effect_proficiency_kind
FROM ins WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'human'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_feat'
)
INSERT INTO rpg.phb_effect_feat (effect_id, option_key, feat_category)
SELECT id, 'human_origin_feat', 'origin' FROM fx;

-- ═══════════════════════════════════════════════════════════════════════════
-- Aasimar
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('damage_resistance'::rpg.effect_kind, 10, 'Resistência Necrótico'),
      ('damage_resistance'::rpg.effect_kind, 11, 'Resistência Radiante'),
      ('grant_sense'::rpg.effect_kind, 12, 'Visão no Escuro 18 m')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_damage_type (effect_id, damage_type_slug, option_key)
SELECT id,
  CASE sort_order WHEN 10 THEN 'necrotic' ELSE 'radiant' END,
  NULL
FROM ins WHERE kind = 'damage_resistance';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_sense' AND e.sort_order = 12
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
rows AS (
  SELECT * FROM (VALUES
    ('healingHands', 1, 20, 'fixed'::rpg.resource_max_formula, 1, 'Mãos Curativas'),
    ('celestialRevelation', 3, 21, 'fixed'::rpg.resource_max_formula, 1, 'Revelação Celestial')
  ) AS v(resource_slug, unlock_level, sort_order, max_formula, fixed_max, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, r.unlock_level, r.sort_order, r.label
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, FALSE, TRUE
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
JOIN rpg.phb_resource_definition rd ON rd.slug = r.resource_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
spell AS (SELECT id FROM rpg.phb_spell WHERE slug = 'luz'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_spell'::rpg.effect_kind, 30, 'Portador da Luz'),
      ('spellcasting_ability'::rpg.effect_kind, 31, 'Atributo — Carisma')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, spell.id, NULL, 0
FROM ins CROSS JOIN spell WHERE ins.kind = 'grant_spell';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell' AND e.sort_order = 30
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'spellcasting_ability'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Atributo de conjuração das magias da espécie: Carisma.' FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_fly_speed'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_resource_spend'::rpg.effect_trigger, 'celestialRevelation', 3, 40,
         'Asas Celestiais — voo', 'aasimarRevelationId', 'celestial-wings'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Durante a revelação: Deslocamento de Voo = Deslocamento a pé (1 min).'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Draconato
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 10, 'Visão no Escuro 18 m'),
      ('damage_resistance'::rpg.effect_kind, 11, 'Resistência Dracônica')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'damage_resistance'
)
INSERT INTO rpg.phb_effect_damage_type (effect_id, damage_type_slug, option_key)
SELECT id, NULL, 'dragonAncestryId' FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'),
rows AS (
  SELECT * FROM (VALUES
    ('breathWeapon', 1, 20, 'proficiency_bonus'::rpg.resource_max_formula, NULL::int, 'Ataque de Sopro'),
    ('dragonFlight', 5, 21, 'fixed'::rpg.resource_max_formula, 1, 'Voo Dracônico')
  ) AS v(resource_slug, unlock_level, sort_order, max_formula, fixed_max, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, r.unlock_level, r.sort_order, r.label
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, FALSE, TRUE
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
JOIN rpg.phb_resource_definition rd ON rd.slug = r.resource_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'grant_fly_speed'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_resource_spend'::rpg.effect_trigger, 'dragonFlight', 5, 30, 'Voo Dracônico'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Asas espectrais 10 min: Deslocamento de Voo = Deslocamento a pé.'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Elfo
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 'passive', 10, 'Visão no Escuro 18 m'),
      ('save_advantage'::rpg.effect_kind, 'passive', 11, 'Ancestralidade Feérica'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 12, 'Sentidos Aguçados'),
      ('rest_quirk'::rpg.effect_kind, 'passive', 13, 'Transe'),
      ('spellcasting_ability'::rpg.effect_kind, 'on_build', 14, 'Atributo de conjuração')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
fx AS (
  SELECT e.id, e.kind FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
    AND e.kind IN ('save_advantage', 'grant_proficiency', 'rest_quirk', 'spellcasting_ability')
    AND e.sort_order BETWEEN 11 AND 14
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'charmed' FROM fx WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'elf_keen_senses', 'skill'::rpg.effect_proficiency_kind
FROM fx WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_rest_quirk (
  effect_id, long_rest_hours, no_sleep, magic_cannot_force_sleep, no_food_drink_air
)
SELECT id, 4, TRUE, TRUE, FALSE FROM fx WHERE kind = 'rest_quirk';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação (magias da linhagem).'
FROM fx WHERE kind = 'spellcasting_ability';

-- Drow visão 120
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 20, 'Visão no Escuro 36 m (Drow)',
         'lineageId', 'drow'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 120, NULL FROM ins;

-- Wood-elf speed_set 35 ft
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'speed_set'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 21, 'Deslocamento 10,5 m',
         'lineageId', 'wood-elf'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 35 FROM ins;

-- Magias por linhagem (S049 + N008)
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
spells AS (
  SELECT * FROM (VALUES
    ('high-elf', 'prestidigitacao-arcana', 1, 30, 0, 'at_will'::rpg.effect_cast_economy, NULL::int),
    ('high-elf', 'detectar-magia', 3, 31, 1, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('high-elf', 'passo-nebuloso', 5, 32, 2, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('drow', 'luzes-dancantes', 1, 33, 0, 'at_will'::rpg.effect_cast_economy, NULL::int),
    ('drow', 'fogo-das-fadas', 3, 34, 1, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('drow', 'escuridao', 5, 35, 2, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('wood-elf', 'arte-druidica', 1, 36, 0, 'at_will'::rpg.effect_cast_economy, NULL::int),
    ('wood-elf', 'passos-largos', 3, 37, 1, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('wood-elf', 'passo-sem-rastro', 5, 38, 2, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('alfar', 'ilusao-menor', 1, 39, 0, 'at_will'::rpg.effect_cast_economy, NULL::int),
    ('alfar', 'imagem-silenciosa', 3, 40, 1, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('alfar', 'embacar', 5, 41, 2, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('ice-elf', 'raio-de-gelo', 1, 42, 0, 'at_will'::rpg.effect_cast_economy, NULL::int),
    ('ice-elf', 'faca-de-gelo', 3, 43, 1, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('ice-elf', 'sopro-de-vento', 5, 44, 2, 'once_per_long_rest'::rpg.effect_cast_economy, 1)
  ) AS v(lineage, spell_slug, unlock_level, sort_order, spell_level, economy, fixed_uses)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, s.unlock_level, s.sort_order,
         'Linhagem — ' || s.spell_slug, 'lineageId', s.lineage
  FROM species CROSS JOIN spells s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, sp.id, NULL, s.spell_level
FROM ins
JOIN spells s ON s.sort_order = ins.sort_order
JOIN rpg.phb_spell sp ON sp.slug = s.spell_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
spells AS (
  SELECT * FROM (VALUES
    (30, 'at_will'::rpg.effect_cast_economy, NULL::int),
    (31, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (32, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (33, 'at_will'::rpg.effect_cast_economy, NULL::int),
    (34, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (35, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (36, 'at_will'::rpg.effect_cast_economy, NULL::int),
    (37, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (38, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (39, 'at_will'::rpg.effect_cast_economy, NULL::int),
    (40, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (41, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (42, 'at_will'::rpg.effect_cast_economy, NULL::int),
    (43, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (44, 'once_per_long_rest'::rpg.effect_cast_economy, 1)
  ) AS v(sort_order, economy, fixed_uses)
),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
    AND e.requires_option_key = 'lineageId'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT fx.id, s.economy, 'fixed'::rpg.effect_uses_formula, s.fixed_uses
FROM fx JOIN spells s ON s.sort_order = fx.sort_order;

-- ═══════════════════════════════════════════════════════════════════════════
-- Gnomo
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 10, 'Visão no Escuro 18 m'),
      ('save_advantage'::rpg.effect_kind, 11, 'Astúcia de Gnomo'),
      ('spellcasting_ability'::rpg.effect_kind, 12, 'Atributo de conjuração')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'),
fx AS (
  SELECT e.id, e.kind FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order IN (11, 12)
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, ARRAY['inteligencia', 'sabedoria', 'carisma']::text[], NULL
FROM fx WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação (magias da linhagem).'
FROM fx WHERE kind = 'spellcasting_ability';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'),
spells AS (
  SELECT * FROM (VALUES
    ('rock-gnome', 'prestidigitacao-arcana', 50, 0, 'at_will'::rpg.effect_cast_economy, NULL::int, 'fixed'::rpg.effect_uses_formula),
    ('rock-gnome', 'reparar', 51, 0, 'at_will'::rpg.effect_cast_economy, NULL::int, 'fixed'::rpg.effect_uses_formula),
    ('forest-gnome', 'ilusao-menor', 52, 0, 'at_will'::rpg.effect_cast_economy, NULL::int, 'fixed'::rpg.effect_uses_formula),
    ('forest-gnome', 'falar-com-animais', 53, 1, 'once_per_long_rest'::rpg.effect_cast_economy, NULL::int, 'proficiency_bonus'::rpg.effect_uses_formula)
  ) AS v(lineage, spell_slug, sort_order, spell_level, economy, fixed_uses, uses_formula)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, s.sort_order,
         'Linhagem — ' || s.spell_slug, 'gnomeLineageId', s.lineage
  FROM species CROSS JOIN spells s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, sp.id, NULL, s.spell_level
FROM ins
JOIN spells s ON s.sort_order = ins.sort_order
JOIN rpg.phb_spell sp ON sp.slug = s.spell_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'),
spells AS (
  SELECT * FROM (VALUES
    (50, 'at_will'::rpg.effect_cast_economy, NULL::int, 'fixed'::rpg.effect_uses_formula),
    (51, 'at_will'::rpg.effect_cast_economy, NULL::int, 'fixed'::rpg.effect_uses_formula),
    (52, 'at_will'::rpg.effect_cast_economy, NULL::int, 'fixed'::rpg.effect_uses_formula),
    (53, 'once_per_long_rest'::rpg.effect_cast_economy, NULL::int, 'proficiency_bonus'::rpg.effect_uses_formula)
  ) AS v(sort_order, economy, fixed_uses, uses_formula)
),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
    AND e.requires_option_key = 'gnomeLineageId'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT fx.id, s.economy, s.uses_formula, s.fixed_uses
FROM fx JOIN spells s ON s.sort_order = fx.sort_order;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'combat_note'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 54, 'Dispositivo gnômico',
         'gnomeLineageId', 'rock-gnome'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Fabricar dispositivo via Prestidigitação Arcana (10 min); ativar com Ação Bônus (toque).'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Golias
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'),
rows AS (
  SELECT * FROM (VALUES
    ('giantAncestry', 1, 10, 'proficiency_bonus'::rpg.resource_max_formula, NULL::int, 'Ancestralidade Gigante'),
    ('largeForm', 5, 11, 'fixed'::rpg.resource_max_formula, 1, 'Forma Grande')
  ) AS v(resource_slug, unlock_level, sort_order, max_formula, fixed_max, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, r.unlock_level, r.sort_order, r.label
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, FALSE, TRUE
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
JOIN rpg.phb_resource_definition rd ON rd.slug = r.resource_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('carry_as_larger_size'::rpg.effect_kind, 20, 'Porte Poderoso — carga'),
      ('save_advantage'::rpg.effect_kind, 21, 'Porte Poderoso — Imobilizado'),
      ('combat_note'::rpg.effect_kind, 22, 'Forma Grande')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'restrained' FROM ins WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'combat_note' AND e.sort_order = 22
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Forma Grande (L5): tamanho Grande 10 min; Vantagem em testes de Força; +3 m Deslocamento.'
FROM fx;

-- ═══════════════════════════════════════════════════════════════════════════
-- Orc
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'orc'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 10, 'Visão no Escuro 36 m'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 120, NULL FROM ins;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'orc'),
rows AS (
  SELECT * FROM (VALUES
    ('adrenalineSurge', 1, 20, 'proficiency_bonus'::rpg.resource_max_formula, NULL::int, TRUE, TRUE, 'Pico de Adrenalina'),
    ('relentlessEndurance', 1, 21, 'fixed'::rpg.resource_max_formula, 1, FALSE, TRUE, 'Vigor Implacável')
  ) AS v(resource_slug, unlock_level, sort_order, max_formula, fixed_max, recover_sr, recover_lr, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, r.unlock_level, r.sort_order, r.label
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, r.recover_sr, r.recover_lr
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
JOIN rpg.phb_resource_definition rd ON rd.slug = r.resource_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'orc'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'survive_at_zero'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_resource_spend'::rpg.effect_trigger, 'relentlessEndurance', 1, 30,
         'Vigor Implacável'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Ao cair a 0 PV (sem morte imediata): fica com 1 PV (gasta 1 uso).'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Halfling
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'halfling'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('save_advantage'::rpg.effect_kind, 'passive', 10, 'Corajoso'),
      ('combat_note'::rpg.effect_kind, 'passive', 11, 'Agilidade Pequenina'),
      ('reroll_d20_on_nat1'::rpg.effect_kind, 'on_d20_nat1', 12, 'Sorte'),
      ('combat_note'::rpg.effect_kind, 'passive', 13, 'Furtividade Natural')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'frightened' FROM ins WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'halfling'),
ins AS (
  SELECT e.id, e.kind, e.sort_order
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 11 THEN 'Pode se mover pelo espaço de criatura de tamanho maior (sem parar no mesmo espaço).'
    ELSE 'Pode Esconder-se mesmo encoberto só por criatura de tamanho maior.'
  END
FROM ins WHERE kind = 'combat_note';

-- ═══════════════════════════════════════════════════════════════════════════
-- Tiferino
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 'passive', 10, 'Visão no Escuro 18 m'),
      ('spellcasting_ability'::rpg.effect_kind, 'on_build', 11, 'Atributo de conjuração')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'spellcasting_ability'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR na criação (legado + Taumaturgia).'
FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
rows AS (
  SELECT * FROM (VALUES
    ('abyssal', 'poison', 20),
    ('chthonic', 'necrotic', 21),
    ('infernal', 'fire', 22)
  ) AS v(legacy, dtype, sort_order)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'damage_resistance'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order,
         'Resistência — ' || r.dtype, 'infernalLegacyId', r.legacy
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_damage_type (effect_id, damage_type_slug, option_key)
SELECT ins.id, r.dtype, NULL
FROM ins JOIN rows r ON r.sort_order = ins.sort_order;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
spell AS (SELECT id FROM rpg.phb_spell WHERE slug = 'taumaturgia'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 30, 'Presença Sobrenatural'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, spell.id, NULL, 0 FROM ins CROSS JOIN spell;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell' AND e.sort_order = 30
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
spells AS (
  SELECT * FROM (VALUES
    ('abyssal', 'rajada-de-veneno', 1, 40, 0),
    ('abyssal', 'raio-nauseante', 3, 41, 1),
    ('abyssal', 'paralisar-pessoa', 5, 42, 2),
    ('chthonic', 'toque-necrotico', 1, 43, 0),
    ('chthonic', 'vitalidade-vazia', 3, 44, 1),
    ('chthonic', 'raio-do-enfraquecimento', 5, 45, 2),
    ('infernal', 'raio-de-fogo', 1, 46, 0),
    ('infernal', 'repreensao-diabolica', 3, 47, 1),
    ('infernal', 'escuridao', 5, 48, 2)
  ) AS v(legacy, spell_slug, unlock_level, sort_order, spell_level)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, s.unlock_level, s.sort_order,
         'Legado — ' || s.spell_slug, 'infernalLegacyId', s.legacy
  FROM species CROSS JOIN spells s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, sp.id, NULL, s.spell_level
FROM ins
JOIN spells s ON s.sort_order = ins.sort_order
JOIN rpg.phb_spell sp ON sp.slug = s.spell_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
    AND e.requires_option_key = 'infernalLegacyId'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order IN (40, 43, 46) THEN 'at_will'::rpg.effect_cast_economy
       ELSE 'once_per_long_rest'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order IN (40, 43, 46) THEN NULL ELSE 1 END
FROM fx;

-- ═══════════════════════════════════════════════════════════════════════════
-- Geppettin (Valdas)
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 'passive', 10, 'Visão no Escuro 18 m'),
      ('rest_quirk'::rpg.effect_kind, 'passive', 11, 'Natureza de Construto'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 12, 'Qualidade Artesanal')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
fx AS (
  SELECT e.id, e.kind FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order IN (11, 12)
)
INSERT INTO rpg.phb_effect_rest_quirk (
  effect_id, long_rest_hours, no_sleep, magic_cannot_force_sleep, no_food_drink_air
)
SELECT id, 4, TRUE, TRUE, TRUE FROM fx WHERE kind = 'rest_quirk';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'geppettin_skill', 'skill'::rpg.effect_proficiency_kind
FROM fx WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'reach_bonus'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 20, 'Marionete — alcance',
         'constructionId', 'marionette'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_reach (effect_id, bonus_ft, exclude_property_slugs)
SELECT id, 5, ARRAY['reach', 'two-handed', 'versatile']::text[] FROM ins;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 21, 'Porcelana — 1º turno',
         'constructionId', 'bisque'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'proficiency_bonus'::rpg.effect_amount_formula, NULL FROM ins;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'damage_bonus'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  '1º turno de combate: +PB dano no primeiro acerto com arma (mesmo tipo da arma).'
FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'damage_resistance_reaction'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 22, 'Pelúcia — reação',
         'constructionId', 'plushie'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Reação ao dano Contundente: Resistência ao dano; empurrado 1,5 m da fonte.'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Mandrágora (Valdas)
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('rest_quirk'::rpg.effect_kind, 'passive', 10, 'Natureza Vegetal'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 11, 'Conexão Natural'),
      ('spellcasting_ability'::rpg.effect_kind, 'on_build', 12, 'Atributo de conjuração')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_rest_quirk (
  effect_id, long_rest_hours, no_sleep, magic_cannot_force_sleep, no_food_drink_air
)
SELECT id, 8, FALSE, FALSE, FALSE FROM ins WHERE kind = 'rest_quirk';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
fx AS (
  SELECT e.id, e.kind FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order IN (10, 11, 12)
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE kind
    WHEN 'rest_quirk' THEN
      'Com ≥4 h de sol direto/dia: sem comida; respira/absorve pelos pés.'
    WHEN 'spellcasting_ability' THEN
      'Escolher INT, SAB ou CAR na criação (Magia das Raízes).'
    ELSE NULL
  END
FROM fx WHERE kind IN ('rest_quirk', 'spellcasting_ability');

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'mandrake_skill', 'skill'::rpg.effect_proficiency_kind
FROM fx WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
spells AS (
  SELECT * FROM (VALUES
    ('bordao-mistico', 1, 20, 0, 'at_will'::rpg.effect_cast_economy, NULL::int),
    ('bom-fruto', 3, 21, 1, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    ('pele-casca', 5, 22, 2, 'once_per_long_rest'::rpg.effect_cast_economy, 1)
  ) AS v(spell_slug, unlock_level, sort_order, spell_level, economy, fixed_uses)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, s.unlock_level, s.sort_order,
         'Magia das Raízes — ' || s.spell_slug
  FROM species CROSS JOIN spells s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, sp.id, NULL, s.spell_level
FROM ins
JOIN spells s ON s.sort_order = ins.sort_order
JOIN rpg.phb_spell sp ON sp.slug = s.spell_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
spells AS (
  SELECT * FROM (VALUES
    (20, 'at_will'::rpg.effect_cast_economy, NULL::int),
    (21, 'once_per_long_rest'::rpg.effect_cast_economy, 1),
    (22, 'once_per_long_rest'::rpg.effect_cast_economy, 1)
  ) AS v(sort_order, economy, fixed_uses)
),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT fx.id, s.economy, 'fixed'::rpg.effect_uses_formula, s.fixed_uses
FROM fx JOIN spells s ON s.sort_order = fx.sort_order;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'entanglingVines'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 30, 'Vinhas Enredantes'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

-- ═══════════════════════════════════════════════════════════════════════════
-- Northlands: bearfolk / beastkin / giantkin / trollkin / werekin
-- ═══════════════════════════════════════════════════════════════════════════

-- Bearfolk
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
rows AS (
  SELECT * FROM (VALUES
    ('bearfolk-apex-predator', 10, 'proficiency_bonus'::rpg.resource_max_formula, NULL::int, 'Predador de Ápice'),
    ('bearfolk-bear-hug', 11, 'constitution_mod'::rpg.resource_max_formula, NULL::int, 'Abraço do Urso')
  ) AS v(resource_slug, sort_order, max_formula, fixed_max, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, r.sort_order, r.label,
         CASE WHEN r.resource_slug = 'bearfolk-bear-hug' THEN 'bearfolkLineageId' ELSE NULL END,
         CASE WHEN r.resource_slug = 'bearfolk-bear-hug' THEN 'garhamr' ELSE NULL END
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, FALSE, TRUE
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
JOIN rpg.phb_resource_definition rd ON rd.slug = r.resource_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('damage_resistance'::rpg.effect_kind, 20, 'Pelagem — frio'),
      ('environmental_immunity'::rpg.effect_kind, 21, 'Pelagem — frio extremo'),
      ('save_advantage'::rpg.effect_kind, 22, 'Coração Selvagem'),
      ('combat_note'::rpg.effect_kind, 23, 'Predador de Ápice')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_damage_type (effect_id, damage_type_slug, option_key)
SELECT id, 'cold', NULL FROM ins WHERE kind = 'damage_resistance';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_environmental_immunity (effect_id, hazard_slug)
SELECT id, 'extreme_cold'::rpg.effect_env_hazard
FROM ins WHERE kind = 'environmental_immunity';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'frightened' FROM ins WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order IN (22, 23)
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 22 THEN 'Você e aliados a 1,5 m: Vantagem vs Amedrontado (enquanto consciente / sem Incapacitado).'
    ELSE 'Teste de Carisma: pode somar mod. Força ou Constituição (escolha na criação); usos = PB / DL.'
  END
FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 30, 'Dádiva da Natureza (truque Druida)',
         'bearfolkLineageId', 'andari'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT id, NULL, 'druidCantrip', 0 FROM ins;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL FROM fx;

-- Beastkin
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 10, 'Instinto Animal'),
      ('damage_die_override'::rpg.effect_kind, 'passive', 11, 'Armas Naturais')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'beastkin_instinct', 'skill'::rpg.effect_proficiency_kind
FROM ins WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'damage_die_override'
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d6' FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label,
         'naturalAdaptationId', v.adaptation
  FROM species CROSS JOIN (
    VALUES
      ('grant_fly_speed'::rpg.effect_kind, 20, 'Aviário — voo', 'avian'),
      ('grant_climb_speed'::rpg.effect_kind, 21, 'Ágil — escalada', 'agile'),
      ('save_advantage'::rpg.effect_kind, 22, 'Ágil — vs Caído', 'agile'),
      ('grant_swim_speed'::rpg.effect_kind, 23, 'Aquático — natação', 'aquatic'),
      ('combat_note'::rpg.effect_kind, 24, 'Aquático — fôlego', 'aquatic'),
      ('combat_note'::rpg.effect_kind, 25, 'Robusto — CA', 'sturdy'),
      ('carry_as_larger_size'::rpg.effect_kind, 26, 'Robusto — carga', 'sturdy')
  ) AS v(kind, sort_order, label, adaptation)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'prone' FROM ins WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'beastkin'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order IN (20, 21, 23, 24, 25)
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 20 THEN 'Deslocamento de Voo = Deslocamento; não voa com armadura Média/Pesada.'
    WHEN 21 THEN 'Deslocamento de Escalada = Deslocamento.'
    WHEN 23 THEN 'Deslocamento de Natação = Deslocamento.'
    WHEN 24 THEN 'Pode prender a respiração por até 20 minutos.'
    ELSE 'Sem armadura: CA = 13 + mod. Destreza.'
  END
FROM fx;

-- Giantkin
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'giantkin-burning-blood'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 10, 'Sangue Ardente',
         'giantkinAncestryId', 'fire'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('carry_as_larger_size'::rpg.effect_kind, 11, 'Constituição Poderosa — carga'),
      ('save_advantage'::rpg.effect_kind, 12, 'Constituição Poderosa — Agarrado'),
      ('combat_note'::rpg.effect_kind, 13, 'Pegar e Arremessar')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id, NULL, 'grappled' FROM ins WHERE kind = 'save_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'combat_note' AND e.sort_order = 13
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Reação ao ser atingido por arma à distância: +3 CA; se errar, pode arremessar de volta.'
FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
env AS (
  SELECT * FROM (VALUES
    ('cloud', 'extreme_cold'::rpg.effect_env_hazard, 20),
    ('cloud', 'high_altitude'::rpg.effect_env_hazard, 21),
    ('fire', 'extreme_heat'::rpg.effect_env_hazard, 22),
    ('frost', 'extreme_cold'::rpg.effect_env_hazard, 23),
    ('frost', 'snow_blindness'::rpg.effect_env_hazard, 24),
    ('storm', 'high_altitude'::rpg.effect_env_hazard, 25),
    ('storm', 'snow_blindness'::rpg.effect_env_hazard, 26)
  ) AS v(ancestry, hazard, sort_order)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'environmental_immunity'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, e.sort_order,
         'Imunidade ambiental — ' || e.hazard::text, 'giantkinAncestryId', e.ancestry
  FROM species CROSS JOIN env e
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_environmental_immunity (effect_id, hazard_slug)
SELECT ins.id, e.hazard
FROM ins JOIN env e ON e.sort_order = ins.sort_order;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
saves AS (
  SELECT * FROM (VALUES
    ('frost', 'stunned', 30),
    ('hill', 'poisoned', 31),
    ('hill', 'stunned', 32),
    ('stone', 'prone', 33),
    ('stone', 'petrified', 34)
  ) AS v(ancestry, cond, sort_order)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'save_advantage'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, s.sort_order,
         'Vantagem vs ' || s.cond, 'giantkinAncestryId', s.ancestry
  FROM species CROSS JOIN saves s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT ins.id, NULL, s.cond
FROM ins JOIN saves s ON s.sort_order = ins.sort_order;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
spells AS (
  SELECT * FROM (VALUES
    ('cloud', 'queda-suave', 40),
    ('storm', 'levitacao', 41)
  ) AS v(ancestry, spell_slug, sort_order)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, s.sort_order,
         'Ancestria — ' || s.spell_slug, 'giantkinAncestryId', s.ancestry
  FROM species CROSS JOIN spells s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, sp.id, NULL, CASE WHEN s.spell_slug = 'queda-suave' THEN 1 ELSE 2 END
FROM ins
JOIN spells s ON s.sort_order = ins.sort_order
JOIN rpg.phb_spell sp ON sp.slug = s.spell_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
    AND e.requires_option_key = 'giantkinAncestryId'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_sense'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 50, 'Visão no Escuro 18 m',
         'giantkinAncestryId', 'stone'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL FROM ins;

-- Trollkin
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 10, 'Visão no Escuro 36 m'),
      ('damage_die_override'::rpg.effect_kind, 11, 'Arma Natural'),
      ('combat_note'::rpg.effect_kind, 12, 'Regeneração Trollística')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 120, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d6'
FROM ins WHERE kind = 'damage_die_override';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
ins AS (
  SELECT e.id, e.sort_order
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ação Bônus: gastar DV até PB para curar. Ácido/Ígneo: perde acesso até Descanso Curto.'
FROM ins WHERE sort_order = 12;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'trollkin-fey-charm'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 20, 'Dado Fey',
         'trollkinAncestryId', 'fey'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label,
         'trollkinAncestryId', v.ancestry
  FROM species CROSS JOIN (
    VALUES
      ('save_advantage'::rpg.effect_kind, 30, 'Ogro — agarres', 'ogre', 'grappled'),
      ('carry_as_larger_size'::rpg.effect_kind, 31, 'Ogro — carga', 'ogre', NULL),
      ('save_advantage'::rpg.effect_kind, 32, 'Troll — Atordoado', 'troll', 'stunned'),
      ('carry_as_larger_size'::rpg.effect_kind, 33, 'Troll — carga', 'troll', NULL)
  ) AS v(kind, sort_order, label, ancestry, cond)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_save_advantage (effect_id, ability_slugs, condition_slug)
SELECT id,
  NULL,
  CASE sort_order WHEN 30 THEN 'grappled' WHEN 32 THEN 'stunned' ELSE NULL END
FROM ins WHERE kind = 'save_advantage';

-- Werekin
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 'passive', 10, 'Visão no Escuro 18 m'),
      ('damage_die_override'::rpg.effect_kind, 'passive', 11, 'Garras'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 12, 'Proeza Predatória'),
      ('check_advantage'::rpg.effect_kind, 'passive', 13, 'Faro')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d6'
FROM ins WHERE kind = 'damage_die_override';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id, 'werekin_prowess', 'skill'::rpg.effect_proficiency_kind
FROM ins WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_check_advantage (effect_id, skill_slug, circumstance_tag, ability_slug)
SELECT id, 'perception', 'scent_track', NULL
FROM ins WHERE kind = 'check_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'werekin-shift-aspect'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, 20, 'Mudar Aspecto'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 21, 'Mudar Aspecto — modos'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ação Bônus 1 min / DL: Força Bestial (PV temp 2×PB + Vant. Força/Agarrado); Selvageria (rugido); Caçador (+3 m + Vant. Atletismo/Sobrevivência).'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Manikin / Scourgeborne (SEH)
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('damage_resistance'::rpg.effect_kind, 10, 'Coração Elétrico'),
      ('rest_quirk'::rpg.effect_kind, 11, 'Material Vivo'),
      ('combat_note'::rpg.effect_kind, 12, 'Nascido para Servir'),
      ('combat_note'::rpg.effect_kind, 13, 'Placas de Ouro')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_damage_type (effect_id, damage_type_slug, option_key)
SELECT id, 'lightning', NULL FROM ins WHERE kind = 'damage_resistance';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_rest_quirk (
  effect_id, long_rest_hours, no_sleep, magic_cannot_force_sleep, no_food_drink_air
)
SELECT id, 8, FALSE, FALSE, TRUE FROM ins WHERE kind = 'rest_quirk';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order IN (11, 12, 13)
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 11 THEN 'Sem comida/bebida/ar; imune à condição Envenenado.'
    WHEN 12 THEN 'Desvantagem em Sabedoria (Intuição).'
    ELSE 'Sem benefício de CA por armadura; Escudo aplica normalmente. Preset via armorPresetId.'
  END
FROM fx;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
rows AS (
  SELECT * FROM (VALUES
    ('manikin-custodian-intercept', 'custodian', 20, 'proficiency_bonus'::rpg.resource_max_formula, NULL::int, FALSE, TRUE, 'Intercepção do Custódio'),
    ('manikin-thespian-bond', 'thespian', 21, 'fixed'::rpg.resource_max_formula, 1, TRUE, TRUE, 'Conexão Teatral')
  ) AS v(resource_slug, model, sort_order, max_formula, fixed_max, recover_sr, recover_lr, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, 1, r.sort_order, r.label,
         'serviceModelId', r.model
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, r.recover_sr, r.recover_lr
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
JOIN rpg.phb_resource_definition rd ON rd.slug = r.resource_slug;

-- Scourgeborne
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 10, 'Maldição Eldritch'),
      ('damage_die_override'::rpg.effect_kind, 11, 'Membros Ferais')
  ) AS v(kind, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Imune a magias que alterariam sua forma (Alterar-se, Polimorfar, etc.).'
FROM ins WHERE sort_order = 10;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
ins AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d6'
FROM ins WHERE kind = 'damage_die_override';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'scourgeborne-lineage'),
rows AS (
  SELECT * FROM (VALUES
    (3, 20, 'fixed'::rpg.resource_max_formula, 1, FALSE, 'Linhagem Monstruosa L3'),
    (5, 21, 'proficiency_bonus'::rpg.resource_max_formula, NULL::int, TRUE, 'Linhagem Monstruosa L5')
  ) AS v(unlock_level, sort_order, max_formula, fixed_max, recover_sr, label)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, r.unlock_level, r.sort_order, r.label
  FROM species CROSS JOIN rows r
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, r.max_formula, r.fixed_max, FALSE, r.recover_sr, TRUE
FROM ins
JOIN rows r ON r.sort_order = ins.sort_order
CROSS JOIN rd;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'passive'::rpg.effect_trigger, 1, 22, 'Linhagem Monstruosa'
  FROM species RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Benefícios por monstrousLineageId (aranea/belua/cervus/vespertilio) nos níveis 1/3/5 — ver option_value.'
FROM ins;

-- ═══════════════════════════════════════════════════════════════════════════
-- Feathren (Griffon's Saddlebag)
-- ═══════════════════════════════════════════════════════════════════════════

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'species'::rpg.effect_owner_kind, species.id,
         v.trigger::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM species CROSS JOIN (
    VALUES
      ('grant_sense'::rpg.effect_kind, 'passive', 10, 'Visão no Escuro 18 m'),
      ('spellcasting_ability'::rpg.effect_kind, 'on_build', 11, 'Atributo de conjuração'),
      ('check_advantage'::rpg.effect_kind, 'passive', 12, 'Fala Fraterna'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 13, 'Criador Natural 1'),
      ('grant_proficiency'::rpg.effect_kind, 'on_build', 14, 'Criador Natural 2'),
      ('damage_die_override'::rpg.effect_kind, 'passive', 15, 'Garras')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, kind, sort_order
)
INSERT INTO rpg.phb_effect_sense (effect_id, sense_slug, range_ft, duration_minutes)
SELECT id, 'darkvision'::rpg.effect_sense_slug, 60, NULL
FROM ins WHERE kind = 'grant_sense';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
fx AS (
  SELECT e.id, e.kind, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.sort_order BETWEEN 11 AND 15
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Escolher INT, SAB ou CAR (magias da Ancestria Feathren).'
FROM fx WHERE kind = 'spellcasting_ability';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_check_advantage (effect_id, skill_slug, circumstance_tag, ability_slug)
SELECT id, 'animal-handling', 'avian_feline', NULL
FROM fx WHERE kind = 'check_advantage';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
fx AS (
  SELECT e.id, e.kind, e.sort_order
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_proficiency (effect_id, option_key, proficiency_kind)
SELECT id,
  CASE sort_order WHEN 13 THEN 'feathren_tool_1' ELSE 'feathren_tool_2' END,
  'tool'::rpg.effect_proficiency_kind
FROM fx WHERE kind = 'grant_proficiency';

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
fx AS (
  SELECT e.id, e.kind
  FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species'
)
INSERT INTO rpg.phb_effect_damage_die (effect_id, applies_to, die)
SELECT id, 'unarmed'::rpg.effect_damage_applies_to, '1d6'
FROM fx WHERE kind = 'damage_die_override';

-- Magias fixas Identificar / Aprimorar + por option aviária/felina
WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
spells AS (
  SELECT * FROM (VALUES
    (NULL::text, NULL::text, 'identificar', 1, 20, 1),
    (NULL::text, NULL::text, 'aprimorar-atributo', 5, 21, 2),
    ('feathrenAvianAncestryId', 'jay-owl-raven', 'taumaturgia', 1, 30, 0),
    ('feathrenAvianAncestryId', 'eagle-falcon-hawk', 'mensagem', 1, 31, 0),
    ('feathrenAvianAncestryId', 'cardinal-mockingbird-parrot', 'prestidigitacao-arcana', 1, 32, 0),
    ('feathrenFelineAncestryId', 'lion-panther-saber', 'detectar-o-bem-e-o-mal', 3, 33, 1),
    ('feathrenFelineAncestryId', 'cheetah-serval-tiger', 'detectar-veneno-e-doenca', 3, 34, 1),
    ('feathrenFelineAncestryId', 'jaguar-lynx-snow-leopard', 'detectar-magia', 3, 35, 1)
  ) AS v(opt_key, opt_val, spell_slug, unlock_level, sort_order, spell_level)
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'grant_spell'::rpg.effect_kind, 'species'::rpg.effect_owner_kind, species.id,
         'on_build'::rpg.effect_trigger, s.unlock_level, s.sort_order,
         'Feathren — ' || s.spell_slug, s.opt_key, s.opt_val
  FROM species CROSS JOIN spells s
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, spell_id, option_key, spell_level)
SELECT ins.id, sp.id, NULL, s.spell_level
FROM ins
JOIN spells s ON s.sort_order = ins.sort_order
JOIN rpg.phb_spell sp ON sp.slug = s.spell_slug;

WITH species AS (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
fx AS (
  SELECT e.id, e.sort_order FROM rpg.phb_effect e
  JOIN species ON species.id = e.owner_id
  WHERE e.owner_kind = 'species' AND e.kind = 'grant_spell'
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id,
  CASE WHEN sort_order BETWEEN 30 AND 32 THEN 'at_will'::rpg.effect_cast_economy
       ELSE 'once_per_long_rest'::rpg.effect_cast_economy END,
  'fixed'::rpg.effect_uses_formula,
  CASE WHEN sort_order BETWEEN 30 AND 32 THEN NULL ELSE 1 END
FROM fx;

-- ═══════════════════════════════════════════════════════════════════════════
-- Aposentar legado species (HP anão + resource grants migrados — tabelas DROP)
-- ═══════════════════════════════════════════════════════════════════════════

SELECT 1;
