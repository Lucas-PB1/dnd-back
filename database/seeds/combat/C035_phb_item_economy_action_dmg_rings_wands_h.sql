-- DMG §0 #9h: economy anéis finais + varinhas lote 2
-- Cast/link magia = fase 6 (só spend-resource + texto)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Anel de Ariete
(
  'item-anel-de-ariete-ataque-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'), NULL,
  'Anel · Ariete (1 carga)', 'action'::rpg.action_economy_bucket, 1,
  'anelArieteCharges', NULL, true,
  'Ataque +7: 2d10 Energético + empurrão 1,5 m',
  'Usar Magia: gaste 1 carga; ataque mágico à distância +7 a 18 m. Acerto: 2d10 Energético e empurrão 1,5 m. Cargas: 3; recupera 1d3 ao amanhecer (MVP: DL).',
  'spend-resource', 1, 970, NULL, NULL
),
(
  'item-anel-de-ariete-ataque-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'), NULL,
  'Anel · Ariete (2 cargas)', 'action'::rpg.action_economy_bucket, 1,
  'anelArieteCharges', NULL, true,
  'Ataque +7: 4d10 Energético + empurrão 3 m',
  'Gaste 2 cargas: +7 acerto; 4d10 Energético e empurrão 3 m. Cargas: 3; MVP recupera no DL.',
  'spend-resource', 2, 971, NULL, NULL
),
(
  'item-anel-de-ariete-ataque-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'), NULL,
  'Anel · Ariete (3 cargas)', 'action'::rpg.action_economy_bucket, 1,
  'anelArieteCharges', NULL, true,
  'Ataque +7: 6d10 Energético + empurrão 4,5 m',
  'Gaste 3 cargas: +7 acerto; 6d10 Energético e empurrão 4,5 m. Cargas: 3; MVP recupera no DL.',
  'spend-resource', 3, 972, NULL, NULL
),
(
  'item-anel-de-ariete-objeto-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'), NULL,
  'Anel · Quebrar Objeto (1)', 'action'::rpg.action_economy_bucket, 1,
  'anelArieteCharges', NULL, true,
  'Teste Força +5 vs objeto não mágico a 18 m',
  'Gaste 1 carga: teste de Força +5 para quebrar objeto não mágico (não usado/carregado) a 18 m.',
  'spend-resource', 1, 973, NULL, NULL
),
(
  'item-anel-de-ariete-objeto-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'), NULL,
  'Anel · Quebrar Objeto (2)', 'action'::rpg.action_economy_bucket, 1,
  'anelArieteCharges', NULL, true,
  'Teste Força +10 vs objeto',
  'Gaste 2 cargas: teste de Força +10 para quebrar objeto.',
  'spend-resource', 2, 974, NULL, NULL
),
(
  'item-anel-de-ariete-objeto-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'), NULL,
  'Anel · Quebrar Objeto (3)', 'action'::rpg.action_economy_bucket, 1,
  'anelArieteCharges', NULL, true,
  'Teste Força +15 vs objeto',
  'Gaste 3 cargas: teste de Força +15 para quebrar objeto.',
  'spend-resource', 3, 975, NULL, NULL
),
-- Djinni
(
  'item-anel-de-invocar-djinni-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-invocar-djinni'), NULL,
  'Anel · Invocar Djinni', 'action'::rpg.action_economy_bucket, 1,
  'anelDjinniUse', NULL, true,
  'Djinni 1 h (Conc.); MVP 1×/DL (texto 24 h)',
  'Usar Magia: invoque Djinni a 36 m (Amigável, Concentração ≤1 h / a 0 PV). Se morrer, anel vira não mágico. Texto: 24 h (MVP: Descanso Longo).',
  'spend-resource', 1, 976, NULL, NULL
),
-- Armazenador
(
  'item-anel-armazenador-de-magias-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-armazenador-de-magias'), NULL,
  'Anel · Conjurar Magia Armazenada', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar magia guardada (até 5 círculos; rastreie na mesa)',
  'Armazena até 5 círculos. Outros podem conjurar 1º–5º no anel para guardar. Você conjura o armazenado (CD/ataque do original). Rastreie magias/círculos na mesa.',
  NULL, NULL, 977, NULL, NULL
),
-- Comando Elemental
(
  'item-anel-de-comando-elemental-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Destruição / Foco Elemental', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem vs Elementais; benefícios do plano (água/ar/fogo/terra)',
  'Vantagem em ataques vs Elementais; eles têm Desvantagem vs você. Foco do plano: Água (Aquan, nadar 18 m, respirar); Ar (Auran, Res. Elétrico, voo); Fogo (Ignan, Imun. Ígneo); Terra (Terran, Res. Ácido, atravessar terra).',
  NULL, NULL, 978, NULL, NULL
),
(
  'item-anel-de-comando-elemental-compulsao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Compulsão Elemental', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Elemental a 18 m: SAB CD 18 ou Encantado (você controla turno)',
  'Usar Magia: Elemental a 18 m SAB CD 18; falha → Encantado até início do seu próximo turno; você decide movimento e ação dele.',
  NULL, NULL, 979, NULL, NULL
),
(
  'item-anel-comando-elem-queda-suave', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Queda Suave (Ar, 0)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Plano Ar: Queda Suave (0 cargas)',
  'Só plano Ar: conjure Queda Suave sem gastar cargas. CD 18. Cargas: 5; recupera 1d4+1 ao amanhecer (MVP: DL).',
  NULL, NULL, 980, NULL, NULL
),
(
  'item-anel-comando-elem-criar-agua', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Criar ou Destruir Água (1)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Água: gastar 1 — Criar ou Destruir Água',
  'Plano Água: gaste 1 carga (CD 18). Cargas: 5; MVP recupera no DL.',
  'spend-resource', 1, 981, NULL, NULL
),
(
  'item-anel-comando-elem-muralha-vento', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Muralha de Vento (1)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Ar: gastar 1 — Muralha de Vento',
  'Plano Ar: gaste 1 carga (CD 18).',
  'spend-resource', 1, 982, NULL, NULL
),
(
  'item-anel-comando-elem-maos-flamejantes', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Mãos Flamejantes (1)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Fogo: gastar 1 — Mãos Flamejantes',
  'Plano Fogo: gaste 1 carga (CD 18).',
  'spend-resource', 1, 983, NULL, NULL
),
(
  'item-anel-comando-elem-caminhar-agua', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Caminhar Sobre as Águas (2)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Água: gastar 2 — Caminhar Sobre as Águas',
  'Plano Água: gaste 2 cargas (CD 18).',
  'spend-resource', 2, 984, NULL, NULL
),
(
  'item-anel-comando-elem-tempestade-glacial', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Tempestade Glacial (2)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Água: gastar 2 — Tempestade Glacial',
  'Plano Água: gaste 2 cargas (CD 18).',
  'spend-resource', 2, 985, NULL, NULL
),
(
  'item-anel-comando-elem-lufada', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Lufada de Vento (2)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Ar: gastar 2 — Lufada de Vento',
  'Plano Ar: gaste 2 cargas (CD 18).',
  'spend-resource', 2, 986, NULL, NULL
),
(
  'item-anel-comando-elem-bola-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Bola de Fogo (2)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Fogo: gastar 2 — Bola de Fogo',
  'Plano Fogo: gaste 2 cargas (CD 18).',
  'spend-resource', 2, 987, NULL, NULL
),
(
  'item-anel-comando-elem-moldar-rochas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Moldar Rochas (2)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Terra: gastar 2 — Moldar Rochas',
  'Plano Terra: gaste 2 cargas (CD 18).',
  'spend-resource', 2, 988, NULL, NULL
),
(
  'item-anel-comando-elem-muralha-gelo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Muralha de Gelo (3)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Água: gastar 3 — Muralha de Gelo',
  'Plano Água: gaste 3 cargas (CD 18).',
  'spend-resource', 3, 989, NULL, NULL
),
(
  'item-anel-comando-elem-corrente', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Corrente de Relâmpagos (3)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Ar: gastar 3 — Corrente de Relâmpagos',
  'Plano Ar: gaste 3 cargas (CD 18).',
  'spend-resource', 3, 990, NULL, NULL
),
(
  'item-anel-comando-elem-muralha-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Muralha de Fogo (3)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Fogo: gastar 3 — Muralha de Fogo',
  'Plano Fogo: gaste 3 cargas (CD 18).',
  'spend-resource', 3, 991, NULL, NULL
),
(
  'item-anel-comando-elem-muralha-pedra', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Muralha de Pedra (3)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Terra: gastar 3 — Muralha de Pedra',
  'Plano Terra: gaste 3 cargas (CD 18).',
  'spend-resource', 3, 992, NULL, NULL
),
(
  'item-anel-comando-elem-pele-rocha', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Pele-Rocha (3)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Terra: gastar 3 — Pele-Rocha',
  'Plano Terra: gaste 3 cargas (CD 18).',
  'spend-resource', 3, 993, NULL, NULL
),
(
  'item-anel-comando-elem-tempestade-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Tempestade de Fogo (4)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Fogo: gastar 4 — Tempestade de Fogo',
  'Plano Fogo: gaste 4 cargas (CD 18).',
  'spend-resource', 4, 994, NULL, NULL
),
(
  'item-anel-comando-elem-tsunami', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Tsunami (5)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Água: gastar 5 — Tsunami',
  'Plano Água: gaste 5 cargas (CD 18).',
  'spend-resource', 5, 995, NULL, NULL
),
(
  'item-anel-comando-elem-terremoto', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'), NULL,
  'Anel · Terremoto (5)', 'action'::rpg.action_economy_bucket, 1,
  'anelComandoElementalCharges', NULL, true,
  'Plano Terra: gastar 5 — Terremoto',
  'Plano Terra: gaste 5 cargas (CD 18).',
  'spend-resource', 5, 996, NULL, NULL
),
-- Varinhas
(
  'item-varinha-dos-segredos-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-dos-segredos'), NULL,
  'Varinha · Porta/Armadilha Secreta', 'action'::rpg.action_economy_bucket, 1,
  'varinhaSegredosCharges', NULL, true,
  'Gastar 1 carga: aponta porta/armadilha secreta a 18 m',
  'Usar Magia: gaste 1 carga; se houver porta/armadilha secreta a 18 m, pulsa e aponta a mais próxima. Cargas: 3; recupera 1d3 ao amanhecer (MVP: DL).',
  'spend-resource', 1, 997, NULL, NULL
),
(
  'item-varinha-de-teia-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-teia'), NULL,
  'Varinha · Teia', 'action'::rpg.action_economy_bucket, 1,
  'varinhaTeiaCharges', NULL, true,
  'Gastar 1 carga: Teia CD 13',
  'Gaste 1 carga: Teia (CD 13). Cargas: 7; recupera 1d6+1 ao amanhecer (MVP: DL). Última carga: 1d20, em 1 destrói.',
  'spend-resource', 1, 998, NULL, NULL
),
(
  'item-varinha-de-polimorfia-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-polimorfia'), NULL,
  'Varinha · Polimorfia', 'action'::rpg.action_economy_bucket, 1,
  'varinhaPolimorfiaCharges', NULL, true,
  'Gastar 1 carga: Polimorfia CD 15',
  'Gaste 1 carga: Polimorfia (CD 15). Cargas: 7; MVP recupera no DL. Última carga: 1d20, em 1 destrói.',
  'spend-resource', 1, 999, NULL, NULL
),
(
  'item-batuta-da-regencia-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'batuta-da-regencia'), NULL,
  'Batuta · Música Orquestral', 'action'::rpg.action_economy_bucket, 1,
  'batutaRegenciaCharges', NULL, true,
  'Gastar 1 carga: música audível a 36 m',
  'Usar Magia: gaste 1 carga; música enquanto agita (36 m). Cargas: 3; recupera todas ao amanhecer (MVP: DL). Última: 1d20, em 1 destrói.',
  'spend-resource', 1, 1000, NULL, NULL
),
(
  'item-varinha-de-relampagos-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-relampagos'), NULL,
  'Varinha · Relâmpago (3º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaRelampagosCharges', NULL, true,
  'Gastar 1 carga: Relâmpago 3º CD 15',
  'Gaste 1–3 cargas (máx. 3): Relâmpago no círculo = 2 + cargas. Cargas: 7; MVP recupera no DL.',
  'spend-resource', 1, 1001, NULL, NULL
),
(
  'item-varinha-de-relampagos-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-relampagos'), NULL,
  'Varinha · Relâmpago (4º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaRelampagosCharges', NULL, true,
  'Gastar 2 cargas: Relâmpago 4º CD 15',
  'Gaste 2 cargas: Relâmpago 4º (CD 15).',
  'spend-resource', 2, 1002, NULL, NULL
),
(
  'item-varinha-de-relampagos-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-relampagos'), NULL,
  'Varinha · Relâmpago (5º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaRelampagosCharges', NULL, true,
  'Gastar 3 cargas: Relâmpago 5º CD 15',
  'Gaste 3 cargas: Relâmpago 5º (CD 15).',
  'spend-resource', 3, 1003, NULL, NULL
),
(
  'item-varinha-cuspidora-de-fogo-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-cuspidora-de-fogo'), NULL,
  'Varinha · Bola de Fogo (3º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaCuspidoraFogoCharges', NULL, true,
  'Gastar 1 carga: Bola de Fogo 3º CD 15',
  'Gaste 1–3 cargas: Bola de Fogo no círculo = 2 + cargas. Cargas: 7; MVP recupera no DL.',
  'spend-resource', 1, 1004, NULL, NULL
),
(
  'item-varinha-cuspidora-de-fogo-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-cuspidora-de-fogo'), NULL,
  'Varinha · Bola de Fogo (4º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaCuspidoraFogoCharges', NULL, true,
  'Gastar 2 cargas: Bola de Fogo 4º CD 15',
  'Gaste 2 cargas: Bola de Fogo 4º (CD 15).',
  'spend-resource', 2, 1005, NULL, NULL
),
(
  'item-varinha-cuspidora-de-fogo-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-cuspidora-de-fogo'), NULL,
  'Varinha · Bola de Fogo (5º)', 'action'::rpg.action_economy_bucket, 1,
  'varinhaCuspidoraFogoCharges', NULL, true,
  'Gastar 3 cargas: Bola de Fogo 5º CD 15',
  'Gaste 3 cargas: Bola de Fogo 5º (CD 15).',
  'spend-resource', 3, 1006, NULL, NULL
),
(
  'item-varinha-pirotecnica-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-pirotecnica'), NULL,
  'Varinha · Explosão de Luz', 'action'::rpg.action_economy_bucket, 1,
  'varinhaPirotecnicaCharges', NULL, true,
  'Gastar 1 carga: luz/ruído inofensivos a 36 m',
  'Usar Magia: gaste 1 carga; explosão inofensiva de luz (tocha, 1 s) + ruído a 90 m. Cargas: 7; MVP recupera no DL.',
  'spend-resource', 1, 1007, NULL, NULL
),
(
  'item-varinha-de-detectar-inimigo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-detectar-inimigo'), NULL,
  'Varinha · Detectar Inimigo', 'action'::rpg.action_economy_bucket, 1,
  'varinhaDetectarInimigoCharges', NULL, true,
  'Gastar 1 carga: direção do Hostil mais próximo 18 m / 1 min',
  'Usar Magia: gaste 1 carga; 1 min sabe a direção do Hostil mais próximo a 18 m (não a distância). Cargas: 7; MVP recupera no DL.',
  'spend-resource', 1, 1008, NULL, NULL
),
(
  'item-varinha-de-paralisia-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-paralisia'), NULL,
  'Varinha · Paralisia', 'action'::rpg.action_economy_bucket, 1,
  'varinhaParalisiaCharges', NULL, true,
  'Gastar 1 carga: CON CD 15 ou Paralisado 1 min',
  'Usar Magia: gaste 1 carga; raio a 18 m; CON CD 15 ou Paralisado 1 min (repetir no fim do turno). Cargas: 7; MVP recupera no DL.',
  'spend-resource', 1, 1009, NULL, NULL
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
