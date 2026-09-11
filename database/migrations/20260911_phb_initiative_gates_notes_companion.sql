-- Regras de iniciativa por classe/subclasse (bÃ´nus de atributo ou vantagem).

CREATE TABLE IF NOT EXISTS rpg.phb_initiative_rule (
  id BIGSERIAL PRIMARY KEY,
  owner_kind TEXT NOT NULL CHECK (owner_kind IN ('class', 'subclass')),
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  rule_kind TEXT NOT NULL CHECK (rule_kind IN ('ability_bonus', 'advantage')),
  ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  label TEXT NOT NULL,
  CONSTRAINT phb_initiative_rule_owner CHECK (
    (owner_kind = 'class' AND class_id IS NOT NULL AND subclass_id IS NULL)
    OR (owner_kind = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NULL)
  ),
  CONSTRAINT phb_initiative_rule_ability CHECK (
    (rule_kind = 'ability_bonus' AND ability_slug IS NOT NULL)
    OR (rule_kind = 'advantage' AND ability_slug IS NULL)
  )
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_phb_initiative_rule_class_unique
  ON rpg.phb_initiative_rule (class_id, rule_kind, unlock_level, COALESCE(ability_slug, ''))
  WHERE class_id IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS idx_phb_initiative_rule_subclass_unique
  ON rpg.phb_initiative_rule (subclass_id, rule_kind, unlock_level, COALESCE(ability_slug, ''))
  WHERE subclass_id IS NOT NULL;
-- Gates de nÃ­vel por subclasse (ex.: Sabujo de Sangue L7/L10/L15).

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_feature_gate (
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  gate_key TEXT NOT NULL,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  PRIMARY KEY (subclass_id, gate_key)
);
-- Comandos de mesa do companheiro (labels PT + formato de nota).

CREATE TABLE IF NOT EXISTS rpg.phb_companion_command (
  slug TEXT PRIMARY KEY,
  label_pt TEXT NOT NULL,
  note_kind TEXT NOT NULL CHECK (note_kind IN ('strike', 'bonus_action')),
  sort_order INTEGER NOT NULL DEFAULT 0
);
-- Notas de combate por nÃ­vel (classe/subclasse) â€” texto de ficha.

CREATE TABLE IF NOT EXISTS rpg.phb_level_combat_note (
  id BIGSERIAL PRIMARY KEY,
  owner_kind TEXT NOT NULL CHECK (owner_kind IN ('class', 'subclass')),
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  note TEXT NOT NULL CHECK (length(trim(note)) > 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT phb_level_combat_note_owner CHECK (
    (owner_kind = 'class' AND class_id IS NOT NULL AND subclass_id IS NULL)
    OR (owner_kind = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NULL)
  )
);

CREATE INDEX IF NOT EXISTS idx_phb_level_combat_note_class
  ON rpg.phb_level_combat_note (class_id, unlock_level)
  WHERE class_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_phb_level_combat_note_subclass
  ON rpg.phb_level_combat_note (subclass_id, unlock_level)
  WHERE subclass_id IS NOT NULL;
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
    ('champion', 3, 'Atleta ExtraordinÃ¡rio: vantagem na Iniciativa'),
    ('assassin', 3, 'Assassinar: vantagem na Iniciativa'),
    ('nightwatcher', 3, 'Sempre Vigilante: vantagem na Iniciativa'),
    ('highway-rider', 3, 'Gatilho RÃ¡pido: vantagem na Iniciativa')
) AS v(subclass_slug, unlock_level, label)
JOIN rpg.phb_subclass s ON s.slug = v.subclass_slug
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_initiative_rule r
  WHERE r.subclass_id = s.id
    AND r.rule_kind = 'advantage'
    AND r.unlock_level = v.unlock_level
);
-- Gates de nÃ­vel â€” Sabujo de Sangue (Blood Hound).

INSERT INTO rpg.phb_subclass_feature_gate (subclass_id, gate_key, unlock_level)
SELECT s.id, v.gate_key, v.unlock_level
FROM rpg.phb_subclass s
CROSS JOIN (
  VALUES
    ('blood-armament', 7),
    ('blood-explosion', 7),
    ('blood-lower-cost', 10),
    ('blood-symphony', 15)
) AS v(gate_key, unlock_level)
WHERE s.slug = 'blood-hound'
ON CONFLICT (subclass_id, gate_key) DO UPDATE SET
  unlock_level = EXCLUDED.unlock_level;
-- Comandos de mesa do companheiro.

INSERT INTO rpg.phb_companion_command (slug, label_pt, note_kind, sort_order)
VALUES
  ('strike', 'Golpe da Fera', 'strike', 1),
  ('help', 'Ajudar', 'bonus_action', 2),
  ('dash', 'Correr', 'bonus_action', 3),
  ('disengage', 'Desengajar', 'bonus_action', 4),
  ('dodge', 'Esquivar', 'bonus_action', 5)
ON CONFLICT (slug) DO UPDATE SET
  label_pt = EXCLUDED.label_pt,
  note_kind = EXCLUDED.note_kind,
  sort_order = EXCLUDED.sort_order;
-- Notas de combate GH Cap.2 (classe/subclasse) â€” gerado a partir dos batches TS.

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Couro de Monstro: armadura leve/mÃ©dia com 2 modificaÃ§Ãµes; resistÃªncia a 2 tipos (Ã¡cido, frio, fogo, relÃ¢mpago, veneno ou trovÃ£o).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'carver-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Couro de Monstro: armadura leve/mÃ©dia com 2 modificaÃ§Ãµes; resistÃªncia a 2 tipos (Ã¡cido, frio, fogo, relÃ¢mpago, veneno ou trovÃ£o).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Fome Roedora: ao causar dano corpo a corpo, PV temporÃ¡rios = metade do dano (total vs tipos do GrimÃ³rio).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'devourer-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Fome Roedora: ao causar dano corpo a corpo, PV temporÃ¡rios = metade do dano (total vs tipos do GrimÃ³rio).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'InterferÃªncia Arcana: vantagem em salvaguardas contra magias de tipos no GrimÃ³rio de Monstros.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'occultist-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'InterferÃªncia Arcana: vantagem em salvaguardas contra magias de tipos no GrimÃ³rio de Monstros.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Vantagem do Emboscador: +INT na Iniciativa; nÃ£o pode ser surpreendido por tipos no GrimÃ³rio.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trapper-guild'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Vantagem do Emboscador: +INT na Iniciativa; nÃ£o pode ser surpreendido por tipos no GrimÃ³rio.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'CÃ©rebro e MÃºsculo: sem FÃºria â€” resistÃªncia psÃ­quica; com FÃºria â€” resistÃªncia a todos os tipos exceto forÃ§a e psÃ­quico.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-fractured'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'CÃ©rebro e MÃºsculo: sem FÃºria â€” resistÃªncia psÃ­quica; com FÃºria â€” resistÃªncia a todos os tipos exceto forÃ§a e psÃ­quico.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'FÃºria Compartilhada: com FÃºria ativa, companheiro primal tem resistÃªncia a concussÃ£o, perfuraÃ§Ã£o e corte.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-primal-spirit'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'FÃºria Compartilhada: com FÃºria ativa, companheiro primal tem resistÃªncia a concussÃ£o, perfuraÃ§Ã£o e corte.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'FÃºria dos Mortos: com FÃºria â€” +3 m deslocamento, visÃ£o espectral 36 m, atravessa terreno difÃ­cil e espaÃ§os ocupados.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-wrathful-dead'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'FÃºria dos Mortos: com FÃºria â€” +3 m deslocamento, visÃ£o espectral 36 m, atravessa terreno difÃ­cil e espaÃ§os ocupados.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Morte Ã© mas uma Porta: vantagem em salvaguardas contra morte; falha em 4 salvaguardas para morrer.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'pathofthe-wrathful-dead'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Morte Ã© mas uma Porta: vantagem em salvaguardas contra morte; falha em 4 salvaguardas para morrer.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Talento de Aventureiro: escolha talentos de aventureiro (L3/6/14) â€” ver descriÃ§Ã£o da subclasse.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'collegeof-adventurers'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Talento de Aventureiro: escolha talentos de aventureiro (L3/6/14) â€” ver descriÃ§Ã£o da subclasse.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Ãšltima Risada: ReaÃ§Ã£o quando Ferido â€” resistÃªncia a todo dano por 1 min (1Ã—/DL).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'collegeof-fools'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Ãšltima Risada: ReaÃ§Ã£o quando Ferido â€” resistÃªncia a todo dano por 1 min (1Ã—/DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Puxar Cordas da Vida: InspiraÃ§Ã£o BÃ¡rdica pode evitar 0 PV ou adicionar dano necrÃ³tico no ataque.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'collegeof-requiems'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Puxar Cordas da Vida: InspiraÃ§Ã£o BÃ¡rdica pode evitar 0 PV ou adicionar dano necrÃ³tico no ataque.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Calma Sobrenatural: resistÃªncia a dano psÃ­quico; vantagem para evitar/encerrar EnfeitiÃ§ado e Amedrontado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'eldritch-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Calma Sobrenatural: resistÃªncia a dano psÃ­quico; vantagem para evitar/encerrar EnfeitiÃ§ado e Amedrontado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Golpe do CaÃ§ador de Bruxas: +1d8 de forÃ§a vs AberraÃ§Ãµes, Celestiais, DemÃ´nios, DragÃµes ou Mortos-vivos.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'inquisition-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Golpe do CaÃ§ador de Bruxas: +1d8 de forÃ§a vs AberraÃ§Ãµes, Celestiais, DemÃ´nios, DragÃµes ou Mortos-vivos.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Marca Impura: vantagem em salvaguardas contra doenÃ§as e efeitos que alteram forma (ex.: Polimorfia).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'purification-domain'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Marca Impura: vantagem em salvaguardas contra doenÃ§as e efeitos que alteram forma (ex.: Polimorfia).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Com Lua de Sangue ativa: resistÃªncia a dano de concussÃ£o, perfuraÃ§Ã£o e corte.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-blood'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Com Lua de Sangue ativa: resistÃªncia a dano de concussÃ£o, perfuraÃ§Ã£o e corte.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'RuÃ­na Incarnate: CA base 17 + Sab (mÃ­n. +1) se sua CA for menor; 2 ataques na aÃ§Ã£o Atacar.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-entropy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'RuÃ­na Incarnate: CA base 17 + Sab (mÃ­n. +1) se sua CA for menor; 2 ataques na aÃ§Ã£o Atacar.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Com RuÃ­na Incarnate ativa: dano elemental/necrÃ³tico nos acertos; +Sab em salv. FOR/DES.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-entropy'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Com RuÃ­na Incarnate ativa: dano elemental/necrÃ³tico nos acertos; +Sab em salv. FOR/DES.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'MutaÃ§Ãµes: tremorsense 9 m; resistÃªncia elemental (Ã¡cido/frio/fogo/relÃ¢mpago/veneno/trovÃ£o) via pontos de mutaÃ§Ã£o.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circleof-mutation'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'MutaÃ§Ãµes: tremorsense 9 m; resistÃªncia elemental (Ã¡cido/frio/fogo/relÃ¢mpago/veneno/trovÃ£o) via pontos de mutaÃ§Ã£o.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Interromper o Ataque: ReaÃ§Ã£o â€” sofre o ataque no lugar de aliado a 1,5 m; resistÃªncia a todo o dano desse ataque.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'bulwark-warrior'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Interromper o Ataque: ReaÃ§Ã£o â€” sofre o ataque no lugar de aliado a 1,5 m; resistÃªncia a todo o dano desse ataque.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'TransmutaÃ§Ã£o TÃ³xica: resistÃªncia a dano de veneno; AÃ§Ã£o BÃ´nus para encerrar Envenenado e ganhar PV temporÃ¡rios.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'living-crucible'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'TransmutaÃ§Ã£o TÃ³xica: resistÃªncia a dano de veneno; AÃ§Ã£o BÃ´nus para encerrar Envenenado e ganhar PV temporÃ¡rios.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Sempre Vigilante: visÃ£o no escuro 18 m; vantagem em Iniciativa e testes de PercepÃ§Ã£o.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'nightwatcher'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Sempre Vigilante: visÃ£o no escuro 18 m; vantagem em Iniciativa e testes de PercepÃ§Ã£o.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'MÃ£o Sutil: alcance desarmado +1,5 m; pode causar dano psÃ­quico no lugar do tipo normal.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warriorofthe-leaden-crown'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'MÃ£o Sutil: alcance desarmado +1,5 m; pode causar dano psÃ­quico no lugar do tipo normal.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Ferido de Orgulho: considerado Ferido enquanto PV atual < PV mÃ¡ximo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warriorof-pride'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Ferido de Orgulho: considerado Ferido enquanto PV atual < PV mÃ¡ximo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Transe da Morte: a 0 PV, pode gastar 1 Ponto de Foco â€” imune a Inconsciente; falha crÃ­tica de morte conta como 1.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'warriorof-regret'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Transe da Morte: a 0 PV, pode gastar 1 Ponto de Foco â€” imune a Inconsciente; falha crÃ­tica de morte conta como 1.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Portador da Peste (forma): imune a veneno/Envenenado; resistÃªncia necrÃ³tica; PV mÃ¡x. nÃ£o pode ser reduzido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oathof-pestilence'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Portador da Peste (forma): imune a veneno/Envenenado; resistÃªncia necrÃ³tica; PV mÃ¡x. nÃ£o pode ser reduzido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Massacre FrenÃ©tico: com frenesi ativo â€” vantagem em salv. contra EnfeitiÃ§ado, Amedrontado e Atordoado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oathof-slaughter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Massacre FrenÃ©tico: com frenesi ativo â€” vantagem em salv. contra EnfeitiÃ§ado, Amedrontado e Atordoado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura de Clareza: vocÃª e aliados imunes a Cegueira na Aura de ProteÃ§Ã£o.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oathof-zeal'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura de Clareza: vocÃª e aliados imunes a Cegueira na Aura de ProteÃ§Ã£o.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Controle de Veneno: resistÃªncia a veneno; vantagem em salvaguardas contra Envenenado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'green-reaper'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Controle de Veneno: resistÃªncia a veneno; vantagem em salvaguardas contra Envenenado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Tece os Elementos: resistÃªncia a Ã¡cido, frio, fogo, relÃ¢mpago ou trovÃ£o (escolha atÃ© descanso longo).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'primordial-archer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Tece os Elementos: resistÃªncia a Ã¡cido, frio, fogo, relÃ¢mpago ou trovÃ£o (escolha atÃ© descanso longo).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Sujeira e Fortitude: imune a Envenenado; resistÃªncia a dano de veneno.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'vermin-lord'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Sujeira e Fortitude: imune a Envenenado; resistÃªncia a dano de veneno.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Gatilho RÃ¡pido: vantagem em Iniciativa; ReaÃ§Ã£o para atirar antes de agir no combate.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'highway-rider'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Gatilho RÃ¡pido: vantagem em Iniciativa; ReaÃ§Ã£o para atirar antes de agir no combate.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Olho Maligno: com alvo amaldiÃ§oado, Ataque Furtivo mesmo sem vantagem (se nÃ£o tiver desvantagem).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'misfortune-bringer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Olho Maligno: com alvo amaldiÃ§oado, Ataque Furtivo mesmo sem vantagem (se nÃ£o tiver desvantagem).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'ConjuraÃ§Ã£o: magias de mago + Sangromancia (lista preparada; INT). Dados de Sangromancia (Poder Roubado) no lugar de DV em magias de sangue.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sanguine-thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'ConjuraÃ§Ã£o: magias de mago + Sangromancia (lista preparada; INT). Dados de Sangromancia (Poder Roubado) no lugar de DV em magias de sangue.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Roubar Sangue: Ataque Furtivo pode restaurar 1 Dado de Sangromancia; se Ferido, recupera 1 Dado de Vida.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'sanguine-thief'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Roubar Sangue: Ataque Furtivo pode restaurar 1 Dado de Sangromancia; se Ferido, recupera 1 Dado de Vida.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Testemunhar o Fim: com FeitiÃ§aria Inata ativa â€” resistÃªncia a forÃ§a; imune a Amedrontado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'apocalypse-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Testemunhar o Fim: com FeitiÃ§aria Inata ativa â€” resistÃªncia a forÃ§a; imune a Amedrontado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Palidez MortÃ­fera: resistÃªncia a dano necrÃ³tico; magias de feiticeiro podem causar necrÃ³tico.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'haunted-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Palidez MortÃ­fera: resistÃªncia a dano necrÃ³tico; magias de feiticeiro podem causar necrÃ³tico.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'MaldiÃ§Ã£o Herdada (escolha): Colossal +1 PV/nÃ­vel; Noturno visÃ£o 36 m no escuro; Flagelo â€” penalidades sociais variadas.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'wretched-bloodline-sorcery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'MaldiÃ§Ã£o Herdada (escolha): Colossal +1 PV/nÃ­vel; Noturno visÃ£o 36 m no escuro; Flagelo â€” penalidades sociais variadas.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Visagem Horripilante: mÃ¡scara de medo â€” criaturas com desvantagem na salv. se puderem ver vocÃª.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'the-coven'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Visagem Horripilante: mÃ¡scara de medo â€” criaturas com desvantagem na salv. se puderem ver vocÃª.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Predador Noturno: visÃ£o no escuro 18 m (+18 m se jÃ¡ tiver).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'the-first-vampire-patron'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Predador Noturno: visÃ£o no escuro 18 m (+18 m se jÃ¡ tiver).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Noite Eterna: resistÃªncia a dano necrÃ³tico; nÃ£o envelhece.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'the-first-vampire-patron'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Noite Eterna: resistÃªncia a dano necrÃ³tico; nÃ£o envelhece.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Forma Aprimorada (1Ã—/DL): pode escolher +PV mÃ¡x. = nÃ­vel de Bruxo, visÃ£o no escuro, velocidade, etc.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'the-parasite-patron'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Forma Aprimorada (1Ã—/DL): pode escolher +PV mÃ¡x. = nÃ­vel de Bruxo, visÃ£o no escuro, velocidade, etc.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'SifÃ£o Aprimorado: com sifÃ£o de Arquidaemons â€” resistÃªncia necrÃ³tica; com Arqueanjo â€” resistÃªncia radiante.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'daemonologist'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'SifÃ£o Aprimorado: com sifÃ£o de Arquidaemons â€” resistÃªncia necrÃ³tica; com Arqueanjo â€” resistÃªncia radiante.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Inale Isso: imune a Envenenado; apÃ³s dano necrÃ³tico ou de veneno, ganha PV temporÃ¡rios = dano recebido.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'plague-doctor'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Inale Isso: imune a Envenenado; apÃ³s dano necrÃ³tico ou de veneno, ganha PV temporÃ¡rios = dano recebido.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Vigor SanguÃ­neo: +PV mÃ¡x. por nÃ­vel (ver PV na ficha); ao conjurar sangromancia com espaÃ§o, recupera PV = nÃ­vel do espaÃ§o.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'sangromancer'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Vigor SanguÃ­neo: +PV mÃ¡x. por nÃ­vel (ver PV na ficha); ao conjurar sangromancia com espaÃ§o, recupera PV = nÃ­vel do espaÃ§o.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 9, 'Defesa Erudita: em salvaguardas forÃ§adas por tipos do GrimÃ³rio, pode usar salvaguarda de InteligÃªncia.', 0
FROM rpg.phb_class c WHERE c.slug = 'monster-hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 9 AND n.note = 'Defesa Erudita: em salvaguardas forÃ§adas por tipos do GrimÃ³rio, pode usar salvaguarda de InteligÃªncia.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'class', c.id, NULL, 14, 'Senso do Covil: vantagem e resistÃªncia a aÃ§Ãµes de covil/regiÃ£o e AÃ§Ãµes LendÃ¡rias de tipos no GrimÃ³rio.', 1
FROM rpg.phb_class c WHERE c.slug = 'monster-hunter'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.class_id = c.id AND n.unlock_level = 14 AND n.note = 'Senso do Covil: vantagem e resistÃªncia a aÃ§Ãµes de covil/regiÃ£o e AÃ§Ãµes LendÃ¡rias de tipos no GrimÃ³rio.'
  );
