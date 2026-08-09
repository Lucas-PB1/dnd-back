-- Economia + painel + recursos das subclasses de Mago (PHB 2024) — gaps L3–L14.
-- Roda após C009/C010 (ordem lexicográfica C014). Idempotente (ON CONFLICT).

-- ---------------------------------------------------------------------------
-- Recursos (1 uso)
-- ---------------------------------------------------------------------------
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  (
    'third-eye',
    'O Terceiro Olho',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
    10
  ),
  (
    'spectral-summon',
    'Criaturas Espectrais',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
    6
  ),
  (
    'illusory-self',
    'Autoimagem Ilusória',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
    10
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
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 10, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'third-eye'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'O Terceiro Olho'
WHERE s.slug = 'diviner'
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
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 6, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'spectral-summon'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Criaturas Espectrais'
WHERE s.slug = 'illusionist'
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
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 10, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'illusory-self'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Autoimagem Ilusória'
WHERE s.slug = 'illusionist'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- ---------------------------------------------------------------------------
-- Economia (aba Ações)
-- ---------------------------------------------------------------------------
INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'wizard-arcane-ward-recharge',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
  'Recarregar Proteção Arcana',
  'bonus'::rpg.action_economy_bucket,
  3,
  NULL,
  NULL,
  false,
  'Ação Bônus: gastar slot → Proteção recupera 2× círculo',
  'Como Ação Bônus, gaste um espaço de magia: a Proteção Arcana recupera Pontos de Vida iguais ao dobro do círculo do espaço gasto.',
  NULL,
  NULL,
  72
),
(
  'wizard-projected-ward',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
  'Proteção Projetada',
  'reaction'::rpg.action_economy_bucket,
  6,
  NULL,
  NULL,
  false,
  'Reação: sua Proteção absorve dano de aliado a até 9 m',
  'Quando uma criatura à sua vista a até 9 m sofrer dano, use sua Reação para que a Proteção Arcana absorva esse dano no lugar dela (conforme o texto da característica).',
  NULL,
  NULL,
  73
),
(
  'wizard-spell-breaker',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
  'Rompe-Magia (Dissipar)',
  'bonus'::rpg.action_economy_bucket,
  10,
  NULL,
  NULL,
  false,
  'Dissipar Magia como Ação Bônus (+PB no teste)',
  'Você sempre tem Contramagia e Dissipar Magia preparadas. Pode conjurar Dissipar Magia como Ação Bônus e soma o Bônus de Proficiência ao teste. Se Dissipar ou Contramagia falharem ao interromper uma magia, o espaço não é gasto.',
  NULL,
  NULL,
  74
),
(
  'wizard-third-eye',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
  'O Terceiro Olho',
  'bonus'::rpg.action_economy_bucket,
  10,
  'third-eye',
  NULL,
  true,
  'Ação Bônus: Compreensão / Ver o Invisível / Visão no Escuro',
  'Como Ação Bônus, escolha um benefício até o próximo descanso: Compreensão Superior (ler qualquer idioma), Ver o Invisível (sem espaço) ou Visão no Escuro 36 m. 1× por Descanso Curto ou Longo.',
  'spend-resource',
  NULL,
  75
),
(
  'wizard-spectral-summon',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
  'Criaturas Espectrais',
  'action'::rpg.action_economy_bucket,
  6,
  'spectral-summon',
  NULL,
  true,
  'Convocar Feérico / Invocar Fera (ilusão, PV metade) sem slot',
  'Conjure a versão Ilusão de Convocar Feérico ou Invocar Fera sem espaço (PV da criatura pela metade). Após usar qualquer uma sem slot, recupere o uso só no Descanso Longo.',
  'spend-resource',
  NULL,
  76
),
(
  'wizard-illusory-self',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
  'Autoimagem Ilusória',
  'reaction'::rpg.action_economy_bucket,
  10,
  'illusory-self',
  NULL,
  true,
  'Reação ao ser atingido: ataque erra; 1×/Descanso',
  'Ao ser atingido por um ataque, use a Reação: duplicata ilusória faz o ataque errar automaticamente. Restaure o uso no Descanso Curto/Longo ou gastando um espaço de 2º+ (sem ação).',
  'spend-resource',
  NULL,
  77
),
(
  'wizard-illusory-reality',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
  'Realidade Ilusória',
  'bonus'::rpg.action_economy_bucket,
  14,
  NULL,
  NULL,
  false,
  'Ação Bônus: tornar real 1 objeto da ilusão (1 min)',
  'Enquanto uma magia de Ilusão conjurada com espaço estiver ativa, como Ação Bônus torne real um objeto inanimado não mágico da ilusão por 1 minuto (não causa dano nem condições).',
  NULL,
  NULL,
  78
),
(
  'wizard-overchannel',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'),
  'Sobrecarga',
  'free'::rpg.action_economy_bucket,
  14,
  NULL,
  NULL,
  false,
  'Ao conjurar (1º–5º): dano máximo; usos extras → Necrótico',
  'Ao conjurar magia de Mago que causa dano com espaço de 1º a 5º, você pode causar dano máximo nesse turno. A 1ª vez no dia não tem custo; usos seguintes antes do Descanso Longo causam 2d12 Necrótico por círculo (+1d12 a cada uso extra), ignorando Resistência/Imunidade.',
  NULL,
  NULL,
  79
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order;

-- ---------------------------------------------------------------------------
-- Painel (Tradição Arcana) — inclui correção Esculpir Magias → nv. 6
-- ---------------------------------------------------------------------------
INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
(
  'wizard|abjurer|arcane-ward-recharge',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
  'arcane-ward-recharge',
  'Recarregar Proteção (slot)',
  NULL,
  3,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  5
),
(
  'wizard|abjurer|projected-ward',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
  'projected-ward',
  'Proteção Projetada',
  NULL,
  6,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  6
),
(
  'wizard|abjurer|spell-breaker',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'),
  'spell-breaker',
  'Rompe-Magia',
  NULL,
  10,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  7
),
(
  'wizard|diviner|third-eye',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
  'third-eye',
  'O Terceiro Olho',
  NULL,
  10,
  'third-eye',
  'subclass'::rpg.panel_action_section,
  false,
  5
),
(
  'wizard|evoker|overchannel',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker'),
  'overchannel',
  'Sobrecarga',
  NULL,
  14,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  5
),
(
  'wizard|illusionist|spectral-summon',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
  'spectral-summon',
  'Criaturas Espectrais',
  NULL,
  6,
  'spectral-summon',
  'subclass'::rpg.panel_action_section,
  false,
  5
),
(
  'wizard|illusionist|illusory-self',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
  'illusory-self',
  'Autoimagem Ilusória',
  NULL,
  10,
  'illusory-self',
  'subclass'::rpg.panel_action_section,
  false,
  6
),
(
  'wizard|illusionist|illusory-reality',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
  'illusory-reality',
  'Realidade Ilusória',
  NULL,
  14,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  7
)
ON CONFLICT (panel_key) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  spends_focus = EXCLUDED.spends_focus,
  sort_order = EXCLUDED.sort_order;

-- Esculpir Magias é feature de nv. 6 no PHB 2024 (não 3).
UPDATE rpg.phb_class_panel_action
SET unlock_level = 6
WHERE panel_key = 'wizard|evoker|sculpt-spells';
