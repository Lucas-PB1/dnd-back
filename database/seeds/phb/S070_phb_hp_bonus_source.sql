-- Bônus permanentes de PV máximo (espécie / subclasse / talento)

-- Espécie: Tenacidade Anã (+1 PV por nível de personagem)
INSERT INTO rpg.phb_hp_bonus_source (species_id, label, per_level_bonus)
SELECT sp.id, 'Tenacidade Anã', 1
FROM rpg.phb_species sp
WHERE sp.slug = 'dwarf';

-- Subclasse: Resiliência Dracônica (+1 PV por nível, a partir do nível 3)
INSERT INTO rpg.phb_hp_bonus_source (subclass_id, label, per_level_bonus, from_level)
SELECT sc.id, 'Resiliência Dracônica', 1, 3
FROM rpg.phb_subclass sc
WHERE sc.slug = 'draconic';

-- Talento: Vigoroso (+2 PV por nível de personagem)
INSERT INTO rpg.phb_hp_bonus_source (feat_id, label, per_level_bonus)
SELECT f.id, 'Vigoroso', 2
FROM rpg.phb_feat f
WHERE f.slug = 'tough';

-- Talento: Dádiva da Fortitude (+40 PV fixos)
INSERT INTO rpg.phb_hp_bonus_source (feat_id, label, flat_bonus)
SELECT f.id, 'Dádiva da Fortitude', 40
FROM rpg.phb_feat f
WHERE f.slug = 'boon-of-fortitude';
