-- Quotas de props aleatórias + senciência fixa nos artefatos nomeados (+ Lunâmina).
-- Não editar D010: overlay idempotente em properties JSONB.

-- Demonômico de Iggwilv: 2 minB, 1 minD, 1 majD
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 2,
    "majorBeneficial": 0,
    "minorDetrimental": 1,
    "majorDetrimental": 1
  }
}'::jsonb
WHERE slug = 'demonomico-de-lggwilv';

-- Espada de Kas
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 1,
    "majorBeneficial": 1,
    "minorDetrimental": 1,
    "majorDetrimental": 1
  },
  "sentience": {
    "alignment": "CM",
    "inteligencia": 15,
    "sabedoria": 13,
    "carisma": 16,
    "senses": "audição e Visão no Escuro até 36 metros",
    "communication": "telepatia",
    "languages": ["Comum"],
    "purpose": "bane",
    "purposeSummary": "Trazer ruína a Vecna; destruir corrompidos pelo Olho e Mão de Vecna."
  }
}'::jsonb
WHERE slug = 'espada-de-kas';

-- Laminegra (só senciência)
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "sentience": {
    "alignment": "CN",
    "inteligencia": 17,
    "sabedoria": 10,
    "carisma": 19,
    "senses": "audição e visão no escuro até 36 metros",
    "communication": "fala+telepatia",
    "languages": ["Comum"],
    "purpose": "destroyer",
    "purposeSummary": "Consumir almas; acelerar o retorno ao vazio de energia negativa."
  }
}'::jsonb
WHERE slug = 'laminegra';

-- Livro das Trevas Profanas
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 3,
    "majorBeneficial": 1,
    "minorDetrimental": 3,
    "majorDetrimental": 2
  }
}'::jsonb
WHERE slug = 'livro-das-trevas-profanas';

-- Livro dos Feitos Sublimes
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 2,
    "majorBeneficial": 2,
    "minorDetrimental": 0,
    "majorDetrimental": 0
  }
}'::jsonb
WHERE slug = 'livro-dos-feitos-sublimes';

-- Machado dos Senhores Anões
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 2,
    "majorBeneficial": 1,
    "minorDetrimental": 2,
    "majorDetrimental": 0
  }
}'::jsonb
WHERE slug = 'machado-dos-senhores-anoes';

-- Olho e Mão de Vecna
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 1,
    "majorBeneficial": 1,
    "minorDetrimental": 1,
    "majorDetrimental": 0
  }
}'::jsonb
WHERE slug = 'olho-e-mao-de-vecna';

-- Onda
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "sentience": {
    "alignment": "N",
    "inteligencia": 14,
    "sabedoria": 10,
    "carisma": 18,
    "senses": "audição e Visão no Escuro até 36 metros",
    "communication": "telepatia",
    "languages": ["Aquan"],
    "purpose": "templar",
    "purposeSummary": "Incentivar adoração a deuses do mar."
  }
}'::jsonb
WHERE slug = 'onda';

-- Opressor
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "sentience": {
    "alignment": "ON",
    "inteligencia": 15,
    "sabedoria": 12,
    "carisma": 15,
    "senses": "audição e Visão no Escuro até 36 metros",
    "communication": "telepatia",
    "languages": ["Anão", "Gigante", "Goblin"],
    "purpose": "protector",
    "purposeSummary": "Proteger anões; retornar ao clã Dankil / Martelo Soberano."
  }
}'::jsonb
WHERE slug = 'opressor';

-- Orbes Dracônicos
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 2,
    "majorBeneficial": 0,
    "minorDetrimental": 1,
    "majorDetrimental": 1
  }
}'::jsonb
WHERE slug = 'orbes-draconicos';

-- Varinha de Orcus
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "artifactRandomQuota": {
    "minorBeneficial": 2,
    "majorBeneficial": 1,
    "minorDetrimental": 2,
    "majorDetrimental": 1
  },
  "sentience": {
    "alignment": "CM",
    "inteligencia": 16,
    "sabedoria": 12,
    "carisma": 16,
    "senses": "audição e Visão no Escuro até 36 metros",
    "communication": "telepatia",
    "languages": ["Abissal", "Comum"],
    "purpose": "destroyer",
    "purposeSummary": "Ajudar Orcus a matar tudo no multiverso."
  }
}'::jsonb
WHERE slug = 'varinha-de-orcus';

-- Lunâmina (lendária; senciência sem quota de artefato)
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "sentience": {
    "alignment": "creator",
    "inteligencia": 12,
    "sabedoria": 10,
    "carisma": 12,
    "senses": "audição e visão no escuro até 36 metros",
    "communication": "empatia",
    "languages": [],
    "purpose": "destiny_seeker",
    "purposeSummary": "Personalidade e alinhamento refletem o criador; só o escolhido deve empunhá-la."
  }
}'::jsonb
WHERE slug = 'lunamina';
