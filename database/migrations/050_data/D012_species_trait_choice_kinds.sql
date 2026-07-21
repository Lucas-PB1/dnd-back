-- Escolhas de traço das demais espécies PHB 2024 (gnome, golias, elfo, tiferino, aasimar)
-- Também reaplica o humano (idempotente) para sobreviver a re-seed sem re-rodar D001.

INSERT INTO rpg.phb_gnome_lineage (slug, name, level1_benefit)
VALUES
  (
    'rock-gnome',
    'Gnomo das Rochas',
    'Você conhece os truques Prestidigitação Arcana e Reparar. Além disso, pode fabricar dispositivos mecânicos minúsculos com Prestidigitação Arcana.'
  ),
  (
    'forest-gnome',
    'Gnomo do Bosque',
    'Você conhece o truque Ilusão Menor. Você também sempre tem a magia Falar com Animais preparada.'
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  level1_benefit = EXCLUDED.level1_benefit;

INSERT INTO rpg.phb_giant_ancestry (slug, name, benefit)
VALUES
  (
    'ice',
    'Arrepio do Gelo',
    'Ao atingir um alvo com uma jogada de ataque e causar dano a ele, você também pode infligir 1d6 pontos de dano Gélido a esse alvo e reduzir o Deslocamento dele em 3 metros até o início do seu próximo turno.'
  ),
  (
    'fire',
    'Queimadura de Fogo',
    'Ao atingir um alvo com uma jogada de ataque e causar dano a ele, você também pode causar 1d10 pontos de dano Ígneo a esse alvo.'
  ),
  (
    'stone',
    'Resistência da Pedra',
    'Ao sofrer dano, pode executar uma Reação para jogar 1d12. Adicione seu modificador de Constituição ao número obtido e reduza o dano desse total.'
  ),
  (
    'cloud',
    'Salto da Nuvem',
    'Como uma Ação Bônus, você se teleporta magicamente até 9 metros para um espaço desocupado à sua vista.'
  ),
  (
    'hill',
    'Tombo da Colina',
    'Ao atingir uma criatura Grande ou menor com uma jogada de ataque e causar dano a ela, você pode impor a esse alvo a condição Caído.'
  ),
  (
    'storm',
    'Trovão da Tempestade',
    'Ao sofrer dano de uma criatura a até 18 metros de você, você pode executar uma Reação para causar 1d8 pontos de dano Trovejante a essa criatura.'
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  benefit = EXCLUDED.benefit;

-- Gnomo
UPDATE rpg.phb_species_trait t
SET choice_kind = 'gnome_lineage'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'gnome'
  AND t.name = 'Linhagem Gnômica';

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Atributo de conjuração',
  'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração das magias da Linhagem Gnômica.',
  'gnome_casting_ability'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'gnome'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Golias
UPDATE rpg.phb_species_trait t
SET choice_kind = 'giant_ancestry'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'goliath'
  AND t.name = 'Ancestralidade Gigante';

-- Elfo
UPDATE rpg.phb_species_trait t
SET choice_kind = 'elf_keen_senses'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'elf'
  AND t.name = 'Sentidos Aguçados';

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Atributo de conjuração',
  'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração das magias da Linhagem Élfica.',
  'elf_casting_ability'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'elf'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Tiferino
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Atributo de conjuração',
  'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração do Legado Ínfero e da Presença Sobrenatural.',
  'infernal_casting_ability'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'tiefling'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Tamanho',
  'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
  'tiefling_size'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'tiefling'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Aasimar (tamanho na criação; Revelação Celestial é escolhida a cada transformação no nv. 3)
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Tamanho',
  'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
  'aasimar_size'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'aasimar'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Humano (reaplica D001 — necessário após truncate/seed)
UPDATE rpg.phb_species_trait t
SET choice_kind = 'human_skill'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'human'
  AND t.name = 'Hábil';

UPDATE rpg.phb_species_trait t
SET choice_kind = 'human_origin_feat'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.id = t.species_id
  AND sp.slug = 'human'
  AND t.name = 'Versátil';

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
SELECT
  sp.id,
  'Tamanho',
  'Escolha Médio ou Pequeno ao selecionar esta espécie (PHB 2024).',
  'human_size'::rpg.species_choice_kind
FROM rpg.phb_species sp
WHERE sp.slug = 'human'
ON CONFLICT (species_id, name) DO UPDATE
SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
