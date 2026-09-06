-- Traços de espécie Eldritch Hunt

-- Manikin
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'Tamanho',
    'Escolha Pequeno (cerca de 0,60–1,20 m) ou Médio (cerca de 1,20–2,10 m) ao selecionar esta espécie.',
    'manikin_size'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'Nascido para Servir',
    'Manikins são feitos incapazes de odiar ou ressentir seus criadores. Essa falha de julgamento afeta você em todas as circunstâncias. Você tem Desvantagem em testes de Sabedoria (Intuição).',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'Coração Elétrico',
    'Você tem Resistência a dano Elétrico.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'Placas de Ouro Integradas',
    'Seu corpo tem camadas defensivas embutidas. Você não obtém benefício de CA por vestir armadura, mas se empunhar um Escudo, aplica o bônus normalmente. Ao selecionar esta espécie, escolha um dos presets de armadura.',
    'manikin_armor'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'Material Vivo',
    'Você não precisa comer, beber ou respirar e tem Imunidade à condição Envenenado.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'Modelo de Serviço',
    'Você foi criado para um propósito específico. Escolha um dos benefícios ao selecionar esta espécie.',
    'manikin_service_model'::rpg.species_choice_kind
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;

-- Scourgeborne
INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
    'Nascido da Loucura',
    'Seu corpo não é o que você nasceu, e sim consequência da exposição à loucura Eldritch. Você tem uma das opções a seguir conforme seu alinhamento (Bom ou Mau).',
    'scourgeborne_madness'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
    'Maldição Eldritch',
    'Sua maldição não é algo que mortais comuns possam desfazer. Você é imune a qualquer magia que alteraria sua forma, como Alterar-se ou Polimorfar.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
    'Membros Ferais',
    'Você pode usar chifres, garras ou presas da mutação para fazer Ataques Desarmados. Ao fazê-lo, causa dano Perfurante igual a 1d6 + seu modificador de Força em vez do dano normal do Ataque Desarmado. Se seu alinhamento for Mau, o lado feral é mais dominante e o dado sobe para d8.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'),
    'Linhagem Monstruosa',
    'Você faz parte de uma linhagem que concede habilidades sobrenaturais. Escolha uma linhagem na tabela Linhagens Monstruosas. Você obtém o benefício de nível 1 dessa linhagem. Nos níveis de personagem 3 e 5, obtém benefícios adicionais, conforme a tabela.',
    'scourgeborne_lineage'::rpg.species_choice_kind
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
