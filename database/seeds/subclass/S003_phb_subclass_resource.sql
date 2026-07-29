-- Seed rpg.phb_subclass_resource
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'tides-of-chaos'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Marés do Caos'
       WHERE s.slug = 'wild-magic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'controlled-surge'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Surto Controlado'
       WHERE s.slug = 'wild-magic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'warp-implosion'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Implosão de Distorção'
       WHERE s.slug = 'aberrant'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dragon-wings'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Asas de Dragão'
       WHERE s.slug = 'draconic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dragon-companion'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Companheiro Dracônico'
       WHERE s.slug = 'draconic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'restore-balance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Restaurar Equilíbrio'
       WHERE s.slug = 'clockwork'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'order-trance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Transe da Ordem'
       WHERE s.slug = 'clockwork'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'clockwork-cavalcade'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Cavalgada Mecânica'
       WHERE s.slug = 'clockwork'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'level_plus_one'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'healing-light'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Luz Medicinal'
       WHERE s.slug = 'celestial'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'searing-vengeance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Vingança Calcinante'
       WHERE s.slug = 'celestial'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dark-ones-luck'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'A Sorte do Próprio Tenebroso'
       WHERE s.slug = 'fiend'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'hurl-through-hell'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Lançar no Inferno'
       WHERE s.slug = 'fiend'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'fey-steps'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Passos Feéricos'
       WHERE s.slug = 'archfey'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 10, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'beguiling-defenses'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Defesas Sedutoras'
       WHERE s.slug = 'archfey'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'clairvoyant-competitor'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Combatente Clarividente'
       WHERE s.slug = 'great-old-one'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'corona-of-light'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Coroa de Luz'
       WHERE s.slug = 'light'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'tricksters-blessing'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Bênção do Trapaceiro'
       WHERE s.slug = 'trickery'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'war-priest'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Sacerdote da Guerra'
       WHERE s.slug = 'war'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 10, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'lunar-step'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Passo Lunar'
       WHERE s.slug = 'moon'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'natural-recovery'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Recuperação Natural'
       WHERE s.slug = 'land'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'stellar-guidance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Mapa Estelar'
       WHERE s.slug = 'stars'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'cosmic-omen'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Presságio Cósmico'
       WHERE s.slug = 'stars'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'holy-nimbus'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Resplendor Sagrado'
       WHERE s.slug = 'devotion'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'undying-sentinel'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Sentinela Imortal'
       WHERE s.slug = 'ancients'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'elder-champion'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Campeão Ancestral'
       WHERE s.slug = 'ancients'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'glorious-defense'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Defesa Gloriosa'
       WHERE s.slug = 'glory'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'living-legend'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Lenda Viva'
       WHERE s.slug = 'glory'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'avenging-angel'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Anjo Vingador'
       WHERE s.slug = 'vengeance'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dread-strike'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Emboscador das Sombras'
       WHERE s.slug = 'gloom-stalker'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 11, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'fey-reinforcements'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Reforços Feéricos'
       WHERE s.slug = 'fey-wanderer'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'misty-wanderer'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Andarilho Nebuloso'
       WHERE s.slug = 'fey-wanderer'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'superiority_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'superiority-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Superioridade em Combate'
       WHERE s.slug = 'battle-master'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 7, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'know-your-enemy'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Conheça Seu Inimigo'
       WHERE s.slug = 'battle-master'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'psi_energy_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'psi-energy-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Poder Psiônico'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 7, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'psychic-leap'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Adepto Telecinético'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'energy-bulwark'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Baluarte de Energia'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'telekinetic-master'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Mestre Telecinético'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'intimidating-presence'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Presença Intimidante'
       WHERE s.slug = 'berserker'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'zealot_healing_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'divine-fury-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Campeão dos Deuses'
       WHERE s.slug = 'zealot'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 10, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'zealous-presence'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Presença Zelosa'
       WHERE s.slug = 'zealot'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'rage-of-the-gods'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Fúria dos Deuses'
       WHERE s.slug = 'zealot'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'wholeness-of-body'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Integridade Corporal'
       WHERE s.slug = 'open-hand'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 11, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'hand-of-harm-flurry'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Torrente de Cura e Dolo'
       WHERE s.slug = 'mercy'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'hand-of-ultimate-mercy'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Mão da Misericórdia Final'
       WHERE s.slug = 'mercy'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'psi_energy_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'soulknife-psi-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Poder Psiônico'
       WHERE s.slug = 'soulknife'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 13, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'psychic-veil'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Véu Psíquico'
       WHERE s.slug = 'soulknife'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'rend-mind'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Rasgar Mente'
       WHERE s.slug = 'soulknife'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;

INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'spell-thief'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Ladrão de Magias'
       WHERE s.slug = 'arcane-trickster'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
