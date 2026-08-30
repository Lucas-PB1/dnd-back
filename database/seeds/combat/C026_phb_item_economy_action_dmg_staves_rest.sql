-- DMG §0 #8e: economy cajados restantes
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Agravo (gasto variável 1–3)
(
  'item-cajado-do-agravo-energia-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-agravo'), NULL,
  'Cajado · +1d6 Energético', 'free'::rpg.action_economy_bucket, 1,
  'cajadoAgravoCharges', NULL, true,
  'No acerto: gastar 1 carga → +1d6 Energético',
  'Cajado mágico +3 ataque/dano. Em acerto corpo a corpo, gaste 1 carga para +1d6 Energético. Cargas: 10; recupera 1d6+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 vira Cajado não mágico.',
  'spend-resource', 1, 700, NULL, NULL
),
(
  'item-cajado-do-agravo-energia-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-agravo'), NULL,
  'Cajado · +2d6 Energético', 'free'::rpg.action_economy_bucket, 1,
  'cajadoAgravoCharges', NULL, true,
  'No acerto: gastar 2 cargas → +2d6 Energético',
  'Em acerto corpo a corpo, gaste 2 cargas para +2d6 Energético. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 701, NULL, NULL
),
(
  'item-cajado-do-agravo-energia-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-agravo'), NULL,
  'Cajado · +3d6 Energético', 'free'::rpg.action_economy_bucket, 1,
  'cajadoAgravoCharges', NULL, true,
  'No acerto: gastar 3 cargas → +3d6 Energético',
  'Em acerto corpo a corpo, gaste 3 cargas (máximo) para +3d6 Energético. Cargas: 10; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 702, NULL, NULL
),
-- Magificado
(
  'item-cajado-magificado-conjurar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-magificado'), NULL,
  'Cajado · Magia Vinculada', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagificadoCharges', NULL, true,
  'Gastar 1 carga: conjurar magia vinculada (≤8º)',
  'Gaste 1 carga para conjurar a magia vinculada na criação (CD/ataque conforme círculo — ver tabela do item). Cargas: 6; recupera 1d6 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20, em 1 perde propriedades.',
  'spend-resource', 1, 703, NULL, NULL
),
-- Trovoada
(
  'item-cajado-da-trovoada-golpe', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'), NULL,
  'Cajado · Golpe de Relâmpago', 'action'::rpg.action_economy_bucket, 1,
  'cajadoTrovoadaGolpeUse', NULL, true,
  'Linha 36 m: DES CD 17 · 9d6 Elétrico (1×/amanhecer)',
  'Cajado mágico +2 ataque/dano. Usar Magia: relâmpago em Linha 1,5×36 m; DES CD 17; falha 9d6 Elétrico / sucesso metade. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 704, NULL, NULL
),
(
  'item-cajado-da-trovoada-relampago', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'), NULL,
  'Cajado · Relâmpago', 'free'::rpg.action_economy_bucket, 1,
  'cajadoTrovoadaRelampagoUse', NULL, true,
  'No acerto: +2d6 Elétrico (1×/amanhecer)',
  'Ao atingir corpo a corpo com o cajado, cause +2d6 Elétrico (sem ação). 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 705, NULL, NULL
),
(
  'item-cajado-da-trovoada-trovao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'), NULL,
  'Cajado · Trovão', 'free'::rpg.action_economy_bucket, 1,
  'cajadoTrovoadaTrovaoUse', NULL, true,
  'No acerto: estrondo; CON CD 17 ou Atordoado (1×/amanhecer)',
  'Ao atingir corpo a corpo, estrondo audível a 90 m; alvo CON CD 17 ou Atordoado até o fim do seu próximo turno. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 706, NULL, NULL
),
(
  'item-cajado-da-trovoada-trovoada', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'), NULL,
  'Cajado · Trovoada', 'action'::rpg.action_economy_bucket, 1,
  'cajadoTrovoadaTrovoadaUse', NULL, true,
  'Emanação 18 m: CON CD 17 · 2d6 Trovejante + Surdo (1×/amanhecer)',
  'Usar Magia: estrondo a 180 m; criaturas na Emanação 18 m CON CD 17; falha 2d6 Trovejante + Surdo 1 min / sucesso metade. 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 707, NULL, NULL
),
(
  'item-cajado-da-trovoada-combo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'), NULL,
  'Cajado · Trovão e Relâmpago', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Após acerto: Ação Bônus usa Relâmpago+Trovão sem gastar usos diários',
  'Imediatamente após acerto corpo a corpo, Ação Bônus: use Relâmpago e Trovão juntos. Isso não gasta o uso diário dessas propriedades — só o uso desta combo (lembrete de mesa; rastreie manualmente se necessário).',
  NULL, NULL, 708, NULL, NULL
),
-- Píton
(
  'item-cajado-da-piton-invocar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-piton'), NULL,
  'Cajado · Cobra Constritora', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPitonUse', NULL, true,
  'Arremessar → Cobra Constritora Gigante (MVP: 1×/Descanso Longo)',
  'Usar Magia: arremesse a até 3 m em espaço livre → Cobra Constritora Gigante sob seu controle (mesma Iniciativa, turno logo após o seu). Ação Bônus: reverter à forma de cajado. Texto: cooldown 1 h (MVP: Descanso Longo). Se a cobra chegar a 0 PV, o cajado se parte e é destruído.',
  'spend-resource', 1, 709, NULL, NULL
),
(
  'item-cajado-da-piton-reverter', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-piton'), NULL,
  'Cajado · Reverter Forma', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: cobra reverte a cajado (restaura PV da cobra)',
  'Comande a cobra a reverter para forma de cajado no espaço dela. Se reverter antes de 0 PV, restaura todos os PV. Depois disso, não use a invocação novamente por 1 hora (MVP: já gasto no botão de invocar).',
  NULL, NULL, 710, NULL, NULL
),
-- Víbora (lembrete)
(
  'item-cajado-da-vibora-animar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-vibora'), NULL,
  'Cajado · Cabeça de Cobra', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: animar cabeça (1 min) ou reverter',
  'Ação Bônus: cabeça vira Cobra Peçonhenta animada por 1 min (ou reverte). Em Atacar, um ataque com a cabeça: PB + Sab; 1d6 Perfurante + 3d6 Venenoso; alcance 1,5 m. Cabeça: CA 15, 20 PV, imune Psíquico/Venenoso; a 0 PV o cajado é destruído.',
  NULL, NULL, 711, NULL, NULL
),
-- Ornamental (lembrete)
(
  'item-cajado-ornamental-flutuar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-ornamental'), NULL,
  'Cajado · Objetos Flutuantes', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Até 3 objetos Minúsculos (≤0,5 kg) flutuam na ponta',
  'Enquanto segura o cajado, objetos Minúsculos ≤0,5 kg podem flutuar 2,5 cm acima da ponta (até 3). Você pode fazê-los girar ou mover lentamente.',
  NULL, NULL, 712, NULL, NULL
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
