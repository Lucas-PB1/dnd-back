-- Grim Hollow Cap. 2 — prepared spells

-- eldritch-domain L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'eldritch-domain' AND sp.slug IN (
  'detectar-pensamentos', 'riso-histerico-de-tasha', 'ver-o-invisivel', 'sono'
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
  'criacao', 'santificar'
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
  'medo'
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
  'coluna-de-chamas', 'imobilizar-monstro'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- circleof-blood L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'circleof-blood' AND sp.slug IN (
  'dominar-pessoa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'ruina', 'causar-ferimentos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'flecha-acida-de-melf', 'raio-de-enfraquecimento'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'nuvem-fetida'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-pestilence L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-pestilence' AND sp.slug IN (
  'pustula', 'confusao'
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
  'causar-ferimentos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'estilhacar'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'medo'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-slaughter L17
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 17, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-slaughter' AND sp.slug IN (
  'onda-destrutiva'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'detectar-o-bem-e-o-mal'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- oathof-zeal L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'oathof-zeal' AND sp.slug IN (
  'detectar-pensamentos', 'abrir'
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
  'adivinhacao', 'localizar-criatura'
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
  'imobilizar-pessoa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- green-reaper L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'green-reaper' AND sp.slug IN (
  'impor-maldicao'
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

-- primordial-archer L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'primordial-archer' AND sp.slug IN (
  'rogar-maldicao'
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
  'evocar-raio'
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

-- vermin-lord L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'mensageiro-animal'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- vermin-lord L13
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 13, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'vermin-lord' AND sp.slug IN (
  'liberdade-de-movimento'
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
  'augurio', 'compreender-idiomas', 'revide-infernal', 'raio-de-enfraquecimento'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- apocalypse-sorcery L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'apocalypse-sorcery' AND sp.slug IN (
  'impor-maldicao', 'reviver'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- apocalypse-sorcery L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'apocalypse-sorcery' AND sp.slug IN (
  'banimento', 'adivinhacao'
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
  'ruina', 'toque-arrepiante', 'invisibilidade', 'ver-o-invisivel', 'servo-invisivel'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'voar', 'falar-com-os-mortos'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'invisibilidade-maior'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- haunted-sorcery L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'haunted-sorcery' AND sp.slug IN (
  'telecinese'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'imobilizar-pessoa', 'identificar', 'localizar-objeto', 'raio-de-doenca'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-coven L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-coven' AND sp.slug IN (
  'impor-maldicao', 'contramagia'
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
  'adivinhacao', 'localizar-criatura'
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
  'ruina', 'mandar', 'vida-falsa', 'nuvem-de-nevoa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L5
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'forma-gasosa'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L7
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 7, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'dominar-pessoa', 'aparencia'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- the-first-vampire-patron L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'the-first-vampire-patron' AND sp.slug IN (
  'telecinese'
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

-- daemonologist L3
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'ruina', 'badalar-os-mortos'
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

-- daemonologist L9
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 9, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'daemonologist' AND sp.slug IN (
  'geas'
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
  'reviver'
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

