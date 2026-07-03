-- Seed rpg.phb_resource_definition
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('tides-of-chaos', 'Marés do Caos', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('controlled-surge', 'Surto Controlado', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('warp-implosion', 'Implosão de Distorção', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dragon-wings', 'Asas de Dragão', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dragon-companion', 'Companheiro Dracônico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('restore-balance', 'Restaurar Equilíbrio', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('order-trance', 'Transe da Ordem', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('clockwork-cavalcade', 'Cavalgada Mecânica', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('healing-light', 'Luz Medicinal', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('searing-vengeance', 'Vingança Calcinante', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dark-ones-luck', 'A Sorte do Próprio Tenebroso', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('hurl-through-hell', 'Lançar no Inferno', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('fey-steps', 'Passos Feéricos', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('beguiling-defenses', 'Defesas Sedutoras', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
         10)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('clairvoyant-competitor', 'Combatente Clarividente', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('corona-of-light', 'Coroa de Luz', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('tricksters-blessing', 'Bênção do Trapaceiro', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('war-priest', 'Sacerdote da Guerra', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('lunar-step', 'Passo Lunar', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'),
         10)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('natural-recovery', 'Recuperação Natural', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('stellar-guidance', 'Mapa Estelar', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('cosmic-omen', 'Presságio Cósmico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('holy-nimbus', 'Resplendor Sagrado', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('undying-sentinel', 'Sentinela Imortal', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('elder-champion', 'Campeão Ancestral', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('glorious-defense', 'Defesa Gloriosa', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('living-legend', 'Lenda Viva', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('avenging-angel', 'Anjo Vingador', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dread-strike', 'Emboscador das Sombras', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('fey-reinforcements', 'Reforços Feéricos', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         11)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('misty-wanderer', 'Andarilho Nebuloso', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('superiority-dice', 'Superioridade em Combate', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('know-your-enemy', 'Conheça Seu Inimigo', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         7)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('psi-energy-dice', 'Poder Psiônico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('psychic-leap', 'Salto com Impulsão Psíquica', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         7)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('energy-bulwark', 'Baluarte de Energia', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('telekinetic-master', 'Mestre Telecinético', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('intimidating-presence', 'Presença Intimidante', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('divine-fury-dice', 'Campeão dos Deuses', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('zealous-presence', 'Presença Zelosa', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         10)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('rage-of-the-gods', 'Fúria dos Deuses', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('wholeness-of-body', 'Integridade Corporal', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('hand-of-harm-flurry', 'Torrente de Cura e Dolo', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
         11)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('hand-of-ultimate-mercy', 'Mão da Misericórdia Final', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('soulknife-psi-dice', 'Poder Psiônico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('psychic-veil', 'Véu Psíquico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
         13)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('rend-mind', 'Rasgar Mente', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('spell-thief', 'Ladrão de Magias', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
