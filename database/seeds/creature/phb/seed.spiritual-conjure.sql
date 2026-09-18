-- PVE-7b: Arma Espiritual + Conjure* como 1 actor no skirmish (sem mapa / sem N tokens).
-- Arma Espiritual: efeito flutuante → companion leve (ataque no turno após o PC).
-- Conjurar Animais: aura PHB 2024 ≈ 1 bando com pulso 3d10 (aprox. ataque).
-- Dano `NdX+0` = flat preenchido com modificador de conjuração no sync.

-- ─── Arma Espiritual ────────────────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'arma-espiritual', 'phb-2024-pt', 'Arma Espiritual',
  'Energia espectral, Neutra', 'Neutra', 'Construct', 'small', NULL, NULL, 10, 20,
  '20 (efeito; sem PV oficiais — proxy skirmish)', 0,
  '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":3,"sabedoria":10,"carisma":10}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'arma-espiritual';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('arma-espiritual', 'fly', 20);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'arma-espiritual';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('arma-espiritual', 'Energia espectral',
   'Proxy skirmish da magia Arma Espiritual. Não é criatura atacável nas regras; no skirmish o inimigo prioriza o PC. Desaparece se a concentração cair.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'arma-espiritual';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('arma-espiritual', 'Golpe Espectral', 'action'::rpg.actor_action_bucket, NULL, '1d8+0',
   'Ataque mágico corpo a corpo: bônus = ataque mágico do conjurador. Dano: 1d8 + modificador de conjuração (Energético). Upcast: +1d8 por círculo acima de 2 (aprox. no skirmish = 1d8 base).', 1);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('arma-espiritual', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'arma-espiritual';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('arma-espiritual', 'padrao', 'arma-espiritual', 'Arma Espiritual');

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('arma-espiritual', 2, 10, 0, 20, 0, 'above_min')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;

-- ─── Conjurar Animais (1 bando) ─────────────────────────────────────────────
INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores
) VALUES
(
  'bando-animais-espectrais', 'phb-2024-pt', 'Bando de Animais Espectrais',
  'Grande bando, Neutro', 'Neutro', 'Beast', 'large', NULL, NULL, 13, 40,
  '40 + 10 × (círculo − 3) — proxy 1-actor (aura PHB 2024)', 2,
  '{"forca":14,"destreza":14,"constituicao":14,"inteligencia":3,"sabedoria":12,"carisma":6}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = 'bando-animais-espectrais';
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('bando-animais-espectrais', 'walk', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = 'bando-animais-espectrais';
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('bando-animais-espectrais', 'Proxy skirmish',
   'Conjurar Animais (PHB 2024) é aura/bando sem ficha. No skirmish vira 1 actor com pulso de dano equivalente (3d10 Cortante).', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug = 'bando-animais-espectrais';
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('bando-animais-espectrais', 'Enxame Espectral', 'action'::rpg.actor_action_bucket, NULL, '3d10',
   'Aprox. do pulso Dex 3d10 Cortante da aura: ataque com bônus = ataque mágico do conjurador. Upcast +1d10 por círculo acima de 3 (aprox. = 3d10 base).', 1);

INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('conjurar-animais', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;

DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'conjurar-animais';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES
  ('conjurar-animais', 'bando', 'bando-animais-espectrais', 'Bando Espectral');

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('bando-animais-espectrais', 3, 13, 0, 40, 10, 'above_min')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;
