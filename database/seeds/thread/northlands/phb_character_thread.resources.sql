-- Recursos Character Threads (Northlands) — defs (grants → effects/E011_thread.sql)
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

-- Grants: SSOT em effects/E011_thread.sql
