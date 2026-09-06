-- Economy Character Threads (Northlands) — spend-resource 1/DL

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, subclass_id, feat_id, item_id, heritage_trait_id, thread_slug,
  name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'thread-wrath', NULL, NULL, NULL, NULL, NULL, NULL, 'bloodsworn',
  'Ira', 'action'::rpg.action_economy_bucket, 1,
  'wrath', NULL, true,
  'Wrathful Smite 1/DL',
  'Conjura Wrathful Smite (INT/SAB/CAR). 1 uso / Descanso Longo.',
  'spend-resource', NULL, 700
),
(
  'thread-tenacity', NULL, NULL, NULL, NULL, NULL, NULL, 'bloodsworn',
  'Tenacidade', 'free'::rpg.action_economy_bucket, 1,
  'tenacity', NULL, true,
  'Encerrar condição no início do turno',
  'No início do turno, encerra Assustado, Incapacitado, Paralisado ou Atordoado. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 701
),
(
  'thread-cursemarked-greater-sacrifice', NULL, NULL, NULL, NULL, NULL, NULL, 'cursemarked',
  'Grande Sacrifício', 'free'::rpg.action_economy_bucket, 1,
  'cursemarked-greater-sacrifice', NULL, true,
  'Sacrifício opcional do bracket Cursemarked',
  'Declare o Grande Sacrifício do benefício Cursemarked ativo (ver nota do bracket). 1 uso / Descanso Longo.',
  'spend-resource', NULL, 710
),
(
  'thread-traversal-expert', NULL, NULL, NULL, NULL, NULL, NULL, 'explorer',
  'Especialista em Travessia', 'bonus'::rpg.action_economy_bucket, 1,
  'traversal-expert', NULL, true,
  'AB Disparar + terreno + Atletismo',
  'Ação Bônus Disparar; ignora Terreno Difícil; vantagem em Atletismo para escalar/saltar/nadar. 1 uso / Descanso Curto ou Longo.',
  'spend-resource', NULL, 720
),
(
  'thread-scouts-awareness', NULL, NULL, NULL, NULL, NULL, NULL, 'explorer',
  'Alerta do Batedor', 'action'::rpg.action_economy_bucket, 1,
  'scouts-awareness', NULL, true,
  '1h vantagem vs armadilhas (9 m)',
  '1 hora: você e aliados a 9 m têm vantagem em salvaguardas vs armadilhas/perigos não mágicos. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 721
),
(
  'thread-wayfarers-steps', NULL, NULL, NULL, NULL, NULL, NULL, 'explorer',
  'Passos do Viajante', 'bonus'::rpg.action_economy_bucket, 1,
  'wayfarers-steps', NULL, true,
  'AB Disparar + aliados',
  'Não se perde; Ação Bônus Disparar + até 4 aliados Disparar sem ataques de oportunidade. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 722
),
(
  'thread-fates-blessing', NULL, NULL, NULL, NULL, NULL, NULL, 'fatebound',
  'Bênção do Destino', 'reaction'::rpg.action_economy_bucket, 1,
  'fates-blessing', NULL, true,
  'Reação: vantagem em save (Bloodied)',
  'Quando Bloodied: Reação para vantagem em um teste de resistência. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 730
),
(
  'thread-strength-of-wyrd', NULL, NULL, NULL, NULL, NULL, NULL, 'fatebound',
  'Força do Wyrd', 'free'::rpg.action_economy_bucket, 1,
  'strength-of-wyrd', NULL, true,
  'Bloodied: +PB dano',
  'Enquanto Bloodied, some o bônus de proficiência ao dano. Usos = PB / Descanso Longo.',
  'spend-resource', NULL, 731
),
(
  'thread-enduring-wyrd', NULL, NULL, NULL, NULL, NULL, NULL, 'fatebound',
  'Wyrd Duradouro', 'reaction'::rpg.action_economy_bucket, 1,
  'enduring-wyrd', NULL, true,
  'Reação: PV temp. = PB',
  'Reação: ganhe PV temporários iguais ao PB. 1 uso / Descanso Curto ou Longo.',
  'spend-resource', NULL, 732
),
(
  'thread-doom-delayed', NULL, NULL, NULL, NULL, NULL, NULL, 'fatebound',
  'Ruína Adiada', 'free'::rpg.action_economy_bucket, 1,
  'doom-delayed', NULL, true,
  'Em vez de morrer → estável 0 PV',
  'Usar quando o personagem morreria: fica estável com 0 PV (3 sucessos de morte). 1 uso / Descanso Longo.',
  'spend-resource', NULL, 733
),
(
  'thread-last-act-of-fate', NULL, NULL, NULL, NULL, NULL, NULL, 'fatebound',
  'Último Ato do Destino', 'free'::rpg.action_economy_bucket, 1,
  'last-act-of-fate', NULL, true,
  '1 PV, limpa condições, 1 turno final',
  'No momento predeterminado: 1 PV, limpa condições; 1 turno com imunidade + vantagem + dano +nível; depois morte permanente. Uso único.',
  'spend-resource', NULL, 734
),
(
  'thread-glorious-end', NULL, NULL, NULL, NULL, NULL, NULL, 'fatebound',
  'Fim Glorioso', 'free'::rpg.action_economy_bucket, 1,
  'glorious-end', NULL, true,
  'Aliados testemunhas: vantagem 24h',
  'Declare Fim Glorioso: aliados que testemunharam têm vantagem em testes d20 por 24 horas. Uso único.',
  'spend-resource', NULL, 735
),
(
  'thread-enthralling-speaker', NULL, NULL, NULL, NULL, NULL, NULL, 'herald',
  'Orador Cativante', 'action'::rpg.action_economy_bucket, 1,
  'enthralling-speaker', NULL, true,
  'Charm Person / Suggestion na performance',
  'Durante uma performance: Charm Person ou Suggestion (Carisma). 1 uso / Descanso Longo.',
  'spend-resource', NULL, 740
),
(
  'thread-persuasive-words', NULL, NULL, NULL, NULL, NULL, NULL, 'herald',
  'Palavras Persuasivas', 'free'::rpg.action_economy_bucket, 1,
  'persuasive-words', NULL, true,
  'd20 ≤9 vira 10 (Carisma)',
  'Em um teste de Carisma, trate d20 ≤9 como 10. Usos = modificador de Carisma / Descanso Longo.',
  'spend-resource', NULL, 741
),
(
  'thread-reliable-senses', NULL, NULL, NULL, NULL, NULL, NULL, 'legend-hunter',
  'Sentidos Confiáveis', 'free'::rpg.action_economy_bucket, 1,
  'reliable-senses', NULL, true,
  'Rerolar Investigação/Percepção/Sobrevivência',
  'Rerole um teste de Investigação, Percepção ou Sobrevivência. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 750
),
(
  'thread-finish-the-fight', NULL, NULL, NULL, NULL, NULL, NULL, 'legend-hunter',
  'Terminar a Luta', 'free'::rpg.action_economy_bucket, 1,
  'finish-the-fight', NULL, true,
  'Após Bloodied: próximo acerto crítico',
  'Após ficar Bloodied, o próximo acerto é crítico. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 751
),
(
  'thread-jarls-authority', NULL, NULL, NULL, NULL, NULL, NULL, 'sworn-huskarl',
  'Autoridade do Jarl', 'free'::rpg.action_economy_bucket, 1,
  'jarls-authority', NULL, true,
  'Intimidação/Persuasão: d20 = 15',
  'Contra quem respeita ou teme o senhor: trate o d20 como 15 em Intimidação ou Persuasão. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 760
),
(
  'thread-extreme-loyalty', NULL, NULL, NULL, NULL, NULL, NULL, 'sworn-huskarl',
  'Lealdade Extrema', 'free'::rpg.action_economy_bucket, 1,
  'extreme-loyalty', NULL, true,
  'Encerrar Enfeitiçado (dano psíquico = nível)',
  'Encerre a condição Enfeitiçado pagando dano Psíquico igual ao seu nível. 1 uso / Descanso Longo.',
  'spend-resource', NULL, 761
)
ON CONFLICT (action_id) DO UPDATE SET
  thread_slug = EXCLUDED.thread_slug,
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
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  subclass_id = EXCLUDED.subclass_id,
  feat_id = EXCLUDED.feat_id,
  item_id = EXCLUDED.item_id,
  heritage_trait_id = EXCLUDED.heritage_trait_id;
