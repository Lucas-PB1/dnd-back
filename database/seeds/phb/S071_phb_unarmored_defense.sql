-- Defesa sem Armadura por classe / subclasse (10 + DES + atributo secundário)

-- Classe: Bárbaro (10 + DES + CON, permite escudo)
INSERT INTO rpg.phb_unarmored_defense (class_id, label, second_ability_slug, allows_shield)
SELECT c.id, 'Defesa sem Armadura (bárbaro)', 'constituicao', TRUE
FROM rpg.phb_class c
WHERE c.slug = 'barbarian';

-- Classe: Monge (10 + DES + SAB, não permite escudo)
INSERT INTO rpg.phb_unarmored_defense (class_id, label, second_ability_slug, allows_shield)
SELECT c.id, 'Defesa sem Armadura (monge)', 'sabedoria', FALSE
FROM rpg.phb_class c
WHERE c.slug = 'monk';

-- Subclasse: Resiliência Dracônica (10 + DES + CAR, permite escudo)
INSERT INTO rpg.phb_unarmored_defense (subclass_id, label, second_ability_slug, allows_shield)
SELECT sc.id, 'Resiliência Dracônica', 'carisma', TRUE
FROM rpg.phb_subclass sc
WHERE sc.slug = 'draconic';

-- Subclasse: Ginga / Colégio da Dança (10 + DES + CAR, não permite escudo)
INSERT INTO rpg.phb_unarmored_defense (subclass_id, label, second_ability_slug, allows_shield)
SELECT sc.id, 'Defesa sem Armadura (dança)', 'carisma', FALSE
FROM rpg.phb_subclass sc
WHERE sc.slug = 'dance';
