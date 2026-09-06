-- Prepared spells — Griffon's Saddlebag Part II (domínios, juramentos, círculos, patronos)

-- astral-domain
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-domain' AND sp.slug IN (
  'embacar', 'raio-guia', 'invisibilidade', 'passos-largos', 'fagulha-estelar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-domain' AND sp.slug IN (
  'piscar', 'lentidao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-domain' AND sp.slug IN (
  'banimento', 'porta-dimensional'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-domain' AND sp.slug IN (
  'circulo-de-teleporte', 'muralha-de-energia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-unbroken-circle
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-unbroken-circle' AND sp.slug IN (
  'golpe-constritor', 'bordao-mistico', 'destruicao-radiante', 'golpe-certeiro'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-unbroken-circle' AND sp.slug IN (
  'celeridade'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-unbroken-circle' AND sp.slug IN (
  'escudo-ardente'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-unbroken-circle' AND sp.slug IN (
  'coluna-de-chamas'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oath-of-the-hearth
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-hearth' AND sp.slug IN (
  'maos-flamejantes', 'convocar-familiar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-hearth' AND sp.slug IN (
  'auxilio', 'chama-continua'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-hearth' AND sp.slug IN (
  'sinal-de-esperanca', 'luz-do-dia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-hearth' AND sp.slug IN (
  'escudo-ardente', 'guardioes-espirituais'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oath-of-the-hearth' AND sp.slug IN (
  'coluna-de-chamas', 'ligacao-telepatica-de-rary'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- winter-trapper
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'winter-trapper' AND sp.slug IN (
  'faca-de-gelo'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'winter-trapper' AND sp.slug IN (
  'reflexos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'winter-trapper' AND sp.slug IN (
  'nevasca'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'winter-trapper' AND sp.slug IN (
  'terreno-alucinatorio'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'winter-trapper' AND sp.slug IN (
  'paralisar-monstro'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- frost-sorcery
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'frost-sorcery' AND sp.slug IN (
  'cegueira-surdez', 'faca-de-gelo', 'passo-nebuloso', 'sono'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'frost-sorcery' AND sp.slug IN (
  'nevasca', 'lentidao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'frost-sorcery' AND sp.slug IN (
  'escudo-ardente', 'tempestade-glacial'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'frost-sorcery' AND sp.slug IN (
  'cone-de-frio', 'invocar-elemental'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- astral-griffon-patron
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-griffon-patron' AND sp.slug IN (
  'identificar', 'localizar-objeto', 'misseis-magicos', 'corda-extradimensional'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-griffon-patron' AND sp.slug IN (
  'piscar', 'clarividencia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-griffon-patron' AND sp.slug IN (
  'santuario-particular-de-mordenkainen', 'arca-secreta-de-leomund'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'astral-griffon-patron' AND sp.slug IN (
  'lendas-e-historias', 'criar-passagem'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

