-- Economy espécie — Steinhardt Eldritch Hunt (gated por opção)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'species-manikin-custodian-intercept', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), NULL,
  'Intercepção do Custódio', 'reaction'::rpg.action_economy_bucket, 1,
  'manikin-custodian-intercept', NULL, true,
  'Reação: troca de lugar e vira alvo',
  'Quando uma criatura a até 1,5 m for alvo de ataque: Reação para saltar à frente; se voluntária, trocam de lugar e você se torna o alvo. Usos = PB; Descanso Longo.',
  'spend-resource', NULL, 300,
  'serviceModelId', 'custodian'
),
(
  'species-manikin-thespian-bond', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'), NULL,
  'Conexão Teatral', 'bonus'::rpg.action_economy_bucket, 1,
  'manikin-thespian-bond', NULL, true,
  'AB: conexão 1 h (Reação mover depois)',
  'Ação Bônus: conecte-se a uma criatura voluntária a até 9 m por 1 hora. Se ela não usar todo o deslocamento, Reação no fim do turno dela para mover o restante. 1× / Descanso Curto ou Longo.',
  'spend-resource', NULL, 301,
  'serviceModelId', 'thespian'
),
(
  'species-scourgeborne-aranea', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), NULL,
  'Linhagem Aranea', 'free'::rpg.action_economy_bucket, 3,
  'scourgeborne-lineage', NULL, true,
  'Escalada em superfícies difíceis (minutos)',
  'L3+: use o traço de escalada em superfícies difíceis/tetos. L3 = 1 min/LR; L5 = PB minutos/LR.',
  'spend-resource', NULL, 310,
  'monstrousLineageId', 'aranea'
),
(
  'species-scourgeborne-belua', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), NULL,
  'Linhagem Belua', 'bonus'::rpg.action_economy_bucket, 3,
  'scourgeborne-lineage', NULL, true,
  'AB: alimentar-se (cura = dano)',
  'Ação Bônus: Ataque Desarmado para alimentar-se; no acerto, recupera PV iguais ao dano. L3 = 1/LR; L5 = PB/LR.',
  'spend-resource', NULL, 311,
  'monstrousLineageId', 'belua'
),
(
  'species-scourgeborne-cervus', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), NULL,
  'Linhagem Cervus', 'free'::rpg.action_economy_bucket, 3,
  'scourgeborne-lineage', NULL, true,
  'Investida: salvaguarda ou Caído',
  'Após mover ≥6 m em linha reta e acertar corpo a corpo: salvaguarda de Força ou Caído (+ AB ataque). L3 = 1/LR; L5 = PB/LR.',
  'spend-resource', NULL, 312,
  'monstrousLineageId', 'cervus'
),
(
  'species-scourgeborne-vespertilio', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'scourgeborne'), NULL,
  'Linhagem Vespertilio', 'bonus'::rpg.action_economy_bucket, 3,
  'scourgeborne-lineage', NULL, true,
  'AB: voo 9 m até o fim do turno',
  'Ação Bônus: Deslocamento de Voo 9 m até o fim do turno. L3 = 1/SR+LR; L5 = PB/SR+LR.',
  'spend-resource', NULL, 313,
  'monstrousLineageId', 'vespertilio'
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
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
