-- Magia Espírito Curador (Healing Spirit) — XGE 2014 + errata
-- Usada pelo Spirit Caller (Northlands). Slug PT conforme glossário.

INSERT INTO rpg.phb_spell (
  slug, name, level, level_label, school_id,
  casting_time, range,
  has_verbal, has_somatic, has_material, material_description, components_label,
  duration, concentration, ritual,
  description, higher_levels, source_citation_id
)
VALUES (
  'espirito-curador',
  'Espírito Curador',
  2,
  '2º círculo',
  (SELECT id FROM rpg.phb_spell_school WHERE slug = 'invocacao'),
  'Ação Bônus',
  '18 metros',
  true,
  true,
  false,
  NULL,
  'V, S',
  'Concentração, até 1 minuto',
  true,
  false,
  '[Xanathar''s Guide to Everything, 2014 — com errata]

Você invoca um espírito da natureza para acalmar os feridos. O espírito intangível aparece em um espaço de cubo de 1,5 m que você possa ver no alcance. Ele parece uma besta ou fada transparente (à sua escolha).

Até o fim da magia, sempre que você ou uma criatura que você possa ver entrar no espaço do espírito pela primeira vez no turno ou começar o turno ali, você pode fazer o espírito restaurar 1d6 pontos de vida a essa criatura (sem ação). O espírito não pode curar construtos nem mortos-vivos.

Como Ação Bônus no seu turno, você pode mover o espírito até 9 metros para um espaço que possa ver.

O espírito pode curar um número de vezes igual a 1 + seu modificador de atributo de conjuração (mínimo duas vezes). Depois de curar esse número de vezes, o espírito desaparece.',
  'Em Níveis Superiores. Quando você conjura esta magia usando um espaço de 3º círculo ou superior, a cura aumenta em 1d6 para cada círculo acima do 2º.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  level = EXCLUDED.level,
  level_label = EXCLUDED.level_label,
  school_id = EXCLUDED.school_id,
  casting_time = EXCLUDED.casting_time,
  range = EXCLUDED.range,
  has_verbal = EXCLUDED.has_verbal,
  has_somatic = EXCLUDED.has_somatic,
  has_material = EXCLUDED.has_material,
  material_description = EXCLUDED.material_description,
  components_label = EXCLUDED.components_label,
  duration = EXCLUDED.duration,
  concentration = EXCLUDED.concentration,
  ritual = EXCLUDED.ritual,
  description = EXCLUDED.description,
  higher_levels = EXCLUDED.higher_levels,
  source_citation_id = EXCLUDED.source_citation_id;

-- Listas XGE: Druida e Patrulheiro
INSERT INTO rpg.phb_spell_class (spell_id, class_id)
VALUES
  (
    (SELECT id FROM rpg.phb_spell WHERE slug = 'espirito-curador'),
    (SELECT id FROM rpg.phb_class WHERE slug = 'druid')
  ),
  (
    (SELECT id FROM rpg.phb_spell WHERE slug = 'espirito-curador'),
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger')
  )
ON CONFLICT DO NOTHING;

-- Spirit Caller L5 (após a magia existir; N004 roda antes deste arquivo)
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 5, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'spirit-caller' AND sp.slug = 'espirito-curador'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
