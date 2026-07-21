-- View rpg.v_phb_species_trait_choices (+ gnome, golias, elfo, tiferino, aasimar)

CREATE OR REPLACE VIEW rpg.v_phb_species_trait_choices AS
SELECT
  sp.slug AS species_slug,
  t.name AS trait_name,
  t.choice_kind,
  el.slug AS choice_slug,
  el.name AS choice_name,
  el.level1_benefit,
  s3.slug AS spell_level3_slug,
  s5.slug AS spell_level5_slug,
  NULL::text AS damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_elf_lineage el ON t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = el.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = el.spell_level5_id
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  il.slug,
  il.name,
  il.level1_benefit,
  s3.slug,
  s5.slug,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_infernal_legacy il ON t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = il.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = il.spell_level5_id
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  da.slug,
  da.name,
  NULL::text,
  NULL::text,
  NULL::text,
  da.damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_dragon_ancestry da ON t.choice_kind = 'dragon_ancestry'::rpg.species_choice_kind
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  gl.slug,
  gl.name,
  gl.level1_benefit,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_gnome_lineage gl ON t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ga.slug,
  ga.name,
  ga.benefit,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_giant_ancestry ga ON t.choice_kind = 'giant_ancestry'::rpg.species_choice_kind
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sk.slug,
  sk.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_skill sk ON t.choice_kind = 'human_skill'::rpg.species_choice_kind
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sk.slug,
  sk.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_skill sk
  ON t.choice_kind = 'elf_keen_senses'::rpg.species_choice_kind
 AND sk.slug IN ('insight', 'perception', 'survival')
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  f.slug,
  f.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_feat f ON t.choice_kind = 'human_origin_feat'::rpg.species_choice_kind
JOIN rpg.phb_feat_category fc ON fc.id = f.category_id AND fc.slug = 'origin'
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ab.slug,
  ab.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_ability ab
  ON t.choice_kind IN (
    'elf_casting_ability'::rpg.species_choice_kind,
    'gnome_casting_ability'::rpg.species_choice_kind,
    'infernal_casting_ability'::rpg.species_choice_kind
  )
 AND ab.slug IN ('inteligencia', 'sabedoria', 'carisma')
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sz.slug,
  sz.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN (
  VALUES
    ('medium', 'Médio'),
    ('small', 'Pequeno')
) AS sz(slug, name)
  ON t.choice_kind IN (
    'human_size'::rpg.species_choice_kind,
    'aasimar_size'::rpg.species_choice_kind,
    'tiefling_size'::rpg.species_choice_kind
  );
