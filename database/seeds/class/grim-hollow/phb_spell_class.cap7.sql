-- Listas de classe — magias Grim Hollow Cap. 7
-- Gerado por scripts/generate-ghpg-cap7-spell-seeds.mjs

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'arboreal-curse'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'arcane-aegis'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'assisted-aim'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'assisted-aim'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'assisted-aim'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'assisted-aim'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'assisted-aim'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'binding-pledge'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'binding-pledge'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'binding-pledge'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloat'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloat'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloat'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloat'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloodbane-rune'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloodletter'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloodletter'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'bloodletter'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-bond'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-rush'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-rush'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-tide'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-tide'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-tide'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-wisp'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-wisp'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'blood-wisp'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'boil-blood'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'boil-blood'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'boil-blood'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'boil-blood'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'boil-blood'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'burst-forth'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'burst-forth'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'burst-forth'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'calling-card'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'calling-card'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'calling-card'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'calling-card'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'call-the-rabid-beast'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'call-the-rabid-beast'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'call-the-rabid-beast'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'call-the-rabid-beast'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'call-the-rabid-beast'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'call-the-rabid-beast'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'chains-of-beleth'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'chains-of-beleth'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'chains-of-beleth'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'chains-of-beleth'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'circle-of-scarlet'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'circle-of-scarlet'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'conjure-plants'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'conjure-plants'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'conjure-plants'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'consume-mind'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'consume-mind'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'consume-mind'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'consumption'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'consumption'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'consumption'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'creeping-death'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'creeping-death'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'creeping-touch'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'creeping-touch'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'creeping-touch'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'creeping-touch'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'crimson-lash'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'crimson-lash'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'crown-of-radiance'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'crown-of-radiance'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'crown-of-radiance'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'dark-sacrament'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'dark-sacrament'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'dazing-blast'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'dazing-blast'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'dazing-blast'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'earth-worm'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'earth-worm'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'elemental-exhalation'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'elemental-exhalation'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'emmelines-essence-infusion'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'enspelled-armament'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'extract-iron'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'extract-iron'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'extract-iron'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'extract-iron'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fiend-flesh'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fiend-flesh'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fiend-flesh'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fiend-flesh'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fiend-flesh'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'flash-fever'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'flash-fever'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'flense'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'flense'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fleshcrawl'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'fleshcrawl'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'frightful-start'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'frightful-start'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'frightful-start'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'frightful-start'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ghost-light'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ghost-light'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ghost-light'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ghost-light'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'greater-animate-dead'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'greater-animate-dead'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'heartseeker'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'heartseeker'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'holy-word'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'hunter-sense'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'illusory-instrument'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'illusory-instrument'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'incite-riot'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'incite-riot'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'incite-riot'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'incite-riot'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'intaglio'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'intaglio'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'intaglio'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'intaglio'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'investiture-of-venom'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'investiture-of-venom'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'lifesink'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'lifesink'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'lifesink'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'lifesink'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'life-tether'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'life-tether'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'life-tether'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'life-tether'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'little-death'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'maelfas-quickened-class'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'magic-mirror'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'melting-curse'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'melting-curse'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'melting-curse'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'melting-curse'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'melting-curse'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'mirror-spell'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'mirror-spell'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'mirror-spell'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'mortality'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'neutralize-aura'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'neutralize-aura'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'neutralize-aura'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'overgrow'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'overgrow'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'overgrow'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'perfection'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'perfection'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'phoenix-flames'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'phoenix-flames'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'phoenix-flames'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'power-word-maim'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'power-word-maim'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'power-word-maim'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'power-word-maim'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'preserve'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'preserve'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'preserve'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'preserve'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'preserve'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'primordial-power'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'reanimate'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'red-rain'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'red-rain'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ride-the-lightning'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ride-the-lightning'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'ride-the-lightning'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-fusillade'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-fusillade'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-fusillade'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-poppet'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-poppet'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-shield'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sanguine-shield'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'seal-spellcasting'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sense-lifeblood'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sense-lifeblood'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'sense-lifeblood'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'serpent-tongue'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'serpent-tongue'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'shared-judgement'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'shroud-blood'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'shroud-blood'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'shroud-blood'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'shroud-blood'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'somnolence'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'somnolence'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'spirit-swarm'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'spirit-swarm'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'splattering-smite'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'steal-immortality'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'suffocate'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'suffocate'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'suffocate'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'suffocate'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'summon-plant'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'summon-plant'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'summon-sea-spirit'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'summon-sea-spirit'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'supernal-smite'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'theft-of-vitae'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'theft-of-vitae'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'thorn-armor'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'thorn-armor'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'tremor'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'tremor'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'tremor'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'tremor'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'tremor'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'undead-enthrallment'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'undead-enthrallment'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'undead-enthrallment'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vampiric-claws'
  AND c.slug = 'druid'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vampiric-claws'
  AND c.slug = 'ranger'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vampiric-claws'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vampiric-claws'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vibrating-humors'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vibrating-humors'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'vibrating-humors'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'viscous-sheath'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'viscous-sheath'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'viscous-sheath'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'wall-of-gloom'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'wall-of-gloom'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'weave-numen'
  AND c.slug = 'bard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'weave-numen'
  AND c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'weave-numen'
  AND c.slug = 'warlock'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'weave-numen'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'wilting-smite'
  AND c.slug = 'paladin'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'wipe-face'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'wipe-face'
  AND c.slug = 'wizard'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
SELECT sp.id, c.id
FROM rpg.phb_spell sp, rpg.phb_class c
WHERE sp.slug = 'wrack'
  AND c.slug = 'cleric'
ON CONFLICT DO NOTHING;
