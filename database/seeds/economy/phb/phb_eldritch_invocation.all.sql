-- Invocações Místicas PHB 2024 (extraídas de S023 / Mestre Místico)

INSERT INTO rpg.phb_eldritch_invocation (
  slug, name, description, min_level, requires_pact_slug, requires_invocation_slug,
  repeatable, kind, granted_spell_slug, sort_order
) VALUES
(
  'pact-of-the-tome',
  'Pacto do Tomo',
  'Ao final de um Descanso Curto ou Longo, conjure um Livro das Sombras com 3 truques e 2 magias de 1º círculo com Ritual (de qualquer lista). O livro é Foco de Conjuração.',
  1, NULL, NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 10
),
(
  'pact-of-the-blade',
  'Pacto da Lâmina',
  'Ação Bônus: conjure ou vincule uma arma corpo a corpo. Use Carisma no ataque/dano; pode causar Necrótico, Psíquico ou Radiante.',
  1, NULL, NULL, false, 'bonus'::rpg.eldritch_invocation_kind, NULL, 20
),
(
  'pact-of-the-chain',
  'Pacto da Corrente',
  'Aprende Convocar Familiar e pode conjurá-la sem espaço. Formas especiais e o familiar pode atacar quando você renuncia a um ataque.',
  1, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'convocar-familiar', 30
),
(
  'armor-of-shadows',
  'Armadura de Sombras',
  'Você pode conjurar Armadura Arcana em si sem gastar um espaço de magia.',
  1, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'armadura-arcana', 40
),
(
  'eldritch-mind',
  'Mente Mística',
  'Você tem Vantagem em salvaguardas de Constituição para manter Concentração.',
  1, NULL, NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 50
),
(
  'agonizing-blast',
  'Explosão Agonizante',
  'Pré-requisito: nv. 2+, truque de Bruxo que cause dano. Adicione seu modificador de Carisma ao dano desse truque. Repetível (outro truque).',
  2, NULL, NULL, true, 'passive'::rpg.eldritch_invocation_kind, NULL, 60
),
(
  'repelling-blast',
  'Explosão Repulsiva',
  'Pré-requisito: nv. 2+, truque de Bruxo com ataque. Ao atingir criatura Grande ou menor, empurre-a até 3 m. Repetível.',
  2, NULL, NULL, true, 'passive'::rpg.eldritch_invocation_kind, NULL, 70
),
(
  'eldritch-spear',
  'Lança Mística',
  'Pré-requisito: nv. 2+, truque de dano com alcance ≥ 3 m. Alcance aumenta em 9 × nível de Bruxo metros. Repetível.',
  2, NULL, NULL, true, 'passive'::rpg.eldritch_invocation_kind, NULL, 80
),
(
  'lessons-of-the-first-ones',
  'Lições dos Primeiros',
  'Pré-requisito: nv. 2+. Obtém um talento de Origem à sua escolha. Repetível (outro talento).',
  2, NULL, NULL, true, 'note'::rpg.eldritch_invocation_kind, NULL, 90
),
(
  'mask-of-many-faces',
  'Máscara das Muitas Faces',
  'Você pode conjurar Disfarçar-se sem gastar um espaço de magia.',
  2, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'disfarcar-se', 100
),
(
  'misty-visions',
  'Visões Nebulosas',
  'Você pode conjurar Imagem Silenciosa sem gastar um espaço de magia.',
  2, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'imagem-silenciosa', 110
),
(
  'otherworldly-leap',
  'Salto Sobrenatural',
  'Você pode conjurar Salto em si sem gastar um espaço de magia.',
  2, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'salto', 120
),
(
  'fiendish-vigor',
  'Vigor Ínfero',
  'Você pode conjurar Vitalidade Vazia em si sem espaço; recebe o máximo de PV temporários no dado.',
  2, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'vitalidade-vazia', 130
),
(
  'devil-sight',
  'Visão Diabólica',
  'Você vê normalmente em Meia-luz e Escuridão (mágica ou não) a até 36 m.',
  2, NULL, NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 140
),
(
  'thirsting-blade',
  'Lâmina Sedenta',
  'Pré-requisitos: nv. 5+, Pacto da Lâmina. Ataque Extra só com a arma de pacto (dois ataques).',
  5, 'pact-of-the-blade', NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 150
),
(
  'investment-of-the-chain-master',
  'Investimento do Mestre da Corrente',
  'Pré-requisitos: nv. 5+, Pacto da Corrente. Familiar aprimorado (voo/natação, Atacar como BA, CD sua, dano N/R, Resistência via Reação).',
  5, 'pact-of-the-chain', NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 160
),
(
  'ascendant-step',
  'Passo Ascendente',
  'Você pode conjurar Levitação em si sem gastar um espaço de magia.',
  5, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'levitacao', 170
),
(
  'gift-of-the-depths',
  'Presente das Profundezas',
  'Respiração aquática e natação. Pode conjurar Respirar na Água 1× sem espaço (recarrega no Descanso Longo).',
  5, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'respirar-na-agua', 180
),
(
  'gaze-of-two-minds',
  'Olhar de Duas Mentes',
  'Ação Bônus: tocar criatura voluntária e perceber pelos sentidos dela; pode manter com BA e conjurar a partir do espaço dela (≤ 18 m).',
  5, NULL, NULL, false, 'bonus'::rpg.eldritch_invocation_kind, NULL, 190
),
(
  'master-of-myriad-forms',
  'Mestre das Infindáveis Formas',
  'Você pode conjurar Alterar-se sem gastar um espaço de magia.',
  5, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'alterar-se', 200
),
(
  'one-with-shadows',
  'Uno com as Sombras',
  'Em Meia-luz ou Escuridão, conjure Invisibilidade em si sem gastar espaço.',
  5, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'invisibilidade', 210
),
(
  'eldritch-smite',
  'Punição Mística',
  'Pré-requisitos: nv. 5+, Pacto da Lâmina. 1×/turno ao atingir com arma de pacto, gaste slot de Pacto para +1d8 Energético/círculo e pode derrubar (≤ Enorme).',
  5, 'pact-of-the-blade', NULL, false, 'note'::rpg.eldritch_invocation_kind, NULL, 220
),
(
  'grave-speeches',
  'Lamento das Sepulturas',
  'Você pode conjurar Falar com Mortos sem gastar um espaço de magia.',
  7, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'falar-com-mortos', 230
),
(
  'gift-of-the-protectors',
  'Presente dos Protetores',
  'Pré-requisitos: nv. 9+, Pacto do Tomo. Página com nomes (até CAR): ao cair a 0 PV, ficam com 1 PV (1×/DL).',
  9, 'pact-of-the-tome', NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 240
),
(
  'lifedrinker',
  'Sorvedouro de Vida',
  'Pré-requisitos: nv. 9+, Pacto da Lâmina. 1×/turno +1d6 N/P/R com arma de pacto; pode gastar Dado de PV para curar.',
  9, 'pact-of-the-blade', NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 250
),
(
  'visions-of-distant-realms',
  'Visões de Reinos Distantes',
  'Você pode conjurar Olho Arcano sem gastar um espaço de magia.',
  9, NULL, NULL, false, 'free_cast'::rpg.eldritch_invocation_kind, 'olho-arcano', 260
),
(
  'devouring-blade',
  'Lâmina Devoradora',
  'Pré-requisitos: nv. 12+, Lâmina Sedenta. O Ataque Extra concede dois ataques extras em vez de um.',
  12, NULL, 'thirsting-blade', false, 'passive'::rpg.eldritch_invocation_kind, NULL, 270
),
(
  'witch-sight',
  'Visão da Bruxa',
  'Você tem Visão Verdadeira com alcance de 9 metros.',
  15, NULL, NULL, false, 'passive'::rpg.eldritch_invocation_kind, NULL, 280
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  min_level = EXCLUDED.min_level,
  requires_pact_slug = EXCLUDED.requires_pact_slug,
  requires_invocation_slug = EXCLUDED.requires_invocation_slug,
  repeatable = EXCLUDED.repeatable,
  kind = EXCLUDED.kind,
  granted_spell_slug = EXCLUDED.granted_spell_slug,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();
