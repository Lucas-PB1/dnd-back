-- Regras de iniciativa (classe/subclasse).

INSERT INTO rpg.phb_initiative_rule (
  owner_kind, class_id, subclass_id, unlock_level, rule_kind, ability_slug, label
)
SELECT 'subclass', NULL, s.id, 3, 'ability_bonus', 'sabedoria', 'Emboscador das Sombras'
FROM rpg.phb_subclass s
WHERE s.slug = 'gloom-stalker'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_initiative_rule r
    WHERE r.subclass_id = s.id AND r.rule_kind = 'ability_bonus' AND r.unlock_level = 3
  );

INSERT INTO rpg.phb_initiative_rule (
  owner_kind, class_id, subclass_id, unlock_level, rule_kind, ability_slug, label
)
SELECT 'subclass', NULL, s.id, 7, 'ability_bonus', 'inteligencia', 'Vantagem do Emboscador'
FROM rpg.phb_subclass s
WHERE s.slug = 'trapper-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_initiative_rule r
    WHERE r.subclass_id = s.id AND r.rule_kind = 'ability_bonus' AND r.unlock_level = 7
  );

INSERT INTO rpg.phb_initiative_rule (
  owner_kind, class_id, subclass_id, unlock_level, rule_kind, ability_slug, label
)
SELECT 'class', c.id, NULL, 7, 'advantage', NULL, 'Instintos Primitivos: vantagem na Iniciativa'
FROM rpg.phb_class c
WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_initiative_rule r
    WHERE r.class_id = c.id AND r.rule_kind = 'advantage' AND r.unlock_level = 7
  );

INSERT INTO rpg.phb_initiative_rule (
  owner_kind, class_id, subclass_id, unlock_level, rule_kind, ability_slug, label
)
SELECT 'subclass', NULL, s.id, v.unlock_level, 'advantage', NULL, v.label
FROM (
  VALUES
    ('champion', 3, 'Atleta Extraordinário: vantagem na Iniciativa'),
    ('assassin', 3, 'Assassinar: vantagem na Iniciativa'),
    ('nightwatcher', 3, 'Sempre Vigilante: vantagem na Iniciativa'),
    ('highway-rider', 3, 'Gatilho Rápido: vantagem na Iniciativa')
) AS v(subclass_slug, unlock_level, label)
JOIN rpg.phb_subclass s ON s.slug = v.subclass_slug
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_initiative_rule r
  WHERE r.subclass_id = s.id
    AND r.rule_kind = 'advantage'
    AND r.unlock_level = v.unlock_level
);
