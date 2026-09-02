-- Recursos Character Threads (Northlands) — usos 1/DL (MVP mesa)
-- slug do resource = benefit_key do N036 (exceto Grande Sacrifício Cursemarked)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, thread_slug, min_level)
VALUES
  ('wrath', 'Ira', 'character_thread'::rpg.resource_scope, 'bloodsworn', 1),
  ('tenacity', 'Tenacidade', 'character_thread'::rpg.resource_scope, 'bloodsworn', 1),
  (
    'cursemarked-greater-sacrifice',
    'Grande Sacrifício',
    'character_thread'::rpg.resource_scope,
    'cursemarked',
    1
  ),
  ('traversal-expert', 'Especialista em Travessia', 'character_thread'::rpg.resource_scope, 'explorer', 1),
  ('scouts-awareness', 'Alerta do Batedor', 'character_thread'::rpg.resource_scope, 'explorer', 1),
  ('wayfarers-steps', 'Passos do Viajante', 'character_thread'::rpg.resource_scope, 'explorer', 1),
  ('fates-blessing', 'Bênção do Destino', 'character_thread'::rpg.resource_scope, 'fatebound', 1),
  ('strength-of-wyrd', 'Força do Wyrd', 'character_thread'::rpg.resource_scope, 'fatebound', 1),
  ('enduring-wyrd', 'Wyrd Duradouro', 'character_thread'::rpg.resource_scope, 'fatebound', 1),
  ('doom-delayed', 'Ruína Adiada', 'character_thread'::rpg.resource_scope, 'fatebound', 1),
  ('last-act-of-fate', 'Último Ato do Destino', 'character_thread'::rpg.resource_scope, 'fatebound', 1),
  ('glorious-end', 'Fim Glorioso', 'character_thread'::rpg.resource_scope, 'fatebound', 1),
  ('enthralling-speaker', 'Orador Cativante', 'character_thread'::rpg.resource_scope, 'herald', 1),
  ('persuasive-words', 'Palavras Persuasivas', 'character_thread'::rpg.resource_scope, 'herald', 1),
  ('reliable-senses', 'Sentidos Confiáveis', 'character_thread'::rpg.resource_scope, 'legend-hunter', 1),
  ('finish-the-fight', 'Terminar a Luta', 'character_thread'::rpg.resource_scope, 'legend-hunter', 1),
  ('jarls-authority', 'Autoridade do Jarl', 'character_thread'::rpg.resource_scope, 'sworn-huskarl', 1),
  ('extreme-loyalty', 'Lealdade Extrema', 'character_thread'::rpg.resource_scope, 'sworn-huskarl', 1)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  thread_slug = EXCLUDED.thread_slug,
  min_level = EXCLUDED.min_level;

-- Grants: owner_id = phb_character_thread.id
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'character_thread'::rpg.resource_owner_kind,
  t.id,
  rd.id,
  1,
  v.max_formula::rpg.resource_max_formula,
  v.fixed_max,
  FALSE,
  v.recover_all_on_short,
  v.recover_all_on_long
FROM (VALUES
  ('bloodsworn', 'wrath', 'fixed', 1, FALSE, TRUE),
  ('bloodsworn', 'tenacity', 'fixed', 1, FALSE, TRUE),
  ('cursemarked', 'cursemarked-greater-sacrifice', 'fixed', 1, FALSE, TRUE),
  ('explorer', 'traversal-expert', 'fixed', 1, TRUE, TRUE),
  ('explorer', 'scouts-awareness', 'fixed', 1, FALSE, TRUE),
  ('explorer', 'wayfarers-steps', 'fixed', 1, FALSE, TRUE),
  ('fatebound', 'fates-blessing', 'fixed', 1, FALSE, TRUE),
  ('fatebound', 'strength-of-wyrd', 'proficiency_bonus', NULL, FALSE, TRUE),
  ('fatebound', 'enduring-wyrd', 'fixed', 1, TRUE, TRUE),
  ('fatebound', 'doom-delayed', 'fixed', 1, FALSE, TRUE),
  ('fatebound', 'last-act-of-fate', 'fixed', 1, FALSE, FALSE),
  ('fatebound', 'glorious-end', 'fixed', 1, FALSE, FALSE),
  ('herald', 'enthralling-speaker', 'fixed', 1, FALSE, TRUE),
  ('herald', 'persuasive-words', 'charisma_mod', NULL, FALSE, TRUE),
  ('legend-hunter', 'reliable-senses', 'fixed', 1, FALSE, TRUE),
  ('legend-hunter', 'finish-the-fight', 'fixed', 1, FALSE, TRUE),
  ('sworn-huskarl', 'jarls-authority', 'fixed', 1, FALSE, TRUE),
  ('sworn-huskarl', 'extreme-loyalty', 'fixed', 1, FALSE, TRUE)
) AS v(thread_slug, resource_slug, max_formula, fixed_max, recover_all_on_short, recover_all_on_long)
JOIN rpg.phb_character_thread t ON t.slug = v.thread_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug
 AND rd.scope = 'character_thread'::rpg.resource_scope
 AND rd.thread_slug = v.thread_slug
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
