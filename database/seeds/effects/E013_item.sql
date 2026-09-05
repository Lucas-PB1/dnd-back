-- Item resources — grant_resource (SSOT; grants removidos dos packs DMG/Valda/…)
-- 145 efeitos gerados de phb_resource_grant

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'adaga-peconhenta'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'adagaPeconhentaVenenoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 1,
         'Veneno — Adaga Peçonhenta'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-da-estilha-negra'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'amuletoEstilhaMagiaDesconhecidaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 2,
         'Magia Desconhecida — Amuleto da Estilha Negra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-mecanico'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'amuletoMecanicoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 3,
         'Amuleto Mecânico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'starRingCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 4,
         'Cargas — Anel das Estrelas Cadentes'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'anelArieteCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 5,
         'Cargas — Anel de Ariete'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'anelComandoElementalCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 6,
         'Cargas — Anel de Comando Elemental'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 5,
       FALSE, FALSE, FALSE, '1d4+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-evasao'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'anelEvasaoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 7,
         'Cargas — Anel de Evasão'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-influenciar-animais'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'anelInfluenciarAnimaisCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 8,
         'Cargas — Anel de Influenciar Animais'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-invocar-djinni'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'anelDjinniUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 9,
         'Invocar Djinni — Anel'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'anel-dos-tres-desejos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'anelTresDesejosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 10,
         'Cargas — Anel dos Três Desejos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'arco-do-juramento'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'arcoDoJuramentoJurarUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 11,
         'Jurar — Arco do Juramento'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'arma-magificada'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'armaMagificadaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 12,
         'Cargas — Arma Magificada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'armadura-de-invulnerabilidade'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'armaduraInvulnerabilidadeCarapacaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 13,
         'Carapaça Metálica — Armadura de Invulnerabilidade'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'armadura-magificada'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'armaduraMagificadaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 14,
         'Cargas — Armadura Magificada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'azagaia-relampago'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'azagaiaRelampagoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 15,
         'Relâmpago — Azagaia Relâmpago'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'bag-of-cheer'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bagOfCheerGifts'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 16,
         'Presentes da Bolsa da Alegria'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'batuta-da-regencia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'batutaRegenciaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 17,
         'Cargas — Batuta da Regência'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal-de-telepatia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bolaCristalTelepatiaSugestaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 18,
         'Sugestão — Bola de Cristal de Telepatia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-das-tropelias'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bolsaTropeliasCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 19,
         'Objetos — Bolsa das Tropelias'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-de-temperos-prestativa-de-howard'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'bolsaTemperosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 20,
         'Cargas — Bolsa de Temperos Prestativa de Howard'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'botas-aladas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'botasAladasCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 21,
         'Cargas — Botas Aladas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 4,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'botas-de-velocidade'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'botasVelocidadeUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 22,
         'Velocidade — Botas de Velocidade'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'braseiro-de-comandar-elementais-do-fogo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'braseiroFogoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 23,
         'Braseiro · Elemental do Fogo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-avicular'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoAvicularCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 24,
         'Cargas — Cajado Avicular'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-cura'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoCuraCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 25,
         'Cargas — Cajado da Cura'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-piton'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoPitonUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 26,
         'Cobra Constritora — Cajado da Píton'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoTrovoadaGolpeUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 27,
         'Golpe de Relâmpago — Cajado da Trovoada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoTrovoadaRelampagoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 28,
         'Relâmpago — Cajado da Trovoada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoTrovoadaTrovaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 29,
         'Trovão — Cajado da Trovoada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-da-trovoada-relampejante'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoTrovoadaTrovoadaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 30,
         'Trovoada — Cajado da Trovoada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-das-matas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoMatasCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 31,
         'Cargas — Cajado das Matas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-de-flores'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoFloresCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 32,
         'Cargas — Cajado de Flores'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-acrobata'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoAcrobataDeflexaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 33,
         'Deflexão — Cajado do Acrobata'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-agravo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoAgravoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 34,
         'Cargas — Cajado do Agravo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-definhamento'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoDefinhamentoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 35,
         'Cargas — Cajado do Definhamento'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-enxame-de-insetos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoEnxameCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 36,
         'Cargas — Cajado do Enxame de Insetos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-fogo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoFogoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 37,
         'Cargas — Cajado do Fogo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-gelo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoGeloCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 38,
         'Cargas — Cajado do Gelo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoPoderCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 39,
         'Cargas — Cajado do Poder'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 20,
       FALSE, FALSE, FALSE, '2d8+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoMagiCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 40,
         'Cargas — Cajado dos Magi'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 50,
       FALSE, FALSE, FALSE, '4d6+2'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoSortilegiosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 41,
         'Cargas — Cajado dos Sortilégios'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoSortilegiosResistUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 42,
         'Resistir Encantamento — Cajado dos Sortilégios'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-magificado'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cajadoMagificadoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 43,
         'Cargas — Cajado Magificado'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'caldeiraoPocaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 44,
         'Poção — Caldeirão do Renascimento'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'caldeiraoReviverUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 45,
         'Reviver — Caldeirão do Renascimento'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'capa-aracnidea'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'capaAracnideaTeiaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 46,
         'Teia — Capa Aracnídea'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'capa-do-saltimbanco'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'capaSaltimbancoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 47,
         'Porta Dimensional — Capa do Saltimbanco'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'carrilhao-destrancador'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'carrilhaoDestrancadorCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 48,
         'Usos — Carrilhão Destrancador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-das-muitas-magias'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'chapeuMuitasMagiasUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 49,
         'Magia Desconhecida — Chapéu das Muitas Magias'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-magos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'chapeuMagosTruqueUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 50,
         'Truque Desconhecido — Chapéu dos Magos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-vermes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'chapeuVermesCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 51,
         'Cargas — Chapéu dos Vermes'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'chifre-do-alarme-silencioso'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'chifreAlarmeSilenciosoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 52,
         'Cargas — Chifre do Alarme Silencioso'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 4,
       FALSE, FALSE, FALSE, '1d4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'colar-dos-pensamentos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'colarPensamentosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 53,
         'Cargas — Colar dos Pensamentos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 5,
       FALSE, FALSE, FALSE, '1d4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-de-invocacao'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cuboInvocacaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 54,
         'Invocação — Cubo de Invocação'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cuboEnergeticoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 55,
         'Cargas — Cubo Energético'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-portal'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'cuboPortalCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 56,
         'Cargas — Cubo Portal'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'demonomicoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 57,
         'Cargas — Demonômico de Iggwilv'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 8,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'demonomicoContencaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 58,
         'Contenção — Demonômico de lggwilv'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'diadema-da-explosao'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'diademaExplosaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 59,
         'Diadema da Explosão'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'dream-executioner'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'dreamExecutionerSoul'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 60,
         'Alma Colhida'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'elmoTelepatiaDetectarUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 61,
         'Detectar Pensamentos — Elmo de Telepatia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'elmoTelepatiaSugestaoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 62,
         'Sugestão — Elmo de Telepatia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-teleporte'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'elmoTeleporteCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 63,
         'Cargas — Elmo de Teleporte'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'escara-gelida'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'escaraGelidaExtinguirUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 64,
         'Extinguir — Escara Gélida'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'escaravelho-de-protecao'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'escaravelhoProtecaoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 65,
         'Cargas — Escaravelho de Proteção'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 12,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-do-cavaleiro'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'escudoCavaleiroCampoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 66,
         'Campo de Proteção — Escudo do Cavaleiro'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'espadaKasConvocarRelampagosUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 67,
         'Convocar Relâmpagos — Espada de Kas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'espadaKasDedoDaMorteUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 68,
         'Dedo da Morte — Espada de Kas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'espadaKasPalavraSagradaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 69,
         'Palavra Sagrada — Espada de Kas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'faixas-de-ferro-de-bilarro'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'faixasBilarroUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 70,
         'Faixas — Bilarro'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-atormentadora'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'flautaAtormentadoraCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 71,
         'Cargas — Flauta Atormentadora'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-dos-esgotos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'flautaEsgotosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 72,
         'Cargas — Flauta dos Esgotos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'frog-prince-statuette'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'frogPrinceUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 73,
         'Estatueta do Príncipe Sapo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'galvanized-claw'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'galvanizedClawCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 74,
         'Cargas da Garra Galvanizada'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'gambler-s-coin'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gamblerCoinCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 75,
         'Cargas da Moeda do Apostador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'garra-silvestre'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'garraSilvestreMensagemUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 76,
         'Mensagem — Garra Silvestre'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-claridade'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gemaClaridadeCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 77,
         'Cargas — Gema da Claridade'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 50,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-visao'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'gemaVisaoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 78,
         'Cargas — Gema da Visão'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'incensario-de-controlar-elementais-do-ar'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'incensarioArUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 79,
         'Incensário · Elemental do Ar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical-de-escrita'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'instrumentoEscritaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 80,
         'Cargas — Instrumento Musical de Escrita'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'jarro-alquimico'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'jarroAlquimicoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 81,
         'Produzir Líquido — Jarro Alquímico'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-da-sorte'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'laminaDaSorteDesejoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 82,
         'Desejo — Lâmina da Sorte'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-da-sorte'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'laminaDaSorteSorteUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 83,
         'Sorte — Lâmina da Sorte'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'leonora-s-throne-of-indolence'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'throneFeast'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 84,
         'Banquete do Trono'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'livroTrevasAnimarMortosUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 85,
         'Animar Mortos — Livro das Trevas Profanas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'livroTrevasCirculoDaMorteUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 86,
         'Círculo da Morte — Livro das Trevas Profanas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'livroTrevasDedoDaMorteUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 87,
         'Dedo da Morte — Livro das Trevas Profanas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'livroTrevasDominarMonstroUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 88,
         'Dominar Monstro — Livro das Trevas Profanas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'loriga-de-escamas-draconicas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'lorigaEscamasDraconicasDetectarUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 89,
         'Detectar Dragão — Loriga de Escamas Dracônicas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'lunamina'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'lunaminaBrilhoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 90,
         'Brilho — Lunâmina (prop. 86–95)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'maca-do-terror'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'macaTerrorCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 91,
         'Cargas — Maça do Terror'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'machadoElementalTerraUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 92,
         'Elemental da Terra — Machado dos Senhores Anões'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'machadoTeleporteUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 93,
         'Teleporte — Machado dos Senhores Anões'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'manto-das-asas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'mantoAsasUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 94,
         'Asas — Manto das Asas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'manto-de-invisibilidade'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'mantoInvisibilidadeCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 95,
         'Cargas — Manto de Invisibilidade'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'manto-do-morcego'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'mantoMorcegoPolimorfiaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 96,
         'Polimorfia — Manto do Morcego'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'martelo-do-trovao'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'marteloDoTrovaoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 97,
         'Cargas — Martelo do Trovão'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 5,
       FALSE, FALSE, FALSE, '1d4+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'moeda-rival'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'moedaRivalUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 98,
         'Lançar — Moeda Rival'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'olho-de-megera'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'olhoMegeraCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 99,
         'Cargas — Olho de Megera'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'maoVecnaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 100,
         'Cargas — Mão de Vecna'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 8,
       FALSE, FALSE, FALSE, '1d4+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'olhoMaoVecnaDesejoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 101,
         'Desejo — Olho e Mão de Vecna'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'olhoVecnaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 102,
         'Cargas — Olho de Vecna'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 8,
       FALSE, FALSE, FALSE, '1d4+4'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-de-enfeiticar'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'olhosEnfeiticarCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 103,
         'Cargas — Olhos de Enfeitiçar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'onda'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'ondaComandoAquaticoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 104,
         'Cargas — Onda (Comando Aquático)'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'onda'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'ondaGloboUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 105,
         'Globo de Invulnerabilidade — Onda'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'opressorDetectarBemMalUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 106,
         'Detectar Bem e Mal — Opressor'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'opressorLocalizarObjetoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 107,
         'Localizar Objeto — Opressor'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'opressorOndaChoqueUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 108,
         'Onda de Choque — Opressor'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'orbe-flutuante'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'orbeFlutuanteLuzDiaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 109,
         'Luz do Dia — Orbe Flutuante'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'orbesDraconicosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 110,
         'Cargas — Orbes Dracônicos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'orphans-cradle'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'orphansCradlePurify'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 111,
         'Miasma Purificador'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pedra-de-controlar-elementais-da-terra'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'pedraTerraUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 112,
         'Pedra · Elemental da Terra'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'pedras-mensageiras'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'pedrasMensageirasUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 113,
         'Remeter — Pedras Mensageiras'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'periapto-de-saude'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'periaptSaudeUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 114,
         'Periapto de Saúde'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'perola-de-poder'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'perolaPoderUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 115,
         'Pérola de Poder'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'po-de-espirro-engasgo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'poEspirroEngasgoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 116,
         'Uso — Pó de Espirro e Engasgo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'poco-dos-mundos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'pocoMundosUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 117,
         'Portal — Poço dos Mundos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'ring-of-barrels'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'ringBarrelCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 118,
         'Cargas do Anel dos Barris'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'shardOfMoonlightCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 119,
         'Cargas do Estilhaço do Luar'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 10,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'soul-figurine'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'soulFigurineWard'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 120,
         'Figurinha da Alma'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tabuleiro-espiritual'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tabuleiroEspiritualCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 121,
         'Cargas — Tabuleiro Espiritual'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tacape-trovejante'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tacapeTerremotoUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 122,
         'Terremoto — Tacape Trovejante'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-do-bem-sem-ver-a-quem'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'talismaBemCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 123,
         'Cargas — Talismã do Bem Sem Ver a Quem'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-do-mal-universal'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'talismaMalCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 124,
         'Cargas — Talismã do Mal Universal'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tigela-de-comandar-elementais-da-agua'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tigelaAguaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 125,
         'Tigela · Elemental da Água'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tomo-das-palavras-tranquilizantes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tomoPalavrasUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 126,
         'Conjurar — Tomo das Palavras Tranquilizantes'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tridente-de-comandar-peixes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tridenteComandarPeixesCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 127,
         'Cargas — Tridente de Comandar Peixes'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'trombeta-do-valhalla'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'trombetaValhallaUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 128,
         'Soprar — Trombeta do Valhalla'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, FALSE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-cores-cintilantes'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tunicaCoresCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 129,
         'Cargas — Túnica das Cores Cintilantes'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-estrelas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'tunicaEstrelasCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 130,
         'Estrelas — Túnica das Estrelas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 6,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-cuspidora-de-fogo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaCuspidoraFogoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 131,
         'Cargas — Varinha Cuspidora de Fogo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-das-maravilhas'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaMaravilhasCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 132,
         'Cargas — Varinha das Maravilhas'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-detectar-inimigo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaDetectarInimigoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 133,
         'Cargas — Varinha de Detectar Inimigo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-misseis-magicos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaMisseisCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 134,
         'Cargas — Varinha de Mísseis Mágicos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaOrcusCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 135,
         'Cargas — Varinha de Orcus'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaOrcusConvocarUse'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 136,
         'Convocar Mortos-Vivos — Varinha de Orcus'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE, NULL
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-paralisia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaParalisiaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 137,
         'Cargas — Varinha de Paralisia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-polimorfia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaPolimorfiaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 138,
         'Cargas — Varinha de Polimorfia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-relampagos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaRelampagosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 139,
         'Cargas — Varinha de Relâmpagos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-teia'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaTeiaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 140,
         'Cargas — Varinha de Teia'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-do-medo'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaMedoCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 141,
         'Cargas — Varinha do Medo'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-dos-segredos'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaSegredosCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 142,
         'Cargas — Varinha dos Segredos'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d3'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-farejadora-de-magias'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaFarejadoraCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 143,
         'Cargas — Varinha Farejadora de Magias'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 3,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-imobilizadora'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaImobilizadoraCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 144,
         'Cargas — Varinha Imobilizadora'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;

WITH owner AS (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-pirotecnica'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'varinhaPirotecnicaCharges'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'item'::rpg.effect_owner_kind, owner.id,
         'on_build'::rpg.effect_trigger, 1, 145,
         'Cargas — Varinha Pirotécnica'
  FROM owner
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long, recover_on_long_dice
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 7,
       FALSE, FALSE, FALSE, '1d6+1'
FROM ins CROSS JOIN rd;
