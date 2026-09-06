-- DMG §0 #9j: economy escudos / armaduras únicas

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-armadura-invulnerabilidade-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'armadura-de-invulnerabilidade'), NULL,
  'Armadura · Resistência B/C/P', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Resistência a Contundente, Cortante e Perfurante',
  'Enquanto usa esta armadura (sintonização).',
  NULL, NULL, 1050, NULL, NULL
),
(
  'item-armadura-invulnerabilidade-carapaca', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'armadura-de-invulnerabilidade'), NULL,
  'Armadura · Carapaça Metálica', 'action'::rpg.action_economy_bucket, 1,
  'armaduraInvulnerabilidadeCarapacaUse', NULL, true,
  'Usar Magia: Imunidade B/C/P por 10 min (1×/amanhecer)',
  'Imunidade a Contundente, Cortante e Perfurante por 10 minutos ou até remover a armadura. MVP: recupera no DL.',
  'spend-resource', 1, 1051, NULL, NULL
),
(
  'item-escudo-animado-ativar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-animado'), NULL,
  'Escudo · Animar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: escudo paira 1 min (mãos livres)',
  'Protege como se empunhado. Encerra se morrer, Incapacitado ou Ação Bônus para parar.',
  NULL, NULL, 1052, NULL, NULL
),
(
  'item-escudo-animado-parar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-animado'), NULL,
  'Escudo · Parar Animação', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: encerra; cai no chão ou na mão livre',
  'Encerra o efeito de animação.',
  NULL, NULL, 1053, NULL, NULL
),
(
  'item-escudo-apanhador-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-apanhador-de-flechas'), NULL,
  'Escudo · +2 CA vs À Distância', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+2 CA vs ataques à distância (além do Escudo)',
  'Bônus situacional — aplique na mesa (não é acBonus flat).',
  NULL, NULL, 1054, NULL, NULL
),
(
  'item-escudo-apanhador-interceptar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-apanhador-de-flechas'), NULL,
  'Escudo · Interceptar Projétil', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: vira alvo de ataque à distância a ≤1,5 m',
  'Quando um atacante faz ataque à distância contra alvo a ≤1,5 m de você.',
  NULL, NULL, 1055, NULL, NULL
),
(
  'item-escudo-bloqueador-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-bloqueador-de-magias'), NULL,
  'Escudo · Antimagia', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem vs magias; ataques mágicos com Desvantagem',
  'Enquanto equipado (sintonização).',
  NULL, NULL, 1056, NULL, NULL
),
(
  'item-escudo-atracao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-de-atracao-de-projeteis'), NULL,
  'Escudo · Resistência / Maldição', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Resistência a dano de armas à distância; maldição atrai alvos a 3 m',
  'Maldição: sintonizar amaldiçoa até Remover Maldição. Ataques à distância a ≤3 m têm você como alvo.',
  NULL, NULL, 1057, NULL, NULL
),
(
  'item-escudo-cavaleiro-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-do-cavaleiro'), NULL,
  'Escudo · +2 CA', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+2 CA (permanentEffects; soma ao Escudo)',
  'Enquanto equipado (sintonização).',
  NULL, NULL, 1058, NULL, NULL
),
(
  'item-escudo-cavaleiro-campo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-do-cavaleiro'), NULL,
  'Escudo · Campo de Proteção', 'reaction'::rpg.action_economy_bucket, 1,
  'escudoCavaleiroCampoUse', NULL, true,
  'Reação: Emanação 1,5 m / Concentração 1 min (1×/amanhecer)',
  'Quando você ou aliado a ≤1,5 m é alvo de ataque ou salvaguarda de área. Bloqueia entrada/saída e dano cruzando a barreira. MVP: DL.',
  'spend-resource', 1, 1059, NULL, NULL
),
(
  'item-escudo-cavaleiro-pancada', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-do-cavaleiro'), NULL,
  'Escudo · Pancada Forte', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Na ação Atacar: 1 ataque com o Escudo (2d6+2+FOR Energético)',
  'Proficiência + FOR. Acerto: empurrão até 3 m; se ≤ seu tamanho, pode impor Caído.',
  NULL, NULL, 1060, NULL, NULL
),
(
  'item-escudo-expressivo-alterar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-expressivo'), NULL,
  'Escudo · Mudar Expressão', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: altera a expressão do rosto',
  'Cosmético. Sem sintonização.',
  NULL, NULL, 1061, NULL, NULL
),
(
  'item-escudo-sentinela-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-sentinela'), NULL,
  'Escudo · Sentinela', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem em Iniciativa e Percepção (Sabedoria)',
  'Enquanto equipado. Sem sintonização.',
  NULL, NULL, 1062, NULL, NULL
),
(
  'item-loriga-escamas-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'loriga-de-escamas-draconicas'), NULL,
  'Loriga · +1 CA / Sopro / Resistência', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 CA (PE); Vantagem vs sopro de Dragão; Resistência do tipo',
  'Tipo de dano = cor do dragão (tabela DMG). Sintonização.',
  NULL, NULL, 1063, NULL, NULL
),
(
  'item-loriga-escamas-detectar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'loriga-de-escamas-draconicas'), NULL,
  'Loriga · Detectar Dragão', 'action'::rpg.action_economy_bucket, 1,
  'lorigaEscamasDraconicasDetectarUse', NULL, true,
  'Usar Magia: direção/distância do dragão do tipo a ≤48 km (1×/amanhecer)',
  'Mesmo tipo das escamas. MVP: recupera no DL.',
  'spend-resource', 1, 1064, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
  item_id = EXCLUDED.item_id,
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
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
