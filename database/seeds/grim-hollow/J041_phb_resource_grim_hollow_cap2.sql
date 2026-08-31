-- Recursos tipados — Grim Hollow Cap. 2 (Fase B, 17 subclasses resource-prose-only)
-- Gerado por scripts/generate-gh-cap2-phase-b-resources.mjs
-- Padrão: J030 / R011. feature_id via nome exato J028.

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES
  (
    'beast-kinship',
    'Parentesco a Feras',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    6
  ),
  (
    'skinrider-trance',
    'Transe do Cavaleiro da Pele',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    10
  ),
  (
    'shape-of-the-wild',
    'Forma do Selvagem',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    14
  ),
  (
    'gallows-humor',
    'Humor da Forca',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
    6
  ),
  (
    'last-laugh',
    'Última Risada',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
    14
  ),
  (
    'dual-death',
    'Dupla Morte',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
    14
  ),
  (
    'witch-hunters-strike',
    'Golpe do Caçador de Bruxas',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
    3
  ),
  (
    'rebuke-invoker',
    'Repreender Invocador',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
    6
  ),
  (
    'purify-with-fire',
    'Purificar com Fogo',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
    3
  ),
  (
    'blood-boon',
    'Dádiva de Sangue',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
    6
  ),
  (
    'exsanguinate',
    'Exsanguinar',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
    14
  ),
  (
    'shake-the-earth',
    'Sacudir a Terra',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
    10
  ),
  (
    'plaguebringer',
    'Portador da Peste',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
    20
  ),
  (
    'blood-knight',
    'Cavaleiro de Sangue',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
    20
  ),
  (
    'apocalyptic-revelation',
    'Revelação Apocalíptica',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
    20
  ),
  (
    'envenomed-attack',
    'Ataque Envenenado',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
    3
  ),
  (
    'poison-control',
    'Controle de Veneno',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
    7
  ),
  (
    'elemental-arrows',
    'Flechas Elementais',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
    3
  ),
  (
    'herbal-lore',
    'Conhecimento Herbal',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
    3
  ),
  (
    'primordial-magic',
    'Magia Primordial',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
    15
  ),
  (
    'verminkin',
    'Verminata',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
    3
  ),
  (
    'swarming-strikes',
    'Golpes do Enxame',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
    3
  ),
  (
    'steal-blood',
    'Roubar Sangue',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    3
  ),
  (
    'bloodstitch',
    'Costura Sangrenta',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    13
  ),
  (
    'bloody-exit',
    'Saída Sanguinária',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    17
  ),
  (
    'hags-eye',
    'Olho da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    3
  ),
  (
    'hags-guile',
    'Astúcia da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    6
  ),
  (
    'hags-visage',
    'Semblante da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    10
  ),
  (
    'hags-craft',
    'Ofício da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    14
  ),
  (
    'creature-of-the-night',
    'Criatura da Noite',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
    6
  ),
  (
    'eldritch-appetite',
    'Apetite Eldritch',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
    10
  ),
  (
    'eternal-night',
    'Eterna Noite',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
    14
  ),
  (
    'stolen-power',
    'Poder Roubado (Dados de Sangromancia)',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    3
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;


INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  6,
  'fixed'::rpg.resource_max_formula,
  2,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'beast-kinship'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Parentesco a Feras'
WHERE s.slug = 'pathofthe-primal-spirit'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  10,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'skinrider-trance'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Skinrider’s Trance'
WHERE s.slug = 'pathofthe-primal-spirit'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'shape-of-the-wild'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Forma de the Selvagem'
WHERE s.slug = 'pathofthe-primal-spirit'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  6,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'gallows-humor'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Forca Humor'
WHERE s.slug = 'collegeof-fools'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'last-laugh'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Última Risada'
WHERE s.slug = 'collegeof-fools'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'dual-death'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Dupla Morte'
WHERE s.slug = 'collegeof-requiems'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'witch-hunters-strike'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Bruxa Hunter’s Golpe'
WHERE s.slug = 'inquisition-domain'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  6,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'rebuke-invoker'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Repreender Invoker'
WHERE s.slug = 'inquisition-domain'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'proficiency_bonus'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'purify-with-fire'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Purificar Com Fogo'
WHERE s.slug = 'purification-domain'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  6,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  TRUE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'blood-boon'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Sangue Dádiva'
WHERE s.slug = 'circleof-blood'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'exsanguinate'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Exsanguinar'
WHERE s.slug = 'circleof-blood'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  10,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'shake-the-earth'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Sacudir the Terra'
WHERE s.slug = 'circleof-entropy'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'shake-the-earth'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Entropy’s Ápice'
WHERE s.slug = 'circleof-entropy'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  20,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'plaguebringer'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Portador da Peste'
WHERE s.slug = 'oathof-pestilence'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  20,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'blood-knight'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Sangue Cavaleiro'
WHERE s.slug = 'oathof-slaughter'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  20,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'apocalyptic-revelation'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Apocalíptica Revelação'
WHERE s.slug = 'oathof-zeal'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'envenomed-attack'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Envenenado Ataque'
WHERE s.slug = 'green-reaper'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  7,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'poison-control'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Veneno Controle'
WHERE s.slug = 'green-reaper'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'elemental-arrows'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Flechas Elementais'
WHERE s.slug = 'primordial-archer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'herbal-lore'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Herbal Conhecimento'
WHERE s.slug = 'primordial-archer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  15,
  'wisdom_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'primordial-magic'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Primordial Magic'
WHERE s.slug = 'primordial-archer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'verminkin'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Verminata'
WHERE s.slug = 'vermin-lord'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'proficiency_bonus'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'swarming-strikes'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Enxame Golpes'
WHERE s.slug = 'vermin-lord'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'intelligence_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'steal-blood'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubar Sangue'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  13,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bloodstitch'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Costura Sangrenta'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  17,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bloody-exit'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Sanguinário Saída'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'charisma_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'hags-eye'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Hag’s Olho'
WHERE s.slug = 'the-coven'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  6,
  'charisma_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  TRUE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'hags-guile'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Hag’s Astúcia'
WHERE s.slug = 'the-coven'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  10,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'hags-visage'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Hag’s Semblante'
WHERE s.slug = 'the-coven'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'hags-craft'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Hag’s Ofício'
WHERE s.slug = 'the-coven'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  6,
  'charisma_mod'::rpg.resource_max_formula,
  NULL,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'creature-of-the-night'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Criatura de the Noite'
WHERE s.slug = 'the-first-vampire-patron'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  10,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'eldritch-appetite'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Eldritch Appetite'
WHERE s.slug = 'the-first-vampire-patron'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  14,
  'fixed'::rpg.resource_max_formula,
  1,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'eternal-night'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Eterna Noite'
WHERE s.slug = 'the-first-vampire-patron'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Roubado Poder: máx. = dados de Furtivo (faixas fixed; sem enum sneak_attack)

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  3,
  'fixed'::rpg.resource_max_formula,
  2,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  5,
  'fixed'::rpg.resource_max_formula,
  3,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  7,
  'fixed'::rpg.resource_max_formula,
  4,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  9,
  'fixed'::rpg.resource_max_formula,
  5,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  11,
  'fixed'::rpg.resource_max_formula,
  6,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  13,
  'fixed'::rpg.resource_max_formula,
  7,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  15,
  'fixed'::rpg.resource_max_formula,
  8,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  17,
  'fixed'::rpg.resource_max_formula,
  9,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind,
  s.id,
  rd.id,
  19,
  'fixed'::rpg.resource_max_formula,
  10,
  sf.id,
  FALSE,
  FALSE,
  TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'stolen-power'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Roubado Poder'
WHERE s.slug = 'sanguine-thief'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
