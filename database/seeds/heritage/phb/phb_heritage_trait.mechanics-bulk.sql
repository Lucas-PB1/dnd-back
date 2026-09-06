-- GH heritage traits — economia Cap. 1 (44 ações)
-- Gerado por scripts/classify-gh-heritage-trait-mechanics.mjs

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-astute-slip-bonus',
  ht.id,
  'Escorregão Astuto',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Escorregão Astuto',
  'Even in the thick of battle, anything that obscures your enemies’ view of you gives you a chance to strike unseen. Você pode realizar the Hide action como Ação Bônus on each of your turns. Você deve have appropriate cover to attempt to hide, as normal.',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'astute-slip'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-born-lucky-reaction',
  ht.id,
  'Nascido Sob a Sorte',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-born-lucky',
  TRUE,
  'Nascido Sob a Sorte',
  'Fortune favors you at times when a threat might send you down. Quando você fail a salvaguarda, você pode use your Reação to roll a d4 and add it to the save, potentially turning it into a success. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'born-lucky'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-centered-edge-bonus',
  ht.id,
  'Fio Centrado',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-centered-edge',
  TRUE,
  'Fio Centrado',
  'By focusing your inner strength, you gain a needed edge. Como Ação Bônus, you grant yourself Vantagem on uma jogada de ataque or ability check you make before the start of your next turn. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'centered-edge'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-damage-immunity-reaction-x2',
  ht.id,
  'Imunidade a Dano (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-damage-immunity-x2',
  TRUE,
  'Imunidade a Dano (aprimorado)',
  'Damage Imunidade. Se você take this trait twice, como Reação to taking damage of the type you chose for Damage Resistência, you gain Imunidade to that damage type até o fim do seu próximo turno. You regain the use este recurso when you finish a Descanso Curto.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'damage-immunity'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-determined-hearing-reaction-x2',
  ht.id,
  'Audição Determinada (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-determined-hearing-x2',
  TRUE,
  'Audição Determinada (aprimorado)',
  'Determined Hearing. Se você take this trait twice, you have Vantagem on Percepção checks involving hearing. Além disso, when you fail a salvaguarda against being Deafened, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'determined-hearing'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-ethereal-focus-action',
  ht.id,
  'Foco Etéreo',
  'action'::rpg.action_economy_bucket,
  1,
  'gh-ethereal-focus',
  TRUE,
  'Foco Etéreo',
  'Shifting away from the mortal world lets you move through and observe that world unseen. Como ação Mágica, you fade from the Material Plane into the Ethereal Plane por 1 minuto. While you remain in this state, você pode’t interact with the Material Plane, and effects on the Material Plane can’t affect you, including spells and creatures. Você pode move and hear as normal, and you see everything in shades of gray. When the effect ends, you reappea',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'ethereal-focus'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-expert-improviser-bonus',
  ht.id,
  'Improvisador Expert',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-expert-improviser',
  TRUE,
  'Improvisador Expert',
  'When needs demand, you get the job done better than most. Como Ação Bônus, choose one skill or tool that you don’t have proficiency with. Você tem proficiency in that skill or with that tool por 1 hora. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'expert-improviser'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-extended-fortification-reaction-x2',
  ht.id,
  'Fortificação Estendida (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-extended-fortification-x2',
  TRUE,
  'Fortificação Estendida (aprimorado)',
  'Extended Fortification. Se você take this trait multiple times, you have Vantagem on salvaguardas using a new ability score each time.

Além disso, se você fail a salvaguarda against a spell or other magical effect and you do not have proficiency with that salvaguarda, você pode use your Reação to reroll the save. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'extended-fortification'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-focused-edge-reaction',
  ht.id,
  'Fio Concentrado',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-focused-edge',
  TRUE,
  'Fio Concentrado',
  'No matter how badly beaten down you are, you find the will to keep fighting when you most need it. Como Reação after you take damage, você pode roll um número de d6s igual a your Bônus de Proficiência and gain Pontos de Vida Temporários igual a the total. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'focused-edge'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-focused-ruthlessness-reaction',
  ht.id,
  'Crueldade Concentrada',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-focused-ruthlessness',
  TRUE,
  'Crueldade Concentrada',
  'A creature that gets the drop on you is met with a swift and brutal reply. Quando você realiza damage from a creature within your reach, você pode use your Reação to make a melee attack with a weapon or an Ataque Desarmado against that creature. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'focused-ruthlessness'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-furious-charge-bonus',
  ht.id,
  'Investida Furiosa',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Investida Furiosa',
  'The fury with which you throw yourself into battle forces your foes to feel your wrath. Se você move at least 6 m straight toward a target and then hit it with a melee attack with a weapon or an Ataque Desarmado on the same turn, você pode make another attack against the same target como Ação Bônus with the same weapon.',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'furious-charge'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-helpful-tactics-bonus',
  ht.id,
  'Táticas Úteis',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Táticas Úteis',
  'You excel at aiding your allies, knowing that the time will come when you need them to return the favor. Você pode usar the ação Ajudar como Ação Bônus to assist any ally making an ability check. (This is an Exploration trait.)',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'helpful-tactics'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-immutable-mind-reaction-x2',
  ht.id,
  'Mente Inabalável (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-immutable-mind-x2',
  TRUE,
  'Mente Inabalável (aprimorado)',
  'Immutable Mind. Se você take this trait twice, when you fail a salvaguarda against being Charmed, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'immutable-mind'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-incomparable-roar-bonus',
  ht.id,
  'Rugido Incomparável',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-incomparable-roar',
  TRUE,
  'Rugido Incomparável',
  'Your battle cry can cause even the most formidable foes to quail before you. Como Ação Bônus, you emit a roar, shout, or other loud vocal outburst. Each creature de sua escolha within 3 m of you that can hear you must succeed on a Sabedoria salvaguarda (CD = 8 + your Bônus de Proficiência + your modificador de Constituição) or have the Amedrontado condtion até o fim do seu próximo turno. You regain the use of este recurso when you finish a Descan',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'incomparable-roar'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-infectious-bravery-reaction-x2',
  ht.id,
  'Coragem Contagiante (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-infectious-bravery-x2',
  TRUE,
  'Coragem Contagiante (aprimorado)',
  'Infectious Bravery. Se você take this trait twice, você pode use your Reação to bolster the spirits of your allies, granting one ally who can see or hear you Vantagem on a salvaguarda against being Amedrontado. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'infectious-bravery'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-long-fade-bonus',
  ht.id,
  'Desvanecimento Longo',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Desvanecimento Longo',
  'Você tem learned to avoid notice at all costs, letting you momentarily obscure yourself from observation. Como Ação Bônus, você pode take the Hide action to conceal yourself without needing to be Heavily Obscured or behind Three-Quarters Cover or Total Cover . You need not be out of a creature’s line of sight to use this ability.',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'long-fade'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-mobile-bastion-action',
  ht.id,
  'Bastião Móvel',
  'action'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Bastião Móvel',
  'Focusing all your resolve, you stand fast and watch your enemies flail against your defenses. Como ação Mágica, you become motionless and gain o seguinte effects:',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'mobile-bastion'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-mobile-bastion-bonus-x2',
  ht.id,
  'Bastião Móvel (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Bastião Móvel (aprimorado)',
  'Você pode’t take actions, and você pode’t use your Ação Bônus except to end the effect of this trait.

Mobile Bastion. Se você take this trait twice, when you use Personal Bastion, your Speed is reduced to half your normal Speed (rounded down), you do not have Desvantagem on Destreza salvaguardas, and você pode use Ação Bônuss.',
  NULL,
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'mobile-bastion'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-moving-insight-reaction',
  ht.id,
  'Intuição em Movimento',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-moving-insight',
  TRUE,
  'Intuição em Movimento',
  'A lifetime spent wandering lets you judge when others’ movement works to your benefit. Quando você make uma jogada de ataque against a creature or make a salvaguarda against a creature’s attack, spell, or ability, você pode use a Reação to have Vantagem on the jogada de ataque or salvaguarda if that creature moved since the end of your last turn. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expe',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'moving-insight'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-moving-insight-reaction-x2',
  ht.id,
  'Intuição em Movimento (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Intuição em Movimento (aprimorado)',
  'Moving Intuição. Se você take this trait twice, Enemy in Motion also lets you use your Reação to affect an ally''s jogada de ataque or salvaguarda se vocêr ally is within 9 m.',
  NULL,
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'moving-insight'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-overwhelming-shove-bonus',
  ht.id,
  'Empurrão Avassalador',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Empurrão Avassalador',
  'Your powerful blows send your targets reeling. Quando você acerta uma creature no more than one size larger than you with a melee attack, você pode use a Ação Bônus to attempt to shove that creature. The target must succeed on a Força or Destreza salvaguarda (CD = 8 + your modificador de Força + your Bônus de Proficiência) or be pushed up to 3 m away from you.',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'overwhelming-shove'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-pack-instinct-reaction',
  ht.id,
  'Instinto de Matilha',
  'reaction'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Instinto de Matilha',
  'Staying close to your allies in combat makes you even more dangerous. Quando você start your turn with at least one ally who isn’t Incapacitado within 1,5 m of another creature você pode see, você pode use your Reação to have Vantagem on jogada de ataques against that creature até o fim de your turn.',
  NULL,
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'pack-instinct'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-pack-leader-reaction',
  ht.id,
  'Líder de Matilha',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-pack-leader',
  TRUE,
  'Líder de Matilha',
  'Fighting in the thick of battle lets you aid your allies when it counts. When an ally within 3 m of you is about to make uma jogada de ataque or a salvaguarda, você pode use a Reação to grant that ally Vantagem on the attack or save. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'pack-leader'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-phase-shift-bonus',
  ht.id,
  'Mudança de Fase',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-phase-shift',
  TRUE,
  'Mudança de Fase',
  'Your corporeal presence shifts and fades, softening your enemies’ ability to harm you. Como Ação Bônus, por 1 minuto, all creatures have Desvantagem on jogada de ataques against you, and você pode move through other creature’s spaces without treating them as Difficult Terrain. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'phase-shift'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-poison-indemnity-reaction-x2',
  ht.id,
  'Indenização ao Veneno (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-poison-indemnity-x2',
  TRUE,
  'Indenização ao Veneno (aprimorado)',
  'Poison Indemnity. Se você take this trait twice, when you fail a salvaguarda against being Envenenado, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'poison-indemnity'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-potent-breath',
  ht.id,
  'Sopro Potente',
  'action'::rpg.action_economy_bucket,
  1,
  'potentBreath',
  TRUE,
  'Sopro Potente',
  'A connection to draconic or elemental fury lets you unleash a blast of destructive energy. Quando você select this trait, choose a damage type: Acid, Cold, Fire, Lightning, Poison, or Thunder. Then choose an area of effect: a Line that is 1,5 m wide and 9 m long, or a 4,5 m Cone .',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'potent-breath'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-potent-breath-action-x2',
  ht.id,
  'Sopro Potente (2×)',
  'action'::rpg.action_economy_bucket,
  1,
  'gh-potent-breath-x2',
  TRUE,
  'Sopro Potente (aprimorado)',
  'Quando você use a ação Mágica to expel your Breath Weapon, each creature in the area of effect must make a Destreza salvaguarda (CD = 8 + your modificador de Constituição + your Bônus de Proficiência). A target creature takes 1d8 damage of the chosen type on a failed save, or half as much damage on a successful one. This damage increases by 1d8 when you reach character levels 5 (2d8), 11 (3d8), and 17 (4d8).

Você pode usar este recurso um número',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'potent-breath'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-protective-cover-reaction-x2',
  ht.id,
  'Cobertura Protetora (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-protective-cover-x2',
  TRUE,
  'Cobertura Protetora (aprimorado)',
  'Protective Cover. Se você take this trait twice, when you make a Destreza salvaguarda or are targeted by a ranged attack, você pode use a Reação to have Vantagem on the salvaguarda or impose Desvantagem on the ranged jogada de ataque. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.

Alternate Rules: Wounds and Resting

The Grim Hollow Campaign Guide c',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'protective-cover'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-quickened-swim-bonus-x2',
  ht.id,
  'Natação Acelerada (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Natação Acelerada (aprimorado)',
  'Quickened Swim. Se você take this trait twice, você pode use the Dash action como Ação Bônus while swimming.',
  NULL,
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'quickened-swim'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-resolute-sight-reaction-x2',
  ht.id,
  'Visão Resoluta (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-resolute-sight-x2',
  TRUE,
  'Visão Resoluta (aprimorado)',
  'Resolute Sight. Se você take this trait twice, when you fail a salvaguarda against having the Blinded condition, você pode use your Reação to succeed on the save instead. You regain the use of este recurso after you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'resolute-sight'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-shared-fleetness-bonus-x2',
  ht.id,
  'Agilidade Compartilhada (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-shared-fleetness-x2',
  TRUE,
  'Agilidade Compartilhada (aprimorado)',
  'Shared Fleetness. Se você take this trait twice, your Speed increases by another 1,5 m, for a total increase of 3 m.

Além disso, como Ação Bônus, choose any number of creatures within 9 m. Those creatures gain a 10 foot bonus to their Speed por 1 minuto. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'shared-fleetness'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-shared-movement-bonus-x2',
  ht.id,
  'Movimento Compartilhado (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Movimento Compartilhado (aprimorado)',
  'Shared Movement. Se você take this trait multiple times, you gain its benefits for a new environment each time. Além disso, while in any environment chosen for Natural Movement, como Ação Bônus, você pode grant creatures de sua escolha the benefit of Natural Movement por 1 hora, as long as those creatures remain within 36 m of you and can see you.',
  NULL,
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'shared-movement'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-slip-free-reaction-x2',
  ht.id,
  'Libertação Ágil (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-slip-free-x2',
  TRUE,
  'Libertação Ágil (aprimorado)',
  'Slip Free. Se você take this trait twice, when you fail a salvaguarda against being Restrained, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'slip-free'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-smoker-bonus-x2',
  ht.id,
  'Fumante (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-smoker-x2',
  TRUE,
  'Fumante (aprimorado)',
  'Além disso, você pode use your Tinker’s Tools and 10 PO worth of appropriate materials to spend 10 minutes creating a small clockwork device. The device must fit in the palm of your hand, and can serve one of o seguinte functions:

Smoker. The device exudes smoke in a 1,5 m Cube por 1 minuto. Any objects or creatures within this Cube are considered Lightly Obscured .

Lighter. The device emits a small flame the size of a candle’s that can light f',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'smoker'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-spirit-s-strength-reaction-x2',
  ht.id,
  'Força do Espírito (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-spirit-s-strength-x2',
  TRUE,
  'Força do Espírito (aprimorado)',
  'Spirit’s Força. Se você take this trait twice, when you fail a salvaguarda against an effect that deals dano Psíquico, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'spirit-s-strength'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-stalwart-edge-reaction',
  ht.id,
  'Fio Inabalável',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-stalwart-edge',
  TRUE,
  'Fio Inabalável',
  'Each time you lay into a foe, their state of peril lends you vigor. Quando você acerta uma creature with a melee attack, você pode use your Reação to roll um número de d4s igual a your Bônus de Proficiência and gain Pontos de Vida Temporários igual a the total rolled. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'stalwart-edge'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-stand-fast-reaction-x2',
  ht.id,
  'Firmeza (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-stand-fast-x2',
  TRUE,
  'Firmeza (aprimorado)',
  'Stand Fast. Se você take this trait twice, standing from Caído takes only five feet of movement instead of half your movement.

Além disso, when you fail a salvaguarda against being knocked Caído, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.

Don’t stay down. Never stay down. Se você stay down, you’re dead.

—Caçador de Monstros’s Guide to Sobrevivência',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'stand-fast'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-strength-of-life-reaction-x2',
  ht.id,
  'Força da Vida (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-strength-of-life-x2',
  TRUE,
  'Força da Vida (aprimorado)',
  'Força of Life. Se você take this trait twice, when you fail a salvaguarda against an effect that deals dano Necrótico, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'strength-of-life'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-supreme-skirmisher-bonus-x2',
  ht.id,
  'Escaramuçador Supremo (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Escaramuçador Supremo (aprimorado)',
  'Supreme Skirmisher. Se você take this trait twice, when you hit a hostile creature with an attack with a weapon attack or an Ataque Desarmado, você pode take the Desengajar action como Ação Bônus até o fim de your turn.',
  NULL,
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'supreme-skirmisher'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-supreme-slip-reaction-x2',
  ht.id,
  'Escorregão Supremo (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-supreme-slip-x2',
  TRUE,
  'Escorregão Supremo (aprimorado)',
  'Supreme Slip. Se você take this trait twice, when you fail an Atletismo or Acrobatics check to escape a grapple, você pode use your Reação to succeed instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'supreme-slip'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-swift-strike-bonus-x2',
  ht.id,
  'Golpe Rápido (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-swift-strike-x2',
  TRUE,
  'Golpe Rápido (aprimorado)',
  'Swift Strike. Se você take this trait twice, você pode use Ataque Desarmado como Ação Bônus. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'swift-strike'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-unparalleled-endurance-reaction-x2',
  ht.id,
  'Resistência Incomparável (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  NULL,
  FALSE,
  'Resistência Incomparável (aprimorado)',
  'Unparalleled Endurance. Se você take this trait twice, when you use Relentless Endurance, you drop to 1d6 Pontos de Vida + your Bônus de Proficiência. Além disso, when you use Relentless Endurance, você pode use a Reação to spend up to five Dados de Vida, rolling them and gaining that number of Pontos de Vida.',
  NULL,
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'unparalleled-endurance'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-vigorous-reaction-x2',
  ht.id,
  'Vigoroso (2×)',
  'reaction'::rpg.action_economy_bucket,
  1,
  'gh-vigorous-x2',
  TRUE,
  'Vigoroso (aprimorado)',
  'Vigorous. Se você take this trait twice, when you fail a salvaguarda against Exhaustion, você pode use your Reação to succeed on the save instead. You regain the use of este recurso when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'vigorous'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  'heritage-wall-walker-bonus-x2',
  ht.id,
  'Caminhante de Paredes (2×)',
  'bonus'::rpg.action_economy_bucket,
  1,
  'gh-wall-walker-x2',
  TRUE,
  'Caminhante de Paredes (aprimorado)',
  'Wall Walker. Se você take this trait twice, você pode use your Climb Speed to move up, down, and across vertical surfaces and upside down along ceilings, while leaving your hands free.

Além disso, while using climbing movement, você pode use the Dash action como Ação Bônus. Você pode usar este recurso um número de times igual a your Bônus de Proficiência, regaining all expended uses when you finish a Descanso Longo.',
  'spend-resource',
  760,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'wall-walker'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  min_trait_takes = EXCLUDED.min_trait_takes;

