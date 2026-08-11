-- DMG §0 #9e: economy maravilhosos passivos/à vontade (lote 5)
-- Ver docs/source/dmg-wiring-status.md
-- Manuais/tomos: +2 atributo permanente no personagem; item perde magia.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-olhos-ampliadores-da-visao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-ampliadores-da-visao'), NULL,
  'Olhos · Visão Ampliada', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'A 30 cm: Visão no Escuro + Vantagem Investigação',
  'Ao usar: no alcance de 30 cm, Visão no Escuro e Vantagem em Inteligência (Investigação) para examinar algo nesse alcance.',
  NULL, NULL, 860, NULL, NULL
),
(
  'item-olhos-da-aguia-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-da-aguia'), NULL,
  'Olhos · Visão de Águia', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem Percepção (visão); detalhes a longa distância',
  'Ao usar: Vantagem em Sabedoria (Percepção) baseada em visão. Em boa visibilidade, distingue detalhes de objetos/criaturas até ~60 cm de extensão a grande distância.',
  NULL, NULL, 861, NULL, NULL
),
(
  'item-sela-do-cavaleiro-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'sela-do-cavaleiro'), NULL,
  'Sela · Cavaleiro Seguro', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Não desmonta (salvo Incapacitado); ataques vs montaria com Desvantagem',
  'Sentado e montado: não pode ser desmontado contra a vontade (suprimido se Incapacitado); jogadas de ataque contra a montaria têm Desvantagem.',
  NULL, NULL, 862, NULL, NULL
),
(
  'item-botas-das-terras-glaciais-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-das-terras-glaciais'), NULL,
  'Botas · Terras Glaciais', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ignora gelo/neve difícil; Resistência Gélido; frio extremo',
  'Ignora Terreno Difícil de gelo/neve; Resistência a Gélido; tolera ≤ −18 °C sem proteção extra.',
  NULL, NULL, 863, NULL, NULL
),
(
  'item-sandalias-de-escalada-de-aranha-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'sandalias-de-escalada-de-aranha'), NULL,
  'Sandálias · Escalada de Aranha', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Escalada = Desloc.; paredes/tetos (não escorregadio)',
  'Deslocamento de Escalada = seu Deslocamento; paredes e tetos com mãos livres. Não funciona em superfícies escorregadias (gelo/óleo).',
  NULL, NULL, 864, NULL, NULL
),
(
  'item-manual-de-saude-corporal-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manual-de-saude-corporal'), NULL,
  'Manual · +2 Constituição', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Estudar 48 h / 6 dias → +2 Con (máx. 30); perde magia',
  'Após 48 h de estudo em ≤6 dias: Constituição +2 (máx. 30). A magia se dissipa (recupera em 1 século). Marque o item como não mágico / remova.',
  NULL, NULL, 865, NULL, NULL
),
(
  'item-tomo-dos-pensamentos-objetivos-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tomo-dos-pensamentos-objetivos'), NULL,
  'Tomo · +2 Inteligência', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Estudar 48 h / 6 dias → +2 Int (máx. 30); perde magia',
  'Após 48 h de estudo em ≤6 dias: Inteligência +2 (máx. 30). Magia se dissipa (1 século). Marque como não mágico / remova.',
  NULL, NULL, 866, NULL, NULL
),
(
  'item-luvas-de-apanhar-projeteis-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'luvas-de-apanhar-projeteis'), NULL,
  'Luvas · Apanhar Projétil', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: −1d10+DES dano; a 0 pode pegar o projétil',
  'Ao ser atingido por arma de Arremesso/à Distância, Reação (mão livre): reduza o dano em 1d10 + mod. DES. Se reduzir a 0, pode pegar a munição/arma se couber na mão.',
  NULL, NULL, 867, NULL, NULL
),
(
  'item-manual-dos-exercicios-beneficos-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manual-dos-exercicios-beneficos'), NULL,
  'Manual · +2 Força', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Estudar 48 h / 6 dias → +2 For (máx. 30); perde magia',
  'Após 48 h de estudo em ≤6 dias: Força +2 (máx. 30). Magia se dissipa (1 século). Marque como não mágico / remova.',
  NULL, NULL, 868, NULL, NULL
),
(
  'item-cachimbo-teratologico-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cachimbo-teratologico'), NULL,
  'Cachimbo · Fumaça Formosa', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: exalar fumaça em forma de criatura (cubo 30 cm)',
  'Ao fumar: Usar Magia exala fumaça em forma de criatura (cabe em cubo 30 cm); perde a forma em segundos.',
  NULL, NULL, 869, NULL, NULL
),
(
  'item-manual-de-rapidez-nas-acoes-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manual-de-rapidez-nas-acoes'), NULL,
  'Manual · +2 Destreza', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Estudar 48 h / 6 dias → +2 Des (máx. 30); perde magia',
  'Após 48 h de estudo em ≤6 dias: Destreza +2 (máx. 30). Magia se dissipa (1 século). Marque como não mágico / remova.',
  NULL, NULL, 870, NULL, NULL
),
(
  'item-capa-de-muitas-modas-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-de-muitas-modas'), NULL,
  'Capa · Mudar Estilo', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: alterar estilo/cor/qualidade aparente',
  'Ação Bônus: mude estilo, cor e qualidade aparente (peso igual; continua sendo só uma capa; sem propriedades de outras capas mágicas).',
  NULL, NULL, 871, NULL, NULL
),
(
  'item-perfume-de-encantamento-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'perfume-de-encantamento'), NULL,
  'Perfume · Encantamento', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Aplicar: Vantagem Enganação/Persuasão 1,5 m / 1 h (consumir)',
  'Usar Magia: aplique em si (1 dose). 1 h: Vantagem em Carisma (Enganação e Persuasão) vs criaturas a até 1,5 m. Remova do inventário.',
  NULL, NULL, 872, NULL, NULL
),
(
  'item-botas-de-caminhar-e-saltar-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-de-caminhar-e-saltar'), NULL,
  'Botas · Caminhar e Saltar', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Desloc. mín. 9 m; 1×/turno salto 9 m por 3 m de movimento',
  'Deslocamento torna-se 9 m (se menor); não reduz por carga/Armadura Pesada. 1× por turno: salte até 9 m gastando só 3 m de movimento.',
  NULL, NULL, 873, NULL, NULL
),
(
  'item-tomo-da-compreensao-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tomo-da-compreensao'), NULL,
  'Tomo · +2 Sabedoria', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Estudar 48 h / 6 dias → +2 Sab (máx. 30); perde magia',
  'Após 48 h de estudo em ≤6 dias: Sabedoria +2 (máx. 30). Magia se dissipa (1 século). Marque como não mágico / remova.',
  NULL, NULL, 874, NULL, NULL
),
(
  'item-tomo-da-lideranca-e-influencia-estudar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tomo-da-lideranca-e-influencia'), NULL,
  'Tomo · +2 Carisma', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Estudar 48 h / 6 dias → +2 Car (máx. 30); perde magia',
  'Após 48 h de estudo em ≤6 dias: Carisma +2 (máx. 30). Magia se dissipa (1 século). Marque como não mágico / remova.',
  NULL, NULL, 875, NULL, NULL
),
(
  'item-membro-protetico-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'membro-protetico'), NULL,
  'Prótese · Acoplar / Remover', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: acoplar ou retirar prótese',
  'Substitui membro perdido. Acoplada funciona como a parte original. Usar Magia: acoplar/retirar; não removível contra a vontade enquanto vivo.',
  NULL, NULL, 876, NULL, NULL
),
(
  'item-manto-da-natureza-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-da-natureza'), NULL,
  'Manto · Natureza', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Foco Druida/Guardião; Esconder (bônus) se Parcialmente Obscurecido',
  'Camufla com o terreno. Foco de conjuração de Druida/Guardião. Em área Parcialmente Obscurecida: Esconder como Ação Bônus mesmo observado.',
  NULL, NULL, 877, NULL, NULL
),
(
  'item-ferraduras-de-velocidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferraduras-de-velocidade'), NULL,
  'Ferraduras · Fixar / +9 m', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: fixar/remover; 4 ferraduras → +9 m Desloc. da montaria',
  'Conjunto de 4. Usar Magia: fixar no casco (ou remover). Com as 4 na mesma criatura: Deslocamento +9 m.',
  NULL, NULL, 878, NULL, NULL
),
(
  'item-olho-ersatz-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-ersatz'), NULL,
  'Olho · Inserir / Remover', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: encaixar ou remover; visão normal',
  'Substitui olho perdido. Encaixado: enxerga como olho natural. Usar Magia: inserir/remover; não removível contra a vontade enquanto vivo.',
  NULL, NULL, 879, NULL, NULL
),
(
  'item-haste-retratil-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'haste-retratil'), NULL,
  'Haste · Retrátil', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: Haste ↔ cetro 30 cm',
  'Funciona como Haste. Usar Magia: reduza a cetro de 30 cm (mesmo peso) ou reverta (só até o espaço permitir).',
  NULL, NULL, 880, NULL, NULL
),
(
  'item-pote-do-despertar-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pote-do-despertar'), NULL,
  'Pote · Arbusto Desperto', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Plantar arbusto 30 dias → Arbusto Desperto (destrói o pote)',
  'Plante arbusto comum; após 30 dias vira Arbusto Desperto (Amigável, obedece). Raízes destroem o vaso — remova o item.',
  NULL, NULL, 881, NULL, NULL
),
(
  'item-corda-autorreparadora-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'corda-autorreparadora'), NULL,
  'Corda · Reunir Pedaços', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: pedaços em contato se unem (15 m)',
  'Corda 15 m. Usar Magia: pedaços em contato e não em uso se unem. Encurta permanentemente se parte for perdida/destruída.',
  NULL, NULL, 882, NULL, NULL
),
(
  'item-lanterna-reveladora-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lanterna-reveladora'), NULL,
  'Lanterna · Revelar Invisível', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Luz Plena 9 m revela invisíveis; tampa → Meia-luz 1,5 m',
  'Acesa: 6 h com 0,5 L de Óleo; Luz Plena 9 m + Meia-luz 9 m. Invisíveis visíveis na Luz Plena. Usar Objeto: abaixar tampa → Meia-luz 1,5 m.',
  NULL, NULL, 883, NULL, NULL
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
