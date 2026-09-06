-- Prepared spells — Northlands Heroes of the Sagas

-- Skald: Zombaria Perversa sempre preparada (grant de truque)
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'skald' AND sp.slug = 'zombaria-perversa'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Nornbound
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'nornbound' AND sp.slug IN (
  'augurio', 'perdicao', 'bencao', 'vinculo-de-protecao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'nornbound' AND sp.slug IN (
  'rogar-maldicao', 'contramagia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'nornbound' AND sp.slug IN (
  'protecao-contra-a-morte', 'pressagio'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'nornbound' AND sp.slug IN (
  'comunhao', 'modificar-memoria'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Circle of Fenris (Conjure Animals → invocar-animais)
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-fenris' AND sp.slug IN (
  'sentido-feral', 'aprimorar-atributo', 'golpe-constritor', 'marca-do-predador'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-fenris' AND sp.slug IN (
  'invocar-animais', 'medo'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-fenris' AND sp.slug = 'dominar-fera'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circle-of-fenris' AND sp.slug = 'comunhao-com-a-natureza'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Oath of Valhalla
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-valhalla' AND sp.slug IN (
  'heroismo', 'destruicao-cauterizante'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-valhalla' AND sp.slug IN (
  'repouso-tranquilo', 'destruicao-radiante'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-valhalla' AND sp.slug IN (
  'sinal-de-esperanca', 'glifo-de-protecao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-valhalla' AND sp.slug IN (
  'aura-de-pureza', 'defensor-da-fe'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-valhalla' AND sp.slug IN (
  'coluna-de-chamas', 'consagrar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Spirit Caller
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'spirit-caller' AND sp.slug IN (
  'perdicao', 'bencao', 'heroismo', 'protecao-contra-o-bem-e-o-mal'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'spirit-caller' AND sp.slug = 'augurio'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'spirit-caller' AND sp.slug IN (
  'falar-com-mortos', 'guardioes-espirituais'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'spirit-caller' AND sp.slug IN (
  'aura-de-vida', 'protecao-contra-a-morte'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Trickster
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'trickster' AND sp.slug IN (
  'detectar-pensamentos', 'disfarcar-se', 'aumentar-reduzir', 'boca-encantada', 'imagem-silenciosa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'trickster' AND sp.slug IN (
  'indetectavel', 'lentidao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'trickster' AND sp.slug IN (
  'compulsao', 'confusao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'trickster' AND sp.slug IN (
  'animar-objetos', 'modificar-memoria'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
