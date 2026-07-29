-- Aumentos de atributo de nível 20 que ultrapassam o teto de 20 (até 25).

-- Bárbaro: Campeão Primitivo (nível 20) — +4 Força e +4 Constituição, teto 25.
INSERT INTO rpg.phb_class_ability_boost (class_id, ability_slug, label, bonus, score_max, from_level)
SELECT c.id, 'forca', 'Campeão Primitivo', 4, 25, 20
FROM rpg.phb_class c
WHERE c.slug = 'barbarian';

INSERT INTO rpg.phb_class_ability_boost (class_id, ability_slug, label, bonus, score_max, from_level)
SELECT c.id, 'constituicao', 'Campeão Primitivo', 4, 25, 20
FROM rpg.phb_class c
WHERE c.slug = 'barbarian';

-- Monge: Corpo e Mente (nível 20) — +4 Destreza e +4 Sabedoria, teto 25.
INSERT INTO rpg.phb_class_ability_boost (class_id, ability_slug, label, bonus, score_max, from_level)
SELECT c.id, 'destreza', 'Corpo e Mente', 4, 25, 20
FROM rpg.phb_class c
WHERE c.slug = 'monk';

INSERT INTO rpg.phb_class_ability_boost (class_id, ability_slug, label, bonus, score_max, from_level)
SELECT c.id, 'sabedoria', 'Corpo e Mente', 4, 25, 20
FROM rpg.phb_class c
WHERE c.slug = 'monk';
