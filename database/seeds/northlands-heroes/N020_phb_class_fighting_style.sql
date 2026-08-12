-- Vincula estilos Northlands às classes com Estilo de Luta (Fighter/Paladin/Ranger)

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'fighter' AND fs.slug = 'glima'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'fighter' AND fs.slug = 'raiders-rush'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'fighter' AND fs.slug = 'savagery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'fighter' AND fs.slug = 'shield-wall'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'fighter' AND fs.slug = 'skirmisher'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'fighter' AND fs.slug = 'underfoot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'paladin' AND fs.slug = 'glima'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'paladin' AND fs.slug = 'raiders-rush'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'paladin' AND fs.slug = 'savagery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'paladin' AND fs.slug = 'shield-wall'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'paladin' AND fs.slug = 'skirmisher'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'paladin' AND fs.slug = 'underfoot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'ranger' AND fs.slug = 'glima'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'ranger' AND fs.slug = 'raiders-rush'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'ranger' AND fs.slug = 'savagery'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'ranger' AND fs.slug = 'shield-wall'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'ranger' AND fs.slug = 'skirmisher'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
SELECT c.id, 'fighting_style'::rpg.class_proficiency_kind, fs.id
FROM rpg.phb_class c
CROSS JOIN rpg.phb_fighting_style fs
WHERE c.slug = 'ranger' AND fs.slug = 'underfoot'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_class_proficiency cp
    WHERE cp.class_id = c.id
      AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
      AND cp.ref_id = fs.id
  );
