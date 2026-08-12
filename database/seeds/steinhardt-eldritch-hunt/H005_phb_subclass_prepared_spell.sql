-- Prepared spells — Circle of Symbiosis + Oath of the Eldritch Hunt + Blade of Radiance (L13)

-- Circle of Symbiosis
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-symbiosis' AND sp.slug IN (
  'arm-cannon', 'calcified-memories', 'fractured-shell', 'phalangeal-shot', 'bordao-mistico'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-symbiosis' AND sp.slug IN (
  'displacing-maw', 'osseous-impalement'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-symbiosis' AND sp.slug IN (
  'dread-scarecrow', 'maiden-of-bones'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-symbiosis' AND sp.slug IN (
  'forest-of-dread', 'passo-arboreo'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Oath of the Eldritch Hunt
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-eldritch-hunt' AND sp.slug IN (
  'fogo-das-fadas', 'spectral-slash'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-eldritch-hunt' AND sp.slug IN (
  'paralisar-pessoa', 'raio-lunar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-eldritch-hunt' AND sp.slug IN (
  'displacing-maw', 'spectral-fury'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-eldritch-hunt' AND sp.slug IN (
  'tentaculos-negros-de-evard', 'maiden-of-bones'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-eldritch-hunt' AND sp.slug IN (
  'contato-extraplanar', 'paralisar-monstro'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Blade of Radiance (Saintly Revelations)
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'blade-of-radiance' AND sp.slug IN (
  'heroismo', 'protecao-contra-o-bem-e-o-mal', 'escudo-da-fe'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
