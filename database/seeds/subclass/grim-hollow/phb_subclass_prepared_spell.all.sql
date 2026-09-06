-- Grim Hollow Cap. 2 — prepared spells
-- Gerado por generate-ghpg-cap2-seeds.mjs (spellTables + CURATED_SPELL_GRANTS)

-- eldritch-domain L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'eldritch-domain' AND sp.slug IN (
  'detectar-pensamentos', 'gargalhada-nefasta-de-tasha', 'ver-o-invisivel', 'sono'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- eldritch-domain L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'eldritch-domain' AND sp.slug IN (
  'medo', 'linguas'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- eldritch-domain L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'eldritch-domain' AND sp.slug IN (
  'confusao', 'assassino-fantasmagorico'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- eldritch-domain L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'eldritch-domain' AND sp.slug IN (
  'contato-extraplanar', 'sonho'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- inquisition-domain L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'inquisition-domain' AND sp.slug IN (
  'ver-o-invisivel', 'silencio'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- inquisition-domain L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'inquisition-domain' AND sp.slug IN (
  'dissipar-magia', 'remover-maldicao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- inquisition-domain L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'inquisition-domain' AND sp.slug IN (
  'olho-arcano', 'localizar-criatura'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- inquisition-domain L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'inquisition-domain' AND sp.slug IN (
  'criacao', 'consagrar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- purification-domain L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'purification-domain' AND sp.slug IN (
  'detectar-veneno-e-doenca', 'lamina-flamejante'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- purification-domain L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'purification-domain' AND sp.slug IN (
  'medo', 'flash-fever'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- purification-domain L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'purification-domain' AND sp.slug IN (
  'aura-de-pureza', 'muralha-de-fogo'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- purification-domain L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'purification-domain' AND sp.slug IN (
  'coluna-de-chamas', 'paralisar-monstro'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- circleof-blood L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circleof-blood' AND sp.slug IN (
  'blood-rush', 'crimson-lash', 'sense-lifeblood'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- circleof-blood L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circleof-blood' AND sp.slug IN (
  'blood-bond', 'sanguine-poppet'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- circleof-blood L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circleof-blood' AND sp.slug IN (
  'circle-of-scarlet', 'dark-sacrament'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- circleof-blood L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circleof-blood' AND sp.slug IN (
  'dominar-pessoa', 'mortality'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'perdicao', 'infligir-ferimentos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'flecha-acida-de-melf', 'raio-do-enfraquecimento'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'flash-fever', 'nuvem-fetida'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'malogro', 'confusao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'contagio', 'praga-de-insetos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'crimson-lash', 'infligir-ferimentos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'bloodletter', 'despedacar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'medo', 'suffocate'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'consume-mind', 'supernal-smite'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'onda-destrutiva', 'incite-riot'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'detectar-o-bem-e-o-mal', 'marca-do-predador'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'detectar-pensamentos', 'arrombar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'medo', 'linguas'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'pressagio', 'localizar-criatura'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'praga-de-insetos', 'videncia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- green-reaper L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'green-reaper' AND sp.slug IN (
  'detectar-veneno-e-doenca'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- green-reaper L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'green-reaper' AND sp.slug IN (
  'paralisar-pessoa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- green-reaper L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'green-reaper' AND sp.slug IN (
  'rogar-maldicao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- green-reaper L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'green-reaper' AND sp.slug IN (
  'invisibilidade-maior'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- green-reaper L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'green-reaper' AND sp.slug IN (
  'nevoa-mortal'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- primordial-archer L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'primordial-archer' AND sp.slug IN (
  'danacao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- primordial-archer L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'primordial-archer' AND sp.slug IN (
  'cegueira-surdez'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- primordial-archer L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'primordial-archer' AND sp.slug IN (
  'convocar-relampagos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- primordial-archer L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'primordial-archer' AND sp.slug IN (
  'metamorfose'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- primordial-archer L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'primordial-archer' AND sp.slug IN (
  'muralha-de-pedra'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- vermin-lord L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'consumption'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- vermin-lord L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'mensageiro-animal'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- vermin-lord L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'flash-fever'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- vermin-lord L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'movimentacao-livre'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- vermin-lord L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'contagio'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- apocalypse-sorcery L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'apocalypse-sorcery' AND sp.slug IN (
  'augurio', 'compreender-idiomas', 'repreensao-diabolica', 'raio-do-enfraquecimento'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- apocalypse-sorcery L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'apocalypse-sorcery' AND sp.slug IN (
  'rogar-maldicao', 'revivificar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- apocalypse-sorcery L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'apocalypse-sorcery' AND sp.slug IN (
  'banimento', 'pressagio'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- apocalypse-sorcery L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'apocalypse-sorcery' AND sp.slug IN (
  'contagio', 'praga-de-insetos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'perdicao', 'toque-necrotico', 'invisibilidade', 'ver-o-invisivel', 'servo-invisivel'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'voo', 'falar-com-mortos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'protecao-contra-a-morte', 'invisibilidade-maior'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'little-death', 'telecinese'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'paralisar-pessoa', 'identificar', 'localizar-objeto', 'raio-nauseante'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'rogar-maldicao', 'contramagia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'assassino-fantasmagorico', 'metamorfose'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'pressagio', 'localizar-criatura'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'contato-extraplanar', 'videncia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'perdicao', 'comando', 'vitalidade-vazia', 'nevoa-obscurecente'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'invocar-animais', 'forma-gasosa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'dominar-pessoa', 'similaridade'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'little-death', 'telecinese'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'perdicao', 'badalar-funebre'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'medo'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'dark-sacrament'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'missao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'auxilio', 'bencao', 'palavra-de-radiancia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'revivificar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'guardiao-da-fe'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'restauracao-maior'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- Grants curated (prosa Cap.2 sem spellTables)

-- occultist-guild L15
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 15, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'occultist-guild' AND sp.slug IN (
  'contramagia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- collegeof-fools L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'collegeof-fools' AND sp.slug IN (
  'sussurros-dissonantes', 'zombaria-perversa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- collegeof-requiems L6
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 6, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'collegeof-requiems' AND sp.slug IN (
  'animar-mortos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- pathofthe-primal-spirit L6
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 6, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'pathofthe-primal-spirit' AND sp.slug IN (
  'amizade-animal', 'falar-com-animais'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- pathofthe-wrathful-dead L10
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 10, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'pathofthe-wrathful-dead' AND sp.slug IN (
  'curar-ferimentos', 'reviver-os-mortos', 'revivificar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- highway-rider L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'highway-rider' AND sp.slug IN (
  'convocar-montaria'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- wretched-bloodline-sorcery L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'wretched-bloodline-sorcery' AND sp.slug IN (
  'detectar-o-bem-e-o-mal'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- wretched-bloodline-sorcery L6
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 6, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'wretched-bloodline-sorcery' AND sp.slug IN (
  'rogar-maldicao'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-parasite-patron L10
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 10, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-parasite-patron' AND sp.slug IN (
  'dominar-pessoa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- warriorofthe-leaden-crown L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'warriorofthe-leaden-crown' AND sp.slug IN (
  'maos-magicas', 'detectar-o-bem-e-o-mal', 'protecao-contra-o-bem-e-o-mal', 'paralisar-pessoa', 'levitacao', 'despedacar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- warriorofthe-leaden-crown L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'warriorofthe-leaden-crown' AND sp.slug IN (
  'dissipar-o-bem-e-o-mal', 'paralisar-monstro', 'telecinese', 'muralha-de-energia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

