-- Complemento: ex-templates dinâmicos → literais (schedules no texto; números vivos no motor).

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Ataque Imprudente: Vantagem em ataques com Força; ataques contra você têm Vantagem', 1
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Ataque Imprudente: Vantagem em ataques com Força; ataques contra você têm Vantagem'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Golpe Brutal: no acerto com Imprudente, pode abrir mão da Vantagem e causar +1d10 (2d10 no 17º+; efeitos de empurrar etc. na mesa)', 0
FROM rpg.phb_class c WHERE c.slug = 'barbarian'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Golpe Brutal: no acerto com Imprudente, pode abrir mão da Vantagem e causar +1d10 (2d10 no 17º+; efeitos de empurrar etc. na mesa)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 1, 'Artes Marciais: Ataque Desarmado e armas de Monge usam o dado de Artes Marciais (1d6→1d8→1d10→1d12; ver ataques) e o melhor de FOR/DES (sem armadura nem escudo)', 0
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 1 AND n.note = 'Artes Marciais: Ataque Desarmado e armas de Monge usam o dado de Artes Marciais (1d6→1d8→1d10→1d12; ver ataques) e o melhor de FOR/DES (sem armadura nem escudo)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 2, 'Movimento sem Armadura: bônus de Deslocamento aumenta com o nível (já na velocidade)', 1
FROM rpg.phb_class c WHERE c.slug = 'monk'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 2 AND n.note = 'Movimento sem Armadura: bônus de Deslocamento aumenta com o nível (já na velocidade)'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 6, 'Aura de Proteção (3 m; 9 m no 18º nível): você e aliados somam o mod. de Carisma às salvaguardas', 0
FROM rpg.phb_class c WHERE c.slug = 'paladin'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 6 AND n.note = 'Aura de Proteção (3 m; 9 m no 18º nível): você e aliados somam o mod. de Carisma às salvaguardas'
  );
